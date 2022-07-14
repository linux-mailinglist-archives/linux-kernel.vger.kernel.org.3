Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1975574BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiGNLWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbiGNLWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:22:18 -0400
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE874F642;
        Thu, 14 Jul 2022 04:22:15 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.156.147])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4LkBlx5H7xz9ttCk;
        Thu, 14 Jul 2022 19:17:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 13:22:07 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 12:22:03 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>,
        <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v6 1/6] dma-mapping: Add dma_opt_mapping_size()
Date:   Thu, 14 Jul 2022 19:15:24 +0800
Message-ID: <1657797329-98541-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Streaming DMA mapping involving an IOMMU may be much slower for larger
total mapping size. This is because every IOMMU DMA mapping requires an
IOVA to be allocated and freed. IOVA sizes above a certain limit are not
cached, which can have a big impact on DMA mapping performance.

Provide an API for device drivers to know this "optimal" limit, such that
they may try to produce mapping which don't exceed it.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 Documentation/core-api/dma-api.rst | 14 ++++++++++++++
 include/linux/dma-map-ops.h        |  1 +
 include/linux/dma-mapping.h        |  5 +++++
 kernel/dma/mapping.c               | 12 ++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 6d6d0edd2d27..829f20a193ca 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -204,6 +204,20 @@ Returns the maximum size of a mapping for the device. The size parameter
 of the mapping functions like dma_map_single(), dma_map_page() and
 others should not be larger than the returned value.
 
+::
+
+	size_t
+	dma_opt_mapping_size(struct device *dev);
+
+Returns the maximum optimal size of a mapping for the device.
+
+Mapping larger buffers may take much longer in certain scenarios. In
+addition, for high-rate short-lived streaming mappings, the upfront time
+spent on the mapping may account for an appreciable part of the total
+request lifetime. As such, if splitting larger requests incurs no
+significant performance penalty, then device drivers are advised to
+limit total DMA streaming mappings length to the returned value.
+
 ::
 
 	bool
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b3a4a6..98ceba6fa848 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -69,6 +69,7 @@ struct dma_map_ops {
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
 	size_t (*max_mapping_size)(struct device *dev);
+	size_t (*opt_mapping_size)(void);
 	unsigned long (*get_merge_boundary)(struct device *dev);
 };
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index dca2b1355bb1..fe3849434b2a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -144,6 +144,7 @@ int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
+size_t dma_opt_mapping_size(struct device *dev);
 bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 unsigned long dma_get_merge_boundary(struct device *dev);
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
@@ -266,6 +267,10 @@ static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
 }
+static inline size_t dma_opt_mapping_size(struct device *dev)
+{
+	return 0;
+}
 static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return false;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index db7244291b74..1bfe11b1edb6 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -773,6 +773,18 @@ size_t dma_max_mapping_size(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_max_mapping_size);
 
+size_t dma_opt_mapping_size(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	size_t size = SIZE_MAX;
+
+	if (ops && ops->opt_mapping_size)
+		size = ops->opt_mapping_size();
+
+	return min(dma_max_mapping_size(dev), size);
+}
+EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
+
 bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.35.3

