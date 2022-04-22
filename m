Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E6950AD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443256AbiDVCCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443248AbiDVCCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:02:11 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C94A922
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:59:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650592748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVUES9M+BRrqRRSLg84CbnN5OMz4VRT3o7tg8BkXGPA=;
        b=Bgi/Cka/PsllPmJPhZipUVfhIBOKl29UgM2UqplAf96Uu/F5JYFQmiPZleCOM0PHM6FDXO
        XM3k6L00CKCUAzrDqXE4IYBOrUz9n+sdGEEdUhZhd7BXJyfGDcMJWdZXQm85PNTfFxoSsz
        ya8r4u4ZqydRGRDaP5rDWlKgFdlT5DQ=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 3/5] mm: introduce memcg interfaces for shrinker debugfs
Date:   Thu, 21 Apr 2022 18:58:51 -0700
Message-Id: <20220422015853.748291-4-roman.gushchin@linux.dev>
In-Reply-To: <20220422015853.748291-1-roman.gushchin@linux.dev>
References: <20220422015853.748291-1-roman.gushchin@linux.dev>
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

This commit introduces "count_memcg" and "scan_memcg" interfaces
for memcg-aware shrinkers.

Count_memcg using the following format:
<cgroup inode number1> <count2>
<cgroup inode number2> <count2>
...

Memory cgroups with 0 associated objects are skipped.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/shrinker_debug.c | 186 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 139 insertions(+), 47 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 4df7382a0737..002d44d6ad56 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/idr.h>
+#include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/shrinker.h>
+#include <linux/memcontrol.h>
 
 /* defined in vmscan.c */
 extern struct rw_semaphore shrinker_rwsem;
@@ -11,25 +13,25 @@ extern struct list_head shrinker_list;
 static DEFINE_IDA(shrinker_debugfs_ida);
 static struct dentry *shrinker_debugfs_root;
 
-static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
+static unsigned long shrinker_count_objects(struct shrinker *shrinker,
+					    struct mem_cgroup *memcg,
+					    unsigned long *count_per_node)
 {
-	struct shrinker *shrinker = (struct shrinker *)m->private;
 	unsigned long nr, total = 0;
-	int ret, nid;
-
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret)
-		return ret;
+	int nid;
 
 	for_each_node(nid) {
 		struct shrink_control sc = {
 			.gfp_mask = GFP_KERNEL,
 			.nid = nid,
+			.memcg = memcg,
 		};
 
 		nr = shrinker->count_objects(shrinker, &sc);
 		if (nr == SHRINK_EMPTY)
 			nr = 0;
+		if (count_per_node)
+			count_per_node[nid] = nr;
 		total += nr;
 
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
@@ -37,32 +39,17 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 
 		cond_resched();
 	}
-	up_read(&shrinker_rwsem);
-
-	seq_printf(m, "%lu\n", total);
 
-	return ret;
+	return total;
 }
-DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
 
-static ssize_t shrinker_debugfs_scan_write(struct file *file,
-					   const char __user *buf,
-					   size_t size, loff_t *pos)
+static int shrinker_scan_objects(struct shrinker *shrinker,
+				 struct mem_cgroup *memcg,
+				 unsigned long nr_to_scan)
 {
-	struct shrinker *shrinker = (struct shrinker *)file->private_data;
-	unsigned long nr, total = 0, nr_to_scan;
-	unsigned long *count_per_node = NULL;
-	int nid;
-	char kbuf[24];
-	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
-	ssize_t ret;
-
-	if (copy_from_user(kbuf, buf, read_len))
-		return -EFAULT;
-	kbuf[read_len] = '\0';
-
-	if (kstrtoul(kbuf, 10, &nr_to_scan))
-		return -EINVAL;
+	unsigned long *count_per_node;
+	unsigned long total, nr;
+	int ret, nid;
 
 	ret = down_read_killable(&shrinker_rwsem);
 	if (ret)
@@ -80,20 +67,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 			goto out;
 		}
 
-		for_each_node(nid) {
-			struct shrink_control sc = {
-				.gfp_mask = GFP_KERNEL,
-				.nid = nid,
-			};
-
-			nr = shrinker->count_objects(shrinker, &sc);
-			if (nr == SHRINK_EMPTY)
-				nr = 0;
-			count_per_node[nid] = nr;
-			total += nr;
-
-			cond_resched();
-		}
+		total = shrinker_count_objects(shrinker, memcg, count_per_node);
 	}
 
 	for_each_node(nid) {
@@ -102,13 +76,13 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 			.nid = nid,
 		};
 
