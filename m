Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3510E5951F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiHPFZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiHPFZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 204E95E654
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660600602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Mm/CnM1h4B5dRbBk+BycTCdz0sdSVv31NtnIHgtZL8=;
        b=Jl0bGLC1VU/LWVfl15S0TjN+AdtgU1UxNO6+6v1gQlMCaHFTtF82rcrEtY8oAUP5th8lrx
        47sYE8SB7wQCZwBR9AtamE2iKp6FvsnwChexDQR6G6EIBHKovaZWlo0lSDXX3OtWMcdhf2
        1I7N8b+hf0wN1M3dXOnAsc4U6cdSrGs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-HjxEIf0kMKSkdfFjTwzv9Q-1; Mon, 15 Aug 2022 17:56:38 -0400
X-MC-Unique: HjxEIf0kMKSkdfFjTwzv9Q-1
Received: by mail-wm1-f71.google.com with SMTP id b4-20020a05600c4e0400b003a5a96f1756so9271377wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=8Mm/CnM1h4B5dRbBk+BycTCdz0sdSVv31NtnIHgtZL8=;
        b=KSMkfTKuQUb8eizgUriRv31WkkR9rLdi2PIMZqyG2yr5FNAPGUH376/ampuO0LxtJr
         tGXIwW8gmBA4oS+T+Ucm0LJT3mKH1K8f/QrD05TCBmt0MwRFEnh94lWydv1PTtlp8JRP
         PNkVfHEBU2ilxbyOZThHihKLJsMWRRQe88W3b+tpw5CSO02BiUfOKg0SN/qIg4SjK+6e
         ySyzP6ymibmId5n9YtIL37uqgIjRjcXFl2YkugGqvOkZsf5AmWRFCQbyKAzWj4AY+H7L
         luzMjXFhvWR5MQH8BCsvbMsRpvHNOC14EokZqxJmYszXcPYGfshTFx0YE0z7R5/PPblT
         Albg==
X-Gm-Message-State: ACgBeo1tlOLs0ZGSX38OMwiEWelviXK2q4EUtsHa754aqUZvAibg8Z5b
        ce9TiNsqtL9Tp65rrW5pHlLZDkBbsBV1IrwccGe5r5SssXdv+8B8P1ac9EaIOT15M1DiHoxsxxZ
        kOrOoyp8ylpj0IAzGxAofm+YDUe0xHmo+LqzzR92z5B3OLIWpMk32eBtl/07wVKAj1Al0RQ==
X-Received: by 2002:a5d:4646:0:b0:220:5c35:d4f2 with SMTP id j6-20020a5d4646000000b002205c35d4f2mr9776336wrs.475.1660600597169;
        Mon, 15 Aug 2022 14:56:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR446rc1SI6gJKMPP11qXiQWWOXXuovFOjed61tFUBD5H8GPlv+4YWAmEn44A+sTFWCC57gMXw==
X-Received: by 2002:a5d:4646:0:b0:220:5c35:d4f2 with SMTP id j6-20020a5d4646000000b002205c35d4f2mr9776312wrs.475.1660600596795;
        Mon, 15 Aug 2022 14:56:36 -0700 (PDT)
Received: from redhat.com ([2.55.4.37])
        by smtp.gmail.com with ESMTPSA id az34-20020a05600c602200b003a5e7435190sm8296828wmb.32.2022.08.15.14.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:56:36 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:56:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio: kerneldocs fixes and enhancements
Message-ID: <20220815175549-mutt-send-email-mst@kernel.org>
References: <20220815215251.154451-1-mst@redhat.com>
 <20220815215251.154451-2-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220815215251.154451-2-mst@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:53:24PM -0400, Michael S. Tsirkin wrote:
> From: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> 
> Fix variable names in some kerneldocs, naming in others.
> Add kerneldocs for struct vring_desc and vring_interrupt.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Message-Id: <20220810094004.1250-2-ricardo.canuelo@collabora.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>


