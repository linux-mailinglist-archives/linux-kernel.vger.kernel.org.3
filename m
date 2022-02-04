Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD3F4AA0CE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbiBDUDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiBDT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDF2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lIjuioOJHPq4RX0whsGK0UKELzJseRq+4vm3ZIS+NFk=; b=I2wTyyvh6k+ne2yj3LDU2S6AI8
        YDD7eClIZRLnpMt0AKR6k+FzmOkcRlHXqga2rlpWCXZJJdrc3ZsLZ9Z3lbRubyT6q6ZWA8Ox43ouS
        xpxAX3v10+QJjvgEsPX0wBBuK7mt5oJ6u3QJfcYnkfu20GE+2jr65fQ1yq3vcsww12bWwOIQdRjzI
        JDaVKcRhf99yWlx0f3edWSXfySguFK1DdiwSRA0DF1yAspDucIyLEldp7H5mY3WT9UKnGGV9TL/qQ
        fMbr9clZZn4pxqcEpRo120J18M/iGkDzfdGMpZjDv4sXhvIC+e92Wg3VVAZLelLjdd4m1pScZK8iH
        IIifuKBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Llr-CB; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 20/75] mm/gup: Convert gup_pte_range() to use a folio
Date:   Fri,  4 Feb 2022 19:57:57 +0000
Message-Id: <20220204195852.1751729-21-willy@infradead.org>
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

We still call try_grab_folio() once per PTE; a future patch could
optimise to just adjust the reference count for each page within
the folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 00227b2cb1cf..44281350db1a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2252,7 +2252,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
 		pte_t pte = ptep_get_lockless(ptep);
-		struct page *head, *page;
+		struct page *page;
+		struct folio *folio;
 
 		/*
 		 * Similar to the PMD case below, NUMA hinting must take slow
@@ -2279,22 +2280,20 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
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
@@ -2308,10 +2307,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
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
2.34.1

