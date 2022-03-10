Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE66B4D477E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbiCJM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242229AbiCJM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:59:30 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734D44925F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:58:26 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KDptT6Yhfz9sWM;
        Thu, 10 Mar 2022 20:54:41 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 20:58:24 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Mar
 2022 20:58:23 +0800
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
 <b4a98c83-08fb-864d-2458-427318960e78@huawei.com>
 <87o82eyxmz.wl-maz@kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <b2da939e-9bf0-72a0-8566-9efa60310159@huawei.com>
Date:   Thu, 10 Mar 2022 20:58:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87o82eyxmz.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2022/3/10 17:17, Marc Zyngier wrote:
> On Thu, 10 Mar 2022 03:19:52 +0000,
> Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>>
>> Hi,
>>
>> On 2022/3/8 22:18, Marc Zyngier wrote:
>>> On Tue, 08 Mar 2022 03:57:33 +0000,
>>> Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 2022/3/7 21:48, John Garry wrote:
>>>>> Hi Marc,
>>>>>
>>>>>>
>>>>>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>>>>>> index 2bdfce5edafd..97e9eb9aecc6 100644
>>>>>> --- a/kernel/irq/msi.c
>>>>>> +++ b/kernel/irq/msi.c
>>>>>> @@ -823,6 +823,19 @@ static int msi_init_virq(struct irq_domain *domain, int
>>>>>> virq, unsigned int vflag
>>>>>>       if (!(vflags & VIRQ_ACTIVATE))
>>>>>>           return 0;
>>>>>>   +    if (!(vflags & VIRQ_CAN_RESERVE)) {
>>>>>> +        /*
>>>>>> +         * If the interrupt is managed but no CPU is available
>>>>>> +         * to service it, shut it down until better times.
>>>>>> +         */
>>>>>> +        if (irqd_affinity_is_managed(irqd) &&
>>>>>> +            !cpumask_intersects(irq_data_get_affinity_mask(irqd),
>>>>>> +                    cpu_online_mask)) {
>>>>>> +            irqd_set_managed_shutdown(irqd);
>>>>>> +            return 0;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>>       ret = irq_domain_activate_irq(irqd, vflags & VIRQ_CAN_RESERVE);
>>>>>>       if (ret)
>>>>>>           return ret;
>>>>>>
>>>>
>>>> I applied the above modification and add kernel parameter 'maxcpus=1'. It can
>>>> boot successfully on D06.
>>>>
>>>> Then I remove 'maxcpus=1' and add 'nohz_full=5-127
>>>> isolcpus=nohz,domain,managed_irq,5-127'. The 'effective_affinity' of the kernel
>>>> managed irq is not correct.
>>>> [root@localhost wxf]# cat /proc/interrupts | grep 350
>>>> 350:          0          0          0          0          0        522
>>>> (ignored info)
>>>> 0          0                  0   ITS-MSI 60882972 Edge      hisi_sas_v3_hw cq
>>>> [root@localhost wxf]# cat /proc/irq/350/smp_affinity
>>>> 00000000,00000000,00000000,000000ff
>>>> [root@localhost wxf]# cat /proc/irq/350/effective_affinity
>>>> 00000000,00000000,00000000,00000020
>>>>
>>>> Then I apply the following modification.
>>>> Refer to https://lore.kernel.org/all/87a6fl8jgb.wl-maz@kernel.org/
>>>> The 'effective_affinity' is correct now.
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index eb0882d15366..0cea46bdaf99 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -1620,7 +1620,7 @@ static int its_select_cpu(struct irq_data *d,
>>>>
>>>>  		cpu = cpumask_pick_least_loaded(d, tmpmask);
>>>>  	} else {
>>>> -		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
>>>> +		cpumask_copy(tmpmask, aff_mask);
>>>>
>>>>  		/* If we cannot cross sockets, limit the search to that node */
>>>>  		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
>>>>
>>>> Then I add both kernel parameters.
>>>> nohz_full=1-127 isolcpus=nohz,domain,managed_irq,1-127 maxcpus=1
>>>> It crashed with the following message.
>>>> [   51.813803][T21132] cma_alloc: 29 callbacks suppressed
>>>> [   51.813809][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 4
>>>> pages, ret: -12
>>>> [   51.897537][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 8
>>>> pages, ret: -12
>>>> [   52.014432][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 4
>>>> pages, ret: -12
>>>> [   52.067313][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 8
>>>> pages, ret: -12
>>>> [   52.180011][T21132] cma: cma_alloc: reserved: alloc failed, req-size: 4
>>>> pages, ret: -12
>>>> [   52.270846][    T0] Detected VIPT I-cache on CPU1
>>>> [   52.275541][    T0] GICv3: CPU1: found redistributor 80100 region
>>>> 1:0x00000000ae140000
>>>> [   52.283425][    T0] GICv3: CPU1: using allocated LPI pending table
>>>> @0x00000040808b0000
>>>> [   52.291381][    T0] CPU1: Booted secondary processor 0x0000080100 [0x481fd010]
>>>> [   52.432971][    T0] Detected VIPT I-cache on CPU101
>>>> [   52.437914][    T0] GICv3: CPU101: found redistributor 390100 region
>>>> 101:0x00002000aa240000
>>>> [   52.446233][    T0] GICv3: CPU101: using allocated LPI pending table
>>>> @0x0000004081170000
>>>> [   52.ULL pointer dereference at virtual address 00000000000000a0
>>>
>>> This is pretty odd. If you passed maxcpus=1, how comes CPU1 and 101
>>> are booting right from the beginning? Or is it userspace doing that?
>>
>> Yes, it is the userspace will online all the CPUs.
>>
>>>
>>>> [   52.471539][T24563] Mem abort info:
>>>> [   52.475011][T24563]   ESR = 0x96000044
>>>> [   52.478742][T24563]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>> [   52.484721][T24563]   SET = 0, FnV = 0
>>>> [   52.488451][T24563]   EA = 0, S1PTW = 0
>>>> [   52.492269][T24563]   FSC = 0x04: level 0 translation fault
>>>> [   52.497815][T24563] Data abort info:
>>>> [   52.501374][T24563]   ISV = 0, ISS = 0x00000044
>>>> [   52.505884][T24563]   CM = 0, WnR = 1
>>>> [   52.509530][T24563] [00000000000000a0] user address but active_mm is swapper
>>>> [   52.516548][T24563] Internal error: Oops: 96000044 [#1] SMP
>>>> [   52.522096][T24563] Modules linked in: ghash_ce sha2_ce sha256_arm64 sha1_ce
>>>> sbsa_gwdt hns_roce_hw_v2 vfat fat ib_uverbs ib_core ipmi_ssif sg acpi_ipmi
>>>> ipmi_si ipmi_devintf ipmi_msghandler hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu
>>>> hisi_uncore_l3c_pmu hisi_uncore_pmu ip_tables xfs libcrc32c sd_mod realtek hclge
>>>> nvme hisi_sas_v3_hw nvme_core hisi_sas_main t10_pi libsas ahci libahci hns3
>>>> scsi_transport_sas libata hnae3 i2c_designware_platform i2c_designware_core nfit
>>>> libnvdimm dm_mirror dm_region_hash dm_log dm_mod
>>>> [   52.567181][T24563] CPU: 101 PID: 24563 Comm: cpuhp/101 Not tainted
>>>> 5.17.0-rc7+ #5
>>>> [   52.574716][T24563] Hardware name: Huawei TaiShan 200 (Model 5280)/BC82AMDD,
>>>> BIOS 1.79 08/21/2021
>>>> [   52.583547][T24563] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS
>>>> BTYPE=--)
>>>> [   52.591170][T24563] pc : lpi_update_config+0xe0/0x300
>>>
>>> Can you please feed this to scripts/faddr2line? All this should do is
>>> to update the property table, which is global. If you get a NULL
>>> pointer there, something is really bad.
>>
>> I found the CallTrace is the same with the following one I got.
>> This one: https://lkml.org/lkml/2022/1/25/529.
>>
>>         gic_write_lpir(val, rdbase + GICR_INVLPIR);
>>     56bc:       91028001        add     x1, x0, #0xa0
>>     56c0:       f9000039        str     x25, [x1]
>> The fault instruction is 'str     x25, [x1]'. I think it may be because the
>> 'rdbase' is null.
> 
> Ah, you're of course using direct invalidation, which is why I
> couldn't get this to explode in a VM. Maybe I should add support for
> this in KVM, if only as an option.
> 
> I'll try and work out what goes wrong.

Thanks a lot!

I add some debug info and got the dmesg as belows. Hope it be helpful.
It seems that irq_to_cpuid_lock() returns an offline CPU and the crash occurs.


diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd77297..f9fc953 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1453,6 +1453,7 @@ static void direct_lpi_inv(struct irq_data *d)

        /* Target the redistributor this LPI is currently routed to */
        cpu = irq_to_cpuid_lock(d, &flags);
+       pr_info("direct_lpi_inv CPU%d current CPU%d\n", cpu, smp_processor_id());
        raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
        rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
        gic_write_lpir(val, rdbase + GICR_INVLPIR);


[   16.052692][ T2280] direct_lpi_inv CPU0 current CPU0
[   16.058914][  T336] hns3 0000:7d:00.0: hclge driver initialization finished.
[   16.066711][    T7] direct_lpi_inv CPU0 current CPU0
[   16.072089][ T2280] nvme nvme1: Shutdown timeout set to 8 seconds
[   16.080703][ T2280] direct_lpi_inv CPU0 current CPU0
[   16.087717][    T7] direct_lpi_inv CPU1 current CPU0
[   16.092663][    T7] Unable to handle kernel NULL pointer dereference at
virtual address 00000000000000a0
[   16.102097][    T7] Mem abort info:
[   16.105569][    T7]   ESR = 0x96000044
[   16.109301][    T7]   EC = 0x25: DABT (current EL), IL = 32 bits
[   16.115280][    T7]   SET = 0, FnV = 0
[   16.119012][    T7]   EA = 0, S1PTW = 0
[   16.122830][    T7]   FSC = 0x04: level 0 translation fault
[   16.128377][    T7] Data abort info:
[   16.131934][    T7]   ISV = 0, ISS = 0x00000044
[   16.136443][    T7]   CM = 0, WnR = 1
[   16.140089][    T7] user pgtable: 4k pages, 48-bit VAs, pgdp=000000409a00f000
[   16.147191][    T7] [00000000000000a0] pgd=0000000000000000, p4d=0000000000000000
[   16.154642][    T7] Internal error: Oops: 96000044 [#1] SMP
[   16.160189][    T7] Modules linked in: nvmec_designware_platform
i2c_designware_core nfit libnvdimm dm_mirror dm_region_hash dm_log dm_mod
[   16.183467][    T7] CPU: 0 PID: 7 Comm: kworker/u256:0 Not tainted 5.17.0-rc7+ #8
[   16.190916][    T7] Hardware name: Huawei TaiShan 200 (Model 5280)/BC82AMDD,
BIOS 1.79 08/21/2021
[   16.199746][    T7] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[   16.205990][    T7] pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[   16.213611][    T7] pc : lpi_update_config+0x10c/0x320
[   16.218729][    T7] lr : lpi_update_config+0xb4/0x320
[   16.223758][    T7] sp : ffff80000a9f3950
[   16.227748][    T7] x29: ffff80000a9f3950 x28: 0000000000000030 x27:
ffff0040a0b81680
[   16.235543][    T7] x26: 0000000000000000 x25: 0000000000000001 x24:
0000000000000000
[   16.243337][    T7] x23: 00000000000028bb x22: ffff8000095cf460 x21:
ffff004087612380
[   16.251131][    T7] x20: ffff8000095cec58 x19: ffff0040a076e600 x18:
0000000000000000
[   16.258925][    T7] x17: ffff807ef6793000 x16: ffff800008004000 x15:
ffff004087612ac8
[   16.266719][    T7] x14: 0000000000000000 x13: 205d375420202020 x12:
5b5d373137373830
[   16.274513][    T7] x11: ffff800009983388 x10: ffff8000098c3348 x9 :
ffff80000825c408
[   16.282306][    T7] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 :
0000000000000001
[   16.290100][    T7] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
ffff007effa56780
[   16.297894][    T7] x2 : 0000000000000001 x1 : 00000000000000a0 x0 :
0000000000000000
[   0x34/0x68
[   16.317920][    T7]  irq_chip_unmask_parent+0x20/0x28
[   16.322950][    T7]  its_unmask_msi_irq+0x24/0x30
[   16.327632][    T7]  unmask_irq.part.0+0x2c/0x48
[   16.332228][    T7]  irq_enable+0x70/0x80
[   16.336220][    T7]  __irq_startup+0x7c/0xa8
[   16.340472][    T7]  irq_startup+0x134/0x158
[   16.344724][    T7]  __setup_irq+0x808/0x940
[   16.348973][    T7]  request_threaded_irq+0xf0/0x1a8
[   16.353915][    T7]  pci_request_irq+0xbc/0x108
[   16.358426][    T7]  queue_request_irq+0x70/0x78 [nvme]
[   16.363629][    T7]  nvme_create_io_queues+0x208/0x368 [nvme]
[   16.369350][    T7]  nvme_reset_work+0x828/0xdd8 [nvme]
[   16.374552][    T7]  process_one_work+0x1dc/0x478
[   16.379236][    T7]  worker_thread+0x150/0x4f0
[   16.383660][    T7]  kthread+0xd0/0xe0
[   16.387393][    T7]  ret_from_fork+0x10/0x20
[   16.391648][    T7] Code: f9400280 8b000020 f9400400 91028001 (f9000037)
[   16.398404][    T7] ---[ end trace 0000000000000000 ]---

Thanks,
Xiongfeng

> 
> Thanks,
> 
> 	M.
> 
