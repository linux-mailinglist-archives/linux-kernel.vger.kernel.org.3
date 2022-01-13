Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B531D48E10C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiAMXkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbiAMXkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:40:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B30C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y10-20020a2586ca000000b006116aaeeee6so14461822ybm.21
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dz0tsg36BPE3seUqLZfpg1x7OYgvQMJbzgKuSruDbXI=;
        b=gK1KNTq0ywitzOYlfv29fSwqgMq8zUmc4ZgddtkYxvIfoVnWGaUuf1aDC1Di0QuVEy
         uN/G6pAYNZPBLOxjhmKSkNCQsf4Daspid/VFt3gXb+5+0heugJeiN+3jmqF30TgQESlD
         CvbNqHzX1aHB5C3YqoCrK8IMFphXlzNRsIXJ6n+h+rIpF7+Kh00yjRJwVS4ydj4pvPE1
         rjoerGWt+yGTjdFUSbRHl2kC3hks0iVTRaW5tmmY2/8vPXtUeSN6eW3I63rbEfH97i15
         RHSnyQZt4kozrS875pa2D3vxrimvaA0zCGVv89V29uzWrbW/IVRZd5MRRWVztzwRgLsI
         g1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dz0tsg36BPE3seUqLZfpg1x7OYgvQMJbzgKuSruDbXI=;
        b=vjUi+Gj1U73oxF1Am4ZnOsrVfnWx2vJdVhJtbRaaBBBRbp7Q0vdHPU8oANWt9WUQB1
         OaTfX4OhsWuPJDoL6jrjLIcAmruhsqCtCHL+rTs/WRgOlB8uAPe8m2z+w2JCngB+VIIU
         QLEyRSHDLMVQor3scaFhDnpuK85UJKxsBhnCUZhoM5e4FbW3IB4s+ITydSUGkGqizXxK
         /wBrY16obdTRiUGx+2Lghcm7NBaEjlvpJQ7UeLPyrLc0PlRbV7Gio+Wncs2Zn1hM6Gmn
         FvFHmQ9W3PWoga2/wSJhVIMbvxx9sK1wfZiyWb3rY+cx/YK/PIh2EaLpStP5Xb9JWfU7
         nPPQ==
X-Gm-Message-State: AOAM531UXOwPtEdvO4txq6ER5fwyoFnYDkdy4gdrVCM3ksGc0UMt8UMH
        I34bThLifXqbN297TRg3stMUrcy5
X-Google-Smtp-Source: ABdhPJx6Y2+cWOHE/DllE9CerzdeIUaZni8LNVS/NieNjzRhMbMXHKoMZnxVX+cF/w0gh2AXV4Tbkhis
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:c548:e79f:8954:121f])
 (user=posk job=sendgmr) by 2002:a05:6902:110:: with SMTP id
 o16mr9141584ybh.385.1642117209384; Thu, 13 Jan 2022 15:40:09 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:39:38 -0800
In-Reply-To: <20220113233940.3608440-1-posk@google.com>
Message-Id: <20220113233940.3608440-4-posk@google.com>
Mime-Version: 1.0
References: <20220113233940.3608440-1-posk@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [RFC PATCH v2 3/5] sched: User Mode Concurency Groups
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

User Managed Concurrency Groups is an M:N threading toolkit that allows
constructing user space schedulers designed to efficiently manage
heterogeneous in-process workloads while maintaining high CPU
utilization (95%+).

XXX moar changelog explaining how this is moar awesome than
traditional user-space threading.

The big thing that's missing is the SMP wake-to-remote-idle.

The big assumption this whole thing is build on is that
pin_user_pages() preserves user mappings in so far that
pagefault_disable() will never generate EFAULT (unless the user does
munmap() in which case it can keep the pieces).

shrink_page_list() does page_maybe_dma_pinned() before try_to_unmap()
and as such seems to respect this constraint.

unmap_and_move() however seems willing to unmap otherwise pinned (and
hence unmigratable) pages. This might need fixing.

Originally-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   3 +
 arch/x86/include/asm/thread_info.h     |   2 +
 fs/exec.c                              |   1 +
 include/linux/entry-common.h           |   6 +
 include/linux/sched.h                  |  86 +++
 include/linux/syscalls.h               |   4 +
 include/linux/thread_info.h            |   2 +
 include/uapi/asm-generic/unistd.h      |   9 +-
 include/uapi/linux/umcg.h              | 143 ++++
 init/Kconfig                           |  15 +
 kernel/entry/common.c                  |  18 +-
 kernel/exit.c                          |   5 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |   9 +-
 kernel/sched/umcg.c                    | 868 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   5 +
 17 files changed, 1171 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 976dd6b532bf..34a398f5a57b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -248,6 +248,7 @@ config X86
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UMCG			if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index fe8f8dd157b4..3d96af7e67cc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -371,6 +371,9 @@
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
+450	common	umcg_ctl		sys_umcg_ctl
+451	common	umcg_wait		sys_umcg_wait
+452	common	umcg_kick		sys_umcg_kick
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index ebec69c35e95..f480e43c8bdf 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_UMCG		6	/* UMCG return to user hook */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -107,6 +108,7 @@ struct thread_info {
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_UMCG		(1 << TIF_UMCG)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
diff --git a/fs/exec.c b/fs/exec.c
index 537d92c41105..1749f0f74fed 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1838,6 +1838,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	umcg_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..6318b0461cd2 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -22,6 +22,10 @@
 # define _TIF_UPROBE			(0)
 #endif
 
+#ifndef _TIF_UMCG
+# define _TIF_UMCG			(0)
+#endif
+
 /*
  * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
  */
@@ -42,11 +46,13 @@
 				 SYSCALL_WORK_SYSCALL_EMU |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_UMCG |		\
 				 ARCH_SYSCALL_WORK_ENTER)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_UMCG |		\
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cd3d9c2e864..6172594282ce 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -67,6 +67,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct umcg_task;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1294,6 +1295,23 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_UMCG
+	/* setup by sys_umcg_ctrl() */
+	clockid_t		umcg_clock;
+	struct umcg_task __user	*umcg_task;
+
+	/* setup by umcg_pin_enter() */
+	struct page		*umcg_worker_page;
+
+	struct task_struct	*umcg_server;
+	struct umcg_task __user *umcg_server_task;
+	struct page		*umcg_server_page;
+
+	struct task_struct	*umcg_next;
+	struct umcg_task __user	*umcg_next_task;
+	struct page		*umcg_next_page;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
@@ -1687,6 +1705,13 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+
+#ifdef CONFIG_UMCG
+#define PF_UMCG_WORKER		0x01000000	/* UMCG worker */
+#else
+#define PF_UMCG_WORKER		0x00000000
+#endif
+
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
@@ -2296,6 +2321,67 @@ static inline void rseq_execve(struct task_struct *t)
 
 #endif
 
