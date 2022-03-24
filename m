Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8E4E620B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347218AbiCXLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbiCXLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64924580FA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648119793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYjq1ynKk1XjU7AutCMoihkQ2UvFoHsHLt+jhZb03Qw=;
        b=CQjicBRuTOlvamHSACCMbm8JJs6LnTBUtk9iMZ1b/2QCVT7Vr+ry7bHHPvQrkuNeurXVuW
        DVsGrZIRieRz1eB0YA1t/xIhCKER8RJ2h0h7YMp766jJHrpnIIqNMsHgcPBAUwKTomIm/o
        r7NePSjpL7mMlmDTDOyZkUxv7+y3OFQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-qfUw95brOXSGVdOKFg3kSw-1; Thu, 24 Mar 2022 07:03:11 -0400
X-MC-Unique: qfUw95brOXSGVdOKFg3kSw-1
Received: by mail-wm1-f70.google.com with SMTP id h127-20020a1c2185000000b0038c6f7e22a4so3886833wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYjq1ynKk1XjU7AutCMoihkQ2UvFoHsHLt+jhZb03Qw=;
        b=CsSl7VpBDPTMlpQh2UNPDAVww6sbK4f4oY1ud8ABjB6HZ5uTpNaR+dXUAqvbWxOkm2
         FkMmLZ3vMKZoJyX4QdHHg5eNIA/70lS/oov6HOkX0wfNFnj6IU9tLet8nPlEVGPMV13A
         a9D1VW0xCJJFpQ/S2X4DgSE/kVa6hGRC//uWZke2askNp9uvUCqFB2jETFDVf+iHf+ot
         GugsMv+9qRlSvlYQiukv/8g+c/b8AJveHzp9t2sOF411Xk623iD/5fMjwk+cvYDMLrar
         scxKbeTgTk3WsE3vx7UeLz5bfNjjyon5E4UXHwAfBZ71msnqtPP86uLl27smwof0ojkz
         XCDg==
X-Gm-Message-State: AOAM531eWZWOstN6aup2rLHG+v1/cht1z96/4x+REX0+3/wZBSPx9C28
        GNbywTJIlzhv5fiMMxYRG3x+iYnxhb0DKKNuQC1E5O0iatpOIsmuoNVngovvoHtRYKaBycnPA+y
        fYq6o5UCi1X2GVW163Sfny16g
X-Received: by 2002:a05:6000:1541:b0:204:18f1:f6b5 with SMTP id 1-20020a056000154100b0020418f1f6b5mr4213206wry.485.1648119790294;
        Thu, 24 Mar 2022 04:03:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUXsiKJYPEKCQrlyZYEBh9xhpuywKFuEOOoO4mOILC6M1EemI4TKKNXI52MftdYhlP1Wn3Pw==
X-Received: by 2002:a05:6000:1541:b0:204:18f1:f6b5 with SMTP id 1-20020a056000154100b0020418f1f6b5mr4213178wry.485.1648119789964;
        Thu, 24 Mar 2022 04:03:09 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c12c800b0038cc2b67c97sm1681308wmd.19.2022.03.24.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 04:03:06 -0700 (PDT)
Date:   Thu, 24 Mar 2022 07:03:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com, keirf@google.com
Subject: Re: [PATCH 3/3] virtio: harden vring IRQ
Message-ID: <20220324064849-mutt-send-email-mst@kernel.org>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324084004.14349-4-jasowang@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:40:04PM +0800, Jason Wang wrote:
> This is a rework on the previous IRQ hardening that is done for
> virtio-pci where several drawbacks were found and were reverted:
> 
> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>    that is used by some device such as virtio-blk
> 2) done only for PCI transport
> 
> In this patch, we tries to borrow the idea from the INTX IRQ hardening
> in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
> by introducing a global irq_soft_enabled variable for each
> virtio_device. Then we can to toggle it during
> virtio_reset_device()/virtio_device_ready(). A synchornize_rcu() is
> used in virtio_reset_device() to synchronize with the IRQ handlers. In
> the future, we may provide config_ops for the transport that doesn't
> use IRQ. With this, vring_interrupt() can return check and early if
> irq_soft_enabled is false. This lead to smp_load_acquire() to be used
> but the cost should be acceptable.

Maybe it should be but is it? Can't we use synchronize_irq instead?

> 
> To avoid breaking legacy device which can send IRQ before DRIVER_OK, a
> module parameter is introduced to enable the hardening so function
> hardening is disabled by default.

Which devices are these? How come they send an interrupt before there
are any buffers in any queues?

