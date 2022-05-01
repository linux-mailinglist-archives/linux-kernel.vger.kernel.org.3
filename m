Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401E8516418
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346109AbiEALbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345933AbiEALbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:31:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CDE6D393
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651404476; x=1682940476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Ab0hXVeJPQFxGivZE668c+wGDeZdo9BvU5oRO/0WGA=;
  b=nywwvmZWA6tyTi5d5M0IV66sqjT/MUglShO3T+BScG3xwJmWsAfh9UNM
   vEeka1OlSqbfq1DdwD9rRfUSIEmYzxMAbNNuqON9G7Hb79Al5mV6HFeM/
   EGOKogimeJ7Tfu2Jz2qwjqweBvXqAVGRqP+h1BqNgKtbPvAPtCJKh+vEs
   t0jduBysmfR99z+a7NZsHpqra+Yv+0e7qaeGnVsM6cHoqOKm5A1torPam
   bkiwFN73ejh+oqCXPPXL7FEVClFSFarIDR+626OuvrCuA4jJxd0+FSfzu
   75pO4V0WgoMDzJVSDSmi07FFPSAIZlo/iwnkKqYJzfvnY7PBPv7CaTUfC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="246912730"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="246912730"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 04:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="545114906"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2022 04:27:54 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/5] iommu/vt-d: Remove domain_update_iommu_snooping()
Date:   Sun,  1 May 2022 19:24:33 +0800
Message-Id: <20220501112434.874236-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501112434.874236-1-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
---
 drivers/iommu/intel/iommu.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3c1c228f9031..d5808495eb64 100644
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
@@ -3593,12 +3566,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
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

