Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD49471920
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhLLHa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:30:28 -0500
Received: from marcansoft.com ([212.63.210.85]:38104 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLLHa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:30:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1B362424CD;
        Sun, 12 Dec 2021 07:30:22 +0000 (UTC)
Subject: Re: [PATCH v2 3/8] irqchip/apple-aic: Add cpumasks for E and P cores
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-4-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <8bb14854-3377-4901-aaba-1a124c57cbec@marcan.st>
Date:   Sun, 12 Dec 2021 16:30:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201134909.390490-4-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 22.49, Marc Zyngier wrote:
> In order to be able to tell the core IRQ code about the affinity
> of the PMU interrupt in later patches, compute the cpumasks of the
> P and E cores at boot time.
> 
> This relies on the affinity scheme used by the vendor, which seems
> to work for the couple of SoCs that are out in the wild.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-apple-aic.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 3759dc36cc8f..30ca80ccda8b 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -177,6 +177,8 @@ struct aic_irq_chip {
>   	void __iomem *base;
>   	struct irq_domain *hw_domain;
>   	struct irq_domain *ipi_domain;
> +	struct cpumask ecore_mask;
> +	struct cpumask pcore_mask;
>   	int nr_hw;
>   	int ipi_hwirq;
>   };
> @@ -200,6 +202,11 @@ static void aic_ic_write(struct aic_irq_chip *ic, u32 reg, u32 val)
>   	writel_relaxed(val, ic->base + reg);
>   }
>   
> +static bool __is_pcore(u64 mpidr)
> +{
> +	return MPIDR_AFFINITY_LEVEL(mpidr, 2) == 1;
> +}
> +
>   /*
>    * IRQ irqchip
>    */
> @@ -833,6 +840,13 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
>   		return -ENODEV;
>   	}
>   
> +	for_each_possible_cpu(i) {
> +		if (__is_pcore(cpu_logical_map(i)))
> +			cpumask_set_cpu(i, &irqc->pcore_mask);
> +		else
> +			cpumask_set_cpu(i, &irqc->ecore_mask);
> +	}
> +
>   	set_handle_irq(aic_handle_irq);
>   	set_handle_fiq(aic_handle_fiq);
>   
> 

I'm okay with this approach, but if we want to be more explicit about 
the affinities, maybe something like apple,pmu-irq-index in the CPU 
nodes? Then we can either start at a higher FIQ offset for these (in 
case we need to add more FIQs in the future), or just make up a new 
AIC_PMU top level interrupt type and start at 0.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
