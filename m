Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1AD4AA0A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiBDUBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiBDT7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFACFC061770
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ysaRl84X3MDbn+S9kI3xR6Jc2oyHwyLSQUnLAsEjMuE=; b=p5WgdxEXuQhOsrZSCWfZ4nbvWd
        S9QxA2QuZm41bgYIDSTo/MoJ3F6y5NybwdjKAb1zENuNPxQ5JaCgoisSanyS+VxfAKNTZ3DhCnGxM
        GRI34pww82APmBXvYe1slhO7KbeDXyRYwJhBD4FhrACgeJ9vVmZjLA9Egg2oklHL/mRUPz6/77gVa
        yDklaGfn9er6UvGCNj/3gWHOB8DvqpXs0QFCe2otSwINEjDLWRJJhtCLlD5Ckjm0Gl6Md8WfVQF1h
        woWkdLuvkwT4gu9PxQ+vAkPFn1LNuh6QF/usG7AwoaOZZD9Z45+qMiHMtBRIQsv92umXED2i2WbuQ
        Tyyv2O+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jb-007LqN-0i; Fri, 04 Feb 2022 19:59:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 64/75] mm/vmscan: Turn page_check_references() into folio_check_references()
Date:   Fri,  4 Feb 2022 19:58:41 +0000
Message-Id: <20220204195852.1751729-65-willy@infradead.org>
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

This function only has one caller, and it already has a folio.  This
removes a number of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5ceed53cb326..450dd9c3395f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1376,55 +1376,54 @@ enum page_references {
 	PAGEREF_ACTIVATE,
 };
 
-static enum page_references page_check_references(struct page *page,
+static enum page_references folio_check_references(struct folio *folio,
 						  struct scan_control *sc)
 {
-	struct folio *folio = page_folio(page);
-	int referenced_ptes, referenced_page;
+	int referenced_ptes, referenced_folio;
 	unsigned long vm_flags;
 
 	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
 					   &vm_flags);
-	referenced_page = TestClearPageReferenced(page);
+	referenced_folio = folio_test_clear_referenced(folio);
 
 	/*
 	 * Mlock lost the isolation race with us.  Let try_to_unmap()
-	 * move the page to the unevictable list.
+	 * move the folio to the unevictable list.
 	 */
 	if (vm_flags & VM_LOCKED)
 		return PAGEREF_RECLAIM;
 
 	if (referenced_ptes) {
 		/*
-		 * All mapped pages start out with page table
+		 * All mapped folios start out with page table
 		 * references from the instantiating fault, so we need
-		 * to look twice if a mapped file page is used more
+		 * to look twice if a mapped file folio is used more
 		 * than once.
 		 *
 		 * Mark it and spare it for another trip around the
 		 * inactive list.  Another page table reference will
 		 * lead to its activation.
 		 *
-		 * Note: the mark is set for activated pages as well
-		 * so that recently deactivated but used pages are
+		 * Note: the mark is set for activated folios as well
+		 * so that recently deactivated but used folios are
 		 * quickly recovered.
 		 */
-		SetPageReferenced(page);
+		folio_set_referenced(folio);
 
-		if (referenced_page || referenced_ptes > 1)
+		if (referenced_folio || referenced_ptes > 1)
 			return PAGEREF_ACTIVATE;
 
 		/*
-		 * Activate file-backed executable pages after first usage.
+		 * Activate file-backed executable folios after first usage.
 		 */
-		if ((vm_flags & VM_EXEC) && !PageSwapBacked(page))
+		if ((vm_flags & VM_EXEC) && !folio_test_swapbacked(folio))
 			return PAGEREF_ACTIVATE;
 
 		return PAGEREF_KEEP;
 	}
 
-	/* Reclaim if clean, defer dirty pages to writeback */
-	if (referenced_page && !PageSwapBacked(page))
+	/* Reclaim if clean, defer dirty folios to writeback */
+	if (referenced_folio && !folio_test_swapbacked(folio))
 		return PAGEREF_RECLAIM_CLEAN;
 
 	return PAGEREF_RECLAIM;
@@ -1664,7 +1663,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		}
 
 		if (!ignore_references)
-			references = page_check_references(page, sc);
+			references = folio_check_references(folio, sc);
 
 		switch (references) {
 		case PAGEREF_ACTIVATE:
-- 
2.34.1

