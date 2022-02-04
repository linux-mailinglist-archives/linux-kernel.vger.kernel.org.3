Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1833A4AA09C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiBDUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F5C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=izsXeAyMwji7NT2VLQq4XArrQ6mR4M3kQTuXbNI6dG8=; b=ZY7NHv98WBbMI0thwkgk2JliNb
        F4bBX4Iy5U3U+keYuogOFrOTFaedNF6gjXA2c2xaPRd60W1XKeasU1JtXBpKWbzkowtaG9y+WpQIX
        QMlBu+Tf/eiXytaFbl2VpAkcZd4X0O9XP+deDyVFl+qRjgUy6b5tu5H8tNDraGI1zTEN/8IhzGfu7
        3Nc1Qafbq/NP7txRPKfXMlr5f92d1oWXlP3Kr4wROMmk5EaJkJYsObyNU9BLaGPo9t8R23TsgEXG2
        ouHLri1WFzWKXvqqd3lowwM+V9Jh+rRNPEiRuRUCJLreTaMxJ3zZkbX7yvocb8eetvJBK2SuP8Irz
        O9uWr1aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jY-007LoC-PU; Fri, 04 Feb 2022 19:59:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 49/75] mm/mlock: Turn munlock_vma_page() into munlock_vma_folio()
Date:   Fri,  4 Feb 2022 19:58:26 +0000
Message-Id: <20220204195852.1751729-50-willy@infradead.org>
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

Add back munlock_vma_page() as a wrapper function.  Saves a few calls
to compound_head() and an assertion that the page is not a tail page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/folio-compat.c |  5 +++
 mm/internal.h     |  3 +-
 mm/mlock.c        | 86 +++++++++++++++++++++++------------------------
 3 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 90f03187a5e3..3804fd8c1f20 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -176,6 +176,11 @@ void mlock_vma_page(struct page *page)
 	mlock_vma_folio(page_folio(page));
 }
 
+unsigned long munlock_vma_page(struct page *page)
+{
+	return munlock_vma_folio(page_folio(page));
+}
+
 void page_mlock(struct page *page)
 {
 	folio_mlock(page_folio(page));
diff --git a/mm/internal.h b/mm/internal.h
index 18b024aa7e59..66645972cbd7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -413,7 +413,8 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
  */
 void mlock_vma_page(struct page *page);
 void mlock_vma_folio(struct folio *folio);
-extern unsigned int munlock_vma_page(struct page *page);
+unsigned long munlock_vma_page(struct page *page);
+unsigned long munlock_vma_folio(struct folio *folio);
 
 extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
 			      unsigned long len);
diff --git a/mm/mlock.c b/mm/mlock.c
index d998fd5c84bf..f188038ef48e 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -115,82 +115,81 @@ void mlock_vma_folio(struct folio *folio)
 /*
  * Finish munlock after successful page isolation
  *
- * Page must be locked. This is a wrapper for page_mlock()
- * and putback_lru_page() with munlock accounting.
+ * Folio must be locked. This is a wrapper for folio_mlock()
+ * and folio_putback_lru() with munlock accounting.
  */
-static void __munlock_isolated_page(struct page *page)
+static void __munlock_isolated_folio(struct folio *folio)
 {
 	/*
 	 * Optimization: if the page was mapped just once, that's our mapping
 	 * and we don't need to check all the other vmas.
 	 */
-	if (page_mapcount(page) > 1)
-		page_mlock(page);
+	/* XXX: should be folio_mapcount(), surely? */
+	if (page_mapcount(&folio->page) > 1)
+		folio_mlock(folio);
 
 	/* Did try_to_unlock() succeed or punt? */
-	if (!PageMlocked(page))
-		count_vm_events(UNEVICTABLE_PGMUNLOCKED, thp_nr_pages(page));
+	if (!folio_test_mlocked(folio))
+		count_vm_events(UNEVICTABLE_PGMUNLOCKED, folio_nr_pages(folio));
 
-	putback_lru_page(page);
+	folio_putback_lru(folio);
 }
 
 /*
- * Accounting for page isolation fail during munlock
+ * Accounting for folio isolation fail during munlock
  *
- * Performs accounting when page isolation fails in munlock. There is nothing
- * else to do because it means some other task has already removed the page
- * from the LRU. putback_lru_page() will take care of removing the page from
+ * Performs accounting when folio isolation fails in munlock. There is nothing
+ * else to do because it means some other task has already removed the folio
+ * from the LRU. folio_putback_lru() will take care of removing the folio from
  * the unevictable list, if necessary. vmscan [folio_referenced()] will move
- * the page back to the unevictable list if some other vma has it mlocked.
+ * the folio back to the unevictable list if some other vma has it mlocked.
  */
