Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C55A8545
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiHaSPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiHaSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08679F23DA;
        Wed, 31 Aug 2022 11:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7431D61CA4;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1854EC4314B;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=MUbxUGccBwX8w6yXUcoyydCki8L8sS4EgyPHInADDxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ac8Ls0Uh/GqTCjkSSBmArcFsnlwrhbCu6S+RyRSI2OpQJgvBkxvbBIKJD1OX7Zmlv
         YQFjiCNmhboQX7J5cAiJ1CPeUvIArI6d2rarL6yQxKCIQLlFmQ82kISctZAu1Xs1YT
         y+qrIPjLUUWrxfbfPyhOX8iALbnYMQCFf1wKrtBJiW8Ncy8tCmOQxNUJukZSZyZ3+7
         F8BA3nJv1BMpO8tkRUYdrxPVEpnymVaqLDrOr32jErVaradhZXHrFmYYOSi3fQdaFr
         UNN6tsRVEhG+g5PrvrqximINnPx75lr/HBlc+TbC1KJ2AumCw+p4Av8s99SAzKdBpI
         cBLXWbuIJuCIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6E3CB5C0B00; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/25] rcu: Add full-sized polling for cond_sync_exp_full()
Date:   Wed, 31 Aug 2022 11:11:57 -0700
Message-Id: <20220831181210.2695080-12-paulmck@kernel.org>
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

The cond_synchronize_rcu_expedited() API compresses the combined expedited and
normal grace-period states into a single unsigned long, which conserves
storage, but can miss grace periods in certain cases involving overlapping
normal and expedited grace periods.  Missing the occasional grace period
is usually not a problem, but there are use cases that care about each
and every grace period.

This commit therefore adds yet another member of the full-state RCU
grace-period polling API, which is the cond_synchronize_rcu_exp_full()
function.  This uses up to three times the storage (rcu_gp_oldstate
structure instead of unsigned long), but is guaranteed not to miss
grace periods.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  5 +++
 include/linux/rcutree.h |  1 +
 kernel/rcu/rcutorture.c | 72 ++++++++++++++++++++++++++++-------------
 kernel/rcu/tree_exp.h   | 27 ++++++++++++++++
 4 files changed, 83 insertions(+), 22 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 3bee97f76bf43..4405e9112cee8 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -64,6 +64,11 @@ static inline void cond_synchronize_rcu_expedited(unsigned long oldstate)
 	cond_synchronize_rcu(oldstate);
 }
 
