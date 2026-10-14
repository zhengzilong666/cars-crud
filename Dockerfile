ARG BASE_IMAGE=python:3.12-slim
FROM ${BASE_IMAGE}

WORKDIR /app

COPY requirements.txt ./
RUN python -m pip install --no-cache-dir -r requirements.txt

# 改成了这行：把 app 文件夹作为一个整体复制到 /app/app 里面
COPY app/ /app/app/

RUN mkdir -p /data && chown 10001:10001 /data
USER 10001:10001
ENV CARS_DB_PATH=/data/cars.db

EXPOSE 8000

# 改成了这行：用 app.main:app 来启动
CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]