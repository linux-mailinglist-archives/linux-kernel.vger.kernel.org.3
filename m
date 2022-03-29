Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C470A4EA85D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiC2HOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiC2HOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38C2223D750
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648537952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCwKGowfl8QEjfi6KQrCCQqXgXbGyGS+aYqko+t3IK0=;
        b=KTzrvYBZi7OHh+pqhMnKYsvs+Xvi1LsvBokeOBXpu2yQzO59RbOacGNRNfyR/fPTFBtZHm
        TGYt55P5u5Gm+pP2UU18B2DUBTWX7ZCxmPZJP9S2DUzp+0z+NbHQdC9Qh61hh199BhYEFL
        C0wVY0GMctVM2hFYlf1av1usBQlMk/Y=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-_vj9vfwdOKynMhMdlctoIA-1; Tue, 29 Mar 2022 03:12:29 -0400
X-MC-Unique: _vj9vfwdOKynMhMdlctoIA-1
Received: by mail-lj1-f199.google.com with SMTP id 11-20020a2e154b000000b0024967cd6752so7099177ljv.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pCwKGowfl8QEjfi6KQrCCQqXgXbGyGS+aYqko+t3IK0=;
        b=yuMG1pWIo50PokQ0MQrO2h+yV0XFqEPIxCJWR1yFWLEOtqARuz6fNUb7jMxil9FEm9
         6n7q87NwKO9XLJdq1wMYIesz4HLooatEVqzGNdnO4gECBKVjM4DVwqdVDYvGfPRyeZHY
         nFR6j5rha2IOSBxXXPU+dkI2px6r7mOT1uQRCvtF3P2AoI7i1rf3UwoT1a2Sd+gjGncp
         ps2d7k/N4x+vSCtvmQgAWcVQHy1ri4F59smCuwJ3GlNbYjPbVWSyhMG8snmcfg9Cvt0H
         GaLylHTF8yzLKKZAT0vbIU71atQfpXdx0+vw6gEvoPLBpjyBKqMa2O0QU3Knnm86+Dnl
         8emg==
X-Gm-Message-State: AOAM533S3JpkrI48ad5irYa5az3dWXRq7YCvculqhmV2JSp6toQ/0jeo
        UuNot/CJPuLg32b9SkowSIWHzuBoRJncI5lUwhSuCM9G7ZIqy18V7zyA+9I4ugbXyg2kR0Tj3XL
        X+sjWYSLU8H8XPmFTDEmOw8TgzKF90rqfqZPWrawJ
X-Received: by 2002:a2e:5318:0:b0:249:8375:81ab with SMTP id h24-20020a2e5318000000b00249837581abmr1296190ljb.243.1648537947035;
        Tue, 29 Mar 2022 00:12:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQBJ/PRq7kSRy5Un4mDB9uLt1bAVB75XnJdfQhNufku+ikbsAx5MIRcVZ4VKspp/QKd4tYkV+tIOsje3iOeWE=
X-Received: by 2002:a2e:5318:0:b0:249:8375:81ab with SMTP id
 h24-20020a2e5318000000b00249837581abmr1296159ljb.243.1648537946573; Tue, 29
 Mar 2022 00:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <Yj1hkpyUqJE9sQ2p@redhat.com> <CACGkMEunsuWhn+aB2dM7noU257M9JV6jDjkQXLyOA+GjEoz_iw@mail.gmail.com>
 <20220325050947-mutt-send-email-mst@kernel.org> <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org> <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org> <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220328062452-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 29 Mar 2022 15:12:14 +0800
