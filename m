Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E979058AA4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiHELo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiHELo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:44:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D32C109
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659699893; x=1691235893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sZEpHu5Hv160J62kF1E13QN5XsUu6YK6w0fKKUO//14=;
  b=D5nOgsaubNe8Lz3HeA2eAuGTvC3+auaOaWOmkKjJlZDOObM+NuIFALF4
   2TFaqcz5IhgiBDTTzxSyI/4Dwp2iVYvfKGtydsdGcx83P+ZKbG3sleAuu
   mNRbfkIVZLs261r3MSSoIug/C75HCmw7+eSw3wUm+jrBuh6HyOp7XttMc
   LIC0DQuDLFXmrEgGgzTFuDd+bnLzNp6aJn1sXPej3taW3C17zCkRbAWcD
   IIUiH4gcyhwiB0xzNzLjSLfgPxnhZSvl0WmdKdCgla+WWUg2oUdmYLfj2
   HscFzZiCYCsqNJQg7/4WqbkpNuxdSkHix25ECBtNcozQVgm5tgSZpvq8k
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="354179982"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="354179982"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 04:44:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="600339623"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 04:44:50 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        konrad.wilk@oracle.com, jxgao@google.com,
        Chao Gao <chao.gao@intel.com>
Subject: [PATCH] swiotlb: avoid potential left shift overflow
Date:   Fri,  5 Aug 2022 19:44:38 +0800
Message-Id: <20220805114438.102085-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second operand passed to slot_addr() is declared as int or unsigned int
in all call sites. The left-shift to get the offset of a slot can overflow
if swiotlb size is larger than 4G.

Fixes: 26a7e094783d ("swiotlb: refactor swiotlb_tbl_map_single")
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..391b03b72978 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -579,7 +579,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	}
 }
 
-#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
+#define slot_addr(start, idx)	((start) + ((phys_addr_t)(idx) << IO_TLB_SHIFT))
 
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
-- 
2.25.1

