Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D790056B299
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiGHGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiGHGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:13:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 775F82612C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:13:11 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx39Ltysdiz8AQAA--.4737S3;
        Fri, 08 Jul 2022 14:13:02 +0800 (CST)
Subject: Re: [PATCH V14 10/15] irqchip/loongson-liointc: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
 <1656837932-18257-11-git-send-email-lvjianmin@loongson.cn>
 <874jztmctd.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <9ab0b6ca-c515-a653-65c0-005af782da23@loongson.cn>
Date:   Fri, 8 Jul 2022 14:13:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <874jztmctd.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx39Ltysdiz8AQAA--.4737S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AryDGrW7Kw18CFWDZF18Krg_yoW3CrWrpF
        WUA3Wqya15GFy7WrWvqF4DZFyayr43KFs2va1fGa4fJF1DXwnYkFn5WFnrCF43C3y8GFW0
        vF4rK3WxCF45Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
        6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
        MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/7 下午6:34, Marc Zyngier wrote:
> On Sun, 03 Jul 2022 09:45:27 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> LIOINTC stands for "Legacy I/O Interrupts" that described in Section
>> 11.1 of "Loongson 3A5000 Processor Reference Manual". For more
>> information please refer Documentation/loongarch/irq-chip-model.rst.
>>
>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/irq.h       |   4 +-
>>   arch/loongarch/kernel/irq.c            |   1 -
>>   drivers/irqchip/irq-loongson-liointc.c | 227 ++++++++++++++++++++++-----------
>>   3 files changed, 154 insertions(+), 78 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
>> index 8775dc6..b4c7956 100644
>> --- a/arch/loongarch/include/asm/irq.h
>> +++ b/arch/loongarch/include/asm/irq.h
>> @@ -97,7 +97,7 @@ static inline void eiointc_enable(void)
>>   
>>   struct irq_domain *loongarch_cpu_irq_init(void);
>>   
>> -struct irq_domain *liointc_acpi_init(struct irq_domain *parent,
>> +int liointc_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_lio_pic *acpi_liointc);
>>   struct irq_domain *eiointc_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_eio_pic *acpi_eiointc);
>> @@ -122,7 +122,7 @@ int pch_pic_acpi_init(struct irq_domain *parent,
>>   extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
>>   
>>   extern struct irq_domain *cpu_domain;
>> -extern struct irq_domain *liointc_domain;
>> +extern struct fwnode_handle *liointc_handle;
>>   extern struct fwnode_handle *pch_lpc_handle;
>>   extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>>   
>> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
>> index ce21281..b04201c 100644
>> --- a/arch/loongarch/kernel/irq.c
>> +++ b/arch/loongarch/kernel/irq.c
>> @@ -26,7 +26,6 @@
>>   EXPORT_PER_CPU_SYMBOL(irq_stat);
>>   
>>   struct irq_domain *cpu_domain;
>> -struct irq_domain *liointc_domain;
>>   
>>   /*
>>    * 'what should we do if we get a hw irq event on an illegal vector'.
>> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
>> index 8d05d8b..526ade4 100644
>> --- a/drivers/irqchip/irq-loongson-liointc.c
>> +++ b/drivers/irqchip/irq-loongson-liointc.c
>> @@ -23,7 +23,7 @@
>>   #endif
>>   
>>   #define LIOINTC_CHIP_IRQ	32
>> -#define LIOINTC_NUM_PARENT 4
>> +#define LIOINTC_NUM_PARENT	4
>>   #define LIOINTC_NUM_CORES	4
>>   
>>   #define LIOINTC_INTC_CHIP_START	0x20
>> @@ -58,6 +58,8 @@ struct liointc_priv {
>>   	bool				has_lpc_irq_errata;
>>   };
>>   
>> +struct fwnode_handle *liointc_handle;
>> +
>>   static void liointc_chained_handle_irq(struct irq_desc *desc)
>>   {
>>   	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
>> @@ -153,97 +155,82 @@ static void liointc_resume(struct irq_chip_generic *gc)
>>   	irq_gc_unlock_irqrestore(gc, flags);
>>   }
>>   
>> -static const char * const parent_names[] = {"int0", "int1", "int2", "int3"};
>> -static const char * const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
>> +static int parent_irq[LIOINTC_NUM_PARENT];
>> +static u32 parent_int_map[LIOINTC_NUM_PARENT];
>> +static const char *const parent_names[] = {"int0", "int1", "int2", "int3"};
>> +static const char *const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
>>   
>> -static void __iomem *liointc_get_reg_byname(struct device_node *node,
>> -						const char *name)
>> +#ifdef CONFIG_ACPI
>> +static int liointc_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
>> +			     const u32 *intspec, unsigned int intsize,
>> +			     unsigned long *out_hwirq, unsigned int *out_type)
>>   {
>> -	int index = of_property_match_string(node, "reg-names", name);
>> -
>> -	if (index < 0)
>> -		return NULL;
>> -
>> -	return of_iomap(node, index);
>> +	if (WARN_ON(intsize < 1))
>> +		return -EINVAL;
>> +	*out_hwirq = intspec[0] - GSI_MIN_CPU_IRQ;
>> +	*out_type = IRQ_TYPE_NONE;
>> +	return 0;
>>   }
>>   
>> -static int __init liointc_of_init(struct device_node *node,
>> -				  struct device_node *parent)
>> +const struct irq_domain_ops acpi_irq_gc_ops = {
> 
> This should be static.
> 

Ok, thanks, I'll change it.


>> +	.map	= irq_map_generic_chip,
>> +	.unmap  = irq_unmap_generic_chip,
>> +	.xlate	= liointc_domain_xlate,
>> +};
>> +#endif
>> +
>> +static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
>> +		struct fwnode_handle *domain_handle, struct device_node *node)
>>   {
>> +	int i, err;
>> +	void __iomem *base;
>> +	struct irq_chip_type *ct;
>>   	struct irq_chip_generic *gc;
>>   	struct irq_domain *domain;
>> -	struct irq_chip_type *ct;
>>   	struct liointc_priv *priv;
>> -	void __iomem *base;
>> -	u32 of_parent_int_map[LIOINTC_NUM_PARENT];
>> -	int parent_irq[LIOINTC_NUM_PARENT];
>> -	bool have_parent = FALSE;
>> -	int sz, i, err = 0;
>>   
>>   	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>   	if (!priv)
>>   		return -ENOMEM;
>>   
>> -	if (of_device_is_compatible(node, "loongson,liointc-2.0")) {
>> -		base = liointc_get_reg_byname(node, "main");
>> -		if (!base) {
>> -			err = -ENODEV;
>> -			goto out_free_priv;
>> -		}
>> +	base = ioremap(addr, size);
>> +	if (!base)
>> +		goto out_free_priv;
>>   
>> -		for (i = 0; i < LIOINTC_NUM_CORES; i++)
>> -			priv->core_isr[i] = liointc_get_reg_byname(node, core_reg_names[i]);
>> -		if (!priv->core_isr[0]) {
>> -			err = -ENODEV;
>> -			goto out_iounmap_base;
>> -		}
>> -	} else {
>> -		base = of_iomap(node, 0);
>> -		if (!base) {
>> -			err = -ENODEV;
>> -			goto out_free_priv;
>> -		}
>> +	for (i = 0; i < LIOINTC_NUM_CORES; i++)
>> +		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
>>   
>> -		for (i = 0; i < LIOINTC_NUM_CORES; i++)
>> -			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
>> -	}
>> +	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
>> +		priv->handler[i].parent_int_map = parent_int_map[i];
>>   
>> -	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
>> -		parent_irq[i] = of_irq_get_byname(node, parent_names[i]);
>> -		if (parent_irq[i] > 0)
>> -			have_parent = TRUE;
>> -	}
>> -	if (!have_parent) {
>> -		err = -ENODEV;
>> -		goto out_iounmap_isr;
>> -	}
>> +	if (revision > 1) {
>> +		for (i = 0; i < LIOINTC_NUM_CORES; i++) {
>> +			int index = of_property_match_string(node,
>> +					"reg-names", core_reg_names[i]);
>>   
>> -	sz = of_property_read_variable_u32_array(node,
>> -						"loongson,parent_int_map",
>> -						&of_parent_int_map[0],
>> -						LIOINTC_NUM_PARENT,
>> -						LIOINTC_NUM_PARENT);
>> -	if (sz < 4) {
>> -		pr_err("loongson-liointc: No parent_int_map\n");
>> -		err = -ENODEV;
>> -		goto out_iounmap_isr;
>> -	}
>> +			if (index < 0)
>> +				return -EINVAL;
>>   
>> -	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
>> -		priv->handler[i].parent_int_map = of_parent_int_map[i];
>> +			priv->core_isr[i] = of_iomap(node, index);
>> +		}
>> +	}
>>   
>>   	/* Setup IRQ domain */
>> -	domain = irq_domain_add_linear(node, 32,
>> +#ifdef CONFIG_ACPI
>> +	domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
>> +					&acpi_irq_gc_ops, priv);
>> +#else
>> +	domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
>>   					&irq_generic_chip_ops, priv);
>> +#endif
> 
> This feels wrong. The ACPI vs OF decision should be a runtime
> one. Maybe you don't have that issue yet because MIPS is only OF and
> LoongArch only ACPI, but it remains that this should be done
> dynamically.
> 
> Please try to rewrite it as:
> 
> 	if (!acpi_disabled)
> 		[... ACPI stuff ...]
> 	else
> 		[... OF stuff ...]
> 
> This should apply to all other cases where you have similar distinctions.
> 

Ok, thanks, I'll change all the patch series according to your 
suggestion here.


> Thanks,
> 
> 	M.
> 

