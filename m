Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7678C4AA0AE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiBDUBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiBDT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06FBC06177E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xzWHUvuH3ytdGGiNqcldB8CLjt4/+/jUSmgWFltkhvY=; b=qNELhIHFV/VxT/M+K1PpTd4TS0
        YcmfU7+ZWvcl2FbMs/CkyOJSTRGxTOwP50E6Uw9kCpV7BDedkaCDhTfG++N98tmoaGmI1c/R8vx3V
        0k0SssQyh7nIlE5giSpVf+dUP2yai60k8Dme6Cf5gkU3ZJzB+eY7LQKRmvE3m2wfgM0gKv29r3ZTS
        RoJEvP/S2W5S77i8jFL7fCT/emksgDiol70aJQFoberuQmpuKXw7TgarnXlF5RhCWeI+/yEzKoKPx
        D8c5PRZhEUdNJeKBN4LkP8Bh817/9oOCCxO8Gc60I/uu9EYDg34WIwW86OsZ3931zPNoo7qIA8rJa
        +fxGwhJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007Lm3-0D; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 26/75] mm/gup: Turn compound_range_next() into gup_folio_range_next()
Date:   Fri,  4 Feb 2022 19:58:03 +0000
Message-Id: <20220204195852.1751729-27-willy@infradead.org>
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

Convert the only caller to work on folios instead of pages.
This removes the last caller of put_compound_head(), so delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h |  4 ++--
 mm/gup.c           | 38 +++++++++++++++++---------------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index da565dc1029d..3ca6dea4fe4a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -216,10 +216,10 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
-#define page_nth(head, tail)	(page_to_pfn(tail) - page_to_pfn(head))
+#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
 #else
 #define nth_page(page,n) ((page) + (n))
-#define page_nth(head, tail)	((tail) - (head))
+#define folio_page_idx(folio, p)	((p) - &(folio)->page)
 #endif
 
 /* to align the pointer to the (next) page boundary */
diff --git a/mm/gup.c b/mm/gup.c
index d90f8e5790c0..edec7356b965 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -146,12 +146,6 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 	folio_put_refs(folio, refs);
 }
 
-static void put_compound_head(struct page *page, int refs, unsigned int flags)
-{
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	gup_put_folio((struct folio *)page, refs, flags);
-}
-
 /**
  * try_grab_page() - elevate a page's refcount by a flag-dependent amount
  * @page:    pointer to page to be grabbed
@@ -214,20 +208,19 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
-static inline struct page *compound_range_next(struct page *start,
+static inline struct folio *gup_folio_range_next(struct page *start,
 		unsigned long npages, unsigned long i, unsigned int *ntails)
 {
-	struct page *next, *page;
+	struct page *next = nth_page(start, i);
+	struct folio *folio = page_folio(next);
 	unsigned int nr = 1;
 
-	next = nth_page(start, i);
-	page = compound_head(next);
-	if (PageHead(page))
+	if (folio_test_large(folio))
 		nr = min_t(unsigned int, npages - i,
-			   compound_nr(page) - page_nth(page, next));
+			   folio_nr_pages(folio) - folio_page_idx(folio, next));
 
 	*ntails = nr;
-	return page;
+	return folio;
 }
 
 static inline struct folio *gup_folio_next(struct page **list,
@@ -335,15 +328,18 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 				      bool make_dirty)
 {
-	unsigned long index;
-	struct page *head;
-	unsigned int ntails;
+	unsigned long i;
+	struct folio *folio;
+	unsigned int nr;
 
-	for (index = 0; index < npages; index += ntails) {
-		head = compound_range_next(page, npages, index, &ntails);
-		if (make_dirty && !PageDirty(head))
-			set_page_dirty_lock(head);
-		put_compound_head(head, ntails, FOLL_PIN);
+	for (i = 0; i < npages; i += nr) {
+		folio = gup_folio_range_next(page, npages, i, &nr);
+		if (make_dirty && !folio_test_dirty(folio)) {
+			folio_lock(folio);
+			folio_mark_dirty(folio);
+			folio_unlock(folio);
+		}
+		gup_put_folio(folio, nr, FOLL_PIN);
 	}
 }
 EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
-- 
2.34.1

