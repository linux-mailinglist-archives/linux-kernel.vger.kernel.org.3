Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2569B53F4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiFGDlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiFGDlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:41:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4AF859968
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:41:39 -0700 (PDT)
Received: from [10.20.42.13] (unknown [10.20.42.13])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx70_hyJ5iFrgbAA--.38848S3;
        Tue, 07 Jun 2022 11:41:22 +0800 (CST)
Subject: Re: [PATCH RFC V2 02/10] irqchip: Add LoongArch CPU interrupt
 controller support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
 <1653649335-11998-3-git-send-email-lvjianmin@loongson.cn>
 <87bkvf56wg.wl-maz@kernel.org>
 <64990891.8322.18119c6d212.Coremail.lvjianmin@loongson.cn>
 <87a6ax6c0n.wl-maz@kernel.org>
 <1c7b1ee5-3f1e-c090-fb2e-65741de76a9f@loongson.cn>
 <871qw25ctt.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <0c6b88f8-c100-4068-5370-c30e95365b3c@loongson.cn>
Date:   Tue, 7 Jun 2022 11:41:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <871qw25ctt.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9Dx70_hyJ5iFrgbAA--.38848S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr43Xw43Gw4xuryDJFWkWFg_yoW8WFW3to
        WfWw13AFyrJw1UG34UGws7XFy5Zw1UGwn7J34kWrsIyr4Dt3yav3y7JrZrAayUGF1rGryk
        JFyUJryxCFW7tF1fn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUY-7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xF
        o4CEbIxvr21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/6 下午6:02, Marc Zyngier wrote:
