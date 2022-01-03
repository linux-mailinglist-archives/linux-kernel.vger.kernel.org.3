Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A05482DBD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiACENO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiACENL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:13:11 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956C4C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 20:13:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y5-20020a17090a390500b001b2b8bb4e3dso10327303pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 20:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J9aTg2q8ho8nlKd2CqNm+FPuVckykKn3uxZlvv9q2ak=;
        b=coIf9+TOHEbp+XchpgnvOTa1hvvpKrDThLnG6uNK8dJrE5l+yINOS3aQszuxAaK5PD
         AKFzwzVQViOTK8rUkKsIOSYOY9ia7sN8iW8JKcUegq+QQ/Pae0KC5B6u2J3Fbr/fLSgP
         0+A5cZCM3KjtRnb+jeo7oDHpJdcsEV6uy3aq/Y4WtUSpyj0tsmmcuncu2rfAvry9WVkj
         UoybVhRKwqFWRiG+sPdGSNgf736QZ1DAYciOMoV6YB4V8rjKsXe8QX7OnfRlPb/Yboga
         DWG62oojWxldOw8nVoT3KkiWK2UG2JKt4ip3SYslr/32i4kNbQC3mAIqx/yRX7ujMf3O
         6xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J9aTg2q8ho8nlKd2CqNm+FPuVckykKn3uxZlvv9q2ak=;
        b=kBc9Kog7LWvVj2HAgGIeEWqoShyzdQRMcIQDN/IgTeuRoYwH8nhEg1qSrwc3qSQqMi
         PiaqxUqr7+/wtXX4A8HsI4U2c5EpDx/6UJ9laoJ7qfdebQJ2uWP7CHwUmDeIm4WOU1O5
         Ki93x8OYIlvRzHSpd2sfL/WHfMs/ojQ5qJ1jmGZiNIw8Jsy4zXNcUZaBEQ0E/UP558Ce
         YRRF+B7QZxWSpCXzK3V02q60go+B4w9cnBI1U4C+FnZnwNJJNevCd9CoKmnl55tuZrTz
         ZCz6l+M/qZ20OI5ZEVtiVBAFGPQnY+sqxekDFci2JCodl8ny9A4I+AOuOtPKGSUZqZ3s
         f5ew==
X-Gm-Message-State: AOAM5318ut/dWkykU7fqczAJcYM+vEve+rHLAOAbibAAU1Xf9eUN4+er
        UzHhm+EbH41QZn+J2i2iLHGqhTYemz26MA==
X-Google-Smtp-Source: ABdhPJyw2vsxbvj66mdsaLk1TQqw9ZzFjqHP/n9r3fIOGWN+nOs85+AG28saBH9H0+X8Xf8oeInEcuiLWPEBUw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:7799:a7c5:d062:a865])
 (user=shakeelb job=sendgmr) by 2002:a63:3e8a:: with SMTP id
 l132mr12917906pga.517.1641183191099; Sun, 02 Jan 2022 20:13:11 -0800 (PST)
Date:   Sun,  2 Jan 2022 20:12:52 -0800
Message-Id: <20220103041252.3778239-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3] memcg: add per-memcg vmalloc stat
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
Changes since v2:
- remove cast, per Muchun
- add area->page[0] check, per Michal

Changes since v1:
- page_memcg() within rcu lock as suggested by Muchun.

 Documentation/admin-guide/cgroup-v2.rst |  3 +++
 include/linux/memcontrol.h              | 21 +++++++++++++++++++++
 mm/memcontrol.c                         |  1 +
 mm/vmalloc.c                            |  8 ++++++++
 4 files changed, 33 insertions(+)

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
index eb6e527a6b77..2809cb696e5c 100644
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
@@ -2626,6 +2627,10 @@ static void __vunmap(const void *addr, int deallocate_pages)
 		unsigned int page_order = vm_area_page_order(area);
 		int i;
 
+		if (area->pages[0])
+			mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
+					     -area->nr_pages);
+
 		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
 			struct page *page = area->pages[i];
 
@@ -2964,6 +2969,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
+	if (area->pages[0])
+		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
+				     area->nr_pages);
 
 	/*
 	 * If not enough pages were obtained to accomplish an
-- 
2.34.1.448.ga2b2bfdf31-goog

