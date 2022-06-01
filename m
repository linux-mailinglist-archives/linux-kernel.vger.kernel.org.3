Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D7539BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiFADf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349500AbiFADfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:35:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCC439CC8D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:35:19 -0700 (PDT)
Received: from [192.168.10.143] (unknown [58.119.4.74])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf09u3pZiLgELAA--.3288S3;
        Wed, 01 Jun 2022 11:35:11 +0800 (CST)
Subject: Re: [PATCH RFC V2 02/10] irqchip: Add LoongArch CPU interrupt
 controller support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
 <1653649335-11998-3-git-send-email-lvjianmin@loongson.cn>
 <87bkvf56wg.wl-maz@kernel.org>
 <64990891.8322.18119c6d212.Coremail.lvjianmin@loongson.cn>
 <87a6ax6c0n.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <5175d491-75d9-78bf-e82a-8eedc0d06449@loongson.cn>
Date:   Wed, 1 Jun 2022 11:35:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87a6ax6c0n.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9Dxf09u3pZiLgELAA--.3288S3
X-Coremail-Antispam: 1UD129KBjvAXoWfXr45Xw43Wr47CrWfuw47CFg_yoW8KryxCo
        Wfurn7AF1rJr1UGr1UG3yDXryYv3WUGr4kJry8ZrsxCr1Uta1jy347GFyUGay5GF1rGr47
        JFyUJr1fAFW7XF13n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYf7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xF
        o4CEbIxvr21lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUb2g4DUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/31 下午9:56, Marc Zyngier wrote:
> On Tue, 31 May 2022 12:01:09 +0100,
> 吕建民 <lvjianmin@loongson.cn> wrote:
>
> Please fix your email setup. I've done some cleanup to be able read
> your email and reply to it, but it'd be better if it was clean the
> first place.
Thanks, Marc. I'm so sorry to reply with a wrong setup computer last time.

>>> -----Original Messages-----
>>> From: "Marc Zyngier" <maz@kernel.org>
>>> Sent Time: 2022-05-31 00:20:31 (Tuesday)
>>> To: "Jianmin Lv" <lvjianmin@loongson.cn>
>>> Cc: "Thomas Gleixner" <tglx@linutronix.de>, linux-kernel@vger.kernel.org, "Xuefeng Li" <lixuefeng@loongson.cn>, "Huacai Chen" <chenhuacai@gmail.com>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Huacai Chen" <chenhuacai@loongson.cn>
>>> Subject: Re: [PATCH RFC V2 02/10] irqchip: Add LoongArch CPU interrupt controller support
>>>
>>> On Fri, 27 May 2022 12:02:12 +0100,
>>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>> We are preparing to add new Loongson (based on LoongArch, not compatible
>>>> with old MIPS-based Loongson) support. This patch add the LoongArch CPU
>>>> interrupt controller support.
>>> Please drop this paragraph, as it doesn't help at all.
>>>
>> Ok,thanks, I'll drop it.
>>
>>>> LoongArch CPUINTC stands for CSR.ECFG/CSR.ESTAT and related interrupt
>>>> controller that described in Section 7.4 of "LoongArch Reference Manual,
>>>> Vol 1". For more information please refer Documentation/loongarch/irq-
>>>> chip-model.rst.
>>> Where is this the patch adding this document?
>>>
>> See https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html
>>
> I was referring to the irq-chip-mode.rst file. I don't see it as part
> of the series, while it would probably be useful.
The irq-chip-mode.rst file is in the link: 
https://lore.kernel.org/linux-arch/20220518092619.1269111-1-chenhuacai@loongson.cn/T/#mb9699cd9aec2708b39e1c7a2a59d888dc520bb1f

>>>> LoongArch CPUINTC has 13 interrupt sources: SWI0~1, HWI0~7, IPI, TI
>>>> (Timer) and PCOV (PMC). IRQ mappings of HWI0~7 are configurable (can be
>>>> created from DT/ACPI), but IPI, TI (Timer) and PCOV (PMC) are hardcoded
>>>> bits, so we define get_xxx_irq() for them.
>>> Where are these functions? How are they used?
>>>
>> Sorry, these functions are implemented in previours version, and
>> they are deleted in current version because I changed to use legacy
>> irqdomain in this version so that we don't have to use these
>> functions to create irq mapping for IPI, PMC and TIMER. Of cause, if
>> you sugguest us to use linear irqdomain, I'll restore them to be
>> what like as last version.
> I'm not sure there is any need for them. Why does the irqchip care
> about the interrupt number of a function or the other? The hwirq->irq
> mapping is always a SW construct, and if the driver cannot extract the
> information from DT/ACPI, it can still pull the number from wherever
> it wants.
In previous version, these functions are defined as following:

