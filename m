Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB05D561347
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiF3Hc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiF3Hc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:32:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA9F387B7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:32:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s1so25883488wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mo6WrAOjqsjetNkKTvO0A8p8xxil527ctc0OUGvOqd4=;
        b=dNpuPrNBikLG7s6tQlEUcKMRjDdb80pqMM1qQdjfbvvGIZtCauHvAha4UJrtVHhyEF
         HV1M+4/LJWn10Ud3PqlHIzmGTsfJCbhqbC8hfXb+joN8LQO2JOLpeIt5G1HA3yCh6sQh
         7OYdL0gBiKwUIiLt9YZ2eR9UCXVv17bJV0DPHpNgjrFUTWqSdfDrDDhKOTHaI2QbH+U5
         eiyo7BFf3eZ6p3bykAWFItcDhFEjJMdfFZv9ICH6GA2VJbaypIbaWSfgppOSvrNQ/BPZ
         xXLQSx7iTQ6HcwSLp2tQ28xikGKEtk0OaXCLe5prMnS+p2nYPLTDllwwzgQary1wNjXN
         oG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mo6WrAOjqsjetNkKTvO0A8p8xxil527ctc0OUGvOqd4=;
        b=JJzP4s0T9L7dma2JD0UbC4kHWMPk4VswHelyfo6PyrQ+SvId+tWncGSkunzVpybrU/
         gv1AYJSdhS4CwkDUS5alE7EQcDhwHfcSkZJ7rVyMa1Ocmbo8vMy+QwXLCFT6oGyCGh4B
         dMWjVYPL0jx3xuk7Tj7kpuyuglNh618kZkddfuGJJdAnAn8S/HmyhdtQ8ULsagIcZNhF
         53319VJ3uPdRjF4OsCu8FiHCSQIQ80zvh1fvw07sjoP2qF4Q0ec83TCnbG7k5hFWs9uO
         Dfk9nqbCzsEy/CwcHIElnxgLbET4+gvAd6sQ7teeY6ipRThFaEkLB+iE6gjUUtz8ixVc
         NpSw==
X-Gm-Message-State: AJIora8IiTMyXoaelcaCPGcOKEl1ibUIOHFHEcYrDVzQqS4JQgiE1Q+J
        9GYaPduo4GDZJkR9r7GSw8vJIcnrzFHNunICg/NaiQ==
X-Google-Smtp-Source: AGRyM1u9Do9XAM3ZhmgC1xJwCfmVluvgU1QIsZQU56HyFQb91+qPaseElYOENvSEi2uGEapY0VqnhGNwt2zin3lHr0k=
X-Received: by 2002:a5d:45c1:0:b0:21b:883e:6116 with SMTP id
 b1-20020a5d45c1000000b0021b883e6116mr6948488wrs.346.1656574344358; Thu, 30
 Jun 2022 00:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220608171334.730739-1-apatel@ventanamicro.com> <20220629174318.GB2018382@p14s>
In-Reply-To: <20220629174318.GB2018382@p14s>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 30 Jun 2022 13:01:32 +0530
Message-ID: <CAAhSdy2-TCURMiPR9eYML_WGzu1JZ32o0BqioKPTSRiw2KVFWw@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-remoteproc@vger.kernel.org,
        "open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" 
        <kvm-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Jun 29, 2022 at 11:13 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hi Anup,
>
> On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> > The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> > fails due to both virtqueues (Rx and Tx) marked as broken by the
> > __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> > (which unbreaks queues) should be called before virtqueue_add_inbuf().
> >
> > Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 905ac7910c98..71a64d2c7644 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >       /* and half is dedicated for TX */
> >       vrp->sbufs = bufs_va + total_buf_space / 2;
> >
> > +     /* From this point on, we can notify and get callbacks. */
> > +     virtio_device_ready(vdev);
> > +
>
> Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> potentially be called (by way of rpmsg_recv_done()), which will race with
> virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> rpmsg_recv_done() will fail, potentially breaking remote processors' state
> machines that don't expect their initial name service to fail when the "device"
> has been marked as ready.

We have VirtIO RPMSG available for Xvisor Guest/VM. When I run Linux-5.19-rcX
as Xvisor Guest/VM, I get following warning for every call to
virtqueue_add_inbuf():