> + Lorenzo and Hanjun who maintain the ACPI irq code
>
> On Thu, 02 Jun 2022 04:16:30 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>>>> +
>>>>>> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
>>>>>> +{
>>>>>> +	if (irqp != NULL)
>>>>>> +		*irqp = acpi_register_gsi(NULL, gsi, -1, -1);
>>>>>> +	return (*irqp >= 0) ? 0 : -EINVAL;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>>>>>> +
>>>>>> +int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
>>>>>> +{
>>>>>> +	if (gsi)
>>>>>> +		*gsi = isa_irq;
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * success: return IRQ number (>=0)
>>>>>> + * failure: return &lt; 0
>>>>>> + */
>>>>>> +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
>>>>>> +{
>>>>>> +	int id;
>>>>>> +	struct irq_fwspec fwspec;
>>>>>> +
>>>>>> +	switch (gsi) {
>>>>>> +	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
>>>>>> +		fwspec.fwnode = liointc_domain->fwnode;
>>>>>> +		fwspec.param[0] = gsi - GSI_MIN_CPU_IRQ;
>>>>>> +		fwspec.param_count = 1;
>>>>>> +
>>>>>> +		return irq_create_fwspec_mapping(&amp;fwspec);
>>>>>> +
>>>>>> +	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
>>>>>> +		if (!pch_lpc_domain)
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		fwspec.fwnode = pch_lpc_domain->fwnode;
>>>>>> +		fwspec.param[0] = gsi - GSI_MIN_LPC_IRQ;
>>>>>> +		fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
>>>>>> +		fwspec.param_count = 2;
>>>>>> +
>>>>>> +		return irq_create_fwspec_mapping(&amp;fwspec);
>>>>>> +
>>>>>> +	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
>>>>>> +		id = find_pch_pic(gsi);
>>>>>> +		if (id &lt; 0)
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		fwspec.fwnode = pch_pic_domain[id]->fwnode;
>>>>>> +		fwspec.param[0] = gsi - acpi_pchpic[id]->gsi_base;
>>>>>> +		fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
>>>>>> +		fwspec.param_count = 2;
>>>>>> +
>>>>>> +		return irq_create_fwspec_mapping(&amp;fwspec);
>>>>>> +	}
>>>>> So all the complexity here seems to stem from the fact that you deal
>>>>> with three ranges of interrupts, managed by three different pieces of
>>>>> code?
>>>>>
>>>> Yes.
>>>>
>>>>> Other architectures have similar requirements, and don't require to
>>>>> re-implement a private version of the ACPI API. Instead, they expose a
>>>>> single irqdomain, and deal with the various ranges internally.
>>>>>
>>>>> Clearly, not being able to reuse drivers/acpi/irq.c *is* an issue.
>>>>>
>>>> Thanks, I agree, that sounds a good and reasonable suggestion, and
>>>> I'll reserach it further and reuse code from drivers/acpi/irq.c as
>>>> can as possible.
>>>>
>> Hi, Marc, according to your suggestion, I carefully looked into gic
>> driver of ARM, and I found one possible gsi mapping path as following:
>>
>> acpi_register_gsi /* whatever the gsi is, gic domain for ARM is only
>> single domain to use.*/
>>   ->irq_create_fwspec_mapping
>>     ->irq_find_mapping /* return irq in the mapping of irqdomain with
>> fwnode_handle of acpi_gsi_domain_id if configured. */
>>     ->irq_domain_alloc_irqs /* if not configured and hierarchy domain */
>>       ->irq_domain_alloc_irqs_hierarchy
>>         ->domain->ops->alloc /* call gic_irq_domain_alloc */
>>           ->gic_irq_domain_map /* handle different GSI range as
>> following code: */
>>
>>
>>          switch (__get_intid_range(hw)) {
>>          case SGI_RANGE:
>>          case PPI_RANGE:
>>          case EPPI_RANGE:
>>                  irq_set_percpu_devid(irq);
>>                  irq_domain_set_info(d, irq, hw, chip, d->host_data,
>>                                      handle_percpu_devid_irq, NULL, NULL);
>>                  break;
>>
>>          case SPI_RANGE:
>>          case ESPI_RANGE:
>>                  irq_domain_set_info(d, irq, hw, chip, d->host_data,
>>                                      handle_fasteoi_irq, NULL, NULL);
>>                  irq_set_probe(irq);
>>                  irqd_set_single_target(irqd);
>>                  break;
>>
>>          case LPI_RANGE:
>>                  if (!gic_dist_supports_lpis())
>>                          return -EPERM;
>>                  irq_domain_set_info(d, irq, hw, chip, d->host_data,
>>                                      handle_fasteoi_irq, NULL, NULL);
>>                  break;
>>
>> Yes, it's well for ARM by this way, and I found that only one
>> domain(specified by acpi_gsi_domain_id)is used.
>>
>> But for LoongArch, different GSI range have to be handled in different
>> domain(e.g. GSI for LIOINTC irqchip can be only mapped in LIOINTC
>> domain.). The hwirq->irq mapping of different GSI range is stored in
>> related separate domain. The reason leading to this is that an
>> interrupt source is hardcodingly to connected to an interrupt vector
>> for these irqchip(LIOINTC,LPC-PIC and PCH-PIC), and the interrupt
>> source of them need to be configured with GSI in DSDT or
>> FADT(e.g. SCI).
>>
>> If only exposing one domain for LoongArch, when calling
>> irq_find_mapping in acpi_register_gsi flow, the irq is returned only
>> from the domain specfied by acpi_gsi_domain_id, so I'm afraid it's
>> unsuitable to expose a single domain for acpi_register_gsi.
>>
>> I'm so sorry, I really don't find a way to reuse driver/acpi/irq.c
>> after my humble work.
> I don't think reimplementing ACPI is the solution. What could be a
> reasonable approach is a way to overload the retrieval of the
> acpi_gsi_domain_id fwnode with a GSI parameter.
>
> I hacked the following patch, which will give you an idea of what I
> have in mind (only compile-tested).


Hi, Marc, thanks so much for your patch. I have verified it on my 
LoongArch machine and it works well.


BTW, in acpi_get_irq_source_fwhandle(), maybe 
acpi_get_gsi_domain_id(ctx->index) is needed to changed to 
acpi_get_gsi_domain_id(irq->interrupts[ctx->index])?


I have another question, for LoongArch, acpi_isa_irq_to_gsi is required 
to implemente, but no common version, do we need to implemente an weak 
version in driver/acpi/irq.c as following?


int __weak acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
{
         if (gsi)
                 *gsi = isa_irq;
         return 0;
}


I'll use the way you provided here to reuse driver/acpi/irq.c in next 
version. How should I do next? Should I integrate your patch into my 
next version or wait for you to merge it first?


> Thanks,
>
> 	M.
>
>  From a3fdc06a53cbcc0e6b77863aae9a7b01a0848fd0 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Mon, 6 Jun 2022 10:49:14 +0100
> Subject: [PATCH] APCI: irq: Add support for multiple GSI domains
>
> In an unfortunate departure from the ACPI spec, the LoongArch
> architecture split its GSI space across multiple interrupt
> controllers.
>
> In order to be able to reuse sthe core code and prevent
> rachitectures from reinventing an already square wheel, offer
> the arch code the ability to register a dispatcher function
> that will return the domain fwnode for a given GSI.
>
> The ARM GIC drivers are updated to support this (with a single
> domain, as intended).
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   drivers/acpi/irq.c           | 41 +++++++++++++++++++++++-------------
>   drivers/irqchip/irq-gic-v3.c | 18 ++++++++++------
>   drivers/irqchip/irq-gic.c    | 18 ++++++++++------
>   include/linux/acpi.h         |  2 +-
>   4 files changed, 51 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index c68e694fca26..6e1633ac1756 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -12,7 +12,7 @@
>   
>   enum acpi_irq_model_id acpi_irq_model;
>   
> -static struct fwnode_handle *acpi_gsi_domain_id;
> +static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
>   
>   /**
>    * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
> @@ -26,8 +26,10 @@ static struct fwnode_handle *acpi_gsi_domain_id;
>    */
>   int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>   {
> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> -							DOMAIN_BUS_ANY);
> +	struct irq_domain *d;
> +
> +	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
> +				     DOMAIN_BUS_ANY);
>   
>   	*irq = irq_find_mapping(d, gsi);
>   	/*
> @@ -53,12 +55,12 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>   {
>   	struct irq_fwspec fwspec;
>   
> -	if (WARN_ON(!acpi_gsi_domain_id)) {
> +	fwspec.fwnode = acpi_get_gsi_domain_id(gsi);
> +	if (WARN_ON(!fwspec.fwnode)) {
>   		pr_warn("GSI: No registered irqchip, giving up\n");
>   		return -EINVAL;
>   	}
>   
> -	fwspec.fwnode = acpi_gsi_domain_id;
>   	fwspec.param[0] = gsi;
>   	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
>   	fwspec.param_count = 2;
> @@ -73,13 +75,14 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
>    */
>   void acpi_unregister_gsi(u32 gsi)
>   {
> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> -							DOMAIN_BUS_ANY);
> +	struct irq_domain *d;
>   	int irq;
>   
>   	if (WARN_ON(acpi_irq_model == ACPI_IRQ_MODEL_GIC && gsi < 16))
>   		return;
>   
> +	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
> +				     DOMAIN_BUS_ANY);
>   	irq = irq_find_mapping(d, gsi);
>   	irq_dispose_mapping(irq);
>   }
> @@ -97,7 +100,8 @@ EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>    * The referenced device fwhandle or NULL on failure
>    */
>   static struct fwnode_handle *
> -acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
> +acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source,
> +			     u32 gsi)
>   {
>   	struct fwnode_handle *result;
>   	struct acpi_device *device;
> @@ -105,7 +109,7 @@ acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
>   	acpi_status status;
>   
>   	if (!source->string_length)
> -		return acpi_gsi_domain_id;
> +		return acpi_get_gsi_domain_id(gsi);
>   
>   	status = acpi_get_handle(NULL, source->string_ptr, &handle);
>   	if (WARN_ON(ACPI_FAILURE(status)))
> @@ -194,7 +198,7 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
>   			ctx->index -= irq->interrupt_count;
>   			return AE_OK;
>   		}
> -		fwnode = acpi_gsi_domain_id;
> +		fwnode = acpi_get_gsi_domain_id(ctx->index);
>   		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
>   					 irq->triggering, irq->polarity,
>   					 irq->shareable, ctx);
> @@ -207,7 +211,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
>   			ctx->index -= eirq->interrupt_count;
>   			return AE_OK;
>   		}
> -		fwnode = acpi_get_irq_source_fwhandle(&eirq->resource_source);
> +		fwnode = acpi_get_irq_source_fwhandle(&eirq->resource_source,
> +						      eirq->interrupts[ctx->index]);
>   		acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
>   					 eirq->triggering, eirq->polarity,
>   					 eirq->shareable, ctx);
> @@ -291,10 +296,10 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
>    *          GSI interrupts
>    */
>   void __init acpi_set_irq_model(enum acpi_irq_model_id model,
> -			       struct fwnode_handle *fwnode)
> +			       struct fwnode_handle *(*fn)(u32))
>   {
>   	acpi_irq_model = model;
> -	acpi_gsi_domain_id = fwnode;
> +	acpi_get_gsi_domain_id = fn;
>   }
>   
>   /**
> @@ -312,8 +317,14 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
>   					     const struct irq_domain_ops *ops,
>   					     void *host_data)
>   {
> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> -							DOMAIN_BUS_ANY);
> +	struct irq_domain *d;
> +
> +	/* This only works for the GIC model... */
> +	if (acpi_irq_model != ACPI_IRQ_MODEL_GIC)
> +		return NULL;
> +
> +	d = irq_find_matching_fwnode(acpi_get_gsi_domain_id(0),
> +				     DOMAIN_BUS_ANY);
>   
>   	if (!d)
>   		return NULL;
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 2be8dea6b6b0..87b1f53a65ec 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2357,11 +2357,17 @@ static void __init gic_acpi_setup_kvm_info(void)
>   	vgic_set_kvm_info(&gic_v3_kvm_info);
>   }
>   
> +static struct fwnode_handle *gsi_domain_handle;
> +
> +static struct fwnode_handle *gic_v3_get_gsi_domain_id(u32 gsi)
> +{
> +	return gsi_domain_handle;
> +}
> +
>   static int __init
>   gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
>   {
>   	struct acpi_madt_generic_distributor *dist;
> -	struct fwnode_handle *domain_handle;
>   	size_t size;
>   	int i, err;
>   
> @@ -2393,18 +2399,18 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
>   	if (err)
>   		goto out_redist_unmap;
>   
> -	domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
> -	if (!domain_handle) {
> +	gsi_domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
> +	if (!gsi_domain_handle) {
>   		err = -ENOMEM;
>   		goto out_redist_unmap;
>   	}
>   
>   	err = gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
> -			     acpi_data.nr_redist_regions, 0, domain_handle);
> +			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
>   	if (err)
>   		goto out_fwhandle_free;
>   
> -	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
> +	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v3_get_gsi_domain_id);
>   
>   	if (static_branch_likely(&supports_deactivate_key))
>   		gic_acpi_setup_kvm_info();
> @@ -2412,7 +2418,7 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
>   	return 0;
>   
>   out_fwhandle_free:
> -	irq_domain_free_fwnode(domain_handle);
> +	irq_domain_free_fwnode(gsi_domain_handle);
>   out_redist_unmap:
>   	for (i = 0; i < acpi_data.nr_redist_regions; i++)
>   		if (acpi_data.redist_regs[i].redist_base)
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 820404cb56bc..4c7bae0ec8f9 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1682,11 +1682,17 @@ static void __init gic_acpi_setup_kvm_info(void)
>   	vgic_set_kvm_info(&gic_v2_kvm_info);
>   }
>   
> +static struct fwnode_handle *gsi_domain_handle;
> +
> +static struct fwnode_handle *gic_v2_get_gsi_domain_id(u32 gsi)
> +{
> +	return gsi_domain_handle;
> +}
> +
>   static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
>   				   const unsigned long end)
>   {
>   	struct acpi_madt_generic_distributor *dist;
> -	struct fwnode_handle *domain_handle;
>   	struct gic_chip_data *gic = &gic_data[0];
>   	int count, ret;
>   
> @@ -1724,22 +1730,22 @@ static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
>   	/*
>   	 * Initialize GIC instance zero (no multi-GIC support).
>   	 */
> -	domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
> -	if (!domain_handle) {
> +	gsi_domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
> +	if (!gsi_domain_handle) {
>   		pr_err("Unable to allocate domain handle\n");
>   		gic_teardown(gic);
>   		return -ENOMEM;
>   	}
>   
> -	ret = __gic_init_bases(gic, domain_handle);
> +	ret = __gic_init_bases(gic, gsi_domain_handle);
>   	if (ret) {
>   		pr_err("Failed to initialise GIC\n");
> -		irq_domain_free_fwnode(domain_handle);
> +		irq_domain_free_fwnode(gsi_domain_handle);
>   		gic_teardown(gic);
>   		return ret;
>   	}
>   
> -	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
> +	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v2_get_gsi_domain_id);
>   
>   	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
>   		gicv2m_init(NULL, gic_data[0].domain);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4f82a5bc6d98..957e23f727ea 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -356,7 +356,7 @@ int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>   int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
>   
>   void acpi_set_irq_model(enum acpi_irq_model_id model,
> -			struct fwnode_handle *fwnode);
> +			struct fwnode_handle *(*)(u32));
>   
>   struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
>   					     unsigned int size,

