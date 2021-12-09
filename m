Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55EA46E2CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhLIG7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:59:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231517AbhLIG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639032957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/fb62qxVVfvgceW+7mro5MbYtbA/njW6uOUzofuzKQ0=;
        b=UxFqxRvhXqyOcAKDfeSZkzHInE3CqoJixcBoQvKLX0BH9MzwYwSJ/DQkxvEoEK/OWH0qGn
        KAWfxAiwCCg5BKxZLZ1WZwEBrSTKY8aMHXmYUyA5yWrbuPO959l2XmDG0WX4tiVp5nb0ej
        SHCh01oe2Z/86Y/9ydX6V2v9wIVQX1o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-z_kG2imVMRqXFyhJqggduA-1; Thu, 09 Dec 2021 01:55:55 -0500
X-MC-Unique: z_kG2imVMRqXFyhJqggduA-1
Received: by mail-wm1-f72.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso4378106wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/fb62qxVVfvgceW+7mro5MbYtbA/njW6uOUzofuzKQ0=;
        b=R0tYgkhjRk6iRMH+8B6P6CeS4Zu7anWp/lC4RoFrryJBPdOQqLIE6iJsqJACJX9ngO
         Vn0ymReqekXiXiB3Y58CqQQCnLglxfjbL1GyTGQqFbKgmf7/6e18Fh1eFLfvdnQtdbII
         uPYtgaCV08mw6yDDHyig73t7t4H3tLsYW5xCEbSsQJScxTPmnDQkOuAy1mw9nTNKWECG
         eKtt1P2iCq6pBPXvlDQS8iQNAvWSq/aEiLTWV6c7rt+ocqT/wg43Q7WuufRMkhPkBVBj
         9Ncz3jYO4HDUHsz24FhOK4u0t6IWp4qDgb3huXRwxB2DsTKjMZ3gQgLS2qQtoyTE18rG
         OC4g==
X-Gm-Message-State: AOAM533kMhnEwN72Pv5MCijAkt+h5XFvxp2t4IaK1weA4OpDDHqPcint
        HBSTMiKGifwbpwlVELwxY461iPu4FaR/BUyB0MO563KXCQ12b7sdY/qE1pziv+TTcBFkHQCQvfX
        WaX0vX/PtYVDyRHHk76TzdCAX
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr4835612wmj.30.1639032954444;
        Wed, 08 Dec 2021 22:55:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFjgkHORRhDzdGFhtR2vh0mcJ117Rtzn0FOi+3LPmzp4mLAvIEY2WhtWYopTY+U6sr6lywbQ==
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr4835591wmj.30.1639032954203;
        Wed, 08 Dec 2021 22:55:54 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id l26sm4927855wms.15.2021.12.08.22.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 22:55:53 -0800 (PST)
Date:   Thu, 9 Dec 2021 01:55:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] virtio-mmio: harden interrupt
Message-ID: <20211209015205-mutt-send-email-mst@kernel.org>
References: <20211126044102.18374-1-jasowang@redhat.com>
 <20211208151801-mutt-send-email-mst@kernel.org>
 <CACGkMEs-ah8VAULcDumPH_u9C2DZQh9SKJ_2bykX5aBCTxnwsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEs-ah8VAULcDumPH_u9C2DZQh9SKJ_2bykX5aBCTxnwsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:06:34AM +0800, Jason Wang wrote:
