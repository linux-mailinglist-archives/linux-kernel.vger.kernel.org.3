Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434584A9B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359534AbiBDPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:06:21 -0500
Received: from foss.arm.com ([217.140.110.172]:50242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359532AbiBDPGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:06:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7FD91396;
        Fri,  4 Feb 2022 07:06:17 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 86B4C3F774;
        Fri,  4 Feb 2022 07:06:15 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v2 3/7] sched/preempt: simplify irqentry_exit_cond_resched() callers
Date:   Fri,  4 Feb 2022 15:05:53 +0000
Message-Id: <20220204150557.434610-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204150557.434610-1-mark.rutland@arm.com>
References: <20220204150557.434610-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently callers of irqentry_exit_cond_resched() need to be aware of
whether the function should be indirected via a static call, leading to
ugly ifdeffery in callers.

Save them the hassle with a static inline wrapper that does the right
thing. The raw_irqentry_exit_cond_resched() will also be useful in
subsequent patches which will add conditional wrappers for preemption
functions.

Note: in arch/x86/entry/common.c, xen_pv_evtchn_do_upcall() always calls
irqentry_exit_cond_resched() directly, even when PREEMPT_DYNAMIC is in
use. I believe this is a latent bug (which this patch corrects), but I'm
not entirely certain this wasn't deliberate.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/entry-common.h |  9 ++++++---
 kernel/entry/common.c        | 12 ++++--------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index a01ac1a0a292..dfd84c59b144 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -454,11 +454,14 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  *
  * Conditional reschedule with additional sanity checks.
  */
-void irqentry_exit_cond_resched(void);
+void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#define irqentry_exit_cond_resched_dynamic_enabled	irqentry_exit_cond_resched
+#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
+#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
+#else
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
 #endif
 
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad713684c2e..1739ca79613b 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -380,7 +380,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
-void irqentry_exit_cond_resched(void)
+void raw_irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
 		/* Sanity check RCU and thread stack */
@@ -392,7 +392,7 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
@@ -420,13 +420,9 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-#ifdef CONFIG_PREEMPT_DYNAMIC
-			static_call(irqentry_exit_cond_resched)();
-#else
+		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
-#endif
-		}
+
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
-- 
2.30.2

