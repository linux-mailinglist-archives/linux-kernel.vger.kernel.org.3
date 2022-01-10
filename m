Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DAC488F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiAJE0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbiAJEYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33239C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8C3hUhjCGJ2Sdk9gK8xC03PTtTrcCZ/ERUofNnCUuq0=; b=bcS4FwNQbPo7ETR9B5dTcak8o1
        MF2eSv6wiCnWc63DybJky7QZlDMkktmdQuJDgJcBCVo+tlYbuzp4WhHd1o9huxTeqgfkcCugweGYP
        gqTHByJSSStlrJazHskBOCGem9kIh1fzgaOvfDyCl9xN7pUCFyE5JowreUCy+8ESnLI40DXcyKRIX
        PFosyUxUrqzjI8XE4dsZU+x894HS9y3PwzR7QIMWUepl8eIIEhiJbJkAH29JfE6k94S4GTS1mQg6F
        mdIsdT/h+YjPWErGXlAFdxrKlkxuiREifCZtqAVSC/2Y0xG/mxTUSwrGWKB0nNmlq0XOi4Qmxh3tP
        Yp3tCFHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wU-1G; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 02/28] gup: Remove for_each_compound_head()
Date:   Mon, 10 Jan 2022 04:23:40 +0000
Message-Id: <20220110042406.499429-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro doesn't simplify the users; it's easier to just call
compound_next() inside a standard loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7a07e0c00bf5..86f8d843de72 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -253,9 +253,6 @@ static inline void compound_next(unsigned long i, unsigned long npages,
 	struct page *page;
 	unsigned int nr;
 
-	if (i >= npages)
-		return;
-
 	page = compound_head(list[i]);
 	for (nr = i + 1; nr < npages; nr++) {
 		if (compound_head(list[nr]) != page)
@@ -266,12 +263,6 @@ static inline void compound_next(unsigned long i, unsigned long npages,
 	*ntails = nr - i;
 }
 
-#define for_each_compound_head(__i, __list, __npages, __head, __ntails) \
-	for (__i = 0, \
-	     compound_next(__i, __npages, __list, &(__head), &(__ntails)); \
-	     __i < __npages; __i += __ntails, \
-	     compound_next(__i, __npages, __list, &(__head), &(__ntails)))
-
 /**
  * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
  * @pages:  array of pages to be maybe marked dirty, and definitely released.
@@ -306,7 +297,8 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		return;
 	}
 
-	for_each_compound_head(index, pages, npages, head, ntails) {
+	for (index = 0; index < npages; index += ntails) {
+		compound_next(index, npages, pages, &head, &ntails);
 		/*
 		 * Checking PageDirty at this point may race with
 		 * clear_page_dirty_for_io(), but that's OK. Two key
@@ -394,8 +386,10 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 	if (WARN_ON(IS_ERR_VALUE(npages)))
 		return;
 
-	for_each_compound_head(index, pages, npages, head, ntails)
+	for (index = 0; index < npages; index += ntails) {
+		compound_next(index, npages, pages, &head, &ntails);
 		put_compound_head(head, ntails, FOLL_PIN);
+	}
 }
 EXPORT_SYMBOL(unpin_user_pages);
 
-- 
2.33.0

