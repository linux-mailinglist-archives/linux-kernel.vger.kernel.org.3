Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB50D488F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiAJE1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbiAJEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:25:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A0C061212
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gT8RG9vD2iSbfvGg96Co6y7w74G3UgjYv7qBo/++MyI=; b=L2bhR2Cjml5DgbFsb0VbH/LASg
        hlrKrN5EDZSd+ik3iO94aKLBEhpESoh/ldGOKrbgbPmXGIu2qcbXCiAV8shqq+2/ODx3xlHB3+uR1
        WXT2IWUHvpb3nAyxNS6UB8iQuPoLnEXLBQjD+gbex6c8IeDmYwqqlmyXJYD5WTjcNo12L6LLjE4i6
        5IM8D1DQiY1HLOCzEqDN7ohzauoczPQSlIU0qIRibEvBiy4Aoezi+R2uI2P9jUtjmtREtxignvDIQ
        cPKhkILOzRhHzQBEAIQvme1db678BNuBgNhF3s0NoYWQDURb8fcVaWWKuI8yOQSqfYGyJIuDXyPx1
        dFjKdG2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wW-3h; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 03/28] gup: Change the calling convention for compound_range_next()
Date:   Mon, 10 Jan 2022 04:23:41 +0000
Message-Id: <20220110042406.499429-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the head page instead of storing it to a passed parameter.
Pass the start page directly instead of passing a pointer to it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 86f8d843de72..3c93d2fdf4da 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -229,21 +229,20 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
-static inline void compound_range_next(unsigned long i, unsigned long npages,
-				       struct page **list, struct page **head,
-				       unsigned int *ntails)
+static inline struct page *compound_range_next(unsigned long i,
+		unsigned long npages, struct page *start, unsigned int *ntails)
 {
 	struct page *next, *page;
 	unsigned int nr = 1;
 
-	next = *list + i;
+	next = start + i;
 	page = compound_head(next);
 	if (PageCompound(page) && compound_order(page) >= 1)
 		nr = min_t(unsigned int,
 			   page + compound_nr(page) - next, npages - i);
 
-	*head = page;
 	*ntails = nr;
+	return page;
 }
 
 static inline void compound_next(unsigned long i, unsigned long npages,
@@ -355,7 +354,7 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 	unsigned int ntails;
 
 	for (index = 0; index < npages; index += ntails) {
-		compound_range_next(index, npages, &page, &head, &ntails);
+		head = compound_range_next(index, npages, page, &ntails);
 		if (make_dirty && !PageDirty(head))
 			set_page_dirty_lock(head);
 		put_compound_head(head, ntails, FOLL_PIN);
-- 
2.33.0

