Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6384AA0A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiBDUBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiBDT7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6308C061771
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=y+3cCKDp9+BhEyUY+TtH96ykniIPjbjUz7fHakaWI40=; b=PBwFfGYx9RYniI3uLUHBpw7p6z
        lYrCP4Mvg1Je8QLOCjRhoNRj+1A3CuUc8NUz5aT5Ar2Vd3igNQ5egPPWUX1bSBHn5TDMXabEJeVzx
        IjSD9ZKLuX2WXgRbM73odT1VKlcy2DgEJ7sHZriLleIX90hOUedlfCWvAGJ0aT2NwCm/IXjZeE15q
        zs+3/BRhXxgiiuDL3q0x7vlBlwwVsu5Avf46KUmKuW18qi+vwzZbJLfYIm73n5rIyw58iEfcAafUv
        F94XMnB/YqRIx3KN9eNLwguXk9iT8O8XQ5FwQy5oI084u74hSjvNXa6mMha/LUM4bdzJxHETNmvaX
        kUv+pAUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007Lm5-3x; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 27/75] mm: Turn isolate_lru_page() into folio_isolate_lru()
Date:   Fri,  4 Feb 2022 19:58:04 +0000
Message-Id: <20220204195852.1751729-28-willy@infradead.org>
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

Add isolate_lru_page() as a wrapper around isolate_lru_folio().
TestClearPageLRU() would have always failed on a tail page, so
returning -EBUSY is the same behaviour.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 arch/powerpc/include/asm/mmu_context.h |  1 -
 mm/folio-compat.c                      |  8 +++++
 mm/internal.h                          |  3 +-
 mm/vmscan.c                            | 43 ++++++++++++--------------
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index fd277b15635c..b8527a74bd4d 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -21,7 +21,6 @@ extern void destroy_context(struct mm_struct *mm);
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 struct mm_iommu_table_group_mem_t;
 
-extern int isolate_lru_page(struct page *page);	/* from internal.h */
 extern bool mm_iommu_preregistered(struct mm_struct *mm);
 extern long mm_iommu_new(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries,
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 749555a232a8..a4a7725f4486 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -7,6 +7,7 @@
 #include <linux/migrate.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include "internal.h"
 
 struct address_space *page_mapping(struct page *page)
 {
@@ -151,3 +152,10 @@ int try_to_release_page(struct page *page, gfp_t gfp)
 	return filemap_release_folio(page_folio(page), gfp);
 }
 EXPORT_SYMBOL(try_to_release_page);
+
+int isolate_lru_page(struct page *page)
+{
+	if (WARN_RATELIMIT(PageTail(page), "trying to isolate tail page"))
+		return -EBUSY;
+	return folio_isolate_lru((struct folio *)page);
+}
diff --git a/mm/internal.h b/mm/internal.h
index 08a44802c80e..8b0249909b06 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -157,7 +157,8 @@ extern unsigned long highest_memmap_pfn;
 /*
  * in mm/vmscan.c:
  */
-extern int isolate_lru_page(struct page *page);
+int isolate_lru_page(struct page *page);
+int folio_isolate_lru(struct folio *folio);
 extern void putback_lru_page(struct page *page);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 090bfb605ecf..e0cc5f0cb999 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2209,45 +2209,40 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 }
 
 /**
- * isolate_lru_page - tries to isolate a page from its LRU list
- * @page: page to isolate from its LRU list
+ * folio_isolate_lru() - Try to isolate a folio from its LRU list.
+ * @folio: Folio to isolate from its LRU list.
  *
- * Isolates a @page from an LRU list, clears PageLRU and adjusts the
- * vmstat statistic corresponding to whatever LRU list the page was on.
+ * Isolate a @folio from an LRU list and adjust the vmstat statistic
+ * corresponding to whatever LRU list the folio was on.
  *
- * Returns 0 if the page was removed from an LRU list.
- * Returns -EBUSY if the page was not on an LRU list.
- *
- * The returned page will have PageLRU() cleared.  If it was found on
- * the active list, it will have PageActive set.  If it was found on
- * the unevictable list, it will have the PageUnevictable bit set. That flag
+ * The folio will have its LRU flag cleared.  If it was found on the
+ * active list, it will have the Active flag set.  If it was found on the
+ * unevictable list, it will have the Unevictable flag set.  These flags
  * may need to be cleared by the caller before letting the page go.
  *
- * The vmstat statistic corresponding to the list on which the page was
- * found will be decremented.
- *
- * Restrictions:
+ * Context:
  *
  * (1) Must be called with an elevated refcount on the page. This is a
- *     fundamental difference from isolate_lru_pages (which is called
+ *     fundamental difference from isolate_lru_pages() (which is called
  *     without a stable reference).
- * (2) the lru_lock must not be held.
- * (3) interrupts must be enabled.
+ * (2) The lru_lock must not be held.
+ * (3) Interrupts must be enabled.
+ *
+ * Return: 0 if the folio was removed from an LRU list.
+ * -EBUSY if the folio was not on an LRU list.
  */
-int isolate_lru_page(struct page *page)
+int folio_isolate_lru(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	int ret = -EBUSY;
 
-	VM_BUG_ON_PAGE(!page_count(page), page);
-	WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
+	VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio);
 
-	if (TestClearPageLRU(page)) {
+	if (folio_test_clear_lru(folio)) {
 		struct lruvec *lruvec;
 
-		get_page(page);
+		folio_get(folio);
 		lruvec = folio_lruvec_lock_irq(folio);
-		del_page_from_lru_list(page, lruvec);
+		lruvec_del_folio(lruvec, folio);
 		unlock_page_lruvec_irq(lruvec);
 		ret = 0;
 	}
-- 
2.34.1

