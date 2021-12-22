Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1047CCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 06:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhLVFZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 00:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhLVFZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 00:25:18 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A50C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:25:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 62-20020a630641000000b0033ab7698954so777200pgg.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V7NKgx+P49cXgQMHOCdgsm/aqsZCXHZS2DX/PC1OjLU=;
        b=OsycMK/PN2uUT3buihQUWnbvxxmeuNFWvw/y7LbM3119dlKMLvf9KJlgfWiNNd8XCs
         dIzeudPPN0sE/tqL5sBEKs7neYdm5J4iNHzuUwPrv70hjGPft9CXb02quVfA7+LPxE1J
         UDh7YvT9e8gWSvUkjk+OXvptZuJWRKXWN0FU1gEnq8cRQPsFdw30EAqaEvQS579QXQts
         7D37mMKZ0HXJYQ5dJzb7PB2ON+aj/fGtZ9AnyWSTr3dPB8ND649Ie1CfoUyQtQKWgGyR
         oL5u+JRYBl8VWURRXnXEZTWnS6scb+N7uUr8ofXhg7M2I+6WT69AJ1ZtZyrMhDRJsDYx
         7AzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V7NKgx+P49cXgQMHOCdgsm/aqsZCXHZS2DX/PC1OjLU=;
        b=akpsLP9BsaHZY6dkPYMBYWfjT2OrGxKSA11PYEvVpmiU4TpocOFpg+2NLhH09sPj/v
         sw5IynqA7ZJRwnWkV9x2AO99c4x07QWkFsPbHu9k2huwDTpAC/plcDuoIPsLx7ziPpT4
         XaD7A/uwn8aldKSq19nCzR+RhsVQdkoFzEcq43OcF3pAatl/43SsWaiwkacrPrIcouhW
         YoTUuedE0cuntfJUQZA3vJbSRm25wz0n6gX+Y44jTkK2EUpYVE9pcCAPmzpaPUYY7BIM
         g1/8drcuy/ZAWO7cH9K019Qb/9N/U7yuf7p/IZyHCPcukituV/YAhYflXbWrDVsdIfwQ
         C3dw==
X-Gm-Message-State: AOAM530uDWp/pIhrL97U5dQG2KYPj4wkqACsudHJxkKT9xvCTSKWuQ8d
        a5W4FvkhbgReHIJBTqrAsD9OIYD7/d42Qw==
X-Google-Smtp-Source: ABdhPJzLJrpINbxDAbJckAXrx2QrhzFGsUj57mjOT3Xrhi6lGorvxNt9hXxVYMQUdKNYCLqdc3/ErRK3KAiDqA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:fbbb:6368:35d1:5ac2])
 (user=shakeelb job=sendgmr) by 2002:a17:902:9b8f:b0:142:7999:67fb with SMTP
 id y15-20020a1709029b8f00b00142799967fbmr1256736plp.24.1640150717444; Tue, 21
 Dec 2021 21:25:17 -0800 (PST)
Date:   Tue, 21 Dec 2021 21:24:57 -0800
Message-Id: <20211222052457.1960701-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2] memcg: add per-memcg vmalloc stat
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

---
Changelog since v1:
- page_memcg() within rcu lock as suggested by Muchun.

 Documentation/admin-guide/cgroup-v2.rst |  3 +++
 include/linux/memcontrol.h              | 21 +++++++++++++++++++++
 mm/memcontrol.c                         |  1 +
 mm/vmalloc.c                            |  5 +++++
 4 files changed, 30 insertions(+)

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
index 7ae77608847e..7027a3cc416f 100644
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
index eb6e527a6b77..af67ce4fd402 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -39,6 +39,7 @@
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
+#include <linux/memcontrol.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -2626,6 +2627,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
 		unsigned int page_order = vm_area_page_order(area);
 		int i;
 
+		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
+				     -(int)area->nr_pages);
+
 		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
 			struct page *page = area->pages[i];
 
@@ -2964,6 +2968,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
+	mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC, area->nr_pages);
 
 	/*
 	 * If not enough pages were obtained to accomplish an
-- 
2.34.1.307.g9b7440fafd-goog

