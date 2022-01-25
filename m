Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9193549B519
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576991AbiAYN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:27:40 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17810 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576558AbiAYNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:23:13 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JjnYz3KPBz9sQ4;
        Tue, 25 Jan 2022 21:21:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 21:23:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mst@redhat.com>, <david@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/balloon_compaction: make balloon page compaction callbacks static
Date:   Tue, 25 Jan 2022 21:22:21 +0800
Message-ID: <20220125132221.2220-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
feature"), these functions are called via balloon_aops callbacks. They're
not called directly outside this file. So make them static and clean up
the relevant code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/balloon_compaction.h | 22 ----------------------
 mm/balloon_compaction.c            |  6 +++---
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 338aa27e4773..edb7f6d41faa 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -80,12 +80,6 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 
 #ifdef CONFIG_BALLOON_COMPACTION
 extern const struct address_space_operations balloon_aops;
-extern bool balloon_page_isolate(struct page *page,
-				isolate_mode_t mode);
-extern void balloon_page_putback(struct page *page);
-extern int balloon_page_migrate(struct address_space *mapping,
-				struct page *newpage,
-				struct page *page, enum migrate_mode mode);
 
 /*
  * balloon_page_insert - insert a page into the balloon's page list and make
@@ -155,22 +149,6 @@ static inline void balloon_page_delete(struct page *page)
 	list_del(&page->lru);
 }
 
-static inline bool balloon_page_isolate(struct page *page)
-{
-	return false;
-}
-
-static inline void balloon_page_putback(struct page *page)
-{
-	return;
-}
-
-static inline int balloon_page_migrate(struct page *newpage,
-				struct page *page, enum migrate_mode mode)
-{
-	return 0;
-}
-
 static inline gfp_t balloon_mapping_gfp_mask(void)
 {
 	return GFP_HIGHUSER;
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 907fefde2572..4b8eab4b3f45 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -203,7 +203,7 @@ EXPORT_SYMBOL_GPL(balloon_page_dequeue);
 
 #ifdef CONFIG_BALLOON_COMPACTION
 
-bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
+static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 
 {
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
@@ -217,7 +217,7 @@ bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 	return true;
 }
 
-void balloon_page_putback(struct page *page)
+static void balloon_page_putback(struct page *page)
 {
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
 	unsigned long flags;
@@ -230,7 +230,7 @@ void balloon_page_putback(struct page *page)
 
 
 /* move_to_new_page() counterpart for a ballooned page */
-int balloon_page_migrate(struct address_space *mapping,
+static int balloon_page_migrate(struct address_space *mapping,
 		struct page *newpage, struct page *page,
 		enum migrate_mode mode)
 {
-- 
2.23.0

