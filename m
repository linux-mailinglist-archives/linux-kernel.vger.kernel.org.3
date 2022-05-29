Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E353704E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiE2IP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 04:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiE2IPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 04:15:45 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D854B434
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:15:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VEe4qOs_1653812139;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VEe4qOs_1653812139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 29 May 2022 16:15:40 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/slub: add nr_full count for debugging slub
Date:   Sun, 29 May 2022 16:15:35 +0800
Message-Id: <20220529081535.69275-3-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The n->nr_slabs will be updated when really to allocate or
free a slab, but this slab is not necessarily in full list
or partial list of one node. That means the total count of
slab in node's full and partial list is not necessarily equal
to n->nr_slabs, even though flush_all() has been called.

An example here, an error message likes below will be
printed when 'slabinfo -v' is executed:

SLUB: kmemleak_object 4157 slabs counted but counter=4161
SLUB: kmemleak_object 4072 slabs counted but counter=4077
SLUB: kmalloc-2k 19 slabs counted but counter=20
SLUB: kmalloc-2k 12 slabs counted but counter=13
SLUB: kmemleak_object 4205 slabs counted but counter=4209

Here, nr_full is introduced in kmem_cache_node, to replace
nr_slabs and eliminate these confusing messages.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/slab.h |  1 +
 mm/slub.c | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 95eb34174c1b..b1190e41a243 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -782,6 +782,7 @@ struct kmem_cache_node {
 	unsigned long nr_partial;
 	struct list_head partial;
 #ifdef CONFIG_SLUB_DEBUG
+	unsigned long nr_full;
 	atomic_long_t nr_slabs;
 	atomic_long_t total_objects;
 	struct list_head full;
diff --git a/mm/slub.c b/mm/slub.c
index bffb95bbb0ee..99e980c8295c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1220,6 +1220,9 @@ static void add_full(struct kmem_cache *s,
 
 	lockdep_assert_held(&n->list_lock);
 	list_add(&slab->slab_list, &n->full);
+#ifdef CONFIG_SLUB_DEBUG
+	n->nr_full++;
+#endif
 }
 
 static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct slab *slab)
@@ -1229,6 +1232,9 @@ static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct
 
 	lockdep_assert_held(&n->list_lock);
 	list_del(&slab->slab_list);
+#ifdef CONFIG_SLUB_DEBUG
+	n->nr_full--;
+#endif
 }
 
 /* Tracking of the number of slabs for debugging purposes */
@@ -3880,6 +3886,7 @@ init_kmem_cache_node(struct kmem_cache_node *n)
 	INIT_LIST_HEAD(&n->partial);
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_set(&n->nr_slabs, 0);
+	n->nr_full = 0;
 	atomic_long_set(&n->total_objects, 0);
 	INIT_LIST_HEAD(&n->full);
 #endif
@@ -4994,9 +5001,30 @@ static int validate_slab_node(struct kmem_cache *s,
 	unsigned long count = 0;
 	struct slab *slab;
 	unsigned long flags;
+	unsigned long nr_cpu_slab = 0, nr_cpu_partial = 0;
+	int cpu;
 
 	spin_lock_irqsave(&n->list_lock, flags);
 
+	for_each_possible_cpu(cpu) {
+		struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
+		struct slab *slab;
+
+		slab = READ_ONCE(c->slab);
+		if (slab && n == get_node(s, slab_nid(slab)))
+				nr_cpu_slab += 1;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+		slab = slub_percpu_partial_read_once(c);
+		if (slab && n == get_node(s, slab_nid(slab)))
+			nr_cpu_partial += slab->slabs;
+#endif
+	}
+	if (nr_cpu_slab || nr_cpu_partial) {
+		pr_err("SLUB %s: %ld cpu slabs and %ld cpu partial slabs counted\n",
+		       s->name, nr_cpu_slab, nr_cpu_partial);
+		slab_add_kunit_errors();
+	}
+
 	list_for_each_entry(slab, &n->partial, slab_list) {
 		validate_slab(s, slab, obj_map);
 		count++;
@@ -5010,13 +5038,14 @@ static int validate_slab_node(struct kmem_cache *s,
 	if (!(s->flags & SLAB_STORE_USER))
 		goto out;
 
+	count = 0;
 	list_for_each_entry(slab, &n->full, slab_list) {
 		validate_slab(s, slab, obj_map);
 		count++;
 	}
-	if (count != atomic_long_read(&n->nr_slabs)) {
+	if (count != n->nr_full) {
 		pr_err("SLUB: %s %ld slabs counted but counter=%ld\n",
-		       s->name, count, atomic_long_read(&n->nr_slabs));
+		       s->name, count, n->nr_full);
 		slab_add_kunit_errors();
 	}
 
-- 
2.27.0