+#ifdef CONFIG_UMCG
+
+extern void umcg_sys_enter(struct pt_regs *regs, long syscall);
+extern void umcg_sys_exit(struct pt_regs *regs);
+extern void umcg_notify_resume(struct pt_regs *regs);
+extern void umcg_worker_exit(void);
+extern void umcg_clear_child(struct task_struct *tsk);
+
+/* Called by bprm_execve() in fs/exec.c. */
+static inline void umcg_execve(struct task_struct *tsk)
+{
+	if (tsk->umcg_task)
+		umcg_clear_child(tsk);
+}
+
+/* Called by do_exit() in kernel/exit.c. */
+static inline void umcg_handle_exit(void)
+{
+	if (current->flags & PF_UMCG_WORKER)
+		umcg_worker_exit();
+}
+
+/*
+ * umcg_wq_worker_[sleeping|running] are called in core.c by
+ * sched_submit_work() and sched_update_worker().
+ */
+extern void umcg_wq_worker_sleeping(struct task_struct *tsk);
+extern void umcg_wq_worker_running(struct task_struct *tsk);
+
+#else  /* CONFIG_UMCG */
+
+static inline void umcg_sys_enter(struct pt_regs *regs, long syscall)
+{
+}
+
+static inline void umcg_sys_exit(struct pt_regs *regs)
+{
+}
+
+static inline void umcg_notify_resume(struct pt_regs *regs)
+{
+}
+
+static inline void umcg_clear_child(struct task_struct *tsk)
+{
+}
+static inline void umcg_execve(struct task_struct *tsk)
+{
+}
+static inline void umcg_handle_exit(void)
+{
+}
+static inline void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+}
+static inline void umcg_wq_worker_running(struct task_struct *tsk)
+{
+}
+
+#endif
+
 #ifdef CONFIG_DEBUG_RSEQ
 
 void rseq_syscall(struct pt_regs *regs);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 528a478dbda8..3ba0af15e223 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -72,6 +72,7 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct umcg_task;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1057,6 +1058,9 @@ asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type ru
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
 asmlinkage long sys_memfd_secret(unsigned int flags);
