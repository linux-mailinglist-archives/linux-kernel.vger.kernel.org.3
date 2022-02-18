Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D34BC1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiBRVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:16:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiBRVQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:16:10 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1760923F0A6;
        Fri, 18 Feb 2022 13:15:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 85CEF3BAC84;
        Fri, 18 Feb 2022 16:06:49 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OyUQxXtczig6; Fri, 18 Feb 2022 16:06:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9BF403BAC80;
        Fri, 18 Feb 2022 16:06:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9BF403BAC80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645218405;
        bh=uMuAXUKA2soJTkFiGICIDNL1xEJYdKm49C06IYaue1s=;
        h=From:To:Date:Message-Id;
        b=YEqyAunoUkZ6zUAueSa1Klmm7gUCSBlZWt3N4778T+RtwBc/6eMB/pBgw326FIs4q
         BN+WDxbznHA30aRsDlH/l6St/0Ag30Gv84Hoy1D5YXMo/2ZMWT1ziLsv0l0kBW2krJ
         TWBxocB5dpUrY2Xmjy16aNH8/FqEdnArkDrNnpwAotsWmXfqIEVo6ZB3JFeN82VHvN
         sw4mG8MqGnSxxV7kZEgPi4uoeHNNv+s4IdmJYp1PYLjsNUlHhjjPgN0acfr8OPffKW
         nAIYs+YaNih4yQJDNLMVH4GltOoJUPhtrcEGfXQtISoGBu8C89/ZQDAHDqZrclbY4K
         M6Zh7lq95RHzA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jE3P2wCmM7o9; Fri, 18 Feb 2022 16:06:45 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 86A143BAC07;
        Fri, 18 Feb 2022 16:06:44 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2 09/11] sched: Introduce per memory space current virtual cpu id
Date:   Fri, 18 Feb 2022 16:06:31 -0500
Message-Id: <20220218210633.23345-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature allows the scheduler to expose a current virtual cpu id
to user-space. This virtual cpu id is within the possible cpus range,
and is temporarily (and uniquely) assigned while threads are actively
running within a memory space. If a memory space has fewer threads than
cores, or is limited to run on few cores concurrently through sched
affinity or cgroup cpusets, the virtual cpu ids will be values close
to 0, thus allowing efficient use of user-space memory for per-cpu
data structures.

The vcpu_ids are NUMA-aware. On NUMA systems, when a vcpu_id is observed
by user-space to be associated with a NUMA node, it is guaranteed to
never change NUMA node unless a kernel-level NUMA configuration change
happens.

This feature is meant to be exposed by a new rseq thread area field.

The primary purpose of this feature is to do the heavy-lifting needed
by memory allocators to allow them to use per-cpu data structures
efficiently in the following situations:

- Single-threaded applications,
- Multi-threaded applications on large systems (many cores) with limited
  cpu affinity mask,
- Multi-threaded applications on large systems (many cores) with
  restricted cgroup cpuset per container,
- Processes using memory from many NUMA nodes.

One of the key concerns from scheduler maintainers is the overhead
associated with additional atomic operations in the scheduler fast-path.
In order to save one atomic set bit and one atomic clear bit on the
scheduler context switch fast path, the following optimizations are
implemented:

1) On context switch between threads belonging to the same memory space,
   transfer the mm_vcpu_id from prev to next without any atomic ops.
   This takes care of use-cases involving frequent context switch
   between threads belonging to the same memory space.

2) Threads belonging to a memory space with single user (mm_users==1)
   can be assigned mm_vcpu_id=0 without any atomic operation on the
   scheduler fast-path. In non-NUMA, when a memory space goes from
   single to multi-threaded, lazily allocate the vcpu_id 0 in the mm
   vcpu mask. This takes care of all single-threaded use-cases
   involving context switching between threads belonging to different
   memory spaces.

   With NUMA, the single-threaded memory space scenario is still
   special-cased to eliminate all atomic operations on the fast path,
   but rather than returning vcpu_id=0, return the current numa_node_id
   to allow single-threaded memory spaces to keep good numa locality.
   On systems where the number of cpus ids is lower than the number of
   numa node ids, pick the first cpu in the node cpumask rather than the
   node ID.

3) Introduce a per-runqueue cache containing { mm, vcpu_id } entries.
   Keep track of the recently allocated vcpu_id for each mm rather than
   freeing them immediately. This eliminates most atomic ops when
   context switching back and forth between threads belonging to
   different memory spaces in multi-threaded scenarios (many processes,
   each with many threads).

The credit goes to Paul Turner (Google) for the vcpu_id idea. This
feature is implemented based on the discussions with Paul Turner and
Peter Oskolkov (Google), but I took the liberty to implement scheduler
fast-path optimizations and my own NUMA-awareness scheme. The rumor has
it that Google have been running a rseq vcpu_id extension internally at
Google in production for a year. The tcmalloc source code indeed has
comments hinting at a vcpu_id prototype extension to the rseq system
call [1].

