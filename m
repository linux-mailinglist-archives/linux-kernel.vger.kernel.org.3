Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4914A4B3FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiBNC6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:58:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiBNC6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:58:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD250B17
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807517; x=1676343517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MLEjABaPQRpMPylojsaUggRqEABq92P6LcGDfuqAl7Y=;
  b=PVOwouWk+CM4BPzM551G0XLNuJUEq60rF2z1ikz/5L2j0omCiSFKa/1m
   pQTxGn12A2wbIUqhRQZiY9Y29/NgAEB82ygHhpRmQv+2NcT3ZMcASc5ip
   jT+gU0pvohonmpFjTPDPuXjE4LRxEV4q4yp3UPCbgvuYkL2LsaUYBX/ua
   m1xXDZOiPLaC146vXLn4K8g6Wyi4RBEzShidDcRc20axp+4J019D6LJe3
   5uTWrfaq4AJ9Gs4Xrv6LdqNcT5TSy0eU7NooIxOu0CCTlMTuop7cTWoOk
   JyF/+oqA6cwg0nu+wYJmmjRrw2eFdDZh0LRqCghz5nxPs3XX+Tj/33noF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280404"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280404"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501514901"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:34 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 01/11] iommu/vt-d: Remove intel_iommu::domains
Date:   Mon, 14 Feb 2022 10:56:54 +0800
Message-Id: <20220214025704.3184654-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "domains" field of the intel_iommu structure keeps the mapping of
domain_id to dmar_domain. This information is not used anywhere. Remove
and cleanup it to avoid unnecessary memory consumption.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index b549172e88ef..e3b04d5d87b0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -455,36 +455,6 @@ __setup("intel_iommu=", intel_iommu_setup);
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
@@ -1751,8 +1721,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 						 DMA_TLB_DSI_FLUSH);
 
 		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(get_iommu_domain(iommu, did),
-					      0, MAX_AGAW_PFN_WIDTH);
+			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
 	}
 }
 
@@ -1815,7 +1784,6 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 static int iommu_init_domains(struct intel_iommu *iommu)
 {
 	u32 ndomains;
-	size_t size;
 
 	ndomains = cap_ndoms(iommu->cap);
 	pr_debug("%s: Number of Domains supported <%d>\n",
@@ -1827,24 +1795,6 @@ static int iommu_init_domains(struct intel_iommu *iommu)
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
@@ -1871,7 +1821,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 	struct device_domain_info *info, *tmp;
 	unsigned long flags;
 
-	if (!iommu->domains || !iommu->domain_ids)
+	if (!iommu->domain_ids)
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
@@ -1892,15 +1842,8 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
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
 
@@ -1978,11 +1921,8 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		}
 
 		set_bit(num, iommu->domain_ids);
-		set_iommu_domain(iommu, num, domain);
-
 		domain->iommu_did[iommu->seq_id] = num;
 		domain->nid			 = iommu->node;
-
 		domain_update_iommu_cap(domain);
 	}
 
@@ -2001,8 +1941,6 @@ static void domain_detach_iommu(struct dmar_domain *domain,
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

