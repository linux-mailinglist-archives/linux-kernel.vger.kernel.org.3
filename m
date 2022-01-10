Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2824488F45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiAJEZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiAJEYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F803C061751
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zipY2Xef+bdp0dO6EMAI54lIjbt9nG2TQ8Ia2LQ9a/Q=; b=ns5OGy9Zz2OyKInKaLEalu2rr6
        qg8S/j7UAKJxQzhpBFlCFvfgDQm/xaI4heaNVADhMk5hbH25uKPWE70CgIHr+u8FtdkeRgHDzldrm
        btpoe3/2uFb7+edVFD6tJjWaEj/OMkHQ22Xu/Bu/de0utTgIEQjHOvtK6+1wR6JmAwZww3Of1yb5v
        /MGjs6Jk2ANLvphPBpkFDvrreMxs5n11Hd9CsxU7X+KEfc9SL4iyLC8X53kQFaY785bAEQM6ng0Lu
        CpzNuR/qQh1XJpRTKtfDtTncReANru/+fgpdvIXzZc2dpTNsEN9TOtbOdOv5WHQLXxHehsufxIYfU
        BkVJoCOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wY-68; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 04/28] gup: Optimise compound_range_next()
Date:   Mon, 10 Jan 2022 04:23:42 +0000
Message-Id: <20220110042406.499429-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By definition, a compound page has an order >= 1, so the second half
of the test was redundant.  Also, this cannot be a tail page since
it's the result of calling compound_head(), so use PageHead() instead
of PageCompound().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3c93d2fdf4da..6eedca605b3d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -237,7 +237,7 @@ static inline struct page *compound_range_next(unsigned long i,
 
 	next = start + i;
 	page = compound_head(next);
-	if (PageCompound(page) && compound_order(page) >= 1)
+	if (PageHead(page))
 		nr = min_t(unsigned int,
 			   page + compound_nr(page) - next, npages - i);
 
-- 
2.33.0

