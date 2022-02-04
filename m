Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5284C4AA0DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbiBDUE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiBDUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:03:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3A7C06177D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/Ikry4i7/ZyLiR01kDRIl2Fp5MVRfbfZzjepJkLAh+0=; b=Jry3eUpw8gdjuiAaSLNyXabMrN
        rb7RLT8kpU03ec6D9LninNI6dY3ilkFxVCsbHb+tELhsY157eG4dtEUVYOIHYxOfhaQKZlx/Q5lqe
        VDfwjYsBc+K8qkTGEmUzqO91B2eMHPu67mPeMymZY8rhpCSEtnlzX5BEpFZRO0X7QFne8UTqTqyYT
        OZPX1lC3mtsKl9nq7+/M3O71JVLmQ3h//U4e8BqQFcvyoiN8QU7K/YihrDvD2O7u33PsAJvMyZPOK
        f62eS1ryqorEdGvRGehE+qkMXPmWNwexe10PFRY0efjEJVnYM+m296lr4S4Q5ak06G/6ce1mN67Qs
        7fRATzbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Llz-R7; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 24/75] mm/gup: Convert gup_huge_pgd() to use a folio
Date:   Fri,  4 Feb 2022 19:58:01 +0000
Message-Id: <20220204195852.1751729-25-willy@infradead.org>
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

Use the new folio-based APIs.  This was the last user of
try_grab_compound_head(), so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6d7a2ba6790b..bf196219c189 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -133,12 +133,6 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	return NULL;
 }
 
-static inline struct page *try_grab_compound_head(struct page *page,
-		int refs, unsigned int flags)
-{
-	return &try_grab_folio(page, refs, flags)->page;
-}
-
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
@@ -2580,7 +2574,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 			struct page **pages, int *nr)
 {
 	int refs;
-	struct page *head, *page;
+	struct page *page;
+	struct folio *folio;
 
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
@@ -2590,17 +2585,17 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	head = try_grab_compound_head(pgd_page(orig), refs, flags);
-	if (!head)
+	folio = try_grab_folio(page, refs, flags);
+	if (!folio)
 		return 0;
 
 	if (unlikely(pgd_val(orig) != pgd_val(*pgdp))) {
-		put_compound_head(head, refs, flags);
+		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
 
 	*nr += refs;
-	SetPageReferenced(head);
+	folio_set_referenced(folio);
 	return 1;
 }
 
-- 
2.34.1

