Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5374AA0C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbiBDUDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA34C061760
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=o/R+lQNQz2S9kttUND7xl8Fc8rIYoPPqfeSJIPC2IiE=; b=kIDCkYhgA64vQwfZuKld1Xh8KJ
        LMlStEtM6+YNsCitN0G96IvtSQvWcz3ochaqjgtz3vajIP2NQ66N5Z/FyktRf9MUSSbGh0X23CdaT
        +Kb/RoFnH3ms5tQ8ChAjTq4LDkTlUYoRC31TFAShIKnMDNbIviRPgxMUY9uitlZSgwTq4WstkFxp1
        I5rLmvDj5prZTaCfZQECDYGwUKbn/CH6G0+iqKc0gBIlNQ6wlTHG9YmreVUI87OM8ixGqbWXY7VHr
        coQmV0PNuMyS6h2sueTlO32sEm7TcuJCRB4RzPD9yVCRF/5JIBL6BN3caPHYCSvZMizHe1mo4aUL8
        Se46oAvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jY-007LoI-SV; Fri, 04 Feb 2022 19:59:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 50/75] mm/huge_memory: Convert __split_huge_pmd() to take a folio
Date:   Fri,  4 Feb 2022 19:58:27 +0000
Message-Id: <20220204195852.1751729-51-willy@infradead.org>
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

Convert split_huge_pmd_address() at the same time since it only passes
the folio through, and its two callers already have a folio on hand.
Removes numerous calls to compound_head() and removes an assumption
that a page cannot be larger than a PMD.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  8 +++----
 mm/huge_memory.c        | 50 ++++++++++++++++++++---------------------
 mm/rmap.c               |  6 +++--
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71c073d411ac..4368b314d9c8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -194,7 +194,7 @@ static inline int split_huge_page(struct page *page)
 void deferred_split_huge_page(struct page *page);
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long address, bool freeze, struct page *page);
+		unsigned long address, bool freeze, struct folio *folio);
 
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
@@ -207,7 +207,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 
 
 void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
-		bool freeze, struct page *page);
+		bool freeze, struct folio *folio);
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long address);
@@ -406,9 +406,9 @@ static inline void deferred_split_huge_page(struct page *page) {}
 	do { } while (0)
 
 static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long address, bool freeze, struct page *page) {}
+		unsigned long address, bool freeze, struct folio *folio) {}
 static inline void split_huge_pmd_address(struct vm_area_struct *vma,
-		unsigned long address, bool freeze, struct page *page) {}
+		unsigned long address, bool freeze, struct folio *folio) {}
 
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94e591d638eb..f934b93d08ca 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2143,11 +2143,11 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 }
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long address, bool freeze, struct page *page)
+		unsigned long address, bool freeze, struct folio *folio)
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
-	bool do_unlock_page = false;
+	bool do_unlock_folio = false;
 	pmd_t _pmd;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
@@ -2157,20 +2157,20 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	ptl = pmd_lock(vma->vm_mm, pmd);
 
 	/*
-	 * If caller asks to setup a migration entries, we need a page to check
-	 * pmd against. Otherwise we can end up replacing wrong page.
+	 * If caller asks to setup a migration entry, we need a folio to check
+	 * pmd against. Otherwise we can end up replacing wrong folio.
 	 */
-	VM_BUG_ON(freeze && !page);
-	if (page) {
-		VM_WARN_ON_ONCE(!PageLocked(page));
-		if (page != pmd_page(*pmd))
+	VM_BUG_ON(freeze && !folio);
+	if (folio) {
+		VM_WARN_ON_ONCE(!folio_test_locked(folio));
+		if (folio != page_folio(pmd_page(*pmd)))
 			goto out;
 	}
 
 repeat:
 	if (pmd_trans_huge(*pmd)) {
-		if (!page) {
-			page = pmd_page(*pmd);
+		if (!folio) {
+			folio = page_folio(pmd_page(*pmd));
 			/*
 			 * An anonymous page must be locked, to ensure that a
 			 * concurrent reuse_swap_page() sees stable mapcount;
@@ -2178,33 +2178,33 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			 * and page lock must not be taken when zap_pmd_range()
 			 * calls __split_huge_pmd() while i_mmap_lock is held.
 			 */
-			if (PageAnon(page)) {
-				if (unlikely(!trylock_page(page))) {
-					get_page(page);
+			if (folio_test_anon(folio)) {
+				if (unlikely(!folio_trylock(folio))) {
+					folio_get(folio);
 					_pmd = *pmd;
 					spin_unlock(ptl);
-					lock_page(page);
+					folio_lock(folio);
 					spin_lock(ptl);
 					if (unlikely(!pmd_same(*pmd, _pmd))) {
-						unlock_page(page);
-						put_page(page);
-						page = NULL;
+						folio_unlock(folio);
+						folio_put(folio);
+						folio = NULL;
 						goto repeat;
 					}
-					put_page(page);
+					folio_put(folio);
 				}
-				do_unlock_page = true;
+				do_unlock_folio = true;
 			}
 		}
-		if (PageMlocked(page))
-			clear_page_mlock(page);
+		if (folio_test_mlocked(folio))
+			folio_end_mlock(folio);
 	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
 		goto out;
 	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
 out:
 	spin_unlock(ptl);
-	if (do_unlock_page)
-		unlock_page(page);
+	if (do_unlock_folio)
+		folio_unlock(folio);
 	/*
 	 * No need to double call mmu_notifier->invalidate_range() callback.
 	 * They are 3 cases to consider inside __split_huge_pmd_locked():
@@ -2222,7 +2222,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 }
 
 void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
-		bool freeze, struct page *page)
+		bool freeze, struct folio *folio)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -2243,7 +2243,7 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 
 	pmd = pmd_offset(pud, address);
 
-	__split_huge_pmd(vma, pmd, address, freeze, page);
+	__split_huge_pmd(vma, pmd, address, freeze, folio);
 }
 
 static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
diff --git a/mm/rmap.c b/mm/rmap.c
index a383e25fb196..42a147746ff8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1422,6 +1422,7 @@ void page_remove_rmap(struct page *page, bool compound)
 static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
+	struct folio *folio = page_folio(page);
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -1444,7 +1445,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		pvmw.flags = PVMW_SYNC;
 
 	if (flags & TTU_SPLIT_HUGE_PMD)
-		split_huge_pmd_address(vma, address, false, page);
+		split_huge_pmd_address(vma, address, false, folio);
 
 	/*
 	 * For THP, we have to assume the worse case ie pmd for invalidation.
@@ -1721,6 +1722,7 @@ void try_to_unmap(struct page *page, enum ttu_flags flags)
 static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
+	struct folio *folio = page_folio(page);
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -1747,7 +1749,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 	 * TTU_SPLIT_HUGE_PMD and it wants to freeze.
 	 */
 	if (flags & TTU_SPLIT_HUGE_PMD)
-		split_huge_pmd_address(vma, address, true, page);
+		split_huge_pmd_address(vma, address, true, folio);
 
 	/*
 	 * For THP, we have to assume the worse case ie pmd for invalidation.
-- 
2.34.1

