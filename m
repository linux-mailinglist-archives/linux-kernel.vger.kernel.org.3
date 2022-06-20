Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9338550EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiFTDGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiFTDGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:06:31 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC22C659A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:06:29 -0700 (PDT)
Received: from [10.20.42.13] (unknown [10.20.42.13])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb00s5K9iZBxOAA--.20655S3;
        Mon, 20 Jun 2022 11:06:20 +0800 (CST)
Subject: Re: [PATCH V12 03/10] irqchip: Add LoongArch CPU interrupt controller
 support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
 <1655273250-23495-4-git-send-email-lvjianmin@loongson.cn>
 <87czf6p78r.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <39511f9f-21f9-91ac-17f5-8608380df600@loongson.cn>
Date:   Mon, 20 Jun 2022 11:06:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87czf6p78r.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxb00s5K9iZBxOAA--.20655S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4fZr1DtryrCFWfArW8JFb_yoWfAw1fpF
        WUAa1avr4UJFyUXr90k3W5Wr9xXw1fGrW2vayfKa47Aryqkr1v9F18ur9ruFWkCw4UGa12
        vF4FqFWxuF45AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU90b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267
        AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x07beAp5UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/18 下午6:59, Marc Zyngier wrote:
> On Wed, 15 Jun 2022 07:07:23 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> LoongArch CPUINTC stands for CSR.ECFG/CSR.ESTAT and related interrupt
>> controller that described in Section 7.4 of "LoongArch Reference Manual,
>> Vol 1". For more information please refer Documentation/loongarch/irq-
>> chip-model.rst.
>>
>> LoongArch CPUINTC has 13 interrupt sources: SWI0~1, HWI0~7, IPI, TI
>> (Timer) and PCOV (PMC). IRQ mappings of HWI0~7 are configurable (can be
>> created from DT/ACPI), but IPI, TI (Timer) and PCOV (PMC) are hardcoded
>> bits, so we define get_xxx_irq() for them.
>>
>> Change-Id: I53fb0be768daeeecc90d0ccc0bb0becd3d4e6984
> 
> Please drop this Change-Id. The upstream kernel doesn't use Gerrit.
> 

Ok, I'll check it before submitting patch series to avoid this.

>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/acpi/bus.c                  |   3 +
>>   drivers/irqchip/Kconfig             |  10 +++
>>   drivers/irqchip/Makefile            |   1 +
>>   drivers/irqchip/irq-loongarch-cpu.c | 134 ++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h                |   1 +
>>   5 files changed, 149 insertions(+)
>>   create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 86fa61a..63fbf00 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1145,6 +1145,9 @@ static int __init acpi_bus_init_irq(void)
>>   	case ACPI_IRQ_MODEL_PLATFORM:
>>   		message = "platform specific model";
>>   		break;
>> +	case ACPI_IRQ_MODEL_LPIC:
>> +		message = "LPIC";
>> +		break;
> 
> This should be part of the patch that deals with the ACPI-specific
> part of the architecture, which is the following patch.
> 


Ok, I'll put the change in the following another patch.

