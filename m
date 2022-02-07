Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E54AB55E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiBGG55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357739AbiBGGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:44:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4CC043188
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216254; x=1675752254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIEVBkJiUooXYrTSIvBLA7Ijyh2xdWSYljcHg0SF2/8=;
  b=CYMTGuSZAy7BPqeglBCqaG3fZeJVxe9erk+C/u72W3O7nWwswXy2JaDV
   1NSEhXfU5WPBlVyN9icVaSTyqyvN/dTJkzwkLTCdlmN04T3f+gp6Vk81f
   ryHpz5cyEbKhMjB4aQLRit/upezwbgTgm4dMQGYgUnekFCrI2ZHRJl/6/
   AdAhaUGkuLcwsacAOrtzRhlIou52U1aOohJ8AI4blhIuv754b5h9Ok1Wg
   axDTx5gx9WPAZzaBSw/GuPLdvGk0I6H1lx9cMoJhLzLKKRPZ/Vzn9ZQc/
   90HPmft4tsLcsVIVopIzwTRq5cPDheSJl2v70kWSUHbgT54S1EG7VLPZp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273171167"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273171167"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525020245"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:09 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 04/10] iommu/vt-d: Remove iova_cache_get/put()
Date:   Mon,  7 Feb 2022 14:41:36 +0800
Message-Id: <20220207064142.1092846-5-baolu.lu@linux.intel.com>
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

These have been done in drivers/iommu/dma-iommu.c. Remove this duplicate
code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 583ec0fa4ac1..e8d58654361c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3348,9 +3348,6 @@ static inline int iommu_devinfo_cache_init(void)
 static int __init iommu_init_mempool(void)
 {
 	int ret;
-	ret = iova_cache_get();
-	if (ret)
-		return ret;
 
 	ret = iommu_domain_cache_init();
 	if (ret)
@@ -3362,7 +3359,6 @@ static int __init iommu_init_mempool(void)
 
 	kmem_cache_destroy(iommu_domain_cache);
 domain_error:
-	iova_cache_put();
 
 	return -ENOMEM;
 }
@@ -3371,7 +3367,6 @@ static void __init iommu_exit_mempool(void)
 {
 	kmem_cache_destroy(iommu_devinfo_cache);
 	kmem_cache_destroy(iommu_domain_cache);
-	iova_cache_put();
 }
 
 static void __init init_no_remapping_devices(void)
-- 
2.25.1

