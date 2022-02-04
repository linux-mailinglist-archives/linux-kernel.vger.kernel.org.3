Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC414AA0C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiBDUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiBDT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B491C061768
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=upR0ccIncisj2dvsJYuu3dh0MkD7JYPSdEAM0Zbapz8=; b=C6qzo6CB9W6zST1Qhsd3lqRrFl
        OCesn6efWlnqF0SOdqWqb1n5FKyD8Pm0H+m5ggMZjMaUBM5sm7lbB+oTVAZty+mrKbp0slsSndu2C
        Zk6iivWxpM9UG8OuOYFiaEhFJLf2ZU/zGVG0m0dtZjouTRZg8Y9X+UF+sZxnrEfiuGcSsMO9xknqL
        ZqpJUCGxqDxUl0zVUtR11ooLl99PFy7I8bnhr/Grw9j4871cnWOo2tHivhCPMWzQ4u44/8lDJOoPk
        mUbPDaceheuOMWBrc89Z5jXqQgEANp5umafClAqowgNgC1LoPsUssZdEEcq7skDU1P9YXg3fwkqGu
        rf5kvqOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jZ-007Lp0-FF; Fri, 04 Feb 2022 19:59:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 54/75] mm/migrate: Convert remove_migration_ptes() to folios
Date:   Fri,  4 Feb 2022 19:58:31 +0000
Message-Id: <20220204195852.1751729-55-willy@infradead.org>
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

Convert the implementation and all callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rmap.h |  2 +-
 mm/huge_memory.c     | 24 +++++++-------
 mm/migrate.c         | 74 +++++++++++++++++++++++++-------------------
 3 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 502439f20d88..85d17a38642c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -263,7 +263,7 @@ int folio_mkclean(struct folio *);
 void page_mlock(struct page *page);
 void folio_mlock(struct folio *folio);
 
-void remove_migration_ptes(struct page *old, struct page *new, bool locked);
+void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
 
 /*
  * Called by memory-failure.c to kill processes.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 21676a4afd07..7a0f4aaf7838 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2302,18 +2302,19 @@ static void unmap_page(struct page *page)
 	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
 
-static void remap_page(struct page *page, unsigned int nr)
+static void remap_page(struct folio *folio, unsigned long nr)
 {
-	int i;
+	int i = 0;
 
 	/* If unmap_page() uses try_to_migrate() on file, remove this check */
-	if (!PageAnon(page))
+	if (!folio_test_anon(folio))
 		return;
-	if (PageTransHuge(page)) {
-		remove_migration_ptes(page, page, true);
-	} else {
-		for (i = 0; i < nr; i++)
-			remove_migration_ptes(page + i, page + i, true);
+	for (;;) {
+		remove_migration_ptes(folio, folio, true);
+		i += folio_nr_pages(folio);
+		if (i >= nr)
+			break;
+		folio = folio_next(folio);
 	}
 }
 
@@ -2470,7 +2471,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 	local_irq_enable();
 
-	remap_page(head, nr);
+	remap_page(folio, nr);
 
 	if (PageSwapCache(head)) {
 		swp_entry_t entry = { .val = page_private(head) };
@@ -2579,7 +2580,8 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
  */
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
+	struct page *head = &folio->page;
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	XA_STATE(xas, &head->mapping->i_pages, head->index);
 	struct anon_vma *anon_vma = NULL;
@@ -2696,7 +2698,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		if (mapping)
 			xas_unlock(&xas);
 		local_irq_enable();
-		remap_page(head, thp_nr_pages(head));
+		remap_page(folio, folio_nr_pages(folio));
 		ret = -EBUSY;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 5dcdd43d983d..4daa8298c79a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -176,34 +176,36 @@ void putback_movable_pages(struct list_head *l)
 static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 				 unsigned long addr, void *old)
 {
+	struct folio *folio = page_folio(page);
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = addr,
 		.flags = PVMW_SYNC | PVMW_MIGRATION,
 	};
-	struct page *new;
-	pte_t pte;
-	swp_entry_t entry;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	pvmw_set_page(&pvmw, old);
 	while (page_vma_mapped_walk(&pvmw)) {
-		if (PageKsm(page))
-			new = page;
-		else
-			new = page - pvmw.pgoff +
-				linear_page_index(vma, pvmw.address);
+		pte_t pte;
+		swp_entry_t entry;
+		struct page *new;
+		unsigned long idx = 0;
+
+		if (!folio_test_ksm(folio))
+			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
+		new = folio_page(folio, idx);
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		/* PMD-mapped THP migration entry */
 		if (!pvmw.pte) {
-			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
+			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
+					!folio_test_pmd_mappable(folio), folio);
 			remove_migration_pmd(&pvmw, new);
 			continue;
 		}
 #endif
 
-		get_page(new);
+		folio_get(folio);
 		pte = pte_mkold(mk_pte(new, READ_ONCE(vma->vm_page_prot)));
 		if (pte_swp_soft_dirty(*pvmw.pte))
 			pte = pte_mksoft_dirty(pte);