schedstats:

* perf bench sched messaging (single instance, multi-process):

On sched-switch:
  single-threaded vcpu-id:                99.985 %
  transfer between threads:                0     %
  runqueue cache hit:                      0.015 %
  runqueue cache eviction (bit-clear):     0     %
  runqueue cache discard (bit-clear):      0     %
  vcpu-id allocation (bit-set):            0     %

On release mm:
  vcpu-id remove (bit-clear):              0     %

On migration:
  vcpu-id remove (bit-clear):              0     %

* perf bench sched messaging -t (single instance, multi-thread):

On sched-switch:
  single-threaded vcpu-id:                 0.128 %
  transfer between threads:               98.260 %
  runqueue cache hit:                      1.075 %
  runqueue cache eviction (bit-clear):     0.001 %
  runqueue cache discard (bit-clear):      0     %
  vcpu-id allocation (bit-set):            0.269 %

On release mm:
  vcpu-id remove (bit-clear):              0.161 %

On migration:
  vcpu-id remove (bit-clear):              0.107 %

* perf bench sched messaging -t (two instances, multi-thread):

On sched-switch:
  single-threaded vcpu-id:                 0.081 %
  transfer between threads:               89.512 %
  runqueue cache hit:                      9.659 %
  runqueue cache eviction (bit-clear):     0.003 %
  runqueue cache discard (bit-clear):      0     %
  vcpu-id allocation (bit-set):            0.374 %

On release mm:
  vcpu-id remove (bit-clear):              0.243 %

On migration:
  vcpu-id remove (bit-clear):              0.129 %

* perf bench sched pipe (one instance, multi-process):

On sched-switch:
  single-threaded vcpu-id:                99.993 %
  transfer between threads:                0.001 %
  runqueue cache hit:                      0.002 %
  runqueue cache eviction (bit-clear):     0     %
  runqueue cache discard (bit-clear):      0     %
  vcpu-id allocation (bit-set):            0.002 %

On release mm:
  vcpu-id remove (bit-clear):              0     %

On migration:
  vcpu-id remove (bit-clear):              0.002 %

[1] https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/linux_syscall_support.h#L26

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 fs/exec.c                |   4 +
 include/linux/mm.h       |  25 +++
 include/linux/mm_types.h | 111 ++++++++++++
 include/linux/sched.h    |   5 +
 init/Kconfig             |   4 +
 kernel/fork.c            |  15 +-
 kernel/sched/core.c      |  82 +++++++++
 kernel/sched/deadline.c  |   3 +
 kernel/sched/debug.c     |  13 ++
 kernel/sched/fair.c      |   1 +
 kernel/sched/rt.c        |   2 +
 kernel/sched/sched.h     | 364 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/stats.c     |  16 +-
 13 files changed, 642 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..7b7520b63e95 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1006,6 +1006,10 @@ static int exec_mmap(struct mm_struct *mm)
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
 	tsk->mm = mm;
