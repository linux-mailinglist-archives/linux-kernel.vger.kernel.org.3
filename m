Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049E14AA090
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiBDT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbiBDT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC48C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZGUNblaPy+0CLxla8etvidC8Ld2G9pzD+/27Z3AyaUs=; b=I+1Sp/cLkrfSPETrjSyMPUw5/c
        M48GPdSCSJpo7W/qwrO7qjJ8A8q6oSpA20ghe+5H+X9qZfb28YDHG6AJtUpA+3QtmKVVR1n6TOxhn
        dvEm3OylxoQDyeEjm55jw/5kV0LjCBYTYIH15S2gskc00EUCz/LjaW2IB0qjl1QPl+DYR5GgsKZIF
        mP4m9nUhudjs6Brw1/ZcupreVgxe04BIHiTb6RzOg0UE3O7J2AMXoQPP0T4Asoi0hTRwYcpcRhvDp
        KFQoiWqY9QdLVCQ5TPw7YNVTaCB+Y/CzHni/C5oO98h7AGggbGVHgoID49ES8AWSU2PhcjQOEpzR0
        2E25y3cA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Llf-0f; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/75] mm/gup: Convert try_grab_page() to use a folio
Date:   Fri,  4 Feb 2022 19:57:53 +0000
Message-Id: <20220204195852.1751729-17-willy@infradead.org>
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

Hoist the folio conversion and the folio_ref_count() check to the
top of the function instead of using the one buried in try_get_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4f1669db92f5..d18ce4da573f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -174,15 +174,14 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
 
 /**
  * try_grab_page() - elevate a page's refcount by a flag-dependent amount
+ * @page:    pointer to page to be grabbed
+ * @flags:   gup flags: these are the FOLL_* flag values.
  *
  * This might not do anything at all, depending on the flags argument.
  *
  * "grab" names in this file mean, "look at flags to decide whether to use
  * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
  *
- * @page:    pointer to page to be grabbed
- * @flags:   gup flags: these are the FOLL_* flag values.
- *
  * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
  * time. Cases: please see the try_grab_folio() documentation, with
  * "refs=1".
@@ -193,29 +192,28 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
  */
 bool __must_check try_grab_page(struct page *page, unsigned int flags)
 {
+	struct folio *folio = page_folio(page);
+
 	WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == (FOLL_GET | FOLL_PIN));
+	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
+		return false;
 
 	if (flags & FOLL_GET)
-		return try_get_page(page);
+		folio_ref_inc(folio);
 	else if (flags & FOLL_PIN) {
-		page = compound_head(page);
-
-		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
-			return false;
-
 		/*
-		 * Similar to try_grab_compound_head(): be sure to *also*
+		 * Similar to try_grab_folio(): be sure to *also*
 		 * increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
-		if (PageHead(page)) {
-			page_ref_add(page, 1);
-			atomic_add(1, compound_pincount_ptr(page));
+		if (folio_test_large(folio)) {
+			folio_ref_add(folio, 1);
+			atomic_add(1, folio_pincount_ptr(folio));
 		} else {
-			page_ref_add(page, GUP_PIN_COUNTING_BIAS);
+			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
 		}
 
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
+		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
 	}
 
 	return true;
-- 
2.34.1

