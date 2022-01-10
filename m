Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F4488F48
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiAJE00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbiAJEYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D54C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=toFUQqgYtl0v327PRslx3eBHdHJmUYmTsDw9nmAaME0=; b=dM3u7vcFyE2WKYv1dSy8MDTHG5
        IGAL8q8VFYIIRashMmorLNTm3sfc4dsBwvsqXdwH3y6KCv4JHhMrUkNUaRhwrNh5yh725n0YhK8uw
        uW0u2BPiVjZpRxGA5+PijRHAsruBIUkNi6bZ6q+KJ4SsxA8TzXWqvvxvCsEhpH3lPDBG40DST1uQU
        kbK2dhclA8f1ozFQx3bUSlmcnxiaW/oifphqGtxqcIiXCiRKXu7tMuaANJJXGhBHcHxpfplm/Ptis
        Fx5YfJgoXVKWnN7dbFWK9ykw1dmIks3XqCyIjI/EA5z4yJI/wEO7F4IKRUdt4ZvZa29a/EBWNGFiz
        MrAhv56g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025xA-Jy; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 23/28] gup: Convert gup_huge_pud() to use a folio
Date:   Mon, 10 Jan 2022 04:24:01 +0000
Message-Id: <20220110042406.499429-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new folio-based APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a006bce2d47b..7b7bf8361558 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2527,7 +2527,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 			unsigned long end, unsigned int flags,
 			struct page **pages, int *nr)
 {
-	struct page *head, *page;
+	struct page *page;
+	struct folio *folio;
 	int refs;
 
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
@@ -2543,17 +2544,17 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	head = try_grab_compound_head(pud_page(orig), refs, flags);
-	if (!head)
+	folio = try_grab_folio(page, refs, flags);
+	if (!folio)
 		return 0;
 
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
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

