Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11AD49DD00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiA0Ixa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:53:30 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40747 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237943AbiA0IxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:53:20 -0500
Received: by mail-ed1-f49.google.com with SMTP id w25so1795880edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2zfZ9y8ubmSsgs0imIlAZWCHpb/2emUUUVSrMtiaz8=;
        b=FilsinnH5AaHP3VrnfjB4T1dkHi7XVw2dVk7T9XDMmjlVpSifx5LMYykN7c8EuZ+7z
         m62rdmVWRfGCmSc1m+334WkByTlyDFOlEyhhhPVN2heSzlpwSEbE1jg9W7rX+LsR1nwJ
         +DvHm9Dl8QMPAYl38cg6NrT9Tr2X6TuTdNb9o5wth0nmqXbxR5m5BL07TFOo4zperxpv
         JSeySWvzba85yWELk0S9D44sxitwtEtL6K2/Zs+hXYauyrdZ6/UvTjH4FKTRYj65P/i0
         tkgp2U7toKBcE/xI4ep1qg526wPTEUbRVNfedZ0CzL3rL6jylrHSwOFz0bryuFuXssD/
         lXzA==
X-Gm-Message-State: AOAM5330L4WJD1vkXhKzOyOZDo9Dx+9QtrSVEzrbA0T6n9iawEecsY7X
        CuqE3uMkqW6ktVnnmaVBy40=
X-Google-Smtp-Source: ABdhPJwqBhWAjvbeH+BW4ztneuZOZmY0mmUJv1AptsP99+eWvmD466zGqb52l7t35QkusOe+F+8KHQ==
X-Received: by 2002:a05:6402:2750:: with SMTP id z16mr2734834edd.312.1643273599208;
        Thu, 27 Jan 2022 00:53:19 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-47-31.eurotel.cz. [85.160.47.31])
        by smtp.gmail.com with ESMTPSA id n11sm11029757edv.52.2022.01.27.00.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:53:18 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 4/6] mm, memory_hotplug: reorganize new pgdat initialization
Date:   Thu, 27 Jan 2022 09:53:03 +0100
Message-Id: <20220127085305.20890-5-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127085305.20890-1-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
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

Acked-by: Rafael Aquini <raquini@redhat.com>
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
index 875cdc7ffa58..ddc62f8b591f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1166,39 +1166,16 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
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
@@ -1210,6 +1187,7 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	 * When memory is hot-added, all the memory is in offline state. So
 	 * clear all zones' present_pages because they will be updated in
 	 * online_pages() and offline_pages().
+	 * TODO: should be in free_area_init_core_hotplug?
 	 */
 	reset_node_managed_pages(pgdat);
 	reset_node_present_pages(pgdat);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1a05669044d3..32d0189de4c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7506,12 +7506,33 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
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

