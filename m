Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF7E56104F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiF3EhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiF3EhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:37:01 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1032B40A1A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:36:50 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx701YKL1iyZFlAA--.13785S3;
        Thu, 30 Jun 2022 12:36:40 +0800 (CST)
Subject: Re: [PATCH V13 06/13] irqchip/loongson-pch-pic: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
 <1656329997-20524-7-git-send-email-lvjianmin@loongson.cn>
 <87v8sj1zs9.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <aa8321d5-9839-9ccf-6284-766719e980ea@loongson.cn>
Date:   Thu, 30 Jun 2022 12:36:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87v8sj1zs9.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx701YKL1iyZFlAA--.13785S3
X-Coremail-Antispam: 1UD129KBjvAXoW3tw4DKF18Cw4ftFyktry7Jrb_yoW8GFW7Co
        WfXrn2vryxJr1UA3yUGayktFy5u3Z8uayxCaykuanxur1Uta15Kw47Ga47Aa17uF18AF4x
        AFy8XwsrAa9rJFnxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYq7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAF
        z4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/29 下午7:20, Marc Zyngier wrote:
> On Mon, 27 Jun 2022 12:39:50 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> We are preparing to add new Loongson (based on LoongArch, not compatible
>> with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
>> as its boot protocol, so add ACPI init support.
> 
> Drop this paragraph.
> 

Ok, I'll drop it for the patch and other patches of this series.


>>
>> PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
>> Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
>> please refer Documentation/loongarch/irq-chip-model.rst.
>>
>> For systems with two chipsets, there are two related pch irqdomains,
>> each of which has the same node id as its parent irqdomain. So we
>> defined a structure to mantain the relation of node and it's parent
>> irqdomain.
>>
>> struct acpi_vector_group {
>>          int node;
>>          struct irq_domain *parent;
>> };
>>
>> The parent irqdomain will be set for node id in parent irqdomain driver
>> before pch irqdomain is created.
>>
>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/irq.h       |  11 +-
>>   arch/loongarch/kernel/irq.c            |   2 +-
>>   drivers/irqchip/irq-loongson-pch-pic.c | 200 ++++++++++++++++++++++++++++-----
>>   3 files changed, 179 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
>> index 48c0ce4..a444dc6 100644
>> --- a/arch/loongarch/include/asm/irq.h
>> +++ b/arch/loongarch/include/asm/irq.h
>> @@ -48,6 +48,12 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
>>   #define MAX_IO_PICS 2
>>   #define NR_IRQS	(64 + (256 * MAX_IO_PICS))
>>   
>> +struct acpi_vector_group {
>> +	int node;
>> +	struct irq_domain *parent;
>> +};
>> +extern struct acpi_vector_group pch_group[MAX_IO_PICS];
>> +
>>   #define CORES_PER_EIO_NODE	4
>>   
>>   #define LOONGSON_CPU_UART0_VEC		10 /* CPU UART0 */
>> @@ -108,8 +114,7 @@ int pch_lpc_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_lpc_pic *acpi_pchlpc);
>>   struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_msi_pic *acpi_pchmsi);
>> -struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
>> -					struct acpi_madt_bio_pic *acpi_pchpic);
>> +int find_pch_pic(u32 gsi);
>>   
>>   extern struct acpi_madt_lio_pic *acpi_liointc;
>>   extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
>> @@ -123,7 +128,7 @@ struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
>>   extern struct irq_domain *liointc_domain;
>>   extern struct fwnode_handle *pch_lpc_handle;
>>   extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>> -extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
>> +extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>>   
>>   extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
>>   
>> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
>> index 07d6059..f2115be 100644
>> --- a/arch/loongarch/kernel/irq.c
>> +++ b/arch/loongarch/kernel/irq.c
>> @@ -28,7 +28,7 @@
>>   struct irq_domain *cpu_domain;
>>   struct irq_domain *liointc_domain;
>>   struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>> -struct irq_domain *pch_pic_domain[MAX_IO_PICS];
>> +struct acpi_vector_group pch_group[MAX_IO_PICS];
>>   
>>   /*
>>    * 'what should we do if we get a hw irq event on an illegal vector'.
>> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
>> index a4eb8a2..170a5b9 100644
>> --- a/drivers/irqchip/irq-loongson-pch-pic.c
>> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
>> @@ -33,13 +33,40 @@
>>   #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
>>   #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
>>   
>> +static int nr_pics;
>> +
>>   struct pch_pic {
>>   	void __iomem		*base;
>>   	struct irq_domain	*pic_domain;
>> +	struct fwnode_handle	*domain_handle;
>>   	u32			ht_vec_base;
>>   	raw_spinlock_t		pic_lock;
>> +	u32			gsi_end;
>> +	u32			gsi_base;
>>   };
>>   
>> +static struct pch_pic *pch_pic_priv[2];
> 
> Why 2? Is that related to MAX_IO_PICS being 2?
> 

Yes, thanks, I should use MAX_IO_PICS for it.


>> +struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>> +
>> +int find_pch_pic(u32 gsi)
>> +{
>> +	int i;
>> +
>> +	/* Find the PCH_PIC that manages this GSI. */
>> +	for (i = 0; i < MAX_IO_PICS; i++) {
>> +		struct pch_pic *priv = pch_pic_priv[i];
>> +
>> +		if (!priv)
>> +			return -1;
>> +
>> +		if (gsi >= priv->gsi_base && gsi <= priv->gsi_end)
>> +			return i;
>> +	}
>> +
>> +	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
>> +	return -1;
>> +}
>> +
>>   static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
>>   {
>>   	u32 reg;
>> @@ -139,6 +166,24 @@ static void pch_pic_ack_irq(struct irq_data *d)
>>   	.irq_set_type		= pch_pic_set_type,
>>   };
>>   
>> +static int pch_pic_domain_translate(struct irq_domain *d,
>> +					struct irq_fwspec *fwspec,
>> +					unsigned long *hwirq,
>> +					unsigned int *type)
>> +{
>> +	struct pch_pic *priv = d->host_data;
>> +	struct device_node *of_node = to_of_node(fwspec->fwnode);
>> +
>> +	if (fwspec->param_count < 1)
>> +		return -EINVAL;
>> +	if (of_node)
>> +		*hwirq += priv->ht_vec_base;
>> +	else
>> +		*hwirq = fwspec->param[0] - priv->gsi_base;
>> +	*type = IRQ_TYPE_NONE;
> 
> Have you tested this on MIPS HW? This looks like a regression on the
> OF path, as it used irq_domain_translate_twocell().
> 

No, I don't test on MIPS for this version patch, I want to use 'of_node' 
to distinguish MIPS and LoongArch, but it seems that there is still 
other problem, I'll fix it as following in next version and test it on MIPS.


  if (of_node) {
      *hwirq = fwspec->param[0] + priv->ht_vec_base;
      *type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
  } else {
      *hwirq = fwspec->param[0] - priv->gsi_base;
      *type = IRQ_TYPE_NONE;
  }



>> +
>> +	return 0;
>> +}
>>   static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
>>   			      unsigned int nr_irqs, void *arg)
>>   {
>> @@ -149,13 +194,13 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
>>   	struct irq_fwspec parent_fwspec;
>>   	struct pch_pic *priv = domain->host_data;
>>   
>> -	err = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
>> +	err = pch_pic_domain_translate(domain, fwspec, &hwirq, &type);
>>   	if (err)
>>   		return err;
>>   
>>   	parent_fwspec.fwnode = domain->parent->fwnode;
>>   	parent_fwspec.param_count = 1;
>> -	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
>> +	parent_fwspec.param[0] = hwirq;
>>   
>>   	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
>>   	if (err)
>> @@ -170,7 +215,7 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
>>   }
>>   
>>   static const struct irq_domain_ops pch_pic_domain_ops = {
>> -	.translate	= irq_domain_translate_twocell,
>> +	.translate	= pch_pic_domain_translate,
>>   	.alloc		= pch_pic_alloc,
>>   	.free		= irq_domain_free_irqs_parent,
>>   };
>> @@ -180,7 +225,7 @@ static void pch_pic_reset(struct pch_pic *priv)
>>   	int i;
>>   
>>   	for (i = 0; i < PIC_COUNT; i++) {
>> -		/* Write vectored ID */
>> +		/* Write vector ID */
>>   		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
>>   		/* Hardcode route to HT0 Lo */
>>   		writeb(1, priv->base + PCH_INT_ROUTE(i));
>> @@ -198,50 +243,41 @@ static void pch_pic_reset(struct pch_pic *priv)
>>   	}
>>   }
>>   
>> -static int pch_pic_of_init(struct device_node *node,
>> -				struct device_node *parent)
>> +static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
>> +			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle,
>> +			u32 gsi_base)
>>   {
>> +	int vec_count;
>>   	struct pch_pic *priv;
>> -	struct irq_domain *parent_domain;
>> -	int err;
>>   
>>   	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>   	if (!priv)
>>   		return -ENOMEM;
>>   
>>   	raw_spin_lock_init(&priv->pic_lock);
>> -	priv->base = of_iomap(node, 0);
>> -	if (!priv->base) {
>> -		err = -ENOMEM;
>> +	priv->base = ioremap(addr, size);
>> +	if (!priv->base)
>>   		goto free_priv;
>> -	}
>>   
>> -	parent_domain = irq_find_host(parent);
>> -	if (!parent_domain) {
>> -		pr_err("Failed to find the parent domain\n");
>> -		err = -ENXIO;
>> -		goto iounmap_base;
>> -	}
>> +	priv->domain_handle = domain_handle;
>>   
>> -	if (of_property_read_u32(node, "loongson,pic-base-vec",
>> -				&priv->ht_vec_base)) {
>> -		pr_err("Failed to determine pic-base-vec\n");
>> -		err = -EINVAL;
>> -		goto iounmap_base;
>> -	}
>> +	priv->ht_vec_base = vec_base;
> 
> Why isn't this pre-filled on the OF path as it isn't relevant to ACPI?
> 

No, ht_vec_base is required for both of OF and ACPI.
pch_pic_init is called from pch_pic_of_init for OF path and from 
pch_pic_init_irqdomain for ACPI path, so the 'vec_base' is passed into 
pch_pic_init to pre-fill 'ht_vec_base' from both path.


>> +	vec_count = ((readq(priv->base) >> 48) & 0xff) + 1;
> 
> Is that valid on the old HW?
> 

Yes.


>> +	priv->gsi_base = gsi_base;
> 
> Why isn't this pre-filled on the ACPI path as it isn't relevant to OF?
> 

Yes, it's only for ACPI.


>> +	priv->gsi_end = gsi_base + vec_count - 1;
> 
> I don't think this needs to be ACPI specific. Just track the vector
> count, which applies to both ACPI and DT.
> 

Agree, thanks for your suggestion, tracking vector count is enough for both.

>>
>>   	priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
>> -						       PIC_COUNT,
>> -						       of_node_to_fwnode(node),
>> -						       &pch_pic_domain_ops,
>> -						       priv);
>> +						vec_count, priv->domain_handle,
>> +						&pch_pic_domain_ops, priv);
>> +
>>   	if (!priv->pic_domain) {
>>   		pr_err("Failed to create IRQ domain\n");
>> -		err = -ENOMEM;
>>   		goto iounmap_base;
>>   	}
>>   
>>   	pch_pic_reset(priv);
>> +	pch_pic_handle[nr_pics] = domain_handle;
>> +	pch_pic_priv[nr_pics++] = priv;
>>   
>>   	return 0;
>>   
>> @@ -250,7 +286,111 @@ static int pch_pic_of_init(struct device_node *node,
>>   free_priv:
>>   	kfree(priv);
>>   
>> -	return err;
>> +	return -EINVAL;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +
>> +static int pch_pic_of_init(struct device_node *node,
>> +				struct device_node *parent)
>> +{
>> +	int err, vec_base;
>> +	struct resource res;
>> +	struct irq_domain *parent_domain;
>> +
>> +	if (of_address_to_resource(node, 0, &res))
>> +		return -EINVAL;
>> +
>> +	parent_domain = irq_find_host(parent);
>> +	if (!parent_domain) {
>> +		pr_err("Failed to find the parent domain\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	if (of_property_read_u32(node, "loongson,pic-base-vec", &vec_base)) {
>> +		pr_err("Failed to determine pic-base-vec\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = pch_pic_init(res.start, resource_size(&res), vec_base,
>> +				parent_domain, of_node_to_fwnode(node), 0);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	return 0;
>>   }
>>   
>>   IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
>> +
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +static int __init
>> +lpcintc_parse_madt(union acpi_subtable_headers *header,
>> +		       const unsigned long end)
>> +{
>> +	struct acpi_madt_lpc_pic *lpcintc_entry = (struct acpi_madt_lpc_pic *)header;
>> +
>> +	return pch_lpc_acpi_init(pch_pic_priv[0]->pic_domain, lpcintc_entry);
>> +}
>> +
>> +static int __init acpi_cascade_irqdomain_init(void)
>> +{
>> +	acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC,
>> +			      lpcintc_parse_madt, 0);
>> +	return 0;
>> +}
> 
> Missing blank line between functions
> 

Ok, thanks for your correction.


>> +int __init pch_pic_init_irqdomain(struct irq_domain *parent,
>> +					struct acpi_madt_bio_pic *acpi_pchpic)
>> +{
>> +	int ret, vec_base;
>> +	struct fwnode_handle *domain_handle;
>> +
>> +	if (!acpi_pchpic)
>> +		return -EINVAL;
>> +
>> +	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
>> +
>> +	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchpic);
>> +	if (!domain_handle) {
>> +		pr_err("Unable to allocate domain handle\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
>> +				vec_base, parent, domain_handle, acpi_pchpic->gsi_base);
>> +	if (ret == 0 && acpi_pchpic->id == 0)
>> +		acpi_cascade_irqdomain_init();
>> +
>> +	return ret;
>> +}
>> +
>> +struct irq_domain *acpi_get_pch_parent(int node)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < MAX_IO_PICS; i++) {
>> +		if (node == pch_group[i].node)
>> +			return pch_group[i].parent;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static int __init pchintc_parse_madt(union acpi_subtable_headers *header,
>> +		       const unsigned long end)
>> +{
>> +	struct acpi_madt_bio_pic *pch_pic_entry = (struct acpi_madt_bio_pic *)header;
>> +
>> +	return pch_pic_init_irqdomain(acpi_get_pch_parent((pch_pic_entry->address >> 44) & 0xf),
>> +										pch_pic_entry);
>> +}
>> +
>> +static int __init pch_pic_acpi_init(void)
>> +{
>> +	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
> 
> Where is this defined? It only appears in the documentation, and
> nowhere else...
> 

It's defined in the patch to ACPICA(which has been merged, please to see 
https://github.com/acpica/acpica/commit/1dc530059a3e6202e941e6a9478cf30f092bfb47).
the patch will be synchronized to linux kernel by maintainer of ACPICA.


>> +			      pchintc_parse_madt, 0);
>> +
>> +	return 0;
>> +}
>> +early_initcall(pch_pic_acpi_init);
> 
> Why can't you use IRQCHIP_ACPI_DECLARE here? This is terribly fragile,
> and will eventually break. I really don't want to rely on this.
> 

In early time, the change here is implemented using 
IRQCHIP_ACPI_DECLARE, but we found that calling order(during 
irqchip_init) of the entry declared using IRQCHIP_ACPI_DECLARE is 
depended on the compiling order(driver order in Makefile) of the driver. 
For removing the dependency to the compiling order, the new way here is 
used(I looked into ARM, it seems that GIC driver uses 
IRQCHIP_ACPI_DECLARE, and ITS driver uses early_initcall too.).


> 	M.
> 

