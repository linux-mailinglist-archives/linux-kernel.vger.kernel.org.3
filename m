Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF25506CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348774AbiDSM6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbiDSM6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:58:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 899122B180
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:55:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB62106F;
        Tue, 19 Apr 2022 05:55:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.75.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6A513F766;
        Tue, 19 Apr 2022 05:55:23 -0700 (PDT)
Date:   Tue, 19 Apr 2022 13:55:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        broonie@kernel.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v4 2/2] arm64/ftrace: Make function graph use ftrace
 directly
Message-ID: <Yl6xN2qf7k5YeEdl@FVFF77S0Q05N>
References: <20220409153554.14470-1-zhouchengming@bytedance.com>
 <20220409153554.14470-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409153554.14470-2-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 11:35:54PM +0800, Chengming Zhou wrote:
> As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
> use ftrace directly"), we don't need special hook for graph tracer,
> but instead we use graph_ops:func function to install return_hooker.
> 
> Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
> implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
> the same cleanup on arm64.
> 
> And this cleanup only changes the FTRACE_WITH_REGS implementation,
> so the mcount-based implementation is unaffected.

Could you please say *why* we only do this for FTRACE_WITH_REGS? IIUC that's
possible, but would require more invasive refactoring of the core code; have I
understood correctly?

If so, could we please make this:

| While in theory it would be possible to make a similar cleanup for
| !FTRACE_WITH_REGS, this will require rework of the core code, and so for now
| we only change the FTRACE_WITH_REGS implementation.

It'd be quite nice if we could clean up the !FTRACE_WITH_REGS case similarly,
but as it appeass that would require far more invasive changes, I'm happy to
leave that for future work.

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v3:
>  - Add comments in ftrace_graph_func() as suggested by Steve. Thanks.
> 
> v2:
>  - Remove FTRACE_WITH_REGS ftrace_graph_caller asm, thanks Mark.
> ---
>  arch/arm64/include/asm/ftrace.h  |  7 +++++++
>  arch/arm64/kernel/entry-ftrace.S | 17 -----------------
>  arch/arm64/kernel/ftrace.c       | 17 +++++++++++++++++
>  3 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 1494cfa8639b..dbc45a4157fa 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -80,8 +80,15 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  struct dyn_ftrace;
> +struct ftrace_ops;
> +struct ftrace_regs;
> +
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>  #define ftrace_init_nop ftrace_init_nop
> +
> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> +		       struct ftrace_ops *op, struct ftrace_regs *fregs);
> +#define ftrace_graph_func ftrace_graph_func
>  #endif
>  
>  #define ftrace_return_address(n) return_address(n)
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index e535480a4069..d42a205ef625 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -97,12 +97,6 @@ SYM_CODE_START(ftrace_common)
>  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>  	bl	ftrace_stub
>  
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
> -	nop				// If enabled, this will be replaced
> -					// "b ftrace_graph_caller"
> -#endif
> -
>  /*
>   * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
>   * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
> @@ -127,17 +121,6 @@ ftrace_common_return:
>  	ret	x9
>  SYM_CODE_END(ftrace_common)
>  
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -SYM_CODE_START(ftrace_graph_caller)
> -	ldr	x0, [sp, #S_PC]
> -	sub	x0, x0, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
> -	add	x1, sp, #S_LR			// parent_ip (callsite's LR)
> -	ldr	x2, [sp, #PT_REGS_SIZE]	   	// parent fp (callsite's FP)
> -	bl	prepare_ftrace_return
> -	b	ftrace_common_return
> -SYM_CODE_END(ftrace_graph_caller)
> -#endif
> -
>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  
>  /*
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 4506c4a90ac1..35eb7c9b5e53 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -268,6 +268,22 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>  }
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	/*
> +	 * Athough graph_ops doesn't have FTRACE_OPS_FL_SAVE_REGS set in flags,
> +	 * regs can't be NULL in DYNAMIC_FTRACE_WITH_REGS. By design, it should
> +	 * be fixed when DYNAMIC_FTRACE_WITH_ARGS is implemented.
> +	 */

This is a bit confusing, since it makes it sound like there's an bug in the
current implementation, rather than something that would need to change if
support for DYNAMIC_FTRACE_WITH_ARGS is added.

Could we please make this:

	/*
	 * When DYNAMIC_FTRACE_WITH_REGS is selected, `fregs` can never be NULL
	 * and arch_ftrace_get_regs(fregs) will always give a non-NULL pt_regs
	 * in which we can safely modify the LR.
	 */

Other than that, this looks good to me. I gave it a spin under QEMU atop
v5.18-rc3. The CONFIG_FTRACE_STARTUP_TEST tests all pass, and I played with the
graph tracer with:

| # echo do_el0_svc > /sys/kernel/tracing/set_graph_function 
| # echo function_graph > /sys/kernel/tracing/current_tracer

... for which the resutls looks sane.

To make sure this didn't adversely affect the return address rewriting, I also
concurrently ran perf with:

| # perf record -g -e raw_syscalls:sys_enter:k /bin/true
| # perf report

... for which the results also looked fine.

I also tested the !DYNAMIC_FTRACE_WITH_REGS modes by building with an older
compiler and also building with !DYNAMIC_FTRACE, which all looked good.

So FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

... and if you make the changes I requested above:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

If you could spin a v5 with that folded in, that would be great.

Thanks,
Mark.
