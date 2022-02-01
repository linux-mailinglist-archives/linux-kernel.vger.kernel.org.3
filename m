Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F50A4A64FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbiBAT00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:26:26 -0500
Received: from mail.efficios.com ([167.114.26.124]:53264 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbiBAT0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:26:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DF04933F866;
        Tue,  1 Feb 2022 14:26:23 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zKDloQarj2oE; Tue,  1 Feb 2022 14:26:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DBB9033F8F9;
        Tue,  1 Feb 2022 14:26:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DBB9033F8F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643743582;
        bh=9E3Ighgjw9m12iC/P0bbBT1+B/3Uw1GcX37hKU7hT1E=;
        h=From:To:Date:Message-Id;
        b=SnSnJ7PLCjW4p/E1891s+36iyUFJrNU/OIwXrZZDfr39U0iTBEEpxH+DGOPR9R5GV
         DG+4u2YZNwN+RkiepmvRH4RqtyPF0Aijx4LTDquIbS90ErBme87YicjlCqgv3afLGV
         vc74L/VUveHGcofZH1HCeaA/QZnj0qHFXLogtATCcvCqnmyBNWu9G7mFW5xQWCb91D
         HBVrGRIBQgl+yE2xPuFIwpF3uNb4sf0wVGDRMGeytKuouWm6WzSXNzogoMweItC/Pw
         DFLEHpgnwSvMFmdA+ybJDWltaOb7e17fT/laVbvZ3HFo7AiAMioPFAeXOIvZBW5ENh
         6twK1NJIHaJVQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X-Sc6Y3AlOlp; Tue,  1 Feb 2022 14:26:22 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 5D4CF33FBA1;
        Tue,  1 Feb 2022 14:26:22 -0500 (EST)
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
Subject: [RFC PATCH 1/3] Introduce per thread group current virtual cpu id
Date:   Tue,  1 Feb 2022 14:25:38 -0500
Message-Id: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature allows the scheduler to expose a current virtual cpu id
to user-space. This virtual cpu id is within the possible cpus range,
and is temporarily (and uniquely) assigned while threads are actively
running within a thread group. If a thread group has fewer threads than
cores, or is limited to run on few cores concurrently through sched
affinity or cgroup cpusets, the virtual cpu ids will be values close
to 0, thus allowing efficient use of user-space memory for per-cpu
data structures.

This feature is meant to be exposed by a new rseq thread area field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 fs/exec.c                    |  4 +++
 include/linux/sched.h        |  4 +++
 include/linux/sched/signal.h | 49 ++++++++++++++++++++++++++++++++++++
 init/Kconfig                 | 14 +++++++++++
 kernel/sched/core.c          |  2 ++
 5 files changed, 73 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..bc9a8c5f17f4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1153,6 +1153,10 @@ static int de_thread(struct task_struct *tsk)
 	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
+	/* Release possibly high vcpu id, get vcpu id 0. */
+	tg_vcpu_put(tsk);
+	tg_vcpu_get(tsk);
+
 no_thread_group:
 	/* we have changed execution domain */
 	tsk->exit_signal = SIGCHLD;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 838c9e0b4cae..0f199daed26a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1300,6 +1300,10 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_SCHED_THREAD_GROUP_VCPU
+	int				tg_vcpu;	/* Current vcpu in thread group */
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b6ecb9fc4cd2..c87e7ad5a1ea 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -244,6 +244,12 @@ struct signal_struct {
 						 * and may have inconsistent
 						 * permissions.
 						 */
+#ifdef CONFIG_SCHED_THREAD_GROUP_VCPU
+	/*
+	 * Mask of allocated vcpu ids within the thread group.
+	 */
+	cpumask_t			vcpu_mask;
+#endif
 } __randomize_layout;
 
 /*
@@ -742,4 +748,47 @@ static inline unsigned long rlimit_max(unsigned int limit)
 	return task_rlimit_max(current, limit);
 }
 
+#ifdef CONFIG_SCHED_THREAD_GROUP_VCPU
+static inline void tg_vcpu_get(struct task_struct *t)
+{
+	struct cpumask *cpumask = &t->signal->vcpu_mask;
+	unsigned int vcpu;
+
+	if (t->flags & PF_KTHREAD)
+		return;
+	/* Atomically reserve lowest available vcpu number. */
+	do {
+		vcpu = cpumask_first_zero(cpumask);
+		WARN_ON_ONCE(vcpu >= nr_cpu_ids);
+	} while (cpumask_test_and_set_cpu(vcpu, cpumask));
+	t->tg_vcpu = vcpu;
+}
+
+static inline void tg_vcpu_put(struct task_struct *t)
+{
+	if (t->flags & PF_KTHREAD)
+		return;
+	cpumask_clear_cpu(t->tg_vcpu, &t->signal->vcpu_mask);
+	t->tg_vcpu = 0;
+}
+
+static inline int task_tg_vcpu_id(struct task_struct *t)
+{
+	return t->tg_vcpu;
+}
+#else
+static inline void tg_vcpu_get(struct task_struct *t) { }
+static inline void tg_vcpu_put(struct task_struct *t) { }
+static inline int task_tg_vcpu_id(struct task_struct *t)
+{
+	/*
+	 * Use the processor id as a fall-back when the thread group vcpu
+	 * feature is disabled. This provides functional per-cpu data structure
+	 * accesses in user-space, althrough it won't provide the memory usage
+	 * benefits.
+	 */
+	return raw_smp_processor_id();
+}
+#endif
+
 #endif /* _LINUX_SCHED_SIGNAL_H */
diff --git a/init/Kconfig b/init/Kconfig
index e9119bf54b1f..5f72b4212a33 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1023,6 +1023,20 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config SCHED_THREAD_GROUP_VCPU
+	bool "Provide per-thread-group virtual cpu id"
+	depends on SMP
+	default n
+	help
+	  This feature allows the scheduler to expose a current virtual cpu id
+	  to user-space. This virtual cpu id is within the possible cpus range,
+	  and is temporarily (and uniquely) assigned while threads are actively
+	  running within a thread group. If a thread group has fewer threads than
+	  cores, or is limited to run on few cores concurrently through sched
+	  affinity or cgroup cpusets, the virtual cpu ids will be values close
+	  to 0, thus allowing efficient use of user-space memory for per-cpu
+	  data structures.
+
 config UCLAMP_TASK_GROUP
 	bool "Utilization clamping per group of tasks"
 	depends on CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00e52d1..2690e80977b1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4795,6 +4795,8 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
+	tg_vcpu_put(prev);
+	tg_vcpu_get(next);
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
-- 
2.17.1

