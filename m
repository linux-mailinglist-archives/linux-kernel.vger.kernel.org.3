Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5874BC7B2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiBSKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:22:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbiBSKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:21:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236FE26CF;
        Sat, 19 Feb 2022 02:21:30 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:21:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645266088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCXrebfRuAiXbufa2fpWVmW3IFFhv8n+laKp8iH3amg=;
        b=CLyqWTo1+VSA5VlqAlhcLXQU3FtbjQzs9W284qCp15Cn+WVnh2jtrXgk447PxSSMWtyAM7
        77hMVrVNpbDfLlIyRB+COlTdrReS15Qv2h4Sa1r/Q6FhllkMmVYa47eANjb8J9uZZbfIqj
        OhqrhRwUvjyPKWtJyntpa4Y54oOmNfinyPw07dpgJgc/VresJz4P5Y974tHr8ydAYLuRAr
        faf+hJMvh+deanQgfUJt9akXt9Q7/0ew5XyuK9EJeFt+5e8Hw89VPBwRvQJS6cdFCtQzts
        lsQePDRSnCPPDHUojOQXySp1VNp8LZKmzhvrgyCNL8tokQ52lMhEdjuM5boEqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645266088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCXrebfRuAiXbufa2fpWVmW3IFFhv8n+laKp8iH3amg=;
        b=lK2wvUEitOynyrC46W6ZTveaxADa+Wa5vmHXjViOnLnyAI8m046OMlWhWCHqcdK9mN4aGC
        MEzFi0o6+BzlhfAQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/preempt: Refactor sched_dynamic_update()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214165216.2231574-3-mark.rutland@arm.com>
References: <20220214165216.2231574-3-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164526608776.16921.2464031961410342635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8a69fe0be143b0a1af829f85f0e9a1ae7d6a04db
Gitweb:        https://git.kernel.org/tip/8a69fe0be143b0a1af829f85f0e9a1ae7d6a04db
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 14 Feb 2022 16:52:11 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Feb 2022 11:11:07 +01:00

sched/preempt: Refactor sched_dynamic_update()

Currently sched_dynamic_update needs to open-code the enabled/disabled
function names for each preemption model it supports, when in practice
this is a boolean enabled/disabled state for each function.

Make this clearer and avoid repetition by defining the enabled/disabled
states at the function definition, and using helper macros to perform the
static_call_update(). Where x86 currently overrides the enabled
function, it is made to provide both the enabled and disabled states for
consistency, with defaults provided by the core code otherwise.

In subsequent patches this will allow us to support PREEMPT_DYNAMIC
without static calls.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220214165216.2231574-3-mark.rutland@arm.com
---
 arch/x86/include/asm/preempt.h | 10 +++---
 include/linux/entry-common.h   |  2 +-
 kernel/sched/core.c            | 59 ++++++++++++++++++++-------------
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index fe5efbc..5f6daea 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -108,16 +108,18 @@ static __always_inline bool should_resched(int preempt_offset)
 extern asmlinkage void preempt_schedule(void);
 extern asmlinkage void preempt_schedule_thunk(void);
 
-#define __preempt_schedule_func preempt_schedule_thunk
+#define preempt_schedule_dynamic_enabled	preempt_schedule_thunk
+#define preempt_schedule_dynamic_disabled	NULL
 
 extern asmlinkage void preempt_schedule_notrace(void);
 extern asmlinkage void preempt_schedule_notrace_thunk(void);
 
-#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
+#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
+#define preempt_schedule_notrace_dynamic_disabled	NULL
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+DECLARE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 
 #define __preempt_schedule() \
 do { \
@@ -125,7 +127,7 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+DECLARE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 
 #define __preempt_schedule_notrace() \
 do { \
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6..a01ac1a 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -456,6 +456,8 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#define irqentry_exit_cond_resched_dynamic_enabled	irqentry_exit_cond_resched
+#define irqentry_exit_cond_resched_dynamic_disabled	NULL
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 #endif
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a123ffa..bf3a97f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6491,7 +6491,11 @@ NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+#ifndef preempt_schedule_dynamic_enabled
+#define preempt_schedule_dynamic_enabled	preempt_schedule
+#define preempt_schedule_dynamic_disabled	NULL
+#endif
+DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
@@ -6549,7 +6553,11 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+#ifndef preempt_schedule_notrace_dynamic_enabled
+#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
+#define preempt_schedule_notrace_dynamic_disabled	NULL
+#endif
+DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
@@ -8060,9 +8068,13 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#define cond_resched_dynamic_enabled	__cond_resched
+#define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
+#define might_resched_dynamic_enabled	__cond_resched
+#define might_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
@@ -8192,43 +8204,46 @@ int sched_dynamic_mode(const char *str)
 	return -EINVAL;
 }
 
+#define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
+#define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
+
 void sched_dynamic_update(int mode)
 {
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
 	 */
-	static_call_update(cond_resched, __cond_resched);
-	static_call_update(might_resched, __cond_resched);
-	static_call_update(preempt_schedule, __preempt_schedule_func);
-	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+	preempt_dynamic_enable(cond_resched);
+	preempt_dynamic_enable(might_resched);
+	preempt_dynamic_enable(preempt_schedule);
+	preempt_dynamic_enable(preempt_schedule_notrace);
+	preempt_dynamic_enable(irqentry_exit_cond_resched);
 
 	switch (mode) {
 	case preempt_dynamic_none:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		preempt_dynamic_enable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_disable(preempt_schedule);
+		preempt_dynamic_disable(preempt_schedule_notrace);
+		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		preempt_dynamic_enable(cond_resched);
+		preempt_dynamic_enable(might_resched);
+		preempt_dynamic_disable(preempt_schedule);
+		preempt_dynamic_disable(preempt_schedule_notrace);
+		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		static_call_update(cond_resched, (void *)&__static_call_return0);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, __preempt_schedule_func);
-		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_enable(preempt_schedule);
+		preempt_dynamic_enable(preempt_schedule_notrace);
+		preempt_dynamic_enable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
