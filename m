Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412751ED86
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiEHMmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiEHMma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:42:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB4FD19
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652013520; x=1683549520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dhHzVPtGCmtqjw7nHlmUc46+bVg8lesIZ0/A9YXT9us=;
  b=HQQNIojWPq/p+dUBGDPgUV5XC6tEtWn5wQsP9dbw6rQDYS6qlLQurpe6
   6S2s/6dX2YbDop4XfHductYCZr1wDVHCIFwgaK+2WM7C6MwMTOEj3Uk0a
   z8wZ9sOYDngxMZb1gWEIMZIcxW9KWQUcAe5D8D6s+rbzG+KkmdErpkXRK
   HuUFPBQzz/2iYlV6K8dTldA61zm5l4ZyV5jctcH9z2+A3cUt2t31PEpLz
   EVE90VgcykxZtJF14JYMX4v1Xar+z13kFCDxdPjgU+lCFgKQpYbuR1lpz
   S4t/YWPx04tC1ULQ9dsbV5/WQFrxjl+cOiFiAz541iL9IlLCOxlePFX66
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="267674811"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="267674811"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 05:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="710143749"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2022 05:38:38 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 3/4] iommu/vt-d: Remove domain_update_iommu_snooping()
Date:   Sun,  8 May 2022 20:35:24 +0800
Message-Id: <20220508123525.1973626-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
References: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
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

The IOMMU force snooping capability is not required to be consistent
among all the IOMMUs anymore. Remove force snooping capability check
in the IOMMU hot-add path and domain_update_iommu_snooping() becomes
a dead code now.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 048ebfbd5fcb..444d51a18c93 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -533,33 +533,6 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 	rcu_read_unlock();
 }
 
-static bool domain_update_iommu_snooping(struct intel_iommu *skip)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool ret = true;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (iommu != skip) {
-			/*
-			 * If the hardware is operating in the scalable mode,
-			 * the snooping control is always supported since we
-			 * always set PASID-table-entry.PGSNP bit if the domain
-			 * is managed outside (UNMANAGED).
-			 */
-			if (!sm_supported(iommu) &&
-			    !ecap_sc_support(iommu->ecap)) {
-				ret = false;
-				break;
-			}
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static int domain_update_iommu_superpage(struct dmar_domain *domain,
 					 struct intel_iommu *skip)
 {
@@ -3606,12 +3579,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 			iommu->name);
 		return -ENXIO;
 	}
-	if (!ecap_sc_support(iommu->ecap) &&
-	    domain_update_iommu_snooping(iommu)) {
-		pr_warn("%s: Doesn't support snooping.\n",
-			iommu->name);
-		return -ENXIO;
-	}
+
 	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
 	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
 		pr_warn("%s: Doesn't support large page.\n",
-- 
2.25.1

