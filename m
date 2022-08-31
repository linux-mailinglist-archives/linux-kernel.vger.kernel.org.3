Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6705A854E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiHaSQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiHaSPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:15:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3E0F23FD;
        Wed, 31 Aug 2022 11:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 847DBB82275;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F04C43147;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=TRn3bzJI59okW4J4LYZ5Q0KKoRbfj7YEJocZB+cVgck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxGeMT8xlruhW0/JeJFwnsgkbaUmJCu/LS6a/ac+dTWnN2/Re4ixz0hN37i0S3uQS
         OmQRe0Qb5Rq9VcyBCTuKxJUFGSu9Wqwqts8iDoeEjZhJipoGktoCFI34GgnHXuvMYk
         pj6qZluI93xkSg+TNMoeA+HMjA0VA0H0iJ2VWQk5RpQdxS3u2QCXpqv53pILZBvbr8
         eTy0aTS+Cjs63ytB6ND5CwU5OQO5FeMYhpUKP3H2nuDJYAoLjCUTmT/E4YPND5samO
         BFrCAYI8bDBVZ5Iy5X+RPwAj9R+zxd2MzWz49LIkqbWKDGaq2D4rJN5OJe6dKem1hj
         8FbawG/3sZHew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 666545C0981; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/25] rcu: Add full-sized polling for start_poll()
Date:   Wed, 31 Aug 2022 11:11:53 -0700
Message-Id: <20220831181210.2695080-8-paulmck@kernel.org>
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

The start_poll_synchronize_rcu() API compresses the combined expedited and
normal grace-period states into a single unsigned long, which conserves
storage, but can miss grace periods in certain cases involving overlapping
normal and expedited grace periods.  Missing the occasional grace period
is usually not a problem, but there are use cases that care about each
and every grace period.

This commit therefore adds the next member of the full-state RCU
grace-period polling API, namely the start_poll_synchronize_rcu_full()
function.  This uses up to three times the storage (rcu_gp_oldstate
structure instead of unsigned long), but is guaranteed not to miss
grace periods.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  6 +++++
 include/linux/rcutree.h |  1 +
 kernel/rcu/rcutorture.c | 49 +++++++++++++++++++++++++++-------
 kernel/rcu/tree.c       | 58 ++++++++++++++++++++++++++++++++---------
 4 files changed, 92 insertions(+), 22 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 6e299955c4e9a..6bc30e46a819c 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -26,6 +26,12 @@ static inline void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 }
 
 unsigned long start_poll_synchronize_rcu(void);
+
+static inline void start_poll_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	rgosp->rgos_norm = start_poll_synchronize_rcu();
+}
+
 bool poll_state_synchronize_rcu(unsigned long oldstate);
 
 static inline bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 7b769f1b417aa..8f2e0f0b26f63 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -52,6 +52,7 @@ void cond_synchronize_rcu_expedited(unsigned long oldstate);
 unsigned long get_state_synchronize_rcu(void);
 void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 unsigned long start_poll_synchronize_rcu(void);
+void start_poll_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
 bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu(unsigned long oldstate);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3d85420108477..68387ccc7ddfc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -88,6 +88,7 @@ torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(bool, gp_normal, false, "Use normal (non-expedited) GP wait primitives");
 torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
 torture_param(bool, gp_poll_exp, false, "Use polling expedited GP wait primitives");
+torture_param(bool, gp_poll_full, false, "Use polling full-state GP wait primitives");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
@@ -198,12 +199,14 @@ static int rcu_torture_writer_state;
 #define RTWS_COND_SYNC		7
 #define RTWS_COND_SYNC_EXP	8
 #define RTWS_POLL_GET		9
-#define RTWS_POLL_GET_EXP	10
-#define RTWS_POLL_WAIT		11
-#define RTWS_POLL_WAIT_EXP	12
-#define RTWS_SYNC		13
-#define RTWS_STUTTER		14
-#define RTWS_STOPPING		15
+#define RTWS_POLL_GET_FULL	10
+#define RTWS_POLL_GET_EXP	11
+#define RTWS_POLL_WAIT		12
+#define RTWS_POLL_WAIT_FULL	13
+#define RTWS_POLL_WAIT_EXP	14
+#define RTWS_SYNC		15
+#define RTWS_STUTTER		16
+#define RTWS_STOPPING		17
 static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_FIXED_DELAY",
 	"RTWS_DELAY",
