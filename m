Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C7564732
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiGCLo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGCLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:44:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D68638F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656848694; x=1688384694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=07o60MGLxH61MHNXX684N0GNY74w8HhuBYdXzf7xTYI=;
  b=I3v2qubrIijWH3bL/A/wOepVquLaY23Te9fCSvp+eJCxzTtwUmFfeoap
   T3SNtLLDtlPZ/LEV8O9SyScEjQWQgcPw9Kv634T7fSKnsSkhlu6tvzy5b
   8zvbj5z11eTTIw+vUVLIgvyc2MwOnqsDV3FhbMwl9E6CSSjkxcppVtyMU
   o/utpSWyu4NxeIUe+rclvhbWp0SLTIuhejKzI3f99Ag8rILON1eUgEfZl
   kiHZw5YcFJ2X9XMePTQhQLfRp8D3psEKfxOZcXn9T205RNazhNTjNKqTX
   ddCcZO2WRhQR9cUonVkwpD40Ohti9xr5rMK8ydD+vSdZQ3GrYtEWeM0ij
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="262733366"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="262733366"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 04:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="566845111"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2022 04:44:51 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Date:   Sun,  3 Jul 2022 19:44:50 +0800
Message-Id: <20220703114450.15184-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc will round up the request size to power of 2, and current
iova_magazine's size is 1032 (1024+8) bytes, so each instance
allocated will get 2048 bytes from kmalloc, causing around 1KB
waste.

Change IOVA_MAG_SIZE from 128 to 127 to make size of 'iova_magazine'
1024 bytes so that no memory will be wasted.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
Changelog:
  
  since v1:
    * update commit log per the comments from Robin and John 

 drivers/iommu/iova.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index db77aa675145b..27634ddd9b904 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -614,7 +614,12 @@ EXPORT_SYMBOL_GPL(reserve_iova);
  * dynamic size tuning described in the paper.
  */
 
-#define IOVA_MAG_SIZE 128
+/*
+ * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
+ * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
+ * will be wasted.
+ */
+#define IOVA_MAG_SIZE 127
 #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_magazine {
-- 
2.27.0

