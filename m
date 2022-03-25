Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211A24E6E32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358463AbiCYGcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358450AbiCYGcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31B6DC682E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648189850;
        h=from:from:reply-to:subject:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FekJb0Ebm4l1ZsloOXr/+liInOUzNlt88+iuPhIaLmA=;
        b=YUp4ufFczLjXlpDd1t9EriU1Cu+oE0V1Q17PcFNfgY6m3rWlkod+yJ6+3mbHYLXnr69Gah
        qaexHQcUMiFzMoYY6kVZAZrt5cc38EXsNuRAll+QX0TydSTZckMKKUab7M8oxAAhXtOLfV
        HTyG9dhJQ6CSEBk31GjeWFTHClRxuNg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-m7Nd8UpwMyqS3x1EhaxVFQ-1; Fri, 25 Mar 2022 02:30:48 -0400
X-MC-Unique: m7Nd8UpwMyqS3x1EhaxVFQ-1
Received: by mail-wm1-f71.google.com with SMTP id r9-20020a1c4409000000b0038c15a1ed8cso4820010wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=FekJb0Ebm4l1ZsloOXr/+liInOUzNlt88+iuPhIaLmA=;
        b=WSw8jZfazv+JlYRjF7IgSqev+2iy7TOw9x1ybkx6U33Gh3XDW1Jt2RXIvExpd+ddjG
         1nfKZiOh+ircy23boYmsZiq4ZPvv1re8lWQ71lCWxJ9XJAvTALzMhXYS1pldObfMlpCP
         QnsN0aH25lmJsgZkrs7gwghg3yL/JMYPNGyCWF3qfCHKLZ4AldhfMCMQ7zxP4lSm9G/g
         4qc97wgthcqgamG9ot0UFlfaaLcv+K7/qn9DuP45B0X3XubIT9KLyoM4wn3o2dxFZnt7
         Q1wOq1o6N2Ny7svteJVBOzIsPvJoHHaI6S1pOIyAdYMDZrnlgJutlspZ/rkTr24ptrJI
         P19w==
X-Gm-Message-State: AOAM5334U3njZvtlE62CZ+R2vbpsFuU5cn+8IcMxRaeLqM42xZQKZd7q
        yV6R1qUXBAQXYR3AC+NLKvPKQpRVqWLmuTlgWCDvy6BVrI8Lcwkh2KTTC4/cNw+wBnT4YY5DpPI
        8FdfJ3jjswsTtlZ3H/5mAyV0d
X-Received: by 2002:adf:d1e5:0:b0:205:85f5:656c with SMTP id g5-20020adfd1e5000000b0020585f5656cmr7599592wrd.65.1648189847609;
        Thu, 24 Mar 2022 23:30:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlmRL2KmDhT7O5HEwayMNU+Neuw2JFbJ7HqKb4Oi9vYJr1vGDtSia4GxkjPPLcFpKBvhivgQ==
X-Received: by 2002:adf:d1e5:0:b0:205:85f5:656c with SMTP id g5-20020adfd1e5000000b0020585f5656cmr7599564wrd.65.1648189847234;
        Thu, 24 Mar 2022 23:30:47 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm7828385wml.10.2022.03.24.23.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 23:30:46 -0700 (PDT)
Date:   Fri, 25 Mar 2022 02:30:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com, keirf@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Message-ID: <Yj1hkpyUqJE9sQ2p@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: 
Subject: Re: [PATCH 3/3] virtio: harden vring IRQ
Message-ID: <20220325021422-mutt-send-email-mst@kernel.org>
Reply-To: 
In-Reply-To: <f7046303-7d7d-e39f-3c71-3688126cc812@redhat.com>

On Fri, Mar 25, 2022 at 11:04:08AM +0800, Jason Wang wrote:
> 
> 在 2022/3/24 下午7:03, Michael S. Tsirkin 写道:
> > On Thu, Mar 24, 2022 at 04:40:04PM +0800, Jason Wang wrote:
> > > This is a rework on the previous IRQ hardening that is done for
> > > virtio-pci where several drawbacks were found and were reverted:
> > > 
> > > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
> > >     that is used by some device such as virtio-blk
> > > 2) done only for PCI transport
> > > 
> > > In this patch, we tries to borrow the idea from the INTX IRQ hardening
> > > in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
> > > by introducing a global irq_soft_enabled variable for each
> > > virtio_device. Then we can to toggle it during
> > > virtio_reset_device()/virtio_device_ready(). A synchornize_rcu() is
> > > used in virtio_reset_device() to synchronize with the IRQ handlers. In
> > > the future, we may provide config_ops for the transport that doesn't
> > > use IRQ. With this, vring_interrupt() can return check and early if
> > > irq_soft_enabled is false. This lead to smp_load_acquire() to be used
> > > but the cost should be acceptable.
> > Maybe it should be but is it? Can't we use synchronize_irq instead?
> 
> 
> Even if we allow the transport driver to synchornize through
> synchronize_irq() we still need a check in the vring_interrupt().
> 
> We do something like the following previously:
> 
>         if (!READ_ONCE(vp_dev->intx_soft_enabled))
>                 return IRQ_NONE;
> 
> But it looks like a bug since speculative read can be done before the check
> where the interrupt handler can't see the uncommitted setup which is done by
> the driver.

