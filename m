Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D764AA0AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbiBDUB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA3BC06175C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ym+IactTUMSvZR1PxH1OAAkr+/wd9anwn29KzzaRfhU=; b=CIFoqRqMRT4Xj8BshTG15EL3AI
        o9MTT8l47D3O29zud28Es1ajooLm0BZlFQKn3w8RIQN4Tsjz1QSUlS9pY0bC9nbhmWHeQUCVrW0Lz
        AB8nnNqMMNgxt9obUdAGGj3xQ3EAXAW8m3X6PQUI5kCUwaGgXCh6UHdQABsX6SOutMKFHyfjmNDPX
        ehhJe9bDmwKRWDsi5mDDBCvOQdq6psu1TsSwwr7AFx0EY24GnpMaEfh6oyaVBFh2kxdkkhExIg3FD
        0zGx2cyCNbMaK67jccqYc+8IT7rdxJ+UB8jDgD6U7Hh/h69BLgBoEZu/AZ+PKvzgds9TuOV0rIe4L
        wd8GltgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jY-007Lni-7u; Fri, 04 Feb 2022 19:59:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 45/75] mm/rmap: Turn page_referenced() into folio_referenced()
Date:   Fri,  4 Feb 2022 19:58:22 +0000
Message-Id: <20220204195852.1751729-46-willy@infradead.org>
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

Both its callers pass a page which was previously on an LRU list,
so were passing a folio by definition.  Use the type system to enforce
that and remove a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rmap.h |  4 ++--
 mm/mlock.c           |  4 ++--
 mm/page_idle.c       |  2 +-
 mm/rmap.c            | 46 ++++++++++++++++++++++----------------------
 mm/vmscan.c          | 20 +++++++++++--------
 5 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 29ea97c5e96a..00b772cdaaaa 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -189,7 +189,7 @@ static inline void page_dup_rmap(struct page *page, bool compound)
 /*
  * Called from mm/vmscan.c to handle paging out
  */
-int page_referenced(struct page *, int is_locked,
+int folio_referenced(struct folio *, int is_locked,
 			struct mem_cgroup *memcg, unsigned long *vm_flags);
 
 void try_to_migrate(struct page *page, enum ttu_flags flags);
@@ -302,7 +302,7 @@ void rmap_walk_locked(struct page *page, struct rmap_walk_control *rwc);
 #define anon_vma_prepare(vma)	(0)
 #define anon_vma_link(vma)	do {} while (0)
 
-static inline int page_referenced(struct page *page, int is_locked,
+static inline int folio_referenced(struct folio *folio, int is_locked,
 				  struct mem_cgroup *memcg,
 				  unsigned long *vm_flags)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index 8f584eddd305..24d0809cacba 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -134,7 +134,7 @@ static void __munlock_isolated_page(struct page *page)
  * Performs accounting when page isolation fails in munlock. There is nothing
  * else to do because it means some other task has already removed the page
  * from the LRU. putback_lru_page() will take care of removing the page from
- * the unevictable list, if necessary. vmscan [page_referenced()] will move
+ * the unevictable list, if necessary. vmscan [folio_referenced()] will move
  * the page back to the unevictable list if some other vma has it mlocked.
  */
 static void __munlock_isolation_failed(struct page *page)
@@ -163,7 +163,7 @@ static void __munlock_isolation_failed(struct page *page)
  * task has removed the page from the LRU, we won't be able to do that.
  * So we clear the PageMlocked as we might not get another chance.  If we
  * can't isolate the page, we leave it for putback_lru_page() and vmscan
- * [page_referenced()/try_to_unmap()] to deal with.
+ * [folio_referenced()/try_to_unmap()] to deal with.
  */
 unsigned int munlock_vma_page(struct page *page)
 {
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 544814bd9e37..35e53db430df 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -81,7 +81,7 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
 		/*
 		 * We cleared the referenced bit in a mapping to this page. To
 		 * avoid interference with page reclaim, mark it young so that
-		 * page_referenced() will return > 0.
+		 * folio_referenced() will return > 0.
 		 */
 		folio_set_young(folio);
 	}
diff --git a/mm/rmap.c b/mm/rmap.c
index 18ae6bd79efd..1cedcfd6105c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -801,6 +801,7 @@ struct page_referenced_arg {
 static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 			unsigned long address, void *arg)
 {
+	struct folio *folio = page_folio(page);
 	struct page_referenced_arg *pra = arg;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -824,10 +825,10 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 				/*
 				 * Don't treat a reference through
 				 * a sequentially read mapping as such.
-				 * If the page has been used in another mapping,
+				 * If the folio has been used in another mapping,
 				 * we will catch it; if this other mapping is
 				 * already gone, the unmap path will have set
-				 * PG_referenced or activated the page.
+				 * the referenced flag or activated the folio.
 				 */
 				if (likely(!(vma->vm_flags & VM_SEQ_READ)))
 					referenced++;
@@ -837,7 +838,7 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 						pvmw.pmd))
 				referenced++;
 		} else {
-			/* unexpected pmd-mapped page? */
+			/* unexpected pmd-mapped folio? */
 			WARN_ON_ONCE(1);
 		}
 
