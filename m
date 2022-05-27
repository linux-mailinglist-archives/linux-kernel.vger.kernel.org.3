Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3F535972
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbiE0GfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343965AbiE0Gey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D30ED8C7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633278; x=1685169278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SpCOjf1fC+0Ig2NGqr8P1EkOw52I2q0BKYX3ILSuZaM=;
  b=DIZHTKXQDfmUgvS5c/VlfNKwj/jx9zsx58dEFLTkKlHUBfCfoUEP3DG/
   AxxpwEc719BvPmtZ+nFcL1/Z+/yPHKhPixnyWxExeapKySRjefq5R7dD5
   ZhYqo5ksW0CpEXKdZUIkzgYtS5olDd9sSgBvNy/hP/TKKG71UVAdUiWfx
   HgrkdMmrMbO/KDwnj6Gb1DAXDmS/WYoLazGULk9hdhsEv2yeqB3cBP+1r
   yQKw1dkLJuOspqAHWfMgTmswiXMFphODsHctS2yfMdvYZpOprvVQ7RAdK
   wdYWQT984I2J1dQVPYTyONJ5BaGDjfWUsK9xXzRMXdJNb/K1EQLEIFpEk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="256469470"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="256469470"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718689186"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:31 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 12/12] iommu/vt-d: Convert device_domain_lock into per-domain mutex
Date:   Fri, 27 May 2022 14:30:19 +0800
Message-Id: <20220527063019.3112905-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a global device_domain_lock spinlock to protect per-domain device
tracking lists is an inefficient way, especially considering this lock
is also needed in the hot paths.

On the other hand, in the iommu_unmap() path, the driver needs to iterate
over the device tracking list and flush the caches on the devices through
qi_submit_sync(), where unfortunately cpu_relax() is used. In order to
avoid holding a spinlock lock when cpu_relax() is called, this also covert
the spinlock into a mutex one. This works as the device tracking lists are
not touched in any interrupt contexts.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/iommu.c | 45 +++++++++++++++----------------------
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6724703d573b..9e572ddffc08 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,6 +541,7 @@ struct dmar_domain {
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;
 
+	struct mutex mutex;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
 
 	struct dma_pte	*pgd;		/* virtual address */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f8aa8649dc6f..1815a9d73426 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -310,7 +310,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-static DEFINE_SPINLOCK(device_domain_lock);
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
@@ -534,9 +533,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
-	unsigned long flags;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	mutex_lock(&domain->mutex);
 	list_for_each_entry(info, &domain->devices, link) {
 		/*
 		 * There could possibly be multiple device numa nodes as devices
@@ -548,7 +546,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	mutex_unlock(&domain->mutex);
 
 	return nid;
 }
@@ -1375,12 +1373,11 @@ iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
 			u8 bus, u8 devfn)
 {
 	struct device_domain_info *info = NULL, *tmp;
-	unsigned long flags;
 
 	if (!iommu->qi)
 		return NULL;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	mutex_lock(&domain->mutex);
 	list_for_each_entry(tmp, &domain->devices, link) {
 		if (tmp->iommu == iommu && tmp->bus == bus &&
 		    tmp->devfn == devfn) {
@@ -1389,7 +1386,7 @@ iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	mutex_unlock(&domain->mutex);
 
 	return info;
 }
@@ -1398,9 +1395,8 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
-	unsigned long flags;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	mutex_lock(&domain->mutex);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
@@ -1408,7 +1404,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 		}
 	}
 	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	mutex_unlock(&domain->mutex);
 }
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
@@ -1499,17 +1495,15 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
-	unsigned long flags;
 	struct device_domain_info *info;
 
 	if (!domain->has_iotlb_device)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	mutex_lock(&domain->mutex);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	mutex_unlock(&domain->mutex);
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -1761,6 +1755,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	mutex_init(&domain->mutex);
 
 	return domain;
 }
@@ -2434,7 +2429,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
 	int ret;
 
@@ -2446,9 +2440,9 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	mutex_lock(&domain->mutex);
 	list_add(&info->link, &domain->devices);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	mutex_unlock(&domain->mutex);
 	info->domain = domain;
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
@@ -4126,7 +4120,6 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *domain = info->domain;
 	struct intel_iommu *iommu = info->iommu;
-	unsigned long flags;
 
 	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
@@ -4138,9 +4131,9 @@ static void dmar_remove_one_dev_info(struct device *dev)
 		intel_pasid_free_table(info->dev);
 	}
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	mutex_lock(&domain->mutex);
 	list_del(&info->link);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	mutex_unlock(&domain->mutex);
 
 	domain_detach_iommu(domain, iommu);
 }
@@ -4424,7 +4417,7 @@ static bool domain_support_force_snooping(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool support = true;
 
-	assert_spin_locked(&device_domain_lock);
+	lockdep_assert_held(&domain->mutex);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (!ecap_sc_support(info->iommu->ecap)) {
 			support = false;
@@ -4439,8 +4432,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 
-	assert_spin_locked(&device_domain_lock);
-
+	lockdep_assert_held(&domain->mutex);
 	/*
 	 * Second level page table supports per-PTE snoop control. The
 	 * iommu_map() interface will handle this by setting SNP bit.
@@ -4458,20 +4450,19 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long flags;
 
 	if (dmar_domain->force_snooping)
 		return true;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	mutex_lock(&dmar_domain->mutex);
 	if (!domain_support_force_snooping(dmar_domain)) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
+		mutex_unlock(&dmar_domain->mutex);
 		return false;
 	}
 
 	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	mutex_unlock(&dmar_domain->mutex);
 
 	return true;
 }
-- 
2.25.1

