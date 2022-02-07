Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD84AB554
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiBGG43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357841AbiBGGoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:44:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8FFC0401C0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216263; x=1675752263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1FAEc7MxY57hsQjIIjJSXw/pIhYqbkltVpu9dLzdic=;
  b=HDfnjt06/QciKFur9FsKIlBPtvK6xneIGcA3ZhJ2jAbCInRRxDexiWCN
   sVOYubzcwrpy9GOUbiBbdK/TjGnuWpu7lqF+fd2XRd3r2vMEkH7yWt1Cn
   6s6pZYw4dq04AWRttQj+lbBqKmt6QmI52278yIWjgpHLbY1/KcuXM1QD7
   oP/J3dOmhB3blxt8XdnxfL4lZzAhkZGPdZxy7zRQhn0CoeK8IzMlxXKe9
   3FSvt39TN67oxQ19mjpfwEY9LX9tdhSxNSM/MIUqzxuSRlgP8/ybBW/+k
   /9As8IXXKO63R1gRKfOsqAW1HWX2SwT40GA3VqJIse8rlyjeU/FJKUcB9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273171192"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273171192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525020303"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:18 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 07/10] iommu/vt-d: Use an xarray for global device_domain_info
Date:   Mon,  7 Feb 2022 14:41:39 +0800
Message-Id: <20220207064142.1092846-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing global device_domain_list with an array so that it
could be easily searched. The index of the array is composed by the PCI
segment, bus and devfn. And use RCU lock for protection.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 68 ++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8c7591b5f3e2..1ccba739a062 100644
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
index 165c890b8304..d7eba86c7f72 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -151,8 +151,6 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -315,30 +313,30 @@ struct device_domain_info *get_domain_info(struct device *dev)
 }
 
 DEFINE_SPINLOCK(device_domain_lock);
-static LIST_HEAD(device_domain_list);
+static DEFINE_XARRAY_ALLOC(device_domain_array);
+
+#define DEVI_IDX(seg, bus, devfn) ((((u16)(seg)) << 16) | PCI_DEVID(bus, devfn))
 
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
@@ -900,7 +898,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
 	struct dmar_domain *domain;
 	int offset, level;
 
-	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	info = xa_load(&device_domain_array,
+		       DEVI_IDX(iommu->segment, bus, devfn));
 	if (!info || !info->domain) {
 		pr_info("device [%02x:%02x.%d] not probed\n",
 			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
@@ -1747,14 +1746,14 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 
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
 
@@ -1763,7 +1762,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 		__dmar_remove_one_dev_info(info);
 	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	rcu_read_unlock();
 
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
@@ -2388,7 +2387,8 @@ static inline void unlink_domain_info(struct device_domain_info *info)
 {
 	assert_spin_locked(&device_domain_lock);
 	list_del(&info->link);
-	list_del(&info->global);
+	xa_erase(&device_domain_array,
+		 DEVI_IDX(info->segment, info->bus, info->devfn));
 	if (info->dev)
 		dev_iommu_priv_set(info->dev, NULL);
 }
@@ -2419,19 +2419,6 @@ struct dmar_domain *find_domain(struct device *dev)
 	return NULL;
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
@@ -4344,8 +4331,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
+	void *curr;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -4387,10 +4374,15 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_add(&info->global, &device_domain_list);
+	curr = xa_store(&device_domain_array,
+			DEVI_IDX(info->segment, info->bus, info->devfn),
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
-- 
2.25.1

