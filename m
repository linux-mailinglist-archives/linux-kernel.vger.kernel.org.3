Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CF04E6170
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349379AbiCXKGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346261AbiCXKF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:05:58 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF4A9F6CB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:04:25 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D7CB450C; Thu, 24 Mar 2022 11:04:22 +0100 (CET)
Date:   Thu, 24 Mar 2022 11:04:20 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.18
Message-ID: <YjxCJKNbtfcyV/6A@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wf2zxYnOXxQkTonL"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wf2zxYnOXxQkTonL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

there is a conflict this time when merging the IOMMU tree updates. It is
in drivers/iommu/intel/iommu.c and comes from the fact that the tip-tree
patched functions in that file which get removed with these updates. So
the merge resolution is to use the changes from the IOMMU tree. With
that in mind, here are the IOMMU changes for v5.18:

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.18

for you to fetch changes up to e17c6debd4b2d2d474074f83946f8c6522587566:

  Merge branches 'arm/mediatek', 'arm/msm', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into next (2022-03-08 12:21:31 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.18

Including:

	- IOMMU Core changes:
	  - Removal of aux domain related code as it is basically dead
	    and will be replaced by iommu-fd framework
	  - Split of iommu_ops to carry domain-specific call-backs
	    separatly
	  - Cleanup to remove useless ops->capable implementations
	  - Improve 32-bit free space estimate in iova allocator

	- Intel VT-d updates:
	  - Various cleanups of the driver
	  - Support for ATS of SoC-integrated devices listed in
	    ACPI/SATC table

	- ARM SMMU updates:
	  - Fix SMMUv3 soft lockup during continuous stream of events
	  - Fix error path for Qualcomm SMMU probe()
	  - Rework SMMU IRQ setup to prepare the ground for PMU support
	  - Minor cleanups and refactoring

	- AMD IOMMU driver:
	  - Some minor cleanups and error-handling fixes

	- Rockchip IOMMU driver:
	  - Use standard driver registration

	- MSM IOMMU driver:
	  - Minor cleanup and change to standard driver registration

	- Mediatek IOMMU driver:
	  - Fixes for IOTLB flushing logic

----------------------------------------------------------------
Andy Shevchenko (2):
      perf/smmuv3: Don't cast parameter in bit operations
      iommu/vt-d: Move intel_iommu_ops to header file

Christophe JAILLET (2):
      iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
      iommu/arm-smmu-v3: Simplify memory allocation

David Heidelberg (1):
      iommu/msm: Simplify with dev_err_probe()

Jiasheng Jiang (1):
      iommu/ipmmu-vmsa: Check for error num after setting mask

Joerg Roedel (3):
      Merge branch 'core' into x86/vt-d
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'arm/mediatek', 'arm/msm', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into next

John Garry (1):
      iommu/iova: Separate out rcache init

Lu Baolu (17):
      iommu/vt-d: Remove guest pasid related callbacks
      iommu: Remove guest pasid related interfaces and definitions
      iommu/vt-d: Remove aux-domain related callbacks
      iommu: Remove aux-domain related interfaces and iommu_ops
      iommu: Remove apply_resv_region
      drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
      iommu: Use right way to retrieve iommu_ops
      iommu: Remove unused argument in is_attach_deferred
      iommu: Split struct iommu_ops
      iommu/vt-d: Remove intel_iommu::domains
      iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
      iommu/vt-d: Remove iova_cache_get/put()
      iommu/vt-d: Remove domain and devinfo mempool
      iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
      iommu/vt-d: Remove unnecessary includes
      iommu/vt-d: Remove unnecessary prototypes
      iommu/vt-d: Fix indentation of goto labels

Marco Bonelli (1):
      iommu/vt-d: Add missing "__init" for rmrr_sanity_check()

Miaoqian Lin (1):
      iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe

Rafael J. Wysocki (1):
      iommu/vtd: Replace acpi_bus_get_device()

Robin Murphy (5):
      iommu: Remove trivial ops->capable implementations
      iommu/rockchip: : Use standard driver registration
      iommu/msm: Use standard driver registration
      iommu/iova: Improve 32-bit free space estimate
      iommu/arm-smmu: Account for PMU interrupts

Sebastian Reichel (1):
      iommu/mediatek: Always check runtime PM status in tlb flush range callback

Suravee Suthikulpanit (2):
      iommu/amd: Improve error handling for amd_iommu_init_pci
      iommu/amd: Improve amd_iommu_v2_exit()

Vasant Hegde (3):
      iommu/amd: Call memunmap in error path
      iommu/amd: Clean up function declarations
      iommu/amd: Remove unused struct fault.devid

Yian Chen (1):
      iommu/vt-d: Enable ATS for the devices in SATC table

Yong Wu (4):
      iommu/mediatek: Remove for_each_m4u in tlb_sync_all
      iommu/mediatek: Remove the power status checking in tlb flush all
      iommu/mediatek: Add tlb_lock in tlb_flush_all
      iommu/mediatek: Always tlb_flush_all when each PM resume

Yoshihiro Shimoda (2):
      dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779f0 support
      iommu/ipmmu-vmsa: Add support for R-Car Gen4

YueHaibing (1):
      iommu/vt-d: Remove unused function intel_svm_capable()

Zhou Guanghui (1):
      iommu/arm-smmu-v3: fix event handling soft lockup

 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   4 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |   2 +-
 drivers/iommu/amd/amd_iommu.h                      |   4 +-
 drivers/iommu/amd/init.c                           |  18 +-
 drivers/iommu/amd/iommu.c                          |  23 +-
 drivers/iommu/amd/iommu_v2.c                       |  37 +-
 drivers/iommu/apple-dart.c                         |  20 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  45 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 113 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   5 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  28 +-
 drivers/iommu/dma-iommu.c                          |   4 +
 drivers/iommu/exynos-iommu.c                       |  14 +-
 drivers/iommu/fsl_pamu_domain.c                    |  10 +-
 drivers/iommu/intel/debugfs.c                      |   6 +-
 drivers/iommu/intel/dmar.c                         |   5 +-
 drivers/iommu/intel/iommu.c                        | 999 +++------------------
 drivers/iommu/intel/pasid.c                        | 173 +---
 drivers/iommu/intel/pasid.h                        |   4 -
 drivers/iommu/intel/svm.c                          | 220 +----
 drivers/iommu/iommu.c                              | 339 +------
 drivers/iommu/iova.c                               |  78 +-
 drivers/iommu/ipmmu-vmsa.c                         |  32 +-
 drivers/iommu/msm_iommu.c                          |  74 +-
 drivers/iommu/mtk_iommu.c                          |  62 +-
 drivers/iommu/mtk_iommu_v1.c                       |  14 +-
 drivers/iommu/omap-iommu.c                         |  14 +-
 drivers/iommu/rockchip-iommu.c                     |  21 +-
 drivers/iommu/s390-iommu.c                         |  14 +-
 drivers/iommu/sprd-iommu.c                         |  18 +-
 drivers/iommu/sun50i-iommu.c                       |  18 +-
 drivers/iommu/tegra-gart.c                         |  24 +-
 drivers/iommu/tegra-smmu.c                         |  20 +-
 drivers/iommu/virtio-iommu.c                       |  14 +-
 drivers/perf/arm_smmuv3_pmu.c                      |   4 +-
 drivers/vdpa/vdpa_user/iova_domain.c               |  11 +
 include/linux/intel-iommu.h                        |  33 +-
 include/linux/intel-svm.h                          |  12 -
 include/linux/iommu.h                              | 181 ++--
 include/linux/iova.h                               |  15 +-
 include/uapi/linux/iommu.h                         | 181 ----
 41 files changed, 662 insertions(+), 2251 deletions(-)

Please pull.

Thanks,

	Joerg

--wf2zxYnOXxQkTonL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmI8QiAACgkQK/BELZcB
GuMstBAA2gx8tQIji33zBo7JG6ws1Fr6Lno5nXQkONomfRFl1rdcS7fCyHgC/3l9
Vk856uIGOdUBbv4zTtUUDSpftCx/aFkEDU8jfCLNVCZN163k2cLlfQNhqUdThGTg
Hm/lxXaId38+lg/mfBuhEAYeYi2+7SeKlQgkIZc8JXUvu+9xTnxpy3bGpyatcwGF
Wh8aZWVP0t9y9CJXxDaqF4SiIpq8Eu1CyWHy8FhHTVRDU6qTDAkCupxR9kPJ/HDg
0nEjryneZdtXXaI7/Nj/m8JNuENLoFra9sQtV2d26d6foYg19L5C1vuoIBNEds/Z
0odDSBBWv2gAHeoZMw5GiNOKYMbayECSQH7ip5BpLognxlGUS4/DTAw73jIuJdz3
F0cKt+oynNZyTcOo/QOPtsrr+ILtAb8jFyI2hnrcs/D2zqRqBDsmlWTD7zugR4iE
u9yDhHHsFJ5ZNrilBjDypyBVY2a8yxpxtOKc0Pk9IH1RDpegFq6Ha59CD9q4XFJ9
eDDWso131drIJXSsXRTJ9WYdz5GrruD0nPjZV+cOoD+iVb/rotA3/1elhdgKXkL6
fq3i2hiayRk1hjevuUeu1MQNxW0US/ZD44Lgltn4SDBXHrEVAtbyYHAgYVkfa9ZE
hPP4citd3hDpdip6Ejw+dHzNlmDxue1cPoGcdSNd9PGKQDP2sKM=
=cgDP
-----END PGP SIGNATURE-----

--wf2zxYnOXxQkTonL--
