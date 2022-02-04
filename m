Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5D4AA0B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiBDUCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28831C06175D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pLnVedokY1Ob/m0v2fa0YulRbXFZgihTv65vJ0dIKko=; b=octtxBvPIrfnM0elg0Mbm4fihl
        KklKhXhWv6upis6fOOmar0Vr+b29vfISmwj3SMNkWX+j7YrJQWAg6QdnrPx0iTz/zRgkrlYKM0fyu
        YOOPMwfZS5RCoDCBKfQg4tr9IZNCNhObd8Fj09aCVSzFb+LXM8uN6sOMcKlqupcPUJ4hA77V2nIkk
        DgFal7d6w3DP9y47BjziJ30pS7vh9ssMQebXVenuxFPxsG9LR/bImJOKcbT8eACuGFCDTvaj2TAvy
        o2QVg2Sm+U6K0E9BIAkSVEcJb4U2NmBFC/U6itIBTuOT1N5dXQH06pOaJ0XHoslvuoOYaRh8C22eB
        F4jw+Mbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jY-007Lnp-Co; Fri, 04 Feb 2022 19:59:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 46/75] mm/mlock: Turn clear_page_mlock() into folio_end_mlock()
Date:   Fri,  4 Feb 2022 19:58:23 +0000
Message-Id: <20220204195852.1751729-47-willy@infradead.org>
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

Add a clear_page_mlock() wrapper function.  It looks like all
callers were already passing a head page, but if they weren't,
this will fix an accounting bug.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/folio-compat.c |  5 +++++
 mm/internal.h     | 15 +++------------
 mm/mlock.c        | 28 +++++++++++++++++-----------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 46fa179e32fb..bcb037d9cec3 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -164,3 +164,8 @@ void putback_lru_page(struct page *page)
 {
 	folio_putback_lru(page_folio(page));
 }
+
+void clear_page_mlock(struct page *page)
+{
+	folio_end_mlock(page_folio(page));
+}
diff --git a/mm/internal.h b/mm/internal.h
index 7f1db0f1a8bc..041c76a4c284 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -416,17 +416,8 @@ extern unsigned int munlock_vma_page(struct page *page);
 
 extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
 			      unsigned long len);
-
-/*
- * Clear the page's PageMlocked().  This can be useful in a situation where
- * we want to unconditionally remove a page from the pagecache -- e.g.,
- * on truncation or freeing.
- *
- * It is legal to call this function for any page, mlocked or not.
- * If called for a page that is still mapped by mlocked vmas, all we do
- * is revert to lazy LRU behaviour -- semantics are not broken.
- */
-extern void clear_page_mlock(struct page *page);
+void folio_end_mlock(struct folio *folio);
+void clear_page_mlock(struct page *page);
 
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
@@ -503,7 +494,7 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 }
 #else /* !CONFIG_MMU */
 static inline void unmap_mapping_folio(struct folio *folio) { }
-static inline void clear_page_mlock(struct page *page) { }
+static inline void folio_end_mlock(struct folio *folio) { }
 static inline void mlock_vma_page(struct page *page) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index 24d0809cacba..ff067d64acc5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -55,31 +55,37 @@ EXPORT_SYMBOL(can_do_mlock);
  */
 
 /*
- *  LRU accounting for clear_page_mlock()
+ * Clear the folio's PageMlocked().  This can be useful in a situation where
+ * we want to unconditionally remove a folio from the pagecache -- e.g.,
+ * on truncation or freeing.
+ *
+ * It is legal to call this function for any folio, mlocked or not.
+ * If called for a folio that is still mapped by mlocked vmas, all we do
+ * is revert to lazy LRU behaviour -- semantics are not broken.
  */
-void clear_page_mlock(struct page *page)
+void folio_end_mlock(struct folio *folio)
 {
-	int nr_pages;
+	long nr_pages;
 
-	if (!TestClearPageMlocked(page))
+	if (!folio_test_clear_mlocked(folio))
 		return;
 
-	nr_pages = thp_nr_pages(page);
-	mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+	nr_pages = folio_nr_pages(folio);
+	zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
 	count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
 	/*
-	 * The previous TestClearPageMlocked() corresponds to the smp_mb()
+	 * The previous folio_test_clear_mlocked() corresponds to the smp_mb()
 	 * in __pagevec_lru_add_fn().
 	 *
 	 * See __pagevec_lru_add_fn for more explanation.
 	 */
-	if (!isolate_lru_page(page)) {
-		putback_lru_page(page);
+	if (!folio_isolate_lru(folio)) {
+		folio_putback_lru(folio);
 	} else {
 		/*
-		 * We lost the race. the page already moved to evictable list.
+		 * We lost the race. the folio already moved to evictable list.
 		 */
-		if (PageUnevictable(page))
+		if (folio_test_unevictable(folio))
 			count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
 	}
 }
-- 
2.34.1

