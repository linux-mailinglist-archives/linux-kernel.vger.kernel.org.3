Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27C4AA0C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiBDUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiBDT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AB7C06177C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PfQOTVgeWGT3scFV19Cd1ZaUkxymD+QBS63EkVoXSxc=; b=RZJM0dLLF/gofYIbSl2YdKP9eL
        1FE4YMufpbI/R4pqNQslFtv2i0QMRYfiyB7Br9Adb8iamSp1IPvVktun+X2Jv44rzt3pmGDbOHHzq
        2TeUyH/6/g40XJ0WMDNf4jNGSmJ9xbbsSLfc9z67VdK/hN/G2E10w1+2re2TSUy60iR6LTPBnQijK
        PhDquH+eVokp6L4mfiCLWbXCwWzNd2sm/sF1lSVTUfWpI/0ZAK/fjlOFUvqtJleBLxu0JB2mg+8N7
        tr1J/9hex36g7BA2P4U5l7gEdbjo8msqS893Z+RpDJ/MMpZ8j0j4R3qs3EpjCpwE8mbkUsvQJV7e1
        NCT1i5Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlL-EQ; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/75] mm/gup: Remove hpage_pincount_add()
Date:   Fri,  4 Feb 2022 19:57:47 +0000
Message-Id: <20220204195852.1751729-11-willy@infradead.org>
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

It's clearer to call atomic_add() in the callers; the assertions clearly
can't fire there because they're part of the condition for calling
atomic_add().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 923a0d44203c..60168a09d52a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,14 +29,6 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
-static void hpage_pincount_add(struct page *page, int refs)
-{
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
-	VM_BUG_ON_PAGE(page != compound_head(page), page);
-
-	atomic_add(refs, compound_pincount_ptr(page));
-}
-
 static void hpage_pincount_sub(struct page *page, int refs)
 {
 	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
@@ -151,17 +143,17 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 			return NULL;
 
 		/*
-		 * When pinning a compound page of order > 1 (which is what
-		 * hpage_pincount_available() checks for), use an exact count to
-		 * track it, via hpage_pincount_add/_sub().
+		 * When pinning a compound page of order > 1 (which is
+		 * what hpage_pincount_available() checks for), use an
+		 * exact count to track it.
 		 *
-		 * However, be sure to *also* increment the normal page refcount
-		 * field at least once, so that the page really is pinned.
-		 * That's why the refcount from the earlier
+		 * However, be sure to *also* increment the normal page
+		 * refcount field at least once, so that the page really
+		 * is pinned.  That's why the refcount from the earlier
 		 * try_get_compound_head() is left intact.
 		 */
 		if (hpage_pincount_available(page))
-			hpage_pincount_add(page, refs);
+			atomic_add(refs, compound_pincount_ptr(page));
 		else
 			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
 
@@ -216,22 +208,19 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 	if (flags & FOLL_GET)
 		return try_get_page(page);
 	else if (flags & FOLL_PIN) {
-		int refs = 1;
-
 		page = compound_head(page);
 
 		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
 			return false;
 
 		/*
-		 * Similar to try_grab_compound_head(): even if using the
-		 * hpage_pincount_add/_sub() routines, be sure to
-		 * *also* increment the normal page refcount field at least
-		 * once, so that the page really is pinned.
+		 * Similar to try_grab_compound_head(): be sure to *also*
+		 * increment the normal page refcount field at least once,
+		 * so that the page really is pinned.
 		 */
 		if (hpage_pincount_available(page)) {
 			page_ref_add(page, 1);
-			hpage_pincount_add(page, 1);
+			atomic_add(1, compound_pincount_ptr(page));
 		} else {
 			page_ref_add(page, GUP_PIN_COUNTING_BIAS);
 		}
-- 
2.34.1

