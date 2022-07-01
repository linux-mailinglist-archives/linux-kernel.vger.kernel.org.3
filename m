Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77159562819
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 03:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiGABWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 21:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiGABWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F4955A2CB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656638550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2KH53Wl1gr5UMbynLfVT+FjBM4ZDGlsSeHT6iWm6OnU=;
        b=bRdviL9TDbL6BeBKnbyhb4tpyRgCxiQEsZFnuxvVhybI3jLOmm2/RfRiESovHgHV8d99Ie
        AuQBHX29ZIBCI3Pc+q3jfZZ2qtailWwSYwtYO8PHjiUlCuzEE8CbYocdSDUhh+Iae6V7Cb
        tAJslrD1FVh5Ps/LLmhzv4kS/WLxlTc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-GyrQLR1-PyaZrSSfoBcrlw-1; Thu, 30 Jun 2022 21:22:28 -0400
X-MC-Unique: GyrQLR1-PyaZrSSfoBcrlw-1
Received: by mail-lf1-f69.google.com with SMTP id p2-20020a05651212c200b004814102d512so391391lfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KH53Wl1gr5UMbynLfVT+FjBM4ZDGlsSeHT6iWm6OnU=;
        b=L9FrRwWD1l+zTKYF4tQ4yNzQkM3LL0rS3CIlcD0CseYT1uZtVTmF3EtfFEReuinDz1
         sJXWU5oRgn6yq2ymFPnUEc2WjiajO1zXeUOYCKEJ/XjbN33+qI4RvtTVSPsvzsrmtLTi
         tYMFscpjNNr3jxU/D1MueUtNsDKsqi0iCpnzue/gLqEqQn6peZTPOhMXTQ6sxlrjLVTn
         Miuw5zHy//dYSh+rupcJniaG03CheG3789Fw/+G/WRgaK2+GwkGaYh5M5m04C1Wbf+xI
         imO6MueciNNREM6uVwzDXgND/G2lJWRn1KZooVA+ULB9Md02gcVZv8eaYqYxHhdsRLPo
         d0Aw==
X-Gm-Message-State: AJIora+tbwIV9tRIbLEW7zyd9E78Br+kG2/KAX1vZK7Xyofi9DWJSIQx
        s+BoiWUjHoc6n4wz+lj7x07I1rCwy522J5Kch3BHVmdBAxdbSbGU3+FAGFee1xfMOcdQvKqgEh0
        1aUzeC585NL81dg6r9VFOB3lzoRGxq6/w3E+mGk1g
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id g3-20020a05651222c300b0047f704b3820mr7390619lfu.411.1656638546133;
        Thu, 30 Jun 2022 18:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vr8HxTtR3VyCNAME9Etu0HGTUwoK8NFuuJdU03zhtIJfCQW8P7Cfwl91EkAy5W/C6W4aZiLeDVgXy6h3cd8Cw=
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7390605lfu.411.1656638545914; Thu, 30
 Jun 2022 18:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s> <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
 <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com> <20220630152003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220630152003-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 1 Jul 2022 09:22:15 +0800
Message-ID: <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 30, 2022 at 11:51:30AM -0600, Mathieu Poirier wrote:
> > + virtualization@lists.linux-foundation.org
> > + jasowang@redhat.com
> > + mst@redhat.com
> >
> > On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
> > <arnaud.pouliquen@foss.st.com> wrote:
> > >
> > > Hi,
> > >
> > > On 6/29/22 19:43, Mathieu Poirier wrote:
> > > > Hi Anup,
> > > >
> > > > On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> > > >> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> > > >> fails due to both virtqueues (Rx and Tx) marked as broken by the
> > > >> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> > > >> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> > > >>
> > > >> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > > >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > >> ---
> > > >>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> > > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >>
> > > >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > >> index 905ac7910c98..71a64d2c7644 100644
> > > >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > >> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > >>      /* and half is dedicated for TX */
> > > >>      vrp->sbufs = bufs_va + total_buf_space / 2;
> > > >>
> > > >> +    /* From this point on, we can notify and get callbacks. */
> > > >> +    virtio_device_ready(vdev);
> > > >> +
> > > >
> > > > Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> > > > potentially be called (by way of rpmsg_recv_done()), which will race with
> > > > virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> > > > rpmsg_recv_done() will fail, potentially breaking remote processors' state
> > > > machines that don't expect their initial name service to fail when the "device"
> > > > has been marked as ready.
> > > >
> > > > What does make me curious though is that nobody on the remoteproc mailing list
> > > > has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> > > > i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> > > > their rig?
> > >
> > > I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
> > > I confirm the issue!
> > >
> > > Concerning the solution, I share Mathieu's concern. This could break legacy.
> > > I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
> > >
> > > I this case the patch would be:
> > >
> > > +       /*
> > > +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
> > > +        * to ready
> > > +        */
> > > +       __virtio_unbreak_device(vdev);
> > > +
> > >
> > >         /* set up the receive buffers */
> > >         for (i = 0; i < vrp->num_bufs / 2; i++) {
> > >                 struct scatterlist sg;
> > >                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> >
> > This will indeed fix the problem.  On the flip side the kernel
> > documentation for __virtio_unbreak_device() puzzles me...
> > It clearly states that it should be used for probing and restoring but
> > _not_ directly by the driver.  Function rpmsg_probe() is part of
> > probing but also the entry point to a driver.
> >
> > Michael and virtualisation folks, is this the right way to move forward?
>
> I don't think it is, __virtio_unbreak_device is intended for core use.

Can we fill the rx after virtio_device_ready() in this case?

Btw, the driver set driver ok after registering, we probably get a svq
kick before DRIVER_OK?

Thanks

>
> > >
> > > Regards,
> > > Arnaud
> > >
> > > >
> > > > Thanks,
> > > > Mathieu
> > > >
> > > >>      /* set up the receive buffers */
> > > >>      for (i = 0; i < vrp->num_bufs / 2; i++) {
> > > >>              struct scatterlist sg;
> > > >> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > >>       */
> > > >>      notify = virtqueue_kick_prepare(vrp->rvq);
> > > >>
> > > >> -    /* From this point on, we can notify and get callbacks. */
> > > >> -    virtio_device_ready(vdev);
> > > >> -
> > > >>      /* tell the remote processor it can start sending messages */
> > > >>      /*
> > > >>       * this might be concurrent with callbacks, but we are only
> > > >> --
> > > >> 2.34.1
> > > >>
>

