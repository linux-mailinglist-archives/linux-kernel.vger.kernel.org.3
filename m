Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23946E390
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhLIIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230042AbhLIIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639036662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OCchJqXlkcPKFU5BGgoX3zpc0zrMK5iqRL4iPWX0udg=;
        b=Puf2zSZwQpI/Ojmd0fz8hyuyeFwrs/zrW7MmlnwPc/U3OC/UYgml96DQuVwMGttrMcAfY2
        3sYPXZCsvCKBqbwfJC08AOhwGdynBWVvtu8MSmMgTSdFrJNuciEryRXQY2Dn7vTMR+AMGD
        RzU19tISXvpsD7PGMdreeO7gCHlJBxc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-273-cPt7TSBlO8Kq1_0Yzh8oNg-1; Thu, 09 Dec 2021 02:57:41 -0500
X-MC-Unique: cPt7TSBlO8Kq1_0Yzh8oNg-1
Received: by mail-lj1-f198.google.com with SMTP id n6-20020a2e82c6000000b00221698ffa68so1464246ljh.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 23:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCchJqXlkcPKFU5BGgoX3zpc0zrMK5iqRL4iPWX0udg=;
        b=VY66fmbJhnmMcoVR93YeJULTo/BKX+hFvaZN4yRrR21z54eHtrF7PCMmzqxo/F9Rpa
         pzri+VO14JndfkC95RT2z3DV1fpsHxKU/FEL+kYwxbzWoQHvrTXb/7sTmzpfIfFviSgQ
         NBmIPhqgSt8TJEJu6ID1lHPgtpBKnqIJ7d1aM/CTbGIkc7Oe99F7MRgci1G5oZd10vfb
         C5QoBaevFak4V5c74YhZs7iI+OaOuAMhnCdNO4HFYm7P0MM2PMOFC8X5oIBBo1h3k282
         GT7cHuM7YWV6nEqJu6YklNCEKRkcchpC0KI/Rv5P2k6JKI+384Ip91C/b2sAauHHHYJL
         2MDw==
X-Gm-Message-State: AOAM531H3RXm3Zt6CK7RX/DreWVuUtz+mhxRYkQ1p8RYU+dovaQIHrQq
        EmplXRTPb2BvmDw4kAJdrUTvf2XoMUMVuTmZZRppI01b6MNz0JIiEp+9oqfWtMbtXhO/qwRmRjA
        fmvAzK86VpGIF/4bLa6PidNgYJTWeNBNnmu0mhRGs
X-Received: by 2002:a2e:915a:: with SMTP id q26mr4464182ljg.277.1639036659766;
        Wed, 08 Dec 2021 23:57:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlrR2u2AzX8ydVKKQ6AlXap6y6RZ+sD0Jjw3+YUukSsKKUjBU09U/YBMhNgB1VKj/LJTNTrklmuM7IzfjUSkY=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr4464165ljg.277.1639036659555;
 Wed, 08 Dec 2021 23:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20211126044102.18374-1-jasowang@redhat.com> <20211208151801-mutt-send-email-mst@kernel.org>
 <CACGkMEs-ah8VAULcDumPH_u9C2DZQh9SKJ_2bykX5aBCTxnwsA@mail.gmail.com> <20211209015205-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211209015205-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Dec 2021 15:57:28 +0800
