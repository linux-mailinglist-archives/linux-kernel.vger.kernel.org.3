Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9194B3FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbiBNC72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:59:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiBNC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:59:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C854FBF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807544; x=1676343544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBMsFrh2PTzmv2WOA2c5Cq3XrHldULkt+wE397bzEns=;
  b=G/oP/38l1aWZwD0DTsFj+fdd7+Iv0gqB0111L2jNh1ogqay6P3J8Z7Xr
   mhI8J7GOotzKgZxxjdSJOfrZlFyfgZz1SnDLT1Fo92E7N++DolPIo9fEh
   5zeQ84xyaKctU1RjerFwuX0hv5XBlwriDd+m4kGQOBwvAg4UUs7dviTbF
   2BSqRgP8TsHD3eRG+xImh1+4k6s7QSpZuUrFtTZpgz0F4b5766SCFzruc
   b82C8NWUpwOH8+mhgwZoAQqRpLfhVh164KU/6o6cRb8Q/G4ZTpyO7qxI7
   zRdRbJ46sOyZNEnQMbhYr7J1obVfaFEfFk7QNJaJ2pT2OHdf3U+vnvnJN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280438"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280438"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:59:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501515047"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:59:01 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 10/11] iommu/vt-d: Use xarray for global device_domain_info
Date:   Mon, 14 Feb 2022 10:57:03 +0800
Message-Id: <20220214025704.3184654-11-baolu.lu@linux.intel.com>
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

Replace the existing global device_domain_list with an array so that it
could be rapidly searched. The index of the array is composed by the PCI
segment, bus and devfn. Use RCU for lock protection.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 72 ++++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 03f1134fc2fe..aca1c1cc04a8 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -610,7 +610,6 @@ struct intel_iommu {
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
 	struct list_head table;	/* link to pasid table */
 	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fb17ed8c08f3..ecec923ce191 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -131,8 +131,6 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -318,30 +316,34 @@ int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
 DEFINE_SPINLOCK(device_domain_lock);
-static LIST_HEAD(device_domain_list);
+static DEFINE_XARRAY_ALLOC(device_domain_array);
+
+/* Convert device source ID into the index of device_domain_array. */
+static inline unsigned long devi_idx(unsigned long seg, u8 bus, u8 devfn)
+{
+	return (seg << 16) | PCI_DEVID(bus, devfn);
+}
 
 /*
- * Iterate over elements in device_domain_list and call the specified
+ * Iterate over elements in device_domain_array and call the specified
  * callback @fn against each element.
  */
 int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data)
 {
-	int ret = 0;
-	unsigned long flags;
 	struct device_domain_info *info;
+	unsigned long index;
+	int ret = 0;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &device_domain_list, global) {
+	rcu_read_lock();
+	xa_for_each(&device_domain_array, index, info) {
 		ret = fn(info, data);
-		if (ret) {
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-			return ret;
-		}
+		if (ret)
+			break;
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	rcu_read_unlock();
 
-	return 0;
+	return ret;
 }
 
 const struct iommu_ops intel_iommu_ops;
@@ -903,7 +905,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
 	struct dmar_domain *domain;
 	int offset, level;
 
-	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	info = xa_load(&device_domain_array,
+		       devi_idx(iommu->segment, bus, devfn));
 	if (!info || !info->domain) {
 		pr_info("device [%02x:%02x.%d] not probed\n",
 			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
@@ -1742,14 +1745,14 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 
 static void disable_dmar_iommu(struct intel_iommu *iommu)
 {
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
+	struct device_domain_info *info;
+	unsigned long index;
 
 	if (!iommu->domain_ids)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
+	rcu_read_lock();
+	xa_for_each(&device_domain_array, index, info) {
 		if (info->iommu != iommu)
 			continue;
 
@@ -1758,7 +1761,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 		__dmar_remove_one_dev_info(info);
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	rcu_read_unlock();
 
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
@@ -2390,19 +2393,6 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
-{
-	struct device_domain_info *info;
-
-	list_for_each_entry(info, &device_domain_list, global)
-		if (info->segment == segment && info->bus == bus &&
-		    info->devfn == devfn)
-			return info;
-
-	return NULL;
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
@@ -4516,8 +4506,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
+	void *curr;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -4559,10 +4549,15 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_add(&info->global, &device_domain_list);
+	curr = xa_store(&device_domain_array,
+			devi_idx(info->segment, info->bus, info->devfn),
+			info, GFP_KERNEL);
+	if (xa_err(curr) || WARN_ON(curr)) {
+		kfree(info);
+		return ERR_PTR(-ENOSPC);
+	}
+
 	dev_iommu_priv_set(dev, info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return &iommu->iommu;
 }
@@ -4576,7 +4571,8 @@ static void intel_iommu_release_device(struct device *dev)
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	dev_iommu_priv_set(dev, NULL);
-	list_del(&info->global);
+	xa_erase(&device_domain_array,
+		 devi_idx(info->segment, info->bus, info->devfn));
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	kfree(info);
-- 
2.25.1

