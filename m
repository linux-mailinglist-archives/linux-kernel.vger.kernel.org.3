Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51164A9DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376942AbiBDRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377029AbiBDRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Mfung302/SpJCvpSlsGBV5kOQwbrpYWh32oOdHGTyU0=;
        b=Lf8yjYdhLIaKjwUohHejBGWOb8s6mi32LK2RWBCLtThQsrzfGlbO+tTf+wd7Aps6RLU9DQ
        1wVT1xa23y43C9vur568BnLz25laJgKw5krWF/HjDrhf7VLCwJ1roahdI/e+VL8gp16vEB
        FwIq7sV9Bn+hueXU6wJp+XicawxvVag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-VIdGju0EMwmsXYf3rP9hhg-1; Fri, 04 Feb 2022 12:37:31 -0500
X-MC-Unique: VIdGju0EMwmsXYf3rP9hhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DB0B1091DA1;
        Fri,  4 Feb 2022 17:37:30 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CF237A425;
        Fri,  4 Feb 2022 17:37:11 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 831F3416D8BE; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173554.676117258@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:42 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v11 05/13] task isolation: sync vmstats on return to userspace
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:

1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
2) app runs mlock, which increases counters for mlock'ed pages.
3) start -RT loop

Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
the mlock, vmstat shepherd can restart vmstat worker thread on
the CPU in question.

To fix this, use the task isolation prctl interface to quiesce 
deferred actions when returning to userspace.

This patch adds hooks to fork and exit code paths.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v11: fold patch to add task_isol_exit hooks (Frederic)
     Use _TIF_TASK_ISOL bit on thread flags (Frederic)
     
v6: modify exit_to_user_mode_loop to cover exceptions and interrupts
v5: no changes
v4: add oneshot mode support

 include/linux/task_isolation.h |   16 ++++++++++++++++
 include/linux/vmstat.h         |    8 ++++++++
 kernel/entry/common.c          |   15 +++++++++++----
 kernel/task_isolation.c        |   21 +++++++++++++++++++++
 mm/vmstat.c                    |   21 +++++++++++++++++++++
 5 files changed, 77 insertions(+), 4 deletions(-)

Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -27,6 +27,13 @@ static inline void task_isol_free(struct
 		__task_isol_free(tsk);
 }
 
