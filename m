Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68006514138
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiD2EST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiD2ESN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B814AF1F5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651205695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHEKG0lycPORQulLXfOynRPG96jJQyQ4MiK1YSKrzbY=;
        b=g4PXYm+17FBFkCLBmOeak62Z+prRvclgstJS0PaNHxatI9I+9wWjavaK9z8eQu8VfInIR9
        ZTgJq4Xg80MZ7LT+T/krGMwjM4YBaO2vQmmGW1934wLmM2F3tOYP5N1tDJ3RhE12dQLz2N
        Q6UNHiEOW/nJg2UiVN3vq8VRRCt1VVM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-SH5HVPsRObqcwxTZIXM2gw-1; Fri, 29 Apr 2022 00:14:53 -0400
X-MC-Unique: SH5HVPsRObqcwxTZIXM2gw-1
Received: by mail-pj1-f72.google.com with SMTP id y12-20020a17090a644c00b001d91b67b983so6286418pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gHEKG0lycPORQulLXfOynRPG96jJQyQ4MiK1YSKrzbY=;
        b=2oc4ux4dGpsm7/FoR2solxQkPYPyvvwoTJEzm5cNokAQ5hN5cqcm/Jez9qd50HzhYo
         JoH2HetBK+1guh0LfDxsKk4fdmLGaeTrIQSwASRDYTlLX5iPSj/Pcvv6sOv5faeRpRi5
         mCaOQVe1s7/1kxlN5x2SlL66Px6NCmSh/UlZSEMEJkLkyb6nJLsW0AD5vy4whoF9dJjT
         KvpHHqfNvQ03LEgNSL7fhDTVm1AOEI1Cv/K2ndTsDQ5g0Gpd6HReOKWCK/vgtQf18TTk
         4F8p2GBG2CPhspvJ+YHk4Cog1SNvibMdlgdc4z99slg6lalvar35A2I8K5UscxzXlAyh
         r2Hg==
X-Gm-Message-State: AOAM532h8wVAbaqOkrmljdCxSw63WMEysZM1YlwZNTuhTkCh2xuT4wWI
        5LntrPAz5h3pLTuUGEZQDrT6YQ/ZQDAmcdeZGcxf7i75Uu1EhJEtFJyh0CLue84NIZCJ4y733na
        ctgia9uu4yrchJCz0OjWT9nlR
X-Received: by 2002:a63:1cd:0:b0:3c1:a1d2:ed90 with SMTP id 196-20020a6301cd000000b003c1a1d2ed90mr2487555pgb.22.1651205692395;
        Thu, 28 Apr 2022 21:14:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD6a/kogGKKB/w2CZp9crdD0tLMKO4qEibcFTbtAc0an+ssyPbOlwNg+wYOwFOdKHfgUuteQ==
X-Received: by 2002:a63:1cd:0:b0:3c1:a1d2:ed90 with SMTP id 196-20020a6301cd000000b003c1a1d2ed90mr2487532pgb.22.1651205691919;
        Thu, 28 Apr 2022 21:14:51 -0700 (PDT)
