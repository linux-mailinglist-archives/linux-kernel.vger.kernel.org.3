Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8851641A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbiEALb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345853AbiEALbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:31:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489016D1BB
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 04:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651404474; x=1682940474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eBk8SSzqPwKYdz2VHD0pbb/cRZp4F9pvvxxdY6ELU6U=;
  b=R9xxm9JN5nojBijjI25F7pisCBs9f2YCAYqezFC5r1U63CbFc4ypbxDf
   s+C0e3Yp9M2S/3S4P/7kH573uAeAuWaknlk5BcnywxmOrQffKliH1xkcq
   Fx+4zROO6WTuT6Nop5pyBJhkR4iWVL+5Wa3o9Bxi62nHNlhfAQ1MapCCh
   rGJfFWgodrM/E5pZThOAJFg6Yr2idoi7aqrbRZzunoHL+nO+KaDyVjWIL
   IYZqHm7LhdafM7MlNcjqCNLIbzjzTUyzi5tICrOEXHiZGjoBp08X1mw/g
   9RRhh4n2L5OtwvHQPcYFQhv3wSffnBf62OER9mYK15DVNcTn4CDGgB7QW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="246912726"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="246912726"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 04:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="545114870"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2022 04:27:51 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/5] iommu/vt-d: Check domain force_snooping against attached devices
Date:   Sun,  1 May 2022 19:24:32 +0800
Message-Id: <20220501112434.874236-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501112434.874236-1-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
 drivers/iommu/intel/pasid.h |  2 ++
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel/pasid.c | 18 +++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

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
index 98050943d863..3c1c228f9031 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4554,13 +4554,61 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
+static bool domain_support_force_snooping(struct dmar_domain *domain)
+{
+	struct device_domain_info *info;
+	unsigned long flags;
+	bool support = true;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	if (list_empty(&domain->devices))
+		goto out;
+
+	list_for_each_entry(info, &domain->devices, link) {
+		if (!ecap_sc_support(info->iommu->ecap)) {
+			support = false;
+			break;
+		}
+	}
+out:
+	spin_unlock_irqrestore(&device_domain_lock, flags);
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
+	if (!domain_use_first_level(domain))
+		return;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	if (list_empty(&domain->devices))
+		goto out_unlock;
+
+	list_for_each_entry(info, &domain->devices, link)
+		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
+						     PASID_RID2PASID);
+
+out_unlock:
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+}
+
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 
-	if (!domain_update_iommu_snooping(NULL))
+	if (!domain_support_force_snooping(dmar_domain))
 		return false;
+
+	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
+
 	return true;
 }
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f8d215d85695..815c744e6a34 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -762,3 +762,21 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 
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
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte || !pasid_pte_is_present(pte)))
+		return;
+
+	pasid_set_pgsnp(pte);
+	did = pasid_get_domain_id(pte);
+	pasid_flush_caches(iommu, pte, pasid, did);
+}
-- 
2.25.1

