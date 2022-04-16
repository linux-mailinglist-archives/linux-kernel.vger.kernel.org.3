Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F035033AC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiDPAa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiDPAau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:30:50 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63449F32A9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:28:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650068896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4RZwMFeMoYiMy3BaiDmGBT4/5Xh5E/nJdWgYIOr1+c=;
        b=KS2KL7AKnVF5bbkq00IgGQWfrF6m3Bbw4XkGPICGRmKBBvv9136d4O01HXIETuoLCAhsXe
        5OzJ3xq3FynjmJ1B3F1bcBL6D8fTuMalJ9bZ0BB2D/WLRC3ZqmnXblvQpCb9DhXmnvp4Tu
        06pOiv6V791REI+n+dmPXqWUYv5jy/8=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 1/5] mm: introduce sysfs interface for debugging kernel shrinker
Date:   Fri, 15 Apr 2022 17:27:52 -0700
Message-Id: <20220416002756.4087977-2-roman.gushchin@linux.dev>
In-Reply-To: <20220416002756.4087977-1-roman.gushchin@linux.dev>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
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

This commit introduces the /sys/kernel/shrinker sysfs interface
which provides an ability to observe the state and interact with
individual kernel memory shrinkers.

Because the feature is oriented on kernel developers and adds some
memory overhead (which shouldn't be large unless there is a huge
amount of registered shrinkers), it's guarded by a config option
(disabled by default).

To simplify the code, kobjects are not embedded into shrinkers
objects, but are created, linked and unlinked dynamically.

This commit introduces basic "count" and "scan" interfaces.
Basic usage:
  $ cat count                   : get the number of objects
  $ echo "500" > scan           : try to reclaim 500 objects
  $ cat scan                    : get the number of objects reclaimed
Following commits in the series will add memcg- and numa-specific
features.

This commit gives sysfs entries simple numeric names, which are not
very convenient. The following commit in the series will provide
shrinkers with more meaningful names.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/shrinker.h |  20 ++-
 lib/Kconfig.debug        |   9 ++
 mm/Makefile              |   1 +
 mm/shrinker_debug.c      | 294 +++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c              |   6 +-
 5 files changed, 327 insertions(+), 3 deletions(-)
 create mode 100644 mm/shrinker_debug.c

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 76fbf92b04d9..50c0e233ecdd 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_SHRINKER_H
 #define _LINUX_SHRINKER_H
 
+struct shrinker_kobj;
+
 /*
  * This struct is used to pass information from page reclaim to the shrinkers.
  * We consolidate the values for easier extension later.
@@ -72,6 +74,9 @@ struct shrinker {
 #ifdef CONFIG_MEMCG
 	/* ID in shrinker_idr */
 	int id;
