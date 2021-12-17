Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7268478FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhLQPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:31:54 -0500
Received: from foss.arm.com ([217.140.110.172]:58928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238280AbhLQPbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:31:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC1B14BF;
        Fri, 17 Dec 2021 07:31:15 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 165BB3F774;
        Fri, 17 Dec 2021 07:31:13 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org, hch@lst.de
Subject: [PATCH v3 2/9] iommu/iova: Squash entry_dtor abstraction
Date:   Fri, 17 Dec 2021 15:30:56 +0000
Message-Id: <2260f8de00ab5e0f9d2a1cf8978e6ae7cd4f182c.1639753638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639753638.git.robin.murphy@arm.com>
References: <cover.1639753638.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All flush queues are driven by iommu-dma now, so there is no need to
abstract entry_dtor or its data any more. Squash the now-canonical
implementation directly into the IOVA code to get it out of the way.

Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 17 ++---------------
 drivers/iommu/iova.c      | 28 +++++++++++++++-------------
 include/linux/iova.h      | 26 +++-----------------------
 3 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b42e38a0dbe2..fa21b9141b71 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -64,18 +64,6 @@ static int __init iommu_dma_forcedac_setup(char *str)
 }
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
-static void iommu_dma_entry_dtor(unsigned long data)
-{
-	struct page *freelist = (struct page *)data;
-
-	while (freelist) {
-		unsigned long p = (unsigned long)page_address(freelist);
-
-		freelist = freelist->freelist;
-		free_page(p);
-	}
-}
-
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
@@ -324,8 +312,7 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	if (cookie->fq_domain)
 		return 0;
 
-	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
-				    iommu_dma_entry_dtor);
+	ret = init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all);
 	if (ret) {
 		pr_warn("iova flush queue initialization failed\n");
 		return ret;
@@ -479,7 +466,7 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	else if (gather && gather->queued)
 		queue_iova(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad),
-				(unsigned long)gather->freelist);
+				gather->freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 920fcc27c9a1..280dd0c7fe1b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -91,11 +91,9 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
 
 	iovad->fq         = NULL;
 	iovad->flush_cb   = NULL;
-	iovad->entry_dtor = NULL;
 }
 
-int init_iova_flush_queue(struct iova_domain *iovad,
-			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor)
+int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb)
 {
 	struct iova_fq __percpu *queue;
 	int cpu;
@@ -108,7 +106,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 		return -ENOMEM;
 
 	iovad->flush_cb   = flush_cb;
-	iovad->entry_dtor = entry_dtor;
 
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq;
@@ -538,6 +535,16 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(free_iova_fast);
 
+static void fq_entry_dtor(struct page *freelist)
+{
+	while (freelist) {
+		unsigned long p = (unsigned long)page_address(freelist);
+
+		freelist = freelist->freelist;
+		free_page(p);
+	}
+}
+
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
 
@@ -570,9 +577,7 @@ static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 		if (fq->entries[idx].counter >= counter)
 			break;
 
-		if (iovad->entry_dtor)
-			iovad->entry_dtor(fq->entries[idx].data);
-
+		fq_entry_dtor(fq->entries[idx].freelist);
 		free_iova_fast(iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
@@ -597,15 +602,12 @@ static void fq_destroy_all_entries(struct iova_domain *iovad)
 	 * bother to free iovas, just call the entry_dtor on all remaining
 	 * entries.
 	 */
-	if (!iovad->entry_dtor)
-		return;
-
 	for_each_possible_cpu(cpu) {
 		struct iova_fq *fq = per_cpu_ptr(iovad->fq, cpu);
 		int idx;
 
 		fq_ring_for_each(idx, fq)
-			iovad->entry_dtor(fq->entries[idx].data);
+			fq_entry_dtor(fq->entries[idx].freelist);
 	}
 }
 
@@ -630,7 +632,7 @@ static void fq_flush_timeout(struct timer_list *t)
 
 void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
-		unsigned long data)
+		struct page *freelist)
 {
 	struct iova_fq *fq;
 	unsigned long flags;
@@ -664,7 +666,7 @@ void queue_iova(struct iova_domain *iovad,
 
 	fq->entries[idx].iova_pfn = pfn;
 	fq->entries[idx].pages    = pages;
-	fq->entries[idx].data     = data;
+	fq->entries[idx].freelist = freelist;
 	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
 
 	spin_unlock_irqrestore(&fq->lock, flags);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 71d8a2de6635..e746d8e41449 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -40,9 +40,6 @@ struct iova_domain;
 /* Call-Back from IOVA code into IOMMU drivers */
 typedef void (* iova_flush_cb)(struct iova_domain *domain);
 
-/* Destructor for per-entry data */
-typedef void (* iova_entry_dtor)(unsigned long data);
-
 /* Number of entries per Flush Queue */
 #define IOVA_FQ_SIZE	256
 
@@ -53,7 +50,7 @@ typedef void (* iova_entry_dtor)(unsigned long data);
 struct iova_fq_entry {
 	unsigned long iova_pfn;
 	unsigned long pages;
-	unsigned long data;
+	struct page *freelist;
 	u64 counter; /* Flush counter when this entrie was added */
 };
 
@@ -88,9 +85,6 @@ struct iova_domain {
 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
 					   TLBs */
 
-	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor for
-					   iova entry */
-
 	struct timer_list fq_timer;		/* Timer to regularily empty the
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
@@ -146,15 +140,14 @@ void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
 void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
-		unsigned long data);
+		struct page *freelist);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn, bool flush_rcache);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-int init_iova_flush_queue(struct iova_domain *iovad,
-			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
+int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
@@ -189,12 +182,6 @@ static inline void free_iova_fast(struct iova_domain *iovad,
 {
 }
 
-static inline void queue_iova(struct iova_domain *iovad,
-			      unsigned long pfn, unsigned long pages,
-			      unsigned long data)
-{
-}
-
 static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
 					    unsigned long size,
 					    unsigned long limit_pfn,
@@ -216,13 +203,6 @@ static inline void init_iova_domain(struct iova_domain *iovad,
 {
 }
 
-static inline int init_iova_flush_queue(struct iova_domain *iovad,
-					iova_flush_cb flush_cb,
-					iova_entry_dtor entry_dtor)
-{
-	return -ENODEV;
-}
-
 static inline struct iova *find_iova(struct iova_domain *iovad,
 				     unsigned long pfn)
 {
-- 
2.28.0.dirty

