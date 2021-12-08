Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BAD46DD08
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhLHUbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232235AbhLHUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638995263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ev59STihuBF0lv3Z72rhNC+eAvsSVcdOYjBliasz+5Q=;
        b=S7OIkJtjmRR+GZZF0Zkou1Sc+hyHog3nR36GzbZq4qPi7YpgZuaR/3eTOiBxtoAjkRHuKE
        CZ+qNWjmZUSNfOyaXyN6naaQG0BXcPIV/SsfZOWVE0EKG1xLHMsx34wgLeNZpAPAcMCs52
        tZqZO1BLHbcFGD1jZoGdRDPihKkjHDk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-Vrg8hQk3Ome8ZG_J6e519Q-1; Wed, 08 Dec 2021 15:27:42 -0500
X-MC-Unique: Vrg8hQk3Ome8ZG_J6e519Q-1
Received: by mail-wm1-f71.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso1810460wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ev59STihuBF0lv3Z72rhNC+eAvsSVcdOYjBliasz+5Q=;
        b=P2l0dR1cgF5VPEGBbaibxd51W9vLQBJ5bUnm16tS1OJCs16GRkbWyGvW3IxVRibJ4r
         whTFBxMB3x1be43d+OgtXLF9BcUnU94S4PJK5U7rnYhLhkMZs8HZaUWoKxri4XYYmX3x
         ayow3RWuLA4lhwDIlwm0GlQzE37HzixhvaB0axMMCZL8jFdwzIXgyKzcbAvGBAhJtkB/
         QJWd42Zm/z9zutf25gxnZFPBdjoUC3YRa/yCFiPWNP51otI9Yf+3pgIBGtQd67uWGnsL
         hR6n87/z0lVY35hjJtDDhFZoe3xnga37V+WaZrRrrKJ8CJ4uObskpNXRza1XI/4NYIKG
         eLeA==
X-Gm-Message-State: AOAM5313O2xkVyJaSbjzwqkaFnpMYtmnnlxOf5Y/LXHjgdMG1xcBluoI
        eBgZhlXrC6y+A2eyHO0PXg5o/l36ac8I4DwExzEb7o0xcOycFiFkgm45zibx5+IHRHtUmnBZSLs
        shbhpR/wA9KQjEjsBmLQCXLbU
X-Received: by 2002:a1c:8002:: with SMTP id b2mr1202107wmd.2.1638995260938;
        Wed, 08 Dec 2021 12:27:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+Ew/GMC+D59qHQoNdS7PwVTKJL+WtNoA4/cYkJjZFPRDqJ0hQUabJznSE72GBSSvH656KUw==
X-Received: by 2002:a1c:8002:: with SMTP id b2mr1202078wmd.2.1638995260690;
        Wed, 08 Dec 2021 12:27:40 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id e18sm3646611wrs.48.2021.12.08.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:27:40 -0800 (PST)
Date:   Wed, 8 Dec 2021 15:27:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] virtio-mmio: harden interrupt
Message-ID: <20211208151801-mutt-send-email-mst@kernel.org>
References: <20211126044102.18374-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126044102.18374-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 12:41:02PM +0800, Jason Wang wrote:
> This patch tries to make sure the virtio interrupt handler for MMIO
> won't be called after a reset and before virtio_device_ready(). We
> can't use IRQF_NO_AUTOEN since we're using shared interrupt
> (IRQF_SHARED). So this patch tracks the interrupt enabling status in a
> new intr_soft_enabled variable and toggle it during in
> vm_disable/enable_interrupts(). The MMIO interrupt handler will check
> intr_soft_enabled before processing the actual interrupt.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - Silent compling warnings
>  drivers/virtio/virtio_mmio.c | 37 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 56128b9c46eb..c517afdd2cc5 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -90,6 +90,7 @@ struct virtio_mmio_device {
>  	/* a list of queues so we can dispatch IRQs */
>  	spinlock_t lock;
>  	struct list_head virtqueues;
> +	bool intr_soft_enabled;
>  };
>  
>  struct virtio_mmio_vq_info {
> @@ -100,7 +101,37 @@ struct virtio_mmio_vq_info {
>  	struct list_head node;
>  };
>  
> +/* disable irq handlers */
> +static void vm_disable_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	int irq = platform_get_irq(vm_dev->pdev, 0);
>  
> +	/*
> +	 * The below synchronize() guarantees that any
> +	 * interrupt for this line arriving after
> +	 * synchronize_irq() has completed is guaranteed to see
> +	 * intx_soft_enabled == false.
> +	 */
> +	WRITE_ONCE(vm_dev->intr_soft_enabled, false);
> +	synchronize_irq(irq);
> +}
> +
> +/* enable irq handlers */
> +static void vm_enable_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	int irq = platform_get_irq(vm_dev->pdev, 0);
> +
> +	disable_irq(irq);
> +	/*
> +	 * The above disable_irq() provides TSO ordering and
> +	 * as such promotes the below store to store-release.
> +	 */
> +	WRITE_ONCE(vm_dev->intr_soft_enabled, true);
> +	enable_irq(irq);
> +	return;
> +}
>  
>  /* Configuration interface */
>  
> @@ -262,6 +293,8 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);

There was a discussion about reading status to make sure it is clear.
The spec says we should, this can't hurt as a further hardening measure.
In fact, let's do it in the core maybe? Spec says it applies to all
devices ...

> +	/* Disable VQ/configuration callbacks. */
> +	vm_disable_cbs(vdev);
>  }
>  
>  
> @@ -288,6 +321,9 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
>  	unsigned long flags;
>  	irqreturn_t ret = IRQ_NONE;
>  
> +	if (!READ_ONCE(vm_dev->intr_soft_enabled))
> +		return IRQ_NONE;
> +

So if the write is seen before reset happened (should not happen, but we
are talking a buggy device) then it won't be acknowledged and device
will keep pulling the interrupt. I think as long as we are hardening
this, let's go the full mile and try to avoid DoS if we can, do the
check before invoking the callback, but do not skip the read.
Whether to still return IRQ_NONE is a good question.




>  	/* Read and acknowledge interrupts */
>  	status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
>  	writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
> @@ -529,6 +565,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>  }
>  
>  static const struct virtio_config_ops virtio_mmio_config_ops = {
> +	.enable_cbs     = vm_enable_cbs,
>  	.get		= vm_get,
>  	.set		= vm_set,
>  	.generation	= vm_generation,
> -- 
> 2.25.1

