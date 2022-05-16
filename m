Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD8E527BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbiEPCBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbiEPCBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:01:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDC12AC4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652666477; x=1684202477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lw/z1i0cdD3DhbXVRo4EJGfKaM6+wWlycH0aSNhGDhA=;
  b=m4qAxejcJMjxaFlUPnfEePY/M2yEDyNURj96IAOuo54/YaYGFCulBvbs
   CXzCiBHyYT1majMJ/GDQXGuBrDybDT6zBKm5oXi07UsQ1SM2JEEVGDi3H
   IhcWFmlgtjwQZ9QtCNrp2RXpVLvXXgdeS2EBvvl9ueMwdnQuWyRskz2rt
   c3luQyAdXyRNeQixofqVX8FHlSZfq/vvOdlGO543SgBorH1jqYmEk+1Fw
   J67UBXJho/0Qo2ZiZt7EbjV16M2anxuypFWzSxmQgT5dAnUCXdqLfso4m
   vHHar8RgWAQDr/CDHCgfZXZrvAsCdjYDKEjPTd2HAcOy/2K/3ohkP5zWO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270658985"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="270658985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 19:01:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="713172159"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2022 19:01:14 -0700
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
Subject: [PATCH 1/5] iommu: Rename attach_dev to set_dev in domain ops
Date:   Mon, 16 May 2022 09:57:55 +0800
Message-Id: <20220516015759.2952771-2-baolu.lu@linux.intel.com>
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

