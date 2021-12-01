Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6FB465287
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351393AbhLAQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:11:43 -0500
Received: from foss.arm.com ([217.140.110.172]:40938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351380AbhLAQLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:11:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D62D143B;
        Wed,  1 Dec 2021 08:08:18 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BDF03F766;
        Wed,  1 Dec 2021 08:08:16 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:08:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH v2 3/8] irqchip/apple-aic: Add cpumasks for E and P cores
Message-ID: <Yaed7VAlwwCBcP13@FVFF77S0Q05N>
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201134909.390490-4-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 01:49:04PM +0000, Marc Zyngier wrote:
> In order to be able to tell the core IRQ code about the affinity
> of the PMU interrupt in later patches, compute the cpumasks of the
> P and E cores at boot time.
> 
> This relies on the affinity scheme used by the vendor, which seems
> to work for the couple of SoCs that are out in the wild.

... but may change at any arbitrary point in future?

Can we please put the affinity in the DT, like we do for other SoCs and
devices?

I don't think we should treat this HW specially in this regard; we certaintly
don't want other folk hard-coding system topology in their irqchip driver, and
it should be possible to do something like the ppi-partitions binding, no?

Thanks,
Mark.

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-apple-aic.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 3759dc36cc8f..30ca80ccda8b 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -177,6 +177,8 @@ struct aic_irq_chip {
>  	void __iomem *base;
>  	struct irq_domain *hw_domain;
>  	struct irq_domain *ipi_domain;
> +	struct cpumask ecore_mask;
> +	struct cpumask pcore_mask;
>  	int nr_hw;
>  	int ipi_hwirq;
>  };
> @@ -200,6 +202,11 @@ static void aic_ic_write(struct aic_irq_chip *ic, u32 reg, u32 val)
>  	writel_relaxed(val, ic->base + reg);
>  }
>  
> +static bool __is_pcore(u64 mpidr)
> +{
> +	return MPIDR_AFFINITY_LEVEL(mpidr, 2) == 1;
> +}
> +
>  /*
>   * IRQ irqchip
>   */
> @@ -833,6 +840,13 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
>  		return -ENODEV;
>  	}
>  
> +	for_each_possible_cpu(i) {
> +		if (__is_pcore(cpu_logical_map(i)))
> +			cpumask_set_cpu(i, &irqc->pcore_mask);
> +		else
> +			cpumask_set_cpu(i, &irqc->ecore_mask);
> +	}
> +
>  	set_handle_irq(aic_handle_irq);
>  	set_handle_fiq(aic_handle_fiq);
>  
> -- 
> 2.30.2
> 
