Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512B049DCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiA0IxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:53:21 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36526 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiA0IxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:53:15 -0500
Received: by mail-ed1-f50.google.com with SMTP id l5so2642702edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eRPJB+YqZd2ZZyxQgtAYtqZKGBXjpCE6LW/md0SNnk=;
        b=ZiDM3r/4FN/eIx4eTMDLJIYktBCjJfC6SDL86Yr8AXq8aMq/6YT/mk2xJG1UZaYM7B
         LxUwcmsCNanoMmAP7aP/2RZtwvrmWg1epkMXifeCA+NkqeyDiMUENM3J1dN4WIjbFZ4i
         w+nBRKxBUPyCB1XqifkYq3AuBADc4BMky9G8snI69XIA7BJats1h7VesLomqZm0Qjb3L
         0Qm8wQ+InKx0gm/GLyevYx/dBYjlwOtjdc5lkWzOMeifuvoygZRVLMfEqa7vq3oWkcV1
         H2eTkyHEl3QkbJkcvJNS7yIvANfcxiiCv0SbeOl7UMZjo+9B5UZc1qO2cTDwUCbwe7FR
         eZ4g==
X-Gm-Message-State: AOAM533RxCaM0MAoMFccc0S5CYH9htpODfRELWH7hCmivXvC5ke4+ZFa
        AQPwz6flVqHCqYh+QHRPT6c=
X-Google-Smtp-Source: ABdhPJwyOcD75d86+ZTjwDWy3uRlg8yr9BNyaeejl1+lf/7zitkPNj75Ine1VgyGWCJsNwqIPaPqvA==
X-Received: by 2002:a05:6402:4414:: with SMTP id y20mr2600218eda.219.1643273594768;
        Thu, 27 Jan 2022 00:53:14 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-47-31.eurotel.cz. [85.160.47.31])
        by smtp.gmail.com with ESMTPSA id n11sm11029757edv.52.2022.01.27.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:53:14 -0800 (PST)
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
Subject: [PATCH 1/6] mm, memory_hotplug: make arch_alloc_nodedata independent on CONFIG_MEMORY_HOTPLUG
Date:   Thu, 27 Jan 2022 09:53:00 +0100
Message-Id: <20220127085305.20890-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127085305.20890-1-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

This is a preparatory patch and it doesn't introduce any functional
change. It merely pulls out arch_alloc_nodedata (and co) outside of
CONFIG_MEMORY_HOTPLUG because the following patch will need to call this
from the generic MM code.

Acked-by: Rafael Aquini <raquini@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/ia64/mm/discontig.c       |   2 -
 include/linux/memory_hotplug.h | 119 ++++++++++++++++-----------------
 2 files changed, 59 insertions(+), 62 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 791d4176e4a6..8dc8a554f774 100644
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
index be48e003a518..4355983b364d 100644
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
+	kzalloc(sizeof(pg_data_t), GFP_KERNEL);			\
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
 
@@ -154,66 +213,6 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
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
- * If ARCH_HAS_NODEDATA_EXTENSION=n, this func is used to allocate pgdat.
- * XXX: kmalloc_node() can't work well to get new node's memory at this time.
- *	Because, pgdat for the new node is not allocated/initialized yet itself.
- *	To use new node's memory, more consideration will be necessary.
- */
-#define generic_alloc_nodedata(nid)				\
-({								\
-	kzalloc(sizeof(pg_data_t), GFP_KERNEL);			\
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
-
 void get_online_mems(void);
 void put_online_mems(void);
 
-- 
2.30.2

