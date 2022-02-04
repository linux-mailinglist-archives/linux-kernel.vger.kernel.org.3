Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF04AA0BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiBDUCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiBDT7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D104C06176F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CHhZ25O3OhV0N7J2wADYsEBTBy/Oulpk6Xzyr7aEGBI=; b=MFx1C5bt5C/1e6O7AB7bbfzcRk
        sCTuR0iR2fgIYTF0/50HMiQ0Fbpmjxy8K5/pMFhv5jKqkMbO5nzo2j5h0k+B4DIrEOKoZhi5oaVcR
        S5a6wL8ibGa9QvcFoPeegAUyIbY6v5akkNddZTscLh75dLc59cLKtxGwsKtw29FzGFYBkPqa+dbCW
        RrcOPUvARw7dhCDYIvVrHeh3/CFD1f2GQ7q9eVdJs7TGxomdlNsGHUDG3+KW+tnnJmSJ0XQ94FNOj
        AUtTOxfB6+NpHA+j+6GdgUEfJBThipsBeBvdHSjti/zs3V3Acl1+QHqGku6KMCtq2Uue0u/24xvqw
        iCaX5crA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4ja-007LqE-TP; Fri, 04 Feb 2022 19:59:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 63/75] mm/vmscan: Account large folios correctly
Date:   Fri,  4 Feb 2022 19:58:40 +0000
Message-Id: <20220204195852.1751729-64-willy@infradead.org>
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

The statistics we gather should count the number of pages, not the
number of folios.  The logic in this function is somewhat convoluted,
but even if we split the folio, I think the accounting is now correct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index edcca2424eaa..5ceed53cb326 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1568,10 +1568,10 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 */
 		folio_check_dirty_writeback(folio, &dirty, &writeback);
 		if (dirty || writeback)
-			stat->nr_dirty++;
+			stat->nr_dirty += nr_pages;
 
 		if (dirty && !writeback)
-			stat->nr_unqueued_dirty++;
+			stat->nr_unqueued_dirty += nr_pages;
 
 		/*
 		 * Treat this page as congested if the underlying BDI is or if
@@ -1583,7 +1583,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		if (((dirty || writeback) && mapping &&
 		     inode_write_congested(mapping->host)) ||
 		    (writeback && PageReclaim(page)))
-			stat->nr_congested++;
+			stat->nr_congested += nr_pages;
 
 		/*
 		 * If a page at the tail of the LRU is under writeback, there
@@ -1632,7 +1632,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			if (current_is_kswapd() &&
 			    PageReclaim(page) &&
 			    test_bit(PGDAT_WRITEBACK, &pgdat->flags)) {
-				stat->nr_immediate++;
+				stat->nr_immediate += nr_pages;
 				goto activate_locked;
 
 			/* Case 2 above */
@@ -1650,7 +1650,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				 * and it's also appropriate in global reclaim.
 				 */
 				SetPageReclaim(page);
-				stat->nr_writeback++;
+				stat->nr_writeback += nr_pages;
 				goto activate_locked;
 
 			/* Case 3 above */
@@ -1816,7 +1816,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			case PAGE_ACTIVATE:
 				goto activate_locked;
 			case PAGE_SUCCESS:
-				stat->nr_pageout += thp_nr_pages(page);
+				stat->nr_pageout += nr_pages;
 
 				if (PageWriteback(page))
 					goto keep;
-- 
2.34.1

