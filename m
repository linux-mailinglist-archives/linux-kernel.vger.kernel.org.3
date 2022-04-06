Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CC44F62E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiDFPRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiDFPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 765875A1C90
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649247312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ubOv2fch/wckoTm8HS8GYp3/vOZS2zK/ygF8PnquGr8=;
        b=PBsKPCLRFXh952aYBNotz1k4LyQ/kXGwWUita+KI0E6FieLhVEoksx2LYMd+3ANDoIqTwq
        PpBV+5+6EivFgq2JuVtdc+cIyY5cONcBTguXcVWtaDRQwmFiUSlcrI/LMCDpfc8sITFjOl
        95HD2tCVoHp72Ci0oJWnlaTV8X/JVDE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-RLIBlsecO2-9doDsHzlzGg-1; Wed, 06 Apr 2022 08:04:53 -0400
X-MC-Unique: RLIBlsecO2-9doDsHzlzGg-1
Received: by mail-wm1-f69.google.com with SMTP id r6-20020a05600c35c600b0038e6db5da9cso609049wmq.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ubOv2fch/wckoTm8HS8GYp3/vOZS2zK/ygF8PnquGr8=;
        b=LudaAU3V3oAgeFQVQzv8VPIkZiOSWsrhSjCLs/VmbjnPQT1+yaEzcy2R5wuwJWlpbE
         A7NY99I04nqSxCVCZWd8/TekRPhf6oicuF/wKzufAD9R+dFXY+9nHthyNjXwLCDnmBaG
         DeuD0vbTP23WgIZFw/+Qq5kd+/az0CiB3+07mqiIXGwDHh+pyQdn7xAsyLUitJUdrDgi
         SBWvvRJIjqJ4GIImbP987aO7d8Se5qyzu0pAcm8g4ZTmPPoAViOEeAI05/IyPsYG54ik
         4xrTwRfPsf4m7m364Dgk3LX1Q/AWALkH43hocaBok7GXkg/OqtJ3sLqEyKKE8dJLJyP1
         Vi7w==
X-Gm-Message-State: AOAM532H54sFOs4HmmeOxqLg7zR8A5UIfBnQHWQGtqsJnmE96WTPBkXO
        QhyzHKG2W2KVlEmZSisMnmEyMCRGzearfyijkQQ2qphxBNBNfdtnhfkuNV7WF7pHEkZJURRbhDs
        PU7g+qrlwEZ0EO8R0f5bV++pZ
X-Received: by 2002:adf:912f:0:b0:204:3be:1a5b with SMTP id j44-20020adf912f000000b0020403be1a5bmr6806918wrj.467.1649246691960;
        Wed, 06 Apr 2022 05:04:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQR5ApoQJ3GQmL6XrNhmVtOvy3kWPmBXxQ5CQD1Yy517tuy3/gi8RA32uBI1lksiBw4nQHkQ==
X-Received: by 2002:adf:912f:0:b0:204:3be:1a5b with SMTP id j44-20020adf912f000000b0020403be1a5bmr6806890wrj.467.1649246691562;
        Wed, 06 Apr 2022 05:04:51 -0700 (PDT)
Received: from redhat.com ([2.55.136.193])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d6081000000b002061b616b83sm5145435wrt.39.2022.04.06.05.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:04:50 -0700 (PDT)
Date:   Wed, 6 Apr 2022 08:04:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 5/5] virtio: harden vring IRQ
Message-ID: <20220406080135-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406083538.16274-6-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 04:35:38PM +0800, Jason Wang wrote:
> This is a rework on the previous IRQ hardening that is done for
> virtio-pci where several drawbacks were found and were reverted:
> 
> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>    that is used by some device such as virtio-blk
> 2) done only for PCI transport
> 
> In this patch, we tries to borrow the idea from the INTX IRQ hardening
> in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
> by introducing a global device_ready variable for each
> virtio_device. Then we can to toggle it during
> virtio_reset_device()/virtio_device_ready(). A
> virtio_synchornize_vqs() is used in both virtio_device_ready() and
> virtio_reset_device() to synchronize with the vring callbacks. With
> this, vring_interrupt() can return check and early if driver_ready is
> false.
> 
> Note that the hardening is only done for vring interrupt since the
> config interrupt hardening is already done in commit 22b7050a024d7
> ("virtio: defer config changed notifications"). But the method that is
> used by config interrupt can't be reused by the vring interrupt
> handler because it uses spinlock to do the synchronization which is
> expensive.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c       | 11 +++++++++++
>  drivers/virtio/virtio_ring.c  |  9 ++++++++-
>  include/linux/virtio.h        |  2 ++
>  include/linux/virtio_config.h |  8 ++++++++
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 8dde44ea044a..2f3a6f8e3d9c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -220,6 +220,17 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +	if (READ_ONCE(dev->driver_ready)) {
> +		/*
> +		 * The below virtio_synchronize_vqs() guarantees that any
> +		 * interrupt for this line arriving after
> +		 * virtio_synchronize_vqs() has completed is guaranteed to see
> +		 * driver_ready == false.
> +		 */
> +		WRITE_ONCE(dev->driver_ready, false);
> +		virtio_synchronize_vqs(dev);
> +	}
> +
>  	dev->config->reset(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cfb028ca238e..a4592e55c9f8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2127,10 +2127,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>  }
>  
> -irqreturn_t vring_interrupt(int irq, void *_vq)
> +irqreturn_t vring_interrupt(int irq, void *v)
>  {
> +	struct virtqueue *_vq = v;
> +	struct virtio_device *vdev = _vq->vdev;
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	if (!READ_ONCE(vdev->driver_ready)) {


I am not sure why we need READ_ONCE here, it's done under lock.


Accrdingly, same thing above for READ_ONCE and WRITE_ONCE.


> +		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
> +		return IRQ_NONE;
> +	}
> +
>  	if (!more_used(vq)) {
>  		pr_debug("virtqueue interrupt with no work for %p\n", vq);
>  		return IRQ_NONE;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 5464f398912a..dfa2638a293e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -95,6 +95,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>   * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>   * @config_enabled: configuration change reporting enabled
>   * @config_change_pending: configuration change reported while disabled
> + * @driver_ready: whehter the driver is ready (e.g for vring callbacks)
>   * @config_lock: protects configuration change reporting
>   * @dev: underlying device.
>   * @id: the device type identification (used to match it with a driver).
> @@ -109,6 +110,7 @@ struct virtio_device {
>  	bool failed;
>  	bool config_enabled;
>  	bool config_change_pending;
> +	bool driver_ready;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock; /* Protects VQs list access */
>  	struct device dev;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 08b73d9bbff2..c9e207bf2c9c 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -246,6 +246,14 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>  	unsigned status = dev->config->get_status(dev);
>  
> +	virtio_synchronize_vqs(dev);
> +        /*
> +         * The above virtio_synchronize_vqs() make sure


makes sure

> +         * vring_interrupt() will see the driver specific setup if it
> +         * see driver_ready as true.

sees

> +         */
> +	WRITE_ONCE(dev->driver_ready, true);
> +
>  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
> -- 
> 2.25.1

