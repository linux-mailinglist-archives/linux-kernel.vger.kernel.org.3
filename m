Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E727E546C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbiFJSDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346245AbiFJSDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:03:24 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997956157
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:03:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654884200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n7eiALpPTcznIaF/fXFxgNtbZ4SHuwV6uZfI15xSoCI=;
        b=qcKvBzgxPkVHmma3sPc0dSPROIntT65cSF8/Y4tzMUDAecGTQAoT+9O2+GP21fIEJNkMF5
        66GK6N8tnp/19FlzaLx21Ewi/0SOlakp+94UJJ9V8gegQ7i2Xd92K68bLozVoSCqdjRbrA
        cujBBXBgiXVX3OzcnID0cXvD8IyQyr4=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] mm: kmem: make mem_cgroup_from_obj() vmalloc()-safe
Date:   Fri, 10 Jun 2022 11:03:10 -0700
Message-Id: <20220610180310.1725111-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently mem_cgroup_from_obj() is not working properly with objects
allocated using vmalloc(). It creates problems in some cases, when
it's called for static objects belonging to  modules or generally
allocated using vmalloc().

This patch makes mem_cgroup_from_obj() safe to be called on objects
allocated using vmalloc().

It also introduces mem_cgroup_from_slab_obj(), which is a faster
version to use in places when we know the object is either a slab
object or a generic slab page (e.g. when adding an object to a lru
list).

Suggested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |  6 ++++
 mm/list_lru.c              |  2 +-
 mm/memcontrol.c            | 71 +++++++++++++++++++++++++++-----------
 3 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0d7584e2f335..4d31ce55b1c0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1761,6 +1761,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 }
 
 struct mem_cgroup *mem_cgroup_from_obj(void *p);
+struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
 
 static inline void count_objcg_event(struct obj_cgroup *objcg,
 				     enum vm_event_item idx)
@@ -1858,6 +1859,11 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	return NULL;
 }
 
+static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
+{
+	return NULL;
+}
+
 static inline void count_objcg_event(struct obj_cgroup *objcg,
 				     enum vm_event_item idx)
 {
diff --git a/mm/list_lru.c b/mm/list_lru.c
index ba76428ceece..a05e5bef3b40 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -71,7 +71,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 	if (!list_lru_memcg_aware(lru))
 		goto out;
 
-	memcg = mem_cgroup_from_obj(ptr);
+	memcg = mem_cgroup_from_slab_obj(ptr);
 	if (!memcg)
 		goto out;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4093062c5c9b..8c408d681377 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -783,7 +783,7 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 	struct lruvec *lruvec;
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_obj(p);
+	memcg = mem_cgroup_from_slab_obj(p);
 
 	/*
 	 * Untracked pages have no memcg, no lruvec. Update only the
@@ -2833,27 +2833,9 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
 	return 0;
 }
 
-/*
- * Returns a pointer to the memory cgroup to which the kernel object is charged.
- *
- * A passed kernel object can be a slab object or a generic kernel page, so
- * different mechanisms for getting the memory cgroup pointer should be used.
- * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
- * can not know for sure how the kernel object is implemented.
- * mem_cgroup_from_obj() can be safely used in such cases.
- *
- * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
- * cgroup_mutex, etc.
- */
-struct mem_cgroup *mem_cgroup_from_obj(void *p)
+static __always_inline
+struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 {
-	struct folio *folio;
-
-	if (mem_cgroup_disabled())
-		return NULL;
-
-	folio = virt_to_folio(p);
-
 	/*
 	 * Slab objects are accounted individually, not per-page.
 	 * Memcg membership data for each individual object is saved in
@@ -2886,6 +2868,53 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	return page_memcg_check(folio_page(folio, 0));
 }
 
+/*
+ * Returns a pointer to the memory cgroup to which the kernel object is charged.
+ *
+ * A passed kernel object can be a slab object, vmalloc object or a generic
+ * kernel page, so different mechanisms for getting the memory cgroup pointer
+ * should be used.
+ *
+ * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
+ * can not know for sure how the kernel object is implemented.
+ * mem_cgroup_from_obj() can be safely used in such cases.
+ *
+ * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
+ * cgroup_mutex, etc.
+ */
+struct mem_cgroup *mem_cgroup_from_obj(void *p)
+{
+	struct folio *folio;
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	if (unlikely(is_vmalloc_addr(p)))
+		folio = page_folio(vmalloc_to_page(p));
+	else
+		folio = virt_to_folio(p);
+
+	return mem_cgroup_from_obj_folio(folio, p);
+}
+
+/*
+ * Returns a pointer to the memory cgroup to which the kernel object is charged.
+ * Similar to mem_cgroup_from_obj(), but faster and not suitable for objects,
+ * allocated using vmalloc().
+ *
+ * A passed kernel object must be a slab object or a generic kernel page.
+ *
+ * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
+ * cgroup_mutex, etc.
+ */
+struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
+{
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	return mem_cgroup_from_obj_folio(virt_to_folio(p), p);
+}
+
 static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg = NULL;
-- 
2.35.3

