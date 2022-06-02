Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0453B203
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiFBDQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiFBDQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:16:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81BF72ACB68
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:16:38 -0700 (PDT)
Received: from [192.168.10.143] (unknown [123.117.60.26])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cxb+aPK5hieh0NAA--.52840S3;
        Thu, 02 Jun 2022 11:16:31 +0800 (CST)
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
Message-ID: <1c7b1ee5-3f1e-c090-fb2e-65741de76a9f@loongson.cn>
Date:   Thu, 2 Jun 2022 11:16:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87a6ax6c0n.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9Cxb+aPK5hieh0NAA--.52840S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1DGF4DJr1UXr4kAFWrKrg_yoW7Ar43pr
        yrGF1UXrWUJr10qr10gw18Xr9xtr18Ja1UXw15JasrJr1DCF12qr15ur1j9r1kAr48Jr4U
        Zr1UJFW5ury3JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUnQ6pDUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Hi, Marc, according to your suggestion, I carefully looked into gic 
driver of ARM, and I found one possible gsi mapping path as following:

acpi_register_gsi /* whatever the gsi is, gic domain for ARM is only 
single domain to use.*/
  ->irq_create_fwspec_mapping
    ->irq_find_mapping /* return irq in the mapping of irqdomain with 
fwnode_handle of acpi_gsi_domain_id if configured. */
    ->irq_domain_alloc_irqs /* if not configured and hierarchy domain */
      ->irq_domain_alloc_irqs_hierarchy
        ->domain->ops->alloc /* call gic_irq_domain_alloc */
          ->gic_irq_domain_map /* handle different GSI range as 
following code: */


         switch (__get_intid_range(hw)) {
         case SGI_RANGE:
         case PPI_RANGE:
         case EPPI_RANGE:
                 irq_set_percpu_devid(irq);
                 irq_domain_set_info(d, irq, hw, chip, d->host_data,
                                     handle_percpu_devid_irq, NULL, NULL);
                 break;

         case SPI_RANGE:
         case ESPI_RANGE:
                 irq_domain_set_info(d, irq, hw, chip, d->host_data,
                                     handle_fasteoi_irq, NULL, NULL);
                 irq_set_probe(irq);
                 irqd_set_single_target(irqd);
                 break;

         case LPI_RANGE:
                 if (!gic_dist_supports_lpis())
                         return -EPERM;
                 irq_domain_set_info(d, irq, hw, chip, d->host_data,
                                     handle_fasteoi_irq, NULL, NULL);
                 break;

Yes, it's well for ARM by this way, and I found that only one 
domain(specified by acpi_gsi_domain_id)is used.

But for LoongArch, different GSI range have to be handled in different 
domain(e.g. GSI for LIOINTC irqchip can be only mapped in LIOINTC 
domain.). The hwirq->irq mapping of different GSI range is stored in 
related separate domain. The reason leading to this is that an interrupt 
source is hardcodingly to connected to an interrupt vector for these 
irqchip(LIOINTC,LPC-PIC and PCH-PIC), and the interrupt source of them 
need to be configured with GSI in DSDT or FADT(e.g. SCI).

If only exposing one domain for LoongArch, when calling irq_find_mapping 
in acpi_register_gsi flow, the irq is returned only from the domain 
specfied by acpi_gsi_domain_id, so I'm afraid it's unsuitable to expose 
a single domain for acpi_register_gsi.

I'm so sorry, I really don't find a way to reuse driver/acpi/irq.c after 
my humble work.

