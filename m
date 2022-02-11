Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0314B2D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbiBKTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:13:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiBKTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:13:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6DCF8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:13:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j4so5434908plj.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0RA1+rJl6iQly3lt5OOAIXpbXhtVTIO8H9TCLMjEdnU=;
        b=I7eysnajiFgWbcrDo8tOlN+z/mH2dB+w9YypphJaeARTZ0w+inUhOPiKOkV7U3/1D/
         YHBwyMlRGvYD90Gb7Xd1bYvRcIVj3YeWWng5pYb8p4eT+/QMdDkyPdq3Q8POknvfpNPM
         vA976ySjIOEFCDy6pFq3SGmBQbTZb0rWSqW489Dpy8GZ7EI+K7FE2PruBaqguGULM9J2
         K9cRe5c1gpp8TaNHg7bkS2vvqggOKb6nC0XQDiOtCUma6o9DS3JuH6ZywgcfvIzT3lYa
         bisyFvsqoEjNiNR44ziCwjwvcMjLFHfqa1fVnDozyv/btcq2A2UOnBu7cpw76XnwvfZZ
         HrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0RA1+rJl6iQly3lt5OOAIXpbXhtVTIO8H9TCLMjEdnU=;
        b=UoQYPBBY+a2+NCU9GTycAFm7hgD+LyjGb++NLFKgjMz2479/Mycmk1lmrlOrDkFqRT
         TPoXxIuKNWbIqdZAo8p7xAkb24vPjhfNaOkF+H6wTkmer8wN+saNxJTSfmUyc3Ob+hgo
         w+Ms5ff5K//tEmLYY4yc4AfJuYyD9WjLjE2MN7GLXlx2x0O82dxWhJA6ELWqnxZLzzj8
         1ZVH8EYdtcS9Zqk+Vmyk5Qgk3cxz0Sr4aw+Ozx7Va2JUxjCoRB3QdZv2qAjM3ByB5RPl
         rDBctWhdwwCZ+UWTZmvDpsU6wAb/ZkGPEw6J6qiOMJAa6EeTRO72PrDR+6RsUZU+lUbN
         bJ0A==
X-Gm-Message-State: AOAM532BerlzjPFb5HUXn82crkAKUmZ3B82SsyAedWtph9PxJ2L1b80U
        6MqHh+skMEjz2JLv/SU6VIBqMw==
X-Google-Smtp-Source: ABdhPJyCDlvg27R0NeK9fiNu24mYjWTGONaf2bH93PwlJiVoqAlXvNA+Zm7V8RShC8WEKnTBf43I4A==
X-Received: by 2002:a17:903:248:: with SMTP id j8mr2911531plh.123.1644606831610;
        Fri, 11 Feb 2022 11:13:51 -0800 (PST)
