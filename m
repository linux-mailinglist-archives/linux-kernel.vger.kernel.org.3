Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8424AA0B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbiBDUCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3FC06176A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nu6DijrC8WBcPz39bB/vehblgzoM159H3giVCpWUnfU=; b=U5guoGdWSY/YcvOjl4Kcqes/Oz
        +L6KQv0zWwwgzL24RFOHVYmohQPCpAdr2aJoRkcGBJzIDxpdGJn3oLmzmxqT/pTTswbZ4Goy9nFgz
        p0xQYD+aznQUG+Q7dThzxepKdH8YXrUAkwffHIl62DUwxgTEhNuQ1RqnVkTvlvG2DBqSOhZxHwlJ7
        eZjLYA/aVI8ctyW0txodD8KcGXv8R5JlgJdbJTfn8oPzzV9M19ihIig2F6h0N1iSUI3S35icpf4VU
        hBlnO1DbXKMWmlC/VMwmUbmSYTwLF5cW1YWy9qRkiR2Cb6JLN2pnU4e1W7PLlMVPrDQ8TtKvWEpSn
        E4/49sEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jZ-007LpE-Pe; Fri, 04 Feb 2022 19:59:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 56/75] mm/damon: Convert damon_pa_young() to use a folio
Date:   Fri,  4 Feb 2022 19:58:33 +0000
Message-Id: <20220204195852.1751729-57-willy@infradead.org>
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

Ensure that we're passing the entire folio to rmap_walk().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/damon/paddr.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index a92d8b146527..05e85a131a49 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -94,6 +94,7 @@ struct damon_pa_access_chk_result {
 static bool __damon_pa_young(struct page *page, struct vm_area_struct *vma,
 		unsigned long addr, void *arg)
 {
+	struct folio *folio = page_folio(page);
 	struct damon_pa_access_chk_result *result = arg;
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
@@ -107,12 +108,12 @@ static bool __damon_pa_young(struct page *page, struct vm_area_struct *vma,
 		addr = pvmw.address;
 		if (pvmw.pte) {
 			result->accessed = pte_young(*pvmw.pte) ||
-				!page_is_idle(page) ||
+				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			result->accessed = pmd_young(*pvmw.pmd) ||
-				!page_is_idle(page) ||
+				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 			result->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
 #else
@@ -131,6 +132,7 @@ static bool __damon_pa_young(struct page *page, struct vm_area_struct *vma,
 
 static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 {
+	struct folio *folio;
 	struct page *page = damon_get_page(PHYS_PFN(paddr));
 	struct damon_pa_access_chk_result result = {
 		.page_sz = PAGE_SIZE,
@@ -145,27 +147,28 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 
 	if (!page)
 		return false;
+	folio = page_folio(page);
 
-	if (!page_mapped(page) || !page_rmapping(page)) {
-		if (page_is_idle(page))
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
+		if (folio_test_idle(folio))
 			result.accessed = false;
 		else
 			result.accessed = true;
-		put_page(page);
+		folio_put(folio);
 		goto out;
 	}
 
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page)) {
-		put_page(page);
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio)) {
+		folio_put(folio);
 		return NULL;
 	}
 
-	rmap_walk(page, &rwc);
+	rmap_walk(&folio->page, &rwc);
 
 	if (need_lock)
-		unlock_page(page);
-	put_page(page);
+		folio_unlock(folio);
+	folio_put(folio);
 
 out:
 	*page_sz = result.page_sz;
-- 
2.34.1

