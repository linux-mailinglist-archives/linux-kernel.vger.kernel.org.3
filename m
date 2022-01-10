Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71597488F36
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiAJEYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB18AC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bF3YwsJlDdayaosPsW7OCN1/4CCh76lSoZ3+feMmOkc=; b=PQk/7QjPqGUvXtrFs0Kr76GObb
        Xng+45VgzfG8GyAOUqUyRYL+YY0Khbhmk3/VWOl13W9NIKy2s9O7y0iZBYM4LlIDEA4SvuqHJGkwi
        85c5ycIXougd1QOFneGEldcJQhSiMm/Xtu4pnGjK20d3hXYGKnFctxHQwWtGUG5dXWVItZ8lqqSkB
        bPcdmokKh7Q4sCD7wcdLHuR3+2VWirUQ8rUzwDF8NtvWwG+vIc0L6dFZu6Lw7TW0ejqjEo15pXiGK
        8SkQfW8Y6XX/KmtV8BDF6iArC0FmXD1TEXPzz6tXqNQ1rvSniEvUx6bDIMtVHm0Knx8fPxDmUzRKX
        803c6OaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mEA-0025xL-1X; Mon, 10 Jan 2022 04:24:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 28/28] gup: Convert check_and_migrate_movable_pages() to use a folio
Date:   Mon, 10 Jan 2022 04:24:06 +0000
Message-Id: <20220110042406.499429-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from head pages to folios.  This removes an assumption that
THPs are the only way to have a high-order page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1cdd5f2887a8..b2d109626c44 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1801,41 +1801,41 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	bool drain_allow = true;
 	LIST_HEAD(movable_page_list);
 	long ret = 0;
-	struct page *prev_head = NULL;
-	struct page *head;
+	struct folio *folio, *prev_folio = NULL;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 	for (i = 0; i < nr_pages; i++) {
-		head = compound_head(pages[i]);
-		if (head == prev_head)
+		folio = page_folio(pages[i]);
+		if (folio == prev_folio)
 			continue;
-		prev_head = head;
+		prev_folio = folio;
 		/*
 		 * If we get a movable page, since we are going to be pinning
 		 * these entries, try to move them out if possible.
 		 */
-		if (!is_pinnable_page(head)) {
-			if (PageHuge(head)) {
-				if (!isolate_huge_page(head, &movable_page_list))
+		if (!is_pinnable_page(&folio->page)) {
+			if (folio_test_hugetlb(folio)) {
+				if (!isolate_huge_page(&folio->page,
+							&movable_page_list))
 					isolation_error_count++;
 			} else {
-				if (!PageLRU(head) && drain_allow) {
+				if (!folio_test_lru(folio) && drain_allow) {
 					lru_add_drain_all();
 					drain_allow = false;
 				}
 
-				if (isolate_lru_page(head)) {
+				if (isolate_lru_folio(folio)) {
 					isolation_error_count++;
 					continue;
 				}
-				list_add_tail(&head->lru, &movable_page_list);
-				mod_node_page_state(page_pgdat(head),
+				list_add_tail(&folio->lru, &movable_page_list);
+				node_stat_mod_folio(folio,
 						    NR_ISOLATED_ANON +
-						    page_is_file_lru(head),
-						    thp_nr_pages(head));
+						    folio_is_file_lru(folio),
+						    folio_nr_pages(folio));
 			}
 		}
 	}
-- 
2.33.0