@@ -215,8 +218,10 @@ static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_COND_SYNC",
 	"RTWS_COND_SYNC_EXP",
 	"RTWS_POLL_GET",
+	"RTWS_POLL_GET_FULL",
 	"RTWS_POLL_GET_EXP",
 	"RTWS_POLL_WAIT",
+	"RTWS_POLL_WAIT_FULL",
 	"RTWS_POLL_WAIT_EXP",
 	"RTWS_SYNC",
 	"RTWS_STUTTER",
@@ -339,6 +344,7 @@ struct rcu_torture_ops {
 	unsigned long (*get_gp_completed)(void);
 	void (*get_gp_completed_full)(struct rcu_gp_oldstate *rgosp);
 	unsigned long (*start_gp_poll)(void);
+	void (*start_gp_poll_full)(struct rcu_gp_oldstate *rgosp);
 	bool (*poll_gp_state)(unsigned long oldstate);
 	bool (*poll_gp_state_full)(struct rcu_gp_oldstate *rgosp);
 	bool (*poll_need_2gp)(bool poll, bool poll_full);
@@ -515,6 +521,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.get_gp_completed	= get_completed_synchronize_rcu,
 	.get_gp_completed_full	= get_completed_synchronize_rcu_full,
 	.start_gp_poll		= start_poll_synchronize_rcu,
+	.start_gp_poll_full	= start_poll_synchronize_rcu_full,
 	.poll_gp_state		= poll_state_synchronize_rcu,
 	.poll_gp_state_full	= poll_state_synchronize_rcu_full,
 	.poll_need_2gp		= rcu_poll_need_2gp,
@@ -1163,13 +1170,13 @@ static void rcu_torture_write_types(void)
 {
 	bool gp_cond1 = gp_cond, gp_cond_exp1 = gp_cond_exp, gp_exp1 = gp_exp;
 	bool gp_poll_exp1 = gp_poll_exp, gp_normal1 = gp_normal, gp_poll1 = gp_poll;
-	bool gp_sync1 = gp_sync;
+	bool gp_poll_full1 = gp_poll_full, gp_sync1 = gp_sync;
 
 	/* Initialize synctype[] array.  If none set, take default. */
 	if (!gp_cond1 && !gp_cond_exp1 && !gp_exp1 && !gp_poll_exp &&
-	    !gp_normal1 && !gp_poll1 && !gp_sync1)
+	    !gp_normal1 && !gp_poll1 && !gp_poll_full1 && !gp_sync1)
 		gp_cond1 = gp_cond_exp1 = gp_exp1 = gp_poll_exp1 =
-			   gp_normal1 = gp_poll1 = gp_sync1 = true;
+			   gp_normal1 = gp_poll1 = gp_poll_full1 = gp_sync1 = true;
 	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
 		pr_info("%s: Testing conditional GPs.\n", __func__);
@@ -1200,6 +1207,12 @@ static void rcu_torture_write_types(void)
 	} else if (gp_poll && (!cur_ops->start_gp_poll || !cur_ops->poll_gp_state)) {
 		pr_alert("%s: gp_poll without primitives.\n", __func__);
 	}
+	if (gp_poll_full1 && cur_ops->start_gp_poll_full && cur_ops->poll_gp_state_full) {
+		synctype[nsynctypes++] = RTWS_POLL_GET_FULL;
+		pr_info("%s: Testing polling full-state GPs.\n", __func__);
+	} else if (gp_poll_full && (!cur_ops->start_gp_poll_full || !cur_ops->poll_gp_state_full)) {
+		pr_alert("%s: gp_poll_full without primitives.\n", __func__);
+	}
 	if (gp_poll_exp1 && cur_ops->start_gp_poll_exp && cur_ops->poll_gp_state_exp) {
 		synctype[nsynctypes++] = RTWS_POLL_GET_EXP;
 		pr_info("%s: Testing polling expedited GPs.\n", __func__);
@@ -1262,6 +1275,7 @@ rcu_torture_writer(void *arg)
 	struct rcu_gp_oldstate cookie_full;
 	int expediting = 0;
 	unsigned long gp_snap;
+	struct rcu_gp_oldstate gp_snap_full;
 	int i;
 	int idx;
 	int oldnice = task_nice(current);
@@ -1376,6 +1390,15 @@ rcu_torture_writer(void *arg)
 								  &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
+			case RTWS_POLL_GET_FULL:
+				rcu_torture_writer_state = RTWS_POLL_GET_FULL;
+				cur_ops->start_gp_poll_full(&gp_snap_full);
+				rcu_torture_writer_state = RTWS_POLL_WAIT_FULL;
+				while (!cur_ops->poll_gp_state_full(&gp_snap_full))
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
+				rcu_torture_pipe_update(old_rp);
+				break;
 			case RTWS_POLL_GET_EXP:
 				rcu_torture_writer_state = RTWS_POLL_GET_EXP;
 				gp_snap = cur_ops->start_gp_poll_exp();
@@ -1454,6 +1477,7 @@ static int
 rcu_torture_fakewriter(void *arg)
 {
 	unsigned long gp_snap;
+	struct rcu_gp_oldstate gp_snap_full;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fakewriter task started");
@@ -1499,6 +1523,13 @@ rcu_torture_fakewriter(void *arg)
 								  &rand);
 				}
 				break;
