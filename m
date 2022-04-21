Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D625096C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384344AbiDUF1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiDUF04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:26:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E0DFAB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650518648; x=1682054648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SaHiXFdHM3HtwhvhX8+fUwtL6GYiG1g1clQUeijO6dA=;
  b=ZSiry4/P/YEBMSyInjloJGuav5vyI9XJhtBlwCWHGpWobwoHjtHICDVU
   t1kbVfFbgIZ5ow3wHTrwGB4g6vU1XOcDDdd91nrQeuikW/q63mxnzxK1Q
   vhRMblwFglXU27yWsiJh4TP62nIIv3aApTQME7wd2OBHNSuGX+XqPuMNj
   fSpymdFCwZZLysFR/Ilicsl6tZmTqhJRUS0JUZrP+AzONL0LL/kn4RzoM
   8Uw8QCdPVyoJ2OG/sCPtZ8ZYKLIGHyTYT2GGFi1WrziMN6KRR00vbBWYZ
   Ol+OfPs3pX9ksdUeLirJU6hnVXTj9qm7cCcSvO5QAbo7G5akSMDqMX5Of
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246135600"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="246135600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 22:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="702944078"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 22:24:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 00/12] iommu: SVA and IOPF refactoring
Date:   Thu, 21 Apr 2022 13:21:09 +0800
Message-Id: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v4

Please review and suggest.

Best regards,
baolu

Change log:
v4:
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

 include/linux/intel-iommu.h                   |   5 +-
 include/linux/iommu.h                         | 106 ++++--
 drivers/dma/idxd/idxd.h                       |   6 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |   8 +-
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/dma/idxd/init.c                       |  30 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  85 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  28 +-
 drivers/iommu/intel/iommu.c                   |  20 +-
 drivers/iommu/intel/svm.c                     | 135 +++----
 drivers/iommu/io-pgfault.c                    |  71 +---
 drivers/iommu/iommu-sva-lib.c                 |  71 ----
 drivers/iommu/iommu-sva.c                     | 331 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 219 +++++++-----
 drivers/iommu/Makefile                        |   2 +-
 16 files changed, 721 insertions(+), 425 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (88%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

