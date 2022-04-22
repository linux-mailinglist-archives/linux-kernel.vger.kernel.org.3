Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71350C192
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiDVV4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiDVV4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:56:25 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973EE401D0D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650659228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzvvA3SXvofoJHZNbBulanDIE6i4rnzYjcD9jlw7cIA=;
        b=GFmSUQ7JMC5moOfjvZm0NWOsGAlKDYtQtWqshJGzeO5UVZz/OWtiLdmHuNNDebpqnSOXYm
        JOoiVw2QcazLuSKW9FD0nlqmQ4HT+ZQD442LkCfTe0gq8yoyD0HMdTxEx/UUP0mFvbXNOO
        SZLLTJfrzNz19c293hDJ/ulc2MQOWhY=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 4/7] mm: introduce numa interfaces for shrinker debugfs
Date:   Fri, 22 Apr 2022 13:26:41 -0700
Message-Id: <20220422202644.799732-5-roman.gushchin@linux.dev>
In-Reply-To: <20220422202644.799732-1-roman.gushchin@linux.dev>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces "count_node", "scan_node", "count_memcg_node"
and "scan_memcg_node" interfaces for numa-aware and numa- and
memcg-aware shrinkers.

Usage examples:
1) Get per-node and per-memcg per-node counts:
  $ cat count_node
    209 3
  $ cat count_memcg_node
    1 209 3
    20 96 0
    53 810 7
    2297 2 0
    218 13 0
    581 30 0
    911 124 0
    <CUT>

2) Scan individual node:
  $ echo "1 200" > scan_node
  $ cat scan_node
    2

3) Scan individual memcg and node:
  $ echo "1868 0 500" > scan_memcg_node
  $ cat scan_memcg_node
    435

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/shrinker_debug.c | 200 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 002d44d6ad56..81350b64bf01 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -222,6 +222,185 @@ static const struct file_operations shrinker_debugfs_scan_memcg_fops = {
 };
 #endif
 
