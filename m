Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44000527BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiEPCBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiEPCBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:01:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47EF13CE6
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652666491; x=1684202491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOxaawGZIzuK4xnzeqSxzg8q19xNDedvZWN/kKyU3MY=;
  b=e65FvvHJ2M53UNIiBr2Tc6lMz5aCIx6O+GwKG02DaB7UrkZP6K78djxb
   VguH1GSUz7lxJUPViQwUpjY9M3A2wCUD7eDltUOUILtTMPmaFR8DjR5H5
   R622j9T+wUjMX0QeagLnk13OZoIqeHdYinNvbTisrmnKU2GeDAgHyNoso
   EAmD1eZXsUysfGjPsquq26W01R8qfBxlBeXcFNYvTvl8ZSj03n7m53ouU
   u9nH3ZJczQgTM3IDFIJIAT1hrVYEWrnh/mf8ztpsMSuqWa+R3nktBwt+J
   0N+YOVxkELgoMIg0eqhf+CXclR50Xrj9MOJJIn7ZGAoFBp7sKP7yqQDWY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270659028"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="270659028"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 19:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="713172214"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2022 19:01:28 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/5] iommu: Remove .detach_dev from iommu domain ops
Date:   Mon, 16 May 2022 09:57:59 +0800
Message-Id: <20220516015759.2952771-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .detach_dev callback is not used anymore. Reomve it to avoid dead
code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                   | 2 --
 include/trace/events/iommu.h            | 7 -------
 drivers/iommu/amd/iommu.c               | 1 -
 drivers/iommu/apple-dart.c              | 1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 -
 drivers/iommu/exynos-iommu.c            | 1 -
 drivers/iommu/fsl_pamu_domain.c         | 1 -
 drivers/iommu/intel/iommu.c             | 1 -
 drivers/iommu/iommu-traces.c            | 1 -
 drivers/iommu/ipmmu-vmsa.c              | 1 -
 drivers/iommu/msm_iommu.c               | 1 -
 drivers/iommu/mtk_iommu.c               | 1 -
 drivers/iommu/mtk_iommu_v1.c            | 1 -
 drivers/iommu/omap-iommu.c              | 1 -
 drivers/iommu/rockchip-iommu.c          | 1 -
 drivers/iommu/s390-iommu.c              | 1 -
 drivers/iommu/sprd-iommu.c              | 1 -
 drivers/iommu/sun50i-iommu.c            | 1 -
 drivers/iommu/tegra-gart.c              | 1 -
 drivers/iommu/tegra-smmu.c              | 1 -
 20 files changed, 27 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e228aad0ef6..a8c87ebef02d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -264,7 +264,6 @@ struct iommu_ops {
 /**
  * struct iommu_domain_ops - domain specific operations
  * @set_dev: set an iommu domain to a device
- * @detach_dev: detach an iommu domain from a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
@@ -287,7 +286,6 @@ struct iommu_ops {
  */
 struct iommu_domain_ops {
 	int (*set_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 29096fe12623..70743db1fb75 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -76,13 +76,6 @@ DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
 	TP_ARGS(dev)
 );
 
-DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
-
-	TP_PROTO(struct device *dev),
-
-	TP_ARGS(dev)
-);
-
 TRACE_EVENT(map,
 
 	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c66713439824..9ccf289196be 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2294,7 +2294,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= amd_iommu_attach_device,
-		.detach_dev	= amd_iommu_detach_device,
 		.map		= amd_iommu_map,
 		.unmap		= amd_iommu_unmap,
 		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 3c37762e01ec..640f2ebeba0c 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -784,7 +784,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= apple_dart_attach_dev,
-		.detach_dev	= apple_dart_detach_dev,
 		.map_pages	= apple_dart_map_pages,
 		.unmap_pages	= apple_dart_unmap_pages,
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index dee9b5a3a324..b6400458bcdb 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -605,7 +605,6 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= qcom_iommu_attach_dev,
-		.detach_dev	= qcom_iommu_detach_dev,
 		.map		= qcom_iommu_map,
 		.unmap		= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index bbecb9a2a554..0ed3ac3f6b28 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1324,7 +1324,6 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.of_xlate = exynos_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= exynos_iommu_attach_device,
-		.detach_dev	= exynos_iommu_detach_device,
 		.map		= exynos_iommu_map,
 		.unmap		= exynos_iommu_unmap,
 		.iova_to_phys	= exynos_iommu_iova_to_phys,
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 92fc320f8c83..8e32d7942835 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -467,7 +467,6 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.device_group   = fsl_pamu_device_group,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= fsl_pamu_attach_device,
-		.detach_dev	= fsl_pamu_detach_device,
 		.iova_to_phys	= fsl_pamu_iova_to_phys,
 		.free		= fsl_pamu_domain_free,
 	},
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2060e8a540b3..9b6b3d38de46 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4934,7 +4934,6 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev		= intel_iommu_attach_device,
-		.detach_dev		= intel_iommu_detach_device,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
diff --git a/drivers/iommu/iommu-traces.c b/drivers/iommu/iommu-traces.c
index 1e9ca7789de1..23416bf76df9 100644
--- a/drivers/iommu/iommu-traces.c
+++ b/drivers/iommu/iommu-traces.c
@@ -18,7 +18,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(remove_device_from_group);
 
 /* iommu_device_event */
 EXPORT_TRACEPOINT_SYMBOL_GPL(attach_device_to_domain);
-EXPORT_TRACEPOINT_SYMBOL_GPL(detach_device_from_domain);
 
 /* iommu_map_unmap */
 EXPORT_TRACEPOINT_SYMBOL_GPL(map);
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 72982d1277c2..5803f6175a46 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -886,7 +886,6 @@ static const struct iommu_ops ipmmu_ops = {
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= ipmmu_attach_device,
-		.detach_dev	= ipmmu_detach_device,
 		.map		= ipmmu_map,
 		.unmap		= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b0471d03db60..3f3ce24e1db6 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -691,7 +691,6 @@ static struct iommu_ops msm_iommu_ops = {
 	.of_xlate = qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= msm_iommu_attach_dev,
-		.detach_dev	= msm_iommu_detach_dev,
 		.map		= msm_iommu_map,
 		.unmap		= msm_iommu_unmap,
 		/*
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index cc8d80290498..63cb4379314c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -946,7 +946,6 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= mtk_iommu_attach_device,
-		.detach_dev	= mtk_iommu_detach_device,
 		.map		= mtk_iommu_map,
 		.unmap		= mtk_iommu_unmap,
 		.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 894d2526ba4c..3ffaadcf9a30 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -603,7 +603,6 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= mtk_iommu_v1_attach_device,
-		.detach_dev	= mtk_iommu_v1_detach_device,
 		.map		= mtk_iommu_v1_map,
 		.unmap		= mtk_iommu_v1_unmap,
 		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 7e6ba6f1218d..33ba73be932a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1748,7 +1748,6 @@ static const struct iommu_ops omap_iommu_ops = {
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= omap_iommu_attach_dev,
-		.detach_dev	= omap_iommu_detach_dev,
 		.map		= omap_iommu_map,
 		.unmap		= omap_iommu_unmap,
 		.iova_to_phys	= omap_iommu_iova_to_phys,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 29c803759a0b..3d3baad1bc36 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1202,7 +1202,6 @@ static const struct iommu_ops rk_iommu_ops = {
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= rk_iommu_attach_device,
-		.detach_dev	= rk_iommu_detach_device,
 		.map		= rk_iommu_map,
 		.unmap		= rk_iommu_unmap,
 		.iova_to_phys	= rk_iommu_iova_to_phys,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index a03bff562a44..e9ad001d086b 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -377,7 +377,6 @@ static const struct iommu_ops s390_iommu_ops = {
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= s390_iommu_attach_device,
-		.detach_dev	= s390_iommu_detach_device,
 		.map		= s390_iommu_map,
 		.unmap		= s390_iommu_unmap,
 		.iova_to_phys	= s390_iommu_iova_to_phys,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ab62063cee5b..b732cd894725 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -431,7 +431,6 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= sprd_iommu_attach_device,
-		.detach_dev	= sprd_iommu_detach_device,
 		.map		= sprd_iommu_map,
 		.unmap		= sprd_iommu_unmap,
 		.iotlb_sync_map	= sprd_iommu_sync_map,
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index a51a55ae0634..12da8e4fdef9 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -775,7 +775,6 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.release_device	= sun50i_iommu_release_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= sun50i_iommu_attach_device,
-		.detach_dev	= sun50i_iommu_detach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
 		.iova_to_phys	= sun50i_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 7e2aef7ae72e..152a04dd5753 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -287,7 +287,6 @@ static const struct iommu_ops gart_iommu_ops = {
 	.of_xlate	= gart_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= gart_iommu_attach_dev,
-		.detach_dev	= gart_iommu_detach_dev,
 		.map		= gart_iommu_map,
 		.unmap		= gart_iommu_unmap,
 		.iova_to_phys	= gart_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index fe2c463db230..f35ee4d07a33 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -980,7 +980,6 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.set_dev	= tegra_smmu_attach_dev,
-		.detach_dev	= tegra_smmu_detach_dev,
 		.map		= tegra_smmu_map,
 		.unmap		= tegra_smmu_unmap,
 		.iova_to_phys	= tegra_smmu_iova_to_phys,
-- 
2.25.1

