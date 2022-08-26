Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA175A24F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbiHZJvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbiHZJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:50:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96E9D4C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661507457; x=1693043457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FyBesxBopP4WUfvr9s3m3ayI6JGta6ovjzfVKeQey/k=;
  b=Xw+8eFb4Mea5wTGwKUiBXjn744PlhBFiPLz7tX0DwyF3EHR4uYma7qkp
   +iIchvp4dUOSafZ8/T2vZDphzAEE/IfVh+SRPVBWqJYReeWeslIGGSRba
   1m51n3ze6slXiYMvdczGXoVszN8GcfUT+BcGWhtBekit2dlCFBBVYtz2V
   qSspZHKHbfjAf1qMSMbF69rEmAWSfM218offUZYCvR2tRxNLUi4x8w26G
   fAnFrVMcs/5IvZklNWdvB+qWaDihLmd4uG9Dm+KCiB8aFc5Mz/Uxn163N
   rfR0dwFmFTUNhsxSXy5gqYdumig4a67lQZxMXxw/0rBttZ7OSzPh0k7ZA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="358436497"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="358436497"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 02:50:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671399096"
Received: from spr.sh.intel.com ([10.239.53.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 02:50:55 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Chao Gao <chao.gao@intel.com>
Subject: [PATCH] swiotlb: fix a typo
Date:   Fri, 26 Aug 2022 17:50:46 +0800
Message-Id: <20220826095046.880626-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"overwirte" isn't a word. It should be "overwrite".

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
BTW, I am wondering if copying the original buffer to the tlb buffer
unconditionally will leak the original buffer to the VMM, especially
when VMM isn't trusted e.g., by confidential VMs. Would it be better
to zero the tlb buffer for dir == DMA_FROM_DEVICE?

 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..f67e5f50ee3c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -765,7 +765,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	/*
 	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
 	 * to the tlb buffer, if we knew for sure the device will
-	 * overwirte the entire current content. But we don't. Thus
+	 * overwrite the entire current content. But we don't. Thus
 	 * unconditional bounce may prevent leaking swiotlb content (i.e.
 	 * kernel memory) to user-space.
 	 */
-- 
2.25.1

