Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36794B1CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347537AbiBKDHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:07:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbiBKDG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:06:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D642647
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644548818; x=1676084818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EkJfB7vhORyeNDzWL4R0G1atL9YTI01FB+mAIw3VUYg=;
  b=DebwYDIOgdpy1g+PFBf2xUOKhnNqGo0ht7iuo5P5XxyYxY4BRGdmyuOD
   7poi9vBbwOh41J+zA8nYHpZYK8v9nO5RYwEkhghYJuCWySOi5RJ4ntahs
   NWMC6/XByVB4MQjdmWUePHahRhdwv8AdnBDpiRfshnv82diompu2tDbs6
   jt78dhjSOUs212yZYBhlAq9Z4d9bFf/5nYSGbMt2myfL4MxXbPyDVUsAs
   dF3O5RdNut0kuUIfTnLYcHislXCqcQ2wdiSHqGrXQ5hCq2ff2JRQrWj3t
   n4aShkzjEQ1Fq9nvahKbumH8VjwWTet662tUoBn06WzRzLMUZYIDqXyYr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230289523"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="230289523"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 19:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="483062861"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 19:06:56 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Myers <ncm@cantrip.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Remove unnecessary exported symbol
Date:   Fri, 11 Feb 2022 11:05:31 +0800
Message-Id: <20220211030531.2398789-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
References: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
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

The exported symbol intel_iommu_gfx_mapped is not used anywhere in the
tree. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h | 1 -
 drivers/iommu/intel/iommu.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2f8a4517c929..b8b8be58cb6b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -789,7 +789,6 @@ extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
-extern int intel_iommu_gfx_mapped;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4b06f2f365bd..88a53140c7f1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -311,9 +311,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-int intel_iommu_gfx_mapped;
-EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
-
 static DEFINE_XARRAY_ALLOC(device_domain_array);
 
 /* Convert device source ID into the index of device_domain_array. */
@@ -4070,9 +4067,6 @@ int __init intel_iommu_init(void)
 	if (list_empty(&dmar_satc_units))
 		pr_info("No SATC found\n");
 
-	if (dmar_map_gfx)
-		intel_iommu_gfx_mapped = 1;
-
 	init_no_remapping_devices();
 
 	ret = init_dmars();
-- 
2.25.1

