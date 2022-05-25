Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40FE5344D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbiEYU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbiEYU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:26:25 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4971903A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:26:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653510378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhnity23iknGbLztmpbJchnjpsbMxKqjxwyG8C/Qw0o=;
        b=co5aYrUmpkVfJLUJSlDiGJdppRXAU/ZeDW3OUPeVWO+EuIA6raM0tNRQ8s4fPKfKM8nd1+
        Wvo/qVLZiKOg8H0WNbqvebdlCI6Yplezx8kdgsTMFQNV0JwfgJ57U51CBPcSNTGTn87mrw
        Q2snrkBE90HsV8PC3vrAdmP+EMn6kPE=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v4 2/6] mm: shrinkers: introduce debugfs interface for memory shrinkers
Date:   Wed, 25 May 2022 13:25:56 -0700
Message-Id: <20220525202600.2910982-3-roman.gushchin@linux.dev>
In-Reply-To: <20220525202600.2910982-1-roman.gushchin@linux.dev>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the /sys/kernel/debug/shrinker debugfs
interface which provides an ability to observe the state of
individual kernel memory shrinkers.

Because the feature adds some memory overhead (which shouldn't be
large unless there is a huge amount of registered shrinkers), it's
guarded by a config option (enabled by default).

This commit introduces the "count" interface for each shrinker
registered in the system.

The output is in the following format:
<cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
<cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
...

To reduce the size of output on machines with many thousands cgroups,
if the total number of objects on all nodes is 0, the line is omitted.

If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
printed for all nodes except the first one.

This commit gives debugfs entries simple numeric names, which are not
very convenient. The following commit in the series will provide
shrinkers with more meaningful names.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/shrinker.h |  19 ++++-
 lib/Kconfig.debug        |   9 +++
 mm/Makefile              |   1 +
 mm/shrinker_debug.c      | 168 +++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c              |   6 +-
 5 files changed, 200 insertions(+), 3 deletions(-)
 create mode 100644 mm/shrinker_debug.c

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 76fbf92b04d9..2ced8149c513 100644
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
+extern int shrinker_debugfs_add(struct shrinker *shrinker);
+extern void shrinker_debugfs_remove(struct shrinker *shrinker);
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
index 075cd25363ac..6fda0ac6661c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -732,6 +732,15 @@ config SLUB_STATS
 	  out which slabs are relevant to a particular load.
 	  Try running: slabinfo -DA
 
+config SHRINKER_DEBUG
+	default y
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
index 4cc13f3179a5..b693cbec9aa9 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -133,3 +133,4 @@ obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
+obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
new file mode 100644
index 000000000000..1a70556bd46c
--- /dev/null
+++ b/mm/shrinker_debug.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/shrinker.h>
+#include <linux/memcontrol.h>
+
+/* defined in vmscan.c */
+extern struct rw_semaphore shrinker_rwsem;
+extern struct list_head shrinker_list;
+
+static DEFINE_IDA(shrinker_debugfs_ida);
+static struct dentry *shrinker_debugfs_root;
+
+static unsigned long shrinker_count_objects(struct shrinker *shrinker,
+					    struct mem_cgroup *memcg,
+					    unsigned long *count_per_node)
+{
+	unsigned long nr, total = 0;
+	int nid;
+
+	for_each_node(nid) {
+		if (nid == 0 || (shrinker->flags & SHRINKER_NUMA_AWARE)) {
+			struct shrink_control sc = {
+				.gfp_mask = GFP_KERNEL,
+				.nid = nid,
+				.memcg = memcg,
+			};
+
+			nr = shrinker->count_objects(shrinker, &sc);
+			if (nr == SHRINK_EMPTY)
+				nr = 0;
+		} else {
+			nr = 0;
+		}
+
+		count_per_node[nid] = nr;
+		total += nr;
+	}
+
+	return total;
+}
+
+static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
+{
+	struct shrinker *shrinker = m->private;
+	unsigned long *count_per_node;
+	struct mem_cgroup *memcg;
+	unsigned long total;
+	bool memcg_aware;
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
+	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		if (memcg && !mem_cgroup_online(memcg))
+			continue;
+
+		total = shrinker_count_objects(shrinker,
+					       memcg_aware ? memcg : NULL,
+					       count_per_node);
+		if (total) {
+			seq_printf(m, "%lu", mem_cgroup_ino(memcg));
+			for_each_node(nid)
+				seq_printf(m, " %lu", count_per_node[nid]);
+			seq_putc(m, '\n');
+		}
+
+		if (!memcg_aware) {
+			mem_cgroup_iter_break(NULL, memcg);
+			break;
+		}
+
+		if (signal_pending(current)) {
+			mem_cgroup_iter_break(NULL, memcg);
+			ret = -EINTR;
+			break;
+		}
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+
+	rcu_read_unlock();
+	up_read(&shrinker_rwsem);
+
+	kfree(count_per_node);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
+
+int shrinker_debugfs_add(struct shrinker *shrinker)
+{
+	struct dentry *entry;
+	char buf[16];
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
+	debugfs_create_file("count", 0220, entry, shrinker,
+			    &shrinker_debugfs_count_fops);
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
+	struct dentry *dentry;
+	int ret = 0;
+
+	dentry = debugfs_create_dir("shrinker", NULL);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	shrinker_debugfs_root = dentry;
+
+	/* Create debugfs entries for shrinkers registered at boot */
+	down_write(&shrinker_rwsem);
+	list_for_each_entry(shrinker, &shrinker_list, list)
+		if (!shrinker->debugfs_entry) {
+			ret = shrinker_debugfs_add(shrinker);
+			if (ret)
+				break;
+		}
+	up_write(&shrinker_rwsem);
+
+	return ret;
+}
+late_initcall(shrinker_debugfs_init);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..f54df1ce9312 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -189,8 +189,8 @@ static void set_task_reclaim_state(struct task_struct *task,
 	task->reclaim_state = rs;
 }
 
-static LIST_HEAD(shrinker_list);
-static DECLARE_RWSEM(shrinker_rwsem);
+LIST_HEAD(shrinker_list);
+DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -654,6 +654,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
+	WARN_ON_ONCE(shrinker_debugfs_add(shrinker));
 	up_write(&shrinker_rwsem);
 }
 
@@ -681,6 +682,7 @@ void unregister_shrinker(struct shrinker *shrinker)
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
+	shrinker_debugfs_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
 	kfree(shrinker->nr_deferred);
-- 
2.35.3