> On Thu, Dec 9, 2021 at 4:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Nov 26, 2021 at 12:41:02PM +0800, Jason Wang wrote:
> > > This patch tries to make sure the virtio interrupt handler for MMIO
> > > won't be called after a reset and before virtio_device_ready(). We
> > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > (IRQF_SHARED). So this patch tracks the interrupt enabling status in a
> > > new intr_soft_enabled variable and toggle it during in
> > > vm_disable/enable_interrupts(). The MMIO interrupt handler will check
> > > intr_soft_enabled before processing the actual interrupt.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - Silent compling warnings
> > >  drivers/virtio/virtio_mmio.c | 37 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > index 56128b9c46eb..c517afdd2cc5 100644
> > > --- a/drivers/virtio/virtio_mmio.c
> > > +++ b/drivers/virtio/virtio_mmio.c
> > > @@ -90,6 +90,7 @@ struct virtio_mmio_device {
> > >       /* a list of queues so we can dispatch IRQs */
> > >       spinlock_t lock;
> > >       struct list_head virtqueues;
> > > +     bool intr_soft_enabled;
> > >  };
> > >
> > >  struct virtio_mmio_vq_info {
> > > @@ -100,7 +101,37 @@ struct virtio_mmio_vq_info {
> > >       struct list_head node;
> > >  };
> > >
> > > +/* disable irq handlers */
> > > +static void vm_disable_cbs(struct virtio_device *vdev)
> > > +{
> > > +     struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > > +     int irq = platform_get_irq(vm_dev->pdev, 0);
> > >
> > > +     /*
> > > +      * The below synchronize() guarantees that any
> > > +      * interrupt for this line arriving after
> > > +      * synchronize_irq() has completed is guaranteed to see
> > > +      * intx_soft_enabled == false.
> > > +      */
> > > +     WRITE_ONCE(vm_dev->intr_soft_enabled, false);
> > > +     synchronize_irq(irq);
> > > +}
> > > +
> > > +/* enable irq handlers */
> > > +static void vm_enable_cbs(struct virtio_device *vdev)
> > > +{
> > > +     struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > > +     int irq = platform_get_irq(vm_dev->pdev, 0);
> > > +
> > > +     disable_irq(irq);
> > > +     /*
> > > +      * The above disable_irq() provides TSO ordering and
> > > +      * as such promotes the below store to store-release.
> > > +      */
> > > +     WRITE_ONCE(vm_dev->intr_soft_enabled, true);
> > > +     enable_irq(irq);
> > > +     return;
> > > +}
> > >
> > >  /* Configuration interface */
> > >
> > > @@ -262,6 +293,8 @@ static void vm_reset(struct virtio_device *vdev)
> > >
> > >       /* 0 status means a reset. */
> > >       writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> >
> > There was a discussion about reading status to make sure it is clear.
> > The spec says we should, this can't hurt as a further hardening measure.
> > In fact, let's do it in the core maybe? Spec says it applies to all
> > devices ...
> 
> We can do that, but I'm not sure if we break some existing device.

Hmm. Have anything specific in mind?

> >
> > > +     /* Disable VQ/configuration callbacks. */
> > > +     vm_disable_cbs(vdev);
> > >  }
> > >
> > >
> > > @@ -288,6 +321,9 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
> > >       unsigned long flags;
> > >       irqreturn_t ret = IRQ_NONE;
> > >
> > > +     if (!READ_ONCE(vm_dev->intr_soft_enabled))
> > > +             return IRQ_NONE;
> > > +
> >
> > So if the write is seen before reset happened (should not happen, but we
> > are talking a buggy device) then it won't be acknowledged and device
> > will keep pulling the interrupt. I think as long as we are hardening
> > this, let's go the full mile and try to avoid DoS if we can, do the
> > check before invoking the callback, but do not skip the read.
> > Whether to still return IRQ_NONE is a good question.
> 
> Did you mean something like this:
> 
>         /* Read and acknowledge interrupts */
>         status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
>         writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
> 
>         if (status)
>                 ret = IRQ_HANDLED;
> 
>        if (!READ_ONCE(vm_dev->intr_soft_enabled))
>                return ret;
> 
> Thanks

Maybe. Or is

        if (!READ_ONCE(vm_dev->intr_soft_enabled))
                return IRQ_NONE;

better here?


> >
> >
> >
> >
> > >       /* Read and acknowledge interrupts */
> > >       status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
> > >       writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
> > > @@ -529,6 +565,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
> > >  }
> > >
> > >  static const struct virtio_config_ops virtio_mmio_config_ops = {
> > > +     .enable_cbs     = vm_enable_cbs,
> > >       .get            = vm_get,
> > >       .set            = vm_set,
> > >       .generation     = vm_generation,
> > > --
> > > 2.25.1
> >

