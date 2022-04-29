Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A477E514AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376259AbiD2Nkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359815AbiD2NkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6804CB00E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q12so6524968pgj.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0pdWx48nGjNlGaELTzsLa2nKTJtILEQX8NtQw3N2p4=;
        b=vOzMg0WwZNZJ2aJySF61oOZUFo15rtaSv8ZgCsHQW+x4vUg2gpucSoyYCNUztLrAxj
         YcWyZiXJ4nMk4ksCagIhUghKnVR27Rn7j5BSZ6aUVnVn3NAPYBai3hPJK2hBYOmr0AY2
         gVgLHui6SE2OT16oLJPwJ+QyDgjiWtWpf8tActM2PfHuUuZcatMxnqeHas/8t6014yuM
         KVp7m4lEzHdo2JHc5dhmn11rh2qarw9f3jRr2hhwGlBagI8nFT6RMAAMvwp/3kKUjbVb
         VSXDJPDXDGANDA3YkyThMCz5buYTS7SBPVfY+iHQXizpWs0u+IFSRVckBCZyha5Y/rwP
         zzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0pdWx48nGjNlGaELTzsLa2nKTJtILEQX8NtQw3N2p4=;
        b=So/y6d+RjWU6auhlwHr7NqGiZa1BpsHdr5+tL+Vim0U2Jqc+VwPtVBQ7pziXqYxqIX
         DOkZWK5T8Ng2AImRVVZGU0PkT5OKnhhdlkfhmYW7FGH7g0xzhTJY9NHHfKzEOPYhXiNo
         PJv7l1XwF+RxNxrY3IaYuNvyepiGVAMfGbnIzZNfL2tECZ0iN2dj+DU+lyggHwNPvlsb
         knwVc/ChE9PY9sMVH3ROZFXv/RR7h0OxorUc4LMnerePjnWQbzUgzCLzUK3QGwK8d9EA
         5FqiBY9ni1LMD7M2ydScQ+tWPvdBYK29MeC96FFCWcepZQ5tCBCm3yGDAWNfSnQvuvGm
         KFyQ==
X-Gm-Message-State: AOAM531kNvjv9u/F9YvryZeI1nYpaDC+7JvrHiZRx55thEis0t5s2pFI
        qeEoPFulb6RfyzhepwlqzuiolJLIFH1EBg==
X-Google-Smtp-Source: ABdhPJwB5nqK52ryAKPNOtkptHUR5XR7j8KK8PoAy/NWEG3XiuyosiUypONBAmFBtJovBvthn4Ixbw==
X-Received: by 2002:a65:60d3:0:b0:39c:f431:5859 with SMTP id r19-20020a6560d3000000b0039cf4315859mr32421659pgv.442.1651239423704;
        Fri, 29 Apr 2022 06:37:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:37:03 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 08/18] mm: introduce percpu_ref for user PTE page table page
Date:   Fri, 29 Apr 2022 21:35:42 +0800
Message-Id: <20220429133552.33768-9-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now in order to pursue high performance, applications mostly use some
high-performance user-mode memory allocators, such as jemalloc or tcmalloc.
These memory allocators use madvise(MADV_DONTNEED or MADV_FREE) to release
physical memory for the following reasons::

 First of all, we should hold as few write locks of mmap_lock as possible,
 since the mmap_lock semaphore has long been a contention point in the
 memory management subsystem. The mmap()/munmap() hold the write lock, and
 the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
 madvise() instead of munmap() to released physical memory can reduce the
 competition of the mmap_lock.

 Secondly, after using madvise() to release physical memory, there is no
 need to build vma and allocate page tables again when accessing the same
 virtual address again, which can also save some time.

The following is the largest user PTE page table memory that can be
allocated by a single user process in a 32-bit and a 64-bit system.

+---------------------------+--------+---------+
|                           | 32-bit | 64-bit  |
+===========================+========+=========+
| user PTE page table pages | 3 MiB  | 512 GiB |
+---------------------------+--------+---------+
| user PMD page table pages | 3 KiB  | 1 GiB   |
+---------------------------+--------+---------+

(for 32-bit, take 3G user address space, 4K page size as an example;
 for 64-bit, take 48-bit address width, 4K page size as an example.)

