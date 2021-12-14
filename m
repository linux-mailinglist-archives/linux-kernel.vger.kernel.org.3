Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E819E474018
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhLNKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:08:00 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40756 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhLNKHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:07:53 -0500
Received: by mail-ed1-f52.google.com with SMTP id r25so60658293edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5o2NK6YHd8eX0YP1l3an8Qf+Gu8tW7bjsRAwlkbqDyM=;
        b=HhRzrDzK8MsAPQCbYBZWOH6c5Aa2v9Cn9yIsuJlDRKMzN7M2s3wF2UXBEnKGj9giIU
         w3xx5BCv8Dq+dUOVGZNA6pdNnWbJwYyt4Ios+l2JtmDBOEciqLk3lFCCGVJGTWmLTgVQ
         daTmWHVXWLJTxenxXfGPU+qXB8OlMQNkjCpF1H8KBSebOIV1dQW11gAzDuJWwC/IAxXf
         vUXfgDTGJNGaN1WrlFKXW5WqaxofzdJuZkYHU2TZHibPXb3o1q1rl249Ey0Pyc0IfaO8
         Qg/BDOseFvg9nySVhJglN5HU5czdmCkriRNBtvmIMMFIrsr5K+ANS1064QnFLLaxAJSS
         8g+g==
X-Gm-Message-State: AOAM532TYexGUbs4Z5U+VobhanXsah0qqvDClMC7ZyP70v15s8IALPHV
        YdB6Zb04SufhTLWFMLNDmJw=
X-Google-Smtp-Source: ABdhPJwOvUVPdu7YJebj4d7USh/r5QZ7K79q+LZVd0FsZw7lIxbd0mXn+8m4oS2T43q1vLgo1XjUdQ==
X-Received: by 2002:a17:907:ea3:: with SMTP id ho35mr4738765ejc.583.1639476471887;
        Tue, 14 Dec 2021 02:07:51 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id f5sm839766ejl.219.2021.12.14.02.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 02:07:51 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 4/4] mm, memory_hotplug: reorganize new pgdat initialization
Date:   Tue, 14 Dec 2021 11:07:32 +0100
Message-Id: <20211214100732.26335-5-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214100732.26335-1-mhocko@kernel.org>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

When a !node_online node is brought up it needs a hotplug specific
initialization because the node could be either uninitialized yet or it
could have been recycled after previous hotremove. hotadd_init_pgdat is
responsible for that.

Internal pgdat state is initialized at two places currently
	- hotadd_init_pgdat
	- free_area_init_core_hotplug
There is no real clear cut what should go where but this patch's chosen to
move the whole internal state initialization into free_area_init_core_hotplug.
hotadd_init_pgdat is still responsible to pull all the parts together -
most notably to initialize zonelists because those depend on the overall topology.

This patch doesn't introduce any functional change.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 28 +++-------------------------
 mm/page_alloc.c                | 25 +++++++++++++++++++++++--
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 60f09d3ebb3d..76bf2de86def 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -319,7 +319,7 @@ extern void set_zone_contiguous(struct zone *zone);
 extern void clear_zone_contiguous(struct zone *zone);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern void __ref free_area_init_core_hotplug(int nid);
+extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
 extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory_resource(int nid, struct resource *resource,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2daa88ce8c80..ddae307152b8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1165,39 +1165,16 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 {
 	struct pglist_data *pgdat;
 
-	pgdat = NODE_DATA(nid);
-
 	/*
 	 * NODE_DATA is preallocated (free_area_init) but its internal
 	 * state is not allocated completely. Add missing pieces.
 	 * Completely offline nodes stay around and they just need
 	 * reintialization.
 	 */
-	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
-		pgdat->per_cpu_nodestats =
-			alloc_percpu(struct per_cpu_nodestat);
-	} else {
-		int cpu;
-		/*
-		 * Reset the nr_zones, order and highest_zoneidx before reuse.
-		 * Note that kswapd will init kswapd_highest_zoneidx properly
-		 * when it starts in the near future.
-		 */
-		pgdat->nr_zones = 0;
-		pgdat->kswapd_order = 0;
-		pgdat->kswapd_highest_zoneidx = 0;
-		for_each_online_cpu(cpu) {
-			struct per_cpu_nodestat *p;
-
-			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
-			memset(p, 0, sizeof(*p));
-		}
-	}
-
-	pgdat->node_start_pfn = 0;
+	pgdat = NODE_DATA(nid);
 
 	/* init node's zones as empty zones, we don't have any present pages.*/
-	free_area_init_core_hotplug(nid);
+	free_area_init_core_hotplug(pgdat);
 
 	/*
 	 * The node we allocated has no zone fallback lists. For avoiding
@@ -1209,6 +1186,7 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	 * When memory is hot-added, all the memory is in offline state. So
 	 * clear all zones' present_pages because they will be updated in
 	 * online_pages() and offline_pages().
+	 * TODO: should be in free_area_init_core_hotplug?
 	 */
 	reset_node_managed_pages(pgdat);
 	reset_node_present_pages(pgdat);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f2ceffadf4eb..34743dcd2d66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7442,12 +7442,33 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
  * NOTE: this function is only called during memory hotplug
  */
 #ifdef CONFIG_MEMORY_HOTPLUG
-void __ref free_area_init_core_hotplug(int nid)
+void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 {
+	int nid = pgdat->node_id;
 	enum zone_type z;
-	pg_data_t *pgdat = NODE_DATA(nid);
+	int cpu;
 
 	pgdat_init_internals(pgdat);
+
+	if (pgdat->per_cpu_nodestats == &boot_nodestats)
+		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
+
+	/*
+	 * Reset the nr_zones, order and highest_zoneidx before reuse.
+	 * Note that kswapd will init kswapd_highest_zoneidx properly
+	 * when it starts in the near future.
+	 */
+	pgdat->nr_zones = 0;
+	pgdat->kswapd_order = 0;
+	pgdat->kswapd_highest_zoneidx = 0;
+	pgdat->node_start_pfn = 0;
+	for_each_online_cpu(cpu) {
+		struct per_cpu_nodestat *p;
+
+		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+		memset(p, 0, sizeof(*p));
+	}
+
 	for (z = 0; z < MAX_NR_ZONES; z++)
 		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
 }
-- 
2.30.2

