Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17164FAD3A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiDJK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiDJK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:29:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A963BF6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649586432; x=1681122432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BKIzNNGqmV4foEUQe34V+LL7z7rFtTEgFa1bQg+vi/E=;
  b=Qo/dhW3jc34yZ32wR/7ArA4F5W/eLXkvKm3XQv09EmSKZ2iOLQEdUp4E
   nRqlJsMnUsNyxXo/Dpu3F8ezQ+OG7aiXpE0HaoUMIROqYywQffV7mCK7I
   a5ox4F5WLft+lF+q4Iww0uHUOLSR9QKUy6Lf/lpH4HAnyvXVdma9DSV0Y
   uqrF9ABKZQ3QgS8oNTs5S9u4E+NaivCvQZY+Dts3zDCvvXDFcic5ixKhw
   MjaBNWEwwhvudMEgPANfMVn24PQNFGE322Efbgu45PoJ+VQ8cpO7dJ2aA
   O2H43iVfzgrCT9x6Mg0561Q1k62VvF4HrKtKxgFQigGjmwz/xsyYlPnwy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="286962885"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="286962885"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 03:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="699019585"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v3 01/12] iommu: Add pasid_bits field in struct dev_iommu
Date:   Sun, 10 Apr 2022 18:24:32 +0800
Message-Id: <20220410102443.294128-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410102443.294128-1-baolu.lu@linux.intel.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use this field to save the pasid/ssid bits that a device is able to
support with its IOMMU hardware. It is a generic attribute of a device
and lifting it into the per-device dev_iommu struct makes it possible
to allocate a PASID for device without calls into the IOMMU drivers.
Any iommu driver which suports PASID related features should set this
field before features are enabled on the devices.

For initialization of this field in the VT-d driver, the
info->pasid_supported is only set for PCI devices. So the status is
that non-PCI SVA hasn't been supported yet. Setting this field only for
PCI devices has no functional change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                       | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
 drivers/iommu/intel/iommu.c                 | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6ef2df258673..36f43af0af53 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -368,6 +368,7 @@ struct dev_iommu {
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
+	unsigned int			pasid_bits;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 627a3ed5ee8f..afc63fce6107 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	dev->iommu->pasid_bits = master->ssid_bits;
+
 	return &smmu->iommu;
 
 err_free_master:
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942..ffad7f8f2d73 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4593,8 +4593,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			if (pasid_supported(iommu)) {
 				int features = pci_pasid_features(pdev);
 
-				if (features >= 0)
+				if (features >= 0) {
 					info->pasid_supported = features | 1;
+					dev->iommu->pasid_bits =
+						fls(pci_max_pasids(pdev)) - 1;
+				}
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-- 
2.25.1

