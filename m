Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1F566F55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiGENg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGENgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 344AEB1D6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657025834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjptA2ZJdNxU1nbLlCQdoMlOkDrm1k7jYSzMWXuoOkw=;
        b=WO1qk9HYCgbdAXwUs/mG8xUR9I5fAwyNZtA656kaVZEwKKC6M7pq9trPsSfTwjSDPpLSa8
        k3L5ijatJFkMENi1seSdXLXnXKf0aywpSr9M8sCHj+/T2zY5ljcDMuOSaxZ/iqRj2ddqYZ
        hOv7c2eynnRWXO/hMANR86xkb6wuC9U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-QXRVZZ5lOdCb2-yLMvvMZg-1; Tue, 05 Jul 2022 08:57:12 -0400
X-MC-Unique: QXRVZZ5lOdCb2-yLMvvMZg-1
Received: by mail-lf1-f70.google.com with SMTP id bi38-20020a0565120ea600b0047f640eaee0so3995319lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cjptA2ZJdNxU1nbLlCQdoMlOkDrm1k7jYSzMWXuoOkw=;
        b=2OnEqr0CVA4vKG8gxUKkzFQnjMtATfJ7MhiScH4lDoTou87cs3Az244n5T7+wsaEiT
         VAycGdxZvwW9F/rUswLu9pucVJpzIYMIlhkh7jCKF6xi8xI5UicUOY0jAn4SM15G1w9R
         nO7nD9eQl6ecaCjFDY0j3qYj8hhNRZKXbEPIRslNYQxhm/pv1a+dVu9M1SIJng+HjZnT
         Cxj3YMnZJH4if4NwawUcWnAT1MnLEIkCcPjQ1vVgHa1veDyZfu+Xx9bz0nXMMglFiLuq
         Lar8EGUhf79UjO+KDyCAePKJoaPprAudsHfMYFfiN1bpfajQOloHCkxtr6N9UBwypKkF
         8WFQ==
X-Gm-Message-State: AJIora/Cr69DljA4k0ZytfFgfTWKnMK9x2RQJ4RRAZ6Uy19+EhoNKeg+
        v7TIXWqR8N0+IMtPmxsMuD3XGxJKCSbKVIVfjljIgLBOZQZw1tP9OsGmA7ugRRnvaOOqmDAA7MD
        hnIKdboyBsGPCgcRlQimXY+2M7WPk7HtNHy6BpGiQ
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id b24-20020a2e8958000000b0025a852ac302mr19997528ljk.130.1657025831062;
        Tue, 05 Jul 2022 05:57:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tziaPbq/IYloKRJnhwO6lLY6BWG39VHutGsfJu15nS2YlfKPmXqa6RsYhoa5lRxfkN9WWiVMSBd0rjOQBS/T8=
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id
 b24-20020a2e8958000000b0025a852ac302mr19997503ljk.130.1657025830803; Tue, 05
 Jul 2022 05:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220527060120.20964-1-jasowang@redhat.com> <20220527060120.20964-9-jasowang@redhat.com>
 <df5a9628-3a00-d18c-9cac-ae6460695cb3@hisilicon.com>
In-Reply-To: <df5a9628-3a00-d18c-9cac-ae6460695cb3@hisilicon.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 5 Jul 2022 20:56:59 +0800
Message-ID: <CACGkMEu8EECPamY__OqQNf7iuKU7nho_-mij2zWULfV2rV+d7A@mail.gmail.com>
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 7:09 PM chenxiang (M) <chenxiang66@hisilicon.com> wr=
ote:
>
> Hi,
>
> I encounter a issue when testing virtio-balloon on my platform (ARM64)
> with kernel 5.19-rc4 to boot VM with "-device virtio-balloon ", and
>
> then change the size of balloon in qemu monitor, but it isn't valid, and
> the log is as follows:
>
> QEMU 6.1.50 monitor - type 'help' for more information
> (qemu) info balloon
> info balloon
> balloon: actual=3D4096
> (qemu) balloon 3172
> balloon 3172
> (qemu) info balloon
> info balloon
> balloon: actual=3D4096
>
> I git bisect the patch, and find this patch
> ([8b4ec69d7e098a7ddf832e1e7840de53ed474c77] virtio: harden vring IRQ) at
> last.
>
> Do you have any idea about it?

