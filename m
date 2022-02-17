Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260DB4BA90B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbiBQS5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244703AbiBQS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCDE5D1A9;
        Thu, 17 Feb 2022 10:56:50 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wmcJnv56iwBr8cdh6qkRTYSsaiBlvYs2C0o5RFb2pQ=;
        b=L5FQB3INtnqSourTu8XgdBHVsL3kPDCWssr75JpQcdnVBdoMIaVD0btGDVglEuasU2VaH/
        n21yf+6QDABAcmcPcfoHyk9FlORfrm0HB3z33dM+ofC+x3jy3jph8HsYMyDH11hGf+WElB
        TIhp3N4uETOX15tdAukGmm8RxQMEw7XTec5I0gdPLF+PKOO+oS7m7IdaW5w7UBMa/TnSC3
        glwykEvGrkPcZrt09z6xv20ExLqTM1cfU21B1SuTj+RRqxM19G700jP5Lhwxm94vmpJHTS
        XL0CKqZFxRTDQjD9K9HkHu7FTZq7BEZDeBLMl08pHJAIP7GjComoaIWGcgQVzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wmcJnv56iwBr8cdh6qkRTYSsaiBlvYs2C0o5RFb2pQ=;
        b=zjn2uT/mkoY1ES7MiK4KqxurYHqmJ3bW8nVCbUmq/xIT0SagdFGKrVtfQHfJeZyIkBIMjn
        F3uK0cUfgzURSMDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Use single feature type while
 referring to housekeeping cpumask
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207155910.527133-5-frederic@kernel.org>
References: <20220207155910.527133-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <164512420798.16921.1042432342597886877.tip-bot2@tip-bot2>
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

Commit-ID:     04d4e665a60902cf36e7ad39af1179cb5df542ad
Gitweb:        https://git.kernel.org/tip/04d4e665a60902cf36e7ad39af1179cb5df542ad
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 07 Feb 2022 16:59:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:55 +01:00

sched/isolation: Use single feature type while referring to housekeeping cpumask

Refer to housekeeping APIs using single feature types instead of flags.
This prevents from passing multiple isolation features at once to
housekeeping interfaces, which soon won't be possible anymore as each
isolation features will have their own cpumask.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20220207155910.527133-5-frederic@kernel.org
---
 arch/x86/kernel/cpu/aperfmperf.c |  6 ++--
 arch/x86/kvm/x86.c               |  2 +-
 drivers/base/cpu.c               |  2 +-
 drivers/pci/pci-driver.c         |  4 +--
 include/linux/sched/isolation.h  | 43 +++++++++++++++----------------
 kernel/cgroup/cpuset.c           |  6 ++--
 kernel/cpu.c                     |  4 +--
 kernel/irq/cpuhotplug.c          |  4 +--
 kernel/irq/manage.c              |  4 +--
 kernel/kthread.c                 |  4 +--
 kernel/rcu/tasks.h               |  2 +-
 kernel/rcu/tree_plugin.h         |  6 ++--
 kernel/sched/core.c              | 12 ++++-----
 kernel/sched/fair.c              | 10 +++----
 kernel/sched/isolation.c         | 32 +++++++++++++++--------
 kernel/sched/topology.c          |  8 +++---
 kernel/watchdog.c                |  2 +-
 kernel/workqueue.c               |  4 +--
 net/core/net-sysfs.c             |  4 +--
 19 files changed, 86 insertions(+), 73 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 22911de..9ca008f 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -91,7 +91,7 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
-	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
 	if (rcu_is_idle_cpu(cpu))
@@ -114,7 +114,7 @@ void arch_freq_prepare_all(void)
 		return;
 
 	for_each_online_cpu(cpu) {
-		if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+		if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 			continue;
 		if (rcu_is_idle_cpu(cpu))
 			continue; /* Idle CPUs are completely uninteresting. */
@@ -136,7 +136,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
-	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9e43d75..02a7ac1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8769,7 +8769,7 @@ int kvm_arch_init(void *opaque)
 	}
 
 	if (pi_inject_timer == -1)
