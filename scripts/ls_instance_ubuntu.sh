sudo apt-get install -y unzip
# AWS CLI
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
aws --version
=>
aws-cli/2.4.18 Python/3.8.8 Linux/5.4.0-1018-aws exe/x86_64.ubuntu.20 prompt/off
# AWS Lightsailctl
sudo curl "https://s3.us-west-2.amazonaws.com/lightsailctl/latest/linux-amd64/lightsailctl" -o "/usr/local/bin/lightsailctl"
sudo chmod +x /usr/local/bin/lightsailctl
# AWS profile
sudo aws configure
# Docker
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo docker run hello-world
=>
Hello from Docker!
This message shows that your installation appears to be working correctly.
# create src code of container
mkdir lightsail-workshop-nginx
cd lightsail-workshop-nginx
echo "Welcome to Amazon Lightsail Container workshop" > index.html
echo "FROM nginx:latest" > Dockerfile
echo "COPY ./index.html /usr/share/nginx/html/index.html" >> Dockerfile
ll
=>
-rw-rw-r-- 1 ubuntu ubuntu   69 Feb 14 17:10 Dockerfile
-rw-rw-r-- 1 ubuntu ubuntu   47 Feb 14 17:09 index.html
# build container
sudo docker build -t nginx-container .
# run
sudo docker run -p 8088:80 nginx-container
curl localhost:8088
=>
Welcome to Amazon Lightsail Container workshop
# check
sudo docker ps
=>
CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS      PORTS    NAMES
0da60655bf5d   nginx-container   "/docker-entrypoint.…"   3 minutes ago   Up 2 minutes   0.0.0.0:8088->80/tcp, :::8088->80/tcp   confident_payne
5efeab783a7e   nginx-container   "/docker-entrypoint.…"   9 minutes ago   Up 9 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp   peaceful_cori
# push container
sudo aws lightsail push-container-image --service-name dtq-lightsail-container --label nginx-container-hello --image nginx-container
=>
Image "nginx-container" registered.
Refer to this image as ":dtq-lightsail-container.nginx-container-hello.1" in deployments.
