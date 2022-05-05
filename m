Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1151B516
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiEEBN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiEEBNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:13:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C32C100B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651713014; x=1683249014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqnbhDARBAPWg4kwGCpJbusJFjCAp3aYBSIf6mS+pC8=;
  b=Z7xKZ3vo2dgC4NOgxYG1cLNPKON15Me/Rv0cTrYL8ThUuUHc6tiEY2Mf
   gZbxw0yZ3CnPgdbdw4L8jYp/Tb86bHdefS+GR+CsMd9JjmpMWtl3FVpAZ
   WpWv3ibuKpLMFub7sNFbBK3yNO6QIaVxxeuMHpJn6jDmQZWiiADK0A4Pz
   XWxT6zdgBGuQE0YTnnrEQyeYY+fkJvC4ssaGbht1wxqTaAEsB86Rgai5f
   GkbWEffOc3B2qiIySr1pIPEqFnykp9XFmlEJni7cCfdOz+M63vaq18rmh
   X8mOaLb3rCFEaGgbGEtqGR9dMdIybst80USGVnnkyxL9RwojtX3Nm9oHq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267832600"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="267832600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="708713904"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2022 18:10:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/4] iommu/vt-d: Check domain force_snooping against attached devices
Date:   Thu,  5 May 2022 09:07:08 +0800
Message-Id: <20220505010710.1477739-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
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

As domain->force_snooping only impacts the devices attached with the
domain, there's no need to check against all IOMMU units. At the same
time, for a brand new domain (hasn't been attached to any device), the
force_snooping field could be set, but the attach_dev callback will
return failure if it wants to attach to a device which IOMMU has no
snoop control capability.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  1 +
 drivers/iommu/intel/pasid.h |  2 ++
 drivers/iommu/intel/iommu.c | 51 ++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel/pasid.c | 23 +++++++++++++++++
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 72e5d7900e71..4f29139bbfc3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -540,6 +540,7 @@ struct dmar_domain {
 	u8 has_iotlb_device: 1;
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
+	u8 set_pte_snp:1;
 
 	struct list_head devices;	/* all devices' list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index ab4408c824a5..583ea67fc783 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -123,4 +123,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 bool fault_ignore);
 int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
 void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
+void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
+					  struct device *dev, u32 pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d68f5bbf3e93..98112228ae93 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2459,7 +2459,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (level == 5)
 		flags |= PASID_FLAG_FL5LP;
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+	if (domain->force_snooping)
 		flags |= PASID_FLAG_PAGE_SNOOP;
 
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
@@ -4431,7 +4431,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= DMA_PTE_WRITE;
-	if (dmar_domain->force_snooping)
+	if (dmar_domain->set_pte_snp)
 		prot |= DMA_PTE_SNP;
 
 	max_addr = iova + size;
@@ -4554,13 +4554,58 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
+static bool domain_support_force_snooping(struct dmar_domain *domain)
+{
+	struct device_domain_info *info;
+	unsigned long flags;
+	bool support = true;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	list_for_each_entry(info, &domain->devices, link) {
+		if (!ecap_sc_support(info->iommu->ecap)) {
+			support = false;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return support;
+}
+
+static void domain_set_force_snooping(struct dmar_domain *domain)
+{
+	struct device_domain_info *info;
+	unsigned long flags;
+
+	/*
+	 * Second level page table supports per-PTE snoop control. The
+	 * iommu_map() interface will handle this by setting SNP bit.
+	 */
+	if (!domain_use_first_level(domain)) {
+		domain->set_pte_snp = true;
+		return;
+	}
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	list_for_each_entry(info, &domain->devices, link)
+		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
+						     PASID_RID2PASID);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+}
+
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 
-	if (!domain_update_iommu_snooping(NULL))
+	if (dmar_domain->force_snooping)
+		return true;
+
+	if (!domain_support_force_snooping(dmar_domain))
 		return false;
+
+	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
+
 	return true;
 }
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f8d215d85695..41a0e3b02c79 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -762,3 +762,26 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 
 	return 0;
 }
+
+/*
+ * Set the page snoop control for a pasid entry which has been set up.
+ */
+void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
+					  struct device *dev, u32 pasid)
+{
+	struct pasid_entry *pte;
+	u16 did;
+
+	spin_lock(&iommu->lock);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
+		spin_unlock(&iommu->lock);
+		return;
+	}
+
+	pasid_set_pgsnp(pte);
+	did = pasid_get_domain_id(pte);
+	spin_unlock(&iommu->lock);
+
+	pasid_flush_caches(iommu, pte, pasid, did);
+}
-- 
2.25.1