The detach callback of the iommu domain ops is not used in some IOMMU
drivers. The detach_dev actually means setting a default domain or a
blocking domain to the device. As attach_dev actually acts as setting
domain for a device, this renames attach_dev to set_dev to reflect the
actual usage.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                       | 4 ++--
 drivers/iommu/amd/iommu.c                   | 2 +-
 drivers/iommu/apple-dart.c                  | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 2 +-
 drivers/iommu/exynos-iommu.c                | 2 +-
 drivers/iommu/fsl_pamu_domain.c             | 2 +-
 drivers/iommu/intel/iommu.c                 | 2 +-
 drivers/iommu/iommu.c                       | 6 +++---
 drivers/iommu/ipmmu-vmsa.c                  | 2 +-
 drivers/iommu/msm_iommu.c                   | 2 +-
 drivers/iommu/mtk_iommu.c                   | 2 +-
 drivers/iommu/mtk_iommu_v1.c                | 2 +-
 drivers/iommu/omap-iommu.c                  | 2 +-
 drivers/iommu/rockchip-iommu.c              | 2 +-
 drivers/iommu/s390-iommu.c                  | 2 +-
 drivers/iommu/sprd-iommu.c                  | 2 +-
 drivers/iommu/sun50i-iommu.c                | 2 +-
 drivers/iommu/tegra-gart.c                  | 2 +-
 drivers/iommu/tegra-smmu.c                  | 2 +-
 drivers/iommu/virtio-iommu.c                | 2 +-
 22 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e1afe169549..572399ac1d83 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -261,7 +261,7 @@ struct iommu_ops {
 
 /**
  * struct iommu_domain_ops - domain specific operations
- * @attach_dev: attach an iommu domain to a device
+ * @set_dev: set an iommu domain to a device
  * @detach_dev: detach an iommu domain from a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
@@ -281,7 +281,7 @@ struct iommu_ops {
  * @free: Release the domain after use.
  */
 struct iommu_domain_ops {
-	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*set_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 840831d5d2ad..01b8668ef46d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2285,7 +2285,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= amd_iommu_attach_device,
+		.set_dev	= amd_iommu_attach_device,
 		.detach_dev	= amd_iommu_detach_device,
 		.map		= amd_iommu_map,
 		.unmap		= amd_iommu_unmap,
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 8af0242a90d9..a0b7281f1989 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -775,7 +775,7 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
 	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= apple_dart_attach_dev,
+		.set_dev	= apple_dart_attach_dev,
 		.detach_dev	= apple_dart_detach_dev,
 		.map_pages	= apple_dart_map_pages,
 		.unmap_pages	= apple_dart_unmap_pages,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 88817a3376ef..7e7d9e0b7aee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2859,7 +2859,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev		= arm_smmu_attach_dev,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ed3594f384e..c91d12b7e283 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1597,7 +1597,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev		= arm_smmu_attach_dev,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4c077c38fbd6..cf624bd305e0 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -596,7 +596,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.of_xlate	= qcom_iommu_of_xlate,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= qcom_iommu_attach_dev,
+		.set_dev	= qcom_iommu_attach_dev,
 		.detach_dev	= qcom_iommu_detach_dev,
 		.map		= qcom_iommu_map,
 		.unmap		= qcom_iommu_unmap,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 71f2018e23fe..797348f3440e 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1315,7 +1315,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 	.of_xlate = exynos_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= exynos_iommu_attach_device,
+		.set_dev	= exynos_iommu_attach_device,
 		.detach_dev	= exynos_iommu_detach_device,
 		.map		= exynos_iommu_map,
 		.unmap		= exynos_iommu_unmap,
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 94b4589dc67c..7512c8e007e9 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -458,7 +458,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.release_device	= fsl_pamu_release_device,
 	.device_group   = fsl_pamu_device_group,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= fsl_pamu_attach_device,
+		.set_dev	= fsl_pamu_attach_device,
 		.detach_dev	= fsl_pamu_detach_device,
 		.iova_to_phys	= fsl_pamu_iova_to_phys,
 		.free		= fsl_pamu_domain_free,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e56b3a4b6998..6abc1fbbd461 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4925,7 +4925,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.page_response		= intel_svm_page_response,
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= intel_iommu_attach_device,
+		.set_dev		= intel_iommu_attach_device,
 		.detach_dev		= intel_iommu_detach_device,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 847ad47a2dfd..8eba26be4363 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1963,10 +1963,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (unlikely(domain->ops->attach_dev == NULL))
+	if (unlikely(domain->ops->set_dev == NULL))
 		return -ENODEV;
 
-	ret = domain->ops->attach_dev(domain, dev);
+	ret = domain->ops->set_dev(domain, dev);
 	if (!ret)
 		trace_attach_device_to_domain(dev);
 	return ret;
@@ -2142,7 +2142,7 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 	}
 
 	/*
-	 * Changing the domain is done by calling attach_dev() on the new
+	 * Changing the domain is done by calling set_dev() on the new
 	 * domain. This switch does not have to be atomic and DMA can be
 	 * discarded during the transition. DMA must only be able to access
 	 * either new_domain or group->domain, never something else.
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8fdb84b3642b..b361a4cff688 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -877,7 +877,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= ipmmu_attach_device,
+		.set_dev	= ipmmu_attach_device,
 		.detach_dev	= ipmmu_detach_device,
 		.map		= ipmmu_map,
 		.unmap		= ipmmu_unmap,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f09aedfdd462..569d36840b67 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -682,7 +682,7 @@ static struct iommu_ops msm_iommu_ops = {
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 	.of_xlate = qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= msm_iommu_attach_dev,
+		.set_dev	= msm_iommu_attach_dev,
 		.detach_dev	= msm_iommu_detach_dev,
 		.map		= msm_iommu_map,
 		.unmap		= msm_iommu_unmap,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bb9dd92c9898..33ec401d40eb 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -937,7 +937,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= mtk_iommu_attach_device,
+		.set_dev	= mtk_iommu_attach_device,
 		.detach_dev	= mtk_iommu_detach_device,
 		.map		= mtk_iommu_map,
 		.unmap		= mtk_iommu_unmap,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index e1cb51b9866c..fb55802fb841 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -594,7 +594,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= mtk_iommu_v1_attach_device,
+		.set_dev	= mtk_iommu_v1_attach_device,
 		.detach_dev	= mtk_iommu_v1_detach_device,
 		.map		= mtk_iommu_v1_map,
 		.unmap		= mtk_iommu_v1_unmap,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d9cf2820c02e..6720dcb437a0 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1739,7 +1739,7 @@ static const struct iommu_ops omap_iommu_ops = {
 	.device_group	= omap_iommu_device_group,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= omap_iommu_attach_dev,
+		.set_dev	= omap_iommu_attach_dev,
 		.detach_dev	= omap_iommu_detach_dev,
 		.map		= omap_iommu_map,
 		.unmap		= omap_iommu_unmap,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ab57c4b8fade..0a4196c34179 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1193,7 +1193,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= rk_iommu_attach_device,
+		.set_dev	= rk_iommu_attach_device,
 		.detach_dev	= rk_iommu_detach_device,
 		.map		= rk_iommu_map,
 		.unmap		= rk_iommu_unmap,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 3833e86c6e7b..cde01c72f573 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -368,7 +368,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= s390_iommu_attach_device,
+		.set_dev	= s390_iommu_attach_device,
 		.detach_dev	= s390_iommu_detach_device,
 		.map		= s390_iommu_map,
 		.unmap		= s390_iommu_unmap,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index bd409bab6286..45b58845f5f8 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -423,7 +423,7 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= sprd_iommu_attach_device,
+		.set_dev	= sprd_iommu_attach_device,
 		.detach_dev	= sprd_iommu_detach_device,
 		.map		= sprd_iommu_map,
 		.unmap		= sprd_iommu_unmap,
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index c54ab477b8fd..041b30463552 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -766,7 +766,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.probe_device	= sun50i_iommu_probe_device,
 	.release_device	= sun50i_iommu_release_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= sun50i_iommu_attach_device,
+		.set_dev	= sun50i_iommu_attach_device,
 		.detach_dev	= sun50i_iommu_detach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index a6700a40a6f8..f083a9fba4d0 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -278,7 +278,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= gart_iommu_attach_dev,
+		.set_dev	= gart_iommu_attach_dev,
 		.detach_dev	= gart_iommu_detach_dev,
 		.map		= gart_iommu_map,
 		.unmap		= gart_iommu_unmap,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1fea68e551f1..36e9c2864e3f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -971,7 +971,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.of_xlate = tegra_smmu_of_xlate,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= tegra_smmu_attach_dev,
+		.set_dev	= tegra_smmu_attach_dev,
 		.detach_dev	= tegra_smmu_detach_dev,
 		.map		= tegra_smmu_map,
 		.unmap		= tegra_smmu_unmap,
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa0..ce2bd01806d8 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1017,7 +1017,7 @@ static struct iommu_ops viommu_ops = {
 	.of_xlate		= viommu_of_xlate,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= viommu_attach_dev,
+		.set_dev		= viommu_attach_dev,
 		.map			= viommu_map,
 		.unmap			= viommu_unmap,
 		.iova_to_phys		= viommu_iova_to_phys,
-- 
2.25.1