Message-ID: <CACGkMEtDybY_ZnQkkfuSkx8eMZKoMAe+pnEwyetuS2cmzRVFgw@mail.gmail.com>
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 6:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 28, 2022 at 02:18:22PM +0800, Jason Wang wrote:
> > On Mon, Mar 28, 2022 at 1:59 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Mon, Mar 28, 2022 at 12:56:41PM +0800, Jason Wang wrote:
> > > > On Fri, Mar 25, 2022 at 6:10 PM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > > >
> > > > > On Fri, Mar 25, 2022 at 05:20:19PM +0800, Jason Wang wrote:
> > > > > > On Fri, Mar 25, 2022 at 5:10 PM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > > > > > >
> > > > > > > On Fri, Mar 25, 2022 at 03:52:00PM +0800, Jason Wang wrote:
> > > > > > > > On Fri, Mar 25, 2022 at 2:31 PM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > > > > > >
> > > > > > > > > Bcc:
> > > > > > > > > Subject: Re: [PATCH 3/3] virtio: harden vring IRQ
> > > > > > > > > Message-ID: <20220325021422-mutt-send-email-mst@kernel.or=
g>
> > > > > > > > > Reply-To:
> > > > > > > > > In-Reply-To: <f7046303-7d7d-e39f-3c71-3688126cc812@redhat=
.com>
> > > > > > > > >
> > > > > > > > > On Fri, Mar 25, 2022 at 11:04:08AM +0800, Jason Wang wrot=
e:
> > > > > > > > > >
> > > > > > > > > > =E5=9C=A8 2022/3/24 =E4=B8=8B=E5=8D=887:03, Michael S. =
Tsirkin =E5=86=99=E9=81=93:
> > > > > > > > > > > On Thu, Mar 24, 2022 at 04:40:04PM +0800, Jason Wang =
wrote:
> > > > > > > > > > > > This is a rework on the previous IRQ hardening that=
 is done for
> > > > > > > > > > > > virtio-pci where several drawbacks were found and w=
ere reverted:
> > > > > > > > > > > >
> > > > > > > > > > > > 1) try to use IRQF_NO_AUTOEN which is not friendly =
to affinity managed IRQ
> > > > > > > > > > > >     that is used by some device such as virtio-blk
> > > > > > > > > > > > 2) done only for PCI transport
> > > > > > > > > > > >
> > > > > > > > > > > > In this patch, we tries to borrow the idea from the=
 INTX IRQ hardening
> > > > > > > > > > > > in the reverted commit 080cd7c3ac87 ("virtio-pci: h=
arden INTX interrupts")
> > > > > > > > > > > > by introducing a global irq_soft_enabled variable f=
or each
> > > > > > > > > > > > virtio_device. Then we can to toggle it during
> > > > > > > > > > > > virtio_reset_device()/virtio_device_ready(). A sync=
hornize_rcu() is
> > > > > > > > > > > > used in virtio_reset_device() to synchronize with t=
he IRQ handlers. In
> > > > > > > > > > > > the future, we may provide config_ops for the trans=
port that doesn't
> > > > > > > > > > > > use IRQ. With this, vring_interrupt() can return ch=
eck and early if
> > > > > > > > > > > > irq_soft_enabled is false. This lead to smp_load_ac=
quire() to be used
> > > > > > > > > > > > but the cost should be acceptable.
> > > > > > > > > > > Maybe it should be but is it? Can't we use synchroniz=
e_irq instead?
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Even if we allow the transport driver to synchornize th=
rough
> > > > > > > > > > synchronize_irq() we still need a check in the vring_in=
terrupt().
> > > > > > > > > >
> > > > > > > > > > We do something like the following previously:
> > > > > > > > > >
> > > > > > > > > >         if (!READ_ONCE(vp_dev->intx_soft_enabled))
> > > > > > > > > >                 return IRQ_NONE;
> > > > > > > > > >
> > > > > > > > > > But it looks like a bug since speculative read can be d=
one before the check
> > > > > > > > > > where the interrupt handler can't see the uncommitted s=
etup which is done by
> > > > > > > > > > the driver.
> > > > > > > > >
> > > > > > > > > I don't think so - if you sync after setting the value th=
en
> > > > > > > > > you are guaranteed that any handler running afterwards
> > > > > > > > > will see the new value.
> > > > > > > >
> > > > > > > > The problem is not disabled but the enable.
> > > > > > >
> > > > > > > So a misbehaving device can lose interrupts? That's not a pro=
blem at all
> > > > > > > imo.
> > > > > >
> > > > > > It's the interrupt raised before setting irq_soft_enabled to tr=
ue:
> > > > > >
> > > > > > CPU 0 probe) driver specific setup (not commited)
> > > > > > CPU 1 IRQ handler) read the uninitialized variable
> > > > > > CPU 0 probe) set irq_soft_enabled to true
> > > > > > CPU 1 IRQ handler) read irq_soft_enable as true
> > > > > > CPU 1 IRQ handler) use the uninitialized variable
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Yea, it hurts if you do it.  So do not do it then ;).
> > > > >
> > > > > irq_soft_enabled (I think driver_ok or status is a better name)
> > > >
> > > > I can change it to driver_ok.
> > > >
> > > > > should be initialized to false *before* irq is requested.
> > > > >
> > > > > And requesting irq commits all memory otherwise all drivers would=
 be
