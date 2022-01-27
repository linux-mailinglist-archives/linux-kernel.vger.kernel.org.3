Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8313349E936
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiA0RjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:39:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244741AbiA0RjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643305142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6EOr+eqMhK6NBEqfwXNQrjcHehTwokP2i2J2TvsubJ4=;
        b=Gr0rxzTVAtaFLe811lXWCasddURsMGUG0loHlfC0HaKUQf5mcEKUjhL2rQMRUWjYLhVP+t
        8a1H73cTsxPA3yPcLhURJL1swa47xfPZQWUcycAIgEt/ANDOeUoRFnQDYqZKJscpfcavtE
        Wx7f0PFvNZAkv5NgXaSY0Ok1YpFzl2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427--a7AlBAbNsON7mGeRwuVbA-1; Thu, 27 Jan 2022 12:38:59 -0500
X-MC-Unique: -a7AlBAbNsON7mGeRwuVbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3DA1801B0F;
        Thu, 27 Jan 2022 17:38:57 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B972B7CD65;
        Thu, 27 Jan 2022 17:38:28 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 25C65416D5CA; Thu, 27 Jan 2022 14:38:05 -0300 (-03)
Message-ID: <20220127173206.501116509@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 27 Jan 2022 14:30:40 -0300
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
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v10 03/10] task isolation: sync vmstats on return to userspace
References: <20220127173037.318440631@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Keep task_isol_has_work returning 0 until all elements
are in place.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
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
@@ -40,8 +40,19 @@ int prctl_task_isol_activate_set(unsigne
 
 int __copy_task_isol(struct task_struct *tsk);
 
+void task_isol_exit_to_user_mode(void);
+
+static inline int task_isol_has_work(void)
+{
+       return 0;
+}
+
 #else
 
+static void task_isol_exit_to_user_mode(void)
+{
+}
+
 static inline void task_isol_free(struct task_struct *tsk)
 {
 }
@@ -86,6 +97,11 @@ static inline int prctl_task_isol_activa
 	return -EOPNOTSUPP;
 }
 
+static inline int task_isol_has_work(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_TASK_ISOLATION */
 
 #endif /* __LINUX_TASK_ISOL_H */
Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h
+++ linux-2.6/include/linux/vmstat.h
@@ -21,6 +21,14 @@ int sysctl_vm_numa_stat_handler(struct c
 		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
+#ifdef CONFIG_SMP
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
 
@@ -149,13 +150,14 @@ static void handle_signal_work(struct pt
 }
 
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-					    unsigned long ti_work)
+					    unsigned long ti_work,
+					    unsigned long task_isol_work)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
 	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
+	while ((ti_work & EXIT_TO_USER_MODE_WORK) || task_isol_work) {
 
 		local_irq_enable_exit_to_user(ti_work);
 
@@ -177,6 +179,9 @@ static unsigned long exit_to_user_mode_l
 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
 
+		if (task_isol_work)
+			task_isol_exit_to_user_mode();
+
 		/*
 		 * Disable interrupts and reevaluate the work flags as they
 		 * might have changed while interrupts and preemption was
@@ -188,6 +193,7 @@ static unsigned long exit_to_user_mode_l
 		tick_nohz_user_enter_prepare();
 
 		ti_work = read_thread_flags();
+		task_isol_work = task_isol_has_work();
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
@@ -197,14 +203,15 @@ static unsigned long exit_to_user_mode_l
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long ti_work = read_thread_flags();
+	unsigned long task_isol_work = task_isol_has_work();
 
 	lockdep_assert_irqs_disabled();
 
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK) || task_isol_work)
+		ti_work = exit_to_user_mode_loop(regs, ti_work, task_isol_work);
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -18,6 +18,8 @@
 #include <linux/sysfs.h>
 #include <linux/init.h>
 #include <linux/sched/task.h>
+#include <linux/mm.h>
+#include <linux/vmstat.h>
 
 void __task_isol_free(struct task_struct *tsk)
 {
@@ -349,3 +351,22 @@ int prctl_task_isol_activate_get(unsigne
 
 	return 0;
 }
+
+void task_isol_exit_to_user_mode(void)
+{
+	struct task_isol_info *i;
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
+			i->active_mask &= ~ISOL_F_QUIESCE_VMSTATS;
+	}
+}
+EXPORT_SYMBOL_GPL(task_isol_exit_to_user_mode);
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -2018,6 +2018,27 @@ static void vmstat_shepherd(struct work_
 		round_jiffies_relative(sysctl_stat_interval));
 }
 
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
+
 static void __init start_shepherd_timer(void)
 {
 	int cpu;


