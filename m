Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1606A53596F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbiE0Gex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245580AbiE0GeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8367F5D5F3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633245; x=1685169245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJ+JykYvRSOpRXDas5V4JVVkM1LJ8CN7dy1o4SqFzqA=;
  b=ellXRRXoMXsPrfHzg9IKMs6A9eV2S10vmXbs7MPlptlVepPRTkUMh3YV
   GT2KIFhrOQ3E51Dxh8LnlV0OWUtt1zcdG+0Cz25rU14ChmmgTMZu/nDZX
   M5hlsL+AXWZn/ewRk2iqpxe1eUcSCYGIRcXgYhVKocKCXdIgWwXc3ntC8
   J06J78Cybl7aOuBsIrONhQgc78ljP/sgVNcIS8voRF2jhvc5ikyNPjyuB
   bAWEqtASY8WbZfD8Rx29TC8th/pJNddqyYtfvrJ7Ej1vsqsDyJHT9nse6
   8PbrVuywDQ8m/BXDfOZsQ5G6lLFawpjE2oOVaDJdEWyn3gWrHv2BQTCQ5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044851"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044851"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:34:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688425"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:02 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 03/12] iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
Date:   Fri, 27 May 2022 14:30:10 +0800
Message-Id: <20220527063019.3112905-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The disable_dmar_iommu() is called when IOMMU initialzation fails or
the IOMMU is hot-removed from the system. In both cases, there is no
need to clear the IOMMU translation data structures for devices.

On the initialization path, the device probing only happens after the
IOMMU is initialized successfully, hence there're no translation data
structures.

On the hot-remove path, there is no real use case where the IOMMU is
hot-removed, but the devices that it manages are still alive in the
system. The translation data structures were torn down during device
release, hence there's no need to repeat it in IOMMU hot-remove path
either.

So, let's remove this unnecessary code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6549b09d7f32..25d4c5200526 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1715,24 +1715,9 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 
 static void disable_dmar_iommu(struct intel_iommu *iommu)
 {
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
-
 	if (!iommu->domain_ids)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
-		if (info->iommu != iommu)
-			continue;
-
-		if (!info->dev || !info->domain)
-			continue;
-
-		__dmar_remove_one_dev_info(info);
-	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
 }
-- 
2.25.1

