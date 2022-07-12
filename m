Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B129757146E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiGLIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiGLIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6296EA44CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657614122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4Tc5GZfUw4D2kbsJyhNpTBCyywZnC5Da4l8D/8G+TM=;
        b=DTAIxGjdkB9jEKRkp730B8Jg86FQ3sHbeVN8Efn3oXZjgipXfoVGiBTvTj4P/U+RYB82ZF
        7grrqH3J1p7NvvUqLiQtIsSsBBlJ5I6CDmw6Teyo0BGVM+gBF0hYmjaQt7s77mOYPdf1FA
        QzKhv4DottYl6xojACHva82WSVs/nR8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-bJn3s6YMPaaLfSwkCpynZQ-1; Tue, 12 Jul 2022 04:22:01 -0400
X-MC-Unique: bJn3s6YMPaaLfSwkCpynZQ-1
Received: by mail-lj1-f199.google.com with SMTP id bd19-20020a05651c169300b0025d47eb32cfso1297341ljb.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4Tc5GZfUw4D2kbsJyhNpTBCyywZnC5Da4l8D/8G+TM=;
        b=Ujs+kMOncfA5WyG1npBYTB8ISCRmrMfxXw9lnUfbz0TLa3L5Z5Vlu33sod74HnevUL
         OLRgTPLuoA28ExNrNJxbGBauq3APpvizr8GbHVcxPIUWfJGcwHYOD7F599pycoK5Jot0
         JUk3rahOCCWmxGg3/vtB2LkwxQFkRQxCgNFCLozGKsmoEo6++IOoxsz2a4JZFzz4EKoT
         CxQuYtOk0T963Xm/kTelTDXzU+EBBs8pbOtINDkMyjXVv67GCP2j0q7IflRBQ5G4sNN5
         nmgnQjV+yi0kbnzNUnYcKhFdPkVWhwmy51rxFQ3Lm5P3vz7K5zguY+NTenkikOTGYeTz
         5+Uw==
X-Gm-Message-State: AJIora/5ba8+Ra+0Kl8TS8IhwS3I3dUIklMmbZZT8pC5CXOCzPRBWj6E
        BukYvi0Zt+yOxGpPzQG7cn5OEKiKptisDQbAyrr5hfO24GUCtxmrTjR+TZcXdIvfve9A6dYkDgk
        oM6vhVTO9MZllsrR3W5ea8yNIHaNQw53UC+VhWMYb
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id w13-20020a0565120b0d00b004815cb4cf1emr13779021lfu.442.1657614119189;
        Tue, 12 Jul 2022 01:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOj+ef5swE9wPB6ChJ0xiKM//aXmndZoRzTQCLAkuCWCfc2xYD56u7wF39W+8YxaMtKhZQXrygCMgEI1OJDhw=
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr13779008lfu.442.1657614118901; Tue, 12
 Jul 2022 01:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s> <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
 <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
 <20220630152003-mutt-send-email-mst@kernel.org> <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
 <20220701021536-mutt-send-email-mst@kernel.org> <CACGkMEtkVmq2+NtDpp-XWZFD_WO6Dzm4=pcVwg-aKmStAqJCVg@mail.gmail.com>
 <66323a79-48a7-853e-1c44-9e62fcc5b775@foss.st.com> <CACGkMEt53Qd0m9sKjmPsHgBLWX=fkujD8hq6nNu3BSthAAGWwQ@mail.gmail.com>
 <dbca5ff7-d681-606e-7574-93280b981ccd@foss.st.com> <CACGkMEtOpG4LoNOVAfRkxziM-v09ZC=-Zn0O++8v_U66fNOp0g@mail.gmail.com>
 <b689cf7d-3429-324d-7544-63dcf8e5d57e@foss.st.com>
