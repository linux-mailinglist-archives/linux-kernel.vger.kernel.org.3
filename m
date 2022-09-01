Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC49F5A9E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiIARhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiIARgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6FF642D9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340c6cfc388so185725407b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=r773C9YRjCBNvMT4CzLpPbmrmyQxRNwpck2TtfCck1k=;
        b=ObA20LITrip87VziaHHJxhsQdt90Sartw38u0QjInvigVBBYp9UQt6FfSRSeXBXEZU
         PLrSrOLMVOwI3/sz3dUO/NCHhkXbIW3GF8M34MWk3xttvYsGitw637zJhtS5J3KbjVTq
         FLk9jwJNLpWEznbWA1xdOdydu+93KP79dvrPgyK7xujYPxVhRBYXk7sgB7YC6n2PoUnC
         kIiWKC2Oq5VXot4jMCKtmju4UEkl0k8b2etD7U9K2bdu4kKMwZb5udL9M4YbR2lJrZYA
         TRfi2Vr1zk+DfsN0D7bvgFUbxdpPUkljp0W3vF7qidlJ9uVGD7Pq+2IeCcnvt21qYUIk
         bD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=r773C9YRjCBNvMT4CzLpPbmrmyQxRNwpck2TtfCck1k=;
        b=NXfb7pBaN2Hx/OSxfhaUNDir8Ko8AVBchTs/nVPXO4DaHe4Xte07+Pn7BdN220NKeE
         k4ELR0ee0iU1EkNzD54IEF9LhPko3IpcRk7yMqXy/543hG9inuyaG0/I3EgImppIj2Ai
         D79UWM08Nv6m72Q7tZPlhRKJTisGoasTdlVNzgucaPTu8uAcJe4pwXgKjT3G/n7cey0n
         uHihLuKXfk4pnQotb3ricsG80whJq/0nCXQ/vlsVyKP9+a+g+/eKjGcaux7S7fS3DGAB
         ilffUceuldOzEWf6N/1pWmOx1GPysMyteW/oiVd7T62xErGW0kVJjRylMGgLz0TBARCb
         We1w==
X-Gm-Message-State: ACgBeo0CWOHoGf7LZnCCtgD1bCtVJAbifFsk9rFTSBt+y0vs2N9LMt36
        1OrLeiZClsikVyrq8IehQ+qxpLji7Xs=
X-Google-Smtp-Source: AA6agR5CArj0XA3uZUba700jvv45FjGtdD6CkgMKCuV3RkIgq+Sm8gt1hyIVkRx9I0S41UWPyjD3FlSg3pw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:dd05:0:b0:69c:97aa:f08e with SMTP id
 u5-20020a25dd05000000b0069c97aaf08emr9069882ybg.583.1662053755821; Thu, 01
 Sep 2022 10:35:55 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:01 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-14-surenb@google.com>
Subject: [RFC PATCH RESEND 13/28] mm: conditionally mark VMA as locked in
 free_pgtables and unmap_page_range
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
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
2.37.2.789.g6183377224-goog

