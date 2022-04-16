Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984CE5032F4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiDPAbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiDPAaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:30:55 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04653F32A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:28:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650068902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ERdF+19mvF3N82X1eSrvKaKf/NF7Kk10EurOOsSAC0=;
        b=QhVoFm1c0QEKUjYdxLXR9/OUgE6EDMKySAdoHLQG6gT4ZLBlQv6bsOQRK1dwmquyxGA5Lv
        pgh3k5rlgv7fJ2iN46oEowzO0DCSZP1gJjlfW2tuS5O5vncaPDRQNsjvXvjePkuYsRnqkP
        cUpVH91hOvlfJvy7YPvrKUVsNsGAlGU=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 3/5] mm: introduce memcg interfaces for shrinker sysfs
Date:   Fri, 15 Apr 2022 17:27:54 -0700
Message-Id: <20220416002756.4087977-4-roman.gushchin@linux.dev>
In-Reply-To: <20220416002756.4087977-1-roman.gushchin@linux.dev>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

If the output doesn't fit into a page (sysfs limitation), a separate
line with "..." is added at the end.

It's possible to write a minimum number to the "count_memcg" interface
to filter the output.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/shrinker_debug.c | 216 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 817d578f993c..24f78f5feb22 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/kobject.h>
 #include <linux/shrinker.h>
+#include <linux/memcontrol.h>
 
 /* defined in vmscan.c */
 extern struct rw_semaphore shrinker_rwsem;
@@ -207,8 +208,223 @@ static const struct attribute_group shrinker_default_group = {
 	.attrs = shrinker_default_attrs,
 };
 
+#ifdef CONFIG_MEMCG
+static ssize_t count_memcg_show(struct shrinker_kobj *skobj,
+				struct shrinker_attribute *attr, char *buf)
+{
+	unsigned long nr, total;
+	struct shrinker *shrinker;
+	struct mem_cgroup *memcg;
+	ssize_t ret = 0;
+	int nid;
+
+	down_read(&shrinker_rwsem);
+	rcu_read_lock();
+
+	shrinker = skobj->shrinker;
+	if (!shrinker) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		if (!mem_cgroup_online(memcg))
+			continue;
+
+		/*
+		 * Display a PAGE_SIZE of data, reserve last 50 characters
+		 * for "...".
+		 */
+		if (ret > PAGE_SIZE - 50) {
+			ret += sprintf(buf + ret, "...\n");
+			mem_cgroup_iter_break(NULL, memcg);
+			break;
+		}
+
+		total = 0;
+		for_each_node(nid) {
+			struct shrink_control sc = {
+				.gfp_mask = GFP_KERNEL,
+				.nid = nid,
+				.memcg = memcg,
+			};
+
+			nr = shrinker->count_objects(shrinker, &sc);
+			if (nr == SHRINK_EMPTY)
+				nr = 0;
+			total += nr;
+
+			if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+				break;
+
+			cond_resched();
+		}
+
+		if (!total || total < attr->private)
+			continue;
+
+		ret += sprintf(buf + ret, "%lu %lu\n", mem_cgroup_ino(memcg),
+			       total);
+
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+out:
+	rcu_read_unlock();
+	up_read(&shrinker_rwsem);
+	return ret;
+}
+
+static ssize_t count_memcg_store(struct shrinker_kobj *skobj,
+				 struct shrinker_attribute *attr,
+				 const char *buf, size_t size)
+{
+	unsigned long min_count;
+
+	if (kstrtoul(buf, 10, &min_count))
+		return -EINVAL;
+
+	attr->private = min_count;
+
+	return size;
+}
+
+static struct shrinker_attribute count_memcg_attribute = __ATTR_RW(count_memcg);
+
+static ssize_t scan_memcg_show(struct shrinker_kobj *skobj,
+			       struct shrinker_attribute *attr, char *buf)
+{
+	/*
+	 * Display the number of objects freed on the last scan.
+	 */
+	return sprintf(buf, "%lu\n", attr->private);
+}
+
+static ssize_t scan_memcg_store(struct shrinker_kobj *skobj,
+			  struct shrinker_attribute *attr,
+			  const char *buf, size_t size)
+{
+	unsigned long nr, nr_to_scan = 0, freed = 0, total = 0, ino;
+	unsigned long *count_per_node = NULL;
+	struct mem_cgroup *memcg;
+	struct shrinker *shrinker;
+	ssize_t ret = size;
+	int nid;
+
+	if (sscanf(buf, "%lu %lu", &ino, &nr_to_scan) < 2)
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
+	down_read(&shrinker_rwsem);
+
+	shrinker = skobj->shrinker;
+	if (!shrinker) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (shrinker->flags & SHRINKER_NUMA_AWARE) {
+		count_per_node = kzalloc(sizeof(unsigned long) * nr_node_ids,
+					GFP_KERNEL);
+		if (!count_per_node) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		for_each_node(nid) {
+			struct shrink_control sc = {
+				.gfp_mask = GFP_KERNEL,
+				.nid = nid,
+				.memcg = memcg,
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
+			.memcg = memcg,
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
+	}
+	attr->private = freed;
+out:
+	up_read(&shrinker_rwsem);
+	mem_cgroup_put(memcg);
+	kfree(count_per_node);
+	return ret;
+}
+
+static struct shrinker_attribute scan_memcg_attribute = __ATTR_RW(scan_memcg);
+
+static struct attribute *shrinker_memcg_attrs[] = {
+	&count_memcg_attribute.attr,
+	&scan_memcg_attribute.attr,
+	NULL,
+};
+
+static umode_t memcg_attrs_visible(struct kobject *kobj, struct attribute *attr,
+				   int i)
+{
+	struct shrinker_kobj *skobj = to_shrinker_kobj(kobj);
+	struct shrinker *shrinker;
+	int ret = 0;
+
+	lockdep_assert_held(&shrinker_rwsem);
+
+	shrinker = skobj->shrinker;
+	if (shrinker && (shrinker->flags & SHRINKER_MEMCG_AWARE))
+		ret = 0644;
+
+	return ret;
+}
+
+static const struct attribute_group shrinker_memcg_group = {
+	.attrs = shrinker_memcg_attrs,
+	.is_visible = memcg_attrs_visible,
+};
+#endif /* CONFIG_MEMCG */
 static const struct attribute_group *shrinker_sysfs_groups[] = {
 	&shrinker_default_group,
+#ifdef CONFIG_MEMCG
+	&shrinker_memcg_group,
+#endif
 	NULL,
 };
 
-- 
2.35.1

