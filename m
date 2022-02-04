Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD94AA0D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiBDUEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiBDUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA0DC0613F4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i2wkl4sotmz4wT7aszpL7HQF6ANbuccRaNKu4WPcawI=; b=mJfYIARQ4YMTZOYBmFKRtKo5Dm
        erGHO40XM6FqbO4BrY9B9+sM5L7WQPVIwLbkp8kl46VuETEPGXrnyxOjhVI+/PLdt/enznE3ijZ7x
        XnlBmwimRvG0rRhdRDOfB8FRxntmWKB34aP72fhwHSWe+GwZgXoe7XEfErYVNW2SMJ2xiIaUAxatH
        /GMxm+BLauMuq3w7QtiTSE5p//f9StszIrrecEeiEfEhzfMDR2LpXC8gM8BBpL733UU+iRTfa7ob+
        z9mNQin7cOlziO0NsiPyFQ+bx3aggqkAJ1JoOT366lYy5GlNjTVfFiuYwHPxMrOgjImTKq5AOkHfT
        MapaYHZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlB-0j; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 05/75] mm/gup: Optimise compound_range_next()
Date:   Fri,  4 Feb 2022 19:57:42 +0000
Message-Id: <20220204195852.1751729-6-willy@infradead.org>
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

By definition, a compound page has an order >= 1, so the second half
of the test was redundant.  Also, this cannot be a tail page since
it's the result of calling compound_head(), so use PageHead() instead
of PageCompound().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 26c73998c6df..75a0a1fd4c2a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -262,7 +262,7 @@ static inline struct page *compound_range_next(struct page *start,
 
 	next = start + i;
 	page = compound_head(next);
-	if (PageCompound(page) && compound_order(page) >= 1)
+	if (PageHead(page))
 		nr = min_t(unsigned int,
 			   page + compound_nr(page) - next, npages - i);
 
-- 
2.34.1