[guest0/uart0] [    2.147931] ------------[ cut here ]------------
[guest0/uart0] [    2.166242] WARNING: CPU: 0 PID: 1 at
drivers/rpmsg/virtio_rpmsg_bus.c:941 rpmsg_probe+0x2e6/0x39e
[guest0/uart0] [    2.190337] Modules linked in:
[guest0/uart0] [    2.196514] CPU: 0 PID: 1 Comm: swapper/0 Not
tainted 5.19.0-rc4 #1
[guest0/uart0] [    2.222706] Hardware name: Virt64 (DT)
[guest0/uart0] [    2.231712] epc : rpmsg_probe+0x2e6/0x39e
[guest0/uart0] [    2.243443]  ra : rpmsg_probe+0x1f8/0x39e
[guest0/uart0] [    2.256899] epc : ffffffff804f7b2c ra :
ffffffff804f7a3e sp : ff2000000400b870
[guest0/uart0] [    2.277700]  gp : ffffffff810dc5b8 tp :
ff60000001258000 t0 : ff2000000400b888
[guest0/uart0] [    2.293144]  t1 : 0000000000000008 t2 :
0000000000000040 s0 : ff2000000400b910
[guest0/uart0] [    2.318932]  s1 : ff600000012cde00 a0 :
fffffffffffffffb a1 : ff2000000400b858
[guest0/uart0] [    2.339688]  a2 : 0000000000000001 a3 :
0000000000000000 a4 : 0000000000000001
[guest0/uart0] [    2.361387]  a5 : 0000000000000000 a6 :
0000000000000000 a7 : 0000000000000cc0
[guest0/uart0] [    2.396055]  s2 : ff60000003a00000 s3 :
0000000000000000 s4 : ff600000015ad428
[guest0/uart0] [    2.414673]  s5 : 0000000000000000 s6 :
0000000000000cc0 s7 : ff60000003a00000
[guest0/uart0] [    2.439996]  s8 : ffffffff80d91408 s9 :
0000000000040000 s10: ffffffff808000ac
[guest0/uart0] [    2.463539]  s11: 0000000000000000 t3 :
ff6000000fb4f000 t4 : ffffffffffffffff
[guest0/uart0] [    2.484201]  t5 : 0000000000000000 t6 : ff600000025a20c4
[guest0/uart0] [    2.500229] status: 0000000200000120 badaddr:
0000000000000000 cause: 0000000000000003
[guest0/uart0] [    2.522769] [<ffffffff80374032>] virtio_dev_probe+0x162/0x2e6
[guest0/uart0] [    2.544173] [<ffffffff803b57a8>]
really_probe.part.0+0x56/0x1ec
[guest0/uart0] [    2.574984] [<ffffffff803b59ae>]
__driver_probe_device+0x70/0xde
[guest0/uart0] [    2.596610] [<ffffffff803b5a48>] driver_probe_device+0x2c/0xb0
[guest0/uart0] [    2.612964] [<ffffffff803b5f70>]
__device_attach_driver+0x62/0x9a
[guest0/uart0] [    2.640715] [<ffffffff803b3b78>] bus_for_each_drv+0x4c/0x8a
[guest0/uart0] [    2.659895] [<ffffffff803b5c7a>] __device_attach+0x96/0x17a
[guest0/uart0] [    2.679809] [<ffffffff803b60be>] device_initial_probe+0xe/0x16
[guest0/uart0] [    2.696944] [<ffffffff803b4b80>] bus_probe_device+0x7c/0x82
[guest0/uart0] [    2.720666] [<ffffffff803b2aec>] device_add+0x2da/0x6be
[guest0/uart0] [    2.743288] [<ffffffff80373e4e>]
register_virtio_device+0x192/0x214
[guest0/uart0] [    2.765431] [<ffffffff80378048>] virtio_mmio_probe+0x134/0x1f2
[guest0/uart0] [    2.795974] [<ffffffff803b77f2>] platform_probe+0x4e/0x96
[guest0/uart0] [    2.816947] [<ffffffff803b57a8>]
really_probe.part.0+0x56/0x1ec
[guest0/uart0] [    2.832840] [<ffffffff803b59ae>]
__driver_probe_device+0x70/0xde
[guest0/uart0] [    2.854298] [<ffffffff803b5a48>] driver_probe_device+0x2c/0xb0
[guest0/uart0] [    2.874422] [<ffffffff803b6008>] __driver_attach+0x60/0x108
[guest0/uart0] [    2.897804] [<ffffffff803b3af2>] bus_for_each_dev+0x4a/0x84
[guest0/uart0] [    2.927286] [<ffffffff803b522e>] driver_attach+0x1a/0x22
[guest0/uart0] [    2.957400] [<ffffffff803b4d9e>] bus_add_driver+0x12c/0x196
[guest0/uart0] [    2.977573] [<ffffffff803b677a>] driver_register+0x48/0xdc
[guest0/uart0] [    3.001172] [<ffffffff803b7564>]
__platform_driver_register+0x1c/0x24
[guest0/uart0] [    3.028986] [<ffffffff8081c11c>] virtio_mmio_init+0x1a/0x22
[guest0/uart0] [    3.047038] [<ffffffff800020dc>] do_one_initcall+0x38/0x174
[guest0/uart0] [    3.071633] [<ffffffff80800fca>]
kernel_init_freeable+0x1a6/0x20a
[guest0/uart0] [    3.095840] [<ffffffff80652d04>] kernel_init+0x1e/0x10a
[guest0/uart0] [    3.120816] [<ffffffff800032dc>] ret_from_exception+0x0/0xc
[guest0/uart0] [    3.143400] ---[ end trace 0000000000000000 ]---

I am not claiming that this patch does the right thing but with this patch
VirtIO RPmsg starts working again for me on Xvisor Guest/VM.

Upon further investigation, it seems this warning is because of a recent kernel
commit mentioned in the "Fixes: " tag. Looks like with latest 5.19-rcX, we can't
call virtqueue_add_inbuf() until virtqueue is marked as unbroken by
virtio_device_ready().

Regards,
Anup

>
> What does make me curious though is that nobody on the remoteproc mailing list
> has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> their rig?
>
> Thanks,
> Mathieu
>
> >       /* set up the receive buffers */
> >       for (i = 0; i < vrp->num_bufs / 2; i++) {
> >               struct scatterlist sg;
> > @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >        */
> >       notify = virtqueue_kick_prepare(vrp->rvq);
> >
> > -     /* From this point on, we can notify and get callbacks. */
> > -     virtio_device_ready(vdev);
> > -
> >       /* tell the remote processor it can start sending messages */
> >       /*
> >        * this might be concurrent with callbacks, but we are only
> > --
> > 2.34.1
> >
