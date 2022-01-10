Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54E3488F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbiAJEYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE28BC06175B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FrPzWZ09xs9aa5csC+CTNKkHIKuSwjgWq1vjKtgzbWE=; b=PDZZlizvSkKJQNj2x7tsRWpb1N
        hdVKt7y+Xxh4qzyI+mWWsfjz8avSgFEZji3flVPQAM8N9XJFoZnAIjvu0gfC6AYOJS5I9+g7jBzhf
        +EcIZ/DFNZhcIBP6lqxrI9kuL1XbW49yqz7xGkLy4Jwwu4b+cLJym2/ff8s4QJMm00XgLqQGrsFy2
        a6OeonVlXtwEvdKeN3+UTDGgJk8ikxpgZEHOHj8fC1C8EdX/yQ/+VNxk4EQnHstSUcksjT1ScuMjs
        N0aPifks38xolz+Si80N3UlHe2ElKqal3R/CjOy2CilLpPvco/iPkHGviOgvnv8LZopjAAEoVjon3
        8DosvRHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025xC-MQ; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 24/28] gup: Convert gup_huge_pgd() to use a folio
Date:   Mon, 10 Jan 2022 04:24:02 +0000
Message-Id: <20220110042406.499429-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new folio-based APIs.  This was the last user of
try_grab_compound_head(), so remove it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7b7bf8361558..b5786e83c418 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -146,12 +146,6 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
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
@@ -2563,7 +2557,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 			struct page **pages, int *nr)
 {
 	int refs;
-	struct page *head, *page;
+	struct page *page;
+	struct folio *folio;
 
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
@@ -2573,17 +2568,17 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
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
2.33.0

