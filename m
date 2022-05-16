Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1C52850D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiEPNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiEPNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:12:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E731EAD7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:12:50 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L20303zmSz6H7Kh;
        Mon, 16 May 2022 21:09:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 16 May 2022 15:12:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 14:12:45 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <hch@lst.de>,
        <robin.murphy@arm.com>, <m.szyprowski@samsung.com>
CC:     <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <liyihang6@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Date:   Mon, 16 May 2022 21:06:01 +0800
Message-ID: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
exceeds the IOVA rcache upper limit (meaning that they are not cached),
performance can be reduced.

Add the IOMMU callback for DMA mapping API dma_max_mapping_size(), which
allows the drivers to know the mapping limit and thus limit the requested 
IOVA lengths.

This resolves the performance issue originally reported in [0] for a SCSI
HBA driver which was regularly mapping SGLs which required IOVAs in
excess of the IOVA caching limit. In this case the block layer limits the
max sectors per request - as configured in __scsi_init_queue() - which
will limit the total SGL length the driver tries to map and in turn limits
IOVA lengths requested.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/

Signed-off-by: John Garry <john.garry@huawei.com>
---
Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, and not
a hard limit which I expect is the semantics of dma_map_ops.max_mapping_size

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..e2d5205cde37 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1442,6 +1442,21 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
 	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
 }
 
+static size_t iommu_dma_max_mapping_size(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_dma_cookie *cookie;
+
+	if (!domain)
+		return 0;
+
+	cookie = domain->iova_cookie;
+	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
+		return 0;
+
+	return iova_rcache_range();
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
@@ -1462,6 +1477,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.map_resource		= iommu_dma_map_resource,
 	.unmap_resource		= iommu_dma_unmap_resource,
 	.get_merge_boundary	= iommu_dma_get_merge_boundary,
+	.max_mapping_size	= iommu_dma_max_mapping_size,
 };
 
 /*
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index db77aa675145..9f00b58d546e 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -26,6 +26,11 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 
+unsigned long iova_rcache_range(void)
+{
+	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
+}
+
 static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct iova_domain *iovad;
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 320a70e40233..ae3e18d77e6c 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -79,6 +79,8 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 int iova_cache_get(void);
 void iova_cache_put(void);
 
+unsigned long iova_rcache_range(void);
+
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
@@ -105,6 +107,11 @@ static inline void iova_cache_put(void)
 {
 }
 
+static inline unsigned long iova_rcache_range(void)
+{
+	return 0;
+}
+
 static inline void free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
 }
-- 
2.26.2

