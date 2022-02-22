Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB664BFDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiBVPzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiBVPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:55:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C00725C645
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:54:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C48B1063;
        Tue, 22 Feb 2022 07:54:48 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AFD13F70D;
        Tue, 22 Feb 2022 07:54:47 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:54:44 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/ftrace: Make function graph use ftrace directly
Message-ID: <YhUHRIDaLqhAz0SV@lakrids>
References: <20220222130049.81284-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222130049.81284-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 09:00:49PM +0800, Chengming Zhou wrote:
> As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
> use ftrace directly"), we don't need special hook for graph tracer,
> but instead we use graph_ops:func function to install return_hooker.
> 
> Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
> implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
> the same optimization on arm64.

This is a nice cleanup/refactoring, but I don't think this is an
optimization as such; we're still doing the same work, just in
marginally different place. So I'd suggest s/optimization/cleanup/ here.

It's probably worth noting that this *only* changes the FTRACE_WITH_REGS
implementation, and the mcount-based implementation is unaffected by
this patch.

> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  arch/arm64/include/asm/ftrace.h  |  7 +++++++
>  arch/arm64/kernel/entry-ftrace.S |  6 ------
>  arch/arm64/kernel/ftrace.c       | 21 +++++++++++++++++++++
>  3 files changed, 28 insertions(+), 6 deletions(-)
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
> index e535480a4069..eb4a69b1f84d 100644
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

You should also be able to delete the FTRACE_WITH_REGS implementation of
ftrace_graph_caller since that's now unused.

Having that in the diff would also make it easier to compare to the
logic in ftrace_graph_func().

>  /*
>   * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
>   * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 4506c4a90ac1..1b5da231b1de 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -268,6 +268,26 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>  }
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +int ftrace_enable_ftrace_graph_caller(void)
> +{
> +	return 0;
> +}
> +
> +int ftrace_disable_ftrace_graph_caller(void)
> +{
> +	return 0;
> +}

It's a shame the core code doesn't provide this if we provide an
implementation of ftrace_graph_func.

> +
> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
> +	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
> +
> +	prepare_ftrace_return(ip, parent, frame_pointer(regs));
> +}

Other than my comments above, this looks about right, but I'd like to
give this some testing before I give any tags.

Could you respin this with the FTRACE_WITH_REGS ftrace_graph_caller asm
removed?

Thanks,
Mark.

> +#else
>  /*
>   * Turn on/off the call to ftrace_graph_caller() in ftrace_caller()
>   * depending on @enable.
> @@ -297,5 +317,6 @@ int ftrace_disable_ftrace_graph_caller(void)
>  {
>  	return ftrace_modify_graph_caller(false);
>  }
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> -- 
> 2.20.1
> 