> 
> Note that the hardening is only done for vring interrupt since the
> config interrupt hardening is already done in commit 22b7050a024d7
> ("virtio: defer config changed notifications"). But the method that is
> used by config interrupt can't be reused by the vring interrupt
> handler because it uses spinlock to do the synchronization which is
> expensive.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


> ---
>  drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>  drivers/virtio/virtio_ring.c  |  9 ++++++++-
>  include/linux/virtio.h        |  4 ++++
>  include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 8dde44ea044a..85e331efa9cc 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -7,6 +7,12 @@
>  #include <linux/of.h>
>  #include <uapi/linux/virtio_ids.h>
>  
> +static bool irq_hardening = false;
> +
> +module_param(irq_hardening, bool, 0444);
> +MODULE_PARM_DESC(irq_hardening,
> +		 "Disalbe IRQ software processing when it is not expected");
> +
>  /* Unique numbering for virtio devices. */
>  static DEFINE_IDA(virtio_index_ida);
>  
> @@ -220,6 +226,15 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +	/*
> +	 * The below synchronize_rcu() guarantees that any
> +	 * interrupt for this line arriving after
> +	 * synchronize_rcu() has completed is guaranteed to see
> +	 * irq_soft_enabled == false.

News to me I did not know synchronize_rcu has anything to do
with interrupts. Did not you intend to use synchronize_irq?
I am not even 100% sure synchronize_rcu is by design a memory barrier
though it's most likely is ...

> +	 */
> +	WRITE_ONCE(dev->irq_soft_enabled, false);
> +	synchronize_rcu();
> +
>  	dev->config->reset(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);

Please add comment explaining where it will be enabled.
Also, we *really* don't need to synch if it was already disabled,
let's not add useless overhead to the boot sequence.


> @@ -427,6 +442,10 @@ int register_virtio_device(struct virtio_device *dev)
>  	spin_lock_init(&dev->config_lock);
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
> +	dev->irq_soft_check = irq_hardening;
> +
> +	if (dev->irq_soft_check)
> +		dev_info(&dev->dev, "IRQ hardening is enabled\n");
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */

one of the points of hardening is it's also helpful for buggy
devices. this flag defeats the purpose.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 962f1477b1fa..0170f8c784d8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2144,10 +2144,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
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
> +	if (!virtio_irq_soft_enabled(vdev)) {
> +		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
> +		return IRQ_NONE;
> +	}
> +
>  	if (!more_used(vq)) {
>  		pr_debug("virtqueue interrupt with no work for %p\n", vq);
>  		return IRQ_NONE;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 5464f398912a..957d6ad604ac 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -95,6 +95,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>   * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>   * @config_enabled: configuration change reporting enabled
>   * @config_change_pending: configuration change reported while disabled
> + * @irq_soft_check: whether or not to check @irq_soft_enabled
> + * @irq_soft_enabled: callbacks enabled
>   * @config_lock: protects configuration change reporting
>   * @dev: underlying device.
>   * @id: the device type identification (used to match it with a driver).
> @@ -109,6 +111,8 @@ struct virtio_device {
>  	bool failed;
>  	bool config_enabled;
>  	bool config_change_pending;
> +	bool irq_soft_check;
> +	bool irq_soft_enabled;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock; /* Protects VQs list access */
>  	struct device dev;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index dafdc7f48c01..9c1b61f2e525 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -174,6 +174,24 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>  	return __virtio_test_bit(vdev, fbit);
>  }
>  
> +/*
> + * virtio_irq_soft_enabled: whether we can execute callbacks
> + * @vdev: the device
> + */
> +static inline bool virtio_irq_soft_enabled(const struct virtio_device *vdev)
> +{
> +	if (!vdev->irq_soft_check)
> +		return true;
> +
> +	/*
> +	 * Read irq_soft_enabled before reading other device specific
> +	 * data. Paried with smp_store_relase() in

paired

> +	 * virtio_device_ready() and WRITE_ONCE()/synchronize_rcu() in
> +	 * virtio_reset_device().
> +	 */
> +	return smp_load_acquire(&vdev->irq_soft_enabled);
> +}
> +
>  /**
>   * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>   * @vdev: the device
> @@ -236,6 +254,13 @@ void virtio_device_ready(struct virtio_device *dev)
>  	if (dev->config->enable_cbs)
>                    dev->config->enable_cbs(dev);
>  
> +	/*
> +	 * Commit the driver setup before enabling the virtqueue
> +	 * callbacks. Paried with smp_load_acuqire() in
> +	 * virtio_irq_soft_enabled()
> +	 */
> +	smp_store_release(&dev->irq_soft_enabled, true);
> +
>  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
> -- 
> 2.25.1

