Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F925036A3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiDPMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiDPMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:42:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7AA65F9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 05:39:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so9010836plk.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=OuLgF0sGBVEmNCjVq+cOXROdNbMI0rT63XN/p3hGmng=;
        b=hARp3WFWVUgRzvrpmdyzZB5sQJ2AJEPglHEhsfs7T+ybC3nnS7mGhWPmPMnhY5AYvV
         5fm7slmAr8kaligcEWVmnjAzBMMljDvp6GjCDc9myDczuOTcrkWq4eSyz24gsYtZ9xB1
         7RkVZwOdXkUF8xrb6hO+ee2k01hv5p5l4grfvIn1Z51K0V8RF1JEzCbPYxIzXYYWs0ue
         q+2r01w6SUB4Y2kXcKp3728Q8/BUMPTEbBS+FTm4yyB8pcvpPjIxwuAhl95PXDn1reIy
         sBDEiuCKV25nuxcEW+7es+IMzDb4QusjPYem97FUqBhuMIRKuYUEJHgUylQQaoyOyMPp
         N41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OuLgF0sGBVEmNCjVq+cOXROdNbMI0rT63XN/p3hGmng=;
        b=KJ+rLEw9fK62bzvTuizNKeY30iH5L5f/qhp0EKV6elL6ODiszZZ39oICHeetrZx1nO
         P9fOoFnaHt/goYK5OEXDMu/cLtHtoo1GvfrT7wRBE/0U3xLdkTH37KwdH7gGe++MSTj+
         HkevDnl8wJDQ7OWVIc1E4Fz/4S4P9K+N9bbGWHFGZNGw9hRMT9FA4ycVbv5SsdPesZ2v
         m+mLwPrNajYUdMKbcftUcuYZsWEZ7UlfPrzAWcvOlWZwnRLpAf4BNL0BRiiRGAUnFHA3
         N/02oDF+5MFaf75LZ2v1Uoa8orJQjLKq+r4Z9Dy2N81eBaIOaKc5TpxVwTCQcQg5Guy+
         KMsg==
X-Gm-Message-State: AOAM532VRak/RupENWUQLwi9SjMJLJhKe2ooMBZhHeR+NRfRXYgS/dyR
        fVh0ipTix5Qw+YVc8vI/4/0=
X-Google-Smtp-Source: ABdhPJxYiPfzVdmv0QFcUBzemBTuuLeEoMGyqL+qQ5Ir8BNZoLPG7tf2rKa4YKJ1Vd49lauWlBuIrA==
X-Received: by 2002:a17:902:7884:b0:158:b5b6:572c with SMTP id q4-20020a170902788400b00158b5b6572cmr3306258pll.144.1650112783981;
        Sat, 16 Apr 2022 05:39:43 -0700 (PDT)
Received: from DESKTOP-MAINPC.localdomain ([14.32.250.76])
        by smtp.gmail.com with ESMTPSA id q12-20020a056a00084c00b0050a4bae6531sm2960425pfk.165.2022.04.16.05.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 05:39:43 -0700 (PDT)
From:   Donghyeok Kim <dthex5d@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mmzone: Introduce a new macro for_each_node_zonelist()
Date:   Sat, 16 Apr 2022 21:39:28 +0900
Message-Id: <20220416123930.5956-1-dthex5d@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some codes using for_each_zone_zonelist() even when only
iterating each node is needed. This commit introduces a new macro
for_each_node_zonelist() which iterates through valid nodes in the
zonelist.

By using this new macro, code can be written in a much simpler form.
Also, slab/slub can now skip trying to allocate from the node which was
previously tried and failed.

Co-developed-by: Ohhoon Kwon <ohkwon1043@gmail.com>
Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
Signed-off-by: Donghyeok Kim <dthex5d@gmail.com>
---
 include/linux/mmzone.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c           | 17 +++++++----------
 mm/mmzone.c            | 17 +++++++++++++++++
 mm/slab.c              |  7 ++-----
 mm/slub.c              |  8 ++++----
 mm/vmscan.c            | 15 ++++++---------
 6 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9aaa04ac862f..cb2ddd0b4c95 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1464,6 +1464,42 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 #define for_each_zone_zonelist(zone, z, zlist, highidx) \
 	for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, NULL)
 