+			case RTWS_POLL_GET_FULL:
+				cur_ops->start_gp_poll_full(&gp_snap_full);
+				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
+				}
+				break;
 			case RTWS_POLL_GET_EXP:
 				gp_snap = cur_ops->start_gp_poll_exp();
 				while (!cur_ops->poll_gp_state_exp(gp_snap)) {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3fa79ee78b5b4..89572385fd1aa 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3589,22 +3589,13 @@ void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu_full);
 
-/**
- * start_poll_synchronize_rcu - Snapshot and start RCU grace period
- *
- * Returns a cookie that is used by a later call to cond_synchronize_rcu()
- * or poll_state_synchronize_rcu() to determine whether or not a full
- * grace period has elapsed in the meantime.  If the needed grace period
- * is not already slated to start, notifies RCU core of the need for that
- * grace period.
- *
- * Interrupts must be enabled for the case where it is necessary to awaken
- * the grace-period kthread.
+/*
+ * Helper function for start_poll_synchronize_rcu() and
+ * start_poll_synchronize_rcu_full().
  */
-unsigned long start_poll_synchronize_rcu(void)
+static void start_poll_synchronize_rcu_common(void)
 {
 	unsigned long flags;
-	unsigned long gp_seq = get_state_synchronize_rcu();
 	bool needwake;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
@@ -3624,10 +3615,51 @@ unsigned long start_poll_synchronize_rcu(void)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
 		rcu_gp_kthread_wake();
+}
+
+/**
+ * start_poll_synchronize_rcu - Snapshot and start RCU grace period
+ *
+ * Returns a cookie that is used by a later call to cond_synchronize_rcu()
+ * or poll_state_synchronize_rcu() to determine whether or not a full
+ * grace period has elapsed in the meantime.  If the needed grace period
+ * is not already slated to start, notifies RCU core of the need for that
+ * grace period.
+ *
+ * Interrupts must be enabled for the case where it is necessary to awaken
+ * the grace-period kthread.
+ */
+unsigned long start_poll_synchronize_rcu(void)
+{
+	unsigned long gp_seq = get_state_synchronize_rcu();
+
+	start_poll_synchronize_rcu_common();
 	return gp_seq;
 }
 EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
 
+/**
+ * start_poll_synchronize_rcu_full - Take a full snapshot and start RCU grace period
+ * @rgosp: value from get_state_synchronize_rcu_full() or start_poll_synchronize_rcu_full()
+ *
+ * Places the normal and expedited grace-period states in *@rgos.  This
+ * state value can be passed to a later call to cond_synchronize_rcu_full()
+ * or poll_state_synchronize_rcu_full() to determine whether or not a
+ * grace period (whether normal or expedited) has elapsed in the meantime.
+ * If the needed grace period is not already slated to start, notifies
+ * RCU core of the need for that grace period.
+ *
+ * Interrupts must be enabled for the case where it is necessary to awaken
+ * the grace-period kthread.
+ */
+void start_poll_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	get_state_synchronize_rcu_full(rgosp);
+
+	start_poll_synchronize_rcu_common();
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
+
 /**
  * poll_state_synchronize_rcu - Has the specified RCU grace period completed?
  *
-- 
2.31.1.189.g2e36527f23

