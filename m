Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7E56134F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiF3Hd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiF3Hd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:33:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2133334B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656574406; x=1688110406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yS4Suwf7GI6LhylNscWfzZ0ukkPLH++SXvgQgtpNGaQ=;
  b=OlzD+6hY0HhiFHVXz3+edKtKH/6Ai6+DJiKdUKmeJ1QiwyH55DGWZwKg
   7/UCM8akS0OMiHVmL9eUBNefmxOE6J4cFdzNZOCLv1mwbyCSz2J8VtoQd
   Ci8G4dLZYdLF5O0M9lXiF2Z46bA4xVDby8nLfgzO+kZ1k6zA3huUBVSdm
   kKIwZ/EaQSi6cD10RVvxBQ07mQODaZGNiVrJCNhETIgthS0R3zhHtdbmf
   SIGTiNUr3KNXhyxusjSZ/l7l4pJry2NbVZn+X9wQsQoEZ/WTrdaRTIruM
   WTX4NIjxfdw/0cY/+8tAcJdc/LneM7PbcEtx+EhhlZMqzUgD3d9Q/8hQY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="343960417"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="343960417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 00:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="680866208"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2022 00:33:05 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Date:   Thu, 30 Jun 2022 15:33:04 +0800
Message-Id: <20220630073304.26945-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

And in some exstreme case, the memory wasted can trigger OOM as
reported in 2019 on a crash kernel with 256 MB memory [1].

  [    4.319253] iommu: Adding device 0000:06:00.2 to group 5
  [    4.325869] iommu: Adding device 0000:20:01.0 to group 15
  [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
  [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
  [    4.350251] swapper/0 cpuset=/ mems_allowed=0
  [    4.354618] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.57.mx64.282 #1
  [    4.355612] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.3 06/25/2019
  [    4.355612] Call Trace:
  [    4.355612]  dump_stack+0x46/0x5b
  [    4.355612]  dump_header+0x6b/0x289
  [    4.355612]  out_of_memory+0x470/0x4c0
  [    4.355612]  __alloc_pages_nodemask+0x970/0x1030
  [    4.355612]  cache_grow_begin+0x7d/0x520
  [    4.355612]  fallback_alloc+0x148/0x200
  [    4.355612]  kmem_cache_alloc_trace+0xac/0x1f0
  [    4.355612]  init_iova_domain+0x112/0x170
  [    4.355612]  amd_iommu_domain_alloc+0x138/0x1a0
  [    4.355612]  iommu_group_get_for_dev+0xc4/0x1a0
  [    4.355612]  amd_iommu_add_device+0x13a/0x610
  [    4.355612]  add_iommu_group+0x20/0x30
  [    4.355612]  bus_for_each_dev+0x76/0xc0
  [    4.355612]  bus_set_iommu+0xb6/0xf0
  [    4.355612]  amd_iommu_init_api+0x112/0x132
  [    4.355612]  state_next+0xfb1/0x1165
  [    4.355612]  amd_iommu_init+0x1f/0x67
  [    4.355612]  pci_iommu_init+0x16/0x3f
  ...
  [    4.670295] Unreclaimable slab info:
  ...
  [    4.857565] kmalloc-2048           59164KB      59164KB

Change IOVA_MAG_SIZE from 128 to 127 to make size of 'iova_magazine'
1024 bytes so that no memory will be wasted.

[1]. https://lkml.org/lkml/2019/8/12/266

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
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
+ * assure size of 'iova_magzine' to be 1024 bytes, so that no memory
+ * will be wasted.
+ */
+#define IOVA_MAG_SIZE 127
 #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_magazine {
-- 
2.27.0

