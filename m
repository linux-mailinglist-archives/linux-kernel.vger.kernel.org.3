Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8764E6F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbiCYHxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiCYHxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AA49CA0CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648194733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmXp1B4mDNVPuxtmkHbvtm1ei+QMIW39oyAAVmEqzqY=;
        b=hauGmB0qnqH/wZWACo0OxR+CdupMB6kiEsbrdiypLFveC2emdxhE4pwA9Oe4AAO6yI2BGM
        P4QonmH8wRtlwHRdIfP5tHldj+y5yy7j5+Aql/fZQ54jnMPDmdFScvT6bBC7/x8JTRDhCj
        kbj38gM7wFfbkwCkzkiZjxTz+SoAbrI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-AZJSwo0lOeaKInOZMap4Yw-1; Fri, 25 Mar 2022 03:52:12 -0400
X-MC-Unique: AZJSwo0lOeaKInOZMap4Yw-1
Received: by mail-yb1-f199.google.com with SMTP id h83-20020a25d056000000b0063380d246ceso5591403ybg.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lmXp1B4mDNVPuxtmkHbvtm1ei+QMIW39oyAAVmEqzqY=;
        b=IfvLbhg1veHK7toV5NlD9DG4Gb7ddbGbPOPAFESD1q4BD87ZEsqLYnSpUrkhDToQPR
         lgwloMgDanX91lPJYj5LWBAHqlu4xgT3fn0LJHSt87YgevvugZLYijgYqg26SVZmY1LO
         q7RGcnZmJpBkepswc/QlD2xFprNHzuygcyy9N1wQubMz5VB8IUdkRRMkxKcL8qC59ghb
         z3IaVpTy51mNkPLsQbP6JZ9kM9Xf1DqW360SOTaTYs/EEhdUQGEA4ZgypUY8b8WsyslT
         yvYLvEXwu8rmpIBRlZBSZGGCEcPoIG+LG/KopgAcf4bizsuT+4VMHaJIJcb1gVjdIXiQ
         Rdaw==
X-Gm-Message-State: AOAM531wjBzL6satvSBJDrM9dRbMt56tcyh0XYk15rjwWZFRP10vlwvm
        VfDy9JHZ1FhKDU+ujH6QKISkkX0SAS/wTCFpJvtFkXY+/+B14KWZq42qzjfpTEQP5YH/Y9eq6IQ
        /mBvFaH4aVDdbFTYVezbr5bLKaqk5+U+tu/b4La+8
X-Received: by 2002:a25:3bd4:0:b0:633:6772:5ac1 with SMTP id i203-20020a253bd4000000b0063367725ac1mr8248040yba.431.1648194731321;
        Fri, 25 Mar 2022 00:52:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweCfj+rk1ABZxPChI+ovo9uEblMZ3tadNgGIpZ6P8yVITQbLS/tPc2/4kUtJF5TABxgwHC5kVZ8g0dPiAbE2g=
X-Received: by 2002:a25:3bd4:0:b0:633:6772:5ac1 with SMTP id
 i203-20020a253bd4000000b0063367725ac1mr8248027yba.431.1648194730994; Fri, 25
 Mar 2022 00:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <Yj1hkpyUqJE9sQ2p@redhat.com>
In-Reply-To: <Yj1hkpyUqJE9sQ2p@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 25 Mar 2022 15:52:00 +0800
Message-ID: <CACGkMEunsuWhn+aB2dM7noU257M9JV6jDjkQXLyOA+GjEoz_iw@mail.gmail.com>
Subject: Re:
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Keir Fraser <keirf@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 2:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Bcc:
> Subject: Re: [PATCH 3/3] virtio: harden vring IRQ
> Message-ID: <20220325021422-mutt-send-email-mst@kernel.org>
> Reply-To:
> In-Reply-To: <f7046303-7d7d-e39f-3c71-3688126cc812@redhat.com>
>
> On Fri, Mar 25, 2022 at 11:04:08AM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/3/24 =E4=B8=8B=E5=8D=887:03, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> > > On Thu, Mar 24, 2022 at 04:40:04PM +0800, Jason Wang wrote:
> > > > This is a rework on the previous IRQ hardening that is done for
> > > > virtio-pci where several drawbacks were found and were reverted:
> > > >
> > > > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity mana=
ged IRQ
> > > >     that is used by some device such as virtio-blk
> > > > 2) done only for PCI transport
> > > >
> > > > In this patch, we tries to borrow the idea from the INTX IRQ harden=
ing
> > > > in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX inter=
rupts")
> > > > by introducing a global irq_soft_enabled variable for each
> > > > virtio_device. Then we can to toggle it during
> > > > virtio_reset_device()/virtio_device_ready(). A synchornize_rcu() is
> > > > used in virtio_reset_device() to synchronize with the IRQ handlers.=
 In
