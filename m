Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3684A404F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358249AbiAaKes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:34:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47256 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358237AbiAaKeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:34:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 686661F380;
        Mon, 31 Jan 2022 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643625285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZUj/hEJRltgUM8RuJLw4DBgkvv6YcpTRqeqZnz+HL0=;
        b=XzjRC45lNozO6K4KXH4qdUUjOq0MXRIu1J2mUkUJzbSeywWWaY8utwtkMOxWe8qjg6ge8O
        LtH3lPbe2zFe7CSG1wm7PnO5HSbOojT/eMNYgOl+sVNeKe0fKIcpO6n6yrMX63zgnVC98B
        JMKCDSqx43oAvV9wR8WV7C6vTfXIcKY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 38863A3B93;
        Mon, 31 Jan 2022 10:34:45 +0000 (UTC)
Date:   Mon, 31 Jan 2022 11:34:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-ID: <Yfe7RBeLCijnWBON@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-3-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of the patch including acks and reviews. All
other patches in this series have only got acks and reviews at this
stage so I am not reposting the full bunch. Please add to the MM tree
Andrew. Thanks!
---
From ad93c2641c4073213a0f9f0d0cd5286aff0de8e0 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 9 Dec 2021 10:00:02 +0100
Subject: [PATCH] mm: handle uninitialized numa nodes gracefully

We have had several reports [1][2][3] that page allocator blows up when
an allocation from a possible node is requested. The underlying reason
is that NODE_DATA for the specific node is not allocated.

NUMA specific initialization is arch specific and it can vary a lot.
E.g. x86 tries to initialize all nodes that have some cpu affinity (see
init_cpu_to_node) but this can be insufficient because the node might be
cpuless for example.

One way to address this problem would be to check for !node_online nodes
when trying to get a zonelist and silently fall back to another node.
That is unfortunately adding a branch into allocator hot path and it
doesn't handle any other potential NODE_DATA users.

This patch takes a different approach (following a lead of [3]) and it
pre allocates pgdat for all possible nodes in an arch indipendent code
- free_area_init. All uninitialized nodes are treated as memoryless
nodes. node_state of the node is not changed because that would lead to
other side effects - e.g. sysfs representation of such a node and from
past discussions [4] it is known that some tools might have problems
digesting that.

Newly allocated pgdat only gets a minimal initialization and the rest of
the work is expected to be done by the memory hotplug - hotadd_new_pgdat
(renamed to hotadd_init_pgdat).

generic_alloc_nodedata is changed to use the memblock allocator because
neither page nor slab allocators are available at the stage when all
pgdats are allocated. Hotplug doesn't allocate pgdat anymore so we can
use the early boot allocator. The only arch specific implementation is
ia64 and that is changed to use the early allocator as well.

Reported-by: Alexey Makhalov <amakhalov@vmware.com>
Tested-by: Alexey Makhalov <amakhalov@vmware.com>
Reported-by: Nico Pache <npache@redhat.com>
Acked-by: Rafael Aquini <raquini@redhat.com>
Tested-by: Rafael Aquini <raquini@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>

[1] http://lkml.kernel.org/r/20211101201312.11589-1-amakhalov@vmware.com
[2] http://lkml.kernel.org/r/20211207224013.880775-1-npache@redhat.com
[3] http://lkml.kernel.org/r/20190114082416.30939-1-mhocko@kernel.org
[4] http://lkml.kernel.org/r/20200428093836.27190-1-srikar@linux.vnet.ibm.com
---
 arch/ia64/mm/discontig.c       |  4 ++--
 include/linux/memory_hotplug.h |  2 +-
 mm/internal.h                  |  2 ++
 mm/memory_hotplug.c            | 21 +++++++++-----------
 mm/page_alloc.c                | 36 ++++++++++++++++++++++++++++++----
 5 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 8dc8a554f774..dd0cf4834eaa 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -608,11 +608,11 @@ void __init paging_init(void)
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
 }
 
