Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297C54C78CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiB1Tai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiB1Tah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:30:37 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DEF120EAF;
        Mon, 28 Feb 2022 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646076588; x=1677612588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w5CiYDbdNUlxrAQe0dmDd/g10ZXmQOIeCXoLQYICtJ4=;
  b=j50H539QlrCFYLg28nzmSLUi+BKr1a5g+ePDkbYAlLLlh7KRBJ8GxoTB
   7Zce8vrszgRbda3tOdY9Wrjtummv0p88mIaKWqR8USAcDt1FlO8MIRtjp
   DVZxkZ4JRDD5pl2P/VcQug0uZdEU3V+iGObAOFUlC888+ufktuJ3MErlL
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2022 11:29:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 11:29:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 11:29:47 -0800
Received: from [10.216.31.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 28 Feb
 2022 11:29:45 -0800
Message-ID: <22ac147c-fb47-fc8c-8e10-8e67db94fbf8@quicinc.com>
Date:   Tue, 1 Mar 2022 00:59:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/5] irqchip/qcom-pdc: Kill non-wakeup irqdomain
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-msm@vger.kernel.org>
References: <20220224101226.88373-1-maz@kernel.org>
 <20220224101226.88373-3-maz@kernel.org>
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20220224101226.88373-3-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/24/2022 3:42 PM, Marc Zyngier wrote:
> A careful look at the way the PDC driver works shows that:
>
> - all interrupts are in the same space
> - all interrupts are treated the same
>
> And yet the driver creates two domains based on whether
> the interrupt gets mapped directly or from the pinctrl code,
> which is obviously a waste of resources.
The GPIO is kept under separate domain to handle extra configuration for 
wake GPIO handling.

On targets like SM8150/SM8250 each wake up capable GPIO (if totan n) 
line has dedicated parent PDC irq (if total m, n = m) associated with it.
However on targets like sdx55 PDC has muxes where each wake GPIO (if 
total n) line goes through each PDC muxes (if total m, n > m) and
any of these muxes can be used to route any one GPIO to PDC (and parent 
GIC) but unlike other targets it doesn't have one to one mapping for 
GPIO to GIC interrupt.
So this will need to be kept as is to support sdx55 target.

Thanks,
Maulik
>
> Kill the non-wakeup domain and unify all the interrupt handling.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/qcom-pdc.c | 84 +++++---------------------------------
>   1 file changed, 10 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index 3b214c4e6755..5be531403f50 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -21,7 +21,6 @@
>   #include <linux/slab.h>
>   #include <linux/types.h>
>   
> -#define PDC_MAX_IRQS		168
>   #define PDC_MAX_GPIO_IRQS	256
>   
>   #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
> @@ -224,51 +223,6 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
>   	unsigned int type;
>   	int ret;
>   
> -	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
> -	if (ret)
> -		return ret;
> -
> -	ret  = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> -					     &qcom_pdc_gic_chip, NULL);
> -	if (ret)
> -		return ret;
> -
> -	region = get_pin_region(hwirq);
> -	if (!region)
> -		return irq_domain_disconnect_hierarchy(domain->parent, virq);
> -
> -	if (type & IRQ_TYPE_EDGE_BOTH)
> -		type = IRQ_TYPE_EDGE_RISING;
> -
> -	if (type & IRQ_TYPE_LEVEL_MASK)
> -		type = IRQ_TYPE_LEVEL_HIGH;
> -
> -	parent_fwspec.fwnode      = domain->parent->fwnode;
> -	parent_fwspec.param_count = 3;
> -	parent_fwspec.param[0]    = 0;
> -	parent_fwspec.param[1]    = pin_to_hwirq(region, hwirq);
> -	parent_fwspec.param[2]    = type;
> -
> -	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> -					    &parent_fwspec);
> -}
> -
> -static const struct irq_domain_ops qcom_pdc_ops = {
> -	.translate	= qcom_pdc_translate,
> -	.alloc		= qcom_pdc_alloc,
> -	.free		= irq_domain_free_irqs_common,
> -};
> -
> -static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
> -			       unsigned int nr_irqs, void *data)
> -{
> -	struct irq_fwspec *fwspec = data;
> -	struct irq_fwspec parent_fwspec;
> -	struct pdc_pin_region *region;
> -	irq_hw_number_t hwirq;
> -	unsigned int type;
> -	int ret;
> -
>   	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
>   	if (ret)
>   		return ret;
> @@ -301,16 +255,9 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
>   					    &parent_fwspec);
>   }
>   
> -static int qcom_pdc_gpio_domain_select(struct irq_domain *d,
> -				       struct irq_fwspec *fwspec,
> -				       enum irq_domain_bus_token bus_token)
> -{
> -	return bus_token == DOMAIN_BUS_WAKEUP;
> -}
> -
> -static const struct irq_domain_ops qcom_pdc_gpio_ops = {
> -	.select		= qcom_pdc_gpio_domain_select,
> -	.alloc		= qcom_pdc_gpio_alloc,
> +static const struct irq_domain_ops qcom_pdc_ops = {
> +	.translate	= qcom_pdc_translate,
> +	.alloc		= qcom_pdc_alloc,
>   	.free		= irq_domain_free_irqs_common,
>   };
>   
> @@ -361,7 +308,7 @@ static int pdc_setup_pin_mapping(struct device_node *np)
>   
>   static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>   {
> -	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
> +	struct irq_domain *parent_domain, *pdc_domain;
>   	int ret;
>   
>   	pdc_base = of_iomap(node, 0);
> @@ -383,32 +330,21 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>   		goto fail;
>   	}
>   
> -	pdc_domain = irq_domain_create_hierarchy(parent_domain, 0, PDC_MAX_IRQS,
> -						 of_fwnode_handle(node),
> -						 &qcom_pdc_ops, NULL);
> -	if (!pdc_domain) {
> -		pr_err("%pOF: GIC domain add failed\n", node);
> -		ret = -ENOMEM;
> -		goto fail;
> -	}
> -
> -	pdc_gpio_domain = irq_domain_create_hierarchy(parent_domain,
> +	pdc_domain = irq_domain_create_hierarchy(parent_domain,
>   					IRQ_DOMAIN_FLAG_QCOM_PDC_WAKEUP,
>   					PDC_MAX_GPIO_IRQS,
>   					of_fwnode_handle(node),
> -					&qcom_pdc_gpio_ops, NULL);
> -	if (!pdc_gpio_domain) {
> -		pr_err("%pOF: PDC domain add failed for GPIO domain\n", node);
> +					&qcom_pdc_ops, NULL);
> +	if (!pdc_domain) {
> +		pr_err("%pOF: PDC domain add failed\n", node);
>   		ret = -ENOMEM;
> -		goto remove;
> +		goto fail;
>   	}
>   
> -	irq_domain_update_bus_token(pdc_gpio_domain, DOMAIN_BUS_WAKEUP);
> +	irq_domain_update_bus_token(pdc_domain, DOMAIN_BUS_WAKEUP);
>   
>   	return 0;
>   
> -remove:
> -	irq_domain_remove(pdc_domain);
>   fail:
>   	kfree(pdc_region);
>   	iounmap(pdc_base);
