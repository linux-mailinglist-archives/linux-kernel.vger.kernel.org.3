Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398494AA0A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiBDUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiBDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FAC061769
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tAlp5bd8C5vytOPTINuNcDJ98zbTyIQpNVjwT2Tt/6A=; b=VzvZxECHLB/Uio/a0kGT0n1wKi
        XfS2JeQAwVBSHV1/WcPaX2OKMrvxbs6Vj9hGGbVRRRSyTQ/0CwUDZl0SuMK7nAMgOnKjUlOg7lB8I
        SF2ZQJdXalWrBS51TbMUaI56SLX/PawfBZT8WbCWkMoQypG8hGz1t6dwvYfh+x7bk8Rv3amiGjDlw
        RoQ6DK8yHxHRMyPya4oNTvGUxr9lER8u1dBh/eflBwD6d7lxHwRoRco1bcwTf29ecRsPSQhDetj6N
        +QkMd7GAA5MIr63Q+6AnEG12vG9FtB2OXbuYxGYlRIXxpZqWHLoYGDawW92/rb2pgAfD23aLIBMcM
        D8D2GJWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jZ-007Lp6-KP; Fri, 04 Feb 2022 19:59:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 55/75] mm/damon: Convert damon_pa_mkold() to use a folio
Date:   Fri,  4 Feb 2022 19:58:32 +0000
Message-Id: <20220204195852.1751729-56-willy@infradead.org>
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
 mm/damon/paddr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4e27d64abbb7..a92d8b146527 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -37,6 +37,7 @@ static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
 
 static void damon_pa_mkold(unsigned long paddr)
 {
+	struct folio *folio;
 	struct page *page = damon_get_page(PHYS_PFN(paddr));
 	struct rmap_walk_control rwc = {
 		.rmap_one = __damon_pa_mkold,
@@ -46,23 +47,24 @@ static void damon_pa_mkold(unsigned long paddr)
 
 	if (!page)
 		return;
+	folio = page_folio(page);
 
-	if (!page_mapped(page) || !page_rmapping(page)) {
-		set_page_idle(page);
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
+		folio_set_idle(folio);
 		goto out;
 	}
 
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page))
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
 		goto out;
 
-	rmap_walk(page, &rwc);
+	rmap_walk(&folio->page, &rwc);
 
 	if (need_lock)
-		unlock_page(page);
+		folio_unlock(folio);
 
 out:
-	put_page(page);
+	folio_put(folio);
 }
 
 static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
-- 
2.34.1

