Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696BB4AA0D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbiBDUEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4FDC061765
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S+32TGDEH3eEuv5WV0Nrkfx+2YFCNkGXH4zGyPO+f3w=; b=LHCOmfVi2hjq3whA77dfMURajt
        E+us7oep/mE0Ko03kw4/dvE8gfUp6n9RMeD2ZAvdo7v2pqKCDSlZFPbiyP14ENLAk8yWNNMMTsNVl
        461U++ET5N2RJcFLBOCXdSr9e2aKD25R0xHIMFW51kafAuimAZFsjFhVGPPZtAkPO0O26rzLtZ2Q6
        DiejAXUDzAPwPvTDzrNVWSSNi9/ThDJvHBdMfxAOj/Fodat80chTYsZ9ydXdbDHPrqpOwl4WQevwY
        T6TPgPECObZKERTr5J40rXAutTGM7X/urRUoUUSBA/jo8rmxQOJKMeutnZpxEa8vu3JG60Xeo6VwK
        eqDbwr4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jZ-007Lop-9n; Fri, 04 Feb 2022 19:59:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 53/75] mm/rmap: Convert make_device_exclusive_range() to use folios
Date:   Fri,  4 Feb 2022 19:58:30 +0000
Message-Id: <20220204195852.1751729-54-willy@infradead.org>
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

Move the PageTail check earlier so we can avoid even taking the page
lock on tail pages.  Otherwise, this is a straightforward use of
folios throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/rmap.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 4cfac67e328c..ffc1b2f0cf24 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2088,6 +2088,7 @@ struct make_exclusive_args {
 static bool page_make_device_exclusive_one(struct page *page,
 		struct vm_area_struct *vma, unsigned long address, void *priv)
 {
+	struct folio *folio = page_folio(page);
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -2104,12 +2105,13 @@ static bool page_make_device_exclusive_one(struct page *page,
 	pvmw_set_page(&pvmw, page);
 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0, vma,
 				      vma->vm_mm, address, min(vma->vm_end,
-				      address + page_size(page)), args->owner);
+				      address + folio_size(folio)),
+				      args->owner);
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_PAGE(!pvmw.pte, page);
+		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
 		if (!pte_present(*pvmw.pte)) {
 			ret = false;
@@ -2117,16 +2119,17 @@ static bool page_make_device_exclusive_one(struct page *page,
 			break;
 		}
 
-		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+		subpage = folio_page(folio,
+				pte_pfn(*pvmw.pte) - folio_pfn(folio));
 		address = pvmw.address;
 
 		/* Nuke the page table entry. */
 		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
 		pteval = ptep_clear_flush(vma, address, pvmw.pte);
 
-		/* Move the dirty bit to the page. Now the pte is gone. */
+		/* Set the dirty flag on the folio now the pte is gone. */
 		if (pte_dirty(pteval))
-			set_page_dirty(page);
+			folio_mark_dirty(folio);
 
 		/*
 		 * Check that our target page is still mapped at the expected
@@ -2181,8 +2184,8 @@ static bool page_make_device_exclusive_one(struct page *page,
  * Returns false if the page is still mapped, or if it could not be unmapped
  * from the expected address. Otherwise returns true (success).
  */
-static bool page_make_device_exclusive(struct page *page, struct mm_struct *mm,
-				unsigned long address, void *owner)
+static bool folio_make_device_exclusive(struct folio *folio,
+		struct mm_struct *mm, unsigned long address, void *owner)
 {
 	struct make_exclusive_args args = {
 		.mm = mm,
@@ -2198,16 +2201,15 @@ static bool page_make_device_exclusive(struct page *page, struct mm_struct *mm,
 	};
 
 	/*
-	 * Restrict to anonymous pages for now to avoid potential writeback
-	 * issues. Also tail pages shouldn't be passed to rmap_walk so skip
-	 * those.
+	 * Restrict to anonymous folios for now to avoid potential writeback
+	 * issues.
 	 */
-	if (!PageAnon(page) || PageTail(page))
+	if (!folio_test_anon(folio))
 		return false;
 
-	rmap_walk(page, &rwc);
+	rmap_walk(&folio->page, &rwc);
 
-	return args.valid && !page_mapcount(page);
+	return args.valid && !folio_mapcount(folio);
 }
 
 /**
@@ -2245,15 +2247,16 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 		return npages;
 
 	for (i = 0; i < npages; i++, start += PAGE_SIZE) {
-		if (!trylock_page(pages[i])) {
-			put_page(pages[i]);
+		struct folio *folio = page_folio(pages[i]);
+		if (PageTail(pages[i]) || !folio_trylock(folio)) {
+			folio_put(folio);
 			pages[i] = NULL;
 			continue;
 		}
 
-		if (!page_make_device_exclusive(pages[i], mm, start, owner)) {
-			unlock_page(pages[i]);
-			put_page(pages[i]);
+		if (!folio_make_device_exclusive(folio, mm, start, owner)) {
+			folio_unlock(folio);
+			folio_put(folio);
 			pages[i] = NULL;
 		}
 	}
-- 
2.34.1

