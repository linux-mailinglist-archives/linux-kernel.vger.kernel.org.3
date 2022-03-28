Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3019F4E8E04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiC1GUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiC1GU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34C633CFEB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648448327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TOq4wlvx736BsBWhZ6JA8b6dWPJXab61zLMmfndi4Bc=;
        b=UqP44aynsNUqRV+i3rAcVGi7nUdrxhikcMwf/Q/TBrzb/AwKjOI4oOMmqGA0+sWigC9zRC
        0/tGxPWIkvSyDpZ1BbPQaO5Tz7u/oePprgYAt5OM9oZcxCR1Jlpm3BC72+fs2m/jhZqXC2
        kNS0IjPdV2XQUH5OS5Qdzu6bFcN2zDw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-QtLNXXxfPZqoNc6FWcXMxQ-1; Mon, 28 Mar 2022 02:18:35 -0400
X-MC-Unique: QtLNXXxfPZqoNc6FWcXMxQ-1
Received: by mail-lj1-f199.google.com with SMTP id h4-20020a2ea484000000b002480c04898aso5515785lji.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 23:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TOq4wlvx736BsBWhZ6JA8b6dWPJXab61zLMmfndi4Bc=;
        b=Om8D8BJM3WBskq6HpNcUahUUOHGa11/TL7J6r/EFrTrTJsIsTBD4TKJGvGOqOmA2jo
         1rU1fXv90roV9Qom5x2V8hlqOP9Hh9wa8dleYNALH6HFn9dNzcKKTVKq1mB2wYM6QgAN
         cDsfrxr/T6OUeRuhVk2ckZF1TUg3djKUtkzTnahG26WQCtJrxBPt8UGZ042nWWm8FvAy
         g9vKJ/bUjKf/YFqF6MXEGZXrGy5j1Lkn4zjAi5oFwd2kwZNkM7d9aXowQkB1GFDPcMGq
         MzE+eVpCZFlIzV7gKRWQv8ycQB0M9WqRiQxOyDdyVXnly9UBm6B477Z1OYxIVQP8Z38b
         KhMQ==
X-Gm-Message-State: AOAM531UIHyL2iuhWqAnYeCMYS8klzbYg29V+/u5uruxLHz27ooQ/TjJ
        6W/uI1XJiBkY7/zcLUO/JCH9ke+yefi+fpk7Cl8YrXlRT9nHoBMGocRoVhb8tPHMEcdcMSl3rzO
        uoGpnKPkD0i2bveqK5pxuiSApFRr7uZKWEF5j59/c
X-Received: by 2002:a05:6512:2203:b0:44a:12c9:8696 with SMTP id h3-20020a056512220300b0044a12c98696mr18842236lfu.98.1648448313760;
        Sun, 27 Mar 2022 23:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI2Q2LMMG8+mW3nff22tnI7dvxsrM50RfloptpE6d8PmS7L1v/505BjHQdTcUuY5bYb0gyp9gkYvlPGG/mgNg=
X-Received: by 2002:a05:6512:2203:b0:44a:12c9:8696 with SMTP id
 h3-20020a056512220300b0044a12c98696mr18842223lfu.98.1648448313408; Sun, 27
 Mar 2022 23:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <Yj1hkpyUqJE9sQ2p@redhat.com> <CACGkMEunsuWhn+aB2dM7noU257M9JV6jDjkQXLyOA+GjEoz_iw@mail.gmail.com>
 <20220325050947-mutt-send-email-mst@kernel.org> <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org> <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220328015757-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 28 Mar 2022 14:18:22 +0800
