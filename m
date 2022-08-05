Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C2F58A8E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbiHEJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiHEJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:38:16 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E40785A3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:38:12 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A2F5A814; Fri,  5 Aug 2022 11:38:10 +0200 (CEST)
Date:   Fri, 5 Aug 2022 11:38:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v5.20
Message-ID: <YuzlAT7RW1U36+ap@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kkANkCbkvbfH1mSU"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kkANkCbkvbfH1mSU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit e0dccc3b76fb35bb257b4118367a883073d7390e:

  Linux 5.19-rc8 (2022-07-24 13:26:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v5.20-or-v6.0

for you to fetch changes up to c10100a416c16b598bf5155e759307b34dac0d7d:

  Merge branches 'arm/exynos', 'arm/mediatek', 'arm/msm', 'arm/smmu', 'virt=
io', 'x86/vt-d', 'x86/amd' and 'core' into next (2022-07-29 12:06:56 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.20/v6.0:

Including:

	- Most intrusive patch is small and changes the default
	  allocation policy for DMA addresses. Before the change the
	  allocator tried its best to find an address in the first 4GB.
	  But that lead to performance problems when that space gets
	  exhaused, and since most devices are capable of 64-bit DMA
	  these days, we changed it to search in the full DMA-mask
	  range from the beginning.  This change has the potential to
	  uncover bugs elsewhere, in the kernel or the hardware. There
	  is a Kconfig option and a command line option to restore the
	  old behavior, but none of them is enabled by default.

	- Add Robin Murphy as reviewer of IOMMU code and maintainer for
	  the dma-iommu and iova code

	- Chaning IOVA magazine size from 1032 to 1024 bytes to save
	  memory

	- Some core code cleanups and dead-code removal

	- Support for ACPI IORT RMR node

	- Support for multiple PCI domains in the AMD-Vi driver

	- ARM SMMU changes from Will Deacon:

	  - Add even more Qualcomm device-tree compatible strings

	  - Support dumping of IMP DEF Qualcomm registers on TLB sync
	    timeout

	  - Fix reference count leak on device tree node in Qualcomm
	    driver

	- Intel VT-d driver updates from Lu Baolu:

	  - Make intel-iommu.h private

	  - Optimize the use of two locks

	  - Extend the driver to support large-scale platforms

	  - Cleanup some dead code

	- MediaTek IOMMU refactoring and support for TTBR up to 35bit

	- Basic support for Exynos SysMMU v7

	- VirtIO IOMMU driver gets a map/unmap_pages() implementation

	- Other smaller cleanups and fixes

----------------------------------------------------------------
AngeloGioacchino Del Regno (3):
      dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
      iommu/mediatek: Lookup phandle to retrieve syscon to infracfg
      iommu/mediatek: Cleanup pericfg lookup flow

Bo Liu (1):
      iommu/amd: Handle return of iommu_device_sysfs_add

Brijesh Singh (1):
      iommu/amd: Introduce function to check and enable SNP

Christoph Hellwig (4):
      iommu: remove the unused dev_has_feat method
      iommu: remove iommu_dev_feature_enabled
      iommu: remove the put_resv_regions method
      iommu/arm-smmu-v3: cleanup arm_smmu_dev_{enable,disable}_feature

Emma Anholt (1):
      iommu: arm-smmu-impl: Add 8250 display compatible to the client list.

Feng Tang (1):
      iommu/iova: change IOVA_MAG_SIZE to 127 to save memory

Joerg Roedel (4):
      MAINTAINERS: Add Robin Murphy as IOMMU SUBSYTEM reviewer
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/will/linux into arm/smmu
      iommu/amd: Fix compile warning in init code
      Merge branches 'arm/exynos', 'arm/mediatek', 'arm/msm', 'arm/smmu', '=
virtio', 'x86/vt-d', 'x86/amd' and 'core' into next

Jon Nettleton (1):
      iommu/arm-smmu: Get associated RMR info and install bypass SMR

Justin Stitt (1):
      drivers: iommu: fix clang -wformat warning

Ke Liu (1):
      iommu: Directly use ida_alloc()/free()

Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add compatible for Qualcomm SM6375
      iommu/arm-smmu-qcom: Add SM6375 SMMU compatible

Liang He (1):
      iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of lo=
op

Lu Baolu (25):
      iommu/vt-d: Move trace/events/intel_iommu.h under iommu
      agp/intel: Use per device iommu check
      iommu/vt-d: Remove unnecessary exported symbol
      drm/i915: Remove unnecessary include
      KVM: x86: Remove unnecessary include
      x86/boot/tboot: Move tboot_force_iommu() to Intel IOMMU
      iommu/vt-d: Move include/linux/intel-iommu.h under iommu
      iommu/vt-d: Remove unused iovad from dmar_domain
      iommu/vt-d: debugfs: Remove device_domain_lock usage
      iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
      iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
      iommu/vt-d: Unnecessary spinlock for root table alloc and free
      iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
      iommu/vt-d: Acquiring lock in domain ID allocation helpers
      iommu/vt-d: Acquiring lock in pasid manipulation helpers
      iommu/vt-d: Check device list of domain in domain free path
      iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
      iommu/vt-d: Use device_domain_lock accurately
      iommu/vt-d: Convert global spinlock into per domain lock
      iommu/vt-d: Remove unused domain_get_iommu()
      iommu/vt-d: Use IDA interface to manage iommu sequence id
      iommu/vt-d: Refactor iommu information of each domain
      iommu/vt-d: Remove unnecessary check in intel_iommu_add()
      iommu/vt-d: Remove global g_iommus array
      iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024

Marek Szyprowski (1):
      iommu/exynos: Make driver independent of the system page size

N=EDcolas F. R. A. Prado (1):
      iommu/mediatek: Log with dev_err_probe when failing to parse dts

Ren Zhijie (1):
      ACPI/IORT: Fix build error implicit-function-declaration

Robin Murphy (4):
      iommu/dma: Add config for PCI SAC address trick
      iommu: Use dev_iommu_ops() for probe_finalize
      iommu: Make .release_device optional
      iommu: Clean up release_device checks

Sai Prakash Ranjan (1):
      iommu/arm-smmu-qcom: Add debug support for TLB sync timeouts

Sam Protsenko (6):
      iommu/exynos: Reuse SysMMU constants for page size and order
      iommu/exynos: Handle failed IOMMU device registration properly
      iommu/exynos: Set correct dma mask for SysMMU v5+
      iommu/exynos: Abstract non-common registers on different variants
      iommu/exynos: Add SysMMU v7 register set
      iommu/exynos: Enable default VM instance on SysMMU v7

Shameer Kolothum (8):
      iommu: Introduce a callback to struct iommu_resv_region
      ACPI/IORT: Make iort_iommu_msi_get_resv_regions() return void
      ACPI/IORT: Provide a generic helper to retrieve reserve regions
      ACPI/IORT: Add support to retrieve IORT RMR reserved regions
      ACPI/IORT: Add a helper to retrieve RMR info directly
      iommu/arm-smmu-v3: Introduce strtab init helper
      iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force bypa=
ss
      iommu/arm-smmu-v3: Get associated RMR info and install bypass STE

Suravee Suthikulpanit (30):
      iommu/amd: Introduce per PCI segment device table
      iommu/amd: Introduce per PCI segment rlookup table
      iommu/amd: Introduce per PCI segment old_dev_tbl_cpy
      iommu/amd: Introduce per PCI segment alias_table
      iommu/amd: Convert to use rlookup_amd_iommu helper function
      iommu/amd: Update irq_remapping_alloc to use IOMMU lookup helper func=
tion
      iommu/amd: Introduce struct amd_ir_data.iommu
      iommu/amd: Update amd_irte_ops functions
      iommu/amd: Update alloc_irq_table and alloc_irq_index
      iommu/amd: Update set_dte_entry and clear_dte_entry
      iommu/amd: Update iommu_ignore_device
      iommu/amd: Update dump_dte_entry
      iommu/amd: Update set_dte_irq_entry
      iommu/amd: Update (un)init_device_table_dma()
      iommu/amd: Update set_dev_entry_bit() and get_dev_entry_bit()
      iommu/amd: Remove global amd_iommu_[dev_table/alias_table/last_bdf]
      iommu/amd: Introduce get_device_sbdf_id() helper function
      iommu/amd: Include PCI segment ID when initialize IOMMU
      iommu/amd: Specify PCI segment ID when getting pci device
      iommu/amd: Add PCI segment support for ivrs_[ioapic/hpet/acpihid] com=
mands
      iommu/amd: Change macro for IOMMU control register bit shift to decim=
al value
      iommu/amd: Introduce Support for Extended Feature 2 Register
      iommu/amd: Introduce global variable for storing common EFR and EFR2
      iommu/amd: Process all IVHDs before enabling IOMMU features
      iommu/amd: Globally detect SNP support
      iommu/amd: Set translation valid bit only when IO page tables are in =
use
      iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
      iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled
      iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement
      iommu/amd: Add support for AVIC when SNP is enabled

Tina Zhang (1):
      iommu/virtio: Add map/unmap_pages() callbacks implementation

Uros Bizjak (1):
      iommu/amd: Use try_cmpxchg64 in alloc_pte and free_clear_pte

Vasant Hegde (15):
      iommu/amd: Update struct iommu_dev_data definition
      iommu/amd: Introduce pci segment structure
      iommu/amd: Introduce per PCI segment irq_lookup_table
      iommu/amd: Introduce per PCI segment dev_data_list
      iommu/amd: Introduce per PCI segment unity map list
      iommu/amd: Introduce per PCI segment last_bdf
      iommu/amd: Introduce per PCI segment device table size
      iommu/amd: Introduce per PCI segment alias table size
      iommu/amd: Introduce per PCI segment rlookup table size
      iommu/amd: Convert to use per PCI segment irq_lookup_table
      iommu/amd: Convert to use per PCI segment rlookup_table
      iommu/amd: Flush upto last_bdf only
      iommu/amd: Print PCI segment ID in error log messages
      iommu/amd: Update device_state structure to include PCI seg ID
      iommu/amd: Update amd_iommu_fault structure to include PCI seg ID

Yunfei Wang (3):
      iommu/dma: Fix race condition during iova_domain initialization
      iommu/io-pgtable-arm-v7s: Add a quirk to allow pgtable PA up to 35bit
      iommu/mediatek: Allow page table PA up to 35bit

 Documentation/admin-guide/kernel-parameters.txt    |  34 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  17 +
 MAINTAINERS                                        |  14 +-
 arch/x86/kernel/tboot.c                            |  15 -
 arch/x86/kvm/x86.c                                 |   1 -
 drivers/acpi/arm64/iort.c                          | 360 +++++++-
 drivers/char/agp/intel-gtt.c                       |  17 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   1 -
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   1 -
 drivers/iommu/Kconfig                              |  36 +
 drivers/iommu/amd/amd_iommu.h                      |  18 +-
 drivers/iommu/amd/amd_iommu_types.h                | 186 ++--
 drivers/iommu/amd/init.c                           | 942 +++++++++++++----=
----
 drivers/iommu/amd/io_pgtable.c                     |   6 +-
 drivers/iommu/amd/iommu.c                          | 585 +++++++------
 drivers/iommu/amd/iommu_v2.c                       |  67 +-
 drivers/iommu/amd/quirks.c                         |   4 +-
 drivers/iommu/apple-dart.c                         |   4 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 144 ++--
 drivers/iommu/arm/arm-smmu/Makefile                |   1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   | 142 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  34 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |  28 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  73 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  18 +-
 drivers/iommu/dma-iommu.c                          |  21 +-
 drivers/iommu/exynos-iommu.c                       | 182 +++-
 drivers/iommu/fsl_pamu_domain.c                    |   5 -
 drivers/iommu/intel/cap_audit.c                    |   2 +-
 drivers/iommu/intel/debugfs.c                      |  51 +-
 drivers/iommu/intel/dmar.c                         |  39 +-
 drivers/iommu/intel/iommu.c                        | 447 ++++------
 .../intel-iommu.h =3D> drivers/iommu/intel/iommu.h   |  35 +-
 drivers/iommu/intel/irq_remapping.c                |   2 +-
 drivers/iommu/intel/pasid.c                        | 107 +--
 drivers/iommu/intel/pasid.h                        |   1 +
 drivers/iommu/intel/perf.c                         |   2 +-
 drivers/iommu/intel/svm.c                          |  11 +-
 drivers/iommu/intel/trace.c                        |   2 +-
 .../intel_iommu.h =3D> drivers/iommu/intel/trace.h   |   7 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  75 +-
 drivers/iommu/iommu.c                              |  55 +-
 drivers/iommu/iova.c                               |   7 +-
 drivers/iommu/msm_iommu.c                          |   7 +-
 drivers/iommu/mtk_iommu.c                          |  71 +-
 drivers/iommu/mtk_iommu_v1.c                       |   5 -
 drivers/iommu/sprd-iommu.c                         |  11 -
 drivers/iommu/sun50i-iommu.c                       |   3 -
 drivers/iommu/tegra-gart.c                         |   5 -
 drivers/iommu/tegra-smmu.c                         |   3 -
 drivers/iommu/virtio-iommu.c                       |  31 +-
 include/linux/acpi_iort.h                          |  14 +-
 include/linux/amd-iommu.h                          |   4 +
 include/linux/dmar.h                               |   6 +-
 include/linux/io-pgtable.h                         |  15 +-
 include/linux/iommu.h                              |  27 +-
 include/linux/tboot.h                              |   2 -
 59 files changed, 2521 insertions(+), 1484 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
 rename include/linux/intel-iommu.h =3D> drivers/iommu/intel/iommu.h (97%)
 rename include/trace/events/intel_iommu.h =3D> drivers/iommu/intel/trace.h=
 (93%)

Please pull.

Thanks,

	Joerg

--kkANkCbkvbfH1mSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmLs5PoACgkQK/BELZcB
GuMiwhAAwly8TRjyrsOHZKWhuPNtnTfGUv2CmOEC1zNkJiwGSAO9hYlzM5uiKO2A
61rgUcIUG3AjR+XIb/2YOtvsdOmEMfab6Cx6hlzwSyTpgcIywcp0uTYdooXLUoBc
l3+E104cBbzFOCjaGR8EfT4mWhYvTy3If2FoS/mOcW9WnZq7cXvx87+n7RqkFql6
+x0u88ZN0i/kUeA9aJlvHKdJh5RuTIeDn5tubzkxY+I+QorgWe7PX9GfdiFjftX3
XntqIDT/6iwnS01AkcSR4VVG+qIUTtICYRYId4UOdPh4omBWTawyu5tW3pvROGkb
/ioecLg+mvlIUB0feMscCH8EJuhOgCVebvkIh8YbYlQLrTk8YU1I0euqG0F+UOLW
J+dm2NKNTdY/BlOoIujaL5RzOy+tH+kWqX8a4/TbshxZ91pQk4aJGlUSCgI187AX
/8hCc4DiU90gSzT2zb2Lo4aLT5UFnjaboGErVoDN3VipemNLp8TToWWiU+mVVLpg
gGljlj2LO9WElBqqb5RMvd9r1WEk9XXVXBzaExMUYjzT2gZB+sCUEP5yPwf8Yvw0
hwr/IHYELVErC0YHNj60htQYM9u6IkXSMeCj/AsSiHoS3AyR4z2/eT4j2h1dsKbf
7Tcqiy0VHWfdemRaNMzvfs18begh4Uc0rM389umJLeuMQL4sk8o=
=FYNv
-----END PGP SIGNATURE-----

--kkANkCbkvbfH1mSU--
