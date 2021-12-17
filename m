Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734CD478FED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbhLQPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:32:00 -0500
Received: from foss.arm.com ([217.140.110.172]:58950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238821AbhLQPbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:31:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2C5A1515;
        Fri, 17 Dec 2021 07:31:16 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F4963F774;
        Fri, 17 Dec 2021 07:31:15 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org, hch@lst.de
Subject: [PATCH v3 3/9] iommu/iova: Squash flush_cb abstraction
Date:   Fri, 17 Dec 2021 15:30:57 +0000
Message-Id: <e3f9b4acdd6640012ef4fbc819ac868d727b64a9.1639753638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639753638.git.robin.murphy@arm.com>
References: <cover.1639753638.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, with iommu-dma now being the only flush queue user, we no
longer need the extra level of indirection through flush_cb. Squash that
and let the flush queue code call the domain method directly. This does
mean temporarily having to carry an additional copy of the IOMMU domain
pointer around instead, but only until a later patch untangles it again.

Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 13 +------------
 drivers/iommu/iova.c      | 11 +++++------
 include/linux/iova.h      | 11 +++--------
 3 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index fa21b9141b71..cde887530549 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -282,17 +282,6 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
-{
-	struct iommu_dma_cookie *cookie;
-	struct iommu_domain *domain;
-
-	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
-	domain = cookie->fq_domain;
-
-	domain->ops->flush_iotlb_all(domain);
-}
-
 static bool dev_is_untrusted(struct device *dev)
 {
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
@@ -312,7 +301,7 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	if (cookie->fq_domain)
 		return 0;
 
-	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all);
+	ret = init_iova_flush_queue(&cookie->iovad, domain);
 	if (ret) {
 		pr_warn("iova flush queue initialization failed\n");
 		return ret;
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 280dd0c7fe1b..76bc6f39fac7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -63,7 +63,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
-	iovad->flush_cb = NULL;
+	iovad->fq_domain = NULL;
 	iovad->fq = NULL;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
@@ -90,10 +90,10 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
 	free_percpu(iovad->fq);
 
 	iovad->fq         = NULL;
-	iovad->flush_cb   = NULL;
+	iovad->fq_domain  = NULL;
 }
 
-int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb)
+int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain)
 {
 	struct iova_fq __percpu *queue;
 	int cpu;
@@ -105,8 +105,6 @@ int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb)
 	if (!queue)
 		return -ENOMEM;
 
-	iovad->flush_cb   = flush_cb;
-
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq;
 
@@ -117,6 +115,7 @@ int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb)
 		spin_lock_init(&fq->lock);
 	}
 
+	iovad->fq_domain = fq_domain;
 	iovad->fq = queue;
 
 	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
@@ -589,7 +588,7 @@ static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 static void iova_domain_flush(struct iova_domain *iovad)
 {
 	atomic64_inc(&iovad->fq_flush_start_cnt);
-	iovad->flush_cb(iovad);
+	iovad->fq_domain->ops->flush_iotlb_all(iovad->fq_domain);
 	atomic64_inc(&iovad->fq_flush_finish_cnt);
 }
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index e746d8e41449..99be4fcea4f3 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -14,6 +14,7 @@
 #include <linux/rbtree.h>
 #include <linux/atomic.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
 
 /* iova structure */
 struct iova {
@@ -35,11 +36,6 @@ struct iova_rcache {
 	struct iova_cpu_rcache __percpu *cpu_rcaches;
 };
 
-struct iova_domain;
-
-/* Call-Back from IOVA code into IOMMU drivers */
-typedef void (* iova_flush_cb)(struct iova_domain *domain);
-
 /* Number of entries per Flush Queue */
 #define IOVA_FQ_SIZE	256
 
@@ -82,8 +78,7 @@ struct iova_domain {
 	struct iova	anchor;		/* rbtree lookup anchor */
 	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
 
-	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
-					   TLBs */
+	struct iommu_domain *fq_domain;
 
 	struct timer_list fq_timer;		/* Timer to regularily empty the
 						   flush-queues */
@@ -147,7 +142,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb);
+int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
-- 
2.28.0.dirty

