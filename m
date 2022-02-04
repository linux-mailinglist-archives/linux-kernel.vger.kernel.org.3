Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FEC4AA0C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiBDUDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiBDT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BCFC06175A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1PqJy3qyxx9ZfB1pTIydk4AC0uSd8CQ4ZT1UzFOW0k4=; b=U/3g5iPw5GVCb0lDCfcs7uWpnM
        eRhaK7lZHruqfwgnJDtz+TH65rfWNL66KAcHpf/lN2psj5vbPgDWOQAw5p7IoU/dugf/TZkZ1xUHE
        YeBej2IYzSbhEuKQ9Wf6rnTT8vwLH/lqGXvKz+428aVcyoBqL1wiVhcEEA0oljN372gXp3M4RzhMj
        OAqgei9MsvBGI2BgvshCb4Oao5qf77t8mXD7tf/Q6uBV+Fmb2Kcr/wc6pfK8vkr2K1aWxG7BLEbHL
        Obk1g1nAORZaB3rBqmEOc3PSLAPLCCA9nooEFmQhpWeyp3fYkB+gnLQXQA/xfW5kBUcpOw/S/qgNI
        wK/+6TgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jY-007Lna-2y; Fri, 04 Feb 2022 19:59:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 44/75] mm/rmap: Use a folio in page_mkclean_one()
Date:   Fri,  4 Feb 2022 19:58:21 +0000
Message-Id: <20220204195852.1751729-45-willy@infradead.org>
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

folio_mkclean() already passes down a head page, so convert it
back to a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/rmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index d62a6fcef318..18ae6bd79efd 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -931,6 +931,7 @@ int page_referenced(struct page *page,
 static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 			    unsigned long address, void *arg)
 {
+	struct folio *folio = page_folio(page);
 	struct page_vma_mapped_walk pvmw = {
 		.vma = vma,
 		.address = address,
@@ -942,7 +943,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 	pvmw_set_page(&pvmw, page);
 	/*
 	 * We have to assume the worse case ie pmd for invalidation. Note that
-	 * the page can not be free from this function.
+	 * the folio can not be freed from this function.
 	 */
 	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
 				0, vma, vma->vm_mm, address,
@@ -974,14 +975,14 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 			if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
 				continue;
 
-			flush_cache_page(vma, address, page_to_pfn(page));
+			flush_cache_page(vma, address, folio_pfn(folio));
 			entry = pmdp_invalidate(vma, address, pmd);
 			entry = pmd_wrprotect(entry);
 			entry = pmd_mkclean(entry);
 			set_pmd_at(vma->vm_mm, address, pmd, entry);
 			ret = 1;
 #else
-			/* unexpected pmd-mapped page? */
+			/* unexpected pmd-mapped folio? */
 			WARN_ON_ONCE(1);
 #endif
 		}
-- 
2.34.1

