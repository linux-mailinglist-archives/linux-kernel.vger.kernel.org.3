Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2724AA092
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiBDUAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbiBDT7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299E7C061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L37MxzcVyvY09GTWOfKpnrpDRYDGlN5/2cipacEt3mI=; b=ZhFNNZhgMvwA2TG2/a6FGpBoc9
        AqK7iDGsWQzCBRJn+TEe0o+W86DMYD9LcFyzHjiowHJ8Tu6VXhtQjRLYHOE2KpmXIo8V/RRqsLTrF
        WbG52N+2uWo532xUuSdlpYwuEK0pg3X/daE+obSOZZlg9P6iKyZOYpBevBtumYw9wIu/ubBuHFGzs
        utudAFbWmLtrVZ3/ztqbAAA3oXWGGg377/i7eNlbgylA3AWNWj+KMTWnNMaQqLCH1et5AkgFy1ePM
        1H4DVtT9Dn1TGeU/lLU510OFH5mEPPWfQInO8YndDKoPnP2aDo0LNMfdeFONzgQ+ceUEzlLdXc4q3
        MZRnsSWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jb-007Lqq-EK; Fri, 04 Feb 2022 19:59:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 67/75] mm/filemap: Allow large folios to be added to the page cache
Date:   Fri,  4 Feb 2022 19:58:44 +0000
Message-Id: <20220204195852.1751729-68-willy@infradead.org>
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

We return -EEXIST if there are any non-shadow entries in the page
cache in the range covered by the folio.  If there are multiple
shadow entries in the range, we set *shadowp to one of them (currently
the one at the highest index).  If that turns out to be the wrong
answer, we can implement something more complex.  This is mostly
modelled after the equivalent function in the shmem code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ad8c39d90bf9..8f7ac3de9098 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -842,26 +842,27 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int huge = folio_test_hugetlb(folio);
-	int error;
 	bool charged = false;
+	long nr = 1;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
 	mapping_set_update(&xas, mapping);
 
-	folio_get(folio);
-	folio->mapping = mapping;
-	folio->index = index;
-
 	if (!huge) {
-		error = mem_cgroup_charge(folio, NULL, gfp);
+		int error = mem_cgroup_charge(folio, NULL, gfp);
 		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
-			goto error;
+			return error;
 		charged = true;
+		xas_set_order(&xas, index, folio_order(folio));
+		nr = folio_nr_pages(folio);
 	}
 
 	gfp &= GFP_RECLAIM_MASK;
+	folio_ref_add(folio, nr);
+	folio->mapping = mapping;
+	folio->index = xas.xa_index;
 
 	do {
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
@@ -885,6 +886,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 			/* entry may have been split before we acquired lock */
 			order = xa_get_order(xas.xa, xas.xa_index);
 			if (order > folio_order(folio)) {
+				/* How to handle large swap entries? */
+				BUG_ON(shmem_mapping(mapping));
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
@@ -894,29 +897,31 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		if (xas_error(&xas))
 			goto unlock;
 
-		mapping->nrpages++;
+		mapping->nrpages += nr;
 
 		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge)
-			__lruvec_stat_add_folio(folio, NR_FILE_PAGES);
+		if (!huge) {
+			__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+			if (folio_test_pmd_mappable(folio))
+				__lruvec_stat_mod_folio(folio,
+						NR_FILE_THPS, nr);
+		}
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
 
-	if (xas_error(&xas)) {
-		error = xas_error(&xas);
-		if (charged)
-			mem_cgroup_uncharge(folio);
+	if (xas_error(&xas))
 		goto error;
-	}
 
 	trace_mm_filemap_add_to_page_cache(folio);
 	return 0;
 error:
+	if (charged)
+		mem_cgroup_uncharge(folio);
 	folio->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	folio_put(folio);
-	return error;
+	folio_put_refs(folio, nr);
+	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-- 
2.34.1

