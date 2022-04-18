Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE015505ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbiDRPRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbiDRPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAC3B919C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KhplS13JczfYy1;
        Mon, 18 Apr 2022 22:11:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 08/12] mm: compaction: clean up comment about async compaction in isolate_migratepages
Date:   Mon, 18 Apr 2022 22:12:49 +0800
Message-ID: <20220418141253.24298-9-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220418141253.24298-1-linmiaohe@huawei.com>
References: <20220418141253.24298-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Since commit 282722b0d258 ("mm, compaction: restrict async compaction to
pageblocks of same migratetype"), async direct compaction is restricted to
scan the pageblocks of same migratetype. Correct the comment accordingly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/compaction.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 55013a2af817..562f274b2c51 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1941,12 +1941,12 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 			continue;
 
 		/*
-		 * For async compaction, also only scan in MOVABLE blocks
-		 * without huge pages. Async compaction is optimistic to see
-		 * if the minimum amount of work satisfies the allocation.
-		 * The cached PFN is updated as it's possible that all
-		 * remaining blocks between source and target are unsuitable
-		 * and the compaction scanners fail to meet.
+		 * For async direct compaction, only scan the pageblocks of the
+		 * same migratetype without huge pages. Async direct compaction
+		 * is optimistic to see if the minimum amount of work satisfies
+		 * the allocation. The cached PFN is updated as it's possible
+		 * that all remaining blocks between source and target are
+		 * unsuitable and the compaction scanners fail to meet.
 		 */
 		if (!suitable_migration_source(cc, page)) {
 			update_cached_migrate(cc, block_end_pfn);
-- 
2.23.0

