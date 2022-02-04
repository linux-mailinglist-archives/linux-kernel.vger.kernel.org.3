Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A632E4AA0C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbiBDUDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2A4C061751
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AZtYGWaQIVF80cGs43r5RQ+0AtmMNHsJoH6q+RECIQc=; b=SEHIb+LELVsxBPqfzw4/b/kzCr
        lWekk7iNkDd6IxVCHlOZqydw4NNeyhWn+d//kpRRHLkgDkRJsEns5mQKXkhikyqZBn/lCPd+PBnZz
        XQRrDLX2VLn1IRk+4EV+ER30v5ySQTKPz1esiGzeOZzc6zCcXrqBNkmJuRQYhpqcFCwXtCBS5bZ4X
        r2b79inNIUEH7f8K30WFd0e6B1dCZDff8P5Vm9KQCySyFbQlgxi+ETGIw2CCBVKe5euKtnJJg7JgY
        kpVTRV/OwTH2t8PENeRCeHUrWN6crW7z9io1oCI+f1XRaOTfAptK0AkfHN9lfR/L0NG7NU4EP7YFg
        Ec+v4Kkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jX-007Lmr-6z; Fri, 04 Feb 2022 19:59:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 37/75] mm: Add split_folio_to_list()
Date:   Fri,  4 Feb 2022 19:58:14 +0000
Message-Id: <20220204195852.1751729-38-willy@infradead.org>
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

This is a convenience function; split_huge_page_to_list() can take
any page in a folio (and does so on purpose because that page will
be the one which keeps the refcount).  But it's convenient for the
callers to pass the folio instead of the first page in the folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  6 ++++++
 mm/vmscan.c             | 10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e4c18ba8d3bf..71c073d411ac 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -483,6 +483,12 @@ static inline bool thp_migration_supported(void)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static inline int split_folio_to_list(struct folio *folio,
+		struct list_head *list)
+{
+	return split_huge_page_to_list(&folio->page, list);
+}
+
 /**
  * thp_size - Size of a transparent huge page.
  * @page: Head page of a transparent huge page.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e8c5855bc38d..0d23ade9f6e2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1708,16 +1708,16 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 					 * tail pages can be freed without IO.
 					 */
 					if (!compound_mapcount(page) &&
-					    split_huge_page_to_list(page,
-								    page_list))
+					    split_folio_to_list(folio,
+								page_list))
 						goto activate_locked;
 				}
 				if (!add_to_swap(page)) {
 					if (!PageTransHuge(page))
 						goto activate_locked_split;
 					/* Fallback to swap normal pages */
-					if (split_huge_page_to_list(page,
-								    page_list))
+					if (split_folio_to_list(folio,
+								page_list))
 						goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 					count_vm_event(THP_SWPOUT_FALLBACK);
@@ -1733,7 +1733,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			}
 		} else if (unlikely(PageTransHuge(page))) {
 			/* Split file THP */
-			if (split_huge_page_to_list(page, page_list))
+			if (split_folio_to_list(folio, page_list))
 				goto keep_locked;
 		}
 
-- 
2.34.1