@@ -845,8 +846,8 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 	}
 
 	if (referenced)
-		clear_page_idle(page);
-	if (test_and_clear_page_young(page))
+		folio_clear_idle(folio);
+	if (folio_test_clear_young(folio))
 		referenced++;
 
 	if (referenced) {
@@ -872,23 +873,22 @@ static bool invalid_page_referenced_vma(struct vm_area_struct *vma, void *arg)
 }
 
 /**
- * page_referenced - test if the page was referenced
- * @page: the page to test
- * @is_locked: caller holds lock on the page
+ * folio_referenced() - Test if the folio was referenced.
+ * @folio: The folio to test.
+ * @is_locked: Caller holds lock on the folio.
  * @memcg: target memory cgroup
- * @vm_flags: collect encountered vma->vm_flags who actually referenced the page
+ * @vm_flags: A combination of all the vma->vm_flags which referenced the folio.
+ *
+ * Quick test_and_clear_referenced for all mappings of a folio,
  *
- * Quick test_and_clear_referenced for all mappings to a page,
- * returns the number of ptes which referenced the page.
+ * Return: The number of mappings which referenced the folio.
  */
-int page_referenced(struct page *page,
-		    int is_locked,
-		    struct mem_cgroup *memcg,
-		    unsigned long *vm_flags)
+int folio_referenced(struct folio *folio, int is_locked,
+		     struct mem_cgroup *memcg, unsigned long *vm_flags)
 {
 	int we_locked = 0;
 	struct page_referenced_arg pra = {
-		.mapcount = total_mapcount(page),
+		.mapcount = folio_mapcount(folio),
 		.memcg = memcg,
 	};
 	struct rmap_walk_control rwc = {
@@ -901,11 +901,11 @@ int page_referenced(struct page *page,
 	if (!pra.mapcount)
 		return 0;
 
-	if (!page_rmapping(page))
+	if (!folio_raw_mapping(folio))
 		return 0;
 
-	if (!is_locked && (!PageAnon(page) || PageKsm(page))) {
-		we_locked = trylock_page(page);
+	if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
+		we_locked = folio_trylock(folio);
 		if (!we_locked)
 			return 1;
 	}
@@ -919,11 +919,11 @@ int page_referenced(struct page *page,
 		rwc.invalid_vma = invalid_page_referenced_vma;
 	}
 
-	rmap_walk(page, &rwc);
+	rmap_walk(&folio->page, &rwc);
 	*vm_flags = pra.vm_flags;
 
 	if (we_locked)
-		unlock_page(page);
+		folio_unlock(folio);
 
 	return pra.referenced;
 }
@@ -1058,8 +1058,8 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	/*
 	 * Ensure that anon_vma and the PAGE_MAPPING_ANON bit are written
-	 * simultaneously, so a concurrent reader (eg page_referenced()'s
-	 * PageAnon()) will not see one without the other.
+	 * simultaneously, so a concurrent reader (eg folio_referenced()'s
+	 * folio_test_anon()) will not see one without the other.
 	 */
 	WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0d23ade9f6e2..1e751ba3b4a8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1379,11 +1379,12 @@ enum page_references {
 static enum page_references page_check_references(struct page *page,
 						  struct scan_control *sc)
 {
+	struct folio *folio = page_folio(page);
 	int referenced_ptes, referenced_page;
 	unsigned long vm_flags;
 
-	referenced_ptes = page_referenced(page, 1, sc->target_mem_cgroup,
-					  &vm_flags);
+	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
+					   &vm_flags);
 	referenced_page = TestClearPageReferenced(page);
 
 	/*
@@ -2483,7 +2484,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
  *
  * If the pages are mostly unmapped, the processing is fast and it is
  * appropriate to hold lru_lock across the whole operation.  But if
- * the pages are mapped, the processing is slow (page_referenced()), so
+ * the pages are mapped, the processing is slow (folio_referenced()), so
  * we should drop lru_lock around each page.  It's impossible to balance
  * this, so instead we remove the pages from the LRU while processing them.
  * It is safe to rely on PG_active against the non-LRU pages in here because
@@ -2503,7 +2504,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_active);
 	LIST_HEAD(l_inactive);
-	struct page *page;
 	unsigned nr_deactivate, nr_activate;
 	unsigned nr_rotated = 0;
 	int file = is_file_lru(lru);
@@ -2525,9 +2525,13 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	spin_unlock_irq(&lruvec->lru_lock);
 
 	while (!list_empty(&l_hold)) {
+		struct folio *folio;
+		struct page *page;
+
 		cond_resched();
-		page = lru_to_page(&l_hold);
-		list_del(&page->lru);
+		folio = lru_to_folio(&l_hold);
+		list_del(&folio->lru);
+		page = &folio->page;
 
 		if (unlikely(!page_evictable(page))) {
 			putback_lru_page(page);
@@ -2542,8 +2546,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 			}
 		}
 
-		if (page_referenced(page, 0, sc->target_mem_cgroup,
-				    &vm_flags)) {
+		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
+				     &vm_flags)) {
 			/*
 			 * Identify referenced, file-backed active pages and
 			 * give them one more trip around the active list. So
-- 
2.34.1

