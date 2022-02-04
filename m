Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69E4AA0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiBDUDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD502C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=liAWeA8dPj0XyvqTIzZr5yVAs96w1tSEsr17cM/B6ps=; b=mLrvQwdsuODASoJwHF7X3NbFRr
        5UAcM3rp05C4rFn/BPxrTMH22MjOM5WxibXx8N6aAqOptEa6fPpZQXcYLnQn522CYRloRJcskqvyP
        L5/mim8fJ7VTcrYwEdoAxn9/BaKv5gX7yi70ro9qzr88wDkA43wsm9vVtlg53+1IHdRKC8wjeXrTJ
        isO3fjBcGDjGRVwLJv49gCp1vAEq9QV2QyA2cKi1q8sHJnoD8CG7iLdOQdIZ6fxkqBit4uV9DQl18
        PTHMgevbrwzmXPrhGe/sYj/hyzCLgzJd1byXDBDsgCFHrSz6srIt3t9v3uxct66YtMKrr+ZGQWak+
        8VE2w6IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Lm1-US; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 25/75] mm/gup: Turn compound_next() into gup_folio_next()
Date:   Fri,  4 Feb 2022 19:58:02 +0000
Message-Id: <20220204195852.1751729-26-willy@infradead.org>
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

Convert both callers to work on folios instead of pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index bf196219c189..d90f8e5790c0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -230,20 +230,19 @@ static inline struct page *compound_range_next(struct page *start,
 	return page;
 }
 
-static inline struct page *compound_next(struct page **list,
+static inline struct folio *gup_folio_next(struct page **list,
 		unsigned long npages, unsigned long i, unsigned int *ntails)
 {
-	struct page *page;
+	struct folio *folio = page_folio(list[i]);
 	unsigned int nr;
 
-	page = compound_head(list[i]);
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
@@ -271,17 +270,17 @@ static inline struct page *compound_next(struct page **list,
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
-		head = compound_next(pages, npages, index, &ntails);
+	for (i = 0; i < npages; i += nr) {
+		folio = gup_folio_next(pages, npages, i, &nr);
 		/*
 		 * Checking PageDirty at this point may race with
 		 * clear_page_dirty_for_io(), but that's OK. Two key
@@ -302,9 +301,12 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
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
@@ -357,9 +359,9 @@ EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
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
@@ -369,9 +371,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 	if (WARN_ON(IS_ERR_VALUE(npages)))
 		return;
 
-	for (index = 0; index < npages; index += ntails) {
-		head = compound_next(pages, npages, index, &ntails);
-		put_compound_head(head, ntails, FOLL_PIN);
+	for (i = 0; i < npages; i += nr) {
+		folio = gup_folio_next(pages, npages, i, &nr);
+		gup_put_folio(folio, nr, FOLL_PIN);
 	}
 }
 EXPORT_SYMBOL(unpin_user_pages);
-- 
2.34.1

