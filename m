Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D664051628F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbiEAIJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbiEAII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:08:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BAA22518;
        Sun,  1 May 2022 01:05:31 -0700 (PDT)
Date:   Sun, 01 May 2022 08:05:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651392330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+spWrcPrbTUUZGwE7e3adfKfCHYQ3Ba2eFYiYfXCJ0=;
        b=eE8y6XRp0yiMmdl2cxhuAt8RVcYycgB0eo/6Y4ZK8eLCxQeVAJX5bn+oGasRFz4LyRYQ0t
        9S87S06XFcp7jHtGjkDbAdL7MyoPscmPLyofWuktoLPFwUpjGuFwDlqWPOsuMdsomDsILH
        jqlI1SkrwC+PMtc4Q5+sof1r0+MkFCdAx2NQOYpnQHbPPuCucz9Napp5U1D7gAfe4yL4/3
        r2b1anIIGF5i5yEgIENh93PvBOLrZJCdH3pzkUP5dEkCOSbmE2/ToP/OraxmrWza89lLCq
        GgC4Jqd1KcI6GUJjhx9EVEYz4i8153y21wHJD/WvBYty5vN+k0Hq5O3F/ujozQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651392330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+spWrcPrbTUUZGwE7e3adfKfCHYQ3Ba2eFYiYfXCJ0=;
        b=Qq/CLeBvJTCIQ2zOE19+HXxaKspxmSDeUCSosxFjIYEyigGEBwIKV2DUwPy5I3Bmyo7GpB
        Wkzc5e/KEXIBCuBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix missing prototype warnings
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220413133024.249118058@linutronix.de>
References: <20220413133024.249118058@linutronix.de>
MIME-Version: 1.0
Message-ID: <165139232942.4207.4368657808943389619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d664e399128bd78b905ff480917e2c2d4949e101
Gitweb:        https://git.kernel.org/tip/d664e399128bd78b905ff480917e2c2d4949e101
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Apr 2022 15:31:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 01 May 2022 10:03:43 +02:00

sched: Fix missing prototype warnings

A W=1 build emits more than a dozen missing prototype warnings related to
scheduler and scheduler specific includes.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220413133024.249118058@linutronix.de
---
 include/linux/sched.h        | 2 ++
 kernel/sched/build_policy.c  | 2 ++
 kernel/sched/build_utility.c | 1 +
 kernel/sched/core.c          | 3 +++
 kernel/sched/deadline.c      | 2 --
 kernel/sched/fair.c          | 1 +
 kernel/sched/sched.h         | 8 ++------
 kernel/sched/smp.h           | 6 ++++++
 kernel/stop_machine.c        | 2 --
 9 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fc74ea2..a27316f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2388,4 +2388,6 @@ static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
 #endif
 
+extern void sched_set_stop_task(int cpu, struct task_struct *stop);
+
 #endif
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index e0104b4..d9dc9ab 100644
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
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index eec0849..99bdd96 100644
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 068c088..e644578 100644
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
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fb4255a..6ae4236 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1220,8 +1220,6 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
 	return (dl_se->runtime <= 0);
 }
 
-extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
-
 /*
  * This function implements the GRUB accounting rule:
  * according to the GRUB reclaiming algorithm, the runtime is
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6ca054b..bc9f6e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -36,6 +36,7 @@
 #include <linux/sched/cond_resched.h>
 #include <linux/sched/cputime.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/nohz.h>
 
 #include <linux/cpuidle.h>
 #include <linux/interrupt.h>
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 762be73..4784898 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1833,12 +1833,7 @@ static inline void dirty_sched_domain_sysctl(int cpu)
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
 
@@ -2315,6 +2310,7 @@ extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
+extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
 extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 9620e32..5719bf9 100644
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
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cbc3027..6da7b91 100644
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
