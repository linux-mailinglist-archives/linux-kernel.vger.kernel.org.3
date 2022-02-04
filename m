Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40F94AA0B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiBDUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiBDT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37691C061741
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B2OutkWqU99op9mi/t36gPZ4A2y3PkyT8m7uUSFjSLM=; b=fvbCRW8wvKcgxDc7/d2nOz3wgX
        5EEViXGpdXarWthRN4a94d0pghpcjAKfz1WgOZqg/kFXUwq6D2rRUTsziDquIhIUU3BHOENV3F71+
        IMU5sT/VG2xqonF0VXBvElWHJzy+pRmAX5zs1z4R2yZZ9ekjxzKGerG/O6I3ypHOoJNZHDpbuiBJF
        nA+i3BFBcDsWUObDlj89jv2weGH/VvhExSGstVkqoOa9F+JruOX8dOgZuA5BQEg6Th6xUgsY+8jGr
        Olp1DpWXPYL9z2KvbAS1Hr79yiOjRVMAsmjzpU6MaIb/iSM30IcrPpR3NnAE8Pf/Nc9JuZxYwMNdR
        g/fcwTmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jT-007Ll7-Sj; Fri, 04 Feb 2022 19:58:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 03/75] mm/gup: Remove for_each_compound_head()
Date:   Fri,  4 Feb 2022 19:57:40 +0000
Message-Id: <20220204195852.1751729-4-willy@infradead.org>
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

This macro doesn't simplify the users; it's easier to just call
compound_next() inside a standard loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index dc00e46fae5a..facadcaedea3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -278,9 +278,6 @@ static inline void compound_next(unsigned long i, unsigned long npages,
 	struct page *page;
 	unsigned int nr;
 
-	if (i >= npages)
-		return;
-
 	page = compound_head(list[i]);
 	for (nr = i + 1; nr < npages; nr++) {
 		if (compound_head(list[nr]) != page)
@@ -291,12 +288,6 @@ static inline void compound_next(unsigned long i, unsigned long npages,
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
@@ -331,7 +322,8 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		return;
 	}
 
-	for_each_compound_head(index, pages, npages, head, ntails) {
+	for (index = 0; index < npages; index += ntails) {
+		compound_next(index, npages, pages, &head, &ntails);
 		/*
 		 * Checking PageDirty at this point may race with
 		 * clear_page_dirty_for_io(), but that's OK. Two key
@@ -419,8 +411,10 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
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
2.34.1