Message-ID: <CACGkMEu89hnGKgQBSuwCA1FPkwpFyXX-MTsuHwUu3vEP2p-EVw@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-mmio: harden interrupt
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 2:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Dec 09, 2021 at 10:06:34AM +0800, Jason Wang wrote:
> > On Thu, Dec 9, 2021 at 4:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Nov 26, 2021 at 12:41:02PM +0800, Jason Wang wrote:
> > > > This patch tries to make sure the virtio interrupt handler for MMIO
> > > > won't be called after a reset and before virtio_device_ready(). We
> > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > (IRQF_SHARED). So this patch tracks the interrupt enabling status in a
> > > > new intr_soft_enabled variable and toggle it during in
> > > > vm_disable/enable_interrupts(). The MMIO interrupt handler will check
> > > > intr_soft_enabled before processing the actual interrupt.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > > Changes since V1:
> > > > - Silent compling warnings
> > > >  drivers/virtio/virtio_mmio.c | 37 ++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 37 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > > index 56128b9c46eb..c517afdd2cc5 100644
> > > > --- a/drivers/virtio/virtio_mmio.c
> > > > +++ b/drivers/virtio/virtio_mmio.c
> > > > @@ -90,6 +90,7 @@ struct virtio_mmio_device {
> > > >       /* a list of queues so we can dispatch IRQs */
> > > >       spinlock_t lock;
> > > >       struct list_head virtqueues;
> > > > +     bool intr_soft_enabled;
> > > >  };
> > > >
> > > >  struct virtio_mmio_vq_info {
> > > > @@ -100,7 +101,37 @@ struct virtio_mmio_vq_info {
> > > >       struct list_head node;
> > > >  };
> > > >
> > > > +/* disable irq handlers */
> > > > +static void vm_disable_cbs(struct virtio_device *vdev)
> > > > +{
> > > > +     struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > > > +     int irq = platform_get_irq(vm_dev->pdev, 0);
> > > >
> > > > +     /*
> > > > +      * The below synchronize() guarantees that any
> > > > +      * interrupt for this line arriving after
> > > > +      * synchronize_irq() has completed is guaranteed to see
> > > > +      * intx_soft_enabled == false.
> > > > +      */
> > > > +     WRITE_ONCE(vm_dev->intr_soft_enabled, false);
> > > > +     synchronize_irq(irq);
> > > > +}
> > > > +
> > > > +/* enable irq handlers */
> > > > +static void vm_enable_cbs(struct virtio_device *vdev)
> > > > +{
> > > > +     struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > > > +     int irq = platform_get_irq(vm_dev->pdev, 0);
> > > > +
> > > > +     disable_irq(irq);
> > > > +     /*
> > > > +      * The above disable_irq() provides TSO ordering and
> > > > +      * as such promotes the below store to store-release.
> > > > +      */
> > > > +     WRITE_ONCE(vm_dev->intr_soft_enabled, true);
> > > > +     enable_irq(irq);
> > > > +     return;
> > > > +}
> > > >
> > > >  /* Configuration interface */
> > > >
> > > > @@ -262,6 +293,8 @@ static void vm_reset(struct virtio_device *vdev)
> > > >
> > > >       /* 0 status means a reset. */
> > > >       writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> > >
> > > There was a discussion about reading status to make sure it is clear.
> > > The spec says we should, this can't hurt as a further hardening measure.
> > > In fact, let's do it in the core maybe? Spec says it applies to all
> > > devices ...
> >
> > We can do that, but I'm not sure if we break some existing device.
>
> Hmm. Have anything specific in mind?

No, I can send a patch to do that.

>
> > >
> > > > +     /* Disable VQ/configuration callbacks. */
> > > > +     vm_disable_cbs(vdev);
> > > >  }
> > > >
> > > >
> > > > @@ -288,6 +321,9 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
> > > >       unsigned long flags;
> > > >       irqreturn_t ret = IRQ_NONE;
> > > >
> > > > +     if (!READ_ONCE(vm_dev->intr_soft_enabled))
> > > > +             return IRQ_NONE;
> > > > +
> > >
> > > So if the write is seen before reset happened (should not happen, but we
> > > are talking a buggy device) then it won't be acknowledged and device
> > > will keep pulling the interrupt. I think as long as we are hardening
> > > this, let's go the full mile and try to avoid DoS if we can, do the
> > > check before invoking the callback, but do not skip the read.
> > > Whether to still return IRQ_NONE is a good question.
> >
> > Did you mean something like this:
> >
> >         /* Read and acknowledge interrupts */
> >         status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
> >         writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
> >
> >         if (status)
> >                 ret = IRQ_HANDLED;
> >
> >        if (!READ_ONCE(vm_dev->intr_soft_enabled))
> >                return ret;
> >
> > Thanks
>
> Maybe. Or is
>
>         if (!READ_ONCE(vm_dev->intr_soft_enabled))
>                 return IRQ_NONE;
>
> better here?

Yes, I just paste part of the code, the ret is initialized to IRQ_NONE.

Thanks

>
>
> > >
> > >
> > >
> > >
> > > >       /* Read and acknowledge interrupts */
> > > >       status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
> > > >       writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
> > > > @@ -529,6 +565,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
> > > >  }
> > > >
> > > >  static const struct virtio_config_ops virtio_mmio_config_ops = {
> > > > +     .enable_cbs     = vm_enable_cbs,
> > > >       .get            = vm_get,
> > > >       .set            = vm_set,
> > > >       .generation     = vm_generation,
> > > > --
> > > > 2.25.1
> > >
>

