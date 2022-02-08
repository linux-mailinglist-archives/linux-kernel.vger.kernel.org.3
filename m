Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4054ACE5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbiBHBty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiBHB12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:27:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE33C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644283647; x=1675819647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pctv2HrISmh5p/g3/+6/TjHP74MB5JcG7fy+BWZgOv8=;
  b=QrOpYS0P1fZBC++yLauHpYF0qM2ddulq4BTGCVbkWBp+cFCly+liiU9M
   8qdWHVeE6xKPdT/MQoXOX2m0mFkiCxL+qQZEqRXV5jM02WwO5aMGH4AdU
   +fKalRZeXsFvr7x8pODHgkw8zfV2Wm7/6cqKvRRsO32FFPOM/zKBl/FQ4
   FEITtibdyhCkejdvxLWthtQHwDgAZ+LyhThnAwKIBuh4Kh81AiEyyb/L4
   7yWstEAn9Ci/1vIGYWiWFkijMBKtJPoo9aVe3n3Enhzf2YLErCEnUM1zR
   GNCKes/ntku9ZqwlFKovzZfPmaIbkBqAugUWhm49BVpZ3dgOv69pCRCfV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236251925"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="236251925"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:27:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677948771"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:27:21 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 00/10] iommu cleanup and refactoring
Date:   Tue,  8 Feb 2022 09:25:49 +0800
Message-Id: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The guest pasid and aux-domain related code are dead code in current
iommu subtree. As we have reached a consensus that all these features
should be based on the new iommufd framework (which is under active
development), the first part of this series removes and cleanups all
the dead code.

The second part of this series refactors the iommu_domain by moving all
domain specific ops from iommu_ops to a new iommu_domain_ops. This makes
iommu_domain self-contained and represent the abstraction of an I/O
translation table in the IOMMU subsystem. With different type of
iommu_domain providing different set of ops, it's easier to support more
types of I/O translation tables.

Please help to review and comment.

Best regards,
baolu

Change log:
v1: https://lore.kernel.org/linux-iommu/20220124071103.2097118-1-baolu.lu@linux.intel.com/

v2:
 - Remove apply_resv_region callback.
 - Remove domain argument from is_attach_deferred callback.
 - Convert all feasible instances of dev->bus->iommu_ops to dev_iommu_ops().
 - Add the default_domain_ops (default iommu_domain_ops) in iommu_ops to
   avoid big churn in dozens of iommu drivers.
 - We discussed removing pgsize_bitmap in struct iommu_ops and
   initialize the domain field in domain_alloc(). Considering that
   domain_alloc() is being refactored, let's wait until the new domain_alloc()
   comes.
 - Various code/description refinement.
 - This version of series is available on github:
   https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-ops-v2

Lu Baolu (10):
  iommu/vt-d: Remove guest pasid related callbacks
  iommu: Remove guest pasid related interfaces and definitions
  iommu/vt-d: Remove aux-domain related callbacks
  iommu: Remove aux-domain related interfaces and iommu_ops
  iommu: Remove apply_resv_region
  drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
  iommu: Use right way to retrieve iommu_ops
  iommu: Remove unused argument in is_attach_deferred
  iommu: Use dev_iommu_ops() helper
  iommu: Split struct iommu_ops

 include/linux/intel-iommu.h                   |  27 -
 include/linux/intel-svm.h                     |  12 -
 include/linux/iommu.h                         | 184 +++---
 drivers/iommu/amd/amd_iommu.h                 |   3 +-
 drivers/iommu/intel/pasid.h                   |   4 -
 include/uapi/linux/iommu.h                    | 181 ------
 .../drm/nouveau/nvkm/engine/device/tegra.c    |   2 +-
 drivers/iommu/amd/iommu.c                     |  23 +-
 drivers/iommu/amd/iommu_v2.c                  |   2 +-
 drivers/iommu/apple-dart.c                    |  20 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  18 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  20 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  18 +-
 drivers/iommu/exynos-iommu.c                  |  14 +-
 drivers/iommu/fsl_pamu_domain.c               |  10 +-
 drivers/iommu/intel/debugfs.c                 |   3 +-
 drivers/iommu/intel/iommu.c                   | 540 +-----------------
 drivers/iommu/intel/pasid.c                   | 161 ------
 drivers/iommu/intel/svm.c                     | 209 -------
 drivers/iommu/iommu.c                         | 326 ++---------
 drivers/iommu/ipmmu-vmsa.c                    |  18 +-
 drivers/iommu/msm_iommu.c                     |  30 +-
 drivers/iommu/mtk_iommu.c                     |  20 +-
 drivers/iommu/mtk_iommu_v1.c                  |  14 +-
 drivers/iommu/omap-iommu.c                    |  14 +-
 drivers/iommu/rockchip-iommu.c                |  14 +-
 drivers/iommu/s390-iommu.c                    |  14 +-
 drivers/iommu/sprd-iommu.c                    |  18 +-
 drivers/iommu/sun50i-iommu.c                  |  18 +-
 drivers/iommu/tegra-gart.c                    |  18 +-
 drivers/iommu/tegra-smmu.c                    |  14 +-
 drivers/iommu/virtio-iommu.c                  |  14 +-
 32 files changed, 303 insertions(+), 1680 deletions(-)

-- 
2.25.1

