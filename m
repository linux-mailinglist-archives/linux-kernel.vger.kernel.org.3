Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5B535969
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbiE0GeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbiE0GeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE405C86A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633242; x=1685169242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SaezIU2KemVpoNQHn3KxEWZBO5XA8cmu4TjU1ZF0rFA=;
  b=iH8mHNo0DQqMk5ROoMwByOrKqEOLlIk32jFNA59H2kO3xpcLm3mRKCNz
   +bLuJ0WN6j3ebUukOGPPJ3C9ewsxg2B6p0A5AbyRD56aXWlw0AUAY7G/B
   ke210XoBBowxfIl6BCe2/D8jv1X6mSqwN1e4zjXg+GQl4FtfbPCp6x7y2
   LZ3yUrO7jb6dOORNH3brWqLxuB0oGVCxxY8YWdmN1N1ytLlS+PV3nsnAp
   Drf36Epq4Ut0N3m8EXPqGB5Ohl9KMtG/EBACdOFDNURK2egKMvb5SRv8C
   KrqDXkUYBqljUoFsHDs+tOSljk+yR1+OP8jI6E3lsOdTQFXrsAa6yZyg4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044847"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044847"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688412"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:33:58 -0700
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
Subject: [PATCH 02/12] iommu/vt-d: Remove for_each_device_domain()
Date:   Fri, 27 May 2022 14:30:09 +0800
Message-Id: <20220527063019.3112905-3-baolu.lu@linux.intel.com>
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

The per-device device_domain_info data could be retrieved from the
device itself. There's no need to search a global list.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  2 --
 drivers/iommu/intel/iommu.c | 25 -------------------------
 drivers/iommu/intel/pasid.c | 37 +++++++++++--------------------------
 3 files changed, 11 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8a6d64d726c0..2f4a5b9509c0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -727,8 +727,6 @@ extern int dmar_ir_support(void);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
-int for_each_device_domain(int (*fn)(struct device_domain_info *info,
-				     void *data), void *data);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cacae8bdaa65..6549b09d7f32 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -316,31 +316,6 @@ static int iommu_skip_te_disable;
 
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
-
-/*
- * Iterate over elements in device_domain_list and call the specified
- * callback @fn against each element.
- */
-int for_each_device_domain(int (*fn)(struct device_domain_info *info,
-				     void *data), void *data)
-{
-	int ret = 0;
-	unsigned long flags;
-	struct device_domain_info *info;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &device_domain_list, global) {
-		ret = fn(info, data);
-		if (ret) {
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-			return ret;
-		}
-	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return 0;
-}
-
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b2ac5869286f..0627d6465f25 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -103,36 +103,20 @@ device_detach_pasid_table(struct device_domain_info *info,
 }
 
 struct pasid_table_opaque {
-	struct pasid_table	**pasid_table;
-	int			segment;
-	int			bus;
-	int			devfn;
+	struct pasid_table	*pasid_table;
 };
 
-static int search_pasid_table(struct device_domain_info *info, void *opaque)
-{
-	struct pasid_table_opaque *data = opaque;
-
-	if (info->iommu->segment == data->segment &&
-	    info->bus == data->bus &&
-	    info->devfn == data->devfn &&
-	    info->pasid_table) {
-		*data->pasid_table = info->pasid_table;
-		return 1;
-	}
-
-	return 0;
-}
-
 static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void *opaque)
 {
 	struct pasid_table_opaque *data = opaque;
+	struct device_domain_info *info;
 
-	data->segment = pci_domain_nr(pdev->bus);
-	data->bus = PCI_BUS_NUM(alias);
-	data->devfn = alias & 0xff;
+	info = dev_iommu_priv_get(&pdev->dev);
+	if (!info || !info->pasid_table)
+		return 0;
 
-	return for_each_device_domain(&search_pasid_table, data);
+	data->pasid_table = info->pasid_table;
+	return 1;
 }
 
 /*
@@ -141,9 +125,9 @@ static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void *opaque)
  */
 int intel_pasid_alloc_table(struct device *dev)
 {
+	struct pasid_table_opaque data = { NULL };
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
-	struct pasid_table_opaque data;
 	struct page *pages;
 	u32 max_pasid = 0;
 	int ret, order;
@@ -155,11 +139,12 @@ int intel_pasid_alloc_table(struct device *dev)
 		return -EINVAL;
 
 	/* DMA alias device already has a pasid table, use it: */
-	data.pasid_table = &pasid_table;
 	ret = pci_for_each_dma_alias(to_pci_dev(dev),
 				     &get_alias_pasid_table, &data);
-	if (ret)
+	if (ret) {
+		pasid_table = data.pasid_table;
 		goto attach_out;
+	}
 
 	pasid_table = kzalloc(sizeof(*pasid_table), GFP_KERNEL);
 	if (!pasid_table)
-- 
2.25.1