+asmlinkage long sys_umcg_ctl(u32 flags, struct umcg_task __user *self, clockid_t which_clock);
+asmlinkage long sys_umcg_wait(u32 flags, u64 abs_timeout);
+asmlinkage long sys_umcg_kick(u32 flags, pid_t tid);
 
 /*
  * Architecture-specific system calls
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 73a6f34b3847..8fdc4a1fa9a5 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -46,6 +46,7 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
+	SYSCALL_WORK_BIT_SYSCALL_UMCG,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
@@ -55,6 +56,7 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
 #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
 #define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
+#define SYSCALL_WORK_SYSCALL_UMCG	BIT(SYSCALL_WORK_BIT_SYSCALL_UMCG)
 #endif
 
 #include <asm/thread_info.h>
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 4557a8b6086f..495949af981e 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -883,8 +883,15 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 
+#define __NR_umcg_ctl 450
+__SYSCALL(__NR_umcg_ctl, sys_umcg_ctl)
+#define __NR_umcg_wait 451
+__SYSCALL(__NR_umcg_wait, sys_umcg_wait)
+#define __NR_umcg_kick 452
+__SYSCALL(__NR_umcg_kick, sys_umcg_kick)
+
 #undef __NR_syscalls
-#define __NR_syscalls 450
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
new file mode 100644
index 000000000000..a994bbb062d5
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_UMCG_H
+#define _UAPI_LINUX_UMCG_H
+
+#include <linux/types.h>
+
+/*
+ * UMCG: User Managed Concurrency Groups.
+ *
+ * Syscalls (see kernel/sched/umcg.c):
+ *      sys_umcg_ctl()  - register/unregister UMCG tasks;
+ *      sys_umcg_wait() - wait/wake/context-switch.
+ *      sys_umcg_kick() - prod a UMCG task
+ *
+ * struct umcg_task (below): controls the state of UMCG tasks.
+ */
+
+/*
+ * UMCG task states, the first 6 bits of struct umcg_task.state_ts.
+ * The states represent the user space point of view.
+ *
+ *   ,--------(TF_PREEMPT + notify_resume)-------. ,------------.
+ *   |                                           v |            |
+ * RUNNING -(schedule)-> BLOCKED -(sys_exit)-> RUNNABLE  (signal + notify_resume)
+ *   ^                                           | ^            |
+ *   `--------------(sys_umcg_wait)--------------' `------------'
+ *
+ */
+#define UMCG_TASK_NONE			0x0000U
+#define UMCG_TASK_RUNNING		0x0001U
+#define UMCG_TASK_RUNNABLE		0x0002U
+#define UMCG_TASK_BLOCKED		0x0003U
+
+#define UMCG_TASK_MASK			0x00ffU
+
+/*
+ * UMCG_TF_PREEMPT: userspace indicates the worker should be preempted.
+ *
+ * Must only be set on UMCG_TASK_RUNNING; once set, any subsequent
+ * return-to-user (eg sys_umcg_kick()) will perform the equivalent of
+ * sys_umcg_wait() on it. That is, it will wake next_tid/server_tid, transfer
+ * to RUNNABLE and enqueue on the server's runnable list.
+ */
+#define UMCG_TF_PREEMPT			0x0100U
+/*
+ * UMCG_TF_COND_WAIT: indicate the task *will* call sys_umcg_wait()
+ *
+ * Enables server loops like (vs umcg_sys_exit()):
+ *
+ *   for(;;) {
+ *	self->status = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
+ *	// smp_mb() implied by xchg()
+ *
+ *	runnable_ptr = xchg(self->runnable_workers_ptr, NULL);
+ *	while (runnable_ptr) {
+ *		next = runnable_ptr->runnable_workers_ptr;
+ *
+ *		umcg_server_add_runnable(self, runnable_ptr);
+ *
+ *		runnable_ptr = next;
+ *	}
+ *
+ *	self->next = umcg_server_pick_next(self);
+ *	sys_umcg_wait(0, 0);
+ *   }
+ *
+ * without a signal or interrupt in between setting umcg_task::state and
+ * sys_umcg_wait() resulting in an infinite wait in umcg_notify_resume().
+ */
+#define UMCG_TF_COND_WAIT		0x0200U
+
+#define UMCG_TF_MASK			0xff00U
+
+#define UMCG_TASK_ALIGN			64
+
+/**
+ * struct umcg_task - controls the state of UMCG tasks.
+ *
+ * The struct is aligned at 64 bytes to ensure that it fits into
+ * a single cache line.
+ */
+struct umcg_task {
+	/**
+	 * @state_ts: the current state of the UMCG task described by
+	 *            this struct, with a unique timestamp indicating
+	 *            when the last state change happened.
+	 *
+	 * Readable/writable by both the kernel and the userspace.
+	 *
+	 * UMCG task state:
+	 *   bits  0 -  7: task state;
+	 *   bits  8 - 15: state flags;
+	 *   bits 16 - 31: for userspace use;
+	 */
+	__u32	state;				/* r/w */
+
+	/**
+	 * @next_tid: the TID of the UMCG task that should be context-switched
+	 *            into in sys_umcg_wait(). Can be zero, in which case
+	 *            it'll switch to server_tid.
+	 *
+	 * @server_tid: the TID of the UMCG server that hosts this task,
+	 *		when RUNNABLE this task will get added to it's
+	 *		runnable_workers_ptr list.
+	 *
+	 * Read-only for the kernel, read/write for the userspace.
+	 */
+	__u32	next_tid;			/* r   */
+	__u32	server_tid;			/* r   */
+
+	__u32	__hole[1];
+
+	/*
+	 * Timestamps for when last we became BLOCKED, RUNNABLE, in CLOCK_MONOTONIC.
+	 */
+	__u64	blocked_ts;			/*   w */
+	__u64   runnable_ts;			/*   w */
+
+	/**
+	 * @runnable_workers_ptr: a single-linked list of runnable workers.
+	 *
+	 * Readable/writable by both the kernel and the userspace: the
+	 * kernel adds items to the list, userspace removes them.
+	 */
+	__u64	runnable_workers_ptr;		/* r/w */
+
+	__u64	__zero[3];
+
+} __attribute__((packed, aligned(UMCG_TASK_ALIGN)));
+
+/**
+ * enum umcg_ctl_flag - flags to pass to sys_umcg_ctl
+ * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
+ * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
+ * @UMCG_CTL_WORKER:     register the current task as a UMCG worker
+ */
+enum umcg_ctl_flag {
+	UMCG_CTL_REGISTER	= 0x00001,
+	UMCG_CTL_UNREGISTER	= 0x00002,
+	UMCG_CTL_WORKER		= 0x10000,
+};
+
+#endif /* _UAPI_LINUX_UMCG_H */
diff --git a/init/Kconfig b/init/Kconfig
index 41a728debdbd..15d1e330fdb9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1686,6 +1686,21 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config HAVE_UMCG
+	bool
+
+config UMCG
+	bool "Enable User Managed Concurrency Groups API"
+	depends on 64BIT
+	depends on GENERIC_ENTRY
+	depends on HAVE_UMCG
+	default n
+	help
+	  Enable User Managed Concurrency Groups API, which form the basis
+	  for an in-process M:N userspace scheduling framework.
+	  At the moment this is an experimental/RFC feature that is not
+	  guaranteed to be backward-compatible.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad713684c2e..7d7bd5c300b1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/sched.h>
 
 #include "common.h"
 
@@ -76,6 +77,9 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
 
+	if (work & SYSCALL_WORK_SYSCALL_UMCG)
+		umcg_sys_enter(regs, syscall);
+
 	syscall_enter_audit(regs, syscall);
 
 	return ret ? : syscall;
@@ -155,8 +159,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
 	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
-
+	do {
 		local_irq_enable_exit_to_user(ti_work);
 
 		if (ti_work & _TIF_NEED_RESCHED)
@@ -168,6 +171,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
+		/* must be before handle_signal_work(); terminates on sigpending */
+		if (ti_work & _TIF_UMCG)
+			umcg_notify_resume(regs);
+
 		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			handle_signal_work(regs, ti_work);
 
@@ -188,7 +195,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		tick_nohz_user_enter_prepare();
 
 		ti_work = read_thread_flags();
-	}
+	} while (ti_work & EXIT_TO_USER_MODE_WORK);
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
 	return ti_work;
