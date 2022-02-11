Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DD94B1EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347569AbiBKHFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:05:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347563AbiBKHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1197102B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644563151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29k5SYn+mA2h6PNt5GA3x1DjygZEHaQPB/zFFKM7ZMI=;
        b=VvMBRkEtmyrtW1TZSXNDNCO+pizYBX0tvPsLL+6X3BUT18SEC36cmDmfl6KUWQfXUqO0q4
        uxtJD7dO/z/1v7rU/HDfCRflkh3Yy/jj7ONrVRUs6lgAGe1T1mxZQ50okMU/I40yvPx7DQ
        v16cys/qthaQJoQYdLp0cRDTMlSv6us=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-wn2F8VcoMyqGhYs8TZxd3g-1; Fri, 11 Feb 2022 02:05:49 -0500
X-MC-Unique: wn2F8VcoMyqGhYs8TZxd3g-1
Received: by mail-pl1-f198.google.com with SMTP id w3-20020a170902a70300b0014cced44ad7so2886260plq.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=29k5SYn+mA2h6PNt5GA3x1DjygZEHaQPB/zFFKM7ZMI=;
        b=UkXANZwe50/e3DRIsk+D44uZ4pGmv+r9rN+FoDqGlSl2yik2lGhKqeFT/ITcZ5youu
         VU5FbXDDWKr9LWKqIIRf1c0m9C9RaZRauu8MQVWFEEWKvcz0KTMW1MnOeUV9DwRF51uh
         U4PB6HmhdqmbCgW1INnsq/SNTuKmAAp9w/yd8Tezncf2lDeqGj25T56Ilzaj4mwn8Iha
         +VJH6wFPR0B2uq5ySjz7iwh6uRmvgUlmBXaZX/sT5JSnDxq4QksrXuHtXUsQcGwZgHjk
         CtzEFy280Q1qWwvyaNwZNQ8lUQD7TpgkCgsqnCrufTomNePqdWiNxw6PZQ8n88tCNTkK
         k3sQ==
X-Gm-Message-State: AOAM531WcKfkqoX4Wce1505EUxiIQLEOlKTOSkBUUeB4RndMMxOTAbqU
        vEVt546Epe1EHYz+J4mBoPF0OIJW1zAxnAvKI5NNgUEyDA5D2q6wdWDvdYGORHGiRmKAlXMD+o5
        pudZPwikwD1WDWuqOo55FUAay
X-Received: by 2002:a17:902:d34b:: with SMTP id l11mr214257plk.137.1644563148465;
        Thu, 10 Feb 2022 23:05:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDHdlBppHsgXHm0IvVylBjFkCJT/zhNst3oVLBd1MN7JhCOa6Oc9S27Sj1pihhf2uZcho8kg==
X-Received: by 2002:a17:902:d34b:: with SMTP id l11mr214242plk.137.1644563148171;
        Thu, 10 Feb 2022 23:05:48 -0800 (PST)
Received: from [10.72.13.85] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mg24sm4105648pjb.4.2022.02.10.23.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 23:05:47 -0800 (PST)
Message-ID: <8b0b5f06-74eb-d6cb-07e2-38249e4cda92@redhat.com>
Date:   Fri, 11 Feb 2022 15:05:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v4 14/14] virtio_pci: queue_reset: support
 VIRTIO_F_RING_RESET
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <20220209122901.51790-15-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220209122901.51790-15-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/2/9 下午8:29, Xuan Zhuo 写道:
> This patch implements virtio pci support for QUEUE RESET.
>
> Performing reset on a queue is divided into these steps:
>
> 1. reset_vq: reset one vq
> 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> 3. release the ring of the vq by vring_release_virtqueue()
> 4. enable_reset_vq: re-enable the reset queue
>
> This patch implements reset_vq, enable_reset_vq in the pci scenario
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_pci_common.c |  8 +--
>   drivers/virtio/virtio_pci_modern.c | 80 ++++++++++++++++++++++++++++--
>   drivers/virtio/virtio_ring.c       |  2 +
>   include/linux/virtio.h             |  1 +
>   4 files changed, 85 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index cb01eb0cb2e4..303637ac4914 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -255,9 +255,11 @@ static void vp_del_vq(struct virtqueue *vq)
>   	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&vp_dev->lock, flags);
> -	list_del(&info->node);
> -	spin_unlock_irqrestore(&vp_dev->lock, flags);
> +	if (!vq->reset) {
> +		spin_lock_irqsave(&vp_dev->lock, flags);
> +		list_del(&info->node);
> +		spin_unlock_irqrestore(&vp_dev->lock, flags);
> +	}
>   
>   	vp_dev->del_vq(info);
>   	kfree(info);
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d29d40bf0b45..cc45515eda50 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>   	if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
>   			pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
>   		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> +
> +	if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> +		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
>   }
>   
>   /* virtio config->finalize_features() implementation */
> @@ -176,6 +179,70 @@ static void vp_reset(struct virtio_device *vdev)
>   	vp_disable_cbs(vdev);
>   }
>   
> +static int vp_modern_reset_vq(struct virtqueue *vq)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +	struct virtio_pci_vq_info *info;
> +	unsigned long flags;
> +	u16 msix_vec;
> +
> +	if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> +		return -ENOENT;
> +
> +	vp_modern_set_queue_reset(mdev, vq->index);
> +
> +	info = vp_dev->vqs[vq->index];
> +	msix_vec = info->msix_vector;
> +
> +	/* Disable VQ callback. */
> +	if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
> +		disable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));


