Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16F4BE9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiBURkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:40:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiBURjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:39:21 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F31DA6A;
        Mon, 21 Feb 2022 09:38:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 459DC3DFFF2;
        Mon, 21 Feb 2022 12:38:53 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sut4Foijx8m4; Mon, 21 Feb 2022 12:38:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3A3D83DFFEF;
        Mon, 21 Feb 2022 12:38:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3A3D83DFFEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645465131;
        bh=/vBepRrgje6EIGD/jBiFiCOltPYNl0HXibl5cbEAHIA=;
        h=From:To:Date:Message-Id;
        b=hMWqmm9SqxJYv1+nR/O57p5VS/Qb8Q4yjdNnyND8ilZRq907PzOUdqb2ByrtKbRYr
         PlNb1Wvd/Wj5YMV1c0lUtHtz3U25lLFDiOD1dIcT2oyIsWKpnpBa1l1C51g9mqcJpL
         M+0qxCzs+KTFf/FJ7JuhL0Tag/MZjAix4uq1IpAaOBhX+/iRpEb7zpgL7Yhmgn20qr
         w2W5pNf7NNiL1xgbmZ1FmqhlTtXgBVnglnUP+NIxiuI9B+HD/2FI7y7zYWnA1tguEl
         8c3M0Ty1cPGaMb2XDFj/dToJ2yA6ppq2epvd/vpFCUhCUBmSYNodtxSLzgEzNJzg+z
         MhJWzB76J+Y8Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v0XJzPgYYXXg; Mon, 21 Feb 2022 12:38:51 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id AA1B73DFD51;
        Mon, 21 Feb 2022 12:38:50 -0500 (EST)
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
Subject: [RFC PATCH v3 09/11] sched: Introduce per memory space current virtual cpu id
Date:   Mon, 21 Feb 2022 12:38:33 -0500
Message-Id: <20220221173833.24656-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218210633.23345-10-mathieu.desnoyers@efficios.com>
References: <20220218210633.23345-10-mathieu.desnoyers@efficios.com>
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
it that Google have been running a rseq vcpu_id extension internally in
production for a year. The tcmalloc source code indeed has comments
hinting at a vcpu_id prototype extension to the rseq system call [1].

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
Changes since v2:
- Fix a race between migration and release_mm, leading to a mm pointer
  leak in the runqueue vcpu cache: clearing the cache on migration
  should validate that the target mm in not the current mm on the target
  runqueue _and_ that the current task on that runqueue it not exiting
  or half-way through exec.
- Introduce struct vcpu_domain to encapsulate the the cpumasks and user
  count. This will make it easier to use this from pid namespaces as
  well in the future.
- Add next_vm_vcpu field to sched_switch tracepoint.
---
 fs/exec.c                    |   3 +
 include/linux/mm.h           |  40 ++++
 include/linux/mm_types.h     |   1 +
 include/linux/sched.h        |   5 +
 include/linux/vcpu.h         |  80 ++++++++
 include/linux/vcpu_types.h   |  28 +++
 include/trace/events/sched.h |   7 +-
 init/Kconfig                 |   4 +
 kernel/fork.c                |  13 +-
 kernel/sched/core.c          |  83 ++++++++
 kernel/sched/deadline.c      |   3 +
 kernel/sched/debug.c         |  13 ++
 kernel/sched/fair.c          |   1 +
 kernel/sched/rt.c            |   2 +
 kernel/sched/sched.h         | 375 +++++++++++++++++++++++++++++++++++
 kernel/sched/stats.c         |  16 +-
 16 files changed, 669 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/vcpu.h
 create mode 100644 include/linux/vcpu_types.h

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..4c562fa13332 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -66,6 +66,7 @@
 #include <linux/io_uring.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/coredump.h>
+#include <linux/vcpu.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1006,6 +1007,8 @@ static int exec_mmap(struct mm_struct *mm)
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
 	tsk->mm = mm;
