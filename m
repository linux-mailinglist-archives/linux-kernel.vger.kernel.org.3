Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A264B1577
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244279AbiBJSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:44:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiBJSoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CCD9110C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644518659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESuhyZGF6aICxRSlsHuy91KPAgsUbLJUbMyMxFMOtb8=;
        b=hbJvcHHq0XN03lENs8NZyg0eS+Tc1JBlqshiVOlA3lMWs6XN+ruoex7R/m8P6o+EUKl5uI
        zx9vudnzsW+1De/AAemzF5TK49+zfF5geRsYVxlnDc7euEGsnhk8pJFaPOTgn7GcwUehlE
        RPm1nOedf3tCCYQOByUEzAwNmp+bn0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-0Y8-1YhCMLG4BvoRR_K4Mw-1; Thu, 10 Feb 2022 13:44:14 -0500
X-MC-Unique: 0Y8-1YhCMLG4BvoRR_K4Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 216F2189CD1B;
        Thu, 10 Feb 2022 18:44:13 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC407E2C6;
        Thu, 10 Feb 2022 18:44:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Rafael Parra <rparrazo@redhat.com>
Subject: [PATCH v2 2/2] drivers/base/memory: determine and store zone for single-zone memory blocks
Date:   Thu, 10 Feb 2022 19:43:59 +0100
Message-Id: <20220210184359.235565-3-david@redhat.com>
In-Reply-To: <20220210184359.235565-1-david@redhat.com>
References: <20220210184359.235565-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_pages_in_a_zone() is just another nasty PFN walker that can easily
stumble over ZONE_DEVICE memory ranges falling into the same memory block
as ordinary system RAM: the memmap of parts of these ranges might possibly
be uninitialized. In fact, we observed (on an older kernel) with UBSAN:

[ 7691.855626] UBSAN: Undefined behaviour in ./include/linux/mm.h:1133:50
[ 7691.862155] index 7 is out of range for type 'zone [5]'
[ 7691.867393] CPU: 121 PID: 35603 Comm: read_all Kdump: loaded Tainted: [...]
[ 7691.879990] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.12.2 11/15/2019
[ 7691.887643] Call Trace:
[ 7691.890107]  dump_stack+0x9a/0xf0
[ 7691.893438]  ubsan_epilogue+0x9/0x7a
[ 7691.897025]  __ubsan_handle_out_of_bounds+0x13a/0x181
[ 7691.902086]  ? __ubsan_handle_shift_out_of_bounds+0x289/0x289
[ 7691.907841]  ? sched_clock_cpu+0x18/0x1e0
[ 7691.911867]  ? __lock_acquire+0x610/0x38d0
[ 7691.915979]  test_pages_in_a_zone+0x3c4/0x500
[ 7691.920357]  show_valid_zones+0x1fa/0x380
[ 7691.924375]  ? print_allowed_zone+0x80/0x80
[ 7691.928571]  ? __lock_is_held+0xb4/0x140
[ 7691.932509]  ? __lock_is_held+0xb4/0x140
[ 7691.936447]  ? dev_attr_store+0x70/0x70
[ 7691.940296]  dev_attr_show+0x43/0xb0
[ 7691.943884]  ? memset+0x1f/0x40
[ 7691.947042]  sysfs_kf_seq_show+0x1c5/0x440
[ 7691.951153]  seq_read+0x49d/0x1190
[ 7691.954574]  ? seq_escape+0x1f0/0x1f0
[ 7691.958249]  ? fsnotify_first_mark+0x150/0x150
[ 7691.962713]  vfs_read+0xff/0x300
[ 7691.965952]  ksys_read+0xb8/0x170
[ 7691.969279]  ? kernel_write+0x130/0x130
[ 7691.973126]  ? entry_SYSCALL_64_after_hwframe+0x7a/0xdf
[ 7691.978365]  ? do_syscall_64+0x22/0x4b0
[ 7691.982212]  do_syscall_64+0xa5/0x4b0
[ 7691.985887]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
[ 7691.990947] RIP: 0033:0x7f01f4439b52

We seem to stumble over a memmap that contains a garbage zone id. While
we could try inserting pfn_to_online_page() calls, it will just make
memory offlining slower, because we use test_pages_in_a_zone() to make
sure we're offlining pages that all belong to the same zone.

Let's just get rid of this PFN walker and determine the single zone
of a memory block -- if any -- for early memory blocks during boot. For
memory onlining, we know the single zone already. Let's avoid any
additional memmap scanning and just rely on the zone information
available during boot.

For memory hot(un)plug, we only really care about memory blocks that:
* span a single zone (and, thereby, a single node)
* are completely System RAM (IOW, no holes, no ZONE_DEVICE)
If one of these conditions is not met, we reject memory offlining.
Hotplugged memory blocks (starting out offline), always meet both
conditions.