+static inline void cond_synchronize_rcu_expedited_full(struct rcu_gp_oldstate *rgosp)
+{
+	cond_synchronize_rcu_expedited(rgosp->rgos_norm);
+}
+
 extern void rcu_barrier(void);
 
 static inline void synchronize_rcu_expedited(void)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 1b44288c027da..755b082f4ec62 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -50,6 +50,7 @@ struct rcu_gp_oldstate {
 unsigned long start_poll_synchronize_rcu_expedited(void);
 void start_poll_synchronize_rcu_expedited_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu_expedited(unsigned long oldstate);
+void cond_synchronize_rcu_expedited_full(struct rcu_gp_oldstate *rgosp);
 unsigned long get_state_synchronize_rcu(void);
 void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 unsigned long start_poll_synchronize_rcu(void);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9d22161bf7700..8995429c6f1c2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -85,6 +85,8 @@ torture_param(bool, fwd_progress_need_resched, 1, "Hide cond_resched() behind ne
 torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
 torture_param(bool, gp_cond_exp, false, "Use conditional/async expedited GP wait primitives");
 torture_param(bool, gp_cond_full, false, "Use conditional/async full-state GP wait primitives");
+torture_param(bool, gp_cond_exp_full, false,
+		    "Use conditional/async full-stateexpedited GP wait primitives");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(bool, gp_normal, false, "Use normal (non-expedited) GP wait primitives");
 torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
@@ -199,20 +201,22 @@ static int rcu_torture_writer_state;
 #define RTWS_COND_GET		5
 #define RTWS_COND_GET_FULL	6
 #define RTWS_COND_GET_EXP	7
-#define RTWS_COND_SYNC		8
-#define RTWS_COND_SYNC_FULL	9
-#define RTWS_COND_SYNC_EXP	10
-#define RTWS_POLL_GET		11
-#define RTWS_POLL_GET_FULL	12
-#define RTWS_POLL_GET_EXP	13
-#define RTWS_POLL_GET_EXP_FULL	14
-#define RTWS_POLL_WAIT		15
-#define RTWS_POLL_WAIT_FULL	16
-#define RTWS_POLL_WAIT_EXP	17
-#define RTWS_POLL_WAIT_EXP_FULL	18
-#define RTWS_SYNC		19
-#define RTWS_STUTTER		20
-#define RTWS_STOPPING		21
+#define RTWS_COND_GET_EXP_FULL	8
+#define RTWS_COND_SYNC		9
+#define RTWS_COND_SYNC_FULL	10
+#define RTWS_COND_SYNC_EXP	11
+#define RTWS_COND_SYNC_EXP_FULL	12
+#define RTWS_POLL_GET		13
+#define RTWS_POLL_GET_FULL	14
+#define RTWS_POLL_GET_EXP	15
+#define RTWS_POLL_GET_EXP_FULL	16
+#define RTWS_POLL_WAIT		17
+#define RTWS_POLL_WAIT_FULL	18
+#define RTWS_POLL_WAIT_EXP	19
+#define RTWS_POLL_WAIT_EXP_FULL	20
+#define RTWS_SYNC		21
+#define RTWS_STUTTER		22
+#define RTWS_STOPPING		23
 static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_FIXED_DELAY",
 	"RTWS_DELAY",
@@ -222,9 +226,11 @@ static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_COND_GET",
 	"RTWS_COND_GET_FULL",
 	"RTWS_COND_GET_EXP",
+	"RTWS_COND_GET_EXP_FULL",
 	"RTWS_COND_SYNC",
 	"RTWS_COND_SYNC_FULL",
 	"RTWS_COND_SYNC_EXP",
+	"RTWS_COND_SYNC_EXP_FULL",
 	"RTWS_POLL_GET",
 	"RTWS_POLL_GET_FULL",
 	"RTWS_POLL_GET_EXP",
@@ -350,6 +356,7 @@ struct rcu_torture_ops {
 	void (*start_gp_poll_exp_full)(struct rcu_gp_oldstate *rgosp);
 	bool (*poll_gp_state_exp)(unsigned long oldstate);
 	void (*cond_sync_exp)(unsigned long oldstate);
+	void (*cond_sync_exp_full)(struct rcu_gp_oldstate *rgosp);
 	unsigned long (*get_gp_state)(void);
 	void (*get_gp_state_full)(struct rcu_gp_oldstate *rgosp);
 	unsigned long (*get_gp_completed)(void);
@@ -1183,16 +1190,17 @@ static int nsynctypes;
 static void rcu_torture_write_types(void)
 {
 	bool gp_cond1 = gp_cond, gp_cond_exp1 = gp_cond_exp, gp_cond_full1 = gp_cond_full;
-	bool gp_exp1 = gp_exp, gp_poll_exp1 = gp_poll_exp, gp_poll_exp_full1 = gp_poll_exp_full;
-	bool gp_normal1 = gp_normal, gp_poll1 = gp_poll, gp_poll_full1 = gp_poll_full;
-	bool gp_sync1 = gp_sync;
+	bool gp_cond_exp_full1 = gp_cond_exp_full, gp_exp1 = gp_exp, gp_poll_exp1 = gp_poll_exp;
+	bool gp_poll_exp_full1 = gp_poll_exp_full, gp_normal1 = gp_normal, gp_poll1 = gp_poll;
+	bool gp_poll_full1 = gp_poll_full, gp_sync1 = gp_sync;
 
 	/* Initialize synctype[] array.  If none set, take default. */
-	if (!gp_cond1 && !gp_cond_exp1 && !gp_cond_full1 && !gp_exp1 && !gp_poll_exp &&
-	    !gp_poll_exp_full1 && !gp_normal1 && !gp_poll1 && !gp_poll_full1 && !gp_sync1)
-		gp_cond1 = gp_cond_exp1 = gp_cond_full1 = gp_exp1 = gp_poll_exp1 =
-			   gp_poll_exp_full1 = gp_normal1 = gp_poll1 = gp_poll_full1 =
-			   gp_sync1 = true;
+	if (!gp_cond1 && !gp_cond_exp1 && !gp_cond_full1 && !gp_cond_exp_full1 && !gp_exp1 &&
+	    !gp_poll_exp && !gp_poll_exp_full1 && !gp_normal1 && !gp_poll1 && !gp_poll_full1 &&
+	    !gp_sync1)
+		gp_cond1 = gp_cond_exp1 = gp_cond_full1 = gp_cond_exp_full1 = gp_exp1 =
+			   gp_poll_exp1 = gp_poll_exp_full1 = gp_normal1 = gp_poll1 =
+			   gp_poll_full1 = gp_sync1 = true;
 	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
 		pr_info("%s: Testing conditional GPs.\n", __func__);
@@ -1211,6 +1219,13 @@ static void rcu_torture_write_types(void)
 	} else if (gp_cond_full && (!cur_ops->get_gp_state || !cur_ops->cond_sync_full)) {
 		pr_alert("%s: gp_cond_full without primitives.\n", __func__);
 	}
+	if (gp_cond_exp_full1 && cur_ops->get_gp_state_exp && cur_ops->cond_sync_exp_full) {
+		synctype[nsynctypes++] = RTWS_COND_GET_EXP_FULL;
+		pr_info("%s: Testing conditional full-state expedited GPs.\n", __func__);
+	} else if (gp_cond_exp_full &&
+		   (!cur_ops->get_gp_state_exp || !cur_ops->cond_sync_exp_full)) {
+		pr_alert("%s: gp_cond_exp_full without primitives.\n", __func__);
+	}
 	if (gp_exp1 && cur_ops->exp_sync) {
 		synctype[nsynctypes++] = RTWS_EXP_SYNC;
 		pr_info("%s: Testing expedited GPs.\n", __func__);
@@ -1418,6 +1433,14 @@ rcu_torture_writer(void *arg)
 				cur_ops->cond_sync_full(&gp_snap_full);
 				rcu_torture_pipe_update(old_rp);
 				break;
+			case RTWS_COND_GET_EXP_FULL:
+				rcu_torture_writer_state = RTWS_COND_GET_EXP_FULL;
+				cur_ops->get_gp_state_full(&gp_snap_full);
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				rcu_torture_writer_state = RTWS_COND_SYNC_EXP_FULL;
+				cur_ops->cond_sync_exp_full(&gp_snap_full);
+				rcu_torture_pipe_update(old_rp);
+				break;
 			case RTWS_POLL_GET:
 				rcu_torture_writer_state = RTWS_POLL_GET;
 				gp_snap = cur_ops->start_gp_poll();
@@ -1567,6 +1590,11 @@ rcu_torture_fakewriter(void *arg)
 				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
 				cur_ops->cond_sync_full(&gp_snap_full);
 				break;
+			case RTWS_COND_GET_EXP_FULL:
+				cur_ops->get_gp_state_full(&gp_snap_full);
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				cur_ops->cond_sync_exp_full(&gp_snap_full);
+				break;
 			case RTWS_POLL_GET:
 				gp_snap = cur_ops->start_gp_poll();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 18128ee0d36c0..9c0ae834ef076 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -1071,3 +1071,30 @@ void cond_synchronize_rcu_expedited(unsigned long oldstate)
 		synchronize_rcu_expedited();
 }
 EXPORT_SYMBOL_GPL(cond_synchronize_rcu_expedited);
+
+/**
+ * cond_synchronize_rcu_expedited_full - Conditionally wait for an expedited RCU grace period
+ * @rgosp: value from get_state_synchronize_rcu_full(), start_poll_synchronize_rcu_full(), or start_poll_synchronize_rcu_expedited_full()
+ *
+ * If a full RCU grace period has elapsed since the call to
+ * get_state_synchronize_rcu_full(), start_poll_synchronize_rcu_full(),
+ * or start_poll_synchronize_rcu_expedited_full() from which @rgosp was
+ * obtained, just return.  Otherwise, invoke synchronize_rcu_expedited()
+ * to wait for a full grace period.
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
+void cond_synchronize_rcu_expedited_full(struct rcu_gp_oldstate *rgosp)
+{
+	if (!poll_state_synchronize_rcu_full(rgosp))
+		synchronize_rcu_expedited();
+}
+EXPORT_SYMBOL_GPL(cond_synchronize_rcu_expedited_full);
-- 
2.31.1.189.g2e36527f23