Received: from dev-hv.mshome.net (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id bj26sm19581012pgb.81.2022.02.11.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:13:51 -0800 (PST)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>, Peter Oskolkov <posk@posk.io>
Subject: [PATCH] RFC: sched: UMCG: episode IV: A New Hope
Date:   Fri, 11 Feb 2022 19:13:46 +0000
Message-Id: <20220211191346.280415-1-posk@google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of effort has been put into making UMCG based on
userspace TLS data work, and it gets ugly very fast because
it is very hard to guarantee that the pages are present
when needed; and they are needed in non-preemptible (sched)
contexts. The last attempt here:
https://lore.kernel.org/lkml/20220120155517.066795336@infradead.org/
is a good example: a lot of mm-related work, a lot of
extra stuff added to struct task_struct just to deal
with kernel-to-userspace writes in sched contexts.

Here I propose a different approach (actually, it was my first approach,
before we pivoted to userspace TLS). Keep everything the kernel
needs in a kernel-side struct umcg_task, and copy relevant
data out to the userspace when the server's sys_umcg_wait() returns.

Before I go too deep down into implementing and testing this,
I'd like to get some feedback re: if this approach is acceptable.

Please review.

=====================

User Managed Concurrency Groups is an M:N threading toolkit that allows
constructing user space schedulers designed to efficiently manage
heterogeneous in-process workloads while maintaining high CPU
utilization (95%+).

Add UMCG syscall stubs, Kconfig, as well as stubs for hooks into
sched, execve, etc., as this boilerplate is more or less stable,
comparing to various approaches attempted at implementing UMCG.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 fs/exec.c                              |   1 +
 include/linux/sched.h                  |  49 ++++++
 include/linux/syscalls.h               |   7 +-
 include/uapi/asm-generic/unistd.h      |   7 +-
 include/uapi/linux/umcg.h              | 232 +++++++++++++++++++++++++
 init/Kconfig                           |  15 ++
 kernel/entry/common.c                  |   4 +-
 kernel/exit.c                          |   5 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  11 +-
 kernel/sched/umcg.c                    | 109 ++++++++++++
 kernel/sys_ni.c                        |   4 +
 14 files changed, 442 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc76949a..bcc97d7f0145 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -249,6 +249,7 @@ config X86
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UMCG			if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..0d266f4a3dd6 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,8 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	umcg_wait		sys_umcg_wait
+452	common	umcg_kick		sys_umcg_kick
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..6c42749c1c58 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1842,6 +1842,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	umcg_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 508b91d57470..0b16a50c82d8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -67,6 +67,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct umcg_task;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1299,6 +1300,10 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_UMCG
+	struct umcg_task		*umcg_task;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
@@ -1695,6 +1700,13 @@ extern struct pid *cad_pid;
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
@@ -2316,6 +2328,43 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+#ifdef CONFIG_UMCG
+
+extern void umcg_notify_resume(void);
+
+/* Called by do_exit() in kernel/exit.c. */
+extern void umcg_handle_exit(void);
+
+/* Called by bprm_execve() in fs/exec.c. */
+extern void umcg_execve(struct task_struct *tsk);
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
+static inline void umcg_notify_resume(void)
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
 const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
 char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
 int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 819c0cb00b6d..3ed99aa49bb8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -178,9 +178,9 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 	SYSCALL_TRACE_EXIT_EVENT(sname);			\
 	static struct syscall_metadata __used			\
 	  __syscall_meta_##sname = {				\
-		.name 		= "sys"#sname,			\
+		.name		= "sys"#sname,			\
 		.syscall_nr	= -1,	/* Filled in at boot */	\
-		.nb_args 	= nb,				\
+		.nb_args	= nb,				\
 		.types		= nb ? types_##sname : NULL,	\
 		.args		= nb ? args_##sname : NULL,	\
 		.enter_event	= &event_enter_##sname,		\
@@ -1060,6 +1060,9 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_umcg_wait(u64 flags, pid_t next_tid, u64 abs_timeout,
+			      u64 __user *workers, u64 worker_id_or_sz);
+asmlinkage long sys_umcg_kick(u32 flags, pid_t tid);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1c48b0ae3ba3..68406e99d0a7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,13 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_umcg_wait 451
+__SYSCALL(__NR_umcg_wait, sys_umcg_wait)
+#define __NR_umcg_kick 452
+__SYSCALL(__NR_umcg_kick, sys_umcg_kick)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
new file mode 100644
index 000000000000..b07fe7032dc8
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,232 @@
+#ifndef _UAPI_LINUX_UMCG_H
+#define _UAPI_LINUX_UMCG_H
+
+#include <linux/types.h>
+
+/*
+ * UMCG: User Managed Concurrency Groups.
+ *
+ * Syscalls, documented below and implemented in kernel/sched/umcg.c:
+ *      sys_umcg_wait()  - wait/wake/context-switch;
+ *      sys_umcg_kick()  - prod a UMCG task.
+ *
+ * UMCG workers have the following internal states:
+ *
+ *      .-----------------------.
+ *      |                       |
+ *      |                       v
+ *   RUNNING --> BLOCKED --> RUNNABLE
+ *      ^                       |
+ *      |                       |
+ *      .-----------------------.
+ *
+ *  RUNNING -> BLOCKED  transition happens when the worker blocks in the
+ *                      kernel in I/O, pagefault, futex, etc.
+ *                      UMCG_WORKER_BLOCK event will be delivered
+ *                      to the worker's server
+ *
+ *  RUNNING -> RUNNABLE transition happens when the worker calls
+ *                      sys_umcg_wait() (UMCG_WORKER_WAIT event) or
+ *                      when the worker is preempted via sys_umcg_kick()
+ *                      (UMCG_WORKER_PREEMPT event)
+ *
+ *  RUNNABLE -> RUNNING transition happens when the worker is "scheduled"
+ *                      by a server via sys_umcg_wait() (no events are
+ *                      delivered to the server in this case)
+ *
+ * Note that umcg_kick() can race with the worker calling a blocking
+ * syscall; in this case the worker enters BLOCKED state, and both
+ * BLOCK and PREEMPT events are delivered to the server.
+ *
+ * So the high-level usage pattern is like this:
+ * servers:
+ *  // server loop
+ *     bool start = true;
+ *     struct umcg_worker_event *events = malloc(...);
+ *
+ *     while (!stop) {
+ *         pid_t next_worker = 0;
+ *
+ *         int ret = sys_umcg_wait(start ? UMCG_NEW_SERVER : 0, 0 ,
+ *                                 0, events, event_sz);
+ *         start = false;
+ *
+ *         if (ret > 0)
+ *             next_worker = scheduler_process_events(events, ret);
+ *         if (next_worker)
+ *             ret = sys_umcg_wait(0, next_worker, 0, events, event_sz);
+ *     }
+ *
+ * Workers will start by calling
+ *     sys_umcg_wait(UMCG_NEW_WORKER, 0, 0, NULL, worker_id);
+ * and then potentially yielding by calling
+ *     sys_umcg_wait(0, 0, 0, NULL, 0);
+ * or cooperatively context-switching by calling
+ *     sys_umcg_wait(0, next_worker_tid, 0, NULL, 0).
+ *
+ * See below for more details.
+ */
+
+/**
+ * enum umcg_event_type - types of worker events delivered to UMCG servers
+ * @UMCG_WORKER_BLOCK:      the worker blocked in kernel in any way
+ *                          (e.g. I/O, pagefault, futex, etc.) other than
+ *                          in sys_umcg_wait()
+ * @UMCG_WORKER_WAKE:       the worker blocking operation, previously
+ *                          indicated by @UMCG_WORKER_BLOCK, has
+ *                          completed, and the worker can now be "scheduled"
+ * @UMCG_WORKER_PREEMPT:    the worker has been preempted via umcg_kick
+ *                          note: can race with BLOCK, i.e. a running
+ *                          worker generate a combined BLOCK | PREEMPT
+ *                          event
+ * @UMCG_WORKER_WAIT:       the worker blocked in kernel by calling
+ *                          sys_umcg_wait()
+ * @UMCG_WORKER_EXIT:       the worker thread exited or unregistered
+ *
+ */
+enum umcg_event_type {
+	UMCG_WORKER_BLOCK	= 0x0001,
+	UMCG_WORKER_WAKE	= 0x0002,
+	UMCG_WORKER_PREEMPT	= 0x0004,
+	UMCG_WORKER_WAIT	= 0x0008,
+	UMCG_WORKER_EXIT	= 0x0010,
+};
+
+/**
+ * struct umcg_worker_event - indicates one or more worker state transitions.
+ * @worker_id:          the ID of the worker (se sys_umcg_wait())
+ * @worker_event_type:  ORed values from umcg_event_type
+ * @counter:            a monotonically increasing wraparound counter,
+ *                      per worker,of events delivered to the userspace;
+ *                      if the event represents several distinct events (ORed), the
+ *                      counter will reflect that number (e.g. if
+ *                      @worker_event_type == BLOCK | WAKE, the counter
+ *                      will increment by 2).
+ *
+ * Worker events are delivered to UMCG servers upon their return from
+ * sys_umcg_wait().
+ */
+struct umcg_worker_event {
+	u64	worker_id;
+	u32	worker_event_type;
+	u32	counter;
+	/* maybe instead of @counter there should be a @timestamp or two? */
+} __attribute__((packed, aligned(64)));
+
+/**
+ * enum umcg_wait_flag - flags to pass to sys_umcg_wait
+ * @UMCG_NEW_WORKER:     register the current task as a UMCG worker
+ * @UMCG_NEW_SERVER:     register the current task as a UMCG server
+ * @UMCG_UNREGISTER:     unregister the current task as a UMCG task
+ *
+ *
+ * @UMCG_CLOCK_REALTIME: treat @abs_timeout as realtime clock value
+ * @UMCG_CLOCK_TAI:      treat @abs_timeout as TAI clock value
+ *                       (default: treat @abs_timeout as MONOTONIC clock value)
+ */
+enum umcg_wait_flag {
+	UMCG_NEW_WORKER		= 0x00001,
+	UMCG_NEW_SERVER		= 0x00002,
+	UMCG_UNREGISTER		= 0x00004,
+
+	UMCG_CLOCK_REALTIME	= 0x10000,
+	UMCG_CLOCK_TAI		= 0x20000,
+};
+
+/*
+ * int sys_umcg_wait(u64 flags, pid_t next_tid, u64 abs_timeout,
+ *                   struct umcg_worker_event __user *events,
+ *                   u64 event_sz_or_worker_id);
+ *
+ * sys_umcg_wait() context switches, synchronously on-CPU if possible,
+ *                 from the currently running thread to @next_tid; also
+ *                 @events is used to deliver worker events to servers.
+ *
+ * @flags:         ORed values from enum umcg_wait_flag.
+ *                 - UMCG_NEW_WORKER    : register the current thread
+ *                                        as a new UMCG worker;
+ *                 - UMCG_NEW_SERVER    : register the current thread
+ *                                        as a new UMCG server;
+ *                 - UMCG_UNREGISTER    : unregister the current thread
+ *                                        as a UMCG task; will not block;
+ *                                        all other parameters must be zeroes.
+ *
+ *                                        if the current thread is a worker,
+ *                                        UMCG_WORKER_EXIT event will be
+ *                                        delivered to its server;
+ *
+ *                if @abs_timeout is not zero, @flags may contain one of the
+ *                UMCG_CLOCK_XXX bits to indicate which clock to use; if
+ *                none of the CLOCK bits are set, the MONOTONIC clock is used;
+ *
+ * @next_tid: tid of the UMCG task to context switch to;
+ *
+ *         if the current thread is a server, @next_tid must be either
+ *         that of a worker, or zero; if @next_tid is a worker, and there
+ *         are no events waiting for this server, sys_umcg_wait() will
+ *         context switch to the worker; if there _are_ events, sys_umcg_wait()
+ *         will wake the worker and immediately return with @events
+ *         populated;
+ *         if the current thread is a server, and @next_tid is zero,
+ *         sys_umcg_wait() will block until there are worker events for
+ *         for this server to consume, or sys_umcg_kick() is called (or
+ *         timeout exipired);
+ *
+ *         if the current thread is a worker, sys_umcg_wait() will block;
+ *         if @next_tid is zero, UMCG_WORKER_WAIT event will be delivered
+ *         to the worker's server; if @next_tid is a RUNNABLE worker,
+ *         sys_umcg_wait() will context-switch to that worker, without
+ *         any events generated;
+ *
+ *         Note: if a worker calls sys_umcg_wait() with @next_tid as zero,
+ *               its server should be woken so that it can schedule another
+ *               worker in place of the waiting worker; if the worker
+ *               cooperatively context-switches into another worker,
+ *               its server does not really need to do anything, so no
+ *               new events are generated;
+ *
+ * @abs_timeout: if not zero, and the current thread is a server,
+ *               sys_umcg_wait will wake; if the current thread is a worker,
+ *               the worker will remain RUNNABLE, but UMCG_WORKER_WAKE
+ *               event will be delivered to its server; in this case
+ *               sys_umcg_wait() will return -ETIMEDOUT when the worker
+ *               is eventually scheduled by a server;
+ *
+ * @events: a block of memory that is used to deliver worker events to
+ *          their servers; must be NOT NULL if the current thread is
+ *          a server; must be NULL if the current thread is a worker;
+ *
+ * @event_sz_or_worker_id: if the current thread is a server, indicates
+ *                         the number of struct umcg_worker_event the @events
+ *                         buffer can accommodate;
+ *
+ *                         if the current thread is a worker, must be
+ *                         zero unless UMCG_NEW_WORKER flag is set,
+ *                         in which case it must indicate a
+ *                         userspace-provided worker ID, usually
+ *                         a pointer to a TLS struct holding the worker's
+ *                         userspace state;
+ *
+ *
+ * Returns:
+ * 0		- Ok;
+ * >0		- the number of worker events in @events;
+ * -ESRCH	- @next_tid is not a UMCG task;
+ * -ETIMEDOUT	- @abs_timeout expired;
+ * -EINVAL	- another error;
+ */
+
+/*
+ * int sys_umcg_kick(u32 flags, pid_t tid) - preempts a running UMCG worker
+ *                                           or wakes a sleeping UMCG server.
+ *
+ * See sys_umcg_wait() for more details.
+ *
+ * Returns:
+ * 0		- Ok;
+ * -EAGAIN	- the worker is not running or the server is not sleeping;
+ * -ESRCH	- not a related UMCG task;
+ * -EINVAL	- another error happened (unknown flags, etc..).
+ */
+
+#endif /* _UAPI_LINUX_UMCG_H */
diff --git a/init/Kconfig b/init/Kconfig
index e9119bf54b1f..75a623deb8cc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1685,6 +1685,21 @@ config MEMBARRIER
 
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
index bad713684c2e..081c3d5b4197 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -171,8 +171,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			handle_signal_work(regs, ti_work);
 
-		if (ti_work & _TIF_NOTIFY_RESUME)
+		if (ti_work & _TIF_NOTIFY_RESUME) {
+			umcg_notify_resume();
 			tracehook_notify_resume(regs);
+		}
 
 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25bb4ab9..bf0e4c95fb77 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -737,6 +737,10 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(blk_needs_flush_plug(tsk));
 
+	/* Turn off UMCG sched hooks. */
+	if (unlikely(tsk->flags & PF_UMCG_WORKER))
+		tsk->flags &= ~PF_UMCG_WORKER;
+
 	/*
 	 * If do_dead is called because this processes oopsed, it's possible
 	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
@@ -760,6 +764,7 @@ void __noreturn do_exit(long code)
 
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
+	umcg_handle_exit();
 
 	/* sync mm's RSS info before statistics gathering */
 	if (tsk->mm)
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c83b37af155b..0da21064aa71 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
 obj-$(CONFIG_SCHED_CORE) += core_sched.o
+obj-$(CONFIG_UMCG) += umcg.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0fded9fd1cd3..3a58592fe391 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4273,6 +4273,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+#ifdef CONFIG_UMCG
+	p->umcg_task = NULL;
+#endif
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -6331,9 +6334,11 @@ static inline void sched_submit_work(struct task_struct *tsk)
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
@@ -6351,9 +6356,11 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
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
index 000000000000..aaf18a47798d
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * User Managed Concurrency Groups (UMCG).
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/umcg.h>
+
+/**
+ * struct umcg_task - describes a server or a worker
+ *
+ * Allocated when the task registers (UMCG_NEW_WORKER/UMCG_NEW_SERVER),
+ * deallocated when the worker exits or unregisters, and the last event
+ * is consumed if worker, or when the server exits or unregisters (without
+ * workers).
+ */
+struct umcg_task {
+	/**
+	 * @worker: is this a worker or a server.
+	 */
+	bool	worker;
+
+	/**
+	 * @worker_events: list of worker events. Consumed (copied out to
+	 *                 sys_umcg_wait()'s @events, with all references
+	 *                 NULL-ed) when the server's sys_umcg_wait() returned.
+	 *
+	 * The server's @worker_events is the head; the workers' @worker_events
+	 * are added to their server's list when the event happens; if
+	 * multiple events happen for a worker, they are ORed in @worker_event.
+	 */
+	struct list_head	worker_events;
+
+	/**
+	 * @workers: lists all workers belonging to the same server. The
+	 *           server's @workers is the head.
+	 */
+	struct list_head	workers;
+
+	/* fields below are valid only for workers */
+
+	/**
+	 * @server: points to the server this worker belongs to. Not NULL.
+	 */
+	struct task_struct	*server;
+
+	/**
+	 * @worker_event: contains worker event(s) to be delivered
+	 *                to the worker's server
+	 *
+	 * @worker_event.worker_id - a constant worker id specified
+	 *                           upon worker registration; never
+	 *                           changes;
+	 *
+	 * @worker_event.worker_event_type - ORed values from
+	 *                                   enum umcg_event_type;
+	 *                                   cleared when the event
+	 *                                   is copied out to the server's
+	 *                                   @events;
+	 *
+	 * @worker_event.counter - incremented (wraparound) upon each new
+	 *                         event (TBD: maybe have timestamps instead?)
+	 */
+	struct umcg_worker_event	worker_event;
+
+	/* Maybe we will need a spin lock here. TBD. */
+};
+
+void umcg_notify_resume(void)
+{
+}
+void umcg_execve(struct task_struct *tsk)
+{
+}
+void umcg_handle_exit(void)
+{
+}
+void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+}
+void umcg_wq_worker_running(struct task_struct *tsk)
+{
+}
+
+/**
+ * sys_umcg_kick: preempts a runnning UMCG worker or wakes a UMCG
+ *                server that is sleeping in sys_umcg_wait().
+ *
+ * Returns:
+ * 0		- Ok;
+ * -EAGAIN	- the worker is not running or the server is not sleeping;
+ * -ESRCH	- not a related UMCG task;
+ * -EINVAL	- another error happened (unknown flags, etc..).
+ */
+SYSCALL_DEFINE2(umcg_kick, u32, flags, pid_t, tid)
+{
+	return -ENOSYS;
+}
+
+SYSCALL_DEFINE5(umcg_wait, u64, flags, pid_t, next_tid, u64, abs_timeout,
+		struct umcg_worker_event __user *, events,
+		u64, event_sz_or_worker_id)
+{
+	return -ENOSYS;
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index a492f159624f..122f79a2ccb9 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -275,6 +275,10 @@ COND_SYSCALL(landlock_restrict_self);
 
 /* arch/example/kernel/sys_example.c */
 
+/* kernel/sched/umcg.c */
+COND_SYSCALL(umcg_wait);
+COND_SYSCALL(umcg_kick);
+
 /* mm/fadvise.c */
 COND_SYSCALL(fadvise64_64);
 
-- 
2.25.1

