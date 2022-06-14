Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F054AA67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352076AbiFNHUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354311AbiFNHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31B203DA77
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655191160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8MH70EqUQYMTaow0vbl+qTzxY/E9IkdMWzxdkmx2So=;
        b=XnWDUA5QAxg9uQII9ykU3rsLISPN0KxuYhojkxV/5KBbTdz2MdhSnHecVam1AYctbu5ptF
        x20Oe/VnuikBFDWINPV0RoqJMS0eLrJcL1G4Pn24goOQOK+MKakvb+bJuzEyu6qiXNuUG/
        T0T4SJox76k22XhzvMO0H04BWREMxGY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-VJ9vBIVwP8aQgb8D_-zpPA-1; Tue, 14 Jun 2022 03:19:18 -0400
X-MC-Unique: VJ9vBIVwP8aQgb8D_-zpPA-1
Received: by mail-lf1-f71.google.com with SMTP id u5-20020a056512128500b00479784f526cso4119824lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8MH70EqUQYMTaow0vbl+qTzxY/E9IkdMWzxdkmx2So=;
        b=jN7BeHhtwjNneaZnUM3V0iM81XDrHyiGsZWNd6Nn2mTsVYO/ofpkn5/uNL+eSlnM0p
         Tiv+d830ww6QHCCC9peG33sltroJMtpbQgRAuTZSmiV5P8C5+i9xuG/b8Lo/b09jMZ6j
         bsABIN9K9u1FLl2s5n6kp4h3uU+blhTeXsUk4rKjHCv6QytaI34v2hOQkzHuMXdGTniN
         6JgugY4AJIeznv8qzjmlptAWqrc+xe9+l6c3a1/dBHWRd0Wk3fnp5av0A2mazzujx4wu
         AwnyX6ScpCgyMMxZtgiiq0rwkJcheH2NYGTBQdyUFr7SLIOvh/6u4tafWAJG2Y2wBoQ3
         XIpQ==
X-Gm-Message-State: AJIora/sFOy+elnLK3eW0usGcAJu44T4D4PUdTSa2s9MQVrwX354VG0u
        q6G385sUs4+9VPZlVOV71cLN2wUmwNQikWOTgJJG7i0tfHEVpLcR78I3CmuKEooPzRmTUajVEmo
        MXGSPTcG/kq0L06Mr+pL98Xz60mkWJtqN2sC92Xoc
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id c7-20020a056512104700b004797805005fmr2215707lfb.238.1655191157046;
        Tue, 14 Jun 2022 00:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ujZy1lInCrYWOb4WhklMGMaKBtEJFI2pk8SnkegOHMC08rxHTriNdcD4EsokNdQ1MAi9wPiPjnMiLwdiXxn+8=
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id
 c7-20020a056512104700b004797805005fmr2215682lfb.238.1655191156649; Tue, 14
 Jun 2022 00:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220527060120.20964-1-jasowang@redhat.com> <20220527060120.20964-9-jasowang@redhat.com>
 <20220611010747-mutt-send-email-mst@kernel.org> <CACGkMEtRP+0Xy63g0SF_y1avv=3rFv6P9+Z7kp9XBS5d+_py8w@mail.gmail.com>
 <20220613023337-mutt-send-email-mst@kernel.org> <CACGkMEs05ZisiPW+7H6Omp80MzmZWZCpc1mf5Vd99C3H-KUtgA@mail.gmail.com>
 <20220613041416-mutt-send-email-mst@kernel.org> <CACGkMEsT_fWdPxN1cTWOX=vu-ntp3Xo4j46-ZKALeSXr7DmJFQ@mail.gmail.com>
 <20220613045606-mutt-send-email-mst@kernel.org> <CACGkMEtAQck7Nr6SP_pD0MGT3njnwZSyT=xPyYzUU3c5GNNM_w@mail.gmail.com>
 <20220613052221-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220613052221-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Jun 2022 15:19:05 +0800
