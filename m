Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE653505AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiDRPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiDRPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153D738BE1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KhpmB73sszhXWg;
        Mon, 18 Apr 2022 22:12:26 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 11/12] mm: compaction: simplify the code in __compact_finished
Date:   Mon, 18 Apr 2022 22:12:52 +0800
Message-ID: <20220418141253.24298-12-linmiaohe@huawei.com>
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

Since commit efe771c7603b ("mm, compaction: always finish scanning of a
full pageblock"), compaction will always finish scanning a pageblock. And
migrate_pfn is assured to align with pageblock_nr_pages when we reach here.
So we will always return COMPACT_SUCCESS if a suitable fallback is found
due to the below IS_ALIGNED check of migrate_pfn. Simplify the code to make
this clear and improve the readability. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/compaction.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 334a573485fe..609a76d7e051 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2134,29 +2134,16 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 		 * other migratetype buddy lists.
 		 */
 		if (find_suitable_fallback(area, order, migratetype,
-						true, &can_steal) != -1) {
-
-			/* movable pages are OK in any pageblock */
-			if (migratetype == MIGRATE_MOVABLE)
-				return COMPACT_SUCCESS;
-
+						true, &can_steal) != -1)
 			/*
-			 * We are stealing for a non-movable allocation. Make
-			 * sure we finish compacting the current pageblock
-			 * first so it is as free as possible and we won't
-			 * have to steal another one soon. This only applies
-			 * to sync compaction, as async compaction operates
-			 * on pageblocks of the same migratetype.
+			 * Movable pages are OK in any pageblock. If we are
+			 * stealing for a non-movable allocation, make sure
+			 * we finish compacting the current pageblock first
+			 * (which is assured by the above migrate_pfn align
+			 * check) so it is as free as possible and we won't
+			 * have to steal another one soon.
 			 */
-			if (cc->mode == MIGRATE_ASYNC ||
-					IS_ALIGNED(cc->migrate_pfn,
-							pageblock_nr_pages)) {
-				return COMPACT_SUCCESS;
-			}
-
-			ret = COMPACT_CONTINUE;
-			break;
-		}
+			return COMPACT_SUCCESS;
 	}
 
 out:
-- 
2.23.0