> > > > the future, we may provide config_ops for the transport that doesn'=
t
> > > > use IRQ. With this, vring_interrupt() can return check and early if
> > > > irq_soft_enabled is false. This lead to smp_load_acquire() to be us=
ed
> > > > but the cost should be acceptable.
> > > Maybe it should be but is it? Can't we use synchronize_irq instead?
> >
> >
> > Even if we allow the transport driver to synchornize through
> > synchronize_irq() we still need a check in the vring_interrupt().
> >
> > We do something like the following previously:
> >
> >         if (!READ_ONCE(vp_dev->intx_soft_enabled))
> >                 return IRQ_NONE;
> >
> > But it looks like a bug since speculative read can be done before the c=
heck
> > where the interrupt handler can't see the uncommitted setup which is do=
ne by
> > the driver.
>
> I don't think so - if you sync after setting the value then
> you are guaranteed that any handler running afterwards
> will see the new value.

The problem is not disabled but the enable. We use smp_store_relase()
to make sure the driver commits the setup before enabling the irq. It
means the read needs to be ordered as well in vring_interrupt().

>
> Although I couldn't find anything about this in memory-barriers.txt
> which surprises me.
>
> CC Paul to help make sure I'm right.
>
>
> >
> > >
> > > > To avoid breaking legacy device which can send IRQ before DRIVER_OK=
, a
> > > > module parameter is introduced to enable the hardening so function
> > > > hardening is disabled by default.
> > > Which devices are these? How come they send an interrupt before there
> > > are any buffers in any queues?
> >
> >
> > I copied this from the commit log for 22b7050a024d7
> >
> > "
> >
> >     This change will also benefit old hypervisors (before 2009)
> >     that send interrupts without checking DRIVER_OK: previously,
> >     the callback could race with driver-specific initialization.
> > "
> >
> > If this is only for config interrupt, I can remove the above log.
>
>
> This is only for config interrupt.

Ok.

>
> >
> > >
> > > > Note that the hardening is only done for vring interrupt since the
> > > > config interrupt hardening is already done in commit 22b7050a024d7
> > > > ("virtio: defer config changed notifications"). But the method that=
 is
