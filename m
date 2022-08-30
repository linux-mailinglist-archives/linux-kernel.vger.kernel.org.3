Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0755A605D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiH3KMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiH3KLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:11:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D6EA885
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:35 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MH2xk49lDzHnVM;
        Tue, 30 Aug 2022 18:05:46 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 18:07:32 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 18:07:32 +0800
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in
 amba_probe()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <Yw3ddyxCpPH5U4kN@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4236a152-c848-a8f9-45db-4b6b7b4b586a@huawei.com>
Date:   Tue, 30 Aug 2022 18:07:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Yw3ddyxCpPH5U4kN@shell.armlinux.org.uk>
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



On 2022/8/30 17:50, Russell King (Oracle) wrote:
> Please don't send the patch system patches that have not had any chance
> of review. The patch system is supposed to be for patches that are to
> be applied.

Okay, I get it now.

> 
> Sending patches that are yet to be reviewed makes extra work for me.

I'm so sorry.

> 
> Thanks.
> 
> On Tue, Aug 30, 2022 at 02:54:13PM +0800, Zhen Lei wrote:
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
>> ---
>> KernelVersion: v6.0-rc3
>>  drivers/amba/bus.c | 24 +++++++++++++++++++++---
>>  1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> v1 --> v2:
>> 1. Update this patch based on:
>>    https://lore.kernel.org/lkml/20220818172852.3548-1-isaacmanjarres@google.com/
>> 2. Move the operations of sanity checking and reading dev->periphid,
>>    updating uevent into new function amba_prepare_periphid().
>>
>> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
>> index 110a535648d2e1f..8e4c7e190880206 100644
>> --- a/drivers/amba/bus.c
>> +++ b/drivers/amba/bus.c
>> @@ -204,10 +204,9 @@ static int amba_read_periphid(struct amba_device *dev)
>>  	return ret;
>>  }
>>  
>> -static int amba_match(struct device *dev, struct device_driver *drv)
>> +static int amba_prepare_periphid(struct device *dev)
>>  {
>>  	struct amba_device *pcdev = to_amba_device(dev);
>> -	struct amba_driver *pcdrv = to_amba_driver(drv);
>>  
>>  	mutex_lock(&pcdev->periphid_lock);
>>  	if (!pcdev->periphid) {
>> @@ -228,6 +227,19 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>>  	}
>>  	mutex_unlock(&pcdev->periphid_lock);
>>  
>> +	return 0;
>> +}
>> +
>> +static int amba_match(struct device *dev, struct device_driver *drv)
>> +{
>> +	struct amba_device *pcdev = to_amba_device(dev);
>> +	struct amba_driver *pcdrv = to_amba_driver(drv);
>> +	int ret;
>> +
>> +	ret = amba_prepare_periphid(dev);
>> +	if (ret)
>> +		return ret;
>> +
>>  	/* When driver_override is set, only bind to the matching driver */
>>  	if (pcdev->driver_override)
>>  		return !strcmp(pcdev->driver_override, drv->name);
>> @@ -278,9 +290,15 @@ static int amba_probe(struct device *dev)
>>  {
>>  	struct amba_device *pcdev = to_amba_device(dev);
>>  	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
>> -	const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
>> +	const struct amba_id *id;
>>  	int ret;
>>  
>> +	ret = amba_prepare_periphid(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	id = amba_lookup(pcdrv->id_table, pcdev);
>> +
>>  	do {
>>  		ret = of_amba_device_decode_irq(pcdev);
>>  		if (ret)
>> -- 
>> 2.25.1
>>
>>
> 

-- 
Regards,
  Zhen Lei
