Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541FE50DE91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiDYLQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbiDYLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:15:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AF92A275
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:12:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kn2Qk43fVzhYkZ;
        Mon, 25 Apr 2022 19:11:58 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 19:12:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <iamjoonsoo.kim@lge.com>, <hch@lst.de>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 2/6] mm/vmscan: introduce helper function reclaim_page_list()
Date:   Mon, 25 Apr 2022 19:12:28 +0800
Message-ID: <20220425111232.23182-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220425111232.23182-1-linmiaohe@huawei.com>
References: <20220425111232.23182-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce helper function reclaim_page_list() to eliminate the duplicated
code of doing shrink_page_list() and putback_lru_page. Also We can separate
node reclaim from node page list operation this way. No functional change
intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 913eb565140c..7dcc8cf4526f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2539,14 +2539,12 @@ static void shrink_active_list(unsigned long nr_to_scan,
 			nr_deactivate, nr_rotated, sc->priority, file);
 }
 
-unsigned long reclaim_pages(struct list_head *page_list)
+static unsigned int reclaim_page_list(struct list_head *page_list,
+				      struct pglist_data *pgdat)
 {
-	int nid = NUMA_NO_NODE;
-	unsigned int nr_reclaimed = 0;
-	LIST_HEAD(node_page_list);
 	struct reclaim_stat dummy_stat;
-	struct page *page;
-	unsigned int noreclaim_flag;
+	unsigned int nr_reclaimed;
+	struct folio *folio;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_writepage = 1,
@@ -2555,6 +2553,24 @@ unsigned long reclaim_pages(struct list_head *page_list)
 		.no_demotion = 1,
 	};
 
+	nr_reclaimed = shrink_page_list(page_list, pgdat, &sc, &dummy_stat, false);
+	while (!list_empty(page_list)) {
+		folio = lru_to_folio(page_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+
+	return nr_reclaimed;
+}
+
+unsigned long reclaim_pages(struct list_head *page_list)
+{
+	int nid = NUMA_NO_NODE;
+	unsigned int nr_reclaimed = 0;
+	LIST_HEAD(node_page_list);
+	struct page *page;
+	unsigned int noreclaim_flag;
+
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	while (!list_empty(page_list)) {
@@ -2570,28 +2586,12 @@ unsigned long reclaim_pages(struct list_head *page_list)
 			continue;
 		}
 
-		nr_reclaimed += shrink_page_list(&node_page_list,
-						NODE_DATA(nid),
-						&sc, &dummy_stat, false);
-		while (!list_empty(&node_page_list)) {
-			page = lru_to_page(&node_page_list);
-			list_del(&page->lru);
-			putback_lru_page(page);
-		}
-
+		nr_reclaimed += reclaim_page_list(&node_page_list, NODE_DATA(nid));
 		nid = NUMA_NO_NODE;
 	}
 
-	if (!list_empty(&node_page_list)) {
-		nr_reclaimed += shrink_page_list(&node_page_list,
-						NODE_DATA(nid),
-						&sc, &dummy_stat, false);
-		while (!list_empty(&node_page_list)) {
-			page = lru_to_page(&node_page_list);
-			list_del(&page->lru);
-			putback_lru_page(page);
-		}
-	}
+	if (!list_empty(&node_page_list))
+		nr_reclaimed += reclaim_page_list(&node_page_list, NODE_DATA(nid));
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-- 
2.23.0

