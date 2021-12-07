Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619FA46C791
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbhLGWik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:38:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:41972 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242238AbhLGWif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:38:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237509349"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237509349"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="515845493"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2021 14:35:03 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
Date:   Tue,  7 Dec 2021 05:47:12 -0800
Message-Id: <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA mapping API is the de facto standard for in-kernel DMA. It operates
on a per device/RID basis which is not PASID-aware.

Some modern devices such as Intel Data Streaming Accelerator, PASID is
required for certain work submissions. To allow such devices use DMA
mapping API, we need the following functionalities:
1. Provide device a way to retrieve a kernel PASID for work submission
2. Enable the kernel PASID on the IOMMU
3. Establish address space for the kernel PASID that matches the default
   domain. Let it be IOVA or physical address in case of pass-through.

This patch introduces a driver facing API that enables DMA API
PASID usage. Once enabled, device drivers can continue to use DMA APIs as
is. There is no difference in dma_handle between without PASID and with
PASID.

To manage device IOTLB flush at PASID level, this patch also introduces
a .pasid field to struct device. This also serves as a flag indicating
whether PASID is being used for the device to perform in-kernel DMA.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 71 +++++++++++++++++++++++++++++++++++++++
 include/linux/device.h    |  1 +
 include/linux/dma-iommu.h |  7 ++++
 include/linux/iommu.h     |  4 +++
 4 files changed, 83 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b42e38a0dbe2..8855d5e99d8e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -167,6 +167,77 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	domain->iova_cookie = NULL;
 }
 
+/**
+ * iommu_enable_pasid_dma --Enable in-kernel DMA request with PASID
+ * @dev:	Device to be enabled
+ *
+ * DMA request with PASID will be mapped the same way as the legacy DMA.
+ * If the device is in pass-through, PASID will also pass-through. If the
+ * device is in IOVA map, the supervisor PASID will point to the same IOVA
+ * page table.
+ *
+ * @return the kernel PASID to be used for DMA or INVALID_IOASID on failure
+ */
+ioasid_t iommu_enable_pasid_dma(struct device *dev)
+{
+	struct iommu_domain *dom;
+
+	if (dev->pasid) {
+		dev_err(dev, "PASID DMA already enabled\n");
+		return IOASID_DMA_PASID;
+	}
+	dom = iommu_get_domain_for_dev(dev);
+
+	if (!dom) {
+		dev_err(dev, "No IOMMU domain\n");
+		return INVALID_IOASID;
+	}
+
+	/*
+	 * Use the reserved kernel PASID for all devices. For now,
+	 * there is no need to have different PASIDs for in-kernel use.
+	 */
+	if (!dom->ops->enable_pasid_dma || dom->ops->enable_pasid_dma(dev, IOASID_DMA_PASID))
+		return INVALID_IOASID;
+	/* Used for device IOTLB flush */
+	dev->pasid = IOASID_DMA_PASID;
+
+	return IOASID_DMA_PASID;
+}
+EXPORT_SYMBOL(iommu_enable_pasid_dma);
+
+/**
+ * iommu_disable_pasid_dma --Disable in-kernel DMA request with PASID
+ * @dev:	Device's PASID DMA to be disabled
+ *
+ * It is the device driver's responsibility to ensure no more incoming DMA
+ * requests with the kernel PASID before calling this function. IOMMU driver
+ * ensures PASID cache, IOTLBs related to the kernel PASID are cleared and
+ * drained.
+ *
+ * @return 0 on success or error code on failure
+ */
+int iommu_disable_pasid_dma(struct device *dev)
+{
+	struct iommu_domain *dom;
+	int ret = 0;
+
+	if (!dev->pasid) {
+		dev_err(dev, "PASID DMA not enabled\n");
+		return -ENODEV;
+	}
+	dom = iommu_get_domain_for_dev(dev);
+	if (!dom->ops->disable_pasid_dma)
+		return -ENOTSUPP;
+
+	ret = dom->ops->disable_pasid_dma(dev);
+	if (!ret)
+		dev->pasid = 0;
+
+	return ret;
+}
+EXPORT_SYMBOL(iommu_disable_pasid_dma);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/device.h b/include/linux/device.h
index e270cb740b9e..8afa033b8b0b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -559,6 +559,7 @@ struct device {
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
+	u32			pasid;	/* For in-kernel DMA w/ PASID */
 
 	enum device_removable	removable;
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 24607dc3c2ac..298b31e3a007 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -18,6 +18,13 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
+/*
+ * For devices that can do DMA request with PASID, setup a system PASID.
+ * Address modes (IOVA, PA) are selected by the platform code.
+ */
+ioasid_t iommu_enable_pasid_dma(struct device *dev);
+int iommu_disable_pasid_dma(struct device *dev);
+
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
 int iommu_dma_init_fq(struct iommu_domain *domain);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d2f3435e7d17..45d281849c93 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -236,6 +236,8 @@ struct iommu_iotlb_gather {
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
  *		- 0: use the default setting
+ * @enable_pasid_dma: Set up PASID for in-kernel DMA
+ * @disable_pasid_dma: Disable in-kernel DMA with PASID on the device
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  */
@@ -310,6 +312,8 @@ struct iommu_ops {
 
 	int (*def_domain_type)(struct device *dev);
 
+	int (*enable_pasid_dma)(struct device *dev, u32 pasid);
+	int (*disable_pasid_dma)(struct device *dev);
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
-- 
2.25.1

