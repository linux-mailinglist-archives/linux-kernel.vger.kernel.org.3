Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0508F4D3F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiCJDVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiCJDVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:21:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEAD11AA32
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:19:59 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KDZ33600Zz9sZl;
        Thu, 10 Mar 2022 11:16:15 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 11:19:54 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Mar
 2022 11:19:53 +0800
Subject: Re: PCI MSI issue for maxcpus=1
To:     Marc Zyngier <maz@kernel.org>
CC:     John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        "David Decotigny" <decot@google.com>
References: <78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com>
 <87a6g8vp8k.wl-maz@kernel.org>
 <19d55cdf-9ef7-e4a3-5ae5-0970f0d7751b@huawei.com>
 <87v8yjyjc0.wl-maz@kernel.org> <87k0ey9122.wl-maz@kernel.org>
 <5f529b4e-1f6c-5a7d-236c-09ebe3a7db29@huawei.com>
 <1cbe7daa-8003-562b-06fa-5a50f7ee6ed2@huawei.com>
 <87a6e4tnkm.wl-maz@kernel.org>
 <452d97ed-459f-7936-99e4-600380608615@huawei.com>
 <645767eb-c5a5-cafa-eb1e-b8d999484ea8@huawei.com>
 <87zgm0zfw7.wl-maz@kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <b4a98c83-08fb-864d-2458-427318960e78@huawei.com>
Date:   Thu, 10 Mar 2022 11:19:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87zgm0zfw7.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Hi,

