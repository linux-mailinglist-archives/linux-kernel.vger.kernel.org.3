Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A64E1A80
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbiCTGoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244850AbiCTGoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:44:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A53277
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647758576; x=1679294576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DzrJvAObEWfBR46EFwvE37+RQ975CC6Vsc2tbNZ86Qs=;
  b=jjciCk36sXt5KMiP3DO+iA1udbHUwsDqJhLqwTytykuH4Xt5gqg4J4uZ
   qfxYh2r7l5wPKG2me6CXjG+q5jdYjQj1nGdIL1/Z8IreQRDFLhvk4l3ce
   hBSWyHz0cB64R8BqdNMkNHlzZir1fUQ2f52Bb12XyR+cKQMjybxc8mx2E
   Mko8DnUqAUwbiq7J1Kyr+fsyQox+U3zUqF+xqLBTbzifwzWONSXCUse66
   HxSHtaDEMbpPTqlaL+TgYzivj7gnsWOt83YNo0gN+LtEQ9BCNtT56q3Lu
   fvQfExXK5m2JOhGQWt3vEeU8fbq0UyKy/pCnIMUp/3NWZBeSHmWJ7Rkj9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254924028"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254924028"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="691839914"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:52 -0700
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
Subject: [PATCH RFC 05/11] arm-smmu-v3/sva: Add SVA domain support
Date:   Sun, 20 Mar 2022 14:40:24 +0800
Message-Id: <20220320064030.2936936-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 ++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 45 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 13 +++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cd48590ada30..7631c00fdcbd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -759,6 +759,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
+int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
+				  struct device *dev, ioasid_t id);
+void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -804,5 +808,15 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 }
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
+
+static inline int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
+						struct device *dev, ioasid_t id)
+{
+	return -ENODEV;
+}
+
+static inline void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
+						 struct device *dev,
+						 ioasid_t id) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 22ddd05bbdcd..1e114b9dc17f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -534,3 +534,48 @@ void arm_smmu_sva_notifier_synchronize(void)
 	 */
 	mmu_notifier_synchronize();
 }
+
+int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
+				  struct device *dev, ioasid_t id)
+{
+	int ret = 0;
+	struct iommu_sva *handle;
+	struct mm_struct *mm = domain->sva_cookie;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1 ||
+	    domain->type != IOMMU_DOMAIN_SVA || !mm)
+		return -EINVAL;
+
+	mutex_lock(&sva_lock);
+	handle = __arm_smmu_sva_bind(dev, mm);
+	if (IS_ERR_OR_NULL(handle))
+		ret = PTR_ERR(handle);
+	mutex_unlock(&sva_lock);
+
+	return ret;
+}
+
+void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t id)
+{
+	struct arm_smmu_bond *bond = NULL, *t;
+	struct mm_struct *mm = domain->sva_cookie;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&sva_lock);
+	list_for_each_entry(t, &master->bonds, list) {
+		if (t->mm == mm) {
+			bond = t;
+			break;
+		}
+	}
+
+	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
+		list_del(&bond->list);
+		arm_smmu_mmu_notifier_put(bond->smmu_mn);
+		iommu_sva_free_pasid(bond->mm);
+		kfree(bond);
+	}
+	mutex_unlock(&sva_lock);
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8e262210b5ad..2e9d3cd30510 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -88,6 +88,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static void arm_smmu_domain_free(struct iommu_domain *domain);
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -1995,6 +1997,12 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
+static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
+	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
+	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
+	.free			= arm_smmu_domain_free,
+};
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
@@ -2002,7 +2010,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
 	    type != IOMMU_DOMAIN_DMA_FQ &&
-	    type != IOMMU_DOMAIN_IDENTITY)
+	    type != IOMMU_DOMAIN_IDENTITY &&
+	    type != IOMMU_DOMAIN_SVA)
 		return NULL;
 
 	/*
@@ -2018,6 +2027,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
+	if (type == IOMMU_DOMAIN_SVA)
+		smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
 
 	return &smmu_domain->domain;
 }
-- 
2.25.1