I don't think so - if you sync after setting the value then
you are guaranteed that any handler running afterwards
will see the new value.

Although I couldn't find anything about this in memory-barriers.txt
which surprises me.

CC Paul to help make sure I'm right.


> 
> > 
> > > To avoid breaking legacy device which can send IRQ before DRIVER_OK, a
> > > module parameter is introduced to enable the hardening so function
> > > hardening is disabled by default.
> > Which devices are these? How come they send an interrupt before there
> > are any buffers in any queues?
> 
> 
> I copied this from the commit log for 22b7050a024d7
> 
> "
> 
>     This change will also benefit old hypervisors (before 2009)
>     that send interrupts without checking DRIVER_OK: previously,
>     the callback could race with driver-specific initialization.
> "
> 
> If this is only for config interrupt, I can remove the above log.


This is only for config interrupt.

> 
> > 
> > > Note that the hardening is only done for vring interrupt since the
> > > config interrupt hardening is already done in commit 22b7050a024d7
> > > ("virtio: defer config changed notifications"). But the method that is
> > > used by config interrupt can't be reused by the vring interrupt
> > > handler because it uses spinlock to do the synchronization which is
> > > expensive.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > 
> > > ---
> > >   drivers/virtio/virtio.c       | 19 +++++++++++++++++++
> > >   drivers/virtio/virtio_ring.c  |  9 ++++++++-
> > >   include/linux/virtio.h        |  4 ++++
> > >   include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
> > >   4 files changed, 56 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 8dde44ea044a..85e331efa9cc 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -7,6 +7,12 @@
> > >   #include <linux/of.h>
> > >   #include <uapi/linux/virtio_ids.h>
> > > +static bool irq_hardening = false;
> > > +
> > > +module_param(irq_hardening, bool, 0444);
> > > +MODULE_PARM_DESC(irq_hardening,
> > > +		 "Disalbe IRQ software processing when it is not expected");
> > > +
> > >   /* Unique numbering for virtio devices. */
> > >   static DEFINE_IDA(virtio_index_ida);
> > > @@ -220,6 +226,15 @@ static int virtio_features_ok(struct virtio_device *dev)
> > >    * */
> > >   void virtio_reset_device(struct virtio_device *dev)
> > >   {
> > > +	/*
> > > +	 * The below synchronize_rcu() guarantees that any
> > > +	 * interrupt for this line arriving after
> > > +	 * synchronize_rcu() has completed is guaranteed to see
> > > +	 * irq_soft_enabled == false.
> > News to me I did not know synchronize_rcu has anything to do
> > with interrupts. Did not you intend to use synchronize_irq?
> > I am not even 100% sure synchronize_rcu is by design a memory barrier
> > though it's most likely is ...
> 
> 
> According to the comment above tree RCU version of synchronize_rcu():
> 
> """
> 
>  * RCU read-side critical sections are delimited by rcu_read_lock()
>  * and rcu_read_unlock(), and may be nested.  In addition, but only in
>  * v5.0 and later, regions of code across which interrupts, preemption,
>  * or softirqs have been disabled also serve as RCU read-side critical
>  * sections.  This includes hardware interrupt handlers, softirq handlers,
>  * and NMI handlers.
> """
> 
> So interrupt handlers are treated as read-side critical sections.
> 
> And it has the comment for explain the barrier:
> 
> """
> 
>  * Note that this guarantee implies further memory-ordering guarantees.
>  * On systems with more than one CPU, when synchronize_rcu() returns,
>  * each CPU is guaranteed to have executed a full memory barrier since
>  * the end of its last RCU read-side critical section whose beginning
>  * preceded the call to synchronize_rcu().  In addition, each CPU having
> """
> 
> So on SMP it provides a full barrier. And for UP/tiny RCU we don't need the
> barrier, if the interrupt come after WRITE_ONCE() it will see the
> irq_soft_enabled as false.
> 

You are right. So then
1. I do not think we need load_acquire - why is it needed? Just
   READ_ONCE should do.
2. isn't synchronize_irq also doing the same thing?


> > 
> > > +	 */
> > > +	WRITE_ONCE(dev->irq_soft_enabled, false);
> > > +	synchronize_rcu();
> > > +
> > >   	dev->config->reset(dev);
> > >   }
> > >   EXPORT_SYMBOL_GPL(virtio_reset_device);
> > Please add comment explaining where it will be enabled.
> > Also, we *really* don't need to synch if it was already disabled,
> > let's not add useless overhead to the boot sequence.
> 
> 
> Ok.
> 
> 
> > 
> > 
> > > @@ -427,6 +442,10 @@ int register_virtio_device(struct virtio_device *dev)
> > >   	spin_lock_init(&dev->config_lock);
> > >   	dev->config_enabled = false;
> > >   	dev->config_change_pending = false;
> > > +	dev->irq_soft_check = irq_hardening;
> > > +
> > > +	if (dev->irq_soft_check)
> > > +		dev_info(&dev->dev, "IRQ hardening is enabled\n");
> > >   	/* We always start by resetting the device, in case a previous
> > >   	 * driver messed it up.  This also tests that code path a little. */
> > one of the points of hardening is it's also helpful for buggy
> > devices. this flag defeats the purpose.
> 
> 
> Do you mean:
> 
> 1) we need something like config_enable? This seems not easy to be
> implemented without obvious overhead, mainly the synchronize with the
> interrupt handlers

