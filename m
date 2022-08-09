Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962A58E3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHIXSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHIXSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:18:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E939461DBE
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:18:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660087111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49BR0x796LXoJ0VhQzJr4EQaUub9aq/xCwbr1Uy7JZk=;
        b=upJCVu7v+BJugzpD9dLKrlHgXZINP3F4S+n0ysjUqHvUEydbmm0eIPKWsP5p0UMnA3TYyH
        +TFpc35CmLXz7Zg8bPXdY2HNbvHv9V5cG8hlJq810fL5ht2agyxpPQUAvFIz1Urjb+xdns
        CKIiL30f1q5Yqqfx0BuWx/kq1HtO4dzYhG+is8WFtJd4T/iZNvM37U0aLrYWSyzHFyqbu3
        ubnIRrHTbmv4USJZcZOrKP+xNMNthjC9I+IAgustXu0ndWmegF2hm0cf3lRQORkohEC/bP
        60h3nPQznbkW82NmMmu3eft4UnNaRPF3b5nbNgw8rYyprug5eWwbRIM9V+W1Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660087111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49BR0x796LXoJ0VhQzJr4EQaUub9aq/xCwbr1Uy7JZk=;
        b=bQ8bUaL+l2tqSf1Y2TuxxI63mBSDGryCDh4JjNRVoN/gw99rBKqmksnMfsljxFlPQnp9+R
        0/q9xr9y5tx3tKAw==
To:     Borislav Petkov <bp@alien8.de>, ira.weiny@intel.com
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [RFC PATCH 1/5] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
In-Reply-To: <YvDnkALyHl77R/Ug@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-2-ira.weiny@intel.com> <YvDnkALyHl77R/Ug@zn.tnic>
Date:   Wed, 10 Aug 2022 01:18:30 +0200
Message-ID: <87fsi5qa49.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08 2022 at 12:38, Borislav Petkov wrote:
> On Fri, Aug 05, 2022 at 10:30:05AM -0700, ira.weiny@intel.com wrote:
>> ---
>>  arch/arm64/include/asm/preempt.h |  2 +-
>>  arch/arm64/kernel/entry-common.c |  4 ++--
>>  arch/x86/entry/common.c          |  2 +-
>>  include/linux/entry-common.h     | 17 ++++++++------
>>  kernel/entry/common.c            | 13 +++++++----
>>  kernel/sched/core.c              | 40 ++++++++++++++++----------------
>>  6 files changed, 43 insertions(+), 35 deletions(-)
>
> Why all this churn?
>
> Why can't you add a parameter to irqentry_exit():
>
>   noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state, bool cond_resched);
>
> and then have all callers except xen_pv_evtchn_do_upcall() pass in false
> and this way have all exit paths end up in irqentry_exit()?
>
> And, ofc, move the true case which is the body of
> raw_irqentry_exit_cond_resched() to irqentry_exit() and then get rid of
> former.
>
> xen_pv_evtchn_do_upcall() will, ofc, do:
>
>         if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
>                 irqentry_exit(regs, state, true);
>                 instrumentation_end();
>                 restore_inhcall(inhcall);
>         } else {
>                 instrumentation_end();
>                 irqentry_exit(regs, state, false);
>

How is that less churn? Care to do:

    git grep 'irqentry_exit(' arch/

The real question is:

    Why is it required that irqentry_exit_cond_resched() handles any of
    the auxiliary pt regs space?
    
That's completely unanswered by the changelog and absolutely irrelevant
for the problem at hand, i.e. storing the CPU number on irq/exception
entry.

    So why is this patch in this series at all?

But even for future purposes it is more than questionable. Why?

Contrary to the claim of the changelog xen_pv_evtchn_do_upcall() is not
really a bypass of irqentry_exit(). The point is:

The hypercall is issued by the kernel from privcmd_ioctl_hypercall()
which does:

      xen_preemptible_hcall_begin();
      hypercall();
      xen_preemptible_hcall_end();

So any upcall from the hypervisor to the guest will semantically hit
regular interrupt enabled guest kernel space which means that if that
code would call irqentry_exit() then it would run through the kernel
exit code path:

	} else if (!regs_irqs_disabled(regs)) {

		instrumentation_begin();
		if (IS_ENABLED(CONFIG_PREEMPTION))
			irqentry_exit_cond_resched();

		/* Covers both tracing and lockdep */
		trace_hardirqs_on();
		instrumentation_end();
       } ....

Which would fail to invoke irqentry_exit_cond_resched() if
CONFIG_PREEMPTION=n.  But the whole point of this exercise is to allow
preemption from the upcall even when the kernel has CONFIG_PREEMPTION=n.

Staring at this XENPV code there are two issues:

  1) That code lacks a trace_hardirqs_on() after the call to
     irqentry_exit_cond_resched(). My bad.

  2) CONFIG_PREEMPT_DYNAMIC broke this mechanism.

     If the static call/key is disabled then the call becomes a NOP.

     Frederic?

Both clearly demonstrate how well tested this XEN_PV muck is which means
we should just delete it.

Anyway. This wants the fix below.

If there is still a need to do anything about this XEN cond_resched()
muck for the PREEMPTION=n case for future auxregs usage then this can be
simply hidden in this new XEN helper and does not need any change to the
rest of the code.

I doubt that this is required, but if so then there needs to be a very
concise explanation and not just uncomprehensible hand waving word
salad.

Thanks,

        tglx
---
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -283,9 +283,18 @@ static __always_inline void restore_inhc
 {
 	__this_cpu_write(xen_in_preemptible_hcall, inhcall);
 }
+
+static __always_inline void xenpv_irqentry_exit_cond_resched(void)
+{
+	instrumentation_begin();
+	raw_irqentry_exit_cond_resched();
+	trace_hardirqs_on();
+	instrumentation_end();
+}
 #else
 static __always_inline bool get_and_clear_inhcall(void) { return false; }
 static __always_inline void restore_inhcall(bool inhcall) { }
+static __always_inline void xenpv_irqentry_exit_cond_resched(void) { }
 #endif
 
 static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
@@ -306,11 +315,11 @@ static void __xen_pv_evtchn_do_upcall(st
 
 	instrumentation_begin();
 	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
+	instrumentation_end();
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		irqentry_exit_cond_resched();
-		instrumentation_end();
+		xenpv_irqentry_exit_cond_resched();
 		restore_inhcall(inhcall);
 	} else {
 		instrumentation_end();
