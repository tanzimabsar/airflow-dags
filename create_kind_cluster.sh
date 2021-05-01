# create kind cluster
kind create cluster --name airflow-cluster --config kind-cluster.yaml

# add repo (managed by marc lamberti)
helm repo add airflow https://marclamberti.github.io/airflow-eks-helm-chart

# add to repository and update the repo list
helm repo update

# get the values and put them in another yml file to configure the deployment 
helm show values airflow/airflow > values.yml

# deploy based on configuration og values.yml
helm install -f values.yml --kube-context kind-airflow-cluster airflow airflow/airflow

# check that it has actually started
# this has been deployed using kind based on a 
# helm chart from a custom help repo
kubectl get pods --context kind-airflow-cluster

# now that it is up and running, make sure to port forward all the ports that are deployed and are in use by the services
kubectl port-forward svc/airflow-webserver 8080:8080 --context kind-airflow-cluster

# login to airflow using user admin and password admin
# localhost:8080