int get_ipi_irq(void)
{
        return irq_create_mapping(irq_domain, EXCCODE_IPI - 
EXCCODE_INT_START);
}

int get_pmc_irq(void)
{
        return irq_create_mapping(irq_domain, EXCCODE_PMC - 
EXCCODE_INT_START);
}

int get_timer_irq(void)
{
        return irq_create_mapping(irq_domain, EXCCODE_TIMER - 
EXCCODE_INT_START);
}

After exporting these functions, in arch directory files, ipi and timer 
irq will be setuped with irq number from these functions. For example, 
in /loongarch/kernel/time.c, timer irq is setuped as following:

irq = get_timer_irq();
if (request_irq(irq, constant_timer_interrupt, IRQF_PERCPU | IRQF_TIMER, 
"timer", NULL))
     pr_err("Failed to request irq %d (timer)\n", irq);

When handing irq, the irq is fatched for the hwirq from the mapping in 
the irq_domain.

>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>> ---
>>>>   drivers/irqchip/Kconfig                    |  10 ++
>>>>   drivers/irqchip/Makefile                   |   1 +
>>>>   drivers/irqchip/irq-loongarch-cpu.c        | 115 +++++++++++++++++
>>>>   drivers/irqchip/irq-loongarch-pic-common.c | 201 +++++++++++++++++++++++++++++
>>> One patch per driver, please.
>>>
>> Ok, I'll split them to be seperate patch.
>>
>>>>   drivers/irqchip/irq-loongarch-pic-common.h |  44 +++++++
>>>>   5 files changed, 371 insertions(+)
>>>>   create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
>>>>   create mode 100644 drivers/irqchip/irq-loongarch-pic-common.c
>>>>   create mode 100644 drivers/irqchip/irq-loongarch-pic-common.h
>>>>
>>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>>> index 39d6be2..a596ee7 100644
>>>> --- a/drivers/irqchip/Kconfig
>>>> +++ b/drivers/irqchip/Kconfig
>>>> @@ -545,6 +545,16 @@ config EXYNOS_IRQ_COMBINER
>>>>   	  Say yes here to add support for the IRQ combiner devices embedded
>>>>   	  in Samsung Exynos chips.
>>>>   
>>>> +config IRQ_LOONGARCH_CPU
>>>> +	bool
>>>> +	select GENERIC_IRQ_CHIP
>>>> +	select IRQ_DOMAIN
>>>> +	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
>>>> +	help
>>>> +	  Support for the LoongArch CPU Interrupt Controller. For details of
>>>> +	  irq chip hierarchy on LoongArch platforms please read the document
>>>> +	  Documentation/loongarch/irq-chip-model.rst.
>>>> +
>>>>   config LOONGSON_LIOINTC
>>>>   	bool "Loongson Local I/O Interrupt Controller"
>>>>   	depends on MACH_LOONGSON64
>>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>>> index 160a1d8..736f030 100644
>>>> --- a/drivers/irqchip/Makefile
>>>> +++ b/drivers/irqchip/Makefile
>>>> @@ -105,6 +105,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>>>>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>>>>   obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
>>>>   obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
>>>> +obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-pic-common.o
>>>>   obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
>>>>   obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
>>>>   obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
>>>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
>>>> new file mode 100644
>>>> index 0000000..26f948f
>>>> --- /dev/null
>>>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>>>> @@ -0,0 +1,115 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>>>> + */
>>>> +
>>>> +#include <linux init.h="">
>>>> +#include <linux kernel.h="">
>>>> +#include <linux interrupt.h="">
>>>> +#include <linux irq.h="">
>>>> +#include <linux irqchip.h="">
>>>> +#include <linux irqdomain.h="">
>>>> +
>>>> +#include <asm loongarch.h="">
>>>> +#include <asm setup.h="">
>>>> +#include "irq-loongarch-pic-common.h"
>>>> +
>>>> +static struct irq_domain *irq_domain;
>>>> +
>>>> +static void mask_loongarch_irq(struct irq_data *d)
>>>> +{
>>>> +	clear_csr_ecfg(ECFGF(d->hwirq));
>>>> +}
>>>> +
>>>> +static void unmask_loongarch_irq(struct irq_data *d)
>>>> +{
>>>> +	set_csr_ecfg(ECFGF(d->hwirq));
>>>> +}
>>>> +
>>>> +static struct irq_chip cpu_irq_controller = {
>>>> +	.name		= "LoongArch",
>>>> +	.irq_mask	= mask_loongarch_irq,
>>>> +	.irq_unmask	= unmask_loongarch_irq,
>>>> +};
>>>> +
>>>> +static void handle_cpu_irq(struct pt_regs *regs)
>>>> +{
>>>> +	int hwirq;
>>>> +	unsigned int estat = read_csr_estat() &amp; CSR_ESTAT_IS;
>>>> +
>>>> +	while ((hwirq = ffs(estat))) {
>>>> +		estat &amp;= ~BIT(hwirq - 1);
>>>> +		generic_handle_domain_irq(irq_domain, hwirq - 1);
>>>> +	}
>>>> +}
>>>> +
>>>> +static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
>>>> +			     irq_hw_number_t hwirq)
>>>> +{
>>>> +	irq_set_noprobe(irq);
>>>> +	irq_set_chip_and_handler(irq, &amp;cpu_irq_controller, handle_percpu_irq);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
>>>> +	.map = loongarch_cpu_intc_map,
>>>> +	.xlate = irq_domain_xlate_onecell,
>>>> +};
>>>> +
>>>> +struct irq_domain * __init loongarch_cpu_irq_init(void)
>>>> +{
>>>> +	/* Mask interrupts. */
>>>> +	clear_csr_ecfg(ECFG0_IM);
>>>> +	clear_csr_estat(ESTATF_IP);
>>>> +
>>>> +	irq_domain = irq_domain_add_legacy(NULL, EXCCODE_INT_NUM, 0, 0,
>>>> +						&amp;loongarch_cpu_intc_irq_domain_ops, NULL);
>>> I already commented on this in the past, and my position is still the
>>> same: this isn't a legacy architecture, you are not converting
>>> anything from a board file, so there is no reason why you get to use a
>>> legacy domain.
>>>
>>> Since you are using ACPI, irq_domain_add_*() really is the wrong API,
>>> as they take an of_node. Use irq_domain_create_linear(), and pass an
>>> actual fwnode there (there are plenty of examples in the tree).
>>>
>> Sorry, as I mentioned above, the only reason that I use legacy
>> irqdomain here is to avoid to export get_xxx_irq functions for
>> others(like arch files). As you recommend here, I'll recover them in
>> next version.
>>
>>>> +	if (!irq_domain)
>>>> +		panic("Failed to add irqdomain for LoongArch CPU");
>>>> +
>>>> +	set_handle_irq(&amp;handle_cpu_irq);
>>>> +
>>>> +	return irq_domain;
>>> What uses this irq_domain in the arch code?
>>>
>> Thanks, sure, there is no need to return irq_domain， and I'll
>> change it in next version.
>>
>>>> +}
>>>> +#ifdef CONFIG_ACPI
>>> Why the #ifdef? Isn't this system supposed to be ACPI only? There is
>>> no DT support anyway, so you should make the driver depend on ACPI and
>>> that's about it.
>>>
>> Yes, we'll support DT in future(in fatct, DT for the driver has been
>> supported in our internel repo for SOC products) for the driver as
>> other irqchip drivers. Should we delete it now and take it into
>> count later when adding DT supporting?
> Drop everything that isn't immediately useful. For example, who cares
> about suspend-resume, which is half of your series? Please focus on
> the bare minimal to get your system up and running.
Ok, thanks for your suggestion, I'll drop them all in next version and 
submit them as separate series.

