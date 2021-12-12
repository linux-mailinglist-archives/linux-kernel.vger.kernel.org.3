Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD8471915
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhLLHZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:25:57 -0500
Received: from marcansoft.com ([212.63.210.85]:36874 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhLLHZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:25:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 419D9424CD;
        Sun, 12 Dec 2021 07:25:52 +0000 (UTC)
Subject: Re: [PATCH v2 4/8] irqchip/apple-aic: Wire PMU interrupts
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
 <20211201134909.390490-5-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <31b5d934-9a51-6eab-2983-311a30db3ad8@marcan.st>
Date:   Sun, 12 Dec 2021 16:25:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201134909.390490-5-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 22.49, Marc Zyngier wrote:
> Add the necessary code to configure and P and E-core PMU interrupts
> with their respective affinities. When such an interrupt fires, map
> it onto the right pseudo-interrupt.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-apple-aic.c | 34 +++++++++++++++++++++------------
>   1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 30ca80ccda8b..23f5f10e974e 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -155,7 +155,7 @@
>   #define SYS_IMP_APL_UPMSR_EL1		sys_reg(3, 7, 15, 6, 4)
>   #define UPMSR_IACT			BIT(0)
>   
> -#define AIC_NR_FIQ		4
> +#define AIC_NR_FIQ		6
>   #define AIC_NR_SWIPI		32
>   
>   /*
> @@ -207,6 +207,11 @@ static bool __is_pcore(u64 mpidr)
>   	return MPIDR_AFFINITY_LEVEL(mpidr, 2) == 1;
>   }
>   
> +static bool is_pcore(void)
> +{
> +	return __is_pcore(read_cpuid_mpidr());
> +}
> +
>   /*
>    * IRQ irqchip
>    */
> @@ -420,16 +425,10 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>   						  aic_irqc->nr_hw + AIC_TMR_EL02_VIRT);
>   	}
>   
> -	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
> -			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
> -		/*
> -		 * Not supported yet, let's figure out how to handle this when
> -		 * we implement these proprietary performance counters. For now,
> -		 * just mask it and move on.
> -		 */
> -		pr_err_ratelimited("PMC FIQ fired. Masking.\n");
> -		sysreg_clear_set_s(SYS_IMP_APL_PMCR0_EL1, PMCR0_IMODE | PMCR0_IACT,
> -				   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
> +	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
> +		int irq = is_pcore() ? AIC_CPU_PMU_P : AIC_CPU_PMU_E;
> +		generic_handle_domain_irq(aic_irqc->hw_domain,
> +					  aic_irqc->nr_hw + irq);
>   	}
>   
>   	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
> @@ -469,7 +468,18 @@ static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
>   				    handle_fasteoi_irq, NULL, NULL);
>   		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
>   	} else {
> -		irq_set_percpu_devid(irq);
> +		switch (hw - ic->nr_hw) {
> +		case AIC_CPU_PMU_P:
> +			irq_set_percpu_devid_partition(irq, &ic->pcore_mask);
> +			break;
> +		case AIC_CPU_PMU_E:
> +			irq_set_percpu_devid_partition(irq, &ic->ecore_mask);
> +			break;
> +		default:
> +			irq_set_percpu_devid(irq);
> +			break;
> +		}
> +
>   		irq_domain_set_info(id, irq, hw, &fiq_chip, id->host_data,
>   				    handle_percpu_devid_irq, NULL, NULL);
>   	}
> 

I still find this idea that we need to split the IRQs virtually quite 
bizarre, but if that's how bit.LITTLE systems do it...

Reviewed-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
