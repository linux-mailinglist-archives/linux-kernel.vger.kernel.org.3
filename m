Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94836516942
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 03:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356775AbiEBBzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356538AbiEBBzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 21:55:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC71FCF4
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651456333; x=1682992333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UOUmO+8oZ5fwhZko7tx+eQ43DUxkM3NBL9B83j0eXd0=;
  b=bM/YAH3SaoFPFHOXGtOwpHnTU8piAQzapwUKd1YU0kOsp24yirMbFlkF
   f2mWDrP0JedDodpu4F91Dh42+SaQoVGqtlPNoS3KwkK9XMBHbz/Re/h1M
   Nt3/FKjPDtkaAXJ561oDRNLjJkFdVP/VsElOOCPHyN5wqY9/N9t4JaZmA
   GI4s8S+oUZwMq1POlTpinByWAgomwqCpTkd5aDPk91wXUFDivxWiqlqJY
   2RFZLvX8Pks24OwFVxHDBFG6DVuyC3k7h7ST+9OT2f9qT/aOtLk4ta05z
   ng/WPLwM213BeDfs6ZZkJZqyfOv0T9ps1+Ij3Oa6aRKW8tW7cma9B9zOO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="249062069"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="249062069"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 18:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="707406502"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2022 18:52:08 -0700
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
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 07/12] arm-smmu-v3/sva: Add SVA domain support
Date:   Mon,  2 May 2022 09:48:37 +0800
Message-Id: <20220502014842.991097-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502014842.991097-1-baolu.lu@linux.intel.com>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 42 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 ++++++++++
 3 files changed, 77 insertions(+)

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
index c623dae1e115..3b843cd3ed67 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -541,3 +541,45 @@ void arm_smmu_sva_notifier_synchronize(void)
 	 */
 	mmu_notifier_synchronize();
 }
+
+int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
+				  struct device *dev, ioasid_t id)
+{
+	int ret = 0;
+	struct iommu_sva *handle;
+	struct mm_struct *mm = iommu_sva_domain_mm(domain);
+
+	if (domain->type != IOMMU_DOMAIN_SVA || !mm)
+		return -EINVAL;
+
+	mutex_lock(&sva_lock);
+	handle = __arm_smmu_sva_bind(dev, mm);
+	if (IS_ERR(handle))
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
+	struct mm_struct *mm = iommu_sva_domain_mm(domain);
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
+		kfree(bond);
+	}
+	mutex_unlock(&sva_lock);
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index afc63fce6107..bd80de0bad98 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1995,10 +1995,31 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
+static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
+{
+	kfree(domain);
+}
+
+static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
+	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
+	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
+	.free			= arm_smmu_sva_domain_free,
+};
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
+	if (type == IOMMU_DOMAIN_SVA) {
+		struct iommu_domain *domain;
+
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (domain)
+			domain->ops = &arm_smmu_sva_domain_ops;
+
+		return domain;
+	}
+
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
 	    type != IOMMU_DOMAIN_DMA_FQ &&
-- 
2.25.1

