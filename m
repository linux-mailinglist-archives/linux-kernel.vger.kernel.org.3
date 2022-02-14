Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6914B3FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiBNC7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:59:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbiBNC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:59:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD6655BCB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807547; x=1676343547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0+x3e/vMXMgvyaDYDILzrLWoxq/qCmfPpA74cSvLKM=;
  b=ntx+H7eFEFZAEFJ8GDYK3yE6Y2QcJzTlyXP4RlnTHxfxEo7Y8SPBnTnH
   UuO+NbvCo599PGeQ2Kpk+yc+AnNm2AmvqjBnGxbWQOhBrl7Ug0gbDzDh4
   o8mVk9hEEs/R8vqOmE0doRyYRpm+vvHbxWeASVaTws2/0rhnqk7OM6opW
   9mfppED0eZsqEas4JZK442nvDRwpmhKMngsiy/HUbopJahBbdwHH4dyim
   E9t9D8vCcqtdonQc4FVnyAlgbhCeaMpLE8pvN/GmaeWEVQBkv2Uen38uM
   OZRdFDFxcyltwV3qJTPmk1EfarHivSIrY2apkObDPK0qSc2zicM3jB2Rz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280444"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280444"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501515057"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:59:04 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 11/11] iommu/vt-d: Use rculist for per-domain device list
Date:   Mon, 14 Feb 2022 10:57:04 +0800
Message-Id: <20220214025704.3184654-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rculist for list of devices attached by a domain. And use the RCU
lock for read/write protection. As both the global device_domain array
and per-domain device_domain list are protected by RCU lock now, there
is no need to use the spinlock anymore. Cleanup device_domain_lock.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h   |   2 +-
 drivers/iommu/intel/debugfs.c |  11 +--
 drivers/iommu/intel/iommu.c   | 126 ++++++++++++++--------------------
 3 files changed, 53 insertions(+), 86 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index aca1c1cc04a8..286bd6f82024 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -480,7 +480,6 @@ enum {
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
 extern int intel_iommu_sm;
-extern spinlock_t device_domain_lock;
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
@@ -609,6 +608,7 @@ struct intel_iommu {
 
 /* PCI domain-device relationship */
 struct device_domain_info {
+	struct rcu_head rcu;
 	struct list_head link;	/* link to domain siblings */
 	struct list_head table;	/* link to pasid table */
 	u32 segment;		/* PCI segment number */
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index ed796eea4581..6a115103412a 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -364,15 +364,8 @@ static int show_device_domain_translation(struct device *dev, void *data)
 
 static int domain_translation_struct_show(struct seq_file *m, void *unused)
 {
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
-			       show_device_domain_translation);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return ret;
+	return bus_for_each_dev(&pci_bus_type, NULL, m,
+				show_device_domain_translation);
 }
 DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ecec923ce191..303d6d93e381 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -294,7 +294,6 @@ static LIST_HEAD(dmar_satc_units);
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
-static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
@@ -315,7 +314,6 @@ static int iommu_skip_te_disable;
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
-DEFINE_SPINLOCK(device_domain_lock);
 static DEFINE_XARRAY_ALLOC(device_domain_array);
 
 /* Convert device source ID into the index of device_domain_array. */
@@ -597,12 +595,11 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (list_empty(&domain->devices))
 		return NUMA_NO_NODE;
 
-	list_for_each_entry(info, &domain->devices, link) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(info, &domain->devices, link) {
 		if (!info->dev)
 			continue;
 
@@ -616,6 +613,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
+	rcu_read_unlock();
 
 	return nid;
 }
@@ -1436,25 +1434,26 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 }
 
 static struct device_domain_info *
-iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
-			 u8 bus, u8 devfn)
+iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
+			u8 bus, u8 devfn)
 {
-	struct device_domain_info *info;
-
-	assert_spin_locked(&device_domain_lock);
+	struct device_domain_info *tmp, *info = NULL;
 
 	if (!iommu->qi)
 		return NULL;
 
-	list_for_each_entry(info, &domain->devices, link)
-		if (info->iommu == iommu && info->bus == bus &&
-		    info->devfn == devfn) {
-			if (info->ats_supported && info->dev)
-				return info;
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp, &domain->devices, link) {
+		if (tmp->iommu == iommu && tmp->bus == bus &&
+		    tmp->devfn == devfn) {
+			if (tmp->ats_supported && tmp->dev)
+				info = tmp;
 			break;
 		}
+	}
+	rcu_read_unlock();
 
-	return NULL;
+	return info;
 }
 
 static void domain_update_iotlb(struct dmar_domain *domain)
@@ -1462,13 +1461,14 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 
-	assert_spin_locked(&device_domain_lock);
-
-	list_for_each_entry(info, &domain->devices, link)
+	rcu_read_lock();
+	list_for_each_entry_rcu(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
 			break;
 		}
