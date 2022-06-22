Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83A5551F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377192AbiFVRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377041AbiFVRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF123F308
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LSqVd6XLFzhYds;
        Thu, 23 Jun 2022 01:04:25 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 01:06:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 13/16] mm/huge_memory: add helper __get_deferred_split_queue
Date:   Thu, 23 Jun 2022 01:06:24 +0800
Message-ID: <20220622170627.19786-14-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220622170627.19786-1-linmiaohe@huawei.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper __get_deferred_split_queue to remove the duplicated codes of
getting ds_queue. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0030b4f67cd9..de8155ff584c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -555,25 +555,23 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 	return pmd;
 }
 
-#ifdef CONFIG_MEMCG
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
+static inline struct deferred_split *__get_deferred_split_queue(struct pglist_data *pgdat,
+								struct mem_cgroup *memcg)
 {
-	struct mem_cgroup *memcg = page_memcg(compound_head(page));
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
-
+#ifdef CONFIG_MEMCG
 	if (memcg)
 		return &memcg->deferred_split_queue;
-	else
-		return &pgdat->deferred_split_queue;
+#endif
+	return &pgdat->deferred_split_queue;
 }
-#else
+
 static inline struct deferred_split *get_deferred_split_queue(struct page *page)
 {
+	struct mem_cgroup *memcg = page_memcg(compound_head(page));
 	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
 
-	return &pgdat->deferred_split_queue;
+	return __get_deferred_split_queue(pgdat, memcg);
 }
-#endif
 
 void prep_transhuge_page(struct page *page)
 {
@@ -2774,31 +2772,22 @@ void deferred_split_huge_page(struct page *page)
 static unsigned long deferred_split_count(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
-	struct pglist_data *pgdata = NODE_DATA(sc->nid);
-	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
+	struct deferred_split *ds_queue;
 
-#ifdef CONFIG_MEMCG
-	if (sc->memcg)
-		ds_queue = &sc->memcg->deferred_split_queue;
-#endif
+	ds_queue = __get_deferred_split_queue(NODE_DATA(sc->nid), sc->memcg);
 	return READ_ONCE(ds_queue->split_queue_len);
 }
 
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
-	struct pglist_data *pgdata = NODE_DATA(sc->nid);
-	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 	LIST_HEAD(list), *pos, *next;
 	struct page *page;
 	int split = 0;
 
-#ifdef CONFIG_MEMCG
-	if (sc->memcg)
-		ds_queue = &sc->memcg->deferred_split_queue;
-#endif
-
+	ds_queue = __get_deferred_split_queue(NODE_DATA(sc->nid), sc->memcg);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	/* Take pin on all head pages to avoid freeing them under us */
 	list_for_each_safe(pos, next, &ds_queue->split_queue) {
-- 
2.23.0

