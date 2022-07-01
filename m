Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCB562B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiGAGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiGAGQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D48BC248F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656656190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQcqzOck2DuwcNM73kgG2jczvXmy2C2LBERQCOmlyiI=;
        b=ivu/wGhpVeaWadxXGTBjwf4bUx+DyX/vpBj7aEw+u0tnAS8dGHYMSnT1MBrJZt/odr311T
        39q12inTFnTNyZQS5H3MPKP6Es8H67Dn2G+Y1KVC0/SW5y0mS9Rokch2n3g7KbxL7p068G
        dPGMue7PGxIaPOJU0INiBG9MbuAPoTc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-qnFKvaqKOuKkmwLLaSexqA-1; Fri, 01 Jul 2022 02:16:29 -0400
X-MC-Unique: qnFKvaqKOuKkmwLLaSexqA-1
Received: by mail-wm1-f71.google.com with SMTP id r132-20020a1c448a000000b003a02a3f0beeso2575165wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oQcqzOck2DuwcNM73kgG2jczvXmy2C2LBERQCOmlyiI=;
        b=uMOWa1jJba2UTOOhA0TXKgKeNu9QZITTrLQNFFSAoxEuPp9pVYe88VAWf0DWoVBAGa
         NYHI/hkk27UvawS/WxJIQ5AQ08LlGvS8yZPwPZIvf4fhpcyPe1N1aZdJlEmbIyPGuoYv
         Wjf3LgTGuBt1lNhb6VPnHzmIcfW1xxHcMr8auVUegxG4uNyAGrpuyBqJzORhmWe0elr/
         XcD+8T1RmbkwBGq7Pu/PIrfMGjooVZUZY6bQo792ia765gRng55enSYi4Z+2RFUeUyeq
         4P4CKEt8iJOnr5kz/XZXsUkyza91mK5el6IwOH6QTbgTKu8aC7TbBCLaa90wELBdO1R/
         8/GQ==
X-Gm-Message-State: AJIora/4SHNhzgibqoPW5JiYGFi77JIdSWb9Fz467rjcx49P8ub6/juu
        p/uO2BI97zWEAdFKgvFpRqBEd5uYOUEwLsk74riZNQ2xBGEnkDeTFTa+X+P14BAfvMAlRMk4vJL
        ybHoeSOtn8JljrPLJhKrnY/1r
X-Received: by 2002:a5d:66cc:0:b0:21b:8f5e:875b with SMTP id k12-20020a5d66cc000000b0021b8f5e875bmr12310695wrw.51.1656656186486;
        Thu, 30 Jun 2022 23:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sMilVx6tjb5laNf/Aur4jV+NAQ//xh8lkTlel5AbEo0b2M+156IA+k0C6GVkoRBrkTGbOFHg==
X-Received: by 2002:a5d:66cc:0:b0:21b:8f5e:875b with SMTP id k12-20020a5d66cc000000b0021b8f5e875bmr12310670wrw.51.1656656186220;
        Thu, 30 Jun 2022 23:16:26 -0700 (PDT)
Received: from redhat.com ([2.55.35.209])
        by smtp.gmail.com with ESMTPSA id c16-20020adfe750000000b002103a7c5c91sm20925668wrn.43.2022.06.30.23.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 23:16:25 -0700 (PDT)
Date:   Fri, 1 Jul 2022 02:16:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-remoteproc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Message-ID: <20220701021536-mutt-send-email-mst@kernel.org>
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s>
 <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
 <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
 <20220630152003-mutt-send-email-mst@kernel.org>
 <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 09:22:15AM +0800, Jason Wang wrote:
> On Fri, Jul 1, 2022 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 30, 2022 at 11:51:30AM -0600, Mathieu Poirier wrote:
> > > + virtualization@lists.linux-foundation.org
> > > + jasowang@redhat.com
> > > + mst@redhat.com
> > >
> > > On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
> > > <arnaud.pouliquen@foss.st.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 6/29/22 19:43, Mathieu Poirier wrote:
> > > > > Hi Anup,
> > > > >
> > > > > On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> > > > >> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> > > > >> fails due to both virtqueues (Rx and Tx) marked as broken by the
> > > > >> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> > > > >> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> > > > >>
> > > > >> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > > > >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > >> ---
> > > > >>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> > > > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >>
> > > > >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > >> index 905ac7910c98..71a64d2c7644 100644
> > > > >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > >> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > > >>      /* and half is dedicated for TX */
> > > > >>      vrp->sbufs = bufs_va + total_buf_space / 2;
> > > > >>
> > > > >> +    /* From this point on, we can notify and get callbacks. */
> > > > >> +    virtio_device_ready(vdev);
> > > > >> +
> > > > >
> > > > > Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> > > > > potentially be called (by way of rpmsg_recv_done()), which will race with
> > > > > virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> > > > > rpmsg_recv_done() will fail, potentially breaking remote processors' state
> > > > > machines that don't expect their initial name service to fail when the "device"
> > > > > has been marked as ready.
> > > > >
> > > > > What does make me curious though is that nobody on the remoteproc mailing list
> > > > > has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> > > > > i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> > > > > their rig?
> > > >
> > > > I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
> > > > I confirm the issue!
> > > >
> > > > Concerning the solution, I share Mathieu's concern. This could break legacy.
> > > > I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
> > > >
> > > > I this case the patch would be:
> > > >
> > > > +       /*
> > > > +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
> > > > +        * to ready
> > > > +        */
> > > > +       __virtio_unbreak_device(vdev);
> > > > +
> > > >
> > > >         /* set up the receive buffers */
> > > >         for (i = 0; i < vrp->num_bufs / 2; i++) {
> > > >                 struct scatterlist sg;
> > > >                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> > >
> > > This will indeed fix the problem.  On the flip side the kernel
> > > documentation for __virtio_unbreak_device() puzzles me...
> > > It clearly states that it should be used for probing and restoring but
> > > _not_ directly by the driver.  Function rpmsg_probe() is part of
> > > probing but also the entry point to a driver.
> > >
> > > Michael and virtualisation folks, is this the right way to move forward?
> >
> > I don't think it is, __virtio_unbreak_device is intended for core use.
> 
> Can we fill the rx after virtio_device_ready() in this case?
> 
> Btw, the driver set driver ok after registering, we probably get a svq
> kick before DRIVER_OK?
> 
> Thanks

Is this an ack for the original patch?

> >
> > > >
> > > > Regards,
> > > > Arnaud
> > > >
> > > > >
> > > > > Thanks,
> > > > > Mathieu
> > > > >
> > > > >>      /* set up the receive buffers */
> > > > >>      for (i = 0; i < vrp->num_bufs / 2; i++) {
> > > > >>              struct scatterlist sg;
> > > > >> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > > >>       */
> > > > >>      notify = virtqueue_kick_prepare(vrp->rvq);
> > > > >>
> > > > >> -    /* From this point on, we can notify and get callbacks. */
> > > > >> -    virtio_device_ready(vdev);
> > > > >> -
> > > > >>      /* tell the remote processor it can start sending messages */
> > > > >>      /*
> > > > >>       * this might be concurrent with callbacks, but we are only
> > > > >> --
> > > > >> 2.34.1
> > > > >>
> >