@@ -203,7 +210,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+	if (unlikely(ti_work & (EXIT_TO_USER_MODE_WORK | _TIF_UMCG)))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
@@ -253,6 +260,9 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 	step = report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
 		arch_syscall_exit_tracehook(regs, step);
+
+	if (work & SYSCALL_WORK_SYSCALL_UMCG)
+		umcg_sys_exit(regs);
 }
 
 /*
diff --git a/kernel/exit.c b/kernel/exit.c
index f702a6a63686..4bdd51c75aee 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -749,6 +749,10 @@ void __noreturn do_exit(long code)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
 
+	/* Turn off UMCG sched hooks. */
+	if (unlikely(tsk->flags & PF_UMCG_WORKER))
+		tsk->flags &= ~PF_UMCG_WORKER;
+
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
 	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
@@ -786,6 +790,7 @@ void __noreturn do_exit(long code)
 
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
+	umcg_handle_exit();
 
 	/* sync mm's RSS info before statistics gathering */
 	if (tsk->mm)
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c7421f2d05e1..c03eea9bc738 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
 obj-$(CONFIG_SCHED_CORE) += core_sched.o
+obj-$(CONFIG_UMCG) += umcg.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04525933de94..6e10080dc25a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4272,6 +4272,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+	umcg_clear_child(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -6330,9 +6331,11 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * If a worker goes to sleep, notify and ask workqueue whether it
 	 * wants to wake up a task to maintain concurrency.
 	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
+		else if (task_flags & PF_UMCG_WORKER)
+			umcg_wq_worker_sleeping(tsk);
 		else
 			io_wq_worker_sleeping(tsk);
 	}
