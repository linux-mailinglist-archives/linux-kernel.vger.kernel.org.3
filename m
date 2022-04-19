Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C39506B34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351784AbiDSLo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352041AbiDSLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:44:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0FC034BA3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:41:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 222F71063;
        Tue, 19 Apr 2022 04:41:15 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.75.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A120F3F73B;
        Tue, 19 Apr 2022 04:41:12 -0700 (PDT)
Date:   Tue, 19 Apr 2022 12:41:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        broonie@kernel.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v4 1/2] ftrace: cleanup ftrace_graph_caller enable and
 disable
Message-ID: <Yl6f0XKoRxNhgGPv@FVFF77S0Q05N>
References: <20220409153554.14470-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409153554.14470-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 11:35:53PM +0800, Chengming Zhou wrote:
> The ftrace_[enable,disable]_ftrace_graph_caller() are used to do
> special hooks for graph tracer, which are not needed on some ARCHs
> that use graph_ops:func function to install return_hooker.
> 
> So introduce the weak version in ftrace core code to cleanup
> in x86.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v4:
>  - put weak ftrace_enable,disable_ftrace_graph_caller() in
>    fgraph.c instead of ftrace.c as suggested by Steve.
> 
> v3:
>  - consolidate two #if into a single #if, suggested by Steve. Thanks.
> ---
>  arch/x86/kernel/ftrace.c | 17 ++---------------
>  kernel/trace/fgraph.c    | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 1e31c7d21597..b09d73c2ba89 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -579,9 +579,7 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -
> -#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +#if defined(CONFIG_DYNAMIC_FTRACE) && !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
>  extern void ftrace_graph_call(void);
>  static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
>  {
> @@ -610,18 +608,7 @@ int ftrace_disable_ftrace_graph_caller(void)
>  
>  	return ftrace_mod_jmp(ip, &ftrace_stub);
>  }
> -#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
> -int ftrace_enable_ftrace_graph_caller(void)
> -{
> -	return 0;
> -}
> -
> -int ftrace_disable_ftrace_graph_caller(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
> -#endif /* !CONFIG_DYNAMIC_FTRACE */
> +#endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>  
>  /*
>   * Hook the return address and push it in the stack of return addrs
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 8f4fb328133a..289311680c29 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -30,6 +30,24 @@ int ftrace_graph_active;
>  /* Both enabled by default (can be cleared by function_graph tracer flags */
>  static bool fgraph_sleep_time = true;
>  
> +/*
> + * archs can override this function if they must do something
> + * to enable hook for graph tracer.
> + */
> +int __weak ftrace_enable_ftrace_graph_caller(void)
> +{
> +	return 0;
> +}
> +
> +/*
> + * archs can override this function if they must do something
> + * to disable hook for graph tracer.
> + */
> +int __weak ftrace_disable_ftrace_graph_caller(void)
> +{
> +	return 0;
> +}

IIUC an arch should either:

* Have ftrace_graph_call()

* Have both ftrace_enable_ftrace_graph_caller() and
  ftrace_disable_ftrace_graph_caller()

... and I can't think of a reason an arch would need both ftrace_graph_call()
*and* the enable/disable functions.

Given that, could we drop the `__weak` and place these within ifdeffery, i.e.
make the above:

| #ifndef ftrace_graph_call
| int ftrace_enable_ftrace_graph_caller(void) { return 0; }
| int ftrace_disable_ftrace_graph_caller(void) { return 0; }
| #endif /* ftrace_graph_call *. 

That way we'd catch cases when:

* An architecture meant to provide one of these functions, but forgot (e.g. the
  name got typo'd)

* An architecture provides an unnecessary implementation of either of these
  functions.

Regardless, this looks ok to me. Steve, are you happy with this? I suspect we'd
need to take this via the arm64 tree with the next patch, so we'd need your Ack.

Thanks,
Mark.

> +
>  /**
>   * ftrace_graph_stop - set to permanently disable function graph tracing
>   *
> -- 
> 2.35.1
> 
