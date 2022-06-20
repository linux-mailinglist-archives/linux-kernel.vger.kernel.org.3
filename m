Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF655272B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiFTWvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344253AbiFTWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E0193FF;
        Mon, 20 Jun 2022 15:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AED8961403;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52442C341D2;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=1W8xRB96Stnh91DupT9jlBEEZh4AW4ECwyhZaB9Eb+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FhwdeZIwsrZuqdOkuX423DHrQNMMD8WmlphYc+kb0llcEOsZE+A7xt0slpzaiIkmx
         1/mnXqHRErv0C+vmjaqDKSiJldPycCGwoEPdpOdglJ9+iu/AY/NPV3r2FQw3VWZC5j
         CAIaeJMYSGkG7VkCxfAEkXgNWTKHS2MckYWVpl/4IBSxfQnhpPYpBAc6Rv9taNB1+g
         U9ZtxR3gJGjVMb37aDKAr2t0qvpP/X2JQSEU407eKPabOesj4985Xot2ffUXknhJDd
         Yt9uL2HtQfZw4YARH+TBRvxD9kniG+0zGemT4lX7SEn2yOV+XEg+EWNh12CHb6n4lq
         TQUyOVFyyXZ4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A39095C0D1B; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 09/12] rcutorture: Test polled expedited grace-period primitives
Date:   Mon, 20 Jun 2022 15:51:25 -0700
Message-Id: <20220620225128.3842050-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
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

