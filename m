Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309FB488F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbiAJE07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiAJEZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:25:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B485C061757
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PMXingW4eQcetsP+Ankg7iWuo3nyPl2vlV/6qXVRFks=; b=n18ODInjFZJSyEpHvkEsh9YJTK
        +uPkafon+0J6706NZc+vLmkEIuqkh8Q8XhvMVc7lJ/Jo7aEh42HgZ+/eFQ9PytDBKBT4DdS9JBr0x
        4bcO22N4r7Ibi0uEIDXR3WjTKCZT7Ut8zxXQHtquJq69Z2sQntuaHku+2aGnVbbjGw9+ulayIB2Q9
        5CHQiTK+6y7fb7hnNmIhK8etwk5VKSFNN+dqOAKSvGIJOMiiUV2y/goH9vf7HGVi5vQ+iML8Dpg+5
        Sddxp9xM5Df1U/mzGxDPb2Bt4oZE8U+Gw++ra1TUSorh+6nE+YgMyplf+BGDZxYlOsSnCpSZlOR9f
        qu4+B7jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wk-KY; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 10/28] gup: Turn hpage_pincount_sub() into page_pincount_sub()
Date:   Mon, 10 Jan 2022 04:23:48 +0000
Message-Id: <20220110042406.499429-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary VM_BUG_ON by handling pages both with and without
a pincount field in page_pincount_sub().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3ed9907f3c8d..aed48de3912e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -48,12 +48,15 @@ static void page_pincount_add(struct page *page, int refs)
 		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
 }
 
-static void hpage_pincount_sub(struct page *page, int refs)
+static int page_pincount_sub(struct page *page, int refs)
 {
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
 	VM_BUG_ON_PAGE(page != compound_head(page), page);
 
-	atomic_sub(refs, compound_pincount_ptr(page));
+	if (hpage_pincount_available(page))
+		atomic_sub(refs, compound_pincount_ptr(page));
+	else
+		refs *= GUP_PIN_COUNTING_BIAS;
+	return refs;
 }
 
 /* Equivalent to calling put_page() @refs times. */
@@ -177,11 +180,7 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
 	if (flags & FOLL_PIN) {
 		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
 				    refs);
-
-		if (hpage_pincount_available(page))
-			hpage_pincount_sub(page, refs);
-		else
-			refs *= GUP_PIN_COUNTING_BIAS;
+		refs = page_pincount_sub(page, refs);
 	}
 
 	put_page_refs(page, refs);
-- 
2.33.0

