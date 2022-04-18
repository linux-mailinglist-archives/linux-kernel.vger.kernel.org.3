Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FAD505AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbiDRPRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiDRPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D0B89BB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KhpjL273FzFppB;
        Mon, 18 Apr 2022 22:09:58 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 01/12] mm: compaction: remove unneeded return value of kcompactd_run
Date:   Mon, 18 Apr 2022 22:12:42 +0800
Message-ID: <20220418141253.24298-2-linmiaohe@huawei.com>
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

The return value of kcompactd_run() is unused now.  Clean it up.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/compaction.h | 5 ++---
 mm/compaction.c            | 7 ++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 34bce35c808d..52a9ff65faee 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -177,7 +177,7 @@ static inline bool compaction_withdrawn(enum compact_result result)
 bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 					int alloc_flags);
 
-extern int kcompactd_run(int nid);
+extern void kcompactd_run(int nid);
 extern void kcompactd_stop(int nid);
 extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
 
@@ -212,9 +212,8 @@ static inline bool compaction_withdrawn(enum compact_result result)
 	return true;
 }
 
-static inline int kcompactd_run(int nid)
+static inline void kcompactd_run(int nid)
 {
-	return 0;
 }
 static inline void kcompactd_stop(int nid)
 {
diff --git a/mm/compaction.c b/mm/compaction.c
index baf654b5e073..2e838992b324 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3016,21 +3016,18 @@ static int kcompactd(void *p)
  * This kcompactd start function will be called by init and node-hot-add.
  * On node-hot-add, kcompactd will moved to proper cpus if cpus are hot-added.
  */
-int kcompactd_run(int nid)
+void kcompactd_run(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
-	int ret = 0;
 
 	if (pgdat->kcompactd)
-		return 0;
+		return;
 
 	pgdat->kcompactd = kthread_run(kcompactd, pgdat, "kcompactd%d", nid);
 	if (IS_ERR(pgdat->kcompactd)) {
 		pr_err("Failed to start kcompactd on node %d\n", nid);
-		ret = PTR_ERR(pgdat->kcompactd);
 		pgdat->kcompactd = NULL;
 	}
-	return ret;
 }
 
 /*
-- 
2.23.0