Ouch this got here by mistake. Just ignore this patch pls -
it's already in my tree but does not belong in the patchset.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d66c8e6d0ef3..4620e9d79dde 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2426,6 +2426,14 @@ static inline bool more_used(const struct vring_virtqueue *vq)
>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>  }
>  
> +/**
> + * vring_interrupt - notify a virtqueue on an interrupt
> + * @irq: the IRQ number (ignored)
> + * @_vq: the struct virtqueue to notify
> + *
> + * Calls the callback function of @_vq to process the virtqueue
> + * notification.
> + */
>  irqreturn_t vring_interrupt(int irq, void *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index a3f73bb6733e..dcab9c7e8784 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -11,7 +11,7 @@
>  #include <linux/gfp.h>
>  
>  /**
> - * virtqueue - a queue to register buffers for sending or receiving.
> + * struct virtqueue - a queue to register buffers for sending or receiving.
>   * @list: the chain of virtqueues for this device
>   * @callback: the function to call when buffers are consumed (can be NULL).
>   * @name: the name of this virtqueue (mainly for debugging)
> @@ -97,7 +97,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  		     void (*recycle)(struct virtqueue *vq, void *buf));
>  
>  /**
> - * virtio_device - representation of a device using virtio
> + * struct virtio_device - representation of a device using virtio
>   * @index: unique position on the virtio bus
>   * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>   * @config_enabled: configuration change reporting enabled
> @@ -156,7 +156,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
>  	list_for_each_entry(vq, &vdev->vqs, list)
>  
>  /**
> - * virtio_driver - operations for a virtio I/O driver
> + * struct virtio_driver - operations for a virtio I/O driver
>   * @driver: underlying device driver (populate name and owner).
>   * @id_table: the ids serviced by this driver.
>   * @feature_table: an array of feature numbers supported by this driver.
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 36ec7be1f480..4b517649cfe8 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -239,7 +239,7 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>  
>  /**
>   * virtio_synchronize_cbs - synchronize with virtqueue callbacks
> - * @vdev: the device
> + * @dev: the virtio device
>   */
>  static inline
>  void virtio_synchronize_cbs(struct virtio_device *dev)
> @@ -258,7 +258,7 @@ void virtio_synchronize_cbs(struct virtio_device *dev)
>  
>  /**
>   * virtio_device_ready - enable vq use in probe function
> - * @vdev: the device
> + * @dev: the virtio device
>   *
>   * Driver must call this to use vqs in the probe function.
>   *
> @@ -306,7 +306,7 @@ const char *virtio_bus_name(struct virtio_device *vdev)
>  /**
>   * virtqueue_set_affinity - setting affinity for a virtqueue
>   * @vq: the virtqueue
> - * @cpu: the cpu no.
> + * @cpu_mask: the cpu mask
>   *
>   * Pay attention the function are best-effort: the affinity hint may not be set
>   * due to config support, irq type and sharing.
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 476d3e5c0fe7..f8c20d3de8da 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -93,15 +93,21 @@
>  #define VRING_USED_ALIGN_SIZE 4
>  #define VRING_DESC_ALIGN_SIZE 16
>  
> -/* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
> +/**
> + * struct vring_desc - Virtio ring descriptors,
> + * 16 bytes long. These can chain together via @next.
> + *
> + * @addr: buffer address (guest-physical)
> + * @len: buffer length
> + * @flags: descriptor flags
> + * @next: index of the next descriptor in the chain,
> + *        if the VRING_DESC_F_NEXT flag is set. We chain unused
> + *        descriptors via this, too.
> + */
>  struct vring_desc {
> -	/* Address (guest-physical). */
>  	__virtio64 addr;
> -	/* Length. */
>  	__virtio32 len;
> -	/* The flags as indicated above. */
>  	__virtio16 flags;
> -	/* We chain unused descriptors via this, too */
>  	__virtio16 next;
>  };
>  
> -- 
> MST
> 

