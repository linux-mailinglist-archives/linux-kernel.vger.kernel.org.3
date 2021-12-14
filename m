Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE24F474015
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhLNKHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:07:50 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37652 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhLNKHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:07:48 -0500
Received: by mail-ed1-f45.google.com with SMTP id e3so62043347edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2NOXkyG+3Xi/LaxqKiwD8QVVfeQpVdyacMokAorcT0=;
        b=Pe8gQA4s28WcuMA8QBuu2Et5uBuUpowGCGYcywgfbaM6/jctQmMbv77q1md/kXHBLD
         vt+3naRMr/c3SN4C93MzSMDwYHzduQy7FmUYJ+nmUaGvDNqr8OvhyQCHbk2AzyVWl+Qf
         Ulim3Z1M//VBe7ZRQ3v+TYrcU3ZCksJ4WQ4/x4eOJO9AspFbnOAhwynY8KDeTT7OFgpe
         WF699DphRxAN9aXOPlFgvq+d4/IzK0QpU7OjD4EwyxwMsm8J/586VnuIVYlSwboGyB44
         SG4EbIpaHAjHIrYEkSZFWa88rP1NBkkOaN63tGc4oaQQCdzJvj+NkiGd06lXHSmBGdyM
         YG3Q==
X-Gm-Message-State: AOAM5328UIJgAHMpNMb//L2rFHhHsCDH2mQALjWH3WI0erR/Lh2QV35K
        wzCtdE4Tb59kgwXE9KysHxk=
X-Google-Smtp-Source: ABdhPJz4GmvdYet4a2DObPOvSj6PTYHN0QQfIdwUfArVTukQO0yok9F+d9brLyoKbxpp2a5999YMmw==
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr6383408edd.213.1639476467691;
        Tue, 14 Dec 2021 02:07:47 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id f5sm839766ejl.219.2021.12.14.02.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 02:07:47 -0800 (PST)
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
Subject: [PATCH v2 1/4] mm, memory_hotplug: make arch_alloc_nodedata independent on CONFIG_MEMORY_HOTPLUG
Date:   Tue, 14 Dec 2021 11:07:29 +0100
Message-Id: <20211214100732.26335-2-mhocko@kernel.org>
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

This is a preparatory patch and it doesn't introduce any functional
change. It merely pulls out arch_alloc_nodedata (and co) outside of
CONFIG_MEMORY_HOTPLUG because the following patch will need to call this
from the generic MM code.

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

