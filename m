Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7493A487813
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbiAGNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:19:35 -0500
Received: from foss.arm.com ([217.140.110.172]:40644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238787AbiAGNTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:19:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 394D013A1;
        Fri,  7 Jan 2022 05:19:34 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.7.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B27763F774;
        Fri,  7 Jan 2022 05:19:32 -0800 (PST)
Date:   Fri, 7 Jan 2022 13:19:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Ying <heying24@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, joey.gouly@arm.com, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Make CONFIG_ARM64_PSEUDO_NMI macro wrap all the
 pseudo-NMI code
Message-ID: <Ydg939btY/bzEAe4@FVFF77S0Q05N>
References: <20220107085536.214501-1-heying24@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107085536.214501-1-heying24@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:55:36AM -0500, He Ying wrote:
> Our product has been updating its kernel from 4.4 to 5.10 recently and
> found a performance issue. We do a bussiness test called ARP test, which
> tests the latency for a ping-pong packets traffic with a certain payload.
> The result is as following.
> 
>  - 4.4 kernel: avg = ~20s
>  - 5.10 kernel (CONFIG_ARM64_PSEUDO_NMI is not set): avg = ~40s

Have you tested with a recent mainline kernel, e.g. v5.15?

Is this test publicly available, and can you say which hardrware (e.g. which
CPU implementation) you're testing with?

> I have been just learning arm64 pseudo-NMI code and have a question,
> why is the related code not wrapped by CONFIG_ARM64_PSEUDO_NMI?

The code in question is all patched via alternatives, and when
CONFIG_ARM64_PSEUDO_NMI is not selected, the code was expected to only have the
overhead of the regular DAIF manipulation.

> I wonder if this brings some performance regression.
> 
> First, I make this patch and then do the test again. Here's the result.
> 
>  - 5.10 kernel with this patch not applied: avg = ~40s
>  - 5.10 kernel with this patch applied: avg = ~23s
> 
> Amazing! Note that all kernel is built with CONFIG_ARM64_PSEUDO_NMI not
> set. It seems the pseudo-NMI feature actually brings some overhead to
> performance event if CONFIG_ARM64_PSEUDO_NMI is not set.

I'm surprised the overhead is so significant; as above this is all patched in
and so the overhead when this is disabled is expected to be *extremely* small.

For example, wjen CONFIG_ARM64_PSEUDO_NMI, in arch_local_irq_enable():

* The portion under the system_has_prio_mask_debugging() test will be removed
  entirely by the compiler, as this internally checks
  IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI).

* The assembly will be left as a write to DAIFClr. The only additional cost
  should be that of generating GIC_PRIO_IRQON into a register.

* The pmr_sync() will be removed entirely by the compiler as is defined
  conditionally dependent on CONFIG_ARM64_PSEUDO_NMI.

I can't spot an obvious issue with that or ther other cases. In the common case
those add no new instructions, and in the worst case they only add NOPs.

> Furthermore, I find the feature also brings some overhead to vmlinux size.
> I build 5.10 kernel with this patch applied or not while
> CONFIG_ARM64_PSEUDO_NMI is not set.
> 
>  - 5.10 kernel with this patch not applied: vmlinux size is 384060600 Bytes.
>  - 5.10 kernel with this patch applied: vmlinux size is 383842936 Bytes.
> 
> That means arm64 pseudo-NMI feature may bring ~200KB overhead to
> vmlinux size.

I suspect that's just the (unused) alternatives, and we could improve that by
passing the config into the alternative blocks.

> Above all, arm64 pseudo-NMI feature brings some overhead to vmlinux size
> and performance even if config is not set. To avoid it, add macro control
> all around the related code.
> 
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  arch/arm64/include/asm/irqflags.h | 38 +++++++++++++++++++++++++++++--
>  arch/arm64/kernel/entry.S         |  4 ++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index b57b9b1e4344..82f771b41cf5 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -26,6 +26,7 @@
>   */
>  static inline void arch_local_irq_enable(void)
>  {
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>  	if (system_has_prio_mask_debugging()) {
>  		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
>  
> @@ -41,10 +42,18 @@ static inline void arch_local_irq_enable(void)
>  		: "memory");
>  
>  	pmr_sync();
> +#else
> +	asm volatile(
> +		"msr	daifclr, #3		// arch_local_irq_enable"
> +		:
> +		:
> +		: "memory");
> +#endif

I'm happy to rework this to improve matters, but I am very much not happy with
duplicating the logic for the !PSEUDO_NMI case. Adding more ifdeffery and
copies of that is not acceptable.

Instead, can you please try changing the alternative to also take the config,
e.g. here have:

|       asm volatile(ALTERNATIVE(
|               "msr    daifclr, #3             // arch_local_irq_enable",
|               __msr_s(SYS_ICC_PMR_EL1, "%0"),
|               ARM64_HAS_IRQ_PRIO_MASKING,
|               CONFIG_ARM64_PSEUDO_NMI)
|               :   
|               : "r" ((unsigned long) GIC_PRIO_IRQON)
|               : "memory");

... and see if that makes a significant difference?

Likewise for the other casees.

>  #endif /* __ASM_IRQFLAGS_H */
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 2f69ae43941d..ffc32d3d909a 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -300,6 +300,7 @@ alternative_else_nop_endif
>  	str	w21, [sp, #S_SYSCALLNO]
>  	.endif
>  
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>  	/* Save pmr */
>  alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>  	mrs_s	x20, SYS_ICC_PMR_EL1
> @@ -307,6 +308,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>  	mov	x20, #GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET
>  	msr_s	SYS_ICC_PMR_EL1, x20
>  alternative_else_nop_endif
> +#endif
>  
>  	/* Re-enable tag checking (TCO set on exception entry) */
>  #ifdef CONFIG_ARM64_MTE
> @@ -330,6 +332,7 @@ alternative_else_nop_endif
>  	disable_daif
>  	.endif
>  
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>  	/* Restore pmr */
>  alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>  	ldr	x20, [sp, #S_PMR_SAVE]
> @@ -339,6 +342,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>  	dsb	sy				// Ensure priority change is seen by redistributor
>  .L__skip_pmr_sync\@:
>  alternative_else_nop_endif
> +#endif

For these two I think the ifdeffery is fine, but I'm surprised this has a
measureable impact as the alternatives should be initialized to NOPS (and never
modified).

Thanks,
Mark.
