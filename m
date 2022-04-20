Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A2507F92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359245AbiDTDYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359239AbiDTDYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E31D220E2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650424914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4Qu9Vgv3L9GdF/GCpm7gFi/cqqJoTgTzG6l8G/JRjw=;
        b=HoJj4VyCG0/BMtlPhD4v+XoGhU/oK5mWnW8l9vZW1JaLUd7LORZ4PR94fMkJ2IV+7ll6ad
        gpi/wdJ0wQGkd50akjaU4KxLCs1KJmLCgrJOpVDb7YmNDpV6CCr3ldI9OQwSvAXktBdIpH
        s14EBVQy3ft6zL30o4V3I6rjz7L68Rg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-eKxC-StFOv-qApZy0Wj1cg-1; Tue, 19 Apr 2022 23:21:53 -0400
X-MC-Unique: eKxC-StFOv-qApZy0Wj1cg-1
Received: by mail-pf1-f197.google.com with SMTP id h66-20020a628345000000b0050ac8fa710eso479705pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N4Qu9Vgv3L9GdF/GCpm7gFi/cqqJoTgTzG6l8G/JRjw=;
        b=whC2+qcDxpYUboFRia5ri1QCgv4PdXc6T8P3se1f+gs44CzT+sKKP5ovz5bQtNmFeK
         q38eSKdaoGArKiahyepC6Sp0Vn3ykmBwAG6TYpmq48tlG7swRrp/75ARPwhY0UIoHKr2
         ohXGNIBTeV1t6gbG20h1my96+ZTmDWAPrYpAbjarttGrCh2GeN1JxZCxgmptNjI5xrsA
         576/IafOlrY+k1IkD+qkCzFolnQVxZc0qkUZ1C+TbdXnZZaK4u3E9bn3RYFkKE8w3lmR
         ldshjzE1CFy+y2AuUy78Jth+gH8nbYPsULA66yJOEncSQwqqcVsn1uTgErCaxmqkxpix
         hRlQ==
X-Gm-Message-State: AOAM531lMyhMVSMZtdQFnwoEtzwr920tcwX4hJaw+gO7BDAYB2vjkmKo
        PvI7rcbsCnTCpzDvRXWjqAe2LTKpKDKPhfAx6KHtYRpedFEriLT46obkSeSkZEvKMLstRJQ34hb
        5KOrmMI1jXVEnVhK6uUhetvk6
X-Received: by 2002:a17:90b:19d7:b0:1c7:3413:87e0 with SMTP id nm23-20020a17090b19d700b001c7341387e0mr2041632pjb.132.1650424912039;
        Tue, 19 Apr 2022 20:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfaKG8EOIcgAODaFpfwEbTUzq+ZZbbNoh/URJ8tDm6N1qcWFB7yxMhvWAv676JwqKc5ZA6lA==
X-Received: by 2002:a17:90b:19d7:b0:1c7:3413:87e0 with SMTP id nm23-20020a17090b19d700b001c7341387e0mr2041616pjb.132.1650424911767;
        Tue, 19 Apr 2022 20:21:51 -0700 (PDT)
Received: from [10.72.14.13] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g14-20020a63200e000000b0039d9816238fsm17655895pgg.81.2022.04.19.20.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 20:21:51 -0700 (PDT)
Message-ID: <32c1113d-4991-0ab0-5a85-33fe85295b93@redhat.com>
Date:   Wed, 20 Apr 2022 11:21:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v1] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
Content-Language: en-US
To:     Cindy Lu <lulu@redhat.com>, mst@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20220419014025.218121-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220419014025.218121-1-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/19 09:40, Cindy Lu 写道:
> this patch is to add the support for vdpa tool in vp_vdpa
> here is the example steps
> modprobe vp_vdpa
> modprobe vhost_vdpa
>
> echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
> echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
>
> vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   drivers/vdpa/virtio_pci/vp_vdpa.c | 86 ++++++++++++++++++++++++++++---
>   1 file changed, 78 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index cce101e6a940..d8a1d2f8e9bb 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -17,6 +17,8 @@
>   #include <linux/virtio_ring.h>
>   #include <linux/virtio_pci.h>
>   #include <linux/virtio_pci_modern.h>
> +#include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/vdpa.h>
>   
>   #define VP_VDPA_QUEUE_MAX 256
>   #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> @@ -41,6 +43,18 @@ struct vp_vdpa {
>   	int vectors;
>   };
>   
> +struct vp_vdpa_mgmtdev {
> +	struct vdpa_mgmt_dev mgtdev;
> +	struct vp_vdpa *vp_vdpa;
> +	struct pci_dev *pdev;
> +};
> +
> +#define VP_VDPA_NET_FEATURES                                                   \
> +	((1ULL << VIRTIO_F_ANY_LAYOUT) | (1ULL << VIRTIO_F_VERSION_1) |        \
> +	 (1ULL << VIRTIO_F_ACCESS_PLATFORM))
> +
> +#define VP_VDPA_NET_VQ_NUM 2


