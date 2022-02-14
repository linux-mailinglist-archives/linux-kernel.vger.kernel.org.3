Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579C04B58BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357182AbiBNRmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:42:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357173AbiBNRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:42:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0B2A65439
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644860518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mx6Ig6cDe6O56YfmEylSBctNQntPOwNgKDj91cpg3UA=;
        b=AoIgR/VGWsOI03gbxTx+M/PsLj8ZSM1mSfT2O/oj6YgadD8rwG/6lWmrY7vHm3zBPz735p
        EmtgXHIk/2/6ul0CyE1yMaCT2K37ffskreRp5WV+SE67AMGtjx85EcLAF2RkHwqihRvSeu
        IxTGutoXPqxFIljuc+hjdbjKDjH0P8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-CCrWw_SaMhCyb4tUx8IFUA-1; Mon, 14 Feb 2022 12:41:54 -0500
X-MC-Unique: CCrWw_SaMhCyb4tUx8IFUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02EF3801B0D;
        Mon, 14 Feb 2022 17:41:52 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DFE07DE56;
        Mon, 14 Feb 2022 17:41:46 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v1 1/2] cma: factor out minimum alignment requirement
Date:   Mon, 14 Feb 2022 18:41:31 +0100
Message-Id: <20220214174132.219303-2-david@redhat.com>
In-Reply-To: <20220214174132.219303-1-david@redhat.com>
References: <20220214174132.219303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's factor out determining the minimum alignment requirement for CMA
and add a helpful comment.

No functional change intended.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/include/asm/fadump-internal.h |  5 -----
 arch/powerpc/kernel/fadump.c               |  2 +-
 drivers/of/of_reserved_mem.c               |  9 +++------
 include/linux/cma.h                        |  9 +++++++++
 kernel/dma/contiguous.c                    |  4 +---
 mm/cma.c                                   | 20 +++++---------------
 6 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump-internal.h b/arch/powerpc/include/asm/fadump-internal.h
index 52189928ec08..81bcb9abb371 100644
--- a/arch/powerpc/include/asm/fadump-internal.h
+++ b/arch/powerpc/include/asm/fadump-internal.h
@@ -19,11 +19,6 @@
 
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
-/* Alignment per CMA requirement. */
-#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
-				 max_t(unsigned long, MAX_ORDER - 1,	\
-				 pageblock_order))
-
 /* FAD commands */
 #define FADUMP_REGISTER			1
 #define FADUMP_UNREGISTER		2
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d03e488cfe9c..7eb67201ea41 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -544,7 +544,7 @@ int __init fadump_reserve_mem(void)
 		if (!fw_dump.nocma) {
 			fw_dump.boot_memory_size =
 				ALIGN(fw_dump.boot_memory_size,
-				      FADUMP_CMA_ALIGNMENT);
+				      CMA_MIN_ALIGNMENT_BYTES);
 		}
 #endif
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9c0fb962c22b..75caa6f5d36f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/cma.h>
 
 #include "of_private.h"
 
@@ -116,12 +117,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 	if (IS_ENABLED(CONFIG_CMA)
 	    && of_flat_dt_is_compatible(node, "shared-dma-pool")
 	    && of_get_flat_dt_prop(node, "reusable", NULL)
-	    && !nomap) {
-		unsigned long order =
-			max_t(unsigned long, MAX_ORDER - 1, pageblock_order);
-
-		align = max(align, (phys_addr_t)PAGE_SIZE << order);
-	}
+	    && !nomap)
+		align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
 
 	prop = of_get_flat_dt_prop(node, "alloc-ranges", &len);
 	if (prop) {
diff --git a/include/linux/cma.h b/include/linux/cma.h
index bd801023504b..75fe188ec4a1 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -20,6 +20,15 @@
 
 #define CMA_MAX_NAME 64
 
+/*
+ * TODO: once the buddy -- especially pageblock merging and alloc_contig_range()
+ * -- can deal with only some pageblocks of a higher-order page being
+ *  MIGRATE_CMA, we can use pageblock_nr_pages.
+ */
+#define CMA_MIN_ALIGNMENT_PAGES max_t(phys_addr_t, MAX_ORDER_NR_PAGES, \
+				      pageblock_nr_pages)
+#define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
+
 struct cma;
 
 extern unsigned long totalcma_pages;
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..6ea80ae42622 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -399,8 +399,6 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
-	phys_addr_t mask = align - 1;
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 	struct cma *cma;
@@ -416,7 +414,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
-	if ((rmem->base & mask) || (rmem->size & mask)) {
+	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
 		pr_err("Reserved memory: incorrect alignment of CMA region\n");
 		return -EINVAL;
 	}
diff --git a/mm/cma.c b/mm/cma.c
index bc9ca8f3c487..5a2cd5851658 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -168,7 +168,6 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 				 struct cma **res_cma)
 {
 	struct cma *cma;
-	phys_addr_t alignment;
 
 	/* Sanity checks */
 	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
@@ -179,15 +178,12 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!size || !memblock_is_region_reserved(base, size))
 		return -EINVAL;
 
-	/* ensure minimal alignment required by mm core */
-	alignment = PAGE_SIZE <<
-			max_t(unsigned long, MAX_ORDER - 1, pageblock_order);
-
 	/* alignment should be aligned with order_per_bit */
-	if (!IS_ALIGNED(alignment >> PAGE_SHIFT, 1 << order_per_bit))
+	if (!IS_ALIGNED(CMA_MIN_ALIGNMENT_PAGES, 1 << order_per_bit))
 		return -EINVAL;
 
-	if (ALIGN(base, alignment) != base || ALIGN(size, alignment) != size)
+	/* ensure minimal alignment required by mm core */
+	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;
 
 	/*
@@ -262,14 +258,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	if (alignment && !is_power_of_2(alignment))
 		return -EINVAL;
 
-	/*
-	 * Sanitise input arguments.
-	 * Pages both ends in CMA area could be merged into adjacent unmovable
-	 * migratetype page by page allocator's buddy algorithm. In the case,
-	 * you couldn't get a contiguous memory, which is not what we want.
-	 */
-	alignment = max(alignment,  (phys_addr_t)PAGE_SIZE <<
-			  max_t(unsigned long, MAX_ORDER - 1, pageblock_order));
+	/* Sanitise input arguments. */
+	alignment = max_t(phys_addr_t, alignment, CMA_MIN_ALIGNMENT_BYTES);
 	if (fixed && base & (alignment - 1)) {
 		ret = -EINVAL;
 		pr_err("Region at %pa must be aligned to %pa bytes\n",
-- 
2.34.1

