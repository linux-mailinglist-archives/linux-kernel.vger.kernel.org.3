Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0405A8543
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiHaSPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiHaSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A8F23D4;
        Wed, 31 Aug 2022 11:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CE50B82277;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F011BC43146;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=vF0tPndtNPFUTW8t5cP+pHfcosNYhFIVTBzI1A/Sdpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9x0ESTIYbXBTubuBxBm8neoBZ2+037u6KAm6o3k0ISfKA50jlzhsFJPenytmm8iE
         NBb53516lu5CMxPCbY1I/Q0flSjmblZzYRZiMfeX/xLwV74CjTM0SznSZZYjSKTNmx
         /UuoaB2wh+CuqLRQ5a/xuxwuCs2qSlG6q2oNLC1+l9136RvMX5OGD29gJoi5Bq9OsY
         YW7wjKxYBrOGR4TjRDt1GkpsJQXhAZyyPZB7572PWQZWxOTawaudvXxf0KftfoG7RR
         rROJIh8HXrMl/PK8NMAbKFt2vI0JkYNKBlGOB2Q1Wo009pianjmYoKviweJqzDaN3O
         S1Vj01cYl99Yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 684725C09C2; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/25] rcu: Add full-sized polling for start_poll_expedited()
Date:   Wed, 31 Aug 2022 11:11:54 -0700
Message-Id: <20220831181210.2695080-9-paulmck@kernel.org>
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

The start_poll_synchronize_rcu_expedited() API compresses the combined
expedited and normal grace-period states into a single unsigned long,
which conserves storage, but can miss grace periods in certain cases
involving overlapping normal and expedited grace periods.  Missing the
occasional grace period is usually not a problem, but there are use
cases that care about each and every grace period.

This commit therefore adds yet another member of the
full-state RCU grace-period polling API, which is the
start_poll_synchronize_rcu_expedited_full() function.  This uses up to
three times the storage (rcu_gp_oldstate structure instead of unsigned
long), but is guaranteed not to miss grace periods.

[ paulmck: Apply feedback from kernel test robot and Julia Lawall. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  5 ++++
 include/linux/rcutree.h |  1 +
 kernel/rcu/rcutorture.c | 51 +++++++++++++++++++++++++++++++++--------
 kernel/rcu/tree_exp.h   | 18 +++++++++++++++
 4 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 6bc30e46a819c..653e35777a99b 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -49,6 +49,11 @@ static inline unsigned long start_poll_synchronize_rcu_expedited(void)
 	return start_poll_synchronize_rcu();
 }
 
