Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967E4AA0AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiBDUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbiBDT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39969C06175D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wHs6MVU8ScHq8HwASxu+WtvgZudUXxYv4AfDo2/UixE=; b=YYjyRdLE6KTkgmsiX/qoVe9qTG
        u5U00Pho6myWayUPcHV7iGMOTx+0zGnd2PztBPNTJO002X2dPO67twQ1I3oGOENv7N1jcIQR25ddR
        Wpmn9rX0YiCX8W15/5nmht+De3x4lIAZn1MmiW/MFLqgRqhU9BV/3jEuF0xOc5HAzqt0R7NGvitaI
        BHERmMeFnO7ZfNaGxlP94Bb+EesY54O65yvtX1uMwFNokRAa8MNWAbYcQG2PFzB/uG9sLYzwMZvna
        WNskPXsOll845+45h1DeXbJGSypF+4tWbbVFNIh2sV2oXbGN2o6Z7ktAODiZB0chZvfwkqIVZrTv/
        /WjxTMkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlH-8J; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 08/75] mm/gup: Remove an assumption of a contiguous memmap
Date:   Fri,  4 Feb 2022 19:57:45 +0000
Message-Id: <20220204195852.1751729-9-willy@infradead.org>
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

This assumption needs the inverse of nth_page(), which is temporarily
named page_nth() until it's renamed later in this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h | 2 ++
 mm/gup.c           | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..e679a7d66200 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -216,8 +216,10 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
+#define page_nth(head, tail)	(page_to_pfn(tail) - page_to_pfn(head))
 #else
 #define nth_page(page,n) ((page) + (n))
+#define page_nth(head, tail)	((tail) - (head))
 #endif
 
 /* to align the pointer to the (next) page boundary */
diff --git a/mm/gup.c b/mm/gup.c
index 29a8021f10a2..fa75b71820a2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -263,8 +263,8 @@ static inline struct page *compound_range_next(struct page *start,
 	next = nth_page(start, i);
 	page = compound_head(next);
 	if (PageHead(page))
-		nr = min_t(unsigned int,
-			   page + compound_nr(page) - next, npages - i);
+		nr = min_t(unsigned int, npages - i,
+			   compound_nr(page) - page_nth(page, next));
 
 	*ntails = nr;
 	return page;
-- 
2.34.1

