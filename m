Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607C505AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbiDRPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbiDRPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A5B9190
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Khpm846fxzhXWx;
        Mon, 18 Apr 2022 22:12:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 06/12] mm: compaction: use COMPACT_CLUSTER_MAX in compaction.c
Date:   Mon, 18 Apr 2022 22:12:47 +0800
Message-ID: <20220418141253.24298-7-linmiaohe@huawei.com>
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

Always use COMPACT_CLUSTER_MAX here as we're doing the compaction.
Minor improvements in readability.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/compaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 97821b7d7a4f..1fc912ec3a98 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -573,7 +573,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		 * contention, to give chance to IRQs. Abort if fatal signal
 		 * pending.
 		 */
-		if (!(blockpfn % SWAP_CLUSTER_MAX)
+		if (!(blockpfn % COMPACT_CLUSTER_MAX)
 		    && compact_unlock_should_abort(&cc->zone->lock, flags,
 								&locked, cc))
 			break;
@@ -862,7 +862,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * contention, to give chance to IRQs. Abort completely if
 		 * a fatal signal is pending.
 		 */
-		if (!(low_pfn % SWAP_CLUSTER_MAX)) {
+		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
 			if (locked) {
 				unlock_page_lruvec_irqrestore(locked, flags);
 				locked = NULL;
@@ -1614,7 +1614,7 @@ static void isolate_freepages(struct compact_control *cc)
 		 * This can iterate a massively long zone without finding any
 		 * suitable migration targets, so periodically check resched.
 		 */
-		if (!(block_start_pfn % (SWAP_CLUSTER_MAX * pageblock_nr_pages)))
+		if (!(block_start_pfn % (COMPACT_CLUSTER_MAX * pageblock_nr_pages)))
 			cond_resched();
 
 		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
@@ -1921,7 +1921,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		 * many pageblocks unsuitable, so periodically check if we
 		 * need to schedule.
 		 */
-		if (!(low_pfn % (SWAP_CLUSTER_MAX * pageblock_nr_pages)))
+		if (!(low_pfn % (COMPACT_CLUSTER_MAX * pageblock_nr_pages)))
 			cond_resched();
 
 		page = pageblock_pfn_to_page(block_start_pfn,
-- 
2.23.0