Yes, we noticed this issue and have disable the hardening feature via:

c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163 ("virtio: disable
notification hardening by default")
6a9720576cd00d30722c5f755bd17d4cfa9df636 ("virtio:
VIRTIO_HARDEN_NOTIFICATION is broken")

which have been merged in Michael's tree.

https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=3Dl=
inux-next&id=3D6a9720576cd00d30722c5f755bd17d4cfa9df636

Thanks

>
>
> Best regards,
>
> Xiang Chen
>
> =E5=9C=A8 2022/5/27 14:01, Jason Wang =E5=86=99=E9=81=93:
> > This is a rework on the previous IRQ hardening that is done for
> > virtio-pci where several drawbacks were found and were reverted:
> >
> > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed =
IRQ
> >     that is used by some device such as virtio-blk
> > 2) done only for PCI transport
> >
> > The vq->broken is re-used in this patch for implementing the IRQ
> > hardening. The vq->broken is set to true during both initialization
> > and reset. And the vq->broken is set to false in
> > virtio_device_ready(). Then vring_interrupt() can check and return
> > when vq->broken is true. And in this case, switch to return IRQ_NONE
> > to let the interrupt core aware of such invalid interrupt to prevent
> > IRQ storm.
> >
> > The reason of using a per queue variable instead of a per device one
> > is that we may need it for per queue reset hardening in the future.
> >
> > Note that the hardening is only done for vring interrupt since the
> > config interrupt hardening is already done in commit 22b7050a024d7
> > ("virtio: defer config changed notifications"). But the method that is
> > used by config interrupt can't be reused by the vring interrupt
> > handler because it uses spinlock to do the synchronization which is
> > expensive.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/s390/virtio/virtio_ccw.c       |  4 ++++
> >   drivers/virtio/virtio.c                | 15 ++++++++++++---
> >   drivers/virtio/virtio_mmio.c           |  5 +++++
> >   drivers/virtio/virtio_pci_modern_dev.c |  5 +++++
> >   drivers/virtio/virtio_ring.c           | 11 +++++++----
> >   include/linux/virtio_config.h          | 20 ++++++++++++++++++++
> >   6 files changed, 53 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/vir=
tio_ccw.c
> > index c188e4f20ca3..97e51c34e6cf 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -971,6 +971,10 @@ static void virtio_ccw_set_status(struct virtio_de=
vice *vdev, u8 status)
> >       ccw->flags =3D 0;
> >       ccw->count =3D sizeof(status);
> >       ccw->cda =3D (__u32)(unsigned long)&vcdev->dma_area->status;
> > +     /* We use ssch for setting the status which is a serializing
> > +      * instruction that guarantees the memory writes have
> > +      * completed before ssch.
> > +      */
> >       ret =3D ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
> >       /* Write failed? We assume status is unchanged. */
> >       if (ret)
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index aa1eb5132767..95fac4c97c8b 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device=
 *dev)
> >    * */
> >   void virtio_reset_device(struct virtio_device *dev)
> >   {
> > +     /*
> > +      * The below virtio_synchronize_cbs() guarantees that any
> > +      * interrupt for this line arriving after
> > +      * virtio_synchronize_vqs() has completed is guaranteed to see
> > +      * vq->broken as true.
> > +      */
> > +     virtio_break_device(dev);
> > +     virtio_synchronize_cbs(dev);
> > +
> >       dev->config->reset(dev);
> >   }
> >   EXPORT_SYMBOL_GPL(virtio_reset_device);
> > @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *de=
v)
> >       dev->config_enabled =3D false;
> >       dev->config_change_pending =3D false;
> >
> > +     INIT_LIST_HEAD(&dev->vqs);
> > +     spin_lock_init(&dev->vqs_list_lock);
> > +
> >       /* We always start by resetting the device, in case a previous
> >        * driver messed it up.  This also tests that code path a little.=
 */
