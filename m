Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597553F3A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiFGBy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiFGByA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:54:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380A96D4C8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654566838; x=1686102838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vfynLd119ywRz5UqRqqA/gVGs+cQFCTNspKWdtr3dCs=;
  b=XWLMSnI5wUgxQ2CfEKSYga9wrv+Meg+larUbzEFkKzWO6CwJ7mU/pNNL
   W5YyIsS70K4ewwhpe2j7iz9IMGibU+Tx0wxMzlxBHSXb8B9bLrG1bhsO4
   zbFYiunW079WldWOwQH8ax3/8PL9PvuF8G47ZPSg6QjQtOEQ/yg7t7bVU
   4+XdAlOpT2F8wjDmNg9RGp7WSL2wksoyq1Q9p8+9LmRw/2fJ9Vbsfa+Ca
   7G3dlcn/6heKFbkLtj2TOo5V4fgKJCxEJO1695YKGBcDPGETBZeK/J2/7
   Ylp2CwB7MDRcuwZ2RBnCZIDRbBQ7oRjph3Vd3ePmLmfiT9Pby15z81EEL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="302064142"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="302064142"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="635886247"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2022 18:53:53 -0700
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
Subject: [PATCH v8 06/11] arm-smmu-v3/sva: Add SVA domain support
Date:   Tue,  7 Jun 2022 09:49:37 +0800
Message-Id: <20220607014942.3954894-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 69 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
 3 files changed, 78 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d2ba86470c42..96399dd3a67a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -758,6 +758,7 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
+struct iommu_domain *arm_smmu_sva_domain_alloc(void);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -803,5 +804,10 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 }
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
+
+static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
+{
+	return NULL;
+}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index f155d406c5d5..0af86e31e674 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -549,3 +549,72 @@ void arm_smmu_sva_notifier_synchronize(void)
 	 */
 	mmu_notifier_synchronize();
 }
+
+static int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t id)
+{
+	int ret = 0;
+	struct mm_struct *mm;
+	struct iommu_sva *handle;
+
+	if (domain->type != IOMMU_DOMAIN_SVA)
+		return -EINVAL;
+
+	mm = domain->mm;
+	if (WARN_ON(!mm))
+		return -ENODEV;
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
+static void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
+					  struct device *dev, ioasid_t id)
+{
+	struct mm_struct *mm = domain->mm;
+	struct arm_smmu_bond *bond = NULL, *t;
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
+
+static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
+{
+	kfree(domain);
+}
+
+static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
+	.set_dev_pasid		= arm_smmu_sva_attach_dev_pasid,
+	.block_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
+	.free			= arm_smmu_sva_domain_free,
+};
+
+struct iommu_domain *arm_smmu_sva_domain_alloc(void)
+{
+	struct iommu_domain *domain;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+	domain->ops = &arm_smmu_sva_domain_ops;
+
+	return domain;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ae8ec8df47c1..a30b252e2f95 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1999,6 +1999,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
+	if (type == IOMMU_DOMAIN_SVA)
+		return arm_smmu_sva_domain_alloc();
+
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
 	    type != IOMMU_DOMAIN_DMA_FQ &&
-- 
2.25.1