Message-ID: <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 1:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 28, 2022 at 12:56:41PM +0800, Jason Wang wrote:
> > On Fri, Mar 25, 2022 at 6:10 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Fri, Mar 25, 2022 at 05:20:19PM +0800, Jason Wang wrote:
> > > > On Fri, Mar 25, 2022 at 5:10 PM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > > >
> > > > > On Fri, Mar 25, 2022 at 03:52:00PM +0800, Jason Wang wrote:
> > > > > > On Fri, Mar 25, 2022 at 2:31 PM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > > > > > >
> > > > > > > Bcc:
> > > > > > > Subject: Re: [PATCH 3/3] virtio: harden vring IRQ
> > > > > > > Message-ID: <20220325021422-mutt-send-email-mst@kernel.org>
> > > > > > > Reply-To:
> > > > > > > In-Reply-To: <f7046303-7d7d-e39f-3c71-3688126cc812@redhat.com=
>
> > > > > > >
> > > > > > > On Fri, Mar 25, 2022 at 11:04:08AM +0800, Jason Wang wrote:
> > > > > > > >
> > > > > > > > =E5=9C=A8 2022/3/24 =E4=B8=8B=E5=8D=887:03, Michael S. Tsir=
kin =E5=86=99=E9=81=93:
> > > > > > > > > On Thu, Mar 24, 2022 at 04:40:04PM +0800, Jason Wang wrot=
e:
> > > > > > > > > > This is a rework on the previous IRQ hardening that is =
done for
> > > > > > > > > > virtio-pci where several drawbacks were found and were =
reverted:
> > > > > > > > > >
> > > > > > > > > > 1) try to use IRQF_NO_AUTOEN which is not friendly to a=
ffinity managed IRQ
> > > > > > > > > >     that is used by some device such as virtio-blk
> > > > > > > > > > 2) done only for PCI transport
> > > > > > > > > >
> > > > > > > > > > In this patch, we tries to borrow the idea from the INT=
X IRQ hardening
> > > > > > > > > > in the reverted commit 080cd7c3ac87 ("virtio-pci: harde=
n INTX interrupts")
> > > > > > > > > > by introducing a global irq_soft_enabled variable for e=
ach
> > > > > > > > > > virtio_device. Then we can to toggle it during
> > > > > > > > > > virtio_reset_device()/virtio_device_ready(). A synchorn=
ize_rcu() is
> > > > > > > > > > used in virtio_reset_device() to synchronize with the I=
RQ handlers. In
> > > > > > > > > > the future, we may provide config_ops for the transport=
 that doesn't
> > > > > > > > > > use IRQ. With this, vring_interrupt() can return check =
and early if
> > > > > > > > > > irq_soft_enabled is false. This lead to smp_load_acquir=
e() to be used
> > > > > > > > > > but the cost should be acceptable.
> > > > > > > > > Maybe it should be but is it? Can't we use synchronize_ir=
q instead?
> > > > > > > >
> > > > > > > >
> > > > > > > > Even if we allow the transport driver to synchornize throug=
h
> > > > > > > > synchronize_irq() we still need a check in the vring_interr=
upt().
> > > > > > > >
> > > > > > > > We do something like the following previously:
> > > > > > > >
> > > > > > > >         if (!READ_ONCE(vp_dev->intx_soft_enabled))
> > > > > > > >                 return IRQ_NONE;
> > > > > > > >
> > > > > > > > But it looks like a bug since speculative read can be done =
before the check
> > > > > > > > where the interrupt handler can't see the uncommitted setup=
 which is done by
> > > > > > > > the driver.
> > > > > > >
> > > > > > > I don't think so - if you sync after setting the value then
> > > > > > > you are guaranteed that any handler running afterwards
> > > > > > > will see the new value.
> > > > > >
> > > > > > The problem is not disabled but the enable.
> > > > >
> > > > > So a misbehaving device can lose interrupts? That's not a problem=
 at all
> > > > > imo.
> > > >
> > > > It's the interrupt raised before setting irq_soft_enabled to true:
> > > >
> > > > CPU 0 probe) driver specific setup (not commited)
> > > > CPU 1 IRQ handler) read the uninitialized variable
> > > > CPU 0 probe) set irq_soft_enabled to true
> > > > CPU 1 IRQ handler) read irq_soft_enable as true
> > > > CPU 1 IRQ handler) use the uninitialized variable
> > > >
> > > > Thanks
> > >
> > > Yea, it hurts if you do it.  So do not do it then ;).
> > >
> > > irq_soft_enabled (I think driver_ok or status is a better name)
> >
> > I can change it to driver_ok.
> >
> > > should be initialized to false *before* irq is requested.
> > >
> > > And requesting irq commits all memory otherwise all drivers would be
> > > broken,
> >
> > So I think we might talk different issues:
> >
> > 1) Whether request_irq() commits the previous setups, I think the
> > answer is yes, since the spin_unlock of desc->lock (release) can
> > guarantee this though there seems no documentation around
> > request_irq() to say this.
> >
> > And I can see at least drivers/video/fbdev/omap2/omapfb/dss/dispc.c is
> > using smp_wmb() before the request_irq().
> >
> > And even if write is ordered we still need read to be ordered to be
> > paired with that.
> >
> > > if it doesn't it just needs to be fixed, not worked around in
> > > virtio.
> >
> > 2) virtio drivers might do a lot of setups between request_irq() and
> > virtio_device_ready():
> >
> > request_irq()
> > driver specific setups
> > virtio_device_ready()
> >
> > CPU 0 probe) request_irq()
> > CPU 1 IRQ handler) read the uninitialized variable
> > CPU 0 probe) driver specific setups
> > CPU 0 probe) smp_store_release(intr_soft_enabled, true), commit the set=
ups
> > CPU 1 IRQ handler) read irq_soft_enable as true
> > CPU 1 IRQ handler) use the uninitialized variable
> >
> > Thanks
>
>
> As I said, virtio_device_ready needs to do synchronize_irq.
> That will guarantee all setup is visible to the specific IRQ,

