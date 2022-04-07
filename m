Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28624F7245
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiDGCuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiDGCuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:50:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8514427F7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649299692; x=1680835692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1YY/TJDW1rtBAHSWfDLqnRcV3QEI1qeg4+hcokdulcw=;
  b=LpeGnD2/4HYqz1ABz61FQ+a29A6RyTPYdiAWcxzrwGGSwMcl5hiIbkZr
   Nnnoa8Oz/rzuWnSu/gqnnAgMUqVxpWnmoLlvuSTCtMQEisNqISQ1Y+Vut
   VTGDsZSoN/EI79gMXlJTH8G3V519H77qOs7o8U5FipDcdigjNwb+fJKGA
   zivdi/LtRqTDBBtIvy4KdNTFwwTwRmC/RIY7+DCLQQGoOrPow4dTz6ics
   +UrYcmQ6Tx2io1pQxCdLbhNYdd+c0AJwZzCX5ImMVHl/wYOqo0TeKS7hY
   YVSvObk9z+iWbBICM5veMxq2CcZQgS/uBcFmK+hkY9zyP6HAYNNCTG5S5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="324377031"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="324377031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:48:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="697623923"
Received: from pgbarran-mobl.amr.corp.intel.com (HELO localhost) ([10.212.127.188])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:48:10 -0700
Date:   Wed, 6 Apr 2022 19:48:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 01/45] entry: Create an internal
 irqentry_exit_cond_resched() call
Message-ID: <Yk5Q6h7d88Yi8EIb@iweiny-desk3>
References: <20220310172019.850939-1-ira.weiny@intel.com>
 <20220310172019.850939-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310172019.850939-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:19:35AM -0800, Ira wrote:
> From: Ira Weiny <ira.weiny@intel.com>

Rebasing to 5.18-rc1 revealed a different fix has been applied for this
work.[1]

Please disregard this patch.

Ira

