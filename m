Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984625997E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347765AbiHSIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347282AbiHSIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:45:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52B2C6512
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660898752; x=1692434752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FEm9dKbVADtF2TWenZ71YMTaKEFg+RMwqpGYzA7uQ+I=;
  b=m1Q5shPs/lTD6toqpPb9hOSEf6XPOwqJkXJqL78XYGXPu9BZ1UqFGf84
   4rZkstrQSD5btZgtaRFJOu445NvP8xGpKmhsnTXS6Bz7frXzdLMHwJzWh
   WkcZPZLzHdye4T1S7RU7bayem8XPfmeJSWFHZwyQIN//YqLNxecmCNm8e
   WYbZjDEUnOo7qVdDJaottGt3CoPQ3zBQPhBcRoncCT565kkMgIGXZDduT
   2E39Z0qCy4uV6dkeh6FIVuu38gNY5kgPwMsqXTWlZ/s0UEMCBVM26/3sz
   ium68i2Wto0c0/skWlcEA2E5XXW+hpheZRL8WBmwf+u4+QHLjPnT53siX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="293756383"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="293756383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 01:45:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="668495401"
Received: from spr.sh.intel.com ([10.239.53.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 01:45:44 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        jxgao@google.com, konrad.wilk@oracle.com,
        Chao Gao <chao.gao@intel.com>
Subject: [PATCH v2] swiotlb: avoid potential left shift overflow
Date:   Fri, 19 Aug 2022 16:45:37 +0800
Message-Id: <20220819084537.52374-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second operand passed to slot_addr() is declared as int or unsigned int
in all call sites. The left-shift to get the offset of a slot can overflow
if swiotlb size is larger than 4G.

Convert the macro to an inline function and declare the second argument as
phys_addr_t to avoid the potential overflow.

Fixes: 26a7e094783d ("swiotlb: refactor swiotlb_tbl_map_single")
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 kernel/dma/swiotlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..41ea9fb3efe1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -579,7 +579,10 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	}
 }
 
-#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
+static inline phys_addr_t slot_addr(phys_addr_t start, phys_addr_t idx)
+{
+	return start + (idx << IO_TLB_SHIFT);
+}
 
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.

base-commit: 5c850d31880e00f063fa2a3746ba212c4bcc510f
-- 
2.25.1