> > > > > broken,
> > > >
> > > > So I think we might talk different issues:
> > > >
> > > > 1) Whether request_irq() commits the previous setups, I think the
> > > > answer is yes, since the spin_unlock of desc->lock (release) can
> > > > guarantee this though there seems no documentation around
> > > > request_irq() to say this.
> > > >
> > > > And I can see at least drivers/video/fbdev/omap2/omapfb/dss/dispc.c=
 is
> > > > using smp_wmb() before the request_irq().
> > > >
> > > > And even if write is ordered we still need read to be ordered to be
> > > > paired with that.
>
> IMO it synchronizes with the CPU to which irq is
> delivered. Otherwise basically all drivers would be broken,
> wouldn't they be?

I guess it's because most of the drivers don't care much about the
buggy/malicious device.  And most of the devices may require an extra
step to enable device IRQ after request_irq(). Or it's the charge of
the driver to do the synchronization.

> I don't know whether it's correct on all platforms, but if not
> we need to fix request_irq.
>
> > > >
> > > > > if it doesn't it just needs to be fixed, not worked around in
> > > > > virtio.
> > > >
> > > > 2) virtio drivers might do a lot of setups between request_irq() an=
d
> > > > virtio_device_ready():
> > > >
> > > > request_irq()
> > > > driver specific setups
> > > > virtio_device_ready()
> > > >
> > > > CPU 0 probe) request_irq()
> > > > CPU 1 IRQ handler) read the uninitialized variable
> > > > CPU 0 probe) driver specific setups
> > > > CPU 0 probe) smp_store_release(intr_soft_enabled, true), commit the=
 setups
> > > > CPU 1 IRQ handler) read irq_soft_enable as true
> > > > CPU 1 IRQ handler) use the uninitialized variable
> > > >
> > > > Thanks
> > >
> > >
> > > As I said, virtio_device_ready needs to do synchronize_irq.
> > > That will guarantee all setup is visible to the specific IRQ,
> >
> > Only the interrupt after synchronize_irq() returns.
>
> Anything else is a buggy device though.

Yes, but the goal of this patch is to prevent the possible attack from
buggy(malicious) devices.

>
> > >this
> > > is what it's point is.
> >
> > What happens if an interrupt is raised in the middle like:
> >
> > smp_store_release(dev->irq_soft_enabled, true)
> > IRQ handler
> > synchornize_irq()
> >
> > If we don't enforce a reading order, the IRQ handler may still see the
> > uninitialized variable.
> >
> > Thanks
>
> IMHO variables should be initialized before request_irq
> to a value meaning "not a valid interrupt".
> Specifically driver_ok =3D false.
> Handler in the scenario you describe will then see !driver_ok
> and exit immediately.

So just to make sure we're on the same page.

1) virtio_reset_device() will set the driver_ok to false;
2) virtio_device_ready() will set the driver_ok to true

So for virtio drivers, it often did:

1) virtio_reset_device()
2) find_vqs() which will call request_irq()
3) other driver specific setups
4) virtio_device_ready()

In virtio_device_ready(), the patch perform the following currently:

smp_store_release(driver_ok, true);
set_status(DRIVER_OK);

Per your suggestion, to add synchronize_irq() after
smp_store_release() so we had

smp_store_release(driver_ok, true);
synchornize_irq()
set_status(DRIVER_OK)

Suppose there's a interrupt raised before the synchronize_irq(), if we do:

if (READ_ONCE(driver_ok)) {
      vq->callback()
}

It will see the driver_ok as true but how can we make sure
vq->callback sees the driver specific setups (3) above?