[1] 4624a14f4daa ("sched/preempt: Simplify irqentry_exit_cond_resched()
callers") 

> 
> The static call to irqentry_exit_cond_resched() was not properly being
> overridden when called from xen_pv_evtchn_do_upcall().
> 
> Define __irqentry_exit_cond_resched() as the static call and place the
> override logic in irqentry_exit_cond_resched().
> 
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for V9
> 	Update the commit message a bit
> 
> Because this was found via code inspection and it does not actually fix
> any seen bug I've not added a fixes tag.
> 
> But for reference:
> Fixes: 40607ee97e4e ("preempt/dynamic: Provide irqentry_exit_cond_resched() static call")
> ---
>  include/linux/entry-common.h |  5 ++++-
>  kernel/entry/common.c        | 23 +++++++++++++--------
>  kernel/sched/core.c          | 40 ++++++++++++++++++------------------
>  3 files changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 2e2b8d6140ed..ddaffc983e62 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -455,10 +455,13 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
>   * Conditional reschedule with additional sanity checks.
>   */
>  void irqentry_exit_cond_resched(void);
> +
> +void __irqentry_exit_cond_resched(void);
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> -DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
> +DECLARE_STATIC_CALL(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
>  #endif
>  
> +
>  /**
>   * irqentry_exit - Handle return from exception that used irqentry_enter()
>   * @regs:	Pointer to pt_regs (exception entry regs)
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index bad713684c2e..490442a48332 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -380,7 +380,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>  	return ret;
>  }
>  
> -void irqentry_exit_cond_resched(void)
> +void __irqentry_exit_cond_resched(void)
>  {
>  	if (!preempt_count()) {
>  		/* Sanity check RCU and thread stack */
> @@ -392,9 +392,20 @@ void irqentry_exit_cond_resched(void)
>  	}
>  }
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
> +DEFINE_STATIC_CALL(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
>  #endif
>  
> +void irqentry_exit_cond_resched(void)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPTION)) {
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +		static_call(__irqentry_exit_cond_resched)();
> +#else
> +		__irqentry_exit_cond_resched();
> +#endif
> +	}
> +}
> +
>  noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  {
>  	lockdep_assert_irqs_disabled();
> @@ -420,13 +431,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  		}
>  
>  		instrumentation_begin();
> -		if (IS_ENABLED(CONFIG_PREEMPTION)) {
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> -			static_call(irqentry_exit_cond_resched)();
> -#else
> -			irqentry_exit_cond_resched();
> -#endif
> -		}
> +		irqentry_exit_cond_resched();
>  		/* Covers both tracing and lockdep */
>  		trace_hardirqs_on();
>  		instrumentation_end();
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9745613d531c..f56db4bd9730 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6571,29 +6571,29 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
>   * SC:might_resched
>   * SC:preempt_schedule
>   * SC:preempt_schedule_notrace
> - * SC:irqentry_exit_cond_resched
> + * SC:__irqentry_exit_cond_resched
>   *
>   *
>   * NONE:
> - *   cond_resched               <- __cond_resched
> - *   might_resched              <- RET0
> - *   preempt_schedule           <- NOP
> - *   preempt_schedule_notrace   <- NOP
> - *   irqentry_exit_cond_resched <- NOP
> + *   cond_resched                 <- __cond_resched
> + *   might_resched                <- RET0
> + *   preempt_schedule             <- NOP
> + *   preempt_schedule_notrace     <- NOP
> + *   __irqentry_exit_cond_resched <- NOP
>   *
>   * VOLUNTARY:
> - *   cond_resched               <- __cond_resched
> - *   might_resched              <- __cond_resched
> - *   preempt_schedule           <- NOP
> - *   preempt_schedule_notrace   <- NOP
> - *   irqentry_exit_cond_resched <- NOP
> + *   cond_resched                 <- __cond_resched
> + *   might_resched                <- __cond_resched
> + *   preempt_schedule             <- NOP
> + *   preempt_schedule_notrace     <- NOP
> + *   __irqentry_exit_cond_resched <- NOP
>   *
>   * FULL:
> - *   cond_resched               <- RET0
> - *   might_resched              <- RET0
> - *   preempt_schedule           <- preempt_schedule
> - *   preempt_schedule_notrace   <- preempt_schedule_notrace
> - *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> + *   cond_resched                 <- RET0
> + *   might_resched                <- RET0
> + *   preempt_schedule             <- preempt_schedule
> + *   preempt_schedule_notrace     <- preempt_schedule_notrace
> + *   __irqentry_exit_cond_resched <- __irqentry_exit_cond_resched
>   */
>  
>  enum {
> @@ -6629,7 +6629,7 @@ void sched_dynamic_update(int mode)
>  	static_call_update(might_resched, __cond_resched);
>  	static_call_update(preempt_schedule, __preempt_schedule_func);
>  	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
> -	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
> +	static_call_update(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
>  
>  	switch (mode) {
>  	case preempt_dynamic_none:
> @@ -6637,7 +6637,7 @@ void sched_dynamic_update(int mode)
>  		static_call_update(might_resched, (void *)&__static_call_return0);
>  		static_call_update(preempt_schedule, NULL);
>  		static_call_update(preempt_schedule_notrace, NULL);
> -		static_call_update(irqentry_exit_cond_resched, NULL);
> +		static_call_update(__irqentry_exit_cond_resched, NULL);
>  		pr_info("Dynamic Preempt: none\n");
>  		break;
>  
> @@ -6646,7 +6646,7 @@ void sched_dynamic_update(int mode)
>  		static_call_update(might_resched, __cond_resched);
>  		static_call_update(preempt_schedule, NULL);
>  		static_call_update(preempt_schedule_notrace, NULL);
> -		static_call_update(irqentry_exit_cond_resched, NULL);
> +		static_call_update(__irqentry_exit_cond_resched, NULL);
>  		pr_info("Dynamic Preempt: voluntary\n");
>  		break;
>  
> @@ -6655,7 +6655,7 @@ void sched_dynamic_update(int mode)
>  		static_call_update(might_resched, (void *)&__static_call_return0);
>  		static_call_update(preempt_schedule, __preempt_schedule_func);
>  		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
> -		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
> +		static_call_update(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
>  		pr_info("Dynamic Preempt: full\n");
>  		break;
>  	}
> -- 
> 2.35.1
> 
