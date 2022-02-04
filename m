Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D9F4AA438
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351648AbiBDXUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378039AbiBDXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:20:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56358DFBC71F;
        Fri,  4 Feb 2022 15:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A715FCE24B8;
        Fri,  4 Feb 2022 23:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FDAC340F1;
        Fri,  4 Feb 2022 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016837;
        bh=S4eE3S6LI0fVFBCvPzoWLKyt6VIRD7KnrVxSw8qANRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNoKmx5gENNnY/2V1bzrutS0sYA6WM4B/GMjlKQiXLTKKEnTAyhVXWJ4cyoFNQeAS
         4wEy0YO4KGIPtaOcKl1t7d9ohzzF4xFBOhXANuI1YTwNyxsngNePAIsU+KJ5p87XKO
         9+bvRFnHcocUSPLpXXUfHtyrqEBFB2HuyffyT4w7n5fmsYHhm3f9urnVZ7QYQDl5mw
         kEHsmzgDdAE7zj+YEDWv54X9oajDaUZ6TTty2mdGdACNRb4CREa0kZ3q1LgdxKGDg/
         N2KVx7vG2YgZOH49WMxZmpYxyDTBoUU307O2faVd9PC1BIqhhrhQtp74jqXr1UP69f
         uuOlp2KFBsItQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AA35F5C0992; Fri,  4 Feb 2022 15:20:37 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/5] rcu: Create and use an rcu_rdp_cpu_online()
Date:   Fri,  4 Feb 2022 15:20:36 -0800
Message-Id: <20220204232036.460-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern "rdp->grpmask & rcu_rnp_online_cpus(rnp)" occurs frequently
in RCU code in order to determine whether rdp->cpu is online from an
RCU perspective.  This commit therefore creates an rcu_rdp_cpu_online()
function to replace it.

[ paulmck: Apply kernel test robot unused-variable feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 21 +++++++++++++--------
 kernel/rcu/tree_plugin.h |  6 ++----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1c30a01692076..6a470bb93b485 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -222,6 +222,16 @@ static unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
 	return READ_ONCE(rnp->qsmaskinitnext);
 }
 
+/*
+ * Is the CPU corresponding to the specified rcu_data structure online
+ * from RCU's perspective?  This perspective is given by that structure's
+ * ->qsmaskinitnext field rather than by the global cpu_online_mask.
+ */
+static bool rcu_rdp_cpu_online(struct rcu_data *rdp)
+{
+	return !!(rdp->grpmask & rcu_rnp_online_cpus(rdp->mynode));
+}
+
 /*
  * Return true if an RCU grace period is in progress.  The READ_ONCE()s
  * permit this function to be invoked without holding the root rcu_node
@@ -1168,14 +1178,12 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 bool rcu_lockdep_current_cpu_online(void)
 {
 	struct rcu_data *rdp;
-	struct rcu_node *rnp;
 	bool ret = false;
 
 	if (in_nmi() || !rcu_scheduler_fully_active)
 		return true;
 	preempt_disable_notrace();
 	rdp = this_cpu_ptr(&rcu_data);
-	rnp = rdp->mynode;
 	/*
 	 * Strictly, we care here about the case where the current CPU is
 	 * in rcu_cpu_starting() and thus has an excuse for rdp->grpmask
@@ -1183,8 +1191,7 @@ bool rcu_lockdep_current_cpu_online(void)
 	 * false positive if it's held by some *other* CPU, but that's
 	 * OK because that just means a false *negative* on the warning.
 	 */
-	if (rdp->grpmask & rcu_rnp_online_cpus(rnp) ||
-	    arch_spin_is_locked(&rcu_state.ofl_lock))
+	if (rcu_rdp_cpu_online(rdp) || arch_spin_is_locked(&rcu_state.ofl_lock))
 		ret = true;
 	preempt_enable_notrace();
 	return ret;
@@ -1269,8 +1276,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * For more detail, please refer to the "Hotplug CPU" section
 	 * of RCU's Requirements documentation.
 	 */
-	if (WARN_ON_ONCE(!(rdp->grpmask & rcu_rnp_online_cpus(rnp)))) {
-		bool onl;
+	if (WARN_ON_ONCE(!rcu_rdp_cpu_online(rdp))) {
 		struct rcu_node *rnp1;
 
 		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
@@ -1279,9 +1285,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		for (rnp1 = rnp; rnp1; rnp1 = rnp1->parent)
 			pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx ->rcu_gp_init_mask %#lx\n",
 				__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext, rnp1->rcu_gp_init_mask);
-		onl = !!(rdp->grpmask & rcu_rnp_online_cpus(rnp));
 		pr_info("%s %d: %c online: %ld(%d) offline: %ld(%d)\n",
-			__func__, rdp->cpu, ".o"[onl],
+			__func__, rdp->cpu, ".o"[rcu_rdp_cpu_online(rdp)],
 			(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_flags,
 			(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_flags);
 		return 1; /* Break things loose after complaining. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c5b45c2f68a15..d3db2168598ef 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -330,7 +330,7 @@ void rcu_note_context_switch(bool preempt)
 		 * then queue the task as required based on the states
 		 * of any ongoing and expedited grace periods.
 		 */
-		WARN_ON_ONCE((rdp->grpmask & rcu_rnp_online_cpus(rnp)) == 0);
+		WARN_ON_ONCE(!rcu_rdp_cpu_online(rdp));
 		WARN_ON_ONCE(!list_empty(&t->rcu_node_entry));
 		trace_rcu_preempt_task(rcu_state.name,
 				       t->pid,
@@ -773,7 +773,6 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 	int cpu;
 	int i;
 	struct list_head *lhp;
-	bool onl;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp1;
 
@@ -797,9 +796,8 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 	pr_cont("\n");
 	for (cpu = rnp->grplo; cpu <= rnp->grphi; cpu++) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
-		onl = !!(rdp->grpmask & rcu_rnp_online_cpus(rnp));
 		pr_info("\t%d: %c online: %ld(%d) offline: %ld(%d)\n",
-			cpu, ".o"[onl],
+			cpu, ".o"[rcu_rdp_cpu_online(rdp)],
 			(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_flags,
 			(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_flags);
 	}
-- 
2.31.1.189.g2e36527f23

