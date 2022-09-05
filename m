Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC75AC91B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiIED3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbiIED3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:29:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1925FB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:29:38 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MLYnV6M6vz1N7v4;
        Mon,  5 Sep 2022 11:25:50 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 11:29:36 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 11:29:35 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>, <npiggin@suse.de>,
        <ying.huang@intel.com>, <hannes@cmpxchg.org>
CC:     <corbet@lwn.net>, <mcgrof@kernel.org>, <mgorman@suse.de>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <osalvador@suse.de>, <surenb@google.com>, <mawupeng1@huawei.com>,
        <rppt@kernel.org>, <charante@codeaurora.org>, <jsavitz@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH -next v3 1/2] mm: Cap zone movable's min wmark to small value
Date:   Mon, 5 Sep 2022 11:28:57 +0800
Message-ID: <20220905032858.1462927-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905032858.1462927-1-mawupeng1@huawei.com>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Since min_free_kbytes is based on gfp_zone(GFP_USER) which does not include
zone movable. However zone movable will get its min share in
__setup_per_zone_wmarks() which does not make any sense.

And like highmem pages, __GFP_HIGH and PF_MEMALLOC allocations usually
don't need movable pages, so there is no need to assign min pages for zone
movable.

Let's cap pages_min for zone movable to a small value here just link
highmem pages.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..f1e4474879f1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8636,9 +8636,9 @@ static void __setup_per_zone_wmarks(void)
 	struct zone *zone;
 	unsigned long flags;
 
-	/* Calculate total number of !ZONE_HIGHMEM pages */
+	/* Calculate total number of none highmem/movable pages */
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
+		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
 			lowmem_pages += zone_managed_pages(zone);
 	}
 
@@ -8648,15 +8648,15 @@ static void __setup_per_zone_wmarks(void)
 		spin_lock_irqsave(&zone->lock, flags);
 		tmp = (u64)pages_min * zone_managed_pages(zone);
 		do_div(tmp, lowmem_pages);
-		if (is_highmem(zone)) {
+		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
-			 * need highmem pages, so cap pages_min to a small
-			 * value here.
+			 * need highmem/movable pages, so cap pages_min to a
+			 * small value here.
 			 *
 			 * The WMARK_HIGH-WMARK_LOW and (WMARK_LOW-WMARK_MIN)
 			 * deltas control async page reclaim, and so should
-			 * not be capped for highmem.
+			 * not be capped for highmem/movable zone.
 			 */
 			unsigned long min_pages;
 
-- 
2.25.1