In-Reply-To: <b689cf7d-3429-324d-7544-63dcf8e5d57e@foss.st.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Jul 2022 16:21:47 +0800
Message-ID: <CACGkMEu5RybjwMG73iFUiKnGyqUE9aEMMgxdeCrjXe3Wf_c+ZQ@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-remoteproc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 4:01 PM Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
>
>
> On 7/8/22 08:19, Jason Wang wrote:
> > On Wed, Jul 6, 2022 at 2:57 PM Arnaud POULIQUEN
> > <arnaud.pouliquen@foss.st.com> wrote:
> >>
> >>
> >>
> >> On 7/6/22 06:03, Jason Wang wrote:
> >>> On Mon, Jul 4, 2022 at 5:45 PM Arnaud POULIQUEN
> >>> <arnaud.pouliquen@foss.st.com> wrote:
> >>>>
> >>>> Hello Jason,
> >>>>
> >>>> On 7/4/22 06:35, Jason Wang wrote:
> >>>>> On Fri, Jul 1, 2022 at 2:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>>>>
> >>>>>> On Fri, Jul 01, 2022 at 09:22:15AM +0800, Jason Wang wrote:
> >>>>>>> On Fri, Jul 1, 2022 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>>>>>>
> >>>>>>>> On Thu, Jun 30, 2022 at 11:51:30AM -0600, Mathieu Poirier wrote:
> >>>>>>>>> + virtualization@lists.linux-foundation.org
> >>>>>>>>> + jasowang@redhat.com
> >>>>>>>>> + mst@redhat.com
> >>>>>>>>>
> >>>>>>>>> On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
> >>>>>>>>> <arnaud.pouliquen@foss.st.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> On 6/29/22 19:43, Mathieu Poirier wrote:
> >>>>>>>>>>> Hi Anup,
> >>>>>>>>>>>
> >>>>>>>>>>> On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> >>>>>>>>>>>> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> >>>>>>>>>>>> fails due to both virtqueues (Rx and Tx) marked as broken by the
> >>>>>>>>>>>> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> >>>>>>>>>>>> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> >>>>>>>>>>>>
> >>>>>>>>>>>> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> >>>>>>>>>>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> >>>>>>>>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> >>>>>>>>>>>> index 905ac7910c98..71a64d2c7644 100644
> >>>>>>>>>>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> >>>>>>>>>>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> >>>>>>>>>>>> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>>>>>>>>>>>      /* and half is dedicated for TX */
> >>>>>>>>>>>>      vrp->sbufs = bufs_va + total_buf_space / 2;
> >>>>>>>>>>>>
> >>>>>>>>>>>> +    /* From this point on, we can notify and get callbacks. */
> >>>>>>>>>>>> +    virtio_device_ready(vdev);
> >>>>>>>>>>>> +
> >>>>>>>>>>>
> >>>>>>>>>>> Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> >>>>>>>>>>> potentially be called (by way of rpmsg_recv_done()), which will race with
> >>>>>>>>>>> virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> >>>>>>>>>>> rpmsg_recv_done() will fail, potentially breaking remote processors' state
> >>>>>>>>>>> machines that don't expect their initial name service to fail when the "device"
> >>>>>>>>>>> has been marked as ready.
> >>>>>>>>>>>
> >>>>>>>>>>> What does make me curious though is that nobody on the remoteproc mailing list
> >>>>>>>>>>> has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> >>>>>>>>>>> i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> >>>>>>>>>>> their rig?
> >>>>>>>>>>
> >>>>>>>>>> I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
> >>>>>>>>>> I confirm the issue!
> >>>>>>>>>>
> >>>>>>>>>> Concerning the solution, I share Mathieu's concern. This could break legacy.
> >>>>>>>>>> I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
> >>>>>>>>>>
> >>>>>>>>>> I this case the patch would be:
> >>>>>>>>>>
> >>>>>>>>>> +       /*
> >>>>>>>>>> +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
> >>>>>>>>>> +        * to ready
> >>>>>>>>>> +        */
> >>>>>>>>>> +       __virtio_unbreak_device(vdev);
> >>>>>>>>>> +
> >>>>>>>>>>
> >>>>>>>>>>         /* set up the receive buffers */
> >>>>>>>>>>         for (i = 0; i < vrp->num_bufs / 2; i++) {
> >>>>>>>>>>                 struct scatterlist sg;
> >>>>>>>>>>                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> >>>>>>>>>
> >>>>>>>>> This will indeed fix the problem.  On the flip side the kernel
> >>>>>>>>> documentation for __virtio_unbreak_device() puzzles me...
> >>>>>>>>> It clearly states that it should be used for probing and restoring but
> >>>>>>>>> _not_ directly by the driver.  Function rpmsg_probe() is part of
> >>>>>>>>> probing but also the entry point to a driver.
> >>>>>>>>>
> >>>>>>>>> Michael and virtualisation folks, is this the right way to move forward?
> >>>>>>>>
> >>>>>>>> I don't think it is, __virtio_unbreak_device is intended for core use.
> >>>>>>>
> >>>>>>> Can we fill the rx after virtio_device_ready() in this case?
> >>>>>>>
> >>>>>>> Btw, the driver set driver ok after registering, we probably get a svq
> >>>>>>> kick before DRIVER_OK?
> >>>>
> >>>> By "registering" you mean calling rpmsg_virtio_add_ctrl_dev and
> >>>> rpmsg_ns_register_device?
> >>>
> >>> Yes.
> >>>
> >>>>
> >>>> The rpmsg_ns_register_device has to be called before. Because it has to be
> >>>> probed to handle the first message coming from the remote side to create
> >>>> associated rpmsg local device.
> >>>
> >>> I couldn't find the code to do this, maybe you can give me some hint on this.
> >>
> >> The rpmsg_ns is available here :
> >> https://elixir.bootlin.com/linux/latest/source/drivers/rpmsg/rpmsg_ns.c
> >>
> >> It is probed on rpmsg_ns_register_device call.
> >> https://elixir.bootlin.com/linux/latest/source/drivers/rpmsg/virtio_rpmsg_bus.c#L974
> >
> > Yes but what I want to ask is, it looks to me
> > rpmsg_ns_register_device() only creates a rpmsg device. Do you mean
> > the rpmsg driver that will handle the first message during its probe?
>
> No it will be out of its probe, in its callback. the callback is called
> by the virtio-rpmsg based on the rpmsg receiver address.
>
> For the details:
> In rpmsg virtio implementation there is a mechanism to discover the
> RPMsg services supported by the remote processor: the name service
> announcement. For instance for the rpmsg_tty[1], the remote processor
> sends a rpmsg service announcement message indicating that it supports
> the "rpmsg-tty" service.
> On linux side the rpmsg_ns receives the message and creates a rpmsg
> channel that leads to a rpmsg_tty device creation on the rpmsg bus.
>
> If the rpmsg_ns is not registered (so no rpmsg receiver address
> registered), then when the "ns announcement" is received,the message
> is dropped, the service not initialized.
>
> [1]:https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/tty/rpmsg_tty.c

Thanks, so if I understand correctly, there could be a race between
the virtio_device_ready() and the name service:

If the announcement came before DRIVER_OK, it might be dropped by the device.

>
> >
> >>
> >>
> >>>
> >>>> It doesn't send message.
> >>>
> >>> I see the function register the device to the bus, I wonder if this
> >>> means the device could be probed and used by the driver before
> >>> virtio_device_ready().
> >>>
> >>>>
> >>>> The risk could be for the rpmsg_ctrl device. Registering it
> >>>> after the virtio_device_ready(vdev) call could make sense...
> >>>
> >>> I see.
> >>>
> >>>>
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>
> >>>>>> Is this an ack for the original patch?
> >>>>>
> >>>>> Nope, I meant, instead of moving virtio_device_ready() a little bit
> >>>>> earlier, can we only move the rvq filling after virtio_device_ready().
> >>>>>
> >>>>> Thanks
> >>>>
> >>>> Please find some concerns about this inversion here:
> >>>> https://lore.kernel.org/lkml/20220701053813-mutt-send-email-mst@kernel.org/
> >>>>
> >>>> Regarding __virtio_unbreak_device. The pending virtio_break_device is
> >>>> used by some virtio driver.
> >>>> Could we consider that it makes sense to also have a
> >>>> virtio_unbreak_device interface?
> >>>
> >>> We don't want to allow the driver to unbreak a device since it's
> >>> easier to have bugs.
> >>>
> >>>>
> >>>>
> >>>> I do not well understand the reason of the commit:
> >>>> 8b4ec69d7e09 ("virtio: harden vring IRQ", 2022-05-27)
> >>>
> >>> It tries to forbid the virtqueue callbacks to be called before
> >>> virtio_device_ready(). This helps to prevent the malicious device from
> >>> attacking the driver.
> >>>
> >>> But unfortunately, it breaks several driver because:
> >>>
> >>> 1) some driver have races in probe/remove
> >>> 2) it tries to reuse vq->broken which may break the driver that call
> >>> virqueue_add() before virtio_device_ready() which is allowed by the
> >>> spec
> >>>
> >>> There's a discussion to have a better behavior that doesn't break the
> >>> existing drivers. And the IRQ hardening feature is marked as broken
> >>> now, so rpmsg should be fine without any extra effort.
> >>
> >> Thanks for the explanations.
> >> If the discussions are in a mail thread could you give me the reference?
> >
> > Here're the discussions and commits:
> >
> > https://lore.kernel.org/lkml/20220622012940.21441-1-jasowang@redhat.com/
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=6a9720576cd00d30722c5f755bd17d4cfa9df636
>
> Thanks for the links!
> So no more update planed in drivers/rpmsg/virtio_rpmsg_bus.c, if i well understood...

