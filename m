Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397325A8547
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiHaSP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiHaSN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E286EF9CB;
        Wed, 31 Aug 2022 11:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FB061C4B;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96356C433D7;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969531;
        bh=7dlnoegYQ8t/B7XwDsIx7nzWC3DNxp9xf0llnojAlaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1HyF3L7g4LuKSUQyq29lRkkBcytdRsfI2KI6No6dLDhS5fyeINVRfP9Q5M03b9sR
         FrlPgChFtmW1/AzeoZYhodTvl+E5riWeO+xqtXGm3QI/dZhOftUhM6c9Lf1PKcpyRi
         MRut8Cg7sDQ2RYLJyVjzWfWNHyKmid3FPwa2RASckhqL+VLbbj4G1TbaYybQIIjsdX
         78+N0FwrOgzCU0O2TZBs6rJw3Wk6C7O01291ImsG+ww4M5EjbLVfz8UiZ8nvbShsQG
         2NJl6jBIFwC+My3O4TbJBsoyxguYIv12l3g/B27qJyx4mtCRxGk5SyfpJhnkwAsilG
         yTAnCwxc0Jenw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5ADF05C019C; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/25] rcu: Add full-sized polling for get_state()
Date:   Wed, 31 Aug 2022 11:11:47 -0700
Message-Id: <20220831181210.2695080-2-paulmck@kernel.org>
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

The get_state_synchronize_rcu() API compresses the combined expedited and
normal grace-period states into a single unsigned long, which conserves
storage, but can miss grace periods in certain cases involving overlapping
normal and expedited grace periods.  Missing the occasional grace period
is usually not a problem, but there are use cases that care about each
and every grace period.

This commit therefore adds the next member of the full-state RCU
grace-period polling API, namely the get_state_synchronize_rcu_full()
function.  This uses up to three times the storage (rcu_gp_oldstate
structure instead of unsigned long), but is guaranteed not to miss
grace periods.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  6 ++++++
 include/linux/rcutree.h |  1 +
 kernel/rcu/rcutorture.c | 10 ++++++----
 kernel/rcu/tree.c       | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 1fbff8600d92d..6e299955c4e9a 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -19,6 +19,12 @@ struct rcu_gp_oldstate {
 };
 
 unsigned long get_state_synchronize_rcu(void);
+
+static inline void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	rgosp->rgos_norm = get_state_synchronize_rcu();
+}
+
 unsigned long start_poll_synchronize_rcu(void);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
 
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 4ccbc3aa9dc20..7b769f1b417aa 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -50,6 +50,7 @@ struct rcu_gp_oldstate {
 unsigned long start_poll_synchronize_rcu_expedited(void);
 void cond_synchronize_rcu_expedited(unsigned long oldstate);
 unsigned long get_state_synchronize_rcu(void);
+void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 unsigned long start_poll_synchronize_rcu(void);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
 bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b31e6ed64d1b9..4f196ebce7f29 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -335,6 +335,7 @@ struct rcu_torture_ops {
 	bool (*poll_gp_state_exp)(unsigned long oldstate);
 	void (*cond_sync_exp)(unsigned long oldstate);
 	unsigned long (*get_gp_state)(void);
+	void (*get_gp_state_full)(struct rcu_gp_oldstate *rgosp);
 	unsigned long (*get_gp_completed)(void);
 	void (*get_gp_completed_full)(struct rcu_gp_oldstate *rgosp);
 	unsigned long (*start_gp_poll)(void);
@@ -504,6 +505,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.sync			= synchronize_rcu,
 	.exp_sync		= synchronize_rcu_expedited,
 	.get_gp_state		= get_state_synchronize_rcu,
+	.get_gp_state_full	= get_state_synchronize_rcu_full,
 	.get_gp_completed	= get_completed_synchronize_rcu,
 	.get_gp_completed_full	= get_completed_synchronize_rcu_full,
 	.start_gp_poll		= start_poll_synchronize_rcu,
@@ -1293,12 +1295,12 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_EXP_SYNC:
 				rcu_torture_writer_state = RTWS_EXP_SYNC;
-				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-					cookie = cur_ops->get_gp_state();
+				if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
+					cur_ops->get_gp_state_full(&cookie_full);
 				cur_ops->exp_sync();
 				cur_ops->exp_sync();
-				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-					WARN_ON_ONCE(!cur_ops->poll_gp_state(cookie));
+				if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
+					WARN_ON_ONCE(!cur_ops->poll_gp_state_full(&cookie_full));
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_COND_GET:
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d47c9b6d81066..3fa79ee78b5b4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1755,6 +1755,8 @@ static noinline void rcu_gp_cleanup(void)
 			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
+		if (!rnp->parent)
+			smp_mb(); // Order against failing poll_state_synchronize_rcu_full().
 		rdp = this_cpu_ptr(&rcu_data);
 		if (rnp == rdp->mynode)
 			needgp = __note_gp_changes(rnp, rdp) || needgp;
@@ -3556,6 +3558,37 @@ unsigned long get_state_synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
 
+/**
+ * get_state_synchronize_rcu_full - Snapshot RCU state, both normal and expedited
+ * @rgosp: location to place combined normal/expedited grace-period state
+ *
+ * Places the normal and expedited grace-period states in @rgosp.  This
+ * state value can be passed to a later call to cond_synchronize_rcu_full()
+ * or poll_state_synchronize_rcu_full() to determine whether or not a
+ * grace period (whether normal or expedited) has elapsed in the meantime.
+ * The rcu_gp_oldstate structure takes up twice the memory of an unsigned
+ * long, but is guaranteed to see all grace periods.  In contrast, the
+ * combined state occupies less memory, but can sometimes fail to take
+ * grace periods into account.
+ *
+ * This does not guarantee that the needed grace period will actually
+ * start.
+ */
+void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	/*
+	 * Any prior manipulation of RCU-protected data must happen
+	 * before the loads from ->gp_seq and ->expedited_sequence.
+	 */
+	smp_mb();  /* ^^^ */
+	rgosp->rgos_norm = rcu_seq_snap(&rnp->gp_seq);
+	rgosp->rgos_exp = rcu_seq_snap(&rcu_state.expedited_sequence);
+	rgosp->rgos_polled = rcu_seq_snap(&rcu_state.gp_seq_polled);
+}
+EXPORT_SYMBOL_GPL(get_state_synchronize_rcu_full);
+
 /**
  * start_poll_synchronize_rcu - Snapshot and start RCU grace period
  *
-- 
2.31.1.189.g2e36527f23

