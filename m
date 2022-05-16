Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC76F527BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbiEPCBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiEPCBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:01:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D73012ABF
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652666476; x=1684202476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qa54zhyfxnhTnC4Kw0P1pvvl+nghPS35LumwnwyE9CY=;
  b=GBfk1UrW+yF17M++TvdqhX4D7vYYM6DwZ/aHuDQn27d0ezIN+VPD+l9p
   T5eFBj/aQ0NRl9EqbQZTfYYQ/9Sxq0m35GGh2EvhNKqsKbBrk/AY2q62L
   QmXBlp1snMjLed5Tn04L0MPPH2IWKnCP4L7IUs2LYVU6maXqH1ib+SEZr
   XyElvJSKCBTg0xMUWX9K+10h4PzANScyyq0i4lZYy+bpwbfUbBCFsPnO9
   nE+l4Z95b/QWl2xNj8LQFoDwCu99yINqxvdSE0/TZavH/DIsbuj2D1Oi6
   eT9L+9kZjPK5xzxGlIpGhvYx9lQFf0KjB9bNPAuD1C5CTwU34vRJxf2/a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270658979"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="270658979"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 19:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="713172146"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2022 19:01:10 -0700
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
Subject: [PATCH 0/5] iommu: Make blocking domain static for group
Date:   Mon, 16 May 2022 09:57:54 +0800
Message-Id: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is a follow-up series after several discussions on blocking domain.
The latest discussion could be found here.

https://lore.kernel.org/linux-iommu/20220510140238.GD49344@nvidia.com/

This makes blocking domain static by:

- Each IOMMU driver is required to report domain ops for the blocking
  domain in its iommu_ops. Some IOMMU drivers support detaching domain
  by clearing an entry in the device context, while others not. To
  distinguish this capability among the IOMMU drivers, a flag is added
  to the domain ops.

- Similar to the default domain, each iommu group also has a static
  blokcing domain. The blocking domain is allocated when the first
  device joins the group and freed after the last device leaves.

- As .detach_dev equals to either setting the default domain or blocking
  domain to the device, this callback is not needed anymore. It is
  removed in this series.

Please kindly review and suggest. Very appreciated.

Best regards,
baolu 

Lu Baolu (5):
  iommu: Rename attach_dev to set_dev in domain ops
  iommu: Add blocking_domain_ops field in iommu_ops
  iommu: Make blocking domain static for iommu group
  iommu: Use blocking domain for empty domain attaching
  iommu: Remove .detach_dev from iommu domain ops

 include/linux/iommu.h                       |  13 ++-
 include/trace/events/iommu.h                |   7 --
 drivers/iommu/amd/iommu.c                   |  15 ++-
 drivers/iommu/apple-dart.c                  |  15 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |   5 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  15 ++-
 drivers/iommu/exynos-iommu.c                |  15 ++-
 drivers/iommu/fsl_pamu_domain.c             |  15 ++-
 drivers/iommu/intel/iommu.c                 |  15 ++-
 drivers/iommu/iommu-traces.c                |   1 -
 drivers/iommu/iommu.c                       | 122 ++++++++++----------
 drivers/iommu/ipmmu-vmsa.c                  |  15 ++-
 drivers/iommu/msm_iommu.c                   |  15 ++-
 drivers/iommu/mtk_iommu.c                   |  15 ++-
 drivers/iommu/mtk_iommu_v1.c                |  15 ++-
 drivers/iommu/omap-iommu.c                  |  15 ++-
 drivers/iommu/rockchip-iommu.c              |  15 ++-
 drivers/iommu/s390-iommu.c                  |  15 ++-
 drivers/iommu/sprd-iommu.c                  |  14 ++-
 drivers/iommu/sun50i-iommu.c                |  15 ++-
 drivers/iommu/tegra-gart.c                  |  15 ++-
 drivers/iommu/tegra-smmu.c                  |  15 ++-
 drivers/iommu/virtio-iommu.c                |   5 +-
 24 files changed, 299 insertions(+), 113 deletions(-)

-- 
2.25.1

