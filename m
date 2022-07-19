Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD74D57A103
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiGSOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241338AbiGSOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:15:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CD8B5A45D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:43:22 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9DztNZioJQoAA--.35892S3;
        Tue, 19 Jul 2022 21:43:16 +0800 (CST)
Subject: Re: [PATCH V16 13/14] irqchip: Add LoongArch CPU interrupt controller
 support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
 <1658153621-40445-14-git-send-email-lvjianmin@loongson.cn>
 <CAAhV-H6EfVhwhEvZRoNBEPhM=9-0iPbT-q0_T558d_b=zDH+sw@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <833d3c5c-7395-e195-16d3-929374d289e1@loongson.cn>
Date:   Tue, 19 Jul 2022 21:43:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6EfVhwhEvZRoNBEPhM=9-0iPbT-q0_T558d_b=zDH+sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxr9DztNZioJQoAA--.35892S3
X-Coremail-Antispam: 1UD129KBjvJXoWfJr4rAr1fXrW5CFyDJF1UKFg_yoWDAryxpF
        WUAa1qqr4UJFy8Xr909a98Wr9Ivw1fG3y2yayfKa47Ar1qyrnYkF1kZr9F9FyFk3y8Ga12
        vF4rtFWxuF4Yy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbKsjUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/18 下午11:21, Huacai Chen wrote:
