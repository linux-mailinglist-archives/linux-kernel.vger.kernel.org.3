Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4D575F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiGOKpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGOKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:45:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0059182FA0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657881945; x=1689417945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7hPfTa7r6+uGVc7oEBGFyFfVeXCuCyqHlJT/PvYkT3c=;
  b=DD9MlWRfUhrglelPZxI3mcg0maTKBlQfs6U4axLs+QogRCcSUyIPEpI+
   Uwi5NFHlLlX07Teg/vIbCX8ZZZ21tFIumY1t1sMK3J3lf5VLjy3C+Blev
   OX/kYKvaLbpLliRBvgICDr0jimld9ym2PiYVI/b3NFCYnVTmthuEwboFm
   w4CBs0YK1y1zUysGt1zQ/AUoatvPgFvl8oTesKW+Gay2g2awVlQzeozsc
   s2mjQXsLe9fGYmR/dRqq9uX0DCkfTLkJ67UaPzT1sXrhMBE0PktyQelKW
   hbErS3xIVOeG9DpE8824qkvQ44rY794zUoTmusjKucumb1hT76H/ZGPdP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286500351"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286500351"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:45:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="654287091"
Received: from spr.sh.intel.com ([10.239.53.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:45:42 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 0/3] Small fixes for swiotlb
Date:   Fri, 15 Jul 2022 18:45:32 +0800
Message-Id: <20220715104535.1053907-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

