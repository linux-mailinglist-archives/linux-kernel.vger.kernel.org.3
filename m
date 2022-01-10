Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E5488F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiAJE0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiAJEYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B3FC06175B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/DPJvh8nZY8O3CzKnWIX/byaa2jenc4w/Fleth+y20E=; b=gHzU4niHDL73CDvZ4y9ZrGch48
        bMd5a3+9Z3TkUFgqpFk1IFK3Yu6nb+K2xMlltYCDn/3nNwCt58gKoG/cLHjhUoUH0s6MH/PH5GsOt
        8xM+W9e6+2bFcXR9YEJMzKaqI5d6E2wpTwXYlSlGgf/PYNXXGRUYIxs9iLRgwoR3Jd5QhKxrkvT4B
        n7YcK3RyLBwZNGitu7ZYNkzKAeCx6UNIvZ5FikJ+1t9s6FxkfNsmyD6tV2wkKOyW7UaFwyLWhDK3V
        KyVFyPhmfKXNObz8PJkzqer7lRnp7CJiUO6sO4BFlN869hlAxZAwSfE4NJHkcKdjm6ePwcZ0UAebu
        s/Fm3+JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025we-Dp; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 07/28] gup: Remove an assumption of a contiguous memmap
Date:   Mon, 10 Jan 2022 04:23:45 +0000
Message-Id: <20220110042406.499429-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This assumption needs the inverse of nth_page(), which I've temporarily
named page_nth() until someone comes up with a better name.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 2 ++
 mm/gup.c           | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d8b7d7ed14dd..f2f3400665a4 100644
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
index 9c0a702a4e03..afb638a30e44 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -238,8 +238,8 @@ static inline struct page *compound_range_next(unsigned long i,
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
2.33.0

