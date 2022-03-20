Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A19D4E1A75
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiCTGoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiCTGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:44:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEDE2102AB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647758561; x=1679294561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=riq+74Hd12qH3YALmkqybAFcLX89Dbvo/9sgqkY6aro=;
  b=kfvQJ8GlVKse/d/TmJllqVtxigk6+G7Rxqd6MKrtvf1S2aO+0gnvYfVN
   /YPHtefs4cYQGcJCXjSvLKmLG/tlKtvctp7IL1VFQIruyxGLHVUqywxbw
   n5ae0KXoAEnbl5TTVZ2NmqO0Al52j6XeLGrHM4qax/JW7PiGsL7wy7ixe
   FfyGesQ77X7vFQ450lV/GE5f7WQ8Pz7Sw1wmrsnCIswzN3XMeyPoKB6Lx
   5vb3YWbmwy+3++/dbs6JAwO3kBxr/7dj2CZtIncoGgj/aqvszS+5bb27A
   5zaOnSW0E59zIwkcXTdScGbhr8QApT8Sq57H/ILud8IsngU8/tXqhYpet
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254924007"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254924007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="691839870"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:38 -0700
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
Subject: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Date:   Sun, 20 Mar 2022 14:40:20 +0800
Message-Id: <20220320064030.2936936-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                       | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/iommu.c                 | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

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
index 627a3ed5ee8f..8e262210b5ad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 		master->iopf_enabled = true;
 		return 0;
 	case IOMMU_DEV_FEAT_SVA:
+		dev->iommu->pasid_bits = master->ssid_bits;
 		return arm_smmu_master_enable_sva(master);
 	default:
 		return -EINVAL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6f7485c44a4b..c1b91bce1530 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4587,8 +4587,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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

