Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16CF562180
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiF3Rvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiF3Rvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:51:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3671620F56
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:51:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so40404928eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hzDZhLxqkjoUmpHgPZPyqLqi72LMmy86NXiSfNOEHI=;
        b=F8Cjja5cT4tDbmAw8yO3QwsVjn3U5AIlNrcWc6OtM6e0gLJFEnKHuuT7R5YfGTowVY
         amrK2aVIeQ96bz48a7d63KhOClgKnH8nY55IFRr9gDaX48onS8iO3ihFYArF26VagBum
         CutsvrRqQ1HM+puU3uFfMlsqmiofr3RISD4LRCDCumpmmJbe0RUnqZ2PvQzHI+IILwWQ
         ckHEaf+LfbYmL7SC5CXbzk3Rqr0EjRueDDPWfPgxFr4rhvsx5RJZrm5KfsCLVw0UrsSK
         Bvuf8zzJ4I8jYJrVG0IzFcW0F7U5j1b/Z2Q/nMdyjrMp56I7zN9GzqpWivrrMU/NrdUE
         WVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hzDZhLxqkjoUmpHgPZPyqLqi72LMmy86NXiSfNOEHI=;
        b=UPaXtmksvb3ozUBjQusDz7+a9m2Juq0uM2hqpK5ng+OSQRbHF+bszP650kTKQL9KQ/
         n4enkWDGYwV8oViAM5s6jzEw55ZaHaOxPQFcfURyMGllTrDm4n2WsNyrx5aRYAO/Vqgb
         pZ6lN3oJLfoJ6qwameVOaxhzX2vG0dH8Lnb/jMTmY3ppwo68GY6e9FbdFl2grqYW0SMg
         VUsk0onZ1ZJ+hdizVm0yzdry0TXx8sxrGUFxXtDH/JL6HP5uzMwBghkYAHHz0YUmmiSA
         +oHpMsLyhq7NQspC3Iq+9hRRDnLMw3AsCyrxAfnYdjVwMrfITM7DdSV3St+vjlSHg6iK
         eFmg==
X-Gm-Message-State: AJIora+pay5cqBpERrKlEbK3CxU0+irldxWuRHfMFiCN1kDtWnXpcRtX
        DJXL/uaajyF16S9EtJqw1qiN3FuJ9ibcjKZq6VzD2Q==
X-Google-Smtp-Source: AGRyM1vJ8TV2OXdZAUriH7ObJl5E2n4LqtDDTWaG7gCe8bjchWjq1OGKxTpoG4HS+yG6fpYXU5t9vL+J2C0Qzc4IdFY=
X-Received: by 2002:a17:906:488d:b0:726:2cdc:dc6c with SMTP id
 v13-20020a170906488d00b007262cdcdc6cmr9893945ejq.62.1656611502760; Thu, 30
 Jun 2022 10:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s> <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
In-Reply-To: <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 30 Jun 2022 11:51:30 -0600
Message-ID: <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-remoteproc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ virtualization@lists.linux-foundation.org
+ jasowang@redhat.com
+ mst@redhat.com

On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hi,
>
> On 6/29/22 19:43, Mathieu Poirier wrote:
> > Hi Anup,
> >
> > On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> >> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> >> fails due to both virtqueues (Rx and Tx) marked as broken by the
> >> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> >> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> >>
> >> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >> ---
> >>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> >> index 905ac7910c98..71a64d2c7644 100644
> >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> >> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>      /* and half is dedicated for TX */
> >>      vrp->sbufs = bufs_va + total_buf_space / 2;
> >>
> >> +    /* From this point on, we can notify and get callbacks. */
> >> +    virtio_device_ready(vdev);
> >> +
> >
> > Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> > potentially be called (by way of rpmsg_recv_done()), which will race with
> > virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> > rpmsg_recv_done() will fail, potentially breaking remote processors' state
> > machines that don't expect their initial name service to fail when the "device"
> > has been marked as ready.
> >
> > What does make me curious though is that nobody on the remoteproc mailing list
> > has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> > i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> > their rig?
>
> I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
> I confirm the issue!
>
> Concerning the solution, I share Mathieu's concern. This could break legacy.
> I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
>
> I this case the patch would be:
>
> +       /*
> +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
> +        * to ready
> +        */
> +       __virtio_unbreak_device(vdev);
> +
>
>         /* set up the receive buffers */
>         for (i = 0; i < vrp->num_bufs / 2; i++) {
>                 struct scatterlist sg;
>                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;

This will indeed fix the problem.  On the flip side the kernel
documentation for __virtio_unbreak_device() puzzles me...
It clearly states that it should be used for probing and restoring but
_not_ directly by the driver.  Function rpmsg_probe() is part of
probing but also the entry point to a driver.

Michael and virtualisation folks, is this the right way to move forward?

>
> Regards,
> Arnaud
>
> >
> > Thanks,
> > Mathieu
> >
> >>      /* set up the receive buffers */
> >>      for (i = 0; i < vrp->num_bufs / 2; i++) {
> >>              struct scatterlist sg;
> >> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>       */
> >>      notify = virtqueue_kick_prepare(vrp->rvq);
> >>
> >> -    /* From this point on, we can notify and get callbacks. */
> >> -    virtio_device_ready(vdev);
> >> -
> >>      /* tell the remote processor it can start sending messages */
> >>      /*
> >>       * this might be concurrent with callbacks, but we are only
> >> --
> >> 2.34.1
> >>
