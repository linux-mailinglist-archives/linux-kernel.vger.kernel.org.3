Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B18570EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiGLAPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiGLAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:15:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42022559F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584865; x=1689120865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rw0bt1lwIejGYkqJC+RFz3d5K0YBnIC0MJskMj+sdcI=;
  b=h1vr4prh4MSQy6YMJxmkDMDDfwG1+MoJiCcsfxtGsla0JWPIpvqtzARD
   vjh8YLR3bb+ZEuN/JybIlAX15rmpvHqwMUT/i0v7ckbCNc3eV2DtuCBXU
   5ssp7kC9i6tcTDn6BnOjfYaJ1HK2VhceN7MMVp9ApS2jvecZPrpZB3YYW
   AXWKxZSDQp7eLTFCRn1ERzIUNbPHN4FXGxzyVarYtf3JQPwCpu7ZQR9K4
   942nM5SIXAAL4D4LgjnYJGO493i2hyCgaY9p5xG1gaSyvUCl5V/1aCNPz
   ogYgDdqKN9HDSMBv7neC2dgMleQxRv4hD6akP0Rnpsdn8Z/8s6jbrgH+T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="265213592"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="265213592"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445803"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:01 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
Date:   Tue, 12 Jul 2022 08:08:56 +0800
Message-Id: <20220712000908.3431936-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu->lock is used to protect changes in root/context/pasid tables
and domain ID allocation. There's no use case to change these resources
in any interrupt context. Therefore, it is unnecessary to disable the
interrupts when the spinlock is held. The same thing happens on the
device_domain_lock side, which protects the device domain attachment
information. This replaces spin_lock/unlock_irqsave/irqrestore() calls
with the normal spin_lock/unlock().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220706025524.2904370-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/debugfs.c |  6 ++--
 drivers/iommu/intel/iommu.c   | 66 ++++++++++++++---------------------
 drivers/iommu/intel/svm.c     |  6 ++--
 3 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 6e1a3f88abc8..1f925285104e 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -263,10 +263,9 @@ static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
 
 static void root_tbl_walk(struct seq_file *m, struct intel_iommu *iommu)
 {
-	unsigned long flags;
 	u16 bus;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	seq_printf(m, "IOMMU %s: Root Table Address: 0x%llx\n", iommu->name,
 		   (u64)virt_to_phys(iommu->root_entry));
 	seq_puts(m, "B.D.F\tRoot_entry\t\t\t\tContext_entry\t\t\t\tPASID\tPASID_table_entry\n");
@@ -278,8 +277,7 @@ static void root_tbl_walk(struct seq_file *m, struct intel_iommu *iommu)
 	 */
 	for (bus = 0; bus < 256; bus++)
 		ctx_tbl_walk(m, iommu, bus);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 }
 
 static int dmar_translation_struct_show(struct seq_file *m, void *unused)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ff49c9460ede..93f01082dce1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -797,13 +797,12 @@ static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
 	struct context_entry *context;
 	int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (context)
 		ret = context_present(context);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 	return ret;
 }
 
@@ -1508,17 +1507,15 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
-	unsigned long flags;
 	struct device_domain_info *info;
 
 	if (!domain->has_iotlb_device)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&device_domain_lock);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&device_domain_lock);
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -1917,7 +1914,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	int translation = CONTEXT_TT_MULTI_LEVEL;
 	struct device_domain_info *info = NULL;
 	struct context_entry *context;
-	unsigned long flags;
 	int ret;
 
 	WARN_ON(did == 0);
@@ -1930,7 +1926,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	BUG_ON(!domain->pgd);
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&device_domain_lock);
 	spin_lock(&iommu->lock);
 
 	ret = -ENOMEM;
@@ -2052,7 +2048,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 out_unlock:
 	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&device_domain_lock);
 
 	return ret;
 }
