Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8290D484AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiADWYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiADWYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:24:14 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB42FC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:24:14 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h33-20020a17090a29a400b001b20b7d48dfso24852667pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7YCEEnOPj4KefNq/L+wc30dtC7OQCX+FrwepcfjVLCk=;
        b=i/4d5jHHzbNLD0plqavS+PSO1WxSe0NYT9QbWG0z3poJM5oXjubaAcJxaiWWreP0cR
         5RiMCt5v4DQTomdHVkq3iLNdYX/yVKtHxPDMl0I2XHVIuxuFSqZGpHeGMYz88UG7O0Xu
         r9RMfDw8lVa4ABXKEpKplbdcb/JYd+BYaRDzoBG8Fr3Bxq/Fuv6XAleGIBpGAsP24c2L
         HqWZEkpkGx0zcwj6E2VFzL8t+653tIMfzyZ7+Kfvyk9YsriAmimD4EL1W9ulKiubY+wC
         kTTycdGDGkg1fP1SB4auPTUcB25a0h9QpzkssNErteZUcjHkYQW6SJMRWAO3Yz3vGlS4
         Lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7YCEEnOPj4KefNq/L+wc30dtC7OQCX+FrwepcfjVLCk=;
        b=FYIontelbIkeh2CaGPO9xSTDxxYePXivOGH9GP6yqbxOwk/SLKRPufAEEWflc1XFDz
         K0MWTZYj7qK/GVkjGFrTrkhNuB56lUKyA0H4k8RlIrv6JDPn0srTBHCC68thnhmuNTnJ
         FuJzdc3u4tv2oHDqPBmyP+lSPK40rlNdPU5r4C6Ud7sML6Fz9tEYqjEUhQXM+FykvvMr
         53pfOvJWD7x3lm75vofMGB3cl5LjcY8f9B6xdgoSeb91ZiFsGxAx7jFyIuMVDj3pDVMW
         k3v72i1Iaq56pEwNJvB1aZEtgRpw9T0YWp0Mn4LJXX3mcmx8wamioN+HELxdnrDigrcE
         pMlA==
X-Gm-Message-State: AOAM53013TAl+H+icEngj01qgKK/L3TnS4Lz64nZ+BVoEtrEH85X/eVF
        z7xV2fZyAQ73ir9fAcMN315AqrpW8fVe9A==
X-Google-Smtp-Source: ABdhPJxu2rUxV1GLYPjz1MbyUkhsmMVGZu7fNO7fjMU2hGoO4haOYMv5RYTU3zN2gckKhL0PGXE0N4uc4PQ3Fg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:15c6:5bd2:a484:dc2e])
 (user=shakeelb job=sendgmr) by 2002:a63:2c06:: with SMTP id
 s6mr44845822pgs.55.1641335054261; Tue, 04 Jan 2022 14:24:14 -0800 (PST)
Date:   Tue,  4 Jan 2022 14:23:41 -0800
Message-Id: <20220104222341.3972772-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4] memcg: add per-memcg vmalloc stat
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvmalloc* allocation functions can fallback to vmalloc allocations
and more often on long running machines. In addition the kernel does
have __GFP_ACCOUNT kvmalloc* calls. So, often on long running machines,
the memory.stat does not tell the complete picture which type of memory
is charged to the memcg. So add a per-memcg vmalloc stat.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>

---
Changes since v3:
- Removed area->page[0] checks and moved to page by page accounting as
  suggested by Michal

Changes since v2:
- remove cast, per Muchun
- add area->page[0] check, per Michal

Changes since v1:
- page_memcg() within rcu lock as suggested by Muchun.

 Documentation/admin-guide/cgroup-v2.rst |  3 +++
 include/linux/memcontrol.h              | 21 +++++++++++++++++++++
 mm/memcontrol.c                         |  1 +
 mm/vmalloc.c                            | 13 +++++++++++--
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 82c8dc91b2be..5aa368d165da 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1314,6 +1314,9 @@ PAGE_SIZE multiple when read back.
 	  sock (npn)
 		Amount of memory used in network transmission buffers
 
+	  vmalloc (npn)
+		Amount of memory used for vmap backed memory.
+
 	  shmem
 		Amount of cached filesystem data that is swap-backed,
 		such as tmpfs, shm segments, shared anonymous mmap()s
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d76dad703580..b72d75141e12 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -33,6 +33,7 @@ enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
+	MEMCG_VMALLOC,
 	MEMCG_NR_STAT,
 };
 
@@ -944,6 +945,21 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 	local_irq_restore(flags);
 }
 
+static inline void mod_memcg_page_state(struct page *page,
+					int idx, int val)
+{
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	rcu_read_lock();
+	memcg = page_memcg(page);
+	if (memcg)
+		mod_memcg_state(memcg, idx, val);
+	rcu_read_unlock();
+}
+
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
 	return READ_ONCE(memcg->vmstats.state[idx]);
@@ -1399,6 +1415,11 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 {
 }
 
+static inline void mod_memcg_page_state(struct page *page,
+					int idx, int val)
+{
+}
+
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 101b22a23096..56ed6b5dd328 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1375,6 +1375,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "pagetables",			NR_PAGETABLE			},
 	{ "percpu",			MEMCG_PERCPU_B			},
 	{ "sock",			MEMCG_SOCK			},
+	{ "vmalloc",			MEMCG_VMALLOC			},
 	{ "shmem",			NR_SHMEM			},
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index eb6e527a6b77..bdc7222f87d4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -31,6 +31,7 @@
 #include <linux/kmemleak.h>
 #include <linux/atomic.h>
 #include <linux/compiler.h>
+#include <linux/memcontrol.h>
 #include <linux/llist.h>
 #include <linux/bitops.h>
 #include <linux/rbtree_augmented.h>
@@ -2624,12 +2625,13 @@ static void __vunmap(const void *addr, int deallocate_pages)
 
 	if (deallocate_pages) {
 		unsigned int page_order = vm_area_page_order(area);
-		int i;
+		int i, step = 1U << page_order;
 
-		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
+		for (i = 0; i < area->nr_pages; i += step) {
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
+			mod_memcg_page_state(page, MEMCG_VMALLOC, -step);
 			__free_pages(page, page_order);
 			cond_resched();
 		}
@@ -2964,6 +2966,13 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
+	if (gfp_mask & __GFP_ACCOUNT) {
+		int i, step = 1U << page_order;
+
+		for (i = 0; i < area->nr_pages; i += step)
+			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC,
+					     step);
+	}
 
 	/*
 	 * If not enough pages were obtained to accomplish an
-- 
2.34.1.448.ga2b2bfdf31-goog

