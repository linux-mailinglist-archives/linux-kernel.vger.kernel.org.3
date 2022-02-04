Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7014AA0A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiBDUBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A920AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kgqLD6/1r3pqXl6hXsEe475huLOrflUH9tTG8cvSgDw=; b=j3V9BV1a439HO2pZf2qMRBylXN
        SaPFWzaALH24RiPRV0suHNvWT9WAz1KF/pAVXJ16Yz0pmQ4Ck+w0PipqMzwM+6f5Owll1t60KOG2P
        Jz5o8IFcSNrZoE8dcSQ2JZ/Pq7Z1u6DktpEV8mgayBL6gj/nL1qJeuaSJXrKhy5AQlSn3dcxYAEj2
        mDYMPUC83LJ4xI9hLmnqyAuW8XTWPXfdS+yqoFmW4Zn9EvBSSTONOmhbjXyKSKA2P123vSFRGcI86
        uQNXGF0o0/49bJNqSOVgdx1jLVwW9GwGkavYx755iIoSj5psQO7NyrxTSAUUlmYse75NTJREhu6Zs
        7FzOrudA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jT-007Ll9-V7; Fri, 04 Feb 2022 19:58:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 04/75] mm/gup: Change the calling convention for compound_range_next()
Date:   Fri,  4 Feb 2022 19:57:41 +0000
Message-Id: <20220204195852.1751729-5-willy@infradead.org>
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

Return the head page instead of storing it to a passed parameter.
Pass the start page directly instead of passing a pointer to it.
Reorder the arguments to match the calling function's arguments.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index facadcaedea3..26c73998c6df 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -254,21 +254,20 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
-static inline void compound_range_next(unsigned long i, unsigned long npages,
-				       struct page **list, struct page **head,
-				       unsigned int *ntails)
+static inline struct page *compound_range_next(struct page *start,
+		unsigned long npages, unsigned long i, unsigned int *ntails)
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
@@ -380,7 +379,7 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 	unsigned int ntails;
 
 	for (index = 0; index < npages; index += ntails) {
-		compound_range_next(index, npages, &page, &head, &ntails);
+		head = compound_range_next(page, npages, index, &ntails);
 		if (make_dirty && !PageDirty(head))
 			set_page_dirty_lock(head);
 		put_compound_head(head, ntails, FOLL_PIN);
-- 
2.34.1