This commit adds tests of start_poll_synchronize_rcu_expedited() and
poll_state_synchronize_rcu_expedited().

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 87 +++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d2edc763bb92a..0788ef2a44911 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -86,10 +86,12 @@ torture_param(int, fwd_progress_holdoff, 60,
 torture_param(bool, fwd_progress_need_resched, 1,
 	      "Hide cond_resched() behind need_resched()");
 torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
+torture_param(bool, gp_cond_exp, false, "Use conditional/async expedited GP wait primitives");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(bool, gp_normal, false,
 	     "Use normal (non-expedited) GP wait primitives");
 torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
+torture_param(bool, gp_poll_exp, false, "Use polling expedited GP wait primitives");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
@@ -209,12 +211,16 @@ static int rcu_torture_writer_state;
 #define RTWS_DEF_FREE		3
 #define RTWS_EXP_SYNC		4
 #define RTWS_COND_GET		5
-#define RTWS_COND_SYNC		6
-#define RTWS_POLL_GET		7
-#define RTWS_POLL_WAIT		8
-#define RTWS_SYNC		9
-#define RTWS_STUTTER		10
-#define RTWS_STOPPING		11
+#define RTWS_COND_GET_EXP	6
+#define RTWS_COND_SYNC		7
+#define RTWS_COND_SYNC_EXP	8
+#define RTWS_POLL_GET		9
+#define RTWS_POLL_GET_EXP	10
+#define RTWS_POLL_WAIT		11
+#define RTWS_POLL_WAIT_EXP	12
+#define RTWS_SYNC		13
+#define RTWS_STUTTER		14
+#define RTWS_STOPPING		15
 static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_FIXED_DELAY",
 	"RTWS_DELAY",
@@ -222,9 +228,13 @@ static const char * const rcu_torture_writer_state_names[] = {
 	"RTWS_DEF_FREE",
 	"RTWS_EXP_SYNC",
 	"RTWS_COND_GET",
+	"RTWS_COND_GET_EXP",
 	"RTWS_COND_SYNC",
+	"RTWS_COND_SYNC_EXP",
 	"RTWS_POLL_GET",
+	"RTWS_POLL_GET_EXP",
 	"RTWS_POLL_WAIT",
+	"RTWS_POLL_WAIT_EXP",
 	"RTWS_SYNC",
 	"RTWS_STUTTER",
 	"RTWS_STOPPING",
@@ -337,6 +347,10 @@ struct rcu_torture_ops {
 	void (*deferred_free)(struct rcu_torture *p);
 	void (*sync)(void);
 	void (*exp_sync)(void);
+	unsigned long (*get_gp_state_exp)(void);
+	unsigned long (*start_gp_poll_exp)(void);
+	bool (*poll_gp_state_exp)(unsigned long oldstate);
+	void (*cond_sync_exp)(unsigned long oldstate);
 	unsigned long (*get_gp_state)(void);
 	unsigned long (*get_gp_completed)(void);
 	unsigned long (*start_gp_poll)(void);
@@ -509,6 +523,10 @@ static struct rcu_torture_ops rcu_ops = {
 	.start_gp_poll		= start_poll_synchronize_rcu,
 	.poll_gp_state		= poll_state_synchronize_rcu,
 	.cond_sync		= cond_synchronize_rcu,
+	.get_gp_state_exp	= get_state_synchronize_rcu,
+	.start_gp_poll_exp	= start_poll_synchronize_rcu_expedited,
+	.poll_gp_state_exp	= poll_state_synchronize_rcu,
+	.cond_sync_exp		= cond_synchronize_rcu_expedited,
 	.call			= call_rcu,
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
@@ -1138,9 +1156,8 @@ rcu_torture_fqs(void *arg)
 	return 0;
 }
 
-// Used by writers to randomly choose from the available grace-period
-// primitives.  The only purpose of the initialization is to size the array.
-static int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC, RTWS_COND_GET, RTWS_POLL_GET, RTWS_SYNC };
+// Used by writers to randomly choose from the available grace-period primitives.
+static int synctype[ARRAY_SIZE(rcu_torture_writer_state_names)] = { };
 static int nsynctypes;
 
 /*
@@ -1148,18 +1165,27 @@ static int nsynctypes;
  */
 static void rcu_torture_write_types(void)
 {
-	bool gp_cond1 = gp_cond, gp_exp1 = gp_exp, gp_normal1 = gp_normal;
-	bool gp_poll1 = gp_poll, gp_sync1 = gp_sync;
+	bool gp_cond1 = gp_cond, gp_cond_exp1 = gp_cond_exp, gp_exp1 = gp_exp;
+	bool gp_poll_exp1 = gp_poll_exp, gp_normal1 = gp_normal, gp_poll1 = gp_poll;
+	bool gp_sync1 = gp_sync;
 
 	/* Initialize synctype[] array.  If none set, take default. */
-	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_poll1 && !gp_sync1)
-		gp_cond1 = gp_exp1 = gp_normal1 = gp_poll1 = gp_sync1 = true;
+	if (!gp_cond1 && !gp_cond_exp1 && !gp_exp1 && !gp_poll_exp &&
+	    !gp_normal1 && !gp_poll1 && !gp_sync1)
+		gp_cond1 = gp_cond_exp1 = gp_exp1 = gp_poll_exp1 =
+			   gp_normal1 = gp_poll1 = gp_sync1 = true;
 	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
 		pr_info("%s: Testing conditional GPs.\n", __func__);
 	} else if (gp_cond && (!cur_ops->get_gp_state || !cur_ops->cond_sync)) {
 		pr_alert("%s: gp_cond without primitives.\n", __func__);
 	}
+	if (gp_cond_exp1 && cur_ops->get_gp_state_exp && cur_ops->cond_sync_exp) {
+		synctype[nsynctypes++] = RTWS_COND_GET_EXP;
+		pr_info("%s: Testing conditional expedited GPs.\n", __func__);
+	} else if (gp_cond_exp && (!cur_ops->get_gp_state_exp || !cur_ops->cond_sync_exp)) {
+		pr_alert("%s: gp_cond_exp without primitives.\n", __func__);
+	}
 	if (gp_exp1 && cur_ops->exp_sync) {
 		synctype[nsynctypes++] = RTWS_EXP_SYNC;
 		pr_info("%s: Testing expedited GPs.\n", __func__);
@@ -1178,6 +1204,12 @@ static void rcu_torture_write_types(void)
 	} else if (gp_poll && (!cur_ops->start_gp_poll || !cur_ops->poll_gp_state)) {
 		pr_alert("%s: gp_poll without primitives.\n", __func__);
 	}
+	if (gp_poll_exp1 && cur_ops->start_gp_poll_exp && cur_ops->poll_gp_state_exp) {
+		synctype[nsynctypes++] = RTWS_POLL_GET_EXP;
+		pr_info("%s: Testing polling expedited GPs.\n", __func__);
+	} else if (gp_poll_exp && (!cur_ops->start_gp_poll_exp || !cur_ops->poll_gp_state_exp)) {
+		pr_alert("%s: gp_poll_exp without primitives.\n", __func__);
+	}
 	if (gp_sync1 && cur_ops->sync) {
 		synctype[nsynctypes++] = RTWS_SYNC;
 		pr_info("%s: Testing normal GPs.\n", __func__);
@@ -1285,6 +1317,14 @@ rcu_torture_writer(void *arg)
 				cur_ops->cond_sync(gp_snap);
 				rcu_torture_pipe_update(old_rp);
 				break;
+			case RTWS_COND_GET_EXP:
+				rcu_torture_writer_state = RTWS_COND_GET_EXP;
+				gp_snap = cur_ops->get_gp_state_exp();
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				rcu_torture_writer_state = RTWS_COND_SYNC_EXP;
+				cur_ops->cond_sync_exp(gp_snap);
+				rcu_torture_pipe_update(old_rp);
+				break;
 			case RTWS_POLL_GET:
 				rcu_torture_writer_state = RTWS_POLL_GET;
 				gp_snap = cur_ops->start_gp_poll();
@@ -1294,6 +1334,15 @@ rcu_torture_writer(void *arg)
 								  &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
+			case RTWS_POLL_GET_EXP:
+				rcu_torture_writer_state = RTWS_POLL_GET_EXP;
+				gp_snap = cur_ops->start_gp_poll_exp();
+				rcu_torture_writer_state = RTWS_POLL_WAIT_EXP;
+				while (!cur_ops->poll_gp_state_exp(gp_snap))
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
+				rcu_torture_pipe_update(old_rp);
+				break;
 			case RTWS_SYNC:
 				rcu_torture_writer_state = RTWS_SYNC;
 				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
@@ -1400,6 +1449,11 @@ rcu_torture_fakewriter(void *arg)
 				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
 				cur_ops->cond_sync(gp_snap);
 				break;
+			case RTWS_COND_GET_EXP:
+				gp_snap = cur_ops->get_gp_state_exp();
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				cur_ops->cond_sync_exp(gp_snap);
+				break;
 			case RTWS_POLL_GET:
 				gp_snap = cur_ops->start_gp_poll();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
@@ -1407,6 +1461,13 @@ rcu_torture_fakewriter(void *arg)
 								  &rand);
 				}
 				break;
+			case RTWS_POLL_GET_EXP:
+				gp_snap = cur_ops->start_gp_poll_exp();
+				while (!cur_ops->poll_gp_state_exp(gp_snap)) {
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
+				}
+				break;
 			case RTWS_SYNC:
 				cur_ops->sync();
 				break;
-- 
2.31.1.189.g2e36527f23

