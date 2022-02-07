Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC904AC0F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389052AbiBGOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245404AbiBGOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:15:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1BFC0401C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644243320; x=1675779320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X/LK6sULWZKDmHlbv9YKIUivTejDy195l3r0gIsqar4=;
  b=SnWNApXlfVKTildmfVpd8bhywHhGt6RwDsQ/LHbcE7ddXCmsCpx5J6vQ
   15LcB0XQwfKWqimAriNPkemmSow19wDLCncKlfeYdubJpgYqFb+jEevHl
   P8pYE51x6KKbV53n+ziFLShfV3x/xN1hrSv8JLvWGty3071SWvoC0G7Gw
   +tgXOK169ciqIKPIYcAoH/2N7n4JRsSO+FqJAhhHNB4oUEExZosvEqwEx
   KMkAW02/Am+e3F3vWWQq+0kPjTrAX+Tv1VG3yO6zM3yjwQQarl5w2NW3T
   hvxmo8SW9jZkzHOYF6YxqcVWRaa9VDqkHo1MX7XNtMGAUqmQEGdVqu7W6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="246313790"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="246313790"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:13:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="700477351"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2022 06:13:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B406A31D; Mon,  7 Feb 2022 16:13:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/dma: Use DMA ops setter instead of direct assignment
Date:   Mon,  7 Feb 2022 16:13:21 +0200
Message-Id: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DMA ops setter instead of direct assignment. Even we know that
this module doesn't perform access to the dma_ops member of struct device,
it's better to use setter to avoid potential problems in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of the latest codebase
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..b585a3fdbc56 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1482,7 +1482,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	if (iommu_is_dma_domain(domain)) {
 		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
-		dev->dma_ops = &iommu_dma_ops;
+		set_dma_ops(dev, &iommu_dma_ops);
 	}
 
 	return;
-- 
2.34.1