+static inline void start_poll_synchronize_rcu_expedited_full(struct rcu_gp_oldstate *rgosp)
+{
+	rgosp->rgos_norm = start_poll_synchronize_rcu_expedited();
+}
+
 static inline void cond_synchronize_rcu_expedited(unsigned long oldstate)
 {
 	cond_synchronize_rcu(oldstate);
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 8f2e0f0b26f63..7151fd8617365 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -48,6 +48,7 @@ struct rcu_gp_oldstate {
 };
 
 unsigned long start_poll_synchronize_rcu_expedited(void);
+void start_poll_synchronize_rcu_expedited_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu_expedited(unsigned long oldstate);
 unsigned long get_state_synchronize_rcu(void);
 void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 68387ccc7ddfc..f9ca33555debf 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -89,6 +89,7 @@ torture_param(bool, gp_normal, false, "Use normal (non-expedited) GP wait primit
 torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
 torture_param(bool, gp_poll_exp, false, "Use polling expedited GP wait primitives");
 torture_param(bool, gp_poll_full, false, "Use polling full-state GP wait primitives");
+torture_param(bool, gp_poll_exp_full, false, "Use polling full-state expedited GP wait primitives");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
@@ -201,12 +202,14 @@ static int rcu_torture_writer_state;
 #define RTWS_POLL_GET		9
 #define RTWS_POLL_GET_FULL	10
 #define RTWS_POLL_GET_EXP	11
-#define RTWS_POLL_WAIT		12
-#define RTWS_POLL_WAIT_FULL	13
-#define RTWS_POLL_WAIT_EXP	14
-#define RTWS_SYNC		15
-#define RTWS_STUTTER		16
-#define RTWS_STOPPING		17
+#define RTWS_POLL_GET_EXP_FULL	12
+#define RTWS_POLL_WAIT		13
+#define RTWS_POLL_WAIT_FULL	14
+#define RTWS_POLL_WAIT_EXP	15
+#define RTWS_POLL_WAIT_EXP_FULL	16
+#define RTWS_SYNC		17
+#define RTWS_STUTTER		18
+#define RTWS_STOPPING		19
 static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_FIXED_DELAY",
 	"RTWS_DELAY",
@@ -220,9 +223,11 @@ static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_POLL_GET",
 	"RTWS_POLL_GET_FULL",
 	"RTWS_POLL_GET_EXP",
+	"RTWS_POLL_GET_EXP_FULL",
 	"RTWS_POLL_WAIT",
 	"RTWS_POLL_WAIT_FULL",
 	"RTWS_POLL_WAIT_EXP",
+	"RTWS_POLL_WAIT_EXP_FULL",
 	"RTWS_SYNC",
 	"RTWS_STUTTER",
 	"RTWS_STOPPING",
@@ -337,6 +342,7 @@ struct rcu_torture_ops {
 	void (*exp_sync)(void);
 	unsigned long (*get_gp_state_exp)(void);
 	unsigned long (*start_gp_poll_exp)(void);
+	void (*start_gp_poll_exp_full)(struct rcu_gp_oldstate *rgosp);
 	bool (*poll_gp_state_exp)(unsigned long oldstate);
 	void (*cond_sync_exp)(unsigned long oldstate);
 	unsigned long (*get_gp_state)(void);
@@ -528,6 +534,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.cond_sync		= cond_synchronize_rcu,
 	.get_gp_state_exp	= get_state_synchronize_rcu,
 	.start_gp_poll_exp	= start_poll_synchronize_rcu_expedited,
+	.start_gp_poll_exp_full	= start_poll_synchronize_rcu_expedited_full,
 	.poll_gp_state_exp	= poll_state_synchronize_rcu,
 	.cond_sync_exp		= cond_synchronize_rcu_expedited,
 	.call			= call_rcu,
@@ -1169,13 +1176,14 @@ static int nsynctypes;
 static void rcu_torture_write_types(void)
 {
 	bool gp_cond1 = gp_cond, gp_cond_exp1 = gp_cond_exp, gp_exp1 = gp_exp;
-	bool gp_poll_exp1 = gp_poll_exp, gp_normal1 = gp_normal, gp_poll1 = gp_poll;
-	bool gp_poll_full1 = gp_poll_full, gp_sync1 = gp_sync;
+	bool gp_poll_exp1 = gp_poll_exp, gp_poll_exp_full1 = gp_poll_exp_full;
+	bool gp_normal1 = gp_normal, gp_poll1 = gp_poll, gp_poll_full1 = gp_poll_full;
+	bool gp_sync1 = gp_sync;
 
 	/* Initialize synctype[] array.  If none set, take default. */
-	if (!gp_cond1 && !gp_cond_exp1 && !gp_exp1 && !gp_poll_exp &&
+	if (!gp_cond1 && !gp_cond_exp1 && !gp_exp1 && !gp_poll_exp && !gp_poll_exp_full1 &&
 	    !gp_normal1 && !gp_poll1 && !gp_poll_full1 && !gp_sync1)
-		gp_cond1 = gp_cond_exp1 = gp_exp1 = gp_poll_exp1 =
+		gp_cond1 = gp_cond_exp1 = gp_exp1 = gp_poll_exp1 = gp_poll_exp_full1 =
 			   gp_normal1 = gp_poll1 = gp_poll_full1 = gp_sync1 = true;
 	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
@@ -1219,6 +1227,13 @@ static void rcu_torture_write_types(void)
 	} else if (gp_poll_exp && (!cur_ops->start_gp_poll_exp || !cur_ops->poll_gp_state_exp)) {
 		pr_alert("%s: gp_poll_exp without primitives.\n", __func__);
 	}
+	if (gp_poll_exp_full1 && cur_ops->start_gp_poll_exp_full && cur_ops->poll_gp_state_full) {
+		synctype[nsynctypes++] = RTWS_POLL_GET_EXP_FULL;
+		pr_info("%s: Testing polling full-state expedited GPs.\n", __func__);
+	} else if (gp_poll_exp_full &&
+		   (!cur_ops->start_gp_poll_exp_full || !cur_ops->poll_gp_state_full)) {
+		pr_alert("%s: gp_poll_exp_full without primitives.\n", __func__);
+	}
 	if (gp_sync1 && cur_ops->sync) {
 		synctype[nsynctypes++] = RTWS_SYNC;
 		pr_info("%s: Testing normal GPs.\n", __func__);
@@ -1408,6 +1423,15 @@ rcu_torture_writer(void *arg)
 								  &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
+			case RTWS_POLL_GET_EXP_FULL:
+				rcu_torture_writer_state = RTWS_POLL_GET_EXP_FULL;
+				cur_ops->start_gp_poll_exp_full(&gp_snap_full);
+				rcu_torture_writer_state = RTWS_POLL_WAIT_EXP_FULL;
+				while (!cur_ops->poll_gp_state_full(&gp_snap_full))
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
+				rcu_torture_pipe_update(old_rp);
+				break;
 			case RTWS_SYNC:
 				rcu_torture_writer_state = RTWS_SYNC;
 				do_rtws_sync(&rand, cur_ops->sync);
@@ -1537,6 +1561,13 @@ rcu_torture_fakewriter(void *arg)
 								  &rand);
 				}
 				break;
+			case RTWS_POLL_GET_EXP_FULL:
+				cur_ops->start_gp_poll_exp_full(&gp_snap_full);
+				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
+				}
+				break;
 			case RTWS_SYNC:
 				cur_ops->sync();
 				break;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index be667583a5547..18128ee0d36c0 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -1027,6 +1027,24 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 }
 EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_expedited);
 
+/**
+ * start_poll_synchronize_rcu_expedited_full - Take a full snapshot and start expedited grace period
+ * @rgosp: Place to put snapshot of grace-period state
+ *
+ * Places the normal and expedited grace-period states in rgosp.  This
+ * state value can be passed to a later call to cond_synchronize_rcu_full()
+ * or poll_state_synchronize_rcu_full() to determine whether or not a
+ * grace period (whether normal or expedited) has elapsed in the meantime.
+ * If the needed expedited grace period is not already slated to start,
+ * initiates that grace period.
+ */
+void start_poll_synchronize_rcu_expedited_full(struct rcu_gp_oldstate *rgosp)
+{
+	get_state_synchronize_rcu_full(rgosp);
+	(void)start_poll_synchronize_rcu_expedited();
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_expedited_full);
+
 /**
  * cond_synchronize_rcu_expedited - Conditionally wait for an expedited RCU grace period
  *
-- 
2.31.1.189.g2e36527f23

