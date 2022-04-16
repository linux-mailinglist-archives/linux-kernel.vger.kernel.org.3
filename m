Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34F5033E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiDPAbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiDPAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:30:58 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D2193F6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:28:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650068905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y34VqwmfK812OvWCLFVqiNZnNYfhGDfFOBslJu4/bLU=;
        b=eOOxSe28AzIKnvaW2OcZvLe3iDdp06CYOA1op2bA1g/1wtTrHNAS62r5THEBpmbifI6p3f
        hKIdx/Qt0eASgdT3+57lZ6uXIVmLaB9Ccs+Fr8/U/fcEy2bmWDcoJ73GZt4LqukT+pdV91
        j35Wv6FrhS7LMNNSmu9XpKzEnozYDFE=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 4/5] mm: introduce numa interfaces for shrinker sysfs
Date:   Fri, 15 Apr 2022 17:27:55 -0700
Message-Id: <20220416002756.4087977-5-roman.gushchin@linux.dev>
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
 mm/shrinker_debug.c | 279 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 24f78f5feb22..ae6e434500bc 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -420,10 +420,289 @@ static const struct attribute_group shrinker_memcg_group = {
 	.is_visible = memcg_attrs_visible,
 };
 #endif /* CONFIG_MEMCG */
+
+#ifdef CONFIG_NUMA
+static ssize_t count_node_show(struct shrinker_kobj *skobj,
+			       struct shrinker_attribute *attr, char *buf)
+{
+	struct shrinker *shrinker;
+	unsigned long nr;
+	int nid;
+	ssize_t ret = 0;
+
+	down_read(&shrinker_rwsem);
+
+	shrinker = skobj->shrinker;
+	if (!shrinker) {
+		ret = -EBUSY;
+		goto out;
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
+
+		ret += sprintf(buf + ret, "%lu ", nr);
+
+		cond_resched();
+	}
+out:
+	up_read(&shrinker_rwsem);
+	ret += sprintf(buf + ret, "\n");
+	return ret;
+}
+
+static struct shrinker_attribute count_node_attribute = __ATTR_RO(count_node);
+
+static ssize_t scan_node_show(struct shrinker_kobj *skobj,
+			      struct shrinker_attribute *attr, char *buf)
+{
+	/*
+	 * Display the number of objects freed on the last scan.
+	 */
+	return sprintf(buf, "%lu\n", attr->private);
+}
+
+static ssize_t scan_node_store(struct shrinker_kobj *skobj,
+			       struct shrinker_attribute *attr,
+			       const char *buf, size_t size)
+{
+	unsigned long nr, nr_to_scan = 0;
+	struct shrinker *shrinker;
+	ssize_t ret = size;
+	int nid;
+	struct shrink_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
+
+	if (sscanf(buf, "%d %lu", &nid, &nr_to_scan) < 2)
+		return -EINVAL;
+
+	if (nid >= nr_node_ids)
+		return -EINVAL;
+
+	if (nid < 0 || nid >= nr_node_ids)
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
+	sc.nid = nid;
+	sc.nr_to_scan = nr_to_scan;
+	sc.nr_scanned = nr_to_scan;
+
+	nr = shrinker->scan_objects(shrinker, &sc);
+	if (nr == SHRINK_STOP || nr == SHRINK_EMPTY)
+		nr = 0;
+
+	attr->private = nr;
+out:
+	up_read(&shrinker_rwsem);
+	return ret;
+}
+
+static struct shrinker_attribute scan_node_attribute = __ATTR_RW(scan_node);
+
+#ifdef CONFIG_MEMCG
+static ssize_t count_memcg_node_show(struct shrinker_kobj *skobj,
+				     struct shrinker_attribute *attr, char *buf)
+{
+	unsigned long nr, total;
+	unsigned long *count_per_node = NULL;
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
+	count_per_node = kzalloc(sizeof(unsigned long) * nr_node_ids, GFP_KERNEL);
+	if (!count_per_node) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		if (!mem_cgroup_online(memcg))
+			continue;
+
+		/*
+		 * Display a PAGE_SIZE of data, reserve last few characters
+		 * for "...".
+		 */
+		if (ret > PAGE_SIZE - (nr_node_ids * 20 + 30)) {
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
+			count_per_node[nid] = nr;
+			total += nr;
+		}
+		if (!total || total < attr->private)
+			continue;
+
+		ret += sprintf(buf + ret, "%lu ", mem_cgroup_ino(memcg));
+		for_each_node(nid)
+			ret += sprintf(buf + ret, "%lu ", count_per_node[nid]);
+		ret += sprintf(buf + ret, "\n");
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+out:
+	rcu_read_unlock();
+	up_read(&shrinker_rwsem);
+	kfree(count_per_node);
+	return ret;
+}
+
+static ssize_t count_memcg_node_store(struct shrinker_kobj *skobj,
+				      struct shrinker_attribute *attr,
+				      const char *buf, size_t size)
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
+static struct shrinker_attribute count_memcg_node_attribute =
+	__ATTR_RW(count_memcg_node);
+
+static ssize_t scan_memcg_node_show(struct shrinker_kobj *skobj,
+				    struct shrinker_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", attr->private);
+}
+
+static ssize_t scan_memcg_node_store(struct shrinker_kobj *skobj,
+				     struct shrinker_attribute *attr,
+				     const char *buf, size_t size)
+{
+	unsigned long nr_to_scan = 0, nr, ino;
+	struct shrink_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
+	struct mem_cgroup *memcg;
+	struct shrinker *shrinker;
+	ssize_t ret = size;
+	int nid;
+
+	if (sscanf(buf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)
+		return -EINVAL;
+
+	if (nid >= nr_node_ids)
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
+	sc.nid = nid;
+	sc.memcg = memcg;
+	sc.nr_to_scan = nr_to_scan;
+	sc.nr_scanned = nr_to_scan;
+
+	nr = shrinker->scan_objects(shrinker, &sc);
+	if (nr == SHRINK_STOP || nr == SHRINK_EMPTY)
+		nr = 0;
+
+	attr->private = nr;
+out:
+	up_read(&shrinker_rwsem);
+	mem_cgroup_put(memcg);
+	return ret;
+}
+
+static struct shrinker_attribute scan_memcg_node_attribute =
+	__ATTR_RW(scan_memcg_node);
+#endif /* CONFIG_MEMCG */
+
+static struct attribute *shrinker_node_attrs[] = {
+	&count_node_attribute.attr,
+	&scan_node_attribute.attr,
+#ifdef CONFIG_MEMCG
+	&count_memcg_node_attribute.attr,
+	&scan_memcg_node_attribute.attr,
+#endif
+	NULL,
+};
+
+static umode_t node_attrs_visible(struct kobject *kobj, struct attribute *attr,
+				  int i)
+{
+	struct shrinker_kobj *skobj = to_shrinker_kobj(kobj);
+	struct shrinker *shrinker;
+	int ret = 0;
+
+	lockdep_assert_held(&shrinker_rwsem);
+
+	shrinker = skobj->shrinker;
+	if (nr_node_ids > 1 && shrinker &&
+	    (shrinker->flags & SHRINKER_NUMA_AWARE))
+		ret = 0644;
+
+	return ret;
+}
+
+static const struct attribute_group shrinker_node_group = {
+	.attrs = shrinker_node_attrs,
+	.is_visible = node_attrs_visible,
+};
+#endif /* CONFIG_NUMA */
+
 static const struct attribute_group *shrinker_sysfs_groups[] = {
 	&shrinker_default_group,
 #ifdef CONFIG_MEMCG
 	&shrinker_memcg_group,
+#endif
+#ifdef CONFIG_NUMA
+	&shrinker_node_group,
 #endif
 	NULL,
 };
-- 
2.35.1