@@ -6350,9 +6353,11 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
+		else if (tsk->flags & PF_UMCG_WORKER)
+			umcg_wq_worker_running(tsk);
 		else
 			io_wq_worker_running(tsk);
 	}
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
new file mode 100644
index 000000000000..9a8755045285
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,868 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * User Managed Concurrency Groups (UMCG).
+ *
+ */
+
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/umcg.h>
+
+#include <asm/syscall.h>
+
+#include "sched.h"
+
+static struct task_struct *umcg_get_task(u32 tid)
+{
+	struct task_struct *tsk = NULL;
+
+	if (tid) {
+		rcu_read_lock();
+		tsk = find_task_by_vpid(tid);
+		if (tsk && current->mm == tsk->mm && tsk->umcg_task)
+			get_task_struct(tsk);
+		else
+			tsk = NULL;
+		rcu_read_unlock();
+	}
+
+	return tsk;
+}
+
+/**
+ * umcg_pin_pages: pin pages containing struct umcg_task of
+ *		   this task, its server (possibly this task again)
+ *		   and the next (possibly NULL).
+ */
+static int umcg_pin_pages(void)
+{
+	struct task_struct *server = NULL, *next = NULL, *tsk = current;
+	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
+	int server_tid, next_tid;
+	int ret;
+
+	/* must not have stale state */
+	if (WARN_ON_ONCE(tsk->umcg_worker_page ||
+			 tsk->umcg_server_page ||
+			 tsk->umcg_next_page   ||
+			 tsk->umcg_server_task ||
+			 tsk->umcg_next_task   ||
+			 tsk->umcg_server      ||
+			 tsk->umcg_next))
+		return -EBUSY;
+
+	ret = -EFAULT;
+	if (pin_user_pages_fast((unsigned long)self, 1, 0,
+				&tsk->umcg_worker_page) != 1)
+		goto clear_self;
+
+	if (get_user(server_tid, &self->server_tid))
+		goto unpin_self;
+
+	ret = -ESRCH;
+	server = umcg_get_task(server_tid);
+	if (!server)
+		goto unpin_self;
+
+	ret = -EFAULT;
+	/* must cache due to possible concurrent change vs access_ok() */
+	tsk->umcg_server_task = READ_ONCE(server->umcg_task);
+	if (pin_user_pages_fast((unsigned long)tsk->umcg_server_task, 1, 0,
+				&tsk->umcg_server_page) != 1)
+		goto clear_server;
+
+	tsk->umcg_server = server;
+
+	if (get_user(next_tid, &self->next_tid))
+		goto unpin_server;
+
+	if (!next_tid)
+		goto done;
+
+	ret = -ESRCH;
+	next = umcg_get_task(next_tid);
+	if (!next)
+		goto unpin_server;
+
+	ret = -EFAULT;
+	tsk->umcg_next_task = READ_ONCE(next->umcg_task);
+	if (pin_user_pages_fast((unsigned long)tsk->umcg_next_task, 1, 0,
+				&tsk->umcg_next_page) != 1)
+		goto clear_next;
+
+	tsk->umcg_next = next;
+
+done:
+	return 0;
+
+clear_next:
+	tsk->umcg_next_task = NULL;
+	tsk->umcg_next_page = NULL;
+
+unpin_server:
+	unpin_user_page(tsk->umcg_server_page);
+
+clear_server:
+	tsk->umcg_server_task = NULL;
+	tsk->umcg_server_page = NULL;
+
+unpin_self:
+	unpin_user_page(tsk->umcg_worker_page);
+clear_self:
+	tsk->umcg_worker_page = NULL;
+
+	return ret;
+}
+
+static void umcg_unpin_pages(void)
+{
+	struct task_struct *tsk = current;
+
+	if (tsk->umcg_server) {
+		unpin_user_page(tsk->umcg_worker_page);
+		tsk->umcg_worker_page = NULL;
+
+		unpin_user_page(tsk->umcg_server_page);
+		tsk->umcg_server_page = NULL;
+		tsk->umcg_server_task = NULL;
+
+		put_task_struct(tsk->umcg_server);
+		tsk->umcg_server = NULL;
+
+		if (tsk->umcg_next) {
+			unpin_user_page(tsk->umcg_next_page);
+			tsk->umcg_next_page = NULL;
+			tsk->umcg_next_task = NULL;
+
+			put_task_struct(tsk->umcg_next);
+			tsk->umcg_next = NULL;
+		}
+	}
+}
+
+static void umcg_clear_task(struct task_struct *tsk)
+{
+	/*
+	 * This is either called for the current task, or for a newly forked
+	 * task that is not yet running, so we don't need strict atomicity
+	 * below.
+	 */
+	if (tsk->umcg_task) {
+		WRITE_ONCE(tsk->umcg_task, NULL);
+		tsk->umcg_worker_page = NULL;
+
+		tsk->umcg_server = NULL;
+		tsk->umcg_server_page = NULL;
+		tsk->umcg_server_task = NULL;
+
+		tsk->umcg_next = NULL;
+		tsk->umcg_next_page = NULL;
+		tsk->umcg_next_task = NULL;
+
+		tsk->flags &= ~PF_UMCG_WORKER;
+		clear_task_syscall_work(tsk, SYSCALL_UMCG);
+		clear_tsk_thread_flag(tsk, TIF_UMCG);
+	}
+}
+
+/* Called for a forked or execve-ed child. */
+void umcg_clear_child(struct task_struct *tsk)
+{
+	umcg_clear_task(tsk);
+}
+
+/* Called both by normally (unregister) and abnormally exiting workers. */
+void umcg_worker_exit(void)
+{
+	umcg_unpin_pages();
+	umcg_clear_task(current);
+}
+
+/*
+ * Do a state transition: @from -> @to.
+ *
+ * Will clear UMCG_TF_PREEMPT, UMCG_TF_COND_WAIT.
+ *
+ * When @to == {BLOCKED,RUNNABLE}, update timestamps.
+ *
+ * Returns:
+ *   0: success
+ *   -EAGAIN: when self->state != @from
+ *   -EFAULT
+ */
+static int umcg_update_state(struct task_struct *tsk,
+			     struct umcg_task __user *self,
+			     u32 from, u32 to)
+{
+	u32 old, new;
+	u64 now;
+
+	if (to >= UMCG_TASK_RUNNABLE) {
+		switch (tsk->umcg_clock) {
+		case CLOCK_REALTIME:      now = ktime_get_real_ns();     break;
+		case CLOCK_MONOTONIC:     now = ktime_get_ns();          break;
+		case CLOCK_BOOTTIME:      now = ktime_get_boottime_ns(); break;
+		case CLOCK_TAI:           now = ktime_get_clocktai_ns(); break;
+		}
+	}
+
+	if (!user_access_begin(self, sizeof(*self)))
+		return -EFAULT;
+
+	unsafe_get_user(old, &self->state, Efault);
+	do {
+		if ((old & UMCG_TASK_MASK) != from)
+			goto fail;
+
+		new = old & ~(UMCG_TASK_MASK |
+			      UMCG_TF_PREEMPT | UMCG_TF_COND_WAIT);
+		new |= to & UMCG_TASK_MASK;
+
+	} while (!unsafe_try_cmpxchg_user(&self->state, &old, new, Efault));
+
+	if (to == UMCG_TASK_BLOCKED)
+		unsafe_put_user(now, &self->blocked_ts, Efault);
+	if (to == UMCG_TASK_RUNNABLE)
+		unsafe_put_user(now, &self->runnable_ts, Efault);
+
+	user_access_end();
+	return 0;
+
+fail:
+	user_access_end();
+	return -EAGAIN;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+#define __UMCG_DIE(stmt, reason)	do {				\
+	stmt;								\
+	pr_warn_ratelimited("%s: killing task %s/%d because: " reason "\n",\
+			    __func__, current->comm, current->pid);	\
+	force_sig(SIGKILL);						\
+	return;								\
+} while (0)
+
+#define UMCG_DIE(reason)	__UMCG_DIE(,reason)
+#define UMCG_DIE_PF(reason)	__UMCG_DIE(pagefault_enable(), reason)
+#define UMCG_DIE_UNPIN(reason)	__UMCG_DIE(umcg_unpin_pages(), reason)
+
+/* Called from syscall enter path */
+void umcg_sys_enter(struct pt_regs *regs, long syscall)
+{
+	/* avoid recursion vs our own syscalls */
+	if (syscall == __NR_umcg_wait ||
+	    syscall == __NR_umcg_ctl)
+		return;
+
+	/* avoid recursion vs schedule() */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	/*
+	 * Pin all the state on sys_enter() such that we can rely on it
+	 * from dodgy contexts. It is either unpinned from pre-schedule()
+	 * or sys_exit(), whichever comes first, thereby ensuring the pin
+	 * is temporary.
+	 */
+	if (umcg_pin_pages())
+		UMCG_DIE("pin");
+
+	current->flags |= PF_UMCG_WORKER;
+}
+
+static int umcg_wake_task(struct task_struct *tsk, struct umcg_task __user *self)
+{
+	int ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING);
+	if (ret)
+		return ret;
+
+	try_to_wake_up(tsk, TASK_NORMAL, WF_CURRENT_CPU);
+	return 0;
+}
+
+static int umcg_wake_next(struct task_struct *tsk)
+{
+	int ret = umcg_wake_task(tsk->umcg_next, tsk->umcg_next_task);
+	if (ret)
+		return ret;
+
+	/*
+	 * If userspace sets umcg_task::next_tid, it needs to remove
+	 * that task from the ready-queue to avoid another server
+	 * selecting it. However, that also means it needs to put it
+	 * back in case it went unused.
+	 *
+	 * By clearing the field on use, userspace can detect this case
+	 * and DTRT.
+	 */
+	if (put_user(0u, &tsk->umcg_task->next_tid))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int umcg_wake_server(struct task_struct *tsk)
+{
+	int ret = umcg_wake_task(tsk->umcg_server, tsk->umcg_server_task);
+	switch (ret) {
+	case 0:
+	case -EAGAIN:
+		/*
+		 * Server could have timed-out or already be running
+		 * due to a runnable enqueue. See umcg_sys_exit().
+		 */
+		break;
+
+	default:
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Wake ::next_tid or ::server_tid.
+ *
+ * Must be called in umcg_pin_pages() context, relies on
+ * tsk->umcg_{server,next}.
+ *
+ * Returns:
+ *   0: success
+ *   -EAGAIN
+ *   -EFAULT
+ */
+static int umcg_wake(struct task_struct *tsk)
+{
+	if (tsk->umcg_next)
+		return umcg_wake_next(tsk);
+
+	return umcg_wake_server(tsk);
+}
+
+/* pre-schedule() */
+void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
+
+	/* Must not fault, mmap_sem might be held. */
+	pagefault_disable();
+
+	if (WARN_ON_ONCE(!tsk->umcg_server))
+		UMCG_DIE_PF("no server");
+
+	if (umcg_update_state(tsk, self, UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED))
+		UMCG_DIE_PF("state");
+
+	if (umcg_wake(tsk))
+		UMCG_DIE_PF("wake");
+
+	pagefault_enable();
+
+	/*
+	 * We're going to sleep, make sure to unpin the pages, this ensures
+	 * the pins are temporary. Also see umcg_sys_exit().
+	 */
+	umcg_unpin_pages();
+}
+
+/* post-schedule() */
+void umcg_wq_worker_running(struct task_struct *tsk)
+{
+	/* nothing here, see umcg_sys_exit() */
+}
+
+/*
+ * Enqueue @tsk on it's server's runnable list
+ *
+ * Must be called in umcg_pin_pages() context, relies on tsk->umcg_server.
+ *
+ * cmpxchg based single linked list add such that list integrity is never
+ * violated.  Userspace *MUST* remove it from the list before changing ->state.
+ * As such, we must change state to RUNNABLE before enqueue.
+ *
+ * Returns:
+ *   0: success
+ *   -EFAULT
+ */
+static int umcg_enqueue_runnable(struct task_struct *tsk)
+{
+	struct umcg_task __user *server = tsk->umcg_server_task;
+	struct umcg_task __user *self = tsk->umcg_task;
+	u64 self_ptr = (unsigned long)self;
+	u64 first_ptr;
+
+	/*
+	 * umcg_pin_pages() did access_ok() on both pointers, use self here
+	 * only because __user_access_begin() isn't available in generic code.
+	 */
+	if (!user_access_begin(self, sizeof(*self)))
+		return -EFAULT;
+
+	unsafe_get_user(first_ptr, &server->runnable_workers_ptr, Efault);
+	do {
+		unsafe_put_user(first_ptr, &self->runnable_workers_ptr, Efault);
+	} while (!unsafe_try_cmpxchg_user(&server->runnable_workers_ptr, &first_ptr, self_ptr, Efault));
+
+	user_access_end();
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+/*
+ * umcg_wait: Wait for ->state to become RUNNING
+ *
+ * Returns:
+ * 0		- success
+ * -EINTR	- pending signal
+ * -EINVAL	- ::state is not {RUNNABLE,RUNNING}
+ * -ETIMEDOUT
+ * -EFAULT
+ */
+int umcg_wait(u64 timo)
+{
+	struct task_struct *tsk = current;
+	struct umcg_task __user *self = tsk->umcg_task;
+	struct page *page = NULL;
+	u32 state;
+	int ret;
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		ret = -EINTR;
+		if (signal_pending(current))
+			break;
+
+		/*
+		 * Faults can block and scribble our wait state.
+		 */
+		pagefault_disable();
+		if (get_user(state, &self->state)) {
+			pagefault_enable();
+
+			ret = -EFAULT;
+			if (page) {
+				unpin_user_page(page);
+				page = NULL;
+				break;
+			}
+
+			if (pin_user_pages_fast((unsigned long)self, 1, 0, &page) != 1) {
+				page = NULL;
+				break;
+			}
+
+			continue;
+		}
+
+		if (page) {
+			unpin_user_page(page);
+			page = NULL;
+		}
+		pagefault_enable();
+
+		state &= UMCG_TASK_MASK;
+		if (state != UMCG_TASK_RUNNABLE) {
+			ret = 0;
+			if (state == UMCG_TASK_RUNNING)
+				break;
+
+			ret = -EINVAL;
+			break;
+		}
+
+		if (!schedule_hrtimeout_range_clock(timo ? &timo : NULL,
+						    tsk->timer_slack_ns,
+						    HRTIMER_MODE_ABS,
+						    tsk->umcg_clock)) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+	}
+	__set_current_state(TASK_RUNNING);
+
+	return ret;
+}
+
+void umcg_sys_exit(struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
+	long syscall = syscall_get_nr(tsk, regs);
+
+	if (syscall == __NR_umcg_wait)
+		return;
+
+	/*
+	 * sys_umcg_ctl() will get here without having called umcg_sys_enter()
+	 * as such it will look like a syscall that blocked.
+	 */
+
+	if (tsk->umcg_server) {
+		/*
+		 * Didn't block, we done.
+		 */
+		umcg_unpin_pages();
+		return;
+	}
+
+	/* avoid recursion vs schedule() */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	if (umcg_pin_pages())
+		UMCG_DIE("pin");
+
+	if (umcg_update_state(tsk, self, UMCG_TASK_BLOCKED, UMCG_TASK_RUNNABLE))
+		UMCG_DIE_UNPIN("state");
+
+	if (umcg_enqueue_runnable(tsk))
+		UMCG_DIE_UNPIN("enqueue");
+
+	/* Server might not be RUNNABLE, means it's already running */
+	if (umcg_wake_server(tsk))
+		UMCG_DIE_UNPIN("wake-server");
+
+	umcg_unpin_pages();
+
+	switch (umcg_wait(0)) {
+	case -EFAULT:
+	case -EINVAL:
+	case -ETIMEDOUT: /* how!?! */
+	default:
+		UMCG_DIE("wait");
+
+	case 0:
+	case -EINTR:
+		/* notify_resume will continue the wait after the signal */
+		break;
+	}
+
+	current->flags |= PF_UMCG_WORKER;
+}
+
+void umcg_notify_resume(struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	struct umcg_task __user *self = tsk->umcg_task;
+	bool worker = tsk->flags & PF_UMCG_WORKER;
+	u32 state;
+
+	/* avoid recursion vs schedule() */
+	if (worker)
+		current->flags &= ~PF_UMCG_WORKER;
+
+	if (get_user(state, &self->state))
+		UMCG_DIE("get-state");
+
+	state &= UMCG_TASK_MASK | UMCG_TF_MASK;
+	if (state == UMCG_TASK_RUNNING)
+		goto done;
+
+	/*
+	 * See comment at UMCG_TF_COND_WAIT; TL;DR: user *will* call
+	 * sys_umcg_wait() and signals/interrupts shouldn't block
+	 * return-to-user.
+	 */
+	if (state == (UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT))
+		goto done;
+
+	if (state & UMCG_TF_PREEMPT) {
+		if (umcg_pin_pages())
+			UMCG_DIE("pin");
+
+		if (umcg_update_state(tsk, self,
+				      UMCG_TASK_RUNNING,
+				      UMCG_TASK_RUNNABLE))
+			UMCG_DIE_UNPIN("state");
+
+		if (umcg_enqueue_runnable(tsk))
+			UMCG_DIE_UNPIN("enqueue");
+
+		/*
+		 * XXX do we want a preemption consuming ::next_tid ?
+		 * I'm currently leaning towards no.
+		 */
+		if (umcg_wake_server(tsk))
+			UMCG_DIE_UNPIN("wake-server");
+
+		umcg_unpin_pages();
+	}
+
+	switch (umcg_wait(0)) {
+	case -EFAULT:
+	case -EINVAL:
+	case -ETIMEDOUT: /* how!?! */
+	default:
+		UMCG_DIE("wait");
+
+	case 0:
+	case -EINTR:
+		/* we'll will resume the wait after the signal */
+		break;
+	}
+
+done:
+	if (worker)
+		current->flags |= PF_UMCG_WORKER;
+}
+
+/**
+ * sys_umcg_kick: makes a UMCG task cycle through umcg_notify_resume()
+ *
+ * Returns:
+ * 0		- Ok;
+ * -ESRCH	- not a related UMCG task
+ * -EINVAL	- another error happened (unknown flags, etc..)
+ */
+SYSCALL_DEFINE2(umcg_kick, u32, flags, pid_t, tid)
+{
+	struct task_struct *task = umcg_get_task(tid);
+	if (!task)
+		return -ESRCH;
+
+	if (flags)
+		return -EINVAL;
+
+#ifdef CONFIG_SMP
+	smp_send_reschedule(task_cpu(task));
+#endif
+
+	return 0;
+}
+
+/**
+ * sys_umcg_wait: transfer running context
+ *
+ * Block until RUNNING. Userspace must already set RUNNABLE to deal with the
+ * sleep condition races (see TF_COND_WAIT).
+ *
+ * Will wake either ::next_tid or ::server_tid to take our place. If this is a
+ * server then not setting ::next_tid will wake self.
+ *
+ * Returns:
+ * 0		- OK;
+ * -ETIMEDOUT	- the timeout expired;
+ * -ERANGE	- the timeout is out of range (worker);
+ * -EAGAIN	- ::state wasn't RUNNABLE, concurrent wakeup;
+ * -EFAULT	- failed accessing struct umcg_task __user of the current
+ *		  task, the server or next;
+ * -ESRCH	- the task to wake not found or not a UMCG task;
+ * -EINVAL	- another error happened (e.g. the current task is not a
+ *		  UMCG task, etc.)
+ */
+SYSCALL_DEFINE2(umcg_wait, u32, flags, u64, timo)
+{
+	struct task_struct *tsk = current;
+	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
+	bool worker = tsk->flags & PF_UMCG_WORKER;
+	int ret;
+
+	if (!self || flags)
+		return -EINVAL;
+
+	if (worker) {
+		tsk->flags &= ~PF_UMCG_WORKER;
+		if (timo)
+			return -ERANGE;
+	}
+
+	/* see umcg_sys_{enter,exit}() syscall exceptions */
+	ret = umcg_pin_pages();
+	if (ret)
+		goto unblock;
+
+	/*
+	 * Clear UMCG_TF_COND_WAIT *and* check state == RUNNABLE.
+	 */
+	ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNABLE);
+	if (ret)
+		goto unpin;
+
+	if (worker) {
+		ret = umcg_enqueue_runnable(tsk);
+		if (ret)
+			goto unpin;
+	}
+
+	if (worker)
+		ret = umcg_wake(tsk);
+	else if (tsk->umcg_next)
+		ret = umcg_wake_next(tsk);
+
+	if (ret) {
+		/*
+		 * XXX already enqueued ourself on ::server_tid; failing now
+		 * leaves the lot in an inconsistent state since it'll also
+		 * unblock self in order to return the error. !?!?
+		 */
+		goto unpin;
+	}
+
+	umcg_unpin_pages();
+
+	ret = umcg_wait(timo);
+	switch (ret) {
+	case 0:		/* all done */
+	case -EINTR:	/* umcg_notify_resume() will continue the wait */
+		ret = 0;
+		break;
+
+	default:
+		goto unblock;
+	}
+out:
+	if (worker)
+		tsk->flags |= PF_UMCG_WORKER;
+	return ret;
+
+unpin:
+	umcg_unpin_pages();
+unblock:
+	/*
+	 * Workers will still block in umcg_notify_resume() before they can
+	 * consume their error, servers however need to get the error asap.
+	 *
+	 * Still, things might be unrecoverably screwy after this. Not our
+	 * problem.
+	 */
+	if (!worker)
+		umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING);
+	goto out;
+}
+
+/**
+ * sys_umcg_ctl: (un)register the current task as a UMCG task.
+ * @flags:       ORed values from enum umcg_ctl_flag; see below;
+ * @self:        a pointer to struct umcg_task that describes this
+ *               task and governs the behavior of sys_umcg_wait if
+ *               registering; must be NULL if unregistering.
+ *
+ * @flags & UMCG_CTL_REGISTER: register a UMCG task:
+ *
+ *         UMCG workers:
+ *              - @flags & UMCG_CTL_WORKER
+ *              - self->state must be UMCG_TASK_BLOCKED
+ *
+ *         UMCG servers:
+ *              - !(@flags & UMCG_CTL_WORKER)
+ *              - self->state must be UMCG_TASK_RUNNING
+ *
+ *         All tasks:
+ *              - self->server_tid must be a valid server
+ *              - self->next_tid must be zero
+ *
+ *         If the conditions above are met, sys_umcg_ctl() immediately returns
+ *         if the registered task is a server. If the registered task is a
+ *         worker it will be added to it's server's runnable_workers_ptr list
+ *         and the server will be woken.
+ *
+ * @flags == UMCG_CTL_UNREGISTER: unregister a UMCG task. If the current task
+ *           is a UMCG worker, the userspace is responsible for waking its
+ *           server (before or after calling sys_umcg_ctl).
+ *
+ * Return:
+ * 0		- success
+ * -EFAULT	- failed to read @self
+ * -EINVAL	- some other error occurred
+ * -ESRCH	- no such server_tid
+ */
+SYSCALL_DEFINE3(umcg_ctl, u32, flags, struct umcg_task __user *, self, clockid_t, which_clock)
+{
+	struct task_struct *server;
+	struct umcg_task ut;
+
+	if ((unsigned long)self % UMCG_TASK_ALIGN)
+		return -EINVAL;
+
+	if (flags & ~(UMCG_CTL_REGISTER |
+		      UMCG_CTL_UNREGISTER |
+		      UMCG_CTL_WORKER))
+		return -EINVAL;
+
+	if (flags == UMCG_CTL_UNREGISTER) {
+		if (self || !current->umcg_task)
+			return -EINVAL;
+
+		if (current->flags & PF_UMCG_WORKER)
+			umcg_worker_exit();
+		else
+			umcg_clear_task(current);
+
+		return 0;
+	}
+
+	if (!(flags & UMCG_CTL_REGISTER))
+		return -EINVAL;
+
+	flags &= ~UMCG_CTL_REGISTER;
+
+	switch (which_clock) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_BOOTTIME:
+	case CLOCK_TAI:
+		current->umcg_clock = which_clock;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (current->umcg_task || !self)
+		return -EINVAL;
+
+	if (copy_from_user(&ut, self, sizeof(ut)))
+		return -EFAULT;
+
+	if (ut.next_tid || ut.__hole[0] || ut.__zero[0] || ut.__zero[1] || ut.__zero[2])
+		return -EINVAL;
+
+	rcu_read_lock();
+	server = find_task_by_vpid(ut.server_tid);
+	if (server && server->mm == current->mm) {
+		if (flags == UMCG_CTL_WORKER) {
+			if (!server->umcg_task ||
+			    (server->flags & PF_UMCG_WORKER))
+				server = NULL;
+		} else {
+			if (server != current)
+				server = NULL;
+		}
+	} else {
+		server = NULL;
+	}
+	rcu_read_unlock();
+
+	if (!server)
+		return -ESRCH;
+
+	if (flags == UMCG_CTL_WORKER) {
+		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_BLOCKED)
+			return -EINVAL;
+
+		WRITE_ONCE(current->umcg_task, self);
+		current->flags |= PF_UMCG_WORKER;	/* hook schedule() */
+		set_syscall_work(SYSCALL_UMCG);		/* hook syscall */
+		set_thread_flag(TIF_UMCG);		/* hook return-to-user */
+
+		/* umcg_sys_exit() will transition to RUNNABLE and wait */
+
+	} else {
+		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_RUNNING)
+			return -EINVAL;
+
+		WRITE_ONCE(current->umcg_task, self);
+		set_thread_flag(TIF_UMCG);		/* hook return-to-user */
+
+		/* umcg_notify_resume() would block if not RUNNING */
+	}
+
+	return 0;
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d1944258cfc0..a4029e05129b 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -273,6 +273,11 @@ COND_SYSCALL(landlock_create_ruleset);
 COND_SYSCALL(landlock_add_rule);
 COND_SYSCALL(landlock_restrict_self);
 
+/* kernel/sched/umcg.c */
+COND_SYSCALL(umcg_ctl);
+COND_SYSCALL(umcg_wait);
+COND_SYSCALL(umcg_kick);
+
 /* arch/example/kernel/sys_example.c */
 
 /* mm/fadvise.c */
-- 
2.34.1.703.g22d0c6ccf7-goog

