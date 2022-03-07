Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C94D0276
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbiCGPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243457AbiCGPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:08:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5992F10FF7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:07:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 157121F395;
        Mon,  7 Mar 2022 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646665656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXn7wMUrFX8sbZ6BajCuexWPZ8vXFeX9A1OvgwoNg58=;
        b=ytHZy3j9HqKRDsW7pEQ4O59R032rFz0Qzy5zOtnue0iOl9c7sgAV2g/tp1wnxtEh2c+oTM
        y8YeL4NGVRR5UrTNk+t3LYU/oI1mFIGjvYTPH/ZzznCZRdnBjQaloHJkjRfTtz2KXJZae7
        h2urm2zh0O7BsBNKYEmCQ4M/7c3xcuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646665656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXn7wMUrFX8sbZ6BajCuexWPZ8vXFeX9A1OvgwoNg58=;
        b=20nmukv7C/ynzp+w1gkwrnOpnahpZQ59CEDXNgnTJnJ2zGHMlyI5k91O7OA90L66HQv9g7
        cwjs+2DJiHFYvpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FE1C132BC;
        Mon,  7 Mar 2022 15:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mHluILcfJmLrHgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 07 Mar 2022 15:07:35 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/3] mm/memory_hotplug: Reset node's state when empty during offline
Date:   Mon,  7 Mar 2022 16:07:24 +0100
Message-Id: <20220307150725.6810-3-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307150725.6810-1-osalvador@suse.de>
References: <20220307150725.6810-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All possible nodes are now pre-allocated at boot time by free_area_init()->
free_area_init_node(), and those which are to be hot-plugged are initialized
later on by hotadd_init_pgdat()->free_area_init_core_hotplug() when they
become online.

free_area_init_core_hotplug() calls pgdat_init_internals() and
zone_init_internals() to initialize some internal data structures
and zeroes a few pgdat fields.

But we do already call pgdat_init_internals() and zone_init_internals()
for all possible nodes back in free_area_init_core(), and pgdat fields
are already zeroed because the pre-allocation memsets with 0s the
structure, meaning we do not need to repeat the process when
the node becomes online.

So initialize it only once when booting, and make sure to reset
the fields we care about to 0 when the node goes empty.
The only thing we need to check for is to allocate per_cpu_nodestats
struct the very first time this node goes online.

node_reset_state() is the function in charge of resetting pgdat's fields,
and it is called when offline_pages() detects that the node becomes empty
worth of memory.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 58 +++++++++++++++++++++-------------
 mm/page_alloc.c                | 49 +++++-----------------------
 3 files changed, 45 insertions(+), 64 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 76bf2de86def..fcf4c9a023cc 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -319,7 +319,7 @@ extern void set_zone_contiguous(struct zone *zone);
 extern void clear_zone_contiguous(struct zone *zone);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
+extern bool pgdat_has_boot_nodestats(pg_data_t *pgdat);
 extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory_resource(int nid, struct resource *resource,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ddc62f8b591f..07cece9e22e4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1164,18 +1164,18 @@ static void reset_node_present_pages(pg_data_t *pgdat)
 /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
 static pg_data_t __ref *hotadd_init_pgdat(int nid)
 {
-	struct pglist_data *pgdat;
+	struct pglist_data *pgdat = NODE_DATA(nid);
 
 	/*
-	 * NODE_DATA is preallocated (free_area_init) but its internal
-	 * state is not allocated completely. Add missing pieces.
-	 * Completely offline nodes stay around and they just need
-	 * reintialization.
+	 * NODE_DATA is preallocated (free_area_init), the only thing missing
+	 * is to allocate its per_cpu_nodestats struct and to build node's
+	 * zonelists. The allocation of per_cpu_nodestats only needs to be done
+	 * the very first time this node is brought up, as we reset its state
+	 * when all node's memory goes offline.
 	 */
-	pgdat = NODE_DATA(nid);
-
-	/* init node's zones as empty zones, we don't have any present pages.*/
-	free_area_init_core_hotplug(pgdat);
+	if (pgdat_has_boot_nodestats(pgdat))
+		pgdat->per_cpu_nodestats = alloc_percpu_gfp(struct per_cpu_nodestat,
+							    __GFP_ZERO);
 
 	/*
 	 * The node we allocated has no zone fallback lists. For avoiding
@@ -1183,15 +1183,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	 */
 	build_all_zonelists(pgdat);
 
-	/*
-	 * When memory is hot-added, all the memory is in offline state. So
-	 * clear all zones' present_pages because they will be updated in
-	 * online_pages() and offline_pages().
-	 * TODO: should be in free_area_init_core_hotplug?
-	 */
-	reset_node_managed_pages(pgdat);
-	reset_node_present_pages(pgdat);
-
 	return pgdat;
 }
 
@@ -1799,6 +1790,30 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
 		node_clear_state(node, N_MEMORY);
 }
 
