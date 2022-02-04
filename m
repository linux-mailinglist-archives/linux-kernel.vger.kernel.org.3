Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F64AA0C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbiBDUDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72AC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rAjdWgwyF0gJodoNZNOjCHqOyiYZl3gXKRPYvb6G/O4=; b=DpiiMK03QKn57cgRvR/FlwGaXA
        q1tCS0HNQfUS2MgyAqnzvVsrWDs2SPT2Rq5Q3MLsBqrOObdi47e0C3RGbE3/ww4uXl6xjPxwKik0o
        QfGVrGCdJ0nJt2cFF3EDlf8WdXdOGMBUZtgaGxXq4+JdFMfuvwNXd8Uetm3ocGzD+Adw9DCQTVAnL
        /gUl5oOJZVOB+aNM6cOCWTjhgu724NUrI0p3FKKszCJ0VkqE30Ba6Vd0HD6h0mGaxKbGrTG2nDGIH
        aZxLXz8DESdjO3U9KAQxP4HrDoxGArgNTmp4psaS1tXiIMdBQY0M89+LoTKLi/9bVfaoX+fgGuPir
        1Eif6E5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4ja-007LpU-2K; Fri, 04 Feb 2022 19:59:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 58/75] mm: Turn page_anon_vma() into folio_anon_vma()
Date:   Fri,  4 Feb 2022 19:58:35 +0000
Message-Id: <20220204195852.1751729-59-willy@infradead.org>
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

Move the prototype from mm.h to mm/internal.h and convert all callers
to pass a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  1 -
 mm/internal.h      |  1 +
 mm/ksm.c           |  3 ++-
 mm/rmap.c          | 19 ++++++++++++-------
 mm/util.c          |  3 +--
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 028bd9336e82..74d9cda7cfd6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1765,7 +1765,6 @@ static inline void *folio_address(const struct folio *folio)
 }
 
 extern void *page_rmapping(struct page *page);
-extern struct anon_vma *page_anon_vma(struct page *page);
 extern pgoff_t __page_file_index(struct page *page);
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index 66645972cbd7..360256e4ee06 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -393,6 +393,7 @@ static inline bool is_data_mapping(vm_flags_t flags)
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
 void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
+struct anon_vma *folio_anon_vma(struct folio *folio);
 
 #ifdef CONFIG_MMU
 void unmap_mapping_folio(struct folio *folio);
diff --git a/mm/ksm.c b/mm/ksm.c
index 1639160c9e9a..212186dbc89f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2567,7 +2567,8 @@ void __ksm_exit(struct mm_struct *mm)
 struct page *ksm_might_need_to_copy(struct page *page,
 			struct vm_area_struct *vma, unsigned long address)
 {
-	struct anon_vma *anon_vma = page_anon_vma(page);
+	struct folio *folio = page_folio(page);
+	struct anon_vma *anon_vma = folio_anon_vma(folio);
 	struct page *new_page;
 
 	if (PageKsm(page)) {
diff --git a/mm/rmap.c b/mm/rmap.c
index ba65d5d3eb5a..8bbbbea483cf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -737,8 +737,9 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
  */
 unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 {
-	if (PageAnon(page)) {
-		struct anon_vma *page__anon_vma = page_anon_vma(page);
+	struct folio *folio = page_folio(page);
+	if (folio_test_anon(folio)) {
+		struct anon_vma *page__anon_vma = folio_anon_vma(folio);
 		/*
 		 * Note: swapoff's unuse_vma() is more efficient with this
 		 * check, and needs it to match anon_vma when KSM is active.
@@ -748,7 +749,7 @@ unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 			return -EFAULT;
 	} else if (!vma->vm_file) {
 		return -EFAULT;
-	} else if (vma->vm_file->f_mapping != compound_head(page)->mapping) {
+	} else if (vma->vm_file->f_mapping != folio->mapping) {
 		return -EFAULT;
 	}
 
@@ -1109,6 +1110,7 @@ static void __page_set_anon_rmap(struct page *page,
 static void __page_check_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address)
 {
+	struct folio *folio = page_folio(page);
 	/*
 	 * The page's anon-rmap details (mapping and index) are guaranteed to
 	 * be set up correctly at this point.
@@ -1120,7 +1122,8 @@ static void __page_check_anon_rmap(struct page *page,
 	 * are initially only visible via the pagetables, and the pte is locked
 	 * over the call to page_add_new_anon_rmap.
 	 */
-	VM_BUG_ON_PAGE(page_anon_vma(page)->root != vma->anon_vma->root, page);
+	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma->anon_vma->root,
+			folio);
 	VM_BUG_ON_PAGE(page_to_pgoff(page) != linear_page_index(vma, address),
 		       page);
 }
@@ -2278,6 +2281,7 @@ void __put_anon_vma(struct anon_vma *anon_vma)
 static struct anon_vma *rmap_walk_anon_lock(struct page *page,
 					struct rmap_walk_control *rwc)
 {
+	struct folio *folio = page_folio(page);
 	struct anon_vma *anon_vma;
 
 	if (rwc->anon_lock)
@@ -2289,7 +2293,7 @@ static struct anon_vma *rmap_walk_anon_lock(struct page *page,
 	 * are holding mmap_lock. Users without mmap_lock are required to
 	 * take a reference count to prevent the anon_vma disappearing
 	 */
-	anon_vma = page_anon_vma(page);
+	anon_vma = folio_anon_vma(folio);
 	if (!anon_vma)
 		return NULL;
 
@@ -2314,14 +2318,15 @@ static struct anon_vma *rmap_walk_anon_lock(struct page *page,
 static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		bool locked)
 {
+	struct folio *folio = page_folio(page);
 	struct anon_vma *anon_vma;
 	pgoff_t pgoff_start, pgoff_end;
 	struct anon_vma_chain *avc;
 
 	if (locked) {
-		anon_vma = page_anon_vma(page);
+		anon_vma = folio_anon_vma(folio);
 		/* anon_vma disappear under us? */
-		VM_BUG_ON_PAGE(!anon_vma, page);
+		VM_BUG_ON_FOLIO(!anon_vma, folio);
 	} else {
 		anon_vma = rmap_walk_anon_lock(page, rwc);
 	}
diff --git a/mm/util.c b/mm/util.c
index b614f423aaa4..13fc88ac8e70 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -679,9 +679,8 @@ bool folio_mapped(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_mapped);
 
-struct anon_vma *page_anon_vma(struct page *page)
+struct anon_vma *folio_anon_vma(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	unsigned long mapping = (unsigned long)folio->mapping;
 
 	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
-- 
2.34.1