Only the interrupt after synchronize_irq() returns.

>this
> is what it's point is.

What happens if an interrupt is raised in the middle like:

smp_store_release(dev->irq_soft_enabled, true)
IRQ handler
synchornize_irq()

If we don't enforce a reading order, the IRQ handler may still see the
uninitialized variable.

Thanks

>
>
> > >
> > >
> > > > >
> > > > > > We use smp_store_relase()
> > > > > > to make sure the driver commits the setup before enabling the i=
rq. It
> > > > > > means the read needs to be ordered as well in vring_interrupt()=
.
> > > > > >
> > > > > > >
> > > > > > > Although I couldn't find anything about this in memory-barrie=
rs.txt
> > > > > > > which surprises me.
> > > > > > >
> > > > > > > CC Paul to help make sure I'm right.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > To avoid breaking legacy device which can send IRQ befo=
re DRIVER_OK, a
> > > > > > > > > > module parameter is introduced to enable the hardening =
so function
> > > > > > > > > > hardening is disabled by default.
> > > > > > > > > Which devices are these? How come they send an interrupt =
before there
> > > > > > > > > are any buffers in any queues?
> > > > > > > >
> > > > > > > >
> > > > > > > > I copied this from the commit log for 22b7050a024d7
> > > > > > > >
> > > > > > > > "
> > > > > > > >
> > > > > > > >     This change will also benefit old hypervisors (before 2=
009)
> > > > > > > >     that send interrupts without checking DRIVER_OK: previo=
usly,
> > > > > > > >     the callback could race with driver-specific initializa=
tion.
> > > > > > > > "
> > > > > > > >
> > > > > > > > If this is only for config interrupt, I can remove the abov=
e log.
> > > > > > >
> > > > > > >
> > > > > > > This is only for config interrupt.
> > > > > >
> > > > > > Ok.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > Note that the hardening is only done for vring interrup=
t since the
> > > > > > > > > > config interrupt hardening is already done in commit 22=
b7050a024d7
> > > > > > > > > > ("virtio: defer config changed notifications"). But the=
 method that is
