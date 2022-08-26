Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B7B5A27E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbiHZMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbiHZMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:35:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C187A26AF8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661517348; x=1693053348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WPpvL0WZJ2bHkHFsnDmPoQ6gWN/LGjpQ7H+MLfE3d9Q=;
  b=TM3e7bL5iv8csySdCMfS15WcuaPNzxTSFeXXCPeg+dX8qDxTzLs+2FA8
   0nCJ1r6dZK+HQTmYslLC+erqK6FUU8ZcL9x9xuoyBx9xQYAQ/mhk8ScVC
   DLbdzxmZDAYqYHDbWEzmK5D5pqgEOPvUnLErC/1k8G7hTSh55jYB7DURQ
   elwhOWvse/99bxo9k7JWlC3RMYudFQRQUozqbSC/3E/Uc9FNm9GKme/zX
   4NwkYpNiNiEiN7sj5CTRuO3pqGxONv52pD6hWsErJDSFq8Rz8NcB6+Z2g
   dFbAHSfh6fv54E3P8kDQGA7KqJcXl3Z69daVCv+Kck7SFxuMFScoth8iZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="356210170"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208,223";a="356210170"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208,223";a="606751947"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:35:44 -0700
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
Subject: [PATCH v2 1/3] iommu: Replace detach_dev with real blocking domains
Date:   Fri, 26 Aug 2022 20:30:12 +0800
Message-Id: <20220826123014.52709-2-baolu.lu@linux.intel.com>
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

From iommu core's point of view, detaching a domain from a device is
equal to attaching the group's blocking domain to the device. This
repalces all detach_dev callbacks in the IOMMU drivers with a real
blocking domain and handles detaching domain through it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/iommu.c               | 22 +++++++++++++++++++++-
 drivers/iommu/apple-dart.c              | 24 +++++++++++++++++++++---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 23 ++++++++++++++++++++++-
 drivers/iommu/exynos-iommu.c            | 23 ++++++++++++++++++++++-
 drivers/iommu/fsl_pamu_domain.c         | 22 +++++++++++++++++++++-
 drivers/iommu/ipmmu-vmsa.c              | 22 +++++++++++++++++++++-
 drivers/iommu/msm_iommu.c               | 23 ++++++++++++++++++++++-
 drivers/iommu/mtk_iommu.c               | 22 +++++++++++++++++++++-
 drivers/iommu/mtk_iommu_v1.c            | 22 +++++++++++++++++++++-
 drivers/iommu/omap-iommu.c              | 20 +++++++++++++++++++-
 drivers/iommu/rockchip-iommu.c          | 20 +++++++++++++++++++-
 drivers/iommu/s390-iommu.c              | 23 ++++++++++++++++++++++-
 drivers/iommu/sprd-iommu.c              | 23 ++++++++++++++++++++++-
 drivers/iommu/sun50i-iommu.c            | 23 ++++++++++++++++++++++-
 drivers/iommu/tegra-gart.c              | 20 +++++++++++++++++++-
 drivers/iommu/tegra-smmu.c              | 23 ++++++++++++++++++++++-
 16 files changed, 337 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 65b8e4fd8217..4cd0438b0a6e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,8 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
+static void amd_iommu_detach_device(struct iommu_domain *dom,
+				    struct device *dev);
 
 /****************************************************************************
  *
@@ -2064,10 +2066,29 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	return NULL;
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	amd_iommu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	/*
 	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
 	 * default to use IOMMU_DOMAIN_DMA[_FQ].
@@ -2398,7 +2419,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
-		.detach_dev	= amd_iommu_detach_device,
 		.map		= amd_iommu_map,
 		.unmap		= amd_iommu_unmap,
 		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 1b1725759262..5f46cbf04e07 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -568,12 +568,31 @@ static void apple_dart_release_device(struct device *dev)
 	kfree(cfg);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	apple_dart_detach_dev(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
 {
 	struct apple_dart_domain *dart_domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED &&
-	    type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_BLOCKED)
+	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
 	dart_domain = kzalloc(sizeof(*dart_domain), GFP_KERNEL);
@@ -583,7 +602,7 @@ static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
 	mutex_init(&dart_domain->init_lock);
 
 	/* no need to allocate pgtbl_ops or do any other finalization steps */