>>   	default:
>>   		pr_info("Unknown interrupt routing model\n");
>>   		return -ENODEV;
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 4ab1038..4126b1c 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -546,6 +546,16 @@ config EXYNOS_IRQ_COMBINER
>>   	  Say yes here to add support for the IRQ combiner devices embedded
>>   	  in Samsung Exynos chips.
>>   
>> +config IRQ_LOONGARCH_CPU
>> +	bool
>> +	select GENERIC_IRQ_CHIP
>> +	select IRQ_DOMAIN
>> +	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
>> +	help
>> +	  Support for the LoongArch CPU Interrupt Controller. For details of
>> +	  irq chip hierarchy on LoongArch platforms please read the document
>> +	  Documentation/loongarch/irq-chip-model.rst.
>> +
>>   config LOONGSON_LIOINTC
>>   	bool "Loongson Local I/O Interrupt Controller"
>>   	depends on MACH_LOONGSON64
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 5b67450..6894a13 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -103,6 +103,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>>   obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
>>   obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
>> +obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
>>   obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
>>   obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
>>   obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
>> new file mode 100644
>> index 0000000..c382bd9
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +
>> +#include <asm/loongarch.h>
>> +#include <asm/setup.h>
>> +#include "irq-loongarch-pic-common.h"
>> +
>> +static struct irq_domain *irq_domain;
>> +
>> +static void mask_loongarch_irq(struct irq_data *d)
>> +{
>> +	clear_csr_ecfg(ECFGF(d->hwirq));
>> +}
>> +
>> +static void unmask_loongarch_irq(struct irq_data *d)
>> +{
>> +	set_csr_ecfg(ECFGF(d->hwirq));
>> +}
>> +
>> +static struct irq_chip cpu_irq_controller = {
>> +	.name		= "LoongArch",
> 
> Why is it "LoongArch" and not "CPUINTC", which would make a lot more
> sense?
> 

I think "CPUINTC" should make more sense, maybe Huacai think "LoongArch"
is better, like "MIPS" in mips cpu irqchip driver, but I prefer 
"CPUINTC", like "LAPIC" of x86 and "GIC" of arm, a name of irqchip 
instead of a name of an architecture.

Huacai, what do you think?

>> +	.irq_mask	= mask_loongarch_irq,
>> +	.irq_unmask	= unmask_loongarch_irq,
>> +};
>> +
>> +static void handle_cpu_irq(struct pt_regs *regs)
>> +{
>> +	int hwirq;
>> +	unsigned int estat = read_csr_estat() & CSR_ESTAT_IS;
>> +
>> +	while ((hwirq = ffs(estat))) {
>> +		estat &= ~BIT(hwirq - 1);
>> +		generic_handle_domain_irq(irq_domain, hwirq - 1);
>> +	}
>> +}
>> +
>> +int get_ipi_irq(void)
>> +{
>> +	return irq_create_mapping(irq_domain, EXCCODE_IPI - EXCCODE_INT_START);
>> +}
>> +
>> +int get_pmc_irq(void)
>> +{
>> +	return irq_create_mapping(irq_domain, EXCCODE_PMC - EXCCODE_INT_START);
>> +}
>> +
>> +int get_timer_irq(void)
>> +{
>> +	return irq_create_mapping(irq_domain, EXCCODE_TIMER - EXCCODE_INT_START);
>> +}
>> +
>> +static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
>> +			     irq_hw_number_t hwirq)
>> +{
>> +	irq_set_noprobe(irq);
>> +	irq_set_chip_and_handler(irq, &cpu_irq_controller, handle_percpu_irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
>> +	.map = loongarch_cpu_intc_map,
>> +	.xlate = irq_domain_xlate_onecell,
>> +};
>> +
>> +struct irq_domain * __init loongarch_cpu_irq_init(void)
>> +{
>> +	struct fwnode_handle *domain_handle;
>> +
>> +	/* Mask interrupts. */
>> +	clear_csr_ecfg(ECFG0_IM);
>> +	clear_csr_estat(ESTATF_IP);
>> +
>> +	domain_handle = irq_domain_alloc_fwnode(NULL);
> 
> Please don't use NULL here, as this is supposed to be a physical
> address. If you don't have any physical address at hand (because this
> driver isn't using MMIO), use irq_domain_alloc_named_fwnode() instead.
> 


Ok, I'll fix it in next version.


>> +	irq_domain = irq_domain_create_linear(domain_handle, EXCCODE_INT_NUM,
>> +					&loongarch_cpu_intc_irq_domain_ops, NULL);
>> +
>> +	if (!irq_domain)
>> +		panic("Failed to add irqdomain for LoongArch CPU");
>> +
>> +	set_handle_irq(&handle_cpu_irq);
>> +	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
> 
> lpic_get_gsi_domain_id only gets defined in the following patch, so
> the series cannot be bisected. Please fix this (the series should
> compile every step of the way).
> 


Ok, I'll fix it in next version.


>> +
>> +	return irq_domain;
>> +}
>> +
>> +static int __init
>> +liointc_parse_madt(union acpi_subtable_headers *header,
>> +		       const unsigned long end)
>> +{
>> +	struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
>> +
>> +	return liointc_acpi_init(irq_domain, liointc_entry);
>> +}
>> +
>> +static int __init
>> +eiointc_parse_madt(union acpi_subtable_headers *header,
>> +		       const unsigned long end)
>> +{
>> +	struct acpi_madt_eio_pic *eiointc_entry = (struct acpi_madt_eio_pic *)header;
>> +
>> +	return eiointc_acpi_init(irq_domain, eiointc_entry);
>> +}
>> +static int __init acpi_cascade_irqdomain_init(void)
>> +{
>> +	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
>> +			      liointc_parse_madt, 0);
>> +	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
>> +			      eiointc_parse_madt, 0);
>> +	return 0;
>> +}
>> +static int __init coreintc_acpi_init_v1(union acpi_subtable_headers *header,
>> +				   const unsigned long end)
>> +{
>> +	if (irq_domain)
>> +		return 0;
>> +
>> +	init_vector_parent_group();
>> +	loongarch_cpu_irq_init();
>> +	acpi_cascade_irqdomain_init();
>> +	return 0;
>> +}
>> +IRQCHIP_ACPI_DECLARE(coreintc_v1, ACPI_MADT_TYPE_CORE_PIC,
>> +		NULL, ACPI_MADT_CORE_PIC_VERSION_V1,
>> +		coreintc_acpi_init_v1);
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 957e23f..d2f5108 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -105,6 +105,7 @@ enum acpi_irq_model_id {
>>   	ACPI_IRQ_MODEL_IOSAPIC,
>>   	ACPI_IRQ_MODEL_PLATFORM,
>>   	ACPI_IRQ_MODEL_GIC,
>> +	ACPI_IRQ_MODEL_LPIC,
> 
> This hunk should be moved to the patch that introduces
> lpic_get_gsi_domain_id.
> 


Ok, I'll move it to the patch that introduces lpic_get_gsi_domain_id in 
next version.


> Thanks,
> 
> 	M.
> 

