Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F244D2D02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiCIKWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiCIKWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:22:06 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF6216BF92
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:21:03 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KD7W60dx0z6802V;
        Wed,  9 Mar 2022 18:20:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 11:21:01 +0100
Received: from [10.47.81.176] (10.47.81.176) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 10:21:00 +0000
Message-ID: <70b15802-b8b1-301e-00f2-39e299114b02@huawei.com>
Date:   Wed, 9 Mar 2022 10:20:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] genirq/msi: Shutdown managed interrupts with unsatifiable
 affinities
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        David Decotigny <ddecotig@google.com>,
        <wangxiongfeng2@huawei.com>
References: <20220307190625.254426-1-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220307190625.254426-1-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.176]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+

On 07/03/2022 19:06, Marc Zyngier wrote:
> When booting with maxcpus=<small number>, interrupt controllers
> such as the GICv3 ITS may not be able to satisfy the affinity of
> some managed interrupts, as some of the HW resources are simply
> not available.
> 
> In order to deal with this, do not try to activate such interrupt
> if there is no online CPU capable of handling it. Instead, place
> it in shutdown state. Once a capable CPU shows up, it will be
> activated.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Reported-by: David Decotigny <ddecotig@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Tested-by: John Garry <john.garry@huawei.com>

> ---

JFYI, I could not recreate the same crash reported in the original 
thread for "nohz_full=5-127 isolcpus=nohz,domain,managed_irq,5-127 
maxcpus=1". Here's just showing what I set via cmdline:

estuary:/$ dmesg | grep -i hz
[    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init 
console=ttyS0,115200 no_console_suspend nvme.use_threaded_interrupts=0 
iommu.strict=0 acpi=force earlycon=pl011,mmio32,0x602b0000 
nohz_full=5-127 isolcpus=nohz,domain,managed_irq,5-127 maxcpus=1
[    0.000000] NO_HZ: Full dynticks CPUs: 5-127.
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] sched_clock: 57 bits at 100MHz, resolution 10ns, wraps 
every 4398046511100ns
[   15.314258] sbsa-gwdt sbsa-gwdt.0: Initialized with 10s timeout @ 
100000000 Hz, action=0

And for the kernel build:
$ more .config | grep NO_HZ
CONFIG_NO_HZ_COMMON=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
# CONFIG_NO_HZ is not set
$

Thanks,
John
>   kernel/irq/msi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 2bdfce5edafd..aa84ce84c2ec 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -818,6 +818,18 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
>   		irqd_clr_can_reserve(irqd);
>   		if (vflags & VIRQ_NOMASK_QUIRK)
>   			irqd_set_msi_nomask_quirk(irqd);
> +
> +		/*
> +		 * If the interrupt is managed but no CPU is available
> +		 * to service it, shut it down until better times.
> +		 */
> +		if ((vflags & VIRQ_ACTIVATE) &&
> +		    irqd_affinity_is_managed(irqd) &&
> +		    !cpumask_intersects(irq_data_get_affinity_mask(irqd),
> +					cpu_online_mask)) {
> +			    irqd_set_managed_shutdown(irqd);
> +			    return 0;
> +		    }
>   	}
>   
>   	if (!(vflags & VIRQ_ACTIVATE))

