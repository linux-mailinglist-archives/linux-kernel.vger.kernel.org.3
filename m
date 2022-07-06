Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF779567C49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiGFDA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiGFDAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:00:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B01C139
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076422; x=1688612422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A7RBb24g7uZ3YBXaYjY6jWSesk0/66f3mKiYAyMbNb8=;
  b=jwb6Ga3/6P8h8kT44af3YyO0jatwNgnWJV8YpZuwKaU0UBup6BxMNISB
   H+Iygtjnw+HGFKpddoZimyI4fy7eWy+0gRM1kADbTxWFtaPsDLBcFoIRf
   CWGOz4tlm+9JXgwol2mQc8srd3cDz6AkMaWn37yn6Tt8G+/HrU80ZJhsu
   4BXE0mt7Ld4ELbII+ibOjhDqmFqZrvqvrwTxasGvEtA4CSrLRg8E1gZ+1
   YHzqpOvYZ/8quj8FFfVEFTNBA6/jJu0zBJ0syv6Fc1fr+yOgZeT9h7Tv3
   DlEpUSkBgjXPD4SW5eVj/gna0hiJ2YcHK8vX4UfaVHLf5HXfvKQL/12or
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409622"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="272409622"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567875365"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 20:00:17 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 11/11] iommu/vt-d: Convert global spinlock into per domain lock
Date:   Wed,  6 Jul 2022 10:55:24 +0800
Message-Id: <20220706025524.2904370-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a global device_domain_lock spinlock to protect per-domain device
tracking lists is an inefficient way, especially considering this lock
is also needed in the hot paths. This optimizes the locking mechanism
by converting the global lock to per domain lock.

On the other hand, as the device tracking lists are never accessed in
any interrupt context, there is no need to disable interrupts while
spinning. Replace irqsave variant with spinlock calls.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/iommu.c | 42 ++++++++++++++++++-------------------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 198c6c822ef4..df64d3d9c49a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,6 +541,7 @@ struct dmar_domain {
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;
 
+	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
 
 	struct dma_pte	*pgd;		/* virtual address */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 46991e313bf3..e007049eb9ff 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -310,7 +310,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-static DEFINE_SPINLOCK(device_domain_lock);
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
@@ -535,7 +534,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		/*
 		 * There could possibly be multiple device numa nodes as devices
@@ -547,7 +546,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 
 	return nid;
 }
@@ -1378,15 +1377,15 @@ iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
 	if (!iommu->qi)
 		return NULL;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
-			spin_unlock(&device_domain_lock);
+			spin_unlock(&domain->lock);
 			return info->ats_supported ? info : NULL;
 		}
 	}
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 
 	return NULL;
 }
@@ -1396,7 +1395,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
@@ -1404,7 +1403,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 		}
 	}
 	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 }
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
@@ -1500,10 +1499,10 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	if (!domain->has_iotlb_device)
 		return;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -1763,6 +1762,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	spin_lock_init(&domain->lock);
 
 	return domain;
 }
@@ -2446,9 +2446,9 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 	info->domain = domain;
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_add(&info->link, &domain->devices);
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
@@ -4123,6 +4123,7 @@ static void domain_context_clear(struct device_domain_info *info)
 static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *domain = info->domain;
 	struct intel_iommu *iommu = info->iommu;
 
 	if (!dev_is_real_dma_subdevice(info->dev)) {
@@ -4135,11 +4136,11 @@ static void dmar_remove_one_dev_info(struct device *dev)
 		intel_pasid_free_table(info->dev);
 	}
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&domain->lock);
 	list_del(&info->link);
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&domain->lock);
 
-	domain_detach_iommu(info->domain, iommu);
+	domain_detach_iommu(domain, iommu);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
@@ -4421,7 +4422,7 @@ static bool domain_support_force_snooping(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool support = true;
 
-	assert_spin_locked(&device_domain_lock);
+	assert_spin_locked(&domain->lock);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (!ecap_sc_support(info->iommu->ecap)) {
 			support = false;
@@ -4436,8 +4437,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 
-	assert_spin_locked(&device_domain_lock);
-
+	assert_spin_locked(&domain->lock);
 	/*
 	 * Second level page table supports per-PTE snoop control. The
 	 * iommu_map() interface will handle this by setting SNP bit.
@@ -4459,15 +4459,15 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	if (dmar_domain->force_snooping)
 		return true;
 
-	spin_lock(&device_domain_lock);
+	spin_lock(&dmar_domain->lock);
 	if (!domain_support_force_snooping(dmar_domain)) {
-		spin_unlock(&device_domain_lock);
+		spin_unlock(&dmar_domain->lock);
 		return false;
 	}
 
 	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
-	spin_unlock(&device_domain_lock);
+	spin_unlock(&dmar_domain->lock);
 
 	return true;
 }
-- 
2.25.1