-		pi_inject_timer = housekeeping_enabled(HK_FLAG_TIMER);
+		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
 #ifdef CONFIG_X86_64
 	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 5fc2580..2ef23fc 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -275,7 +275,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 		return -ENOMEM;
 
 	cpumask_andnot(isolated, cpu_possible_mask,
-		       housekeeping_cpumask(HK_FLAG_DOMAIN));
+		       housekeeping_cpumask(HK_TYPE_DOMAIN));
 	len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4a5792c..f61c40a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -377,8 +377,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			goto out;
 		}
 		cpumask_and(wq_domain_mask,
-			    housekeeping_cpumask(HK_FLAG_WQ),
-			    housekeeping_cpumask(HK_FLAG_DOMAIN));
+			    housekeeping_cpumask(HK_TYPE_WQ),
+			    housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 		cpu = cpumask_any_and(cpumask_of_node(node),
 				      wq_domain_mask);
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index cc9f393..8c15abd 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -5,54 +5,55 @@
 #include <linux/init.h>
 #include <linux/tick.h>
 
-enum hk_flags {
-	HK_FLAG_TIMER		= 1,
-	HK_FLAG_RCU		= (1 << 1),
-	HK_FLAG_MISC		= (1 << 2),
-	HK_FLAG_SCHED		= (1 << 3),
-	HK_FLAG_TICK		= (1 << 4),
-	HK_FLAG_DOMAIN		= (1 << 5),
-	HK_FLAG_WQ		= (1 << 6),
-	HK_FLAG_MANAGED_IRQ	= (1 << 7),
-	HK_FLAG_KTHREAD		= (1 << 8),
+enum hk_type {
+	HK_TYPE_TIMER,
+	HK_TYPE_RCU,
+	HK_TYPE_MISC,
+	HK_TYPE_SCHED,
+	HK_TYPE_TICK,
+	HK_TYPE_DOMAIN,
+	HK_TYPE_WQ,
+	HK_TYPE_MANAGED_IRQ,
+	HK_TYPE_KTHREAD,
+	HK_TYPE_MAX
 };
 
 #ifdef CONFIG_CPU_ISOLATION
 DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
-extern int housekeeping_any_cpu(enum hk_flags flags);
-extern const struct cpumask *housekeeping_cpumask(enum hk_flags flags);
-extern bool housekeeping_enabled(enum hk_flags flags);
-extern void housekeeping_affine(struct task_struct *t, enum hk_flags flags);
-extern bool housekeeping_test_cpu(int cpu, enum hk_flags flags);
+extern int housekeeping_any_cpu(enum hk_type type);
+extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
+extern bool housekeeping_enabled(enum hk_type type);
+extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
+extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern void __init housekeeping_init(void);
 
 #else
 
-static inline int housekeeping_any_cpu(enum hk_flags flags)
+static inline int housekeeping_any_cpu(enum hk_type type)
 {
 	return smp_processor_id();
 }
 
-static inline const struct cpumask *housekeeping_cpumask(enum hk_flags flags)
+static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
 {
 	return cpu_possible_mask;
 }
 
-static inline bool housekeeping_enabled(enum hk_flags flags)
+static inline bool housekeeping_enabled(enum hk_type type)
 {
 	return false;
 }
 
 static inline void housekeeping_affine(struct task_struct *t,
-				       enum hk_flags flags) { }
+				       enum hk_type type) { }
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
-static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
+static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 {
 #ifdef CONFIG_CPU_ISOLATION
 	if (static_branch_unlikely(&housekeeping_overridden))
-		return housekeeping_test_cpu(cpu, flags);
+		return housekeeping_test_cpu(cpu, type);
 #endif
 	return true;
 }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index dc653ab..e4e18a2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -803,7 +803,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 			update_domain_attr_tree(dattr, &top_cpuset);
 		}
 		cpumask_and(doms[0], top_cpuset.effective_cpus,
-			    housekeeping_cpumask(HK_FLAG_DOMAIN));
+			    housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 		goto done;
 	}
