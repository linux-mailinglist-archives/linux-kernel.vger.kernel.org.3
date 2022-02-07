Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F144AB56E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiBGG6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357550AbiBGGoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:44:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246A9C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216248; x=1675752248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gN3LPgLC7pbNU4whlKOywLY30HbjfL0dlgHdNEPYbiE=;
  b=WdzNyDVxvIcYeLG/AE8OISq3HBw4/XL6wyaskn7ibPNvuNOSWlxdCZJB
   ZFohdG5uKpSW79bo9xNaB2R2ri1niPfNeV30dA7kO21Cg4wGncaWM0fJu
   YQWngFac7HuJohF2o28VdhILX69FSOvzxcEZra4gpGOeotOszZ0hV0a88
   n0/2PX8lG4yWsx8XsKmqF6MWyHs8+h9g8PE949zkNrpeWfk/QGanvSupd
   SAIFEj3QDbTdk2dTUSzNlLMnSeskpCiDwWVLur3ivfzb7NO0tBpKVGOzy
   TqdMupVMIO0T95DEMSxoQDRK2/Xh0aEdhkoiLYZKTg9C27gAE/xsscIpq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273171143"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273171143"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525020204"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:03 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 02/10] iommu/vt-d: Remove intel_iommu::domains
Date:   Mon,  7 Feb 2022 14:41:34 +0800
Message-Id: <20220207064142.1092846-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
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

The "domains" field of the intel_iommu structure keeps the mapping of
domain_id to dmar_domain. This information is not used anywhere. Remove
and cleanup it to avoid unnecessary memory consumption.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 68 ++-----------------------------------
 2 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 5cfda90b2cca..8c7591b5f3e2 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -578,7 +578,6 @@ struct intel_iommu {
 
 #ifdef CONFIG_INTEL_IOMMU
 	unsigned long 	*domain_ids; /* bitmap of domains */
-	struct dmar_domain ***domains; /* ptr to domains */
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3eb914798c18..438da5da301d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -422,36 +422,6 @@ __setup("intel_iommu=", intel_iommu_setup);
 static struct kmem_cache *iommu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
 
-static struct dmar_domain* get_iommu_domain(struct intel_iommu *iommu, u16 did)
-{
-	struct dmar_domain **domains;
-	int idx = did >> 8;
-
-	domains = iommu->domains[idx];
-	if (!domains)
-		return NULL;
-
-	return domains[did & 0xff];
-}
-
-static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
-			     struct dmar_domain *domain)
-{
-	struct dmar_domain **domains;
-	int idx = did >> 8;
-
-	if (!iommu->domains[idx]) {
-		size_t size = 256 * sizeof(struct dmar_domain *);
-		iommu->domains[idx] = kzalloc(size, GFP_ATOMIC);
-	}
-
-	domains = iommu->domains[idx];
-	if (WARN_ON(!domains))
-		return;
-	else
-		domains[did & 0xff] = domain;
-}
-
 void *alloc_pgtable_page(int node)
 {
 	struct page *page;
@@ -1718,8 +1688,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 						 DMA_TLB_DSI_FLUSH);
 
 		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(get_iommu_domain(iommu, did),
-					      0, MAX_AGAW_PFN_WIDTH);
+			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
 	}
 }
 
@@ -1782,7 +1751,6 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 static int iommu_init_domains(struct intel_iommu *iommu)
 {
 	u32 ndomains;
-	size_t size;
 
 	ndomains = cap_ndoms(iommu->cap);
 	pr_debug("%s: Number of Domains supported <%d>\n",
@@ -1794,24 +1762,6 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	if (!iommu->domain_ids)
 		return -ENOMEM;
 
-	size = (ALIGN(ndomains, 256) >> 8) * sizeof(struct dmar_domain **);
-	iommu->domains = kzalloc(size, GFP_KERNEL);
-
-	if (iommu->domains) {
-		size = 256 * sizeof(struct dmar_domain *);
-		iommu->domains[0] = kzalloc(size, GFP_KERNEL);
-	}
-
-	if (!iommu->domains || !iommu->domains[0]) {
-		pr_err("%s: Allocating domain array failed\n",
-		       iommu->name);
-		bitmap_free(iommu->domain_ids);
-		kfree(iommu->domains);
-		iommu->domain_ids = NULL;
-		iommu->domains    = NULL;
-		return -ENOMEM;
-	}
-
 	/*
 	 * If Caching mode is set, then invalid translations are tagged
 	 * with domain-id 0, hence we need to pre-allocate it. We also
@@ -1838,7 +1788,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 	struct device_domain_info *info, *tmp;
 	unsigned long flags;
 
-	if (!iommu->domains || !iommu->domain_ids)
+	if (!iommu->domain_ids)
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
@@ -1859,15 +1809,8 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 static void free_dmar_iommu(struct intel_iommu *iommu)
 {
-	if ((iommu->domains) && (iommu->domain_ids)) {
-		int elems = ALIGN(cap_ndoms(iommu->cap), 256) >> 8;
-		int i;
-
-		for (i = 0; i < elems; i++)
-			kfree(iommu->domains[i]);
-		kfree(iommu->domains);
+	if (iommu->domain_ids) {
 		bitmap_free(iommu->domain_ids);
-		iommu->domains = NULL;
 		iommu->domain_ids = NULL;
 	}
 
@@ -1945,11 +1888,8 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		}
 
 		set_bit(num, iommu->domain_ids);
-		set_iommu_domain(iommu, num, domain);
-
 		domain->iommu_did[iommu->seq_id] = num;
 		domain->nid			 = iommu->node;
-
 		domain_update_iommu_cap(domain);
 	}
 
@@ -1968,8 +1908,6 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
 		clear_bit(num, iommu->domain_ids);
-		set_iommu_domain(iommu, num, NULL);
-
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
-- 
2.25.1

