Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94E506095
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiDSAHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiDSAGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A30222A3;
        Mon, 18 Apr 2022 17:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 646DCB8114E;
        Tue, 19 Apr 2022 00:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DDCC385C9;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=IS66TlnWS5Eiy9CLr4zipmghBlyHKD0nvzdhCVNl4zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDUiUrLxtNPSKbwDSrdkq1Gpg6/5lB5BBITk/Ujts31NHBO+WnJ0XKixOjRLGlz3e
         prlOnwtJtZJwNBL6jJGlncOiEzIEQM9JiQy49puwro/elWMdKZ6vfCcyfaFMJZSWZX
         tbcJdDpLezYjP13Mf1IU33y/CjqGfhrjSYM2adA3O03RsbhWv3M6DsQ1mQJAOS/ne0
         l9aJ7KI8sf7RsOzTAom5xS/BJ58yKpFd6VKsaeejHpxdyXneLagGzEkJsj2EG1JrvI
         KJye454HfbDwdBz8OEqMLvOdeLvgiag/vFi6N/ijYDSEiFrAhLgpWR+l+qPfJIaVLm
         /fMV2CSakMPGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B5955C30D2; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 17/21] srcu: Add contention-triggered addition of srcu_node tree
Date:   Mon, 18 Apr 2022 17:03:18 -0700
Message-Id: <20220419000322.3948903-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit instruments the acquisitions of the srcu_struct structure's
->lock, enabling the initiation of a transition from SRCU_SIZE_SMALL
to SRCU_SIZE_BIG when sufficient contention is experienced.  The
instrumentation counts the number of trylock failures within the confines
of a single jiffy.  If that number exceeds the value specified by the
srcutree.small_contention_lim kernel boot parameter (which defaults to
100), and if the value specified by the srcutree.convert_to_big kernel
boot parameter has the 0x10 bit set (defaults to 0), then a transition
will be automatically initiated.

By default, there will never be any transitions, so that none of the
srcu_struct structures ever gains an srcu_node array.

The useful values for srcutree.convert_to_big are:

0x00:  Never convert.
0x01:  Always convert at init_srcu_struct() time.
0x02:  Convert when rcutorture prints its first round of statistics.
0x03:  Decide conversion approach at boot given system size.
0x10:  Convert if contention is encountered.
0x12:  Convert if contention is encountered or when rcutorture prints
        its first round of statistics, whichever comes first.

The value 0x11 acts the same as 0x01 because the conversion happens
before there is any chance of contention.

[ paulmck: Apply "static" feedback from kernel test robot. ]

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |   9 ++
 include/linux/srcutree.h                      |   2 +
 kernel/rcu/srcutree.c                         | 107 ++++++++++++++----
 3 files changed, 94 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1f1fcac7777d..177e688768c0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5616,6 +5616,7 @@
 				   0:  Never.
 				   1:  At init_srcu_struct() time.
 				   2:  When rcutorture decides to.
+				0x1X:  Above plus if high contention.
 
 			Either way, the srcu_node tree will be sized based
 			on the actual runtime number of CPUs (nr_cpu_ids)
@@ -5638,6 +5639,14 @@
 			expediting.  Set to zero to disable automatic
 			expediting.
 