-pg_data_t *arch_alloc_nodedata(int nid)
+pg_data_t * __init arch_alloc_nodedata(int nid)
 {
 	unsigned long size = compute_pernodesize(nid);
 
-	return kzalloc(size, GFP_KERNEL);
+	return memblock_alloc(size, SMP_CACHE_BYTES);
 }
 
 void arch_free_nodedata(pg_data_t *pgdat)
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 4355983b364d..cdd66bfdf855 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -44,7 +44,7 @@ extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
  */
 #define generic_alloc_nodedata(nid)				\
 ({								\
-	kzalloc(sizeof(pg_data_t), GFP_KERNEL);			\
+	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
 })
 /*
  * This definition is just for error path in node hotadd.
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..43b8ccf56b7f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -718,4 +718,6 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
+DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a9627dc784c..fc991831d296 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1162,19 +1162,21 @@ static void reset_node_present_pages(pg_data_t *pgdat)
 }
 
 /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
-static pg_data_t __ref *hotadd_new_pgdat(int nid)
+static pg_data_t __ref *hotadd_init_pgdat(int nid)
 {
 	struct pglist_data *pgdat;
 
 	pgdat = NODE_DATA(nid);
-	if (!pgdat) {
-		pgdat = arch_alloc_nodedata(nid);
-		if (!pgdat)
-			return NULL;
 
+	/*
+	 * NODE_DATA is preallocated (free_area_init) but its internal
+	 * state is not allocated completely. Add missing pieces.
+	 * Completely offline nodes stay around and they just need
+	 * reintialization.
+	 */
+	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
-		arch_refresh_nodedata(nid, pgdat);
 	} else {
 		int cpu;
 		/*
@@ -1193,8 +1195,6 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
 		}
 	}
 
-	/* we can use NODE_DATA(nid) from here */
-	pgdat->node_id = nid;
 	pgdat->node_start_pfn = 0;
 
 	/* init node's zones as empty zones, we don't have any present pages.*/
@@ -1246,7 +1246,7 @@ static int __try_online_node(int nid, bool set_node_online)
 	if (node_online(nid))
 		return 0;
 
-	pgdat = hotadd_new_pgdat(nid);
+	pgdat = hotadd_init_pgdat(nid);
 	if (!pgdat) {
 		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
 		ret = -ENOMEM;
@@ -1445,9 +1445,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	return ret;
 error:
-	/* rollback pgdat allocation and others */
-	if (new_node)
-		rollback_node_hotadd(nid);
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		memblock_remove(start, size);
 error_mem_hotplug_end:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..ef9cfc1069e9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6380,7 +6380,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 #define BOOT_PAGESET_BATCH	1
 static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
-static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
+DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
 static void __build_all_zonelists(void *data)
 {
@@ -6402,7 +6402,11 @@ static void __build_all_zonelists(void *data)
 	if (self && !node_online(self->node_id)) {
 		build_zonelists(self);
 	} else {
-		for_each_online_node(nid) {
+		/*
+		 * All possible nodes have pgdat preallocated
+		 * in free_area_init
+		 */
+		for_each_node(nid) {
 			pg_data_t *pgdat = NODE_DATA(nid);
 
 			build_zonelists(pgdat);
@@ -8096,8 +8100,32 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
 	setup_nr_node_ids();
-	for_each_online_node(nid) {
-		pg_data_t *pgdat = NODE_DATA(nid);
+	for_each_node(nid) {
+		pg_data_t *pgdat;
+
+		if (!node_online(nid)) {
+			pr_info("Initializing node %d as memoryless\n", nid);
+
+			/* Allocator not initialized yet */
+			pgdat = arch_alloc_nodedata(nid);
+			if (!pgdat) {
+				pr_err("Cannot allocate %zuB for node %d.\n",
+						sizeof(*pgdat), nid);
+				continue;
+			}
+			arch_refresh_nodedata(nid, pgdat);
+			free_area_init_memoryless_node(nid);
+			/*
+			 * not marking this node online because we do not want to
+			 * confuse userspace by sysfs files/directories for node
+			 * without any memory attached to it (see topology_init)
+			 * The pgdat will get fully initialized when a memory is
+			 * hotpluged into it by hotadd_init_pgdat
+			 */
+			continue;
+		}
+
+		pgdat = NODE_DATA(nid);
 		free_area_init_node(nid);
 
 		/* Any memory on that node */
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
