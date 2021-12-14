Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72086474016
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhLNKHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:07:52 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:40741 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhLNKHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:07:50 -0500
Received: by mail-ed1-f53.google.com with SMTP id r25so60657908edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1MgZBE+5x0MRU/lUBuCLoewFRnB8P5xnPPt5m5f3GQ=;
        b=c2XvKLyInq0o4+Gaxjub5kJRR4jIOmZxQJ/3qan508ITi15161QEnreZk28q7LTW+J
         B94EYWeJualf8Kg6tbNdFFJAS/BKuN3vWDEM5qGk8NV9euKuQ32t+U8NRnxPu1vJMJ8D
         a7GR9SSQkrUKVsZCWjW2GhInarEILjCTXUSs64hEsysnwFOqvtHiB38KnPxa0PLtU0nZ
         8rRAsplBFRVdDoTJI8Havrk4cD8AwXRhJK9icaTJidcx/qQrTQtUA4zQhJzHGDMsY8TB
         LkFgnHXkVOr6Uu+g2PUNCxW7XiS7AGQA2mIScadoME2zEm0uHyQB6oYUVLfvU0paqtQU
         qNzg==
X-Gm-Message-State: AOAM532Z5ifX9EZD+ARlYK/9K2vKF5labCCsHjiU76oIHwA8o8wpM6UT
        PSakaqt5/GhQ8+5MBll/UQ0=
X-Google-Smtp-Source: ABdhPJyHhWGaa75REzSPxX4bK9JrMuPYC19+6DvEUNGqaMyGIpfOEaO39TBVRpJ6PjHz1x8HmaOreg==
X-Received: by 2002:a50:fb09:: with SMTP id d9mr6304448edq.283.1639476469106;
        Tue, 14 Dec 2021 02:07:49 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id f5sm839766ejl.219.2021.12.14.02.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 02:07:48 -0800 (PST)
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
Subject: [PATCH v2 2/4] mm: handle uninitialized numa nodes gracefully
Date:   Tue, 14 Dec 2021 11:07:30 +0100
Message-Id: <20211214100732.26335-3-mhocko@kernel.org>
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
Reported-by: Nico Pache <npache@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>

[1] http://lkml.kernel.org/r/20211101201312.11589-1-amakhalov@vmware.com
[2] http://lkml.kernel.org/r/20211207224013.880775-1-npache@redhat.com
[3] http://lkml.kernel.org/r/20190114082416.30939-1-mhocko@kernel.org
[4] http://lkml.kernel.org/r/20200428093836.27190-1-srikar@linux.vnet.ibm.com
---
 arch/ia64/mm/discontig.c       |  2 +-
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 21 +++++++++------------
 mm/page_alloc.c                | 34 +++++++++++++++++++++++++++++++---
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 8dc8a554f774..b4c46925792f 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -612,7 +612,7 @@ pg_data_t *arch_alloc_nodedata(int nid)
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
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 852041f6be41..9009a7b2a170 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1161,19 +1161,21 @@ static void reset_node_present_pages(pg_data_t *pgdat)
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
@@ -1192,8 +1194,6 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
 		}
 	}
 
-	/* we can use NODE_DATA(nid) from here */
-	pgdat->node_id = nid;
 	pgdat->node_start_pfn = 0;
 
 	/* init node's zones as empty zones, we don't have any present pages.*/
@@ -1245,7 +1245,7 @@ static int __try_online_node(int nid, bool set_node_online)
 	if (node_online(nid))
 		return 0;
 
-	pgdat = hotadd_new_pgdat(nid);
+	pgdat = hotadd_init_pgdat(nid);
 	if (!pgdat) {
 		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
 		ret = -ENOMEM;
@@ -1444,9 +1444,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	return ret;
 error:
-	/* rollback pgdat allocation and others */
-	if (new_node)
-		rollback_node_hotadd(nid);
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		memblock_remove(start, size);
 error_mem_hotplug_end:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..f2ceffadf4eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6382,7 +6382,11 @@ static void __build_all_zonelists(void *data)
 	if (self && !node_online(self->node_id)) {
 		build_zonelists(self);
 	} else {
-		for_each_online_node(nid) {
+		/*
+		 * All possible nodes have pgdat preallocated
+		 * free_area_init
+		 */
+		for_each_node(nid) {
 			pg_data_t *pgdat = NODE_DATA(nid);
 
 			build_zonelists(pgdat);
@@ -8032,8 +8036,32 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
 	setup_nr_node_ids();
-	for_each_online_node(nid) {
-		pg_data_t *pgdat = NODE_DATA(nid);
+	for_each_node(nid) {
+		pg_data_t *pgdat;
+
+		if (!node_online(nid)) {
+			pr_warn("Node %d uninitialized by the platform. Please report with boot dmesg.\n", nid);
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

