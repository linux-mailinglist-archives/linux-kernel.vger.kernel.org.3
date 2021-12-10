Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9547846FD8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbhLJJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:22:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbhLJJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:22:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B38B1F3A1;
        Fri, 10 Dec 2021 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639127907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lTE9D+jxIMbgsHAojo4idlXVTzTwXM9rewKMrbu/Y4o=;
        b=VlAiEr9eaHP/22mWwfMUeEHXfHkbMdzXcouLVJSmsA81AA0HALaDGkeE9vvLoEAmqCDP3E
        cRDJFSYPWSdlMi+vltyv5YAZRgWWsrToDPoSCUUki+Zhkt1gpNugh7mAGjWHtUm2ZzL13t
        49tdil0DQotJtUBQPLaIsL/h8eHaTSU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76BF5A3B81;
        Fri, 10 Dec 2021 09:18:27 +0000 (UTC)
Date:   Fri, 10 Dec 2021 10:18:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: mm/page_alloc.c:8046:33: error: implicit declaration of function
 'arch_alloc_nodedata'; did you mean 'arch_alloc_page'?
Message-ID: <YbMbYsZyGMHYsK1G@dhcp22.suse.cz>
References: <202112100657.wrZJcCEG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112100657.wrZJcCEG-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report! I suspect this had CONFIG_MEMORY_HOTPLUG=n.
This patch should address that. Could you give it a try please?
--- 
From 404c7a5cbc886a28d53d23866ad388cf0f4d28a9 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 10 Dec 2021 10:14:31 +0100
Subject: [PATCH] mm, memory_hotplug: make arch_alloc_nodedata independent on
 CONFIG_MEMORY_HOTPLUG

This is a preparatory patch and it doesn't introduce any functional
change. It merely pulls out arch_alloc_nodedata (and co) outside of
CONFIG_MEMORY_HOTPLUG because the following patch will need to call this
from the generic MM code.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/ia64/mm/discontig.c       |   2 -
 include/linux/memory_hotplug.h | 117 +++++++++++++++++----------------
 2 files changed, 59 insertions(+), 60 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 9a7a09e0aa52..b4c46925792f 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -608,7 +608,6 @@ void __init paging_init(void)
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
 pg_data_t *arch_alloc_nodedata(int nid)
 {
 	unsigned long size = compute_pernodesize(nid);
@@ -626,7 +625,6 @@ void arch_refresh_nodedata(int update_node, pg_data_t *update_pgdat)
 	pgdat_list[update_node] = update_pgdat;
 	scatter_node_data();
 }
-#endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 38f8d33f0884..bea12881360f 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -16,6 +16,65 @@ struct memory_group;
 struct resource;
 struct vmem_altmap;
 
+#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
+/*
+ * For supporting node-hotadd, we have to allocate a new pgdat.
+ *
+ * If an arch has generic style NODE_DATA(),
+ * node_data[nid] = kzalloc() works well. But it depends on the architecture.
+ *
+ * In general, generic_alloc_nodedata() is used.
+ * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
+ *
+ */
+extern pg_data_t *arch_alloc_nodedata(int nid);
+extern void arch_free_nodedata(pg_data_t *pgdat);
+extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
+
+#else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
+
+#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
+#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
+
+#ifdef CONFIG_NUMA
+/*
+ * XXX: node aware allocation can't work well to get new node's memory at this time.
+ *	Because, pgdat for the new node is not allocated/initialized yet itself.
+ *	To use new node's memory, more consideration will be necessary.
+ */
+#define generic_alloc_nodedata(nid)				\
+({								\
+	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
+})
+/*
+ * This definition is just for error path in node hotadd.
+ * For node hotremove, we have to replace this.
+ */
+#define generic_free_nodedata(pgdat)	kfree(pgdat)
+
+extern pg_data_t *node_data[];
+static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
+{
+	node_data[nid] = pgdat;
+}
+
+#else /* !CONFIG_NUMA */
+
+/* never called */
+static inline pg_data_t *generic_alloc_nodedata(int nid)
+{
+	BUG();
+	return NULL;
+}
+static inline void generic_free_nodedata(pg_data_t *pgdat)
+{
+}
+static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
+{
+}
+#endif /* CONFIG_NUMA */
+#endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 struct page *pfn_to_online_page(unsigned long pfn);
 
@@ -154,64 +213,6 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	      struct mhp_params *params);
 #endif /* ARCH_HAS_ADD_PAGES */
 
-#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
-/*
- * For supporting node-hotadd, we have to allocate a new pgdat.
- *
- * If an arch has generic style NODE_DATA(),
- * node_data[nid] = kzalloc() works well. But it depends on the architecture.
- *
- * In general, generic_alloc_nodedata() is used.
- * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
- *
- */
-extern pg_data_t *arch_alloc_nodedata(int nid);
-extern void arch_free_nodedata(pg_data_t *pgdat);
-extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
-
-#else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
-
-#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
-#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
-
-#ifdef CONFIG_NUMA
-/*
- * XXX: node aware allocation can't work well to get new node's memory at this time.
- *	Because, pgdat for the new node is not allocated/initialized yet itself.
- *	To use new node's memory, more consideration will be necessary.
- */
-#define generic_alloc_nodedata(nid)				\
-({								\
-	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
-})
-/*
- * This definition is just for error path in node hotadd.
- * For node hotremove, we have to replace this.
- */
-#define generic_free_nodedata(pgdat)	kfree(pgdat)
-
-extern pg_data_t *node_data[];
-static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
-{
-	node_data[nid] = pgdat;
-}
-
-#else /* !CONFIG_NUMA */
-
-/* never called */
-static inline pg_data_t *generic_alloc_nodedata(int nid)
-{
-	BUG();
-	return NULL;
-}
-static inline void generic_free_nodedata(pg_data_t *pgdat)
-{
-}
-static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
-{
-}
-#endif /* CONFIG_NUMA */
-#endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
 void get_online_mems(void);
 void put_online_mems(void);
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
