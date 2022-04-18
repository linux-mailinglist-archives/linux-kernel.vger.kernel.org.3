Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC0505ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbiDRPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243746AbiDRPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A0B918F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KhplQ4z6qzfYx6;
        Mon, 18 Apr 2022 22:11:46 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 05/12] mm: compaction: clean up comment about suitable migration target recheck
Date:   Mon, 18 Apr 2022 22:12:46 +0800
Message-ID: <20220418141253.24298-6-linmiaohe@huawei.com>
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

checked_pageblock is already removed and suitable_migration_target is not
rechecked under the zone lock since commit f8224aa5a0a4 ("mm, compaction:
do not recheck suitable_migration_target under lock"). Correct the comment
accordingly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/compaction.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e839b26fb3d8..97821b7d7a4f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -599,13 +599,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		if (!PageBuddy(page))
 			goto isolate_fail;
 
-		/*
-		 * If we already hold the lock, we can skip some rechecking.
-		 * Note that if we hold the lock now, checked_pageblock was
-		 * already set in some previous iteration (or strict is true),
-		 * so it is correct to skip the suitable migration target
-		 * recheck as well.
-		 */
+		/* If we already hold the lock, we can skip some rechecking. */
 		if (!locked) {
 			locked = compact_lock_irqsave(&cc->zone->lock,
 								&flags, cc);
-- 
2.23.0