On 2022/3/8 22:18, Marc Zyngier wrote:
> On Tue, 08 Mar 2022 03:57:33 +0000,
> Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>>
>> Hi,
>>
>> On 2022/3/7 21:48, John Garry wrote:
>>> Hi Marc,
>>>
>>>>
>>>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>>>> index 2bdfce5edafd..97e9eb9aecc6 100644
>>>> --- a/kernel/irq/msi.c
>>>> +++ b/kernel/irq/msi.c
>>>> @@ -823,6 +823,19 @@ static int msi_init_virq(struct irq_domain *domain, int
>>>> virq, unsigned int vflag
>>>>       if (!(vflags & VIRQ_ACTIVATE))
>>>>           return 0;
>>>>   +    if (!(vflags & VIRQ_CAN_RESERVE)) {
>>>> +        /*
>>>> +         * If the interrupt is managed but no CPU is available
>>>> +         * to service it, shut it down until better times.
>>>> +         */
>>>> +        if (irqd_affinity_is_managed(irqd) &&
>>>> +            !cpumask_intersects(irq_data_get_affinity_mask(irqd),
>>>> +                    cpu_online_mask)) {
>>>> +            irqd_set_managed_shutdown(irqd);
>>>> +            return 0;
>>>> +        }
>>>> +    }
>>>> +
>>>>       ret = irq_domain_activate_irq(irqd, vflags & VIRQ_CAN_RESERVE);
>>>>       if (ret)
>>>>           return ret;
>>>>
>>
>> I applied the above modification and add kernel parameter 'maxcpus=1'. It can
>> boot successfully on D06.
>>
>> Then I remove 'maxcpus=1' and add 'nohz_full=5-127
>> isolcpus=nohz,domain,managed_irq,5-127'. The 'effective_affinity' of the kernel
>> managed irq is not correct.
>> [root@localhost wxf]# cat /proc/interrupts | grep 350
>> 350:          0          0          0          0          0        522
>> (ignored info)
>> 0          0                  0   ITS-MSI 60882972 Edge      hisi_sas_v3_hw cq
>> [root@localhost wxf]# cat /proc/irq/350/smp_affinity
>> 00000000,00000000,00000000,000000ff
>> [root@localhost wxf]# cat /proc/irq/350/effective_affinity
>> 00000000,00000000,00000000,00000020
>>
>> Then I apply the following modification.
>> Refer to https://lore.kernel.org/all/87a6fl8jgb.wl-maz@kernel.org/
>> The 'effective_affinity' is correct now.
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index eb0882d15366..0cea46bdaf99 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1620,7 +1620,7 @@ static int its_select_cpu(struct irq_data *d,
>>
>>  		cpu = cpumask_pick_least_loaded(d, tmpmask);
>>  	} else {
>> -		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
>> +		cpumask_copy(tmpmask, aff_mask);
>>
>>  		/* If we cannot cross sockets, limit the search to that node */
>>  		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
>>
>> Then I add both kernel parameters.
>> nohz_full=1-127 isolcpus=nohz,domain,managed_irq,1-127 maxcpus=1
>> It crashed with the following message.
>> [   51.813803][T21132] cma_alloc: 29 callbacks suppressed
>> [   51.813809][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 4
>> pages, ret: -12
>> [   51.897537][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 8
>> pages, ret: -12
>> [   52.014432][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 4
>> pages, ret: -12
>> [   52.067313][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 8
>> pages, ret: -12
>> [   52.180011][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 4
>> pages, ret: -12
>> [   52.270846][    T0] Detected VIPT I-cache on CPU1
>> [   52.275541][    T0] GICv3: CPU1: found redistributor 80100 region
>> 1:0x00000000ae140000
>> [   52.283425][    T0] GICv3: CPU1: using allocated LPI pending table
>> @0x00000040808b0000
>> [   52.291381][    T0] CPU1: Booted secondary processor 0x0000080100 [0x481fd010]
>> [   52.432971][    T0] Detected VIPT I-cache on CPU101
>> [   52.437914][    T0] GICv3: CPU101: found redistributor 390100 region
>> 101:0x00002000aa240000
>> [   52.446233][    T0] GICv3: CPU101: using allocated LPI pending table
>> @0x0000004081170000
>> [   52.ULL pointer dereference at virtual address 00000000000000a0
> 
> This is pretty odd. If you passed maxcpus=1, how comes CPU1 and 101
> are booting right from the beginning? Or is it userspace doing that?

Yes, it is the userspace will online all the CPUs.

> 
>> [   52.471539][T24563] Mem abort info:
>> [   52.475011][T24563]   ESR = 0x96000044
>> [   52.478742][T24563]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   52.484721][T24563]   SET = 0, FnV = 0
>> [   52.488451][T24563]   EA = 0, S1PTW = 0
>> [   52.492269][T24563]   FSC = 0x04: level 0 translation fault
>> [   52.497815][T24563] Data abort info:
>> [   52.501374][T24563]   ISV = 0, ISS = 0x00000044
>> [   52.505884][T24563]   CM = 0, WnR = 1
>> [   52.509530][T24563] [00000000000000a0] user address but active_mm is swapper
>> [   52.516548][T24563] Internal error: Oops: 96000044 [#1] SMP
>> [   52.522096][T24563] Modules linked in: ghash_ce sha2_ce sha256_arm64 sha1_ce
>> sbsa_gwdt hns_roce_hw_v2 vfat fat ib_uverbs ib_core ipmi_ssif sg acpi_ipmi
>> ipmi_si ipmi_devintf ipmi_msghandler hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu
>> hisi_uncore_l3c_pmu hisi_uncore_pmu ip_tables xfs libcrc32c sd_mod realtek hclge
>> nvme hisi_sas_v3_hw nvme_core hisi_sas_main t10_pi libsas ahci libahci hns3
>> scsi_transport_sas libata hnae3 i2c_designware_platform i2c_designware_core nfit
>> libnvdimm dm_mirror dm_region_hash dm_log dm_mod
>> [   52.567181][T24563] CPU: 101 PID: 24563 Comm: cpuhp/101 Not tainted
>> 5.17.0-rc7+ #5
>> [   52.574716][T24563] Hardware name: Huawei TaiShan 200 (Model 5280)/BC82AMDD,
>> BIOS 1.79 08/21/2021
>> [   52.583547][T24563] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS
>> BTYPE=--)
>> [   52.591170][T24563] pc : lpi_update_config+0xe0/0x300
> 
> Can you please feed this to scripts/faddr2line? All this should do is
> to update the property table, which is global. If you get a NULL
> pointer there, something is really bad.

I found the CallTrace is the same with the following one I got.
This one: https://lkml.org/lkml/2022/1/25/529.

        gic_write_lpir(val, rdbase + GICR_INVLPIR);
    56bc:       91028001        add     x1, x0, #0xa0
    56c0:       f9000039        str     x25, [x1]
The fault instruction is 'str     x25, [x1]'. I think it may be because the
'rdbase' is null.

> 
> I also can't reproduce it locally, but that doesn't mean much.
> 
>> [   52.59620000ce6bb90 x28: 0000000000000000 x27: 0000000000000060
>> [   52.613021][T24563] x26: ffff20800798b818 x25: 0000000000002781 x24:
>> ffff80000962f460
>> [   52.620815][T24563] x23: 0000000000000000 x22: 0000000000000060 x21:
>> ffff80000962ec58
>> [   52.628610][T24563] x20: ffff20800633b540 x19: ffff208007946e00 x18:
>> 0000000000000000
>> [   52.636404][T24563] x17: 3731313830343030 x16: 3030303078304020 x15:
>> 0000000000000000
>> [   52.644199][T24563] x14: 0000000000000000 x13: 0000000000000000 x12:
>> 0000000000000000
>> [   52.651993][T24563] x11: 0000000000000000 x10: 0000000000000000 x9 :
>> ffff80000867a99c
>> [   52.659788][T24563] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
>> ffff800008d3dda0
>> [   52.667582][T24563] x5 : ffff800028e00000 x4 : 0000000000000000 x3 :
>> ffff20be7f837780
>> [   52.675376][T24563] x2 : 0000000000000001 x1 : 00000000000000a0 x0 :
>> 0000000000000000
>> [   52.683170][T24563] Call trace:
>> [   52.686298][T24563]  lpi_update_config+0xe0/0x300
>> [   52.690982][T24563]  its_unmask_irq+0x34/0x68
>> [   52.695318][T24563]  irq_chip_unmask_parent+0x20/0x28
>> [   52.700349][T24563]  its_unmask_msi_irq+0x24/0x30
>> [   52.705032][T24563]  unmask_irq.part.0+0x2c/0x48
>> [   52.709630][T24563]  irq_enable+0x70/0x80
>> [   52.713623][T24563]  __irq_startup+0x7c/0xa8
>> [   52.717875][T24563]  irq_startup+0x134/0x158
>> [   52.722127][T24563]  irq_affinity_online_cpu+0x1c0/0x210
>> [   52.727415][T24563]  cpuhp_invoke_callback+0x14c/0x590
>> [   52.732533][T24563]  cpuhp_thread_fun+0xd4/0x188
>> [   52.737130][T24563]   52.749890][T24563] Code: f94002a0 8b000020 f9400400
>> 91028001 (f9000039)
>> [   52.756649][T24563] ---[ end trace 0000000000000000 ]---
>> [   52.787287][T24563] Kernel panic - not syncing: Oops: Fatal exception
>> [   52.793701][T24563] SMP: stopping secondary CPUs
>> [   52.798309][T24563] Kernel Offset: 0xb0000 from 0xffff800008000000
>> [   52.804462][T24563] PHYS_OFFSET: 0x0
>> [   52.808021][T24563] CPU features: 0x00,00000803,46402c40
>> [   52.813308][T24563] Memory Limit: none
>> [   52.841424][T24563] ---[ end Kernel panic - not syncing: Oops: Fatal
>> exception ]---
>>
>> Then I only add kernel parameter 'maxcpus=1. It also crash with the same Call Trace.
>>
>> Then I add the cpu_online_mask check like below. Add both kernel parameters. It
>> won't crash now.
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index d25b7a864bbb..17c15d3b2784 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1624,7 +1624,10 @@ static int its_select_cpu(struct irq_data *d,
>>
>>  		cpu = cpumask_pick_least_loaded(d, tmpmask);
>>  	} else {
>> -		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
>> +		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
>> +		if (cpumask_empty(tmpmask))
>> +			cpumask_and(tmpmask, irq_data_get_affinity_mask(d),
>> +				    cpu_online_mask);
> 
> I don't get what this is trying to do.
> 
> For a managed interrupt, we really should never reach set_affinity if
> no CPUs that are able to deal with this interrupt are online. The
> current ITS code is buggy in that respect (it really should ignore
> cpu_online_mask), but I don't think we should end-up here the first
> place (this should all be core code).

Thanks, I got it.

Thanks,
Xiongfeng

> 
> Thanks,
> 
> 	M.
> 