+	vcpu_domain_init(mm_vcpu_domain(mm));
+	vcpu_domain_activate(tsk, mm_vcpu_domain(mm));
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1a84b1e6787..9d44d64cbc7c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3374,5 +3374,45 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
+#ifdef CONFIG_VCPU_DOMAIN
+static inline struct vcpu_domain *mm_vcpu_domain(struct mm_struct *mm)
+{
+	unsigned long vcpu_bitmap = (unsigned long)mm;
+
+	if (!mm)
+		return NULL;
+	vcpu_bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	/* Skip cpu_bitmap */
+	vcpu_bitmap += cpumask_size();
+	return (struct vcpu_domain *)vcpu_bitmap;
+}
+void vcpu_domain_release(struct task_struct *t, struct vcpu_domain *domain);
+void vcpu_domain_activate(struct task_struct *t, struct vcpu_domain *domain);
+void vcpu_domain_get(struct task_struct *t, struct vcpu_domain *domain);
+void vcpu_domain_dup(struct task_struct *t, struct vcpu_domain *domain);
+static inline int task_mm_vcpu_id(struct task_struct *t)
+{
+	return t->mm_vcpu;
+}
+#else
+static inline struct vcpu_domain *mm_vcpu_domain(struct mm_struct *mm)
+{
+	return NULL;
+}
+void vcpu_domain_release(struct task_struct *t, struct vcpu_domain *domain) { }
+void vcpu_domain_activate(struct task_struct *t, struct vcpu_domain *domain) { }
+void vcpu_domain_get(struct task_struct *t, struct vcpu_domain *domain) { }
+void vcpu_domain_dup(struct task_struct *t, struct vcpu_domain *domain) { }
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
index 9db36dc5d4cf..ef23400aee51 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -17,6 +17,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
+#include <linux/nodemask.h>
 
 #include <asm/mmu.h>
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 838c9e0b4cae..96df9e3fc7af 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1300,6 +1300,11 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_VCPU_DOMAIN
+	int				mm_vcpu;	/* Current vcpu in mm */
+	int				vcpu_domain_active;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
diff --git a/include/linux/vcpu.h b/include/linux/vcpu.h
new file mode 100644
index 000000000000..252fc7573025
--- /dev/null
+++ b/include/linux/vcpu.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VCPU_H
+#define _LINUX_VCPU_H
+
+#include <linux/cpumask.h>
+#include <linux/nodemask.h>
+#include <linux/vcpu_types.h>
+
+#ifdef CONFIG_VCPU_DOMAIN
+static inline unsigned int vcpu_domain_vcpumask_size(void)
+{
+	return cpumask_size();
+}
+static inline cpumask_t *vcpu_domain_vcpumask(struct vcpu_domain *vcpu_domain)
+{
+	return vcpu_domain->vcpumasks;
+}
+
+# ifdef CONFIG_NUMA
+static inline unsigned int vcpu_domain_node_vcpumask_size(void)
+{
+	if (num_possible_nodes() == 1)
+		return 0;
+	return (nr_node_ids + 1) * cpumask_size();
+}
+static inline cpumask_t *vcpu_domain_node_alloc_vcpumask(struct vcpu_domain *vcpu_domain)
+{
+	unsigned long vcpu_bitmap = (unsigned long)vcpu_domain_vcpumask(vcpu_domain);
+
+	/* Skip vcpumask */
+	vcpu_bitmap += cpumask_size();
+	return (struct cpumask *)vcpu_bitmap;
+}
+static inline cpumask_t *vcpu_domain_node_vcpumask(struct vcpu_domain *vcpu_domain, unsigned int node)
+{
+	unsigned long vcpu_bitmap = (unsigned long)vcpu_domain_node_alloc_vcpumask(vcpu_domain);
+
+	/* Skip node alloc vcpumask */
+	vcpu_bitmap += cpumask_size();
+	vcpu_bitmap += node * cpumask_size();
+	return (struct cpumask *)vcpu_bitmap;
+}
+static inline void vcpu_domain_node_init(struct vcpu_domain *vcpu_domain)
+{
+	unsigned int node;
+
+	if (num_possible_nodes() == 1)
+		return;
+	cpumask_clear(vcpu_domain_node_alloc_vcpumask(vcpu_domain));
+	for (node = 0; node < nr_node_ids; node++)
+		cpumask_clear(vcpu_domain_node_vcpumask(vcpu_domain, node));
+}
+# else /* CONFIG_NUMA */
+static inline unsigned int vcpu_domain_node_vcpumask_size(void)
+{
+	return 0;
+}
+static inline void vcpu_domain_node_init(struct vcpu_domain *vcpu_domain) { }
+# endif /* CONFIG_NUMA */
+
+static inline unsigned int vcpu_domain_size(void)
+{
+	return offsetof(struct vcpu_domain, vcpumasks) + vcpu_domain_vcpumask_size() +
+	       vcpu_domain_node_vcpumask_size();
+}
+static inline void vcpu_domain_init(struct vcpu_domain *vcpu_domain)
+{
+	atomic_set(&vcpu_domain->users, 1);
+	cpumask_clear(vcpu_domain_vcpumask(vcpu_domain));
+	vcpu_domain_node_init(vcpu_domain);
+}
+#else /* CONFIG_VCPU_DOMAIN */
+static inline unsigned int vcpu_domain_size(void)
+{
+	return 0;
+}
+static inline void vcpu_domain_init(struct vcpu_domain *vcpu_domain) { }
+#endif /* CONFIG_VCPU_DOMAIN */
+
+#endif /* _LINUX_VCPU_H */
diff --git a/include/linux/vcpu_types.h b/include/linux/vcpu_types.h
new file mode 100644
index 000000000000..36e520c4e287
--- /dev/null
+++ b/include/linux/vcpu_types.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VCPU_TYPES_H
+#define _LINUX_VCPU_TYPES_H
+
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
+
+struct vcpu_domain {
+	/**
+	 * @users: The number of references to &struct vcpu_domain from
+	 * user-space threads.
+	 *
+	 * Initialized to 1 for the first thread with a reference with
+	 * the domain. Incremented for each thread getting a reference to the
+	 * domain, and decremented on domain release from user-space threads.
+	 * Used to enable single-threaded domain vcpu accounting (when == 1).
+	 */
+	atomic_t users;
+	/*
+	 * Layout of vcpumasks:
+	 * - vcpumask (cpumask_size()),
+	 * - node_alloc_vcpumask (cpumask_size(), NUMA=y only),
+	 * - array of nr_node_ids node_vcpumask (each cpumask_size(), NUMA=y only).
+	 */
+	cpumask_t vcpumasks[];
+};
+
+#endif /* _LINUX_VCPU_TYPES_H */
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 94640482cfe7..050cb749ca1a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -233,6 +233,7 @@ TRACE_EVENT(sched_switch,
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
 		__field(	int,	next_prio			)
+		__field(	pid_t,	next_vm_vcpu			)
 	),
 
 	TP_fast_assign(
@@ -243,10 +244,11 @@ TRACE_EVENT(sched_switch,
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
+		__entry->next_vm_vcpu	= task_mm_vcpu_id(next);
 		/* XXX SCHED_DEADLINE */
 	),
 
-	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
+	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_vm_vcpu=%d",
 		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
 
 		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
@@ -262,7 +264,8 @@ TRACE_EVENT(sched_switch,
 		  "R",
 
 		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
-		__entry->next_comm, __entry->next_pid, __entry->next_prio)
+		__entry->next_comm, __entry->next_pid, __entry->next_prio,
+		__entry->next_vm_vcpu)
 );
 
 /*
diff --git a/init/Kconfig b/init/Kconfig
index e9119bf54b1f..8d504675d3a3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1023,6 +1023,10 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config VCPU_DOMAIN
+	def_bool y
+	depends on SMP && RSEQ
+
 config UCLAMP_TASK_GROUP
 	bool "Utilization clamping per group of tasks"
 	depends on CGROUP_SCHED
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..97bc7dcadafe 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/vcpu.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -970,6 +971,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
+
+#ifdef CONFIG_VCPU_DOMAIN
+	tsk->mm_vcpu = 0;
+	tsk->vcpu_domain_active = 0;
+#endif
 	return tsk;
 
 free_stack:
@@ -1079,6 +1085,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 		goto fail_nocontext;
 
 	mm->user_ns = get_user_ns(user_ns);
+	vcpu_domain_init(mm_vcpu_domain(mm));
 	return mm;
 
 fail_nocontext:
@@ -1380,6 +1387,8 @@ static int wait_for_vfork_done(struct task_struct *child,
  */
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
+	vcpu_domain_release(tsk, mm_vcpu_domain(mm));
+
 	uprobe_free_utask(tsk);
 
 	/* Get rid of any cached register state */
