Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE72577930
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiGRBQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGRBQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:16:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF99011823
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106984; x=1689642984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1WUb26eGG0rtceH20RMmEXVjO0dlju8oh9FxVP/TLrQ=;
  b=H+F0ULgCUI2ZWo9y0KoVbumjH5rkVEN6k1IB/V6IzB4Wfp+580z7+I6P
   Gs+0WuZfXmeZhUTwUjpxhS5WyWoYszv+UIMhi36fKEnlpDCmv9UCqV0UQ
   YsKeDgsrOD4m3DJfYSm6mXAiWbZqHvjHJDFQXb2klXdf9a0JJnWumMLir
   X51DhIlNwi5a53Bz01u56sTZV8AfmG3siSCvf5XL/qmIluwAkuUAR/1cD
   tJx8kcTZghRVRqwlNOz9siAd3TDc9Fu3CB1HY7EVDpJrZbo8RZ/JoFnRF
   xui0F32hMmEburC5XtJqw5IIBWxNUUC+eug9lDZfsGs+kJBBsGc3NOuLs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286127470"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="286127470"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624520457"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:22 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [RESEND PATCH 0/3] Small fixes for swiotlb
Date:   Mon, 18 Jul 2022 09:16:04 +0800
Message-Id: <20220718011608.106289-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend reason: use correct IOMMU mailing list.
---

They are found when I try to rebase my swiotlb optimizations onto the
latest dma-mapping tree.

Patch 1 is to remove unused fields.
Patch 2-3 are to fix a corner case that area size can be smaller than the
number of slots in a segment (128). Such small areas conflict with an
implication of the mechanism used to track free slots.

Chao Gao (3):
  swiotlb: remove unused fields in io_tlb_mem
  swiotlb: consolidate rounding up default_nslabs
  swiotlb: ensure a segment doesn't cross the area boundary

 include/linux/swiotlb.h |  5 -----
 kernel/dma/swiotlb.c    | 45 ++++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 23 deletions(-)

-- 
2.25.1

