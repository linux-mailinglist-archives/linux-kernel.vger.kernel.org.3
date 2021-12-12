Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F331471913
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhLLHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:23:51 -0500
Received: from marcansoft.com ([212.63.210.85]:36344 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhLLHXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:23:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 825FA424CD;
        Sun, 12 Dec 2021 07:23:46 +0000 (UTC)
Subject: Re: [PATCH v2 5/8] irqchip/apple-aic: Move PMU-specific registers to
 their own include file
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
 <20211201134909.390490-6-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <289add6a-a536-cfd2-65da-a606527e3bd1@marcan.st>
Date:   Sun, 12 Dec 2021 16:23:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201134909.390490-6-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 22.49, Marc Zyngier wrote:
> As we are about to have a PMU driver, move the PMU bits from the AIC
> driver into a common include file.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   arch/arm64/include/asm/apple_m1_pmu.h | 19 +++++++++++++++++++
>   drivers/irqchip/irq-apple-aic.c       | 11 +----------
>   2 files changed, 20 insertions(+), 10 deletions(-)
>   create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h
> 
> diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
> new file mode 100644
> index 000000000000..b848af7faadc
> --- /dev/null
> +++ b/arch/arm64/include/asm/apple_m1_pmu.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __ASM_APPLE_M1_PMU_h
> +#define __ASM_APPLE_M1_PMU_h
> +
> +#include <linux/bits.h>
> +#include <asm/sysreg.h>
> +
> +/* Core PMC control register */
> +#define SYS_IMP_APL_PMCR0_EL1	sys_reg(3, 1, 15, 0, 0)
> +#define PMCR0_IMODE		GENMASK(10, 8)
> +#define PMCR0_IMODE_OFF		0
> +#define PMCR0_IMODE_PMI		1
> +#define PMCR0_IMODE_AIC		2
> +#define PMCR0_IMODE_HALT	3
> +#define PMCR0_IMODE_FIQ		4
> +#define PMCR0_IACT		BIT(11)
> +
> +#endif /* __ASM_APPLE_M1_PMU_h */
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 23f5f10e974e..9663166fd97f 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -55,6 +55,7 @@
>   #include <linux/limits.h>
>   #include <linux/of_address.h>
>   #include <linux/slab.h>
> +#include <asm/apple_m1_pmu.h>
>   #include <asm/exception.h>
>   #include <asm/sysreg.h>
>   #include <asm/virt.h>
> @@ -109,16 +110,6 @@
>    * Note: sysreg-based IPIs are not supported yet.
>    */
>   
> -/* Core PMC control register */
> -#define SYS_IMP_APL_PMCR0_EL1		sys_reg(3, 1, 15, 0, 0)
> -#define PMCR0_IMODE			GENMASK(10, 8)
> -#define PMCR0_IMODE_OFF			0
> -#define PMCR0_IMODE_PMI			1
> -#define PMCR0_IMODE_AIC			2
> -#define PMCR0_IMODE_HALT		3
> -#define PMCR0_IMODE_FIQ			4
> -#define PMCR0_IACT			BIT(11)
> -
>   /* IPI request registers */
>   #define SYS_IMP_APL_IPI_RR_LOCAL_EL1	sys_reg(3, 5, 15, 0, 0)
>   #define SYS_IMP_APL_IPI_RR_GLOBAL_EL1	sys_reg(3, 5, 15, 0, 1)
> 

Reviewed-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
