Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACAD58E7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiHJHZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiHJHZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:25:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B784193D2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:25:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660116349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffLIQVAGIVPV6ZV8JBI4al5/eLbBn8Xd04Qi2APVWdk=;
        b=gQsDaQUUU4pAyx9RmsXuibIavf9tnZTYd9OZYRVa5gVj/fE1ONDX93WDFolM8syVh7+u4S
        wDeJMoLB3yFhknkW+BX3i88X22r/Efn6eDxlZV6Ix/sLigonRLuMmyg72V3u7Bh/L6HFR6
        mDgUIlQlrDXv/WKj1YpFfPPIdFMbEyWH6TjkFl0oVM+JcCLD35LkEzV2jrx6KV7/MOY8fp
        FwAfC8P2hIRVx8BO5UUWSmjc61iQJW25J7JLkZZkt2g0G0tPUtzVvFIQdZ2EX/u2BOiJQO
        3DsaGA6fVNz93UXnRd9NXmyxqZiFy++lnpyy0fDfbj4uykhKYhaZ1W0jHbzajA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660116349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffLIQVAGIVPV6ZV8JBI4al5/eLbBn8Xd04Qi2APVWdk=;
        b=srsQFUyf59Y1aacJivQ6q93A9cgX0D73ThYUA4+RDUoDYRGXbojmpgC2hTUKb3BKypidvL
        O16/JJmPnCfHMwAA==
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
In-Reply-To: <87fsi5qa49.ffs@tglx>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-2-ira.weiny@intel.com> <YvDnkALyHl77R/Ug@zn.tnic>
 <87fsi5qa49.ffs@tglx>
Date:   Wed, 10 Aug 2022 09:25:48 +0200
Message-ID: <87a68cr24j.ffs@tglx>
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

On Wed, Aug 10 2022 at 01:18, Thomas Gleixner wrote:
> Both clearly demonstrate how well tested this XEN_PV muck is which means
> we should just delete it.
>
> Anyway. This wants the fix below.

which is not sufficient. If CONFIG_PREEMPT_DYNAMIC is set then
CONFIG_PREEMPTION is set too, which makes the preemtible hypercall magic
a complete NOP. So if the dynamic call is disabled, then such a several
seconds (sic!) hypercall cannot be preempted at all.

Something like the below then. Oh well...

Thanks,

        tglx
---
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -253,7 +253,8 @@ SYSCALL_DEFINE0(ni_syscall)
 }
 
 #ifdef CONFIG_XEN_PV
-#ifndef CONFIG_PREEMPTION
+
+#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 /*
  * Some hypercalls issued by the toolstack can take many 10s of
  * seconds. Allow tasks running hypercalls via the privcmd driver to
@@ -283,9 +284,18 @@ static __always_inline void restore_inhc
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
@@ -306,11 +316,11 @@ static void __xen_pv_evtchn_do_upcall(st
 
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
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -416,6 +416,7 @@ irqentry_state_t noinstr irqentry_enter(
  * Conditional reschedule with additional sanity checks.
  */
 void raw_irqentry_exit_cond_resched(void);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -194,7 +194,7 @@ bool xen_running_on_version_or_later(uns
 void xen_efi_runtime_setup(void);
 
 
-#if defined(CONFIG_XEN_PV) && !defined(CONFIG_PREEMPTION)
+#if defined(CONFIG_XEN_PV) && (!defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC))
 
 DECLARE_PER_CPU(bool, xen_in_preemptible_hcall);
 
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -385,6 +385,7 @@ void raw_irqentry_exit_cond_resched(void
 			preempt_schedule_irq();
 	}
 }
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
