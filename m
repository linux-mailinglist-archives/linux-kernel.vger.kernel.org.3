Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F1659F40B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiHXHOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiHXHN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:13:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25949412D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:13:54 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCHMT6TTxznTbG;
        Wed, 24 Aug 2022 15:11:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 15:13:52 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 15:13:52 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <muchun.song@linux.dev>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] mm: slince possible data races about pgdat->kswapd
Date:   Wed, 24 Aug 2022 15:19:09 +0800
Message-ID: <20220824071909.192535-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
References: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pgdat->kswapd could be accessed concurrently by kswapd_run() and
kcompactd(), it don't be protected by any lock, which could leads to
data races, adding READ/WRITE_ONCE() to slince it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/compaction.c | 4 +++-
 mm/vmscan.c     | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 640fa76228dd..aa1cfe47f046 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1983,7 +1983,9 @@ static inline bool is_via_compact_memory(int order)
 
 static bool kswapd_is_running(pg_data_t *pgdat)
 {
-	return pgdat->kswapd && task_is_running(pgdat->kswapd);
+	struct task_struct *t = READ_ONCE(pgdat->kswapd);
+
+	return t && task_is_running(t);
 }
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 08c6497f76c3..65b19ca8c8ee 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4644,7 +4644,7 @@ void kswapd_run(int nid)
 	pg_data_t *pgdat = NODE_DATA(nid);
 	struct task_struct *t;
 
-	if (pgdat->kswapd)
+	if (READ_ONCE(pgdat->kswapd))
 		return;
 
 	t = kthread_run(kswapd, pgdat, "kswapd%d", nid);
@@ -4653,7 +4653,7 @@ void kswapd_run(int nid)
 		BUG_ON(system_state < SYSTEM_RUNNING);
 		pr_err("Failed to start kswapd on node %d\n", nid);
 	} else {
-		pgdat->kswapd = t;
+		WRITE_ONCE(pgdat->kswapd, t);
 	}
 }
 
@@ -4663,11 +4663,11 @@ void kswapd_run(int nid)
  */
 void kswapd_stop(int nid)
 {
-	struct task_struct *kswapd = NODE_DATA(nid)->kswapd;
+	struct task_struct *kswapd = READ_ONCE(NODE_DATA(nid)->kswapd);
 
 	if (kswapd) {
 		kthread_stop(kswapd);
-		NODE_DATA(nid)->kswapd = NULL;
+		WRITE_ONCE(NODE_DATA(nid)->kswapd, NULL);
 	}
 }
 
-- 
2.35.3

