Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74C570EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiGLAQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiGLAPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:15:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DD33DF39
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584885; x=1689120885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1ng+aqSA3bxg6XtqN0sxaxbhfr1xdkgYzRBbz8ItSE=;
  b=afUosRXNM0RYHtIjPHXb7TYs8Wt584uU1Bhf+rT/lq+0aH+AY17w2HrC
   52EqtMWByVK5uGL7Knz+0X97bDaZKZP7RsRwmNXy0mmYg1+jNdDUs/+rB
   jsG/QC+vJCjPry7ouOPKj1bxbyedrbGbw/fr/rUw55ZN3PaDHlGPXyi28
   FAacoHepUXRZLIhIMr8sCwP4y57S51x6BKQsu9mxn/mI77rYey5d/chSw
   v3EMBlbTFAsmirlFuC293f1xwCP2gbmx0PVE3rpfi9CvcuEh1BEpubYU0
   tC2DiPNLu9YXaRObmPutWiAY699cs3fr+AkDPDb0IqyKcq/ZCBnx6yTfL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285929322"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="285929322"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445835"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:05 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 16/25] iommu/vt-d: Check device list of domain in domain free path
Date:   Tue, 12 Jul 2022 08:08:59 +0800
Message-Id: <20220712000908.3431936-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the IOMMU domain is about to be freed, it should not be set on any
device. Instead of silently dealing with some bug cases, it's better to
trigger a warning to report and fix any potential bugs at the first time.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220706025524.2904370-9-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3d53de8c7634..a94fb69e1f9a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -294,7 +294,6 @@ static LIST_HEAD(dmar_satc_units);
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
-static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
@@ -1841,10 +1840,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 
 static void domain_exit(struct dmar_domain *domain)
 {
-
-	/* Remove associated devices and clear attached or cached domains */
-	domain_remove_dev_info(domain);
-
 	if (domain->pgd) {
 		LIST_HEAD(freelist);
 
@@ -1852,6 +1847,9 @@ static void domain_exit(struct dmar_domain *domain)
 		put_pages_list(&freelist);
 	}
 
+	if (WARN_ON(!list_empty(&domain->devices)))
+		return;
+
 	kfree(domain);
 }
 
@@ -2333,16 +2331,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
-static void domain_remove_dev_info(struct dmar_domain *domain)
-{
-	struct device_domain_info *info, *tmp;
-
-	spin_lock(&device_domain_lock);
-	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		__dmar_remove_one_dev_info(info);
-	spin_unlock(&device_domain_lock);
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
-- 
2.25.1

