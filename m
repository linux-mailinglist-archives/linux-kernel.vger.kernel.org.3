Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA074B3F27
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiBNB6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:58:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiBNB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:58:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A655BF7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644803888; x=1676339888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F26i5auVutrL0981CHcSyAs4eEJxP31jaSB2EXCl+uI=;
  b=fTY5Qs9oWUjRYstQ7KuG8g8a8DiazoQmafEY5Exl6xeiBhUCumP08OqT
   6TRsyTtNmeS6cgj7V6O86rUha4T/ViGNrDiytLXncN+zgvs6HUfn8GNBI
   7/Lwff3aQYtph0+Aa5gnZNhosMkso7mFDtByfseiMGMyDU5ynFZfOdWei
   Y77LQA5Jzhm81xM5QdGXZnxLUAYRQz5HuiLRDJAhDaqzt35CvBa3lx2GL
   7G/K1DswA9tRo1Ldu2x6Mjaj/k4+coIoC+kz11s6/w8vSnZxQA09pfz8Z
   JKeybXynRjxwojVsk18gdJOsXgJju4r+yfo6iGe/bycv+rmsP03FTeI+V
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="248823730"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="248823730"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 17:58:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="680137441"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 17:58:04 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 09/10] iommu: Use dev_iommu_ops() helper
Date:   Mon, 14 Feb 2022 09:55:37 +0800
Message-Id: <20220214015538.2828933-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
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

This converts all the feasible instances of dev->bus->iommu_ops to
dev_iommu_ops() in order to make the operation of obtaining iommu_ops
from a device consistent. The dev_iommu_ops() warns on NULL ops, so
we don't need to keep the confusing ops check.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 245e3d2fb74b..27276421d253 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -323,13 +323,14 @@ int iommu_probe_device(struct device *dev)
 
 void iommu_release_device(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops;
 
 	if (!dev->iommu)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	ops = dev_iommu_ops(dev);
 	ops->release_device(dev);
 
 	iommu_group_remove_device(dev);
@@ -1522,7 +1523,7 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
 static int iommu_get_def_domain_type(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
 		return IOMMU_DOMAIN_DMA;
@@ -1581,7 +1582,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
  */
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group;
 	int ret;
 
@@ -1589,9 +1590,6 @@ static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (group)
 		return group;
 
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
 	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		return ERR_PTR(-EINVAL);
@@ -2578,17 +2576,17 @@ EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
 
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (ops && ops->get_resv_regions)
+	if (ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (ops && ops->put_resv_regions)
+	if (ops->put_resv_regions)
 		ops->put_resv_regions(dev, list);
 }
 
@@ -2793,9 +2791,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!ops || !ops->sva_bind)
+	if (!ops->sva_bind)
 		return ERR_PTR(-ENODEV);
 
 	group = iommu_group_get(dev);
@@ -2836,9 +2834,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 	struct iommu_group *group;
 	struct device *dev = handle->dev;
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!ops || !ops->sva_unbind)
+	if (!ops->sva_unbind)
 		return;
 
 	group = iommu_group_get(dev);
@@ -2855,9 +2853,9 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
 u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
-	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
 
-	if (!ops || !ops->sva_get_pasid)
+	if (!ops->sva_get_pasid)
 		return IOMMU_PASID_INVALID;
 
 	return ops->sva_get_pasid(handle);
-- 
2.25.1

