Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD70A567C39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiGFDAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiGFDAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:00:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638711AF0D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076399; x=1688612399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3apr3bU9mf+okAIPMYSp8s/p9GHpJYjT6FHqDZj33g=;
  b=M40o6sqj4EcvM4RwQw4FrPgCiJoDPemCUn9XJPWmMe+8FEmgaB/XhiRP
   opBjn/F3SRSyW4ufL/O5RVW2qAOoNMtH8cX/r9zfQPEykvk5RpewIeesu
   NF9D/pZWKf7sD/j7vGfnY3kJTjKGs+RYiq1PHiDHWU4RX/tLXF9uCRafe
   xl7s20LJgLX4R0HS5ibtcBpTmHVcg94ZcP+mSve09BW4wHYNSuWA2A5Lb
   tTQscNilt1Xpi3J/nko6lRGeChvkTG7TVdIQG3Tk9uy6XFdm/+8BPluQg
   IcrlHr6xf1VxGMqT945tZZ/KHbkh7ctp2qyjKN/24jndi5aCDn/cawNy+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409540"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="272409540"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 19:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567874783"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 19:59:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 03/11] iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
Date:   Wed,  6 Jul 2022 10:55:16 +0800
Message-Id: <20220706025524.2904370-4-baolu.lu@linux.intel.com>
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

Use pci_get_domain_bus_and_slot() instead of searching the global list
to retrieve the pci device pointer. This also removes the global
device_domain_list as there isn't any consumer anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 34 ++++++----------------------------
 2 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8deb745d8b36..198c6c822ef4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -609,7 +609,6 @@ struct intel_iommu {
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
 	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 43aaec5bdd84..77915d61f7ec 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -131,8 +131,6 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -315,8 +313,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_AZALIA		4
 
 static DEFINE_SPINLOCK(device_domain_lock);
-static LIST_HEAD(device_domain_list);
-
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
@@ -846,9 +842,14 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
 	struct device_domain_info *info;
 	struct dma_pte *parent, *pte;
 	struct dmar_domain *domain;
+	struct pci_dev *pdev;
 	int offset, level;
 
-	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	pdev = pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);
+	if (!pdev)
+		return;
+
+	info = dev_iommu_priv_get(&pdev->dev);
 	if (!info || !info->domain) {
 		pr_info("device [%02x:%02x.%d] not probed\n",
 			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
@@ -2357,19 +2358,6 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
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
@@ -4573,7 +4561,6 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
@@ -4616,10 +4603,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_add(&info->global, &device_domain_list);
 	dev_iommu_priv_set(dev, info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return &iommu->iommu;
 }
@@ -4627,15 +4611,9 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	unsigned long flags;
 
 	dmar_remove_one_dev_info(dev);
-
-	spin_lock_irqsave(&device_domain_lock, flags);
 	dev_iommu_priv_set(dev, NULL);
-	list_del(&info->global);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
 	kfree(info);
 	set_dma_ops(dev, NULL);
 }
-- 
2.25.1

