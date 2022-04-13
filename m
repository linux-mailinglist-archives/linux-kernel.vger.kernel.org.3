Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9324B4FF7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiDMNd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiDMNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:33:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1C45E765
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:31:03 -0700 (PDT)
Message-ID: <20220413133024.249118058@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649856662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=69AEwFG9KN7E8YNtjZ/V9qyJTOeoNdNZpvhNkDaqw4I=;
        b=yFR2IECGpJx6Rv//CloyWMdYnZ0Mi5YoRty0BQ1EapXLz/eAGzU+JTDBe7AAjYYSvrc61B
        3PH/NonMi5AMn3r+7EFc6tjzwYMDpS3n/iy8xsCTo3wAD1D7UicPUbGCMCn29+heCzsCzQ
        l58NVwEcXk0HYK4JcspGJf1oKJ/J9cwxghmG5rjWrX7NgbMSeW/X2uj4uTqfzewxdfc87Z
        UaShlNPbL6IeVPYFEzTxfjBrlRcQIcDe/nwq8baKAg20ZEJOw2D5zNzHpKGNkGiuGyxOHh
        tIiVfqgy/QKobe81FEPFScwJY0VCor4EYqjWLTcOnI/Tfw2WF5L9ZKUHiU8jdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649856662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=69AEwFG9KN7E8YNtjZ/V9qyJTOeoNdNZpvhNkDaqw4I=;
        b=Q+0vE2QoWFyjrJI/oLw/Gdo3nulfE9wFqeV5eNh5ZpuysHpDNZN3u3RPWQi2aUAByRgxS+
        UEs9y1hmYmamMUDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: [patch V5 1/3] sched: Fix missing prototype warnings
References: <20220413132836.099363044@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Apr 2022 15:31:02 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A W=1 build emits more than a dozen missing prototype warnings related to
scheduler and scheduler specific includes.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/sched.h        |    2 ++
 kernel/sched/build_policy.c  |    2 ++
 kernel/sched/build_utility.c |    1 +
 kernel/sched/core.c          |    3 +++
 kernel/sched/deadline.c      |    2 --
 kernel/sched/fair.c          |    1 +
 kernel/sched/sched.h         |    8 ++------
 kernel/sched/smp.h           |    6 ++++++
 kernel/stop_machine.c        |    2 --
 9 files changed, 17 insertions(+), 10 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2361,4 +2361,6 @@ static inline void sched_core_free(struc
 static inline void sched_core_fork(struct task_struct *p) { }
 #endif
 
+extern void sched_set_stop_task(int cpu, struct task_struct *stop);
+
 #endif
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -15,6 +15,7 @@
 /* Headers: */
 #include <linux/sched/clock.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/hotplug.h>
 #include <linux/sched/posix-timers.h>
 #include <linux/sched/rt.h>
 
@@ -31,6 +32,7 @@
 #include <uapi/linux/sched/types.h>
 
 #include "sched.h"
+#include "smp.h"
 
 #include "autogroup.h"
 #include "stats.h"
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -14,6 +14,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/loadavg.h>
+#include <linux/sched/nohz.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/rseq_api.h>
 #include <linux/sched/task_stack.h>
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -26,7 +26,10 @@
 #include <linux/topology.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/cond_resched.h>
+#include <linux/sched/cputime.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/hotplug.h>
+#include <linux/sched/init.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/loadavg.h>
 #include <linux/sched/mm.h>
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1220,8 +1220,6 @@ int dl_runtime_exceeded(struct sched_dl_
 	return (dl_se->runtime <= 0);
 }
 
-extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
-
 /*
  * This function implements the GRUB accounting rule:
  * according to the GRUB reclaiming algorithm, the runtime is
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -36,6 +36,7 @@
 #include <linux/sched/cond_resched.h>
 #include <linux/sched/cputime.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/nohz.h>
 
 #include <linux/cpuidle.h>
 #include <linux/interrupt.h>
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1827,12 +1827,7 @@ static inline void dirty_sched_domain_sy
 #endif
 
 extern int sched_update_scaling(void);
-
-extern void flush_smp_call_function_from_idle(void);
-
-#else /* !CONFIG_SMP: */
-static inline void flush_smp_call_function_from_idle(void) { }
-#endif
+#endif /* CONFIG_SMP */
 
 #include "stats.h"
 
@@ -2309,6 +2304,7 @@ extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
+extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
 extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -7,3 +7,9 @@
 extern void sched_ttwu_pending(void *arg);
 
 extern void send_call_function_single_ipi(int cpu);
+
+#ifdef CONFIG_SMP
+extern void flush_smp_call_function_from_idle(void);
+#else
+static inline void flush_smp_call_function_from_idle(void) { }
+#endif
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -535,8 +535,6 @@ void stop_machine_park(int cpu)
 	kthread_park(stopper->thread);
 }
 
-extern void sched_set_stop_task(int cpu, struct task_struct *stop);
-
 static void cpu_stop_create(unsigned int cpu)
 {
 	sched_set_stop_task(cpu, per_cpu(cpu_stopper.thread, cpu));

