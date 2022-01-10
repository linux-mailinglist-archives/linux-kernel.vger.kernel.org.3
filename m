Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D79488F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiAJEYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9353C06175A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Z2gQhd94zLvZOxg2P3olHAv1sEvF2BSvVZSPWfTVDGI=; b=SZFQzxmRdm+Os236gX9J2RY9g8
        ckaQRRqi/4gGgNiUzDOpo+Mjlm1JMQ98qgXAULO+b56mRwhJWsQPtarcgcozdlMQtgJPjUrqev1ee
        dkhmh9+NEytrAX2GgYwm34QOpOrOYIGR6IRK72602NpYlhbosHIwe3m5WeOXbQbjDr2DXAtZFsTv5
        Wf1tYpEl641n2TRVis0AorZG7PFLpKfda9BjAiHgxleT6FYlwiSLRg7ZOMPlHmCv192Sre5GH6XTj
        3QzhO5KG4nhoQc8iIjTzVKrlSItQNzoJQKIkOQU0vBw1vWD+e4ghX4G5GfqLC1r5M6sRjkwQbMhE6
        qrVmW3Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025xG-S7; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 26/28] gup: Convert compound_range_next() to gup_folio_range_next()
Date:   Mon, 10 Jan 2022 04:24:04 +0000
Message-Id: <20220110042406.499429-27-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the only caller to work on folios instead of pages.
This removes the last caller of put_compound_head(), so delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  4 ++--
 mm/gup.c           | 38 ++++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c103c6401ecd..1ddb0a55b5ca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -216,10 +216,10 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
-#define page_nth(head, tail)	(page_to_pfn(tail) - page_to_pfn(head))
+#define folio_nth(folio, page)	(page_to_pfn(page) - folio_pfn(folio))
 #else
 #define nth_page(page,n) ((page) + (n))
-#define page_nth(head, tail)	((tail) - (head))
+#define folio_nth(folio, tail)	((tail) - &(folio)->page)
 #endif
 
 /* to align the pointer to the (next) page boundary */
diff --git a/mm/gup.c b/mm/gup.c
index 0cf2d5fd8d2d..1cdd5f2887a8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -156,12 +156,6 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
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
  *
@@ -204,20 +198,21 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
-static inline struct page *compound_range_next(unsigned long i,
+static inline struct folio *gup_folio_range_next(unsigned long i,
 		unsigned long npages, struct page *start, unsigned int *ntails)
 {
-	struct page *next, *page;
+	struct page *next;
+	struct folio *folio;
 	unsigned int nr = 1;
 
 	next = nth_page(start, i);
-	page = compound_head(next);
-	if (PageHead(page))
+	folio = page_folio(next);
+	if (folio_test_large(folio))
 		nr = min_t(unsigned int, npages - i,
-			   compound_nr(page) - page_nth(page, next));
+			   folio_nr_pages(folio) - folio_nth(folio, next));
 
 	*ntails = nr;
-	return page;
+	return folio;
 }
 
 static inline struct folio *gup_folio_next(unsigned long i,
@@ -326,15 +321,18 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
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
-		head = compound_range_next(index, npages, page, &ntails);
-		if (make_dirty && !PageDirty(head))
-			set_page_dirty_lock(head);
-		put_compound_head(head, ntails, FOLL_PIN);
+	for (i = 0; i < npages; i += nr) {
+		folio = gup_folio_range_next(i, npages, page, &nr);
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
2.33.0

