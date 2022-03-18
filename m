Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5355C4DD39D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiCRDiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiCRDiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B8F2B244A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647574615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zxGXQ8pyGz1TR5bJw25kI48yQ0iV5cJOtc0fF/w965w=;
        b=NKz1ht/h3t1LnRJ/fbvL7dNaE9pT9Q6/W+Vb4ANQLFHM7O5QpbSAbiSkghfDGZP80/lHtZ
        gyLoHOm+BzqLSscYy7YOQ7OzGOqJncBTduo1TfCBawBiGoqzFCEadKfJvF4CmIlOE3R3eM
        pO24UzwHmJg8THi/K4YRvpyF/Kh8NyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-58BrhHofNuOBtxs6M3Tb1g-1; Thu, 17 Mar 2022 23:36:52 -0400
X-MC-Unique: 58BrhHofNuOBtxs6M3Tb1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80272811E80;
        Fri, 18 Mar 2022 03:36:51 +0000 (UTC)
Received: from localhost.net (unknown [10.22.16.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEA291402400;
        Fri, 18 Mar 2022 03:36:49 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit and the oom_reaper
Date:   Thu, 17 Mar 2022 21:36:21 -0600
Message-Id: <20220318033621.626006-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
be targeted by the oom reaper. This mapping is used to store the futex
robust list; the kernel does not keep a copy of the robust list and instead
references a userspace address to maintain the robustness during a process
death. A race can occur between exit_mm and the oom reaper that allows
the oom reaper to free the memory of the futex robust list before the
exit path has handled the futex death:

    CPU1                               CPU2
------------------------------------------------------------------------
    page_fault
    out_of_memory
    do_exit "signal"
    wake_oom_reaper
					oom_reaper
                        		oom_reap_task_mm (invalidates mm)
    exit_mm
    exit_mm_release
    futex_exit_release
    futex_cleanup
    exit_robust_list
    get_user (EFAULT- can't access memory)

While in the oom reaper thread, we must handle the futex cleanup without
sleeping. To achieve this, add the boolean `try` to futex_exit_begin().
This will control weather or not we use a trylock. Also introduce
try_futex_exit_release() which will utilize the trylock version of the
futex_cleanup_begin(). Also call kthread_use_mm in this context to assure
the get_user call in futex_cleanup() does not return with EFAULT.

If the robust list exists, and the mutex_trylock fails, we prevent the OOM
reaper from concurrently reaping the mappings. If the dying task_struct
does not contain a pointer in tsk->robust_list, we can assume there was
either never one setup for this task struct, or the exit path's call to
futex_cleanup() has properly handled the futex death, and we can safely
reap this memory.

Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer

[1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370

Fixes: 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Christoph von Recklinghausen <crecklin@redhat.com>
Cc: Don Dutile <ddutile@redhat.com>
Cc: Herton R. Krzesinski <herton@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Andre Almeida <andrealmeid@collabora.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/futex.h | 14 ++++++++++++++
 kernel/futex/core.c   | 35 +++++++++++++++++++++++++++++++----
 mm/oom_kill.c         | 13 +++++++++++++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85..64d6e89294ac 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -71,9 +71,21 @@ static inline void futex_init_task(struct task_struct *tsk)
 	mutex_init(&tsk->futex_exit_mutex);
 }
 
+static inline bool task_has_robust_list(struct task_struct *tsk)
+{
+	bool robust = false;
+
+	robust = tsk->robust_list != NULL;
+#ifdef CONFIG_COMPAT
+	robust |= tsk->compat_robust_list != NULL;
+#endif
+	return robust;
+}
+
 void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
 void futex_exec_release(struct task_struct *tsk);
+bool try_futex_exit_release(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
@@ -82,6 +94,8 @@ static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
+static inline bool task_has_robust_list(struct task_struct *tsk) { return false; }
+static inline bool try_futex_exit_release(struct task_struct *tsk) { return true; }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 			    ktime_t *timeout, u32 __user *uaddr2,
 			    u32 val2, u32 val3)
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 51dd822a8060..81aa60ce1ed6 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -37,6 +37,7 @@
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -1047,7 +1048,7 @@ void futex_exit_recursive(struct task_struct *tsk)
 	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
-static void futex_cleanup_begin(struct task_struct *tsk)
+static bool futex_cleanup_begin(struct task_struct *tsk, bool try)
 {
 	/*
 	 * Prevent various race issues against a concurrent incoming waiter
@@ -1055,7 +1056,12 @@ static void futex_cleanup_begin(struct task_struct *tsk)
 	 * tsk->futex_exit_mutex when it observes FUTEX_STATE_EXITING in
 	 * attach_to_pi_owner().
 	 */
-	mutex_lock(&tsk->futex_exit_mutex);
+	if (try) {
+		if (!mutex_trylock(&tsk->futex_exit_mutex))
+			return false;
+	} else {
+		mutex_lock(&tsk->futex_exit_mutex);
+	}
 
 	/*
 	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
@@ -1071,6 +1077,7 @@ static void futex_cleanup_begin(struct task_struct *tsk)
 	raw_spin_lock_irq(&tsk->pi_lock);
 	tsk->futex_state = FUTEX_STATE_EXITING;
 	raw_spin_unlock_irq(&tsk->pi_lock);
+	return true;
 }
 
 static void futex_cleanup_end(struct task_struct *tsk, int state)
@@ -1096,7 +1103,7 @@ void futex_exec_release(struct task_struct *tsk)
 	 * futex is held on exec(), this provides at least as much state
 	 * consistency protection which is possible.
 	 */
-	futex_cleanup_begin(tsk);
+	futex_cleanup_begin(tsk, false);
 	futex_cleanup(tsk);
 	/*
 	 * Reset the state to FUTEX_STATE_OK. The task is alive and about
@@ -1107,9 +1114,29 @@ void futex_exec_release(struct task_struct *tsk)
 
 void futex_exit_release(struct task_struct *tsk)
 {
-	futex_cleanup_begin(tsk);
+	futex_cleanup_begin(tsk, false);
+	futex_cleanup(tsk);
+	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
+}
+
+/* Try to perform the futex_cleanup and return true if successful.
+ * Designed to be called from the context of the OOM Reaper.
+ */
+bool try_futex_exit_release(struct task_struct *tsk)
+{
+	if (!futex_cleanup_begin(tsk, true))
+		return false;
+
+	/* We are calling this from the context of a kthread. We need to
+	 * instruct the kthread to use the address space of the given mm
+	 * so the get_user won't return -EFAULT.
+	 */
+	kthread_use_mm(tsk->mm);
 	futex_cleanup(tsk);
+	kthread_unuse_mm(tsk->mm);
+
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
+	return true;
 }
 
 static int __init futex_init(void)
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 832fb330376e..f7834c53d874 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -44,6 +44,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/futex.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -587,6 +588,18 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 		goto out_unlock;
 	}
 
+	/* We can't reap a process holding a robust_list; the pthread
+	 * struct is allocated in userspace using PRIVATE | ANONYMOUS
+	 * memory which when reaped before futex_cleanup() can leave
+	 * the waiting process stuck. Try to perform the futex_cleanup,
+	 * and if unsuccessful, skip the OOM reaping.
+	 */
+	if (task_has_robust_list(tsk) && !try_futex_exit_release(tsk)) {
+		trace_skip_task_reaping(tsk->pid);
+		pr_info("oom_reaper: skipping task as it contains a robust list");
+		goto out_finish;
+	}
+
 	trace_start_task_reaping(tsk->pid);
 
 	/* failed to reap part of the address space. Try again later */
-- 
2.35.1