-		if (shrinker->flags & SHRINKER_NUMA_AWARE) {
+		if (count_per_node) {
 			sc.nr_to_scan = nr_to_scan * count_per_node[nid] /
 				(total ? total : 1);
 			sc.nr_scanned = sc.nr_to_scan;
 		} else {
 			sc.nr_to_scan = nr_to_scan;
-			sc.nr_scanned = sc.nr_to_scan;
+			sc.nr_scanned = nr_to_scan;
 		}
 
 		nr = shrinker->scan_objects(shrinker, &sc);
@@ -119,15 +93,51 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 			break;
 
 		cond_resched();
-
 	}
-	ret = size;
 out:
 	up_read(&shrinker_rwsem);
 	kfree(count_per_node);
 	return ret;
 }
 
+static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
+{
+	struct shrinker *shrinker = (struct shrinker *)m->private;
+	int ret;
+
+	ret = down_read_killable(&shrinker_rwsem);
+	if (!ret) {
+		unsigned long total = shrinker_count_objects(shrinker, NULL, NULL);
+
+		up_read(&shrinker_rwsem);
+		seq_printf(m, "%lu\n", total);
+	}
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
+
+static ssize_t shrinker_debugfs_scan_write(struct file *file,
+					   const char __user *buf,
+					   size_t size, loff_t *pos)
+{
+	struct shrinker *shrinker = (struct shrinker *)file->private_data;
+	unsigned long nr_to_scan;
+	char kbuf[24];
+	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
+	ssize_t ret;
+
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EFAULT;
+	kbuf[read_len] = '\0';
+
+	if (kstrtoul(kbuf, 10, &nr_to_scan))
+		return -EINVAL;
+
+	ret = shrinker_scan_objects(shrinker, NULL, nr_to_scan);
+
+	return ret ? ret : size;
+}
+
 static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
 {
 	file->private_data = inode->i_private;
@@ -140,6 +150,78 @@ static const struct file_operations shrinker_debugfs_scan_fops = {
 	.write	 = shrinker_debugfs_scan_write,
 };
 
+#ifdef CONFIG_MEMCG
+static int shrinker_debugfs_count_memcg_show(struct seq_file *m, void *v)
+{
+	struct shrinker *shrinker = (struct shrinker *)m->private;
+	struct mem_cgroup *memcg;
+	unsigned long total;
+	int ret;
+
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret)
+		return ret;
+	rcu_read_lock();
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		if (!mem_cgroup_online(memcg))
+			continue;
+
+		total = shrinker_count_objects(shrinker, memcg, NULL);
+		if (!total)
+			continue;
+
+		seq_printf(m, "%lu %lu\n", mem_cgroup_ino(memcg), total);
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+
+	rcu_read_unlock();
+	up_read(&shrinker_rwsem);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count_memcg);
+
+static ssize_t shrinker_debugfs_scan_memcg_write(struct file *file,
+						 const char __user *buf,
+						 size_t size, loff_t *pos)
+{
+	struct shrinker *shrinker = (struct shrinker *)file->private_data;
+	unsigned long nr_to_scan, ino;
+	struct mem_cgroup *memcg;
+	char kbuf[48];
+	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
+	ssize_t ret;
+
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EFAULT;
+	kbuf[read_len] = '\0';
+
+	if (sscanf(kbuf, "%lu %lu", &ino, &nr_to_scan) < 2)
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
+	ret = shrinker_scan_objects(shrinker, memcg, nr_to_scan);
+	mem_cgroup_put(memcg);
+
+	return ret ? ret : size;
+}
+
+static const struct file_operations shrinker_debugfs_scan_memcg_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = shrinker_debugfs_scan_open,
+	.write	 = shrinker_debugfs_scan_memcg_write,
+};
+#endif
+
 int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	struct dentry *entry;
@@ -173,6 +255,16 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	debugfs_create_file("scan", 0440, entry, shrinker,
 			    &shrinker_debugfs_scan_fops);
 
+#ifdef CONFIG_MEMCG
+	/* create memcg interfaces */
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		debugfs_create_file("count_memcg", 0220, entry, shrinker,
+				    &shrinker_debugfs_count_memcg_fops);
+		debugfs_create_file("scan_memcg", 0440, entry, shrinker,
+				    &shrinker_debugfs_scan_memcg_fops);
+	}
+#endif
+
 	return 0;
 }
 
-- 
2.35.1

