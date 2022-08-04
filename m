Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AD589629
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiHDCe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbiHDCet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:34:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632035FAF3;
        Wed,  3 Aug 2022 19:34:48 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lyt7r0pv9zTgZC;
        Thu,  4 Aug 2022 10:33:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 10:34:46 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 10:34:45 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 1/2] sched/debug: Try trigger_single_cpu_backtrace(cpu) in dump_cpu_task()
Date:   Thu, 4 Aug 2022 10:34:19 +0800
Message-ID: <20220804023420.1663-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220804023420.1663-1-thunder.leizhen@huawei.com>
References: <20220804023420.1663-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function trigger_all_cpu_backtrace() uses NMI to dump the stack traces
of other CPU, it should actually be one of the ways to implement
dump_cpu_task(). So try it first in dump_cpu_task(). At the same time,
unnecessary duplicate code of upper-layer functions is eliminated.

There is also a call to dump_cpu_task() in
synchronize_rcu_expedited_wait(), which should also try to use NMI to
dump the stack traces first. It is currently the result of this
adjustment, so leave it unchanged.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tree_stall.h | 8 +++-----
 kernel/sched/core.c     | 3 +++
 kernel/smp.c            | 3 +--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a001e1e7a99269c..80749d257ac2f78 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -368,7 +368,7 @@ static void rcu_dump_cpu_stacks(void)
 			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
 				if (cpu_is_offline(cpu))
 					pr_err("Offline CPU %d blocking current GP.\n", cpu);
-				else if (!trigger_single_cpu_backtrace(cpu))
+				else
 					dump_cpu_task(cpu);
 			}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -486,8 +486,7 @@ static void rcuc_kthread_dump(struct rcu_data *rdp)
 
 	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
 	sched_show_task(rcuc);
-	if (!trigger_single_cpu_backtrace(cpu))
-		dump_cpu_task(cpu);
+	dump_cpu_task(cpu);
 }
 
 /* Complain about starvation of grace-period kthread.  */
@@ -515,8 +514,7 @@ static void rcu_check_gp_kthread_starvation(void)
 					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
 				} else  {
 					pr_err("Stack dump where RCU GP kthread last ran:\n");
-					if (!trigger_single_cpu_backtrace(cpu))
-						dump_cpu_task(cpu);
+					dump_cpu_task(cpu);
 				}
 			}
 			wake_up_process(gpk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df8fe433642fa30..0e82073020bf0d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11145,6 +11145,9 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 void dump_cpu_task(int cpu)
 {
+	if (trigger_single_cpu_backtrace(cpu))
+		return;
+
 	pr_info("Task dump for CPU %d:\n", cpu);
 	sched_show_task(cpu_curr(cpu));
 }
diff --git a/kernel/smp.c b/kernel/smp.c
index dd215f439426449..56ca958364aebeb 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -370,8 +370,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 	if (cpu >= 0) {
 		if (static_branch_unlikely(&csdlock_debug_extended))
 			csd_lock_print_extended(csd, cpu);
-		if (!trigger_single_cpu_backtrace(cpu))
-			dump_cpu_task(cpu);
+		dump_cpu_task(cpu);
 		if (!cpu_cur_csd) {
 			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
 			arch_send_call_function_single_ipi(cpu);
-- 
2.25.1