But synchronize is only on tear-down path. That is not critical for any
users at the moment, even less than probe.

> 2) enable this by default, so I don't object, but this may have some risk
> for old hypervisors


The risk if there's a driver adding buffers without setting DRIVER_OK.
So with this approach, how about we rename the flag "driver_ok"?
And then add_buf can actually test it and BUG_ON if not there  (at least
in the debug build).

And going down from there, how about we cache status in the
device? Then we don't need to keep re-reading it every time,
speeding boot up a tiny bit.

> 
> > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 962f1477b1fa..0170f8c784d8 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2144,10 +2144,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
> > >   	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> > >   }
> > > -irqreturn_t vring_interrupt(int irq, void *_vq)
> > > +irqreturn_t vring_interrupt(int irq, void *v)
> > >   {
> > > +	struct virtqueue *_vq = v;
> > > +	struct virtio_device *vdev = _vq->vdev;
> > >   	struct vring_virtqueue *vq = to_vvq(_vq);
> > > +	if (!virtio_irq_soft_enabled(vdev)) {
> > > +		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
> > > +		return IRQ_NONE;
> > > +	}
> > > +
> > >   	if (!more_used(vq)) {
> > >   		pr_debug("virtqueue interrupt with no work for %p\n", vq);
> > >   		return IRQ_NONE;
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 5464f398912a..957d6ad604ac 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -95,6 +95,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> > >    * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
> > >    * @config_enabled: configuration change reporting enabled
> > >    * @config_change_pending: configuration change reported while disabled
> > > + * @irq_soft_check: whether or not to check @irq_soft_enabled
> > > + * @irq_soft_enabled: callbacks enabled
> > >    * @config_lock: protects configuration change reporting
> > >    * @dev: underlying device.
> > >    * @id: the device type identification (used to match it with a driver).
> > > @@ -109,6 +111,8 @@ struct virtio_device {
> > >   	bool failed;
> > >   	bool config_enabled;
> > >   	bool config_change_pending;
> > > +	bool irq_soft_check;
> > > +	bool irq_soft_enabled;
> > >   	spinlock_t config_lock;
> > >   	spinlock_t vqs_list_lock; /* Protects VQs list access */
> > >   	struct device dev;
> > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > index dafdc7f48c01..9c1b61f2e525 100644
> > > --- a/include/linux/virtio_config.h
> > > +++ b/include/linux/virtio_config.h
> > > @@ -174,6 +174,24 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
> > >   	return __virtio_test_bit(vdev, fbit);
> > >   }
> > > +/*
> > > + * virtio_irq_soft_enabled: whether we can execute callbacks
> > > + * @vdev: the device
> > > + */
> > > +static inline bool virtio_irq_soft_enabled(const struct virtio_device *vdev)
> > > +{
> > > +	if (!vdev->irq_soft_check)
> > > +		return true;
> > > +
> > > +	/*
> > > +	 * Read irq_soft_enabled before reading other device specific
> > > +	 * data. Paried with smp_store_relase() in
> > paired
> 
> 
> Will fix.
> 
> Thanks
> 
> 
> > 
> > > +	 * virtio_device_ready() and WRITE_ONCE()/synchronize_rcu() in
> > > +	 * virtio_reset_device().
> > > +	 */
> > > +	return smp_load_acquire(&vdev->irq_soft_enabled);
> > > +}
> > > +
> > >   /**
> > >    * virtio_has_dma_quirk - determine whether this device has the DMA quirk
> > >    * @vdev: the device
> > > @@ -236,6 +254,13 @@ void virtio_device_ready(struct virtio_device *dev)
> > >   	if (dev->config->enable_cbs)
> > >                     dev->config->enable_cbs(dev);
> > > +	/*
> > > +	 * Commit the driver setup before enabling the virtqueue
> > > +	 * callbacks. Paried with smp_load_acuqire() in
> > > +	 * virtio_irq_soft_enabled()
> > > +	 */
> > > +	smp_store_release(&dev->irq_soft_enabled, true);
> > > +
> > >   	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > >   	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > >   }
> > > -- 
> > > 2.25.1

