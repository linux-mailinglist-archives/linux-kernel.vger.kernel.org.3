Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A2559F40A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbiHXHOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiHXHN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:13:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A023294129
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:13:54 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCHMT411cznTXf;
        Wed, 24 Aug 2022 15:11:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
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
Subject: [PATCH 1/2] mm: fix null-ptr-deref in kswapd_is_running()
Date:   Wed, 24 Aug 2022 15:19:08 +0800
Message-ID: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
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

The kswapd_run/stop() will set pgdat->kswapd to NULL, which
could race with kswapd_is_running() in kcompactd(),

kswapd_run/stop()	kcompactd()
			  kswapd_is_running()
				if (pgdat->kswapd) // load non-NULL pgdat->kswapd
  pgdat->kswapd = NULL
				task_is_running(pgdat->kswapd) // Null pointer derefence

The KASAN report the null-ptr-deref shown below,

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

For race between kswapd_run() and kcompactd(), adding a temporary value
when create a kthread, and only set it to pgdat->kswapd if kthread_run()
return successful task_struct to fix the issue.

For race between kswapd_stop() and kcompactd(), let's call kcompactd_stop()
before kswapd_stop() to fix the issue.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory_hotplug.c | 2 +-
 mm/vmscan.c         | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fad6d1f2262a..2fd45ccbce45 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1940,8 +1940,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	node_states_clear_node(node, &arg);
 	if (arg.status_change_nid >= 0) {
-		kswapd_stop(node);
 		kcompactd_stop(node);
+		kswapd_stop(node);
 	}
 
 	writeback_set_ratelimit();
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2b1431352dc..08c6497f76c3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4642,16 +4642,18 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 void kswapd_run(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
+	struct task_struct *t;
 
 	if (pgdat->kswapd)
 		return;
 
-	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
-	if (IS_ERR(pgdat->kswapd)) {
+	t = kthread_run(kswapd, pgdat, "kswapd%d", nid);
+	if (IS_ERR(t)) {
 		/* failure at boot is fatal */
 		BUG_ON(system_state < SYSTEM_RUNNING);
 		pr_err("Failed to start kswapd on node %d\n", nid);
-		pgdat->kswapd = NULL;
+	} else {
+		pgdat->kswapd = t;
 	}
 }
 
-- 
2.35.3

