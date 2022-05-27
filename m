Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A153596A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbiE0GeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244912AbiE0GeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC8D5BD1C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633238; x=1685169238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d/p078n3J2mHTDHMlCsZwDS4Rb5qjjADCMyliDReNEI=;
  b=MuMY/OeJaVfZNQb8pZ4OqWqTvZUYIrTuxBtZw/6KQrJrgvNxU06gEc+G
   PBppgz5HielnLhbj4zC8+GU5WACtL9DmSWqyY3yiHXEmrmfWv6tlHc8eU
   gbTEX8JsyxOmomjWLaDz0csgZJ9g20VUFzFBNb82e/mKPISlV5MUiQJDi
   bXHKVdjTWN9oRKn8vRdtO5smPRO0tUG8cVa3AA27VQimh8Jh2J0B4jiNs
   S2Lm7PRcSCBM/DL35bz65XgURoR6OPxu8YLAFhds5WTbqSID7UONPS5zC
   /kl3eApX4LesEaWAk39/reSPle7cj+nXybJbcBCZB5pwf2eLINOEAx0aR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044822"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044822"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688387"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:33:55 -0700
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
Subject: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in debugfs
Date:   Fri, 27 May 2022 14:30:08 +0800
Message-Id: <20220527063019.3112905-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retrieve the attached domain for a device through the generic interface
exposed by the iommu core. This also makes device_domain_lock static.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h   |  1 -
 drivers/iommu/intel/debugfs.c | 20 ++++++++------------
 drivers/iommu/intel/iommu.c   |  2 +-
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a22adfbdf870..8a6d64d726c0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -480,7 +480,6 @@ enum {
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
 extern int intel_iommu_sm;
-extern spinlock_t device_domain_lock;
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index d927ef10641b..eea8727aa7bc 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -344,19 +344,21 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 
 static int show_device_domain_translation(struct device *dev, void *data)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
+	struct dmar_domain *dmar_domain;
+	struct iommu_domain *domain;
 	struct seq_file *m = data;
 	u64 path[6] = { 0 };
 
+	domain = iommu_get_domain_for_dev(dev);
 	if (!domain)
 		return 0;
 
+	dmar_domain = to_dmar_domain(domain);
 	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
-		   (u64)virt_to_phys(domain->pgd));
+		   (u64)virt_to_phys(dmar_domain->pgd));
 	seq_puts(m, "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
 
-	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
+	pgtable_walk_level(m, dmar_domain->pgd, dmar_domain->agaw + 2, 0, path);
 	seq_putc(m, '\n');
 
 	return 0;
@@ -364,15 +366,9 @@ static int show_device_domain_translation(struct device *dev, void *data)
 
 static int domain_translation_struct_show(struct seq_file *m, void *unused)
 {
-	unsigned long flags;
-	int ret;
 
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
index 1af4b6562266..cacae8bdaa65 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-DEFINE_SPINLOCK(device_domain_lock);
+static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
 /*
-- 
2.25.1

