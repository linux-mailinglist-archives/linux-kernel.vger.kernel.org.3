Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D16C469D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387433AbhLFPbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:31:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357746AbhLFPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:14 -0500
Date:   Mon, 06 Dec 2021 15:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+9F5EsGytKdgZU4XV76nqkNnzRQxT/NwLmTBaXbKK0=;
        b=UPmu4/nlqWQl3+YBlv4bCS0bV5Ka/19mAbdONyDb/DVql2BbRbvtpLMspHf6QDJcJP3peV
        ubPyxuGNl+haG+i5bFP3FFXduj7Mg2vzfITG6lv3JRg7TZBr5fHrSVtAHD9LpmJ9D5CCel
        PuRSwZkkE3i733Av4JA+QTPR+5rCaS2+MMydJSUIRteZw3S6QFCaqv+KHYpSAVNubWd1mY
        PgDZs5rw03XeYAMa0jdPdWScicsADi44meXun3xI9FbN7nWUChqn6FLVbS0aF6B5+U9ksC
        CbBy+kaDHodZ+tzuXxfY46tkKq+HPo/JIBs83DnUpYmJpsrpE2KBHEqnafQSEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+9F5EsGytKdgZU4XV76nqkNnzRQxT/NwLmTBaXbKK0=;
        b=u66w6dS2w5SsJQrcm1+MyWOPkxjvo4ssX1yapsUAL92rOaF1g5+Zt+U9S1VgiPyTKNqSl8
        4fK2Tu0Gl2B9XKAg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftests: Skip the softirq related tests
 on PREEMPT_RT
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-9-bigeasy@linutronix.de>
References: <20211129174654.668506-9-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880374357.11128.11136600066709598926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a529f8db897625859b640b565325463e5d5ff01e
Gitweb:        https://git.kernel.org/tip/a529f8db897625859b640b565325463e5d5ff01e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:24 +01:00

lockdep/selftests: Skip the softirq related tests on PREEMPT_RT

The softirq context on PREEMPT_RT is different compared to !PREEMPT_RT.
As such lockdep_softirq_enter() is a nop and the all the "softirq safe"
tests fail on PREEMPT_RT because there is no difference.

Skip the softirq context tests on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-9-bigeasy@linutronix.de
---
 lib/locking-selftest.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 417056b..9031f50 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -26,6 +26,12 @@
 #include <linux/rtmutex.h>
 #include <linux/local_lock.h>
 
+#ifdef CONFIG_PREEMPT_RT
+# define NON_RT(...)
+#else
+# define NON_RT(...)	__VA_ARGS__
+#endif
+
 /*
  * Change this to 1 if you want to see the failure printouts:
  */
@@ -808,6 +814,7 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_spin)
 
@@ -816,10 +823,12 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
 
+#ifndef CONFIG_PREEMPT_RT
 /*
  * Enabling hardirqs with a softirq-safe lock held:
  */
@@ -852,6 +861,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #undef E1
 #undef E2
 
+#endif
+
 /*
  * Enabling irqs with an irq-safe lock held:
  */
@@ -881,6 +892,7 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_spin)
 
@@ -889,6 +901,7 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
@@ -927,6 +940,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_spin)
 
@@ -935,6 +949,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
@@ -975,6 +990,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_spin)
 
@@ -983,6 +999,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
@@ -1037,6 +1054,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_spin)
 
@@ -1045,6 +1063,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_rlock)
 
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
@@ -1212,12 +1231,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_rlock)
 
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
@@ -1258,12 +1279,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
 
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
+#endif
 
 #undef E1
 #undef E2
@@ -1312,12 +1335,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_wlock)
 
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_rlock)
 
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
+#endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
@@ -1523,7 +1548,7 @@ static inline void print_testname(const char *testname)
 
 #define DO_TESTCASE_2x2RW(desc, name, nr)			\
 	DO_TESTCASE_2RW("hard-"desc, name##_hard, nr)		\
-	DO_TESTCASE_2RW("soft-"desc, name##_soft, nr)		\
+	NON_RT(DO_TESTCASE_2RW("soft-"desc, name##_soft, nr))	\
 
 #define DO_TESTCASE_6x2x2RW(desc, name)				\
 	DO_TESTCASE_2x2RW(desc, name, 123);			\
@@ -1571,19 +1596,19 @@ static inline void print_testname(const char *testname)
 
 #define DO_TESTCASE_2I(desc, name, nr)				\
 	DO_TESTCASE_1("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_1("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_1("soft-"desc, name##_soft, nr));
 
 #define DO_TESTCASE_2IB(desc, name, nr)				\
 	DO_TESTCASE_1B("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_1B("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_1B("soft-"desc, name##_soft, nr));
 
 #define DO_TESTCASE_6I(desc, name, nr)				\
 	DO_TESTCASE_3("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_3("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_3("soft-"desc, name##_soft, nr));
 
 #define DO_TESTCASE_6IRW(desc, name, nr)			\
 	DO_TESTCASE_3RW("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_3RW("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_3RW("soft-"desc, name##_soft, nr));
 
 #define DO_TESTCASE_2x3(desc, name)				\
 	DO_TESTCASE_3(desc, name, 12);				\
@@ -2909,12 +2934,11 @@ void locking_selftest(void)
 	DO_TESTCASE_6x1RR("rlock W1R2/R2R3/W3W1", W1R2_R2R3_W3W1);
 
 	printk("  --------------------------------------------------------------------------\n");
-
 	/*
 	 * irq-context testcases:
 	 */
 	DO_TESTCASE_2x6("irqs-on + irq-safe-A", irqsafe1);
-	DO_TESTCASE_2x3("sirq-safe-A => hirqs-on", irqsafe2A);
+	NON_RT(DO_TESTCASE_2x3("sirq-safe-A => hirqs-on", irqsafe2A));
 	DO_TESTCASE_2x6("safe-A + irqs-on", irqsafe2B);
 	DO_TESTCASE_6x6("safe-A + unsafe-B #1", irqsafe3);
 	DO_TESTCASE_6x6("safe-A + unsafe-B #2", irqsafe4);
