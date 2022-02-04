Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE34AA0A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiBDUBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D7C061763
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DYOK7Cv9XHLHWQbmW8cJx1Pne9VB46L3mBP+N/iRYRM=; b=hS9eGAQp5VnkH7lhSLNPJvAbwU
        w3ucXm7feVYCiGP7I1nY3Qn7Zc2IlB3dU+kJV/nyb1RqXNoaO0VEc7teXSNemYrvGdq5CN9D1rtrS
        dqbH9rv8xTHm8NFRDkR7fTkyD5y/QlQ6+5J0dCJAs8QMALhKxpAfAx7e/O35DqcL5LlxHuNYV3naF
        Q90rgGjvxIA92RZv/dKxBqIPxKLngXoHS8VJLdgTt7epm7wSdGxKdnxqILVPjorGtDAnFytK8GGOE
        cmgt2g4X3Kk5sXcPhHfIvWtr7pPhAZahtVYILGiYHSa1oVn23r218AtNon/VvYu04qSLWmmeceRaI
        oPkd97CA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jZ-007LoY-3h; Fri, 04 Feb 2022 19:59:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 52/75] mm/rmap: Convert try_to_migrate() to folios
Date:   Fri,  4 Feb 2022 19:58:29 +0000
Message-Id: <20220204195852.1751729-53-willy@infradead.org>
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

Convert the callers to pass a folio and the try_to_migrate_one()
worker to use a folio throughout.  Fixes an assumption that a
folio must be <= PMD size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rmap.h |  2 +-
 mm/huge_memory.c     |  4 ++--
 mm/migrate.c         | 12 ++++++----
 mm/rmap.c            | 57 +++++++++++++++++++++++---------------------
 4 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 66407434c3b5..502439f20d88 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,7 +192,7 @@ static inline void page_dup_rmap(struct page *page, bool compound)
 int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
-void try_to_migrate(struct page *page, enum ttu_flags flags);
+void try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
 
 int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4ea22b7319fd..21676a4afd07 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2294,8 +2294,8 @@ static void unmap_page(struct page *page)
 	 * pages can simply be left unmapped, then faulted back on demand.
 	 * If that is ever changed (perhaps for mlock), update remap_page().
 	 */
-	if (PageAnon(page))
-		try_to_migrate(page, ttu_flags);
+	if (folio_test_anon(folio))
+		try_to_migrate(folio, ttu_flags);
 	else
 		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 766dc67874a1..5dcdd43d983d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -927,6 +927,7 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 static int __unmap_and_move(struct page *page, struct page *newpage,
 				int force, enum migrate_mode mode)
 {
+	struct folio *folio = page_folio(page);
 	int rc = -EAGAIN;
 	bool page_was_mapped = false;
 	struct anon_vma *anon_vma = NULL;
@@ -1030,7 +1031,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		/* Establish migration ptes */
 		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
 				page);
-		try_to_migrate(page, 0);
+		try_to_migrate(folio, 0);
 		page_was_mapped = true;
 	}
 
@@ -1173,6 +1174,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 				enum migrate_mode mode, int reason,
 				struct list_head *ret)
 {
+	struct folio *src = page_folio(hpage);
 	int rc = -EAGAIN;
 	int page_was_mapped = 0;
 	struct page *new_hpage;
@@ -1249,7 +1251,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 			ttu |= TTU_RMAP_LOCKED;
 		}
 
-		try_to_migrate(hpage, ttu);
+		try_to_migrate(src, ttu);
 		page_was_mapped = 1;
 
 		if (mapping_locked)
@@ -2449,6 +2451,7 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
 
 	for (i = 0; i < npages; i++) {
 		struct page *page = migrate_pfn_to_page(migrate->src[i]);
+		struct folio *folio;
 
 		if (!page)
 			continue;
@@ -2472,8 +2475,9 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
 			put_page(page);
 		}
 