@@ -2296,16 +2292,15 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 {
 	struct intel_iommu *iommu = info->iommu;
 	struct context_entry *context;
-	unsigned long flags;
 	u16 did_old;
 
 	if (!iommu)
 		return;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (!context) {
-		spin_unlock_irqrestore(&iommu->lock, flags);
+		spin_unlock(&iommu->lock);
 		return;
 	}
 
@@ -2320,7 +2315,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 	iommu->flush.flush_context(iommu,
 				   did_old,
 				   (((u16)bus) << 8) | devfn,
@@ -2342,12 +2337,11 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 static void domain_remove_dev_info(struct dmar_domain *domain)
 {
 	struct device_domain_info *info, *tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&device_domain_lock);
 	list_for_each_entry_safe(info, tmp, &domain->devices, link)
 		__dmar_remove_one_dev_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&device_domain_lock);
 }
 
 static int domain_setup_first_level(struct intel_iommu *iommu,
@@ -2469,7 +2463,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
 	int ret;
 
@@ -2477,17 +2470,17 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&device_domain_lock);
 	info->domain = domain;
 	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
 	spin_unlock(&iommu->lock);
 	if (ret) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
+		spin_unlock(&device_domain_lock);
 		return ret;
 	}
 	list_add(&info->link, &domain->devices);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&device_domain_lock);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
@@ -2499,7 +2492,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
-		spin_lock_irqsave(&iommu->lock, flags);
+		spin_lock(&iommu->lock);
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2509,7 +2502,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock_irqrestore(&iommu->lock, flags);
+		spin_unlock(&iommu->lock);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
@@ -2777,7 +2770,6 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	struct root_entry *old_rt;
 	phys_addr_t old_rt_phys;
 	int ctxt_table_entries;
-	unsigned long flags;
 	u64 rtaddr_reg;
 	int bus, ret;
 	bool new_ext, ext;
@@ -2820,7 +2812,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		}
 	}
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 
 	/* Context tables are copied, now write them to the root_entry table */
 	for (bus = 0; bus < 256; bus++) {
@@ -2839,7 +2831,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		iommu->root_entry[bus].hi = val;
 	}
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 
 	kfree(ctxt_tbls);
 
@@ -4166,7 +4158,6 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 
 	assert_spin_locked(&device_domain_lock);
 
@@ -4188,21 +4179,20 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 
 	list_del(&info->link);
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	domain_detach_iommu(domain, iommu);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info;
-	unsigned long flags;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&device_domain_lock);
 	info = dev_iommu_priv_get(dev);
 	if (info)
 		__dmar_remove_one_dev_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&device_domain_lock);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
@@ -4518,20 +4508,19 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long flags;
 
 	if (dmar_domain->force_snooping)
 		return true;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&device_domain_lock);
 	if (!domain_support_force_snooping(dmar_domain)) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
+		spin_unlock(&device_domain_lock);
 		return false;
 	}
 
 	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&device_domain_lock);
 
 	return true;
 }
@@ -4678,7 +4667,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct context_entry *context;
 	struct dmar_domain *domain;
-	unsigned long flags;
 	u64 ctx_lo;
 	int ret;
 
@@ -4686,7 +4674,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	if (!domain)
 		return -EINVAL;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&device_domain_lock);
 	spin_lock(&iommu->lock);
 
 	ret = -EINVAL;
@@ -4718,7 +4706,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 
  out:
 	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&device_domain_lock);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 580713aa9e07..82288a50660d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -328,9 +328,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   unsigned int flags)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	unsigned long iflags, sflags;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
+	unsigned long sflags;
 	int ret = 0;
 
 	svm = pasid_private_find(mm->pasid);
@@ -394,10 +394,10 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
 			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	spin_lock_irqsave(&iommu->lock, iflags);
+	spin_lock(&iommu->lock);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-	spin_unlock_irqrestore(&iommu->lock, iflags);
+	spin_unlock(&iommu->lock);
 
 	if (ret)
 		goto free_sdev;
-- 
2.25.1

