Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563285A27E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbiHZMgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344200AbiHZMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:36:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0DD9D46
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661517361; x=1693053361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sOThp6gvbzkwQaPwwF0GAMaALhyV1l4KHiUjVYiga9s=;
  b=Ex1vWWpdY6MBbngT6kdMgE7DT+kWhzkVtX8hcZQCxfta9y61IQ95vtcM
   re7oJuP3EhOLwMqoNLUd1yuIfdA4/m+UcWhUlUIZmlErlXYsZ4Hsm/kmF
   n2gpjO8fY5moczOJe6nFEYqhr4KhPJiUpn0XJlds3z+/5zneHpi97D/ye
   0ErQfMtFmL+ue5Un+aERek0RMx0MfRj0808bwsraOptzqvFVfdvrgg6Rj
   OYLzc8qZcfDBYT2qeVKSScF1JSj8TIQx+hlbaneuYoIpaVIqIdWLJ74sP
   u0doO1hcmqh8JhDwVUEnfxcWQawrCXYi8NuH/N/7Np4CDvJaqM6QkP9jR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="356210199"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="356210199"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606751990"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:35:52 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/3] iommu: Rename attach_dev to set_dev
Date:   Fri, 26 Aug 2022 20:30:14 +0800
Message-Id: <20220826123014.52709-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826123014.52709-1-baolu.lu@linux.intel.com>
References: <20220826123014.52709-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the retirement of the detach_dev callback, the naming of attach_dev
isn't meaningful anymore. Rename it to set_dev to restore its original
meaning, that is, setting an iommu domain to a device. From now on, after
the devices are probed, the core only sets various iommu domains to the
device, i.e. identity domain, dma domain, blocking domain and etc.
Conceptually, there's always an iommu domain setting on the device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                       | 4 ++--
 drivers/iommu/amd/iommu.c                   | 4 ++--
 drivers/iommu/apple-dart.c                  | 4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 4 ++--
 drivers/iommu/exynos-iommu.c                | 4 ++--
 drivers/iommu/fsl_pamu_domain.c             | 4 ++--
 drivers/iommu/intel/iommu.c                 | 4 ++--
 drivers/iommu/iommu.c                       | 4 ++--
 drivers/iommu/ipmmu-vmsa.c                  | 4 ++--
 drivers/iommu/msm_iommu.c                   | 4 ++--
 drivers/iommu/mtk_iommu.c                   | 4 ++--
 drivers/iommu/mtk_iommu_v1.c                | 4 ++--
 drivers/iommu/omap-iommu.c                  | 4 ++--
 drivers/iommu/rockchip-iommu.c              | 4 ++--
 drivers/iommu/s390-iommu.c                  | 6 +++---
 drivers/iommu/sprd-iommu.c                  | 4 ++--
 drivers/iommu/sun50i-iommu.c                | 4 ++--
 drivers/iommu/tegra-gart.c                  | 4 ++--
 drivers/iommu/tegra-smmu.c                  | 4 ++--
 drivers/iommu/virtio-iommu.c                | 2 +-
 22 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1e9fecfb23a7..0d3131c7bf11 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -273,7 +273,7 @@ struct iommu_ops {
 
 /**
  * struct iommu_domain_ops - domain specific operations
- * @attach_dev: attach an iommu domain to a device
+ * @set_dev: attach an iommu domain to a device
  * @set_dev_pasid: set an iommu domain to a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
@@ -293,7 +293,7 @@ struct iommu_ops {
  * @free: Release the domain after use.
  */
 struct iommu_domain_ops {
-	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*set_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
 			     ioasid_t pasid);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4cd0438b0a6e..620ad8d53773 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,7 +2078,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -2418,7 +2418,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= amd_iommu_attach_device,
+		.set_dev	= amd_iommu_attach_device,
 		.map		= amd_iommu_map,
 		.unmap		= amd_iommu_unmap,
 		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 5f46cbf04e07..01d7adb6b97a 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -580,7 +580,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -790,7 +790,7 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
 	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= apple_dart_attach_dev,
+		.set_dev	= apple_dart_attach_dev,
 		.map_pages	= apple_dart_map_pages,
 		.unmap_pages	= apple_dart_unmap_pages,
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a3c5b1a1203b..04d625aef897 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2032,7 +2032,7 @@ static int blocking_domain_set_dev_pasid(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev,
+		.set_dev	= blocking_domain_attach_dev,
 		.set_dev_pasid	= blocking_domain_set_dev_pasid
 	}
 };