Message-ID: <CACGkMEv-=_WPZH9a8spgMFk1HcyvRmk3znqDh9DXVpNFsU7XTw@mail.gmail.com>
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 5:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 13, 2022 at 05:08:20PM +0800, Jason Wang wrote:
> > On Mon, Jun 13, 2022 at 4:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jun 13, 2022 at 04:51:08PM +0800, Jason Wang wrote:
> > > > On Mon, Jun 13, 2022 at 4:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Jun 13, 2022 at 04:07:09PM +0800, Jason Wang wrote:
> > > > > > On Mon, Jun 13, 2022 at 3:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 13, 2022 at 01:26:59PM +0800, Jason Wang wrote:
> > > > > > > > On Sat, Jun 11, 2022 at 1:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, May 27, 2022 at 02:01:19PM +0800, Jason Wang wrote:
> > > > > > > > > > This is a rework on the previous IRQ hardening that is done for
> > > > > > > > > > virtio-pci where several drawbacks were found and were reverted:
> > > > > > > > > >
> > > > > > > > > > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
> > > > > > > > > >    that is used by some device such as virtio-blk
> > > > > > > > > > 2) done only for PCI transport
> > > > > > > > > >
> > > > > > > > > > The vq->broken is re-used in this patch for implementing the IRQ
> > > > > > > > > > hardening. The vq->broken is set to true during both initialization
> > > > > > > > > > and reset. And the vq->broken is set to false in
> > > > > > > > > > virtio_device_ready(). Then vring_interrupt() can check and return
> > > > > > > > > > when vq->broken is true. And in this case, switch to return IRQ_NONE
> > > > > > > > > > to let the interrupt core aware of such invalid interrupt to prevent
> > > > > > > > > > IRQ storm.
> > > > > > > > > >
> > > > > > > > > > The reason of using a per queue variable instead of a per device one
> > > > > > > > > > is that we may need it for per queue reset hardening in the future.
> > > > > > > > > >
> > > > > > > > > > Note that the hardening is only done for vring interrupt since the
> > > > > > > > > > config interrupt hardening is already done in commit 22b7050a024d7
> > > > > > > > > > ("virtio: defer config changed notifications"). But the method that is
> > > > > > > > > > used by config interrupt can't be reused by the vring interrupt
> > > > > > > > > > handler because it uses spinlock to do the synchronization which is
> > > > > > > > > > expensive.
> > > > > > > > > >
> > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > > > > > > > > > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > > > > > > > > Cc: linux-s390@vger.kernel.org
> > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Jason, I am really concerned by all the fallout.
> > > > > > > > > I propose adding a flag to suppress the hardening -
> > > > > > > > > this will be a debugging aid and a work around for
> > > > > > > > > users if we find more buggy drivers.
> > > > > > > > >
> > > > > > > > > suppress_interrupt_hardening ?
> > > > > > > >
> > > > > > > > I can post a patch but I'm afraid if we disable it by default, it
> > > > > > > > won't be used by the users so there's no way for us to receive the bug
> > > > > > > > report. Or we need a plan to enable it by default.
> > > > > > > >
> > > > > > > > It's rc2, how about waiting for 1 and 2 rc? Or it looks better if we
> > > > > > > > simply warn instead of disable it by default.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > I meant more like a flag in struct virtio_driver.
> > > > > > > For now, could you audit all drivers which don't call _ready?
> > > > > > > I found 5 of these:
> > > > > > >
> > > > > > > drivers/bluetooth/virtio_bt.c
> > > > > >
> > > > > > This driver seems to be fine, it doesn't use the device/vq in its probe().
> > > > >
> > > > >
> > > > > But it calls hci_register_dev and that in turn queues all kind of
> > > > > work. Also, can linux start using the device immediately after
> > > > > it's registered?
> > > >
> > > > So I think the driver is allowed to queue before DRIVER_OK.
> > >
> > > it's not allowed to kick
> >
> > Yes.
> >
> > >
> > > > If yes,
> > > > the only side effect is the delay of the tx interrupt after DRIVER_OK
> > > > for a well behaved device.
> > >
> > > your patches drop the interrupt though, it won't be just delayed.
> >
> > For a well behaved device, it can only trigger the interrupt after DRIVER_OK.
> >
> > So for virtio bt, it works like:
> >
> > 1) driver queue buffer and kick
> > 2) driver set DRIVER_OK
> > 3) device start to process the buffer
> > 4) device send an notification
> >
> > The only risk is that the virtqueue could be filled before DRIVER_OK,
> > or anything I missed?
> >
> > >
> > > > If not, we need to clarify it in the spec
> > > > and call virtio_device_ready() before subsystem registration.
> > >
> > > hmm, i don't get what we need to clarify
> >
> > E.g the driver is not allowed to kick or after DRIVER_OK should the
> > device only process the buffer after a kick after DRIVER_OK (I think
> > no)?
>
> I am not sure I understand. Are you asking whether device
> must check vqs for buffers upon DRIVER_OK?

