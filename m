Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9034AA093
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiBDUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60363C061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=y6p8+MJkK+iojKvg+sCKZZ8nwxZP7FWYLeEHjHoDQdg=; b=HUL9PebXZ888AnsWESfPYxl8OI
        6Gsxse1mArB4K/J80n0lO3AiO67o06XdXMtVm+ez1TWvOakfn+tE/SjJdzB4E7GIsIVoWSf+wFoaA
        v/egZtltIQCZKOeaZQDZvv/Nr/Gcqv+DqsaLryM1U/5yHR55YGAQ/I7gdulmJnRS7rtThwr96qw5q
        GOgikwcPjejGSxSeoAPHhKpX3IjBpWixuoZS/AiZ+6hGrzkCKX0navkwhB5danZBDu4P034F7csE8
        ZQOtoG/glu6VSL+uDzRjMhdvs24gz5lkTKxkoP97hMtWoAg1GJ4fykYNagpfXVsd1SOQemhxm3vE2
        kG2CDsXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jY-007Lo5-MF; Fri, 04 Feb 2022 19:59:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 48/75] mm/rmap: Turn page_mlock() into folio_mlock()
Date:   Fri,  4 Feb 2022 19:58:25 +0000
Message-Id: <20220204195852.1751729-49-willy@infradead.org>
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

Add back page_mlock() as a wrapper around folio_mlock().  Removes
a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rmap.h |  1 +
 mm/folio-compat.c    |  6 ++++++
 mm/rmap.c            | 31 +++++++++++++++++--------------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 00b772cdaaaa..31f3a299ef66 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -261,6 +261,7 @@ int folio_mkclean(struct folio *);
  * the page mlocked.
  */
 void page_mlock(struct page *page);
+void folio_mlock(struct folio *folio);
 
 void remove_migration_ptes(struct page *old, struct page *new, bool locked);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 9cb0867d5b38..90f03187a5e3 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -7,6 +7,7 @@
 #include <linux/migrate.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/rmap.h>
 #include "internal.h"
 
 struct address_space *page_mapping(struct page *page)
@@ -174,3 +175,8 @@ void mlock_vma_page(struct page *page)
 {
 	mlock_vma_folio(page_folio(page));
 }
+
+void page_mlock(struct page *page)
+{
+	folio_mlock(page_folio(page));
+}
diff --git a/mm/rmap.c b/mm/rmap.c
index 1cedcfd6105c..a383e25fb196 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2001,6 +2001,7 @@ void try_to_migrate(struct page *page, enum ttu_flags flags)
 static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
 				 unsigned long address, void *unused)
 {
+	struct folio *folio = page_folio(page);
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = address,
@@ -2024,9 +2025,9 @@ static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
 			 * nor on an Anon THP (which may still be PTE-mapped
 			 * after DoubleMap was cleared).
 			 */
-			mlock_vma_page(page);
+			mlock_vma_folio(folio);
 			/*
-			 * No need to scan further once the page is marked
+			 * No need to scan further once the folio is marked
 			 * as mlocked.
 			 */
 			page_vma_mapped_walk_done(&pvmw);
@@ -2038,14 +2039,14 @@ static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
 }
 
 /**
- * page_mlock - try to mlock a page
- * @page: the page to be mlocked
+ * folio_mlock() - Try to mlock a folio.
+ * @folio: The folio to be mlocked.
  *
- * Called from munlock code. Checks all of the VMAs mapping the page and mlocks
- * the page if any are found. The page will be returned with PG_mlocked cleared
- * if it is not mapped by any locked vmas.
+ * Called from munlock code. Checks all of the VMAs mapping the folio
+ * and mlocks the folio if any are found. The folio will be returned
+ * with the mlocked flag clear if it is not mapped by any locked vmas.
  */
-void page_mlock(struct page *page)
+void folio_mlock(struct folio *folio)
 {
 	struct rmap_walk_control rwc = {
 		.rmap_one = page_mlock_one,
@@ -2054,14 +2055,16 @@ void page_mlock(struct page *page)
 
 	};
 
-	VM_BUG_ON_PAGE(!PageLocked(page) || PageLRU(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio) || folio_test_lru(folio),
+			folio);
+	VM_BUG_ON_FOLIO(folio_test_large(folio) && folio_test_double_map(folio),
+			folio);
 
 	/* Anon THP are only marked as mlocked when singly mapped */
-	if (PageTransCompound(page) && PageAnon(page))
+	if (folio_test_large(folio) && folio_test_anon(folio))
 		return;
 
-	rmap_walk(page, &rwc);
+	rmap_walk(&folio->page, &rwc);
 }
 
 #ifdef CONFIG_DEVICE_PRIVATE
@@ -2290,7 +2293,7 @@ static struct anon_vma *rmap_walk_anon_lock(struct page *page,
  * Find all the mappings of a page using the mapping pointer and the vma chains
  * contained in the anon_vma struct it points to.
  *
- * When called from page_mlock(), the mmap_lock of the mm containing the vma
+ * When called from folio_mlock(), the mmap_lock of the mm containing the vma
  * where the page was found will be held for write.  So, we won't recheck
  * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
  * LOCKED.
@@ -2343,7 +2346,7 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
  * Find all the mappings of a page using the mapping pointer and the vma chains
  * contained in the address_space struct it points to.
  *
- * When called from page_mlock(), the mmap_lock of the mm containing the vma
+ * When called from folio_mlock(), the mmap_lock of the mm containing the vma
  * where the page was found will be held for write.  So, we won't recheck
  * vm_flags for that VMA.  That should be OK, because that vma shouldn't be
  * LOCKED.
-- 
2.34.1

