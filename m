Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D934AA0A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiBDUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiBDT7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A4C06176E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rlu6DfUIa88mJ0cd0BcIuuL4upjrC5tsvOB++vR6LVA=; b=B6+NbG428CNYYqm0lmODKCU4kV
        rLceLSWjdi+ZT/N8+swpTSOSDOS0hXWNlEW8P8iCFcn5VJbg0kwrthbgDJzupB+FI8gjlKzQDpGHm
        gEs/kQyYtjK3lroOE3aRkIaY90hVKCVx4q87BeHP/8NQAvxwDoPjoTAk4ZOHHZyyiVIJ7Qz/aZhut
        DA5R7qLo7hsT5FDJNP43V7ebNTlEu9qo5Sk8GGVrJd7e8JdfHceGZ1U0hYMkSdVbiZquy4pXI6Ybl
        9xqZeHfM5/g8BrPsVaOyixyWoIVh4f90YNvJ/7q7dFU8QMZ1DC3k1PV/CnRZ8Y4gUXEgiRh2mGbxz
        OCI1BGTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4ja-007Lpz-Jg; Fri, 04 Feb 2022 19:59:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 62/75] mm/vmscan: Optimise shrink_page_list for non-PMD-sized folios
Date:   Fri,  4 Feb 2022 19:58:39 +0000
Message-Id: <20220204195852.1751729-63-willy@infradead.org>
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

A large folio which is smaller than a PMD does not need to do the extra
work in try_to_unmap() of trying to split a PMD entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 794cba8511f1..edcca2424eaa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1758,7 +1758,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			enum ttu_flags flags = TTU_BATCH_FLUSH;
 			bool was_swapbacked = PageSwapBacked(page);
 
-			if (unlikely(PageTransHuge(page)))
+			if (PageTransHuge(page) &&
+					thp_order(page) >= HPAGE_PMD_ORDER)
 				flags |= TTU_SPLIT_HUGE_PMD;
 
 			try_to_unmap(folio, flags);
-- 
2.34.1

