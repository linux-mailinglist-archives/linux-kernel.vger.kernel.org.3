Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7884349FA94
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349170AbiA1NUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:23 -0500
Received: from server.lespinasse.org ([63.205.204.226]:58853 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348747AbiA1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:11 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=P67mhsIt1ppjFTFW+x1YN2vEk/hxfE1OzpykzhPxla8=;
 b=j05HraC270uf9eSPytFr4+XRdIB2UMC4nP+hXv9KOHmP5Tpxd1I3xZVKhGwxrIWQxFito
 6SX6oF6SPaYp8DyAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=P67mhsIt1ppjFTFW+x1YN2vEk/hxfE1OzpykzhPxla8=;
 b=ATrqRJnge0cYDvYRn6k7PBbijeM0h2dmb6XlkF6kgZBYAzZTNWQhpOEyYdfd3ig3EAxlm
 XRJY7kymtFXBbDuHn20R/ysQ3y+T/UjXQH9ehvC7rWhtJ6mKKjSO4iDbz2j+PZjNMZ5oONj
 rt8Y0w7HuZxI6oRK0/a1DdPwp8U6Wpk2z6peNkcODaj8xWGYHJnozGnTJmWHzkNbzc9DTQB
 FGnIuAqR5K+Q++6P4Uz9di1TOldV0BQCB1qqF4PEYmbt1WY5n7VTjqrQr0i+VvEIhcG4heR
 9ZzYLWjDurPxXV+wh3Zz/ADRzNspdvk3dD/t6Wz24QmuwistOpeXw6u6QHuA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 29F9D160AAC;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 0BE3F2055C; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 23/35] mm: add mmu_notifier_lock
Date:   Fri, 28 Jan 2022 05:09:54 -0800
Message-Id: <20220128131006.67712-24-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce mmu_notifier_lock as a per-mm percpu_rw_semaphore,
as well as the code to initialize and destroy it together with the mm.

This lock will be used to prevent races between mmu_notifier_register()
and speculative fault handlers that need to fire MMU notifications
without holding any of the mmap or rmap locks.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm_types.h     |  6 +++++-
 include/linux/mmu_notifier.h | 27 +++++++++++++++++++++++++--
 kernel/fork.c                |  3 ++-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 305f05d2a4bc..f77e2dec038d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -462,6 +462,7 @@ struct vm_area_struct {
 } __randomize_layout;
 
 struct kioctx_table;
+struct percpu_rw_semaphore;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
@@ -608,7 +609,10 @@ struct mm_struct {
 		struct file __rcu *exe_file;
 #ifdef CONFIG_MMU_NOTIFIER
 		struct mmu_notifier_subscriptions *notifier_subscriptions;
-#endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+		struct percpu_rw_semaphore *mmu_notifier_lock;
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+#endif	/* CONFIG_MMU_NOTIFIER */
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 45fc2c81e370..ace76fe91c0c 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -6,6 +6,8 @@
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
 #include <linux/mmap_lock.h>
+#include <linux/percpu-rwsem.h>
+#include <linux/slab.h>
 #include <linux/srcu.h>
 #include <linux/interval_tree.h>
 
@@ -499,15 +501,35 @@ static inline void mmu_notifier_invalidate_range(struct mm_struct *mm,
 		__mmu_notifier_invalidate_range(mm, start, end);
 }
 
-static inline void mmu_notifier_subscriptions_init(struct mm_struct *mm)
+static inline bool mmu_notifier_subscriptions_init(struct mm_struct *mm)
 {
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	mm->mmu_notifier_lock = kzalloc(sizeof(struct percpu_rw_semaphore), GFP_KERNEL);
+	if (!mm->mmu_notifier_lock)
+		return false;
+	if (percpu_init_rwsem(mm->mmu_notifier_lock)) {
+		kfree(mm->mmu_notifier_lock);
+		return false;
+	}
+#endif
+
 	mm->notifier_subscriptions = NULL;
+	return true;
 }
 
 static inline void mmu_notifier_subscriptions_destroy(struct mm_struct *mm)
 {
 	if (mm_has_notifiers(mm))
 		__mmu_notifier_subscriptions_destroy(mm);
+
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if (!in_atomic()) {
+		percpu_free_rwsem(mm->mmu_notifier_lock);
+		kfree(mm->mmu_notifier_lock);
+	} else {
+		percpu_rwsem_async_destroy(mm->mmu_notifier_lock);
+	}
+#endif
 }
 
 
@@ -724,8 +746,9 @@ static inline void mmu_notifier_invalidate_range(struct mm_struct *mm,
 {
 }
 
-static inline void mmu_notifier_subscriptions_init(struct mm_struct *mm)
+static inline bool mmu_notifier_subscriptions_init(struct mm_struct *mm)
 {
+	return true;
 }
 
 static inline void mmu_notifier_subscriptions_destroy(struct mm_struct *mm)
diff --git a/kernel/fork.c b/kernel/fork.c
index 2e5f2e8de31a..db92e42d0087 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1069,7 +1069,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_owner(mm, p);
 	mm_init_pasid(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
-	mmu_notifier_subscriptions_init(mm);
+	if (!mmu_notifier_subscriptions_init(mm))
+		goto fail_nopgd;
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
-- 
2.20.1