+	mm_init_vcpu_users(mm);
+	mm_init_vcpumask(mm);
+	mm_init_node_vcpumask(mm);
+	sched_vcpu_activate_mm(tsk, mm);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1a84b1e6787..6ca8a4a85fcd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3374,5 +3374,30 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
+#ifdef CONFIG_SCHED_MM_VCPU
+void sched_vcpu_release_mm(struct task_struct *t, struct mm_struct *mm);
+void sched_vcpu_activate_mm(struct task_struct *t, struct mm_struct *mm);
+void sched_vcpu_get_mm(struct task_struct *t, struct mm_struct *mm);
+void sched_vcpu_dup_mm(struct task_struct *t, struct mm_struct *mm);
+static inline int task_mm_vcpu_id(struct task_struct *t)
+{
+	return t->mm_vcpu;
+}
+#else
+static inline void sched_vcpu_release_mm(struct task_struct *t, struct mm_struct *mm) { }
+static inline void sched_vcpu_activate_mm(struct task_struct *t, struct mm_struct *mm) { }
+static inline void sched_vcpu_get_mm(struct task_struct *t, struct mm_struct *mm) { }
+static inline void sched_vcpu_dup_mm(struct task_struct *t, struct mm_struct *mm) { }
+static inline int task_mm_vcpu_id(struct task_struct *t)
+{
+	/*
+	 * Use the processor id as a fall-back when the mm vcpu feature is
+	 * disabled. This provides functional per-cpu data structure accesses
+	 * in user-space, althrough it won't provide the memory usage benefits.
+	 */
+	return raw_smp_processor_id();
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9db36dc5d4cf..40fcc526396f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -17,6 +17,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
+#include <linux/nodemask.h>
 
 #include <asm/mmu.h>
 
@@ -502,6 +503,20 @@ struct mm_struct {
 		 */
 		atomic_t mm_count;
 
+#ifdef CONFIG_SCHED_MM_VCPU
+		/**
+		 * @mm_vcpu_users: The number of references to &struct mm_struct
+		 * from user-space threads.
+		 *
+		 * Initialized to 1 for the first thread with a reference with
+		 * the mm. Incremented for each thread getting a reference to the
+		 * mm, and decremented on mm release from user-space threads.
+		 * Used to enable single-threaded mm_vcpu accounting (when == 1).
+		 */
+
+		atomic_t mm_vcpu_users;
+#endif
+
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* PTE page table pages */
 #endif
@@ -659,6 +674,102 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
 
+#ifdef CONFIG_SCHED_MM_VCPU
+/* Future-safe accessor for struct mm_struct's vcpu_mask. */
+static inline cpumask_t *mm_vcpumask(struct mm_struct *mm)
+{
+	unsigned long vcpu_bitmap = (unsigned long)mm;
+
+	vcpu_bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	/* Skip cpu_bitmap */
+	vcpu_bitmap += cpumask_size();
+	return (struct cpumask *)vcpu_bitmap;
+}
+
+static inline void mm_init_vcpu_users(struct mm_struct *mm)
+{
+	atomic_set(&mm->mm_vcpu_users, 1);
+}
+
+static inline void mm_init_vcpumask(struct mm_struct *mm)
+{
+	cpumask_clear(mm_vcpumask(mm));
+}
+
+static inline unsigned int mm_vcpumask_size(void)
+{
+	return cpumask_size();
+}
+
+#else
+static inline cpumask_t *mm_vcpumask(struct mm_struct *mm)
+{
+	return NULL;
+}
+
+static inline void mm_init_vcpu_users(struct mm_struct *mm) { }
+static inline void mm_init_vcpumask(struct mm_struct *mm) { }
+
+static inline unsigned int mm_vcpumask_size(void)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_SCHED_MM_VCPU) && defined(CONFIG_NUMA)
+/*
+ * Layout of node vcpumasks:
+ * - node_alloc vcpumask:        cpumask tracking which vcpu_id were
+ *                               allocated (across nodes) in this
+ *                               memory space.
+ * - node vcpumask[nr_node_ids]: per-node cpumask tracking which vcpu_id
+ *                               were allocated in this memory space.
+ */
+static inline cpumask_t *mm_node_alloc_vcpumask(struct mm_struct *mm)
+{
+	unsigned long vcpu_bitmap = (unsigned long)mm_vcpumask(mm);
+
+	/* Skip mm_vcpumask */
+	vcpu_bitmap += cpumask_size();
+	return (struct cpumask *)vcpu_bitmap;
+}
+
+static inline cpumask_t *mm_node_vcpumask(struct mm_struct *mm, unsigned int node)
+{
+	unsigned long vcpu_bitmap = (unsigned long)mm_node_alloc_vcpumask(mm);
+
+	/* Skip node alloc vcpumask */
+	vcpu_bitmap += cpumask_size();
+	vcpu_bitmap += node * cpumask_size();
+	return (struct cpumask *)vcpu_bitmap;
+}
+
+static inline void mm_init_node_vcpumask(struct mm_struct *mm)
+{
+	unsigned int node;
+
+	if (num_possible_nodes() == 1)
+		return;
+	cpumask_clear(mm_node_alloc_vcpumask(mm));
+	for (node = 0; node < nr_node_ids; node++)
+		cpumask_clear(mm_node_vcpumask(mm, node));
+}
+
+static inline unsigned int mm_node_vcpumask_size(void)
+{
+	if (num_possible_nodes() == 1)
+		return 0;
+	return (nr_node_ids + 1) * cpumask_size();
+}
+#else
+static inline void mm_init_node_vcpumask(struct mm_struct *mm) { }
+
+static inline unsigned int mm_node_vcpumask_size(void)
+{
+	return 0;
+}
+#endif
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 838c9e0b4cae..c400d44f8716 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1300,6 +1300,11 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_SCHED_MM_VCPU
+	int				mm_vcpu;	/* Current vcpu in mm */
+	int				vcpu_mm_active;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
diff --git a/init/Kconfig b/init/Kconfig
index e9119bf54b1f..6bd40f303a0d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1023,6 +1023,10 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config SCHED_MM_VCPU
+	def_bool y
+	depends on SMP && RSEQ
+
 config UCLAMP_TASK_GROUP
 	bool "Utilization clamping per group of tasks"
 	depends on CGROUP_SCHED
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..78fcf3277540 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -970,6 +970,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
+
+#ifdef CONFIG_SCHED_MM_VCPU
+	tsk->mm_vcpu = 0;
+	tsk->vcpu_mm_active = 0;
+#endif
 	return tsk;
 
 free_stack:
@@ -1079,6 +1084,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 		goto fail_nocontext;
 
 	mm->user_ns = get_user_ns(user_ns);
+	mm_init_vcpu_users(mm);
+	mm_init_vcpumask(mm);
+	mm_init_node_vcpumask(mm);
 	return mm;
 
 fail_nocontext:
@@ -1380,6 +1388,8 @@ static int wait_for_vfork_done(struct task_struct *child,
  */
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
+	sched_vcpu_release_mm(tsk, mm);
+
 	uprobe_free_utask(tsk);
 
 	/* Get rid of any cached register state */
@@ -1499,10 +1509,12 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm = oldmm;
+		sched_vcpu_get_mm(tsk, mm);
 	} else {
 		mm = dup_mm(tsk, current->mm);
 		if (!mm)
 			return -ENOMEM;
+		sched_vcpu_dup_mm(tsk, mm);
 	}
 
 	tsk->mm = mm;
@@ -2901,7 +2913,8 @@ void __init proc_caches_init(void)
 	 * dynamically sized based on the maximum CPU number this system
 	 * can have, taking hotplug into account (nr_cpu_ids).
 	 */
-	mm_size = sizeof(struct mm_struct) + cpumask_size();
+	mm_size = sizeof(struct mm_struct) + cpumask_size() + mm_vcpumask_size() +
+		  mm_node_vcpumask_size();
 
 	mm_cachep = kmem_cache_create_usercopy("mm_struct",
 			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1e08b02e0cd5..70bf2899c9b3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2267,6 +2267,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 	lockdep_assert_rq_held(rq);
 
 	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
+	rq_vcpu_cache_remove_mm_locked(rq, p->mm, false);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
 
@@ -2454,6 +2455,7 @@ int push_cpu_stop(void *arg)
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
 		deactivate_task(rq, p, 0);
+		rq_vcpu_cache_remove_mm_locked(rq, p->mm, false);
 		set_task_cpu(p, lowest_rq->cpu);
 		activate_task(lowest_rq, p, 0);
 		resched_curr(lowest_rq);
@@ -3093,6 +3095,7 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
 		rq_pin_lock(dst_rq, &drf);
 
 		deactivate_task(src_rq, p, 0);
+		rq_vcpu_cache_remove_mm_locked(src_rq, p->mm, false);
 		set_task_cpu(p, cpu);
 		activate_task(dst_rq, p, 0);
 		check_preempt_curr(dst_rq, p, 0);
@@ -3716,6 +3719,8 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
+	if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
+		rq_vcpu_cache_remove_mm(task_rq(p), p->mm, false);
 	__smp_call_single_queue(cpu, &p->wake_entry.llist);
 }
 
@@ -4125,6 +4130,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
+		rq_vcpu_cache_remove_mm(task_rq(p), p->mm, false);
 		set_task_cpu(p, cpu);
 	}
 #else
