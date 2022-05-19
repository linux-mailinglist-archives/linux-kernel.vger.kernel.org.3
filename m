Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4708952DFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiESV5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245304AbiESV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:57:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7657344F7;
        Thu, 19 May 2022 14:57:10 -0700 (PDT)
Date:   Thu, 19 May 2022 21:57:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652997428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNtZdExUT81isRwo6av4c4egoL+scuUoCFP/FSxDy1Q=;
        b=Y9B0fL2ZFYnTUBayo/4Klu9mC+Fk0oiCZZDyzZ3/K3bNikc2C2hOCypdAnvuwbXUKkZR1K
        6P+U3g1tbqIUbI5AeBYArszr3k/6fEv0uBUdAGR6T1HHgeJZl4nOpjWiOGKiUHEYxU6FEc
        +dRaiKCWo+86To/gvXfcaTbpUpkJ3gsZ8pLzzrftiFKcC2mCQhNXfSTUow5e7/9ZJP7HGO
        UcyqteaaDOFO4cwNK0y+tcPXn1KcLaGNEPUuVbYZ4LEnJ84iwBIuDqWaSxwrbNh3w9Nrk7
        J6k9GOz1E7BxFDOpMcMEMNRGPqfCTzFJvJLgVNB4CW4Z9z0Rdb9Zof31s0F/hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652997428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNtZdExUT81isRwo6av4c4egoL+scuUoCFP/FSxDy1Q=;
        b=nZIOBiSMNOs962TmOdfjWa4X+yfmc239PN/Pa6O0jQlsyRqzmmIrS4/i4duoPEd1QYUYC6
        vY0jwRvS2IT1miAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Reverse sched_class layout
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net>
References: <YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165299742766.4207.12663616500512270922.tip-bot2@tip-bot2>
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

Commit-ID:     546a3fee174969ff323d70ff27b1ef181f0d7ceb
Gitweb:        https://git.kernel.org/tip/546a3fee174969ff323d70ff27b1ef181f0d7ceb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 May 2022 13:46:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 May 2022 23:46:13 +02:00

sched: Reverse sched_class layout

Because GCC-12 is fully stupid about array bounds and it's just really
hard to get a solid array definition from a linker script, flip the
array order to avoid needing negative offsets :-/

This makes the whole relational pointer magic a little less obvious, but
alas.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++------
 kernel/sched/core.c               | 12 ++++++------
 kernel/sched/sched.h              | 15 ++++++++-------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 69138e9..7515a46 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -126,13 +126,13 @@
  */
 #define SCHED_DATA				\
 	STRUCT_ALIGN();				\
-	__begin_sched_classes = .;		\
-	*(__idle_sched_class)			\
-	*(__fair_sched_class)			\
-	*(__rt_sched_class)			\
-	*(__dl_sched_class)			\
+	__sched_class_highest = .;		\
 	*(__stop_sched_class)			\
-	__end_sched_classes = .;
+	*(__dl_sched_class)			\
+	*(__rt_sched_class)			\
+	*(__fair_sched_class)			\
+	*(__idle_sched_class)			\
+	__sched_class_lowest = .;
 
 /* The actual configuration determine if the init/exit sections
  * are handled as text/data or they can be discarded (which
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2c9f5e9..66c4e59 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2193,7 +2193,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->sched_class == rq->curr->sched_class)
 		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
-	else if (p->sched_class > rq->curr->sched_class)
+	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
 		resched_curr(rq);
 
 	/*
@@ -5692,7 +5692,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * higher scheduling class, because otherwise those lose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
-	if (likely(prev->sched_class <= &fair_sched_class &&
+	if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
 		   rq->nr_running == rq->cfs.h_nr_running)) {
 
 		p = pick_next_task_fair(rq, prev, rf);
@@ -9472,11 +9472,11 @@ void __init sched_init(void)
 	int i;
 
 	/* Make sure the linker didn't screw up */
-	BUG_ON(&idle_sched_class + 1 != &fair_sched_class ||
-	       &fair_sched_class + 1 != &rt_sched_class ||
-	       &rt_sched_class + 1   != &dl_sched_class);
+	BUG_ON(&idle_sched_class != &fair_sched_class + 1 ||
+	       &fair_sched_class != &rt_sched_class + 1 ||
+	       &rt_sched_class   != &dl_sched_class + 1);
 #ifdef CONFIG_SMP
-	BUG_ON(&dl_sched_class + 1 != &stop_sched_class);
+	BUG_ON(&dl_sched_class != &stop_sched_class + 1);
 #endif
 
 	wait_bit_init();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fe4d1ac..2ce1858 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2177,6 +2177,8 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
  *
  *   include/asm-generic/vmlinux.lds.h
  *
+ * *CAREFUL* they are laid out in *REVERSE* order!!!
+ *
  * Also enforce alignment on the instance, not the type, to guarantee layout.
  */
 #define DEFINE_SCHED_CLASS(name) \
@@ -2185,17 +2187,16 @@ const struct sched_class name##_sched_class \
 	__section("__" #name "_sched_class")
 
 /* Defined in include/asm-generic/vmlinux.lds.h */
-extern struct sched_class __begin_sched_classes[];
-extern struct sched_class __end_sched_classes[];
-
-#define sched_class_highest (__end_sched_classes - 1)
-#define sched_class_lowest  (__begin_sched_classes - 1)
+extern struct sched_class __sched_class_highest[];
+extern struct sched_class __sched_class_lowest[];
 
 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class--)
+	for (class = (_from); class < (_to); class++)
 
 #define for_each_class(class) \
-	for_class_range(class, sched_class_highest, sched_class_lowest)
+	for_class_range(class, __sched_class_highest, __sched_class_lowest)
+
+#define sched_class_above(_a, _b)	((_a) < (_b))
 
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
