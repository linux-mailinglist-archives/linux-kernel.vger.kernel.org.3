Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45222473539
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbhLMTqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241743AbhLMTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:46:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC7EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yUSgcqoB9v9UUpBon7RSqOh5MUtdO61wMOqjvq6oJNk=; b=B5ZWXD56kjUw4KfwJOypMp0C31
        nW5u3ZzPvRm8RQ5ExTBhSLHh6t5T97AVQeqDnksjCmkMGwNPK+/fDvyY2z72hAZsdAtgQ6rCsxJ1b
        4ap4/7ROxqqzmFk3Djlex9uZ0sTc94txldKaeJQfFJ6i8gFxpohT7jS/AVFvSnVoMAZQidy4c6/rI
        fNicncnvXIyQGz6HFsifBbZm8C22AMfvmGHp+Xxb5cAYfRNM37JqYyI7/OWPtJRB5BuB7Xs4g0jH3
        5YpAQk18cmDix7Y9mBHkPL019VhXEAw/fnUyP16V1hUnFrknpzDiARYQ4c7xHEZWOIljbNShgssuN
        BzlAyM9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwrHF-00D6mx-11; Mon, 13 Dec 2021 19:46:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCFCF981767; Mon, 13 Dec 2021 20:46:24 +0100 (CET)
Date:   Mon, 13 Dec 2021 20:46:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] X86/db: Change __this_cpu_read() to this_cpu_read()
 in hw_breakpoint_active()
Message-ID: <20211213194624.GZ16608@worktop.programming.kicks-ass.net>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213042215.3096-2-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:22:13PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> __this_cpu_read() can not be instrumented except its own debugging code
> when CONFIG_DEBUG_PREEMPT.  The debugging code will call
> __this_cpu_preempt_check().  __this_cpu_preempt_check() itself is also
> noinstr, so __this_cpu_read() can be used in noinstr.
> 
> But these is one exception when exc_debug_kernel() calls local_db_save()
> which calls hw_breakpoint_active() which calls __this_cpu_read().  If
> the data accessed by __this_cpu_preempt_check() is also watched by
> hw_breakpoints, it would cause recursive #DB.
> 
> this_cpu_read() in X86 is also non instrumentable, and it doesn't access
> to any extra data except the percpu cpu_dr7, and cpu_dr7 is disallowed
> to be watched in arch_build_bp_info().  So this_cpu_read() is safe to
> be used when hw_breakpoints is still active, and __this_cpu_read() here
> should be changed to this_cpu_read().
> 
> This problem can only happen when the system owner uses a kernel with
> CONFIG_DEBUG_PREEMPT enabled and deliberately use hw_breakpoints on
> the data that __this_cpu_preempt_check() accesses.  Sot it is just a
> problem with no significance.
> 
> One might suggest that, all the data accessed by noinstr functions
> should be marked in denylist for hw_breakpoints.  That would complexify
> the noinstrment framework and add hurdles to anyone that who want to
> add a new noinstr function.  All we need is to suppress #DB in the IST
> interrupt entry path until safe place where #DB is disabled in hardware
> or #DB handler can handle well even it hits data accessed by noinstr
> function.  Changing __this_cpu_read() to this_cpu_read() is fit for it.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/include/asm/debugreg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> index cfdf307ddc01..20189ce41578 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
> @@ -87,7 +87,7 @@ static inline void hw_breakpoint_disable(void)
>  
>  static __always_inline bool hw_breakpoint_active(void)
>  {
> -	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
> +	return this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;

I don't really follow the argument for why this_cpu_read(); why not
raw_cpu_read() instead, which is what __this_cpu_read() is based on.
Also, this really needs a comment.

Alternatively, we should remove noinstr from check_preemption_disabled()
and fix up all the fallout, but that seems like far more work than it's
worth.

	/*
	 * Must not hit a breakpoint in check_preempt_disabled()
	 */
	return raw_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;

>  }
>  
>  extern void hw_breakpoint_restore(void);
> -- 
> 2.19.1.6.gb485710b
> 