@@ -4796,6 +4802,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
+	switch_mm_vcpu(rq, prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -5922,6 +5929,7 @@ static bool try_steal_cookie(int this, int that)
 			goto next;
 
 		deactivate_task(src, p, 0);
+		rq_vcpu_cache_remove_mm_locked(src, p->mm, false);
 		set_task_cpu(p, this);
 		activate_task(dst, p, 0);
 
@@ -10927,3 +10935,77 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
+
+#ifdef CONFIG_SCHED_MM_VCPU
+void sched_vcpu_release_mm(struct task_struct *t, struct mm_struct *mm)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (!mm)
+		return;
+	WARN_ON_ONCE(t != current);
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
+	t->vcpu_mm_active = 0;
+	atomic_dec(&mm->mm_vcpu_users);
+	rq_vcpu_cache_remove_mm_locked(rq, mm, true);
+	rq_unlock_irqrestore(rq, &rf);
+	t->mm_vcpu = -1;
+	preempt_enable();
+}
+
+void sched_vcpu_activate_mm(struct task_struct *t, struct mm_struct *mm)
+{
+	WARN_ON_ONCE(t != current);
+	preempt_disable();
+	t->vcpu_mm_active = 1;
+	/* No need to reserve in cpumask because single-threaded. */
+	t->mm_vcpu = mm_vcpu_first_node_vcpu(numa_node_id());
+	preempt_enable();
+}
+
+void sched_vcpu_get_mm(struct task_struct *t, struct mm_struct *mm)
+{
+	int vcpu, mm_vcpu_users;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	preempt_disable();
+	rq = this_rq();
+	t->vcpu_mm_active = 1;
+	mm_vcpu_users = atomic_read(&mm->mm_vcpu_users);
+	atomic_inc(&mm->mm_vcpu_users);
+	t->mm_vcpu = -1;
+	vcpu = current->mm_vcpu;
+	rq_lock_irqsave(rq, &rf);
+	/* On transition from 1 to 2 mm users, reserve vcpu ids. */
+	if (mm_vcpu_users == 1) {
+		mm_vcpu_reserve_nodes(mm);
+		rq_vcpu_cache_remove_mm_locked(rq, mm, true);
+		current->mm_vcpu = __mm_vcpu_get(rq, mm);
+		rq_vcpu_cache_add(rq, mm, current->mm_vcpu);
+		/*
+		 * __mm_vcpu_get could get a different vcpu after going
+		 * multi-threaded, then back single-threaded, then
+		 * multi-threaded on a NUMA configuration using the first CPU
+		 * matching the NUMA node as single-threaded vcpu, with
+		 * leftover vcpu_id matching the NUMA node set from when this
+		 * task was multithreaded.
+		 */
+		if (current->mm_vcpu != vcpu)
+			rseq_set_notify_resume(current);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+	preempt_enable();
+}
+
+void sched_vcpu_dup_mm(struct task_struct *t, struct mm_struct *mm)
+{
+	preempt_disable();
+	t->vcpu_mm_active = 1;
+	t->mm_vcpu = -1;
+	preempt_enable();
+}
+#endif
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b0ef01..f4f394db2db8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -655,6 +655,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
 	raw_spin_unlock(&dl_b->lock);
 
+	rq_vcpu_cache_remove_mm_locked(rq, p->mm, false);
 	set_task_cpu(p, later_rq->cpu);
 	double_unlock_balance(later_rq, rq);
 
@@ -2290,6 +2291,7 @@ static int push_dl_task(struct rq *rq)
 	}
 
 	deactivate_task(rq, next_task, 0);
