Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457AF50AD92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443241AbiDVCCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiDVCB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:01:56 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7C4A907
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:59:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650592742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urcY4KpR6Y/rKfU1Exf0ylTVTWbC0tQ2e4XTZHXE3Ec=;
        b=bn9gcaOdhr5Jh87xq/5Eau4lhsgSb90keirrmftLOnUYbpNc2pyqKHUbZIo4OYudiKhb62
        w9iU8/vl0G+7K0ZQDkQRw66f/uELFSXnOw5lFOsKDZL13OAyA7KCEkmF5hqFfm3K/jYiTs
        LFJwRFlht9vfDFwg7fEuBMe4qRxK0lg=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 1/5] mm: introduce debugfs interface for kernel memory shrinkers
Date:   Thu, 21 Apr 2022 18:58:49 -0700
Message-Id: <20220422015853.748291-2-roman.gushchin@linux.dev>
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

This commit introduces the /sys/kernel/debug/shrinker debugfs
interface which provides an ability to observe the state and interact
with individual kernel memory shrinkers.

Because the feature is oriented on kernel developers and adds some
memory overhead (which shouldn't be large unless there is a huge
amount of registered shrinkers), it's guarded by a config option
(disabled by default).

This commit introduces "count" and "scan" interfaces for each
shrinker registered in the system.

Basic usage:
  1) Get the number of objects
    $ cat count

  2) Try to reclaim 500 objects
    $ echo "500" > scan

Following commits in the series will add memcg- and numa-specific
features.

