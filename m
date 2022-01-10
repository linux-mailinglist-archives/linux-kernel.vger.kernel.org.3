Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02E488F49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiAJE03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiAJEYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4EC061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cNkGRRqE4MZ2IOY+aRtZ6O11ENnM+VUoRZ1VxqjqE3o=; b=XOj3bE4s2SziUPl4NNs9v1GOQC
        HevnwI8lrxL7DmnEAPUYAWy34kzK5npISqem7T56xj61z6L1q/Ddv/LabQ3++ka6+lsIEVo41JWsX
        8rtSy+opZf39sTkTo8cAEMnv/XkqN6anRr/PyfCxHDwlLFFWajLlzFxx8mA+fso+lCsl+OSsqnfJa
        6MJvBhMubiCav7PUMH1D4cVum7gqyi9YjODfwdYR0krwMxJO4ODeZhPC8iY0HPWKXqS5m8d63HWV4
        CFSi3NBDsz+n8zSkyDHuxQ1sJpNTOR1oMnGth7hL9Z1Ux+EPuZAqRCG7JaoW4hwP7AQx5bDnFoUVp
        urm0Tg0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wi-IQ; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 09/28] gup: Turn hpage_pincount_add() into page_pincount_add()
Date:   Mon, 10 Jan 2022 04:23:47 +0000
Message-Id: <20220110042406.499429-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify try_grab_compound_head() and remove an unnecessary
VM_BUG_ON by handling pages both with and without a pincount field in
page_pincount_add().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index dbb1b54d0def..3ed9907f3c8d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,12 +29,23 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
-static void hpage_pincount_add(struct page *page, int refs)
+/*
+ * When pinning a compound page of order > 1 (which is what
+ * hpage_pincount_available() checks for), use an exact count to track
+ * it, via page_pincount_add/_sub().
+ *
+ * However, be sure to *also* increment the normal page refcount field
+ * at least once, so that the page really is pinned.  That's why the
+ * refcount from the earlier try_get_compound_head() is left intact.
+ */
+static void page_pincount_add(struct page *page, int refs)
 {
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
 	VM_BUG_ON_PAGE(page != compound_head(page), page);
 
-	atomic_add(refs, compound_pincount_ptr(page));
+	if (hpage_pincount_available(page))
+		atomic_add(refs, compound_pincount_ptr(page));
+	else
+		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
 }
 
 static void hpage_pincount_sub(struct page *page, int refs)
@@ -150,21 +161,7 @@ struct page *try_grab_compound_head(struct page *page,
 		if (!page)
 			return NULL;
 
-		/*
-		 * When pinning a compound page of order > 1 (which is what
-		 * hpage_pincount_available() checks for), use an exact count to
-		 * track it, via hpage_pincount_add/_sub().
-		 *
-		 * However, be sure to *also* increment the normal page refcount
-		 * field at least once, so that the page really is pinned.
-		 * That's why the refcount from the earlier
-		 * try_get_compound_head() is left intact.
-		 */
-		if (hpage_pincount_available(page))
-			hpage_pincount_add(page, refs);
-		else
-			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
-
+		page_pincount_add(page, refs);
 		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
 				    refs);
 
-- 
2.33.0

