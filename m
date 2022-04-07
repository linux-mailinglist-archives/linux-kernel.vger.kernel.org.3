Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255684F7253
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiDGCxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbiDGCw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:52:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87990121533
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649299860; x=1680835860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EQhB3Ed1HUXRyli1pVL01JInLFg6L9jOCRO5DJGl7WQ=;
  b=eeqWuSKCwh/ODc8do+eWnChwgOT5PzHKSDUFdraaSPCrTECfY+xLID3Z
   9a+SkhXjY5DSwZgV9uQ2GQF+mS+ryNV8o50lqurbtlHXh61ACP9toWGY2
   NQDv4I9c0Tq3U9NgYZTIbpNgSKT2siRkhL3mP0PdBZoOlbb4Ao3Ht76No
   R1ZAfckQWTP6J5bN74cSYMaBdgdvJLFZPCyqThnruTHH2ig4M8CoRA7KO
   wfcnlVJeyNtWxpVCY4wzRuruQ+ZaRxOBVQLnlT3Q5jTm4pphLQAz3MX5l
   abtsZ6S+bWALC2dTDUMqXVgJK1+Nwfpj+Z82VtKEEEiJ/ISUIYItDXMpy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="243347941"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="243347941"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:51:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="588627300"
Received: from pgbarran-mobl.amr.corp.intel.com (HELO localhost) ([10.212.127.188])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:50:59 -0700
Date:   Wed, 6 Apr 2022 19:50:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 24/45] entry: Split up irqentry_exit_cond_resched()
Message-ID: <Yk5Rk4JALK0hsYym@iweiny-desk3>
References: <20220310172019.850939-1-ira.weiny@intel.com>
 <20220310172019.850939-25-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310172019.850939-25-ira.weiny@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:19:58AM -0800, Ira wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Auxiliary pt_regs space needs to be manipulated by the generic
> entry/exit code.

Because of fix to the irqentry_exit_cond_resched() code[1] this patch needed
rework upon rebasing to 5.18-rc1

This basic design of this patch remains but the code is different.  The
irqentry_exit_cond_resched() still needs to have pt_regs passed into it.

However, this could be safely ignored for this review cycle as well.

As soon as I have a series based on 5.18 I'll resend the full series.

Thanks for understanding,
Ira

[1] 4624a14f4daa ("sched/preempt: Simplify irqentry_exit_cond_resched()
callers") 

> 
> Normally irqentry_exit() would take care of handling any auxiliary
> pt_regs on exit.  Unfortunately, the call to
> irqentry_exit_cond_resched() from xen_pv_evtchn_do_upcall() bypasses the
> normal irqentry_exit() call.  Because of this bypass
> irqentry_exit_cond_resched() will be required to handle any auxiliary
> pt_regs exit handling.  However, this prevents irqentry_exit() from
> being able to call irqentry_exit_cond_resched() and while maintaining
> control of the auxiliary pt_regs.
> 
> Separate out the common functionality of irqentry_exit_cond_resched() so
> that functionality can be used by irqentry_exit().  Add a pt_regs
> parameter in anticipation of having irqentry_exit_cond_resched() handle
> the auxiliary pt_regs separately from irqentry_exit().
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for V9
> 	Update commit message
> 
> Changes for V8
> 	New Patch
> ---
>  arch/x86/entry/common.c      | 2 +-
>  include/linux/entry-common.h | 3 ++-
>  kernel/entry/common.c        | 9 +++++++--
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 6c2826417b33..f1ba770d035d 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -309,7 +309,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
>  
>  	inhcall = get_and_clear_inhcall();
>  	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
> -		irqentry_exit_cond_resched();
> +		irqentry_exit_cond_resched(regs);
>  		instrumentation_end();
>  		restore_inhcall(inhcall);
>  	} else {
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index ddaffc983e62..14fd329847e7 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -451,10 +451,11 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
>  
>  /**
>   * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
> + * @regs:	Pointer to pt_regs of interrupted context
>   *
>   * Conditional reschedule with additional sanity checks.
>   */
> -void irqentry_exit_cond_resched(void);
> +void irqentry_exit_cond_resched(struct pt_regs *regs);
>  
>  void __irqentry_exit_cond_resched(void);
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 490442a48332..f4210a7fc84d 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -395,7 +395,7 @@ void __irqentry_exit_cond_resched(void)
>  DEFINE_STATIC_CALL(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
>  #endif
>  
> -void irqentry_exit_cond_resched(void)
> +static void exit_cond_resched(void)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPTION)) {
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> @@ -406,6 +406,11 @@ void irqentry_exit_cond_resched(void)
>  	}
>  }
>  
> +void irqentry_exit_cond_resched(struct pt_regs *regs)
> +{
> +	exit_cond_resched();
> +}
> +
>  noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  {
>  	lockdep_assert_irqs_disabled();
> @@ -431,7 +436,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  		}
>  
>  		instrumentation_begin();
> -		irqentry_exit_cond_resched();
> +		exit_cond_resched();
>  		/* Covers both tracing and lockdep */
>  		trace_hardirqs_on();
>  		instrumentation_end();
> -- 
> 2.35.1
> 
