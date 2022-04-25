Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833EA50DEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiDYLYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiDYLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:23:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA0C8AAA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:20:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kn2cp6cxBzhYj8;
        Mon, 25 Apr 2022 19:20:42 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 19:20:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <hch@infradead.org>, <hannes@cmpxchg.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3] mm/vmscan: take min_slab_pages into account when try to call shrink_node
Date:   Mon, 25 Apr 2022 19:21:18 +0800
Message-ID: <20220425112118.20924-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

Since commit 6b4f7799c6a5 ("mm: vmscan: invoke slab shrinkers from
shrink_zone()"), slab reclaim and lru page reclaim are done together
in the shrink_node. So we should take min_slab_pages into account
when try to call shrink_node.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
v3:
  This patch is pending verifying. Split it out to make it easier
  to move forward.
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a2752e8fc879..1049f5324765 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4718,7 +4718,8 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	noreclaim_flag = memalloc_noreclaim_save();
 	set_task_reclaim_state(p, &sc.reclaim_state);
 
-	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
+	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages ||
+	    node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) > pgdat->min_slab_pages) {
 		/*
 		 * Free memory by calling shrink node with increasing
 		 * priorities until we have enough memory freed.
-- 
2.23.0

