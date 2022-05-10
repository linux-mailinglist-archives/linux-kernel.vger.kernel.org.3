Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97212521394
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiEJLYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbiEJLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:24:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4544D1868CB;
        Tue, 10 May 2022 04:20:28 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KyFqg38W9z6GD8s;
        Tue, 10 May 2022 19:17:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 13:20:26 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 12:20:24 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 2/2] sbitmap: Spread sbitmap word allocation over NUMA nodes
Date:   Tue, 10 May 2022 19:14:34 +0800
Message-ID: <1652181274-136198-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sbitmap words are allocated in a single array. That array is
flagged for allocating at the NUMA node passed in sbitmap_init_node().

However often the sbitmap will be accessed by all the CPUs in the system -
for example, when BLK_MQ_F_TAG_HCTX_SHARED is set for the blk-mq tagset.

This can lead to performance issues where all CPUs in the system are doing
cross-NUMA node accesses to read/set/unset sbitmap tags.

Improve this by spreading the word allocations across all NUMA nodes as
evenly as possible. We set the per-CPU hint to fall within range of words
allocated for the NUMA node to which that CPU belongs.

Known issues:
- sbitmap resize does not work well for this scheme
- Improve updating hint for sbitmap_get() failure and sbitmap_put() when
  hint is outside range of CPU's NUMA node words.
- Add intelligence for sub-arrays to be allocated at a single node, e.g.
  when numa != NUMA_NO_NODE in sbitmap_init_node()

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/sbitmap.h |  5 ++++
 lib/sbitmap.c           | 63 +++++++++++++++++++++++++++++++++--------
 2 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 46268f391e32..6d897032dbc6 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -60,6 +60,11 @@ struct sbitmap {
 	 */
 	unsigned int map_nr;
 
+	/**
+	 * @map_nr_per_node: Number of words being used per NUMA node.
+	 */
+	unsigned int map_nr_per_node;
+
 	/**
 	 * @round_robin: Allocate bits in strict round-robin order.
 	 */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 64fb9800ed8c..99c87fbfa1a1 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -8,6 +8,17 @@
 #include <linux/random.h>
 #include <linux/sbitmap.h>
 #include <linux/seq_file.h>
+#include <linux/mm.h>
+
+static unsigned int sbitmap_get_new_hint(struct sbitmap *sb, int cpu)
+{
+	unsigned int shift = sb->shift;
+	unsigned int map_nr_per_node = sb->map_nr_per_node;
+	unsigned int bit_per_node = map_nr_per_node << shift;
+	unsigned int hint_base = bit_per_node * cpu_to_node(cpu);
+
+	return hint_base + (prandom_u32() % bit_per_node);
+}
 
 static int init_alloc_hint(struct sbitmap *sb, gfp_t flags)
 {
@@ -20,8 +31,10 @@ static int init_alloc_hint(struct sbitmap *sb, gfp_t flags)
 	if (depth && !sb->round_robin) {
 		int i;
 
-		for_each_possible_cpu(i)
-			*per_cpu_ptr(sb->alloc_hint, i) = prandom_u32() % depth;
+		for_each_possible_cpu(i) {
+			*per_cpu_ptr(sb->alloc_hint, i) =
+				sbitmap_get_new_hint(sb, i);
+		}
 	}
 	return 0;
 }
@@ -86,7 +99,8 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 {
 	unsigned int bits_per_word;
 	struct sbitmap_word *map;
-	int index;
+	int index, num_nodes = num_online_nodes();
+	int nid, map_nr_cnt;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -105,6 +119,11 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return 0;
 	}
 
+	if (sb->map_nr < num_nodes) {
+		sb->map_nr_per_node = 1;
+	} else {
+		sb->map_nr_per_node = sb->map_nr / num_nodes;
+	}
 	if (alloc_hint) {
 		if (init_alloc_hint(sb, flags))
 			return -ENOMEM;
@@ -113,23 +132,43 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	}
 
 	sb->map = kvzalloc_node(sb->map_nr * sizeof(*sb->map), flags, node);
-	if (!sb->map) {
-		free_percpu(sb->alloc_hint);
-		return -ENOMEM;
-	}
-
-	map = kvzalloc_node(sb->map_nr * sizeof(**sb->map), flags, node);
-	if (!map)
-		return -ENOMEM;
+	if (!sb->map)
+		goto err_map;
 
-	for (index = 0; index < sb->map_nr; index++, map++) {
+	for (index = 0, nid = 0; index < sb->map_nr; index++, map++, map_nr_cnt++) {
 		struct sbitmap_word **_map;
 
+		if ((index % sb->map_nr_per_node) == 0) {
+			int cnt;
+
+			if (index == 0) {
+				cnt = sb->map_nr_per_node +
+					(sb->map_nr % sb->map_nr_per_node);
+			} else {
+				cnt = sb->map_nr_per_node;
+			}
+
+			map = kvzalloc_node(cnt * sizeof(**sb->map), flags, nid);
+			if (!map)
+				goto err_map_numa;
+			nid++;
+		}
+
 		_map = &sb->map[index];
 		*_map = map;
 	}
 
 	return 0;
+err_map_numa:
+	for (index = 0; index < sb->map_nr; index++, map++) {
+		if ((index % sb->map_nr_per_node) == 0) {
+			kfree(map);
+		}
+	}
+err_map:
+	free_percpu(sb->alloc_hint);
+
+	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
 
-- 
2.26.2