+void __task_isol_exit(struct task_struct *tsk);
+static inline void task_isol_exit(struct task_struct *tsk)
+{
+	if (tsk->task_isol_info)
+		__task_isol_exit(tsk);
+}
+
 int prctl_task_isol_feat_get(unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4, unsigned long arg5);
 int prctl_task_isol_cfg_get(unsigned long arg2, unsigned long arg3,
@@ -40,12 +47,22 @@ int prctl_task_isol_activate_set(unsigne
 
 int __copy_task_isol(struct task_struct *tsk);
 
+void task_isol_exit_to_user_mode(void);
+
 #else
 
+static inline void task_isol_exit_to_user_mode(void)
+{
+}
+
 static inline void task_isol_free(struct task_struct *tsk)
 {
 }
 
+static inline void task_isol_exit(struct task_struct *tsk)
+{
+}
+
 static inline int prctl_task_isol_feat_get(unsigned long arg2,
 					   unsigned long arg3,
 					   unsigned long arg4,
Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h
+++ linux-2.6/include/linux/vmstat.h
@@ -21,6 +21,14 @@ int sysctl_vm_numa_stat_handler(struct c
 		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
+#if defined(CONFIG_SMP) && defined(CONFIG_TASK_ISOLATION)
+void sync_vmstat(void);
+#else
+static inline void sync_vmstat(void)
+{
+}
+#endif
+
 struct reclaim_stat {
 	unsigned nr_dirty;
 	unsigned nr_unqueued_dirty;
Index: linux-2.6/kernel/entry/common.c
===================================================================
--- linux-2.6.orig/kernel/entry/common.c
+++ linux-2.6/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/task_isolation.h>
 
 #include "common.h"
 
@@ -174,6 +175,9 @@ static unsigned long exit_to_user_mode_l
 		if (ti_work & _TIF_NOTIFY_RESUME)
 			tracehook_notify_resume(regs);
 
+		if (ti_work & _TIF_TASK_ISOL)
+			task_isol_exit_to_user_mode();
+
 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
 
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -18,6 +18,12 @@
 #include <linux/sysfs.h>
 #include <linux/init.h>
 #include <linux/sched/task.h>
+#include <linux/mm.h>
+#include <linux/vmstat.h>
+
+void __task_isol_exit(struct task_struct *tsk)
+{
+}
 
 void __task_isol_free(struct task_struct *tsk)
 {
@@ -251,6 +257,9 @@ static int cfg_feat_quiesce_set(unsigned
 	task_isol_info->quiesce_mask = i_qctrl->quiesce_mask;
 	task_isol_info->oneshot_mask = i_qctrl->quiesce_oneshot_mask;
 	task_isol_info->conf_mask |= ISOL_F_QUIESCE;
+	if (task_isol_info->quiesce_mask & ISOL_F_QUIESCE_VMSTATS)
+		set_thread_flag(TIF_TASK_ISOL);
+
 	ret = 0;
 
 out_free:
@@ -303,6 +312,7 @@ int __copy_task_isol(struct task_struct
 		new_info->active_mask = info->active_mask;
 
 	tsk->task_isol_info = new_info;
+	set_ti_thread_flag(task_thread_info(tsk), TIF_TASK_ISOL);
 
 	return 0;
 }
@@ -328,6 +338,7 @@ int prctl_task_isol_activate_set(unsigne
 		return ret;
 
 	task_isol_info->active_mask = active_mask;
+	set_thread_flag(TIF_TASK_ISOL);
 	ret = 0;
 
 out:
@@ -349,3 +360,24 @@ int prctl_task_isol_activate_get(unsigne
 
 	return 0;
 }
+
+void task_isol_exit_to_user_mode(void)
+{
+	struct task_isol_info *i;
+
+	clear_thread_flag(TIF_TASK_ISOL);
+
+	i = current->task_isol_info;
+	if (!i)
+		return;
+
+	if (i->active_mask != ISOL_F_QUIESCE)
+		return;
+
+	if (i->quiesce_mask & ISOL_F_QUIESCE_VMSTATS) {
+		sync_vmstat();
+		if (i->oneshot_mask & ISOL_F_QUIESCE_VMSTATS)
+			i->quiesce_mask &= ~ISOL_F_QUIESCE_VMSTATS;
+	}
+}
+EXPORT_SYMBOL_GPL(task_isol_exit_to_user_mode);
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -2018,6 +2018,29 @@ static void vmstat_shepherd(struct work_
 		round_jiffies_relative(sysctl_stat_interval));
 }
 
+#ifdef CONFIG_TASK_ISOLATION
+void sync_vmstat(void)
+{
+	int cpu;
+
+	cpu = get_cpu();
+
+	refresh_cpu_vm_stats(false);
+	put_cpu();
+
+	/*
+	 * If task is migrated to another CPU between put_cpu
+	 * and cancel_delayed_work_sync, the code below might
+	 * cancel vmstat_update work for a different cpu
+	 * (than the one from which the vmstats were flushed).
+	 *
+	 * However, vmstat shepherd will re-enable it later,
+	 * so its harmless.
+	 */
+	cancel_delayed_work_sync(&per_cpu(vmstat_work, cpu));
+}
+#endif
+
 static void __init start_shepherd_timer(void)
 {
 	int cpu;
Index: linux-2.6/include/linux/entry-common.h
===================================================================
--- linux-2.6.orig/include/linux/entry-common.h
+++ linux-2.6/include/linux/entry-common.h
@@ -60,7 +60,7 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
+	 _TIF_TASK_ISOL | ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
  * arch_check_user_regs - Architecture specific sanity check for user mode regs
Index: linux-2.6/kernel/exit.c
===================================================================
--- linux-2.6.orig/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/compat.h>
 #include <linux/io_uring.h>
 #include <linux/kprobes.h>
+#include <linux/task_isolation.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -759,6 +760,7 @@ void __noreturn do_exit(long code)
 	validate_creds_for_do_exit(tsk);
 
 	io_uring_files_cancel();
+	task_isol_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	/* sync mm's RSS info before statistics gathering */
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -2417,6 +2417,7 @@ bad_fork_free_pid:
 	if (pid != &init_struct_pid)
 		free_pid(pid);
 bad_fork_cleanup_task_isol:
+	task_isol_exit(p);
 	task_isol_free(p);
 bad_fork_cleanup_thread:
 	exit_thread(p);


