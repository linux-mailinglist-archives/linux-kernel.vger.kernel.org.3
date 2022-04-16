Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E5503689
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiDPMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiDPMJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:09:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C24D9CC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650110818; x=1681646818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZEekOCvmqUuQ4X15MOWFS0pi7DbdrUqVzVf5lho4Kk=;
  b=GHyhn4AA+U9ZaZTf55XTivNMB8I/3I0ClZAtKKeFn1PthW5ToXsKDtxv
   NHZO6gI6xBNHA3yKguJHEXt4l5L7bxCrMetOkxSY14p9o9M4aaa42ywvs
   9g9Hj1LA5+8o9Db+dt1iwv6hEMXHNFGU9yPXKHdB82dOFWd9w0sblplQ5
   KKnAHppCk2sBAtfecVsdYxyCr+GAJpDX6Y3uUylv8L2+Dhr8ekhClHio6
   8CGm0+i1v+Ef8jJ9/kI7lBsZi7LxQlYG/DR67JxYsqUIw0xCsn6ClzTqD
   TTTwCvJ8FMtpCSbOZwK0i8mWZblmW0fXCP+vXf85CTRABuX10IVBLGniA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349738708"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="349738708"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 05:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701329057"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:06:57 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/2] iommu/vt-d: Change return type of dmar_insert_one_dev_info()
Date:   Sat, 16 Apr 2022 20:04:22 +0800
Message-Id: <20220416120423.879552-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416120423.879552-1-baolu.lu@linux.intel.com>
References: <20220416120423.879552-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/intel/iommu.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d24e6da33a60..ae0301e3ce53 100644
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
+		return ret;
 	}
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -2501,7 +2500,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
 			dmar_remove_one_dev_info(dev);
-			return NULL;
+			return ret;
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
@@ -2519,17 +2518,18 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
-			return NULL;
+			return ret;
 		}
 	}
 
-	if (domain_context_mapping(domain, dev)) {
+	ret = domain_context_mapping(domain, dev);
+	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(dev);
-		return NULL;
+		return ret;
 	}
 
-	return domain;
+	return 0;
 }
 
 static int iommu_domain_identity_map(struct dmar_domain *domain,
@@ -2607,7 +2607,6 @@ static int __init si_domain_init(int hw)
 
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
-	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
 
@@ -2615,11 +2614,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
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

