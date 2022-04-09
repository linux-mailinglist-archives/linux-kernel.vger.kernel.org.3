Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472504FA893
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242055AbiDINen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiDINek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:34:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E730187BB4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649511153; x=1681047153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=60z86IsfKNedOIQbPNYiwb7F+FTL02AF8htmqN73hc0=;
  b=NZ4QJ9MsUeniY+CohUK9NC7PN0pqWbD9F6fdP481gWqGVskwat6UZ+/a
   0w7UQZjxDGoLgoHn5th/QnvXfdcl82EaBmEndeG0yrSJ3MHm0kTw0ilDQ
   SIUHwE524u3t2N6+ynyP65NY+LB9EjgNkkC0zRtPk2RQ7klkRSJKzvva0
   FnzZqXhczRGwobvsxSUoxV+Gg7IVfVdIcWdpWVLp9x8bImoVGWu623YbT
   AZaazn6r12a6O6Jpkn6MuCH091QZj+mifBum7q2ixoXU9nyDMsxMjWHtn
   kOMz8FPufvMKeqHvb9sjxD2KJWFGDR8WCDHhYkYNaIo9avyUEwtKjNLqj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="260648032"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="260648032"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 06:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="610239138"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2022 06:32:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Change return type of dmar_insert_one_dev_info()
Date:   Sat,  9 Apr 2022 21:30:06 +0800
Message-Id: <20220409133006.3953129-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dmar_insert_one_dev_info() returns the pass-in domain on success and
NULL on failure. This doesn't make much sense. Change it to an integer.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d24e6da33a60..5682f3de205d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2474,10 +2474,9 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
-						    int bus, int devfn,
-						    struct device *dev,
-						    struct dmar_domain *domain)
+static int dmar_insert_one_dev_info(struct intel_iommu *iommu, int bus,
+				    int devfn, struct device *dev,
+				    struct dmar_domain *domain)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	unsigned long flags;
@@ -2490,7 +2489,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	spin_unlock(&iommu->lock);
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
-		return NULL;
+		return -ENODEV;
 	}
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -2501,7 +2500,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
 			dmar_remove_one_dev_info(dev);
-			return NULL;
+			return -ENOMEM;
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
@@ -2519,17 +2518,17 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
-			return NULL;
+			return -ENODEV;
 		}
 	}
 
 	if (domain_context_mapping(domain, dev)) {
 		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(dev);
-		return NULL;
+		return -ENODEV;
 	}
 
-	return domain;
+	return 0;
 }
 
 static int iommu_domain_identity_map(struct dmar_domain *domain,
@@ -2607,7 +2606,6 @@ static int __init si_domain_init(int hw)
 
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
-	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
 
@@ -2615,11 +2613,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	ndomain = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
-	if (ndomain != domain)
-		return -EBUSY;
-
-	return 0;
+	return dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
 }
 
 static bool device_has_rmrr(struct device *dev)
-- 
2.25.1

