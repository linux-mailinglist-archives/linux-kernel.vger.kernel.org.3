Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1749B455
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455960AbiAYMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:52:07 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35867 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457349AbiAYMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:49:29 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jjmqg5vlgzcchP;
        Tue, 25 Jan 2022 20:48:31 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 20:49:21 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 20:49:20 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Select housekeeping CPUs
 preferentially for managed IRQs
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, John Garry <john.garry@huawei.com>
References: <20220124073440.88598-1-wangxiongfeng2@huawei.com>
 <87a6fl8jgb.wl-maz@kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <12ac7447-34dc-8497-b608-ada5a2ba17c4@huawei.com>
Date:   Tue, 25 Jan 2022 20:49:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87a6fl8jgb.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2022/1/24 19:24, Marc Zyngier wrote:
> + John Garry, as he was reporting issues around the same piece of code[1]
> 
> On Mon, 24 Jan 2022 07:34:40 +0000,
> Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>>
>> When using kernel parameter 'isolcpus=managed_irq,xxxx' to bind the
>> managed IRQs to housekeeping CPUs, the effective_affinity sometimes
>> still contains the non-housekeeping CPUs.
>>
>> irq_do_set_affinity() passes the housekeeping cpumask to
>> chip->irq_set_affinity(), but ITS driver select CPU according to
>> irq_common_data->affinity. While 'irq_common_data->affinity' is updated
>> after chip->irq_set_affinity() is called in irq_do_set_affinity(). Also
>> 'irq_common_data->affinity' may contains non-housekeeping CPUs. I found
>> the below link explaining the reason.
>>   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2267032.html
>>
>> To modify CPU selecting logic to prefer housekeeping CPUs, select CPU
>> from the input cpumask parameter first. If none of it is online, then
>> select CPU from 'irq_common_data->affinity'.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
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
> I think that the online_cpu_mask logical and is a bit wrong. A managed
> interrupt should be able to target an offline CPU:
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index eb0882d15366..0cea46bdaf99 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1620,7 +1620,7 @@ static int its_select_cpu(struct irq_data *d,
>  
>  		cpu = cpumask_pick_least_loaded(d, tmpmask);
>  	} else {
> -		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
> +		cpumask_copy(tmpmask, aff_mask);
>  
>  		/* If we cannot cross sockets, limit the search to that node */
>  		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&

I have tested the above modification with 'maxcpus=1' kernel parameter and got
the following CallTrace.

[   14.571189][    T5] Unable to handle kernel NULL pointer dereference at
virtual address 00000000000000a0
[   14.580625][    T5] Mem abort info:
[   14.584096][    T5]   ESR = 0x96000044
[   14.587830][    T5]   EC = 0x25: DABT (current EL), IL = 32 bits
[   14.593808][    T5]   SET = 0, FnV = 0
[   14.597538][    T5]   EA = 0, S1PTW = 0
[   14.601357][    T5]   FSC = 0x04: level 0 translation fault
[   14.606903][    T5] Data abort info:
[   14.610461][    T5]   ISV = 0, ISS = 0x00000044
[   14.614970][    T5]   CM = 0, WnR = 1
[   14.618614][    T5] user pgtable: 4k pages, 48-bit VAs, pgdp=000000409ac33000
[   14.625716][    T5] [00000000000000a0] pgd=0000000000000000, p4d=0000000000000000
[   14.633164][    T5] Internal error: Oocore nfit libnvdimm hisi_sas_v3_hw(+)
hisi_sas_main libsas scsi_transport_sas libata dm_mirror dm_region_hash dm_log
dm_mod
[   14.658441][    T5] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.16.0-rc2+ #3
[   14.665630][    T5] Hardware name: Huawei TaiShan 200 (Model 5280)/BC82AMDD,
BIOS 1.79 08/21/2021
[   14.674460][    T5] Workqueue: events work_for_cpu_fn
[   14.679493][    T5] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[   14.687114][    T5] pc : lpi_update_config+0xe0/0x300
[   14.692146][    T5] lr : lpi_update_config+0x3c/0x300
[   14.697174][    T5] sp : ffff80001297ba30
[   14.701165][    T5] x29: ffff80001297ba30 x28: ffff00409e3c0828 x27:
ffff800008d848f8
[   14.708959][    T5] x26: ffff800008d832a8 x25: 000000000000277f x24:
ffff80001164f650
[   14.716754][    T5] x23: 0000000000000000 x22: 0000000000000001 x21:
ffff80001164ee50
[   14.724548][    T5] x20: ffff00408761a380 x19: ffff00409e803f00 x18:
0000000000000001
[   14.732342][    T5] x17: 00000000c7432c35 x16: 00000000a376051e x15:
0000000000000000
[   14.740136][    T5] x14: 0000000000000000 x13: 0000000000000000 x12:
0000000000000000
[   14.747930][    T5] x11: 0000000000000000 x10: 0000000000000000 x9 :
ffff8000106b028c
[   14.755724][    T5] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
ffff800010d6d4f0
[   14.763517][    T5] x5 : ffff800030e00000 x4 : 0000000000000000 x3 :
ffff007effa565a0
[   14.771311][    T5] x2 : 0000000000000001 x1 : 00000000000000a0 x0 :
0000000000000000
[   14.779105][    T5] Call trace:
[   14.782231][    T5]  lpi_update_config+0xe0/0x300
[   14.786914][    T5]  its_unmask_irq+0x34/0x68
[   14.791252][    T5]  irq_chip_unmask_parent+0x20/0x28
[   14.796282][    T5]  its_unmask_msi_irq+0x24/]  __irq_startup+0x7c/0xa8
[   14.813803][    T5]  irq_startup+0x134/0x158
[   14.818055][    T5]  __setup_irq+0x810/0x948
[   14.822305][    T5]  request_threaded_irq+0xf0/0x1a8
[   14.827247][    T5]  devm_request_threaded_irq+0x84/0xf8
[   14.832534][    T5]  hisi_sas_v3_probe+0x4f0/0x708 [hisi_sas_v3_hw]
[   14.838778][    T5]  local_pci_probe+0x44/0xa8
[   14.843203][    T5]  work_for_cpu_fn+0x20/0x30
[   14.847628][    T5]  process_one_work+0x1dc/0x480
[   14.852310][    T5]  worker_thread+0x150/0x4f8
[   14.856734][    T5]  kthread+0x138/0x148
[   14.860639][    T5]  ret_from_fork+0x10/0x20
[   14.864893][    T5] Code: f94002a0 8b000020 f9400400 91028001 (f9000039)
[   14.871649][    T5] ---[ end trace 627494869fd96883 ]---
[   14.903345][    T5] Kernel panic - not syncing: Oops: Fatal exception
[   14.909760][    T5] Kernel Offset: 0xf0000 from 0xffff800010000000
[   14.915912][    T5] PHYS_OFFSET: 0x0
[   14.919470][    T5] CPU features: 0x0,00000803,46402c40
[   14.924671][    T5] Memory Limit: none
[   14.946762][    T5] ---[ end Kernel panic - not syncing: Oops: Fatal
exception ]---


        gic_write_lpir(val, rdbase + GICR_INVLPIR);
    56bc:       91028001        add     x1, x0, #0xa0
    56c0:       f9000039        str     x25, [x1]
The fault instruction is 'str     x25, [x1]'. I think it may be because the
'rdbase' is null.

I think we may still need the cpu_online_mask check. It can avoid the system panic.

> 
> We still have an issue when the system hasn't booted with all its
> CPUs, as the corresponding collections aren't initialised and we
> end-up in a rather bad place.

Shall we fix this 'effective CPU of managed IRQs is not housekeeping CPU' issue
first, or we will wait until the 'maxcpus=1' issue is fixed.

Thanks,
Xiongfeng

> 
> 	M.
> 
> [1] https://lore.kernel.org/r/78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com
> 