>>>> +static int __init
>>>> +liointc_parse_madt(union acpi_subtable_headers *header,
>>>> +		       const unsigned long end)
>>>> +{
>>>> +	struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
>>>> +
>>>> +	return liointc_acpi_init(irq_domain, liointc_entry);
>>>> +}
>>>> +
>>>> +static int __init
>>>> +eiointc_parse_madt(union acpi_subtable_headers *header,
>>>> +		       const unsigned long end)
>>>> +{
>>>> +	struct acpi_madt_eio_pic *eiointc_entry = (struct acpi_madt_eio_pic *)header;
>>>> +
>>>> +	return eiointc_acpi_init(irq_domain, eiointc_entry);
>>>> +}
>>>> +static int __init acpi_cascade_irqdomain_init(void)
>>>> +{
>>>> +	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
>>>> +			      liointc_parse_madt, 0);
>>>> +	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
>>>> +			      eiointc_parse_madt, 0);
>>>> +	return 0;
>>>> +}
>>>> +static int __init coreintc_acpi_init_v1(union acpi_subtable_headers *header,
>>>> +				   const unsigned long end)
>>>> +{
>>>> +	if (irq_domain)
>>>> +		return 0;
>>>> +
>>>> +	init_vector_parent_group();
>>>> +	loongarch_cpu_irq_init();
>>>> +	acpi_cascade_irqdomain_init();
>>>> +	return 0;
>>>> +}
>>>> +IRQCHIP_ACPI_DECLARE(coreintc_v1, ACPI_MADT_TYPE_CORE_PIC,
>>>> +		NULL, ACPI_MADT_CORE_PIC_VERSION_V1,
>>>> +		coreintc_acpi_init_v1);
>>>> +#endif
>>>> diff --git a/drivers/irqchip/irq-loongarch-pic-common.c b/drivers/irqchip/irq-loongarch-pic-common.c
>>>> new file mode 100644
>>>> index 0000000..94437e4
>>>> --- /dev/null
>>>> +++ b/drivers/irqchip/irq-loongarch-pic-common.c
>>>> @@ -0,0 +1,201 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (C) 2022 Loongson Limited, All Rights Reserved.
>>>> + */
>>>> +
>>>> +#include <linux irq.h="">
>>>> +#include <linux acpi.h="">
>>>> +#include <linux pci.h="">
>>>> +#include "irq-loongarch-pic-common.h"
>>>> +
>>>> +static struct acpi_vector_group vector_group[MAX_IO_PICS];
>>>> +struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
>>>> +
>>>> +struct irq_domain *liointc_domain;
>>>> +struct irq_domain *pch_lpc_domain;
>>>> +struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>>>> +struct irq_domain *pch_pic_domain[MAX_IO_PICS];
>>> Why isn't this static? If someone needs to know, why isn't there an
>>> accessor?
>>>
>> These irq_domains will be initialized in other irqchip
>> drivers(e.g. liointc_domain is set in liointc driver).
> Really, there shouldn't any need to keep domain references around at
> all. That's why we have fwnodes, to be able to retrive them from the
> list of existing domains. If you have to keep all these domain
> references around, you're doing something wrong.
Thanks, I got what you mean, maybe I should export fwnode_handle as 
following:

struct fwnode_handle *liointc_handle;
struct fwnode_handle *pch_lpc_handle;
struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];

and find domain by these handle in the created domins list, yes?
>>>> +
>>>> +static int find_pch_pic(u32 gsi)
>>>> +{
>>>> +	int i, start, end;
>>>> +
>>>> +	/* Find the PCH_PIC that manages this GSI. */
>>>> +	for (i = 0; i &lt; MAX_IO_PICS; i++) {
>>>> +		struct acpi_madt_bio_pic *irq_cfg = acpi_pchpic[i];
>>>> +
>>>> +		if (!irq_cfg)
>>>> +			return -1;
>>>> +
>>>> +		start = irq_cfg->gsi_base;
>>>> +		end   = irq_cfg->gsi_base + irq_cfg->size;
>>>> +		if (gsi >= start &amp;&amp; gsi &lt; end)
>>>> +			return i;
>>>> +	}
>>>> +
>>>> +	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
>>>> +	return -1;
>>>> +}
>>>> +
>>>> +int pcibios_device_add(struct pci_dev *dev)
>>>> +{
>>>> +	int id = pci_domain_nr(dev->bus);
>>>> +
>>>> +	dev_set_msi_domain(&amp;dev->dev, pch_msi_domain[id]);
>>>> +
>>>> +	return 0;
>>>> +}
>>> This doesn't belong here at all. Please move it to the PCI code.
>>>
>> Ok, I'll put them into PCI code of arch directory.
>>
>>>> +
>>>> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
>>>> +{
>>>> +	if (irqp != NULL)
>>>> +		*irqp = acpi_register_gsi(NULL, gsi, -1, -1);
>>>> +	return (*irqp >= 0) ? 0 : -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>>>> +
>>>> +int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
>>>> +{
>>>> +	if (gsi)
>>>> +		*gsi = isa_irq;
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * success: return IRQ number (>=0)
>>>> + * failure: return &lt; 0
>>>> + */
>>>> +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
>>>> +{
>>>> +	int id;
>>>> +	struct irq_fwspec fwspec;
>>>> +
>>>> +	switch (gsi) {
>>>> +	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
>>>> +		fwspec.fwnode = liointc_domain->fwnode;
>>>> +		fwspec.param[0] = gsi - GSI_MIN_CPU_IRQ;
>>>> +		fwspec.param_count = 1;
>>>> +
>>>> +		return irq_create_fwspec_mapping(&amp;fwspec);
>>>> +
>>>> +	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
>>>> +		if (!pch_lpc_domain)
>>>> +			return -EINVAL;
>>>> +
>>>> +		fwspec.fwnode = pch_lpc_domain->fwnode;
>>>> +		fwspec.param[0] = gsi - GSI_MIN_LPC_IRQ;
>>>> +		fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
>>>> +		fwspec.param_count = 2;
>>>> +
>>>> +		return irq_create_fwspec_mapping(&amp;fwspec);
>>>> +
>>>> +	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
>>>> +		id = find_pch_pic(gsi);
>>>> +		if (id &lt; 0)
>>>> +			return -EINVAL;
>>>> +
>>>> +		fwspec.fwnode = pch_pic_domain[id]->fwnode;
>>>> +		fwspec.param[0] = gsi - acpi_pchpic[id]->gsi_base;
>>>> +		fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
>>>> +		fwspec.param_count = 2;
>>>> +
>>>> +		return irq_create_fwspec_mapping(&amp;fwspec);
>>>> +	}
>>> So all the complexity here seems to stem from the fact that you deal
>>> with three ranges of interrupts, managed by three different pieces of
>>> code?
>>>
>> Yes.
>>
>>> Other architectures have similar requirements, and don't require to
>>> re-implement a private version of the ACPI API. Instead, they expose a
>>> single irqdomain, and deal with the various ranges internally.
>>>
>>> Clearly, not being able to reuse drivers/acpi/irq.c *is* an issue.
>>>
>> Thanks, I agree, that sounds a good and reasonable suggestion, and
>> I'll reserach it further and reuse code from drivers/acpi/irq.c as
>> can as possible.
>>
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(acpi_register_gsi);
>>>> +
>>>> +void acpi_unregister_gsi(u32 gsi)
>>>> +{
>>>> +	int id, irq, hw_irq;
>>>> +	struct irq_domain *d;
>>>> +
>>>> +	switch (gsi) {
>>>> +	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
>>>> +		if (!liointc_domain)
>>>> +			return;
>>>> +		d = liointc_domain;
>>>> +		hw_irq = gsi - GSI_MIN_CPU_IRQ;
>>>> +		break;
>>>> +
>>>> +	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
>>>> +		if (!pch_lpc_domain)
>>>> +			return;
>>>> +		d = pch_lpc_domain;
>>>> +		hw_irq = gsi - GSI_MIN_LPC_IRQ;
>>>> +		break;
>>>> +
>>>> +	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
>>>> +		id = find_pch_pic(gsi);
>>>> +		if (id &lt; 0)
>>>> +			return;
>>>> +		if (!pch_pic_domain[id])
>>>> +			return;
>>>> +		d = pch_pic_domain[id];
>>>> +
>>>> +		hw_irq = gsi - acpi_pchpic[id]->gsi_base;
>>>> +		break;
>>>> +	}
>>>> +	irq = irq_find_mapping(d, hw_irq);
>>>> +	irq_dispose_mapping(irq);
>>>> +
>>>> +	return;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>>>> +
>>>> +static int pci_mcfg_parse(struct acpi_table_header *header)
>>>> +{
>>>> +	struct acpi_table_mcfg *mcfg;
>>>> +	struct acpi_mcfg_allocation *mptr;
>>>> +	int i, n;
>>>> +
>>>> +	if (header->length &lt; sizeof(struct acpi_table_mcfg))
>>>> +		return -EINVAL;
>>>> +
>>>> +	n = (header->length - sizeof(struct acpi_table_mcfg)) /
>>>> +					sizeof(struct acpi_mcfg_allocation);
>>>> +	mcfg = (struct acpi_table_mcfg *)header;
>>>> +	mptr = (struct acpi_mcfg_allocation *) &amp;mcfg[1];
>>>> +
>>>> +	for (i = 0; i &lt; n; i++, mptr++)
>>>> +		vector_group[mptr->pci_segment].node = (mptr->address >> 44) &amp; 0xf;
>>>> +
>>>> +	return 0;
>>>> +}
>>> Again, why can't you reuse drivers/acpi/pci_mcfg.c?
>>>
>> Yes, I really want to reuse code from pci_mcfg.c, but I found that
>> pci_mmcfg_late_init() is called from acpi_init during
>> subsys_initcall. vector_group entries here are needed initialzed
>> during irqchip_init flow before EIOINTC, PCH PIC and PCH MSI
>> initialization as I descripted info 'Example of irqchip topology in
>> a system with two chipsets' in [PATCH RFC V2 00/10].
> I'm not sure why this is needed. Can't this be done at a later time?
> Surely, no PCI device can come up without the ACPI resources having
> been populated. And if the PCI bus comes up before, you should be able
> to defer it.
>
> In any case, this doesn't seem to belong the an irqchip driver, and is
> much more a PCI thing.
For ARM, the parent domain of pci msi domain is matched to ITS domain by 
pci segment
in IORT. For LoongArch, we didn't haveIORT-like table, so we used pci 
segment in
MCFG to match the parent domain of pci msi domain to EIOINTC domain. An 
example of
irqchip topology in a system with  two chipsets as following(same as 
[PATCH RFC V2 00/10]):

  +------------------------------------------------------------+
  |                                                            |
  |                     +------------------+                   |
  |                     |      CPUINTC     |                   |
  |                     +------------------+                   |
  |                     ^                  ^                   |
  |                     |                  |                   |
  |          +----------+                  +----------+        |
  |          | EIOINTC 0|                  | EIOINTC 1|        |
  |          +----------+                  +----------+        |
  |          ^          ^                  ^          ^        |
  |          |          |                  |          |        |
  | +----------+   +----------+   +----------+    +----------+ |
  | | PCH-PIC 0|   | PCH-MSI 0|   | PCH-PIC 1|    | PCH-MSI 1| |
  | +----------+   +----------+   +----------+    +----------+ |
  |                                                            |
  |                                                            |
  +------------------------------------------------------------+


For systems with two chipsets, there are tow group(consists of EIOINTC, 
PCH-PIC and PCH-MSI) irqdomains,
and each group has same node id. So we defined a structure to mantain 
the relation of node and it's parent irqdomain.

struct acpi_vector_group {
         int node;
         struct irq_domain *parent;
};

The initialization and use of acpi_vector_group array are following:

- Entry of struct acpi_vector_group array initialization:

By parsing MCFG, the node id£šfrom bit44-47 of Base Address£©of each pci 
segment is extracted. And from MADT, we have the node id of each EIOINTC.

entrys[pci segment].node = node id of pci segment
entrys[pci segment].parent = EIOINTC irqdomain(node id of EIOINTC == 
node id of pci segment)

- Get parent irqdomain for PCH-PIC:

 From MADT, we have the node id of each PCH-PIC(from bit44-47 of Base 
Address).
if (node of entry i == node of PCH-PIC)
         return entrys[i].parent;

entrys[pci segment].node = node id of pci segment
entrys[pci segment].parent = EIOINTC irqdomain(node id of EIOINTC == 
node id of pci segment)

- Get parent irqdomain for PCH-MSI of pci segment:

         return entrys[pci segment].parent;

Then, how to select a correct irqdomain to map irq for a device?
For devices using legacy irq behind PCH-PIC, GSI is used to select 
correct PCH-PIC irqdomain.
For devices using msi irq behind PCH-MSI, the pci segmen of the device 
is used to select correct PCH-MSI irqdomain.

I don't know whether we should create IORT-like table and add related 
code. If so, I'll create new table for LoongArch and submit it to UEFI 
and ASWG after it's verified.


> Thanks,
>
> 	M.
>

