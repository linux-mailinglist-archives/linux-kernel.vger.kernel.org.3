Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0758C819
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbiHHMFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbiHHMFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:05:36 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B2A825E0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:05:30 -0700 (PDT)
Received: from [10.20.42.22] (unknown [10.20.42.22])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3yMH_PBiVicKAA--.4044S3;
        Mon, 08 Aug 2022 20:05:28 +0800 (CST)
Subject: Re: [PATCH] irqchip/loongarch: Fix irq_domain_alloc_fwnode() abuse
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     chenhuacai@loongson.cn, Thomas Gleixner <tglx@linutronix.de>
References: <20220808105020.2689757-1-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <d0b93546-eb2e-029e-5124-144fa10b41d3@loongson.cn>
Date:   Mon, 8 Aug 2022 20:05:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220808105020.2689757-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx3yMH_PBiVicKAA--.4044S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4xGw43tryxuw4DGrW3Wrg_yoWrZw45pF
        W7Aa42vr45Ja4UWFnrGayUXry3Zw1Fg3y7KayrKa4a9r98G39IkF18A3ZrZFs7Ar47Wa1a
        9F4Fq3WUu3Z8AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc

Yes, I think that's right. Thanks for your patch to fix them.

On 2022/8/8 下午6:50, Marc Zyngier wrote:
> The recently merged LoongArch drivers paper over the lack of
> topology information by creating a bunch of fwnodes for the
> irqchips. So far, so good.
> 
> However, irq_domain_alloc_fwnode() is supposed to take a PA, and
> not a kernel VA blindly cast as a PA, potentially disclosing
> kernel VAs to userspace. In some other cases, even NULL is used
> as the PA, which is entertaining.
> 
> Fix this by using the actual PA of the block when available,
> and switch to a named fwnode in the other cases.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-loongarch-cpu.c    | 2 +-
>   drivers/irqchip/irq-loongson-eiointc.c | 3 ++-
>   drivers/irqchip/irq-loongson-liointc.c | 2 +-
>   drivers/irqchip/irq-loongson-pch-msi.c | 2 +-
>   drivers/irqchip/irq-loongson-pch-pic.c | 2 +-
>   5 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
> index 327f3ab62c03..741612ba6a52 100644
> --- a/drivers/irqchip/irq-loongarch-cpu.c
> +++ b/drivers/irqchip/irq-loongarch-cpu.c
> @@ -129,7 +129,7 @@ static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
>   	clear_csr_ecfg(ECFG0_IM);
>   	clear_csr_estat(ESTATF_IP);
>   
> -	cpuintc_handle = irq_domain_alloc_fwnode(NULL);
> +	cpuintc_handle = irq_domain_alloc_named_fwnode("CPUINTC");
>   	irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
>   					&loongarch_cpu_intc_irq_domain_ops, NULL);
>   
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> index bffb7b3128e8..16e9af8d8b1e 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -348,7 +348,8 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
>   	if (!priv)
>   		return -ENOMEM;
>   
> -	priv->domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_eiointc);
> +	priv->domain_handle = irq_domain_alloc_named_id_fwnode("EIOPIC",
> +							       acpi_eiointc->node);
>   	if (!priv->domain_handle) {
>   		pr_err("Unable to allocate domain handle\n");
>   		goto out_free_priv;
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index c4f3c886ad61..acd1a4b897df 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -360,7 +360,7 @@ int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic
>   	parent_irq[0] = irq_create_mapping(parent, acpi_liointc->cascade[0]);
>   	parent_irq[1] = irq_create_mapping(parent, acpi_liointc->cascade[1]);
>   
> -	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_liointc);
> +	domain_handle = irq_domain_alloc_fwnode(&acpi_liointc->address);
>   	if (!domain_handle) {
>   		pr_err("Unable to allocate domain handle\n");
>   		return -ENOMEM;
> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
> index d0e8551bebfa..a72ede90ffc6 100644
> --- a/drivers/irqchip/irq-loongson-pch-msi.c
> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
> @@ -282,7 +282,7 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
>   	int ret;
>   	struct fwnode_handle *domain_handle;
>   
> -	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
> +	domain_handle = irq_domain_alloc_fwnode(&acpi_pchmsi->msg_address);
>   	ret = pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
>   				acpi_pchmsi->count, parent, domain_handle);
>   	if (ret < 0)
> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
> index b987b6517d59..c01b9c257005 100644
> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> @@ -349,7 +349,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
>   
>   	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
>   
> -	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchpic);
> +	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
>   	if (!domain_handle) {
>   		pr_err("Unable to allocate domain handle\n");
>   		return -ENOMEM;
> 

