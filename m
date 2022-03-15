Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCF94D9396
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbiCOFMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344840AbiCOFMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:12:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93524924A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647321066; x=1678857066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ekgMTzrt4B/E5Ajgcaoa3ieo7uw7tCFXNnm15MECQas=;
  b=DTQDd3SmHyOG2kwoQNdAOo31txWrmjNssI1YFsMCIIVPwRofpccbAq1T
   gbdiQq8ucnX5J/VWXG0U7hWyXPxzoQR4oS0uo6CcHTAohgmDDqSH5Y2Ho
   xJg+rGg29ljCvWhv/rF0bzIW9ou0Z9prPgAQ7gY7OSv7FPzMzrXc2nrZ1
   zIKcsvYtp1Hhx9iVzZ1Xxhcl2xJ4iGEx1ac6vLiRfmQ/7oQy73FKLn7Sb
   ZWKWDUZExWHg4TwbNzWnLuepYP3spvmuKHXlD4vVl1TXVWOoXClDBFHSx
   ULldq99ggKz6Fj+T+LGuf5nEGX9aeOP6KGQIHAuZSamSheqw7Dyp1rnG1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236159099"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="236159099"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="580383567"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:58 -0700
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
Subject: [PATCH v2 1/8] iommu: Assign per device max PASID
Date:   Mon, 14 Mar 2022 22:07:05 -0700
Message-Id: <20220315050713.2000518-2-jacob.jun.pan@linux.intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

PCIe spec defines Max PASID Width per-device.  Since a PASID is only
used with IOMMU enabled, this patch introduces a PASID max variable on
the per-device IOMMU data. It will be used for limiting PASID allocation
in that PASID table is per-device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  4 +++-
 include/linux/iommu.h       | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50666d250b36..881f8361eca2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2602,8 +2602,10 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (sm_supported(iommu)) {
 			if (pasid_supported(iommu)) {
 				int features = pci_pasid_features(pdev);
-				if (features >= 0)
+				if (features >= 0) {
 					info->pasid_supported = features | 1;
+					iommu_set_dev_pasid_max(&pdev->dev, pci_max_pasids(pdev));
+				}
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de0c57a567c8..369f05c2a4e2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -364,6 +364,7 @@ struct iommu_fault_param {
  * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
+ * @pasid_max	 Max PASID value supported by this device
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -375,8 +376,20 @@ struct dev_iommu {
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
+	unsigned int			pasid_max;
 };
 
+static inline void iommu_set_dev_pasid_max(struct device *dev,
+					    unsigned int max)
+{
+	struct dev_iommu *param = dev->iommu;
+
+	if (WARN_ON(!param))
+		return;
+
+	param->pasid_max = max;
+}
+
 int iommu_device_register(struct iommu_device *iommu,
 			  const struct iommu_ops *ops,
 			  struct device *hwdev);
-- 
2.25.1

