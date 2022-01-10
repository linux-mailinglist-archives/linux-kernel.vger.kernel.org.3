Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74B0488F39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiAJEYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081BC061757
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yZ4KQo4q1BMM1IW+AzT2B5hxEwiTFmWyBI9LyNwadcs=; b=Y5qROpafFS6IdPE7SWUIpy6y8Z
        Ds+tDsyfKz6WZBH31pIe6DOFpJl+sL1ipeyGzZS6M32jWbWlVpPjrdc0wyfd3tfgdzi96/xLaCYPK
        6IWJzByu6T19rwB9OaCPv52ko4Rp38fup0pf0Dn/rNQA93YVC5YF+L2YbELkCpRTT9VVzRlW2Set/
        YCOnWIPsNbA16eeJW5Q/hsx4elwOPo+uFT9qegKtEVyIg7uDimB17Irt6Tsu6pozdXSx4r9XT13LR
        HDCAr9UF4wB8jm9nDjxjU2PPIK4G+ApcUMyf20j05eU8DoKnc8U15y26j3J/PkR6sHGJBD2QPxycG
        630C9lUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025x4-Ce; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 20/28] gup: Convert gup_pte_range() to use a folio
Date:   Mon, 10 Jan 2022 04:23:58 +0000
Message-Id: <20220110042406.499429-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still call try_grab_folio() once per PTE; a future patch could
optimise to just adjust the reference count for each page within
the folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index c3e514172eaf..27cc097ec05d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2235,7 +2235,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
 		pte_t pte = ptep_get_lockless(ptep);
-		struct page *head, *page;
+		struct page *page;
+		struct folio *folio;
 
 		/*
 		 * Similar to the PMD case below, NUMA hinting must take slow
@@ -2262,22 +2263,20 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		head = try_grab_compound_head(page, 1, flags);
-		if (!head)
+		folio = try_grab_folio(page, 1, flags);
+		if (!folio)
 			goto pte_unmap;
 
 		if (unlikely(page_is_secretmem(page))) {
-			put_compound_head(head, 1, flags);
+			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
 
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
-			put_compound_head(head, 1, flags);
+			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
 
-		VM_BUG_ON_PAGE(compound_head(page) != head, page);
-
 		/*
 		 * We need to make the page accessible if and only if we are
 		 * going to access its content (the FOLL_PIN case).  Please
@@ -2291,10 +2290,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 				goto pte_unmap;
 			}
 		}
-		SetPageReferenced(page);
+		folio_set_referenced(folio);
 		pages[*nr] = page;
 		(*nr)++;
-
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
 
 	ret = 1;
-- 
2.33.0

