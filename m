Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9479F488F42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiAJEZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiAJEY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC3C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rKKpy0oluulkvLBfnA/9hhQL753tZQacHkRyC1WeJU0=; b=sGdCDh4ZVcVD4kmjTA+PY/SRmA
        Xy0yRyA5WDiywX9swJnbRDtdRVp/t9tnbO0FbJIbD8klaRw1FSmjZ6aQ3s87Zqfm83GSNw9+W6EBB
        jUEqlKQg87FdYHfliSejnX27WaWwrifLIdLGxqtuIivNfw8F47wH/NJVLGNkh9RiWTPp/jc+Mjpr/
        4OzgBeACGD0VX+bJqHy4Oh3gbqvvXQK2HdoX5rjTR92I/QwNL951f1izvcp4+2VZw0t66GoH8Pp2c
        dzDjq+odwp2UsO4gda+0abuQYve0KMcJcKKClan7zrqcmr/MWnR0NbwZfC0BJO5Z0xGFZMxeKcQML
        SErKzKMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE7-0025wS-Uo; Mon, 10 Jan 2022 04:24:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 01/28] gup: Remove for_each_compound_range()
Date:   Mon, 10 Jan 2022 04:23:39 +0000
Message-Id: <20220110042406.499429-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro doesn't simplify the users; it's easier to just call
compound_range_next() inside the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..7a07e0c00bf5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -236,9 +236,6 @@ static inline void compound_range_next(unsigned long i, unsigned long npages,
 	struct page *next, *page;
 	unsigned int nr = 1;
 
-	if (i >= npages)
-		return;
-
 	next = *list + i;
 	page = compound_head(next);
 	if (PageCompound(page) && compound_order(page) >= 1)
@@ -249,12 +246,6 @@ static inline void compound_range_next(unsigned long i, unsigned long npages,
 	*ntails = nr;
 }
 
-#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
-	for (__i = 0, \
-	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)); \
-	     __i < __npages; __i += __ntails, \
-	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)))
-
 static inline void compound_next(unsigned long i, unsigned long npages,
 				 struct page **list, struct page **head,
 				 unsigned int *ntails)
@@ -371,7 +362,8 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 	struct page *head;
 	unsigned int ntails;
 
-	for_each_compound_range(index, &page, npages, head, ntails) {
+	for (index = 0; index < npages; index += ntails) {
+		compound_range_next(index, npages, &page, &head, &ntails);
 		if (make_dirty && !PageDirty(head))
 			set_page_dirty_lock(head);
 		put_compound_head(head, ntails, FOLL_PIN);
-- 
2.33.0