@@ -2870,7 +2870,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev		= arm_smmu_attach_dev,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dfa82df00342..57e93727b5f5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1588,7 +1588,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev		= arm_smmu_attach_dev,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 59f8a4d3865c..a8d2bea55205 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -334,7 +334,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -607,7 +607,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.of_xlate	= qcom_iommu_of_xlate,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= qcom_iommu_attach_dev,
+		.set_dev	= qcom_iommu_attach_dev,
 		.map		= qcom_iommu_map,
 		.unmap		= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index f2958ec1868c..d2f5182bc50b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -833,7 +833,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -1427,7 +1427,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 	.of_xlate = exynos_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= exynos_iommu_attach_device,
+		.set_dev	= exynos_iommu_attach_device,
 		.map		= exynos_iommu_map,
 		.unmap		= exynos_iommu_unmap,
 		.iova_to_phys	= exynos_iommu_iova_to_phys,
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 66a7093c7852..740e45bce776 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -206,7 +206,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -474,7 +474,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.probe_device	= fsl_pamu_probe_device,
 	.device_group   = fsl_pamu_device_group,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= fsl_pamu_attach_device,
+		.set_dev	= fsl_pamu_attach_device,
 		.iova_to_phys	= fsl_pamu_iova_to_phys,
 		.free		= fsl_pamu_domain_free,
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f5ae4f7f916d..28493abd736e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4154,7 +4154,7 @@ static int blocking_domain_set_dev_pasid(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev,
+		.set_dev	= blocking_domain_attach_dev,
 		.set_dev_pasid	= blocking_domain_set_dev_pasid,
 	}
 };
@@ -4793,7 +4793,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.page_response		= intel_svm_page_response,
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= intel_iommu_attach_device,
+		.set_dev		= intel_iommu_attach_device,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ad34e4df1aad..8cb35ba60501 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2002,10 +2002,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (unlikely(domain->ops->attach_dev == NULL))
+	if (unlikely(!domain->ops->set_dev))
 		return -ENODEV;
 
