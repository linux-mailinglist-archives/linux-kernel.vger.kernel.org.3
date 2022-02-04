Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E414AA0D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiBDUEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiBDUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E523C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ONe6Ip0BP1XUQGEnFf/nfruk2orxD2roZmMmPoCcsMM=; b=JDBa4N6rYzqQGltWzr55J6xaGy
        0GJicxEs38k2F/8Vv7byvbjWPU1x8KyPlwdyOWlbBA41PYFpgZHPIt7HfJIb72rHbKh6Zdl0XUGd1
        QOl89g4McGHIE6PhMfin5UeQ3fQN/w2iegU1U4XOn8gdkU7DQFNAFdif01fQtu8Qxk+hl5l2/1LKF
        qpbRwK+BhZtN7uWSx/g1Q0sFs2yHYyjxC/Csbhcty4L/LtVd7JBW7QE+3ZPJYndWqBt4NI7fjhzsV
        q6L/GaehDxwu2MQ5eCvUq5db/N3RHY9/A94mTr4GJFOfrOQXxaJqhusc+wei2KpgGc2qFcDGlB3/0
        Rspew+xA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jY-007LoP-W2; Fri, 04 Feb 2022 19:59:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 51/75] mm/rmap: Convert try_to_unmap() to take a folio
Date:   Fri,  4 Feb 2022 19:58:28 +0000
Message-Id: <20220204195852.1751729-52-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change both callers and the worker function try_to_unmap_one().
---
 include/linux/rmap.h |  4 +--
 mm/huge_memory.c     |  3 +-
 mm/memory-failure.c  |  7 ++--
 mm/memory_hotplug.c  | 13 ++++---
 mm/rmap.c            | 81 +++++++++++++++++++++++---------------------
 mm/vmscan.c          |  2 +-
 6 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 31f3a299ef66..66407434c3b5 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -193,7 +193,7 @@ int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
 void try_to_migrate(struct page *page, enum ttu_flags flags);
-void try_to_unmap(struct page *, enum ttu_flags flags);
+void try_to_unmap(struct folio *, enum ttu_flags flags);
 
 int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, struct page **pages,
@@ -311,7 +311,7 @@ static inline int folio_referenced(struct folio *folio, int is_locked,
 	return 0;
 }
 
-static inline void try_to_unmap(struct page *page, enum ttu_flags flags)
+static inline void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 {
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f934b93d08ca..4ea22b7319fd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2283,6 +2283,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 
 static void unmap_page(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
 		TTU_SYNC;
 
@@ -2296,7 +2297,7 @@ static void unmap_page(struct page *page)
 	if (PageAnon(page))
 		try_to_migrate(page, ttu_flags);
 	else
-		try_to_unmap(page, ttu_flags | TTU_IGNORE_MLOCK);
+		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
 
 	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 97a9ed8f87a9..1c7a71b5248e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1347,6 +1347,7 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
 static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 				  int flags, struct page *hpage)
 {
+	struct folio *folio = page_folio(hpage);
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
@@ -1412,7 +1413,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
 	if (!PageHuge(hpage)) {
-		try_to_unmap(hpage, ttu);
+		try_to_unmap(folio, ttu);
 	} else {
 		if (!PageAnon(hpage)) {
 			/*
@@ -1424,12 +1425,12 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 			 */
 			mapping = hugetlb_page_mapping_lock_write(hpage);
 			if (mapping) {
-				try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
+				try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
 				i_mmap_unlock_write(mapping);
 			} else
 				pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
 		} else {
-			try_to_unmap(hpage, ttu);
+			try_to_unmap(folio, ttu);
 		}
 	}
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a9627dc784c..914057da53c7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1690,10 +1690,13 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 				      DEFAULT_RATELIMIT_BURST);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		struct folio *folio;
+
 		if (!pfn_valid(pfn))
 			continue;
 		page = pfn_to_page(pfn);
-		head = compound_head(page);
+		folio = page_folio(page);
+		head = &folio->page;
 
 		if (PageHuge(page)) {
 			pfn = page_to_pfn(head) + compound_nr(head) - 1;
@@ -1710,10 +1713,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		 * the unmap as the catch all safety net).
 		 */
 		if (PageHWPoison(page)) {
-			if (WARN_ON(PageLRU(page)))
-				isolate_lru_page(page);
-			if (page_mapped(page))
-				try_to_unmap(page, TTU_IGNORE_MLOCK);
+			if (WARN_ON(folio_test_lru(folio)))
+				folio_isolate_lru(folio);
+			if (folio_mapped(folio))
+				try_to_unmap(folio, TTU_IGNORE_MLOCK);
 			continue;
 		}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 42a147746ff8..c598fd667948 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1452,13 +1452,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	 * For hugetlb, it could be much worse if we need to do pud
 	 * invalidation in the case of pmd sharing.
 	 *
-	 * Note that the page can not be free in this function as call of
-	 * try_to_unmap() must hold a reference on the page.
+	 * Note that the folio can not be freed in this function as call of
+	 * try_to_unmap() must hold a reference on the folio.
 	 */
 	range.end = vma_address_end(&pvmw);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address, range.end);