> > > > > > > > > > used by config interrupt can't be reused by the vring i=
nterrupt
> > > > > > > > > > handler because it uses spinlock to do the synchronizat=
ion which is
> > > > > > > > > > expensive.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >   drivers/virtio/virtio.c       | 19 ++++++++++++++++++=
+
> > > > > > > > > >   drivers/virtio/virtio_ring.c  |  9 ++++++++-
> > > > > > > > > >   include/linux/virtio.h        |  4 ++++
> > > > > > > > > >   include/linux/virtio_config.h | 25 ++++++++++++++++++=
+++++++
> > > > > > > > > >   4 files changed, 56 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/v=
irtio.c
> > > > > > > > > > index 8dde44ea044a..85e331efa9cc 100644
> > > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > > @@ -7,6 +7,12 @@
> > > > > > > > > >   #include <linux/of.h>
> > > > > > > > > >   #include <uapi/linux/virtio_ids.h>
> > > > > > > > > > +static bool irq_hardening =3D false;
> > > > > > > > > > +
> > > > > > > > > > +module_param(irq_hardening, bool, 0444);
> > > > > > > > > > +MODULE_PARM_DESC(irq_hardening,
> > > > > > > > > > +          "Disalbe IRQ software processing when it is =
not expected");
> > > > > > > > > > +
> > > > > > > > > >   /* Unique numbering for virtio devices. */
> > > > > > > > > >   static DEFINE_IDA(virtio_index_ida);
> > > > > > > > > > @@ -220,6 +226,15 @@ static int virtio_features_ok(stru=
ct virtio_device *dev)
> > > > > > > > > >    * */
> > > > > > > > > >   void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > > >   {
> > > > > > > > > > + /*
> > > > > > > > > > +  * The below synchronize_rcu() guarantees that any
> > > > > > > > > > +  * interrupt for this line arriving after
> > > > > > > > > > +  * synchronize_rcu() has completed is guaranteed to s=
ee
> > > > > > > > > > +  * irq_soft_enabled =3D=3D false.
> > > > > > > > > News to me I did not know synchronize_rcu has anything to=
 do
> > > > > > > > > with interrupts. Did not you intend to use synchronize_ir=
q?
> > > > > > > > > I am not even 100% sure synchronize_rcu is by design a me=
mory barrier
> > > > > > > > > though it's most likely is ...
> > > > > > > >
> > > > > > > >
> > > > > > > > According to the comment above tree RCU version of synchron=
ize_rcu():
> > > > > > > >
> > > > > > > > """
> > > > > > > >
> > > > > > > >  * RCU read-side critical sections are delimited by rcu_rea=
d_lock()
> > > > > > > >  * and rcu_read_unlock(), and may be nested.  In addition, =
but only in
> > > > > > > >  * v5.0 and later, regions of code across which interrupts,=
 preemption,
> > > > > > > >  * or softirqs have been disabled also serve as RCU read-si=
de critical
> > > > > > > >  * sections.  This includes hardware interrupt handlers, so=
ftirq handlers,
> > > > > > > >  * and NMI handlers.
> > > > > > > > """
> > > > > > > >
> > > > > > > > So interrupt handlers are treated as read-side critical sec=
tions.
> > > > > > > >
> > > > > > > > And it has the comment for explain the barrier:
> > > > > > > >
> > > > > > > > """
> > > > > > > >
> > > > > > > >  * Note that this guarantee implies further memory-ordering=
 guarantees.
> > > > > > > >  * On systems with more than one CPU, when synchronize_rcu(=
) returns,
> > > > > > > >  * each CPU is guaranteed to have executed a full memory ba=
rrier since
> > > > > > > >  * the end of its last RCU read-side critical section whose=
 beginning
> > > > > > > >  * preceded the call to synchronize_rcu().  In addition, ea=
ch CPU having
> > > > > > > > """
> > > > > > > >
> > > > > > > > So on SMP it provides a full barrier. And for UP/tiny RCU w=
e don't need the
> > > > > > > > barrier, if the interrupt come after WRITE_ONCE() it will s=
ee the
> > > > > > > > irq_soft_enabled as false.
> > > > > > > >
> > > > > > >
> > > > > > > You are right. So then
> > > > > > > 1. I do not think we need load_acquire - why is it needed? Ju=
st
> > > > > > >    READ_ONCE should do.
> > > > > >
> > > > > > See above.
> > > > > >
> > > > > > > 2. isn't synchronize_irq also doing the same thing?
> > > > > >
> > > > > >
> > > > > > Yes, but it requires a config ops since the IRQ knowledge is tr=
ansport specific.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > +  */
> > > > > > > > > > + WRITE_ONCE(dev->irq_soft_enabled, false);
> > > > > > > > > > + synchronize_rcu();
> > > > > > > > > > +
> > > > > > > > > >           dev->config->reset(dev);
> > > > > > > > > >   }
> > > > > > > > > >   EXPORT_SYMBOL_GPL(virtio_reset_device);
> > > > > > > > > Please add comment explaining where it will be enabled.
> > > > > > > > > Also, we *really* don't need to synch if it was already d=
isabled,
> > > > > > > > > let's not add useless overhead to the boot sequence.
> > > > > > > >
> > > > > > > >
> > > > > > > > Ok.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > @@ -427,6 +442,10 @@ int register_virtio_device(struct =
virtio_device *dev)
> > > > > > > > > >           spin_lock_init(&dev->config_lock);
> > > > > > > > > >           dev->config_enabled =3D false;
> > > > > > > > > >           dev->config_change_pending =3D false;
> > > > > > > > > > + dev->irq_soft_check =3D irq_hardening;
> > > > > > > > > > +
> > > > > > > > > > + if (dev->irq_soft_check)
> > > > > > > > > > +         dev_info(&dev->dev, "IRQ hardening is enabled=
\n");
> > > > > > > > > >           /* We always start by resetting the device, i=
n case a previous
> > > > > > > > > >            * driver messed it up.  This also tests that=
 code path a little. */
> > > > > > > > > one of the points of hardening is it's also helpful for b=
uggy
> > > > > > > > > devices. this flag defeats the purpose.
> > > > > > > >
> > > > > > > >
> > > > > > > > Do you mean:
> > > > > > > >
> > > > > > > > 1) we need something like config_enable? This seems not eas=
y to be
> > > > > > > > implemented without obvious overhead, mainly the synchroniz=
e with the
> > > > > > > > interrupt handlers
> > > > > > >
> > > > > > > But synchronize is only on tear-down path. That is not critic=
al for any
> > > > > > > users at the moment, even less than probe.
> > > > > >
> > > > > > I meant if we have vq->irq_pending, we need to call vring_inter=
rupt()
> > > > > > in the virtio_device_ready() and synchronize the IRQ handlers w=
ith
> > > > > > spinlock or others.
> > > > > >
> > > > > > >
> > > > > > > > 2) enable this by default, so I don't object, but this may =
have some risk
> > > > > > > > for old hypervisors
> > > > > > >
> > > > > > >
> > > > > > > The risk if there's a driver adding buffers without setting D=
RIVER_OK.
> > > > > >
> > > > > > Probably not, we have devices that accept random inputs from ou=
tside,
> > > > > > net, console, input etc. I've done a round of audits of the Qem=
u
> > > > > > codes. They look all fine since day0.
> > > > > >
> > > > > > > So with this approach, how about we rename the flag "driver_o=
k"?
> > > > > > > And then add_buf can actually test it and BUG_ON if not there=
  (at least
> > > > > > > in the debug build).
> > > > > >
> > > > > > This looks like a hardening of the driver in the core instead o=
f the
> > > > > > device. I think it can be done but in a separate series.
> > > > > >
> > > > > > >
> > > > > > > And going down from there, how about we cache status in the
> > > > > > > device? Then we don't need to keep re-reading it every time,
> > > > > > > speeding boot up a tiny bit.
> > > > > >
> > > > > > I don't fully understand here, actually spec requires status to=
 be