> > > > used by config interrupt can't be reused by the vring interrupt
> > > > handler because it uses spinlock to do the synchronization which is
> > > > expensive.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > > ---
> > > >   drivers/virtio/virtio.c       | 19 +++++++++++++++++++
> > > >   drivers/virtio/virtio_ring.c  |  9 ++++++++-
> > > >   include/linux/virtio.h        |  4 ++++
> > > >   include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
> > > >   4 files changed, 56 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > index 8dde44ea044a..85e331efa9cc 100644
> > > > --- a/drivers/virtio/virtio.c
> > > > +++ b/drivers/virtio/virtio.c
> > > > @@ -7,6 +7,12 @@
> > > >   #include <linux/of.h>
> > > >   #include <uapi/linux/virtio_ids.h>
> > > > +static bool irq_hardening =3D false;
> > > > +
> > > > +module_param(irq_hardening, bool, 0444);
> > > > +MODULE_PARM_DESC(irq_hardening,
> > > > +          "Disalbe IRQ software processing when it is not expected=
");
> > > > +
> > > >   /* Unique numbering for virtio devices. */
> > > >   static DEFINE_IDA(virtio_index_ida);
> > > > @@ -220,6 +226,15 @@ static int virtio_features_ok(struct virtio_de=
vice *dev)
> > > >    * */
> > > >   void virtio_reset_device(struct virtio_device *dev)
> > > >   {
> > > > + /*
> > > > +  * The below synchronize_rcu() guarantees that any
> > > > +  * interrupt for this line arriving after
> > > > +  * synchronize_rcu() has completed is guaranteed to see
> > > > +  * irq_soft_enabled =3D=3D false.
> > > News to me I did not know synchronize_rcu has anything to do
> > > with interrupts. Did not you intend to use synchronize_irq?
> > > I am not even 100% sure synchronize_rcu is by design a memory barrier
> > > though it's most likely is ...
> >
> >
> > According to the comment above tree RCU version of synchronize_rcu():
> >
> > """
> >
> >  * RCU read-side critical sections are delimited by rcu_read_lock()
> >  * and rcu_read_unlock(), and may be nested.  In addition, but only in
> >  * v5.0 and later, regions of code across which interrupts, preemption,
> >  * or softirqs have been disabled also serve as RCU read-side critical
> >  * sections.  This includes hardware interrupt handlers, softirq handle=
rs,
> >  * and NMI handlers.
> > """
> >
> > So interrupt handlers are treated as read-side critical sections.
> >
> > And it has the comment for explain the barrier:
> >
> > """
> >
> >  * Note that this guarantee implies further memory-ordering guarantees.
> >  * On systems with more than one CPU, when synchronize_rcu() returns,
> >  * each CPU is guaranteed to have executed a full memory barrier since
> >  * the end of its last RCU read-side critical section whose beginning
> >  * preceded the call to synchronize_rcu().  In addition, each CPU havin=
g
> > """
> >
> > So on SMP it provides a full barrier. And for UP/tiny RCU we don't need=
 the
> > barrier, if the interrupt come after WRITE_ONCE() it will see the
> > irq_soft_enabled as false.
> >
>
> You are right. So then
> 1. I do not think we need load_acquire - why is it needed? Just
>    READ_ONCE should do.

See above.

> 2. isn't synchronize_irq also doing the same thing?


Yes, but it requires a config ops since the IRQ knowledge is transport spec=
ific.

>
>
> > >
> > > > +  */
> > > > + WRITE_ONCE(dev->irq_soft_enabled, false);
> > > > + synchronize_rcu();
> > > > +
> > > >           dev->config->reset(dev);
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(virtio_reset_device);
> > > Please add comment explaining where it will be enabled.
> > > Also, we *really* don't need to synch if it was already disabled,
> > > let's not add useless overhead to the boot sequence.
> >
> >
> > Ok.
> >
> >
> > >
> > >
> > > > @@ -427,6 +442,10 @@ int register_virtio_device(struct virtio_devic=
e *dev)
> > > >           spin_lock_init(&dev->config_lock);
> > > >           dev->config_enabled =3D false;
> > > >           dev->config_change_pending =3D false;
> > > > + dev->irq_soft_check =3D irq_hardening;
> > > > +
> > > > + if (dev->irq_soft_check)
> > > > +         dev_info(&dev->dev, "IRQ hardening is enabled\n");
> > > >           /* We always start by resetting the device, in case a pre=
vious
> > > >            * driver messed it up.  This also tests that code path a=
 little. */
> > > one of the points of hardening is it's also helpful for buggy
> > > devices. this flag defeats the purpose.
> >
> >
> > Do you mean:
> >
> > 1) we need something like config_enable? This seems not easy to be
> > implemented without obvious overhead, mainly the synchronize with the
> > interrupt handlers
>
> But synchronize is only on tear-down path. That is not critical for any
> users at the moment, even less than probe.

I meant if we have vq->irq_pending, we need to call vring_interrupt()
in the virtio_device_ready() and synchronize the IRQ handlers with
spinlock or others.

>
> > 2) enable this by default, so I don't object, but this may have some ri=
sk
> > for old hypervisors
>
>
> The risk if there's a driver adding buffers without setting DRIVER_OK.

Probably not, we have devices that accept random inputs from outside,
net, console, input etc. I've done a round of audits of the Qemu
codes. They look all fine since day0.

> So with this approach, how about we rename the flag "driver_ok"?
> And then add_buf can actually test it and BUG_ON if not there  (at least
> in the debug build).

This looks like a hardening of the driver in the core instead of the
device. I think it can be done but in a separate series.

>
> And going down from there, how about we cache status in the
> device? Then we don't need to keep re-reading it every time,
> speeding boot up a tiny bit.

I don't fully understand here, actually spec requires status to be
read back for validation in many cases.

