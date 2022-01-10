Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4987D488F41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiAJEZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiAJEY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA9C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SzJAO82OEH7GJ/mx7wGbrx//DOWsumHlBiQh3Qh2tnQ=; b=fjA0ppGWoAmzrPEL5HhRkIA+hr
        fzlhnHNr4mbg+FEjXHmiirYvrOledQFtXWc+8V+wEmsSXldqHGRyDqFahNY1GgB+Djy/o6DrumHiW
        a9LAONzmOJGdPQ7c1X+jl+BpOYhqLCvUzgUkFc5bKyNcnzdG1wEL80ExG+BOgn/L3HoDTLwJ00VOW
        hhsvdm2fk05IAB25GVH39Ip69aba3Bk3Ba2n7Zx7f0L9KpUOCn6Dn9tZ9Gaa2nSJrlxOzyUSIkITB
        zzm50sqecdqw8qZaSbFuY/V8Qovp1Z8QLFT4/kSUZZ8KBmhTI7AWTA9RGWJC0tgQscXCShYQFp65Z
        wSTTeGFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025xE-OM; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 25/28] gup: Convert compound_next() to gup_folio_next()
Date:   Mon, 10 Jan 2022 04:24:03 +0000
Message-Id: <20220110042406.499429-26-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert both callers to work on folios instead of pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b5786e83c418..0cf2d5fd8d2d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -220,20 +220,20 @@ static inline struct page *compound_range_next(unsigned long i,
 	return page;
 }
 
-static inline struct page *compound_next(unsigned long i,
+static inline struct folio *gup_folio_next(unsigned long i,
 		unsigned long npages, struct page **list, unsigned int *ntails)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned int nr;
 
-	page = compound_head(list[i]);
+	folio = page_folio(list[i]);
 	for (nr = i + 1; nr < npages; nr++) {
-		if (compound_head(list[nr]) != page)
+		if (page_folio(list[nr]) != folio)
 			break;
 	}
 
 	*ntails = nr - i;
-	return page;
+	return folio;
 }
 
 /**
@@ -261,17 +261,17 @@ static inline struct page *compound_next(unsigned long i,
 void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 				 bool make_dirty)
 {
-	unsigned long index;
-	struct page *head;
-	unsigned int ntails;
+	unsigned long i;
+	struct folio *folio;
+	unsigned int nr;
 
 	if (!make_dirty) {
 		unpin_user_pages(pages, npages);
 		return;
 	}
 
-	for (index = 0; index < npages; index += ntails) {
-		head = compound_next(index, npages, pages, &ntails);
+	for (i = 0; i < npages; i += nr) {
+		folio = gup_folio_next(i, npages, pages, &nr);
 		/*
 		 * Checking PageDirty at this point may race with
 		 * clear_page_dirty_for_io(), but that's OK. Two key
@@ -292,9 +292,12 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		 * written back, so it gets written back again in the
 		 * next writeback cycle. This is harmless.
 		 */
-		if (!PageDirty(head))
-			set_page_dirty_lock(head);
-		put_compound_head(head, ntails, FOLL_PIN);
+		if (!folio_test_dirty(folio)) {
+			folio_lock(folio);
+			folio_mark_dirty(folio);
+			folio_unlock(folio);
+		}
+		gup_put_folio(folio, nr, FOLL_PIN);
 	}
 }
 EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
@@ -347,9 +350,9 @@ EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
  */
 void unpin_user_pages(struct page **pages, unsigned long npages)
 {
-	unsigned long index;
-	struct page *head;
-	unsigned int ntails;
+	unsigned long i;
+	struct folio *folio;
+	unsigned int nr;
 
 	/*
 	 * If this WARN_ON() fires, then the system *might* be leaking pages (by
@@ -359,9 +362,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 	if (WARN_ON(IS_ERR_VALUE(npages)))
 		return;
 
-	for (index = 0; index < npages; index += ntails) {
-		head = compound_next(index, npages, pages, &ntails);
-		put_compound_head(head, ntails, FOLL_PIN);
+	for (i = 0; i < npages; i += nr) {
+		folio = gup_folio_next(i, npages, pages, &nr);
+		gup_put_folio(folio, nr, FOLL_PIN);
 	}
 }
 EXPORT_SYMBOL(unpin_user_pages);
-- 
2.33.0

