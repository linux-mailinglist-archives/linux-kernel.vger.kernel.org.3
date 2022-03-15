Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C444D93A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiCOFNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344851AbiCOFMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:12:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350304924A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647321070; x=1678857070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6uSpqGl1pbsEqnfIlo3vVDu6SwoYiBP9Hzf6kLLgWR8=;
  b=d9CYuwcTPTkqpN8Munh15JCMAam9CC9OQHu+6q9cM9/yQiUNvjQInBeq
   BpPhFDZvLJ99s0jsXx8atZwYoraF/IrqROn3+Ixd71q/GygZElT6+XzsJ
   KagRk0viMHoC+LDq4/z26xwyIoWsk6LMJKibFplDUEnbzUhMvo9CZGG3v
   Q1vwWuvRHrl+OvX5Mxxo2EkLkzB0WRDGvskOceC2FdjFxY3yt9JnVpGhC
   5I6EJJOhk/KY7+kC9jFiBX3yxOdgf83fd0np42N1rJkfRqxoYsrCaYbPo
   qIc92tXKU5jXDFQeRI+CNoaHKH8STIO+tCIxi8bA0A05XQvu2kYRYoEG1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236159110"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="236159110"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="580383598"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:04:00 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 9/9] dmaengine: idxd: separate user and kernel pasid enabling
Date:   Mon, 14 Mar 2022 22:07:13 -0700
Message-Id: <20220315050713.2000518-10-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

The idxd driver always gated the pasid enabling under a single knob and
this assumption is incorrect. The pasid used for kernel operation can be
independently toggled and has no dependency on the user pasid (and vice
versa). Split the two so they are independent "enabled" flags.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/dma/idxd/cdev.c |  4 ++--
 drivers/dma/idxd/idxd.h |  6 ++++++
 drivers/dma/idxd/init.c | 30 ++++++++++++++++++------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 312ec37ebf91..addaebca7683 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -99,7 +99,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	ctx->wq = wq;
 	filp->private_data = ctx;
 
-	if (device_pasid_enabled(idxd)) {
+	if (device_user_pasid_enabled(idxd)) {
 		sva = iommu_sva_bind_device(dev, current->mm);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
@@ -152,7 +152,7 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	if (wq_shared(wq)) {
 		idxd_device_drain_pasid(idxd, ctx->pasid);
 	} else {
-		if (device_pasid_enabled(idxd)) {
+		if (device_user_pasid_enabled(idxd)) {
 			/* The wq disable in the disable pasid function will drain the wq */
 			rc = idxd_wq_disable_pasid(wq);
 			if (rc < 0)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index a09ab4a6e1c1..190b08bd7c08 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -239,6 +239,7 @@ enum idxd_device_flag {
 	IDXD_FLAG_CONFIGURABLE = 0,
 	IDXD_FLAG_CMD_RUNNING,
 	IDXD_FLAG_PASID_ENABLED,
+	IDXD_FLAG_USER_PASID_ENABLED,
 };
 
 struct idxd_dma_dev {
@@ -468,6 +469,11 @@ static inline bool device_pasid_enabled(struct idxd_device *idxd)
 	return test_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 }
 
+static inline bool device_user_pasid_enabled(struct idxd_device *idxd)
+{
+	return test_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
+}
+
 static inline bool device_swq_supported(struct idxd_device *idxd)
 {
 	return (support_enqcmd && device_pasid_enabled(idxd));
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 5d1f8dd4abf6..981150b7d09b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -500,16 +500,19 @@ static int idxd_probe(struct idxd_device *idxd)
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
 		rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA);
-		if (rc == 0) {
-			rc = idxd_enable_system_pasid(idxd);
-			if (rc < 0) {
-				iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
-				dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
-			} else {
-				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
-			}
-		} else {
+		if (rc) {
+			/*
+			 * Do not bail here since legacy DMA is still
+			 * supported, both user and in-kernel DMA with
+			 * PASID rely on SVA feature.
+			 */
 			dev_warn(dev, "Unable to turn on SVA feature.\n");
+		} else {
+			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
+			if (idxd_enable_system_pasid(idxd))
+				dev_warn(dev, "No in-kernel DMA with PASID.\n");
+			else
+				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 		}
 	}
 	idxd_read_caps(idxd);
@@ -545,7 +548,8 @@ static int idxd_probe(struct idxd_device *idxd)
  err:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd) || device_pasid_enabled(idxd))
+		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
 	return rc;
 }
 
@@ -558,7 +562,8 @@ static void idxd_cleanup(struct idxd_device *idxd)
 	idxd_cleanup_internals(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd) || device_pasid_enabled(idxd))
+		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
 }
 
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -677,7 +682,8 @@ static void idxd_remove(struct pci_dev *pdev)
 	free_irq(irq_entry->vector, irq_entry);
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
-	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd) || device_pasid_enabled(idxd))
+		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-- 
2.25.1