Yes.

> I don't think so,
> if driver wants buffers processed it must kick after DRIVER_OK.

Ok.

>
> And kicking before DRIVER_OK is out of spec.

Right.

>
>
> > >
> > > > >
> > > > >
> > > > > > > drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > > >
> > > > > > It calles virtio_device_ready() in virtio_gpu_init(), and it looks to
> > > > > > me the code is correct.
> > > > >
> > > > > OK.
> > > > >
> > > > > > > drivers/i2c/busses/i2c-virtio.c
> > > > > > > drivers/net/caif/caif_virtio.c
> > > > > > > drivers/nvdimm/virtio_pmem.c
> > > > > >
> > > > > > The above looks fine and we have three more:
> > > > > >
> > > > > > arm_scmi: probe() doesn't use vq
> > > > > > mac80211_hwsim.c: doesn't use vq (only fill rx), but it kicks the rx,
> > > > > > it looks to me we need a device_ready before the kick.
> > > > > > virtio_rpmsg_bus.c: doesn't use vq
> > > > > >
> > > > > > I will post a patch for mac80211_hwsim.c.
> > > > > > Thanks
> > > > >
> > > > > Same comments for all of the above. Might linux not start using the
> > > > > device once it's registered?
> > > >
> > > > It depends on the specific subsystem.
> > > >
> > > > For the subsystem that can't use the device immediately, calling
> > > > virtio_device_ready() after the subsystem's registration should be
> > > > fine. E.g for the networking subsystem, the TX won't happen if
> > > > ndo_open() is not called, calling virtio_device_ready() after
> > > > netdev_register() seems to be fine.
> > >
> > > exactly
> > >
> > > > For the subsystem that can use the device immediately, if the
> > > > subsystem does not depend on the result of a request in the probe to
> > > > proceed, we are still fine. Since those requests will be proceed after
> > > > DRIVER_OK.
> > >
> > > Well first won't driver code normally kick as well?
> >
> > Kick itself is not blocked.
>
> It is out of spec though.

Yes.

>
> > > And without kick, won't everything just be blocked?
> >
> > It depends on the subsystem. E.g driver can choose to use a callback
> > instead of polling the used buffer in the probe.
> >
> > >
> > >
> > > > For the rest we need to do virtio_device_ready() before registration.
> > > >
> > > > Thanks
> > >
> > > Then we can get an interrupt for an unregistered device.
> >
> > It depends on the device. For the device that doesn't have an rx queue
> > (or device to driver queue), we are fine:
> >
> > E.g in virtio-blk:
> >
> >         virtio_device_ready(vdev);
> >
> >         err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> >         if (err)
> >                 goto out_cleanup_disk;
> >
> > Thanks
>
> yes - as long as no buffers are used, no callback is expected.
> However wasn't the point of your patches to handle a malicious device?

Right, but for subsystems that don't have a way to open/close devices
like the block layer, there's not much we can do except depending on
the callback - virtblk_done itself which seems to be safe.

We guard the malicious hypervisor by checking:

1) checking the token
2) when token is NULL, no dereference to any subsystem's data structure