@@ -1499,10 +1508,12 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm = oldmm;
+		vcpu_domain_get(tsk, mm_vcpu_domain(mm));
 	} else {
 		mm = dup_mm(tsk, current->mm);
 		if (!mm)
 			return -ENOMEM;
+		vcpu_domain_dup(tsk, mm_vcpu_domain(mm));
 	}
 
 	tsk->mm = mm;
@@ -2901,7 +2912,7 @@ void __init proc_caches_init(void)
 	 * dynamically sized based on the maximum CPU number this system
 	 * can have, taking hotplug into account (nr_cpu_ids).
 	 */
-	mm_size = sizeof(struct mm_struct) + cpumask_size();
+	mm_size = sizeof(struct mm_struct) + cpumask_size() + vcpu_domain_size();
 
 	mm_cachep = kmem_cache_create_usercopy("mm_struct",
 			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1e08b02e0cd5..3894822d548a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -16,6 +16,7 @@
 #include <linux/blkdev.h>
 #include <linux/kcov.h>
 #include <linux/scs.h>
+#include <linux/vcpu.h>
 
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
@@ -2267,6 +2268,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 	lockdep_assert_rq_held(rq);
 
 	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
+	rq_vcpu_domain_migrate_locked(rq, p);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
 
@@ -2454,6 +2456,7 @@ int push_cpu_stop(void *arg)
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
 		deactivate_task(rq, p, 0);
+		rq_vcpu_domain_migrate_locked(rq, p);
 		set_task_cpu(p, lowest_rq->cpu);
 		activate_task(lowest_rq, p, 0);
 		resched_curr(lowest_rq);
@@ -3093,6 +3096,7 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
 		rq_pin_lock(dst_rq, &drf);
 
 		deactivate_task(src_rq, p, 0);
+		rq_vcpu_domain_migrate_locked(src_rq, p);
 		set_task_cpu(p, cpu);
 		activate_task(dst_rq, p, 0);
 		check_preempt_curr(dst_rq, p, 0);
@@ -3716,6 +3720,8 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
+	if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
+		rq_vcpu_domain_migrate_locked(task_rq(p), p);
 	__smp_call_single_queue(cpu, &p->wake_entry.llist);
 }
 