Let's not go backwards, e.g we've already support any kind of virtio 
device with any kind of features. see the comment in vp_vdpa_probe().


> +
>   static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
>   {
>   	return container_of(vdpa, struct vp_vdpa, vdpa);
> @@ -454,9 +468,14 @@ static void vp_vdpa_free_irq_vectors(void *data)
>   	pci_free_irq_vectors(data);
>   }
>   
> -static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> +			   const struct vdpa_dev_set_config *add_config)
>   {
> +	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =
> +		container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
> +
>   	struct virtio_pci_modern_device *mdev;
> +	struct pci_dev *pdev = vp_vdpa_mgtdev->pdev;
>   	struct device *dev = &pdev->dev;
>   	struct vp_vdpa *vp_vdpa;
>   	int ret, i;
> @@ -465,8 +484,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (ret)
>   		return ret;
>   
> -	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> -				    dev, &vp_vdpa_ops, NULL, false);
> +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa, dev, &vp_vdpa_ops,
> +				    name, false);


Nit: let's keep the line of vdpa_alloc_device() unchanged to reduce the 
changeset.


> +
>   	if (IS_ERR(vp_vdpa)) {
>   		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
>   		return PTR_ERR(vp_vdpa);
> @@ -480,9 +500,10 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
>   		goto err;
>   	}
> +	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
>   
>   	pci_set_master(pdev);
> -	pci_set_drvdata(pdev, vp_vdpa);
> +	pci_set_drvdata(pdev, vp_vdpa_mgtdev);
>   
>   	vp_vdpa->vdpa.dma_dev = &pdev->dev;
>   	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> @@ -516,7 +537,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	}
>   	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
>   
> -	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
> +	vp_vdpa->vdpa.mdev = &vp_vdpa_mgtdev->mgtdev;
> +	ret = _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
>   		goto err;
> @@ -529,12 +551,60 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	return ret;
>   }
>   
> -static void vp_vdpa_remove(struct pci_dev *pdev)
> +static void vp_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
> +			    struct vdpa_device *dev)
>   {
> -	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
> +	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev =
> +		container_of(v_mdev, struct vp_vdpa_mgmtdev, mgtdev);
> +
> +	struct vp_vdpa *vp_vdpa = vp_vdpa_mgtdev->vp_vdpa;
>   
>   	vp_modern_remove(&vp_vdpa->mdev);
> -	vdpa_unregister_device(&vp_vdpa->vdpa);
> +	_vdpa_unregister_device(&vp_vdpa->vdpa);
> +	vp_vdpa_mgtdev->vp_vdpa = NULL;
> +}
> +
> +static const struct vdpa_mgmtdev_ops vp_vdpa_mdev_ops = {
> +	.dev_add = vp_vdpa_dev_add,
> +	.dev_del = vp_vdpa_dev_del,
> +};
> +
> +static struct virtio_device_id vp_vdpa_id_table[] = {
> +	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};


Let's not limit the vp_vdpa to net, it can support all other virtio devices.


> +
> +static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev;
> +	struct vdpa_mgmt_dev *mgtdev;
> +	struct device *dev = &pdev->dev;
> +	int err;
> +
> +	vp_vdpa_mgtdev = kzalloc(sizeof(*vp_vdpa_mgtdev), GFP_KERNEL);
> +	if (!vp_vdpa_mgtdev)
> +		return -ENOMEM;
> +	mgtdev = &vp_vdpa_mgtdev->mgtdev;
> +
> +	mgtdev->ops = &vp_vdpa_mdev_ops;
> +	mgtdev->device = dev;
> +	mgtdev->id_table = vp_vdpa_id_table;
> +	vp_vdpa_mgtdev->pdev = pdev;
> +
> +	mgtdev->max_supported_vqs = VP_VDPA_NET_VQ_NUM;


Let's read this from the device instead of using the hard-coded value.


> +	mgtdev->supported_features = VP_VDPA_NET_FEATURES;


Let's read this from the device.


> +
> +	err = vdpa_mgmtdev_register(mgtdev);


Do we need to free the vp_vdpa_mgtdev here?

Thanks


> +
> +	return err;
> +}
> +
> +static void vp_vdpa_remove(struct pci_dev *pdev)
> +{
> +	struct vp_vdpa_mgmtdev *vp_vdpa_mgtdev = pci_get_drvdata(pdev);
> +
> +	vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
> +	kfree(vp_vdpa_mgtdev);
>   }
>   
>   static struct pci_driver vp_vdpa_driver = {