And an example is virtio_scsi():

virtio_reset_device()
virtscsi_probe()
    virtscsi_init()
        virtio_find_vqs()
        ...
        virtscsi_init_vq(&vscsi->event_vq, vqs[1])
    ....
    virtio_device_ready()

In virtscsi_event_done():

virtscsi_event_done():
    virtscsi_vq_done(vscsi, &vscsi->event_vq, ...);

We need to make sure the even_done reads driver_ok before read vscsi->event=
_vq.

Thanks

>
>
> > >
> > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > > We use smp_store_relase()
> > > > > > > > to make sure the driver commits the setup before enabling t=
he irq. It
> > > > > > > > means the read needs to be ordered as well in vring_interru=
pt().
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Although I couldn't find anything about this in memory-ba=
rriers.txt
> > > > > > > > > which surprises me.
> > > > > > > > >
> > > > > > > > > CC Paul to help make sure I'm right.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > To avoid breaking legacy device which can send IRQ =
before DRIVER_OK, a
> > > > > > > > > > > > module parameter is introduced to enable the harden=
ing so function
> > > > > > > > > > > > hardening is disabled by default.
> > > > > > > > > > > Which devices are these? How come they send an interr=
upt before there
> > > > > > > > > > > are any buffers in any queues?
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I copied this from the commit log for 22b7050a024d7
> > > > > > > > > >
> > > > > > > > > > "
> > > > > > > > > >
> > > > > > > > > >     This change will also benefit old hypervisors (befo=
re 2009)
> > > > > > > > > >     that send interrupts without checking DRIVER_OK: pr=
eviously,
> > > > > > > > > >     the callback could race with driver-specific initia=
lization.
> > > > > > > > > > "
> > > > > > > > > >
> > > > > > > > > > If this is only for config interrupt, I can remove the =
above log.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > This is only for config interrupt.
> > > > > > > >
> > > > > > > > Ok.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > Note that the hardening is only done for vring inte=
rrupt since the
> > > > > > > > > > > > config interrupt hardening is already done in commi=
t 22b7050a024d7
> > > > > > > > > > > > ("virtio: defer config changed notifications"). But=
 the method that is
