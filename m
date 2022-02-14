Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B7C4B3F21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiBNB6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:58:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbiBNB55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:57:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1EB5418B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644803871; x=1676339871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QPnDGZYqEL8lzJ/a++F6WRyRimejmxMhswRnFUkhPWs=;
  b=WSPMZGIabZWMFHlVT0bXqDOloZbakjBMz2uAwQmUZ1a8pkCEHCl4EA65
   2lq/xaBiL1JL4BMFhdu0hUAzdp80k7VKYFUHtactWm6kYDqWO/Z39/XTf
   8ecOZAWriP9g/lWs9iof8RWiLEziAhp5Nq9QHCb2wrCx+xKM3W674gRET
   NEAnslPewixgU+UhGxmAcd7RQJZDYAT+M4okzJB+mo/WzmcpUg+Rvl7kp
   dAPrKB6IXV/WFKgtE00ijrGJYgNnzXBYO9QIxGAco6kIWhaQ3+XyJy1ZC
   +kth0qiwmNbJWhoGkLjtWGUNRY5mIrMvNnG2uXCjlWGr6FMaL7iaCu7nB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="248823700"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="248823700"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 17:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="680137286"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 17:57:47 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 05/10] iommu: Remove apply_resv_region
Date:   Mon, 14 Feb 2022 09:55:33 +0800
Message-Id: <20220214015538.2828933-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
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

The apply_resv_region callback in iommu_ops was introduced to reserve an
IOVA range in the given DMA domain when the IOMMU driver manages the IOVA
by itself. As all drivers converted to use dma-iommu in the core, there's
no driver using this anymore. Remove it to avoid dead code.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/iommu.h | 4 ----
 drivers/iommu/iommu.c | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9983a01373b2..9ffa2e88f3d0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -214,7 +214,6 @@ struct iommu_iotlb_gather {
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
- * @apply_resv_region: Temporary helper call-back for iova reserved ranges
  * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
@@ -268,9 +267,6 @@ struct iommu_ops {
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 	void (*put_resv_regions)(struct device *dev, struct list_head *list);
-	void (*apply_resv_region)(struct device *dev,
-				  struct iommu_domain *domain,
-				  struct iommu_resv_region *region);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ebaf561a70e..7cf073c56036 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -790,9 +790,6 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 		dma_addr_t start, end, addr;
 		size_t map_size = 0;
 
-		if (domain->ops->apply_resv_region)
-			domain->ops->apply_resv_region(dev, domain, entry);
-
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
-- 
2.25.1

