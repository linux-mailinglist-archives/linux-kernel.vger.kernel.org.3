Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634F563DAE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 04:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiGBCA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 22:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiGBCAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 22:00:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D106057248
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 19:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656727251; x=1688263251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CTgci0gtk4B8onuxHazyj9YA3lG/u654uE8PqymAGq8=;
  b=i7+0tn/0yndprTvOnpbsxJurSRsMETDZ2RElHGacwfxB2F7Xi/2ThB1y
   BV60Ho6gGwnbtq28NYS+FyAdDUYi82XK/gAEji0L42QPQA6qndMAscaQz
   oatKNq6057Vdtl9kA9IkirofDAFI4UosDR2qH3Qu/Ko24E101vcehgNmS
   3qn/6u/pHSvL14D3HsnEOF+ey3iOC3flxv4hA7TejSr2sW6rZ57tmCsHy
   O+Q8HLk2sxQHDXAagrn9kb1YtdJGrI45ZgAB+qK5KUKXcT65nFxB1SkPB
   ReD4FbV6OIIfmVozYGv7KnmB/iMs5bYgaJM7rDwMEgIwsBOG2R0t9pNH/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="262573756"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="262573756"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="589518336"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:00:48 -0700
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
Subject: [PATCH v2 5/6] iommu/vt-d: Remove global g_iommus array
Date:   Sat,  2 Jul 2022 09:56:09 +0800
Message-Id: <20220702015610.2849494-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The g_iommus and g_num_of_iommus is not used anywhere. Remove them to
avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 44 -------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d79c48c5fc8c..73a48e2d4fbe 100644
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
@@ -1694,8 +1688,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		iommu->domain_ids = NULL;
 	}
 
-	g_iommus[iommu->seq_id] = NULL;
-
 	/* free context mapping */
 	free_context_table(iommu);
 
@@ -2901,36 +2893,6 @@ static int __init init_dmars(void)
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
@@ -2953,8 +2915,6 @@ static int __init init_dmars(void)
 						   intel_pasid_max_id);
 		}
 
-		g_iommus[iommu->seq_id] = iommu;
-
 		intel_iommu_init_qi(iommu);
 
 		ret = iommu_init_domains(iommu);
@@ -3080,9 +3040,6 @@ static int __init init_dmars(void)
 		free_dmar_iommu(iommu);
 	}
 
-	kfree(g_iommus);
-
-error:
 	return ret;
 }
 
@@ -3486,7 +3443,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
 
-	g_iommus[iommu->seq_id] = iommu;
 	ret = iommu_init_domains(iommu);
 	if (ret == 0)
 		ret = iommu_alloc_root_entry(iommu);
-- 
2.25.1

