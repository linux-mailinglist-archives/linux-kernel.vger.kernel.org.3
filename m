Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836E7520DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiEJGYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiEJGYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:24:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB25DF5F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652163649; x=1683699649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UMoOuGqNBTp5BKUte75oUqeM8P736Bjhoh4LYu+1ej4=;
  b=c+TktfeW9h8B3jU/GhIs/pQw6efewm85f0AlLkcz7YTVFzoKDP5pBN5t
   K1w5bjTnVbcXncVCJEOTlBCdxo0NUaPnPnm8VNPNgZwzclX7yAhR9/an1
   izH/jjn3Gtjz5kFytfmAgI2GYV9mJHfFkUAvQfA/3lB31W1aKV3X4AKY0
   eM9FBBjNnJSQRmUrJVQ43HUY4IRUdLOVmUTEn+I4xdyPGTg6BgZYNsWOu
   J5mljaYjiiNi+oXPFIu3cqvfFpTwowNeQjGwWd/DyltkgYu0lzd7JF8ji
   k+v/MWtGR7B8WsY1hO8PA6L3fPerT/O2mVpYMsNK1K0Lq1DDV7pmG+dbC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="332312839"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="332312839"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="552636294"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:20:43 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 00/12] iommu: SVA and IOPF refactoring
Date:   Tue, 10 May 2022 14:17:26 +0800
Message-Id: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

The former part of this series refactors the IOMMU SVA code by assigning
an SVA type of iommu_domain to a shared virtual address and replacing
sva_bind/unbind iommu ops with attach/detach_dev_pasid domain ops.

The latter part changes the existing I/O page fault handling framework
from only serving SVA to a generic one. Any driver or component could
handle the I/O page faults for its domain in its own way by installing
an I/O page fault handler.

This series has been functionally tested on an x86 machine and compile
tested for other architectures.

This series is also available on github:
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v6

Please review and suggest.

Best regards,
baolu

Change log:
v6:
 - Refine the SVA basic data structures.
   Link: https://lore.kernel.org/linux-iommu/YnFv0ps0Ad8v+7uH@myrica/
 - Refine arm smmuv3 sva domain allocation.
 - Fix a possible lock issue.
   Link: https://lore.kernel.org/linux-iommu/YnFydE8j8l7Q4m+b@myrica/

v5:
 - https://lore.kernel.org/linux-iommu/20220502014842.991097-1-baolu.lu@linux.intel.com/
 - Address review comments from Jean-Philippe Brucker. Very appreciated!
 - Remove redundant pci aliases check in
   device_group_immutable_singleton().
 - Treat all buses exept PCI as static in immutable singleton check.
 - As the sva_bind/unbind() have already guaranteed sva domain free only
   after iopf_queue_flush_dev(), remove the unnecessary domain refcount.
 - Move domain get() out of the list iteration in iopf_handle_group().

v4:
 - https://lore.kernel.org/linux-iommu/20220421052121.3464100-1-baolu.lu@linux.intel.com/
 - Solve the overlap with another series and make this series
   self-contained.
 - No objection to the abstraction of data structure during v3 review.
   Hence remove the RFC subject prefix.
 - Refine the immutable singleton group code according to Kevin's
   comments.

v3:
 - https://lore.kernel.org/linux-iommu/20220410102443.294128-1-baolu.lu@linux.intel.com/
 - Rework iommu_group_singleton_lockdown() by adding a flag to the group
   that positively indicates the group can never have more than one
   member, even after hot plug.
 - Abstract the data structs used for iommu sva in a separated patches to
   make it easier for review.
 - I still keep the RFC prefix in this series as above two significant
   changes need at least another round review to be finalized.
 - Several misc refinements.

v2:
 - https://lore.kernel.org/linux-iommu/20220329053800.3049561-1-baolu.lu@linux.intel.com/
 - Add sva domain life cycle management to avoid race between unbind and
   page fault handling.
 - Use a single domain for each mm.
 - Return a single sva handler for the same binding.
 - Add a new helper to meet singleton group requirement.
 - Rework the SVA domain allocation for arm smmu v3 driver and move the
   pasid_bit initialization to device probe.
 - Drop the patch "iommu: Handle IO page faults directly".
 - Add mmget_not_zero(mm) in SVA page fault handler.

v1:
 - https://lore.kernel.org/linux-iommu/20220320064030.2936936-1-baolu.lu@linux.intel.com/
 - Initial post.

Dave Jiang (1):
  dmaengine: idxd: Separate user and kernel pasid enabling

Lu Baolu (11):
  iommu: Add pasid_bits field in struct dev_iommu
  iommu: Add attach/detach_dev_pasid domain ops
  iommu/sva: Basic data structures for SVA
  iommu/vt-d: Remove SVM_FLAG_SUPERVISOR_MODE support
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Prepare IOMMU domain for IOPF
  iommu: Per-domain I/O page fault handling
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-iommu.h                   |   9 +-
 include/linux/iommu.h                         |  99 +++++--
 drivers/dma/idxd/idxd.h                       |   6 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  19 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |   3 -
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/dma/idxd/init.c                       |  30 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 111 +++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  10 +-
 drivers/iommu/intel/iommu.c                   |  12 +-
 drivers/iommu/intel/svm.c                     | 146 ++++------
 drivers/iommu/io-pgfault.c                    |  73 +----
 drivers/iommu/iommu-sva-lib.c                 |  71 -----
 drivers/iommu/iommu-sva.c                     | 261 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 193 +++++++------
 drivers/iommu/Makefile                        |   2 +-
 16 files changed, 623 insertions(+), 426 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (91%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

