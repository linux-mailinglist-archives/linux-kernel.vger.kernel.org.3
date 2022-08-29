Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67C5A561F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiH2V0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiH2V0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:30 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831591D01
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id dc10-20020a056a0035ca00b0053870674be9so756906pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=i5dTvRyWQzPS3ycEVnnedNfB+iHCFx9RUaZKzBMQ1fM=;
        b=OIPy78dmVL2e9cDtVRNWLABLgvKsSbZL8TpHXpGFOXD1iGGPPAnyGMcNCguJqgzcNF
         vE+9cNpICzTMp48ey6JmMRyIlEctkJFDoL9MrqQuHHLDpAc2aXZC9NHJQw5sThX00eJ4
         cjI0k3jAy5gFEX5VEHv4cVfUWBvRtfOC3iZWstqSQy3ibplhtgaSEpWxPcs9EVcm88qg
         LMXuGuQRDlQwRuQ7YNFSCH+8XULwWBK9BYSC5nbMXIDpOIovOb1rbCvinLUjcMpntl6K
         B3Pgew8zey/TtmyxMcXnTuT0BjzA6VIn4rP9dbnKnx4PgoHjYUplxPVEMwf3o1trOT0a
         21qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=i5dTvRyWQzPS3ycEVnnedNfB+iHCFx9RUaZKzBMQ1fM=;
        b=fCwnfPlM9TCFEmHVd0/zlh9jJu98NSi/YVwhwZy6nbNVG15kX0t0wut+YAQggMu6TM
         AwO0JSKrKpCi4wDMT/q0kiqgjBXJvGSHG/KP821EiFPCBMW7KtvI9RQ5nx3w2ib1hX5+
         I5RNiu5jAo34YUHCjb41Sq7oqL4OzljgUFJwwFa0QhpOMp/wcrB0OSn/H46rVi+G9Nz0
         YSobgnPaL5Q1MbmxZpgKg0mTHbPbmLIt3AUD2/sUFPt7K77wIN4RT0YYOOnkd2Nx74aS
         AIjJOZNKfSOayZu0/H8Cy/o5vYdU1XundLe6QxYJPDt96+7ji6tIDOfjj4ULPZxjhk+r
         P8Gg==
X-Gm-Message-State: ACgBeo1360aT0vOSB8FT98JV9TX0z8s/1U6Jur6/sDUCP80WovQUlS5I
        7lv8Voqhvi0Lu6pfyVLqPA0xMcWWgZU=
X-Google-Smtp-Source: AA6agR4q+ezvBgIOmovwk/KulEVJwqDq2XJXfw+za6wVj0A/SjlqYDTJGsWkQl5JJSuDpwxpjjn7kfBBqpA=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:902:76c5:b0:174:e586:f6e2 with SMTP id
 j5-20020a17090276c500b00174e586f6e2mr4373889plt.37.1661808359839; Mon, 29 Aug
 2022 14:25:59 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:16 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-14-surenb@google.com>
Subject: [RFC PATCH 13/28] mm: conditionally mark VMA as locked in
 free_pgtables and unmap_page_range
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pgtables and unmap_page_range functions can be called with mmap_lock
held for write (e.g. in mmap_region), held for read (e.g in
madvise_pageout) or not held at all (e.g in madvise_remove might
drop mmap_lock before calling vfs_fallocate, which ends up calling
unmap_page_range).
Provide free_pgtables and unmap_page_range with additional argument
indicating whether to mark the VMA as locked or not based on the usage.
The parameter is set based on whether mmap_lock is held in write mode
during the call. This ensures no change in behavior between mmap_lock
and per-vma locks.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h |  2 +-
 mm/internal.h      |  4 ++--
 mm/memory.c        | 32 +++++++++++++++++++++-----------
 mm/mmap.c          | 17 +++++++++--------
 mm/oom_kill.c      |  3 ++-
 5 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 476bf936c5f0..dc72be923e5b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1874,7 +1874,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
 void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long start, unsigned long end);
+		unsigned long start, unsigned long end, bool lock_vma);
 
 struct mmu_notifier_range;
 
diff --git a/mm/internal.h b/mm/internal.h
index 785409805ed7..e6c0f999e0cb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -85,14 +85,14 @@ bool __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long floor, unsigned long ceiling);
+		unsigned long floor, unsigned long ceiling, bool lock_vma);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 
 struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
-			     struct zap_details *details);
+			     struct zap_details *details, bool lock_vma);
 
 void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
 		unsigned int order);