> > > > > > > > > > > > used by config interrupt can't be reused by the vri=
ng interrupt
> > > > > > > > > > > > handler because it uses spinlock to do the synchron=
ization which is
> > > > > > > > > > > > expensive.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > >   drivers/virtio/virtio.c       | 19 ++++++++++++++=
+++++
> > > > > > > > > > > >   drivers/virtio/virtio_ring.c  |  9 ++++++++-
> > > > > > > > > > > >   include/linux/virtio.h        |  4 ++++
> > > > > > > > > > > >   include/linux/virtio_config.h | 25 ++++++++++++++=
+++++++++++
> > > > > > > > > > > >   4 files changed, 56 insertions(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virt=
io/virtio.c
> > > > > > > > > > > > index 8dde44ea044a..85e331efa9cc 100644
> > > > > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > > > > @@ -7,6 +7,12 @@
> > > > > > > > > > > >   #include <linux/of.h>
> > > > > > > > > > > >   #include <uapi/linux/virtio_ids.h>
> > > > > > > > > > > > +static bool irq_hardening =3D false;
> > > > > > > > > > > > +
> > > > > > > > > > > > +module_param(irq_hardening, bool, 0444);
> > > > > > > > > > > > +MODULE_PARM_DESC(irq_hardening,
> > > > > > > > > > > > +          "Disalbe IRQ software processing when it=
 is not expected");
> > > > > > > > > > > > +
> > > > > > > > > > > >   /* Unique numbering for virtio devices. */
> > > > > > > > > > > >   static DEFINE_IDA(virtio_index_ida);
> > > > > > > > > > > > @@ -220,6 +226,15 @@ static int virtio_features_ok(=
struct virtio_device *dev)
> > > > > > > > > > > >    * */
> > > > > > > > > > > >   void virtio_reset_device(struct virtio_device *de=
v)
> > > > > > > > > > > >   {
> > > > > > > > > > > > + /*
> > > > > > > > > > > > +  * The below synchronize_rcu() guarantees that an=
y
> > > > > > > > > > > > +  * interrupt for this line arriving after
> > > > > > > > > > > > +  * synchronize_rcu() has completed is guaranteed =
to see
> > > > > > > > > > > > +  * irq_soft_enabled =3D=3D false.
> > > > > > > > > > > News to me I did not know synchronize_rcu has anythin=
g to do
> > > > > > > > > > > with interrupts. Did not you intend to use synchroniz=
e_irq?
> > > > > > > > > > > I am not even 100% sure synchronize_rcu is by design =
a memory barrier
> > > > > > > > > > > though it's most likely is ...
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > According to the comment above tree RCU version of sync=
hronize_rcu():
> > > > > > > > > >
> > > > > > > > > > """
> > > > > > > > > >
> > > > > > > > > >  * RCU read-side critical sections are delimited by rcu=
_read_lock()
> > > > > > > > > >  * and rcu_read_unlock(), and may be nested.  In additi=
on, but only in
> > > > > > > > > >  * v5.0 and later, regions of code across which interru=
pts, preemption,
> > > > > > > > > >  * or softirqs have been disabled also serve as RCU rea=
d-side critical
> > > > > > > > > >  * sections.  This includes hardware interrupt handlers=
, softirq handlers,
> > > > > > > > > >  * and NMI handlers.
> > > > > > > > > > """
> > > > > > > > > >
> > > > > > > > > > So interrupt handlers are treated as read-side critical=
 sections.
> > > > > > > > > >
> > > > > > > > > > And it has the comment for explain the barrier:
> > > > > > > > > >
> > > > > > > > > > """
> > > > > > > > > >
> > > > > > > > > >  * Note that this guarantee implies further memory-orde=
ring guarantees.
> > > > > > > > > >  * On systems with more than one CPU, when synchronize_=
rcu() returns,
> > > > > > > > > >  * each CPU is guaranteed to have executed a full memor=
y barrier since
> > > > > > > > > >  * the end of its last RCU read-side critical section w=
hose beginning
> > > > > > > > > >  * preceded the call to synchronize_rcu().  In addition=
, each CPU having
> > > > > > > > > > """
> > > > > > > > > >
> > > > > > > > > > So on SMP it provides a full barrier. And for UP/tiny R=
CU we don't need the
> > > > > > > > > > barrier, if the interrupt come after WRITE_ONCE() it wi=
ll see the
> > > > > > > > > > irq_soft_enabled as false.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > You are right. So then
> > > > > > > > > 1. I do not think we need load_acquire - why is it needed=
? Just
> > > > > > > > >    READ_ONCE should do.
> > > > > > > >
> > > > > > > > See above.
> > > > > > > >
> > > > > > > > > 2. isn't synchronize_irq also doing the same thing?
> > > > > > > >
> > > > > > > >
> > > > > > > > Yes, but it requires a config ops since the IRQ knowledge i=
s transport specific.
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > +  */
> > > > > > > > > > > > + WRITE_ONCE(dev->irq_soft_enabled, false);
> > > > > > > > > > > > + synchronize_rcu();
> > > > > > > > > > > > +
> > > > > > > > > > > >           dev->config->reset(dev);
> > > > > > > > > > > >   }
> > > > > > > > > > > >   EXPORT_SYMBOL_GPL(virtio_reset_device);
> > > > > > > > > > > Please add comment explaining where it will be enable=
d.
> > > > > > > > > > > Also, we *really* don't need to synch if it was alrea=
dy disabled,
> > > > > > > > > > > let's not add useless overhead to the boot sequence.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Ok.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > @@ -427,6 +442,10 @@ int register_virtio_device(str=
uct virtio_device *dev)
> > > > > > > > > > > >           spin_lock_init(&dev->config_lock);
> > > > > > > > > > > >           dev->config_enabled =3D false;
> > > > > > > > > > > >           dev->config_change_pending =3D false;
> > > > > > > > > > > > + dev->irq_soft_check =3D irq_hardening;
> > > > > > > > > > > > +
> > > > > > > > > > > > + if (dev->irq_soft_check)
> > > > > > > > > > > > +         dev_info(&dev->dev, "IRQ hardening is ena=
bled\n");
> > > > > > > > > > > >           /* We always start by resetting the devic=
e, in case a previous
> > > > > > > > > > > >            * driver messed it up.  This also tests =
that code path a little. */
> > > > > > > > > > > one of the points of hardening is it's also helpful f=
or buggy
> > > > > > > > > > > devices. this flag defeats the purpose.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Do you mean:
> > > > > > > > > >
> > > > > > > > > > 1) we need something like config_enable? This seems not=
 easy to be
> > > > > > > > > > implemented without obvious overhead, mainly the synchr=
onize with the
> > > > > > > > > > interrupt handlers
> > > > > > > > >
> > > > > > > > > But synchronize is only on tear-down path. That is not cr=
itical for any
> > > > > > > > > users at the moment, even less than probe.
> > > > > > > >
> > > > > > > > I meant if we have vq->irq_pending, we need to call vring_i=
nterrupt()
> > > > > > > > in the virtio_device_ready() and synchronize the IRQ handle=
rs with
> > > > > > > > spinlock or others.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > 2) enable this by default, so I don't object, but this =
may have some risk
> > > > > > > > > > for old hypervisors
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > The risk if there's a driver adding buffers without setti=
ng DRIVER_OK.
> > > > > > > >
> > > > > > > > Probably not, we have devices that accept random inputs fro=
m outside,
> > > > > > > > net, console, input etc. I've done a round of audits of the=
 Qemu