There are three scenarios to handle:

(1) Memory hot(un)plug

A memory block with zone == NULL cannot be offlined, corresponding to
our previous test_pages_in_a_zone() check.

After successful memory onlining/offlining, we simply set the zone
accordingly.
* Memory onlining: set the zone we just used for onlining
* Memory offlining: set zone = NULL

So a hotplugged memory block starts with zone = NULL. Once memory
onlining is done, we set the proper zone.

(2) Boot memory with !CONFIG_NUMA

We know that there is just a single pgdat, so we simply scan all zones
of that pgdat for an intersection with our memory block PFN range when
adding the memory block. If more than one zone intersects (e.g., DMA and
DMA32 on x86 for the first memory block) we set zone = NULL and
consequently mimic what test_pages_in_a_zone() used to do.

(3) Boot memory with CONFIG_NUMA

At the point in time we create the memory block devices during boot, we
don't know yet which nodes *actually* span a memory block. While we could
scan all zones of all nodes for intersections, overlapping nodes complicate
the situation and scanning all nodes is possibly expensive. But that
problem has already been solved by the code that sets the node of a memory
block and creates the link in the sysfs --
do_register_memory_block_under_node().

So, we hook into the code that sets the node id for a memory block. If
we already have a different node id set for the memory block, we know
that multiple nodes *actually* have PFNs falling into our memory block:
we set zone = NULL and consequently mimic what test_pages_in_a_zone() used
to do. If there is no node id set, we do the same as (2) for the given
node.

Note that the call order in driver_init() is:
-> memory_dev_init(): create memory block devices
-> node_dev_init(): link memory block devices to the node and set the
		    node id

So in summary, we detect if there is a single zone responsible for this
memory block and we consequently store the zone in that case in the
memory block, updating it during memory onlining/offlining.

Reported-by: Rafael Parra <rparrazo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 101 +++++++++++++++++++++++++++++++--
 drivers/base/node.c            |  13 ++---
 include/linux/memory.h         |  12 ++++
 include/linux/memory_hotplug.h |   6 +-
 mm/memory_hotplug.c            |  50 ++++------------
 5 files changed, 125 insertions(+), 57 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 60c38f9cf1a7..5297c8a84428 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -215,6 +215,7 @@ static int memory_block_online(struct memory_block *mem)
 		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
 					  nr_vmemmap_pages);
 
+	mem->zone = zone;
 	return ret;
 }
 
@@ -225,6 +226,9 @@ static int memory_block_offline(struct memory_block *mem)
 	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
 	int ret;
 
+	if (!mem->zone)
+		return -EINVAL;
+
 	/*
 	 * Unaccount before offlining, such that unpopulated zone and kthreads
 	 * can properly be torn down in offline_pages().
@@ -234,7 +238,7 @@ static int memory_block_offline(struct memory_block *mem)
 					  -nr_vmemmap_pages);
 
 	ret = offline_pages(start_pfn + nr_vmemmap_pages,
-			    nr_pages - nr_vmemmap_pages, mem->group);
+			    nr_pages - nr_vmemmap_pages, mem->zone, mem->group);
 	if (ret) {
 		/* offline_pages() failed. Account back. */
 		if (nr_vmemmap_pages)
@@ -246,6 +250,7 @@ static int memory_block_offline(struct memory_block *mem)
 	if (nr_vmemmap_pages)
 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
 
+	mem->zone = NULL;
 	return ret;
 }
 