@@ -833,7 +833,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		if (!cpumask_empty(cp->cpus_allowed) &&
 		    !(is_sched_load_balance(cp) &&
 		      cpumask_intersects(cp->cpus_allowed,
-					 housekeeping_cpumask(HK_FLAG_DOMAIN))))
+					 housekeeping_cpumask(HK_TYPE_DOMAIN))))
 			continue;
 
 		if (root_load_balance &&
@@ -922,7 +922,7 @@ restart:
 
 			if (apn == b->pn) {
 				cpumask_or(dp, dp, b->effective_cpus);
-				cpumask_and(dp, dp, housekeeping_cpumask(HK_FLAG_DOMAIN));
+				cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
 				if (dattr)
 					update_domain_attr_tree(dattr + nslot, b);
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a256..f39eb0b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1488,8 +1488,8 @@ int freeze_secondary_cpus(int primary)
 	cpu_maps_update_begin();
 	if (primary == -1) {
 		primary = cpumask_first(cpu_online_mask);
-		if (!housekeeping_cpu(primary, HK_FLAG_TIMER))
-			primary = housekeeping_any_cpu(HK_FLAG_TIMER);
+		if (!housekeeping_cpu(primary, HK_TYPE_TIMER))
+			primary = housekeeping_any_cpu(HK_TYPE_TIMER);
 	} else {
 		if (!cpu_online(primary))
 			primary = cpumask_first(cpu_online_mask);
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 39a41c5..1ed2b17 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -176,10 +176,10 @@ static bool hk_should_isolate(struct irq_data *data, unsigned int cpu)
 {
 	const struct cpumask *hk_mask;
 
-	if (!housekeeping_enabled(HK_FLAG_MANAGED_IRQ))
+	if (!housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
 		return false;
 
-	hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 	if (cpumask_subset(irq_data_get_effective_affinity_mask(data), hk_mask))
 		return false;
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f23ffd3..c03f71d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -247,13 +247,13 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * online.
 	 */
 	if (irqd_affinity_is_managed(data) &&
-	    housekeeping_enabled(HK_FLAG_MANAGED_IRQ)) {
+	    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
 		const struct cpumask *hk_mask, *prog_mask;
 
 		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
 		static struct cpumask tmp_mask;
 
-		hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 
 		raw_spin_lock(&tmp_mask_lock);
 		cpumask_and(&tmp_mask, mask, hk_mask);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 38c6dd8..d100d5a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -356,7 +356,7 @@ static int kthread(void *_create)
 	 * back to default in case they have been changed.
 	 */
 	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
-	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
+	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
@@ -722,7 +722,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_FLAG_KTHREAD));
+	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KTHREAD));
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 84f1d91..6093b20 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -492,7 +492,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	struct rcu_tasks *rtp = arg;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
-	housekeeping_affine(current, HK_FLAG_RCU);
+	housekeeping_affine(current, HK_TYPE_RCU);
 	WRITE_ONCE(rtp->kthread_ptr, current); // Let GPs start!
 
 	/*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c5b45c2..65f25a3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1214,9 +1214,9 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
 		    cpu != outgoingcpu)
 			cpumask_set_cpu(cpu, cm);
-	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
+	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
 	if (cpumask_weight(cm) == 0)
-		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
+		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
 	set_cpus_allowed_ptr(t, cm);
 	free_cpumask_var(cm);
 }
@@ -1291,7 +1291,7 @@ static void rcu_bind_gp_kthread(void)
 {
 	if (!tick_nohz_full_enabled())
 		return;
-	housekeeping_affine(current, HK_FLAG_RCU);
+	housekeeping_affine(current, HK_TYPE_RCU);
 }
 
 /* Record the current task on dyntick-idle entry. */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b222692..1e08b02 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1025,13 +1025,13 @@ int get_nohz_timer_target(void)
 	struct sched_domain *sd;
 	const struct cpumask *hk_mask;
 
-	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
+	if (housekeeping_cpu(cpu, HK_TYPE_TIMER)) {
 		if (!idle_cpu(cpu))
 			return cpu;
 		default_cpu = cpu;
 	}
 
-	hk_mask = housekeeping_cpumask(HK_FLAG_TIMER);
+	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
@@ -1047,7 +1047,7 @@ int get_nohz_timer_target(void)
 	}
 
 	if (default_cpu == -1)
-		default_cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+		default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
 	cpu = default_cpu;
 unlock:
 	rcu_read_unlock();
@@ -5371,7 +5371,7 @@ static void sched_tick_start(int cpu)
 	int os;
 	struct tick_work *twork;
 
-	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
@@ -5392,7 +5392,7 @@ static void sched_tick_stop(int cpu)
 	struct tick_work *twork;
 	int os;
 
-	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
@@ -9251,7 +9251,7 @@ void __init sched_init_smp(void)
 	mutex_unlock(&sched_domains_mutex);
 
 	/* Move init over to a non-isolated CPU */
-	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
+	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0)
 		BUG();
 	current->flags &= ~PF_NO_SETAFFINITY;
 	sched_init_granularity();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11a72e1..dcbd311 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10337,7 +10337,7 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notice that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED not set
+ * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED not set
  *   anywhere yet.
  */
 
@@ -10346,7 +10346,7 @@ static inline int find_new_ilb(void)
 	int ilb;
 	const struct cpumask *hk_mask;
 
-	hk_mask = housekeeping_cpumask(HK_FLAG_MISC);
+	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
 
 	for_each_cpu_and(ilb, nohz.idle_cpus_mask, hk_mask) {
 
@@ -10362,7 +10362,7 @@ static inline int find_new_ilb(void)
 
 /*
  * Kick a CPU to do the nohz balancing, if it is time for it. We pick any
- * idle CPU in the HK_FLAG_MISC housekeeping set (if there is one).
+ * idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {
@@ -10575,7 +10575,7 @@ void nohz_balance_enter_idle(int cpu)
 		return;
 
 	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
-	if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
+	if (!housekeeping_cpu(cpu, HK_TYPE_SCHED))
 		return;
 
 	/*
@@ -10791,7 +10791,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	 * This CPU doesn't want to be disturbed by scheduler
 	 * housekeeping
 	 */
-	if (!housekeeping_cpu(this_cpu, HK_FLAG_SCHED))
+	if (!housekeeping_cpu(this_cpu, HK_TYPE_SCHED))
 		return;
 
 	/* Will wake up very soon. No time for doing anything else*/
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7f06eaf..a735d9e 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -9,23 +9,35 @@
  */
 #include "sched.h"
 
+enum hk_flags {
+	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
+	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
+	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
+	HK_FLAG_SCHED		= BIT(HK_TYPE_SCHED),
+	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
+	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
+	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
+	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
+	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
+};
+
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 static cpumask_var_t housekeeping_mask;
 static unsigned int housekeeping_flags;
 
-bool housekeeping_enabled(enum hk_flags flags)
+bool housekeeping_enabled(enum hk_type type)
 {
-	return !!(housekeeping_flags & flags);
+	return !!(housekeeping_flags & BIT(type));
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
-int housekeeping_any_cpu(enum hk_flags flags)
+int housekeeping_any_cpu(enum hk_type type)
 {
 	int cpu;
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
-		if (housekeeping_flags & flags) {
+		if (housekeeping_flags & BIT(type)) {
 			cpu = sched_numa_find_closest(housekeeping_mask, smp_processor_id());
 			if (cpu < nr_cpu_ids)
 				return cpu;
@@ -37,27 +49,27 @@ int housekeeping_any_cpu(enum hk_flags flags)
 }
 EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
 
-const struct cpumask *housekeeping_cpumask(enum hk_flags flags)
+const struct cpumask *housekeeping_cpumask(enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
+		if (housekeeping_flags & BIT(type))
 			return housekeeping_mask;
 	return cpu_possible_mask;
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
 
-void housekeeping_affine(struct task_struct *t, enum hk_flags flags)
+void housekeeping_affine(struct task_struct *t, enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
+		if (housekeeping_flags & BIT(type))
 			set_cpus_allowed_ptr(t, housekeeping_mask);
 }
 EXPORT_SYMBOL_GPL(housekeeping_affine);
 
-bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
+bool housekeeping_test_cpu(int cpu, enum hk_type type)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
+		if (housekeeping_flags & BIT(type))
 			return cpumask_test_cpu(cpu, housekeeping_mask);
 	return true;
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5db322c..32841c6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1366,7 +1366,7 @@ static void asym_cpu_capacity_scan(void)
 	list_for_each_entry(entry, &asym_cap_list, link)
 		cpumask_clear(cpu_capacity_span(entry));
 
-	for_each_cpu_and(cpu, cpu_possible_mask, housekeeping_cpumask(HK_FLAG_DOMAIN))
+	for_each_cpu_and(cpu, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN))
 		asym_cpu_capacity_update_data(cpu);
 
 	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
@@ -2440,7 +2440,7 @@ int sched_init_domains(const struct cpumask *cpu_map)
 	doms_cur = alloc_sched_domains(ndoms_cur);
 	if (!doms_cur)
 		doms_cur = &fallback_doms;
-	cpumask_and(doms_cur[0], cpu_map, housekeeping_cpumask(HK_FLAG_DOMAIN));
+	cpumask_and(doms_cur[0], cpu_map, housekeeping_cpumask(HK_TYPE_DOMAIN));
 	err = build_sched_domains(doms_cur[0], NULL);
 
 	return err;
@@ -2529,7 +2529,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 		if (doms_new) {
 			n = 1;
 			cpumask_and(doms_new[0], cpu_active_mask,
-				    housekeeping_cpumask(HK_FLAG_DOMAIN));
+				    housekeeping_cpumask(HK_TYPE_DOMAIN));
 		}
 	} else {
 		n = ndoms_new;
@@ -2564,7 +2564,7 @@ match1:
 		n = 0;
 		doms_new = &fallback_doms;
 		cpumask_and(doms_new[0], cpu_active_mask,
-			    housekeeping_cpumask(HK_FLAG_DOMAIN));
+			    housekeeping_cpumask(HK_TYPE_DOMAIN));
 	}
 
 	/* Build new domains: */
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 99afb88..9166220 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -848,7 +848,7 @@ void __init lockup_detector_init(void)
 		pr_info("Disabling watchdog on nohz_full cores by default\n");
 
 	cpumask_copy(&watchdog_cpumask,
-		     housekeeping_cpumask(HK_FLAG_TIMER));
+		     housekeeping_cpumask(HK_TYPE_TIMER));
 
 	if (!watchdog_nmi_probe())
 		nmi_watchdog_available = true;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 61ed310..52e9abb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6011,8 +6011,8 @@ void __init workqueue_init_early(void)
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
-	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_WQ));
-	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_DOMAIN));
+	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
+	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ed8da7b..7ceb346 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -839,8 +839,8 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 	}
 
 	if (!cpumask_empty(mask)) {
-		cpumask_and(mask, mask, housekeeping_cpumask(HK_FLAG_DOMAIN));
-		cpumask_and(mask, mask, housekeeping_cpumask(HK_FLAG_WQ));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_WQ));
 		if (cpumask_empty(mask)) {
 			free_cpumask_var(mask);
 			return -EINVAL;
