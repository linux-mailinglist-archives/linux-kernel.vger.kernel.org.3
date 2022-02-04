Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1714AA0BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiBDUCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiBDT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9BC061756
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qaW1STlEavKmMe0Akb7mwFUoG0w3VvyW+VFu7YfPNxY=; b=Lj9uvwTl7Z80l0jhEiZGvXJgjW
        mrOOogAihpQO7lVIsHcGiLmz/BoAX1pPqX61dCjSs41YGdhV9xWlxhdDwzByaHuUW9cWjRk+MNu9R
        RJtT/TXdhfH+zqoOuYpEw/RcOIeIYuYheb9oqqZK9JD1qpxDtxEd5L1meDe2+ZhK1tFKBqI6rXc5o
        kN29+9CcysQUp+eVGB8Ckt+Q7q0PIT6VOWXVPm2kyGPNOE6Sv8ARW7CCpwPuuCV/GoFZytmkbA+HB
        xSueWi5Ey940fuZybEHO/S6g5jdy4AyUVa/igXdYrJwr6jaEfmg1u9zFFvsVALvI9PPbngM8CnS09
        qMcNKuVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlF-5f; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 07/75] mm/gup: Fix some contiguous memmap assumptions
Date:   Fri,  4 Feb 2022 19:57:44 +0000
Message-Id: <20220204195852.1751729-8-willy@infradead.org>
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

Several functions in gup.c assume that a compound page has virtually
contiguous page structs.  This isn't true for SPARSEMEM configs unless
SPARSEMEM_VMEMMAP is also set.  Fix them by using nth_page() instead of
plain pointer arithmetic.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7e4bdae83e9b..29a8021f10a2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -260,7 +260,7 @@ static inline struct page *compound_range_next(struct page *start,
 	struct page *next, *page;
 	unsigned int nr = 1;
 
-	next = start + i;
+	next = nth_page(start, i);
 	page = compound_head(next);
 	if (PageHead(page))
 		nr = min_t(unsigned int,
@@ -2462,8 +2462,8 @@ static int record_subpages(struct page *page, unsigned long addr,
 {
 	int nr;
 
-	for (nr = 0; addr != end; addr += PAGE_SIZE)
-		pages[nr++] = page++;
+	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
+		pages[nr] = nth_page(page, nr);
 
 	return nr;
 }
@@ -2498,7 +2498,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
 	head = pte_page(pte);
-	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
+	page = nth_page(head, (addr & (sz - 1)) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
 	head = try_grab_compound_head(head, refs, flags);
@@ -2558,7 +2558,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
 	head = try_grab_compound_head(pmd_page(orig), refs, flags);
@@ -2592,7 +2592,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
 	head = try_grab_compound_head(pud_page(orig), refs, flags);
@@ -2621,7 +2621,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 
 	BUILD_BUG_ON(pgd_devmap(orig));
 
-	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
+	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
 	head = try_grab_compound_head(pgd_page(orig), refs, flags);
-- 
2.34.1