Received: from [10.72.12.18] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a20-20020a63cd54000000b003c14af50623sm4431969pgj.59.2022.04.28.21.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 21:14:51 -0700 (PDT)
Message-ID: <80a4a48a-9557-0411-c01c-4e04fd113a8a@redhat.com>
Date:   Fri, 29 Apr 2022 12:14:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
Content-Language: en-US
To:     Cindy Lu <lulu@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220428073727.390987-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220428073727.390987-1-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/28 15:37, Cindy Lu 写道:
> this patch is to add the support for vdpa tool in vp_vdpa
> here is the example steps
>
> modprobe vp_vdpa
> modprobe vhost_vdpa
> echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
> echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
>
> vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   drivers/vdpa/virtio_pci/vp_vdpa.c | 159 ++++++++++++++++++++++++------
>   include/linux/vdpa.h              |   2 +-
>   2 files changed, 128 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index cce101e6a940..a3827e496b8f 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -32,7 +32,7 @@ struct vp_vring {
>   
>   struct vp_vdpa {
>   	struct vdpa_device vdpa;
> -	struct virtio_pci_modern_device mdev;
> +	struct virtio_pci_modern_device *mdev;
>   	struct vp_vring *vring;
>   	struct vdpa_callback config_cb;
>   	char msix_name[VP_VDPA_NAME_SIZE];
> @@ -41,6 +41,12 @@ struct vp_vdpa {
>   	int vectors;
>   };
>   
> +struct vp_vdpa_mgmtdev {
> +	struct vdpa_mgmt_dev mgtdev;
> +	struct virtio_pci_modern_device *mdev;
> +	struct vp_vdpa *vp_vdpa;
> +};
> +
>   static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
>   {
>   	return container_of(vdpa, struct vp_vdpa, vdpa);
> @@ -50,7 +56,12 @@ static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
>   {
>   	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>   
> -	return &vp_vdpa->mdev;
> +	return vp_vdpa->mdev;
> +}
> +
> +static struct virtio_pci_modern_device *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
> +{
> +	return vp_vdpa->mdev;
>   }
>   
>   static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
> @@ -96,7 +107,7 @@ static int vp_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
>   
>   static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>   {
> -	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>   	struct pci_dev *pdev = mdev->pci_dev;
>   	int i;
>   
> @@ -143,7 +154,7 @@ static irqreturn_t vp_vdpa_config_handler(int irq, void *arg)
>   
>   static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>   {
> -	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>   	struct pci_dev *pdev = mdev->pci_dev;
>   	int i, ret, irq;
>   	int queues = vp_vdpa->queues;
> @@ -198,7 +209,7 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>   static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>   {
>   	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> -	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>   	u8 s = vp_vdpa_get_status(vdpa);
>   
>   	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> @@ -212,7 +223,7 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>   static int vp_vdpa_reset(struct vdpa_device *vdpa)
>   {
>   	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> -	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>   	u8 s = vp_vdpa_get_status(vdpa);
>   
>   	vp_modern_set_status(mdev, 0);
> @@ -372,7 +383,7 @@ static void vp_vdpa_get_config(struct vdpa_device *vdpa,
>   			       void *buf, unsigned int len)
>   {
>   	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> -	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>   	u8 old, new;
>   	u8 *p;
>   	int i;
> @@ -392,7 +403,7 @@ static void vp_vdpa_set_config(struct vdpa_device *vdpa,
>   			       unsigned int len)
>   {
>   	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> -	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>   	const u8 *p = buf;
>   	int i;
>   
> @@ -412,7 +423,7 @@ static struct vdpa_notification_area
>   vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
>   {
>   	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> -	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>   	struct vdpa_notification_area notify;
>   
>   	notify.addr = vp_vdpa->vring[qid].notify_pa;
> @@ -454,38 +465,31 @@ static void vp_vdpa_free_irq_vectors(void *data)
>   	pci_free_irq_vectors(data);
>   }
>   
> -static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> +			   const struct vdpa_dev_set_config *add_config)
>   {
> -	struct virtio_pci_modern_device *mdev;
> +	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =
> +		container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
> +
> +	struct virtio_pci_modern_device *mdev = vp_vdpa_mgtdev->mdev;
> +	struct pci_dev *pdev = mdev->pci_dev;
>   	struct device *dev = &pdev->dev;
> -	struct vp_vdpa *vp_vdpa;
> +	struct vp_vdpa *vp_vdpa = NULL;
>   	int ret, i;
>   
> -	ret = pcim_enable_device(pdev);
> -	if (ret)
> -		return ret;
> +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa, dev, &vp_vdpa_ops,
> +				    name, false);
>   
> -	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> -				    dev, &vp_vdpa_ops, NULL, false);
>   	if (IS_ERR(vp_vdpa)) {
>   		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
>   		return PTR_ERR(vp_vdpa);
>   	}
>   
> -	mdev = &vp_vdpa->mdev;
> -	mdev->pci_dev = pdev;
> -
> -	ret = vp_modern_probe(mdev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
> -		goto err;
> -	}
> -
> -	pci_set_master(pdev);
> -	pci_set_drvdata(pdev, vp_vdpa);
> +	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
>   
>   	vp_vdpa->vdpa.dma_dev = &pdev->dev;
>   	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> +	vp_vdpa->mdev = mdev;
>   
>   	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
>   	if (ret) {
> @@ -516,7 +520,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	}
>   	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
>   
> -	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
> +	vp_vdpa->vdpa.mdev = &vp_vdpa_mgtdev->mgtdev;
> +	ret = _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
>   		goto err;
> @@ -529,12 +534,102 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	return ret;
>   }
>   
> +static void vp_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
> +			    struct vdpa_device *dev)
> +{
> +	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =
> +		container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
> +
> +	struct vp_vdpa *vp_vdpa = vp_vdpa_mgtdev->vp_vdpa;
> +
> +	_vdpa_unregister_device(&vp_vdpa->vdpa);
> +	vp_vdpa_mgtdev->vp_vdpa = NULL;
> +}
> +
> +static const struct vdpa_mgmtdev_ops vp_vdpa_mdev_ops = {
> +	.dev_add = vp_vdpa_dev_add,
> +	.dev_del = vp_vdpa_dev_del,
> +};
> +
> +static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev = NULL;
> +	struct vdpa_mgmt_dev *mgtdev;
> +	struct device *dev = &pdev->dev;
> +	struct virtio_pci_modern_device *mdev = NULL;
> +	struct virtio_device_id *mdev_id = NULL;
> +	int err;
> +
> +	vp_vdpa_mgtdev = kzalloc(sizeof(*vp_vdpa_mgtdev), GFP_KERNEL);
> +	if (!vp_vdpa_mgtdev)
> +		return -ENOMEM;
> +
> +	mgtdev = &vp_vdpa_mgtdev->mgtdev;
> +	mgtdev->ops = &vp_vdpa_mdev_ops;
> +	mgtdev->device = dev;
> +
> +	mdev = kzalloc(sizeof(struct virtio_pci_modern_device), GFP_KERNEL);
> +	if (!mdev) {
> +		kfree(vp_vdpa_mgtdev);
> +		return -ENOMEM;
> +	}
> +
> +	mdev_id = kzalloc(sizeof(struct virtio_device_id), GFP_KERNEL);
> +	if (!mdev_id) {
> +		kfree(mdev);
> +		kfree(vp_vdpa_mgtdev);
> +		return -ENOMEM;


Nit: let' use err label for having a consistent rewind.

Other looks good.

Thanks


> +	}
> +
> +	vp_vdpa_mgtdev->mdev = mdev;
> +	mdev->pci_dev = pdev;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		goto err;
> +	}
> +
> +	err = vp_modern_probe(mdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
> +		goto err;
> +	}
> +
> +	mdev_id->device = mdev->id.device;
> +	mdev_id->vendor = mdev->id.vendor;
> +	mgtdev->id_table = mdev_id;
> +
> +	mgtdev->max_supported_vqs = vp_modern_get_num_queues(mdev);
> +	mgtdev->supported_features = vp_modern_get_features(mdev);
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, vp_vdpa_mgtdev);
> +
> +	err = vdpa_mgmtdev_register(mgtdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to register vdpa mgmtdev device\n");
> +		vp_modern_remove(vp_vdpa_mgtdev->mdev);
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	kfree(mdev_id);
> +	kfree(mdev);
> +	kfree(vp_vdpa_mgtdev);
> +	return err;
> +}
> +
>   static void vp_vdpa_remove(struct pci_dev *pdev)
>   {
> -	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
> +	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev = pci_get_drvdata(pdev);
> +	struct virtio_pci_modern_device *mdev = NULL;
>   
> -	vp_modern_remove(&vp_vdpa->mdev);
> -	vdpa_unregister_device(&vp_vdpa->vdpa);
> +	mdev = vp_vdpa_mgtdev->mdev;
> +	vp_modern_remove(mdev);
> +	vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
> +	kfree(&vp_vdpa_mgtdev->mgtdev.id_table);
> +	kfree(mdev);
> +	kfree(vp_vdpa_mgtdev);
>   }
>   
>   static struct pci_driver vp_vdpa_driver = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 721089bb4c84..342c454c1623 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -462,7 +462,7 @@ struct vdpa_mgmtdev_ops {
>   struct vdpa_mgmt_dev {
>   	struct device *device;
>   	const struct vdpa_mgmtdev_ops *ops;
> -	const struct virtio_device_id *id_table;
> +	struct virtio_device_id *id_table;
>   	u64 config_attr_mask;
>   	struct list_head list;
>   	u64 supported_features;

