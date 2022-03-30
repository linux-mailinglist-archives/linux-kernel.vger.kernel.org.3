Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6184EBE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbiC3KIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbiC3KI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:08:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56413F8CC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:06:42 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KT28q5fk6zDq9W;
        Wed, 30 Mar 2022 18:04:27 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 18:06:40 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 18:06:40 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>
Subject: [PATCH v2 1/2] mm: fix contiguous memmap assumptions about split page
Date:   Wed, 30 Mar 2022 18:25:33 +0800
Message-ID: <20220330102534.1053240-2-chenwandun@huawei.com>
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

Inspired by:
https://lore.kernel.org/linux-mm/20220204195852.1751729-8-willy@infradead.org/

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/compaction.c  | 6 +++---
 mm/huge_memory.c | 2 +-
 mm/page_alloc.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c3e37aa9ff9e..ddff13b968a2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -87,7 +87,7 @@ static unsigned long release_freepages(struct list_head *freelist)
 static void split_map_pages(struct list_head *list)
 {
 	unsigned int i, order, nr_pages;
-	struct page *page, *next;
+	struct page *page, *next, *tmp;
 	LIST_HEAD(tmp_list);
 
 	list_for_each_entry_safe(page, next, list, lru) {
@@ -101,8 +101,8 @@ static void split_map_pages(struct list_head *list)
 			split_page(page, order);
 
 		for (i = 0; i < nr_pages; i++) {
-			list_add(&page->lru, &tmp_list);
-			page++;
+			tmp = nth_page(page, i);
+			list_add(&tmp->lru, &tmp_list);
 		}
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fe38212e07c..d77fc2ad581d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2297,7 +2297,7 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 static void __split_huge_page_tail(struct page *head, int tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	struct page *page_tail = head + tail;
+	struct page *page_tail = nth_page(head, tail);
 
 	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f648decfe39d..855211dea13e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3513,7 +3513,7 @@ void split_page(struct page *page, unsigned int order)
 	VM_BUG_ON_PAGE(!page_count(page), page);
 
 	for (i = 1; i < (1 << order); i++)
-		set_page_refcounted(page + i);
+		set_page_refcounted(nth_page(page, i));
 	split_page_owner(page, 1 << order);
 	split_page_memcg(page, 1 << order);
 }
-- 
2.18.0.huawei.25

