Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F125A59B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiH3DGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiH3DGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:06:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635B871BC7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:06:11 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGsYH5VbXzkWnH;
        Tue, 30 Aug 2022 11:02:27 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 11:06:04 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 11:06:04 +0800
Subject: Re: [PATCH] ARM: 9220/1: amba: Add sanity check for dev->periphid in
 amba_probe()
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
References: <20220827101853.353-1-thunder.leizhen@huawei.com>
 <CACRpkdZC-GxhWN_+LpBg3W1xxR2YE6gknwroE3CWSGHeFSOfhQ@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <98beaa03-6eb5-c6e3-411d-7e76fb8f0936@huawei.com>
Date:   Tue, 30 Aug 2022 11:06:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZC-GxhWN_+LpBg3W1xxR2YE6gknwroE3CWSGHeFSOfhQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/30 5:00, Linus Walleij wrote:
> On Sat, Aug 27, 2022 at 12:22 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>> Commit f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
>> forcibly invokes device_add() even if dev->periphid is not ready. Although
>> it will be remedied in amba_match(): dev->periphid will be initialized
>> if everything is in place; Otherwise, return -EPROBE_DEFER to block
>> __driver_attach() from further execution. But not all drivers have .match
>> hook, such as pl031, the dev->bus->probe will be called directly in
>> __driver_attach(). Unfortunately, if dev->periphid is still not
>> initialized, the following exception will be triggered.
>>
>> 8<--- cut here ---
>> Unable to handle kernel NULL pointer dereference at virtual address 00000008
>> [00000008] *pgd=00000000
>> Internal error: Oops: 5 [#1] SMP ARM
>> Modules linked in:
>> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc2+ #7
>> Hardware name: ARM-Versatile Express
>> PC is at pl031_probe+0x8/0x208
>> LR is at amba_probe+0xf0/0x160
>> pc : 80698df8  lr : 8050eb54  psr: 80000013
>> sp : c0825df8  ip : 00000000  fp : 811fda38
>> r10: 00000000  r9 : 80d72470  r8 : fffffdfb
>> r7 : 811fd800  r6 : be7eb330  r5 : 00000000  r4 : 811fd900
>> r3 : 80698df0  r2 : 37000000  r1 : 00000000  r0 : 811fd800
>> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: 6000406a  DAC: 00000051
>> ... ...
>>  pl031_probe from amba_probe+0xf0/0x160
>>  amba_probe from really_probe+0x118/0x290
>>  really_probe from __driver_probe_device+0x84/0xe4
>>  __driver_probe_device from driver_probe_device+0x30/0xd0
>>  driver_probe_device from __driver_attach+0x8c/0xfc
>>  __driver_attach from bus_for_each_dev+0x70/0xb0
>>  bus_for_each_dev from bus_add_driver+0x168/0x1f4
>>  bus_add_driver from driver_register+0x7c/0x118
>>  driver_register from do_one_initcall+0x44/0x1ec
>>  do_one_initcall from kernel_init_freeable+0x238/0x288
>>  kernel_init_freeable from kernel_init+0x18/0x12c
>>  kernel_init from ret_from_fork+0x14/0x2c
>> ... ...
>> ---[ end trace 0000000000000000 ]---
>>
>> Therefore, take the same action as in amba_match(): return -EPROBE_DEFER
>> if dev->periphid is not ready in amba_probe().
>>
>> Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> For the record, this makes Vexpress QEMU boot again for me, so
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> The problem on QEMU is however not that the device is "not ready"
> the device is simply not there, the implementation in QEMU
> is incomplete. What platform are you getting this on? If it's QEMU
> you probably need to alter the commit message. I made this similar patch:

Also on QEMU. But your conclusion may be wrong, The problem on QEMU is really
because of pl031 is not ready. With my patch, pl031_probe() is called, so that
its ID is implemented on QEMU.

+++ b/drivers/base/driver.c
@@ -217,6 +217,9 @@ int driver_register(struct device_driver *drv)
 {
        int ret;
        struct device_driver *other;
+       static int seq;
+
+       printk("%d: drv=%s, bus=%s\n", ++seq, drv->name, drv->bus->name);

Add the above print, we can see:
50: drv=rtc-pl031, bus=amba
51: drv=vexpress-reset, bus=platform

I didn't go to further verify. I think the driver vexpress-reset makes the
clock available. After that, rtc-pl031's periphid can be read successfully.


> 
>>From 561e9c5a80183223613a2cfe225a900dd28c1cd5 Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Mon, 29 Aug 2022 22:26:11 +0200
> Subject: [PATCH] amba: Don't probe devices without valid match ID
> 
> After the recent changes to the AMBA bus core, QEMU Versatile
> Express (and probably other machines) refuse to boot properly
> in the v6.0-rc1 thru -rc3 kernels.
> 
> After enabling earlydebug this kind of stuff comes out:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [00000008] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1+ #474
> Hardware name: ARM-Versatile Express
> PC is at pl031_probe+0x18/0x224
> LR is at amba_probe+0xf0/0x174
> 
> This is because the AMBA driver probe call is called with an id
> argument that is NULL while drivers often directly dereference
> this ID to get to the match data.
> 
> This happens when an AMBA device exist in the device tree, but
> it is lacking any PrimceCell ID in hardware so there is no match
> data.
> 
> This happens most typically in QEMU which tries to mimic e.g.
> Versatile Express, but several PrimeCells that exist in the
> physical platform are not implemented or incomplete in the
> QEMU model so only zeroes are returned when reading the PrimeCell
> ID and thus there is no match data.
> 
> Fix this by not probing the device if there is no ID.
> 
> This print from QEMU after applying the patch shows clearly
> what blocks are missing from QEMU:
> 
> 1c0f0000.watchdog: no ID for device, skipping probe
>   (QEMU incomplete device?)
> 2b0a0000.memory-controller: no ID for device, skipping probe
>   (QEMU incomplete device?)
> 7ffd0000.memory-controller: no ID for device, skipping probe
>   (QEMU incomplete device?)
> 7ffb0000.dma: no ID for device, skipping probe
>   (QEMU incomplete device?)
> 
> Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: qemu-devel@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/amba/bus.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 32b0e0b930c1..6a1bffc60169 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -300,9 +300,14 @@ static int amba_probe(struct device *dev)
>          pm_runtime_set_active(dev);
>          pm_runtime_enable(dev);
> 
> -        ret = pcdrv->probe(pcdev, id);
> -        if (ret == 0)
> -            break;
> +        if (!id) {
> +            pr_err("%s: no ID for device, skipping probe (QEMU
> incomplete device?)\n",
> +                   dev_name(dev));
> +        } else {
> +            ret = pcdrv->probe(pcdev, id);
> +            if (ret == 0)
> +                break;
> +        }
> 
>          pm_runtime_disable(dev);
>          pm_runtime_set_suspended(dev);
> 

-- 
Regards,
  Zhen Lei
