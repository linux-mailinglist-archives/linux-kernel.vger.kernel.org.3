Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D5D5527DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346250AbiFTXMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346652AbiFTXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:11:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7435225C4F;
        Mon, 20 Jun 2022 16:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D236BB81649;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96333C3411C;
        Mon, 20 Jun 2022 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766631;
        bh=+rj4ghNkEiHAQaun3eCwWQ1DE2elLmXJU5WBjGsDFrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9T7iLlFPceRrLUeoRerQgmellUJ615wD6Y059ynTFRpM4zBT7pji5XDZzly2dliM
         bsd1CNoj6dr/hktKEZyZcfAGG6sTgeEzzDeKDgUKS02bIcp0jQUqFykkR2gR7rDWhC
         vmqrCeUtpCMV4p2cB8kY9tL4IPrEiJ1aJ6MMd43eTeAdF86m/t2DOHjaxs8/kgcNv9
         PnBKfYfqBOdZ/qiXvScNg5Z7Aam3BtQCm+aJhODYeGTa9IdlD6Vn/l9Gr0uAuQaaCA
         SyH0ARU1INitEo7OKnXGhQ68r31gfXlB6vLTqIaE0567hVhAIxKP6tTJdFlQtkXfTo
         ndCDGPmiMqPbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 499B75C05B9; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/23] rcu: Dump rcuc kthread status for CPUs not reporting quiescent state
Date:   Mon, 20 Jun 2022 16:10:07 -0700
Message-Id: <20220620231029.3844583-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
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

If the rcutree.use_softirq kernel boot parameter is disabled, then it is
possible that a RCU CPU stall is due to the rcuc kthreads being starved of
CPU time.  There is currently no easy way to infer this from the RCU CPU
stall warning output.  This commit therefore adds a string of the form "
rcuc=%ld jiffies(starved)" to a given CPU's output if the corresponding
rcuc kthread has been starved for more than two seconds.

[ paulmck: Eliminate extraneous space characters. ]

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 49 ++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4995c078cff98..3556637768fd5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -409,7 +409,19 @@ static bool rcu_is_gp_kthread_starving(unsigned long *jp)
 
 static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp)
 {
-	unsigned long j = jiffies - READ_ONCE(rdp->rcuc_activity);
+	int cpu;
+	struct task_struct *rcuc;
+	unsigned long j;
+
+	rcuc = rdp->rcu_cpu_kthread_task;
+	if (!rcuc)
+		return false;
+
+	cpu = task_cpu(rcuc);
+	if (cpu_is_offline(cpu) || idle_cpu(cpu))
+		return false;
+
+	j = jiffies - READ_ONCE(rdp->rcuc_activity);
 
 	if (jp)
 		*jp = j;
@@ -434,6 +446,9 @@ static void print_cpu_stall_info(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	char *ticks_title;
 	unsigned long ticks_value;
+	bool rcuc_starved;
+	unsigned long j;
+	char buf[32];
 
 	/*
 	 * We could be printing a lot while holding a spinlock.  Avoid
@@ -451,7 +466,10 @@ static void print_cpu_stall_info(int cpu)
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
+	if (rcuc_starved)
+		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -464,32 +482,10 @@ static void print_cpu_stall_info(int cpu)
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       rcuc_starved ? buf : "",
 	       falsepositive ? " (false positive?)" : "");
 }
 
-static void rcuc_kthread_dump(struct rcu_data *rdp)
-{
-	int cpu;
-	unsigned long j;
-	struct task_struct *rcuc;
-
-	rcuc = rdp->rcu_cpu_kthread_task;
-	if (!rcuc)
-		return;
-
-	cpu = task_cpu(rcuc);
-	if (cpu_is_offline(cpu) || idle_cpu(cpu))
-		return;
-
-	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
-		return;
-
-	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
-	sched_show_task(rcuc);
-	if (!trigger_single_cpu_backtrace(cpu))
-		dump_cpu_task(cpu);
-}
-
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
@@ -662,9 +658,6 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
-	if (!use_softirq)
-		rcuc_kthread_dump(rdp);
-
 	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-- 
2.31.1.189.g2e36527f23

