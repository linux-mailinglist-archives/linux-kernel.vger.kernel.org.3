Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B606C4EA733
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiC2Fl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiC2Flz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:41:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E929831935
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648532413; x=1680068413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tknkKS8klJn8jY0SolaOVo53TFN54BvuIWRpHY8TEAU=;
  b=gvJSPbAUKZAH4uddy/clx5OY0YiMbpn+fSZiHaijOJdGOLygJUYLTDGM
   bkYCpD3/vf0MKfNdFEj+W+ER1uXocV7Hd+mOPR06dJ7eeQd57lJIsV589
   OGo8wljnyzcUMXuXfip0fCAUJlhJ09xwRcgW6n2bUORFIhSwKX9WxvJMk
   ToPLasmTsqkYmuvesdUNW5iL/T6gQ2KAL+dMfHUcjTpg0opmexIi03Yu7
   wqblOnPiS2+HTDnShL76JeOdojdF/D76s9NL+fstMc0qNdqko8x+uMKwM
   HW+AzV28jJdkajVFsBiZ17pa7nW1aQjHWLlOvCVTO1eC9ASxN4n82az3b
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259136959"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259136959"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="694603557"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:10 -0700
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
Subject: [PATCH RFC v2 00/11] iommu: SVA and IOPF refactoring
Date:   Tue, 29 Mar 2022 13:37:49 +0800
Message-Id: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The former part of this series refactors the IOMMU SVA code by assigning
an SVA type of iommu_domain to a shared virtual address and replacing
sva_bind/unbind iommu ops with attach/detach_dev_pasid domain ops.

The latter part changes the existing I/O page fault handling framework
from only serving SVA to a generic one. Any driver or component could
handle the I/O page faults for its domain in its own way by installing
an I/O page fault handler.

This series overlaps with another series posted here [1]. For the
convenience of review, I included all relevant patches in this series.
We will solve the overlap problem later.

This series is also available on github here [2].

[1] https://lore.kernel.org/lkml/20220315050713.2000518-1-jacob.jun.pan@linux.intel.com/
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v2

Please help review and suggest.

Best regards,
baolu

Change log:
v1:
 - https://lore.kernel.org/linux-iommu/20220320064030.2936936-1-baolu.lu@linux.intel.com/
 - Initial post.

v2:
 - Add sva domain life cycle management to avoid race between unbind and
   page fault handling.
 - Use a single domain for each mm.
 - Return a single sva handler for the same binding.
 - Add a new helper to meet singleton group requirement.
 - Rework the SVA domain allocation for arm smmu v3 driver and move the
   pasid_bit initialization to device probe.
 - Drop the patch "iommu: Handle IO page faults directly".
 - Add mmget_not_zero(mm) in SVA page fault handler.

Lu Baolu (11):
  iommu: Add pasid_bits field in struct dev_iommu
  iommu: Add iommu_group_singleton_lockdown()
  iommu/sva: Add iommu_domain type for SVA
  iommu: Add attach/detach_dev_pasid domain ops
  iommu/vt-d: Remove SVM_FLAG_SUPERVISOR_MODE suport
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Per-domain I/O page fault handling
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-iommu.h                   |   5 +-
 include/linux/iommu.h                         | 107 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |  12 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  85 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  28 +-
 drivers/iommu/intel/iommu.c                   |  20 +-
 drivers/iommu/intel/svm.c                     | 135 +++-----
 drivers/iommu/io-pgfault.c                    |  72 +---
 drivers/iommu/iommu-sva-lib.c                 |  71 ----
 drivers/iommu/iommu-sva.c                     | 307 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 208 ++++++------
 drivers/iommu/Makefile                        |   2 +-
 13 files changed, 655 insertions(+), 422 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (80%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