+
+struct zoneref *next_node_zones_zonelist(struct zoneref *z,
+					int prev_nid,
+					enum zone_type highest_zoneidx,
+					nodemask_t *nodes);
+
+/**
+ * for_each_node_zonelist_nodemask - helper macro to iterate over valid nodes in a zonelist which have at least one zone at or below a given zone index and within a nodemask
+ * @node: The current node in the iterator
+ * @z: First matched zoneref within current node
+ * @zlist: The zonelist being iterated
+ * @highidx: The zone index of the highest zone in the node
+ * @nodemask: Nodemask allowed by the allocator
+ *
+ * This iterator iterates through all nodes which have at least one zone at or below a given zone index and
+ * within a given nodemask
+ */
+#define for_each_node_zonelist_nodemask(node, z, zlist, highidx, nodemask)		\
+	for (z = first_zones_zonelist(zlist, highidx, nodemask),			\
+			node = zonelist_zone(z) ? zonelist_node_idx(z) : NUMA_NO_NODE;	\
+		zonelist_zone(z);							\
+		z = next_node_zones_zonelist(++z, node, highidx, nodemask),		\
+			node = zonelist_zone(z) ? zonelist_node_idx(z) : NUMA_NO_NODE)
+
+/**
+ * for_each_node_zonelist - helper macro to iterate over nodes in a zonelist which have at least one zone at or below a given zone index
+ * @node: The current node in the iterator
+ * @z: First matched zoneref within current node
+ * @zlist: The zonelist being iterated
+ * @highidx: The zone index of the highest zone in the node
+ *
+ * This iterator iterates through all nodes which have at least one zone at or below a given zone index.
+ */
+#define for_each_node_zonelist(node, z, zlist, highidx) \
+	for_each_node_zonelist_nodemask(node, z, zlist, highidx, NULL)
+
 /* Whether the 'nodes' are all movable nodes */
 static inline bool movable_only_nodes(nodemask_t *nodes)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index daa4bdd6c26c..283f28f1aca8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1157,7 +1157,6 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 {
 	unsigned int cpuset_mems_cookie;
 	struct zonelist *zonelist;
-	struct zone *zone;
 	struct zoneref *z;
 	int node = NUMA_NO_NODE;
 
@@ -1165,18 +1164,16 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
+
+	/*
+	 * no need to ask again on the same node. Pool is node rather than
+	 * zone aware
+	 */
+	for_each_node_zonelist_nodemask(node, z, zonelist, gfp_zone(gfp_mask), nmask) {
 		struct page *page;
 
-		if (!cpuset_zone_allowed(zone, gfp_mask))
-			continue;
-		/*
-		 * no need to ask again on the same node. Pool is node rather than
-		 * zone aware
-		 */
-		if (zone_to_nid(zone) == node)
+		if (!cpuset_node_allowed(node, gfp_mask))
 			continue;
-		node = zone_to_nid(zone);
 
 		page = dequeue_huge_page_node_exact(h, node);
 		if (page)
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12d..8b7d6286056e 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -72,6 +72,23 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 	return z;
 }
 
+/* Returns the zone in the next node and at or below highest_zoneidx in a zonelist */
+struct zoneref *next_node_zones_zonelist(struct zoneref *z,
+					int prev_nid,
+					enum zone_type highest_zoneidx,
+					nodemask_t *nodes)
+{
+	if (likely(nodes == NULL))
+		while (z->zone && (zonelist_node_idx(z) == prev_nid || zonelist_zone_idx(z) > highest_zoneidx))
+			z++;
+	else
+		while (z->zone && (zonelist_node_idx(z) == prev_nid || zonelist_zone_idx(z) > highest_zoneidx ||
+				!zref_in_nodemask(z, nodes)))
+			z++;
+
+	return z;
+}
+
 void lruvec_init(struct lruvec *lruvec)
 {
 	enum lru_list lru;
diff --git a/mm/slab.c b/mm/slab.c
index a301f266efd1..b374fb88f80e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3077,7 +3077,6 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 {
 	struct zonelist *zonelist;
 	struct zoneref *z;
-	struct zone *zone;
 	enum zone_type highest_zoneidx = gfp_zone(flags);
 	void *obj = NULL;
 	struct slab *slab;
@@ -3096,10 +3095,8 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 	 * Look through allowed nodes for objects available
 	 * from existing per node queues.
 	 */
-	for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
-		nid = zone_to_nid(zone);
-
-		if (cpuset_zone_allowed(zone, flags) &&
+	for_each_node_zonelist(nid, z, zonelist, highest_zoneidx) {
+		if (cpuset_node_allowed(nid, flags) &&
 			get_node(cache, nid) &&
 			get_node(cache, nid)->free_objects) {
 				obj = ____cache_alloc_node(cache,
diff --git a/mm/slub.c b/mm/slub.c
index 6dc703488d30..3e8b4aa98b84 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2192,7 +2192,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
 	struct zoneref *z;
-	struct zone *zone;
+	int nid;
 	enum zone_type highest_zoneidx = gfp_zone(flags);
 	void *object;
 	unsigned int cpuset_mems_cookie;
@@ -2222,12 +2222,12 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
 		zonelist = node_zonelist(mempolicy_slab_node(), flags);
-		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
+		for_each_node_zonelist(nid, z, zonelist, highest_zoneidx) {
 			struct kmem_cache_node *n;
 
-			n = get_node(s, zone_to_nid(zone));
+			n = get_node(s, nid);
 
-			if (n && cpuset_zone_allowed(zone, flags) &&
+			if (n && cpuset_node_allowed(nid, flags) &&
 					n->nr_partial > s->min_partial) {
 				object = get_partial_node(s, n, ret_slab, flags);
 				if (object) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4a7d2bd276d..f25b71bf8f61 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6176,9 +6176,9 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 					  struct scan_control *sc)
 {
 	int initial_priority = sc->priority;
-	pg_data_t *last_pgdat;
+	pg_data_t *pgdat;
 	struct zoneref *z;
-	struct zone *zone;
+	int nid;
 retry:
 	delayacct_freepages_start();
 
@@ -6206,19 +6206,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	} while (--sc->priority >= 0);
 
 	last_pgdat = NULL;
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
+	for_each_node_zonelist_nodemask(nid, z, zonelist, sc->reclaim_idx,
 					sc->nodemask) {
-		if (zone->zone_pgdat == last_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
+		pgdat = NODE_DATA(nid);
 
-		snapshot_refaults(sc->target_mem_cgroup, zone->zone_pgdat);
+		snapshot_refaults(sc->target_mem_cgroup, pgdat);
 
 		if (cgroup_reclaim(sc)) {
 			struct lruvec *lruvec;
 
-			lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup,
-						   zone->zone_pgdat);
+			lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
 			clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
 		}
 	}
-- 
2.17.1

