Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4A47717B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhLPMRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:17:11 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34098 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234080AbhLPMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:17:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V-p8n22_1639657018;
Received: from localhost(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0V-p8n22_1639657018)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 20:17:06 +0800
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
To:     bhelgaas@google.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org
Cc:     linux-kernel@vger.kernel.org,
        alikernel-developer@linux.alibaba.com,
        zhangliguang@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        yaohongbo@linux.alibaba.com
Subject: [RFC PATCH] iommu: alloc iommu group for pasid supported devices
Date:   Thu, 16 Dec 2021 20:16:58 +0800
Message-Id: <1639657018-39884-1-git-send-email-yaohongbo@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a pci hotlug problem for PCI pasid enabled devices.

We can probe PCI pasid enabled devices on boot normally,
but the following error is seen while we poweroff and poweron
this pci slot:
[  312.407485] nvme 0000:9c:00.0: cannot attach to incompatible domain
(0 SSID bits != 20)
[  312.415618] nvme 0000:9c:00.0: Failed to add to iommu group 11: -22

Each device would alloc an iommu group when the os starts.
But when we hot-plug the pcie device, the device may be added to the
parent iommu group. If the device supports pasid, master->ssid_bits
would be changed in arm_smmu_enable_pasid(), but smmu->domain is from
the parent iommu, which will result in the upon error in
arm_smmu_attach_dev().

Realloc a new iommu group if the device supports to enable pasid.

Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
---
 drivers/iommu/iommu.c   |  4 ++++
 drivers/pci/ats.c       | 12 ++++++++++++
 include/linux/pci-ats.h |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dd7863e..61b5360 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -21,6 +21,7 @@
 #include <linux/notifier.h>
 #include <linux/err.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
@@ -1475,6 +1476,9 @@ struct iommu_group *pci_device_group(struct device *dev)
 		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
 			break;
 
+		if (pci_pasid_supported(pdev))
+			break;
+
 		pdev = bus->self;
 
 		group = iommu_group_get(&pdev->dev);
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6..8fcca4f 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -349,6 +349,18 @@ void pci_pasid_init(struct pci_dev *pdev)
 	pdev->pasid_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 }
 
+bool pci_pasid_supported(struct pci_dev *pdev)
+{
+	if (!pdev->pasid_cap)
+		return false;
+
+	if (!pdev->eetlp_prefix_path)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_pasid_supported);
+
 /**
  * pci_enable_pasid - Enable the PASID capability
  * @pdev: PCI device structure
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b..623725b 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -35,11 +35,14 @@ static inline bool pci_pri_supported(struct pci_dev *pdev)
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
+bool pci_pasid_supported(struct pci_dev *dev);
 int pci_enable_pasid(struct pci_dev *pdev, int features);
 void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
+static inline bool pci_pasid_supported(struct pci_dev *d)
+{ return false; }
 static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
 { return -EINVAL; }
 static inline void pci_disable_pasid(struct pci_dev *pdev) { }
-- 
1.8.3.1

