Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E14AA0D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbiBDUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E23C061758
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZXJX8g+O71bIjUui7B0+veSLfk70kaEasqNlGiQVNKI=; b=fgwTe528KHcrWcQ14MONnNMDtA
        yRl1+31n//6VWp8+3xwgosA/PQSu9kl0IsVTd7jEIH9lWqScQXTR+PIZ9DcIprltD+LM5CKfANVpM
        aaEF5LeA6+9yVLw9pYcti+oRALY80g+ScvObBtav3wGi4zjjRUbOrgt82zjtzbpFGpCdwZz1e3C4a
        RIGmWVt0PeR80w6IYSLJHGECXKXOF8Q3sdqAmqtkv0pgFcMjNHrfMeVGETk4fe59d6ZjNVzufCS3M
        CRzjbZXZcnk82/MKdJ47jxYTVjKg1kw7Xuj4O6ReyYBKVHvuPuKXfhL82DDmAX6HPe/0FN6KFma7G
        ClBO2uTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jX-007LnO-SS; Fri, 04 Feb 2022 19:59:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 42/75] mm: Convert page_vma_mapped_walk to work on PFNs
Date:   Fri,  4 Feb 2022 19:58:19 +0000
Message-Id: <20220204195852.1751729-43-willy@infradead.org>
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

page_mapped_in_vma() really just wants to walk one page, but as the
code stands, if passed the head page of a compound page, it will
walk every page in the compound page.  Extract pfn/nr_pages/pgoff
from the struct page early, so they can be overridden by
page_mapped_in_vma().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/hugetlb.h |  5 ++++
 include/linux/rmap.h    | 17 ++++++++----
 mm/internal.h           | 15 ++++++-----
 mm/migrate.c            |  2 +-
 mm/page_vma_mapped.c    | 58 ++++++++++++++++++-----------------------
 mm/rmap.c               |  8 +++---
 6 files changed, 56 insertions(+), 49 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d1897a69c540..6ba2f8e74fbb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -970,6 +970,11 @@ static inline struct hstate *page_hstate(struct page *page)
 	return NULL;
 }
 
+static inline struct hstate *size_to_hstate(unsigned long size)
+{
+	return NULL;
+}
+
 static inline unsigned long huge_page_size(struct hstate *h)
 {
 	return PAGE_SIZE;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e076aca3a203..29ea97c5e96a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -11,6 +11,7 @@
 #include <linux/rwsem.h>
 #include <linux/memcontrol.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
@@ -200,11 +201,13 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 
 /* Avoid racy checks */
 #define PVMW_SYNC		(1 << 0)
-/* Look for migarion entries rather than present PTEs */
+/* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
 
 struct page_vma_mapped_walk {
-	struct page *page;
+	unsigned long pfn;
+	unsigned long nr_pages;
+	pgoff_t pgoff;
 	struct vm_area_struct *vma;
 	unsigned long address;
 	pmd_t *pmd;
@@ -216,19 +219,23 @@ struct page_vma_mapped_walk {
 static inline void pvmw_set_page(struct page_vma_mapped_walk *pvmw,
 		struct page *page)
 {
-	pvmw->page = page;
+	pvmw->pfn = page_to_pfn(page);
+	pvmw->nr_pages = compound_nr(page);
+	pvmw->pgoff = page_to_pgoff(page);
 }
 
 static inline void pvmw_set_folio(struct page_vma_mapped_walk *pvmw,
 		struct folio *folio)
 {
-	pvmw->page = &folio->page;
+	pvmw->pfn = folio_pfn(folio);
+	pvmw->nr_pages = folio_nr_pages(folio);
+	pvmw->pgoff = folio_pgoff(folio);
 }
 
 static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 {
 	/* HugeTLB pte is set to the relevant page table entry without pte_mapped. */
-	if (pvmw->pte && !PageHuge(pvmw->page))
+	if (pvmw->pte && !is_vm_hugetlb_page(pvmw->vma))
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
diff --git a/mm/internal.h b/mm/internal.h
index b7a2195c12b1..7f1db0f1a8bc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/rmap.h>
 #include <linux/tracepoint-defs.h>
 
 struct folio_batch;
@@ -459,18 +460,20 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 }
 
 /*
- * Then at what user virtual address will none of the page be found in vma?
+ * Then at what user virtual address will none of the range be found in vma?
  * Assumes that vma_address() already returned a good starting address.
- * If page is a compound head, the entire compound page is considered.
  */
-static inline unsigned long
-vma_address_end(struct page *page, struct vm_area_struct *vma)
+static inline unsigned long vma_address_end(struct page_vma_mapped_walk *pvmw)
 {
+	struct vm_area_struct *vma = pvmw->vma;
 	pgoff_t pgoff;
 	unsigned long address;
 
-	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
-	pgoff = page_to_pgoff(page) + compound_nr(page);
+	/* Common case, plus ->pgoff is invalid for KSM */
+	if (pvmw->nr_pages == 1)
+		return pvmw->address + PAGE_SIZE;
+
+	pgoff = pvmw->pgoff + pvmw->nr_pages;
 	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	/* Check for address beyond vma (or wrapped through 0?) */
 	if (address < vma->vm_start || address > vma->vm_end)
diff --git a/mm/migrate.c b/mm/migrate.c
index 07464fd45925..766dc67874a1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -191,7 +191,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		if (PageKsm(page))
 			new = page;
 		else
-			new = page - pvmw.page->index +
+			new = page - pvmw.pgoff +
 				linear_page_index(vma, pvmw.address);
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f7b331081791..1187f9c1ec5b 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -53,18 +53,6 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 	return true;
 }
 
