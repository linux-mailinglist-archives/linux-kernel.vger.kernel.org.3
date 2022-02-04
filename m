Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25834AA0B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiBDUC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCD0C061759
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2mHVS7k36npFN25FhvkmSnAZo1mYjfPpfVgX9RGUKq8=; b=eicnxn7w0V/pR8d6uMIwjVD6Ok
        77YRhLGQYq04iqZwutq5XjOgvr+7uRnoY2Cl+WTzj68vCg+oUP3ImeT7Si5h7ulgNMRfj2T78SQp5
        +q8UGik6YLFcfzBACXLaQt2NkAnEMwChLqjdtV7vR8kQKXoZU0HKu2z7HcC0gARygClwcFBNd86A7
        ZYmQqrNo4wWZjU25VqF96I+8Zl7uV5vEvOWrSWlzljGauvFnsQLCHY+Ka0UR6gF+AqrCqp/pZC4CH
        5WMrus0c1eZQ0AYCi++lxFSuX5QEfPatfNyk/r60WsxPZwvCoTcYD6bFMgb8wD5pACfUyGopg+sVL
        PP0BCwag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jX-007LnU-Vg; Fri, 04 Feb 2022 19:59:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 43/75] mm/page_idle: Convert page_idle_clear_pte_refs() to use a folio
Date:   Fri,  4 Feb 2022 19:58:20 +0000
Message-Id: <20220204195852.1751729-44-willy@infradead.org>
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

The PG_idle and PG_young bits are ignored if they're set on tail
pages, so ensure we're passing a folio around.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_idle.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 20d35d720872..544814bd9e37 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -13,6 +13,8 @@
 #include <linux/page_ext.h>
 #include <linux/page_idle.h>
 
+#include "internal.h"
+
 #define BITMAP_CHUNK_SIZE	sizeof(u64)
 #define BITMAP_CHUNK_BITS	(BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
 
@@ -48,6 +50,7 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
 					struct vm_area_struct *vma,
 					unsigned long addr, void *arg)
 {
+	struct folio *folio = page_folio(page);
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = addr,
@@ -74,19 +77,20 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
 	}
 
 	if (referenced) {
-		clear_page_idle(page);
+		folio_clear_idle(folio);
 		/*
 		 * We cleared the referenced bit in a mapping to this page. To
 		 * avoid interference with page reclaim, mark it young so that
 		 * page_referenced() will return > 0.
 		 */
-		set_page_young(page);
+		folio_set_young(folio);
 	}
 	return true;
 }
 
 static void page_idle_clear_pte_refs(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	/*
 	 * Since rwc.arg is unused, rwc is effectively immutable, so we
 	 * can make it static const to save some cycles and stack.
@@ -97,18 +101,17 @@ static void page_idle_clear_pte_refs(struct page *page)
 	};
 	bool need_lock;
 
-	if (!page_mapped(page) ||
-	    !page_rmapping(page))
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio))
 		return;
 
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page))
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
 		return;
 
-	rmap_walk(page, (struct rmap_walk_control *)&rwc);
+	rmap_walk(&folio->page, (struct rmap_walk_control *)&rwc);
 
 	if (need_lock)
-		unlock_page(page);
+		folio_unlock(folio);
 }
 
 static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
-- 
2.34.1