Thanks

>
> > >
> > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >  drivers/s390/virtio/virtio_ccw.c       |  4 ++++
> > > > > > > > > >  drivers/virtio/virtio.c                | 15 ++++++++++++---
> > > > > > > > > >  drivers/virtio/virtio_mmio.c           |  5 +++++
> > > > > > > > > >  drivers/virtio/virtio_pci_modern_dev.c |  5 +++++
> > > > > > > > > >  drivers/virtio/virtio_ring.c           | 11 +++++++----
> > > > > > > > > >  include/linux/virtio_config.h          | 20 ++++++++++++++++++++
> > > > > > > > > >  6 files changed, 53 insertions(+), 7 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > index c188e4f20ca3..97e51c34e6cf 100644
> > > > > > > > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > @@ -971,6 +971,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
> > > > > > > > > >       ccw->flags = 0;
> > > > > > > > > >       ccw->count = sizeof(status);
> > > > > > > > > >       ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
> > > > > > > > > > +     /* We use ssch for setting the status which is a serializing
> > > > > > > > > > +      * instruction that guarantees the memory writes have
> > > > > > > > > > +      * completed before ssch.
> > > > > > > > > > +      */
> > > > > > > > > >       ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
> > > > > > > > > >       /* Write failed? We assume status is unchanged. */
> > > > > > > > > >       if (ret)
> > > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > > > > index aa1eb5132767..95fac4c97c8b 100644
> > > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > > @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
> > > > > > > > > >   * */
> > > > > > > > > >  void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > > >  {
> > > > > > > > > > +     /*
> > > > > > > > > > +      * The below virtio_synchronize_cbs() guarantees that any
> > > > > > > > > > +      * interrupt for this line arriving after
> > > > > > > > > > +      * virtio_synchronize_vqs() has completed is guaranteed to see
> > > > > > > > > > +      * vq->broken as true.
> > > > > > > > > > +      */
> > > > > > > > > > +     virtio_break_device(dev);
> > > > > > > > >
> > > > > > > > > So make this conditional
> > > > > > > > >
> > > > > > > > > > +     virtio_synchronize_cbs(dev);
> > > > > > > > > > +
> > > > > > > > > >       dev->config->reset(dev);
> > > > > > > > > >  }
> > > > > > > > > >  EXPORT_SYMBOL_GPL(virtio_reset_device);
> > > > > > > > > > @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > > > > >       dev->config_enabled = false;
> > > > > > > > > >       dev->config_change_pending = false;
> > > > > > > > > >
> > > > > > > > > > +     INIT_LIST_HEAD(&dev->vqs);
> > > > > > > > > > +     spin_lock_init(&dev->vqs_list_lock);
> > > > > > > > > > +
> > > > > > > > > >       /* We always start by resetting the device, in case a previous
> > > > > > > > > >        * driver messed it up.  This also tests that code path a little. */
> > > > > > > > > >       virtio_reset_device(dev);
> > > > > > > > > > @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > > > > >       /* Acknowledge that we've seen the device. */
> > > > > > > > > >       virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > > > > > > > > >
> > > > > > > > > > -     INIT_LIST_HEAD(&dev->vqs);
> > > > > > > > > > -     spin_lock_init(&dev->vqs_list_lock);
> > > > > > > > > > -
> > > > > > > > > >       /*
> > > > > > > > > >        * device_add() causes the bus infrastructure to look for a matching
> > > > > > > > > >        * driver.
> > > > > > > > > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > > > > > > > > index c9699a59f93c..f9a36bc7ac27 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_mmio.c
> > > > > > > > > > +++ b/drivers/virtio/virtio_mmio.c
> > > > > > > > > > @@ -253,6 +253,11 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
> > > > > > > > > >       /* We should never be setting status to 0. */
> > > > > > > > > >       BUG_ON(status == 0);
> > > > > > > > > >
> > > > > > > > > > +     /*
> > > > > > > > > > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > > > > > > > > > +      * that the the cache coherent memory writes have completed
> > > > > > > > > > +      * before writing to the MMIO region.
> > > > > > > > > > +      */
> > > > > > > > > >       writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > > > > index 4093f9cca7a6..a0fa14f28a7f 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > > > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > > > > @@ -467,6 +467,11 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> > > > > > > > > >  {
> > > > > > > > > >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> > > > > > > > > >
> > > > > > > > > > +     /*
> > > > > > > > > > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > > > > > > > > > +      * that the the cache coherent memory writes have completed
> > > > > > > > > > +      * before writing to the MMIO region.
> > > > > > > > > > +      */
> > > > > > > > > >       vp_iowrite8(status, &cfg->device_status);
> > > > > > > > > >  }
> > > > > > > > > >  EXPORT_SYMBOL_GPL(vp_modern_set_status);
> > > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > > index 9c231e1fded7..13a7348cedff 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > > @@ -1688,7 +1688,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > > > > > > >       vq->we_own_ring = true;
> > > > > > > > > >       vq->notify = notify;
> > > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > > -     vq->broken = false;
> > > > > > > > > > +     vq->broken = true;
> > > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > > >       vq->event_triggered = false;
> > > > > > > > > >       vq->num_added = 0;
> > > > > > > > >
> > > > > > > > > and make this conditional
> > > > > > > > >
> > > > > > > > > > @@ -2134,8 +2134,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > > > > >               return IRQ_NONE;
> > > > > > > > > >       }
> > > > > > > > > >
> > > > > > > > > > -     if (unlikely(vq->broken))
> > > > > > > > > > -             return IRQ_HANDLED;
> > > > > > > > > > +     if (unlikely(vq->broken)) {
> > > > > > > > > > +             dev_warn_once(&vq->vq.vdev->dev,
> > > > > > > > > > +                           "virtio vring IRQ raised before DRIVER_OK");
> > > > > > > > > > +             return IRQ_NONE;
> > > > > > > > > > +     }
> > > > > > > > > >
> > > > > > > > > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > > > > > > > >       if (vq->event)
> > > > > > > > > > @@ -2177,7 +2180,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > > > > > > >       vq->we_own_ring = false;
> > > > > > > > > >       vq->notify = notify;
> > > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > > -     vq->broken = false;
> > > > > > > > > > +     vq->broken = true;
> > > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > > >       vq->event_triggered = false;
> > > > > > > > > >       vq->num_added = 0;
> > > > > > > > >
> > > > > > > > > and make this conditional
> > > > > > > > >
> > > > > > > > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > > > > > > > index 25be018810a7..d4edfd7d91bb 100644
> > > > > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > > > > @@ -256,6 +256,26 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > > > > >       unsigned status = dev->config->get_status(dev);
> > > > > > > > > >
> > > > > > > > > >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > > > > +
> > > > > > > > > > +     /*
> > > > > > > > > > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > > > > > > > > +      * will see the driver specific setup if it sees vq->broken
> > > > > > > > > > +      * as false (even if the notifications come before DRIVER_OK).
> > > > > > > > > > +      */
> > > > > > > > > > +     virtio_synchronize_cbs(dev);
> > > > > > > > > > +     __virtio_unbreak_device(dev);
> > > > > > > > > > +     /*
> > > > > > > > > > +      * The transport should ensure the visibility of vq->broken
> > > > > > > > > > +      * before setting DRIVER_OK. See the comments for the transport
> > > > > > > > > > +      * specific set_status() method.
> > > > > > > > > > +      *
> > > > > > > > > > +      * A well behaved device will only notify a virtqueue after
> > > > > > > > > > +      * DRIVER_OK, this means the device should "see" the coherenct
> > > > > > > > > > +      * memory write that set vq->broken as false which is done by
> > > > > > > > > > +      * the driver when it sees DRIVER_OK, then the following
> > > > > > > > > > +      * driver's vring_interrupt() will see vq->broken as false so
> > > > > > > > > > +      * we won't lose any notification.
> > > > > > > > > > +      */
> > > > > > > > > >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