+static void node_reset_state(int node)
+{
+	pg_data_t *pgdat = NODE_DATA(node);
+	int cpu;
+
+	kswapd_stop(node);
+	kcompactd_stop(node);
+
+	reset_node_managed_pages(pgdat);
+	reset_node_present_pages(pgdat);
+
+	pgdat->nr_zones = 0;
+	pgdat->kswapd_order = 0;
+	pgdat->kswapd_highest_zoneidx = 0;
+	pgdat->node_start_pfn = 0;
+
+	for_each_online_cpu(cpu) {
+		struct per_cpu_nodestat *p;
+
+		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+		memset(p, 0, sizeof(*p));
+	}
+}
+
 static int count_system_ram_pages_cb(unsigned long start_pfn,
 				     unsigned long nr_pages, void *data)
 {
@@ -1956,10 +1971,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	}
 
 	node_states_clear_node(node, &arg);
-	if (arg.status_change_nid >= 0) {
-		kswapd_stop(node);
-		kcompactd_stop(node);
-	}
+	if (arg.status_change_nid >= 0)
+		/* Reset node's state as all its memory went offline. */
+		node_reset_state(node);
 
 	writeback_set_ratelimit();
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0b7d176a8990..36e67418a6f0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6382,6 +6382,13 @@ static DEFINE_PER_CPU(struct per_cpu_pages, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_zonestat, boot_zonestats);
 static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+bool pgdat_has_boot_nodestats(pg_data_t *pgdat)
+{
+	return pgdat->per_cpu_nodestats == &boot_nodestats;
+}
+#endif
+
 static void __build_all_zonelists(void *data)
 {
 	int nid;
@@ -7491,7 +7498,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	lruvec_init(&pgdat->__lruvec);
 }
 
-static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
+static void __init zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
 							unsigned long remaining_pages)
 {
 	atomic_long_set(&zone->managed_pages, remaining_pages);
@@ -7503,46 +7510,6 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
 	zone_pcp_init(zone);
 }
 
-/*
- * Set up the zone data structures
- * - init pgdat internals
- * - init all zones belonging to this node
- *
- * NOTE: this function is only called during memory hotplug
- */
-#ifdef CONFIG_MEMORY_HOTPLUG
-void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
-{
-	int nid = pgdat->node_id;
-	enum zone_type z;
-	int cpu;
-
-	pgdat_init_internals(pgdat);
-
-	if (pgdat->per_cpu_nodestats == &boot_nodestats)
-		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
-
-	/*
-	 * Reset the nr_zones, order and highest_zoneidx before reuse.
-	 * Note that kswapd will init kswapd_highest_zoneidx properly
-	 * when it starts in the near future.
-	 */
-	pgdat->nr_zones = 0;
-	pgdat->kswapd_order = 0;
-	pgdat->kswapd_highest_zoneidx = 0;
-	pgdat->node_start_pfn = 0;
-	for_each_online_cpu(cpu) {
-		struct per_cpu_nodestat *p;
-
-		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
-		memset(p, 0, sizeof(*p));
-	}
-
-	for (z = 0; z < MAX_NR_ZONES; z++)
-		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
-}
-#endif
-
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
-- 
2.34.1