> >       virtio_reset_device(dev);
> > @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *de=
v)
> >       /* Acknowledge that we've seen the device. */
> >       virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> >
> > -     INIT_LIST_HEAD(&dev->vqs);
> > -     spin_lock_init(&dev->vqs_list_lock);
> > -
> >       /*
> >        * device_add() causes the bus infrastructure to look for a match=
ing
> >        * driver.
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.=
c
> > index c9699a59f93c..f9a36bc7ac27 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -253,6 +253,11 @@ static void vm_set_status(struct virtio_device *vd=
ev, u8 status)
> >       /* We should never be setting status to 0. */
> >       BUG_ON(status =3D=3D 0);
> >
> > +     /*
> > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > +      * that the the cache coherent memory writes have completed
> > +      * before writing to the MMIO region.
> > +      */
> >       writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> >   }
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/vi=
rtio_pci_modern_dev.c
> > index 4093f9cca7a6..a0fa14f28a7f 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -467,6 +467,11 @@ void vp_modern_set_status(struct virtio_pci_modern=
_device *mdev,
> >   {
> >       struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> >
> > +     /*
> > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > +      * that the the cache coherent memory writes have completed
> > +      * before writing to the MMIO region.
> > +      */
> >       vp_iowrite8(status, &cfg->device_status);
> >   }
> >   EXPORT_SYMBOL_GPL(vp_modern_set_status);
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 9c231e1fded7..13a7348cedff 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1688,7 +1688,7 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
> >       vq->we_own_ring =3D true;
> >       vq->notify =3D notify;
> >       vq->weak_barriers =3D weak_barriers;
> > -     vq->broken =3D false;
> > +     vq->broken =3D true;
> >       vq->last_used_idx =3D 0;
> >       vq->event_triggered =3D false;
> >       vq->num_added =3D 0;
> > @@ -2134,8 +2134,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >               return IRQ_NONE;
> >       }
> >
> > -     if (unlikely(vq->broken))
> > -             return IRQ_HANDLED;
> > +     if (unlikely(vq->broken)) {
> > +             dev_warn_once(&vq->vq.vdev->dev,
> > +                           "virtio vring IRQ raised before DRIVER_OK")=
;
> > +             return IRQ_NONE;
> > +     }
> >
> >       /* Just a hint for performance: so it's ok that this can be racy!=
 */
> >       if (vq->event)
> > @@ -2177,7 +2180,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned =
int index,
> >       vq->we_own_ring =3D false;
> >       vq->notify =3D notify;
> >       vq->weak_barriers =3D weak_barriers;
> > -     vq->broken =3D false;
> > +     vq->broken =3D true;
> >       vq->last_used_idx =3D 0;
> >       vq->event_triggered =3D false;
> >       vq->num_added =3D 0;
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_confi=
g.h
> > index 25be018810a7..d4edfd7d91bb 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -256,6 +256,26 @@ void virtio_device_ready(struct virtio_device *dev=
)
> >       unsigned status =3D dev->config->get_status(dev);
> >
> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > +
> > +     /*
> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > +      * will see the driver specific setup if it sees vq->broken
> > +      * as false (even if the notifications come before DRIVER_OK).
> > +      */
> > +     virtio_synchronize_cbs(dev);
> > +     __virtio_unbreak_device(dev);
> > +     /*
> > +      * The transport should ensure the visibility of vq->broken
> > +      * before setting DRIVER_OK. See the comments for the transport
> > +      * specific set_status() method.
> > +      *
> > +      * A well behaved device will only notify a virtqueue after
> > +      * DRIVER_OK, this means the device should "see" the coherenct
> > +      * memory write that set vq->broken as false which is done by
> > +      * the driver when it sees DRIVER_OK, then the following
> > +      * driver's vring_interrupt() will see vq->broken as false so
> > +      * we won't lose any notification.
> > +      */
> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> >   }
> >
>

