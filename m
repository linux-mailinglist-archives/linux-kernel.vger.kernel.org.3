Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1734AA0CF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiBDUEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiBDT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80139C06175C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=33UEnkkNiFlfpyXfZQc/LWytQLTqEtcMw8GjP7m9GVg=; b=Wgw2CjNZqh9Erx8pW4gMctzcJf
        UZqLpn5pTUpas0OFMO2M5k5zis+SCoZIqOjYZthR6WSiz1fE/BONQXvgBQZOFNWoHgFKiYoYerw0d
        qQP6VKW7n5A6fv3OPPdAZCyUIfG/56Yis5fso2i1DYM8qfhgLBLy1bcJXc0uMHlFsQfSxjhbpT2Ae
        uEV0V5fIK1aSLAE9nDxhqQZbZW8+wsIuNtPJWl98mDeaSBPkGj+DfjEzswgwvQi8A2343UmsSyFyU
        Liwh0IhA9veh31c4tGKIXEyRcPvCLA1G970OUx+hy8K56XI8f+92iPiU8v0pRaEj2FfudcUIBQbpX
        5uy1vmpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jT-007Ll5-QC; Fri, 04 Feb 2022 19:58:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 02/75] mm/gup: Remove for_each_compound_range()
Date:   Fri,  4 Feb 2022 19:57:39 +0000
Message-Id: <20220204195852.1751729-3-willy@infradead.org>
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
compound_range_next() inside the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 08020987dfc0..dc00e46fae5a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -261,9 +261,6 @@ static inline void compound_range_next(unsigned long i, unsigned long npages,
 	struct page *next, *page;
 	unsigned int nr = 1;
 
-	if (i >= npages)
-		return;
-
 	next = *list + i;
 	page = compound_head(next);
 	if (PageCompound(page) && compound_order(page) >= 1)
@@ -274,12 +271,6 @@ static inline void compound_range_next(unsigned long i, unsigned long npages,
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
@@ -396,7 +387,8 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 	struct page *head;
 	unsigned int ntails;
 
-	for_each_compound_range(index, &page, npages, head, ntails) {
+	for (index = 0; index < npages; index += ntails) {
+		compound_range_next(index, npages, &page, &head, &ntails);
 		if (make_dirty && !PageDirty(head))
 			set_page_dirty_lock(head);
 		put_compound_head(head, ntails, FOLL_PIN);
-- 
2.34.1

