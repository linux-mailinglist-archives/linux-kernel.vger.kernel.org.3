Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C706520DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiEJGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiEJGZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:25:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75CD1F62E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652163664; x=1683699664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VjhNoKI6MtW1lOMCYZbpbYvPa5VAnC2OCUg7RydhhmI=;
  b=GzNcFKo69X2N/KIgKsbasrP2rtxT6Ql5GpMAGjt3usMgWGbNdoYGCrDS
   0n9QkPHo6JeQzh9+SOlIWRemrKBXeIvndqD+CLMHKf9gqsKTMlyzx8rvY
   3giLv0Us9FJcEQXio2J89P5hmLUR8YNpaDCH8uyOOaud8yrETo52nnW8b
   OqEoiUk+P/xGLK6ti1Z2WkglBmC91nB10wdDhTOzycvlspD07GCqsSwPc
   66/8JgFqjEpbCeTT9H2bru3FY1Hm6xKnDD4cBQAKABMOrVKZ0Fx3WJGqo
   Wu9srJfpUgwSN9IMWp2PDWdDaTes7xjKPq5Gb9KV9fjcnR8J+j2AlrUUl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="332312921"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="332312921"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="552636440"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:21:00 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v6 04/12] iommu/sva: Basic data structures for SVA
Date:   Tue, 10 May 2022 14:17:30 +0800
Message-Id: <20220510061738.2761430-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use below data structures for SVA implementation in the IOMMU core:

- struct iommu_domain (IOMMU_DOMAIN_SVA type)
  Represent a hardware pagetable that the IOMMU hardware could use for
  SVA translation. Multiple iommu domains could be bound with an SVA mm
  and each grabs a mm_count of the mm in order to make sure mm could
  only be freed after all domains have been unbound. A new mm field is
  added to struct iommu_domain and a helper is added to retrieve mm from
  a domain pointer.

- struct iommu_sva (existing)
  Represent a bond relationship between an SVA ioas and an iommu domain.
  If a bond already exists, it's reused and a reference is taken.

- struct dev_iommu::sva_bonds
  A pasid-indexed xarray to track the bonds happened on the device.

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 13 +++++++++++++
 drivers/iommu/iommu.c |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ab36244d4e94..2921e634491e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -64,6 +64,9 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
+#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
+#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
+
 /*
  * This are the possible domain-types
  *
@@ -86,6 +89,8 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
+				 __IOMMU_DOMAIN_HOST_VA)
 
 struct iommu_domain {
 	unsigned type;
@@ -95,6 +100,9 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+#ifdef CONFIG_IOMMU_SVA
+	struct mm_struct *mm;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -380,6 +388,9 @@ struct dev_iommu {
 	struct iommu_device		*iommu_dev;
 	void				*priv;
 	unsigned int			pasid_bits;
+#ifdef CONFIG_IOMMU_SVA
+	struct xarray			sva_bonds;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
@@ -629,6 +640,8 @@ struct iommu_fwspec {
  */
 struct iommu_sva {
 	struct device			*dev;
+	struct iommu_domain		*domain;
+	refcount_t			users;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 16e8db2d86fc..1abff5fc9554 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -202,6 +202,9 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 		return NULL;
 
 	mutex_init(&param->lock);
+#ifdef CONFIG_IOMMU_SVA
+	xa_init(&param->sva_bonds);
+#endif
 	dev->iommu = param;
 	return param;
 }
-- 
2.25.1

