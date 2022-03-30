Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C14EBE58
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbiC3KIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbiC3KI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:08:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00013F8CC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:06:44 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KT29W0RhCzgY96;
        Wed, 30 Mar 2022 18:05:03 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 18:06:42 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 18:06:41 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>
Subject: [PATCH v2 2/2] mm: fix contiguous memmap assumptions about alloc/free pages
Date:   Wed, 30 Mar 2022 18:25:34 +0800
Message-ID: <20220330102534.1053240-3-chenwandun@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220330102534.1053240-1-chenwandun@huawei.com>
References: <20220330102534.1053240-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 mm/page_alloc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 855211dea13e..758d8f069b32 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -721,7 +721,7 @@ static void prep_compound_head(struct page *page, unsigned int order)
 
 static void prep_compound_tail(struct page *head, int tail_idx)
 {
-	struct page *p = head + tail_idx;
+	struct page *p = nth_page(head, tail_idx);
 
 	p->mapping = TAIL_MAPPING;
 	set_compound_head(p, head);
@@ -1199,10 +1199,10 @@ static inline int check_free_page(struct page *page)
 	return 1;
 }
 
-static int free_tail_pages_check(struct page *head_page, struct page *page)
+static int free_tail_pages_check(struct page *head_page, int index)
 {
+	struct page *page = nth_page(head_page, index);
 	int ret = 1;
-
 	/*
 	 * We rely page->lru.next never has bit 0 set, unless the page
 	 * is PageTail(). Let's make sure that's true even for poisoned ->lru.
@@ -1213,7 +1213,7 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 		ret = 0;
 		goto out;
 	}
-	switch (page - head_page) {
+	switch (index) {
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
+				bad += free_tail_pages_check(page, i);
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

