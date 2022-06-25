Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2455AA3A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiFYM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiFYM4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:56:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F7D1836D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656161805; x=1687697805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ln3n9F0ShlVuPAtczPL0XqN7vo4FAVJWYWhIOXlcAvo=;
  b=JftxZ00V2DWnM9+NwEkhKBe93JCiKoI9ERJ7m96uIXaTGPAN/q2zxHFw
   yt0LzbaZq7w0Yv/U2Zr51e/xMiEcKNoFoVXy/PdPq8vD8BA+CgjiB41y6
   pkOpN5eyJJuW0JVZU31N71WIEmgsTLycZFLfSN8sQpVliyhd7nel7f2cj
   cuLAhAV+TbbsEJEpmbTVk9Y28q/mMq3hqTH5VYrFcaLhCRR5C05cRZJJN
   s8ktjLDOwW8qIiWxn3cDobN0wjzeF5L1WYOfpFbZJ20a6L0urDpfQl/Mx
   Vu0tZaBvRsfMTttFGlhva9SFG+fPrw2CmBDKDrWIWhMqmIWksGb5npidw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278727999"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="278727999"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="586890402"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:42 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 5/6] iommu/vt-d: Remove global g_iommus array
Date:   Sat, 25 Jun 2022 20:52:03 +0800
Message-Id: <20220625125204.2199437-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
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

The g_iommus is not used anywhere. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 42 -------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f6d7055cffd7..9a284394b2c5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -126,9 +126,6 @@ static inline unsigned long virt_to_dma_pfn(void *p)
 	return page_to_dma_pfn(virt_to_page(p));
 }
 
-/* global iommu list, set NULL for ignored DMAR units */
-static struct intel_iommu **g_iommus;
-
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
@@ -287,9 +284,6 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-/* bitmap for indexing intel_iommus */
-static int g_num_of_iommus;
-
 static void dmar_remove_one_dev_info(struct device *dev);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -1694,7 +1688,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		iommu->domain_ids = NULL;
 	}
 
-	g_iommus[iommu->seq_id] = NULL;
 	iommu->flags &= ~VTD_FLAG_IOMMU_PROBED;
 
 	/* free context mapping */
@@ -2899,36 +2892,6 @@ static int __init init_dmars(void)
 	struct intel_iommu *iommu;
 	int ret;
 
-	/*
-	 * for each drhd
-	 *    allocate root
-	 *    initialize and program root entry to not present
-	 * endfor
-	 */
-	for_each_drhd_unit(drhd) {
-		/*
-		 * lock not needed as this is only incremented in the single
-		 * threaded kernel __init code path all other access are read
-		 * only
-		 */
-		if (g_num_of_iommus < DMAR_UNITS_SUPPORTED) {
-			g_num_of_iommus++;
-			continue;
-		}
-		pr_err_once("Exceeded %d IOMMUs\n", DMAR_UNITS_SUPPORTED);
-	}
-
-	/* Preallocate enough resources for IOMMU hot-addition */
-	if (g_num_of_iommus < DMAR_UNITS_SUPPORTED)
-		g_num_of_iommus = DMAR_UNITS_SUPPORTED;
-
-	g_iommus = kcalloc(g_num_of_iommus, sizeof(struct intel_iommu *),
-			GFP_KERNEL);
-	if (!g_iommus) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
 	ret = intel_cap_audit(CAP_AUDIT_STATIC_DMAR, NULL);
 	if (ret)
 		goto free_iommu;
@@ -2951,7 +2914,6 @@ static int __init init_dmars(void)
 						   intel_pasid_max_id);
 		}
 
-		g_iommus[iommu->seq_id] = iommu;
 		iommu->flags |= VTD_FLAG_IOMMU_PROBED;
 
 		intel_iommu_init_qi(iommu);
@@ -3079,9 +3041,6 @@ static int __init init_dmars(void)
 		free_dmar_iommu(iommu);
 	}
 
-	kfree(g_iommus);
-
-error:
 	return ret;
 }
 
@@ -3488,7 +3447,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
 
-	g_iommus[iommu->seq_id] = iommu;
 	iommu->flags |= VTD_FLAG_IOMMU_PROBED;
 	ret = iommu_init_domains(iommu);
 	if (ret == 0)
-- 
2.25.1

