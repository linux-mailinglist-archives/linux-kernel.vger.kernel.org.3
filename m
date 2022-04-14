Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA656500DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbiDNMpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbiDNMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:45:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EC358C7C3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:42:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6569139F;
        Thu, 14 Apr 2022 05:42:47 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B932A3F70D;
        Thu, 14 Apr 2022 05:42:45 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] iommu: Retire bus_set_iommu()
Date:   Thu, 14 Apr 2022 13:42:29 +0100
Message-Id: <cover.1649935679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's another chapter in my saga of moving to per-instance IOMMU ops -
iommu_present() and iommu_capable() cleanups will be ongoing for another
cycle or two, while this one is at least self-contained within the
subsystem. The next steps after this are making iommu_domain_alloc()
instance-aware - which should finish the public API - and pulling the
fwnode/of_xlate bits into __iommu_probe_device(). And then making sense
of whatever's left :)

For ease of review here I split out individual driver patches based on
whether there was any non-trivial change or affect on control flow; the
straightforward deletions are all lumped together since the whole series
needs applying together either way, but I'm happy to split the final
patch up further if anyone would like.

Patch #3 for AMD is based on Mario's SWIOTLB patch here:

https://lore.kernel.org/linux-iommu/20220404204723.9767-1-mario.limonciello@amd.com/

since that wants merging first as fix material. The series is also based
contextually (but not functionally) on my device_iommu_capable() patches
here:

https://lore.kernel.org/linux-iommu/cover.1649089693.git.robin.murphy@arm.com/

since those are pretty much good to go now (I'll send a slightly-tweaked
final version once the iommu/core branch is open).

Thanks,
Robin.


Robin Murphy (13):
  iommu: Always register bus notifiers
  iommu: Move bus setup to IOMMU device registration
  iommu/amd: Clean up bus_set_iommu()
  iommu/arm-smmu: Clean up bus_set_iommu()
  iommu/arm-smmu-v3: Clean up bus_set_iommu()
  iommu/dart: Clean up bus_set_iommu()
  iommu/exynos: Clean up bus_set_iommu()
  iommu/ipmmu-vmsa: Clean up bus_set_iommu()
  iommu/mtk: Clean up bus_set_iommu()
  iommu/omap: Clean up bus_set_iommu()
  iommu/tegra-smmu: Clean up bus_set_iommu()
  iommu/virtio: Clean up bus_set_iommu()
  iommu: Clean up bus_set_iommu()

 drivers/iommu/amd/amd_iommu.h               |   1 -
 drivers/iommu/amd/init.c                    |   9 +-
 drivers/iommu/amd/iommu.c                   |  21 ----
 drivers/iommu/apple-dart.c                  |  30 +-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  53 +---------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  84 +--------------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   4 -
 drivers/iommu/exynos-iommu.c                |   9 --
 drivers/iommu/fsl_pamu_domain.c             |   4 -
 drivers/iommu/intel/iommu.c                 |   1 -
 drivers/iommu/iommu.c                       | 109 +++++++++-----------
 drivers/iommu/ipmmu-vmsa.c                  |  35 +------
 drivers/iommu/msm_iommu.c                   |   2 -
 drivers/iommu/mtk_iommu.c                   |  13 +--
 drivers/iommu/mtk_iommu_v1.c                |  13 +--
 drivers/iommu/omap-iommu.c                  |   6 --
 drivers/iommu/rockchip-iommu.c              |   2 -
 drivers/iommu/s390-iommu.c                  |   6 --
 drivers/iommu/sprd-iommu.c                  |   5 -
 drivers/iommu/sun50i-iommu.c                |   2 -
 drivers/iommu/tegra-smmu.c                  |  29 ++----
 drivers/iommu/virtio-iommu.c                |  24 -----
 include/linux/iommu.h                       |   1 -
 23 files changed, 62 insertions(+), 401 deletions(-)

-- 
2.28.0.dirty

