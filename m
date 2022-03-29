Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22984EADCB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiC2MxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiC2MxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:53:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B64565CE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:50:54 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KSTv04kk1z1GD2C;
        Tue, 29 Mar 2022 20:50:36 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 20:50:52 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 20:50:52 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH 2/2] mm: fix contiguous memmap assumptions about alloc/free pages
Date:   Tue, 29 Mar 2022 21:09:28 +0800
Message-ID: <20220329130928.266323-3-chenwandun@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220329130928.266323-1-chenwandun@huawei.com>
References: <20220329130928.266323-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't true for only SPARSEMEM configs to assume that a compound page
has virtually contiguous page structs, so use nth_page to iterate each
page.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 include/linux/mm.h |  2 ++
 mm/page_alloc.c    | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 355075fb2654..ef48cfef7c67 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -212,9 +212,11 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
+#define page_nth(head, tail)	(page_to_pfn(tail) - page_to_pfn(head))
 #define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
 #else
 #define nth_page(page,n) ((page) + (n))
+#define page_nth(head, tail)	((tail) - (head))
 #define folio_page_idx(folio, p)	((p) - &(folio)->page)
 #endif
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 855211dea13e..09bc63992d20 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -721,7 +721,7 @@ static void prep_compound_head(struct page *page, unsigned int order)
 
 static void prep_compound_tail(struct page *head, int tail_idx)
 {
-	struct page *p = head + tail_idx;
+	struct page *p = nth_page(head, tail_idx);
 
 	p->mapping = TAIL_MAPPING;
 	set_compound_head(p, head);
@@ -1213,7 +1213,7 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 		ret = 0;
 		goto out;
 	}
-	switch (page - head_page) {
+	switch (page_nth(head_page, page)) {
 	case 1:
 		/* the first tail page: ->mapping may be compound_mapcount() */
 		if (unlikely(compound_mapcount(page))) {
@@ -1322,6 +1322,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	if (unlikely(order)) {
 		bool compound = PageCompound(page);
 		int i;
+		struct page *tail_page;
 
 		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
 
@@ -1330,13 +1331,14 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			ClearPageHasHWPoisoned(page);
 		}
 		for (i = 1; i < (1 << order); i++) {
+			tail_page = nth_page(page, i);
 			if (compound)
-				bad += free_tail_pages_check(page, page + i);
-			if (unlikely(check_free_page(page + i))) {
+				bad += free_tail_pages_check(page, tail_page);
+			if (unlikely(check_free_page(tail_page))) {
 				bad++;
 				continue;
 			}
-			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+			tail_page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
 	if (PageMappingFlags(page))
-- 
2.18.0.huawei.25