Michael proposed to allow the callback after vq kick, I think the
rpmsg callback is ready before it kicks the device. If this is true,
no more updates.

But to be safe, I will cc you and all the other maintainers for the
patch of the above proposal.

Thanks

>
> Thanks,
> Arnaud
>
> >
> > Thanks
> >
> >>
> >> Thanks,
> >> Arnaud
> >>
> >>>
> >>>> So following alternative is probably pretty naive:
> >>>> Is the use of virtqueue_disable_cb could be an alternative to the
> >>>> vq->broken usage allowing to register buffer while preventing virtqueue IRQ?
> >>>
> >>> Probably not, there's no guarantee that the device will not send
> >>> notification after virqtueue_disable_cb().
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>> Thanks,
> >>>> Arnaud
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Regards,
> >>>>>>>>>> Arnaud
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks,
> >>>>>>>>>>> Mathieu
> >>>>>>>>>>>
> >>>>>>>>>>>>      /* set up the receive buffers */
> >>>>>>>>>>>>      for (i = 0; i < vrp->num_bufs / 2; i++) {
> >>>>>>>>>>>>              struct scatterlist sg;
> >>>>>>>>>>>> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>>>>>>>>>>>       */
> >>>>>>>>>>>>      notify = virtqueue_kick_prepare(vrp->rvq);
> >>>>>>>>>>>>
> >>>>>>>>>>>> -    /* From this point on, we can notify and get callbacks. */
> >>>>>>>>>>>> -    virtio_device_ready(vdev);
> >>>>>>>>>>>> -
> >>>>>>>>>>>>      /* tell the remote processor it can start sending messages */
> >>>>>>>>>>>>      /*
> >>>>>>>>>>>>       * this might be concurrent with callbacks, but we are only
> >>>>>>>>>>>> --
> >>>>>>>>>>>> 2.34.1
> >>>>>>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>