-static void __munlock_isolation_failed(struct page *page)
+static void __munlock_isolation_failed(struct folio *folio)
 {
-	int nr_pages = thp_nr_pages(page);
+	long nr_pages = folio_nr_pages(folio);
 
-	if (PageUnevictable(page))
+	if (folio_test_unevictable(folio))
 		__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
 	else
 		__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 }
 
 /**
- * munlock_vma_page - munlock a vma page
- * @page: page to be unlocked, either a normal page or THP page head
+ * munlock_vma_folio() - munlock a vma folio.
+ * @folio: Folio to be unlocked.
  *
- * returns the size of the page as a page mask (0 for normal page,
- *         HPAGE_PMD_NR - 1 for THP head page)
- *
- * called from munlock()/munmap() path with page supposedly on the LRU.
- * When we munlock a page, because the vma where we found the page is being
+ * called from munlock()/munmap() path with folio supposedly on the LRU.
+ * When we munlock a folio, because the vma where we found the folio is being
  * munlock()ed or munmap()ed, we want to check whether other vmas hold the
- * page locked so that we can leave it on the unevictable lru list and not
- * bother vmscan with it.  However, to walk the page's rmap list in
- * page_mlock() we must isolate the page from the LRU.  If some other
- * task has removed the page from the LRU, we won't be able to do that.
- * So we clear the PageMlocked as we might not get another chance.  If we
- * can't isolate the page, we leave it for putback_lru_page() and vmscan
+ * folio locked so that we can leave it on the unevictable lru list and not
+ * bother vmscan with it.  However, to walk the folio's rmap list in
+ * folio_mlock() we must isolate the folio from the LRU.  If some other
+ * task has removed the folio from the LRU, we won't be able to do that.
+ * So we clear the folio mlocked flag as we might not get another chance.  If
+ * we can't isolate the folio, we leave it for folio_putback_lru() and vmscan
  * [folio_referenced()/try_to_unmap()] to deal with.
+ *
+ * Return: The size of the folio as a page mask (2^order - 1).
  */
-unsigned int munlock_vma_page(struct page *page)
+unsigned long munlock_vma_folio(struct folio *folio)
 {
-	int nr_pages;
+	long nr_pages;
 
-	/* For page_mlock() and to serialize with page migration */
-	BUG_ON(!PageLocked(page));
-	VM_BUG_ON_PAGE(PageTail(page), page);
+	/* For folio_mlock() and to serialize with page migration */
+	BUG_ON(!folio_test_locked(folio));
 
-	if (!TestClearPageMlocked(page)) {
-		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
+	if (!folio_test_clear_mlocked(folio)) {
+		/* Potentially, PTE-mapped folio: do not skip the other PTEs */
 		return 0;
 	}
 
-	nr_pages = thp_nr_pages(page);
-	mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+	nr_pages = folio_nr_pages(folio);
+	zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
 
-	if (!isolate_lru_page(page))
-		__munlock_isolated_page(page);
+	if (!folio_isolate_lru(folio))
+		__munlock_isolated_folio(folio);
 	else
-		__munlock_isolation_failed(page);
+		__munlock_isolation_failed(folio);
 
 	return nr_pages - 1;
 }
@@ -289,7 +288,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 				del_page_from_lru_list(page, lruvec);
 				continue;
 			} else
-				__munlock_isolation_failed(page);
+				__munlock_isolation_failed(folio);
 		} else {
 			delta_munlocked++;
 		}
@@ -318,6 +317,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		struct page *page = pvec->pages[i];
 
 		if (page) {
+			struct folio *folio = page_folio(page);
 			lock_page(page);
 			if (!__putback_lru_fast_prepare(page, &pvec_putback,
 					&pgrescued)) {
@@ -326,7 +326,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 				 * pin before unlock_page()
 				 */
 				get_page(page); /* for putback_lru_page() */
-				__munlock_isolated_page(page);
+				__munlock_isolated_folio(folio);
 				unlock_page(page);
 				put_page(page); /* from follow_page_mask() */
 			}
-- 
2.34.1

