Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436D847C8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhLUVxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUVxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:53:50 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C202FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 13:53:49 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q2-20020a056a00084200b004a2582fcec1so267576pfk.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 13:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ubsJbz4XTDj0Y8BVp+tyzvUQoOJ8p9o6eKqcemly/7o=;
        b=cN60PblALTbqNU/fDADDM/JTRbZx6LxiU706eGsSoWw9mgARm1kVuelsKrgV+Dqcyd
         xuOqqKM+yLG689hUnCvrrE4AEZKqY60WwsifQDci0DtqnpE13rVnj81Z7sE+rI+qXl47
         F8vrDQREIceKqe2mi5xX4Qao7BTG29zt2btQWg+Ws0ea6pee8KXO+bEhvVx10gG2KJHC
         EbG5ekDDHfBMF0kbIBZLzBV/lgvyDvNTLgm0LivY5CZRzTYG5I0htgUYw7bSM7y595NZ
         kv20cpVlNcJQbHS1m5GXgJ7FC96sAJPYkepFIQnMJnwikBAKJnffPq0XwnqflD1RYgL1
         EaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ubsJbz4XTDj0Y8BVp+tyzvUQoOJ8p9o6eKqcemly/7o=;
        b=s/M2q5RPY954iMqc0+NDi46cJMqlO+qc/ye40J1mviZqORjT+q0e1Fn7cT+tjWy9LU
         JlZOQr6bhRhjw/Ryx+22do8h7yW8AmJnOb8PlKdA7XzvKhS7HTeEQagW31HCe8DRQ6br
         5wbs4l8/RWN+XPNUQsvvDfLSfWgoch4ZoFL36PIBYyJcYDtHTttsXKS3r01NUVT1kkZW
         p9xbtp/Hh2Jbe9IEoI3XV3bBlk73Bmm+d/3Ry0lJAQG3FBRqXylnkkWhkTgg530R3XBB
         WajwNPJtKMZRvtXZICLAx/LZVKKH+XibEgz3qe43uRwNfIbxGSnUQxhNb8TYiQEgzEk9
         Vzpg==
X-Gm-Message-State: AOAM530b8+zRoLFg2yXmxytsME94muTCRcLEXdx8+JHluP37dOyvT2kt
        2mveEUR5p9ePCgD5zFGO9xNlVtVlqqplqg==
X-Google-Smtp-Source: ABdhPJwWQi4/qgSn1GBR6R+WRdImbaFdH+zC3nALV07H9X3SgI2Ua9OoL/cJh1NASCoZBq4z+v+SX11BJzWWsw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:fbbb:6368:35d1:5ac2])
 (user=shakeelb job=sendgmr) by 2002:a17:902:e843:b0:148:f219:afb7 with SMTP
 id t3-20020a170902e84300b00148f219afb7mr73688plg.81.1640123629026; Tue, 21
 Dec 2021 13:53:49 -0800 (PST)
Date:   Tue, 21 Dec 2021 13:53:36 -0800
Message-Id: <20211221215336.1922823-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH] memcg: add per-memcg vmalloc stat
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
 Documentation/admin-guide/cgroup-v2.rst |  3 +++
 include/linux/memcontrol.h              | 15 +++++++++++++++
 mm/memcontrol.c                         |  1 +
 mm/vmalloc.c                            |  5 +++++
 4 files changed, 24 insertions(+)

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
index d76dad703580..000bfad6ff69 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -33,6 +33,7 @@ enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
+	MEMCG_VMALLOC,
 	MEMCG_NR_STAT,
 };
 
@@ -944,6 +945,15 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 	local_irq_restore(flags);
 }
 
+static inline void mod_memcg_page_state(struct page *page,
+					int idx, int val)
+{
+	struct mem_cgroup *memcg = page_memcg(page);
+
+	if (!mem_cgroup_disabled() && memcg)
+		mod_memcg_state(memcg, idx, val);
+}
+
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
 	return READ_ONCE(memcg->vmstats.state[idx]);
@@ -1399,6 +1409,11 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
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