+#endif
+#ifdef CONFIG_SHRINKER_DEBUG
+	struct shrinker_kobj *kobj;
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
@@ -94,4 +99,17 @@ extern int register_shrinker(struct shrinker *shrinker);
 extern void unregister_shrinker(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
-#endif
+
+#ifdef CONFIG_SHRINKER_DEBUG
+int shrinker_init_kobj(struct shrinker *shrinker);
+void shrinker_unlink_kobj(struct shrinker *shrinker);
+#else /* CONFIG_SHRINKER_DEBUG */
+static inline int shrinker_init_kobj(struct shrinker *shrinker)
+{
+	return 0;
+}
+static inline void shrinker_unlink_kobj(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_SHRINKER_DEBUG */
+#endif /* _LINUX_SHRINKER_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6bf9cceb7d20..6369fcd9587f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -733,6 +733,15 @@ config SLUB_STATS
 	  out which slabs are relevant to a particular load.
 	  Try running: slabinfo -DA
 
+config SHRINKER_DEBUG
+	default n
+	bool "Enable shrinker debugging support"
+	depends on SYSFS
+	help
+	  Say Y to enable the /sys/kernel/shrinkers debug interface which
+	  provides visibility into the kernel memory shrinkers subsystem.
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
index 000000000000..817d578f993c
--- /dev/null
+++ b/mm/shrinker_debug.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/kobject.h>
+#include <linux/shrinker.h>
+
+/* defined in vmscan.c */
+extern struct rw_semaphore shrinker_rwsem;
+extern struct list_head shrinker_list;
+
+static DEFINE_IDA(shrinker_sysfs_ida);
+
+struct shrinker_kobj {
+	struct kobject kobj;
+	struct shrinker *shrinker;
+	int id;
+};
+
+struct shrinker_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct shrinker_kobj *skobj,
+			struct shrinker_attribute *attr, char *buf);
+	ssize_t (*store)(struct shrinker_kobj *skobj,
+			 struct shrinker_attribute *attr, const char *buf,
+			 size_t count);
+	unsigned long private;
+};
+
+#define to_shrinker_kobj(x) container_of(x, struct shrinker_kobj, kobj)
+#define to_shrinker_attr(x) container_of(x, struct shrinker_attribute, attr)
+
+static ssize_t shrinker_attr_show(struct kobject *kobj, struct attribute *attr,
+				  char *buf)
+{
+	struct shrinker_attribute *attribute = to_shrinker_attr(attr);
+	struct shrinker_kobj *skobj = to_shrinker_kobj(kobj);
+
+	if (!attribute->show)
+		return -EIO;
+
+	return attribute->show(skobj, attribute, buf);
+}
+
+static ssize_t shrinker_attr_store(struct kobject *kobj, struct attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct shrinker_attribute *attribute = to_shrinker_attr(attr);
+	struct shrinker_kobj *skobj = to_shrinker_kobj(kobj);
+
+	if (!attribute->store)
+		return -EIO;
+
+	return attribute->store(skobj, attribute, buf, len);
+}
+
+static const struct sysfs_ops shrinker_sysfs_ops = {
+	.show = shrinker_attr_show,
+	.store = shrinker_attr_store,
+};
+
+static void shrinker_kobj_release(struct kobject *kobj)
+{
+	struct shrinker_kobj *skobj = to_shrinker_kobj(kobj);
+
+	WARN_ON(skobj->shrinker);
+	kfree(skobj);
+}
+
+static ssize_t count_show(struct shrinker_kobj *skobj,
+			  struct shrinker_attribute *attr, char *buf)
+{
+	unsigned long nr, total = 0;
+	struct shrinker *shrinker;
+	int nid;
+
+	down_read(&shrinker_rwsem);
+
+	shrinker = skobj->shrinker;
+	if (!shrinker) {
+		up_read(&shrinker_rwsem);
+		return -EBUSY;
+	}
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
+	return sprintf(buf, "%lu\n", total);
+}
+
+static struct shrinker_attribute count_attribute = __ATTR_RO(count);
+
+static ssize_t scan_show(struct shrinker_kobj *skobj,
+			 struct shrinker_attribute *attr, char *buf)
+{
+	/*
+	 * Display the number of objects freed on the last scan.
+	 */
+	return sprintf(buf, "%lu\n", attr->private);
+}
+
+static ssize_t scan_store(struct shrinker_kobj *skobj,
+			  struct shrinker_attribute *attr,
+			  const char *buf, size_t size)
+{
+	unsigned long nr, total = 0, nr_to_scan = 0, freed = 0;
+	unsigned long *count_per_node = NULL;
+	struct shrinker *shrinker;
+	ssize_t ret = size;
+	int nid;
+
+	if (kstrtoul(buf, 10, &nr_to_scan))
+		return -EINVAL;
+
+	down_read(&shrinker_rwsem);
+
+	shrinker = skobj->shrinker;
+	if (!shrinker) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (shrinker->flags & SHRINKER_NUMA_AWARE) {
+		/*
+		 * If the shrinker is numa aware, distribute nr_to_scan
+		 * proportionally.
+		 */
+		count_per_node = kzalloc(sizeof(unsigned long) * nr_node_ids,
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
+		if (nr == SHRINK_STOP || nr == SHRINK_EMPTY)
+			nr = 0;
+
+		freed += nr;
+
+		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+			break;
+
+		cond_resched();
+
+	}
+	attr->private = freed;
+out:
+	up_read(&shrinker_rwsem);
+	kfree(count_per_node);
+	return ret;
+}
+
+static struct shrinker_attribute scan_attribute = __ATTR_RW(scan);
+
+static struct attribute *shrinker_default_attrs[] = {
+	&count_attribute.attr,
+	&scan_attribute.attr,
+	NULL,
+};
+
+static const struct attribute_group shrinker_default_group = {
+	.attrs = shrinker_default_attrs,
+};
+
+static const struct attribute_group *shrinker_sysfs_groups[] = {
+	&shrinker_default_group,
+	NULL,
+};
+
+static struct kobj_type shrinker_ktype = {
+	.sysfs_ops = &shrinker_sysfs_ops,
+	.release = shrinker_kobj_release,
+	.default_groups = shrinker_sysfs_groups,
+};
+
+static struct kset *shrinker_kset;
+
+int shrinker_init_kobj(struct shrinker *shrinker)
+{
+	struct shrinker_kobj *skobj;
+	int ret = 0;
+	int id;
+
+	/* Sysfs isn't initialize yet, allocate kobjects later. */
+	if (!shrinker_kset)
+		return 0;
+
+	skobj = kzalloc(sizeof(struct shrinker_kobj), GFP_KERNEL);
+	if (!skobj)
+		return -ENOMEM;
+
+	id = ida_alloc(&shrinker_sysfs_ida, GFP_KERNEL);
+	if (id < 0) {
+		kfree(skobj);
+		return id;
+	}
+
+	skobj->id = id;
+	skobj->kobj.kset = shrinker_kset;
+	skobj->shrinker = shrinker;
+	ret = kobject_init_and_add(&skobj->kobj, &shrinker_ktype, NULL, "%d",
+				   id);
+	if (ret) {
+		ida_free(&shrinker_sysfs_ida, id);
+		kobject_put(&skobj->kobj);
+		return ret;
+	}
+
+	shrinker->kobj = skobj;
+
+	kobject_uevent(&skobj->kobj, KOBJ_ADD);
+
+	return ret;
+}
+
+void shrinker_unlink_kobj(struct shrinker *shrinker)
+{
+	struct shrinker_kobj *skobj;
+
+	if (!shrinker->kobj)
+		return;
+
+	skobj = shrinker->kobj;
+	skobj->shrinker = NULL;
+	ida_free(&shrinker_sysfs_ida, skobj->id);
+	shrinker->kobj = NULL;
+
+	kobject_put(&skobj->kobj);
+}
+
+static int __init shrinker_sysfs_init(void)
+{
+	struct shrinker *shrinker;
+	int ret = 0;
+
+	shrinker_kset = kset_create_and_add("shrinker", NULL, kernel_kobj);
+	if (!shrinker_kset)
+		return -ENOMEM;
+
+	/* Create sysfs entries for shrinkers registered at boot */
+	down_write(&shrinker_rwsem);
+	list_for_each_entry(shrinker, &shrinker_list, list)
+		if (!shrinker->kobj)
+			ret = shrinker_init_kobj(shrinker);
+	up_write(&shrinker_rwsem);
+
+	return ret;
+}
+__initcall(shrinker_sysfs_init);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4a7d2bd276d..79eaa9cea618 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -201,8 +201,8 @@ static void set_task_reclaim_state(struct task_struct *task,
 	task->reclaim_state = rs;
 }
 
-static LIST_HEAD(shrinker_list);
-static DECLARE_RWSEM(shrinker_rwsem);
+LIST_HEAD(shrinker_list);
+DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -666,6 +666,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
+	WARN_ON_ONCE(shrinker_init_kobj(shrinker));
 	up_write(&shrinker_rwsem);
 }
 
@@ -693,6 +694,7 @@ void unregister_shrinker(struct shrinker *shrinker)
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
+	shrinker_unlink_kobj(shrinker);
 	up_write(&shrinker_rwsem);
 
 	kfree(shrinker->nr_deferred);
-- 
2.35.1

