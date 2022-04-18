Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48114505AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiDRPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbiDRPPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C212BB9186
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KhpjM4t6MzFplq;
        Mon, 18 Apr 2022 22:09:59 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 04/12] mm: compaction: clean up comment for sched contention
Date:   Mon, 18 Apr 2022 22:12:45 +0800
Message-ID: <20220418141253.24298-5-linmiaohe@huawei.com>
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

Since commit cf66f0700c8f ("mm, compaction: do not consider a need to
reschedule as contention"), async compaction won't abort when scheduling
is needed. Correct the relevant comment accordingly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/compaction.c | 11 ++++-------
 mm/internal.h   |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ee2ddf77191f..e839b26fb3d8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -513,15 +513,12 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
  * very heavily contended. The lock should be periodically unlocked to avoid
  * having disabled IRQs for a long time, even when there is nobody waiting on
  * the lock. It might also be that allowing the IRQs will result in
- * need_resched() becoming true. If scheduling is needed, async compaction
- * aborts. Sync compaction schedules.
+ * need_resched() becoming true. If scheduling is needed, compaction schedules.
  * Either compaction type will also abort if a fatal signal is pending.
  * In either case if the lock was locked, it is dropped and not regained.
  *
- * Returns true if compaction should abort due to fatal signal pending, or
- *		async compaction due to need_resched()
- * Returns false when compaction can continue (sync compaction might have
- *		scheduled)
+ * Returns true if compaction should abort due to fatal signal pending.
+ * Returns false when compaction can continue.
  */
 static bool compact_unlock_should_abort(spinlock_t *lock,
 		unsigned long flags, bool *locked, struct compact_control *cc)
@@ -574,7 +571,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		/*
 		 * Periodically drop the lock (if held) regardless of its
 		 * contention, to give chance to IRQs. Abort if fatal signal
-		 * pending or async compaction detects need_resched()
+		 * pending.
 		 */
 		if (!(blockpfn % SWAP_CLUSTER_MAX)
 		    && compact_unlock_should_abort(&cc->zone->lock, flags,
diff --git a/mm/internal.h b/mm/internal.h
index 48eb2d24fcd2..70cc61af06de 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -403,7 +403,7 @@ struct compact_control {
 	bool direct_compaction;		/* False from kcompactd or /proc/... */
 	bool proactive_compaction;	/* kcompactd proactive compaction */
 	bool whole_zone;		/* Whole zone should/has been scanned */
-	bool contended;			/* Signal lock or sched contention */
+	bool contended;			/* Signal lock contention */
 	bool rescan;			/* Rescanning the same pageblock */
 	bool alloc_contig;		/* alloc_contig_range allocation */
 };
-- 
2.23.0

