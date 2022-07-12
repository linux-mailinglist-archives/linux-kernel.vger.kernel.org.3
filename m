Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016CB570EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiGLANy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiGLANo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:13:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96BBC82
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584823; x=1689120823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uu6VWplyJC0WtS10OxO4TZ5+WvHrBkUqwlK1Uir6SUE=;
  b=GsWfNQKlVUQim7tR37G9NTMwiaJV7r6wV8AGsLtj/RVwCMlSv4Sach2v
   ho3DdQXmnrKs43vGcvGN3hKWfxMwyXdi5EvUS1y5jzLek988zcXZwz/Rz
   kZVFL8ebPFxvSQyxodMlqpRF2oJd3iNvt5zZgkj7k4GVNBOTjAOiULUjX
   E9X3nTerOD8/SFdIEtQLThvBp3VLj/z+ZOHhZVl2yUwt+l9KBTd55kyyf
   usnmtjQrt1x4kiqpwQOir880hiUVVyZ3J3t/deSPV3KTiRDo8o610lJoW
   xb7Q2aPiqxRn0giQa2B3en5rojDzZXrhBGMzs0dAlYBAlDRXUTLNaW+GE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284827883"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284827883"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445691"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:42 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/25] iommu/vt-d: Remove unnecessary exported symbol
Date:   Tue, 12 Jul 2022 08:08:46 +0800
Message-Id: <20220712000908.3431936-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-4-baolu.lu@linux.intel.com
---
 include/linux/intel-iommu.h | 1 -
 drivers/iommu/intel/iommu.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 5fcf89faa31a..4ebf3c4da45e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -787,7 +787,6 @@ extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
-extern int intel_iommu_gfx_mapped;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5c0dce78586a..6564af7ec0dd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -314,9 +314,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-int intel_iommu_gfx_mapped;
-EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
-
 DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
@@ -4093,9 +4090,6 @@ int __init intel_iommu_init(void)
 	if (list_empty(&dmar_satc_units))
 		pr_info("No SATC found\n");
 
-	if (dmar_map_gfx)
-		intel_iommu_gfx_mapped = 1;
-
 	init_no_remapping_devices();
 
 	ret = init_dmars();
-- 
2.25.1