> > > > > > read back for validation in many cases.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/vir=
tio/virtio_ring.c
> > > > > > > > > > index 962f1477b1fa..0170f8c784d8 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > > @@ -2144,10 +2144,17 @@ static inline bool more_used(co=
nst struct vring_virtqueue *vq)
> > > > > > > > > >           return vq->packed_ring ? more_used_packed(vq)=
 : more_used_split(vq);
> > > > > > > > > >   }
> > > > > > > > > > -irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > > > > > +irqreturn_t vring_interrupt(int irq, void *v)
> > > > > > > > > >   {
> > > > > > > > > > + struct virtqueue *_vq =3D v;
> > > > > > > > > > + struct virtio_device *vdev =3D _vq->vdev;
> > > > > > > > > >           struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > > > > > > + if (!virtio_irq_soft_enabled(vdev)) {
> > > > > > > > > > +         dev_warn_once(&vdev->dev, "virtio vring IRQ r=
aised before DRIVER_OK");
> > > > > > > > > > +         return IRQ_NONE;
> > > > > > > > > > + }
> > > > > > > > > > +
> > > > > > > > > >           if (!more_used(vq)) {
> > > > > > > > > >                   pr_debug("virtqueue interrupt with no=
 work for %p\n", vq);
> > > > > > > > > >                   return IRQ_NONE;
> > > > > > > > > > diff --git a/include/linux/virtio.h b/include/linux/vir=
tio.h
> > > > > > > > > > index 5464f398912a..957d6ad604ac 100644
> > > > > > > > > > --- a/include/linux/virtio.h
> > > > > > > > > > +++ b/include/linux/virtio.h
> > > > > > > > > > @@ -95,6 +95,8 @@ dma_addr_t virtqueue_get_used_addr(st=
ruct virtqueue *vq);
> > > > > > > > > >    * @failed: saved value for VIRTIO_CONFIG_S_FAILED bi=
t (for restore)
> > > > > > > > > >    * @config_enabled: configuration change reporting en=
abled
> > > > > > > > > >    * @config_change_pending: configuration change repor=
ted while disabled
> > > > > > > > > > + * @irq_soft_check: whether or not to check @irq_soft_=
enabled
> > > > > > > > > > + * @irq_soft_enabled: callbacks enabled
> > > > > > > > > >    * @config_lock: protects configuration change report=
ing
> > > > > > > > > >    * @dev: underlying device.
> > > > > > > > > >    * @id: the device type identification (used to match=
 it with a driver).
> > > > > > > > > > @@ -109,6 +111,8 @@ struct virtio_device {
> > > > > > > > > >           bool failed;
> > > > > > > > > >           bool config_enabled;
> > > > > > > > > >           bool config_change_pending;
> > > > > > > > > > + bool irq_soft_check;
> > > > > > > > > > + bool irq_soft_enabled;
> > > > > > > > > >           spinlock_t config_lock;
> > > > > > > > > >           spinlock_t vqs_list_lock; /* Protects VQs lis=
t access */
> > > > > > > > > >           struct device dev;
> > > > > > > > > > diff --git a/include/linux/virtio_config.h b/include/li=
nux/virtio_config.h
> > > > > > > > > > index dafdc7f48c01..9c1b61f2e525 100644
> > > > > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > > > > @@ -174,6 +174,24 @@ static inline bool virtio_has_feat=
ure(const struct virtio_device *vdev,
> > > > > > > > > >           return __virtio_test_bit(vdev, fbit);
> > > > > > > > > >   }
> > > > > > > > > > +/*
> > > > > > > > > > + * virtio_irq_soft_enabled: whether we can execute cal=
lbacks
> > > > > > > > > > + * @vdev: the device
> > > > > > > > > > + */
> > > > > > > > > > +static inline bool virtio_irq_soft_enabled(const struc=
t virtio_device *vdev)
> > > > > > > > > > +{
> > > > > > > > > > + if (!vdev->irq_soft_check)
> > > > > > > > > > +         return true;
> > > > > > > > > > +
> > > > > > > > > > + /*
> > > > > > > > > > +  * Read irq_soft_enabled before reading other device =
specific
> > > > > > > > > > +  * data. Paried with smp_store_relase() in
> > > > > > > > > paired
> > > > > > > >
> > > > > > > >
> > > > > > > > Will fix.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > +  * virtio_device_ready() and WRITE_ONCE()/synchronize=
_rcu() in
> > > > > > > > > > +  * virtio_reset_device().
> > > > > > > > > > +  */
> > > > > > > > > > + return smp_load_acquire(&vdev->irq_soft_enabled);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >   /**
> > > > > > > > > >    * virtio_has_dma_quirk - determine whether this devi=
ce has the DMA quirk
> > > > > > > > > >    * @vdev: the device
> > > > > > > > > > @@ -236,6 +254,13 @@ void virtio_device_ready(struct vi=
rtio_device *dev)
> > > > > > > > > >           if (dev->config->enable_cbs)
> > > > > > > > > >                     dev->config->enable_cbs(dev);
> > > > > > > > > > + /*
> > > > > > > > > > +  * Commit the driver setup before enabling the virtqu=
eue
> > > > > > > > > > +  * callbacks. Paried with smp_load_acuqire() in
> > > > > > > > > > +  * virtio_irq_soft_enabled()
> > > > > > > > > > +  */
> > > > > > > > > > + smp_store_release(&dev->irq_soft_enabled, true);
> > > > > > > > > > +
> > > > > > > > > >           BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > > > >           dev->config->set_status(dev, status | VIRTIO_=
CONFIG_S_DRIVER_OK);
> > > > > > > > > >   }
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >
>