> Hi, Jianmin,
> 
> On Mon, Jul 18, 2022 at 10:21 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
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
>> bits, so we expose the fwnode_handle to map them, and get mapped irq
>> by irq_create_mapping when using them.
>>
>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/irq.h    |   7 +--
>>   arch/loongarch/kernel/irq.c         |  15 ++++-
>>   arch/loongarch/kernel/time.c        |  14 ++++-
>>   drivers/irqchip/Kconfig             |  10 ++++
>>   drivers/irqchip/Makefile            |   1 +
>>   drivers/irqchip/irq-loongarch-cpu.c | 112 ++++++++++++++++++++++++++++++++++++
>>   6 files changed, 150 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
>>
>> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
>> index 67ebcc5..149b212 100644
>> --- a/arch/loongarch/include/asm/irq.h
>> +++ b/arch/loongarch/include/asm/irq.h
>> @@ -35,9 +35,6 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
>>          return (low <= sp && sp <= high);
>>   }
>>
>> -int get_ipi_irq(void);
>> -int get_pmc_irq(void);
>> -int get_timer_irq(void);
>>   void spurious_interrupt(void);
>>
>>   #define NR_IRQS_LEGACY 16
>> @@ -94,8 +91,6 @@ struct acpi_vector_group {
>>   struct acpi_madt_msi_pic;
>>   struct acpi_madt_lpc_pic;
>>
>> -struct irq_domain *loongarch_cpu_irq_init(void);
>> -
>>   int liointc_acpi_init(struct irq_domain *parent,
>>                                          struct acpi_madt_lio_pic *acpi_liointc);
>>   int eiointc_acpi_init(struct irq_domain *parent,
>> @@ -128,7 +123,7 @@ int pch_pic_acpi_init(struct irq_domain *parent,
>>   extern struct acpi_madt_msi_pic *acpi_pchmsi[MAX_IO_PICS];
>>   extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
>>
>> -extern struct irq_domain *cpu_domain;
>> +extern struct fwnode_handle *cpuintc_handle;
>>   extern struct fwnode_handle *liointc_handle;
>>   extern struct fwnode_handle *pch_lpc_handle;
>>   extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
>> index 06f2a15..99924d8 100644
>> --- a/arch/loongarch/kernel/irq.c
>> +++ b/arch/loongarch/kernel/irq.c
>> @@ -25,7 +25,6 @@
>>   DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
>>   EXPORT_PER_CPU_SYMBOL(irq_stat);
>>
>> -struct irq_domain *cpu_domain;
>>   struct acpi_vector_group pch_group[MAX_IO_PICS];
>>   struct acpi_vector_group msi_group[MAX_IO_PICS];
>>
>> @@ -89,6 +88,16 @@ static void __init init_vec_parent_group(void)
>>          acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
>>   }
>>
>> +static int __init get_ipi_irq(void)
>> +{
>> +       struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
>> +
>> +       if (d)
>> +               return irq_create_mapping(d, EXCCODE_IPI - EXCCODE_INT_START);
>> +
>> +       return -EINVAL;
>> +}
>> +
>>   void __init init_IRQ(void)
>>   {
>>          int i;
>> @@ -105,7 +114,9 @@ void __init init_IRQ(void)
>>          init_vec_parent_group();
>>          irqchip_init();
>>   #ifdef CONFIG_SMP
>> -       ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;
>> +       ipi_irq = get_ipi_irq();
>> +       if (ipi_irq < 0)
>> +               panic("IPI IRQ mapping failed\n");
>>          irq_set_percpu_devid(ipi_irq);
>>          r = request_percpu_irq(ipi_irq, loongson3_ipi_interrupt, "IPI", &ipi_dummy_dev);
>>          if (r < 0)
>> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
>> index fe68238..79dc5ed 100644
>> --- a/arch/loongarch/kernel/time.c
>> +++ b/arch/loongarch/kernel/time.c
>> @@ -123,6 +123,16 @@ void sync_counter(void)
>>          csr_write64(-init_timeval, LOONGARCH_CSR_CNTC);
>>   }
>>
>> +static int get_timer_irq(void)
>> +{
>> +       struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
>> +
>> +       if (d)
>> +               return irq_create_mapping(d, EXCCODE_TIMER - EXCCODE_INT_START);
>> +
>> +       return -EINVAL;
>> +}
>> +
>>   int constant_clockevent_init(void)
>>   {
>>          unsigned int irq;
>> @@ -132,7 +142,9 @@ int constant_clockevent_init(void)
>>          struct clock_event_device *cd;
>>          static int timer_irq_installed = 0;
>>
>> -       irq = EXCCODE_TIMER - EXCCODE_INT_START;
>> +       irq = get_timer_irq();
>> +       if (irq < 0)
>> +               pr_err("Failed to map irq %d (timer)\n", irq);
>>
>>          cd = &per_cpu(constant_clockevent_device, cpu);
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 8f077d3..f53164c 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -546,6 +546,16 @@ config EXYNOS_IRQ_COMBINER
>>            Say yes here to add support for the IRQ combiner devices embedded
>>            in Samsung Exynos chips.
>>
>> +config IRQ_LOONGARCH_CPU
>> +       bool
>> +       select GENERIC_IRQ_CHIP
>> +       select IRQ_DOMAIN
>> +       select GENERIC_IRQ_EFFECTIVE_AFF_MASK
>> +       help
>> +         Support for the LoongArch CPU Interrupt Controller. For details of
>> +         irq chip hierarchy on LoongArch platforms please read the document
>> +         Documentation/loongarch/irq-chip-model.rst.
>> +
>>   config LOONGSON_LIOINTC
>>          bool "Loongson Local I/O Interrupt Controller"
>>          depends on MACH_LOONGSON64
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 0cfd4f0..e559007 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -103,6 +103,7 @@ obj-$(CONFIG_LS1X_IRQ)                      += irq-ls1x.o
>>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)      += irq-ti-sci-intr.o
>>   obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)      += irq-ti-sci-inta.o
>>   obj-$(CONFIG_TI_PRUSS_INTC)            += irq-pruss-intc.o
>> +obj-$(CONFIG_IRQ_LOONGARCH_CPU)                += irq-loongarch-cpu.o
>>   obj-$(CONFIG_LOONGSON_LIOINTC)         += irq-loongson-liointc.o
>>   obj-$(CONFIG_LOONGSON_EIOINTC)         += irq-loongson-eiointc.o
>>   obj-$(CONFIG_LOONGSON_HTPIC)           += irq-loongson-htpic.o
>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
>> new file mode 100644
>> index 0000000..b4db430
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>> @@ -0,0 +1,112 @@
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
>> +
>> +static struct irq_domain *irq_domain;
>> +struct fwnode_handle *cpuintc_handle;
>> +
>> +static void mask_loongarch_irq(struct irq_data *d)
>> +{
>> +       clear_csr_ecfg(ECFGF(d->hwirq));
>> +}
>> +
>> +static void unmask_loongarch_irq(struct irq_data *d)
>> +{
>> +       set_csr_ecfg(ECFGF(d->hwirq));
>> +}
>> +
>> +static struct irq_chip cpu_irq_controller = {
>> +       .name           = "CPUINTC",
>> +       .irq_mask       = mask_loongarch_irq,
>> +       .irq_unmask     = unmask_loongarch_irq,
>> +};
>> +
>> +static void handle_cpu_irq(struct pt_regs *regs)
>> +{
>> +       int hwirq;
>> +       unsigned int estat = read_csr_estat() & CSR_ESTAT_IS;
>> +
>> +       while ((hwirq = ffs(estat))) {
>> +               estat &= ~BIT(hwirq - 1);
>> +               generic_handle_domain_irq(irq_domain, hwirq - 1);
>> +       }
>> +}
>> +
>> +static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
>> +                            irq_hw_number_t hwirq)
>> +{
>> +       irq_set_noprobe(irq);
>> +       irq_set_chip_and_handler(irq, &cpu_irq_controller, handle_percpu_irq);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
>> +       .map = loongarch_cpu_intc_map,
>> +       .xlate = irq_domain_xlate_onecell,
>> +};
>> +
>> +static int __init
>> +liointc_parse_madt(union acpi_subtable_headers *header,
>> +                      const unsigned long end)
>> +{
>> +       struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
>> +
>> +       return liointc_acpi_init(irq_domain, liointc_entry);
>> +}
>> +
>> +static int __init
>> +eiointc_parse_madt(union acpi_subtable_headers *header,
>> +                      const unsigned long end)
>> +{
>> +       struct acpi_madt_eio_pic *eiointc_entry = (struct acpi_madt_eio_pic *)header;
>> +
>> +       return eiointc_acpi_init(irq_domain, eiointc_entry);
>> +}
>> +
>> +static int __init acpi_cascade_irqdomain_init(void)
>> +{
>> +       acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
>> +                             liointc_parse_madt, 0);
>> +       acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
>> +                             eiointc_parse_madt, 0);
>> +       return 0;
>> +}
>> +
>> +static int __init cpuintc_acpi_init_v1(union acpi_subtable_headers *header,
>> +                                  const unsigned long end)
> Can we remove the _v1 postfix here? This can keep consistency across
> cpuintc/liointc/eiointc.
> 

Ok, thanks.


> Huacai
>> +{
>> +       if (irq_domain)
>> +               return 0;
>> +
>> +       /* Mask interrupts. */
>> +       clear_csr_ecfg(ECFG0_IM);
>> +       clear_csr_estat(ESTATF_IP);
>> +
>> +       cpuintc_handle = irq_domain_alloc_fwnode(NULL);
>> +       irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
>> +                                       &loongarch_cpu_intc_irq_domain_ops, NULL);
>> +
>> +       if (!irq_domain)
>> +               panic("Failed to add irqdomain for LoongArch CPU");
>> +
>> +       set_handle_irq(&handle_cpu_irq);
>> +       acpi_cascade_irqdomain_init();
>> +
>> +       return 0;
>> +}
>> +
>> +IRQCHIP_ACPI_DECLARE(cpuintc_v1, ACPI_MADT_TYPE_CORE_PIC,
>> +               NULL, ACPI_MADT_CORE_PIC_VERSION_V1,
>> +               cpuintc_acpi_init_v1);
>> --
>> 1.8.3.1
>>
>>

