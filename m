Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE330506C68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352299AbiDSM01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352278AbiDSM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7E53617A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E846149B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DB0C385A5;
        Tue, 19 Apr 2022 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650371015;
        bh=Pbn8y8UibwqYIdOkM1GCt1gTd+ojcDKirE+bzLDzcsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfK3K5V4OTkKlGm7WBTtwQGVwntDHbN9bYvbnGHqXdPRM5+b8P6ovtC8GEVwW/LdI
         rIGsoVgeJyG89eue3+QiQ2nf8LAklyGxezJHj5pvRA5Tha2QoD0VbkiDp4+GbMpjeK
         FH2Kn/6je3dn8wAG0qHRU0Kzm/H4+B77h5BasbPECP2nvMVZXH0WHP1XEGJOs/HpqP
         r6GZC8wEvuwMp3U8TkTPangx+vK+DCy1TpBWUkgQXxzyCdkzy/BFMWyPGxUZiqFE46
         4Z1HYOMC0gAxq0D/euQuenOIFGWqlj7x9RCKhZ9DbnhLnwOEnjkh5AxyPCeNpOWBOF
         6bFQu1wn5y+ZQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zqiang <qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/3] rcu/nocb: Fix NOCB kthreads spawn failure with rcu_nocb_rdp_deoffload() direct call
Date:   Tue, 19 Apr 2022 14:23:20 +0200
Message-Id: <20220419122320.2060902-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419122320.2060902-1-frederic@kernel.org>
References: <20220419122320.2060902-1-frederic@kernel.org>
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

From: Zqiang <qiang1.zhang@intel.com>

If the rcuog/o[p] kthreads spawn failed, the offloaded rdp needs to
be explicitly deoffloaded, otherwise the target rdp is still considered
offloaded even though nothing actually handles the callbacks.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 80 +++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f2f2cab6285a..4cf9a29bba79 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -986,10 +986,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	}
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
-	if (wake_gp)
-		wake_up_process(rdp_gp->nocb_gp_kthread);
-
-	return 0;
+	return wake_gp;
 }
 
 static long rcu_nocb_rdp_deoffload(void *arg)
@@ -997,9 +994,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
-	int ret;
+	int wake_gp;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
-	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	/*
+	 * rcu_nocb_rdp_deoffload() may be called directly if
+	 * rcuog/o[p] spawn failed, because at this time the rdp->cpu
+	 * is not online yet.
+	 */
+	WARN_ON_ONCE((rdp->cpu != raw_smp_processor_id()) && cpu_online(rdp->cpu));
 
 	pr_info("De-offloading %d\n", rdp->cpu);
 
@@ -1023,10 +1026,41 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 */
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
 	invoke_rcu_core();
-	ret = rdp_offload_toggle(rdp, false, flags);
-	swait_event_exclusive(rdp->nocb_state_wq,
-			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
-							SEGCBLIST_KTHREAD_GP));
+	wake_gp = rdp_offload_toggle(rdp, false, flags);
+
+	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
+	if (rdp_gp->nocb_gp_kthread) {
+		if (wake_gp)
+			wake_up_process(rdp_gp->nocb_gp_kthread);
+
+		/*
+		 * If rcuo[p] kthread spawn failed, directly remove SEGCBLIST_KTHREAD_CB.
+		 * Just wait SEGCBLIST_KTHREAD_GP to be cleared by rcuog.
+		 */
+		if (!rdp->nocb_cb_kthread) {
+			rcu_nocb_lock_irqsave(rdp, flags);
+			rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+		}
+
+		swait_event_exclusive(rdp->nocb_state_wq,
+					!rcu_segcblist_test_flags(cblist,
+					  SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP));
+	} else {
+		/*
+		 * No kthread to clear the flags for us or remove the rdp from the nocb list
+		 * to iterate. Do it here instead. Locking doesn't look stricly necessary
+		 * but we stick to paranoia in this rare path.
+		 */
+		rcu_nocb_lock_irqsave(rdp, flags);
+		rcu_segcblist_clear_flags(&rdp->cblist,
+				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+
+		list_del(&rdp->nocb_entry_rdp);
+	}
+	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
+
 	/*
 	 * Lock one last time to acquire latest callback updates from kthreads
 	 * so we can later handle callbacks locally without locking.
@@ -1047,7 +1081,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 
 
-	return ret;
+	return 0;
 }
 
 int rcu_nocb_cpu_deoffload(int cpu)
@@ -1079,7 +1113,8 @@ static long rcu_nocb_rdp_offload(void *arg)
 	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
-	int ret;
+	int wake_gp;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
 	/*
@@ -1089,6 +1124,9 @@ static long rcu_nocb_rdp_offload(void *arg)
 	if (!rdp->nocb_gp_rdp)
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
+		return -EINVAL;
+
 	pr_info("Offloading %d\n", rdp->cpu);
 
 	/*
@@ -1113,7 +1151,9 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 *      WRITE flags               READ callbacks
 	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
 	 */
-	ret = rdp_offload_toggle(rdp, true, flags);
+	wake_gp = rdp_offload_toggle(rdp, true, flags);
+	if (wake_gp)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
@@ -1126,7 +1166,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	rcu_segcblist_clear_flags(cblist, SEGCBLIST_RCU_CORE);
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	return ret;
+	return 0;
 }
 
 int rcu_nocb_cpu_offload(int cpu)
@@ -1248,7 +1288,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 				"rcuog/%d", rdp_gp->cpu);
 		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
 			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
-			return;
+			goto end;
 		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 		if (kthread_prio)
@@ -1260,12 +1300,20 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	t = kthread_run(rcu_nocb_cb_kthread, rdp,
 			"rcuo%c/%d", rcu_state.abbr, cpu);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
-		return;
+		goto end;
 
 	if (kthread_prio)
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
+	return;
+end:
+	mutex_lock(&rcu_state.barrier_mutex);
+	if (rcu_rdp_is_offloaded(rdp)) {
+		rcu_nocb_rdp_deoffload(rdp);
+		cpumask_clear_cpu(cpu, rcu_nocb_mask);
+	}
+	mutex_unlock(&rcu_state.barrier_mutex);
 }
 
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
-- 
2.25.1

