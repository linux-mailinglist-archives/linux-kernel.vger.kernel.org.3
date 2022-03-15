Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD854D939E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiCOFMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbiCOFMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:12:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C349254
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647321068; x=1678857068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rk+QUCnbRB21mlAbYWkm6ssZeIW/wunY1IQvr0sPRwQ=;
  b=lyemL0cGDkiWesUiC9p0k5NrPG1zaBe4PG04W+4rIdWbJ7ZZGX3idI/f
   7hWLpq2FpABrk3H2/k2s3DIV2CM0qYUgDJzroLvOM29mnjomrRfAwy5sx
   BZNwJVc/BlMhWWh7tY5LLH1++1DwNfqV1UHUiuZnmpt/Ip4PTWydWwOaf
   6l6BGyhOhYBr4pdJGj1c3tT46mGOWEmnnZmeGqer3n2MwDPiokE+V4t0N
   xaOWKIHFDfNN+VrHGmyk3ShoTOQNq40lVLL2TN9tpzYVo3nxOW72llE95
   LNfle3zC/yJflndmVkM0Q6ym/tAvKiVEfMi6e0rTceKMX42lhdqsd3mKC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236159104"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="236159104"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="580383584"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:59 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Date:   Mon, 14 Mar 2022 22:07:09 -0700
Message-Id: <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA mapping API is the de facto standard for in-kernel DMA. It operates
on a per device/RID basis which is not PASID-aware.

Some modern devices such as Intel Data Streaming Accelerator, PASID is
required for certain work submissions. To allow such devices use DMA
mapping API, we need the following functionalities:
1. Provide device a way to retrieve a PASID for work submission within
the kernel
2. Enable the kernel PASID on the IOMMU for the device
3. Attach the kernel PASID to the device's default DMA domain, let it
be IOVA or physical address in case of pass-through.

This patch introduces a driver facing API that enables DMA API
PASID usage. Once enabled, device drivers can continue to use DMA APIs as
is. There is no difference in dma_handle between without PASID and with
PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++
 include/linux/iommu.h     |  9 ++++++
 3 files changed, 81 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b22034975301..d0ff1a34b1b6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -39,6 +39,8 @@ enum iommu_dma_cookie_type {
 	IOMMU_DMA_MSI_COOKIE,
 };
 
+static DECLARE_IOASID_SET(iommu_dma_pasid);
+
 struct iommu_dma_cookie {
 	enum iommu_dma_cookie_type	type;
 	union {
@@ -370,6 +372,69 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
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
+int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid)
+{
+	struct iommu_domain *dom;
+	ioasid_t id, max;
+	int ret;
+
+	dom = iommu_get_domain_for_dev(dev);
+	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
+		return -ENODEV;
+	max = iommu_get_dev_pasid_max(dev);
+	if (!max)
+		return -EINVAL;
+
+	id = ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
+	if (id == INVALID_IOASID)
+		return -ENOMEM;
+
+	ret = dom->ops->attach_dev_pasid(dom, dev, id);
+	if (ret) {
+		ioasid_put(id);
+		return ret;
+	}
+	*pasid = id;
+
+	return ret;
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
+void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *dom;
+
+	/* TODO: check the given PASID is within the ioasid_set */
+	dom = iommu_get_domain_for_dev(dev);
+	if (!dom->ops->detach_dev_pasid)
+		return;
+	dom->ops->detach_dev_pasid(dom, dev, pasid);
+	ioasid_put(pasid);
+}
+EXPORT_SYMBOL(iommu_disable_pasid_dma);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 24607dc3c2ac..e6cb9b52a420 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -18,6 +18,13 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
+/*
+ * For devices that can do DMA request with PASID, setup a system PASID.
+ * Address modes (IOVA, PA) are selected by the platform code.
+ */
+int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid);
+void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid);
+
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
 int iommu_dma_init_fq(struct iommu_domain *domain);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fde5b933dbe3..fb011722e4f8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -395,6 +395,15 @@ static inline void iommu_set_dev_pasid_max(struct device *dev,
 
 	param->pasid_max = max;
 }
+static inline ioasid_t iommu_get_dev_pasid_max(struct device *dev)
+{
+	struct dev_iommu *param = dev->iommu;
+
+	if (WARN_ON(!param))
+		return 0;
+
+	return param->pasid_max;
+}
 
 int iommu_device_register(struct iommu_device *iommu,
 			  const struct iommu_ops *ops,
-- 
2.25.1

