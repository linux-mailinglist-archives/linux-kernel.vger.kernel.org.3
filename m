Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43A04EAE69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiC2N1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiC2N1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:27:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E961F5195
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:25:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KSVgF1Nsvz1GCxj;
        Tue, 29 Mar 2022 21:25:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 21:25:45 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/8] mm/vmscan: introduce helper function reclaim_page_list()
Date:   Tue, 29 Mar 2022 21:26:14 +0800
Message-ID: <20220329132619.18689-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220329132619.18689-1-linmiaohe@huawei.com>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 mm/vmscan.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 09b452c4d256..a6e60c78d058 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2513,14 +2513,11 @@ static void shrink_active_list(unsigned long nr_to_scan,
 			nr_deactivate, nr_rotated, sc->priority, file);
 }
 
-unsigned long reclaim_pages(struct list_head *page_list)
+static inline unsigned int reclaim_page_list(struct list_head *page_list, struct pglist_data *pgdat)
 {
-	int nid = NUMA_NO_NODE;
-	unsigned int nr_reclaimed = 0;
-	LIST_HEAD(node_page_list);
 	struct reclaim_stat dummy_stat;
+	unsigned int nr_reclaimed;
 	struct page *page;
-	unsigned int noreclaim_flag;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_writepage = 1,
@@ -2529,6 +2526,24 @@ unsigned long reclaim_pages(struct list_head *page_list)
 		.no_demotion = 1,
 	};
 
+	nr_reclaimed = shrink_page_list(page_list, pgdat, &sc, &dummy_stat, false);
+	while (!list_empty(page_list)) {
+		page = lru_to_page(page_list);
+		list_del(&page->lru);
+		putback_lru_page(page);
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
@@ -2544,28 +2559,12 @@ unsigned long reclaim_pages(struct list_head *page_list)
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