@@ -411,11 +416,10 @@ static ssize_t valid_zones_show(struct device *dev,
 	 */
 	if (mem->state == MEM_ONLINE) {
 		/*
-		 * The block contains more than one zone can not be offlined.
-		 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
+		 * If !mem->zone, the memory block spans multiple zones and
+		 * cannot get offlined.
 		 */
-		default_zone = test_pages_in_a_zone(start_pfn,
-						    start_pfn + nr_pages);
+		default_zone = mem->zone;
 		if (!default_zone)
 			return sysfs_emit(buf, "%s\n", "none");
 		len += sysfs_emit_at(buf, len, "%s", default_zone->name);
@@ -641,6 +645,82 @@ int register_memory(struct memory_block *memory)
 	return ret;
 }
 
+static struct zone *early_node_zone_for_memory_block(struct memory_block *mem,
+						     int nid)
+{
+	const unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
+	const unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
+	struct zone *zone, *matching_zone = NULL;
+	pg_data_t *pgdat = NODE_DATA(nid);
+	int i;
+
+	/*
+	 * This logic only works for early memory, when the applicable zones
+	 * already span the memory block. We don't expect overlapping zones on
+	 * a single node for early memory. So if we're told that some PFNs
+	 * of a node fall into this memory block, we can assume that all node
+	 * zones that intersect with the memory block are actually applicable.
+	 * No need to look at the memmap.
+	 */
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		zone = pgdat->node_zones + i;
+		if (!populated_zone(zone))
+			continue;
+		if (!zone_intersects(zone, start_pfn, nr_pages))
+			continue;
+		if (!matching_zone) {
+			matching_zone = zone;
+			continue;
+		}
+		/* Spans multiple zones ... */
+		matching_zone = NULL;
+		break;
+	}
+	return matching_zone;
+}
+
+#ifdef CONFIG_NUMA
+/**
+ * memory_block_add_nid() - Indicate that system RAM falling into this memory
+ *			    block device (partially) belongs to the given node.
+ * @mem: The memory block device.
+ * @nid: The node id.
+ * @context: The memory initialization context.
+ *
+ * Indicate that system RAM falling into this memory block (partially) belongs
+ * to the given node. If the context indicates ("early") that we are adding the
+ * node during node device subsystem initialization, this will also properly
+ * set/adjust mem->zone based on the zone ranges of the given node.
+ */
+void memory_block_add_nid(struct memory_block *mem, int nid,
+			  enum meminit_context context)
+{
+	if (context == MEMINIT_EARLY && mem->nid != nid) {
+		/*
+		 * For early memory we have to determine the zone when setting
+		 * the node id and handle multiple nodes spanning a single
+		 * memory block by indicate via zone == NULL that we're not
+		 * dealing with a single zone. So if we're setting the node id
+		 * the first time, determine if there is a single zone. If we're
+		 * setting the node id a second time to a different node,
+		 * invalidate the single detected zone.
+		 */
+		if (mem->nid == NUMA_NO_NODE)
+			mem->zone = early_node_zone_for_memory_block(mem, nid);
+		else
+			mem->zone = NULL;
+	}
+
+	/*
+	 * If this memory block spans multiple nodes, we only indicate
+	 * the last processed node. If we span multiple nodes (not applicable
+	 * to hotplugged memory), zone == NULL will prohibit memory offlining
+	 * and consequently unplug.
+	 */
+	mem->nid = nid;
+}
+#endif
+
 static int init_memory_block(unsigned long block_id, unsigned long state,
 			     unsigned long nr_vmemmap_pages,
 			     struct memory_group *group)
@@ -663,6 +743,17 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
 	mem->nr_vmemmap_pages = nr_vmemmap_pages;
 	INIT_LIST_HEAD(&mem->group_next);
 
