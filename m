Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9046E0B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhLICKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:10:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbhLICKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639015608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mC887ZdN1WmKD1soOyAa6c3nS8AecZUnCpHC6LAqUl4=;
        b=PDfubalnoz/JcpyEGNcSzzllbTf2VkSKQmM9UXr2y73kfiUK3mnN9tCAsnLtgojOLFgIv0
        fEstuujbv8rn4ziWGXE3+Y3iYT5N6IGFCOclwORqJK9ajDS/G3dM6XKIK2jHKa7sDygSvD
        X1c5Z5l1fz2/tL46yd4k89w/PBrcfCo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-C998-WQKPbOgZwcF2iGPsA-1; Wed, 08 Dec 2021 21:06:47 -0500
X-MC-Unique: C998-WQKPbOgZwcF2iGPsA-1
Received: by mail-lf1-f72.google.com with SMTP id z8-20020a056512370800b0041bf49128a9so1953143lfr.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 18:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mC887ZdN1WmKD1soOyAa6c3nS8AecZUnCpHC6LAqUl4=;
        b=ixahgVzGCYxDmGFI5fZxFbyGhWuDAQKw0F6FzaaGbUMswTkDZOabfPGSxroZ7cu34w
         Mxo4+eLOyjnDkI/xhkcElPyDVNRI7CzoUtzGBHiaA9MNF6svlNiXgfyu4SfPCXEqj+b4
         K1ljSb8o4MVWVC8JH8CpbHvEnhphAYsqrHRvjI2gDzGf3VlnsRKJXfT6DkfYTYUhl4hc
         Ny4AIZZiq4I77glrYeayJyuBUJA22OM7cUU2y0Le6YWk3kBf/9LxveHkO0IaCQzxZJBE
         AGveR26dCj2hxpYANlCoocvJD4cvRORhO4vKfM9BBl/jCE1ZCHUleKnFYQi2ipBqcGuN
         KyWw==
X-Gm-Message-State: AOAM530H8CxGF2C6QGFMF7ZbKeeDrzsYRUxak9LKUafqE8hLFUeYrENt
        vfsdd/W2yf8cu8qZx2fFAboEbdZenFQ6d9hNBAZgDPn2OLb/Mefzwlt3xcJzy5lra4CzqGRLCUc
        Itsh1FVdW/IjZ8+a/Xv7+tEWREVTaOIHdUcYfNnFA
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr3240676ljk.420.1639015605815;
        Wed, 08 Dec 2021 18:06:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMgJMyiOBAM5SX9gmlUwV16I4ymfq9KkPGUOs3vjrDROmgUpAFQBSghfD4gJUfgUKXQt4JlQabnVDKsCoWztU=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr3240657ljk.420.1639015605537;
 Wed, 08 Dec 2021 18:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20211126044102.18374-1-jasowang@redhat.com> <20211208151801-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211208151801-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Dec 2021 10:06:34 +0800
Message-ID: <CACGkMEs-ah8VAULcDumPH_u9C2DZQh9SKJ_2bykX5aBCTxnwsA@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-mmio: harden interrupt
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 4:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Nov 26, 2021 at 12:41:02PM +0800, Jason Wang wrote:
> > This patch tries to make sure the virtio interrupt handler for MMIO
> > won't be called after a reset and before virtio_device_ready(). We
> > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > (IRQF_SHARED). So this patch tracks the interrupt enabling status in a
> > new intr_soft_enabled variable and toggle it during in
> > vm_disable/enable_interrupts(). The MMIO interrupt handler will check
> > intr_soft_enabled before processing the actual interrupt.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - Silent compling warnings
> >  drivers/virtio/virtio_mmio.c | 37 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 56128b9c46eb..c517afdd2cc5 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -90,6 +90,7 @@ struct virtio_mmio_device {
> >       /* a list of queues so we can dispatch IRQs */
> >       spinlock_t lock;
> >       struct list_head virtqueues;
> > +     bool intr_soft_enabled;
> >  };
> >
> >  struct virtio_mmio_vq_info {
> > @@ -100,7 +101,37 @@ struct virtio_mmio_vq_info {
> >       struct list_head node;
> >  };
> >
> > +/* disable irq handlers */
> > +static void vm_disable_cbs(struct virtio_device *vdev)
> > +{
> > +     struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > +     int irq = platform_get_irq(vm_dev->pdev, 0);
> >
> > +     /*
> > +      * The below synchronize() guarantees that any
> > +      * interrupt for this line arriving after
> > +      * synchronize_irq() has completed is guaranteed to see
> > +      * intx_soft_enabled == false.
> > +      */
> > +     WRITE_ONCE(vm_dev->intr_soft_enabled, false);
> > +     synchronize_irq(irq);
> > +}
> > +
> > +/* enable irq handlers */
> > +static void vm_enable_cbs(struct virtio_device *vdev)
> > +{
> > +     struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > +     int irq = platform_get_irq(vm_dev->pdev, 0);
> > +
> > +     disable_irq(irq);
> > +     /*
> > +      * The above disable_irq() provides TSO ordering and
> > +      * as such promotes the below store to store-release.
> > +      */
> > +     WRITE_ONCE(vm_dev->intr_soft_enabled, true);
> > +     enable_irq(irq);
> > +     return;
> > +}
> >
> >  /* Configuration interface */
> >
> > @@ -262,6 +293,8 @@ static void vm_reset(struct virtio_device *vdev)
> >
> >       /* 0 status means a reset. */
> >       writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
>
> There was a discussion about reading status to make sure it is clear.
> The spec says we should, this can't hurt as a further hardening measure.
> In fact, let's do it in the core maybe? Spec says it applies to all
> devices ...

We can do that, but I'm not sure if we break some existing device.

>
> > +     /* Disable VQ/configuration callbacks. */
> > +     vm_disable_cbs(vdev);
> >  }
> >
> >
> > @@ -288,6 +321,9 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
> >       unsigned long flags;
> >       irqreturn_t ret = IRQ_NONE;
> >
> > +     if (!READ_ONCE(vm_dev->intr_soft_enabled))
> > +             return IRQ_NONE;
> > +
>
> So if the write is seen before reset happened (should not happen, but we
> are talking a buggy device) then it won't be acknowledged and device
> will keep pulling the interrupt. I think as long as we are hardening
> this, let's go the full mile and try to avoid DoS if we can, do the
> check before invoking the callback, but do not skip the read.
> Whether to still return IRQ_NONE is a good question.

Did you mean something like this:

        /* Read and acknowledge interrupts */
        status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
        writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);

        if (status)
                ret = IRQ_HANDLED;

       if (!READ_ONCE(vm_dev->intr_soft_enabled))
               return ret;

Thanks

>
>
>
>
> >       /* Read and acknowledge interrupts */
> >       status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
> >       writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
> > @@ -529,6 +565,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
> >  }
> >
> >  static const struct virtio_config_ops virtio_mmio_config_ops = {
> > +     .enable_cbs     = vm_enable_cbs,
> >       .get            = vm_get,
> >       .set            = vm_set,
> >       .generation     = vm_generation,
> > --
> > 2.25.1
>

