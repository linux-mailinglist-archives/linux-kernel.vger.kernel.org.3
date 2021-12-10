Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE71146FED3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhLJKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:39:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4242 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhLJKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:39:58 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9S2D5S0tz67j3H;
        Fri, 10 Dec 2021 18:34:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 11:36:21 +0100
Received: from [10.47.85.63] (10.47.85.63) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 10:36:20 +0000
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>
CC:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <Viswas.G@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Niklas.Cassel@wdc.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
 <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
 <Ya4PAu4Xj8UGHEV7@x1-carbon>
 <PH0PR11MB5112E2E7D00D95F32C86677AEC6E9@PH0PR11MB5112.namprd11.prod.outlook.com>
 <6ee6fe1b-e811-cada-0c18-78149c313358@huawei.com>
 <PH0PR11MB51120361EB6F6931CCE023D6EC709@PH0PR11MB5112.namprd11.prod.outlook.com>
 <f41d2bed-f320-1b70-7d63-fe77caa2534d@huawei.com>
 <6ed96184-6291-ad37-0241-00a5389293e6@opensource.wdc.com>
 <24a9ac51-ce60-b883-2284-023c703a7885@huawei.com>
 <5dfd6c4b-dd10-c9b5-7efb-82a11613fdd4@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a4b2bf44-ef21-6cc8-f79f-d0e41c8f037f@huawei.com>
Date:   Fri, 10 Dec 2021 10:35:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <5dfd6c4b-dd10-c9b5-7efb-82a11613fdd4@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.63]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 23:55, Damien Le Moal wrote:
>> Earlier today it was the mount command which was hanging. From debugging
>> that, I found that the very first SSP command when mounting is sent the
>> HW successfully but no completion interrupt ever occurs there - I really
>> don't know why. Other SSP commands complete successfully before this and
>> after (TMFs in the error handling), including ones which have sgls.
>>
>> sda is a SAS drive, but I think SATA has the same issue - I was just
>> looking at sda.
>>
>> One thing I noticed in the driver is that it uses mb() in between
>> writing to the DMA memory and initiating the HW - I don't think mb is
>> strong enough. However I don't think that is my issue - it wouldn't fail
>> reliably if it was.
> Weird. 

Yeah, quite strange.

I will also note that these earlier logs are also red flags, which I 
have not investigated:

[87.288239] sas: target proto 0x0 at 500e004aaaaaaa1f:0x10 not handled
[87.294793] sas: ex 500e004aaaaaaa1f phy16 failed to discover

> I do not have an arm host to test. Could it be that the card FW is
> crashing ?

But the later TMFs seem to succeed, so I doubt it's crashing. I did 
wonder if it's going into some low-power/idle mode and just not 
responding, but not sure on that.

> Can you recover from the above ? 

It never really recovers and is always caught up in some error handling.

> Or do you have to power cycle for
> the HDD to be accessible again ?

Power cycle is necessary to recover as we can't remove the driver when 
it is in error handling

> 
> Other possibility may be an IRQ controller issue with the platform ?
> 

Highly unlikely. I did wonder if the interrupts are properly allocated 
and requested, and they look ok from /proc/interrupts

I also tried limiting the CPUs we bring up to a single CPU and so that 
we only use a single MSIx and a single HW queue, and now get this crash:

[7.775168] loop: module loaded
[7.783226] pm80xx 0000:04:00.0: Adding to iommu group 0
[7.795787] pm80xx 0000:04:00.0: pm80xx: driver version 0.1.40
[7.806789] pm80xx 0000:04:00.0: enabling device (0140 -> 0142)
[7.818910] :: pm8001_pci_alloc  530:Setting link rate to default value
[8.866618] scsi host0: pm80xx
[8.879056] pm80xx0:: process_oq  4169:Firmware Fatal error! Regval:0xc0f
[8.885842] pm80xx0:: print_scratchpad_registers 
4130:MSGU_SCRATCH_PAD_0: 0x40002000
[8.893661] pm80xx0:: print_scratchpad_registers 
4132:MSGU_SCRATCH_PAD_1:0xc0f
[8.900958] pm80xx0:: print_scratchpad_registers 
4134:MSGU_SCRATCH_PAD_2: 0x0
[8.908169] pm80xx0:: print_scratchpad_registers 
4136:MSGU_SCRATCH_PAD_3: 0x30000000
[8.915986] pm80xx0:: print_scratchpad_registers 
4138:MSGU_HOST_SCRATCH_PAD_0: 0x0
[8.923630] pm80xx0:: print_scratchpad_registers 
4140:MSGU_HOST_SCRATCH_PAD_1: 0x0
[8.931274] pm80xx0:: print_scratchpad_registers 
4142:MSGU_HOST_SCRATCH_PAD_2: 0x0
[8.938917] pm80xx0:: print_scratchpad_registers 
4144:MSGU_HOST_SCRATCH_PAD_3: 0x0
[8.946561] pm80xx0:: print_scratchpad_registers 
4146:MSGU_HOST_SCRATCH_PAD_4: 0x0
[8.954205] pm80xx0:: print_scratchpad_registers 
4148:MSGU_HOST_SCRATCH_PAD_5: 0x0
[8.961849] pm80xx0:: print_scratchpad_registers 
4150:MSGU_RSVD_SCRATCH_PAD_0: 0x0
[8.969493] pm80xx0:: print_scratchpad_registers 
4152:MSGU_RSVD_SCRATCH_PAD_1: 0x0
[8.977143] Unable to handle kernel NULL pointer dereference at virtual 
address 0000000000000018
[8.994782] Mem abort info:
[8.997565]   ESR = 0x96000004
[9.006782]   EC = 0x25: DABT (current EL), IL = 32 bits
[9.018781]   SET = 0, FnV = 0
[9.021824]   EA = 0, S1PTW = 0
[9.030797]   FSC = 0x04: level 0 translation fault
[9.038794] Data abort info:
[9.041662]   ISV = 0, ISS = 0x00000004
[9.050781]   CM = 0, WnR = 0
[9.053737] [0000000000000018] user address but active_mm is swapper
[9.070782] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[9.076343] Modules linked in:
[9.079387] CPU: 0 PID: 20 Comm: kworker/0:2 Not tainted 
5.16.0-rc4-00002-ge23d68774178-dirty #328
[9.088333] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 - 
V1.16.01 03/15/2019
[9.096844] Workqueue: pm80xx pm8001_work_fn
[9.101108] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[9.108057] pc : pm8001_work_fn+0x298/0x690
[9.112229] lr : process_one_work+0x1d0/0x354
[9.116574] sp : ffff800012d23d50
[9.119876] x29: ffff800012d23d50 x28: 0000000000000000 x27: 0000000000000000
[9.127000] x26: ffff8000117e8bc0 x25: ffff8000113aaeb0 x24: ffff00209d4b0000
[9.134124] x23: ffff0020ad23b280 x22: ffff00209d4b8000 x21: 0000000000000001
[9.141249] x20: 0000000000000000 x19: 0000000000000038 x18: 0000000000000000
[9.148373] x17: 4441505f48435441 x16: 5243535f44565352 x15: 000000052ff6b548
[9.155496] x14: 0000000000000018 x13: 0000000000000018 x12: 0000000000000000
[9.162620] x11: 0000000000000014 x10: 00000000000009a0 x9 : ffff002086ef6074
[9.169743] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff002086ef6074
[9.176867] x5 : 0000787830386d70 x4 : ffff00209d5e0000 x3 : 0000000000000000
[9.183990] x2 : ffff00209d5e0038 x1 : ffff800010a20120 x0 : 0000000000000051
[9.191114] Call trace:
[9.193547]  pm8001_work_fn+0x298/0x690
[9.197372]  process_one_work+0x1d0/0x354
[9.201369]  worker_thread+0x13c/0x470
[9.205105]  kthread+0x17c/0x190
[9.208321]  ret_from_fork+0x10/0x20
[9.211886] Code: 17fffff1 310006bf 54fffde0 f9400c54 (f9400e80)
[9.217968] ---[ end trace de649a9be2843866 ]---
[9.339812] pm80xx0:: process_oq  4169:Firmware Fatal error! Regval:0xc0f
[9.346602] pm80xx0:: print_scratchpad_registers 
4130:MSGU_SCRATCH_PAD_0: 0x40002000
[9.354420] pm80xx0:: print_scratchpad_registers 
4132:MSGU_SCRATCH_PAD_1:0xc0f
[9.361717] pm80xx0:: print_scratchpad_registers 
4134:MSGU_SCRATCH_PAD_2: 0x0
[9.368927] pm80xx0:: print_scratchpad_registers 
4136:MSGU_SCRATCH_PAD_3: 0x30000000
[9.376744] pm80xx0:: print_scratchpad_registers 
4138:MSGU_HOST_SCRATCH_PAD_0: 0x0
[9.384388] pm80xx0:: print_scratchpad_registers 
4140:MSGU_HOST_SCRATCH_PAD_1: 0x0
[9.392032] pm80xx0:: print_scratchpad_registers 
4142:MSGU_HOST_SCRATCH_PAD_2: 0x0
[9.399676] pm80xx0:: print_scratchpad_registers 
4144:MSGU_HOST_SCRATCH_PAD_3: 0x0
[9.407319] pm80xx0:: print_scratchpad_registers 
4146:MSGU_HOST_SCRATCH_PAD_4: 0x0
[9.414963] pm80xx0:: print_scratchpad_registers 
4148:MSGU_HOST_SCRATCH_PAD_5: 0x0
[9.422607] pm80xx0:: print_scratchpad_registers 
4150:MSGU_RSVD_SCRATCH_PAD_0: 0x0
[9.430251] pm80xx0:: print_scratchpad_registers 
4152:MSGU_RSVD_SCRATCH_PAD_1: 0x0
[   10.028906] Freeing initrd memory: 413456K

...

Thanks,
John