+	rq_vcpu_cache_remove_mm_locked(rq, next_task->mm, false);
 	set_task_cpu(next_task, later_rq->cpu);
 
 	/*
@@ -2386,6 +2388,7 @@ static void pull_dl_task(struct rq *this_rq)
 				push_task = get_push_task(src_rq);
 			} else {
 				deactivate_task(src_rq, p, 0);
+				rq_vcpu_cache_remove_mm_locked(src_rq, p->mm, false);
 				set_task_cpu(p, this_cpu);
 				activate_task(this_rq, p, 0);
 				dmin = p->dl.deadline;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 102d6f70e84d..3b44f8dd064d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -763,6 +763,19 @@ do {									\
 		P(sched_goidle);
 		P(ttwu_count);
 		P(ttwu_local);
+#undef P
+#define P(n) SEQ_printf(m, "  .%-30s: %Ld\n", #n, schedstat_val(rq->n));
+		P(nr_vcpu_thread_transfer);
+		P(nr_vcpu_cache_hit);
+		P(nr_vcpu_cache_evict);
+		P(nr_vcpu_cache_discard_wrong_node);
+		P(nr_vcpu_allocate);
+		P(nr_vcpu_allocate_node_reuse);
+		P(nr_vcpu_allocate_node_new);
+		P(nr_vcpu_allocate_node_rebalance);
+		P(nr_vcpu_allocate_node_steal);
+		P(nr_vcpu_remove_release_mm);
+		P(nr_vcpu_remove_migrate);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dcbd3110c687..9c8b88e57315 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7817,6 +7817,7 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 	lockdep_assert_rq_held(env->src_rq);
 
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
+	rq_vcpu_cache_remove_mm_locked(env->src_rq, p->mm, false);
 	set_task_cpu(p, env->dst_cpu);
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fbbb404..fd37e23612f9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2106,6 +2106,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	}
 
 	deactivate_task(rq, next_task, 0);
+	rq_vcpu_cache_remove_mm_locked(rq, next_task->mm, false);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
 	resched_curr(lowest_rq);
@@ -2379,6 +2380,7 @@ static void pull_rt_task(struct rq *this_rq)
 				push_task = get_push_task(src_rq);
 			} else {
 				deactivate_task(src_rq, p, 0);
+				rq_vcpu_cache_remove_mm_locked(src_rq, p->mm, false);
 				set_task_cpu(p, this_cpu);
 				activate_task(this_rq, p, 0);
 				resched = true;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3da5718cd641..5034a7372452 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -916,6 +916,19 @@ struct uclamp_rq {
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
+#ifdef CONFIG_SCHED_MM_VCPU
+# define RQ_VCPU_CACHE_SIZE	8
+struct rq_vcpu_entry {
+	struct mm_struct *mm;	/* NULL if unset */
+	int vcpu_id;
+};
+
+struct rq_vcpu_cache {
+	struct rq_vcpu_entry entry[RQ_VCPU_CACHE_SIZE];
+	unsigned int head;
+};
+#endif
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -1086,6 +1099,19 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+
+	unsigned long long	nr_vcpu_single_thread;
+	unsigned long long	nr_vcpu_thread_transfer;
+	unsigned long long	nr_vcpu_cache_hit;
+	unsigned long long	nr_vcpu_cache_evict;
+	unsigned long long	nr_vcpu_cache_discard_wrong_node;
+	unsigned long long	nr_vcpu_allocate;
+	unsigned long long	nr_vcpu_allocate_node_reuse;
+	unsigned long long	nr_vcpu_allocate_node_new;
+	unsigned long long	nr_vcpu_allocate_node_rebalance;
+	unsigned long long	nr_vcpu_allocate_node_steal;
+	unsigned long long	nr_vcpu_remove_release_mm;
+	unsigned long long	nr_vcpu_remove_migrate;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
@@ -1116,6 +1142,10 @@ struct rq {
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
+
+#ifdef CONFIG_SCHED_MM_VCPU
+	struct rq_vcpu_cache	vcpu_cache;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -3137,3 +3167,337 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+#ifdef CONFIG_SCHED_MM_VCPU
+static inline int __mm_vcpu_get_single_node(struct mm_struct *mm)
+{
+	struct cpumask *cpumask;
+	int vcpu;
+
+	cpumask = mm_vcpumask(mm);
+	/* Atomically reserve lowest available vcpu number. */
+	do {
+		vcpu = cpumask_first_zero(cpumask);
+		if (vcpu >= nr_cpu_ids)
+			return -1;
+	} while (cpumask_test_and_set_cpu(vcpu, cpumask));
+	return vcpu;
+}
+
+#ifdef CONFIG_NUMA
+static inline bool mm_node_vcpumask_test_cpu(struct mm_struct *mm, int vcpu_id)
+{
+	if (num_possible_nodes() == 1)
+		return true;
+	return cpumask_test_cpu(vcpu_id, mm_node_vcpumask(mm, numa_node_id()));
+}
+
+static inline int __mm_vcpu_get(struct rq *rq, struct mm_struct *mm)
+{
+	struct cpumask *cpumask = mm_vcpumask(mm),
+		       *node_cpumask = mm_node_vcpumask(mm, numa_node_id()),
+		       *node_alloc_cpumask = mm_node_alloc_vcpumask(mm);
+	unsigned int node;
+	int vcpu;
+
+	if (num_possible_nodes() == 1)
+		return __mm_vcpu_get_single_node(mm);
+
+	/*
+	 * Try to atomically reserve lowest available vcpu number within those
+	 * already reserved for this NUMA node.
+	 */
+	do {
+		vcpu = cpumask_first_one_and_zero(node_cpumask, cpumask);
+		if (vcpu >= nr_cpu_ids)
+			goto alloc_numa;
+	} while (cpumask_test_and_set_cpu(vcpu, cpumask));
+	schedstat_inc(rq->nr_vcpu_allocate_node_reuse);
+	goto end;
+
+alloc_numa:
+	/*
+	 * Try to atomically reserve lowest available vcpu number within those
+	 * not already allocated for numa nodes.
+	 */
+	do {
+		vcpu = cpumask_first_zero_and_zero(node_alloc_cpumask, cpumask);
+		if (vcpu >= nr_cpu_ids)
+			goto numa_update;
+	} while (cpumask_test_and_set_cpu(vcpu, cpumask));
+	cpumask_set_cpu(vcpu, node_cpumask);
+	cpumask_set_cpu(vcpu, node_alloc_cpumask);
+	schedstat_inc(rq->nr_vcpu_allocate_node_new);
+	goto end;
+
+numa_update:
+	/*
+	 * NUMA node id configuration changed for at least one CPU in the system.
+	 * We need to steal a currently unused vcpu_id from an overprovisioned
+	 * node for our current node. Userspace must handle the fact that the
+	 * node id associated with this vcpu_id may change due to node ID
+	 * reconfiguration.
+	 *
+	 * Count how many possible cpus are attached to each (other) node id,
+	 * and compare this with the per-mm node vcpumask cpu count. Find one
+	 * which has too many cpus in its mask to steal from.
+	 */
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask;
+
+		if (node == numa_node_id())
+			continue;
+		iter_cpumask = mm_node_vcpumask(mm, node);
+		if (nr_cpus_node(node) < cpumask_weight(iter_cpumask)) {
+			/* Try to steal from this node. */
+			do {
+				vcpu = cpumask_first_one_and_zero(iter_cpumask, cpumask);
+				if (vcpu >= nr_cpu_ids)
+					goto steal_fail;
+			} while (cpumask_test_and_set_cpu(vcpu, cpumask));
+			cpumask_clear_cpu(vcpu, iter_cpumask);
+			cpumask_set_cpu(vcpu, node_cpumask);
+			schedstat_inc(rq->nr_vcpu_allocate_node_rebalance);
+			goto end;
+		}
+	}
+
+steal_fail:
+	/*
+	 * Our attempt at gracefully stealing a vcpu_id from another
+	 * overprovisioned NUMA node failed. Fallback to grabbing the first
+	 * available vcpu_id.
+	 */
+	do {
+		vcpu = cpumask_first_zero(cpumask);
+		if (vcpu >= nr_cpu_ids)
+			return -1;
+	} while (cpumask_test_and_set_cpu(vcpu, cpumask));
+	/* Steal vcpu from its numa node mask. */
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask;
+
+		if (node == numa_node_id())
+			continue;
+		iter_cpumask = mm_node_vcpumask(mm, node);
+		if (cpumask_test_cpu(vcpu, iter_cpumask)) {
+			cpumask_clear_cpu(vcpu, iter_cpumask);
+			break;
+		}
+	}
+	cpumask_set_cpu(vcpu, node_cpumask);
+	schedstat_inc(rq->nr_vcpu_allocate_node_steal);
+end:
+	return vcpu;
+}
+
+static inline int mm_vcpu_first_node_vcpu(int node)
+{
+	int vcpu;
+
+	if (likely(nr_cpu_ids >= nr_node_ids))
+		return node;
+	vcpu = cpumask_first(cpumask_of_node(node));
+	if (vcpu >= nr_cpu_ids)
+		return -1;
+	return vcpu;
+}
+
+/*
+ * Single-threaded processes observe a mapping of vcpu_id->node_id where
+ * the vcpu_id returned corresponds to mm_vcpu_first_node_vcpu(). When going
+ * from single to multi-threaded, reserve this same mapping so it stays
+ * invariant.
+ */
+static inline void mm_vcpu_reserve_nodes(struct mm_struct *mm)
+{
+	struct cpumask *node_alloc_cpumask = mm_node_alloc_vcpumask(mm);
+	int node, other_node;
+
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask = mm_node_vcpumask(mm, node);
+		int vcpu = mm_vcpu_first_node_vcpu(node);
+
+		/* Skip nodes that have no CPU associated with them. */
+		if (vcpu < 0)
+			continue;
+		cpumask_set_cpu(vcpu, iter_cpumask);
+		cpumask_set_cpu(vcpu, node_alloc_cpumask);
+		for (other_node = 0; other_node < nr_node_ids; other_node++) {
+			if (other_node == node)
+				continue;
+			cpumask_clear_cpu(vcpu, mm_node_vcpumask(mm, other_node));
+		}
+	}
+}
+#else
+static inline bool mm_node_vcpumask_test_cpu(struct mm_struct *mm, int vcpu_id)
+{
+	return true;
+}
+static inline int __mm_vcpu_get(struct rq *rq, struct mm_struct *mm)
+{
+	return __mm_vcpu_get_single_node(mm);
+}
+static inline int mm_vcpu_first_node_vcpu(int node)
+{
+	return 0;
+}
+static inline void mm_vcpu_reserve_nodes(struct mm_struct *mm) { }
+#endif
+
+static inline void __mm_vcpu_put(struct mm_struct *mm, int vcpu)
+{
+	if (vcpu < 0)
+		return;
+	cpumask_clear_cpu(vcpu, mm_vcpumask(mm));
+}
+
+static inline struct rq_vcpu_entry *rq_vcpu_cache_lookup(struct rq *rq, struct mm_struct *mm)
+{
+	struct rq_vcpu_cache *vcpu_cache = &rq->vcpu_cache;
+	int i;
+
+	for (i = 0; i < RQ_VCPU_CACHE_SIZE; i++) {
+		struct rq_vcpu_entry *entry = &vcpu_cache->entry[i];
+
+		if (entry->mm == mm)
+			return entry;
+	}
+	return NULL;
+}
+
+/* Removal from cache simply leaves an unused hole. */
+static inline int rq_vcpu_cache_lookup_remove(struct rq *rq, struct mm_struct *mm)
+{
+	struct rq_vcpu_entry *entry = rq_vcpu_cache_lookup(rq, mm);
+
+	if (!entry)
+		return -1;
+	entry->mm = NULL;	/* Remove from cache */
+	return entry->vcpu_id;
+}
+
+static inline void rq_vcpu_cache_remove_mm_locked(struct rq *rq, struct mm_struct *mm,
+						  bool release_mm)
+{
+	int vcpu;
+
+	if (!mm)
+		return;
+	/*
+	 * Do not remove the cache entry for a runqueue that runs a task which
+	 * currently uses the target mm.
+	 */
+	if (!release_mm && rq->curr->mm == mm)
+		return;
+	vcpu = rq_vcpu_cache_lookup_remove(rq, mm);
+	if (vcpu < 0)
+		return;
+	if (release_mm)
+		schedstat_inc(rq->nr_vcpu_remove_release_mm);
+	else
+		schedstat_inc(rq->nr_vcpu_remove_migrate);
+	__mm_vcpu_put(mm, vcpu);
+}
+
+static inline void rq_vcpu_cache_remove_mm(struct rq *rq, struct mm_struct *mm,
+					   bool release_mm)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	rq_vcpu_cache_remove_mm_locked(rq, mm, release_mm);
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+/*
+ * Add at head, move head forward. Cheap LRU cache.
+ * Only need to clear the vcpu mask bit from its own mm_vcpumask(mm) when we
+ * overwrite an old entry from the cache. Note that this is not needed if the
+ * overwritten entry is an unused hole. This access to the old_mm from an
+ * unrelated thread requires that cache entry for a given mm gets pruned from
+ * the cache when a task is dequeued from the runqueue.
+ */
+static inline void rq_vcpu_cache_add(struct rq *rq, struct mm_struct *mm,
+				     int vcpu_id)
+{
+	struct rq_vcpu_cache *vcpu_cache = &rq->vcpu_cache;
+	struct mm_struct *old_mm;
+	struct rq_vcpu_entry *entry;
+	unsigned int pos;
+
+	pos = vcpu_cache->head;
+	entry = &vcpu_cache->entry[pos];
+	old_mm = entry->mm;
+	if (old_mm) {
+		schedstat_inc(rq->nr_vcpu_cache_evict);
+		__mm_vcpu_put(old_mm, entry->vcpu_id);
+	}
+	entry->mm = mm;
+	entry->vcpu_id = vcpu_id;
+	vcpu_cache->head = (pos + 1) % RQ_VCPU_CACHE_SIZE;
+}
+
+static inline int mm_vcpu_get(struct rq *rq, struct task_struct *t)
+{
+	struct rq_vcpu_entry *entry;
+	struct mm_struct *mm = t->mm;
+	int vcpu;
+
+	/* Skip allocation if mm is single-threaded. */
+	if (atomic_read(&mm->mm_vcpu_users) == 1) {
+		schedstat_inc(rq->nr_vcpu_single_thread);
+		vcpu = mm_vcpu_first_node_vcpu(numa_node_id());
+		goto end;
+	}
+	entry = rq_vcpu_cache_lookup(rq, mm);
+	if (likely(entry)) {
+		vcpu = entry->vcpu_id;
+		if (likely(mm_node_vcpumask_test_cpu(mm, vcpu))) {
+			schedstat_inc(rq->nr_vcpu_cache_hit);
+			goto end;
+		} else {
+			schedstat_inc(rq->nr_vcpu_cache_discard_wrong_node);
+			entry->mm = NULL;	/* Remove from cache */
+			__mm_vcpu_put(mm, vcpu);
+		}
+	}
+	schedstat_inc(rq->nr_vcpu_allocate);
+	vcpu = __mm_vcpu_get(rq, mm);
+	rq_vcpu_cache_add(rq, mm, vcpu);
+end:
+	return vcpu;
+}
+
+static inline void switch_mm_vcpu(struct rq *rq, struct task_struct *prev,
+				  struct task_struct *next)
+{
+	if (!(next->flags & PF_EXITING) && !(next->flags & PF_KTHREAD) &&
+	    next->mm && next->vcpu_mm_active) {
+		if (!(prev->flags & PF_EXITING) && !(prev->flags & PF_KTHREAD) &&
+				prev->mm == next->mm && prev->vcpu_mm_active &&
+				mm_node_vcpumask_test_cpu(next->mm, prev->mm_vcpu)) {
+			/*
+			 * Switching between threads with the same mm. Simply pass the
+			 * vcpu token along to the next thread.
+			 */
+			schedstat_inc(rq->nr_vcpu_thread_transfer);
+			next->mm_vcpu = prev->mm_vcpu;
+		} else {
+			next->mm_vcpu = mm_vcpu_get(rq, next);
+		}
+	}
+	if (!(prev->flags & PF_EXITING) && !(prev->flags & PF_KTHREAD) &&
+	    prev->mm && prev->vcpu_mm_active)
+		prev->mm_vcpu = -1;
+}
+
+#else
+static inline void switch_mm_vcpu(struct rq *rq, struct task_struct *prev,
+				  struct task_struct *next) { }
+static inline void rq_vcpu_cache_remove_mm_locked(struct rq *rq,
+						  struct mm_struct *mm,
+						  bool release_mm) { }
+static inline void rq_vcpu_cache_remove_mm(struct rq *rq, struct mm_struct *mm,
+						  bool release_mm) { }
+#endif
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 07dde2928c79..027d0caf2d14 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -134,12 +134,24 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq->nr_vcpu_single_thread,
+		    rq->nr_vcpu_thread_transfer,
+		    rq->nr_vcpu_cache_hit,
+		    rq->nr_vcpu_cache_evict,
+		    rq->nr_vcpu_cache_discard_wrong_node,
+		    rq->nr_vcpu_allocate,
+		    rq->nr_vcpu_allocate_node_reuse,
+		    rq->nr_vcpu_allocate_node_new,
+		    rq->nr_vcpu_allocate_node_rebalance,
+		    rq->nr_vcpu_allocate_node_steal,
+		    rq->nr_vcpu_remove_release_mm,
+		    rq->nr_vcpu_remove_migrate);
 
 		seq_printf(seq, "\n");
 
-- 
2.17.1

