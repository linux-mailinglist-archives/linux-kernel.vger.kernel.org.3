Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDDD5A3738
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiH0LPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241751AbiH0LOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:14:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054421104
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:14:52 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MFDZq5jG5zGpsR;
        Sat, 27 Aug 2022 19:13:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 19:14:50 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 19:14:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v2] mm: fix null-ptr-deref in kswapd_is_running()
Date:   Sat, 27 Aug 2022 19:19:59 +0800
Message-ID: <20220827111959.186838-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

kswapd_run/stop()                       kcompactd()
                                          kswapd_is_running()
  pgdat->kswapd // error or nomal ptr
                                          verify pgdat->kswapd
                                            // load non-NULL
pgdat->kswapd
  pgdat->kswapd = NULL
                                          task_is_running(pgdat->kswapd)
                                            // Null pointer derefence

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

For now, kswapd/kcompactd_run() and kswapd/kcompactd_stop() protected
by mem_hotplug_begin/done(), but without kcompactd(). It is no need to
involve memory hotplug lock in kcompactd(), so let's add new mutex to
protect pgdat->kswapd accessed concurrently, also because kcompactd task
will check the state of kswapd task, it's better to call kcompactd_stop()
before kswapd_stop() to reduce lock conflicts.

Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: add new lock to protect pgdat->kswapd, suggested by David Hildenbrand

 include/linux/memory_hotplug.h | 19 +++++++++++++++++++
 include/linux/mmzone.h         |  6 ++++--
 mm/compaction.c                |  8 +++++++-
 mm/memory_hotplug.c            |  2 +-
 mm/page_alloc.c                |  1 +
 mm/vmscan.c                    | 27 ++++++++++++++++-----------
 6 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e0b2209ab71c..409196ef8038 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -216,6 +216,21 @@ void put_online_mems(void);
 void mem_hotplug_begin(void);
 void mem_hotplug_done(void);
 
+static inline void pgdat_kswapd_lock(pg_data_t *pgdat)
+{
+	mutex_lock(&pgdat->kswapd_lock);
+}
+
+static inline void pgdat_kswapd_unlock(pg_data_t *pgdat)
+{
+	mutex_unlock(&pgdat->kswapd_lock);
+}
+
+static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat)
+{
+	mutex_init(&pgdat->kswapd_lock);
+}
+
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 #define pfn_to_online_page(pfn)			\
 ({						\
@@ -252,6 +267,10 @@ static inline bool movable_node_is_enabled(void)
 {
 	return false;
 }
+
+static inline void pgdat_kswapd_lock(pg_data_t *pgdat) {}
+static inline void pgdat_kswapd_unlock(pg_data_t *pgdat) {}
+static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
 #endif /* ! CONFIG_MEMORY_HOTPLUG */
 
 /*
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 14919b2fb5f5..9e2317659520 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1165,8 +1165,10 @@ typedef struct pglist_data {
 	atomic_t nr_writeback_throttled;/* nr of writeback-throttled tasks */
 	unsigned long nr_reclaim_start;	/* nr pages written while throttled
 					 * when throttling started. */
-	struct task_struct *kswapd;	/* Protected by
-					   mem_hotplug_begin/done() */
+#ifdef CONFIG_MEMORY_HOTPLUG
+	struct mutex kswapd_lock;
+#endif
+	struct task_struct *kswapd;	/* Protected by kswapd_lock */
 	int kswapd_order;
 	enum zone_type kswapd_highest_zoneidx;
 
diff --git a/mm/compaction.c b/mm/compaction.c
index eb2de3c06ce0..6e9dd600ba4e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1982,7 +1982,13 @@ static inline bool is_via_compact_memory(int order)
 
 static bool kswapd_is_running(pg_data_t *pgdat)
 {
-	return pgdat->kswapd && task_is_running(pgdat->kswapd);
+	bool running;
+
+	pgdat_kswapd_lock(pgdat);
+	running = pgdat->kswapd && task_is_running(pgdat->kswapd);
+	pgdat_kswapd_unlock(pgdat);
+
+	return running;
 }
 
 /*
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 045543fa310e..4e91b1753f00 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7619,6 +7619,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	int i;
 
 	pgdat_resize_init(pgdat);
+	pgdat_kswapd_lock_init(pgdat);
 
 	pgdat_init_split_queue(pgdat);
 	pgdat_init_kcompactd(pgdat);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 27a3f29c0181..f30ab03df2ba 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7425,16 +7425,17 @@ void kswapd_run(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 
-	if (pgdat->kswapd)
-		return;
-
-	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
-	if (IS_ERR(pgdat->kswapd)) {
-		/* failure at boot is fatal */
-		BUG_ON(system_state < SYSTEM_RUNNING);
-		pr_err("Failed to start kswapd on node %d\n", nid);
-		pgdat->kswapd = NULL;
+	pgdat_kswapd_lock(pgdat);
+	if (!pgdat->kswapd) {
+		pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
+		if (IS_ERR(pgdat->kswapd)) {
+			/* failure at boot is fatal */
+			BUG_ON(system_state < SYSTEM_RUNNING);
+			pr_err("Failed to start kswapd on node %d\n", nid);
+			pgdat->kswapd = NULL;
+		}
 	}
+	pgdat_kswapd_unlock(pgdat);
 }
 
 /*
@@ -7443,12 +7444,16 @@ void kswapd_run(int nid)
  */
 void kswapd_stop(int nid)
 {
-	struct task_struct *kswapd = NODE_DATA(nid)->kswapd;
+	pg_data_t *pgdat = NODE_DATA(nid);
+	struct task_struct *kswapd;
 
+	pgdat_kswapd_lock(pgdat);
+	kswapd = pgdat->kswapd;
 	if (kswapd) {
 		kthread_stop(kswapd);
-		NODE_DATA(nid)->kswapd = NULL;
+		pgdat->kswapd = NULL;
 	}
+	pgdat_kswapd_unlock(pgdat);
 }
 
 static int __init kswapd_init(void)
-- 
2.35.3