This commit gives debugfs entries simple numeric names, which are not
very convenient. The following commit in the series will provide
shrinkers with more meaningful names.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/shrinker.h |  19 +++-
 lib/Kconfig.debug        |   9 ++
 mm/Makefile              |   1 +
 mm/shrinker_debug.c      | 214 +++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c              |   6 +-
 5 files changed, 246 insertions(+), 3 deletions(-)
 create mode 100644 mm/shrinker_debug.c

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 76fbf92b04d9..17985a890887 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -72,6 +72,10 @@ struct shrinker {
 #ifdef CONFIG_MEMCG
 	/* ID in shrinker_idr */
 	int id;
+#endif
+#ifdef CONFIG_SHRINKER_DEBUG
+	int debugfs_id;
+	struct dentry *debugfs_entry;
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
@@ -94,4 +98,17 @@ extern int register_shrinker(struct shrinker *shrinker);
 extern void unregister_shrinker(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
-#endif
+
+#ifdef CONFIG_SHRINKER_DEBUG
+int shrinker_debugfs_add(struct shrinker *shrinker);
+void shrinker_debugfs_remove(struct shrinker *shrinker);
+#else /* CONFIG_SHRINKER_DEBUG */
+static inline int shrinker_debugfs_add(struct shrinker *shrinker)
+{
+	return 0;
+}
+static inline void shrinker_debugfs_remove(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_SHRINKER_DEBUG */
+#endif /* _LINUX_SHRINKER_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6bf9cceb7d20..51910b291b81 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -733,6 +733,15 @@ config SLUB_STATS
 	  out which slabs are relevant to a particular load.
 	  Try running: slabinfo -DA
 
+config SHRINKER_DEBUG
+	default n
+	bool "Enable shrinker debugging support"
+	depends on DEBUG_FS
+	help
+	  Say Y to enable the shrinker debugfs interface which provides
+	  visibility into the kernel memory shrinkers subsystem.
+	  Disable it to avoid an extra memory footprint.
+
 config HAVE_DEBUG_KMEMLEAK
 	bool
 
diff --git a/mm/Makefile b/mm/Makefile
index 6f9ffa968a1a..9a564f836403 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -133,3 +133,4 @@ obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
+obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
new file mode 100644
index 000000000000..4df7382a0737
--- /dev/null
+++ b/mm/shrinker_debug.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/idr.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/shrinker.h>
+
+/* defined in vmscan.c */
+extern struct rw_semaphore shrinker_rwsem;
+extern struct list_head shrinker_list;
+
+static DEFINE_IDA(shrinker_debugfs_ida);
+static struct dentry *shrinker_debugfs_root;
+
+static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
+{
+	struct shrinker *shrinker = (struct shrinker *)m->private;
+	unsigned long nr, total = 0;
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
+		total += nr;
+
+		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+			break;
+
+		cond_resched();
+	}
+	up_read(&shrinker_rwsem);
+
+	seq_printf(m, "%lu\n", total);
+
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
+
+static ssize_t shrinker_debugfs_scan_write(struct file *file,
+					   const char __user *buf,
+					   size_t size, loff_t *pos)
+{
+	struct shrinker *shrinker = (struct shrinker *)file->private_data;
+	unsigned long nr, total = 0, nr_to_scan;
+	unsigned long *count_per_node = NULL;
+	int nid;
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
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret)
+		return ret;
+
+	if (shrinker->flags & SHRINKER_NUMA_AWARE) {
+		/*
+		 * If the shrinker is numa aware, distribute nr_to_scan
+		 * proportionally.
+		 */
+		count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long),
+					 GFP_KERNEL);
+		if (!count_per_node) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		for_each_node(nid) {
+			struct shrink_control sc = {
+				.gfp_mask = GFP_KERNEL,
+				.nid = nid,
+			};
+
+			nr = shrinker->count_objects(shrinker, &sc);
+			if (nr == SHRINK_EMPTY)
+				nr = 0;
+			count_per_node[nid] = nr;
+			total += nr;
+
+			cond_resched();
+		}
+	}
+
+	for_each_node(nid) {
+		struct shrink_control sc = {
+			.gfp_mask = GFP_KERNEL,
+			.nid = nid,
+		};
+
+		if (shrinker->flags & SHRINKER_NUMA_AWARE) {
+			sc.nr_to_scan = nr_to_scan * count_per_node[nid] /
+				(total ? total : 1);
+			sc.nr_scanned = sc.nr_to_scan;
+		} else {
+			sc.nr_to_scan = nr_to_scan;
+			sc.nr_scanned = sc.nr_to_scan;
+		}
+
+		nr = shrinker->scan_objects(shrinker, &sc);
+		if (nr == SHRINK_STOP)
+			break;
+
+		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+			break;
+
+		cond_resched();
+
+	}
+	ret = size;
+out:
+	up_read(&shrinker_rwsem);
+	kfree(count_per_node);
+	return ret;
+}
+
+static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return nonseekable_open(inode, file);
+}
+
+static const struct file_operations shrinker_debugfs_scan_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = shrinker_debugfs_scan_open,
+	.write	 = shrinker_debugfs_scan_write,
+};
+
+int shrinker_debugfs_add(struct shrinker *shrinker)
+{
+	struct dentry *entry;
+	char buf[256];
+	int id;
+
+	lockdep_assert_held(&shrinker_rwsem);
+
+	/* debugfs isn't initialized yet, add debugfs entries later. */
+	if (!shrinker_debugfs_root)
+		return 0;
+
+	id = ida_alloc(&shrinker_debugfs_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	shrinker->debugfs_id = id;
+
+	snprintf(buf, sizeof(buf), "%d", id);
+
+	/* create debugfs entry */
+	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
+	if (IS_ERR(entry)) {
+		ida_free(&shrinker_debugfs_ida, id);
+		return PTR_ERR(entry);
+	}
+	shrinker->debugfs_entry = entry;
+
+	/* create generic interfaces */
+	debugfs_create_file("count", 0220, entry, shrinker,
+			    &shrinker_debugfs_count_fops);
+	debugfs_create_file("scan", 0440, entry, shrinker,
+			    &shrinker_debugfs_scan_fops);
+
+	return 0;
+}
+
+void shrinker_debugfs_remove(struct shrinker *shrinker)
+{
+	lockdep_assert_held(&shrinker_rwsem);
+
+	if (!shrinker->debugfs_entry)
+		return;
+
+	debugfs_remove_recursive(shrinker->debugfs_entry);
+	ida_free(&shrinker_debugfs_ida, shrinker->debugfs_id);
+}
+
+static int __init shrinker_debugfs_init(void)
+{
+	struct shrinker *shrinker;
+	int ret;
+
+	if (!debugfs_initialized())
+		return -ENODEV;
+
+	shrinker_debugfs_root = debugfs_create_dir("shrinker", NULL);
+	if (!shrinker_debugfs_root)
+		return -ENOMEM;
+
+	/* Create debugfs entries for shrinkers registered at boot */
+	ret = down_write_killable(&shrinker_rwsem);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(shrinker, &shrinker_list, list)
+		if (!shrinker->debugfs_entry)
+			ret = shrinker_debugfs_add(shrinker);
+	up_write(&shrinker_rwsem);
+
+	return ret;
+}
+late_initcall(shrinker_debugfs_init);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99a572f01cb4..121a54a1602b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -190,8 +190,8 @@ static void set_task_reclaim_state(struct task_struct *task,
 	task->reclaim_state = rs;
 }
 
-static LIST_HEAD(shrinker_list);
-static DECLARE_RWSEM(shrinker_rwsem);
+LIST_HEAD(shrinker_list);
+DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -655,6 +655,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
+	WARN_ON_ONCE(shrinker_debugfs_add(shrinker));
 	up_write(&shrinker_rwsem);
 }
 
@@ -682,6 +683,7 @@ void unregister_shrinker(struct shrinker *shrinker)
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
+	shrinker_debugfs_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
 	kfree(shrinker->nr_deferred);
-- 
2.35.1