I think we need a comment to explain why per_vq_mode needs to be dealt 
with differently.


> +
> +	/* delete vq */
> +	spin_lock_irqsave(&vp_dev->lock, flags);
> +	list_del(&info->node);
> +	spin_unlock_irqrestore(&vp_dev->lock, flags);


So I don't see where vring is freed and vp_setup_vq() may try to 
allocate new memory, won't it be a memory leak in this case?

Thanks


> +
> +	vq->reset = true;
> +
> +	INIT_LIST_HEAD(&info->node);
> +
> +	return 0;
> +}
> +
> +static int vp_modern_enable_reset_vq(struct virtqueue *vq, u16 ring_num)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +	struct virtio_pci_vq_info *info;
> +	struct virtqueue *_vq;
> +	u16 msix_vec;
> +
> +	if (!vq->reset)
> +		return -EPERM;
> +
> +	/* check queue reset status */
> +	if (vp_modern_get_queue_reset(mdev, vq->index) != 1)
> +		return -EBUSY;
> +
> +	info = vp_dev->vqs[vq->index];
> +	_vq = vp_setup_vq(vq->vdev, vq->index, NULL, NULL, NULL,
> +			 info->msix_vector, ring_num);
> +	if (IS_ERR(_vq)) {
> +		vq->reset = true;
> +		return PTR_ERR(_vq);
> +	}
> +
> +	vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
> +
> +	msix_vec = vp_dev->vqs[vq->index]->msix_vector;
> +	if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
> +		enable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
> +
> +	return 0;
> +}
> +
>   static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>   {
>   	return vp_modern_config_vector(&vp_dev->mdev, vector);
> @@ -231,10 +298,13 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>   				virtqueue_get_avail_addr(vq),
>   				virtqueue_get_used_addr(vq));
>   
> -	vq->priv = (void __force *)vp_modern_map_vq_notify(mdev, index, NULL);
>   	if (!vq->priv) {
> -		err = -ENOMEM;
> -		goto err_map_notify;
> +		vq->priv = (void __force *)vp_modern_map_vq_notify(mdev, index,
> +								   NULL);
> +		if (!vq->priv) {
> +			err = -ENOMEM;
> +			goto err_map_notify;
> +		}


This seems unrelated or an artifact of previous patches?

Thanks


>   	}
>   
>   	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
> @@ -402,6 +472,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>   	.set_vq_affinity = vp_set_vq_affinity,
>   	.get_vq_affinity = vp_get_vq_affinity,
>   	.get_shm_region  = vp_get_shm_region,
> +	.reset_vq	 = vp_modern_reset_vq,
> +	.enable_reset_vq = vp_modern_enable_reset_vq,
>   };
>   
>   static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -420,6 +492,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>   	.set_vq_affinity = vp_set_vq_affinity,
>   	.get_vq_affinity = vp_get_vq_affinity,
>   	.get_shm_region  = vp_get_shm_region,
> +	.reset_vq	 = vp_modern_reset_vq,
> +	.enable_reset_vq = vp_modern_enable_reset_vq,
>   };
>   
>   /* the PCI probing function */
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b8747df8dc1f..4f6028e1e2d9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1731,6 +1731,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   	vq->vq.vdev = vdev;
>   	vq->vq.num_free = num;
>   	vq->vq.index = index;
> +	vq->vq.reset = false;
>   	vq->we_own_ring = true;
>   	vq->notify = notify;
>   	vq->weak_barriers = weak_barriers;
> @@ -2220,6 +2221,7 @@ static int __vring_init_virtqueue(struct virtqueue *_vq,
>   	vq->vq.vdev = vdev;
>   	vq->vq.num_free = vring.num;
>   	vq->vq.index = index;
> +	vq->vq.reset = false;
>   	vq->we_own_ring = false;
>   	vq->notify = notify;
>   	vq->weak_barriers = weak_barriers;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index dd1657c3a488..5d4817d79f3f 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -32,6 +32,7 @@ struct virtqueue {
>   	unsigned int index;
>   	unsigned int num_free;
>   	void *priv;
> +	bool reset;
>   };
>   
>   int virtqueue_add_outbuf(struct virtqueue *vq,

