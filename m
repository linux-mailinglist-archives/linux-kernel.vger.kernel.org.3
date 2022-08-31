Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3EA5A8540
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiHaSOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiHaSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0299F23C2;
        Wed, 31 Aug 2022 11:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1030A61C61;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18877C4314C;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=LUL2A+Zv7HuiXq34oyc7N/QVEedua4nTRyKRGZjm96M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0M3RvBkJ2xop124SqXh5CSYeQ0UMLip0nB+A3jC/PuoQZ3Ke7r/LkZciR/k5Zhwl
         OihU5JO4MnjIfWq7Tu+Mt1Bf8fsmlndfPMkTOgQUyPlw7eU/Wu7QeEb3rML4wLCy+C
         eTAmIu9srIaVLlNhZteWhzVZ1TzQfHSULe9NUEizod8PVtADudALvS1okbGpF5IVla
         WNeaQJ0o/s50EwvloyUdOcnRoSFXviGU4K3DLFhUNXVhRhd0vwSTGoQZcghPIdo4pD
         m/slWnpUYM9vjN2lSj1z1yMHEo6zsDchtNMJ1MGmy5SqDNx3XPOA3mPLSvR1J7oAmv
         n35UbSZIsyRnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C3585C0AAE; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/25] rcu: Add full-sized polling for cond_sync_full()
Date:   Wed, 31 Aug 2022 11:11:56 -0700
Message-Id: <20220831181210.2695080-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cond_synchronize_rcu() API compresses the combined expedited and
normal grace-period states into a single unsigned long, which conserves
storage, but can miss grace periods in certain cases involving overlapping
normal and expedited grace periods.  Missing the occasional grace period
is usually not a problem, but there are use cases that care about each
and every grace period.

This commit therefore adds yet another member of the full-state RCU
grace-period polling API, which is the cond_synchronize_rcu_full()
function.  This uses up to three times the storage (rcu_gp_oldstate
structure instead of unsigned long), but is guaranteed not to miss
grace periods.

[ paulmck: Apply feedback from kernel test robot and Julia Lawall. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  5 +++
 include/linux/rcutree.h |  1 +
 kernel/rcu/rcutorture.c | 67 +++++++++++++++++++++++++++++------------
 kernel/rcu/tree.c       | 28 ++++++++++++++++-
 4 files changed, 80 insertions(+), 21 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 653e35777a99b..3bee97f76bf43 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -44,6 +44,11 @@ static inline void cond_synchronize_rcu(unsigned long oldstate)
 	might_sleep();
 }
 
