Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67AC4B58A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357131AbiBNRfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:35:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357124AbiBNRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:35:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BAF65416
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:34:56 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JyBDW220Bz6H6jL;
        Tue, 15 Feb 2022 01:34:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 18:34:54 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 17:34:51 +0000
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <hch@lst.de>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v5 2/5] iova: Allow rcache range upper limit to be flexible
Date:   Tue, 15 Feb 2022 01:29:03 +0800
Message-ID: <1644859746-20279-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
References: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some low-level drivers may request DMA mappings whose IOVA length exceeds
that of the current rcache upper limit.

This means that allocations for those IOVAs will never be cached, and
always must be allocated and freed from the RB tree per DMA mapping cycle.
This has a significant effect on performance, more so since commit
4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
fails"), as discussed at [0].

As a first step towards allowing the rcache range upper limit be
configured, hold this value in the IOVA rcache structure, and allocate
the rcaches separately.

Delete macro IOVA_RANGE_CACHE_MAX_SIZE in case it's reused by mistake.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 20 ++++++++++----------
 include/linux/iova.h |  3 +++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 7e9c3a97c040..f6eb93c737cb 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -15,8 +15,6 @@
 /* The anchor node sits above the top of the usable address space */
 #define IOVA_ANCHOR	~0UL
 
-#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
-
 static bool iova_rcache_insert(struct iova_domain *iovad,
 			       unsigned long pfn,
 			       unsigned long size);
@@ -442,7 +440,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 	 * rounding up anything cacheable to make sure that can't happen. The
 	 * order of the unadjusted size will still match upon freeing.
 	 */
-	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
+	if (size < (1 << (iovad->rcache_max_size - 1)))
 		size = roundup_pow_of_two(size);
 
 	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
@@ -712,13 +710,15 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, ret;
 
-	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
+	iovad->rcache_max_size = 6; /* Arbitrarily high default */
+
+	iovad->rcaches = kcalloc(iovad->rcache_max_size,
 				 sizeof(struct iova_rcache),
 				 GFP_KERNEL);
 	if (!iovad->rcaches)
 		return -ENOMEM;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < iovad->rcache_max_size; ++i) {
 		struct iova_cpu_rcache *cpu_rcache;
 		struct iova_rcache *rcache;
 
@@ -815,7 +815,7 @@ static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
 {
 	unsigned int log_size = order_base_2(size);
 
-	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
+	if (log_size >= iovad->rcache_max_size)
 		return false;
 
 	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
@@ -871,7 +871,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 {
 	unsigned int log_size = order_base_2(size);
 
-	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
+	if (log_size >= iovad->rcache_max_size || !iovad->rcaches)
 		return 0;
 
 	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
@@ -887,7 +887,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 	unsigned int cpu;
 	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < iovad->rcache_max_size; ++i) {
 		rcache = &iovad->rcaches[i];
 		if (!rcache->cpu_rcaches)
 			break;
@@ -915,7 +915,7 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 	unsigned long flags;
 	int i;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < iovad->rcache_max_size; ++i) {
 		rcache = &iovad->rcaches[i];
 		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
 		spin_lock_irqsave(&cpu_rcache->lock, flags);
@@ -934,7 +934,7 @@ static void free_global_cached_iovas(struct iova_domain *iovad)
 	unsigned long flags;
 	int i, j;
 
-	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+	for (i = 0; i < iovad->rcache_max_size; ++i) {
 		rcache = &iovad->rcaches[i];
 		spin_lock_irqsave(&rcache->lock, flags);
 		for (j = 0; j < rcache->depot_size; ++j) {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 320a70e40233..02f7222fa85a 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -38,6 +38,9 @@ struct iova_domain {
 
 	struct iova_rcache	*rcaches;
 	struct hlist_node	cpuhp_dead;
+
+	/* log of max cached IOVA range size (in pages) */
+	unsigned long	rcache_max_size;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
2.26.2