-	if (type == IOMMU_DOMAIN_IDENTITY || type == IOMMU_DOMAIN_BLOCKED)
+	if (type == IOMMU_DOMAIN_IDENTITY)
 		dart_domain->finalized = true;
 
 	return &dart_domain->domain;
@@ -772,7 +791,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= apple_dart_attach_dev,
-		.detach_dev	= apple_dart_detach_dev,
 		.map_pages	= apple_dart_map_pages,
 		.unmap_pages	= apple_dart_unmap_pages,
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 17235116d3bb..59f8a4d3865c 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -72,6 +72,9 @@ struct qcom_iommu_domain {
 	struct iommu_fwspec	*fwspec;
 };
 
+static void qcom_iommu_detach_dev(struct iommu_domain *domain,
+				  struct device *dev);
+
 static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct qcom_iommu_domain, domain);
@@ -319,10 +322,29 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	return ret;
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	qcom_iommu_detach_dev(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *qcom_iommu_domain_alloc(unsigned type)
 {
 	struct qcom_iommu_domain *qcom_domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 	/*
@@ -586,7 +608,6 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
-		.detach_dev	= qcom_iommu_detach_dev,
 		.map		= qcom_iommu_map,
 		.unmap		= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8e18984a0c4f..f2958ec1868c 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -174,6 +174,9 @@ static struct kmem_cache *lv2table_kmem_cache;
 static sysmmu_pte_t *zero_lv2_table;
 #define ZERO_LV2LINK mk_lv1ent_page(virt_to_phys(zero_lv2_table))
 
+static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
+				       struct device *dev);
+
 static sysmmu_pte_t *section_entry(sysmmu_pte_t *pgtable, sysmmu_iova_t iova)
 {
 	return pgtable + lv1ent_offset(iova);
@@ -818,12 +821,31 @@ static inline void exynos_iommu_set_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
 				   DMA_TO_DEVICE);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	exynos_iommu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 {
 	struct exynos_iommu_domain *domain;
 	dma_addr_t handle;
 	int i;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	/* Check if correct PTE offsets are initialized */
 	BUG_ON(PG_ENT_SHIFT < 0 || !dma_dev);
 
@@ -1406,7 +1428,6 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.of_xlate = exynos_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
-		.detach_dev	= exynos_iommu_detach_device,
 		.map		= exynos_iommu_map,
 		.unmap		= exynos_iommu_unmap,
 		.iova_to_phys	= exynos_iommu_iova_to_phys,
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 011f9ab7f743..66a7093c7852 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -23,6 +23,8 @@ static struct kmem_cache *iommu_devinfo_cache;
 static DEFINE_SPINLOCK(device_domain_lock);
 
 struct iommu_device pamu_iommu;	/* IOMMU core code handle */
+static void fsl_pamu_detach_device(struct iommu_domain *domain,
+				   struct device *dev);
 
 static struct fsl_dma_domain *to_fsl_dma_domain(struct iommu_domain *dom)
 {
@@ -192,10 +194,29 @@ static void fsl_pamu_domain_free(struct iommu_domain *domain)
 	kmem_cache_free(fsl_pamu_domain_cache, dma_domain);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	fsl_pamu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
 {
 	struct fsl_dma_domain *dma_domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -454,7 +475,6 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.device_group   = fsl_pamu_device_group,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= fsl_pamu_attach_device,
-		.detach_dev	= fsl_pamu_detach_device,
 		.iova_to_phys	= fsl_pamu_iova_to_phys,
 		.free		= fsl_pamu_domain_free,
 	}
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1d42084d0276..cfb94e77bbab 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -79,6 +79,9 @@ struct ipmmu_vmsa_domain {
 	struct mutex mutex;			/* Protects mappings */
 };
 
+static void ipmmu_detach_device(struct iommu_domain *io_domain,
+				struct device *dev);
+
 static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
@@ -566,11 +569,29 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 /* -----------------------------------------------------------------------------
  * IOMMU Operations
  */
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	ipmmu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
 
 static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
@@ -878,7 +899,6 @@ static const struct iommu_ops ipmmu_ops = {
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
-		.detach_dev	= ipmmu_detach_device,
 		.map		= ipmmu_map,
 		.unmap		= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6a24aa804ea3..f57f2da2d652 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -46,6 +46,9 @@ struct msm_priv {
 	spinlock_t		pgtlock; /* pagetable lock */
 };
 
+static void msm_iommu_detach_dev(struct iommu_domain *domain,
+				 struct device *dev);
+
 static struct msm_priv *to_msm_priv(struct iommu_domain *dom)
 {
 	return container_of(dom, struct msm_priv, domain);
@@ -302,10 +305,29 @@ static void __program_context(void __iomem *base, int ctx,
 	SET_M(base, ctx, 1);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	msm_iommu_detach_dev(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
 {
 	struct msm_priv *priv;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -678,7 +700,6 @@ static struct iommu_ops msm_iommu_ops = {
 	.of_xlate = qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
-		.detach_dev	= msm_iommu_detach_dev,
 		.map		= msm_iommu_map,
 		.unmap		= msm_iommu_unmap,
 		/*
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7e363b1f24df..63360272d504 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -264,6 +264,8 @@ static void mtk_iommu_unbind(struct device *dev)
 static const struct iommu_ops mtk_iommu_ops;
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int bankid);
+static void mtk_iommu_detach_device(struct iommu_domain *domain,
+				    struct device *dev);
 
 #define MTK_IOMMU_TLB_ADDR(iova) ({					\
 	dma_addr_t _addr = iova;					\
@@ -622,10 +624,29 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	return 0;
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	mtk_iommu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 {
 	struct mtk_iommu_domain *dom;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -934,7 +955,6 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_attach_device,
-		.detach_dev	= mtk_iommu_detach_device,
 		.map		= mtk_iommu_map,
 		.unmap		= mtk_iommu_unmap,
 		.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 128c7a3f1778..269622023917 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -116,6 +116,8 @@ struct mtk_iommu_v1_domain {
 	struct mtk_iommu_v1_data	*data;
 };
 
+static void mtk_iommu_v1_detach_device(struct iommu_domain *domain,
+				       struct device *dev);
 static int mtk_iommu_v1_bind(struct device *dev)
 {
 	struct mtk_iommu_v1_data *data = dev_get_drvdata(dev);
@@ -270,10 +272,29 @@ static int mtk_iommu_v1_domain_finalise(struct mtk_iommu_v1_data *data)
 	return 0;
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	mtk_iommu_v1_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *mtk_iommu_v1_domain_alloc(unsigned type)
 {
 	struct mtk_iommu_v1_domain *dom;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -590,7 +611,6 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_v1_attach_device,
-		.detach_dev	= mtk_iommu_v1_detach_device,
 		.map		= mtk_iommu_v1_map,
 		.unmap		= mtk_iommu_v1_unmap,
 		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d9cf2820c02e..ceb88fd96ac0 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1566,10 +1566,29 @@ static void omap_iommu_detach_dev(struct iommu_domain *domain,
 	spin_unlock(&omap_domain->lock);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	omap_iommu_detach_dev(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
 {
 	struct omap_iommu_domain *omap_domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -1740,7 +1759,6 @@ static const struct iommu_ops omap_iommu_ops = {
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= omap_iommu_attach_dev,
-		.detach_dev	= omap_iommu_detach_dev,
 		.map		= omap_iommu_map,
 		.unmap		= omap_iommu_unmap,
 		.iova_to_phys	= omap_iommu_iova_to_phys,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ab57c4b8fade..3a8239ddbb4f 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1059,10 +1059,29 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	rk_iommu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 {
 	struct rk_iommu_domain *rk_domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
@@ -1194,7 +1213,6 @@ static const struct iommu_ops rk_iommu_ops = {
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
-		.detach_dev	= rk_iommu_detach_device,
 		.map		= rk_iommu_map,
 		.unmap		= rk_iommu_unmap,
 		.iova_to_phys	= rk_iommu_iova_to_phys,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..b18c8302a23d 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -34,6 +34,9 @@ struct s390_domain_device {
 	struct zpci_dev		*zdev;
 };
 
+static void s390_iommu_detach_device(struct iommu_domain *domain,
+				     struct device *dev);
+
 static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct s390_domain, domain);
@@ -51,10 +54,29 @@ static bool s390_iommu_capable(enum iommu_cap cap)
 	}
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	s390_iommu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 {
 	struct s390_domain *s390_domain;
 
+	if (domain_type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (domain_type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -378,7 +400,6 @@ static const struct iommu_ops s390_iommu_ops = {
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
-		.detach_dev	= s390_iommu_detach_device,
 		.map		= s390_iommu_map,
 		.unmap		= s390_iommu_unmap,
 		.iova_to_phys	= s390_iommu_iova_to_phys,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 511959c8a14d..46c567c489d7 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -82,6 +82,9 @@ struct sprd_iommu_domain {
 
 static const struct iommu_ops sprd_iommu_ops;
 
+static void sprd_iommu_detach_device(struct iommu_domain *domain,
+				     struct device *dev);
+
 static struct sprd_iommu_domain *to_sprd_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct sprd_iommu_domain, domain);
@@ -132,10 +135,29 @@ sprd_iommu_pgt_size(struct iommu_domain *domain)
 		SPRD_IOMMU_PAGE_SHIFT) * sizeof(u32);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	sprd_iommu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 {
 	struct sprd_iommu_domain *dom;
 
+	if (domain_type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (domain_type != IOMMU_DOMAIN_DMA && domain_type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -413,7 +435,6 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sprd_iommu_attach_device,
-		.detach_dev	= sprd_iommu_detach_device,
 		.map		= sprd_iommu_map,
 		.unmap		= sprd_iommu_unmap,
 		.iotlb_sync_map	= sprd_iommu_sync_map,
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index a84c63518773..1e63e782d23e 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -121,6 +121,9 @@ struct sun50i_iommu_domain {
 	struct sun50i_iommu *iommu;
 };
 
+static void sun50i_iommu_detach_device(struct iommu_domain *domain,
+				       struct device *dev);
+
 static struct sun50i_iommu_domain *to_sun50i_domain(struct iommu_domain *domain)
 {
 	return container_of(domain, struct sun50i_iommu_domain, domain);
@@ -596,10 +599,29 @@ static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
 		sun50i_iova_get_page_offset(iova);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	sun50i_iommu_detach_device(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
 {
 	struct sun50i_iommu_domain *sun50i_domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_DMA &&
 	    type != IOMMU_DOMAIN_IDENTITY &&
 	    type != IOMMU_DOMAIN_UNMANAGED)
@@ -764,7 +786,6 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.probe_device	= sun50i_iommu_probe_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sun50i_iommu_attach_device,
-		.detach_dev	= sun50i_iommu_detach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
 		.iova_to_phys	= sun50i_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index e5ca3cf1a949..5d5669f60d23 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -141,10 +141,29 @@ static void gart_iommu_detach_dev(struct iommu_domain *domain,
 	spin_unlock(&gart->dom_lock);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	gart_iommu_detach_dev(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
 	struct iommu_domain *domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -274,7 +293,6 @@ static const struct iommu_ops gart_iommu_ops = {
 	.of_xlate	= gart_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= gart_iommu_attach_dev,
-		.detach_dev	= gart_iommu_detach_dev,
 		.map		= gart_iommu_map,
 		.unmap		= gart_iommu_unmap,
 		.iova_to_phys	= gart_iommu_iova_to_phys,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2a8de975fe63..54fddb5215a5 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -62,6 +62,9 @@ struct tegra_smmu_as {
 	u32 attr;
 };
 
+static void tegra_smmu_detach_dev(struct iommu_domain *domain,
+				  struct device *dev);
+
 static struct tegra_smmu_as *to_smmu_as(struct iommu_domain *dom)
 {
 	return container_of(dom, struct tegra_smmu_as, domain);
@@ -272,10 +275,29 @@ static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
 	clear_bit(id, smmu->asids);
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *_domain,
+				      struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	tegra_smmu_detach_dev(domain, dev);
+
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -969,7 +991,6 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= tegra_smmu_attach_dev,
-		.detach_dev	= tegra_smmu_detach_dev,
 		.map		= tegra_smmu_map,
 		.unmap		= tegra_smmu_unmap,
 		.iova_to_phys	= tegra_smmu_iova_to_phys,
-- 
2.25.1