+	srcutree.small_contention_lim [KNL]
+			Specifies the number of update-side contention
+			events per jiffy will be tolerated before
+			initiating a conversion of an srcu_struct
+			structure to big form.	Note that the value of
+			srcutree.convert_to_big must have the 0x10 bit
+			set for contention-based conversions to occur.
+
 	ssbd=		[ARM64,HW]
 			Speculative Store Bypass Disable control
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 44bd204498a1..1b9ff4ed37e4 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -72,6 +72,8 @@ struct srcu_struct {
 	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	unsigned long srcu_last_gp_end;		/* Last GP end timestamp (ns) */
+	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
+	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c9460374d437..0bc6a0a3edee 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -41,13 +41,29 @@ module_param(counter_wrap_check, ulong, 0444);
 
 /*
  * Control conversion to SRCU_SIZE_BIG:
- * 0: Don't convert at all (default).
- * 1: Convert at init_srcu_struct() time.
- * 2: Convert when rcutorture invokes srcu_torture_stats_print().
+ *    0: Don't convert at all (default).
+ *    1: Convert at init_srcu_struct() time.
+ *    2: Convert when rcutorture invokes srcu_torture_stats_print().
+ *    3: Decide at boot time based on system shape.
+ * 0x1x: Convert when excessive contention encountered.
  */
-static int convert_to_big;
+#define SRCU_SIZING_NONE	0
+#define SRCU_SIZING_INIT	1
+#define SRCU_SIZING_TORTURE	2
+#define SRCU_SIZING_AUTO	3
+#define SRCU_SIZING_CONTEND	0x10
+#define SRCU_SIZING_IS(x) ((convert_to_big & ~SRCU_SIZING_CONTEND) == x)
+#define SRCU_SIZING_IS_NONE() (SRCU_SIZING_IS(SRCU_SIZING_NONE))
+#define SRCU_SIZING_IS_INIT() (SRCU_SIZING_IS(SRCU_SIZING_INIT))
+#define SRCU_SIZING_IS_TORTURE() (SRCU_SIZING_IS(SRCU_SIZING_TORTURE))
+#define SRCU_SIZING_IS_CONTEND() (convert_to_big & SRCU_SIZING_CONTEND)
+static int convert_to_big = SRCU_SIZING_NONE;
 module_param(convert_to_big, int, 0444);
 
+/* Contention events per jiffy to initiate transition to big. */
+static int small_contention_lim __read_mostly = 100;
+module_param(small_contention_lim, int, 0444);
+
 /* Early-boot callback-management, so early that no lock is required! */
 static LIST_HEAD(srcu_boot_list);
 static bool __read_mostly srcu_init_done;
@@ -58,31 +74,40 @@ static void process_srcu(struct work_struct *work);
 static void srcu_delay_timer(struct timer_list *t);
 
 /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
-#define spin_lock_rcu_node(p)					\
-do {									\
-	spin_lock(&ACCESS_PRIVATE(p, lock));			\
-	smp_mb__after_unlock_lock();					\
+#define spin_lock_rcu_node(p)							\
+do {										\
+	spin_lock(&ACCESS_PRIVATE(p, lock));					\
+	smp_mb__after_unlock_lock();						\
 } while (0)
 
 #define spin_unlock_rcu_node(p) spin_unlock(&ACCESS_PRIVATE(p, lock))
 
-#define spin_lock_irq_rcu_node(p)					\
-do {									\
-	spin_lock_irq(&ACCESS_PRIVATE(p, lock));			\
-	smp_mb__after_unlock_lock();					\
+#define spin_lock_irq_rcu_node(p)						\
+do {										\
+	spin_lock_irq(&ACCESS_PRIVATE(p, lock));				\
+	smp_mb__after_unlock_lock();						\
 } while (0)
 
-#define spin_unlock_irq_rcu_node(p)					\
+#define spin_unlock_irq_rcu_node(p)						\
 	spin_unlock_irq(&ACCESS_PRIVATE(p, lock))
 
-#define spin_lock_irqsave_rcu_node(p, flags)			\
-do {									\
-	spin_lock_irqsave(&ACCESS_PRIVATE(p, lock), flags);	\
-	smp_mb__after_unlock_lock();					\
+#define spin_lock_irqsave_rcu_node(p, flags)					\
+do {										\
+	spin_lock_irqsave(&ACCESS_PRIVATE(p, lock), flags);			\
+	smp_mb__after_unlock_lock();						\
 } while (0)
 
-#define spin_unlock_irqrestore_rcu_node(p, flags)			\
-	spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)	\
+#define spin_trylock_irqsave_rcu_node(p, flags)					\
+({										\
+	bool ___locked = spin_trylock_irqsave(&ACCESS_PRIVATE(p, lock), flags);	\
+										\
+	if (___locked)								\
+		smp_mb__after_unlock_lock();					\
+	___locked;								\
+})
+
+#define spin_unlock_irqrestore_rcu_node(p, flags)				\
+	spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)			\
 
 /*
  * Initialize SRCU per-CPU data.  Note that statically allocated
@@ -225,7 +250,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	init_srcu_struct_data(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
-	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 1) {
+	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
 			if (!ssp->sda_is_static) {
 				free_percpu(ssp->sda);
@@ -272,6 +297,15 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+/*
+ * Initiate a transition to SRCU_SIZE_BIG with lock held.
+ */
+static void __srcu_transition_to_big(struct srcu_struct *ssp)
+{
+	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
+	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_ALLOC);
+}
+
 /*
  * Initiate an idempotent transition to SRCU_SIZE_BIG.
  */
@@ -287,10 +321,35 @@ static void srcu_transition_to_big(struct srcu_struct *ssp)
 		spin_unlock_irqrestore_rcu_node(ssp, flags);
 		return;
 	}
-	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_ALLOC);
+	__srcu_transition_to_big(ssp);
 	spin_unlock_irqrestore_rcu_node(ssp, flags);
 }
 
+/*
+ * Acquire the specified srcu_struct structure's ->lock, but check for
+ * excessive contention, which results in initiation of a transition
+ * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
+ * parameter permits this.
+ */
+static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
+{
+	unsigned long j;
+
+	if (spin_trylock_irqsave_rcu_node(ssp, *flags))
+		return;
+	spin_lock_irqsave_rcu_node(ssp, *flags);
+	if (!SRCU_SIZING_IS_CONTEND() || ssp->srcu_size_state)
+		return;
+	j = jiffies;
+	if (ssp->srcu_size_jiffies != j) {
+		ssp->srcu_size_jiffies = j;
+		ssp->srcu_n_lock_retries = 0;
+	}
+	if (++ssp->srcu_n_lock_retries <= small_contention_lim)
+		return;
+	__srcu_transition_to_big(ssp);
+}
+
 /*
  * First-use initialization of statically allocated srcu_struct
  * structure.  Wiring up the combining tree is more than can be
@@ -718,7 +777,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
 			spin_unlock_irqrestore_rcu_node(snp, flags);
 		}
-	spin_lock_irqsave_rcu_node(ssp, flags);
+	spin_lock_irqsave_ssp_contention(ssp, &flags);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
 	spin_unlock_irqrestore_rcu_node(ssp, flags);
@@ -779,7 +838,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		}
 
 	/* Top of tree, must ensure the grace period will be started. */
-	spin_lock_irqsave_rcu_node(ssp, flags);
+	spin_lock_irqsave_ssp_contention(ssp, &flags);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed, s)) {
 		/*
 		 * Record need for grace period s.  Pair with load
@@ -1542,7 +1601,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		}
 		pr_cont(" T(%ld,%ld)\n", s0, s1);
 	}
-	if (convert_to_big == 2)
+	if (SRCU_SIZING_IS_TORTURE())
 		srcu_transition_to_big(ssp);
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
-- 
2.31.1.189.g2e36527f23

