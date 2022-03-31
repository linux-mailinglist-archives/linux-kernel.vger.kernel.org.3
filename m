Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161724ED6BB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiCaJ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiCaJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:26:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF2441FCD00
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:24:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADE1223A;
        Thu, 31 Mar 2022 02:24:37 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D258A3F718;
        Thu, 31 Mar 2022 02:24:34 -0700 (PDT)
Date:   Thu, 31 Mar 2022 10:24:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 2/4] arm64, scs: save scs_sp values per-cpu when
 switching stacks
Message-ID: <YkVzTbafttTHWETU@FVFF77S0Q05N>
References: <cover.1648049113.git.andreyknvl@google.com>
 <f75c58b17bfaa419f84286cd174e3a08f971b779.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f75c58b17bfaa419f84286cd174e3a08f971b779.1648049113.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:32:53PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> When an interrupt happens, the current Shadow Call Stack (SCS) pointer
> is switched to a per-interrupt one stored in a per-CPU variable. The old
> pointer is then saved on the normal stack and restored when the interrupt
> is handled.
> 
> To collect the current stack trace based on SCS when the interrupt is
> being handled, we need to know the SCS pointers that belonged to the
> task and potentially other interrupts that were interrupted.
> 
> Instead of trying to retrieve the SCS pointers from the stack, change
> interrupt handlers (for hard IRQ, Normal and Critical SDEI) to save the
> previous SCS pointer in a per-CPU variable.

I'm *really* not keen on *always* poking this in the entry code for the
uncommon case of unwind. It complicates the entry code and means we're always
paying a cost for potentially no benefit. At a high-level, I don't think this
is the right approach.

For the regular unwinder, I want to rework things such that we can identify
exception boundaries and look into the regs (e.g. so that we can recover the
PC+LR+FP and avoid duplicating part of this in a frame record), and I'd much
prefer that we did the same here.

Thanks,
Mark.