+#ifdef CONFIG_NUMA
+static int shrinker_debugfs_count_node_show(struct seq_file *m, void *v)
+{
+	struct shrinker *shrinker = (struct shrinker *)m->private;
+	unsigned long nr;
+	int ret, nid;
+
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret)
+		return ret;
+
+	for_each_node(nid) {
+		struct shrink_control sc = {
+			.gfp_mask = GFP_KERNEL,
+			.nid = nid,
+		};
+
+		nr = shrinker->count_objects(shrinker, &sc);
+		if (nr == SHRINK_EMPTY)
+			nr = 0;
+
+		seq_printf(m, "%s%lu", nid ? " " : "", nr);
+		cond_resched();
+	}
+	up_read(&shrinker_rwsem);
+	seq_puts(m, "\n");
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count_node);
+
+static ssize_t shrinker_debugfs_scan_node_write(struct file *file,
+						const char __user *buf,
+						size_t size, loff_t *pos)
+{
+	struct shrinker *shrinker = (struct shrinker *)file->private_data;
+	unsigned long nr_to_scan = 0;
+	int nid;
+	struct shrink_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
+	char kbuf[48];
+	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
+	ssize_t ret;
+
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EFAULT;
+	kbuf[read_len] = '\0';
+
+	if (sscanf(kbuf, "%d %lu", &nid, &nr_to_scan) < 2)
+		return -EINVAL;
+
+	if (nid < 0 || nid >= nr_node_ids)
+		return -EINVAL;
+
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret)
+		return ret;
+
+	sc.nid = nid;
+	sc.nr_to_scan = nr_to_scan;
+	sc.nr_scanned = nr_to_scan;
+
+	shrinker->scan_objects(shrinker, &sc);
+
+	up_read(&shrinker_rwsem);
+
+	return ret ? ret : size;
+}
+
+static const struct file_operations shrinker_debugfs_scan_node_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = shrinker_debugfs_scan_open,
+	.write	 = shrinker_debugfs_scan_node_write,
+};
+
+#ifdef CONFIG_MEMCG
+static int shrinker_debugfs_count_memcg_node_show(struct seq_file *m, void *v)
+{
+	struct shrinker *shrinker = (struct shrinker *)m->private;
+	unsigned long *count_per_node = NULL;
+	struct mem_cgroup *memcg;
+	unsigned long total;
+	int ret, nid;
+
+	count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
+	if (!count_per_node)
+		return -ENOMEM;
+
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret) {
+		kfree(count_per_node);
+		return ret;
+	}
+	rcu_read_lock();
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		if (!mem_cgroup_online(memcg))
+			continue;
+
+		total = shrinker_count_objects(shrinker, memcg, count_per_node);
+		if (!total)
+			continue;
+
+		seq_printf(m, "%lu", mem_cgroup_ino(memcg));
+		for_each_node(nid)
+			seq_printf(m, " %lu", count_per_node[nid]);
+		seq_puts(m, "\n");
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+
+	rcu_read_unlock();
+	up_read(&shrinker_rwsem);
+
+	kfree(count_per_node);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count_memcg_node);
+
+static ssize_t shrinker_debugfs_scan_memcg_node_write(struct file *file,
+						      const char __user *buf,
+						      size_t size, loff_t *pos)
+{
+	struct shrinker *shrinker = (struct shrinker *)file->private_data;
+	unsigned long nr_to_scan = 0, ino;
+	struct shrink_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
+	struct mem_cgroup *memcg;
+	int nid;
+	char kbuf[72];
+	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
+	ssize_t ret;
+
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EFAULT;
+	kbuf[read_len] = '\0';
+
+	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)
+		return -EINVAL;
+
+	if (nid < 0 || nid >= nr_node_ids)
+		return -EINVAL;
+
+	memcg = mem_cgroup_get_from_ino(ino);
+	if (!memcg || IS_ERR(memcg))
+		return -ENOENT;
+
+	if (!mem_cgroup_online(memcg)) {
+		mem_cgroup_put(memcg);
+		return -ENOENT;
+	}
+
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret) {
+		mem_cgroup_put(memcg);
+		return ret;
+	}
+
+	sc.nid = nid;
+	sc.memcg = memcg;
+	sc.nr_to_scan = nr_to_scan;
+	sc.nr_scanned = nr_to_scan;
+
+	shrinker->scan_objects(shrinker, &sc);
+
+	up_read(&shrinker_rwsem);
+	mem_cgroup_put(memcg);
+
+	return ret ? ret : size;
+}
+
+static const struct file_operations shrinker_debugfs_scan_memcg_node_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = shrinker_debugfs_scan_open,
+	.write	 = shrinker_debugfs_scan_memcg_node_write,
+};
+#endif /* CONFIG_MEMCG */
+#endif /* CONFIG_NUMA */
+
 int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	struct dentry *entry;
@@ -265,6 +444,27 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	}
 #endif
 
+#ifdef CONFIG_NUMA
+	/* create numa and memcg/numa interfaces */
+	if ((shrinker->flags & SHRINKER_NUMA_AWARE) && nr_node_ids > 1) {
+		debugfs_create_file("count_node", 0220, entry, shrinker,
+				    &shrinker_debugfs_count_node_fops);
+		debugfs_create_file("scan_node", 0440, entry, shrinker,
+				    &shrinker_debugfs_scan_node_fops);
+
+#ifdef CONFIG_MEMCG
+		if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+			debugfs_create_file("count_memcg_node", 0220, entry,
+					    shrinker,
+					    &shrinker_debugfs_count_memcg_node_fops);
+			debugfs_create_file("scan_memcg_node", 0440, entry,
+					    shrinker,
+					    &shrinker_debugfs_scan_memcg_node_fops);
+		}
+#endif /* CONFIG_MEMCG */
+	}
+#endif /* CONFIG_NUMA */
+
 	return 0;
 }
 
-- 
2.35.1