-static inline bool pfn_is_match(struct page *page, unsigned long pfn)
-{
-	unsigned long page_pfn = page_to_pfn(page);
-
-	/* normal page and hugetlbfs page */
-	if (!PageTransCompound(page) || PageHuge(page))
-		return page_pfn == pfn;
-
-	/* THP can be referenced by any subpage */
-	return pfn >= page_pfn && pfn - page_pfn < thp_nr_pages(page);
-}
-
 /**
  * check_pte - check if @pvmw->page is mapped at the @pvmw->pte
  * @pvmw: page_vma_mapped_walk struct, includes a pair pte and page for checking
@@ -116,7 +104,17 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 		pfn = pte_pfn(*pvmw->pte);
 	}
 
-	return pfn_is_match(pvmw->page, pfn);
+	return (pfn - pvmw->pfn) < pvmw->nr_pages;
+}
+
+/* Returns true if the two ranges overlap.  Careful to not overflow. */
+static bool check_pmd(unsigned long pfn, struct page_vma_mapped_walk *pvmw)
+{
+	if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
+		return false;
+	if (pfn > pvmw->pfn + pvmw->nr_pages - 1)
+		return false;
+	return true;
 }
 
 static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
@@ -127,7 +125,7 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
 }
 
 /**
- * page_vma_mapped_walk - check if @pvmw->page is mapped in @pvmw->vma at
+ * page_vma_mapped_walk - check if @pvmw->pfn is mapped in @pvmw->vma at
  * @pvmw->address
  * @pvmw: pointer to struct page_vma_mapped_walk. page, vma, address and flags
  * must be set. pmd, pte and ptl must be NULL.
@@ -152,8 +150,8 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
  */
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 {
-	struct mm_struct *mm = pvmw->vma->vm_mm;
-	struct page *page = pvmw->page;
+	struct vm_area_struct *vma = pvmw->vma;
+	struct mm_struct *mm = vma->vm_mm;
 	unsigned long end;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -164,32 +162,26 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (pvmw->pmd && !pvmw->pte)
 		return not_found(pvmw);
 
-	if (unlikely(PageHuge(page))) {
+	if (unlikely(is_vm_hugetlb_page(vma))) {
+		unsigned long size = pvmw->nr_pages * PAGE_SIZE;
 		/* The only possible mapping was handled on last iteration */
 		if (pvmw->pte)
 			return not_found(pvmw);
 
 		/* when pud is not present, pte will be NULL */
-		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
+		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
 		if (!pvmw->pte)
 			return false;
 
-		pvmw->ptl = huge_pte_lockptr(page_hstate(page), mm, pvmw->pte);
+		pvmw->ptl = huge_pte_lockptr(size_to_hstate(size), mm,
+						pvmw->pte);
 		spin_lock(pvmw->ptl);
 		if (!check_pte(pvmw))
 			return not_found(pvmw);
 		return true;
 	}
 
-	/*
-	 * Seek to next pte only makes sense for THP.
-	 * But more important than that optimization, is to filter out
-	 * any PageKsm page: whose page->index misleads vma_address()
-	 * and vma_address_end() to disaster.
-	 */
-	end = PageTransCompound(page) ?
-		vma_address_end(page, pvmw->vma) :
-		pvmw->address + PAGE_SIZE;
+	end = vma_address_end(pvmw);
 	if (pvmw->pte)
 		goto next_pte;
 restart:
@@ -224,7 +216,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
-				if (pmd_page(pmde) != page)
+				if (!check_pmd(pmd_pfn(pmde), pvmw))
 					return not_found(pvmw);
 				return true;
 			}
@@ -236,7 +228,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				entry = pmd_to_swp_entry(pmde);
 				if (!is_migration_entry(entry) ||
-				    pfn_swap_entry_to_page(entry) != page)
+				    !check_pmd(swp_offset(entry), pvmw))
 					return not_found(pvmw);
 				return true;
 			}
@@ -250,7 +242,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
 			if ((pvmw->flags & PVMW_SYNC) &&
-			    PageTransCompound(page)) {
+			    transparent_hugepage_active(vma) &&
+			    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
 				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
 
 				spin_unlock(ptl);
@@ -307,7 +300,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma)
 {
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
+		.pfn = page_to_pfn(page),
+		.nr_pages = 1,
 		.vma = vma,
 		.flags = PVMW_SYNC,
 	};
diff --git a/mm/rmap.c b/mm/rmap.c
index fa8478372e94..d62a6fcef318 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -946,7 +946,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 	 */
 	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
 				0, vma, vma->vm_mm, address,
-				vma_address_end(page, vma));
+				vma_address_end(&pvmw));
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
@@ -1453,8 +1453,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	 * Note that the page can not be free in this function as call of
 	 * try_to_unmap() must hold a reference on the page.
 	 */
-	range.end = PageKsm(page) ?
-			address + PAGE_SIZE : vma_address_end(page, vma);
+	range.end = vma_address_end(&pvmw);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address, range.end);
 	if (PageHuge(page)) {
@@ -1757,8 +1756,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 	 * Note that the page can not be free in this function as call of
 	 * try_to_unmap() must hold a reference on the page.
 	 */
-	range.end = PageKsm(page) ?
-			address + PAGE_SIZE : vma_address_end(page, vma);
+	range.end = vma_address_end(&pvmw);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address, range.end);
 	if (PageHuge(page)) {
-- 
2.34.1

