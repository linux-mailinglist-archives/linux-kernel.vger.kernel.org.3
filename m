Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83EC497D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiAXKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiAXKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:53:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD270C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:53:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 634E3B80EF3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E6CC340EA;
        Mon, 24 Jan 2022 10:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643021584;
        bh=rjYcfivnXLMYloSB+GYd4XhVGaJkd4qwOtzVclJx7YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WE3WAmX+KG/sxElRQR+9R3/bW0UbN+8WVD0kpOWh5bt4G9Hflz7r3d4LI94uRaFLz
         VG/fIrZZNCK6FyGyMITAwSFkHwGdZDiKv4GNksHnrRg8Kf8/g1a52eROBcsVdT4AyJ
         DMQkbk788X1Tl2Lccn/MssA10QE3mVf9RIFNWNG5mbqlbsunaZ4LyIoxJnCyXyzsnR
         m8U+9NstvgwxdYC3QOgwcsCOp1N2QcX2PDbLTmvrcj1htnSa8fMmcvp6qfOE2BOG8z
         vQ5/iwYPxuYKZgztk/6YT6H4h69M7669Q7eZw46RQeF3mJj2+85L4mY0bOloa9AK+4
         u+3h1iVxm1mVw==
From:   Christian Brauner <brauner@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Peter Collingbourne <pcc@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Subject: [resend RFC 1/3] pid: introduce task_by_pid()
Date:   Mon, 24 Jan 2022 11:52:45 +0100
Message-Id: <20220124105247.2118990-2-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124105247.2118990-1-brauner@kernel.org>
References: <20220124105247.2118990-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11875; h=from:subject; bh=rjYcfivnXLMYloSB+GYd4XhVGaJkd4qwOtzVclJx7YQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS+a/mz/k3jp7+iFzlrLj5iOcH7PEDQO+VY+cO0HSw61Y35 D6pdO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSrMHwv6JhYbKr+MM5/Nd94s7kdY fONt2W9UtD+/PK2VH8e561f2D4K90WvSc/ONds1fkZ/7IftCg0mIhcY5exPJ+yzyphi0Q9OwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a lot of places that open code

if (who)
        p = find_task_by_vpid(who);
else
        p = current;

Introduce a simpler helper which can be used instead.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/mips/kernel/mips-mt-fpaff.c       | 14 ++-----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++-----------
 block/ioprio.c                         | 10 ++--------
 include/linux/sched.h                  |  7 +++++++
 kernel/cgroup/cgroup.c                 | 12 ++++--------
 kernel/events/core.c                   |  5 +----
 kernel/futex/syscalls.c                | 20 ++++++-------------
 kernel/pid.c                           |  5 +++++
 kernel/sched/core.c                    | 27 ++++++++------------------
 kernel/sched/core_sched.c              | 12 ++++--------
 kernel/sys.c                           | 12 +++---------
 mm/mempolicy.c                         |  2 +-
 12 files changed, 50 insertions(+), 95 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 67e130d3f038..53c8a56815ea 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -33,16 +33,6 @@ unsigned long mt_fpemul_threshold;
  * updated when kernel/sched/core.c changes.
  */
 
-/*
- * find_process_by_pid - find a process with a matching PID value.
- * used in sys_sched_set/getaffinity() in kernel/sched/core.c, so
- * cloned here.
- */
-static inline struct task_struct *find_process_by_pid(pid_t pid)
-{
-	return pid ? find_task_by_vpid(pid) : current;
-}
-
 /*
  * check the target process has a UID that matches the current process's
  */