-	ret = domain->ops->attach_dev(domain, dev);
+	ret = domain->ops->set_dev(domain, dev);
 	if (!ret)
 		trace_attach_device_to_domain(dev);
 	return ret;
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index cfb94e77bbab..4ebd9a15ce07 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -581,7 +581,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -898,7 +898,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= ipmmu_attach_device,
+		.set_dev	= ipmmu_attach_device,
 		.map		= ipmmu_map,
 		.unmap		= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f57f2da2d652..a6288a325076 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -317,7 +317,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -699,7 +699,7 @@ static struct iommu_ops msm_iommu_ops = {
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 	.of_xlate = qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= msm_iommu_attach_dev,
+		.set_dev	= msm_iommu_attach_dev,
 		.map		= msm_iommu_map,
 		.unmap		= msm_iommu_unmap,
 		/*
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 63360272d504..7c02b4fe8314 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -636,7 +636,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -954,7 +954,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= mtk_iommu_attach_device,
+		.set_dev	= mtk_iommu_attach_device,
 		.map		= mtk_iommu_map,
 		.unmap		= mtk_iommu_unmap,
 		.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 269622023917..221b3af5fa94 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -284,7 +284,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -610,7 +610,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= mtk_iommu_v1_attach_device,
+		.set_dev	= mtk_iommu_v1_attach_device,
 		.map		= mtk_iommu_v1_map,
 		.unmap		= mtk_iommu_v1_unmap,
 		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index ceb88fd96ac0..0bb75c0994c8 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1578,7 +1578,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -1758,7 +1758,7 @@ static const struct iommu_ops omap_iommu_ops = {
 	.device_group	= omap_iommu_device_group,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= omap_iommu_attach_dev,
+		.set_dev	= omap_iommu_attach_dev,
 		.map		= omap_iommu_map,
 		.unmap		= omap_iommu_unmap,
 		.iova_to_phys	= omap_iommu_iova_to_phys,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 3a8239ddbb4f..3b0bbc80b4aa 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1071,7 +1071,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -1212,7 +1212,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= rk_iommu_attach_device,
+		.set_dev	= rk_iommu_attach_device,
 		.map		= rk_iommu_map,
 		.unmap		= rk_iommu_unmap,
 		.iova_to_phys	= rk_iommu_iova_to_phys,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index b18c8302a23d..3b91c0570cbd 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -66,7 +66,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -221,7 +221,7 @@ static void s390_iommu_release_device(struct device *dev)
 	 * This is a workaround for a scenario where the IOMMU API common code
 	 * "forgets" to call the detach_dev callback: After binding a device
 	 * to vfio-pci and completing the VFIO_SET_IOMMU ioctl (which triggers
-	 * the attach_dev), removing the device via
+	 * the set_dev), removing the device via
 	 * "echo 1 > /sys/bus/pci/devices/.../remove" won't trigger detach_dev,
 	 * only release_device will be called via the BUS_NOTIFY_REMOVED_DEVICE
 	 * notifier.
@@ -399,7 +399,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= s390_iommu_attach_device,
+		.set_dev	= s390_iommu_attach_device,
 		.map		= s390_iommu_map,
 		.unmap		= s390_iommu_unmap,
 		.iova_to_phys	= s390_iommu_iova_to_phys,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 46c567c489d7..7629e107c266 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -147,7 +147,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -434,7 +434,7 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= sprd_iommu_attach_device,
+		.set_dev	= sprd_iommu_attach_device,
 		.map		= sprd_iommu_map,
 		.unmap		= sprd_iommu_unmap,
 		.iotlb_sync_map	= sprd_iommu_sync_map,
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 1e63e782d23e..289184549238 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -611,7 +611,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -785,7 +785,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.of_xlate	= sun50i_iommu_of_xlate,
 	.probe_device	= sun50i_iommu_probe_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= sun50i_iommu_attach_device,
+		.set_dev	= sun50i_iommu_attach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
 		.iova_to_phys	= sun50i_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 5d5669f60d23..c5f3d6feed24 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -153,7 +153,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -292,7 +292,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= gart_iommu_attach_dev,
+		.set_dev	= gart_iommu_attach_dev,
 		.map		= gart_iommu_map,
 		.unmap		= gart_iommu_unmap,
 		.iova_to_phys	= gart_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 54fddb5215a5..9b3e44e36b10 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -287,7 +287,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *_domain,
 
 static struct iommu_domain blocking_domain = {
 	.ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= blocking_domain_attach_dev
+		.set_dev	= blocking_domain_attach_dev
 	}
 };
 
@@ -990,7 +990,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.of_xlate = tegra_smmu_of_xlate,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= tegra_smmu_attach_dev,
+		.set_dev	= tegra_smmu_attach_dev,
 		.map		= tegra_smmu_map,
 		.unmap		= tegra_smmu_unmap,
 		.iova_to_phys	= tegra_smmu_iova_to_phys,
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08eeafc9529f..24de723f9158 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1016,7 +1016,7 @@ static struct iommu_ops viommu_ops = {
 	.of_xlate		= viommu_of_xlate,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= viommu_attach_dev,
+		.set_dev		= viommu_attach_dev,
 		.map_pages		= viommu_map_pages,
 		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
-- 
2.25.1