> > > > > > > > codes. They look all fine since day0.
> > > > > > > >
> > > > > > > > > So with this approach, how about we rename the flag "driv=
er_ok"?
> > > > > > > > > And then add_buf can actually test it and BUG_ON if not t=
here  (at least
> > > > > > > > > in the debug build).
> > > > > > > >
> > > > > > > > This looks like a hardening of the driver in the core inste=
ad of the
> > > > > > > > device. I think it can be done but in a separate series.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > And going down from there, how about we cache status in t=
he
> > > > > > > > > device? Then we don't need to keep re-reading it every ti=
me,
> > > > > > > > > speeding boot up a tiny bit.
> > > > > > > >
> > > > > > > > I don't fully understand here, actually spec requires statu=
s to be
> > > > > > > > read back for validation in many cases.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers=
/virtio/virtio_ring.c
> > > > > > > > > > > > index 962f1477b1fa..0170f8c784d8 100644
> > > > > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > > > > @@ -2144,10 +2144,17 @@ static inline bool more_use=
d(const struct vring_virtqueue *vq)
> > > > > > > > > > > >           return vq->packed_ring ? more_used_packed=
(vq) : more_used_split(vq);
> > > > > > > > > > > >   }
> > > > > > > > > > > > -irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > > > > > > > +irqreturn_t vring_interrupt(int irq, void *v)
> > > > > > > > > > > >   {
> > > > > > > > > > > > + struct virtqueue *_vq =3D v;
> > > > > > > > > > > > + struct virtio_device *vdev =3D _vq->vdev;
> > > > > > > > > > > >           struct vring_virtqueue *vq =3D to_vvq(_vq=
);
> > > > > > > > > > > > + if (!virtio_irq_soft_enabled(vdev)) {
> > > > > > > > > > > > +         dev_warn_once(&vdev->dev, "virtio vring I=
RQ raised before DRIVER_OK");
> > > > > > > > > > > > +         return IRQ_NONE;
> > > > > > > > > > > > + }
> > > > > > > > > > > > +
> > > > > > > > > > > >           if (!more_used(vq)) {
> > > > > > > > > > > >                   pr_debug("virtqueue interrupt wit=
h no work for %p\n", vq);
> > > > > > > > > > > >                   return IRQ_NONE;
> > > > > > > > > > > > diff --git a/include/linux/virtio.h b/include/linux=
/virtio.h
> > > > > > > > > > > > index 5464f398912a..957d6ad604ac 100644
> > > > > > > > > > > > --- a/include/linux/virtio.h
> > > > > > > > > > > > +++ b/include/linux/virtio.h
> > > > > > > > > > > > @@ -95,6 +95,8 @@ dma_addr_t virtqueue_get_used_add=
r(struct virtqueue *vq);
> > > > > > > > > > > >    * @failed: saved value for VIRTIO_CONFIG_S_FAILE=
D bit (for restore)
> > > > > > > > > > > >    * @config_enabled: configuration change reportin=
g enabled
> > > > > > > > > > > >    * @config_change_pending: configuration change r=
eported while disabled
> > > > > > > > > > > > + * @irq_soft_check: whether or not to check @irq_s=
oft_enabled
> > > > > > > > > > > > + * @irq_soft_enabled: callbacks enabled
> > > > > > > > > > > >    * @config_lock: protects configuration change re=
porting
> > > > > > > > > > > >    * @dev: underlying device.
> > > > > > > > > > > >    * @id: the device type identification (used to m=
atch it with a driver).
> > > > > > > > > > > > @@ -109,6 +111,8 @@ struct virtio_device {
> > > > > > > > > > > >           bool failed;
> > > > > > > > > > > >           bool config_enabled;
> > > > > > > > > > > >           bool config_change_pending;
> > > > > > > > > > > > + bool irq_soft_check;
> > > > > > > > > > > > + bool irq_soft_enabled;
> > > > > > > > > > > >           spinlock_t config_lock;
> > > > > > > > > > > >           spinlock_t vqs_list_lock; /* Protects VQs=
 list access */
> > > > > > > > > > > >           struct device dev;
> > > > > > > > > > > > diff --git a/include/linux/virtio_config.h b/includ=
e/linux/virtio_config.h
> > > > > > > > > > > > index dafdc7f48c01..9c1b61f2e525 100644
> > > > > > > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > > > > > > @@ -174,6 +174,24 @@ static inline bool virtio_has_=
feature(const struct virtio_device *vdev,
> > > > > > > > > > > >           return __virtio_test_bit(vdev, fbit);
> > > > > > > > > > > >   }
> > > > > > > > > > > > +/*
> > > > > > > > > > > > + * virtio_irq_soft_enabled: whether we can execute=
 callbacks
> > > > > > > > > > > > + * @vdev: the device
> > > > > > > > > > > > + */
> > > > > > > > > > > > +static inline bool virtio_irq_soft_enabled(const s=
truct virtio_device *vdev)
> > > > > > > > > > > > +{
> > > > > > > > > > > > + if (!vdev->irq_soft_check)
> > > > > > > > > > > > +         return true;
> > > > > > > > > > > > +
> > > > > > > > > > > > + /*
> > > > > > > > > > > > +  * Read irq_soft_enabled before reading other dev=
ice specific
> > > > > > > > > > > > +  * data. Paried with smp_store_relase() in
> > > > > > > > > > > paired
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Will fix.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > +  * virtio_device_ready() and WRITE_ONCE()/synchro=
nize_rcu() in
> > > > > > > > > > > > +  * virtio_reset_device().
> > > > > > > > > > > > +  */
> > > > > > > > > > > > + return smp_load_acquire(&vdev->irq_soft_enabled);
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >   /**
> > > > > > > > > > > >    * virtio_has_dma_quirk - determine whether this =
device has the DMA quirk
> > > > > > > > > > > >    * @vdev: the device
> > > > > > > > > > > > @@ -236,6 +254,13 @@ void virtio_device_ready(struc=
t virtio_device *dev)
> > > > > > > > > > > >           if (dev->config->enable_cbs)
> > > > > > > > > > > >                     dev->config->enable_cbs(dev);
> > > > > > > > > > > > + /*
> > > > > > > > > > > > +  * Commit the driver setup before enabling the vi=
rtqueue
> > > > > > > > > > > > +  * callbacks. Paried with smp_load_acuqire() in
> > > > > > > > > > > > +  * virtio_irq_soft_enabled()
> > > > > > > > > > > > +  */
> > > > > > > > > > > > + smp_store_release(&dev->irq_soft_enabled, true);
> > > > > > > > > > > > +
> > > > > > > > > > > >           BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK=
);
> > > > > > > > > > > >           dev->config->set_status(dev, status | VIR=
TIO_CONFIG_S_DRIVER_OK);
> > > > > > > > > > > >   }
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.25.1
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

