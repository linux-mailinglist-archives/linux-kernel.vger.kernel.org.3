Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4ED4B3FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiBNC65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:58:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbiBNC6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:58:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EFF50E02
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807526; x=1676343526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QdYhx9EO4AI/TCmCtlewK7xJRADcHuvAfbD9DIvtaeM=;
  b=G7z5sAY1p60znGdGivYfTS9rBdCBbnqOlXVKWYAMnykLGbWCoZBpU1qe
   m6/sWx/iZ+sStBzFnZFrLER7zhzPOoREM96zlZLx9C7rdrm05VOenueE/
   IDIpZK0t2ylvB4QSjGiBBW/1yHekWXVaa14NyxgjgXzD0H8gtuz3PAs2R
   78siVy/dtiuH66Ef1io97ndBEDeRtE8lG8Prg0iyFM7YOVWTX9cqMlBqX
   eePeSemOIOwxFUbfp36k6p5/exu8Ti3P9SAx7vbwia78kChjP7085Ke/c
   MVd3GSCfqa2uRzun0yZEcjtr/K/rwy7A1Y1+2ouclOSwxbO00ntxjzOOr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280418"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280418"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501514930"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:43 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 04/11] iommu/vt-d: Remove domain and devinfo mempool
Date:   Mon, 14 Feb 2022 10:56:57 +0800
Message-Id: <20220214025704.3184654-5-baolu.lu@linux.intel.com>
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

The domain and devinfo memory blocks are only allocated during device
probe and released during remove. There's no hot-path context, hence
no need for memory pools.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel/iommu.c | 104 ++----------------------------------
 1 file changed, 5 insertions(+), 99 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2b427bea3b..51db26d8606c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -452,9 +452,6 @@ static int __init intel_iommu_setup(char *str)
 }
 __setup("intel_iommu=", intel_iommu_setup);
 
-static struct kmem_cache *iommu_domain_cache;
-static struct kmem_cache *iommu_devinfo_cache;
-
 void *alloc_pgtable_page(int node)
 {
 	struct page *page;
@@ -471,26 +468,6 @@ void free_pgtable_page(void *vaddr)
 	free_page((unsigned long)vaddr);
 }
 
-static inline void *alloc_domain_mem(void)
-{
-	return kmem_cache_alloc(iommu_domain_cache, GFP_ATOMIC);
-}
-
-static void free_domain_mem(void *vaddr)
-{
-	kmem_cache_free(iommu_domain_cache, vaddr);
-}
-
-static inline void * alloc_devinfo_mem(void)
-{
-	return kmem_cache_alloc(iommu_devinfo_cache, GFP_ATOMIC);
-}
-
-static inline void free_devinfo_mem(void *vaddr)
-{
-	kmem_cache_free(iommu_devinfo_cache, vaddr);
-}
-
 static inline int domain_type_is_si(struct dmar_domain *domain)
 {
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
@@ -1885,11 +1862,10 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 {
 	struct dmar_domain *domain;
 
-	domain = alloc_domain_mem();
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	memset(domain, 0, sizeof(*domain));
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
@@ -1973,7 +1949,7 @@ static void domain_exit(struct dmar_domain *domain)
 		put_pages_list(&freelist);
 	}
 
-	free_domain_mem(domain);
+	kfree(domain);
 }
 
 /*
@@ -2558,7 +2534,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	unsigned long flags;
 	int ret;
 
-	info = alloc_devinfo_mem();
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return NULL;
 
@@ -2574,13 +2550,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		info->segment = pci_domain_nr(pdev->bus);
 	}
 
-	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
-	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
-	info->ats_qdep = 0;
 	info->dev = dev;
 	info->domain = domain;
 	info->iommu = iommu;
-	info->pasid_table = NULL;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -2610,7 +2582,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
-		free_devinfo_mem(info);
+		kfree(info);
 		return NULL;
 	}
 
@@ -3343,65 +3315,6 @@ static int __init init_dmars(void)
 	return ret;
 }
 
-static inline int iommu_domain_cache_init(void)
-{
-	int ret = 0;
-
-	iommu_domain_cache = kmem_cache_create("iommu_domain",
-					 sizeof(struct dmar_domain),
-					 0,
-					 SLAB_HWCACHE_ALIGN,
-
-					 NULL);
-	if (!iommu_domain_cache) {
-		pr_err("Couldn't create iommu_domain cache\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-
-static inline int iommu_devinfo_cache_init(void)
-{
-	int ret = 0;
-
-	iommu_devinfo_cache = kmem_cache_create("iommu_devinfo",
-					 sizeof(struct device_domain_info),
-					 0,
-					 SLAB_HWCACHE_ALIGN,
-					 NULL);
-	if (!iommu_devinfo_cache) {
-		pr_err("Couldn't create devinfo cache\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-
-static int __init iommu_init_mempool(void)
-{
-	int ret;
-
-	ret = iommu_domain_cache_init();
-	if (ret)
-		goto domain_error;
-
-	ret = iommu_devinfo_cache_init();
-	if (!ret)
-		return ret;
-
-	kmem_cache_destroy(iommu_domain_cache);
-domain_error:
-
-	return -ENOMEM;
-}
-
-static void __init iommu_exit_mempool(void)
-{
-	kmem_cache_destroy(iommu_devinfo_cache);
-	kmem_cache_destroy(iommu_domain_cache);
-}
-
 static void __init init_no_remapping_devices(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -4253,12 +4166,6 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
-	if (iommu_init_mempool()) {
-		if (force_on)
-			panic("tboot: Failed to initialize iommu memory\n");
-		return -ENOMEM;
-	}
-
 	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
 		if (force_on)
@@ -4379,7 +4286,6 @@ int __init intel_iommu_init(void)
 out_free_dmar:
 	intel_iommu_free_dmars();
 	up_write(&dmar_global_lock);
-	iommu_exit_mempool();
 	return ret;
 }
 
@@ -4436,7 +4342,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain_detach_iommu(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	free_devinfo_mem(info);
+	kfree(info);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
-- 
2.25.1

