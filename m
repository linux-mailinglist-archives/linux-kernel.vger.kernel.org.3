Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C754AA09F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiBDUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiBDT7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84F9C061772
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7lCdDpwYdKDkLlbslxBRg+2wOD2EjKVgpCEmaUyy+oM=; b=QwfwufgSXk6f+sdolDtZP+fdSy
        0fpEMthi/hNNBIpZDavPRrrnFKpzDge8xNVnjkWzTocuexNJjAS/TWxrOFtQ1tvRmiehHabY0lDjE
        TlWM/nsV/WE6cplK2QqPAUwHPvNJx7/ga9XwlrKkha5pmb3Z0Rc6msOCHpL2v47s3gEAfHa0+/qpq
        VzwDGcKx2ESs7sEahSmI8MKSWjhixRG4YAOdw/+cMeWIgxx0OwYi3Om2L7IzeGghQ0DxcuU3B0QoU
        QK4nlFZJp/rBlVTTkeOnYvAm4e791rtqywqKOv7ix2+XRLLrm2LdnK7ZauqGEWb/6VoKmyR5DQdiu
        /iUrolLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007Lm7-66; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 28/75] mm/gup: Convert check_and_migrate_movable_pages() to use a folio
Date:   Fri,  4 Feb 2022 19:58:05 +0000
Message-Id: <20220204195852.1751729-29-willy@infradead.org>
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

Switch from head pages to folios.  This removes an assumption that
THPs are the only way to have a high-order page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index edec7356b965..9f2f8d765c58 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1815,41 +1815,41 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
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
+				if (folio_isolate_lru(folio)) {
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
2.34.1