After using madvise(), everything looks good, but as can be seen from the
above table, a single process can create a large number of PTE page tables
on a 64-bit system, since both of the MADV_DONTNEED and MADV_FREE will not
release page table memory. And before the process exits or calls munmap(),
the kernel cannot reclaim these pages even if these PTE page tables do not
map anything.

To fix the situation, this patchset introduces a percpu_ref for each user
PTE page table page. The following people will hold a percpu_ref::

 The !pte_none() entry, such as regular page table entry that map physical
 pages, or swap entry, or migrate entry, etc.

 Visitor to the PTE page table entries, such as page table walker.

Any ``!pte_none()`` entry and visitor can be regarded as the user of its
PTE page table page. When the percpu_ref is reduced to 0 (need to switch
to atomic mode first to check), it means that no one is using the PTE page
table page, then this free PTE page table page can be reclaimed at this
time.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h       |  9 +++++++-
 include/linux/mm_types.h |  1 +
 include/linux/pte_ref.h  | 29 +++++++++++++++++++++++++
 mm/Makefile              |  2 +-
 mm/pte_ref.c             | 47 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0afd3b097e90..1a6bc79c351b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -28,6 +28,7 @@
 #include <linux/sched.h>
 #include <linux/pgtable.h>
 #include <linux/kasan.h>
+#include <linux/pte_ref.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2260,11 +2261,16 @@ static inline void pgtable_init(void)
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
-	if (!ptlock_init(page))
+	if (!pte_ref_init(page))
 		return false;
+	if (!ptlock_init(page))
+		goto free_pte_ref;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
+free_pte_ref:
+	pte_ref_free(page);
+	return false;
 }
 
 static inline void pgtable_pte_page_dtor(struct page *page)
@@ -2272,6 +2278,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 	ptlock_free(page);
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pte_ref_free(page);
 }
 
 #define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..650bfb22b0e2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -153,6 +153,7 @@ struct page {
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
+				struct percpu_ref *pte_ref; /* PTE page only */
 			};
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
new file mode 100644
index 000000000000..d3963a151ca5
--- /dev/null
+++ b/include/linux/pte_ref.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+
+#ifndef _LINUX_PTE_REF_H
+#define _LINUX_PTE_REF_H
+
+#ifdef CONFIG_FREE_USER_PTE
+
+bool pte_ref_init(pgtable_t pte);
+void pte_ref_free(pgtable_t pte);
+
+#else /* !CONFIG_FREE_USER_PTE */
+
+static inline bool pte_ref_init(pgtable_t pte)
+{
+	return true;
+}
+
+static inline void pte_ref_free(pgtable_t pte)
+{
+}
+
+#endif /* CONFIG_FREE_USER_PTE */
+
+#endif /* _LINUX_PTE_REF_H */
diff --git a/mm/Makefile b/mm/Makefile
index 4cc13f3179a5..b9711510f84f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -54,7 +54,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o $(mmu-y) pte_ref.o
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
new file mode 100644
index 000000000000..52e31be00de4
--- /dev/null
+++ b/mm/pte_ref.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+#include <linux/pgtable.h>
+#include <linux/pte_ref.h>
+#include <linux/percpu-refcount.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_FREE_USER_PTE
+
+static void no_op(struct percpu_ref *r) {}
+
+bool pte_ref_init(pgtable_t pte)
+{
+	struct percpu_ref *pte_ref;
+
+	pte_ref = kmalloc(sizeof(struct percpu_ref), GFP_KERNEL);
+	if (!pte_ref)
+		return false;
+	if (percpu_ref_init(pte_ref, no_op,
+			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL) < 0)
+		goto free_ref;
+	/* We want to start with the refcount at zero */
+	percpu_ref_put(pte_ref);
+
+	pte->pte_ref = pte_ref;
+	return true;
+free_ref:
+	kfree(pte_ref);
+	return false;
+}
+
+void pte_ref_free(pgtable_t pte)
+{
+	struct percpu_ref *ref = pte->pte_ref;
+	if (!ref)
+		return;
+
+	pte->pte_ref = NULL;
+	percpu_ref_exit(ref);
+	kfree(ref);
+}
+
+#endif /* CONFIG_FREE_USER_PTE */
-- 
2.20.1