+#ifndef CONFIG_NUMA
+	if (state == MEM_ONLINE)
+		/*
+		 * MEM_ONLINE at this point implies early memory. With NUMA,
+		 * we'll determine the zone when setting the node id via
+		 * memory_block_add_nid(). Memory hotplug updated the zone
+		 * manually when memory onlining/offlining succeeds.
+		 */
+		mem->zone = early_node_zone_for_memory_block(mem, NUMA_NO_NODE);
+#endif /* CONFIG_NUMA */
+
 	ret = register_memory(mem);
 	if (ret)
 		return ret;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 5d75341413ce..ec8bb24a5a22 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -796,15 +796,12 @@ static int __ref get_nid_for_pfn(unsigned long pfn)
 }
 
 static void do_register_memory_block_under_node(int nid,
-						struct memory_block *mem_blk)
+						struct memory_block *mem_blk,
+						enum meminit_context context)
 {
 	int ret;
 
-	/*
-	 * If this memory block spans multiple nodes, we only indicate
-	 * the last processed node.
-	 */
-	mem_blk->nid = nid;
+	memory_block_add_nid(mem_blk, nid, context);
 
 	ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
 				       &mem_blk->dev.kobj,
@@ -857,7 +854,7 @@ static int register_mem_block_under_node_early(struct memory_block *mem_blk,
 		if (page_nid != nid)
 			continue;
 
-		do_register_memory_block_under_node(nid, mem_blk);
+		do_register_memory_block_under_node(nid, mem_blk, MEMINIT_EARLY);
 		return 0;
 	}
 	/* mem section does not span the specified node */
@@ -873,7 +870,7 @@ static int register_mem_block_under_node_hotplug(struct memory_block *mem_blk,
 {
 	int nid = *(int *)arg;
 
-	do_register_memory_block_under_node(nid, mem_blk);
+	do_register_memory_block_under_node(nid, mem_blk, MEMINIT_HOTPLUG);
 	return 0;
 }
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 88eb587b5143..aa619464a1df 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -70,6 +70,13 @@ struct memory_block {
 	unsigned long state;		/* serialized by the dev->lock */
 	int online_type;		/* for passing data to online routine */
 	int nid;			/* NID for this memory block */
+	/*
+	 * The single zone of this memory block if all PFNs of this memory block
+	 * that are System RAM (not a memory hole, not ZONE_DEVICE ranges) are
+	 * managed by a single zone. NULL if multiple zones (including nodes)
+	 * apply.
+	 */
+	struct zone *zone;
 	struct device dev;
 	/*
 	 * Number of vmemmap pages. These pages
@@ -161,6 +168,11 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 })
 #define register_hotmemory_notifier(nb)		register_memory_notifier(nb)
 #define unregister_hotmemory_notifier(nb) 	unregister_memory_notifier(nb)
+
+#ifdef CONFIG_NUMA
+void memory_block_add_nid(struct memory_block *mem, int nid,
+			  enum meminit_context context);
+#endif /* CONFIG_NUMA */
 #endif	/* CONFIG_MEMORY_HOTPLUG */
 
 /*
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index be48e003a518..05b2cdf6c935 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -107,8 +107,6 @@ extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 extern void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group);
-extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
-					 unsigned long end_pfn);
 extern void __offline_isolated_pages(unsigned long start_pfn,
 				     unsigned long end_pfn);
 
@@ -297,7 +295,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 
 extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
-			 struct memory_group *group);
+			 struct zone *zone, struct memory_group *group);
 extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
 extern int offline_and_remove_memory(u64 start, u64 size);
@@ -306,7 +304,7 @@ extern int offline_and_remove_memory(u64 start, u64 size);
 static inline void try_offline_node(int nid) {}
 
 static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
-				struct memory_group *group)
+				struct zone *zone, struct memory_group *group)
 {
 	return -EINVAL;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 69af90e9f507..53a6543dceeb 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1589,38 +1589,6 @@ bool mhp_range_allowed(u64 start, u64 size, bool need_mapping)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-/*
- * Confirm all pages in a range [start, end) belong to the same zone (skipping
- * memory holes). When true, return the zone.
- */
-struct zone *test_pages_in_a_zone(unsigned long start_pfn,
-				  unsigned long end_pfn)
-{
-	unsigned long pfn, sec_end_pfn;
-	struct zone *zone = NULL;
-	struct page *page;
-
-	for (pfn = start_pfn, sec_end_pfn = SECTION_ALIGN_UP(start_pfn + 1);
-	     pfn < end_pfn;
-	     pfn = sec_end_pfn, sec_end_pfn += PAGES_PER_SECTION) {
-		/* Make sure the memory section is present first */
-		if (!present_section_nr(pfn_to_section_nr(pfn)))
-			continue;
-		for (; pfn < sec_end_pfn && pfn < end_pfn;
-		     pfn += MAX_ORDER_NR_PAGES) {
-			/* Check if we got outside of the zone */
-			if (zone && !zone_spans_pfn(zone, pfn))
-				return NULL;
-			page = pfn_to_page(pfn);
-			if (zone && page_zone(page) != zone)
-				return NULL;
-			zone = page_zone(page);
-		}
-	}
-
-	return zone;
-}
-
 /*
  * Scan pfn range [start,end) to find movable/migratable pages (LRU pages,
  * non-lru movable pages and hugepages). Will skip over most unmovable
@@ -1844,15 +1812,15 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 }
 
 int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
-			struct memory_group *group)
+			struct zone *zone, struct memory_group *group)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn, system_ram_pages = 0;
+	const int node = zone_to_nid(zone);
 	unsigned long flags;
-	struct zone *zone;
 	struct memory_notify arg;
-	int ret, node;
 	char *reason;
+	int ret;
 
 	/*
 	 * {on,off}lining is constrained to full memory sections (or more
@@ -1884,15 +1852,17 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		goto failed_removal;
 	}
 
-	/* This makes hotplug much easier...and readable.
-	   we assume this for now. .*/
-	zone = test_pages_in_a_zone(start_pfn, end_pfn);
-	if (!zone) {
+	/*
+	 * We only support offlining of memory blocks managed by a single zone,
+	 * checked by calling code. This is just a sanity check that we might
+	 * want to remove in the future.
+	 */
+	if (WARN_ON_ONCE(page_zone(pfn_to_page(start_pfn)) != zone ||
+			 page_zone(pfn_to_page(end_pfn - 1)) != zone)) {
 		ret = -EINVAL;
 		reason = "multizone range";
 		goto failed_removal;
 	}
-	node = zone_to_nid(zone);
 
 	/*
 	 * Disable pcplists so that page isolation cannot race with freeing
-- 
2.34.1

