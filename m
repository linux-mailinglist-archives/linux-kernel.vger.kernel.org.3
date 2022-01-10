Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D712488F44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiAJEZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbiAJEY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE17C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Z6FL4QqZXpHUsas/XSj8HAlMM6U3EcqhJKpaCEuMmN8=; b=gxWZW6abe4i+kvz3u9LtWrvatH
        BoiG6HjaV3GJHxMRnfZSa7H9MJrW92RwHaeh3xjnfLoiR0eUxaQ7XdWjA/BL6eJb0/QcWDZvVS8Rt
        DCaSPmPce+iympJJ2YASM5qmcfx5BuQSc65ohl4fkLmb+tdj5xAwUXehLGGdLSl619nzH1L/FHKl+
        UDpwP47wln4ui7FvBWkA7D+nkmrPQjhcA/QvbT0pxWGDMVnveDBAJfolGSS/6tgIsLbRqfcL/616V
        gIejTrUhUfqYl3v3R+N0T6w0T8MRjR91OhMBPs1fbjvyix4twfVWIX6h6Z46/JLPO1L/n2goXg0KT
        xg9aX3Qw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wa-8a; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 05/28] gup: Change the calling convention for compound_next()
Date:   Mon, 10 Jan 2022 04:23:43 +0000
Message-Id: <20220110042406.499429-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the head page instead of storing it to a passed parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6eedca605b3d..8a0ea220ced1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -245,9 +245,8 @@ static inline struct page *compound_range_next(unsigned long i,
 	return page;
 }
 
-static inline void compound_next(unsigned long i, unsigned long npages,
-				 struct page **list, struct page **head,
-				 unsigned int *ntails)
+static inline struct page *compound_next(unsigned long i,
+		unsigned long npages, struct page **list, unsigned int *ntails)
 {
 	struct page *page;
 	unsigned int nr;
@@ -258,8 +257,8 @@ static inline void compound_next(unsigned long i, unsigned long npages,
 			break;
 	}
 
-	*head = page;
 	*ntails = nr - i;
+	return page;
 }
 
 /**
@@ -297,7 +296,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 	}
 
 	for (index = 0; index < npages; index += ntails) {
-		compound_next(index, npages, pages, &head, &ntails);
+		head = compound_next(index, npages, pages, &ntails);
 		/*
 		 * Checking PageDirty at this point may race with
 		 * clear_page_dirty_for_io(), but that's OK. Two key
@@ -386,7 +385,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 		return;
 
 	for (index = 0; index < npages; index += ntails) {
-		compound_next(index, npages, pages, &head, &ntails);
+		head = compound_next(index, npages, pages, &ntails);
 		put_compound_head(head, ntails, FOLL_PIN);
 	}
 }
-- 
2.33.0