> Note that interrupts stack. A task can be interrupted by a hard IRQ,
> which then can interrupted by a normal SDEI, etc. This is handled by
> using a separate per-CPU variable for each interrupt type.
> 
> Also reset the saved SCS pointer when exiting the interrupt. This allows
> checking whether we should include any interrupt frames when collecting
> the stack trace. While we could use in_hardirq(), there seems to be no
> easy way to check whether we are in an SDEI handler. Directly checking
> the per-CPU variables for being non-zero is more resilient.
> 
> Also expose both the the added saved SCS variables and the existing SCS
> base variables in arch/arm64/include/asm/scs.h so that the stack trace
> collection impementation can use them.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/assembler.h | 12 ++++++++++++
>  arch/arm64/include/asm/scs.h       | 13 ++++++++++++-
>  arch/arm64/kernel/entry.S          | 28 ++++++++++++++++++++++++----
>  arch/arm64/kernel/irq.c            |  4 +---
>  arch/arm64/kernel/sdei.c           |  5 ++---
>  5 files changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 8c5a61aeaf8e..ca018e981d13 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -270,6 +270,18 @@ alternative_endif
>  	ldr	\dst, [\dst, \tmp]
>  	.endm
>  
> +	/*
> +	 * @src: Register whose value gets stored in sym
> +	 * @sym: The name of the per-cpu variable
> +	 * @tmp0: Scratch register
> +	 * @tmp1: Another scratch register
> +	 */
> +	.macro str_this_cpu src, sym, tmp0, tmp1
> +	adr_l	\tmp0, \sym
> +	get_this_cpu_offset \tmp1
> +	str	\src, [\tmp0, \tmp1]
> +	.endm
> +
>  /*
>   * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
>   */
> diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
> index 8297bccf0784..2bb2b32f787b 100644
> --- a/arch/arm64/include/asm/scs.h
> +++ b/arch/arm64/include/asm/scs.h
> @@ -24,6 +24,17 @@
>  	.endm
>  #endif /* CONFIG_SHADOW_CALL_STACK */
>  
> -#endif /* __ASSEMBLY __ */
> +#else /* __ASSEMBLY__ */
> +
> +#include <linux/percpu.h>
> +
> +DECLARE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
> +DECLARE_PER_CPU(unsigned long *, irq_shadow_call_stack_saved_ptr);
> +DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
> +DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_saved_ptr);
> +DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
> +DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_saved_ptr);
> +
> +#endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_SCS_H */
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ede028dee81b..1c62fecda172 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -880,7 +880,8 @@ NOKPROBE(ret_from_fork)
>   */
>  SYM_FUNC_START(call_on_irq_stack)
>  #ifdef CONFIG_SHADOW_CALL_STACK
> -	stp	scs_sp, xzr, [sp, #-16]!
> +	/* Save the current SCS pointer and load the per-IRQ one. */
> +	str_this_cpu scs_sp, irq_shadow_call_stack_saved_ptr, x15, x17
>  	ldr_this_cpu scs_sp, irq_shadow_call_stack_ptr, x17
>  #endif
>  	/* Create a frame record to save our LR and SP (implicit in FP) */
> @@ -902,7 +903,9 @@ SYM_FUNC_START(call_on_irq_stack)
>  	mov	sp, x29
>  	ldp	x29, x30, [sp], #16
>  #ifdef CONFIG_SHADOW_CALL_STACK
> -	ldp	scs_sp, xzr, [sp], #16
> +	/* Restore saved SCS pointer and reset the saved value. */
> +	ldr_this_cpu scs_sp, irq_shadow_call_stack_saved_ptr, x17
> +	str_this_cpu xzr, irq_shadow_call_stack_saved_ptr, x15, x17
>  #endif
>  	ret
>  SYM_FUNC_END(call_on_irq_stack)
> @@ -1024,11 +1027,16 @@ SYM_CODE_START(__sdei_asm_handler)
>  #endif
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
> -	/* Use a separate shadow call stack for normal and critical events */
> +	/*
> +	 * Use a separate shadow call stack for normal and critical events.
> +	 * Save the current SCS pointer and load the per-SDEI one.
> +	 */
>  	cbnz	w4, 3f
> +	str_this_cpu src=scs_sp, sym=sdei_shadow_call_stack_normal_saved_ptr, tmp0=x5, tmp1=x6
>  	ldr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_normal_ptr, tmp=x6
>  	b	4f
> -3:	ldr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_critical_ptr, tmp=x6
> +3:	str_this_cpu src=scs_sp, sym=sdei_shadow_call_stack_critical_saved_ptr, tmp0=x5, tmp1=x6
> +	ldr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_critical_ptr, tmp=x6
>  4:
>  #endif
>  
> @@ -1062,6 +1070,18 @@ SYM_CODE_START(__sdei_asm_handler)
>  	ldp	lr, x1, [x4, #SDEI_EVENT_INTREGS + S_LR]
>  	mov	sp, x1
>  
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +	/* Restore saved SCS pointer and reset the saved value. */
> +	ldrb	w5, [x4, #SDEI_EVENT_PRIORITY]
> +	cbnz	w5, 5f
> +	ldr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_normal_saved_ptr, tmp=x6
> +	str_this_cpu src=xzr, sym=sdei_shadow_call_stack_normal_saved_ptr, tmp0=x5, tmp1=x6
> +	b	6f
> +5:	ldr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_critical_saved_ptr, tmp=x6
> +	str_this_cpu src=xzr, sym=sdei_shadow_call_stack_critical_saved_ptr, tmp0=x5, tmp1=x6
> +6:
> +#endif
> +
>  	mov	x1, x0			// address to complete_and_resume
>  	/* x0 = (x0 <= SDEI_EV_FAILED) ?
>  	 * EVENT_COMPLETE:EVENT_COMPLETE_AND_RESUME
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index bda49430c9ea..4199f900714a 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -28,11 +28,9 @@ DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
>  
>  DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
>  
> -
> -DECLARE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
> -
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  DEFINE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
> +DEFINE_PER_CPU(unsigned long *, irq_shadow_call_stack_saved_ptr);
>  #endif
>  
>  static void init_irq_scs(void)
> diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
> index d20620a1c51a..269adcb9e854 100644
> --- a/arch/arm64/kernel/sdei.c
> +++ b/arch/arm64/kernel/sdei.c
> @@ -39,12 +39,11 @@ DEFINE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
>  DEFINE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
>  #endif
>  
> -DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
> -DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
> -
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
> +DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_saved_ptr);
>  DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
> +DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_saved_ptr);
>  #endif
>  
>  static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
> -- 
> 2.25.1
> 
