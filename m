Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537074D0069
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiCGNtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242344AbiCGNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:49:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD192E08A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:48:17 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KC0CD6yVbz67jjw;
        Mon,  7 Mar 2022 21:47:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 14:48:15 +0100
Received: from [10.47.81.176] (10.47.81.176) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Mar
 2022 13:48:14 +0000
Message-ID: <452d97ed-459f-7936-99e4-600380608615@huawei.com>
Date:   Mon, 7 Mar 2022 13:48:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: PCI MSI issue for maxcpus=1
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>, <wangxiongfeng2@huawei.com>,
        David Decotigny <decot@google.com>
References: <78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com>
 <87a6g8vp8k.wl-maz@kernel.org>
 <19d55cdf-9ef7-e4a3-5ae5-0970f0d7751b@huawei.com>
 <87v8yjyjc0.wl-maz@kernel.org> <87k0ey9122.wl-maz@kernel.org>
 <5f529b4e-1f6c-5a7d-236c-09ebe3a7db29@huawei.com>
 <1cbe7daa-8003-562b-06fa-5a50f7ee6ed2@huawei.com>
 <87a6e4tnkm.wl-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <87a6e4tnkm.wl-maz@kernel.org>
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

Hi Marc,

> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 2bdfce5edafd..97e9eb9aecc6 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -823,6 +823,19 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
>   	if (!(vflags & VIRQ_ACTIVATE))
>   		return 0;
>   
> +	if (!(vflags & VIRQ_CAN_RESERVE)) {
> +		/*
> +		 * If the interrupt is managed but no CPU is available
> +		 * to service it, shut it down until better times.
> +		 */
> +		if (irqd_affinity_is_managed(irqd) &&
> +		    !cpumask_intersects(irq_data_get_affinity_mask(irqd),
> +					cpu_online_mask)) {
> +			irqd_set_managed_shutdown(irqd);
> +			return 0;
> +		}
> +	}
> +
>   	ret = irq_domain_activate_irq(irqd, vflags & VIRQ_CAN_RESERVE);
>   	if (ret)
>   		return ret;
> 

Yeah, that seems to solve the issue. I will test it a bit more.

We need to check the isolcpus cmdline issue as well - wang xiongfeng, 
please assist here. I assume that this feature just never worked for 
arm64 since it was added.

> With this in place, I get the following results (VM booted with 4
> vcpus and maxcpus=1, the virtio device is using managed interrupts):
> 
> root@debian:~# cat /proc/interrupts
>             CPU0
>   10:       2298     GICv3  27 Level     arch_timer
>   12:         84     GICv3  33 Level     uart-pl011
>   49:          0     GICv3  41 Edge      ACPI:Ged
>   50:          0   ITS-MSI 16384 Edge      virtio0-config
>   51:       2088   ITS-MSI 16385 Edge      virtio0-req.0
>   52:          0   ITS-MSI 16386 Edge      virtio0-req.1
>   53:          0   ITS-MSI 16387 Edge      virtio0-req.2
>   54:          0   ITS-MSI 16388 Edge      virtio0-req.3
>   55:      11641   ITS-MSI 32768 Edge      xhci_hcd
>   56:          0   ITS-MSI 32769 Edge      xhci_hcd
> IPI0:         0       Rescheduling interrupts
> IPI1:         0       Function call interrupts
> IPI2:         0       CPU stop interrupts
> IPI3:         0       CPU stop (for crash dump) interrupts
> IPI4:         0       Timer broadcast interrupts
> IPI5:         0       IRQ work interrupts
> IPI6:         0       CPU wake-up interrupts
> Err:          0
> root@debian:~# echo 1 >/sys/devices/system/cpu/cpu2/online
> root@debian:~# cat /proc/interrupts
>             CPU0       CPU2
>   10:       2530         90     GICv3  27 Level     arch_timer
>   12:        103          0     GICv3  33 Level     uart-pl011
>   49:          0          0     GICv3  41 Edge      ACPI:Ged
>   50:          0          0   ITS-MSI 16384 Edge      virtio0-config
>   51:       2097          0   ITS-MSI 16385 Edge      virtio0-req.0
>   52:          0          0   ITS-MSI 16386 Edge      virtio0-req.1
>   53:          0         12   ITS-MSI 16387 Edge      virtio0-req.2
>   54:          0          0   ITS-MSI 16388 Edge      virtio0-req.3
>   55:      13487          0   ITS-MSI 32768 Edge      xhci_hcd
>   56:          0          0   ITS-MSI 32769 Edge      xhci_hcd
> IPI0:        38         45       Rescheduling interrupts
> IPI1:         3          3       Function call interrupts
> IPI2:         0          0       CPU stop interrupts
> IPI3:         0          0       CPU stop (for crash dump) interrupts
> IPI4:         0          0       Timer broadcast interrupts
> IPI5:         0          0       IRQ work interrupts
> IPI6:         0          0       CPU wake-up interrupts
> Err:          0
> 

Out of interest, is the virtio managed interrupts support just in your 
sandbox? You did mention earlier in the thread that you were considering 
adding this feature.

Thanks,
John
