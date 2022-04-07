Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237E04F873E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346917AbiDGSpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiDGSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C85311C71C0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649356996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gGh/iM6e6CHwEnjIl2Ke5DGcT+ij0WjuoxQf3hSUZQk=;
        b=NgbL6N5N+bITciwIjvygokNAy1zGBZNSn1scjtbRuehaOPD5gVBM9sguxa8Qq840IrqX3c
        kycXxKs8S6UbrapjX0CsCbjsQ76DZK0QgxWSkY5u2Hj36AntnvvA+kh+ubEs/8nowj9l9n
        qhDgwe4XfrjLkee9MW58mJtYY4kCrhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-J-mnCU6sNxuTWOZL5Y-9Tg-1; Thu, 07 Apr 2022 14:43:14 -0400
X-MC-Unique: J-mnCU6sNxuTWOZL5Y-9Tg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BFC2899EC4;
        Thu,  7 Apr 2022 18:43:13 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.19.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3624840D2848;
        Thu,  7 Apr 2022 18:43:12 +0000 (UTC)
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
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH v6] oom_kill.c: futex: Don't OOM reap the VMA containing the robust_list_head
Date:   Thu,  7 Apr 2022 14:42:54 -0400
Message-Id: <20220407184254.3612387-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/oom.h |  3 ++-
 mm/mmap.c           |  3 ++-
 mm/oom_kill.c       | 14 +++++++++++---
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..580c95a0541d 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -106,7 +106,8 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 	return 0;
 }
 
-bool __oom_reap_task_mm(struct mm_struct *mm);
+bool __oom_reap_task_mm(struct mm_struct *mm, struct robust_list_head
+		__user *robust_list);
 
 long oom_badness(struct task_struct *p,
 		unsigned long totalpages);
diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..c14fe6f8e9a5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3126,7 +3126,8 @@ void exit_mmap(struct mm_struct *mm)
 		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
 		 * __oom_reap_task_mm() will not block.
 		 */
-		(void)__oom_reap_task_mm(mm);
+		(void)__oom_reap_task_mm(mm, current->robust_list);
+
 		set_bit(MMF_OOM_SKIP, &mm->flags);
 	}
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 7ec38194f8e1..727cfc3bd284 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -509,9 +509,11 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
 static struct task_struct *oom_reaper_list;
 static DEFINE_SPINLOCK(oom_reaper_lock);
 
-bool __oom_reap_task_mm(struct mm_struct *mm)
+bool __oom_reap_task_mm(struct mm_struct *mm, struct robust_list_head
+		__user *robust_list)
 {
 	struct vm_area_struct *vma;
+	unsigned long head = (unsigned long) robust_list;
 	bool ret = true;
 
 	/*
@@ -526,6 +528,11 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
 
+		if (vma->vm_start <= head && vma->vm_end > head) {
+			pr_info("oom_reaper: skipping vma, contains robust_list");
+			continue;
+		}
+
 		/*
 		 * Only anonymous pages have a good chance to be dropped
 		 * without additional steps which we cannot afford as we
@@ -587,7 +594,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	trace_start_task_reaping(tsk->pid);
 
 	/* failed to reap part of the address space. Try again later */
-	ret = __oom_reap_task_mm(mm);
+	ret = __oom_reap_task_mm(mm, tsk->robust_list);
 	if (!ret)
 		goto out_finish;
 
@@ -1190,7 +1197,8 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
 	 * possible change in exit_mmap is seen
 	 */
-	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
+	if (!test_bit(MMF_OOM_SKIP, &mm->flags) &&
+			!__oom_reap_task_mm(mm, p->robust_list))
 		ret = -EAGAIN;
 	mmap_read_unlock(mm);
 
-- 
2.35.1