@@ -79,7 +69,7 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	cpus_read_lock();
 	rcu_read_lock();
 
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p) {
 		rcu_read_unlock();
 		cpus_read_unlock();
@@ -170,7 +160,7 @@ asmlinkage long mipsmt_sys_sched_getaffinity(pid_t pid, unsigned int len,
 	rcu_read_lock();
 
 	retval = -ESRCH;
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p)
 		goto out_unlock;
 	retval = security_task_getscheduler(p);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b57b3db9a6a7..577d0ffebb9d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -660,19 +660,14 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
 	int ret;
 
 	rcu_read_lock();
-	if (pid) {
-		tsk = find_task_by_vpid(pid);
-		if (!tsk) {
-			rcu_read_unlock();
-			rdt_last_cmd_printf("No task %d\n", pid);
-			return -ESRCH;
-		}
-	} else {
-		tsk = current;
-	}
-
-	get_task_struct(tsk);
+	tsk = task_by_pid(pid);
+	if (tsk)
+		get_task_struct(tsk);
 	rcu_read_unlock();
+	if (!tsk) {
+		rdt_last_cmd_printf("No task %d\n", pid);
+		return -ESRCH;
+	}
 
 	ret = rdtgroup_task_write_permission(tsk, of);
 	if (!ret)
diff --git a/block/ioprio.c b/block/ioprio.c
index 2fe068fcaad5..934e96cd495b 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -81,10 +81,7 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 	rcu_read_lock();
 	switch (which) {
 		case IOPRIO_WHO_PROCESS:
-			if (!who)
-				p = current;
-			else
-				p = find_task_by_vpid(who);
+			p = task_by_pid(who);
 			if (p)
 				ret = set_task_ioprio(p, ioprio);
 			break;
@@ -176,10 +173,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 	rcu_read_lock();
 	switch (which) {
 		case IOPRIO_WHO_PROCESS:
-			if (!who)
-				p = current;
-			else
-				p = find_task_by_vpid(who);
+			p = task_by_pid(who);
 			if (p)
 				ret = get_task_ioprio(p);
 			break;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 508b91d57470..0408372594dd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1912,6 +1912,13 @@ extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
  */
 
 extern struct task_struct *find_task_by_vpid(pid_t nr);
+/**
+ * task_by_pid - find a process with a matching PID value.
+ * @pid: the pid in question.
+ *
+ * The task of @pid, if found. %NULL otherwise.
+ */
+extern struct task_struct *task_by_pid(pid_t nr);
 extern struct task_struct *find_task_by_pid_ns(pid_t nr, struct pid_namespace *ns);
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b31e1465868a..3fddd5003a2b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2839,14 +2839,10 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	}
 
 	rcu_read_lock();
-	if (pid) {
-		tsk = find_task_by_vpid(pid);
-		if (!tsk) {
-			tsk = ERR_PTR(-ESRCH);
-			goto out_unlock_threadgroup;
-		}
-	} else {
-		tsk = current;
+	tsk = task_by_pid(pid);
+	if (!tsk) {
+		tsk = ERR_PTR(-ESRCH);
+		goto out_unlock_threadgroup;
 	}
 
 	if (threadgroup)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc18664f49b0..9f9ea469f1d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4608,10 +4608,7 @@ find_lively_task_by_vpid(pid_t vpid)
 	struct task_struct *task;
 
 	rcu_read_lock();
-	if (!vpid)
-		task = current;
-	else
-		task = find_task_by_vpid(vpid);
+	task = task_by_pid(vpid);
 	if (task)
 		get_task_struct(task);
 	rcu_read_unlock();
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 086a22d1adb7..76b5c5389214 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -57,13 +57,9 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 	rcu_read_lock();
 
 	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
+	p = task_by_pid(pid);
+	if (!p)
+		goto err_unlock;
 
 	ret = -EPERM;
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
@@ -326,13 +322,9 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 	rcu_read_lock();
 
 	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
+	p = task_by_pid(pid);
+	if (!p)
+		goto err_unlock;
 
 	ret = -EPERM;
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
diff --git a/kernel/pid.c b/kernel/pid.c
index 2fc0a16ec77b..1cd82fa58273 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -422,6 +422,11 @@ struct task_struct *find_task_by_vpid(pid_t vnr)
 	return find_task_by_pid_ns(vnr, task_active_pid_ns(current));
 }
 
+struct task_struct *task_by_pid(pid_t nr)
+{
+	return nr ? find_task_by_vpid(nr) : current;
+}
+
 struct task_struct *find_get_task_by_vpid(pid_t nr)
 {
 	struct task_struct *task;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00e52d1..196543f0c39a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7174,17 +7174,6 @@ unsigned long sched_cpu_util(int cpu, unsigned long max)
 }
 #endif /* CONFIG_SMP */
 
-/**
- * find_process_by_pid - find a process with a matching PID value.
- * @pid: the pid in question.
- *
- * The task of @pid, if found. %NULL otherwise.
- */
-static struct task_struct *find_process_by_pid(pid_t pid)
-{
-	return pid ? find_task_by_vpid(pid) : current;
-}
-
 /*
  * sched_setparam() passes in -1 for its policy, to let the functions
  * it calls know not to change it.
@@ -7627,7 +7616,7 @@ do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 
 	rcu_read_lock();
 	retval = -ESRCH;
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (likely(p))
 		get_task_struct(p);
 	rcu_read_unlock();
@@ -7750,7 +7739,7 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 
 	rcu_read_lock();
 	retval = -ESRCH;
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (likely(p))
 		get_task_struct(p);
 	rcu_read_unlock();
@@ -7782,7 +7771,7 @@ SYSCALL_DEFINE1(sched_getscheduler, pid_t, pid)
 
 	retval = -ESRCH;
 	rcu_read_lock();
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (p) {
 		retval = security_task_getscheduler(p);
 		if (!retval)
@@ -7811,7 +7800,7 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
 		return -EINVAL;
 
 	rcu_read_lock();
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	retval = -ESRCH;
 	if (!p)
 		goto out_unlock;
@@ -7894,7 +7883,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		return -EINVAL;
 
 	rcu_read_lock();
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	retval = -ESRCH;
 	if (!p)
 		goto out_unlock;
@@ -8003,7 +7992,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 
 	rcu_read_lock();
 
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p) {
 		rcu_read_unlock();
 		return -ESRCH;
@@ -8082,7 +8071,7 @@ long sched_getaffinity(pid_t pid, struct cpumask *mask)
 	rcu_read_lock();
 
 	retval = -ESRCH;
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p)
 		goto out_unlock;
 
@@ -8482,7 +8471,7 @@ static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
 
 	retval = -ESRCH;
 	rcu_read_lock();
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p)
 		goto out_unlock;
 
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1fb45672ec85..0c40445337c5 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -148,14 +148,10 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 		return -EINVAL;
 
 	rcu_read_lock();
-	if (pid == 0) {
-		task = current;
-	} else {
-		task = find_task_by_vpid(pid);
-		if (!task) {
-			rcu_read_unlock();
-			return -ESRCH;
-		}
+	task = task_by_pid(pid);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
 	}
 	get_task_struct(task);
 	rcu_read_unlock();
diff --git a/kernel/sys.c b/kernel/sys.c
index ecc4cf019242..9460e2eefaad 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -222,10 +222,7 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 	rcu_read_lock();
 	switch (which) {
 	case PRIO_PROCESS:
-		if (who)
-			p = find_task_by_vpid(who);
-		else
-			p = current;
+		p = task_by_pid(who);
 		if (p)
 			error = set_one_prio(p, niceval, error);
 		break;
@@ -285,10 +282,7 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 	rcu_read_lock();
 	switch (which) {
 	case PRIO_PROCESS:
-		if (who)
-			p = find_task_by_vpid(who);
-		else
-			p = current;
+		p = task_by_pid(who);
 		if (p) {
 			niceval = nice_to_rlimit(task_nice(p));
 			if (niceval > retval)
@@ -1659,7 +1653,7 @@ SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
 	}
 
 	rcu_read_lock();
-	tsk = pid ? find_task_by_vpid(pid) : current;
+	tsk = task_by_pid(pid);
 	if (!tsk) {
 		rcu_read_unlock();
 		return -ESRCH;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 028e8dd82b44..c113e274204a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1613,7 +1613,7 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 
 	/* Find the mm_struct */
 	rcu_read_lock();
-	task = pid ? find_task_by_vpid(pid) : current;
+	task = task_by_pid(pid);
 	if (!task) {
 		rcu_read_unlock();
 		err = -ESRCH;
-- 
2.32.0