diff --git a/mm/memory.c b/mm/memory.c
index 4ba73f5aa8bb..9ac9944e8c62 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -403,7 +403,7 @@ void free_pgd_range(struct mmu_gather *tlb,
 }
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+		unsigned long floor, unsigned long ceiling, bool lock_vma)
 {
 	while (vma) {
 		struct vm_area_struct *next = vma->vm_next;
@@ -413,6 +413,8 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * Hide vma from rmap and truncate_pagecache before freeing
 		 * pgtables
 		 */
+		if (lock_vma)
+			vma_mark_locked(vma);
 		unlink_anon_vmas(vma);
 		unlink_file_vma(vma);
 
@@ -427,6 +429,8 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = vma->vm_next;
+				if (lock_vma)
+					vma_mark_locked(vma);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
@@ -1631,12 +1635,16 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
 void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
-			     struct zap_details *details)
+			     struct zap_details *details,
+			     bool lock_vma)
 {
 	pgd_t *pgd;
 	unsigned long next;
 
 	BUG_ON(addr >= end);
+	if (lock_vma)
+		vma_mark_locked(vma);
+
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
@@ -1652,7 +1660,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 static void unmap_single_vma(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr,
-		struct zap_details *details)
+		struct zap_details *details, bool lock_vma)
 {
 	unsigned long start = max(vma->vm_start, start_addr);
 	unsigned long end;
@@ -1691,7 +1699,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
 			}
 		} else
-			unmap_page_range(tlb, vma, start, end, details);
+			unmap_page_range(tlb, vma, start, end, details, lock_vma);
 	}
 }
 
@@ -1715,7 +1723,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
  */
 void unmap_vmas(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr)
+		unsigned long end_addr, bool lock_vma)
 {
 	struct mmu_notifier_range range;
 	struct zap_details details = {
@@ -1728,7 +1736,8 @@ void unmap_vmas(struct mmu_gather *tlb,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
-		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
+		unmap_single_vma(tlb, vma, start_addr, end_addr, &details,
+				 lock_vma);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
@@ -1753,7 +1762,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
-		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+		unmap_single_vma(&tlb, vma, start, range.end, NULL, false);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
@@ -1768,7 +1777,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
  * The range must fit into one VMA.
  */
 static void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
-		unsigned long size, struct zap_details *details)
+		unsigned long size, struct zap_details *details, bool lock_vma)
 {
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
@@ -1779,7 +1788,7 @@ static void zap_page_range_single(struct vm_area_struct *vma, unsigned long addr
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	unmap_single_vma(&tlb, vma, address, range.end, details);
+	unmap_single_vma(&tlb, vma, address, range.end, details, lock_vma);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
@@ -1802,7 +1811,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 	    		!(vma->vm_flags & VM_PFNMAP))
 		return;
 
-	zap_page_range_single(vma, address, size, NULL);
+	zap_page_range_single(vma, address, size, NULL, true);
 }
 EXPORT_SYMBOL_GPL(zap_vma_ptes);
 
@@ -3483,7 +3492,8 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
 		unsigned long start_addr, unsigned long end_addr,
 		struct zap_details *details)
 {
-	zap_page_range_single(vma, start_addr, end_addr - start_addr, details);
+	zap_page_range_single(vma, start_addr, end_addr - start_addr, details,
+			      false);
 }
 
 static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
diff --git a/mm/mmap.c b/mm/mmap.c
index 121544fd90de..094678b4434b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -79,7 +79,7 @@ core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
 static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
+		unsigned long start, unsigned long end, bool lock_vma);
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
@@ -1866,7 +1866,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_file = NULL;
 
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end, true);
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
@@ -2626,7 +2626,7 @@ static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end)
+		unsigned long start, unsigned long end, bool lock_vma)
 {
 	struct vm_area_struct *next = vma_next(mm, prev);
 	struct mmu_gather tlb;
@@ -2634,9 +2634,10 @@ static void unmap_region(struct mm_struct *mm,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
+	unmap_vmas(&tlb, vma, start, end, lock_vma);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING);
+				 next ? next->vm_start : USER_PGTABLES_CEILING,
+				 lock_vma);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -2849,7 +2850,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (downgrade)
 		mmap_write_downgrade(mm);
 
-	unmap_region(mm, vma, prev, start, end);
+	unmap_region(mm, vma, prev, start, end, !downgrade);
 
 	/* Fix up all other VM information */
 	remove_vma_list(mm, vma);
@@ -3129,8 +3130,8 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	unmap_vmas(&tlb, vma, 0, -1, true);
+	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
 	/* Walk the list again, actually closing and freeing it. */
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3c6cf9e3cd66..6ffa7c511aa3 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -549,7 +549,8 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 				ret = false;
 				continue;
 			}
-			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
+			unmap_page_range(&tlb, vma, range.start, range.end,
+					 NULL, false);
 			mmu_notifier_invalidate_range_end(&range);
 			tlb_finish_mmu(&tlb);
 		}
-- 
2.37.2.672.g94769d06f0-goog