+	}
+	rcu_read_unlock();
 
 	domain->has_iotlb_device = has_iotlb_device;
 }
@@ -1477,8 +1477,6 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!info || !dev_is_pci(info->dev))
 		return;
 
@@ -1524,8 +1522,6 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!dev_is_pci(info->dev))
 		return;
 
@@ -1565,17 +1561,15 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
-	unsigned long flags;
 	struct device_domain_info *info;
 
 	if (!domain->has_iotlb_device)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &domain->devices, link)
+	rcu_read_lock();
+	list_for_each_entry_rcu(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	rcu_read_unlock();
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -1820,7 +1814,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	if (first_level_by_default(type))
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
-	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD_RCU(&domain->devices);
 
 	return domain;
 }
@@ -1832,7 +1826,6 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	unsigned long ndomains;
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
 
 	domain->iommu_refcnt[iommu->seq_id] += 1;
@@ -1860,7 +1853,6 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 {
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
 
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
@@ -1889,8 +1881,15 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 static void domain_exit(struct dmar_domain *domain)
 {
 
-	/* Remove associated devices and clear attached or cached domains */
-	domain_remove_dev_info(domain);
+	struct device_domain_info *info, *tmp;
+
+	/*
+	 * Remove associated devices and clear attached or cached domains.
+	 * No worries about new devices insertion or removal. Hence no need
+	 * for a lock here.
+	 */
+	list_for_each_entry_safe(info, tmp, &domain->devices, link)
+		__dmar_remove_one_dev_info(info);
 
 	if (domain->pgd) {
 		LIST_HEAD(freelist);
@@ -1973,9 +1972,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	BUG_ON(!domain->pgd);
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	spin_lock(&iommu->lock);
-
+	spin_lock_irqsave(&iommu->lock, flags);
 	ret = -ENOMEM;
 	context = iommu_context_addr(iommu, bus, devfn, 1);
 	if (!context)
@@ -2094,8 +2091,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	ret = 0;
 
 out_unlock:
-	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
@@ -2382,17 +2378,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
-static void domain_remove_dev_info(struct dmar_domain *domain)
-{
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		__dmar_remove_one_dev_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
@@ -2444,17 +2429,14 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info->domain = domain;
-	spin_lock(&iommu->lock);
+	spin_lock_irqsave(&iommu->lock, flags);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
-	if (ret) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+	if (ret)
 		return NULL;
-	}
-	list_add(&info->link, &domain->devices);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	info->domain = domain;
+	list_add_rcu(&info->link, &domain->devices);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
@@ -4182,8 +4164,6 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	struct intel_iommu *iommu;
 	unsigned long flags;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (WARN_ON(!info))
 		return;
 
@@ -4191,16 +4171,19 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain = info->domain;
 
 	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
+		if (dev_is_pci(info->dev) && sm_supported(iommu)) {
+			spin_lock_irqsave(&iommu->lock, flags);
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
+			spin_unlock_irqrestore(&iommu->lock, flags);
+		}
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
 		intel_pasid_free_table(info->dev);
 	}
 
-	list_del(&info->link);
+	list_del_rcu(&info->link);
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	domain_detach_iommu(domain, iommu);
@@ -4210,13 +4193,10 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info;
-	unsigned long flags;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	info = dev_iommu_priv_get(dev);
 	if (info)
 		__dmar_remove_one_dev_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
@@ -4529,6 +4509,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	info->dev = dev;
 	info->iommu = iommu;
+	init_rcu_head(&info->rcu);
 	if (dev_is_pci(dev)) {
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
@@ -4553,7 +4534,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			devi_idx(info->segment, info->bus, info->devfn),
 			info, GFP_KERNEL);
 	if (xa_err(curr) || WARN_ON(curr)) {
-		kfree(info);
+		kfree_rcu(info, rcu);
 		return ERR_PTR(-ENOSPC);
 	}
 
@@ -4565,17 +4546,13 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	unsigned long flags;
 
 	dmar_remove_one_dev_info(dev);
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	dev_iommu_priv_set(dev, NULL);
 	xa_erase(&device_domain_array,
 		 devi_idx(info->segment, info->bus, info->devfn));
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	kfree(info);
+	kfree_rcu(info, rcu);
 	set_dma_ops(dev, NULL);
 }
 
@@ -4655,9 +4632,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	if (!domain)
 		return -EINVAL;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	spin_lock(&iommu->lock);
-
+	spin_lock_irqsave(&iommu->lock, flags);
 	ret = -EINVAL;
 	if (!info->pasid_supported)
 		goto out;
@@ -4686,8 +4661,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	ret = 0;
 
  out:
-	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
-- 
2.25.1

