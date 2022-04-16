Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A35036A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiDPMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiDPMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:36:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92655FE427
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650112417; x=1681648417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bLV46reasuOPuFLE2C3UtgPLXAur55KabjsunKbN5r0=;
  b=Y8SRLd1Kkr4zOjjXAyGjvRdtMmYtSqspLagYFdqMrNFNNTjVPDPXNG3F
   kpOr4GqYtpXg/6A9qpjwM1jf//gc0QdH26nny8cYh/QErZE1/NpmJirvd
   hpeWQnUiE4AzxbxOOUHts8CfeVt4Es9+8Knl4hFnwgKKoAKgQdX5u/146
   oSIVvgKSS+18geueBzfW+aA8PDua+FeWCyIQIEbnA59XGHnzqrFfKwkyh
   Al/SJlb6MJrKOOwsbb4a3oCqIV5tnvQs3EuI7USYU5Lmx9hvQUFG58D2V
   tdzr1ROLYYHeUFy19tIT6RGyH4kGRY1rlrksjNJTqxaCcisl482cTyWXk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243221104"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243221104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 05:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701332481"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:33:35 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/3] iommu/vt-d: Size Page Request Queue to avoid overflow condition
Date:   Sat, 16 Apr 2022 20:30:49 +0800
Message-Id: <20220416123049.879969-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416123049.879969-1-baolu.lu@linux.intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRQ overflow may cause I/O throughput congestion, resulting in unnecessary
degradation of IO performance. Appropriately increasing the length of PRQ
can greatly reduce the occurrence of PRQ overflow. The count of maximum
page requests that can be generated in parallel by a PCIe device is
statically defined in the Outstanding Page Request Capacity field of the
PCIe ATS configure space.

The new lenght of PRQ is calculated by summing up the value of Outstanding
Page Request Capacity register across all devices where Page Requests are
supported on the real PR-capable platfrom (Intel Sapphire Rapids). The
result is round to the nearest higher power of 2.

The PRQ length is also double sized as the VT-d IOMMU driver only updates
the Page Request Queue Head Register (PQH_REG) after processing the entire
queue.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-svm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index b3b125b332aa..207ef06ba3e1 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -9,7 +9,7 @@
 #define __INTEL_SVM_H__
 
 /* Page Request Queue depth */
-#define PRQ_ORDER	2
+#define PRQ_ORDER	4
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 #define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
 
-- 
2.25.1

