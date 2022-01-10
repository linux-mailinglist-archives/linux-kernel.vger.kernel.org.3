Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8626488F37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiAJEYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6766C061751
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dlgtKTjkERgxYua7qA7Yoi6vlUOwWisaGlBoko6Kg7w=; b=MdYehaqZTNoBT0pJr/dBzKu0xk
        rhxJqipWHBLzxGzgjGBSI9ARSQ1RlA4UFGaT5vyh+ZLD3n7X2WtXi/hIBHEVGqogTYY7hy7cYaNbD
        L5MM96NFsVLNhjaHZpA7rpoJPoiVDLQaQ+clb3yED1pcwzO53aJrART1VpQnwzz3IlH8mHxrQnI4v
        HCGbkVFR1Hd/dDw/RZ/wB1DfOJHhjE7+qw3/DKruUDpZ+rY+erQhJUTjkB1tFsoQIt9v4WCQiF9mS
        GSAMnbkin/NrUmK334/OwCMLSJDzanEXMKDv7Mwe92ldpljQ6RNp0MiNFKkdnOmL2uqPkJBfzkTE6
        4x4BRuug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025x6-F5; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 21/28] gup: Convert gup_hugepte() to use a folio
Date:   Mon, 10 Jan 2022 04:23:59 +0000
Message-Id: <20220110042406.499429-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should be little to no effect from this patch; just removing
uses of some old APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 27cc097ec05d..250326458df6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2428,7 +2428,8 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		       struct page **pages, int *nr)
 {
 	unsigned long pte_end;
-	struct page *head, *page;
+	struct page *page;
+	struct folio *folio;
 	pte_t pte;
 	int refs;
 
@@ -2444,21 +2445,20 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	/* hugepages are never "special" */
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-	head = pte_page(pte);
-	page = nth_page(head, (addr & (sz-1)) >> PAGE_SHIFT);
+	page = nth_page(pte_page(pte), (addr & (sz - 1)) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	head = try_grab_compound_head(head, refs, flags);
-	if (!head)
+	folio = try_grab_folio(page, refs, flags);
+	if (!folio)
 		return 0;
 
 	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
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

