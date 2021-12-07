Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F404646C793
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbhLGWip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:38:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:41976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242255AbhLGWig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:38:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237509356"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237509356"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="515845508"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2021 14:35:05 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with PASID
Date:   Tue,  7 Dec 2021 05:47:14 -0800
Message-Id: <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-kernel DMA should be managed by DMA mapping API. The existing kernel
PASID support is based on the SVA machinery in SVA lib that is intended
for user process SVA. The binding between a kernel PASID and kernel
mapping has many flaws. See discussions in the link below.

This patch utilizes iommu_enable_pasid_dma() to enable DSA to perform DMA
requests with PASID under the same mapping managed by DMA mapping API.
In addition, SVA-related bits for kernel DMA are removed. As a result,
DSA users shall use DMA mapping API to obtain DMA handles instead of
using kernel virtual addresses.

Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 --
 drivers/dma/Kconfig                           | 10 ----
 drivers/dma/idxd/idxd.h                       |  1 -
 drivers/dma/idxd/init.c                       | 59 ++++++-------------
 drivers/dma/idxd/sysfs.c                      |  7 ---
 5 files changed, 19 insertions(+), 64 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d4..fe73d02c62f3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1751,12 +1751,6 @@
 			In such case C2/C3 won't be used again.
 			idle=nomwait: Disable mwait for CPU C-states
 
-	idxd.sva=	[HW]
-			Format: <bool>
-			Allow force disabling of Shared Virtual Memory (SVA)
-			support for the idxd driver. By default it is set to
-			true (1).
-
 	idxd.tc_override= [HW]
 			Format: <bool>
 			Allow override of default traffic class configuration
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6bcdb4e6a0d1..3b28bd720e7d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -313,16 +313,6 @@ config INTEL_IDXD_COMPAT
 
 	  If unsure, say N.
 
-# Config symbol that collects all the dependencies that's necessary to
-# support shared virtual memory for the devices supported by idxd.
-config INTEL_IDXD_SVM
-	bool "Accelerator Shared Virtual Memory Support"
-	depends on INTEL_IDXD
-	depends on INTEL_IOMMU_SVM
-	depends on PCI_PRI
-	depends on PCI_PASID
-	depends on PCI_IOV
-
 config INTEL_IDXD_PERFMON
 	bool "Intel Data Accelerators performance monitor support"
 	depends on INTEL_IDXD
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 0cf8d3145870..3155e3a2d3ae 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -262,7 +262,6 @@ struct idxd_device {
 	struct idxd_wq **wqs;
 	struct idxd_engine **engines;
 
-	struct iommu_sva *sva;
 	unsigned int pasid;
 
 	int num_groups;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 7bf03f371ce1..44633f8113e2 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -16,6 +16,7 @@
 #include <linux/idr.h>
 #include <linux/intel-svm.h>
 #include <linux/iommu.h>
+#include <linux/dma-iommu.h>
 #include <uapi/linux/idxd.h>
 #include <linux/dmaengine.h>
 #include "../dmaengine.h"
@@ -28,10 +29,6 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_IMPORT_NS(IDXD);
 
-static bool sva = true;
-module_param(sva, bool, 0644);
-MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
-
 bool tc_override;
 module_param(tc_override, bool, 0644);
 MODULE_PARM_DESC(tc_override, "Override traffic class defaults");
@@ -530,36 +527,22 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
 {
-	int flags;
-	unsigned int pasid;
-	struct iommu_sva *sva;
-
-	flags = SVM_FLAG_SUPERVISOR_MODE;
-
-	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
-	if (IS_ERR(sva)) {
-		dev_warn(&idxd->pdev->dev,
-			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
-		return PTR_ERR(sva);
-	}
+	u32 pasid;
 
-	pasid = iommu_sva_get_pasid(sva);
-	if (pasid == IOMMU_PASID_INVALID) {
-		iommu_sva_unbind_device(sva);
+	pasid = iommu_enable_pasid_dma(&idxd->pdev->dev);
+	if (pasid == INVALID_IOASID) {
+		dev_err(&idxd->pdev->dev, "No kernel DMA PASID\n");
 		return -ENODEV;
 	}
-
-	idxd->sva = sva;
 	idxd->pasid = pasid;
-	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
+
 	return 0;
 }
 
 static void idxd_disable_system_pasid(struct idxd_device *idxd)
 {
-
-	iommu_sva_unbind_device(idxd->sva);
-	idxd->sva = NULL;
+	iommu_disable_pasid_dma(&idxd->pdev->dev);
+	idxd->pasid = 0;
 }
 
 static int idxd_probe(struct idxd_device *idxd)
@@ -575,21 +558,17 @@ static int idxd_probe(struct idxd_device *idxd)
 
 	dev_dbg(dev, "IDXD reset complete\n");
 
-	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA);
-		if (rc == 0) {
-			rc = idxd_enable_system_pasid(idxd);
-			if (rc < 0) {
-				iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
-				dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
-			} else {
-				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
-			}
-		} else {
-			dev_warn(dev, "Unable to turn on SVA feature.\n");
-		}
-	} else if (!sva) {
-		dev_warn(dev, "User forced SVA off via module param.\n");
+	/*
+	 * Try to enable both in-kernel and user DMA request with PASID.
+	 * PASID is supported unless both user and kernel PASID are
+	 * supported. Do not fail probe here in that idxd can still be
+	 * used w/o PASID or IOMMU.
+	 */
+	if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) ||
+		idxd_enable_system_pasid(idxd)) {
+		dev_warn(dev, "Failed to enable PASID\n");
+	} else {
+		set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 	}
 
 	idxd_read_caps(idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index a9025be940db..35737299c355 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -776,13 +776,6 @@ static ssize_t wq_name_store(struct device *dev,
 	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
 		return -EINVAL;
 
-	/*
-	 * This is temporarily placed here until we have SVM support for
-	 * dmaengine.
-	 */
-	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq->idxd))
-		return -EOPNOTSUPP;
-
 	memset(wq->name, 0, WQ_NAME_SIZE + 1);
 	strncpy(wq->name, buf, WQ_NAME_SIZE);
 	strreplace(wq->name, '\n', '\0');
-- 
2.25.1