-	if (PageHuge(page)) {
+	if (folio_test_hugetlb(folio)) {
 		/*
 		 * If sharing is possible, start and end will be adjusted
 		 * accordingly.
@@ -1470,31 +1470,34 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		/*
-		 * If the page is mlock()d, we cannot swap it out.
+		 * If the folio is mlock()d, we cannot swap it out.
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
 			/*
-			 * PTE-mapped THP are never marked as mlocked: so do
-			 * not set it on a DoubleMap THP, nor on an Anon THP
+			 * PTE-mapped folios are never marked as mlocked: so do
+			 * not set it on a DoubleMap folio, nor on an Anon folio
 			 * (which may still be PTE-mapped after DoubleMap was
 			 * cleared).  But stop unmapping even in those cases.
 			 */
-			if (!PageTransCompound(page) || (PageHead(page) &&
-			     !PageDoubleMap(page) && !PageAnon(page)))
-				mlock_vma_page(page);
+			if (!folio_test_large(folio) ||
+			    (folio_test_large(folio) &&
+			     !folio_test_double_map(folio) &&
+			     !folio_test_anon(folio)))
+				mlock_vma_folio(folio);
 			page_vma_mapped_walk_done(&pvmw);
 			ret = false;
 			break;
 		}
 
 		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_PAGE(!pvmw.pte, page);
+		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+		subpage = folio_page(folio,
+					pte_pfn(*pvmw.pte) - folio_pfn(folio));
 		address = pvmw.address;
 
-		if (PageHuge(page) && !PageAnon(page)) {
+		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
 			/*
 			 * To call huge_pmd_unshare, i_mmap_rwsem must be
 			 * held in write mode.  Caller needs to explicitly
@@ -1533,7 +1536,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		if (should_defer_flush(mm, flags)) {
 			/*
 			 * We clear the PTE but do not flush so potentially
-			 * a remote CPU could still be writing to the page.
+			 * a remote CPU could still be writing to the folio.
 			 * If the entry was previously clean then the
 			 * architecture must guarantee that a clear->dirty
 			 * transition on a cached TLB entry is written through
@@ -1546,22 +1549,22 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			pteval = ptep_clear_flush(vma, address, pvmw.pte);
 		}
 
-		/* Move the dirty bit to the page. Now the pte is gone. */
+		/* Set the dirty flag on the folio now the pte is gone. */
 		if (pte_dirty(pteval))
-			set_page_dirty(page);
+			folio_mark_dirty(folio);
 
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
-		if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
+		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
-			if (PageHuge(page)) {
-				hugetlb_count_sub(compound_nr(page), mm);
+			if (folio_test_hugetlb(folio)) {
+				hugetlb_count_sub(folio_nr_pages(folio), mm);
 				set_huge_swap_pte_at(mm, address,
 						     pvmw.pte, pteval,
 						     vma_mmu_pagesize(vma));
 			} else {
-				dec_mm_counter(mm, mm_counter(page));
+				dec_mm_counter(mm, mm_counter(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1576,18 +1579,19 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(page));
+			dec_mm_counter(mm, mm_counter(&folio->page));
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
-		} else if (PageAnon(page)) {
+		} else if (folio_test_anon(folio)) {
 			swp_entry_t entry = { .val = page_private(subpage) };
 			pte_t swp_pte;
 			/*
 			 * Store the swap location in the pte.
 			 * See handle_pte_fault() ...
 			 */
-			if (unlikely(PageSwapBacked(page) != PageSwapCache(page))) {
+			if (unlikely(folio_test_swapbacked(folio) !=
+					folio_test_swapcache(folio))) {
 				WARN_ON_ONCE(1);
 				ret = false;
 				/* We have to invalidate as we cleared the pte */
@@ -1598,8 +1602,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			}
 
 			/* MADV_FREE page check */
-			if (!PageSwapBacked(page)) {
-				if (!PageDirty(page)) {
+			if (!folio_test_swapbacked(folio)) {
+				if (!folio_test_dirty(folio)) {
 					/* Invalidate as we cleared the pte */
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
@@ -1608,11 +1612,11 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				}
 
 				/*
-				 * If the page was redirtied, it cannot be
+				 * If the folio was redirtied, it cannot be
 				 * discarded. Remap the page to page table.
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				SetPageSwapBacked(page);
+				folio_set_swapbacked(folio);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
@@ -1649,16 +1653,17 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 						      address + PAGE_SIZE);
 		} else {
 			/*
-			 * This is a locked file-backed page, thus it cannot
-			 * be removed from the page cache and replaced by a new
-			 * page before mmu_notifier_invalidate_range_end, so no
-			 * concurrent thread might update its page table to
-			 * point at new page while a device still is using this
-			 * page.
+			 * This is a locked file-backed folio,
+			 * so it cannot be removed from the page
+			 * cache and replaced by a new folio before
+			 * mmu_notifier_invalidate_range_end, so no
+			 * concurrent thread might update its page table
+			 * to point at a new folio while a device is
+			 * still using this folio.
 			 *
 			 * See Documentation/vm/mmu_notifier.rst
 			 */
-			dec_mm_counter(mm, mm_counter_file(page));
+			dec_mm_counter(mm, mm_counter_file(&folio->page));
 		}
 discard:
 		/*
@@ -1668,8 +1673,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, PageHuge(page));
-		put_page(page);
+		page_remove_rmap(subpage, folio_test_hugetlb(folio));
+		folio_put(folio);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
@@ -1698,7 +1703,7 @@ static int page_not_mapped(struct page *page)
  * It is the caller's responsibility to check if the page is still
  * mapped when needed (use TTU_SYNC to prevent accounting races).
  */
-void try_to_unmap(struct page *page, enum ttu_flags flags)
+void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_unmap_one,
@@ -1708,9 +1713,9 @@ void try_to_unmap(struct page *page, enum ttu_flags flags)
 	};
 
 	if (flags & TTU_RMAP_LOCKED)
-		rmap_walk_locked(page, &rwc);
+		rmap_walk_locked(&folio->page, &rwc);
 	else
-		rmap_walk(page, &rwc);
+		rmap_walk(&folio->page, &rwc);
 }
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1e751ba3b4a8..2e94e0b15a76 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1761,7 +1761,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;
 
-			try_to_unmap(page, flags);
+			try_to_unmap(folio, flags);
 			if (page_mapped(page)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked && PageSwapBacked(page))
-- 
2.34.1

