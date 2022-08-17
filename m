Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE3059679A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiHQDCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiHQDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:02:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315A9A949
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660705331; x=1692241331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6X6o1i61RSlBf+Uwyk+xiA1OnR+QLGnsLgi6BR+f7oY=;
  b=g/gfC+um5YlVS/NbNUzVe3j9eXKRFYoe5EF9naHdCx5c0daOnElI5w3e
   U+ofWFregTm2Boo0arE04ajw/ef1t0F9+EyjtDW2KoU/tN+XvtfM/6lmF
   6L05/JEs9KR5JIFYvsBq5ItLNMY8HwjScmvGAld0ND6xhPamH4GH9c0of
   Yt4HTnB6cyheW8NXPs2e/aI3WLYkY6jvDw/23ZmF6ZZfVCh4xb61nalYQ
   e7Fm85Y7+/2tXVzdSMnYMsBp/Vn+emuchxtRnLQoGEJmmbJb1yr9xxzOe
   1Ii3K3B7gvGfRk/bv3IMaVFmXJpsGrBjLduu7jog8Sz84NJhparB2NWpw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="291139146"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="291139146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 20:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583577318"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2022 20:02:08 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix possible recursive lock in iommu_flush_dev_iotlb()
Date:   Wed, 17 Aug 2022 10:56:50 +0800
Message-Id: <20220817025650.3253959-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per domain spinlock is acquired in iommu_flush_dev_iotlb(), which
is possbile to be called in the interrupt context. For instance,

  <IRQ>
  iommu_flush_dev_iotlb
  iommu_flush_iotlb_psi
  intel_iommu_tlb_sync
  iommu_iotlb_sync
  __iommu_dma_unmap
  ? nvme_unmap_data
  nvme_unmap_data
  nvme_pci_complete_rq
  nvme_irq
  __handle_irq_event_percpu
  handle_irq_event_percpu
  handle_irq_event
  handle_edge_irq
  __common_interrupt
  common_interrupt

This coverts the spin_lock/unlock() into the irq save/restore varieties
to avoid the possible recursive locking issues.

Fixes: ffd5869d93530 ("iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 39 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2d0d2ef820d2..8d4f6f0b6c1c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -495,8 +495,9 @@ static int domain_update_device_node(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
+	unsigned long flags;
 
-	spin_lock(&domain->lock);
+	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
 		/*
 		 * There could possibly be multiple device numa nodes as devices
@@ -508,7 +509,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
-	spin_unlock(&domain->lock);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	return nid;
 }
@@ -1336,19 +1337,20 @@ iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
 			u8 bus, u8 devfn)
 {
 	struct device_domain_info *info;
+	unsigned long flags;
 
 	if (!iommu->qi)
 		return NULL;
 
-	spin_lock(&domain->lock);
+	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
-			spin_unlock(&domain->lock);
+			spin_unlock_irqrestore(&domain->lock, flags);
 			return info->ats_supported ? info : NULL;
 		}
 	}
-	spin_unlock(&domain->lock);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	return NULL;
 }
@@ -1357,8 +1359,9 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
+	unsigned long flags;
 
-	spin_lock(&domain->lock);
+	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
@@ -1366,7 +1369,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 		}
 	}
 	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock(&domain->lock);
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
@@ -1458,14 +1461,15 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 				  u64 addr, unsigned mask)
 {
 	struct device_domain_info *info;
+	unsigned long flags;
 
 	if (!domain->has_iotlb_device)
 		return;
 
-	spin_lock(&domain->lock);
+	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link)
 		__iommu_flush_dev_iotlb(info, addr, mask);
-	spin_unlock(&domain->lock);
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
@@ -2427,6 +2431,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
+	unsigned long flags;
 	u8 bus, devfn;
 	int ret;
 
@@ -2438,9 +2443,9 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 	info->domain = domain;
-	spin_lock(&domain->lock);
+	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
-	spin_unlock(&domain->lock);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
@@ -4064,6 +4069,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *domain = info->domain;
 	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
 
 	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
@@ -4075,9 +4081,9 @@ static void dmar_remove_one_dev_info(struct device *dev)
 		intel_pasid_free_table(info->dev);
 	}
 
-	spin_lock(&domain->lock);
+	spin_lock_irqsave(&domain->lock, flags);
 	list_del(&info->link);
-	spin_unlock(&domain->lock);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	domain_detach_iommu(domain, iommu);
 	info->domain = NULL;
@@ -4396,19 +4402,20 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long flags;
 
 	if (dmar_domain->force_snooping)
 		return true;
 
-	spin_lock(&dmar_domain->lock);
+	spin_lock_irqsave(&dmar_domain->lock, flags);
 	if (!domain_support_force_snooping(dmar_domain)) {
-		spin_unlock(&dmar_domain->lock);
+		spin_unlock_irqrestore(&dmar_domain->lock, flags);
 		return false;
 	}
 
 	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
-	spin_unlock(&dmar_domain->lock);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	return true;
 }
-- 
2.25.1

