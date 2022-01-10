Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5824D488F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiAJE0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiAJEYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3654C061201
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/mKomX3uXiZG7krGrOYnz6hJemX5OW1n+xjyCfpBJys=; b=a+pmaVeLJi8SRHS5L7Dmup8EfI
        2Nsn3zM4iQfxtuZc0F+2ox0aylv0ROJxj6j+/0/YRSBk8bdqF/Js/jkheepU4xFCwlCqSafOo1kBC
        CmnDDcwxdecjjSCy5j4PCjipzr8m+UYAtqmsXVrU7MeC8Y2k5a8hOGFfDTSW0y1QshGRHnLBAynJ3
        R/EcAV18PSYHlf7fr3+xRy51kcSev0z3bPVPQlqluI3IlARSIoqqlbaXvePozuIKaCyFsuN39gR1y
        8t672VdTzDDI9o7KCcm08Si2loC7UJ4T3XmiHaept+7O6n4Dwkb8SCamVEAvgMjnYtMrbrPIiJdar
        lE1BtiUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wc-B3; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 06/28] gup: Fix some contiguous memmap assumptions
Date:   Mon, 10 Jan 2022 04:23:44 +0000
Message-Id: <20220110042406.499429-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions in gup.c assume that a compound page has virtually
contiguous page structs.  This isn't true for SPARSEMEM configs unless
SPARSEMEM_VMEMMAP is also set.  Fix them by using nth_page() instead of
plain pointer arithmetic.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8a0ea220ced1..9c0a702a4e03 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -235,7 +235,7 @@ static inline struct page *compound_range_next(unsigned long i,
 	struct page *next, *page;
 	unsigned int nr = 1;
 
-	next = start + i;
+	next = nth_page(start, i);
 	page = compound_head(next);
 	if (PageHead(page))
 		nr = min_t(unsigned int,
@@ -2430,8 +2430,8 @@ static int record_subpages(struct page *page, unsigned long addr,
 {
 	int nr;
 
-	for (nr = 0; addr != end; addr += PAGE_SIZE)
-		pages[nr++] = page++;
+	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
+		pages[nr] = nth_page(page, nr);
 
 	return nr;
 }
@@ -2466,7 +2466,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
 	head = pte_page(pte);
-	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
+	page = nth_page(head, (addr & (sz-1)) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
 	head = try_grab_compound_head(head, refs, flags);
@@ -2526,7 +2526,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
 	head = try_grab_compound_head(pmd_page(orig), refs, flags);
@@ -2560,7 +2560,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
 	head = try_grab_compound_head(pud_page(orig), refs, flags);
@@ -2589,7 +2589,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 
 	BUILD_BUG_ON(pgd_devmap(orig));
 
-	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
+	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
 	head = try_grab_compound_head(pgd_page(orig), refs, flags);
-- 
2.33.0

