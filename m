Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D7462618
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhK2WrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhK2WoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:44:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1991C0C236B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:48:30 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RiQocfEa+KcL07bi4FsDIlscRDEQmYX5/b5DFdpHla4=;
        b=JcPT03oqxwZMlfGC+snWvzslDO3DlhLD6KUKR7tn2AIZpgUivHaq8DGCijtzN20DBzEewO
        G3IjrqqgXezY3IvKX2Nsl1IXfNHMyq4P9Db3VMS0fZHgvl+5c2v1RekKyXvHqJDYFY4vnk
        2oBnMNJgMPjKytvCFBLqs0h99aW/OBtHltespV+p/QRhCNM/Ntkzr28i5GUmDRRzijY4r2
        VJeF7xslqqeO5ejoOEj4olN2phzBsLGLqTrUc91QV/B7Ga2V4ahc+SurcRsU8b4AjE0W8f
        5n81+4x29wSEPXF6/oBJxI3CP3NiKs54DxvI2wDqU04jZKuO+Qzny0+Man2uRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RiQocfEa+KcL07bi4FsDIlscRDEQmYX5/b5DFdpHla4=;
        b=DFp29oTyJYt/hqCjhg0w37BSo1zgNzCmIJq2FRw4+djmriebobd/G0AOJubkMkj/pgA2mh
        /JxpmMp0r2CURKDQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/11] lockdep/selftests: Skip the softirq related tests on PREEMPT_RT
Date:   Mon, 29 Nov 2021 18:46:51 +0100
Message-Id: <20211129174654.668506-9-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softirq context on PREEMPT_RT is different compared to !PREEMPT_RT.
As such lockdep_softirq_enter() is a nop and the all the "softirq safe"
tests fail on PREEMPT_RT because there is no difference.

Skip the softirq context tests on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/locking-selftest.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 417056ba28e1f..9031f50905aed 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -26,6 +26,12 @@
 #include <linux/rtmutex.h>
 #include <linux/local_lock.h>
=20
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
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_spin)
=20
@@ -816,10 +823,12 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_rlock)
=20
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_wlock)
+#endif
=20
 #undef E1
 #undef E2
=20
+#ifndef CONFIG_PREEMPT_RT
 /*
  * Enabling hardirqs with a softirq-safe lock held:
  */
@@ -852,6 +861,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #undef E1
 #undef E2
=20
+#endif
+
 /*
  * Enabling irqs with an irq-safe lock held:
  */
@@ -881,6 +892,7 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_wlock)
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_spin)
=20
@@ -889,6 +901,7 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_rlock)
=20
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
+#endif
=20
 #undef E1
 #undef E2
@@ -927,6 +940,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_wlock)
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_spin)
=20
@@ -935,6 +949,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_rlock)
=20
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
+#endif
=20
 #undef E1
 #undef E2
@@ -975,6 +990,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_rlock)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_wlock)
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_spin)
=20
@@ -983,6 +999,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_rlock)
=20
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_wlock)
+#endif
=20
 #undef E1
 #undef E2
@@ -1037,6 +1054,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_hard_rlo=
ck)
 #include "locking-selftest-wlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_hard_wlock)
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-spin-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_spin)
=20
@@ -1045,6 +1063,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_rlo=
ck)
=20
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
+#endif
=20
 #undef E1
 #undef E2
@@ -1212,12 +1231,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_h=
ard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_wlock)
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_rlock)
=20
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_wlock)
+#endif
=20
 #undef E1
 #undef E2
@@ -1258,12 +1279,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_=
hard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_wlock)
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
=20
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
+#endif
=20
 #undef E1
 #undef E2
@@ -1312,12 +1335,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_=
hard_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_wlock)
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_rlock)
=20
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
+#endif
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
@@ -1523,7 +1548,7 @@ static inline void print_testname(const char *testnam=
e)
=20
 #define DO_TESTCASE_2x2RW(desc, name, nr)			\
 	DO_TESTCASE_2RW("hard-"desc, name##_hard, nr)		\
-	DO_TESTCASE_2RW("soft-"desc, name##_soft, nr)		\
+	NON_RT(DO_TESTCASE_2RW("soft-"desc, name##_soft, nr))	\
=20
 #define DO_TESTCASE_6x2x2RW(desc, name)				\
 	DO_TESTCASE_2x2RW(desc, name, 123);			\
@@ -1571,19 +1596,19 @@ static inline void print_testname(const char *testn=
ame)
=20
 #define DO_TESTCASE_2I(desc, name, nr)				\
 	DO_TESTCASE_1("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_1("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_1("soft-"desc, name##_soft, nr));
=20
 #define DO_TESTCASE_2IB(desc, name, nr)				\
 	DO_TESTCASE_1B("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_1B("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_1B("soft-"desc, name##_soft, nr));
=20
 #define DO_TESTCASE_6I(desc, name, nr)				\
 	DO_TESTCASE_3("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_3("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_3("soft-"desc, name##_soft, nr));
=20
 #define DO_TESTCASE_6IRW(desc, name, nr)			\
 	DO_TESTCASE_3RW("hard-"desc, name##_hard, nr);		\
-	DO_TESTCASE_3RW("soft-"desc, name##_soft, nr);
+	NON_RT(DO_TESTCASE_3RW("soft-"desc, name##_soft, nr));
=20
 #define DO_TESTCASE_2x3(desc, name)				\
 	DO_TESTCASE_3(desc, name, 12);				\
@@ -2909,12 +2934,11 @@ void locking_selftest(void)
 	DO_TESTCASE_6x1RR("rlock W1R2/R2R3/W3W1", W1R2_R2R3_W3W1);
=20
 	printk("  ---------------------------------------------------------------=
-----------\n");
-
 	/*
 	 * irq-context testcases:
 	 */
 	DO_TESTCASE_2x6("irqs-on + irq-safe-A", irqsafe1);
-	DO_TESTCASE_2x3("sirq-safe-A =3D> hirqs-on", irqsafe2A);
+	NON_RT(DO_TESTCASE_2x3("sirq-safe-A =3D> hirqs-on", irqsafe2A));
 	DO_TESTCASE_2x6("safe-A + irqs-on", irqsafe2B);
 	DO_TESTCASE_6x6("safe-A + unsafe-B #1", irqsafe3);
 	DO_TESTCASE_6x6("safe-A + unsafe-B #2", irqsafe4);
--=20
2.34.0