@@ -232,12 +234,12 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		}
 
 #ifdef CONFIG_HUGETLB_PAGE
-		if (PageHuge(new)) {
+		if (folio_test_hugetlb(folio)) {
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
 			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
-			if (PageAnon(new))
+			if (folio_test_anon(folio))
 				hugepage_add_anon_rmap(new, vma, pvmw.address);
 			else
 				page_dup_rmap(new, true);
@@ -245,17 +247,17 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		} else
 #endif
 		{
-			if (PageAnon(new))
+			if (folio_test_anon(folio))
 				page_add_anon_rmap(new, vma, pvmw.address, false);
 			else
 				page_add_file_rmap(new, false);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
-		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
-			mlock_vma_page(new);
+		if (vma->vm_flags & VM_LOCKED && !folio_test_large(folio))
+			mlock_vma_folio(folio);
 
-		if (PageTransHuge(page) && PageMlocked(page))
-			clear_page_mlock(page);
+		if (folio_test_large(folio) && folio_test_mlocked(folio))
+			folio_end_mlock(folio);
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
@@ -268,17 +270,17 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  */
-void remove_migration_ptes(struct page *old, struct page *new, bool locked)
+void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = remove_migration_pte,
-		.arg = old,
+		.arg = src,
 	};
 
 	if (locked)
-		rmap_walk_locked(new, &rwc);
+		rmap_walk_locked(&dst->page, &rwc);
 	else
-		rmap_walk(new, &rwc);
+		rmap_walk(&dst->page, &rwc);
 }
 
 /*
@@ -771,6 +773,7 @@ int buffer_migrate_page_norefs(struct address_space *mapping,
  */
 static int writeout(struct address_space *mapping, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 		.nr_to_write = 1,
@@ -796,7 +799,7 @@ static int writeout(struct address_space *mapping, struct page *page)
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
-	remove_migration_ptes(page, page, false);
+	remove_migration_ptes(folio, folio, false);
 
 	rc = mapping->a_ops->writepage(page, &wbc);
 
@@ -928,6 +931,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 				int force, enum migrate_mode mode)
 {
 	struct folio *folio = page_folio(page);
+	struct folio *dst = page_folio(newpage);
 	int rc = -EAGAIN;
 	bool page_was_mapped = false;
 	struct anon_vma *anon_vma = NULL;
@@ -1039,8 +1043,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		rc = move_to_new_page(newpage, page, mode);
 
 	if (page_was_mapped)
-		remove_migration_ptes(page,
-			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false);
+		remove_migration_ptes(folio,
+			rc == MIGRATEPAGE_SUCCESS ? dst : folio, false);
 
 out_unlock_both:
 	unlock_page(newpage);
@@ -1174,7 +1178,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 				enum migrate_mode mode, int reason,
 				struct list_head *ret)
 {
-	struct folio *src = page_folio(hpage);
+	struct folio *dst, *src = page_folio(hpage);
 	int rc = -EAGAIN;
 	int page_was_mapped = 0;
 	struct page *new_hpage;
@@ -1202,6 +1206,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	new_hpage = get_new_page(hpage, private);
 	if (!new_hpage)
 		return -ENOMEM;
+	dst = page_folio(new_hpage);
 
 	if (!trylock_page(hpage)) {
 		if (!force)
@@ -1262,8 +1267,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		rc = move_to_new_page(new_hpage, hpage, mode);
 
 	if (page_was_mapped)
-		remove_migration_ptes(hpage,
-			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
+		remove_migration_ptes(src,
+			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
 
 unlock_put_anon:
 	unlock_page(new_hpage);
@@ -2494,15 +2499,17 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
 
 	for (i = 0; i < npages && restore; i++) {
 		struct page *page = migrate_pfn_to_page(migrate->src[i]);
+		struct folio *folio;
 
 		if (!page || (migrate->src[i] & MIGRATE_PFN_MIGRATE))
 			continue;
 
-		remove_migration_ptes(page, page, false);
+		folio = page_folio(page);
+		remove_migration_ptes(folio, folio, false);
 
 		migrate->src[i] = 0;
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		restore--;
 	}
 }
@@ -2851,6 +2858,7 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 	unsigned long i;
 
 	for (i = 0; i < npages; i++) {
+		struct folio *dst, *src;
 		struct page *newpage = migrate_pfn_to_page(migrate->dst[i]);
 		struct page *page = migrate_pfn_to_page(migrate->src[i]);
 
@@ -2870,8 +2878,10 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 			newpage = page;
 		}
 
-		remove_migration_ptes(page, newpage, false);
-		unlock_page(page);
+		src = page_folio(page);
+		dst = page_folio(newpage);
+		remove_migration_ptes(src, dst, false);
+		folio_unlock(src);
 
 		if (is_zone_device_page(page))
 			put_page(page);
-- 
2.34.1