+static inline void cond_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	cond_synchronize_rcu(rgosp->rgos_norm);
+}
+
 static inline unsigned long start_poll_synchronize_rcu_expedited(void)
 {
 	return start_poll_synchronize_rcu();
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 7151fd8617365..1b44288c027da 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -57,6 +57,7 @@ void start_poll_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
 bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu(unsigned long oldstate);
+void cond_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 
 bool rcu_is_idle_cpu(int cpu);
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f9ca33555debf..9d22161bf7700 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -84,6 +84,7 @@ torture_param(int, fwd_progress_holdoff, 60, "Time between forward-progress test
 torture_param(bool, fwd_progress_need_resched, 1, "Hide cond_resched() behind need_resched()");
 torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
 torture_param(bool, gp_cond_exp, false, "Use conditional/async expedited GP wait primitives");
+torture_param(bool, gp_cond_full, false, "Use conditional/async full-state GP wait primitives");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(bool, gp_normal, false, "Use normal (non-expedited) GP wait primitives");
 torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
@@ -196,20 +197,22 @@ static int rcu_torture_writer_state;
 #define RTWS_DEF_FREE		3
 #define RTWS_EXP_SYNC		4
 #define RTWS_COND_GET		5
-#define RTWS_COND_GET_EXP	6
-#define RTWS_COND_SYNC		7
-#define RTWS_COND_SYNC_EXP	8
-#define RTWS_POLL_GET		9
-#define RTWS_POLL_GET_FULL	10
-#define RTWS_POLL_GET_EXP	11
-#define RTWS_POLL_GET_EXP_FULL	12
-#define RTWS_POLL_WAIT		13
-#define RTWS_POLL_WAIT_FULL	14
-#define RTWS_POLL_WAIT_EXP	15
-#define RTWS_POLL_WAIT_EXP_FULL	16
-#define RTWS_SYNC		17
-#define RTWS_STUTTER		18
-#define RTWS_STOPPING		19
+#define RTWS_COND_GET_FULL	6
+#define RTWS_COND_GET_EXP	7
+#define RTWS_COND_SYNC		8
+#define RTWS_COND_SYNC_FULL	9
+#define RTWS_COND_SYNC_EXP	10
+#define RTWS_POLL_GET		11
+#define RTWS_POLL_GET_FULL	12
+#define RTWS_POLL_GET_EXP	13
+#define RTWS_POLL_GET_EXP_FULL	14
+#define RTWS_POLL_WAIT		15
+#define RTWS_POLL_WAIT_FULL	16
+#define RTWS_POLL_WAIT_EXP	17
+#define RTWS_POLL_WAIT_EXP_FULL	18
+#define RTWS_SYNC		19
+#define RTWS_STUTTER		20
+#define RTWS_STOPPING		21
 static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_FIXED_DELAY",
 	"RTWS_DELAY",
@@ -217,8 +220,10 @@ static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_DEF_FREE",
 	"RTWS_EXP_SYNC",
 	"RTWS_COND_GET",
+	"RTWS_COND_GET_FULL",
 	"RTWS_COND_GET_EXP",
 	"RTWS_COND_SYNC",
+	"RTWS_COND_SYNC_FULL",
 	"RTWS_COND_SYNC_EXP",
 	"RTWS_POLL_GET",
 	"RTWS_POLL_GET_FULL",
@@ -355,6 +360,7 @@ struct rcu_torture_ops {
 	bool (*poll_gp_state_full)(struct rcu_gp_oldstate *rgosp);
 	bool (*poll_need_2gp)(bool poll, bool poll_full);
 	void (*cond_sync)(unsigned long oldstate);
+	void (*cond_sync_full)(struct rcu_gp_oldstate *rgosp);
 	call_rcu_func_t call;
 	void (*cb_barrier)(void);
 	void (*fqs)(void);
@@ -532,6 +538,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.poll_gp_state_full	= poll_state_synchronize_rcu_full,
 	.poll_need_2gp		= rcu_poll_need_2gp,
 	.cond_sync		= cond_synchronize_rcu,
+	.cond_sync_full		= cond_synchronize_rcu_full,
 	.get_gp_state_exp	= get_state_synchronize_rcu,
 	.start_gp_poll_exp	= start_poll_synchronize_rcu_expedited,
 	.start_gp_poll_exp_full	= start_poll_synchronize_rcu_expedited_full,
@@ -1175,16 +1182,17 @@ static int nsynctypes;
  */
 static void rcu_torture_write_types(void)
 {
-	bool gp_cond1 = gp_cond, gp_cond_exp1 = gp_cond_exp, gp_exp1 = gp_exp;
-	bool gp_poll_exp1 = gp_poll_exp, gp_poll_exp_full1 = gp_poll_exp_full;
+	bool gp_cond1 = gp_cond, gp_cond_exp1 = gp_cond_exp, gp_cond_full1 = gp_cond_full;
+	bool gp_exp1 = gp_exp, gp_poll_exp1 = gp_poll_exp, gp_poll_exp_full1 = gp_poll_exp_full;
 	bool gp_normal1 = gp_normal, gp_poll1 = gp_poll, gp_poll_full1 = gp_poll_full;
 	bool gp_sync1 = gp_sync;
 
 	/* Initialize synctype[] array.  If none set, take default. */
-	if (!gp_cond1 && !gp_cond_exp1 && !gp_exp1 && !gp_poll_exp && !gp_poll_exp_full1 &&
-	    !gp_normal1 && !gp_poll1 && !gp_poll_full1 && !gp_sync1)
-		gp_cond1 = gp_cond_exp1 = gp_exp1 = gp_poll_exp1 = gp_poll_exp_full1 =
-			   gp_normal1 = gp_poll1 = gp_poll_full1 = gp_sync1 = true;
+	if (!gp_cond1 && !gp_cond_exp1 && !gp_cond_full1 && !gp_exp1 && !gp_poll_exp &&
+	    !gp_poll_exp_full1 && !gp_normal1 && !gp_poll1 && !gp_poll_full1 && !gp_sync1)
+		gp_cond1 = gp_cond_exp1 = gp_cond_full1 = gp_exp1 = gp_poll_exp1 =
+			   gp_poll_exp_full1 = gp_normal1 = gp_poll1 = gp_poll_full1 =
+			   gp_sync1 = true;
 	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
 		pr_info("%s: Testing conditional GPs.\n", __func__);
@@ -1197,6 +1205,12 @@ static void rcu_torture_write_types(void)
 	} else if (gp_cond_exp && (!cur_ops->get_gp_state_exp || !cur_ops->cond_sync_exp)) {
 		pr_alert("%s: gp_cond_exp without primitives.\n", __func__);
 	}
+	if (gp_cond_full1 && cur_ops->get_gp_state && cur_ops->cond_sync_full) {
+		synctype[nsynctypes++] = RTWS_COND_GET_FULL;
+		pr_info("%s: Testing conditional full-state GPs.\n", __func__);
+	} else if (gp_cond_full && (!cur_ops->get_gp_state || !cur_ops->cond_sync_full)) {
+		pr_alert("%s: gp_cond_full without primitives.\n", __func__);
+	}
 	if (gp_exp1 && cur_ops->exp_sync) {
 		synctype[nsynctypes++] = RTWS_EXP_SYNC;
 		pr_info("%s: Testing expedited GPs.\n", __func__);
@@ -1396,6 +1410,14 @@ rcu_torture_writer(void *arg)
 				cur_ops->cond_sync_exp(gp_snap);
 				rcu_torture_pipe_update(old_rp);
 				break;
+			case RTWS_COND_GET_FULL:
+				rcu_torture_writer_state = RTWS_COND_GET_FULL;
+				cur_ops->get_gp_state_full(&gp_snap_full);
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				rcu_torture_writer_state = RTWS_COND_SYNC_FULL;
+				cur_ops->cond_sync_full(&gp_snap_full);
+				rcu_torture_pipe_update(old_rp);
+				break;
 			case RTWS_POLL_GET:
 				rcu_torture_writer_state = RTWS_POLL_GET;
 				gp_snap = cur_ops->start_gp_poll();
@@ -1540,6 +1562,11 @@ rcu_torture_fakewriter(void *arg)
 				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
 				cur_ops->cond_sync_exp(gp_snap);
 				break;
+			case RTWS_COND_GET_FULL:
+				cur_ops->get_gp_state_full(&gp_snap_full);
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				cur_ops->cond_sync_full(&gp_snap_full);
+				break;
 			case RTWS_POLL_GET:
 				gp_snap = cur_ops->start_gp_poll();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0a24ef4d6b823..5c46c0d34ef0d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3749,7 +3749,6 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu_full);
 
 /**
  * cond_synchronize_rcu - Conditionally wait for an RCU grace period
- *
  * @oldstate: value from get_state_synchronize_rcu(), start_poll_synchronize_rcu(), or start_poll_synchronize_rcu_expedited()
  *
  * If a full RCU grace period has elapsed since the earlier call to
@@ -3773,6 +3772,33 @@ void cond_synchronize_rcu(unsigned long oldstate)
 }
 EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
 
+/**
+ * cond_synchronize_rcu_full - Conditionally wait for an RCU grace period
+ * @rgosp: value from get_state_synchronize_rcu_full(), start_poll_synchronize_rcu_full(), or start_poll_synchronize_rcu_expedited_full()
+ *
+ * If a full RCU grace period has elapsed since the call to
+ * get_state_synchronize_rcu_full(), start_poll_synchronize_rcu_full(),
+ * or start_poll_synchronize_rcu_expedited_full() from which @rgosp was
+ * obtained, just return.  Otherwise, invoke synchronize_rcu() to wait
+ * for a full grace period.
+ *
+ * Yes, this function does not take counter wrap into account.
+ * But counter wrap is harmless.  If the counter wraps, we have waited for
+ * more than 2 billion grace periods (and way more on a 64-bit system!),
+ * so waiting for a couple of additional grace periods should be just fine.
+ *
+ * This function provides the same memory-ordering guarantees that
+ * would be provided by a synchronize_rcu() that was invoked at the call
+ * to the function that provided @rgosp and that returned at the end of
+ * this function.
+ */
+void cond_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	if (!poll_state_synchronize_rcu_full(rgosp))
+		synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(cond_synchronize_rcu_full);
+
 /*
  * Check to see if there is any immediate RCU-related work to be done by
  * the current CPU, returning 1 if so and zero otherwise.  The checks are
-- 
2.31.1.189.g2e36527f23

