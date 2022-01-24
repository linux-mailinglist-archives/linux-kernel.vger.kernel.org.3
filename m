Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E898497924
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiAXHM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:12:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:53043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbiAXHMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643008345; x=1674544345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uz8nnVAfjL27meYo3jRGFNPYe6YwRskFjRkD9zDxGkk=;
  b=PLOTZlfaVHuODGNizVoOVJ6hs1w913xLxMsliPqI6aoGtsYMJE67s1fb
   IClVeAzo255FFNYGfCGuVI9D3FeYrZxq2RPCwwI5/3PFnMat/C7Sy+W7P
   oHxenuvBWqzDKX0SjwBYjEfz3W7WKhVmcPG0tIzyTbam6Q01ms1iuMgd/
   4m9DTJppqg5g9jHIVXdA1mz634PpnORya8mnssBg7qsn6H6wOGs6vHHVC
   Y96sfAdjJQ6oXJZQ18b15GUxIoVsKQy+yP88LvR8dI6Sj/tXyjH0FeL3l
   Yu1HZ25QfUZURjVpcJ0Tj4GZGn1wzp+8TFMP8SkWvFoQj5rD5YYfN9j1z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244814184"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244814184"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 23:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627387741"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2022 23:12:20 -0800
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
Subject: [PATCH 0/7] iommu cleanup and refactoring
Date:   Mon, 24 Jan 2022 15:10:55 +0800
Message-Id: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
domain-specific ops from iommu_ops to a new domain_ops. This makes an
iommu_domain self-contained and represent the abstraction of an I/O
translation table in the IOMMU subsystem. With different type of
iommu_domain providing different set of ops, it's easier to support more
types of I/O translation tables.

Please help to review and comment.

Best regards,
baolu

Lu Baolu (7):
  iommu/vt-d: Remove guest pasid related callbacks
  iommu: Remove guest pasid related interfaces and definitions
  iommu/vt-d: Remove aux-domain related callbacks
  iommu: Remove aux-domain related interfaces and iommu_ops
  drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
  iommu: Use right way to retrieve iommu_ops
  iommu: Add iommu_domain::domain_ops

 include/linux/intel-iommu.h                   |  27 -
 include/linux/intel-svm.h                     |  12 -
 include/linux/iommu.h                         | 174 ++----
 drivers/iommu/intel/pasid.h                   |   4 -
 include/uapi/linux/iommu.h                    | 181 ------
 .../drm/nouveau/nvkm/engine/device/tegra.c    |   2 +-
 drivers/iommu/amd/iommu.c                     |  21 +-
 drivers/iommu/apple-dart.c                    |  24 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  22 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  23 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  17 +-
 drivers/iommu/exynos-iommu.c                  |  17 +-
 drivers/iommu/fsl_pamu_domain.c               |  13 +-
 drivers/iommu/intel/debugfs.c                 |   3 +-
 drivers/iommu/intel/iommu.c                   | 542 +-----------------
 drivers/iommu/intel/pasid.c                   | 161 ------
 drivers/iommu/intel/svm.c                     | 209 -------
 drivers/iommu/iommu.c                         | 296 +---------
 drivers/iommu/ipmmu-vmsa.c                    |  21 +-
 drivers/iommu/msm_iommu.c                     |  17 +-
 drivers/iommu/mtk_iommu.c                     |  24 +-
 drivers/iommu/mtk_iommu_v1.c                  |  19 +-
 drivers/iommu/omap-iommu.c                    |  15 +-
 drivers/iommu/rockchip-iommu.c                |  17 +-
 drivers/iommu/s390-iommu.c                    |  15 +-
 drivers/iommu/sprd-iommu.c                    |  19 +-
 drivers/iommu/sun50i-iommu.c                  |  18 +-
 drivers/iommu/tegra-gart.c                    |  15 +-
 drivers/iommu/tegra-smmu.c                    |  16 +-
 drivers/iommu/virtio-iommu.c                  |  18 +-
 30 files changed, 331 insertions(+), 1631 deletions(-)

-- 
2.25.1

