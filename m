Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61F84B58BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357190AbiBNRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:42:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiBNRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8B1B65438
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644860522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HkzlRRdo6yqhnTQGH6gMkxF53RbjGfg491HfYhh8cbk=;
        b=dbvdOVSgw+ACqctla/MhkG5Hsi6pwgIIBdRgQVJEOgoNWkll2XB7anRHy2YNOeLRm8+Epm
        toE2UZhkbq1bc6JbyHWEuJ1HfqZVSol08i0xc5VOVzeJ5LRgikBnq6WY4q+KCZ8giOjuI2
        NZd0JMhFCvUP1zfmmswkKOJwjE9kf3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-WRmKjxQsNriFtkzQAXa43A-1; Mon, 14 Feb 2022 12:41:59 -0500
X-MC-Unique: WRmKjxQsNriFtkzQAXa43A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CE881091DA0;
        Mon, 14 Feb 2022 17:41:57 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB017DE56;
        Mon, 14 Feb 2022 17:41:52 +0000 (UTC)
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
Subject: [PATCH v1 2/2] mm: enforce pageblock_order < MAX_ORDER
Date:   Mon, 14 Feb 2022 18:41:32 +0100
Message-Id: <20220214174132.219303-3-david@redhat.com>
In-Reply-To: <20220214174132.219303-1-david@redhat.com>
References: <20220214174132.219303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some places in the kernel don't really expect pageblock_order >=
MAX_ORDER, and it looks like this is only possible in corner cases:

1) CONFIG_DEFERRED_STRUCT_PAGE_INIT we'll end up freeing pageblock_order
   pages via __free_pages_core(), which cannot possibly work.

2) find_zone_movable_pfns_for_nodes() will roundup the ZONE_MOVABLE
   start PFN to MAX_ORDER_NR_PAGES. Consequently with a bigger
   pageblock_order, we could have a single pageblock partially managed by
   two zones.

3) compaction code runs into __fragmentation_index() with order
   >= MAX_ORDER, when checking WARN_ON_ONCE(order >= MAX_ORDER). [1]

4) mm/page_reporting.c won't be reporting any pages with default
   page_reporting_order == pageblock_order, as we'll be skipping the
   reporting loop inside page_reporting_process_zone().

5) __rmqueue_fallback() will never be able to steal with
   ALLOC_NOFRAGMENT.

pageblock_order >= MAX_ORDER is weird either way: it's a pure
optimization for making alloc_contig_range(), as used for allcoation of
gigantic pages, a little more reliable to succeed. However, if there is
demand for somewhat reliable allocation of gigantic pages, affected setups
should be using CMA or boottime allocations instead.

So let's make sure that pageblock_order < MAX_ORDER and simplify.

[1] https://lkml.kernel.org/r/87r189a2ks.fsf@linux.ibm.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c     |  9 +++------
 include/linux/cma.h             |  3 +--
 include/linux/pageblock-flags.h |  7 +++++--
 mm/Kconfig                      |  3 +++
 mm/page_alloc.c                 | 32 ++++++++------------------------
 5 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 38becd8d578c..e7d6b679596d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2476,13 +2476,10 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
 
 	/*
-	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
-	 * pageblock_nr_pages pages. This:
-	 * - Is required for now for alloc_contig_range() to work reliably -
-	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
+	 * TODO: once alloc_contig_range() works reliably with pageblock
+	 * granularity on ZONE_NORMAL, use pageblock_nr_pages instead.
 	 */
-	sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
-			pageblock_nr_pages) * PAGE_SIZE;
+	sb_size = PAGE_SIZE * MAX_ORDER_NR_PAGES;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 75fe188ec4a1..b1ba94f1cc9c 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -25,8 +25,7 @@
  * -- can deal with only some pageblocks of a higher-order page being
  *  MIGRATE_CMA, we can use pageblock_nr_pages.
  */
-#define CMA_MIN_ALIGNMENT_PAGES max_t(phys_addr_t, MAX_ORDER_NR_PAGES, \
-				      pageblock_nr_pages)
+#define CMA_MIN_ALIGNMENT_PAGES MAX_ORDER_NR_PAGES
 #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
 
 struct cma;
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 973fd731a520..83c7248053a1 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -37,8 +37,11 @@ extern unsigned int pageblock_order;
 
 #else /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
-/* Huge pages are a constant size */
-#define pageblock_order		HUGETLB_PAGE_ORDER
+/*
+ * Huge pages are a constant size, but don't exceed the maximum allocation
+ * granularity.
+ */
+#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_ORDER - 1)
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 3326ee3903f3..4c91b92e7537 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -262,6 +262,9 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 	  HUGETLB_PAGE_ORDER when there are multiple HugeTLB page sizes available
 	  on a platform.
 
+	  Note that the pageblock_order cannot exceed MAX_ORDER - 1 and will be
+	  clamped down to MAX_ORDER - 1.
+
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..04cf964b57b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1072,14 +1072,12 @@ static inline void __free_one_page(struct page *page,
 		int migratetype, fpi_t fpi_flags)
 {
 	struct capture_control *capc = task_capc(zone);
+	unsigned int max_order = pageblock_order;
 	unsigned long buddy_pfn;
 	unsigned long combined_pfn;
-	unsigned int max_order;
 	struct page *buddy;
 	bool to_tail;
 
-	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
-
 	VM_BUG_ON(!zone_is_initialized(zone));
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
 
@@ -2260,19 +2258,8 @@ void __init init_cma_reserved_pageblock(struct page *page)
 	} while (++p, --i);
 
 	set_pageblock_migratetype(page, MIGRATE_CMA);
-
-	if (pageblock_order >= MAX_ORDER) {
-		i = pageblock_nr_pages;
-		p = page;
-		do {
-			set_page_refcounted(p);
-			__free_pages(p, MAX_ORDER - 1);
-			p += MAX_ORDER_NR_PAGES;
-		} while (i -= MAX_ORDER_NR_PAGES);
-	} else {
-		set_page_refcounted(page);
-		__free_pages(page, pageblock_order);
-	}
+	set_page_refcounted(page);
+	__free_pages(page, pageblock_order);
 
 	adjust_managed_page_count(page, pageblock_nr_pages);
 	page_zone(page)->cma_pages += pageblock_nr_pages;
@@ -7389,16 +7376,15 @@ static inline void setup_usemap(struct zone *zone) {}
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
 void __init set_pageblock_order(void)
 {
-	unsigned int order;
+	unsigned int order = MAX_ORDER - 1;
 
 	/* Check that pageblock_nr_pages has not already been setup */
 	if (pageblock_order)
 		return;
 
-	if (HPAGE_SHIFT > PAGE_SHIFT)
+	/* Don't let pageblocks exceed the maximum allocation granularity. */
+	if (HPAGE_SHIFT > PAGE_SHIFT && HUGETLB_PAGE_ORDER < order)
 		order = HUGETLB_PAGE_ORDER;
-	else
-		order = MAX_ORDER - 1;
 
 	/*
 	 * Assume the largest contiguous order of interest is a huge page.
@@ -8986,14 +8972,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 #ifdef CONFIG_CONTIG_ALLOC
 static unsigned long pfn_max_align_down(unsigned long pfn)
 {
-	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
-			     pageblock_nr_pages) - 1);
+	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
 }
 
 static unsigned long pfn_max_align_up(unsigned long pfn)
 {
-	return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
-				pageblock_nr_pages));
+	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
 }
 
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
-- 
2.34.1

