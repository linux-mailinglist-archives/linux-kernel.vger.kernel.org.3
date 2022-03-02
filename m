Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B064CADA3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbiCBSfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbiCBSfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:35:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90AE4CA305
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:34:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46E371424;
        Wed,  2 Mar 2022 10:34:52 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B53193F73D;
        Wed,  2 Mar 2022 10:34:46 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sched/deadline: Remove unused def_dl_bandwidth
Date:   Wed,  2 Mar 2022 19:34:28 +0100
Message-Id: <20220302183433.333029-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302183433.333029-1-dietmar.eggemann@arm.com>
References: <20220302183433.333029-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1724813d9f2c ("sched/deadline: Remove the sysctl_sched_dl
knobs") the default deadline bandwidth control structure has no purpose.
Remove it.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c     | 1 -
 kernel/sched/deadline.c | 7 -------
 kernel/sched/sched.h    | 1 -
 3 files changed, 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3aafc15da24a..d342c4c779f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9420,7 +9420,6 @@ void __init sched_init(void)
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
 	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
-	init_dl_bandwidth(&def_dl_bandwidth, global_rt_period(), global_rt_runtime());
 
 #ifdef CONFIG_SMP
 	init_defrootdomain();
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 62f0cf842277..ed4251fa87c7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -18,8 +18,6 @@
 #include "sched.h"
 #include "pelt.h"
 
-struct dl_bandwidth def_dl_bandwidth;
-
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
 	return container_of(dl_se, struct task_struct, dl);
@@ -423,12 +421,10 @@ void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
 void init_dl_bw(struct dl_bw *dl_b)
 {
 	raw_spin_lock_init(&dl_b->lock);
-	raw_spin_lock(&def_dl_bandwidth.dl_runtime_lock);
 	if (global_rt_runtime() == RUNTIME_INF)
 		dl_b->bw = -1;
 	else
 		dl_b->bw = to_ratio(global_rt_period(), global_rt_runtime());
-	raw_spin_unlock(&def_dl_bandwidth.dl_runtime_lock);
 	dl_b->total_bw = 0;
 }
 
@@ -2731,9 +2727,6 @@ void sched_dl_do_global(void)
 	int cpu;
 	unsigned long flags;
 
-	def_dl_bandwidth.dl_period = global_rt_period();
-	def_dl_bandwidth.dl_runtime = global_rt_runtime();
-
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3da5718cd641..a8b8516b8452 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2333,7 +2333,6 @@ extern void resched_cpu(int cpu);
 extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 
-extern struct dl_bandwidth def_dl_bandwidth;
 extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
 extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
-- 
2.25.1

