Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42D5A8504
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiHaSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiHaSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1616E3426;
        Wed, 31 Aug 2022 11:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA4D61BFB;
        Wed, 31 Aug 2022 18:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A4FC43147;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=/uL5W9eLHl+SeaTGYxjhOKKa+37RcoDRIc6rSK6aGYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ya7lrUH6BuPPFoMDt5cTFT8U63Rj19ssY0sIun5dQA7NevNz8LavQbqDHbSFtqfk3
         RWbx1nPgIdMjxpfJuT5T1x6xNQFl9NtkJtKfdYgR1WZz6zbeYDBIq+9ZFzM77f/J6b
         vZ7iWq0FuBAh2NcunU4Hv2KLHTQdwli0b2VVdeMl0+zgUygvNZ0dgDe/m6KVTDJgNV
         IXq+p21r1Ww/B6U3q47VemMbwYWCwYNALdUgUP5b/zNeu3dpugBJrKqTRD85AncDmt
         fziOsWN4xSNi0kwUTiIk9tNZbNzlUzRBoBXhTnqHtDEusZHSOHt6RwuaB8CWP/ksf4
         xiKWAZqiHP5aQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 022C75C0950; Wed, 31 Aug 2022 11:08:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 07/10] sched/debug: Try trigger_single_cpu_backtrace(cpu) in dump_cpu_task()
Date:   Wed, 31 Aug 2022 11:08:02 -0700
Message-Id: <20220831180805.2693546-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
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

From: Zhen Lei <thunder.leizhen@huawei.com>

The trigger_all_cpu_backtrace() function attempts to send an NMI to the
target CPU, which usually provides much better stack traces than the
dump_cpu_task() function's approach of dumping that stack from some other
CPU.  So much so that most calls to dump_cpu_task() only happen after
a call to trigger_all_cpu_backtrace() has failed.  And the exception to
this rule really should attempt to use trigger_all_cpu_backtrace() first.

Therefore, move the trigger_all_cpu_backtrace() invocation into
dump_cpu_task().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/rcu/tree_stall.h | 5 ++---
 kernel/sched/core.c     | 3 +++
 kernel/smp.c            | 3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c3fbbcc09327f..5653560573e22 100644
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
@@ -511,8 +511,7 @@ static void rcu_check_gp_kthread_starvation(void)
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
index ee28253c9ac0c..e15b6a7f34f47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11183,6 +11183,9 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 void dump_cpu_task(int cpu)
 {
+	if (trigger_single_cpu_backtrace(cpu))
+		return;
+
 	pr_info("Task dump for CPU %d:\n", cpu);
 	sched_show_task(cpu_curr(cpu));
 }
diff --git a/kernel/smp.c b/kernel/smp.c
index 650810a6f29b3..e8cdc025a046f 100644
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
2.31.1.189.g2e36527f23

