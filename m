Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1004ACE41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245720AbiBHBsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbiBHB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:28:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF057C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644283684; x=1675819684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OG9iZylin4o9oKkALo3y6gJK8tYv5s9ZK3w3oIi1xjA=;
  b=E+C8gQbOusz9blA6ima1L1/rtljNCIuXRBGP22iwcdm268fbwcv2cxfG
   cwpl6lpvjKPt9Jmh2f3Rk7DRMy/ID2FTbWRHJ9T6r6tAJFXqJ/Z9l03No
   +qlc1FfxaycFDxlrhpC/mWRgb05nUA/uu5jzasoLuzlrnomRm6t27nqLN
   o2Ju30qXgGdLEM/B7jSCQrxUJ0VhQpwkZmiBwV24AyESeDsDzi04oq7fI
   VxLI8N3tIgsx1EIXdpmNwbuWsnJ05EitcatHjKTGh8tRpHNl7TIDq44Rt
   5vl9yCnw7x0jwRd5i29E2z/I5qkPTwUdgFp+FYQ5TvoADMRB2cB1AqlkJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236252006"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="236252006"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:28:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677948876"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:28:00 -0800
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
Subject: [PATCH v2 09/10] iommu: Use dev_iommu_ops() helper
Date:   Tue,  8 Feb 2022 09:25:58 +0800
Message-Id: <20220208012559.1121729-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all the feasible instances of dev->bus->iommu_ops to
dev_iommu_ops() in order to making the operation of obtaining
iommu_ops from a device consistent.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3dff30ddebdd..a731b037e6fb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -318,13 +318,14 @@ int iommu_probe_device(struct device *dev)
 
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
@@ -1518,7 +1519,7 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
 static int iommu_get_def_domain_type(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
 		return IOMMU_DOMAIN_DMA;
@@ -1577,7 +1578,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
  */
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group;
 	int ret;
 
@@ -2574,7 +2575,7 @@ EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
 
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops && ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
@@ -2582,7 +2583,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops && ops->put_resv_regions)
 		ops->put_resv_regions(dev, list);
@@ -2788,7 +2789,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (!ops || !ops->sva_bind)
 		return ERR_PTR(-ENODEV);
@@ -2831,7 +2832,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 	struct iommu_group *group;
 	struct device *dev = handle->dev;
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (!ops || !ops->sva_unbind)
 		return;
@@ -2850,7 +2851,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
 u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
-	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
 
 	if (!ops || !ops->sva_get_pasid)
 		return IOMMU_PASID_INVALID;
-- 
2.25.1

