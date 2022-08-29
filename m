Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268B15A55D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiH2VAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2VAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:00:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046779ED3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:00:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lx1so18109673ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T3FCG6OZIdEzfz04KlRaEg8Amkz+JcWLstgDrvHpwME=;
        b=ZLYI9Gd5BOrUZq0PPz+sgvHlhfBMWawbb+7634K/WZXPpBEw3fY72i1hW/P4ofBp7G
         HGt0QPaVolqjBtwKQzyjOeywpEqGRCVD4hwkAZBTiA3AXv8v5pqpgkiSXzM77X1pkWxZ
         OHyHxVF9MUDseXvUzXWg//74gNkbq/pMPpC97/y1SyxDcIAo0nR+iUHj0CMLsD9GyQiK
         zHDWe2iIzhwwUJ14wWltxiuLXzbgEUjblBdaQS9YzdDPI4Yw3MlS4I5w2YE3mON0QK09
         HPiquMfDAzTcmEO2cyS8hlnWYbeT+ogrFepvVuWaA1eealEoN21PyL5oF3cEJ4gVpcWE
         ZN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T3FCG6OZIdEzfz04KlRaEg8Amkz+JcWLstgDrvHpwME=;
        b=Opozp2hiodNiSUpwZB9sSbL6IIqM/h+nyBJOA5NkT1KaujuBavEkUIoFYvinZRL9SA
         7BFYEUIQBrBWUnbMiXnhdX2gnP1ILpFpv0un6aNTK6DBVaOT4GL5oAsxJqz5bwujfr6j
         /eCHmGu+dcunwKXlfI6zTnvaYG2vaUVEQZSBFbS9c5QtIO8HEJ/mcoRQO8oA9DKXUSDS
         vb1Gb7VAYJPT/nOp9dUFoiEDBRgwVWjgGmQXdRu1DyoFuF6UsnzAIZ0e1xe04ALjIa6g
         lRWCzp7WI/uTErCVH/rNtdU+tHc6CynbRjgR28kcNkNgEaH7zZikVa0uxJbltCe+ywDf
         DJDQ==
X-Gm-Message-State: ACgBeo2epskdn52IXJ2ETVxdBftIlSZptbOBmR30ZjgMIkqnM6vZep0Y
        J5iHXAQ5O1i+roBuZ1EE1KR+r8NhyDP5DQbkvQNsqQ==
X-Google-Smtp-Source: AA6agR6UIg91RvB396TMlRzBLXiZXtVcFcGg7u/wtPMTFriEn1DH1iK75cGieRkQVuC5uFBE90eRRghRqiK/ZVoh6zU=
X-Received: by 2002:a17:907:2707:b0:741:7c18:4e76 with SMTP id
 w7-20020a170907270700b007417c184e76mr5051418ejk.690.1661806835679; Mon, 29
 Aug 2022 14:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220827101853.353-1-thunder.leizhen@huawei.com>
In-Reply-To: <20220827101853.353-1-thunder.leizhen@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Aug 2022 23:00:24 +0200
Message-ID: <CACRpkdZC-GxhWN_+LpBg3W1xxR2YE6gknwroE3CWSGHeFSOfhQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: 9220/1: amba: Add sanity check for dev->periphid in amba_probe()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Saravana Kannan <saravanak@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
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

On Sat, Aug 27, 2022 at 12:22 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:

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

For the record, this makes Vexpress QEMU boot again for me, so
Tested-by: Linus Walleij <linus.walleij@linaro.org>

The problem on QEMU is however not that the device is "not ready"
the device is simply not there, the implementation in QEMU
is incomplete. What platform are you getting this on? If it's QEMU
you probably need to alter the commit message. I made this similar patch:

From 561e9c5a80183223613a2cfe225a900dd28c1cd5 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Aug 2022 22:26:11 +0200
Subject: [PATCH] amba: Don't probe devices without valid match ID

After the recent changes to the AMBA bus core, QEMU Versatile
Express (and probably other machines) refuse to boot properly
in the v6.0-rc1 thru -rc3 kernels.

After enabling earlydebug this kind of stuff comes out:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
[00000008] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1+ #474
Hardware name: ARM-Versatile Express
PC is at pl031_probe+0x18/0x224
LR is at amba_probe+0xf0/0x174

This is because the AMBA driver probe call is called with an id
argument that is NULL while drivers often directly dereference
this ID to get to the match data.

This happens when an AMBA device exist in the device tree, but
it is lacking any PrimceCell ID in hardware so there is no match
data.

This happens most typically in QEMU which tries to mimic e.g.
Versatile Express, but several PrimeCells that exist in the
physical platform are not implemented or incomplete in the
QEMU model so only zeroes are returned when reading the PrimeCell
ID and thus there is no match data.

Fix this by not probing the device if there is no ID.

This print from QEMU after applying the patch shows clearly
what blocks are missing from QEMU:

1c0f0000.watchdog: no ID for device, skipping probe
  (QEMU incomplete device?)
2b0a0000.memory-controller: no ID for device, skipping probe
  (QEMU incomplete device?)
7ffd0000.memory-controller: no ID for device, skipping probe
  (QEMU incomplete device?)
7ffb0000.dma: no ID for device, skipping probe
  (QEMU incomplete device?)

Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
Cc: Saravana Kannan <saravanak@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/amba/bus.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 32b0e0b930c1..6a1bffc60169 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -300,9 +300,14 @@ static int amba_probe(struct device *dev)
         pm_runtime_set_active(dev);
         pm_runtime_enable(dev);

-        ret = pcdrv->probe(pcdev, id);
-        if (ret == 0)
-            break;
+        if (!id) {
+            pr_err("%s: no ID for device, skipping probe (QEMU
incomplete device?)\n",
+                   dev_name(dev));
+        } else {
+            ret = pcdrv->probe(pcdev, id);
+            if (ret == 0)
+                break;
+        }

         pm_runtime_disable(dev);
         pm_runtime_set_suspended(dev);
-- 
2.37.2

Yours,
Linus Walleij
