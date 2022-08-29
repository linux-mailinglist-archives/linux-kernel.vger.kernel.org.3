Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C495A55FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiH2VSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2VSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:18:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3777FF9F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:17:59 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-33dc345ad78so227705057b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zLswp3FZG6XiSwB7qX17Z9zYqMeczVnBI6C7erx43GM=;
        b=BQj25WU3XNpieIsnWRjkaL3SGRbb30vf3H4zgu8tj+/t1SIArtdnPdxggSuEF6HICK
         6P+Pu4bFQNMJhiAKKqLzINTaQoKmaXD4k1+Gbnab+qpZXLGorfAPwfIa4qK/o1COB/wh
         RktqZxYdjf1c7t4PiuOit+ho6F+4xOW7L3BVLcvW1Vl+Ib4VFJUVDQqPmcmEGw1DVq81
         4W1tc/Lzx7lAYLOn7t5oqFqtzGw+1Kjbg31NNt/xNH1J10txy+c1ClGmVvqeGLMUMP40
         zSJ8yMTZp2dPxDHELYP+9knPXEfzG1hcHibcCGkjglRzn/xrlPzU4Pdy1SEqrFQvXrmk
         g+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zLswp3FZG6XiSwB7qX17Z9zYqMeczVnBI6C7erx43GM=;
        b=U9y0P6Sg4DsR2LY6Cx+wVltrgafcBKasOae14ct0igxEoX5Hj9QA+FD7JKtZ7sTUjY
         hZ08w8Rh4LikFzxMjBCcrTtgkAnBg+wJKxYDoqy0bcsmZiG7VcOEKu5TGGFQ7e5c7tuH
         hWI6RTYVsilNkFnPBDrewA6iK9shGxGrS4ddGeWh4tFl+RtfpRPxEFtdX+UZOUOPEERY
         9wszok3bBxWrSRlTzXu2drqzMGJSFpMWTne/OYx5zh83L889wBOAhbBOmrqBtA5gMpcX
         Bc8dz3UJHd8noV0/sNO/+Sbjm3hfr6QwRXsKu98mCkkzahkPVKS1rxbUl0AelAF4zsn3
         iKUA==
X-Gm-Message-State: ACgBeo1H5bRv5e+/T90Y4qif2H25I/Y7Fu9h4EOEHmkIdluIn9R3L47J
        iKEiao+7FQPIRTpNBUNEhlO7/WY0cA3rWP5otshq9A==
X-Google-Smtp-Source: AA6agR52oOxUaq0v+IaCSaYABR1QJsF2tncYM6x1EyKYEgwwnfx5yByF+Qv5OYLQ6XGhz+8uVtsESjISS7/ZzUhAY6U=
X-Received: by 2002:a81:6f43:0:b0:335:9e7e:ad25 with SMTP id
 k64-20020a816f43000000b003359e7ead25mr11761466ywc.518.1661807879019; Mon, 29
 Aug 2022 14:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220827101853.353-1-thunder.leizhen@huawei.com>
In-Reply-To: <20220827101853.353-1-thunder.leizhen@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Aug 2022 14:17:22 -0700
Message-ID: <CAGETcx9yXSsHZDQ4QOnVLbO3rZ1nQ0x=x5TeSQj6mpG05PmGcw@mail.gmail.com>
Subject: Re: [PATCH] ARM: 9220/1: amba: Add sanity check for dev->periphid in amba_probe()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Isaac Manjarres <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 3:21 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Commit f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> forcibly invokes device_add() even if dev->periphid is not ready. Although
> it will be remedied in amba_match(): dev->periphid will be initialized
> if everything is in place; Otherwise, return -EPROBE_DEFER to block
> __driver_attach() from further execution. But not all drivers have .match
> hook, such as pl031, the dev->bus->probe will be called directly in
> __driver_attach(). Unfortunately, if dev->periphid is still not
> initialized, the following exception will be triggered.
>
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [00000008] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc2+ #7
> Hardware name: ARM-Versatile Express
> PC is at pl031_probe+0x8/0x208
> LR is at amba_probe+0xf0/0x160
> pc : 80698df8  lr : 8050eb54  psr: 80000013
> sp : c0825df8  ip : 00000000  fp : 811fda38
> r10: 00000000  r9 : 80d72470  r8 : fffffdfb
> r7 : 811fd800  r6 : be7eb330  r5 : 00000000  r4 : 811fd900
> r3 : 80698df0  r2 : 37000000  r1 : 00000000  r0 : 811fd800
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6000406a  DAC: 00000051
> ... ...
>  pl031_probe from amba_probe+0xf0/0x160
>  amba_probe from really_probe+0x118/0x290
>  really_probe from __driver_probe_device+0x84/0xe4
>  __driver_probe_device from driver_probe_device+0x30/0xd0
>  driver_probe_device from __driver_attach+0x8c/0xfc
>  __driver_attach from bus_for_each_dev+0x70/0xb0
>  bus_for_each_dev from bus_add_driver+0x168/0x1f4
>  bus_add_driver from driver_register+0x7c/0x118
>  driver_register from do_one_initcall+0x44/0x1ec
>  do_one_initcall from kernel_init_freeable+0x238/0x288
>  kernel_init_freeable from kernel_init+0x18/0x12c
>  kernel_init from ret_from_fork+0x14/0x2c
> ... ...
> ---[ end trace 0000000000000000 ]---
>
> Therefore, take the same action as in amba_match(): return -EPROBE_DEFER
> if dev->periphid is not ready in amba_probe().
>
> Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
> KernelVersion: v6.0-rc2
>  drivers/amba/bus.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 32b0e0b930c1068..2e5572f60692a33 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -274,9 +274,17 @@ static int amba_probe(struct device *dev)
>  {
>         struct amba_device *pcdev = to_amba_device(dev);
>         struct amba_driver *pcdrv = to_amba_driver(dev->driver);
> -       const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
> +       const struct amba_id *id;
>         int ret;
>
> +       if (!pcdev->periphid) {
> +               ret = amba_read_periphid(pcdev);
> +               if (ret)
> +                       return -EPROBE_DEFER;
> +       }
> +
> +       id = amba_lookup(pcdrv->id_table, pcdev);
> +
>         do {
>                 ret = of_amba_device_decode_irq(pcdev);
>                 if (ret)

Cc: Isaac

Hi Zhen,

Thanks for the report and trying to fix it. I think your change is in
the right direction but there are a couple of issues that need to be
addressed.

Firstly, please make your change on top of [1] that fixes a race in my
patch. So, you'll need to use some locks here. Also, you'll need to do
the uevent update thing I do in amba_match() when you read the
periphid successfully for the first time.

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/20220818172852.3548-1-isaacmanjarres@google.com/
