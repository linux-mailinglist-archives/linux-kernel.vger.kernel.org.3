Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932CC490812
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiAQMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:00:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4417 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiAQMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:00:28 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jcr7g2n5xz6864S;
        Mon, 17 Jan 2022 20:00:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 17 Jan 2022 13:00:25 +0100
Received: from [10.47.83.126] (10.47.83.126) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 17 Jan
 2022 12:00:25 +0000
Subject: Re: PCI MSI issue for maxcpus=1
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>
References: <78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com>
 <87a6g8vp8k.wl-maz@kernel.org>
 <19d55cdf-9ef7-e4a3-5ae5-0970f0d7751b@huawei.com>
 <87v8yjyjc0.wl-maz@kernel.org> <87k0ey9122.wl-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5f529b4e-1f6c-5a7d-236c-09ebe3a7db29@huawei.com>
Date:   Mon, 17 Jan 2022 11:59:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <87k0ey9122.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.126]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 09:14, Marc Zyngier wrote:
>> I guess that for managed interrupts, it shouldn't matter, as these
>> interrupts should only be used when the relevant CPUs come online.
>>
>> Would something like below help? Totally untested, as I don't have a
>> Multi-MSI capable device that I can plug in a GICv3 system (maybe I
>> should teach that to a virtio device...).

JFYI, NVMe PCI uses the same API (pci_alloc_irq_vectors_affinity()), but 
does not suffer from this issue - for maxcpus=1 the driver looks to only 
want 1x vector

> Actually, if the CPU online status doesn't matter for managed affinity
> interrupts, then the correct fix is this:
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index d25b7a864bbb..af4e72a6be63 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1624,7 +1624,7 @@ static int its_select_cpu(struct irq_data *d,
>   
>   		cpu = cpumask_pick_least_loaded(d, tmpmask);
>   	} else {
> -		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
> +		cpumask_copy(tmpmask, irq_data_get_affinity_mask(d));
>   
>   		/* If we cannot cross sockets, limit the search to that node */
>   		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&

That produces a warn:

[ 7.833025] ------------[ cut here ]------------
[ 7.837634] WARNING: CPU: 0 PID: 44 at 
drivers/irqchip/irq-gic-v3-its.c:298 valid_col+0x14/0x24
[ 7.846324] Modules linked in:
[ 7.849368] CPU: 0 PID: 44 Comm: kworker/0:3 Not tainted 5.16.0-dirty #119
[ 7.856230] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 
- V1.16.01 03/15/2019
[ 7.864740] Workqueue: events work_for_cpu_fn
[ 7.869088] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 7.876037] pc : valid_col+0x14/0x24
[ 7.879600] lr : its_build_mapti_cmd+0x84/0x90

...

[ 7.961007]  valid_col+0x14/0x24
[ 7.964223]  its_send_single_command+0x4c/0x150
[ 7.968741]  its_irq_domain_activate+0xc8/0x104
[ 7.973259]  __irq_domain_activate_irq+0x5c/0xac
[ 7.977865]  __irq_domain_activate_irq+0x38/0xac
[ 7.982471]  irq_domain_activate_irq+0x3c/0x64
[ 7.986902]  __msi_domain_alloc_irqs+0x1a8/0x2f4
[ 7.991507]  msi_domain_alloc_irqs+0x20/0x2c
[ 7.995764]  __pci_enable_msi_range+0x2ec/0x590
[ 8.000284]  pci_alloc_irq_vectors_affinity+0xe0/0x140
[ 8.005410]  hisi_sas_v3_probe+0x300/0xbe0
[ 8.009494]  local_pci_probe+0x44/0xb0
[ 8.013232]  work_for_cpu_fn+0x20/0x34
[ 8.016969]  process_one_work+0x1d0/0x354
[ 8.020966]  worker_thread+0x2c0/0x470
[ 8.024703]  kthread+0x17c/0x190
[ 8.027920]  ret_from_fork+0x10/0x20
[ 8.031485] ---[ end trace bb67cfc7eded7361 ]---

Apart from this, I assume that if another cpu comes online later in the 
affinity mask I would figure that we want to target the irq to that cpu 
(which I think we would not do here).

Cheers,
John