Thanks

>
> >
> > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 962f1477b1fa..0170f8c784d8 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -2144,10 +2144,17 @@ static inline bool more_used(const struct v=
ring_virtqueue *vq)
> > > >           return vq->packed_ring ? more_used_packed(vq) : more_used=
_split(vq);
> > > >   }
> > > > -irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > +irqreturn_t vring_interrupt(int irq, void *v)
> > > >   {
> > > > + struct virtqueue *_vq =3D v;
> > > > + struct virtio_device *vdev =3D _vq->vdev;
> > > >           struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > + if (!virtio_irq_soft_enabled(vdev)) {
> > > > +         dev_warn_once(&vdev->dev, "virtio vring IRQ raised before=
 DRIVER_OK");
> > > > +         return IRQ_NONE;
> > > > + }
> > > > +
> > > >           if (!more_used(vq)) {
> > > >                   pr_debug("virtqueue interrupt with no work for %p=
\n", vq);
> > > >                   return IRQ_NONE;
> > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > index 5464f398912a..957d6ad604ac 100644
> > > > --- a/include/linux/virtio.h
> > > > +++ b/include/linux/virtio.h
> > > > @@ -95,6 +95,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtque=
ue *vq);
> > > >    * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for resto=
re)
> > > >    * @config_enabled: configuration change reporting enabled
> > > >    * @config_change_pending: configuration change reported while di=
sabled
> > > > + * @irq_soft_check: whether or not to check @irq_soft_enabled
> > > > + * @irq_soft_enabled: callbacks enabled
> > > >    * @config_lock: protects configuration change reporting
> > > >    * @dev: underlying device.
> > > >    * @id: the device type identification (used to match it with a d=
river).
> > > > @@ -109,6 +111,8 @@ struct virtio_device {
> > > >           bool failed;
> > > >           bool config_enabled;
> > > >           bool config_change_pending;
> > > > + bool irq_soft_check;
> > > > + bool irq_soft_enabled;
> > > >           spinlock_t config_lock;
> > > >           spinlock_t vqs_list_lock; /* Protects VQs list access */
> > > >           struct device dev;
> > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_c=
onfig.h
> > > > index dafdc7f48c01..9c1b61f2e525 100644
> > > > --- a/include/linux/virtio_config.h
> > > > +++ b/include/linux/virtio_config.h
> > > > @@ -174,6 +174,24 @@ static inline bool virtio_has_feature(const st=
ruct virtio_device *vdev,
> > > >           return __virtio_test_bit(vdev, fbit);
> > > >   }
> > > > +/*
> > > > + * virtio_irq_soft_enabled: whether we can execute callbacks
> > > > + * @vdev: the device
> > > > + */
> > > > +static inline bool virtio_irq_soft_enabled(const struct virtio_dev=
ice *vdev)
> > > > +{
> > > > + if (!vdev->irq_soft_check)
> > > > +         return true;
> > > > +
> > > > + /*
> > > > +  * Read irq_soft_enabled before reading other device specific
> > > > +  * data. Paried with smp_store_relase() in
> > > paired
> >
> >
> > Will fix.
> >
> > Thanks
> >
> >
> > >
> > > > +  * virtio_device_ready() and WRITE_ONCE()/synchronize_rcu() in
> > > > +  * virtio_reset_device().
> > > > +  */
> > > > + return smp_load_acquire(&vdev->irq_soft_enabled);
> > > > +}
> > > > +
> > > >   /**
> > > >    * virtio_has_dma_quirk - determine whether this device has the D=
MA quirk
> > > >    * @vdev: the device
> > > > @@ -236,6 +254,13 @@ void virtio_device_ready(struct virtio_device =
*dev)
> > > >           if (dev->config->enable_cbs)
> > > >                     dev->config->enable_cbs(dev);
> > > > + /*
> > > > +  * Commit the driver setup before enabling the virtqueue
> > > > +  * callbacks. Paried with smp_load_acuqire() in
> > > > +  * virtio_irq_soft_enabled()
> > > > +  */
> > > > + smp_store_release(&dev->irq_soft_enabled, true);
> > > > +
> > > >           BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > >           dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRI=
VER_OK);
> > > >   }
> > > > --
> > > > 2.25.1
>

