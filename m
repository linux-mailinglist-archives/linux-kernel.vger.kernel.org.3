Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3503E4F8C2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiDHDED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiDHDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EEE71FCCC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649386918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jCX1y8YkYErXqxbU75JYgSzh157PLJ3whtneCBmV6f8=;
        b=iDZDfT6L0gkCgRc8xcTuNoMveSWFUZm+OnO7eH0LOOT4pj12M8lKum9r9ZpMH15+G7DG1F
        5Wy+wklad/ixbfT/MqKdnb8bvouTukdBd30BMw9pJVU8PETc6XEPvHs3AAeLGSbhdrYZZH
        uzINf+xPe97DdGKuw531eo9GusNqhbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-wMSkZ1nuOWm41HQS1PXQZg-1; Thu, 07 Apr 2022 23:01:55 -0400
X-MC-Unique: wMSkZ1nuOWm41HQS1PXQZg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14272800882;
        Fri,  8 Apr 2022 03:01:55 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.19.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1BDB40317B;
        Fri,  8 Apr 2022 03:01:53 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: [PATCH v7] oom_kill.c: futex: Don't OOM reap the VMA containing the robust_list_head
Date:   Thu,  7 Apr 2022 23:01:37 -0400
Message-Id: <20220408030137.3693195-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
be targeted by the oom reaper. This mapping is used to store the futex
robust list head; the kernel does not keep a copy of the robust list and
instead references a userspace address to maintain the robustness during
a process death. A race can occur between exit_mm and the oom reaper that
allows the oom reaper to free the memory of the futex robust list before
the exit path has handled the futex death:

    CPU1                               CPU2
------------------------------------------------------------------------
    page_fault
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

If the get_user EFAULT's, the kernel will be unable to recover the
waiters on the robust_list, leaving userspace mutexes hung indefinitely.

Use the robust_list address stored in the kernel to skip the VMA that holds
it, allowing a successful futex_cleanup.

Theoretically a failure can still occur if there are locks mapped as
PRIVATE|ANON; however, the robust futexes are a best-effort approach.
This patch only strengthens that best-effort.

The following case can still fail:
robust head (skipped) -> private lock (reaped) -> shared lock (skipped)

Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer

[1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370

Fixes: 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Christoph von Recklinghausen <crecklin@redhat.com>
Cc: Don Dutile <ddutile@redhat.com>
Cc: Herton R. Krzesinski <herton@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joel Savitz <jsavitz@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: stable@kernel.org
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/oom.h |  2 +-
 mm/mmap.c           |  8 +++++++-
 mm/oom_kill.c       | 31 ++++++++++++++++++++++++++++---
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..5253fcee049e 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -106,7 +106,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 	return 0;
 }
 
-bool __oom_reap_task_mm(struct mm_struct *mm);
+bool __oom_reap_task_mm(struct mm_struct *mm, void *robust_list);
 
 long oom_badness(struct task_struct *p,
 		unsigned long totalpages);
diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..d5af1b83cbb2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3109,6 +3109,11 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
+	void *robust_list;
+
+#ifdef CONFIG_FUTEX
+	robust_list = current->robust_list;
+#endif
 
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -3126,7 +3131,8 @@ void exit_mmap(struct mm_struct *mm)
 		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
 		 * __oom_reap_task_mm() will not block.
 		 */
-		(void)__oom_reap_task_mm(mm);
+		(void)__oom_reap_task_mm(mm, robust_list);
+
 		set_bit(MMF_OOM_SKIP, &mm->flags);
 	}
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 7ec38194f8e1..f856d8dd53e1 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -509,9 +509,10 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
 static struct task_struct *oom_reaper_list;
 static DEFINE_SPINLOCK(oom_reaper_lock);
 
-bool __oom_reap_task_mm(struct mm_struct *mm)
+bool __oom_reap_task_mm(struct mm_struct *mm, void *robust_list)
 {
 	struct vm_area_struct *vma;
+	unsigned long skip_vma = (unsigned long) robust_list;
 	bool ret = true;
 
 	/*
@@ -526,6 +527,20 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
 
+#ifdef CONFIG_FUTEX
+		/*
+		 * The OOM reaper runs concurrently with do_exit.
+		 * The robust_list_head is stored in userspace and is required
+		 * by the exit path to recover the robust futex waiters.
+		 * Skip the VMA that contains the robust_list to allow for
+		 * proper cleanup.
+		 */
+		if (vma->vm_start <= skip_vma && vma->vm_end > skip_vma) {
+			pr_info("oom_reaper: skipping vma, contains robust_list");
+			continue;
+		}
+#endif
+
 		/*
 		 * Only anonymous pages have a good chance to be dropped
 		 * without additional steps which we cannot afford as we
@@ -567,6 +582,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 {
 	bool ret = true;
+	void *robust_list;
 
 	if (!mmap_read_trylock(mm)) {
 		trace_skip_task_reaping(tsk->pid);
@@ -586,8 +602,11 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 
 	trace_start_task_reaping(tsk->pid);
 
+#ifdef CONFIG_FUTEX
+	robust_list = tsk->robust_list;
+#endif
 	/* failed to reap part of the address space. Try again later */
-	ret = __oom_reap_task_mm(mm);
+	ret = __oom_reap_task_mm(mm, robust_list);
 	if (!ret)
 		goto out_finish;
 
@@ -1149,6 +1168,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	unsigned int f_flags;
 	bool reap = false;
 	long ret = 0;
+	void *robust_list;
 
 	if (flags)
 		return -EINVAL;
@@ -1186,11 +1206,16 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		ret = -EINTR;
 		goto drop_mm;
 	}
+
+#ifdef CONFIG_FUTEX
+	robust_list = p->robust_list;
+#endif
 	/*
 	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
 	 * possible change in exit_mmap is seen
 	 */
-	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
+	if (!test_bit(MMF_OOM_SKIP, &mm->flags) &&
+			!__oom_reap_task_mm(mm, robust_list))
 		ret = -EAGAIN;
 	mmap_read_unlock(mm);
 
-- 
2.35.1

