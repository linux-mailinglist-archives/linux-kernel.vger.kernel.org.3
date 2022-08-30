Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51895A5CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiH3HUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiH3HUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:20:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460D65A14E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:20:37 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3321c2a8d4cso251932327b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qA4nFlapT5Cp3x59xqBr8L01v99UDre3YMqa7ZF5Ji4=;
        b=KcEMzYnNkv+u7eeHEAdUk0f0Swfw7hgrKVGXPIB+6PG8ZvlgopVG4eVxqBf7wlhcbf
         fUjWRyveweaKJJ9peHUloBI5d6HtHcDePx9uxOeZixT9TWLzRmn+9zT1PCWzpdf73SMn
         fGgE21r+pPugkzfgm+YjwvuMrPXD4DuSJeBT6NQsg5lCZjcehgstRX99EDWEsj+5NV0O
         L4XmCmN6pCF/TGmRM3a7z/KdH270claRx7XFR6d6c5aEczq6tx9jIYNjVikyRtcMi1C6
         ePilba+cZTxW6BWi7t68iSgBziPKCuqsE2n4fUnhAtyBj4U37DMw0FibrB0P1InqQwzs
         XyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qA4nFlapT5Cp3x59xqBr8L01v99UDre3YMqa7ZF5Ji4=;
        b=JrPY9wEXVKSReWhILt0IAXYJEtJzoL2of7sabErGoTfgU3a6rIEnp6UPx8EbZtaJB0
         uTeCdzmbDwUM6N/gAiIIZ8UVedUdxbNDo7AB6aiIbtXBfIQaq9uMiA71676zFAv1zKpD
         jMKf30EppdOUCA0ru1BmhWZH4RO2f9p75tJJE8IdkJCU1x0N16/PiDtpBCDDDu7+D0Kv
         0XNk6cXPzxCnAPFsTkeFafVghTadcuC+znitDKdafGuujNGilvoFdM5lfXarmePPbRg6
         6OHW+8amburH7PWxWvWsg0kWoK/INCAb9jMw+603eC4A5Yefot66bMB9eoWyD4r246Ic
         YqVg==
X-Gm-Message-State: ACgBeo3NBjz3D1LWde5VDP8f/IBWjUagA81gU7gAHtBazOnLPYeLXNtw
        SUQFI6eaUhT2qDKoDJId3kPBx+PX7146jAfJ7ppjBw==
X-Google-Smtp-Source: AA6agR6h3QjyxQT9HTWEYi2dapXCExpSGWtnAqbavvqdVNgWSL1YZTMQYx1ujl8429TYy7yP/EMb3funPPsBu0atDgE=
X-Received: by 2002:a25:a06:0:b0:695:8d8f:b5c3 with SMTP id
 6-20020a250a06000000b006958d8fb5c3mr11051969ybk.352.1661844036344; Tue, 30
 Aug 2022 00:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
In-Reply-To: <20220830065413.638-1-thunder.leizhen@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Aug 2022 00:20:00 -0700
Message-ID: <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in amba_probe()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
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

On Mon, Aug 29, 2022 at 11:59 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
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
> KernelVersion: v6.0-rc3
>  drivers/amba/bus.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> v1 --> v2:
> 1. Update this patch based on:
>    https://lore.kernel.org/lkml/20220818172852.3548-1-isaacmanjarres@google.com/
> 2. Move the operations of sanity checking and reading dev->periphid,
>    updating uevent into new function amba_prepare_periphid().
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 110a535648d2e1f..8e4c7e190880206 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -204,10 +204,9 @@ static int amba_read_periphid(struct amba_device *dev)
>         return ret;
>  }
>
> -static int amba_match(struct device *dev, struct device_driver *drv)
> +static int amba_prepare_periphid(struct device *dev)
>  {
>         struct amba_device *pcdev = to_amba_device(dev);
> -       struct amba_driver *pcdrv = to_amba_driver(drv);
>
>         mutex_lock(&pcdev->periphid_lock);
>         if (!pcdev->periphid) {
> @@ -228,6 +227,19 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>         }
>         mutex_unlock(&pcdev->periphid_lock);
>
> +       return 0;
> +}
> +
> +static int amba_match(struct device *dev, struct device_driver *drv)
> +{
> +       struct amba_device *pcdev = to_amba_device(dev);
> +       struct amba_driver *pcdrv = to_amba_driver(drv);
> +       int ret;
> +
> +       ret = amba_prepare_periphid(dev);
> +       if (ret)
> +               return ret;
> +
>         /* When driver_override is set, only bind to the matching driver */
>         if (pcdev->driver_override)
>                 return !strcmp(pcdev->driver_override, drv->name);
> @@ -278,9 +290,15 @@ static int amba_probe(struct device *dev)
>  {
>         struct amba_device *pcdev = to_amba_device(dev);
>         struct amba_driver *pcdrv = to_amba_driver(dev->driver);
> -       const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
> +       const struct amba_id *id;
>         int ret;
>
> +       ret = amba_prepare_periphid(dev);
> +       if (ret)
> +               return ret;
> +
> +       id = amba_lookup(pcdrv->id_table, pcdev);
> +
>         do {
>                 ret = of_amba_device_decode_irq(pcdev);
>                 if (ret)

Let's wait for Isaac to review this. He has been looking at the
locking issue for a bit and there were some tricky cases.

-Saravana
