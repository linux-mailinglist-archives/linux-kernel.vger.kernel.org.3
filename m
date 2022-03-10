Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD24D4101
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiCJGNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiCJGND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:13:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C31BABA3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:12:02 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KDdrH0LGhz1GCCR;
        Thu, 10 Mar 2022 14:07:11 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 14:12:00 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Mar
 2022 14:12:00 +0800
Subject: Re: [PATCH] genirq/msi: Shutdown managed interrupts with unsatifiable
 affinities
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        David Decotigny <ddecotig@google.com>
References: <20220307190625.254426-1-maz@kernel.org>
 <70b15802-b8b1-301e-00f2-39e299114b02@huawei.com>
 <24325714-8d2b-3818-9300-d61a2870405f@huawei.com>
Message-ID: <32633c5f-abbb-0946-3519-e0f9759971f7@huawei.com>
Date:   Thu, 10 Mar 2022 14:11:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24325714-8d2b-3818-9300-d61a2870405f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/10 11:24, Xiongfeng Wang wrote:
> 
> 
> On 2022/3/9 18:20, John Garry wrote:
>> +
>>
>> On 07/03/2022 19:06, Marc Zyngier wrote:
>>> When booting with maxcpus=<small number>, interrupt controllers
>>> such as the GICv3 ITS may not be able to satisfy the affinity of
>>> some managed interrupts, as some of the HW resources are simply
>>> not available.
>>>
>>> In order to deal with this, do not try to activate such interrupt
>>> if there is no online CPU capable of handling it. Instead, place
>>> it in shutdown state. Once a capable CPU shows up, it will be
>>> activated.
>>>
>>> Reported-by: John Garry <john.garry@huawei.com>
>>> Reported-by: David Decotigny <ddecotig@google.com>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>
>> Tested-by: John Garry <john.garry@huawei.com>
>>
>>> ---
>>
>> JFYI, I could not recreate the same crash reported in the original thread for
>> "nohz_full=5-127 isolcpus=nohz,domain,managed_irq,5-127 maxcpus=1". Here's just
>> showing what I set via cmdline:
> 
> I think it's the userspace online all the CPUs that cause the crash. Could you
> please try to online all the CPUs after boot.

Sorry, please ignore what I said above. It's wrong.

This patch has no issues. When I test the managed irq, I apply this patch and
the following modification. It is the following modification and the kernel
parameters that cause the crash. This patch has no problems. Sorry for the
unclear discription before.

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index eb0882d15366..0cea46bdaf99 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1620,7 +1620,7 @@ static int its_select_cpu(struct irq_data *d,

 		cpu = cpumask_pick_least_loaded(d, tmpmask);
 	} else {
-		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+		cpumask_copy(tmpmask, aff_mask);

 		/* If we cannot cross sockets, limit the search to that node */
 		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&

Thanks,
Xiongfeng

> 
> Thanks,
> Xiongfeng
> 
>>
>> estuary:/$ dmesg | grep -i hz
>> [    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init
>> console=ttyS0,115200 no_console_suspend nvme.use_threaded_interrupts=0
>> iommu.strict=0 acpi=force earlycon=pl011,mmio32,0x602b0000 nohz_full=5-127
>> isolcpus=nohz,domain,managed_irq,5-127 maxcpus=1
>> [    0.000000] NO_HZ: Full dynticks CPUs: 5-127.
>> [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
>> [    0.000000] sched_clock: 57 bits at 100MHz, resolution 10ns, wraps every
>> 4398046511100ns
>> [   15.314258] sbsa-gwdt sbsa-gwdt.0: Initialized with 10s timeout @ 100000000
>> Hz, action=0
>>
>> And for the kernel build:
>> $ more .config | grep NO_HZ
>> CONFIG_NO_HZ_COMMON=y
>> # CONFIG_NO_HZ_IDLE is not set
>> CONFIG_NO_HZ_FULL=y
>> # CONFIG_NO_HZ is not set
>> $
>>
>> Thanks,
>> John
>>>   kernel/irq/msi.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>>> index 2bdfce5edafd..aa84ce84c2ec 100644
>>> --- a/kernel/irq/msi.c
>>> +++ b/kernel/irq/msi.c
>>> @@ -818,6 +818,18 @@ static int msi_init_virq(struct irq_domain *domain, int
>>> virq, unsigned int vflag
>>>           irqd_clr_can_reserve(irqd);
>>>           if (vflags & VIRQ_NOMASK_QUIRK)
>>>               irqd_set_msi_nomask_quirk(irqd);
>>> +
>>> +        /*
>>> +         * If the interrupt is managed but no CPU is available
>>> +         * to service it, shut it down until better times.
>>> +         */
>>> +        if ((vflags & VIRQ_ACTIVATE) &&
>>> +            irqd_affinity_is_managed(irqd) &&
>>> +            !cpumask_intersects(irq_data_get_affinity_mask(irqd),
>>> +                    cpu_online_mask)) {
>>> +                irqd_set_managed_shutdown(irqd);
>>> +                return 0;
>>> +            }
>>>       }
>>>         if (!(vflags & VIRQ_ACTIVATE))
>>
>> .
> .
> 
