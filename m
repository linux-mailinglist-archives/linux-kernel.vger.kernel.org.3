Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8D64AB567
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiBGG6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357924AbiBGGob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:44:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B8FC043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216270; x=1675752270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mT+9PcyYDHIgmL0UWJZy2RHRNEpPZBOFnxSL7FkSYzI=;
  b=ZNBfAYClDcNdCXDBv2I5sga4ZFQxfQBkTSG6lUmSLRciZ4uLgeS2z7xe
   CuBBY7mPo3mIkuFI/vc0WloZWyZLqQrvmnzApqyZFLHCh+vAl26bap5jv
   ze/PbLuR+Hm7fFZ0/HeDQHyBK8aZKZVsi6AUyPw34eleMjSob+4RAfoRw
   zPQx59h0K3lLLr9QOQSel4Y1Rqp4V2ri9GZQAYrMeBP281fMOm99LiJr0
   0OdUi7MZcL1ufE4gyGebLpsNfE7GtlMFx6qhFMXHWcgLaEc0r7Trzqmba
   U1fHNBU01v4Qo25vuzr5MZaY+JniU4eo+iXtKvxCfRFdx0qDVrbj5JcUC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273171205"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273171205"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525020334"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:25 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 09/10] iommu/vt-d: Refactor dmar_insert_one_dev_info()
Date:   Mon,  7 Feb 2022 14:41:41 +0800
Message-Id: <20220207064142.1092846-10-baolu.lu@linux.intel.com>
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

The existing dmar_insert_one_dev_info() implementation looks messy.
This refactors it by moving pasid table allocation to device probe
function, changing the return type to integer, adding the error
rewinding paths.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 117 +++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7d2fec3041e4..9a9f21fd268a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2379,15 +2379,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
-static inline void unlink_domain_info(struct device_domain_info *info)
-{
-	list_del_rcu(&info->link);
-	xa_erase(&device_domain_array,
-		 DEVI_IDX(info->segment, info->bus, info->devfn));
-	if (info->dev)
-		dev_iommu_priv_set(info->dev, NULL);
-}
-
 struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
@@ -2445,35 +2436,22 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
-						    int bus, int devfn,
-						    struct device *dev,
-						    struct dmar_domain *domain)
+static int dmar_insert_one_dev_info(struct intel_iommu *iommu, int bus,
+				    int devfn, struct device *dev,
+				    struct dmar_domain *domain)
 {
 	struct device_domain_info *info = get_domain_info(dev);
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&iommu->lock, flags);
+	/* Link to iommu and get a domain id: */
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 	if (ret)
-		return NULL;
-
-	info->domain = domain;
-	list_add_rcu(&info->link, &domain->devices);
-
-	/* PASID table is mandatory for a PCI device in scalable mode. */
-	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
-		ret = intel_pasid_alloc_table(dev);
-		if (ret) {
-			dev_err(dev, "PASID table allocation failed\n");
-			dmar_remove_one_dev_info(dev);
-			return NULL;
-		}
+		goto attach_iommu_err;
 
-		/* Setup the PASID entry for requests without PASID: */
-		spin_lock_irqsave(&iommu->lock, flags);
+	/* Setup the PASID entry for requests without PASID: */
+	if (dev_is_pci(dev) && sm_supported(iommu)) {
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2483,21 +2461,31 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock_irqrestore(&iommu->lock, flags);
-		if (ret) {
-			dev_err(dev, "Setup RID2PASID failed\n");
-			dmar_remove_one_dev_info(dev);
-			return NULL;
-		}
+		if (ret)
+			goto pasid_setup_err;
 	}
+	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	if (dev && domain_context_mapping(domain, dev)) {
-		dev_err(dev, "Domain context map failed\n");
-		dmar_remove_one_dev_info(dev);
-		return NULL;
-	}
+	/* Setup the context entry for device: */
+	ret = domain_context_mapping(domain, dev);
+	if (ret)
+		goto setup_context_err;
 
-	return domain;
+	info->domain = domain;
+	list_add_rcu(&info->link, &domain->devices);
+
+	return 0;
+
+setup_context_err:
+	spin_lock_irqsave(&iommu->lock, flags);
+	if (dev_is_pci(dev) && sm_supported(iommu))
+		intel_pasid_tear_down_entry(iommu, dev, PASID_RID2PASID, false);
+pasid_setup_err:
+	domain_detach_iommu(domain, iommu);
+attach_iommu_err:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	return ret;
 }
 
 static int iommu_domain_identity_map(struct dmar_domain *domain,
@@ -2575,7 +2563,6 @@ static int __init si_domain_init(int hw)
 
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
-	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
 
@@ -2583,11 +2570,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	ndomain = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
-	if (ndomain != domain)
-		return -EBUSY;
-
-	return 0;
+	return dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
 }
 
 static bool device_has_rmrr(struct device *dev)
@@ -4001,16 +3984,13 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
-		intel_pasid_free_table(info->dev);
 	}
 
-	unlink_domain_info(info);
+	list_del_rcu(&info->link);
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	domain_detach_iommu(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	kfree(info);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
@@ -4310,8 +4290,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
+	unsigned long index;
 	u8 bus, devfn;
 	void *curr;
+	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -4353,30 +4335,39 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
-	curr = xa_store(&device_domain_array,
-			DEVI_IDX(info->segment, info->bus, info->devfn),
-			info, GFP_KERNEL);
+	index = DEVI_IDX(info->segment, info->bus, info->devfn);
+	curr = xa_store(&device_domain_array, index, info, GFP_KERNEL);
 	if (xa_err(curr) || WARN_ON(curr)) {
-		kfree(info);
-		return ERR_PTR(-ENOSPC);
+		ret = -ENOSPC;
+		goto free_out;
 	}
 
 	dev_iommu_priv_set(dev, info);
+	if (sm_supported(iommu)) {
+		ret = intel_pasid_alloc_table(dev);
+		if (ret)
+			goto cleanup_out;
+	}
 
 	return &iommu->iommu;
+
+cleanup_out:
+	dev_iommu_priv_set(dev, NULL);
+	xa_erase(&device_domain_array, index);
+free_out:
+	kfree(info);
+	return ERR_PTR(ret);
 }
 
 static void intel_iommu_release_device(struct device *dev)
 {
-	struct intel_iommu *iommu;
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return;
-
-	dmar_remove_one_dev_info(dev);
+	struct device_domain_info *info = get_domain_info(dev);
+	unsigned long index = DEVI_IDX(info->segment, info->bus, info->devfn);
 
+	xa_erase(&device_domain_array, index);
+	dev_iommu_priv_set(info->dev, NULL);
 	set_dma_ops(dev, NULL);
+	kfree(info);
 }
 
 static void intel_iommu_probe_finalize(struct device *dev)
-- 
2.25.1