-		if (page_mapped(page))
-			try_to_migrate(page, 0);
+		folio = page_folio(page);
+		if (folio_mapped(folio))
+			try_to_migrate(folio, 0);
 
 		if (page_mapped(page) || !migrate_vma_check_page(page)) {
 			if (!is_zone_device_page(page)) {
diff --git a/mm/rmap.c b/mm/rmap.c
index c598fd667948..4cfac67e328c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1767,7 +1767,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 	range.end = vma_address_end(&pvmw);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address, range.end);
-	if (PageHuge(page)) {
+	if (folio_test_hugetlb(folio)) {
 		/*
 		 * If sharing is possible, start and end will be adjusted
 		 * accordingly.
@@ -1781,21 +1781,24 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		/* PMD-mapped THP migration entry */
 		if (!pvmw.pte) {
-			VM_BUG_ON_PAGE(PageHuge(page) ||
-				       !PageTransCompound(page), page);
+			subpage = folio_page(folio,
+				pmd_pfn(*pvmw.pmd) - folio_pfn(folio));
+			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
+					!folio_test_pmd_mappable(folio), folio);
 
-			set_pmd_migration_entry(&pvmw, page);
+			set_pmd_migration_entry(&pvmw, subpage);
 			continue;
 		}
 #endif
 
 		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_PAGE(!pvmw.pte, page);
+		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+		subpage = folio_page(folio,
+				pte_pfn(*pvmw.pte) - folio_pfn(folio));
 		address = pvmw.address;
 
-		if (PageHuge(page) && !PageAnon(page)) {
+		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
 			/*
 			 * To call huge_pmd_unshare, i_mmap_rwsem must be
 			 * held in write mode.  Caller needs to explicitly
@@ -1833,15 +1836,15 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
 		pteval = ptep_clear_flush(vma, address, pvmw.pte);
 
-		/* Move the dirty bit to the page. Now the pte is gone. */
+		/* Set the dirty flag on the folio now the pte is gone. */
 		if (pte_dirty(pteval))
-			set_page_dirty(page);
+			folio_mark_dirty(folio);
 
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
-		if (is_zone_device_page(page)) {
-			unsigned long pfn = page_to_pfn(page);
+		if (folio_is_zone_device(folio)) {
+			unsigned long pfn = folio_pfn(folio);
 			swp_entry_t entry;
 			pte_t swp_pte;
 
@@ -1877,16 +1880,16 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			 * changed when hugepage migrations to device private
 			 * memory are supported.
 			 */
-			subpage = page;
-		} else if (PageHWPoison(page)) {
+			subpage = &folio->page;
+		} else if (PageHWPoison(subpage)) {
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
 
@@ -1901,7 +1904,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(page));
+			dec_mm_counter(mm, mm_counter(&folio->page));
 			/* We have to invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
 						      address + PAGE_SIZE);
@@ -1947,8 +1950,8 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, PageHuge(page));
-		put_page(page);
+		page_remove_rmap(subpage, folio_test_hugetlb(folio));
+		folio_put(folio);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
@@ -1958,13 +1961,13 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 
 /**
  * try_to_migrate - try to replace all page table mappings with swap entries
- * @page: the page to replace page table entries for
+ * @folio: the folio to replace page table entries for
  * @flags: action and flags
  *
- * Tries to remove all the page table entries which are mapping this page and
- * replace them with special swap entries. Caller must hold the page lock.
+ * Tries to remove all the page table entries which are mapping this folio and
+ * replace them with special swap entries. Caller must hold the folio lock.
  */
-void try_to_migrate(struct page *page, enum ttu_flags flags)
+void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_migrate_one,
@@ -1981,7 +1984,7 @@ void try_to_migrate(struct page *page, enum ttu_flags flags)
 					TTU_SYNC)))
 		return;
 
-	if (is_zone_device_page(page) && !is_device_private_page(page))
+	if (folio_is_zone_device(folio) && !folio_is_device_private(folio))
 		return;
 
 	/*
@@ -1992,13 +1995,13 @@ void try_to_migrate(struct page *page, enum ttu_flags flags)
 	 * locking requirements of exec(), migration skips
 	 * temporary VMAs until after exec() completes.
 	 */
-	if (!PageKsm(page) && PageAnon(page))
+	if (!folio_test_ksm(folio) && folio_test_anon(folio))
 		rwc.invalid_vma = invalid_migration_vma;
 
 	if (flags & TTU_RMAP_LOCKED)
-		rmap_walk_locked(page, &rwc);
+		rmap_walk_locked(&folio->page, &rwc);
 	else
-		rmap_walk(page, &rwc);
+		rmap_walk(&folio->page, &rwc);
 }
 
 /*
-- 
2.34.1

