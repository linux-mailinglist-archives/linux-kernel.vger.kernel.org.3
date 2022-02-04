Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578884AA0BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiBDUCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiBDT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD65EC061778
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JubzDfprAA1Un2jOXx0p+mdrOF9Jffo8nBXBBkxLbYU=; b=iPVQs+aC5XUS7bDv6l/us8ZJPC
        yoKMdOcdnUTcRQccnXiOqXkmUbJAPjIyfQVsmbgEgbv71a2Dy++AKfMAQFWzcqe4yUrL5c9c+fzA4
        RcO0epUbpGbz1nSWQtpIZUMhxy/6gnT/Q3yrN7ak0wNt1/7jsEnbccTXAqpS4cmSLPxEEtQcX3WXj
        b6nhFkQQuX6oYFoa5y9eCojIRLouUlwz1YCknq186/1TBlmIcOn7i/F7tlEre+BsffFhwT3Gulqnh
        Nd16VCX6tTTuQMZnb7MNHiUmwGdlgohj8lDQbUVLhBRiQGypYNapaRNN1FepCwKeb+OKiX095dUAR
        S5HLkq8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Llt-Er; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 21/75] mm/gup: Convert gup_hugepte() to use a folio
Date:   Fri,  4 Feb 2022 19:57:58 +0000
Message-Id: <20220204195852.1751729-22-willy@infradead.org>
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

There should be little to no effect from this patch; just removing
uses of some old APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 44281350db1a..6faf8beb4cd9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2445,7 +2445,8 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		       struct page **pages, int *nr)
 {
 	unsigned long pte_end;
-	struct page *head, *page;
+	struct page *page;
+	struct folio *folio;
 	pte_t pte;
 	int refs;
 
@@ -2461,21 +2462,20 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	/* hugepages are never "special" */
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-	head = pte_page(pte);
-	page = nth_page(head, (addr & (sz - 1)) >> PAGE_SHIFT);
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
2.34.1

