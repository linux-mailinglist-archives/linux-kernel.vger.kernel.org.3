Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF044AA08F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiBDT7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiBDT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA9AC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dWpyn2grOZbdkVKfq1AQyk9euyCX9uRwjuX/Z2zFNP8=; b=IIkx0MGDdfq/Z2Hje/dD5In3xo
        5RLRAtlsVK17eQ6leQRmuWVmLhUgRIZ3UNMsql8hGllsmJTC5KqvT2Cu2/tJfRPqmmOzM8xPavF7I
        Oiqo3heIu0zgrstAoKIS5pPumlBODsWJj953N0OBB8bhVhQGLn82xox7Dpx8x4M4kjVJc17tWA5XF
        A0YYRqXYJsh4ykbR6TQjS3WKCkM0M0x2snmyX+c+VmEWa7GkSeJL/RTjbg2cdwASk43rEjy5o/oFL
        YYeP6kslsXWFRCcQuufR/ZMwk4scTRWaF3U9NV3L3Ncsu7fsrx0WX3S3d2Um2C8kS4K9iWwe9WHkU
        zOjNDC2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007Lmf-WC; Fri, 04 Feb 2022 19:59:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 35/75] mm: Turn head_compound_mapcount() into folio_entire_mapcount()
Date:   Fri,  4 Feb 2022 19:58:12 +0000
Message-Id: <20220204195852.1751729-36-willy@infradead.org>
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

Adjust documentation to be more clear.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 17 +++++++++++------
 mm/debug.c         |  6 ++++--
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6cb2651eccbe..6ddf655f9279 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -777,21 +777,26 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 }
 #endif
 
-static inline int head_compound_mapcount(struct page *head)
+/*
+ * How many times the entire folio is mapped as a single unit (eg by a
+ * PMD or PUD entry).  This is probably not what you want, except for
+ * debugging purposes; look at folio_mapcount() or page_mapcount()
+ * instead.
+ */
+static inline int folio_entire_mapcount(struct folio *folio)
 {
-	return atomic_read(compound_mapcount_ptr(head)) + 1;
+	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	return atomic_read(folio_mapcount_ptr(folio)) + 1;
 }
 
 /*
  * Mapcount of compound page as a whole, does not include mapped sub-pages.
  *
- * Must be called only for compound pages or any their tail sub-pages.
+ * Must be called only for compound pages.
  */
 static inline int compound_mapcount(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageCompound(page), page);
-	page = compound_head(page);
-	return head_compound_mapcount(page);
+	return folio_entire_mapcount(page_folio(page));
 }
 
 /*
diff --git a/mm/debug.c b/mm/debug.c
index c4cf44266430..eeb7ea3ca292 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -48,7 +48,8 @@ const struct trace_print_flags vmaflag_names[] = {
 
 static void __dump_page(struct page *page)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
+	struct page *head = &folio->page;
 	struct address_space *mapping;
 	bool compound = PageCompound(page);
 	/*
@@ -76,6 +77,7 @@ static void __dump_page(struct page *page)
 		else
 			mapping = (void *)(tmp & ~PAGE_MAPPING_FLAGS);
 		head = page;
+		folio = (struct folio *)page;
 		compound = false;
 	} else {
 		mapping = page_mapping(page);
@@ -94,7 +96,7 @@ static void __dump_page(struct page *page)
 	if (compound) {
 		pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
 				head, compound_order(head),
-				head_compound_mapcount(head),
+				folio_entire_mapcount(folio),
 				head_compound_pincount(head));
 	}
 
-- 
2.34.1

