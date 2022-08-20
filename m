Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937E359AAE9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 05:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiHTDTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 23:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244019AbiHTDTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 23:19:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12E356BA4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:19:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M8kMn0dGyzGpfF;
        Sat, 20 Aug 2022 11:17:57 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 20 Aug 2022 11:19:32 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 20 Aug 2022 11:19:31 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Qian Cai <cai@lca.pw>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: fix pgdat->kswap accessed concurrently
Date:   Sat, 20 Aug 2022 11:25:06 +0800
Message-ID: <20220820032506.126860-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
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

The pgdat->kswap could be accessed concurrently by kswapd_run() and
kcompactd(), it don't be protected by any lock, which leads to the
following null-ptr-deref,

  vmscan: Failed to start kswapd on node 0
  ...
  BUG: KASAN: null-ptr-deref in kcompactd+0x440/0x504
  Read of size 8 at addr 0000000000000024 by task kcompactd0/37

  CPU: 0 PID: 37 Comm: kcompactd0 Kdump: loaded Tainted: G           OE     5.10.60 #1
  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
  Call trace:
   dump_backtrace+0x0/0x394
   show_stack+0x34/0x4c
   dump_stack+0x158/0x1e4
   __kasan_report+0x138/0x140
   kasan_report+0x44/0xdc
   __asan_load8+0x94/0xd0
   kcompactd+0x440/0x504
   kthread+0x1a4/0x1f0
   ret_from_fork+0x10/0x18

Fix it by adding READ_ONCE()|WRITE_ONCE().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/compaction.c |  4 +++-
 mm/vmscan.c     | 15 +++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

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
index b2b1431352dc..9abba714249e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4642,16 +4642,19 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 void kswapd_run(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
+	struct task_struct *t;
 
-	if (pgdat->kswapd)
+	if (READ_ONCE(pgdat->kswapd))
 		return;
 
-	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
-	if (IS_ERR(pgdat->kswapd)) {
+	t = kthread_run(kswapd, pgdat, "kswapd%d", nid);
+	if (IS_ERR(t)) {
 		/* failure at boot is fatal */
 		BUG_ON(system_state < SYSTEM_RUNNING);
 		pr_err("Failed to start kswapd on node %d\n", nid);
-		pgdat->kswapd = NULL;
+		WRITE_ONCE(pgdat->kswapd, NULL);
+	} else {
+		WRITE_ONCE(pgdat->kswapd, t);
 	}
 }
 
@@ -4661,11 +4664,11 @@ void kswapd_run(int nid)
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