@@ -4125,6 +4131,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
+		rq_vcpu_domain_migrate(task_rq(p), p);
 		set_task_cpu(p, cpu);
 	}
 #else
@@ -4796,6 +4803,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
+	switch_mm_vcpu(rq, prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
@@ -5922,6 +5930,7 @@ static bool try_steal_cookie(int this, int that)
 			goto next;
 
 		deactivate_task(src, p, 0);
+		rq_vcpu_domain_migrate_locked(src, p);
 		set_task_cpu(p, this);
 		activate_task(dst, p, 0);
 
@@ -10927,3 +10936,77 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
+
+#ifdef CONFIG_VCPU_DOMAIN
+void vcpu_domain_release(struct task_struct *t, struct vcpu_domain *vcpu_domain)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (!vcpu_domain)
+		return;
+	WARN_ON_ONCE(t != current);
+	preempt_disable();
+	rq = this_rq();
+	rq_lock_irqsave(rq, &rf);
+	t->vcpu_domain_active = 0;
+	atomic_dec(&vcpu_domain->users);
+	rq_vcpu_cache_remove_vcpu_domain_locked(rq, vcpu_domain, true);
+	rq_unlock_irqrestore(rq, &rf);
+	t->mm_vcpu = -1;
+	preempt_enable();
+}
+
+void vcpu_domain_activate(struct task_struct *t, struct vcpu_domain *vcpu_domain)
+{
+	WARN_ON_ONCE(t != current);
+	preempt_disable();
+	t->vcpu_domain_active = 1;
+	/* No need to reserve in cpumask because single-threaded. */
+	t->mm_vcpu = vcpu_domain_vcpu_first_node_vcpu(numa_node_id());
+	preempt_enable();
+}
+
+void vcpu_domain_get(struct task_struct *t, struct vcpu_domain *vcpu_domain)
+{
+	int vcpu, vcpu_users;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	preempt_disable();
+	rq = this_rq();
+	t->vcpu_domain_active = 1;
+	vcpu_users = atomic_read(&vcpu_domain->users);
+	atomic_inc(&vcpu_domain->users);
+	t->mm_vcpu = -1;
+	vcpu = current->mm_vcpu;
+	rq_lock_irqsave(rq, &rf);
+	/* On transition from 1 to 2 vcpu domain users, reserve vcpu ids. */
+	if (vcpu_users == 1) {
+		vcpu_domain_vcpu_reserve_nodes(vcpu_domain);
+		rq_vcpu_cache_remove_vcpu_domain_locked(rq, vcpu_domain, true);
+		current->mm_vcpu = __vcpu_domain_vcpu_get(rq, vcpu_domain);
+		rq_vcpu_cache_add(rq, vcpu_domain, current->mm_vcpu);
+		/*
+		 * __vcpu_domain_vcpu_get could get a different vcpu after
+		 * going multi-threaded, then back single-threaded, then
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
+void vcpu_domain_dup(struct task_struct *t, struct vcpu_domain *vcpu_domain)
+{
+	preempt_disable();
+	t->vcpu_domain_active = 1;
+	t->mm_vcpu = -1;
+	preempt_enable();
+}
+#endif
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b0ef01..056933d83469 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -655,6 +655,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
 	raw_spin_unlock(&dl_b->lock);
 
+	rq_vcpu_domain_migrate_locked(rq, p);
 	set_task_cpu(p, later_rq->cpu);
 	double_unlock_balance(later_rq, rq);
 
@@ -2290,6 +2291,7 @@ static int push_dl_task(struct rq *rq)
 	}
 
 	deactivate_task(rq, next_task, 0);
+	rq_vcpu_domain_migrate_locked(rq, next_task);
 	set_task_cpu(next_task, later_rq->cpu);
 
 	/*
@@ -2386,6 +2388,7 @@ static void pull_dl_task(struct rq *this_rq)
 				push_task = get_push_task(src_rq);
 			} else {
 				deactivate_task(src_rq, p, 0);
+				rq_vcpu_domain_migrate_locked(src_rq, p);
 				set_task_cpu(p, this_cpu);
 				activate_task(this_rq, p, 0);
 				dmin = p->dl.deadline;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 102d6f70e84d..0b30946de2a4 100644
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
+		P(nr_vcpu_remove_release);
+		P(nr_vcpu_remove_migrate);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dcbd3110c687..c43d97c79237 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7817,6 +7817,7 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 	lockdep_assert_rq_held(env->src_rq);
 
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
+	rq_vcpu_domain_migrate_locked(env->src_rq, p);
 	set_task_cpu(p, env->dst_cpu);
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fbbb404..4922a87d5527 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2106,6 +2106,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	}
 
 	deactivate_task(rq, next_task, 0);
+	rq_vcpu_domain_migrate_locked(rq, next_task);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
 	resched_curr(lowest_rq);
@@ -2379,6 +2380,7 @@ static void pull_rt_task(struct rq *this_rq)
 				push_task = get_push_task(src_rq);
 			} else {
 				deactivate_task(src_rq, p, 0);
+				rq_vcpu_domain_migrate_locked(src_rq, p);
 				set_task_cpu(p, this_cpu);
 				activate_task(this_rq, p, 0);
 				resched = true;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3da5718cd641..abdd48d1ffe6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -66,6 +66,7 @@
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
 #include <linux/tsacct_kern.h>
+#include <linux/vcpu.h>
 
 #include <asm/tlb.h>
 
@@ -916,6 +917,19 @@ struct uclamp_rq {
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
+#ifdef CONFIG_VCPU_DOMAIN
+# define RQ_VCPU_CACHE_SIZE	8
+struct rq_vcpu_entry {
+	struct vcpu_domain *vcpu_domain;	/* NULL if unset */
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
@@ -1086,6 +1100,19 @@ struct rq {
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
+	unsigned long long	nr_vcpu_remove_release;
+	unsigned long long	nr_vcpu_remove_migrate;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
@@ -1116,6 +1143,10 @@ struct rq {
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
+
+#ifdef CONFIG_VCPU_DOMAIN
+	struct rq_vcpu_cache	vcpu_cache;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -3137,3 +3168,347 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+#ifdef CONFIG_VCPU_DOMAIN
+static inline int __vcpu_domain_vcpu_get_single_node(struct vcpu_domain *vcpu_domain)
+{
+	struct cpumask *cpumask;
+	int vcpu;
+
+	cpumask = vcpu_domain_vcpumask(vcpu_domain);
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
+static inline bool vcpu_domain_node_vcpumask_test_cpu(struct vcpu_domain *vcpu_domain, int vcpu_id)
+{
+	if (num_possible_nodes() == 1)
+		return true;
+	return cpumask_test_cpu(vcpu_id, vcpu_domain_node_vcpumask(vcpu_domain, numa_node_id()));
+}
+
+static inline int __vcpu_domain_vcpu_get(struct rq *rq, struct vcpu_domain *vcpu_domain)
+{
+	struct cpumask *cpumask = vcpu_domain_vcpumask(vcpu_domain),
+		       *node_cpumask = vcpu_domain_node_vcpumask(vcpu_domain, numa_node_id()),
+		       *node_alloc_cpumask = vcpu_domain_node_alloc_vcpumask(vcpu_domain);
+	unsigned int node;
+	int vcpu;
+
+	if (num_possible_nodes() == 1)
+		return __vcpu_domain_vcpu_get_single_node(vcpu_domain);
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
+		iter_cpumask = vcpu_domain_node_vcpumask(vcpu_domain, node);
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
+		iter_cpumask = vcpu_domain_node_vcpumask(vcpu_domain, node);
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
+static inline int vcpu_domain_vcpu_first_node_vcpu(int node)
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
+ * the vcpu_id returned corresponds to vcpu_domain_vcpu_first_node_vcpu(). When going
+ * from single to multi-threaded, reserve this same mapping so it stays
+ * invariant.
+ */
+static inline void vcpu_domain_vcpu_reserve_nodes(struct vcpu_domain *vcpu_domain)
+{
+	struct cpumask *node_alloc_cpumask = vcpu_domain_node_alloc_vcpumask(vcpu_domain);
+	int node, other_node;
+
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask = vcpu_domain_node_vcpumask(vcpu_domain, node);
+		int vcpu = vcpu_domain_vcpu_first_node_vcpu(node);
+
+		/* Skip nodes that have no CPU associated with them. */
+		if (vcpu < 0)
+			continue;
+		cpumask_set_cpu(vcpu, iter_cpumask);
+		cpumask_set_cpu(vcpu, node_alloc_cpumask);
+		for (other_node = 0; other_node < nr_node_ids; other_node++) {
+			if (other_node == node)
+				continue;
+			cpumask_clear_cpu(vcpu, vcpu_domain_node_vcpumask(vcpu_domain, other_node));
+		}
+	}
+}
+#else
+static inline bool vcpu_domain_node_vcpumask_test_cpu(struct vcpu_domain *vcpu_domain,
+						      int vcpu_id)
+{
+	return true;
+}
+static inline int __vcpu_domain_vcpu_get(struct rq *rq, struct vcpu_domain *vcpu_domain)
+{
+	return __vcpu_domain_vcpu_get_single_node(vcpu_domain);
+}
+static inline int vcpu_domain_vcpu_first_node_vcpu(int node)
+{
+	return 0;
+}
+static inline void vcpu_domain_vcpu_reserve_nodes(struct vcpu_domain *vcpu_domain) { }
+#endif
+
+static inline void __vcpu_domain_vcpu_put(struct vcpu_domain *vcpu_domain, int vcpu)
+{
+	if (vcpu < 0)
+		return;
+	cpumask_clear_cpu(vcpu, vcpu_domain_vcpumask(vcpu_domain));
+}
+
+static inline struct rq_vcpu_entry *rq_vcpu_cache_lookup(struct rq *rq, struct vcpu_domain *vcpu_domain)
+{
+	struct rq_vcpu_cache *vcpu_cache = &rq->vcpu_cache;
+	int i;
+
+	for (i = 0; i < RQ_VCPU_CACHE_SIZE; i++) {
+		struct rq_vcpu_entry *entry = &vcpu_cache->entry[i];
+
+		if (entry->vcpu_domain == vcpu_domain)
+			return entry;
+	}
+	return NULL;
+}
+
+/* Removal from cache simply leaves an unused hole. */
+static inline int rq_vcpu_cache_lookup_remove(struct rq *rq, struct vcpu_domain *vcpu_domain)
+{
+	struct rq_vcpu_entry *entry = rq_vcpu_cache_lookup(rq, vcpu_domain);
+
+	if (!entry)
+		return -1;
+	entry->vcpu_domain = NULL;	/* Remove from cache */
+	return entry->vcpu_id;
+}
+
+static inline void rq_vcpu_cache_remove_vcpu_domain_locked(struct rq *rq, struct vcpu_domain *vcpu_domain,
+							   bool release)
+{
+	int vcpu;
+
+	if (!vcpu_domain)
+		return;
+	/*
+	 * Do not remove the cache entry for a runqueue that runs a task which
+	 * currently uses the target mm.
+	 */
+	if (!release && rq->curr->vcpu_domain_active && mm_vcpu_domain(rq->curr->mm) == vcpu_domain)
+		return;
+	vcpu = rq_vcpu_cache_lookup_remove(rq, vcpu_domain);
+	if (vcpu < 0)
+		return;
+	if (release)
+		schedstat_inc(rq->nr_vcpu_remove_release);
+	else
+		schedstat_inc(rq->nr_vcpu_remove_migrate);
+	__vcpu_domain_vcpu_put(vcpu_domain, vcpu);
+}
+
+static inline void rq_vcpu_cache_remove_vcpu_domain(struct rq *rq, struct vcpu_domain *vcpu_domain,
+						    bool release)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	rq_vcpu_cache_remove_vcpu_domain_locked(rq, vcpu_domain, release);
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static inline void rq_vcpu_domain_migrate_locked(struct rq *rq, struct task_struct *t)
+{
+	rq_vcpu_cache_remove_vcpu_domain_locked(rq, mm_vcpu_domain(t->mm), false);
+}
+
+static inline void rq_vcpu_domain_migrate(struct rq *rq, struct task_struct *t)
+{
+	rq_vcpu_cache_remove_vcpu_domain(rq, mm_vcpu_domain(t->mm), false);
+}
+
+/*
+ * Add at head, move head forward. Cheap LRU cache.
+ * Only need to clear the vcpu mask bit from its own domain when we overwrite
+ * an old entry from the cache. Note that this is not needed if the overwritten
+ * entry is an unused hole. This access to the old_vcpu_domain from an
+ * unrelated thread requires that cache entry for a given vcpu_domain gets
+ * pruned from the cache when a task is dequeued from the runqueue.
+ */
+static inline void rq_vcpu_cache_add(struct rq *rq, struct vcpu_domain *vcpu_domain,
+				     int vcpu_id)
+{
+	struct rq_vcpu_cache *vcpu_cache = &rq->vcpu_cache;
+	struct vcpu_domain *old_vcpu_domain;
+	struct rq_vcpu_entry *entry;
+	unsigned int pos;
+
+	pos = vcpu_cache->head;
+	entry = &vcpu_cache->entry[pos];
+	old_vcpu_domain = entry->vcpu_domain;
+	if (old_vcpu_domain) {
+		schedstat_inc(rq->nr_vcpu_cache_evict);
+		__vcpu_domain_vcpu_put(old_vcpu_domain, entry->vcpu_id);
+	}
+	entry->vcpu_domain = vcpu_domain;
+	entry->vcpu_id = vcpu_id;
+	vcpu_cache->head = (pos + 1) % RQ_VCPU_CACHE_SIZE;
+}
+
+static inline int vcpu_domain_vcpu_get(struct rq *rq, struct vcpu_domain *vcpu_domain)
+{
+	struct rq_vcpu_entry *entry;
+	int vcpu;
+
+	/* Skip allocation if mm is single-threaded. */
+	if (atomic_read(&vcpu_domain->users) == 1) {
+		schedstat_inc(rq->nr_vcpu_single_thread);
+		vcpu = vcpu_domain_vcpu_first_node_vcpu(numa_node_id());
+		goto end;
+	}
+	entry = rq_vcpu_cache_lookup(rq, vcpu_domain);
+	if (likely(entry)) {
+		vcpu = entry->vcpu_id;
+		if (likely(vcpu_domain_node_vcpumask_test_cpu(vcpu_domain, vcpu))) {
+			schedstat_inc(rq->nr_vcpu_cache_hit);
+			goto end;
+		} else {
+			schedstat_inc(rq->nr_vcpu_cache_discard_wrong_node);
+			entry->vcpu_domain = NULL;	/* Remove from cache */
+			__vcpu_domain_vcpu_put(vcpu_domain, vcpu);
+		}
+	}
+	schedstat_inc(rq->nr_vcpu_allocate);
+	vcpu = __vcpu_domain_vcpu_get(rq, vcpu_domain);
+	rq_vcpu_cache_add(rq, vcpu_domain, vcpu);
+end:
+	return vcpu;
+}
+
+static inline void switch_mm_vcpu(struct rq *rq, struct task_struct *prev,
+				  struct task_struct *next)
+{
+	if (!(next->flags & PF_KTHREAD) && next->vcpu_domain_active && next->mm) {
+		if (!(prev->flags & PF_KTHREAD) && prev->vcpu_domain_active &&
+		    prev->mm == next->mm &&
+		    vcpu_domain_node_vcpumask_test_cpu(mm_vcpu_domain(next->mm), prev->mm_vcpu)) {
+			/*
+			 * Switching between threads with the same mm. Simply pass the
+			 * vcpu token along to the next thread.
+			 */
+			schedstat_inc(rq->nr_vcpu_thread_transfer);
+			next->mm_vcpu = prev->mm_vcpu;
+		} else {
+			next->mm_vcpu = vcpu_domain_vcpu_get(rq, mm_vcpu_domain(next->mm));
+		}
+	}
+	if (!(prev->flags & PF_KTHREAD) && prev->vcpu_domain_active && prev->mm)
+		prev->mm_vcpu = -1;
+}
+
+#else
+static inline void switch_mm_vcpu(struct rq *rq, struct task_struct *prev,
+				  struct task_struct *next) { }
+static inline void rq_vcpu_cache_remove_vcpu_domain_locked(struct rq *rq,
+							   struct vcpu_domain *domain,
+							   bool release) { }
+static inline void rq_vcpu_cache_remove_vcpu_domain(struct rq *rq, struct vcpu_domain *domain,
+						    bool release) { }
+static inline void rq_vcpu_domain_migrate_locked(struct rq *rq, struct task_struct *t) { }
+static inline void rq_vcpu_domain_migrate(struct rq *rq, struct task_struct *t) { }
+#endif
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 07dde2928c79..a0bf4eaae296 100644
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
+		    rq->nr_vcpu_remove_release,
+		    rq->nr_vcpu_remove_migrate);
 
 		seq_printf(seq, "\n");
 
-- 
2.17.1



