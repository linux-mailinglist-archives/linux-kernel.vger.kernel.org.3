Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3331E567537
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiGERIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGERIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:08:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0178E1A838;
        Tue,  5 Jul 2022 10:08:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE246152B;
        Tue,  5 Jul 2022 10:08:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED1E73F66F;
        Tue,  5 Jul 2022 10:08:41 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] iommu: Retire bus_set_iommu()
Date:   Tue,  5 Jul 2022 18:08:23 +0100
Message-Id: <cover.1657034827.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: https://lore.kernel.org/linux-iommu/cover.1650890638.git.robin.murphy@arm.com/

Hi all,

Here's v3, now with working x86! Having finally made sense of how I
broke Intel, I've given AMD the same fix by inspection. I'm still not
100% sure about s390, but it looks like it should probably be OK since
it seems to register an IOMMU instance for each PCI device (?!) before
disappearing into PCI hotplug code, wherein I assume we should never see
a PCI device appear without its IOMMU already registered.

Otherwise, the only other updates are hooking up the new host1x context
bus (noting that it now takes all of 4 lines to support a whole new bus,
yay!), and a slight tweak to make sure we keep rejecting registration of
conflicting iommu_ops rather than needlessly change that just yet.

Thanks,
Robin.


Robin Murphy (15):
  iommu/vt-d: Handle race between registration and device probe
  iommu/amd: Handle race between registration and device probe
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
 drivers/iommu/amd/iommu.c                   |  25 +----
 drivers/iommu/apple-dart.c                  |  30 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  53 +--------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  84 +-------------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   4 -
 drivers/iommu/exynos-iommu.c                |   9 --
 drivers/iommu/fsl_pamu_domain.c             |   4 -
 drivers/iommu/intel/iommu.c                 |   4 +-
 drivers/iommu/iommu.c                       | 117 +++++++++-----------
 drivers/iommu/ipmmu-vmsa.c                  |  35 +-----
 drivers/iommu/msm_iommu.c                   |   2 -
 drivers/iommu/mtk_iommu.c                   |  24 +---
 drivers/iommu/mtk_iommu_v1.c                |  13 +--
 drivers/iommu/omap-iommu.c                  |   6 -
 drivers/iommu/rockchip-iommu.c              |   2 -
 drivers/iommu/s390-iommu.c                  |   6 -
 drivers/iommu/sprd-iommu.c                  |   5 -
 drivers/iommu/sun50i-iommu.c                |   2 -
 drivers/iommu/tegra-smmu.c                  |  29 +----
 drivers/iommu/virtio-iommu.c                |  25 -----
 include/linux/iommu.h                       |   1 -
 23 files changed, 75 insertions(+), 415 deletions(-)

-- 
2.36.1.dirty

