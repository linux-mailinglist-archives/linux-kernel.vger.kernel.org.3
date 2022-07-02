Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3173C563DA9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 04:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiGBCAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 22:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBCAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 22:00:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B037AA4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 19:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656727236; x=1688263236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UQ8rm6he44UkqobDuw9OLVJ2BgIRmbGPjiGXkEH/j+k=;
  b=M5xLRIGGLquxL9JZdT5selxBfp0Zun0NZFs5OrpoOxIw27y51JNaLhsL
   38lUjJslvIgx2yt8CVjiZDDCWgyH/ZaMMPIDnwXACNDBD+d3KBo/NMroV
   1akYCG+iWSr97JJeM0Zoxw6fCKz8F9MxoJyu/qhOQJ5sfbglPkpvIw1/b
   45S5DV6+VUckPuuQT/H/nlLwCuIwhEM+wyQcxgTSZbB25nudOIBG9cJqW
   dbzWO20/P/6EIoc7MAc2CsI9OdhomKWFDniaRwje7jREnlyNER0uvZadt
   PzeTcpmDuavglYoqk4BkCmGwKAithwp5zEuIipsvaaIEtkDQwBFyH97v1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="262573726"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="262573726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="589518271"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:00:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Date:   Sat,  2 Jul 2022 09:56:04 +0800
Message-Id: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is a follow-up series of changes proposed by this patch:

https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/

It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
the DMAR_UNITS_SUPPORTED to 1024.

This series is also available on github:

https://github.com/LuBaolu/intel-iommu/commits/reset-DMAR_UNITS_SUPPORTED-v2

Please help review and suggest.

Best regards,
baolu

Change log:

v2:
 - Set the right @max for ida_alloc_range() and return the right error
   when ida_alloc_range() returns failure.
 - Replace xa_store() with xa_cmpxchg().
 - Set domain->nid to NUMA_NO_NODE when domain is detached from an
   iommu.
 - Avoid adding a new VTD_FLAG_IOMMU_PROBED flag. Remove the duplicate
   check directly.

v1:
 - https://lore.kernel.org/lkml/20220625125204.2199437-1-baolu.lu@linux.intel.com/
 - Initial post.

Lu Baolu (6):
  iommu/vt-d: Remove unused domain_get_iommu()
  iommu/vt-d: Use IDA interface to manage iommu sequence id
  iommu/vt-d: Refactor iommu information of each domain
  iommu/vt-d: Remove unnecessary check in intel_iommu_add()
  iommu/vt-d: Remove global g_iommus array
  iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024

 include/linux/dmar.h        |   6 +-
 drivers/iommu/intel/iommu.h |  30 ++++--
 drivers/iommu/intel/dmar.c  |  35 ++-----
 drivers/iommu/intel/iommu.c | 189 ++++++++++++++----------------------
 drivers/iommu/intel/pasid.c |   2 +-
 drivers/iommu/intel/svm.c   |   2 +-
 6 files changed, 103 insertions(+), 161 deletions(-)

-- 
2.25.1

