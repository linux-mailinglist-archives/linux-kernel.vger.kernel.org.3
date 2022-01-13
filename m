Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3571C48D57C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiAMKNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:13:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34860 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiAMKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:13:22 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642068800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TNGuZWXw6Sff+RmDv17bD3P/hyyrUhoMbEYXx1PmfgU=;
        b=4uDYtkGJXWmcAt0wd/iTXDTOobRCpfWnMqAdT2JwqRBx7Uetwd2iT7FrZPVNi3CNbA/z6W
        vO9dcu2UyqvghaOxuk5ObwMwYubCEAmz+yKQBBUr35iPZbjeE0j1QWlgCtRg9ReQ2ZwvyS
        zjjVjNJhoBMImduuXb1pg9iqyzbhJxGZVl1d9y4KJXNsE8oMW7I5D3CsEWU1n18H1Zh743
        6G0/dJRgax9tDUaluHfksPtOKD3C6WkXdrMkk0wTxou8Ytzqz95AakitNoWf+vZLrTQV2b
        /U2bJpXDxtnnv4VI6S/cnimUE4k/jkZQ23Zhj/eAmrV5vn+mjD5z6Z5IzmbbRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642068800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TNGuZWXw6Sff+RmDv17bD3P/hyyrUhoMbEYXx1PmfgU=;
        b=VoTe7yID8FqzKZkgmXPLgYvoZgx+PYz6Lj8Vc0sJaNuaG4XuRu/aqzdwGX7+l+KjE39VjY
        u9J7wdxICjgwbSBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/msi for v5.17-rc1
References: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
Message-ID: <164206863209.82661.6310423060263423123.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Thu, 13 Jan 2022 11:13:20 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/msi branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2022-01-=
13

up to:  74a5257a0c17: genirq/msi: Populate sysfs entry only once


Rework of the MSI interrupt infrastructure:

  Treewide cleanup and consolidation of MSI interrupt handling in
  preparation for further changes in this area which are necessary to:

  - address existing shortcomings in the VFIO area

  - support the upcoming Interrupt Message Store functionality which
    decouples the message store from the PCI config/MMIO space



Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      x86/xen: Use correct #ifdef guard for xen_initdom_restore_msi()

C=C3=A9dric Le Goater (1):
      powerpc/4xx: Complete removal of MSI support

Thomas Gleixner (92):
      powerpc/4xx: Remove MSI support which never worked
      PCI/MSI: Fix pci_irq_vector()/pci_irq_get_affinity()
      genirq/msi: Guard sysfs code
      genirq/msi: Remove unused domain callbacks
      genirq/msi: Fixup includes
      PCI/MSI: Make pci_msi_domain_write_msg() static
      PCI/MSI: Remove msi_desc_to_pci_sysdata()
      PCI/sysfs: Use pci_irq_vector()
      MIPS: Octeon: Use arch_setup_msi_irq()
      genirq/msi, treewide: Use a named struct for PCI/MSI attributes
      x86/hyperv: Refactor hv_msi_domain_free_irqs()
      PCI/MSI: Make arch_restore_msi_irqs() less horrible.
      PCI/MSI: Cleanup include zoo
      PCI/MSI: Make msix_update_entries() smarter
      PCI/MSI: Move code into a separate directory
      PCI/MSI: Split out CONFIG_PCI_MSI independent part
      PCI/MSI: Split out !IRQDOMAIN code
      PCI/MSI: Split out irqdomain code
      PCI/MSI: Sanitize MSI-X table map handling
      PCI/MSI: Move msi_lock to struct pci_dev
      PCI/MSI: Make pci_msi_domain_check_cap() static
      genirq/msi: Handle PCI/MSI allocation fail in core code
      PCI/MSI: Move descriptor counting on allocation fail to the legacy code
      PCI/MSI: Set pci_dev::msi[x]_enabled early
      x86/pci/XEN: Use PCI device property
      x86/apic/msi: Use PCI device MSI property
      genirq/msi: Use PCI device property
      powerpc/cell/axon_msi: Use PCI device property
      powerpc/pseries/msi: Use PCI device properties
      device: Move MSI related data into a struct
      device: Add device:: Msi_data pointer and struct msi_device_data
      PCI/MSI: Decouple MSI[-X] disable from pcim_release()
      PCI/MSI: Allocate MSI device data on first use
      platform-msi: Allocate MSI device data on first use
      bus: fsl-mc-msi: Allocate MSI device data on first use
      soc: ti: ti_sci_inta_msi: Allocate MSI device data on first use
      genirq/msi: Provide msi_device_populate/destroy_sysfs()
      PCI/MSI: Let the irq code handle sysfs groups
      platform-msi: Let the core code handle sysfs groups
      genirq/msi: Remove the original sysfs interfaces
      platform-msi: Rename functions and clarify comments
      platform-msi: Store platform private data pointer in msi_device_data
      genirq/msi: Consolidate MSI descriptor data
      platform-msi: Use msi_desc::msi_index
      bus: fsl-mc-msi: Use msi_desc::msi_index
      soc: ti: ti_sci_inta_msi: Use msi_desc::msi_index
      PCI/MSI: Use msi_desc::msi_index
      PCI/MSI: Provide MSI_FLAG_MSIX_CONTIGUOUS
      powerpc/pseries/msi: Let core code check for contiguous entries
      genirq/msi: Provide interface to retrieve Linux interrupt number
      PCI/MSI: Use msi_get_virq() in pci_get_vector()
      PCI/MSI: Simplify pci_irq_get_affinity()
      dmaengine: mv_xor_v2: Get rid of msi_desc abuse
      perf/smmuv3: Use msi_get_virq()
      iommu/arm-smmu-v3: Use msi_get_virq()
      mailbox: bcm-flexrm-mailbox: Rework MSI interrupt handling
      bus: fsl-mc: fsl-mc-allocator: Rework MSI handling
      soc: ti: ti_sci_inta_msi: Get rid of ti_sci_inta_msi_get_virq()
      dmaengine: qcom_hidma: Cleanup MSI handling
      genirq/msi: Move descriptor list to struct msi_device_data
      genirq/msi: Add mutex for MSI list protection
      genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()
      genirq/msi: Provide a set of advanced MSI accessors and iterators
      genirq/msi: Provide msi_alloc_msi_desc() and a simple allocator
      genirq/msi: Provide domain flags to allocate/free MSI descriptors autom=
atically
      PCI/MSI: Protect MSI operations
      PCI/MSI: Use msi_add_msi_desc()
      PCI/MSI: Let core code free MSI descriptors
      PCI/MSI: Use msi_on_each_desc()
      x86/pci/xen: Use msi_for_each_desc()
      xen/pcifront: Rework MSI handling
      s390/pci: Rework MSI descriptor walk
      powerpc/4xx/hsta: Rework MSI handling
      powerpc/cell/axon_msi: Convert to msi_on_each_desc()
      powerpc/pasemi/msi: Convert to msi_on_each_dec()
      powerpc/fsl_msi: Use msi_for_each_desc()
      powerpc/mpic_u3msi: Use msi_for_each-desc()
      PCI: hv: Rework MSI handling
      NTB/msi: Convert to msi_on_each_desc()
      soc: ti: ti_sci_inta_msi: Rework MSI descriptor allocation
      soc: ti: ti_sci_inta_msi: Remove ti_sci_inta_msi_domain_free_irqs()
      bus: fsl-mc-msi: Simplify MSI descriptor handling
      platform-msi: Let core code handle MSI descriptors
      platform-msi: Simplify platform device MSI code
      genirq/msi: Make interrupt allocation less convoluted
      genirq/msi: Convert to new functions
      genirq/msi: Mop up old interfaces
      genirq/msi: Add abuse prevention comment to msi header
      genirq/msi: Simplify sysfs handling
      genirq/msi: Convert storage to xarray
      PCI/MSI: Unbreak pci_irq_get_affinity()
      genirq/msi: Populate sysfs entry only once


 .clang-format                                      |   1 -
 Documentation/driver-api/pci/pci.rst               |   2 +-
 arch/mips/pci/msi-octeon.c                         |  32 +-
 arch/powerpc/boot/dts/bluestone.dts                |  25 -
 arch/powerpc/boot/dts/canyonlands.dts              |  18 -
 arch/powerpc/boot/dts/katmai.dts                   |  18 -
 arch/powerpc/boot/dts/kilauea.dts                  |  28 -
 arch/powerpc/boot/dts/redwood.dts                  |  19 -
 arch/powerpc/platforms/40x/Kconfig                 |   1 -
 arch/powerpc/platforms/44x/Kconfig                 |   4 -
 arch/powerpc/platforms/4xx/Makefile                |   1 -
 arch/powerpc/platforms/4xx/hsta_msi.c              |   7 +-
 arch/powerpc/platforms/4xx/msi.c                   | 281 ------
 arch/powerpc/platforms/cell/axon_msi.c             |  12 +-
 arch/powerpc/platforms/pasemi/msi.c                |   9 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   4 +-
 arch/powerpc/platforms/pseries/msi.c               |  38 +-
 arch/powerpc/sysdev/Kconfig                        |   6 -
 arch/powerpc/sysdev/fsl_msi.c                      |   8 +-
 arch/powerpc/sysdev/mpic_u3msi.c                   |   9 +-
 arch/s390/pci/pci_irq.c                            |  10 +-
 arch/sparc/kernel/pci_msi.c                        |   4 +-
 arch/x86/hyperv/irqdomain.c                        |  55 +-
 arch/x86/include/asm/x86_init.h                    |   6 -
 arch/x86/include/asm/xen/hypervisor.h              |   8 +
 arch/x86/kernel/apic/msi.c                         |  11 +-
 arch/x86/kernel/x86_init.c                         |  12 -
 arch/x86/pci/xen.c                                 |  38 +-
 drivers/base/core.c                                |   4 -
 drivers/base/platform-msi.c                        | 234 ++---
 drivers/bus/fsl-mc/dprc-driver.c                   |   8 +-
 drivers/bus/fsl-mc/fsl-mc-allocator.c              |   9 +-
 drivers/bus/fsl-mc/fsl-mc-msi.c                    |  79 +-
 drivers/dma/mv_xor_v2.c                            |  16 +-
 drivers/dma/qcom/hidma.c                           |  44 +-
 drivers/dma/ti/k3-udma-private.c                   |   6 +-
 drivers/dma/ti/k3-udma.c                           |  14 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  23 +-
 drivers/irqchip/irq-gic-v2m.c                      |   1 -
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           |   1 -
 drivers/irqchip/irq-gic-v3-mbi.c                   |   1 -
 drivers/irqchip/irq-mbigen.c                       |   4 +-
 drivers/irqchip/irq-mvebu-icu.c                    |  12 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   2 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |   9 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   4 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c   |   4 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   2 +-
 drivers/ntb/msi.c                                  |  19 +-
 drivers/pci/Makefile                               |   3 +-
 drivers/pci/controller/pci-hyperv.c                |  15 +-
 drivers/pci/msi/Makefile                           |   7 +
 drivers/pci/msi/irqdomain.c                        | 280 ++++++
 drivers/pci/msi/legacy.c                           |  81 ++
 drivers/pci/{ =3D> msi}/msi.c                        | 954 ++++++-----------=
----
 drivers/pci/msi/msi.h                              |  39 +
 drivers/pci/msi/pcidev_msi.c                       |  43 +
 drivers/pci/pci-sysfs.c                            |   7 +-
 drivers/pci/pci.c                                  |   5 -
 drivers/pci/probe.c                                |   4 +-
 drivers/pci/xen-pcifront.c                         |   4 +-
 drivers/perf/arm_smmuv3_pmu.c                      |   5 +-
 drivers/soc/fsl/dpio/dpio-driver.c                 |   8 +-
 drivers/soc/ti/k3-ringacc.c                        |   6 +-
 drivers/soc/ti/ti_sci_inta_msi.c                   |  94 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c             |   4 +-
 include/linux/device.h                             |  31 +-
 include/linux/fsl/mc.h                             |   4 +-
 include/linux/msi.h                                | 289 ++++---
 include/linux/pci.h                                |   6 +-
 include/linux/soc/ti/ti_sci_inta_msi.h             |   2 -
 kernel/irq/msi.c                                   | 792 ++++++++++++-----
 73 files changed, 1773 insertions(+), 2078 deletions(-)
 delete mode 100644 arch/powerpc/platforms/4xx/msi.c
 create mode 100644 drivers/pci/msi/Makefile
 create mode 100644 drivers/pci/msi/irqdomain.c
 create mode 100644 drivers/pci/msi/legacy.c
 rename drivers/pci/{ =3D> msi}/msi.c (56%)
 create mode 100644 drivers/pci/msi/msi.h
 create mode 100644 drivers/pci/msi/pcidev_msi.c

diff --git a/.clang-format b/.clang-format
index 15d4eaabc6b5..fa959436bcfd 100644
--- a/.clang-format
+++ b/.clang-format
@@ -216,7 +216,6 @@ ForEachMacros:
   - 'for_each_migratetype_order'
   - 'for_each_msi_entry'
   - 'for_each_msi_entry_safe'
-  - 'for_each_msi_vector'
   - 'for_each_net'
   - 'for_each_net_continue_reverse'
   - 'for_each_netdev'
diff --git a/Documentation/driver-api/pci/pci.rst b/Documentation/driver-api/=
pci/pci.rst
index ca85e5e78b2c..4843cfad4f60 100644
--- a/Documentation/driver-api/pci/pci.rst
+++ b/Documentation/driver-api/pci/pci.rst
@@ -13,7 +13,7 @@ PCI Support Library
 .. kernel-doc:: drivers/pci/search.c
    :export:
=20
-.. kernel-doc:: drivers/pci/msi.c
+.. kernel-doc:: drivers/pci/msi/msi.c
    :export:
=20
 .. kernel-doc:: drivers/pci/bus.c
diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 288b58b00dc8..c2860ebbd863 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -68,6 +68,9 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc=
 *desc)
 	u64 search_mask;
 	int index;
=20
+	if (desc->pci.msi_attrib.is_msix)
+		return -EINVAL;
+
 	/*
 	 * Read the MSI config to figure out how many IRQs this device
 	 * wants.  Most devices only want 1, which will give
@@ -182,35 +185,6 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_d=
esc *desc)
 	return 0;
 }
=20
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct msi_desc *entry;
-	int ret;
-
-	/*
-	 * MSI-X is not supported.
-	 */
-	if (type =3D=3D PCI_CAP_ID_MSIX)
-		return -EINVAL;
-
-	/*
-	 * If an architecture wants to support multiple MSI, it needs to
-	 * override arch_setup_msi_irqs()
-	 */
-	if (type =3D=3D PCI_CAP_ID_MSI && nvec > 1)
-		return 1;
-
-	for_each_pci_msi_entry(entry, dev) {
-		ret =3D arch_setup_msi_irq(dev, entry);
-		if (ret < 0)
-			return ret;
-		if (ret > 0)
-			return -ENOSPC;
-	}
-
-	return 0;
-}
-
 /**
  * Called when a device no longer needs its MSI interrupts. All
  * MSI interrupts for the device are freed.
diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/blue=
stone.dts
index aa1ae94cd776..6971595319c1 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -366,30 +366,5 @@ PCIE0: pcie@d00000000 {
 				0x0 0x0 0x0 0x3 &UIC3 0xe 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0xf 0x4 /* swizzled int D */>;
 		};
-
-		MSI: ppc4xx-msi@C10000000 {
-			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-			reg =3D < 0xC 0x10000000 0x100
-				0xC 0x10000000 0x100>;
-			sdr-base =3D <0x36C>;
-			msi-data =3D <0x00004440>;
-			msi-mask =3D <0x0000ffe0>;
-			interrupts =3D<0 1 2 3 4 5 6 7>;
-			interrupt-parent =3D <&MSI>;
-			#interrupt-cells =3D <1>;
-			#address-cells =3D <0>;
-			#size-cells =3D <0>;
-			msi-available-ranges =3D <0x0 0x100>;
-			interrupt-map =3D <
-				0 &UIC3 0x18 1
-				1 &UIC3 0x19 1
-				2 &UIC3 0x1A 1
-				3 &UIC3 0x1B 1
-				4 &UIC3 0x1C 1
-				5 &UIC3 0x1D 1
-				6 &UIC3 0x1E 1
-				7 &UIC3 0x1F 1
-			>;
-		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/ca=
nyonlands.dts
index c5fbb08e0a6e..5db1bff6b23d 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -544,23 +544,5 @@ PCIE1: pcie@d20000000 {
 				0x0 0x0 0x0 0x3 &UIC3 0x12 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0x13 0x4 /* swizzled int D */>;
 		};
-
-		MSI: ppc4xx-msi@C10000000 {
-			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-			reg =3D < 0xC 0x10000000 0x100>;
-			sdr-base =3D <0x36C>;
-			msi-data =3D <0x00000000>;
-			msi-mask =3D <0x44440000>;
-			interrupt-count =3D <3>;
-			interrupts =3D <0 1 2 3>;
-			interrupt-parent =3D <&UIC3>;
-			#interrupt-cells =3D <1>;
-			#address-cells =3D <0>;
-			#size-cells =3D <0>;
-			interrupt-map =3D <0 &UIC3 0x18 1
-					1 &UIC3 0x19 1
-					2 &UIC3 0x1A 1
-					3 &UIC3 0x1B 1>;
-		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.=
dts
index a8f353229fb7..4262b2bbd6de 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -442,24 +442,6 @@ PCIE2: pcie@d40000000 {
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
=20
-		MSI: ppc4xx-msi@400300000 {
-				compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-				reg =3D < 0x4 0x00300000 0x100>;
-				sdr-base =3D <0x3B0>;
-				msi-data =3D <0x00000000>;
-				msi-mask =3D <0x44440000>;
-				interrupt-count =3D <3>;
-				interrupts =3D<0 1 2 3>;
-				interrupt-parent =3D <&UIC0>;
-				#interrupt-cells =3D <1>;
-				#address-cells =3D <0>;
-				#size-cells =3D <0>;
-				interrupt-map =3D <0 &UIC0 0xC 1
-					1 &UIC0 0x0D 1
-					2 &UIC0 0x0E 1
-					3 &UIC0 0x0F 1>;
-		};
-
 		I2O: i2o@400100000 {
 			compatible =3D "ibm,i2o-440spe";
 			reg =3D <0x00000004 0x00100000 0x100>;
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilaue=
a.dts
index a709fb47a180..c07a7525a72c 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -403,33 +403,5 @@ PCIE1: pcie@c0000000 {
 				0x0 0x0 0x0 0x3 &UIC2 0xd 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC2 0xe 0x4 /* swizzled int D */>;
 		};
-
-		MSI: ppc4xx-msi@C10000000 {
-			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-			reg =3D <0xEF620000 0x100>;
-			sdr-base =3D <0x4B0>;
-			msi-data =3D <0x00000000>;
-			msi-mask =3D <0x44440000>;
-			interrupt-count =3D <12>;
-			interrupts =3D <0 1 2 3 4 5 6 7 8 9 0xA 0xB 0xC 0xD>;
-			interrupt-parent =3D <&UIC2>;
-			#interrupt-cells =3D <1>;
-			#address-cells =3D <0>;
-			#size-cells =3D <0>;
-			interrupt-map =3D <0 &UIC2 0x10 1
-					1 &UIC2 0x11 1
-					2 &UIC2 0x12 1
-					2 &UIC2 0x13 1
-					2 &UIC2 0x14 1
-					2 &UIC2 0x15 1
-					2 &UIC2 0x16 1
-					2 &UIC2 0x17 1
-					2 &UIC2 0x18 1
-					2 &UIC2 0x19 1
-					2 &UIC2 0x1A 1
-					2 &UIC2 0x1B 1
-					2 &UIC2 0x1C 1
-					3 &UIC2 0x1D 1>;
-		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/redwood.dts b/arch/powerpc/boot/dts/redwoo=
d.dts
index f38035a1f4a1..3c849e23e5f3 100644
--- a/arch/powerpc/boot/dts/redwood.dts
+++ b/arch/powerpc/boot/dts/redwood.dts
@@ -358,25 +358,6 @@ PCIE2: pcie@d40000000 {
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
=20
-		MSI: ppc4xx-msi@400300000 {
-				compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-				reg =3D < 0x4 0x00300000 0x100
-					0x4 0x00300000 0x100>;
-				sdr-base =3D <0x3B0>;
-				msi-data =3D <0x00000000>;
-				msi-mask =3D <0x44440000>;
-				interrupt-count =3D <3>;
-				interrupts =3D<0 1 2 3>;
-				interrupt-parent =3D <&UIC0>;
-				#interrupt-cells =3D <1>;
-				#address-cells =3D <0>;
-				#size-cells =3D <0>;
-				interrupt-map =3D <0 &UIC0 0xC 1
-					1 &UIC0 0x0D 1
-					2 &UIC0 0x0E 1
-					3 &UIC0 0x0F 1>;
-		};
-
 	};
=20
=20
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/=
Kconfig
index e3e5217c9822..614ea6dc994c 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -23,7 +23,6 @@ config KILAUEA
 	select PPC4xx_PCI_EXPRESS
 	select FORCE_PCI
 	select PCI_MSI
-	select PPC4xx_MSI
 	help
 	  This option enables support for the AMCC PPC405EX evaluation board.
=20
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/=
Kconfig
index 83975ef50975..25b80cd558f8 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -23,7 +23,6 @@ config BLUESTONE
 	select APM821xx
 	select FORCE_PCI
 	select PCI_MSI
-	select PPC4xx_MSI
 	select PPC4xx_PCI_EXPRESS
 	select IBM_EMAC_RGMII if IBM_EMAC
 	help
@@ -73,7 +72,6 @@ config KATMAI
 	select FORCE_PCI
 	select PPC4xx_PCI_EXPRESS
 	select PCI_MSI
-	select PPC4xx_MSI
 	help
 	  This option enables support for the AMCC PPC440SPe evaluation board.
=20
@@ -115,7 +113,6 @@ config CANYONLANDS
 	select FORCE_PCI
 	select PPC4xx_PCI_EXPRESS
 	select PCI_MSI
-	select PPC4xx_MSI
 	select IBM_EMAC_RGMII if IBM_EMAC
 	select IBM_EMAC_ZMII if IBM_EMAC
 	help
@@ -141,7 +138,6 @@ config REDWOOD
 	select FORCE_PCI
 	select PPC4xx_PCI_EXPRESS
 	select PCI_MSI
-	select PPC4xx_MSI
 	help
 	  This option enables support for the AMCC PPC460SX Redwood board.
=20
diff --git a/arch/powerpc/platforms/4xx/Makefile b/arch/powerpc/platforms/4xx=
/Makefile
index d009d2e0b9e8..2071a0abe09b 100644
--- a/arch/powerpc/platforms/4xx/Makefile
+++ b/arch/powerpc/platforms/4xx/Makefile
@@ -3,6 +3,5 @@ obj-y				+=3D uic.o machine_check.o
 obj-$(CONFIG_4xx_SOC)		+=3D soc.o
 obj-$(CONFIG_PCI)		+=3D pci.o
 obj-$(CONFIG_PPC4xx_HSTA_MSI)	+=3D hsta_msi.o
-obj-$(CONFIG_PPC4xx_MSI)	+=3D msi.o
 obj-$(CONFIG_PPC4xx_CPM)	+=3D cpm.o
 obj-$(CONFIG_PPC4xx_GPIO)	+=3D gpio.o
diff --git a/arch/powerpc/platforms/4xx/hsta_msi.c b/arch/powerpc/platforms/4=
xx/hsta_msi.c
index c950fed43b32..fee430eadcc6 100644
--- a/arch/powerpc/platforms/4xx/hsta_msi.c
+++ b/arch/powerpc/platforms/4xx/hsta_msi.c
@@ -47,7 +47,7 @@ static int hsta_setup_msi_irqs(struct pci_dev *dev, int nve=
c, int type)
 		return -EINVAL;
 	}
=20
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		irq =3D msi_bitmap_alloc_hwirqs(&ppc4xx_hsta_msi.bmp, 1);
 		if (irq < 0) {
 			pr_debug("%s: Failed to allocate msi interrupt\n",
@@ -105,10 +105,7 @@ static void hsta_teardown_msi_irqs(struct pci_dev *dev)
 	struct msi_desc *entry;
 	int irq;
=20
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
 		irq =3D hsta_find_hwirq_offset(entry->irq);
=20
 		/* entry->irq should always be in irq_map */
diff --git a/arch/powerpc/platforms/4xx/msi.c b/arch/powerpc/platforms/4xx/ms=
i.c
deleted file mode 100644
index 1051564b94f2..000000000000
--- a/arch/powerpc/platforms/4xx/msi.c
+++ /dev/null
@@ -1,281 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Adding PCI-E MSI support for PPC4XX SoCs.
- *
- * Copyright (c) 2010, Applied Micro Circuits Corporation
- * Authors:	Tirumala R Marri <tmarri@apm.com>
- *		Feng Kan <fkan@apm.com>
- */
-
-#include <linux/irq.h>
-#include <linux/pci.h>
-#include <linux/msi.h>
-#include <linux/of_platform.h>
-#include <linux/interrupt.h>
-#include <linux/export.h>
-#include <linux/kernel.h>
-#include <asm/prom.h>
-#include <asm/hw_irq.h>
-#include <asm/ppc-pci.h>
-#include <asm/dcr.h>
-#include <asm/dcr-regs.h>
-#include <asm/msi_bitmap.h>
-
-#define PEIH_TERMADH	0x00
-#define PEIH_TERMADL	0x08
-#define PEIH_MSIED	0x10
-#define PEIH_MSIMK	0x18
-#define PEIH_MSIASS	0x20
-#define PEIH_FLUSH0	0x30
-#define PEIH_FLUSH1	0x38
-#define PEIH_CNTRST	0x48
-
-static int msi_irqs;
-
-struct ppc4xx_msi {
-	u32 msi_addr_lo;
-	u32 msi_addr_hi;
-	void __iomem *msi_regs;
-	int *msi_virqs;
-	struct msi_bitmap bitmap;
-	struct device_node *msi_dev;
-};
-
-static struct ppc4xx_msi ppc4xx_msi;
-
-static int ppc4xx_msi_init_allocator(struct platform_device *dev,
-		struct ppc4xx_msi *msi_data)
-{
-	int err;
-
-	err =3D msi_bitmap_alloc(&msi_data->bitmap, msi_irqs,
-			      dev->dev.of_node);
-	if (err)
-		return err;
-
-	err =3D msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
-	if (err < 0) {
-		msi_bitmap_free(&msi_data->bitmap);
-		return err;
-	}
-
-	return 0;
-}
-
-static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	int int_no =3D -ENOMEM;
-	unsigned int virq;
-	struct msi_msg msg;
-	struct msi_desc *entry;
-	struct ppc4xx_msi *msi_data =3D &ppc4xx_msi;
-
-	dev_dbg(&dev->dev, "PCIE-MSI:%s called. vec %x type %d\n",
-		__func__, nvec, type);
-	if (type =3D=3D PCI_CAP_ID_MSIX)
-		pr_debug("ppc4xx msi: MSI-X untested, trying anyway.\n");
-
-	msi_data->msi_virqs =3D kmalloc_array(msi_irqs, sizeof(int), GFP_KERNEL);
-	if (!msi_data->msi_virqs)
-		return -ENOMEM;
-
-	for_each_pci_msi_entry(entry, dev) {
-		int_no =3D msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
-		if (int_no >=3D 0)
-			break;
-		if (int_no < 0) {
-			pr_debug("%s: fail allocating msi interrupt\n",
-					__func__);
-		}
-		virq =3D irq_of_parse_and_map(msi_data->msi_dev, int_no);
-		if (!virq) {
-			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
-			msi_bitmap_free_hwirqs(&msi_data->bitmap, int_no, 1);
-			return -ENOSPC;
-		}
-		dev_dbg(&dev->dev, "%s: virq =3D %d\n", __func__, virq);
-
-		/* Setup msi address space */
-		msg.address_hi =3D msi_data->msi_addr_hi;
-		msg.address_lo =3D msi_data->msi_addr_lo;
-
-		irq_set_msi_desc(virq, entry);
-		msg.data =3D int_no;
-		pci_write_msi_msg(virq, &msg);
-	}
-	return 0;
-}
-
-void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
-{
-	struct msi_desc *entry;
-	struct ppc4xx_msi *msi_data =3D &ppc4xx_msi;
-	irq_hw_number_t hwirq;
-
-	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
-
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-		hwirq =3D virq_to_hw(entry->irq);
-		irq_set_msi_desc(entry->irq, NULL);
-		irq_dispose_mapping(entry->irq);
-		msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
-	}
-}
-
-static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
-				 struct resource res, struct ppc4xx_msi *msi)
-{
-	const u32 *msi_data;
-	const u32 *msi_mask;
-	const u32 *sdr_addr;
-	dma_addr_t msi_phys;
-	void *msi_virt;
-	int err;
-
-	sdr_addr =3D of_get_property(dev->dev.of_node, "sdr-base", NULL);
-	if (!sdr_addr)
-		return -EINVAL;
-
-	msi_data =3D of_get_property(dev->dev.of_node, "msi-data", NULL);
-	if (!msi_data)
-		return -EINVAL;
-
-	msi_mask =3D of_get_property(dev->dev.of_node, "msi-mask", NULL);
-	if (!msi_mask)
-		return -EINVAL;
-
-	msi->msi_dev =3D of_find_node_by_name(NULL, "ppc4xx-msi");
-	if (!msi->msi_dev)
-		return -ENODEV;
-
-	msi->msi_regs =3D of_iomap(msi->msi_dev, 0);
-	if (!msi->msi_regs) {
-		dev_err(&dev->dev, "of_iomap failed\n");
-		err =3D -ENOMEM;
-		goto node_put;
-	}
-	dev_dbg(&dev->dev, "PCIE-MSI: msi register mapped 0x%x 0x%x\n",
-		(u32) (msi->msi_regs + PEIH_TERMADH), (u32) (msi->msi_regs));
-
-	msi_virt =3D dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);
-	if (!msi_virt) {
-		err =3D -ENOMEM;
-		goto iounmap;
-	}
-	msi->msi_addr_hi =3D upper_32_bits(msi_phys);
-	msi->msi_addr_lo =3D lower_32_bits(msi_phys & 0xffffffff);
-	dev_dbg(&dev->dev, "PCIE-MSI: msi address high 0x%x, low 0x%x\n",
-		msi->msi_addr_hi, msi->msi_addr_lo);
-
-	mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));	/*HIGH addr */
-	mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));	/* Low addr */
-
-	/* Progam the Interrupt handler Termination addr registers */
-	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
-	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
-
-	/* Program MSI Expected data and Mask bits */
-	out_be32(msi->msi_regs + PEIH_MSIED, *msi_data);
-	out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
-
-	dma_free_coherent(&dev->dev, 64, msi_virt, msi_phys);
-
-	return 0;
-
-iounmap:
-	iounmap(msi->msi_regs);
-node_put:
-	of_node_put(msi->msi_dev);
-	return err;
-}
-
-static int ppc4xx_of_msi_remove(struct platform_device *dev)
-{
-	struct ppc4xx_msi *msi =3D dev->dev.platform_data;
-	int i;
-	int virq;
-
-	for (i =3D 0; i < msi_irqs; i++) {
-		virq =3D msi->msi_virqs[i];
-		if (virq)
-			irq_dispose_mapping(virq);
-	}
-
-	if (msi->bitmap.bitmap)
-		msi_bitmap_free(&msi->bitmap);
-	iounmap(msi->msi_regs);
-	of_node_put(msi->msi_dev);
-
-	return 0;
-}
-
-static int ppc4xx_msi_probe(struct platform_device *dev)
-{
-	struct ppc4xx_msi *msi;
-	struct resource res;
-	int err =3D 0;
-	struct pci_controller *phb;
-
-	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
-
-	msi =3D devm_kzalloc(&dev->dev, sizeof(*msi), GFP_KERNEL);
-	if (!msi)
-		return -ENOMEM;
-	dev->dev.platform_data =3D msi;
-
-	/* Get MSI ranges */
-	err =3D of_address_to_resource(dev->dev.of_node, 0, &res);
-	if (err) {
-		dev_err(&dev->dev, "%pOF resource error!\n", dev->dev.of_node);
-		return err;
-	}
-
-	msi_irqs =3D of_irq_count(dev->dev.of_node);
-	if (!msi_irqs)
-		return -ENODEV;
-
-	err =3D ppc4xx_setup_pcieh_hw(dev, res, msi);
-	if (err)
-		return err;
-
-	err =3D ppc4xx_msi_init_allocator(dev, msi);
-	if (err) {
-		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
-		goto error_out;
-	}
-	ppc4xx_msi =3D *msi;
-
-	list_for_each_entry(phb, &hose_list, list_node) {
-		phb->controller_ops.setup_msi_irqs =3D ppc4xx_setup_msi_irqs;
-		phb->controller_ops.teardown_msi_irqs =3D ppc4xx_teardown_msi_irqs;
-	}
-	return 0;
-
-error_out:
-	ppc4xx_of_msi_remove(dev);
-	return err;
-}
-static const struct of_device_id ppc4xx_msi_ids[] =3D {
-	{
-		.compatible =3D "amcc,ppc4xx-msi",
-	},
-	{}
-};
-static struct platform_driver ppc4xx_msi_driver =3D {
-	.probe =3D ppc4xx_msi_probe,
-	.remove =3D ppc4xx_of_msi_remove,
-	.driver =3D {
-		   .name =3D "ppc4xx-msi",
-		   .of_match_table =3D ppc4xx_msi_ids,
-		   },
-
-};
-
-static __init int ppc4xx_msi_init(void)
-{
-	return platform_driver_register(&ppc4xx_msi_driver);
-}
-
-subsys_initcall(ppc4xx_msi_init);
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/=
cell/axon_msi.c
index 82335e364c44..354a58c1e6f2 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -199,7 +199,6 @@ static struct axon_msic *find_msi_translator(struct pci_d=
ev *dev)
 static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 {
 	struct device_node *dn;
-	struct msi_desc *entry;
 	int len;
 	const u32 *prop;
=20
@@ -209,10 +208,8 @@ static int setup_msi_msg_address(struct pci_dev *dev, st=
ruct msi_msg *msg)
 		return -ENODEV;
 	}
=20
-	entry =3D first_pci_msi_entry(dev);
-
 	for (; dn; dn =3D of_get_next_parent(dn)) {
-		if (entry->msi_attrib.is_64) {
+		if (!dev->no_64bit_msi) {
 			prop =3D of_get_property(dn, "msi-address-64", &len);
 			if (prop)
 				break;
@@ -265,7 +262,7 @@ static int axon_msi_setup_msi_irqs(struct pci_dev *dev, i=
nt nvec, int type)
 	if (rc)
 		return rc;
=20
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		virq =3D irq_create_direct_mapping(msic->irq_domain);
 		if (!virq) {
 			dev_warn(&dev->dev,
@@ -288,10 +285,7 @@ static void axon_msi_teardown_msi_irqs(struct pci_dev *d=
ev)
=20
 	dev_dbg(&dev->dev, "axon_msi: tearing down msi irqs\n");
=20
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 	}
diff --git a/arch/powerpc/platforms/pasemi/msi.c b/arch/powerpc/platforms/pas=
emi/msi.c
index d38944a1e258..e8af72282682 100644
--- a/arch/powerpc/platforms/pasemi/msi.c
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -62,17 +62,12 @@ static void pasemi_msi_teardown_msi_irqs(struct pci_dev *=
pdev)
=20
 	pr_debug("pasemi_msi_teardown_msi_irqs, pdev %p\n", pdev);
=20
-	for_each_pci_msi_entry(entry, pdev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		hwirq =3D virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, ALLOC_CHUNK);
 	}
-
-	return;
 }
=20
 static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int typ=
e)
@@ -90,7 +85,7 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, =
int nvec, int type)
 	msg.address_hi =3D 0;
 	msg.address_lo =3D PASEMI_MSI_ADDR;
=20
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		/* Allocate 16 interrupts for now, since that's the grouping for
 		 * affinity. This can be changed later if it turns out 32 is too
 		 * few MSIs for someone, but restrictions will apply to how the
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platfor=
ms/powernv/pci-ioda.c
index 004cd6a96c8a..8913c86009d9 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2154,10 +2154,10 @@ static void pnv_msi_compose_msg(struct irq_data *d, s=
truct msi_msg *msg)
 	int rc;
=20
 	rc =3D __pnv_pci_ioda_msi_setup(phb, pdev, d->hwirq,
-				      entry->msi_attrib.is_64, msg);
+				      entry->pci.msi_attrib.is_64, msg);
 	if (rc)
 		dev_err(&pdev->dev, "Failed to setup %s-bit MSI #%ld : %d\n",
-			entry->msi_attrib.is_64 ? "64" : "32", d->hwirq, rc);
+			entry->pci.msi_attrib.is_64 ? "64" : "32", d->hwirq, rc);
 }
=20
 /*
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/ps=
eries/msi.c
index 8627362f613e..fb2919fd6bc0 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -321,27 +321,6 @@ static int msi_quota_for_device(struct pci_dev *dev, int=
 request)
 	return request;
 }
=20
-static int check_msix_entries(struct pci_dev *pdev)
-{
-	struct msi_desc *entry;
-	int expected;
-
-	/* There's no way for us to express to firmware that we want
-	 * a discontiguous, or non-zero based, range of MSI-X entries.
-	 * So we must reject such requests. */
-
-	expected =3D 0;
-	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->msi_attrib.entry_nr !=3D expected) {
-			pr_debug("rtas_msi: bad MSI-X entries.\n");
-			return -EINVAL;
-		}
-		expected++;
-	}
-
-	return 0;
-}
-
 static void rtas_hack_32bit_msi_gen2(struct pci_dev *pdev)
 {
 	u32 addr_hi, addr_lo;
@@ -380,9 +359,6 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, in=
t nvec_in, int type,
 	if (quota && quota < nvec)
 		return quota;
=20
-	if (type =3D=3D PCI_CAP_ID_MSIX && check_msix_entries(pdev))
-		return -EINVAL;
-
 	/*
 	 * Firmware currently refuse any non power of two allocation
 	 * so we round up if the quota will allow it.
@@ -448,8 +424,7 @@ static int pseries_msi_ops_prepare(struct irq_domain *dom=
ain, struct device *dev
 				   int nvec, msi_alloc_info_t *arg)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
-	struct msi_desc *desc =3D first_pci_msi_entry(pdev);
-	int type =3D desc->msi_attrib.is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
+	int type =3D pdev->msix_enabled ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
=20
 	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
 }
@@ -530,9 +505,16 @@ static struct irq_chip pseries_pci_msi_irq_chip =3D {
 	.irq_write_msi_msg	=3D pseries_msi_write_msg,
 };
=20
+
+/*
+ * Set MSI_FLAG_MSIX_CONTIGUOUS as there is no way to express to
+ * firmware to request a discontiguous or non-zero based range of
+ * MSI-X entries. Core code will reject such setup attempts.
+ */
 static struct msi_domain_info pseries_msi_domain_info =3D {
 	.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX),
+		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX |
+		  MSI_FLAG_MSIX_CONTIGUOUS),
 	.ops   =3D &pseries_pci_msi_domain_ops,
 	.chip  =3D &pseries_pci_msi_irq_chip,
 };
@@ -580,7 +562,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *do=
main, unsigned int virq
 	int hwirq;
 	int i, ret;
=20
-	hwirq =3D rtas_query_irq_number(pci_get_pdn(pdev), desc->msi_attrib.entry_n=
r);
+	hwirq =3D rtas_query_irq_number(pci_get_pdn(pdev), desc->msi_index);
 	if (hwirq < 0) {
 		dev_err(&pdev->dev, "Failed to query HW IRQ: %d\n", hwirq);
 		return hwirq;
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 9ebcc1337560..5aa92ff3622d 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -12,17 +12,11 @@ config PPC4xx_HSTA_MSI
 	depends on PCI_MSI
 	depends on PCI && 4xx
=20
-config PPC4xx_MSI
-	bool
-	depends on PCI_MSI
-	depends on PCI && 4xx
-
 config PPC_MSI_BITMAP
 	bool
 	depends on PCI_MSI
 	default y if MPIC
 	default y if FSL_PCI
-	default y if PPC4xx_MSI
 	default y if PPC_POWERNV
=20
 source "arch/powerpc/sysdev/xics/Kconfig"
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index e6b06c3f8197..b3475ae9f236 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -125,17 +125,13 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	struct fsl_msi *msi_data;
 	irq_hw_number_t hwirq;
=20
-	for_each_pci_msi_entry(entry, pdev) {
-		if (!entry->irq)
-			continue;
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		hwirq =3D virq_to_hw(entry->irq);
 		msi_data =3D irq_get_chip_data(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 		msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
 	}
-
-	return;
 }
=20
 static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
@@ -215,7 +211,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int n=
vec, int type)
 		}
 	}
=20
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		/*
 		 * Loop over all the MSI devices until we find one that has an
 		 * available interrupt.
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3ms=
i.c
index 3861023d378a..fa53b6d85ef9 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -104,17 +104,12 @@ static void u3msi_teardown_msi_irqs(struct pci_dev *pde=
v)
 	struct msi_desc *entry;
 	irq_hw_number_t hwirq;
=20
-	for_each_pci_msi_entry(entry, pdev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		hwirq =3D virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
 	}
-
-	return;
 }
=20
 static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
@@ -136,7 +131,7 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int=
 nvec, int type)
 		return -ENXIO;
 	}
=20
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		hwirq =3D msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap, 1);
 		if (hwirq < 0) {
 			pr_debug("u3msi: failed allocating hwirq\n");
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 954bb7a83124..0975ff3ba046 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -303,7 +303,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, i=
nt type)
=20
 	/* Request MSI interrupts */
 	hwirq =3D bit;
-	for_each_pci_msi_entry(msi, pdev) {
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		rc =3D -EIO;
 		if (hwirq - bit >=3D msi_vecs)
 			break;
@@ -362,9 +362,7 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		return;
=20
 	/* Release MSI interrupts */
-	for_each_pci_msi_entry(msi, pdev) {
-		if (!msi->irq)
-			continue;
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo =3D 0;
@@ -387,13 +385,13 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
 }
=20
-void arch_restore_msi_irqs(struct pci_dev *pdev)
+bool arch_restore_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev =3D to_zpci(pdev);
=20
 	if (!zdev->irqs_registered)
 		zpci_set_irq(zdev);
-	default_restore_msi_irqs(pdev);
+	return true;
 }
=20
 static struct airq_struct zpci_airq =3D {
diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index fb5899cbfa51..9ed11985768e 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -146,13 +146,13 @@ static int sparc64_setup_msi_irq(unsigned int *irq_p,
 	msiqid =3D pick_msiq(pbm);
=20
 	err =3D ops->msi_setup(pbm, msiqid, msi,
-			     (entry->msi_attrib.is_64 ? 1 : 0));
+			     (entry->pci.msi_attrib.is_64 ? 1 : 0));
 	if (err)
 		goto out_msi_free;
=20
 	pbm->msi_irq_table[msi - pbm->msi_first] =3D *irq_p;
=20
-	if (entry->msi_attrib.is_64) {
+	if (entry->pci.msi_attrib.is_64) {
 		msg.address_hi =3D pbm->msi64_start >> 32;
 		msg.address_lo =3D pbm->msi64_start & 0xffffffff;
 	} else {
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 514fc64e23d5..7e0f6bedc248 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -253,64 +253,43 @@ static int hv_unmap_msi_interrupt(struct pci_dev *dev, =
struct hv_interrupt_entry
 	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry);
 }
=20
-static void hv_teardown_msi_irq_common(struct pci_dev *dev, struct msi_desc =
*msidesc, int irq)
+static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
 {
-	u64 status;
 	struct hv_interrupt_entry old_entry;
-	struct irq_desc *desc;
-	struct irq_data *data;
 	struct msi_msg msg;
+	u64 status;
=20
-	desc =3D irq_to_desc(irq);
-	if (!desc) {
-		pr_debug("%s: no irq desc\n", __func__);
-		return;
-	}
-
-	data =3D &desc->irq_data;
-	if (!data) {
-		pr_debug("%s: no irq data\n", __func__);
-		return;
-	}
-
-	if (!data->chip_data) {
+	if (!irqd->chip_data) {
 		pr_debug("%s: no chip data\n!", __func__);
 		return;
 	}
=20
-	old_entry =3D *(struct hv_interrupt_entry *)data->chip_data;
+	old_entry =3D *(struct hv_interrupt_entry *)irqd->chip_data;
 	entry_to_msi_msg(&old_entry, &msg);
=20
-	kfree(data->chip_data);
-	data->chip_data =3D NULL;
+	kfree(irqd->chip_data);
+	irqd->chip_data =3D NULL;
=20
 	status =3D hv_unmap_msi_interrupt(dev, &old_entry);
=20
-	if (status !=3D HV_STATUS_SUCCESS) {
+	if (status !=3D HV_STATUS_SUCCESS)
 		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
-		return;
-	}
 }
=20
-static void hv_msi_domain_free_irqs(struct irq_domain *domain, struct device=
 *dev)
+static void hv_msi_free_irq(struct irq_domain *domain,
+			    struct msi_domain_info *info, unsigned int virq)
 {
-	int i;
-	struct msi_desc *entry;
-	struct pci_dev *pdev;
+	struct irq_data *irqd =3D irq_get_irq_data(virq);
+	struct msi_desc *desc;
=20
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+	if (!irqd)
 		return;
=20
-	pdev =3D to_pci_dev(dev);
+	desc =3D irq_data_get_msi_desc(irqd);
+	if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
+		return;
=20
-	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq) {
-			for (i =3D 0; i < entry->nvec_used; i++) {
-				hv_teardown_msi_irq_common(pdev, entry, entry->irq + i);
-				irq_domain_free_irqs(entry->irq + i, 1);
-			}
-		}
-	}
+	hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
 }
=20
 /*
@@ -329,7 +308,7 @@ static struct irq_chip hv_pci_msi_controller =3D {
 };
=20
 static struct msi_domain_ops pci_msi_domain_ops =3D {
-	.domain_free_irqs	=3D hv_msi_domain_free_irqs,
+	.msi_free		=3D hv_msi_free_irq,
 	.msi_prepare		=3D pci_msi_prepare,
 };
=20
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 5c69f7eb5d47..22b7412c08f6 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -289,12 +289,6 @@ struct x86_platform_ops {
 	struct x86_hyper_runtime hyper;
 };
=20
-struct pci_dev;
-
-struct x86_msi_ops {
-	void (*restore_msi_irqs)(struct pci_dev *dev);
-};
-
 struct x86_apic_ops {
 	unsigned int	(*io_apic_read)   (unsigned int apic, unsigned int reg);
 	void		(*restore)(void);
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen=
/hypervisor.h
index 5adab895127e..1bf2ad34188a 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -57,6 +57,14 @@ static inline bool __init xen_x2apic_para_available(void)
 }
 #endif
=20
+struct pci_dev;
+
+#ifdef CONFIG_XEN_PV_DOM0
+bool xen_initdom_restore_msi(struct pci_dev *dev);
+#else
+static inline bool xen_initdom_restore_msi(struct pci_dev *dev) { return tru=
e; }
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
 void xen_arch_register_cpu(int num);
 void xen_arch_unregister_cpu(int num);
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index dbacb9ec8843..7517eb05bdc1 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -19,6 +19,7 @@
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
+#include <asm/xen/hypervisor.h>
=20
 struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
=20
@@ -159,11 +160,8 @@ static struct irq_chip pci_msi_controller =3D {
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
-	struct pci_dev *pdev =3D to_pci_dev(dev);
-	struct msi_desc *desc =3D first_pci_msi_entry(pdev);
-
 	init_irq_alloc_info(arg, NULL);
-	if (desc->msi_attrib.is_msix) {
+	if (to_pci_dev(dev)->msix_enabled) {
 		arg->type =3D X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
 		arg->type =3D X86_IRQ_ALLOC_TYPE_PCI_MSI;
@@ -345,3 +343,8 @@ void dmar_free_hwirq(int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 #endif
+
+bool arch_restore_msi_irqs(struct pci_dev *dev)
+{
+	return xen_initdom_restore_msi(dev);
+}
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 8b395821cb8d..7d20c1d34a3c 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -145,18 +145,6 @@ struct x86_platform_ops x86_platform __ro_after_init =3D=
 {
=20
 EXPORT_SYMBOL_GPL(x86_platform);
=20
-#if defined(CONFIG_PCI_MSI)
-struct x86_msi_ops x86_msi __ro_after_init =3D {
-	.restore_msi_irqs	=3D default_restore_msi_irqs,
-};
-
-/* MSI arch specific hooks */
-void arch_restore_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.restore_msi_irqs(dev);
-}
-#endif
-
 struct x86_apic_ops x86_apic_ops __ro_after_init =3D {
 	.io_apic_read	=3D native_io_apic_read,
 	.restore	=3D native_restore_boot_irq_mode,
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 12da00558631..9bb1e2941179 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -184,7 +184,7 @@ static int xen_setup_msi_irqs(struct pci_dev *dev, int nv=
ec, int type)
 	if (ret)
 		goto error;
 	i =3D 0;
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		irq =3D xen_bind_pirq_msi_to_irq(dev, msidesc, v[i],
 					       (type =3D=3D PCI_CAP_ID_MSI) ? nvec : 1,
 					       (type =3D=3D PCI_CAP_ID_MSIX) ?
@@ -235,7 +235,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, in=
t nvec, int type)
 	if (type =3D=3D PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
=20
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		pirq =3D xen_allocate_pirq_msi(dev, msidesc);
 		if (pirq < 0) {
 			irq =3D -ENODEV;
@@ -270,7 +270,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev=
, int nvec, int type)
 	int ret =3D 0;
 	struct msi_desc *msidesc;
=20
-	for_each_pci_msi_entry(msidesc, dev) {
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		struct physdev_map_pirq map_irq;
 		domid_t domid;
=20
@@ -306,7 +306,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev=
, int nvec, int type)
 				return -EINVAL;
=20
 			map_irq.table_base =3D pci_resource_start(dev, bir);
-			map_irq.entry_nr =3D msidesc->msi_attrib.entry_nr;
+			map_irq.entry_nr =3D msidesc->msi_index;
 		}
=20
 		ret =3D -EINVAL;
@@ -351,10 +351,13 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *d=
ev, int nvec, int type)
 	return ret;
 }
=20
-static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
+bool xen_initdom_restore_msi(struct pci_dev *dev)
 {
 	int ret =3D 0;
=20
+	if (!xen_initial_domain())
+		return true;
+
 	if (pci_seg_supported) {
 		struct physdev_pci_device restore_ext;
=20
@@ -375,10 +378,10 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev=
 *dev)
 		ret =3D HYPERVISOR_physdev_op(PHYSDEVOP_restore_msi, &restore);
 		WARN(ret && ret !=3D -ENOSYS, "restore_msi -> %d\n", ret);
 	}
+	return false;
 }
 #else /* CONFIG_XEN_PV_DOM0 */
 #define xen_initdom_setup_msi_irqs	NULL
-#define xen_initdom_restore_msi_irqs	NULL
 #endif /* !CONFIG_XEN_PV_DOM0 */
=20
 static void xen_teardown_msi_irqs(struct pci_dev *dev)
@@ -386,19 +389,15 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 	struct msi_desc *msidesc;
 	int i;
=20
-	for_each_pci_msi_entry(msidesc, dev) {
-		if (msidesc->irq) {
-			for (i =3D 0; i < msidesc->nvec_used; i++)
-				xen_destroy_irq(msidesc->irq + i);
-		}
+	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_ASSOCIATED) {
+		for (i =3D 0; i < msidesc->nvec_used; i++)
+			xen_destroy_irq(msidesc->irq + i);
 	}
 }
=20
 static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
 {
-	struct msi_desc *msidesc =3D first_pci_msi_entry(dev);
-
-	if (msidesc->msi_attrib.is_msix)
+	if (dev->msix_enabled)
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
@@ -414,10 +413,7 @@ static int xen_msi_domain_alloc_irqs(struct irq_domain *=
domain,
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return -EINVAL;
=20
-	if (first_msi_entry(dev)->msi_attrib.is_msix)
-		type =3D PCI_CAP_ID_MSIX;
-	else
-		type =3D PCI_CAP_ID_MSI;
+	type =3D to_pci_dev(dev)->msix_enabled ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
=20
 	return xen_msi_ops.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }
@@ -466,12 +462,10 @@ static __init struct irq_domain *xen_create_pci_msi_dom=
ain(void)
 static __init void xen_setup_pci_msi(void)
 {
 	if (xen_pv_domain()) {
-		if (xen_initial_domain()) {
+		if (xen_initial_domain())
 			xen_msi_ops.setup_msi_irqs =3D xen_initdom_setup_msi_irqs;
-			x86_msi.restore_msi_irqs =3D xen_initdom_restore_msi_irqs;
-		} else {
+		else
 			xen_msi_ops.setup_msi_irqs =3D xen_setup_msi_irqs;
-		}
 		xen_msi_ops.teardown_msi_irqs =3D xen_pv_teardown_msi_irqs;
 		pci_msi_ignore_mask =3D 1;
 	} else if (xen_hvm_domain()) {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd034d742447..f8987867789f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2874,10 +2874,6 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
 	set_dev_node(dev, NUMA_NO_NODE);
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	raw_spin_lock_init(&dev->msi_lock);
-	INIT_LIST_HEAD(&dev->msi_list);
-#endif
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.defer_sync);
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 3d6c8f9caf43..296ea673d661 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -23,7 +23,6 @@
 struct platform_msi_priv_data {
 	struct device			*dev;
 	void				*host_data;
-	const struct attribute_group    **msi_irq_groups;
 	msi_alloc_info_t		arg;
 	irq_write_msi_msg_t		write_msg;
 	int				devid;
@@ -39,11 +38,9 @@ static DEFINE_IDA(platform_msi_devid_ida);
  */
 static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
 {
-	u32 devid;
+	u32 devid =3D desc->dev->msi.data->platform_data->devid;
=20
-	devid =3D desc->platform.msi_priv_data->devid;
-
-	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
+	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
 }
=20
 static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *de=
sc)
@@ -86,11 +83,8 @@ static void platform_msi_update_dom_ops(struct msi_domain_=
info *info)
 static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *ms=
g)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
-	struct platform_msi_priv_data *priv_data;
-
-	priv_data =3D desc->platform.msi_priv_data;
=20
-	priv_data->write_msg(desc, msg);
+	desc->dev->msi.data->platform_data->write_msg(desc, msg);
 }
=20
 static void platform_msi_update_chip_ops(struct msi_domain_info *info)
@@ -113,62 +107,6 @@ static void platform_msi_update_chip_ops(struct msi_doma=
in_info *info)
 		info->flags &=3D ~MSI_FLAG_LEVEL_CAPABLE;
 }
=20
-static void platform_msi_free_descs(struct device *dev, int base, int nvec)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		if (desc->platform.msi_index >=3D base &&
-		    desc->platform.msi_index < (base + nvec)) {
-			list_del(&desc->list);
-			free_msi_entry(desc);
-		}
-	}
-}
-
-static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
-					     int nvec,
-					     struct platform_msi_priv_data *data)
-
-{
-	struct msi_desc *desc;
-	int i, base =3D 0;
-
-	if (!list_empty(dev_to_msi_list(dev))) {
-		desc =3D list_last_entry(dev_to_msi_list(dev),
-				       struct msi_desc, list);
-		base =3D desc->platform.msi_index + 1;
-	}
-
-	for (i =3D 0; i < nvec; i++) {
-		desc =3D alloc_msi_entry(dev, 1, NULL);
-		if (!desc)
-			break;
-
-		desc->platform.msi_priv_data =3D data;
-		desc->platform.msi_index =3D base + i;
-		desc->irq =3D virq ? virq + i : 0;
-
-		list_add_tail(&desc->list, dev_to_msi_list(dev));
-	}
-
-	if (i !=3D nvec) {
-		/* Clean up the mess */
-		platform_msi_free_descs(dev, base, nvec);
-
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int platform_msi_alloc_descs(struct device *dev, int nvec,
-				    struct platform_msi_priv_data *data)
-
-{
-	return platform_msi_alloc_descs_with_irq(dev, 0, nvec, data);
-}
-
 /**
  * platform_msi_create_irq_domain - Create a platform MSI interrupt domain
  * @fwnode:		Optional fwnode of the interrupt controller
@@ -191,6 +129,8 @@ struct irq_domain *platform_msi_create_irq_domain(struct =
fwnode_handle *fwnode,
 		platform_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		platform_msi_update_chip_ops(info);
+	info->flags |=3D MSI_FLAG_DEV_SYSFS | MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
+		       MSI_FLAG_FREE_MSI_DESCS;
=20
 	domain =3D msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -199,49 +139,57 @@ struct irq_domain *platform_msi_create_irq_domain(struc=
t fwnode_handle *fwnode,
 	return domain;
 }
=20
-static struct platform_msi_priv_data *
-platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
-			     irq_write_msi_msg_t write_msi_msg)
+static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nve=
c,
+					irq_write_msi_msg_t write_msi_msg)
 {
 	struct platform_msi_priv_data *datap;
+	int err;
+
 	/*
 	 * Limit the number of interrupts to 2048 per device. Should we
 	 * need to bump this up, DEV_ID_SHIFT should be adjusted
 	 * accordingly (which would impact the max number of MSI
 	 * capable devices).
 	 */
-	if (!dev->msi_domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
-		return ERR_PTR(-EINVAL);
+	if (!dev->msi.domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
+		return -EINVAL;
=20
-	if (dev->msi_domain->bus_token !=3D DOMAIN_BUS_PLATFORM_MSI) {
+	if (dev->msi.domain->bus_token !=3D DOMAIN_BUS_PLATFORM_MSI) {
 		dev_err(dev, "Incompatible msi_domain, giving up\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
=20
-	/* Already had a helping of MSI? Greed... */
-	if (!list_empty(dev_to_msi_list(dev)))
-		return ERR_PTR(-EBUSY);
+	err =3D msi_setup_device_data(dev);
+	if (err)
+		return err;
+
+	/* Already initialized? */
+	if (dev->msi.data->platform_data)
+		return -EBUSY;
=20
 	datap =3D kzalloc(sizeof(*datap), GFP_KERNEL);
 	if (!datap)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
=20
 	datap->devid =3D ida_simple_get(&platform_msi_devid_ida,
 				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
 	if (datap->devid < 0) {
-		int err =3D datap->devid;
+		err =3D datap->devid;
 		kfree(datap);
-		return ERR_PTR(err);
+		return err;
 	}
=20
 	datap->write_msg =3D write_msi_msg;
 	datap->dev =3D dev;
-
-	return datap;
+	dev->msi.data->platform_data =3D datap;
+	return 0;
 }
=20
-static void platform_msi_free_priv_data(struct platform_msi_priv_data *data)
+static void platform_msi_free_priv_data(struct device *dev)
 {
+	struct platform_msi_priv_data *data =3D dev->msi.data->platform_data;
+
+	dev->msi.data->platform_data =3D NULL;
 	ida_simple_remove(&platform_msi_devid_ida, data->devid);
 	kfree(data);
 }
@@ -258,35 +206,15 @@ static void platform_msi_free_priv_data(struct platform=
_msi_priv_data *data)
 int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 				   irq_write_msi_msg_t write_msi_msg)
 {
-	struct platform_msi_priv_data *priv_data;
 	int err;
=20
-	priv_data =3D platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (IS_ERR(priv_data))
-		return PTR_ERR(priv_data);
-
-	err =3D platform_msi_alloc_descs(dev, nvec, priv_data);
+	err =3D platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
 	if (err)
-		goto out_free_priv_data;
+		return err;
=20
-	err =3D msi_domain_alloc_irqs(dev->msi_domain, dev, nvec);
+	err =3D msi_domain_alloc_irqs(dev->msi.domain, dev, nvec);
 	if (err)
-		goto out_free_desc;
-
-	priv_data->msi_irq_groups =3D msi_populate_sysfs(dev);
-	if (IS_ERR(priv_data->msi_irq_groups)) {
-		err =3D PTR_ERR(priv_data->msi_irq_groups);
-		goto out_free_irqs;
-	}
-
-	return 0;
-
-out_free_irqs:
-	msi_domain_free_irqs(dev->msi_domain, dev);
-out_free_desc:
-	platform_msi_free_descs(dev, 0, nvec);
-out_free_priv_data:
-	platform_msi_free_priv_data(priv_data);
+		platform_msi_free_priv_data(dev);
=20
 	return err;
 }
@@ -298,16 +226,8 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
  */
 void platform_msi_domain_free_irqs(struct device *dev)
 {
-	if (!list_empty(dev_to_msi_list(dev))) {
-		struct msi_desc *desc;
-
-		desc =3D first_msi_entry(dev);
-		msi_destroy_sysfs(dev, desc->platform.msi_priv_data->msi_irq_groups);
-		platform_msi_free_priv_data(desc->platform.msi_priv_data);
-	}
-
-	msi_domain_free_irqs(dev->msi_domain, dev);
-	platform_msi_free_descs(dev, 0, MAX_DEV_MSIS);
+	msi_domain_free_irqs(dev->msi.domain, dev);
+	platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
=20
@@ -316,17 +236,20 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
  *                              a platform-msi domain
  * @domain:	The platform-msi domain
  *
- * Returns the private data provided when calling
- * platform_msi_create_device_domain.
+ * Return: The private data provided when calling
+ * platform_msi_create_device_domain().
  */
 void *platform_msi_get_host_data(struct irq_domain *domain)
 {
 	struct platform_msi_priv_data *data =3D domain->host_data;
+
 	return data->host_data;
 }
=20
+static struct lock_class_key platform_device_msi_lock_class;
+
 /**
- * __platform_msi_create_device_domain - Create a platform-msi domain
+ * __platform_msi_create_device_domain - Create a platform-msi device domain
  *
  * @dev:		The device generating the MSIs
  * @nvec:		The number of MSIs that need to be allocated
@@ -335,7 +258,11 @@ void *platform_msi_get_host_data(struct irq_domain *doma=
in)
  * @ops:		The hierarchy domain operations to use
  * @host_data:		Private data associated to this domain
  *
- * Returns an irqdomain for @nvec interrupts
+ * Return: An irqdomain for @nvec interrupts on success, NULL in case of err=
or.
+ *
+ * This is for interrupt domains which stack on a platform-msi domain
+ * created by platform_msi_create_irq_domain(). @dev->msi.domain points to
+ * that platform-msi domain which is the parent for the new domain.
  */
 struct irq_domain *
 __platform_msi_create_device_domain(struct device *dev,
@@ -349,12 +276,20 @@ __platform_msi_create_device_domain(struct device *dev,
 	struct irq_domain *domain;
 	int err;
=20
-	data =3D platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (IS_ERR(data))
+	err =3D platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
+	if (err)
 		return NULL;
=20
+	/*
+	 * Use a separate lock class for the MSI descriptor mutex on
+	 * platform MSI device domains because the descriptor mutex nests
+	 * into the domain mutex. See alloc/free below.
+	 */
+	lockdep_set_class(&dev->msi.data->mutex, &platform_device_msi_lock_class);
+
+	data =3D dev->msi.data->platform_data;
 	data->host_data =3D host_data;
-	domain =3D irq_domain_create_hierarchy(dev->msi_domain, 0,
+	domain =3D irq_domain_create_hierarchy(dev->msi.domain, 0,
 					     is_tree ? 0 : nvec,
 					     dev->fwnode, ops, data);
 	if (!domain)
@@ -370,61 +305,46 @@ __platform_msi_create_device_domain(struct device *dev,
 free_domain:
 	irq_domain_remove(domain);
 free_priv:
-	platform_msi_free_priv_data(data);
+	platform_msi_free_priv_data(dev);
 	return NULL;
 }
=20
 /**
- * platform_msi_domain_free - Free interrupts associated with a platform-msi
- *                            domain
+ * platform_msi_device_domain_free - Free interrupts associated with a platf=
orm-msi
+ *				     device domain
  *
- * @domain:	The platform-msi domain
+ * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the free operation
- * @nvec:	How many interrupts to free from @virq
+ * @nr_irqs:	How many interrupts to free from @virq
  */
-void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nvec)
+void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int=
 virq,
+				     unsigned int nr_irqs)
 {
 	struct platform_msi_priv_data *data =3D domain->host_data;
-	struct msi_desc *desc, *tmp;
-	for_each_msi_entry_safe(desc, tmp, data->dev) {
-		if (WARN_ON(!desc->irq || desc->nvec_used !=3D 1))
-			return;
-		if (!(desc->irq >=3D virq && desc->irq < (virq + nvec)))
-			continue;
-
-		irq_domain_free_irqs_common(domain, desc->irq, 1);
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
+
+	msi_lock_descs(data->dev);
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+	msi_free_msi_descs_range(data->dev, MSI_DESC_ALL, virq, virq + nr_irqs - 1);
+	msi_unlock_descs(data->dev);
 }
=20
 /**
- * platform_msi_domain_alloc - Allocate interrupts associated with
- *			       a platform-msi domain
+ * platform_msi_device_domain_alloc - Allocate interrupts associated with
+ *				      a platform-msi device domain
  *
- * @domain:	The platform-msi domain
+ * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the allocate operation
- * @nr_irqs:	How many interrupts to free from @virq
+ * @nr_irqs:	How many interrupts to allocate from @virq
  *
  * Return 0 on success, or an error code on failure. Must be called
  * with irq_domain_mutex held (which can only be done as part of a
  * top-level interrupt allocation).
  */
-int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nr_irqs)
+int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int=
 virq,
+				     unsigned int nr_irqs)
 {
 	struct platform_msi_priv_data *data =3D domain->host_data;
-	int err;
-
-	err =3D platform_msi_alloc_descs_with_irq(data->dev, virq, nr_irqs, data);
-	if (err)
-		return err;
-
-	err =3D msi_domain_populate_irqs(domain->parent, data->dev,
-				       virq, nr_irqs, &data->arg);
-	if (err)
-		platform_msi_domain_free(domain, virq, nr_irqs);
+	struct device *dev =3D data->dev;
=20
-	return err;
+	return msi_domain_populate_irqs(domain->parent, dev, virq, nr_irqs, &data->=
arg);
 }
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-drive=
r.c
index 315e830b6ecd..5e70f9775a0e 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -400,7 +400,7 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, =
void *arg)
 	struct fsl_mc_device *mc_dev =3D to_fsl_mc_device(dev);
 	struct fsl_mc_bus *mc_bus =3D to_fsl_mc_bus(mc_dev);
 	struct fsl_mc_io *mc_io =3D mc_dev->mc_io;
-	struct msi_desc *msi_desc =3D mc_dev->irqs[0]->msi_desc;
+	int irq =3D mc_dev->irqs[0]->virq;
=20
 	dev_dbg(dev, "DPRC IRQ %d triggered on CPU %u\n",
 		irq_num, smp_processor_id());
@@ -409,7 +409,7 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, =
void *arg)
 		return IRQ_HANDLED;
=20
 	mutex_lock(&mc_bus->scan_mutex);
-	if (!msi_desc || msi_desc->irq !=3D (u32)irq_num)
+	if (irq !=3D (u32)irq_num)
 		goto out;
=20
 	status =3D 0;
@@ -521,7 +521,7 @@ static int register_dprc_irq_handler(struct fsl_mc_device=
 *mc_dev)
 	 * function that programs the MSI physically in the device
 	 */
 	error =3D devm_request_threaded_irq(&mc_dev->dev,
-					  irq->msi_desc->irq,
+					  irq->virq,
 					  dprc_irq0_handler,
 					  dprc_irq0_handler_thread,
 					  IRQF_NO_SUSPEND | IRQF_ONESHOT,
@@ -771,7 +771,7 @@ static void dprc_teardown_irq(struct fsl_mc_device *mc_de=
v)
=20
 	(void)disable_dprc_irq(mc_dev);
=20
-	devm_free_irq(&mc_dev->dev, irq->msi_desc->irq, &mc_dev->dev);
+	devm_free_irq(&mc_dev->dev, irq->virq, &mc_dev->dev);
=20
 	fsl_mc_free_irqs(mc_dev);
 }
diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-m=
c-allocator.c
index 6c513556911e..dced427ca8ba 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -350,7 +350,6 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_device *mc_bus=
_dev,
 			     unsigned int irq_count)
 {
 	unsigned int i;
-	struct msi_desc *msi_desc;
 	struct fsl_mc_device_irq *irq_resources;
 	struct fsl_mc_device_irq *mc_dev_irq;
 	int error;
@@ -388,16 +387,12 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_device *mc_b=
us_dev,
 		mc_dev_irq->resource.type =3D res_pool->type;
 		mc_dev_irq->resource.data =3D mc_dev_irq;
 		mc_dev_irq->resource.parent_pool =3D res_pool;
+		mc_dev_irq->virq =3D msi_get_virq(&mc_bus_dev->dev, i);
+		mc_dev_irq->resource.id =3D mc_dev_irq->virq;
 		INIT_LIST_HEAD(&mc_dev_irq->resource.node);
 		list_add_tail(&mc_dev_irq->resource.node, &res_pool->free_list);
 	}
=20
-	for_each_msi_entry(msi_desc, &mc_bus_dev->dev) {
-		mc_dev_irq =3D &irq_resources[msi_desc->fsl_mc.msi_index];
-		mc_dev_irq->msi_desc =3D msi_desc;
-		mc_dev_irq->resource.id =3D msi_desc->irq;
-	}
-
 	res_pool->max_count =3D irq_count;
 	res_pool->free_count =3D irq_count;
 	mc_bus->irq_resources =3D irq_resources;
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index cf974870ba55..5e0e4393ce4d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -29,7 +29,7 @@ static irq_hw_number_t fsl_mc_domain_calc_hwirq(struct fsl_=
mc_device *dev,
 	 * Make the base hwirq value for ICID*10000 so it is readable
 	 * as a decimal value in /proc/interrupts.
 	 */
-	return (irq_hw_number_t)(desc->fsl_mc.msi_index + (dev->icid * 10000));
+	return (irq_hw_number_t)(desc->msi_index + (dev->icid * 10000));
 }
=20
 static void fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
@@ -58,11 +58,11 @@ static void fsl_mc_msi_update_dom_ops(struct msi_domain_i=
nfo *info)
 }
=20
 static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
-				   struct fsl_mc_device_irq *mc_dev_irq)
+				   struct fsl_mc_device_irq *mc_dev_irq,
+				   struct msi_desc *msi_desc)
 {
 	int error;
 	struct fsl_mc_device *owner_mc_dev =3D mc_dev_irq->mc_dev;
-	struct msi_desc *msi_desc =3D mc_dev_irq->msi_desc;
 	struct dprc_irq_cfg irq_cfg;
=20
 	/*
@@ -122,14 +122,14 @@ static void fsl_mc_msi_write_msg(struct irq_data *irq_d=
ata,
 	struct fsl_mc_device *mc_bus_dev =3D to_fsl_mc_device(msi_desc->dev);
 	struct fsl_mc_bus *mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_device_irq *mc_dev_irq =3D
-		&mc_bus->irq_resources[msi_desc->fsl_mc.msi_index];
+		&mc_bus->irq_resources[msi_desc->msi_index];
=20
 	msi_desc->msg =3D *msg;
=20
 	/*
 	 * Program the MSI (paddr, value) pair in the device:
 	 */
-	__fsl_mc_msi_write_msg(mc_bus_dev, mc_dev_irq);
+	__fsl_mc_msi_write_msg(mc_bus_dev, mc_dev_irq, msi_desc);
 }
=20
 static void fsl_mc_msi_update_chip_ops(struct msi_domain_info *info)
@@ -170,6 +170,7 @@ struct irq_domain *fsl_mc_msi_create_irq_domain(struct fw=
node_handle *fwnode,
 		fsl_mc_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		fsl_mc_msi_update_chip_ops(info);
+	info->flags |=3D MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
=20
 	domain =3D msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -210,61 +211,21 @@ struct irq_domain *fsl_mc_find_msi_domain(struct device=
 *dev)
 	return msi_domain;
 }
=20
-static void fsl_mc_msi_free_descs(struct device *dev)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
-}
-
-static int fsl_mc_msi_alloc_descs(struct device *dev, unsigned int irq_count)
-
-{
-	unsigned int i;
-	int error;
-	struct msi_desc *msi_desc;
-
-	for (i =3D 0; i < irq_count; i++) {
-		msi_desc =3D alloc_msi_entry(dev, 1, NULL);
-		if (!msi_desc) {
-			dev_err(dev, "Failed to allocate msi entry\n");
-			error =3D -ENOMEM;
-			goto cleanup_msi_descs;
-		}
-
-		msi_desc->fsl_mc.msi_index =3D i;
-		INIT_LIST_HEAD(&msi_desc->list);
-		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-	}
-
-	return 0;
-
-cleanup_msi_descs:
-	fsl_mc_msi_free_descs(dev);
-	return error;
-}
-
-int fsl_mc_msi_domain_alloc_irqs(struct device *dev,
-				 unsigned int irq_count)
+int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 {
 	struct irq_domain *msi_domain;
 	int error;
=20
-	if (!list_empty(dev_to_msi_list(dev)))
+	msi_domain =3D dev_get_msi_domain(dev);
+	if (!msi_domain)
 		return -EINVAL;
=20
-	error =3D fsl_mc_msi_alloc_descs(dev, irq_count);
-	if (error < 0)
+	error =3D msi_setup_device_data(dev);
+	if (error)
 		return error;
=20
-	msi_domain =3D dev_get_msi_domain(dev);
-	if (!msi_domain) {
-		error =3D -EINVAL;
-		goto cleanup_msi_descs;
-	}
+	if (msi_first_desc(dev, MSI_DESC_ALL))
+		return -EINVAL;
=20
 	/*
 	 * NOTE: Calling this function will trigger the invocation of the
@@ -272,15 +233,8 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,
 	 */
 	error =3D msi_domain_alloc_irqs(msi_domain, dev, irq_count);
=20
-	if (error) {
+	if (error)
 		dev_err(dev, "Failed to allocate IRQs\n");
-		goto cleanup_msi_descs;
-	}
-
-	return 0;
-
-cleanup_msi_descs:
-	fsl_mc_msi_free_descs(dev);
 	return error;
 }
=20
@@ -293,9 +247,4 @@ void fsl_mc_msi_domain_free_irqs(struct device *dev)
 		return;
=20
 	msi_domain_free_irqs(msi_domain, dev);
-
-	if (list_empty(dev_to_msi_list(dev)))
-		return;
-
-	fsl_mc_msi_free_descs(dev);
 }
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 9b0d463f89bb..9c8b4084ba2f 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -149,7 +149,7 @@ struct mv_xor_v2_descriptor {
  * @desc_size: HW descriptor size
  * @npendings: number of pending descriptors (for which tx_submit has
  * @hw_queue_idx: HW queue index
- * @msi_desc: local interrupt descriptor information
+ * @irq: The Linux interrupt number
  * been called, but not yet issue_pending)
  */
 struct mv_xor_v2_device {
@@ -168,7 +168,7 @@ struct mv_xor_v2_device {
 	int desc_size;
 	unsigned int npendings;
 	unsigned int hw_queue_idx;
-	struct msi_desc *msi_desc;
+	unsigned int irq;
 };
=20
 /**
@@ -718,7 +718,6 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	int i, ret =3D 0;
 	struct dma_device *dma_dev;
 	struct mv_xor_v2_sw_desc *sw_desc;
-	struct msi_desc *msi_desc;
=20
 	BUILD_BUG_ON(sizeof(struct mv_xor_v2_descriptor) !=3D
 		     MV_XOR_V2_EXT_DESC_SIZE);
@@ -770,14 +769,9 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
=20
-	msi_desc =3D first_msi_entry(&pdev->dev);
-	if (!msi_desc) {
-		ret =3D -ENODEV;
-		goto free_msi_irqs;
-	}
-	xor_dev->msi_desc =3D msi_desc;
+	xor_dev->irq =3D msi_get_virq(&pdev->dev, 0);
=20
-	ret =3D devm_request_irq(&pdev->dev, msi_desc->irq,
+	ret =3D devm_request_irq(&pdev->dev, xor_dev->irq,
 			       mv_xor_v2_interrupt_handler, 0,
 			       dev_name(&pdev->dev), xor_dev);
 	if (ret)
@@ -892,7 +886,7 @@ static int mv_xor_v2_remove(struct platform_device *pdev)
 			  xor_dev->desc_size * MV_XOR_V2_DESC_NUM,
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
=20
-	devm_free_irq(&pdev->dev, xor_dev->msi_desc->irq, xor_dev);
+	devm_free_irq(&pdev->dev, xor_dev->irq, xor_dev);
=20
 	platform_msi_domain_free_irqs(&pdev->dev);
=20
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 23d64489d25f..65d054bb11aa 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -666,7 +666,7 @@ static void hidma_write_msi_msg(struct msi_desc *desc, st=
ruct msi_msg *msg)
 	struct device *dev =3D msi_desc_to_dev(desc);
 	struct hidma_dev *dmadev =3D dev_get_drvdata(dev);
=20
-	if (!desc->platform.msi_index) {
+	if (!desc->msi_index) {
 		writel(msg->address_lo, dmadev->dev_evca + 0x118);
 		writel(msg->address_hi, dmadev->dev_evca + 0x11C);
 		writel(msg->data, dmadev->dev_evca + 0x120);
@@ -678,11 +678,13 @@ static void hidma_free_msis(struct hidma_dev *dmadev)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 	struct device *dev =3D dmadev->ddev.dev;
-	struct msi_desc *desc;
+	int i, virq;
=20
-	/* free allocated MSI interrupts above */
-	for_each_msi_entry(desc, dev)
-		devm_free_irq(dev, desc->irq, &dmadev->lldev);
+	for (i =3D 0; i < HIDMA_MSI_INTS; i++) {
+		virq =3D msi_get_virq(dev, i);
+		if (virq)
+			devm_free_irq(dev, virq, &dmadev->lldev);
+	}
=20
 	platform_msi_domain_free_irqs(dev);
 #endif
@@ -692,45 +694,37 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
 			     struct platform_device *pdev)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	int rc;
-	struct msi_desc *desc;
-	struct msi_desc *failed_desc =3D NULL;
+	int rc, i, virq;
=20
 	rc =3D platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
 					    hidma_write_msi_msg);
 	if (rc)
 		return rc;
=20
-	for_each_msi_entry(desc, &pdev->dev) {
-		if (!desc->platform.msi_index)
-			dmadev->msi_virqbase =3D desc->irq;
-
-		rc =3D devm_request_irq(&pdev->dev, desc->irq,
+	for (i =3D 0; i < HIDMA_MSI_INTS; i++) {
+		virq =3D msi_get_virq(&pdev->dev, i);
+		rc =3D devm_request_irq(&pdev->dev, virq,
 				       hidma_chirq_handler_msi,
 				       0, "qcom-hidma-msi",
 				       &dmadev->lldev);
-		if (rc) {
-			failed_desc =3D desc;
+		if (rc)
 			break;
-		}
+		if (!i)
+			dmadev->msi_virqbase =3D virq;
 	}
=20
 	if (rc) {
 		/* free allocated MSI interrupts above */
-		for_each_msi_entry(desc, &pdev->dev) {
-			if (desc =3D=3D failed_desc)
-				break;
-			devm_free_irq(&pdev->dev, desc->irq,
-				      &dmadev->lldev);
+		for (--i; i >=3D 0; i--) {
+			virq =3D msi_get_virq(&pdev->dev, i);
+			devm_free_irq(&pdev->dev, virq, &dmadev->lldev);
 		}
+		dev_warn(&pdev->dev,
+			 "failed to request MSI irq, falling back to wired IRQ\n");
 	} else {
 		/* Add callback to free MSIs on teardown */
 		hidma_ll_setup_irq(dmadev->lldev, true);
-
 	}
-	if (rc)
-		dev_warn(&pdev->dev,
-			 "failed to request MSI irq, falling back to wired IRQ\n");
 	return rc;
 #else
 	return -EINVAL;
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-privat=
e.c
index aada84f40723..d4f1e4e9603a 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -168,8 +168,7 @@ int xudma_pktdma_tflow_get_irq(struct udma_dev *ud, int u=
dma_tflow_id)
 {
 	const struct udma_oes_offsets *oes =3D &ud->soc_data->oes;
=20
-	return ti_sci_inta_msi_get_virq(ud->dev, udma_tflow_id +
-					oes->pktdma_tchan_flow);
+	return msi_get_virq(ud->dev, udma_tflow_id + oes->pktdma_tchan_flow);
 }
 EXPORT_SYMBOL(xudma_pktdma_tflow_get_irq);
=20
@@ -177,7 +176,6 @@ int xudma_pktdma_rflow_get_irq(struct udma_dev *ud, int u=
dma_rflow_id)
 {
 	const struct udma_oes_offsets *oes =3D &ud->soc_data->oes;
=20
-	return ti_sci_inta_msi_get_virq(ud->dev, udma_rflow_id +
-					oes->pktdma_rchan_flow);
+	return msi_get_virq(ud->dev, udma_rflow_id + oes->pktdma_rchan_flow);
 }
 EXPORT_SYMBOL(xudma_pktdma_rflow_get_irq);
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 041d8e32d630..86f7a0ae2648 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2313,8 +2313,7 @@ static int udma_alloc_chan_resources(struct dma_chan *c=
han)
=20
 	/* Event from UDMA (TR events) only needed for slave TR mode channels */
 	if (is_slave_direction(uc->config.dir) && !uc->config.pkt_mode) {
-		uc->irq_num_udma =3D ti_sci_inta_msi_get_virq(ud->dev,
-							    irq_udma_idx);
+		uc->irq_num_udma =3D msi_get_virq(ud->dev, irq_udma_idx);
 		if (uc->irq_num_udma <=3D 0) {
 			dev_err(ud->dev, "Failed to get udma irq (index: %u)\n",
 				irq_udma_idx);
@@ -2486,7 +2485,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *=
chan)
 		uc->psil_paired =3D true;
 	}
=20
-	uc->irq_num_ring =3D ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	uc->irq_num_ring =3D msi_get_virq(ud->dev, irq_ring_idx);
 	if (uc->irq_num_ring <=3D 0) {
 		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
 			irq_ring_idx);
@@ -2503,8 +2502,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *=
chan)
=20
 	/* Event from BCDMA (TR events) only needed for slave channels */
 	if (is_slave_direction(uc->config.dir)) {
-		uc->irq_num_udma =3D ti_sci_inta_msi_get_virq(ud->dev,
-							    irq_udma_idx);
+		uc->irq_num_udma =3D msi_get_virq(ud->dev, irq_udma_idx);
 		if (uc->irq_num_udma <=3D 0) {
 			dev_err(ud->dev, "Failed to get bcdma irq (index: %u)\n",
 				irq_udma_idx);
@@ -2672,7 +2670,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan =
*chan)
=20
 	uc->psil_paired =3D true;
=20
-	uc->irq_num_ring =3D ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	uc->irq_num_ring =3D msi_get_virq(ud->dev, irq_ring_idx);
 	if (uc->irq_num_ring <=3D 0) {
 		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
 			irq_ring_idx);
@@ -5279,9 +5277,9 @@ static int udma_probe(struct platform_device *pdev)
 	if (IS_ERR(ud->ringacc))
 		return PTR_ERR(ud->ringacc);
=20
-	dev->msi_domain =3D of_msi_get_domain(dev, dev->of_node,
+	dev->msi.domain =3D of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
-	if (!dev->msi_domain) {
+	if (!dev->msi.domain) {
 		dev_err(dev, "Failed to get MSI domain\n");
 		return -EPROBE_DEFER;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/=
arm-smmu-v3/arm-smmu-v3.c
index f5848b351b19..6dc6d8b6b368 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3142,7 +3142,7 @@ static void arm_smmu_write_msi_msg(struct msi_desc *des=
c, struct msi_msg *msg)
 	phys_addr_t doorbell;
 	struct device *dev =3D msi_desc_to_dev(desc);
 	struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
-	phys_addr_t *cfg =3D arm_smmu_msi_cfg[desc->platform.msi_index];
+	phys_addr_t *cfg =3D arm_smmu_msi_cfg[desc->msi_index];
=20
 	doorbell =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &=3D MSI_CFG0_ADDR_MASK;
@@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struct msi_desc *des=
c, struct msi_msg *msg)
=20
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
-	struct msi_desc *desc;
 	int ret, nvec =3D ARM_SMMU_MAX_MSIS;
 	struct device *dev =3D smmu->dev;
=20
@@ -3170,7 +3169,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device =
*smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
 		return;
=20
-	if (!dev->msi_domain) {
+	if (!dev->msi.domain) {
 		dev_info(smmu->dev, "msi_domain absent - falling back to wired irqs\n");
 		return;
 	}
@@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device=
 *smmu)
 		return;
 	}
=20
-	for_each_msi_entry(desc, dev) {
-		switch (desc->platform.msi_index) {
-		case EVTQ_MSI_INDEX:
-			smmu->evtq.q.irq =3D desc->irq;
-			break;
-		case GERROR_MSI_INDEX:
-			smmu->gerr_irq =3D desc->irq;
-			break;
-		case PRIQ_MSI_INDEX:
-			smmu->priq.q.irq =3D desc->irq;
-			break;
-		default:	/* Unknown */
-			continue;
-		}
-	}
+	smmu->evtq.q.irq =3D msi_get_virq(dev, EVTQ_MSI_INDEX);
+	smmu->gerr_irq =3D msi_get_virq(dev, GERROR_MSI_INDEX);
+	smmu->priq.q.irq =3D msi_get_virq(dev, PRIQ_MSI_INDEX);
=20
 	/* Add callback to free MSIs on teardown */
 	devm_add_action(dev, arm_smmu_free_msis, dev);
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 9349fc68b81a..62cc78e0da78 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -88,7 +88,6 @@ static struct irq_chip gicv2m_msi_irq_chip =3D {
 	.irq_mask		=3D gicv2m_mask_msi_irq,
 	.irq_unmask		=3D gicv2m_unmask_msi_irq,
 	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
 };
=20
 static struct msi_domain_info gicv2m_msi_domain_info =3D {
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-g=
ic-v3-its-pci-msi.c
index ad2810c017ed..93f77a8196da 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -28,7 +28,6 @@ static struct irq_chip its_msi_irq_chip =3D {
 	.irq_unmask		=3D its_unmask_msi_irq,
 	.irq_mask		=3D its_mask_msi_irq,
 	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
 };
=20
 static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mb=
i.c
index b84c9c2eccdc..a2163d32f17d 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -171,7 +171,6 @@ static struct irq_chip mbi_msi_irq_chip =3D {
 	.irq_unmask		=3D mbi_unmask_msi_irq,
 	.irq_eoi		=3D irq_chip_eoi_parent,
 	.irq_compose_msi_msg	=3D mbi_compose_msi_msg,
-	.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
 };
=20
 static struct msi_domain_info mbi_msi_domain_info =3D {
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 12df2162108e..f3faf5c99770 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -207,7 +207,7 @@ static int mbigen_irq_domain_alloc(struct irq_domain *dom=
ain,
 	if (err)
 		return err;
=20
-	err =3D platform_msi_domain_alloc(domain, virq, nr_irqs);
+	err =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs);
 	if (err)
 		return err;
=20
@@ -223,7 +223,7 @@ static int mbigen_irq_domain_alloc(struct irq_domain *dom=
ain,
 static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int v=
irq,
 				   unsigned int nr_irqs)
 {
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 }
=20
 static const struct irq_domain_ops mbigen_domain_ops =3D {
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 3e7297fc5948..497da344717c 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -221,7 +221,7 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, uns=
igned int virq,
 		icu_irqd->icu_group =3D msi_data->subset_data->icu_group;
 	icu_irqd->icu =3D icu;
=20
-	err =3D platform_msi_domain_alloc(domain, virq, nr_irqs);
+	err =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs);
 	if (err) {
 		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
 		goto free_irqd;
@@ -245,7 +245,7 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, uns=
igned int virq,
 	return 0;
=20
 free_msi:
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 free_irqd:
 	kfree(icu_irqd);
 	return err;
@@ -260,7 +260,7 @@ mvebu_icu_irq_domain_free(struct irq_domain *domain, unsi=
gned int virq,
=20
 	kfree(icu_irqd);
=20
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 }
=20
 static const struct irq_domain_ops mvebu_icu_domain_ops =3D {
@@ -314,12 +314,12 @@ static int mvebu_icu_subset_probe(struct platform_devic=
e *pdev)
 		msi_data->subset_data =3D of_device_get_match_data(dev);
 	}
=20
-	dev->msi_domain =3D of_msi_get_domain(dev, dev->of_node,
+	dev->msi.domain =3D of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_PLATFORM_MSI);
-	if (!dev->msi_domain)
+	if (!dev->msi.domain)
 		return -EPROBE_DEFER;
=20
-	msi_parent_dn =3D irq_domain_get_of_node(dev->msi_domain);
+	msi_parent_dn =3D irq_domain_get_of_node(dev->msi.domain);
 	if (!msi_parent_dn)
 		return -ENODEV;
=20
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-i=
nta.c
index 8eba08db33b2..5fdbb4358dd0 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -595,7 +595,7 @@ static void ti_sci_inta_msi_set_desc(msi_alloc_info_t *ar=
g,
 	struct platform_device *pdev =3D to_platform_device(desc->dev);
=20
 	arg->desc =3D desc;
-	arg->hwirq =3D TO_HWIRQ(pdev->id, desc->inta.dev_index);
+	arg->hwirq =3D TO_HWIRQ(pdev->id, desc->msi_index);
 }
=20
 static struct msi_domain_ops ti_sci_inta_msi_ops =3D {
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexr=
m-mailbox.c
index 78073ad1f2f1..c2e9a05641c8 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1484,7 +1484,7 @@ static void flexrm_mbox_msi_write(struct msi_desc *desc=
, struct msi_msg *msg)
 {
 	struct device *dev =3D msi_desc_to_dev(desc);
 	struct flexrm_mbox *mbox =3D dev_get_drvdata(dev);
-	struct flexrm_ring *ring =3D &mbox->rings[desc->platform.msi_index];
+	struct flexrm_ring *ring =3D &mbox->rings[desc->msi_index];
=20
 	/* Configure per-Ring MSI registers */
 	writel_relaxed(msg->address_lo, ring->regs + RING_MSI_ADDR_LS);
@@ -1497,7 +1497,6 @@ static int flexrm_mbox_probe(struct platform_device *pd=
ev)
 	int index, ret =3D 0;
 	void __iomem *regs;
 	void __iomem *regs_end;
-	struct msi_desc *desc;
 	struct resource *iomem;
 	struct flexrm_ring *ring;
 	struct flexrm_mbox *mbox;
@@ -1608,10 +1607,8 @@ static int flexrm_mbox_probe(struct platform_device *p=
dev)
 		goto fail_destroy_cmpl_pool;
=20
 	/* Save alloced IRQ numbers for each ring */
-	for_each_msi_entry(desc, dev) {
-		ring =3D &mbox->rings[desc->platform.msi_index];
-		ring->irq =3D desc->irq;
-	}
+	for (index =3D 0; index < mbox->num_rings; index++)
+		mbox->rings[index].irq =3D msi_get_virq(dev, index);
=20
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/e=
thernet/freescale/dpaa2/dpaa2-eth.c
index 8e643567abce..2c53f957e373 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4246,7 +4246,7 @@ static int dpaa2_eth_setup_irqs(struct fsl_mc_device *l=
s_dev)
 	}
=20
 	irq =3D ls_dev->irqs[0];
-	err =3D devm_request_threaded_irq(&ls_dev->dev, irq->msi_desc->irq,
+	err =3D devm_request_threaded_irq(&ls_dev->dev, irq->virq,
 					NULL, dpni_irq0_handler_thread,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(&ls_dev->dev), &ls_dev->dev);
@@ -4273,7 +4273,7 @@ static int dpaa2_eth_setup_irqs(struct fsl_mc_device *l=
s_dev)
 	return 0;
=20
 free_irq:
-	devm_free_irq(&ls_dev->dev, irq->msi_desc->irq, &ls_dev->dev);
+	devm_free_irq(&ls_dev->dev, irq->virq, &ls_dev->dev);
 free_mc_irq:
 	fsl_mc_free_irqs(ls_dev);
=20
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/e=
thernet/freescale/dpaa2/dpaa2-ptp.c
index 32b5faa87bb8..5f5f8c53c4a0 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -129,7 +129,6 @@ static irqreturn_t dpaa2_ptp_irq_handler_thread(int irq, =
void *priv)
 static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 {
 	struct device *dev =3D &mc_dev->dev;
-	struct fsl_mc_device_irq *irq;
 	struct ptp_qoriq *ptp_qoriq;
 	struct device_node *node;
 	void __iomem *base;
@@ -177,8 +176,7 @@ static int dpaa2_ptp_probe(struct fsl_mc_device *mc_dev)
 		goto err_unmap;
 	}
=20
-	irq =3D mc_dev->irqs[0];
-	ptp_qoriq->irq =3D irq->msi_desc->irq;
+	ptp_qoriq->irq =3D mc_dev->irqs[0]->virq;
=20
 	err =3D request_threaded_irq(ptp_qoriq->irq, NULL,
 				   dpaa2_ptp_irq_handler_thread,
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/ne=
t/ethernet/freescale/dpaa2/dpaa2-switch.c
index d039457928b0..084cc4d2d876 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1553,8 +1553,7 @@ static int dpaa2_switch_setup_irqs(struct fsl_mc_device=
 *sw_dev)
=20
 	irq =3D sw_dev->irqs[DPSW_IRQ_INDEX_IF];
=20
-	err =3D devm_request_threaded_irq(dev, irq->msi_desc->irq,
-					NULL,
+	err =3D devm_request_threaded_irq(dev, irq->virq, NULL,
 					dpaa2_switch_irq0_handler_thread,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(dev), dev);
@@ -1580,7 +1579,7 @@ static int dpaa2_switch_setup_irqs(struct fsl_mc_device=
 *sw_dev)
 	return 0;
=20
 free_devm_irq:
-	devm_free_irq(dev, irq->msi_desc->irq, dev);
+	devm_free_irq(dev, irq->virq, dev);
 free_irq:
 	fsl_mc_free_irqs(sw_dev);
 	return err;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath=
/ath11k/pci.c
index 3d353e7c9d5c..d9d00e499174 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -911,7 +911,7 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 	}
=20
 	ab_pci->msi_ep_base_data =3D msi_desc->msg.data;
-	if (msi_desc->msi_attrib.is_64)
+	if (msi_desc->pci.msi_attrib.is_64)
 		set_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags);
=20
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab_pci->msi_ep_base=
_data);
diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 3f05cfbc73af..2818bfcf4031 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -108,8 +108,10 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 	if (!ntb->msi)
 		return -EINVAL;
=20
-	desc =3D first_msi_entry(&ntb->pdev->dev);
+	msi_lock_descs(&ntb->pdev->dev);
+	desc =3D msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
 	addr =3D desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
+	msi_unlock_descs(&ntb->pdev->dev);
=20
 	for (peer =3D 0; peer < ntb_peer_port_count(ntb); peer++) {
 		peer_widx =3D ntb_peer_highest_mw_idx(ntb, peer);
@@ -281,13 +283,15 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, =
irq_handler_t handler,
 				  const char *name, void *dev_id,
 				  struct ntb_msi_desc *msi_desc)
 {
+	struct device *dev =3D &ntb->pdev->dev;
 	struct msi_desc *entry;
 	int ret;
=20
 	if (!ntb->msi)
 		return -EINVAL;
=20
-	for_each_pci_msi_entry(entry, ntb->pdev) {
+	msi_lock_descs(dev);
+	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
 		if (irq_has_action(entry->irq))
 			continue;
=20
@@ -304,14 +308,17 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, =
irq_handler_t handler,
 		ret =3D ntbm_msi_setup_callback(ntb, entry, msi_desc);
 		if (ret) {
 			devm_free_irq(&ntb->dev, entry->irq, dev_id);
-			return ret;
+			goto unlock;
 		}
=20
-
-		return entry->irq;
+		ret =3D entry->irq;
+		goto unlock;
 	}
+	ret =3D -ENODEV;
=20
-	return -ENODEV;
+unlock:
+	msi_unlock_descs(dev);
+	return ret;
 }
 EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
=20
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index d62c4ac4ae1b..37be95adf169 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -5,8 +5,9 @@
 obj-$(CONFIG_PCI)		+=3D access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
 				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
-				   setup-bus.o vc.o mmap.o setup-irq.o msi.o
+				   setup-bus.o vc.o mmap.o setup-irq.o
=20
+obj-$(CONFIG_PCI)		+=3D msi/
 obj-$(CONFIG_PCI)		+=3D pcie/
=20
 ifdef CONFIG_PCI
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci=
-hyperv.c
index 6733cb14e775..45b6ff8dc665 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3445,18 +3445,23 @@ static int hv_pci_suspend(struct hv_device *hdev)
=20
 static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 {
-	struct msi_desc *entry;
 	struct irq_data *irq_data;
+	struct msi_desc *entry;
+	int ret =3D 0;
=20
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_lock_descs(&pdev->dev);
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data =3D irq_get_irq_data(entry->irq);
-		if (WARN_ON_ONCE(!irq_data))
-			return -EINVAL;
+		if (WARN_ON_ONCE(!irq_data)) {
+			ret =3D -EINVAL;
+			break;
+		}
=20
 		hv_compose_msi_msg(irq_data, &entry->msg);
 	}
+	msi_unlock_descs(&pdev->dev);
=20
-	return 0;
+	return ret;
 }
=20
 /*
diff --git a/drivers/pci/msi/Makefile b/drivers/pci/msi/Makefile
new file mode 100644
index 000000000000..93ef7b9e404d
--- /dev/null
+++ b/drivers/pci/msi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the PCI/MSI
+obj-$(CONFIG_PCI)			+=3D pcidev_msi.o
+obj-$(CONFIG_PCI_MSI)			+=3D msi.o
+obj-$(CONFIG_PCI_MSI_IRQ_DOMAIN)	+=3D irqdomain.o
+obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+=3D legacy.o
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
new file mode 100644
index 000000000000..0d63541c4052
--- /dev/null
+++ b/drivers/pci/msi/irqdomain.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Message Signaled Interrupt (MSI) - irqdomain support
+ */
+#include <linux/acpi_iort.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+
+#include "msi.h"
+
+int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct irq_domain *domain;
+
+	domain =3D dev_get_msi_domain(&dev->dev);
+	if (domain && irq_domain_is_hierarchy(domain))
+		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
+
+	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
+}
+
+void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct irq_domain *domain;
+
+	domain =3D dev_get_msi_domain(&dev->dev);
+	if (domain && irq_domain_is_hierarchy(domain))
+		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
+	else
+		pci_msi_legacy_teardown_msi_irqs(dev);
+}
+
+/**
+ * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
+ * @irq_data:	Pointer to interrupt data of the MSI interrupt
+ * @msg:	Pointer to the message
+ */
+static void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_m=
sg *msg)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(irq_data);
+
+	/*
+	 * For MSI-X desc->irq is always equal to irq_data->irq. For
+	 * MSI only the first interrupt of MULTI MSI passes the test.
+	 */
+	if (desc->irq =3D=3D irq_data->irq)
+		__pci_write_msi_msg(desc, msg);
+}
+
+/**
+ * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
+ * @desc:	Pointer to the MSI descriptor
+ *
+ * The ID number is only used within the irqdomain.
+ */
+static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
+{
+	struct pci_dev *dev =3D msi_desc_to_pci_dev(desc);
+
+	return (irq_hw_number_t)desc->msi_index |
+		pci_dev_id(dev) << 11 |
+		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+}
+
+static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
+{
+	return !desc->pci.msi_attrib.is_msix && desc->nvec_used > 1;
+}
+
+/**
+ * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
+ *			      for @dev
+ * @domain:	The interrupt domain to check
+ * @info:	The domain info for verification
+ * @dev:	The device to check
+ *
+ * Returns:
+ *  0 if the functionality is supported
+ *  1 if Multi MSI is requested, but the domain does not support it
+ *  -ENOTSUPP otherwise
+ */
+static int pci_msi_domain_check_cap(struct irq_domain *domain,
+				    struct msi_domain_info *info,
+				    struct device *dev)
+{
+	struct msi_desc *desc =3D msi_first_desc(dev, MSI_DESC_ALL);
+
+	/* Special handling to support __pci_enable_msi_range() */
+	if (pci_msi_desc_is_multi_msi(desc) &&
+	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
+		return 1;
+
+	if (desc->pci.msi_attrib.is_msix) {
+		if (!(info->flags & MSI_FLAG_PCI_MSIX))
+			return -ENOTSUPP;
+
+		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
+			unsigned int idx =3D 0;
+
+			/* Check for gaps in the entry indices */
+			msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
+				if (desc->msi_index !=3D idx++)
+					return -ENOTSUPP;
+			}
+		}
+	}
+	return 0;
+}
+
+static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
+				    struct msi_desc *desc)
+{
+	arg->desc =3D desc;
+	arg->hwirq =3D pci_msi_domain_calc_hwirq(desc);
+}
+
+static struct msi_domain_ops pci_msi_domain_ops_default =3D {
+	.set_desc	=3D pci_msi_domain_set_desc,
+	.msi_check	=3D pci_msi_domain_check_cap,
+};
+
+static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
+{
+	struct msi_domain_ops *ops =3D info->ops;
+
+	if (ops =3D=3D NULL) {
+		info->ops =3D &pci_msi_domain_ops_default;
+	} else {
+		if (ops->set_desc =3D=3D NULL)
+			ops->set_desc =3D pci_msi_domain_set_desc;
+		if (ops->msi_check =3D=3D NULL)
+			ops->msi_check =3D pci_msi_domain_check_cap;
+	}
+}
+
+static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
+{
+	struct irq_chip *chip =3D info->chip;
+
+	BUG_ON(!chip);
+	if (!chip->irq_write_msi_msg)
+		chip->irq_write_msi_msg =3D pci_msi_domain_write_msg;
+	if (!chip->irq_mask)
+		chip->irq_mask =3D pci_msi_mask_irq;
+	if (!chip->irq_unmask)
+		chip->irq_unmask =3D pci_msi_unmask_irq;
+}
+
+/**
+ * pci_msi_create_irq_domain - Create a MSI interrupt domain
+ * @fwnode:	Optional fwnode of the interrupt controller
+ * @info:	MSI domain info
+ * @parent:	Parent irq domain
+ *
+ * Updates the domain and chip ops and creates a MSI interrupt domain.
+ *
+ * Returns:
+ * A domain pointer or NULL in case of failure.
+ */
+struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
+					     struct msi_domain_info *info,
+					     struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
+		info->flags &=3D ~MSI_FLAG_LEVEL_CAPABLE;
+
+	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
+		pci_msi_domain_update_dom_ops(info);
+	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
+		pci_msi_domain_update_chip_ops(info);
+
+	info->flags |=3D MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
+		       MSI_FLAG_FREE_MSI_DESCS;
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		info->flags |=3D MSI_FLAG_MUST_REACTIVATE;
+
+	/* PCI-MSI is oneshot-safe */
+	info->chip->flags |=3D IRQCHIP_ONESHOT_SAFE;
+
+	domain =3D msi_create_irq_domain(fwnode, info, parent);
+	if (!domain)
+		return NULL;
+
+	irq_domain_update_bus_token(domain, DOMAIN_BUS_PCI_MSI);
+	return domain;
+}
+EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
+
+/*
+ * Users of the generic MSI infrastructure expect a device to have a single =
ID,
+ * so with DMA aliases we have to pick the least-worst compromise. Devices w=
ith
+ * DMA phantom functions tend to still emit MSIs from the real function numb=
er,
+ * so we ignore those and only consider topological aliases where either the
+ * alias device or RID appears on a different bus number. We also make the
+ * reasonable assumption that bridges are walked in an upstream direction (so
+ * the last one seen wins), and the much braver assumption that the most lik=
ely
+ * case is that of PCI->PCIe so we should always use the alias RID. This ech=
oes
+ * the logic from intel_irq_remapping's set_msi_sid(), which presumably works
+ * well enough in practice; in the face of the horrible PCIe<->PCI-X conditi=
ons
+ * for taking ownership all we can really do is close our eyes and hope...
+ */
+static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	u32 *pa =3D data;
+	u8 bus =3D PCI_BUS_NUM(*pa);
+
+	if (pdev->bus->number !=3D bus || PCI_BUS_NUM(alias) !=3D bus)
+		*pa =3D alias;
+
+	return 0;
+}
+
+/**
+ * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
+ * @domain:	The interrupt domain
+ * @pdev:	The PCI device.
+ *
+ * The RID for a device is formed from the alias, with a firmware
+ * supplied mapping applied
+ *
+ * Returns: The RID.
+ */
+u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pd=
ev)
+{
+	struct device_node *of_node;
+	u32 rid =3D pci_dev_id(pdev);
+
+	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
+
+	of_node =3D irq_domain_get_of_node(domain);
+	rid =3D of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
+			iort_msi_map_id(&pdev->dev, rid);
+
+	return rid;
+}
+
+/**
+ * pci_msi_get_device_domain - Get the MSI domain for a given PCI device
+ * @pdev:	The PCI device
+ *
+ * Use the firmware data to find a device-specific MSI domain
+ * (i.e. not one that is set as a default).
+ *
+ * Returns: The corresponding MSI domain or NULL if none has been found.
+ */
+struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
+{
+	struct irq_domain *dom;
+	u32 rid =3D pci_dev_id(pdev);
+
+	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
+	dom =3D of_msi_map_get_device_domain(&pdev->dev, rid, DOMAIN_BUS_PCI_MSI);
+	if (!dom)
+		dom =3D iort_get_device_domain(&pdev->dev, rid,
+					     DOMAIN_BUS_PCI_MSI);
+	return dom;
+}
+
+/**
+ * pci_dev_has_special_msi_domain - Check whether the device is handled by
+ *				    a non-standard PCI-MSI domain
+ * @pdev:	The PCI device to check.
+ *
+ * Returns: True if the device irqdomain or the bus irqdomain is
+ * non-standard PCI/MSI.
+ */
+bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
+{
+	struct irq_domain *dom =3D dev_get_msi_domain(&pdev->dev);
+
+	if (!dom)
+		dom =3D dev_get_msi_domain(&pdev->bus->dev);
+
+	if (!dom)
+		return true;
+
+	return dom->bus_token !=3D DOMAIN_BUS_PCI_MSI;
+}
diff --git a/drivers/pci/msi/legacy.c b/drivers/pci/msi/legacy.c
new file mode 100644
index 000000000000..cdbb4689db78
--- /dev/null
+++ b/drivers/pci/msi/legacy.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Message Signaled Interrupt (MSI).
+ *
+ * Legacy architecture specific setup and teardown mechanism.
+ */
+#include "msi.h"
+
+/* Arch hooks */
+int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+{
+	return -EINVAL;
+}
+
+void __weak arch_teardown_msi_irq(unsigned int irq)
+{
+}
+
+int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct msi_desc *desc;
+	int ret;
+
+	/*
+	 * If an architecture wants to support multiple MSI, it needs to
+	 * override arch_setup_msi_irqs()
+	 */
+	if (type =3D=3D PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
+		ret =3D arch_setup_msi_irq(dev, desc);
+		if (ret)
+			return ret < 0 ? ret : -ENOSPC;
+	}
+
+	return 0;
+}
+
+void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *desc;
+	int i;
+
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED) {
+		for (i =3D 0; i < desc->nvec_used; i++)
+			arch_teardown_msi_irq(desc->irq + i);
+	}
+}
+
+static int pci_msi_setup_check_result(struct pci_dev *dev, int type, int ret)
+{
+	struct msi_desc *desc;
+	int avail =3D 0;
+
+	if (type !=3D PCI_CAP_ID_MSIX || ret >=3D 0)
+		return ret;
+
+	/* Scan the MSI descriptors for successfully allocated ones. */
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ASSOCIATED)
+		avail++;
+
+	return avail ? avail : ret;
+}
+
+int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	int ret =3D arch_setup_msi_irqs(dev, nvec, type);
+
+	ret =3D pci_msi_setup_check_result(dev, type, ret);
+	if (!ret)
+		ret =3D msi_device_populate_sysfs(&dev->dev);
+	return ret;
+}
+
+void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
+{
+	msi_device_destroy_sysfs(&dev->dev);
+	arch_teardown_msi_irqs(dev);
+	msi_free_msi_descs(&dev->dev);
+}
diff --git a/drivers/pci/msi.c b/drivers/pci/msi/msi.c
similarity index 56%
rename from drivers/pci/msi.c
rename to drivers/pci/msi/msi.c
index d84cf30bb279..c19c7ca58186 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -6,156 +6,29 @@
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  * Copyright (C) 2016 Christoph Hellwig.
  */
-
 #include <linux/err.h>
-#include <linux/mm.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
 #include <linux/export.h>
-#include <linux/ioport.h>
-#include <linux/pci.h>
-#include <linux/proc_fs.h>
-#include <linux/msi.h>
-#include <linux/smp.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/acpi_iort.h>
-#include <linux/slab.h>
-#include <linux/irqdomain.h>
-#include <linux/of_irq.h>
-
-#include "pci.h"
-
-#ifdef CONFIG_PCI_MSI
+#include <linux/irq.h>
+
+#include "../pci.h"
+#include "msi.h"
=20
 static int pci_msi_enable =3D 1;
 int pci_msi_ignore_mask;
=20
-#define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
-
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct irq_domain *domain;
-
-	domain =3D dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
-		return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
-
-	return arch_setup_msi_irqs(dev, nvec, type);
-}
-
-static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
-{
-	struct irq_domain *domain;
-
-	domain =3D dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
-		msi_domain_free_irqs(domain, &dev->dev);
-	else
-		arch_teardown_msi_irqs(dev);
-}
-#else
-#define pci_msi_setup_msi_irqs		arch_setup_msi_irqs
-#define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
-#endif
-
-#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
-/* Arch hooks */
-int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
-{
-	return -EINVAL;
-}
-
-void __weak arch_teardown_msi_irq(unsigned int irq)
-{
-}
-
-int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct msi_desc *entry;
-	int ret;
-
-	/*
-	 * If an architecture wants to support multiple MSI, it needs to
-	 * override arch_setup_msi_irqs()
-	 */
-	if (type =3D=3D PCI_CAP_ID_MSI && nvec > 1)
-		return 1;
-
-	for_each_pci_msi_entry(entry, dev) {
-		ret =3D arch_setup_msi_irq(dev, entry);
-		if (ret < 0)
-			return ret;
-		if (ret > 0)
-			return -ENOSPC;
-	}
-
-	return 0;
-}
-
-void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	int i;
-	struct msi_desc *entry;
-
-	for_each_pci_msi_entry(entry, dev)
-		if (entry->irq)
-			for (i =3D 0; i < entry->nvec_used; i++)
-				arch_teardown_msi_irq(entry->irq + i);
-}
-#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
-
-static void default_restore_msi_irq(struct pci_dev *dev, int irq)
-{
-	struct msi_desc *entry;
-
-	entry =3D NULL;
-	if (dev->msix_enabled) {
-		for_each_pci_msi_entry(entry, dev) {
-			if (irq =3D=3D entry->irq)
-				break;
-		}
-	} else if (dev->msi_enabled)  {
-		entry =3D irq_get_msi_desc(irq);
-	}
-
-	if (entry)
-		__pci_write_msi_msg(entry, &entry->msg);
-}
-
-void __weak arch_restore_msi_irqs(struct pci_dev *dev)
-{
-	return default_restore_msi_irqs(dev);
-}
-
-/*
- * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
- * mask all MSI interrupts by clearing the MSI enable bit does not work
- * reliably as devices without an INTx disable bit will then generate a
- * level IRQ which will never be cleared.
- */
-static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
-{
-	/* Don't shift by >=3D width of type */
-	if (desc->msi_attrib.multi_cap >=3D 5)
-		return 0xffffffff;
-	return (1 << (1 << desc->msi_attrib.multi_cap)) - 1;
-}
-
 static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u=
32 set)
 {
-	raw_spinlock_t *lock =3D &desc->dev->msi_lock;
+	raw_spinlock_t *lock =3D &to_pci_dev(desc->dev)->msi_lock;
 	unsigned long flags;
=20
-	if (!desc->msi_attrib.can_mask)
+	if (!desc->pci.msi_attrib.can_mask)
 		return;
=20
 	raw_spin_lock_irqsave(lock, flags);
-	desc->msi_mask &=3D ~clear;
-	desc->msi_mask |=3D set;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
-			       desc->msi_mask);
+	desc->pci.msi_mask &=3D ~clear;
+	desc->pci.msi_mask |=3D set;
+	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
+			       desc->pci.msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
=20
@@ -171,7 +44,7 @@ static inline void pci_msi_unmask(struct msi_desc *desc, u=
32 mask)
=20
 static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 {
-	return desc->mask_base + desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
 }
=20
 /*
@@ -184,27 +57,27 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *=
desc, u32 ctrl)
 {
 	void __iomem *desc_addr =3D pci_msix_desc_addr(desc);
=20
-	if (desc->msi_attrib.can_mask)
+	if (desc->pci.msi_attrib.can_mask)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
 static inline void pci_msix_mask(struct msi_desc *desc)
 {
-	desc->msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 	/* Flush write to device */
-	readl(desc->mask_base);
+	readl(desc->pci.mask_base);
 }
=20
 static inline void pci_msix_unmask(struct msi_desc *desc)
 {
-	desc->msix_ctrl &=3D ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+	desc->pci.msix_ctrl &=3D ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 }
=20
 static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (desc->msi_attrib.is_msix)
+	if (desc->pci.msi_attrib.is_msix)
 		pci_msix_mask(desc);
 	else
 		pci_msi_mask(desc, mask);
@@ -212,7 +85,7 @@ static void __pci_msi_mask_desc(struct msi_desc *desc, u32=
 mask)
=20
 static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (desc->msi_attrib.is_msix)
+	if (desc->pci.msi_attrib.is_msix)
 		pci_msix_unmask(desc);
 	else
 		pci_msi_unmask(desc, mask);
@@ -242,24 +115,16 @@ void pci_msi_unmask_irq(struct irq_data *data)
 }
 EXPORT_SYMBOL_GPL(pci_msi_unmask_irq);
=20
-void default_restore_msi_irqs(struct pci_dev *dev)
-{
-	struct msi_desc *entry;
-
-	for_each_pci_msi_entry(entry, dev)
-		default_restore_msi_irq(dev, entry->irq);
-}
-
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev =3D msi_desc_to_pci_dev(entry);
=20
 	BUG_ON(dev->current_state !=3D PCI_D0);
=20
-	if (entry->msi_attrib.is_msix) {
+	if (entry->pci.msi_attrib.is_msix) {
 		void __iomem *base =3D pci_msix_desc_addr(entry);
=20
-		if (WARN_ON_ONCE(entry->msi_attrib.is_virtual))
+		if (WARN_ON_ONCE(entry->pci.msi_attrib.is_virtual))
 			return;
=20
 		msg->address_lo =3D readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
@@ -271,7 +136,7 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct ms=
i_msg *msg)
=20
 		pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
 				      &msg->address_lo);
-		if (entry->msi_attrib.is_64) {
+		if (entry->pci.msi_attrib.is_64) {
 			pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
 					      &msg->address_hi);
 			pci_read_config_word(dev, pos + PCI_MSI_DATA_64, &data);
@@ -289,12 +154,12 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct=
 msi_msg *msg)
=20
 	if (dev->current_state !=3D PCI_D0 || pci_dev_is_disconnected(dev)) {
 		/* Don't touch the hardware now */
-	} else if (entry->msi_attrib.is_msix) {
+	} else if (entry->pci.msi_attrib.is_msix) {
 		void __iomem *base =3D pci_msix_desc_addr(entry);
-		u32 ctrl =3D entry->msix_ctrl;
+		u32 ctrl =3D entry->pci.msix_ctrl;
 		bool unmasked =3D !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
=20
-		if (entry->msi_attrib.is_virtual)
+		if (entry->pci.msi_attrib.is_virtual)
 			goto skip;
=20
 		/*
@@ -323,12 +188,12 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct=
 msi_msg *msg)
=20
 		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 		msgctl &=3D ~PCI_MSI_FLAGS_QSIZE;
-		msgctl |=3D entry->msi_attrib.multiple << 4;
+		msgctl |=3D entry->pci.msi_attrib.multiple << 4;
 		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
=20
 		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
 				       msg->address_lo);
-		if (entry->msi_attrib.is_64) {
+		if (entry->pci.msi_attrib.is_64) {
 			pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
 					       msg->address_hi);
 			pci_write_config_word(dev, pos + PCI_MSI_DATA_64,
@@ -359,30 +224,11 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
=20
 static void free_msi_irqs(struct pci_dev *dev)
 {
-	struct list_head *msi_list =3D dev_to_msi_list(&dev->dev);
-	struct msi_desc *entry, *tmp;
-	int i;
-
-	for_each_pci_msi_entry(entry, dev)
-		if (entry->irq)
-			for (i =3D 0; i < entry->nvec_used; i++)
-				BUG_ON(irq_has_action(entry->irq + i));
-
-	if (dev->msi_irq_groups) {
-		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
-		dev->msi_irq_groups =3D NULL;
-	}
-
 	pci_msi_teardown_msi_irqs(dev);
=20
-	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		if (entry->msi_attrib.is_msix) {
-			if (list_is_last(&entry->list, msi_list))
-				iounmap(entry->mask_base);
-		}
-
-		list_del(&entry->list);
-		free_msi_entry(entry);
+	if (dev->msix_base) {
+		iounmap(dev->msix_base);
+		dev->msix_base =3D NULL;
 	}
 }
=20
@@ -403,10 +249,19 @@ static void pci_msi_set_enable(struct pci_dev *dev, int=
 enable)
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
=20
+/*
+ * Architecture override returns true when the PCI MSI message should be
+ * written by the generic restore function.
+ */
+bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
+{
+	return true;
+}
+
 static void __pci_restore_msi_state(struct pci_dev *dev)
 {
-	u16 control;
 	struct msi_desc *entry;
+	u16 control;
=20
 	if (!dev->msi_enabled)
 		return;
@@ -415,12 +270,13 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
=20
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 0);
-	arch_restore_msi_irqs(dev);
+	if (arch_restore_msi_irqs(dev))
+		__pci_write_msi_msg(entry, &entry->msg);
=20
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	pci_msi_update_mask(entry, 0, 0);
 	control &=3D ~PCI_MSI_FLAGS_QSIZE;
-	control |=3D (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
+	control |=3D (entry->pci.msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
=20
@@ -437,19 +293,25 @@ static void pci_msix_clear_and_set_ctrl(struct pci_dev =
*dev, u16 clear, u16 set)
 static void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
+	bool write_msg;
=20
 	if (!dev->msix_enabled)
 		return;
-	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
=20
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
 	pci_msix_clear_and_set_ctrl(dev, 0,
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
=20
-	arch_restore_msi_irqs(dev);
-	for_each_pci_msi_entry(entry, dev)
-		pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
+	write_msg =3D arch_restore_msi_irqs(dev);
+
+	msi_lock_descs(&dev->dev);
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
+		if (write_msg)
+			__pci_write_msi_msg(entry, &entry->msg);
+		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
+	}
+	msi_unlock_descs(&dev->dev);
=20
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -461,48 +323,79 @@ void pci_restore_msi_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_restore_msi_state);
=20
-static struct msi_desc *
-msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
+static void pcim_msi_release(void *pcidev)
 {
-	struct irq_affinity_desc *masks =3D NULL;
-	struct msi_desc *entry;
-	u16 control;
+	struct pci_dev *dev =3D pcidev;
=20
-	if (affd)
-		masks =3D irq_create_affinity_masks(nvec, affd);
+	dev->is_msi_managed =3D false;
+	pci_free_irq_vectors(dev);
+}
+
+/*
+ * Needs to be separate from pcim_release to prevent an ordering problem
+ * vs. msi_device_data_release() in the MSI core code.
+ */
+static int pcim_setup_msi_release(struct pci_dev *dev)
+{
+	int ret;
+
+	if (!pci_is_managed(dev) || dev->is_msi_managed)
+		return 0;
+
+	ret =3D devm_add_action(&dev->dev, pcim_msi_release, dev);
+	if (!ret)
+		dev->is_msi_managed =3D true;
+	return ret;
+}
+
+/*
+ * Ordering vs. devres: msi device data has to be installed first so that
+ * pcim_msi_release() is invoked before it on device release.
+ */
+static int pci_setup_msi_context(struct pci_dev *dev)
+{
+	int ret =3D msi_setup_device_data(&dev->dev);
+
+	if (!ret)
+		ret =3D pcim_setup_msi_release(dev);
+	return ret;
+}
+
+static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
+			      struct irq_affinity_desc *masks)
+{
+	struct msi_desc desc;
+	u16 control;
=20
 	/* MSI Entry Initialization */
-	entry =3D alloc_msi_entry(&dev->dev, nvec, masks);
-	if (!entry)
-		goto out;
+	memset(&desc, 0, sizeof(desc));
=20
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |=3D PCI_MSI_FLAGS_MASKBIT;
+	/* Respect XEN's mask disabling */
+	if (pci_msi_ignore_mask)
+		control &=3D ~PCI_MSI_FLAGS_MASKBIT;
=20
-	entry->msi_attrib.is_msix	=3D 0;
-	entry->msi_attrib.is_64		=3D !!(control & PCI_MSI_FLAGS_64BIT);
-	entry->msi_attrib.is_virtual    =3D 0;
-	entry->msi_attrib.entry_nr	=3D 0;
-	entry->msi_attrib.can_mask	=3D !pci_msi_ignore_mask &&
-					  !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->msi_attrib.default_irq	=3D dev->irq;	/* Save IOAPIC IRQ */
-	entry->msi_attrib.multi_cap	=3D (control & PCI_MSI_FLAGS_QMASK) >> 1;
-	entry->msi_attrib.multiple	=3D ilog2(__roundup_pow_of_two(nvec));
+	desc.nvec_used			=3D nvec;
+	desc.pci.msi_attrib.is_64	=3D !!(control & PCI_MSI_FLAGS_64BIT);
+	desc.pci.msi_attrib.can_mask	=3D !!(control & PCI_MSI_FLAGS_MASKBIT);
+	desc.pci.msi_attrib.default_irq	=3D dev->irq;
+	desc.pci.msi_attrib.multi_cap	=3D (control & PCI_MSI_FLAGS_QMASK) >> 1;
+	desc.pci.msi_attrib.multiple	=3D ilog2(__roundup_pow_of_two(nvec));
+	desc.affinity			=3D masks;
=20
 	if (control & PCI_MSI_FLAGS_64BIT)
-		entry->mask_pos =3D dev->msi_cap + PCI_MSI_MASK_64;
+		desc.pci.mask_pos =3D dev->msi_cap + PCI_MSI_MASK_64;
 	else
-		entry->mask_pos =3D dev->msi_cap + PCI_MSI_MASK_32;
+		desc.pci.mask_pos =3D dev->msi_cap + PCI_MSI_MASK_32;
=20
 	/* Save the initial mask status */
-	if (entry->msi_attrib.can_mask)
-		pci_read_config_dword(dev, entry->mask_pos, &entry->msi_mask);
+	if (desc.pci.msi_attrib.can_mask)
+		pci_read_config_dword(dev, desc.pci.mask_pos, &desc.pci.msi_mask);
=20
-out:
-	kfree(masks);
-	return entry;
+	return msi_add_msi_desc(&dev->dev, &desc);
 }
=20
 static int msi_verify_entries(struct pci_dev *dev)
@@ -512,14 +405,14 @@ static int msi_verify_entries(struct pci_dev *dev)
 	if (!dev->no_64bit_msi)
 		return 0;
=20
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
 		if (entry->msg.address_hi) {
 			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only su=
pports 32 bits\n",
 				entry->msg.address_hi, entry->msg.address_lo);
-			return -EIO;
+			break;
 		}
 	}
-	return 0;
+	return !entry ? 0 : -EIO;
 }
=20
 /**
@@ -537,21 +430,29 @@ static int msi_verify_entries(struct pci_dev *dev)
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
+	struct irq_affinity_desc *masks =3D NULL;
 	struct msi_desc *entry;
 	int ret;
=20
-	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
+	/*
+	 * Disable MSI during setup in the hardware, but mark it enabled
+	 * so that setup code can evaluate it.
+	 */
+	pci_msi_set_enable(dev, 0);
+	dev->msi_enabled =3D 1;
=20
-	entry =3D msi_setup_entry(dev, nvec, affd);
-	if (!entry)
-		return -ENOMEM;
+	if (affd)
+		masks =3D irq_create_affinity_masks(nvec, affd);
+
+	msi_lock_descs(&dev->dev);
+	ret =3D msi_setup_msi_desc(dev, nvec, masks);
+	if (ret)
+		goto fail;
=20
 	/* All MSIs are unmasked by default; mask them all */
+	entry =3D msi_first_desc(&dev->dev, MSI_DESC_ALL);
 	pci_msi_mask(entry, msi_multi_mask(entry));
=20
-	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
-
 	/* Configure MSI capability structure */
 	ret =3D pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
 	if (ret)
@@ -561,26 +462,22 @@ static int msi_capability_init(struct pci_dev *dev, int=
 nvec,
 	if (ret)
 		goto err;
=20
-	groups =3D msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret =3D PTR_ERR(groups);
-		goto err;
-	}
-
-	dev->msi_irq_groups =3D groups;
-
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
-	dev->msi_enabled =3D 1;
=20
 	pcibios_free_irq(dev);
 	dev->irq =3D entry->irq;
-	return 0;
+	goto unlock;
=20
 err:
 	pci_msi_unmask(entry, msi_multi_mask(entry));
 	free_msi_irqs(dev);
+fail:
+	dev->msi_enabled =3D 0;
+unlock:
+	msi_unlock_descs(&dev->dev);
+	kfree(masks);
 	return ret;
 }
=20
@@ -605,70 +502,49 @@ static void __iomem *msix_map_region(struct pci_dev *de=
v,
 	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
 }
=20
-static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
-			      struct msix_entry *entries, int nvec,
-			      struct irq_affinity *affd)
+static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
+				struct msix_entry *entries, int nvec,
+				struct irq_affinity_desc *masks)
 {
-	struct irq_affinity_desc *curmsk, *masks =3D NULL;
-	struct msi_desc *entry;
+	int ret =3D 0, i, vec_count =3D pci_msix_vec_count(dev);
+	struct irq_affinity_desc *curmsk;
+	struct msi_desc desc;
 	void __iomem *addr;
-	int ret, i;
-	int vec_count =3D pci_msix_vec_count(dev);
-
-	if (affd)
-		masks =3D irq_create_affinity_masks(nvec, affd);
=20
-	for (i =3D 0, curmsk =3D masks; i < nvec; i++) {
-		entry =3D alloc_msi_entry(&dev->dev, 1, curmsk);
-		if (!entry) {
-			if (!i)
-				iounmap(base);
-			else
-				free_msi_irqs(dev);
-			/* No enough memory. Don't try again */
-			ret =3D -ENOMEM;
-			goto out;
-		}
+	memset(&desc, 0, sizeof(desc));
=20
-		entry->msi_attrib.is_msix	=3D 1;
-		entry->msi_attrib.is_64		=3D 1;
+	desc.nvec_used			=3D 1;
+	desc.pci.msi_attrib.is_msix	=3D 1;
+	desc.pci.msi_attrib.is_64	=3D 1;
+	desc.pci.msi_attrib.default_irq	=3D dev->irq;
+	desc.pci.mask_base		=3D base;
=20
-		if (entries)
-			entry->msi_attrib.entry_nr =3D entries[i].entry;
-		else
-			entry->msi_attrib.entry_nr =3D i;
+	for (i =3D 0, curmsk =3D masks; i < nvec; i++, curmsk++) {
+		desc.msi_index =3D entries ? entries[i].entry : i;
+		desc.affinity =3D masks ? curmsk : NULL;
+		desc.pci.msi_attrib.is_virtual =3D desc.msi_index >=3D vec_count;
+		desc.pci.msi_attrib.can_mask =3D !pci_msi_ignore_mask &&
+					       !desc.pci.msi_attrib.is_virtual;
=20
-		entry->msi_attrib.is_virtual =3D
-			entry->msi_attrib.entry_nr >=3D vec_count;
-
-		entry->msi_attrib.can_mask	=3D !pci_msi_ignore_mask &&
-						  !entry->msi_attrib.is_virtual;
-
-		entry->msi_attrib.default_irq	=3D dev->irq;
-		entry->mask_base		=3D base;
-
-		if (entry->msi_attrib.can_mask) {
-			addr =3D pci_msix_desc_addr(entry);
-			entry->msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+		if (!desc.pci.msi_attrib.can_mask) {
+			addr =3D pci_msix_desc_addr(&desc);
+			desc.pci.msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
=20
-		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
-		if (masks)
-			curmsk++;
+		ret =3D msi_add_msi_desc(&dev->dev, &desc);
+		if (ret)
+			break;
 	}
-	ret =3D 0;
-out:
-	kfree(masks);
 	return ret;
 }
=20
 static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entr=
ies)
 {
-	struct msi_desc *entry;
+	struct msi_desc *desc;
=20
-	for_each_pci_msi_entry(entry, dev) {
-		if (entries) {
-			entries->vector =3D entry->irq;
+	if (entries) {
+		msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL) {
+			entries->vector =3D desc->irq;
 			entries++;
 		}
 	}
@@ -686,6 +562,41 @@ static void msix_mask_all(void __iomem *base, int tsize)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
+static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
+				 struct msix_entry *entries, int nvec,
+				 struct irq_affinity *affd)
+{
+	struct irq_affinity_desc *masks =3D NULL;
+	int ret;
+
+	if (affd)
+		masks =3D irq_create_affinity_masks(nvec, affd);
+
+	msi_lock_descs(&dev->dev);
+	ret =3D msix_setup_msi_descs(dev, base, entries, nvec, masks);
+	if (ret)
+		goto out_free;
+
+	ret =3D pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
+	if (ret)
+		goto out_free;
+
+	/* Check if all MSI entries honor device restrictions */
+	ret =3D msi_verify_entries(dev);
+	if (ret)
+		goto out_free;
+
+	msix_update_entries(dev, entries);
+	goto out_unlock;
+
+out_free:
+	free_msi_irqs(dev);
+out_unlock:
+	msi_unlock_descs(&dev->dev);
+	kfree(masks);
+	return ret;
+}
+
 /**
  * msix_capability_init - configure device's MSI-X capability
  * @dev: pointer to the pci_dev data structure of MSI-X device function
@@ -700,7 +611,6 @@ static void msix_mask_all(void __iomem *base, int tsize)
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entr=
ies,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct attribute_group **groups;
 	void __iomem *base;
 	int ret, tsize;
 	u16 control;
@@ -713,6 +623,9 @@ static int msix_capability_init(struct pci_dev *dev, stru=
ct msix_entry *entries,
 	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
 				    PCI_MSIX_FLAGS_ENABLE);
=20
+	/* Mark it enabled so setup functions can query it */
+	dev->msix_enabled =3D 1;
+
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
 	tsize =3D msix_table_size(control);
@@ -722,32 +635,14 @@ static int msix_capability_init(struct pci_dev *dev, st=
ruct msix_entry *entries,
 		goto out_disable;
 	}
=20
-	ret =3D msix_setup_entries(dev, base, entries, nvec, affd);
-	if (ret)
-		goto out_disable;
-
-	ret =3D pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
-	if (ret)
-		goto out_avail;
+	dev->msix_base =3D base;
=20
-	/* Check if all MSI entries honor device restrictions */
-	ret =3D msi_verify_entries(dev);
+	ret =3D msix_setup_interrupts(dev, base, entries, nvec, affd);
 	if (ret)
-		goto out_free;
-
-	msix_update_entries(dev, entries);
-
-	groups =3D msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(groups)) {
-		ret =3D PTR_ERR(groups);
-		goto out_free;
-	}
-
-	dev->msi_irq_groups =3D groups;
+		goto out_disable;
=20
-	/* Set MSI-X enabled bits and unmask the function */
+	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
-	dev->msix_enabled =3D 1;
=20
 	/*
 	 * Ensure that all table entries are masked to prevent
@@ -763,27 +658,8 @@ static int msix_capability_init(struct pci_dev *dev, str=
uct msix_entry *entries,
 	pcibios_free_irq(dev);
 	return 0;
=20
-out_avail:
-	if (ret < 0) {
-		/*
-		 * If we had some success, report the number of IRQs
-		 * we succeeded in setting up.
-		 */
-		struct msi_desc *entry;
-		int avail =3D 0;
-
-		for_each_pci_msi_entry(entry, dev) {
-			if (entry->irq !=3D 0)
-				avail++;
-		}
-		if (avail !=3D 0)
-			ret =3D avail;
-	}
-
-out_free:
-	free_msi_irqs(dev);
-
 out_disable:
+	dev->msix_enabled =3D 0;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_EN=
ABLE, 0);
=20
 	return ret;
@@ -870,18 +746,17 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
=20
-	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
-	desc =3D first_pci_msi_entry(dev);
-
 	pci_msi_set_enable(dev, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msi_enabled =3D 0;
=20
 	/* Return the device with MSI unmasked as initial states */
-	pci_msi_unmask(desc, msi_multi_mask(desc));
+	desc =3D msi_first_desc(&dev->dev, MSI_DESC_ALL);
+	if (!WARN_ON_ONCE(!desc))
+		pci_msi_unmask(desc, msi_multi_mask(desc));
=20
 	/* Restore dev->irq to its default pin-assertion IRQ */
-	dev->irq =3D desc->msi_attrib.default_irq;
+	dev->irq =3D desc->pci.msi_attrib.default_irq;
 	pcibios_alloc_irq(dev);
 }
=20
@@ -890,8 +765,10 @@ void pci_disable_msi(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
=20
+	msi_lock_descs(&dev->dev);
 	pci_msi_shutdown(dev);
 	free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msi);
=20
@@ -952,7 +829,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct =
msix_entry *entries,
=20
 static void pci_msix_shutdown(struct pci_dev *dev)
 {
-	struct msi_desc *entry;
+	struct msi_desc *desc;
=20
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
@@ -963,8 +840,8 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	}
=20
 	/* Return the device with MSI-X masked as initial states */
-	for_each_pci_msi_entry(entry, dev)
-		pci_msix_mask(entry);
+	msi_for_each_desc(desc, &dev->dev, MSI_DESC_ALL)
+		pci_msix_mask(desc);
=20
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);
@@ -977,28 +854,13 @@ void pci_disable_msix(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
=20
+	msi_lock_descs(&dev->dev);
 	pci_msix_shutdown(dev);
 	free_msi_irqs(dev);
+	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msix);
=20
-void pci_no_msi(void)
-{
-	pci_msi_enable =3D 0;
-}
-
-/**
- * pci_msi_enabled - is MSI enabled?
- *
- * Returns true if MSI has not been disabled by the command-line option
- * pci=3Dnomsi.
- **/
-int pci_msi_enabled(void)
-{
-	return pci_msi_enable;
-}
-EXPORT_SYMBOL(pci_msi_enabled);
-
 static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxve=
c,
 				  struct irq_affinity *affd)
 {
@@ -1029,6 +891,10 @@ static int __pci_enable_msi_range(struct pci_dev *dev, =
int minvec, int maxvec,
 	if (nvec > maxvec)
 		nvec =3D maxvec;
=20
+	rc =3D pci_setup_msi_context(dev);
+	if (rc)
+		return rc;
+
 	for (;;) {
 		if (affd) {
 			nvec =3D irq_calc_affinity_vectors(minvec, nvec, affd);
@@ -1072,6 +938,10 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
=20
+	rc =3D pci_setup_msi_context(dev);
+	if (rc)
+		return rc;
+
 	for (;;) {
 		if (affd) {
 			nvec =3D irq_calc_affinity_vectors(minvec, nvec, affd);
@@ -1194,35 +1064,25 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
=20
 /**
  * pci_irq_vector - return Linux IRQ number of a device vector
- * @dev: PCI device to operate on
- * @nr: device-relative interrupt vector index (0-based).
+ * @dev:	PCI device to operate on
+ * @nr:		Interrupt vector index (0-based)
+ *
+ * @nr has the following meanings depending on the interrupt mode:
+ *   MSI-X:	The index in the MSI-X vector table
+ *   MSI:	The index of the enabled MSI vectors
+ *   INTx:	Must be 0
+ *
+ * Return: The Linux interrupt number or -EINVAl if @nr is out of range.
  */
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 {
-	if (dev->msix_enabled) {
-		struct msi_desc *entry;
-		int i =3D 0;
-
-		for_each_pci_msi_entry(entry, dev) {
-			if (i =3D=3D nr)
-				return entry->irq;
-			i++;
-		}
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
+	unsigned int irq;
=20
-	if (dev->msi_enabled) {
-		struct msi_desc *entry =3D first_pci_msi_entry(dev);
-
-		if (WARN_ON_ONCE(nr >=3D entry->nvec_used))
-			return -EINVAL;
-	} else {
-		if (WARN_ON_ONCE(nr > 0))
-			return -EINVAL;
-	}
+	if (!dev->msi_enabled && !dev->msix_enabled)
+		return !nr ? dev->irq : -EINVAL;
=20
-	return dev->irq + nr;
+	irq =3D msi_get_virq(&dev->dev, nr);
+	return irq ? irq : -EINVAL;
 }
 EXPORT_SYMBOL(pci_irq_vector);
=20
@@ -1230,332 +1090,58 @@ EXPORT_SYMBOL(pci_irq_vector);
  * pci_irq_get_affinity - return the affinity of a particular MSI vector
  * @dev:	PCI device to operate on
  * @nr:		device-relative interrupt vector index (0-based).
+ *
+ * @nr has the following meanings depending on the interrupt mode:
+ *   MSI-X:	The index in the MSI-X vector table
+ *   MSI:	The index of the enabled MSI vectors
+ *   INTx:	Must be 0
+ *
+ * Return: A cpumask pointer or NULL if @nr is out of range
  */
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 {
-	if (dev->msix_enabled) {
-		struct msi_desc *entry;
-		int i =3D 0;
+	int idx, irq =3D pci_irq_vector(dev, nr);
+	struct msi_desc *desc;
=20
-		for_each_pci_msi_entry(entry, dev) {
-			if (i =3D=3D nr)
-				return &entry->affinity->mask;
-			i++;
-		}
-		WARN_ON_ONCE(1);
+	if (WARN_ON_ONCE(irq <=3D 0))
 		return NULL;
-	} else if (dev->msi_enabled) {
-		struct msi_desc *entry =3D first_pci_msi_entry(dev);
=20
-		if (WARN_ON_ONCE(!entry || !entry->affinity ||
-				 nr >=3D entry->nvec_used))
-			return NULL;
-
-		return &entry->affinity[nr].mask;
-	} else {
+	desc =3D irq_get_msi_desc(irq);
+	/* Non-MSI does not have the information handy */
+	if (!desc)
 		return cpu_possible_mask;
-	}
-}
-EXPORT_SYMBOL(pci_irq_get_affinity);
=20
-struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
-{
-	return to_pci_dev(desc->dev);
-}
-EXPORT_SYMBOL(msi_desc_to_pci_dev);
-
-void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
-{
-	struct pci_dev *dev =3D msi_desc_to_pci_dev(desc);
-
-	return dev->bus->sysdata;
-}
-EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
-
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-/**
- * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
- * @irq_data:	Pointer to interrupt data of the MSI interrupt
- * @msg:	Pointer to the message
- */
-void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
-{
-	struct msi_desc *desc =3D irq_data_get_msi_desc(irq_data);
+	if (WARN_ON_ONCE(!desc->affinity))
+		return NULL;
=20
 	/*
-	 * For MSI-X desc->irq is always equal to irq_data->irq. For
-	 * MSI only the first interrupt of MULTI MSI passes the test.
+	 * MSI has a mask array in the descriptor.
+	 * MSI-X has a single mask.
 	 */
-	if (desc->irq =3D=3D irq_data->irq)
-		__pci_write_msi_msg(desc, msg);
-}
-
-/**
- * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
- * @desc:	Pointer to the MSI descriptor
- *
- * The ID number is only used within the irqdomain.
- */
-static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
-{
-	struct pci_dev *dev =3D msi_desc_to_pci_dev(desc);
-
-	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
-		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
-}
-
-static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
-{
-	return !desc->msi_attrib.is_msix && desc->nvec_used > 1;
-}
-
-/**
- * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
- * 			      for @dev
- * @domain:	The interrupt domain to check
- * @info:	The domain info for verification
- * @dev:	The device to check
- *
- * Returns:
- *  0 if the functionality is supported
- *  1 if Multi MSI is requested, but the domain does not support it
- *  -ENOTSUPP otherwise
- */
-int pci_msi_domain_check_cap(struct irq_domain *domain,
-			     struct msi_domain_info *info, struct device *dev)
-{
-	struct msi_desc *desc =3D first_pci_msi_entry(to_pci_dev(dev));
-
-	/* Special handling to support __pci_enable_msi_range() */
-	if (pci_msi_desc_is_multi_msi(desc) &&
-	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
-		return 1;
-	else if (desc->msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
-		return -ENOTSUPP;
-
-	return 0;
-}
-
-static int pci_msi_domain_handle_error(struct irq_domain *domain,
-				       struct msi_desc *desc, int error)
-{
-	/* Special handling to support __pci_enable_msi_range() */
-	if (pci_msi_desc_is_multi_msi(desc) && error =3D=3D -ENOSPC)
-		return 1;
-
-	return error;
-}
-
-static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
-				    struct msi_desc *desc)
-{
-	arg->desc =3D desc;
-	arg->hwirq =3D pci_msi_domain_calc_hwirq(desc);
-}
-
-static struct msi_domain_ops pci_msi_domain_ops_default =3D {
-	.set_desc	=3D pci_msi_domain_set_desc,
-	.msi_check	=3D pci_msi_domain_check_cap,
-	.handle_error	=3D pci_msi_domain_handle_error,
-};
-
-static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
-{
-	struct msi_domain_ops *ops =3D info->ops;
-
-	if (ops =3D=3D NULL) {
-		info->ops =3D &pci_msi_domain_ops_default;
-	} else {
-		if (ops->set_desc =3D=3D NULL)
-			ops->set_desc =3D pci_msi_domain_set_desc;
-		if (ops->msi_check =3D=3D NULL)
-			ops->msi_check =3D pci_msi_domain_check_cap;
-		if (ops->handle_error =3D=3D NULL)
-			ops->handle_error =3D pci_msi_domain_handle_error;
-	}
-}
-
-static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
-{
-	struct irq_chip *chip =3D info->chip;
-
-	BUG_ON(!chip);
-	if (!chip->irq_write_msi_msg)
-		chip->irq_write_msi_msg =3D pci_msi_domain_write_msg;
-	if (!chip->irq_mask)
-		chip->irq_mask =3D pci_msi_mask_irq;
-	if (!chip->irq_unmask)
-		chip->irq_unmask =3D pci_msi_unmask_irq;
-}
-
-/**
- * pci_msi_create_irq_domain - Create a MSI interrupt domain
- * @fwnode:	Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Updates the domain and chip ops and creates a MSI interrupt domain.
- *
- * Returns:
- * A domain pointer or NULL in case of failure.
- */
-struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
-					     struct msi_domain_info *info,
-					     struct irq_domain *parent)
-{
-	struct irq_domain *domain;
-
-	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
-		info->flags &=3D ~MSI_FLAG_LEVEL_CAPABLE;
-
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		pci_msi_domain_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		pci_msi_domain_update_chip_ops(info);
-
-	info->flags |=3D MSI_FLAG_ACTIVATE_EARLY;
-	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
-		info->flags |=3D MSI_FLAG_MUST_REACTIVATE;
-
-	/* PCI-MSI is oneshot-safe */
-	info->chip->flags |=3D IRQCHIP_ONESHOT_SAFE;
-
-	domain =3D msi_create_irq_domain(fwnode, info, parent);
-	if (!domain)
-		return NULL;
-
-	irq_domain_update_bus_token(domain, DOMAIN_BUS_PCI_MSI);
-	return domain;
-}
-EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
-
-/*
- * Users of the generic MSI infrastructure expect a device to have a single =
ID,
- * so with DMA aliases we have to pick the least-worst compromise. Devices w=
ith
- * DMA phantom functions tend to still emit MSIs from the real function numb=
er,
- * so we ignore those and only consider topological aliases where either the
- * alias device or RID appears on a different bus number. We also make the
- * reasonable assumption that bridges are walked in an upstream direction (so
- * the last one seen wins), and the much braver assumption that the most lik=
ely
- * case is that of PCI->PCIe so we should always use the alias RID. This ech=
oes
- * the logic from intel_irq_remapping's set_msi_sid(), which presumably works
- * well enough in practice; in the face of the horrible PCIe<->PCI-X conditi=
ons
- * for taking ownership all we can really do is close our eyes and hope...
- */
-static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
-{
-	u32 *pa =3D data;
-	u8 bus =3D PCI_BUS_NUM(*pa);
-
-	if (pdev->bus->number !=3D bus || PCI_BUS_NUM(alias) !=3D bus)
-		*pa =3D alias;
-
-	return 0;
+	idx =3D dev->msi_enabled ? nr : 0;
+	return &desc->affinity[idx].mask;
 }
+EXPORT_SYMBOL(pci_irq_get_affinity);
=20
-/**
- * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
- * @domain:	The interrupt domain
- * @pdev:	The PCI device.
- *
- * The RID for a device is formed from the alias, with a firmware
- * supplied mapping applied
- *
- * Returns: The RID.
- */
-u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pd=
ev)
+struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
-	struct device_node *of_node;
-	u32 rid =3D pci_dev_id(pdev);
-
-	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-
-	of_node =3D irq_domain_get_of_node(domain);
-	rid =3D of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
-			iort_msi_map_id(&pdev->dev, rid);
-
-	return rid;
+	return to_pci_dev(desc->dev);
 }
+EXPORT_SYMBOL(msi_desc_to_pci_dev);
=20
-/**
- * pci_msi_get_device_domain - Get the MSI domain for a given PCI device
- * @pdev:	The PCI device
- *
- * Use the firmware data to find a device-specific MSI domain
- * (i.e. not one that is set as a default).
- *
- * Returns: The corresponding MSI domain or NULL if none has been found.
- */
-struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
+void pci_no_msi(void)
 {
-	struct irq_domain *dom;
-	u32 rid =3D pci_dev_id(pdev);
-
-	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-	dom =3D of_msi_map_get_device_domain(&pdev->dev, rid, DOMAIN_BUS_PCI_MSI);
-	if (!dom)
-		dom =3D iort_get_device_domain(&pdev->dev, rid,
-					     DOMAIN_BUS_PCI_MSI);
-	return dom;
+	pci_msi_enable =3D 0;
 }
=20
 /**
- * pci_dev_has_special_msi_domain - Check whether the device is handled by
- *				    a non-standard PCI-MSI domain
- * @pdev:	The PCI device to check.
+ * pci_msi_enabled - is MSI enabled?
  *
- * Returns: True if the device irqdomain or the bus irqdomain is
- * non-standard PCI/MSI.
- */
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
-{
-	struct irq_domain *dom =3D dev_get_msi_domain(&pdev->dev);
-
-	if (!dom)
-		dom =3D dev_get_msi_domain(&pdev->bus->dev);
-
-	if (!dom)
-		return true;
-
-	return dom->bus_token !=3D DOMAIN_BUS_PCI_MSI;
-}
-
-#endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
-#endif /* CONFIG_PCI_MSI */
-
-void pci_msi_init(struct pci_dev *dev)
-{
-	u16 ctrl;
-
-	/*
-	 * Disable the MSI hardware to avoid screaming interrupts
-	 * during boot.  This is the power on reset default so
-	 * usually this should be a noop.
-	 */
-	dev->msi_cap =3D pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (!dev->msi_cap)
-		return;
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
-	if (ctrl & PCI_MSI_FLAGS_ENABLE)
-		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
-				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
-
-	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
-		dev->no_64bit_msi =3D 1;
-}
-
-void pci_msix_init(struct pci_dev *dev)
+ * Returns true if MSI has not been disabled by the command-line option
+ * pci=3Dnomsi.
+ **/
+int pci_msi_enabled(void)
 {
-	u16 ctrl;
-
-	dev->msix_cap =3D pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (!dev->msix_cap)
-		return;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
-	if (ctrl & PCI_MSIX_FLAGS_ENABLE)
-		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
-				      ctrl & ~PCI_MSIX_FLAGS_ENABLE);
+	return pci_msi_enable;
 }
+EXPORT_SYMBOL(pci_msi_enabled);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
new file mode 100644
index 000000000000..dbeff066bedd
--- /dev/null
+++ b/drivers/pci/msi/msi.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/pci.h>
+#include <linux/msi.h>
+
+#define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
+
+extern int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+extern void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
+
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
+extern int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int =
type);
+extern void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
+#else
+static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nve=
c, int type)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
+
+static inline void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
+/*
+ * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
+ * mask all MSI interrupts by clearing the MSI enable bit does not work
+ * reliably as devices without an INTx disable bit will then generate a
+ * level IRQ which will never be cleared.
+ */
+static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
+{
+	/* Don't shift by >=3D width of type */
+	if (desc->pci.msi_attrib.multi_cap >=3D 5)
+		return 0xffffffff;
+	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
+}
diff --git a/drivers/pci/msi/pcidev_msi.c b/drivers/pci/msi/pcidev_msi.c
new file mode 100644
index 000000000000..5520aff53b56
--- /dev/null
+++ b/drivers/pci/msi/pcidev_msi.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MSI[X} related functions which are available unconditionally.
+ */
+#include "../pci.h"
+
+/*
+ * Disable the MSI[X] hardware to avoid screaming interrupts during boot.
+ * This is the power on reset default so usually this should be a noop.
+ */
+
+void pci_msi_init(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	dev->msi_cap =3D pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (!dev->msi_cap)
+		return;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
+	if (ctrl & PCI_MSI_FLAGS_ENABLE) {
+		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
+				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
+	}
+
+	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
+		dev->no_64bit_msi =3D 1;
+}
+
+void pci_msix_init(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	dev->msix_cap =3D pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (!dev->msix_cap)
+		return;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	if (ctrl & PCI_MSIX_FLAGS_ENABLE) {
+		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
+				      ctrl & ~PCI_MSIX_FLAGS_ENABLE);
+	}
+}
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index cfe2f85af09e..602f0fb0b007 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -62,11 +62,8 @@ static ssize_t irq_show(struct device *dev,
 	 * For MSI, show the first MSI IRQ; for all other cases including
 	 * MSI-X, show the legacy INTx IRQ.
 	 */
-	if (pdev->msi_enabled) {
-		struct msi_desc *desc =3D first_pci_msi_entry(pdev);
-
-		return sysfs_emit(buf, "%u\n", desc->irq);
-	}
+	if (pdev->msi_enabled)
+		return sysfs_emit(buf, "%u\n", pci_irq_vector(pdev, 0));
 #endif
=20
 	return sysfs_emit(buf, "%u\n", pdev->irq);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb394986a..f3f606c232a8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2024,11 +2024,6 @@ static void pcim_release(struct device *gendev, void *=
res)
 	struct pci_devres *this =3D res;
 	int i;
=20
-	if (dev->msi_enabled)
-		pci_disable_msi(dev);
-	if (dev->msix_enabled)
-		pci_disable_msix(dev);
-
 	for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++)
 		if (this->region_mask & (1 << i))
 			pci_release_region(dev, i);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 087d3658f75c..443efb00e219 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2311,7 +2311,9 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type =3D &pci_dev_type;
 	dev->bus =3D pci_bus_get(bus);
-
+#ifdef CONFIG_PCI_MSI
+	raw_spin_lock_init(&dev->msi_lock);
+#endif
 	return dev;
 }
 EXPORT_SYMBOL(pci_alloc_dev);
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index d858d25b6cab..d2a7b9fd678b 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -262,8 +262,8 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
 	}
=20
 	i =3D 0;
-	for_each_pci_msi_entry(entry, dev) {
-		op.msix_entries[i].entry =3D entry->msi_attrib.entry_nr;
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
+		op.msix_entries[i].entry =3D entry->msi_index;
 		/* Vector is useless at this point. */
 		op.msix_entries[i].vector =3D -1;
 		i++;
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 226348822ab3..fdbc3ec20f4b 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -684,7 +684,6 @@ static void smmu_pmu_write_msi_msg(struct msi_desc *desc,=
 struct msi_msg *msg)
=20
 static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 {
-	struct msi_desc *desc;
 	struct device *dev =3D pmu->dev;
 	int ret;
=20
@@ -701,9 +700,7 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 		return;
 	}
=20
-	desc =3D first_msi_entry(dev);
-	if (desc)
-		pmu->irq =3D desc->irq;
+	pmu->irq =3D msi_get_virq(dev, 0);
=20
 	/* Add callback to free MSIs on teardown */
 	devm_add_action(dev, smmu_pmu_free_msis, dev);
diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-d=
river.c
index dd948889eeab..5a2edc48dd79 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -88,7 +88,7 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_devi=
ce *dpio_dev)
 	irq =3D dpio_dev->irqs[0];
=20
 	/* clear the affinity hint */
-	irq_set_affinity_hint(irq->msi_desc->irq, NULL);
+	irq_set_affinity_hint(irq->virq, NULL);
 }
=20
 static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cp=
u)
@@ -98,7 +98,7 @@ static int register_dpio_irq_handlers(struct fsl_mc_device =
*dpio_dev, int cpu)
=20
 	irq =3D dpio_dev->irqs[0];
 	error =3D devm_request_irq(&dpio_dev->dev,
-				 irq->msi_desc->irq,
+				 irq->virq,
 				 dpio_irq_handler,
 				 0,
 				 dev_name(&dpio_dev->dev),
@@ -111,10 +111,10 @@ static int register_dpio_irq_handlers(struct fsl_mc_dev=
ice *dpio_dev, int cpu)
 	}
=20
 	/* set the affinity hint */
-	if (irq_set_affinity_hint(irq->msi_desc->irq, cpumask_of(cpu)))
+	if (irq_set_affinity_hint(irq->virq, cpumask_of(cpu)))
 		dev_err(&dpio_dev->dev,
 			"irq_set_affinity failed irq %d cpu %d\n",
-			irq->msi_desc->irq, cpu);
+			irq->virq, cpu);
=20
 	return 0;
 }
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 312ba0f98ad7..56be39161489 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -647,7 +647,7 @@ int k3_ringacc_get_ring_irq_num(struct k3_ring *ring)
 	if (!ring)
 		return -EINVAL;
=20
-	irq_num =3D ti_sci_inta_msi_get_virq(ring->parent->dev, ring->ring_id);
+	irq_num =3D msi_get_virq(ring->parent->dev, ring->ring_id);
 	if (irq_num <=3D 0)
 		irq_num =3D -EINVAL;
 	return irq_num;
@@ -1356,9 +1356,9 @@ static int k3_ringacc_init(struct platform_device *pdev,
 	struct resource *res;
 	int ret, i;
=20
-	dev->msi_domain =3D of_msi_get_domain(dev, dev->of_node,
+	dev->msi.domain =3D of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
-	if (!dev->msi_domain) {
+	if (!dev->msi.domain) {
 		dev_err(dev, "Failed to get MSI domain\n");
 		return -EPROBE_DEFER;
 	}
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_ms=
i.c
index a1d9c027022a..991c78b34745 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -51,6 +51,7 @@ struct irq_domain *ti_sci_inta_msi_create_irq_domain(struct=
 fwnode_handle *fwnod
 	struct irq_domain *domain;
=20
 	ti_sci_inta_msi_update_chip_ops(info);
+	info->flags |=3D MSI_FLAG_FREE_MSI_DESCS;
=20
 	domain =3D msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -60,50 +61,32 @@ struct irq_domain *ti_sci_inta_msi_create_irq_domain(stru=
ct fwnode_handle *fwnod
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_create_irq_domain);
=20
-static void ti_sci_inta_msi_free_descs(struct device *dev)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
-}
-
 static int ti_sci_inta_msi_alloc_descs(struct device *dev,
 				       struct ti_sci_resource *res)
 {
-	struct msi_desc *msi_desc;
+	struct msi_desc msi_desc;
 	int set, i, count =3D 0;
=20
+	memset(&msi_desc, 0, sizeof(msi_desc));
+	msi_desc.nvec_used =3D 1;
+
 	for (set =3D 0; set < res->sets; set++) {
-		for (i =3D 0; i < res->desc[set].num; i++) {
-			msi_desc =3D alloc_msi_entry(dev, 1, NULL);
-			if (!msi_desc) {
-				ti_sci_inta_msi_free_descs(dev);
-				return -ENOMEM;
-			}
-
-			msi_desc->inta.dev_index =3D res->desc[set].start + i;
-			INIT_LIST_HEAD(&msi_desc->list);
-			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-			count++;
+		for (i =3D 0; i < res->desc[set].num; i++, count++) {
+			msi_desc.msi_index =3D res->desc[set].start + i;
+			if (msi_add_msi_desc(dev, &msi_desc))
+				goto fail;
 		}
-		for (i =3D 0; i < res->desc[set].num_sec; i++) {
-			msi_desc =3D alloc_msi_entry(dev, 1, NULL);
-			if (!msi_desc) {
-				ti_sci_inta_msi_free_descs(dev);
-				return -ENOMEM;
-			}
-
-			msi_desc->inta.dev_index =3D res->desc[set].start_sec + i;
-			INIT_LIST_HEAD(&msi_desc->list);
-			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-			count++;
+
+		for (i =3D 0; i < res->desc[set].num_sec; i++, count++) {
+			msi_desc.msi_index =3D res->desc[set].start_sec + i;
+			if (msi_add_msi_desc(dev, &msi_desc))
+				goto fail;
 		}
 	}
-
 	return count;
+fail:
+	msi_free_msi_descs(dev);
+	return -ENOMEM;
 }
=20
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
@@ -120,39 +103,22 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *de=
v,
 	if (pdev->id < 0)
 		return -ENODEV;
=20
-	nvec =3D ti_sci_inta_msi_alloc_descs(dev, res);
-	if (nvec <=3D 0)
-		return nvec;
+	ret =3D msi_setup_device_data(dev);
+	if (ret)
+		return ret;
=20
-	ret =3D msi_domain_alloc_irqs(msi_domain, dev, nvec);
-	if (ret) {
-		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
-		goto cleanup;
+	msi_lock_descs(dev);
+	nvec =3D ti_sci_inta_msi_alloc_descs(dev, res);
+	if (nvec <=3D 0) {
+		ret =3D nvec;
+		goto unlock;
 	}
=20
-	return 0;
-
-cleanup:
-	ti_sci_inta_msi_free_descs(&pdev->dev);
+	ret =3D msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);
+	if (ret)
+		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
+unlock:
+	msi_unlock_descs(dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
-
-void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
-{
-	msi_domain_free_irqs(dev->msi_domain, dev);
-	ti_sci_inta_msi_free_descs(dev);
-}
-EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
-
-unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 dev_index)
-{
-	struct msi_desc *desc;
-
-	for_each_msi_entry(desc, dev)
-		if (desc->inta.dev_index =3D=3D dev_index)
-			return desc->irq;
-
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(ti_sci_inta_msi_get_virq);
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfi=
o_fsl_mc_intr.c
index 77e584093a23..7b428eac3d3e 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -67,7 +67,7 @@ static int vfio_set_trigger(struct vfio_fsl_mc_device *vdev,
 	int hwirq;
 	int ret;
=20
-	hwirq =3D vdev->mc_dev->irqs[index]->msi_desc->irq;
+	hwirq =3D vdev->mc_dev->irqs[index]->virq;
 	if (irq->trigger) {
 		free_irq(hwirq, irq);
 		kfree(irq->name);
@@ -137,7 +137,7 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc=
_device *vdev,
 		return vfio_set_trigger(vdev, index, fd);
 	}
=20
-	hwirq =3D vdev->mc_dev->irqs[index]->msi_desc->irq;
+	hwirq =3D vdev->mc_dev->irqs[index]->virq;
=20
 	irq =3D &vdev->mc_irqs[index];
=20
diff --git a/include/linux/device.h b/include/linux/device.h
index e270cb740b9e..93459724dcde 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -45,6 +45,7 @@ struct iommu_ops;
 struct iommu_group;
 struct dev_pin_info;
 struct dev_iommu;
+struct msi_device_data;
=20
 /**
  * struct subsys_interface - interfaces to device functions
@@ -371,6 +372,20 @@ struct dev_links_info {
 	enum dl_dev_state status;
 };
=20
+/**
+ * struct dev_msi_info - Device data related to MSI
+ * @domain:	The MSI interrupt domain associated to the device
+ * @data:	Pointer to MSI device data
+ */
+struct dev_msi_info {
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	struct irq_domain	*domain;
+#endif
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	struct msi_device_data	*data;
+#endif
+};
+
 /**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
@@ -407,9 +422,7 @@ struct dev_links_info {
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
- * @msi_lock:	Lock to protect MSI mask cache and mask register
- * @msi_list:	Hosts MSI descriptors
- * @msi_domain: The generic MSI domain this device is using.
+ * @msi:	MSI related data
  * @numa_node:	NUMA node this device is close to.
  * @dma_ops:    DMA mapping operations for this device.
  * @dma_mask:	Dma mask (if dma'ble device).
@@ -501,16 +514,10 @@ struct device {
 	struct em_perf_domain	*em_pd;
 #endif
=20
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	struct irq_domain	*msi_domain;
-#endif
 #ifdef CONFIG_PINCTRL
 	struct dev_pin_info	*pins;
 #endif
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	raw_spinlock_t		msi_lock;
-	struct list_head	msi_list;
-#endif
+	struct dev_msi_info	msi;
 #ifdef CONFIG_DMA_OPS
 	const struct dma_map_ops *dma_ops;
 #endif
@@ -668,7 +675,7 @@ static inline void set_dev_node(struct device *dev, int n=
ode)
 static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	return dev->msi_domain;
+	return dev->msi.domain;
 #else
 	return NULL;
 #endif
@@ -677,7 +684,7 @@ static inline struct irq_domain *dev_get_msi_domain(const=
 struct device *dev)
 static inline void dev_set_msi_domain(struct device *dev, struct irq_domain =
*d)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	dev->msi_domain =3D d;
+	dev->msi.domain =3D d;
 #endif
 }
=20
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index e026f6c48b49..7b6c42bfb660 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -91,13 +91,13 @@ struct fsl_mc_resource {
=20
 /**
  * struct fsl_mc_device_irq - MC object device message-based interrupt
- * @msi_desc: pointer to MSI descriptor allocated by fsl_mc_msi_alloc_descs()
+ * @virq: Linux virtual interrupt number
  * @mc_dev: MC object device that owns this interrupt
  * @dev_irq_index: device-relative IRQ index
  * @resource: MC generic resource associated with the interrupt
  */
 struct fsl_mc_device_irq {
-	struct msi_desc *msi_desc;
+	unsigned int virq;
 	struct fsl_mc_device *mc_dev;
 	u8 dev_irq_index;
 	struct fsl_mc_resource resource;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e616f94c7c58..fc918a658d48 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -2,7 +2,23 @@
 #ifndef LINUX_MSI_H
 #define LINUX_MSI_H
=20
-#include <linux/kobject.h>
+/*
+ * This header file contains MSI data structures and functions which are
+ * only relevant for:
+ *	- Interrupt core code
+ *	- PCI/MSI core code
+ *	- MSI interrupt domain implementations
+ *	- IOMMU, low level VFIO, NTB and other justified exceptions
+ *	  dealing with low level MSI details.
+ *
+ * Regular device drivers have no business with any of these functions and
+ * especially storing MSI descriptor pointers in random code is considered
+ * abuse. The only function which is relevant for drivers is msi_get_virq().
+ */
+
+#include <linux/cpumask.h>
+#include <linux/xarray.h>
+#include <linux/mutex.h>
 #include <linux/list.h>
 #include <asm/msi.h>
=20
@@ -56,6 +72,8 @@ struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
+struct device_attribute;
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -69,62 +87,59 @@ typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
 				    struct msi_msg *msg);
=20
 /**
- * platform_msi_desc - Platform device specific msi descriptor data
- * @msi_priv_data:	Pointer to platform private data
- * @msi_index:		The index of the MSI descriptor for multi MSI
- */
-struct platform_msi_desc {
-	struct platform_msi_priv_data	*msi_priv_data;
-	u16				msi_index;
-};
-
-/**
- * fsl_mc_msi_desc - FSL-MC device specific msi descriptor data
- * @msi_index:		The index of the MSI descriptor
+ * pci_msi_desc - PCI/MSI specific MSI descriptor data
+ *
+ * @msi_mask:	[PCI MSI]   MSI cached mask bits
+ * @msix_ctrl:	[PCI MSI-X] MSI-X cached per vector control bits
+ * @is_msix:	[PCI MSI/X] True if MSI-X
+ * @multiple:	[PCI MSI/X] log2 num of messages allocated
+ * @multi_cap:	[PCI MSI/X] log2 num of messages supported
+ * @can_mask:	[PCI MSI/X] Masking supported?
+ * @is_64:	[PCI MSI/X] Address size: 0=3D32bit 1=3D64bit
+ * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
+ * @mask_pos:	[PCI MSI]   Mask register position
+ * @mask_base:	[PCI MSI-X] Mask register base address
  */
-struct fsl_mc_msi_desc {
-	u16				msi_index;
+struct pci_msi_desc {
+	union {
+		u32 msi_mask;
+		u32 msix_ctrl;
+	};
+	struct {
+		u8	is_msix		: 1;
+		u8	multiple	: 3;
+		u8	multi_cap	: 3;
+		u8	can_mask	: 1;
+		u8	is_64		: 1;
+		u8	is_virtual	: 1;
+		unsigned default_irq;
+	} msi_attrib;
+	union {
+		u8	mask_pos;
+		void __iomem *mask_base;
+	};
 };
=20
-/**
- * ti_sci_inta_msi_desc - TISCI based INTA specific msi descriptor data
- * @dev_index: TISCI device index
- */
-struct ti_sci_inta_msi_desc {
-	u16	dev_index;
-};
+#define MSI_MAX_INDEX		((unsigned int)USHRT_MAX)
=20
 /**
  * struct msi_desc - Descriptor structure for MSI based interrupts
- * @list:	List head for management
  * @irq:	The base interrupt number
  * @nvec_used:	The number of vectors used
  * @dev:	Pointer to the device which uses this descriptor
  * @msg:	The last set MSI message cached for reuse
  * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
+ * @sysfs_attr:	Pointer to sysfs device attribute
  *
  * @write_msi_msg:	Callback that may be called when the MSI message
  *			address or data changes
  * @write_msi_msg_data:	Data parameter for the callback.
  *
- * @msi_mask:	[PCI MSI]   MSI cached mask bits
- * @msix_ctrl:	[PCI MSI-X] MSI-X cached per vector control bits
- * @is_msix:	[PCI MSI/X] True if MSI-X
- * @multiple:	[PCI MSI/X] log2 num of messages allocated
- * @multi_cap:	[PCI MSI/X] log2 num of messages supported
- * @maskbit:	[PCI MSI/X] Mask-Pending bit supported?
- * @is_64:	[PCI MSI/X] Address size: 0=3D32bit 1=3D64bit
- * @entry_nr:	[PCI MSI/X] Entry which is described by this descriptor
- * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
- * @mask_pos:	[PCI MSI]   Mask register position
- * @mask_base:	[PCI MSI-X] Mask register base address
- * @platform:	[platform]  Platform device specific msi descriptor data
- * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
- * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
+ * @msi_index:	Index of the msi descriptor
+ * @pci:	PCI specific msi descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
-	struct list_head		list;
 	unsigned int			irq;
 	unsigned int			nvec_used;
 	struct device			*dev;
@@ -133,61 +148,71 @@ struct msi_desc {
 #ifdef CONFIG_IRQ_MSI_IOMMU
 	const void			*iommu_cookie;
 #endif
+#ifdef CONFIG_SYSFS
+	struct device_attribute		*sysfs_attrs;
+#endif
=20
 	void (*write_msi_msg)(struct msi_desc *entry, void *data);
 	void *write_msi_msg_data;
=20
-	union {
-		/* PCI MSI/X specific data */
-		struct {
-			union {
-				u32 msi_mask;
-				u32 msix_ctrl;
-			};
-			struct {
-				u8	is_msix		: 1;
-				u8	multiple	: 3;
-				u8	multi_cap	: 3;
-				u8	can_mask	: 1;
-				u8	is_64		: 1;
-				u8	is_virtual	: 1;
-				u16	entry_nr;
-				unsigned default_irq;
-			} msi_attrib;
-			union {
-				u8	mask_pos;
-				void __iomem *mask_base;
-			};
-		};
-
-		/*
-		 * Non PCI variants add their data structure here. New
-		 * entries need to use a named structure. We want
-		 * proper name spaces for this. The PCI part is
-		 * anonymous for now as it would require an immediate
-		 * tree wide cleanup.
-		 */
-		struct platform_msi_desc platform;
-		struct fsl_mc_msi_desc fsl_mc;
-		struct ti_sci_inta_msi_desc inta;
-	};
+	u16				msi_index;
+	struct pci_msi_desc		pci;
+};
+
+/*
+ * Filter values for the MSI descriptor iterators and accessor functions.
+ */
+enum msi_desc_filter {
+	/* All descriptors */
+	MSI_DESC_ALL,
+	/* Descriptors which have no interrupt associated */
+	MSI_DESC_NOTASSOCIATED,
+	/* Descriptors which have an interrupt associated */
+	MSI_DESC_ASSOCIATED,
 };
=20
-/* Helpers to hide struct msi_desc implementation details */
+/**
+ * msi_device_data - MSI per device data
+ * @properties:		MSI properties which are interesting to drivers
+ * @platform_data:	Platform-MSI specific data
+ * @mutex:		Mutex protecting the MSI descriptor store
+ * @__store:		Xarray for storing MSI descriptor pointers
+ * @__iter_idx:		Index to search the next entry for iterators
+ */
+struct msi_device_data {
+	unsigned long			properties;
+	struct platform_msi_priv_data	*platform_data;
+	struct mutex			mutex;
+	struct xarray			__store;
+	unsigned long			__iter_idx;
+};
+
+int msi_setup_device_data(struct device *dev);
+
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
+void msi_lock_descs(struct device *dev);
+void msi_unlock_descs(struct device *dev);
+
+struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter fil=
ter);
+struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filt=
er);
+
+/**
+ * msi_for_each_desc - Iterate the MSI descriptors
+ *
+ * @desc:	struct msi_desc pointer used as iterator
+ * @dev:	struct device pointer - device to iterate
+ * @filter:	Filter for descriptor selection
+ *
+ * Notes:
+ *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
+ *    pair.
+ *  - It is safe to remove a retrieved MSI descriptor in the loop.
+ */
+#define msi_for_each_desc(desc, dev, filter)			\
+	for ((desc) =3D msi_first_desc((dev), (filter)); (desc);	\
+	     (desc) =3D msi_next_desc((dev), (filter)))
+
 #define msi_desc_to_dev(desc)		((desc)->dev)
-#define dev_to_msi_list(dev)		(&(dev)->msi_list)
-#define first_msi_entry(dev)		\
-	list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
-#define for_each_msi_entry(desc, dev)	\
-	list_for_each_entry((desc), dev_to_msi_list((dev)), list)
-#define for_each_msi_entry_safe(desc, tmp, dev)	\
-	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
-#define for_each_msi_vector(desc, __irq, dev)				\
-	for_each_msi_entry((desc), (dev))				\
-		if ((desc)->irq)					\
-			for (__irq =3D (desc)->irq;			\
-			     __irq < ((desc)->irq + (desc)->nvec_used);	\
-			     __irq++)
=20
 #ifdef CONFIG_IRQ_MSI_IOMMU
 static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
@@ -213,36 +238,33 @@ static inline void msi_desc_set_iommu_cookie(struct msi=
_desc *desc,
 #endif
=20
 #ifdef CONFIG_PCI_MSI
-#define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
-#define for_each_pci_msi_entry(desc, pdev)	\
-	for_each_msi_entry((desc), &(pdev)->dev)
-
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
-void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else /* CONFIG_PCI_MSI */
-static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
-{
-	return NULL;
-}
 static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
 {
 }
 #endif /* CONFIG_PCI_MSI */
=20
-struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
-				 const struct irq_affinity_desc *affinity);
-void free_msi_entry(struct msi_desc *entry);
+int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
+void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filte=
r,
+			      unsigned int first_index, unsigned int last_index);
+
+/**
+ * msi_free_msi_descs - Free MSI descriptors of a device
+ * @dev:	Device to free the descriptors
+ */
+static inline void msi_free_msi_descs(struct device *dev)
+{
+	msi_free_msi_descs_range(dev, MSI_DESC_ALL, 0, MSI_MAX_INDEX);
+}
+
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
=20
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
=20
-const struct attribute_group **msi_populate_sysfs(struct device *dev);
-void msi_destroy_sysfs(struct device *dev,
-		       const struct attribute_group **msi_irq_groups);
-
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
  * as weak symbols so that they /can/ be overriden by architecture specific
@@ -256,25 +278,20 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_=
desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
-#else
-static inline int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int typ=
e)
-{
-	WARN_ON_ONCE(1);
-	return -ENODEV;
-}
-
-static inline void arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	WARN_ON_ONCE(1);
-}
-#endif
+#ifdef CONFIG_SYSFS
+int msi_device_populate_sysfs(struct device *dev);
+void msi_device_destroy_sysfs(struct device *dev);
+#else /* CONFIG_SYSFS */
+static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
+static inline void msi_device_destroy_sysfs(struct device *dev) { }
+#endif /* !CONFIG_SYSFS */
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
=20
 /*
- * The restore hooks are still available as they are useful even
- * for fully irq domain based setups. Courtesy to XEN/X86.
+ * The restore hook is still available even for fully irq domain based
+ * setups. Courtesy to XEN/X86.
  */
-void arch_restore_msi_irqs(struct pci_dev *dev);
-void default_restore_msi_irqs(struct pci_dev *dev);
+bool arch_restore_msi_irqs(struct pci_dev *dev);
=20
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
=20
@@ -294,20 +311,17 @@ struct msi_domain_info;
  * @msi_free:		Domain specific function to free a MSI interrupts
  * @msi_check:		Callback for verification of the domain/info/dev data
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
- * @msi_finish:		Optional callback to finalize the allocation
  * @set_desc:		Set the msi descriptor for an interrupt
- * @handle_error:	Optional error handler if the allocation fails
  * @domain_alloc_irqs:	Optional function to override the default allocation
  *			function.
  * @domain_free_irqs:	Optional function to override the default free
  *			function.
  *
- * @get_hwirq, @msi_init and @msi_free are callbacks used by
- * msi_create_irq_domain() and related interfaces
+ * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
+ * irqdomain.
  *
- * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
- * are callbacks used by msi_domain_alloc_irqs() and related
- * interfaces which are based on msi_desc.
+ * @msi_check, @msi_prepare and @set_desc are callbacks used by
+ * msi_domain_alloc/free_irqs().
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
  * default allocation/free functions (__msi_domain_alloc/free_irqs). This
@@ -341,11 +355,8 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
-	void		(*msi_finish)(msi_alloc_info_t *arg, int retval);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
-	int		(*handle_error)(struct irq_domain *domain,
-					struct msi_desc *desc, int error);
 	int		(*domain_alloc_irqs)(struct irq_domain *domain,
 					     struct device *dev, int nvec);
 	void		(*domain_free_irqs)(struct irq_domain *domain,
@@ -399,6 +410,14 @@ enum {
 	MSI_FLAG_MUST_REACTIVATE	=3D (1 << 5),
 	/* Is level-triggered capable, using two messages */
 	MSI_FLAG_LEVEL_CAPABLE		=3D (1 << 6),
+	/* Populate sysfs on alloc() and destroy it on free() */
+	MSI_FLAG_DEV_SYSFS		=3D (1 << 7),
+	/* MSI-X entries must be contiguous */
+	MSI_FLAG_MSIX_CONTIGUOUS	=3D (1 << 8),
+	/* Allocate simple MSI descriptors */
+	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	=3D (1 << 9),
+	/* Free MSI descriptors */
+	MSI_FLAG_FREE_MSI_DESCS		=3D (1 << 10),
 };
=20
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mas=
k,
@@ -409,9 +428,12 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_h=
andle *fwnode,
 					 struct irq_domain *parent);
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec);
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct dev=
ice *dev,
+				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct dev=
ice *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
=20
@@ -440,20 +462,17 @@ __platform_msi_create_device_domain(struct device *dev,
 #define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
 	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
=20
-int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nr_irqs);
-void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nvec);
+int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int=
 virq,
+				     unsigned int nr_irqs);
+void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int=
 virq,
+				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
=20
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg=
);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-int pci_msi_domain_check_cap(struct irq_domain *domain,
-			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pd=
ev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..0a7b6b2f163b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -425,7 +425,8 @@ struct pci_dev {
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
-	unsigned int	is_managed:1;
+	unsigned int	is_managed:1;		/* Managed via devres */
+	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
@@ -473,7 +474,8 @@ struct pci_dev {
 	u8		ptm_granularity;
 #endif
 #ifdef CONFIG_PCI_MSI
-	const struct attribute_group **msi_irq_groups;
+	void __iomem	*msix_base;
+	raw_spinlock_t	msi_lock;
 #endif
 	struct pci_vpd	vpd;
 #ifdef CONFIG_PCIE_DPC
diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti=
_sci_inta_msi.h
index e3aa8b14612e..4dba2f2aff6f 100644
--- a/include/linux/soc/ti/ti_sci_inta_msi.h
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -18,6 +18,4 @@ struct irq_domain
 				   struct irq_domain *parent);
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 				      struct ti_sci_resource *res);
-unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 index);
-void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
 #endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7f350ae59c5f..2bdfce5edafd 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -14,12 +14,15 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/pci.h>
=20
 #include "internals.h"
=20
+static inline int msi_sysfs_create_group(struct device *dev);
+
 /**
- * alloc_msi_entry - Allocate an initialized msi_desc
+ * msi_alloc_desc - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
  * @nvec:	The number of vectors used in this entry
  * @affinity:	Optional pointer to an affinity mask array size of @nvec
@@ -29,34 +32,134 @@
  *
  * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
-struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
-				 const struct irq_affinity_desc *affinity)
+static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
+					const struct irq_affinity_desc *affinity)
 {
-	struct msi_desc *desc;
+	struct msi_desc *desc =3D kzalloc(sizeof(*desc), GFP_KERNEL);
=20
-	desc =3D kzalloc(sizeof(*desc), GFP_KERNEL);
 	if (!desc)
 		return NULL;
=20
-	INIT_LIST_HEAD(&desc->list);
 	desc->dev =3D dev;
 	desc->nvec_used =3D nvec;
 	if (affinity) {
-		desc->affinity =3D kmemdup(affinity,
-			nvec * sizeof(*desc->affinity), GFP_KERNEL);
+		desc->affinity =3D kmemdup(affinity, nvec * sizeof(*desc->affinity), GFP_K=
ERNEL);
 		if (!desc->affinity) {
 			kfree(desc);
 			return NULL;
 		}
 	}
-
 	return desc;
 }
=20
-void free_msi_entry(struct msi_desc *entry)
+static void msi_free_desc(struct msi_desc *desc)
 {
-	kfree(entry->affinity);
-	kfree(entry);
+	kfree(desc->affinity);
+	kfree(desc);
+}
+
+static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc=
, unsigned int index)
+{
+	int ret;
+
+	desc->msi_index =3D index;
+	ret =3D xa_insert(&md->__store, index, desc, GFP_KERNEL);
+	if (ret)
+		msi_free_desc(desc);
+	return ret;
+}
+
+/**
+ * msi_add_msi_desc - Allocate and initialize a MSI descriptor
+ * @dev:	Pointer to the device for which the descriptor is allocated
+ * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc)
+{
+	struct msi_desc *desc;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	desc =3D msi_alloc_desc(dev, init_desc->nvec_used, init_desc->affinity);
+	if (!desc)
+		return -ENOMEM;
+
+	/* Copy type specific data to the new descriptor. */
+	desc->pci =3D init_desc->pci;
+	return msi_insert_desc(dev->msi.data, desc, init_desc->msi_index);
+}
+
+/**
+ * msi_add_simple_msi_descs - Allocate and initialize MSI descriptors
+ * @dev:	Pointer to the device for which the descriptors are allocated
+ * @index:	Index for the first MSI descriptor
+ * @ndesc:	Number of descriptors to allocate
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, =
unsigned int ndesc)
+{
+	unsigned int idx, last =3D index + ndesc - 1;
+	struct msi_desc *desc;
+	int ret;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	for (idx =3D index; idx <=3D last; idx++) {
+		desc =3D msi_alloc_desc(dev, 1, NULL);
+		if (!desc)
+			goto fail_mem;
+		ret =3D msi_insert_desc(dev->msi.data, desc, idx);
+		if (ret)
+			goto fail;
+	}
+	return 0;
+
+fail_mem:
+	ret =3D -ENOMEM;
+fail:
+	msi_free_msi_descs_range(dev, MSI_DESC_NOTASSOCIATED, index, last);
+	return ret;
+}
+
+static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filte=
r)
+{
+	switch (filter) {
+	case MSI_DESC_ALL:
+		return true;
+	case MSI_DESC_NOTASSOCIATED:
+		return !desc->irq;
+	case MSI_DESC_ASSOCIATED:
+		return !!desc->irq;
+	}
+	WARN_ON_ONCE(1);
+	return false;
+}
+
+/**
+ * msi_free_msi_descs_range - Free MSI descriptors of a device
+ * @dev:		Device to free the descriptors
+ * @filter:		Descriptor state filter
+ * @first_index:	Index to start freeing from
+ * @last_index:		Last index to be freed
+ */
+void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filte=
r,
+			      unsigned int first_index, unsigned int last_index)
+{
+	struct xarray *xa =3D &dev->msi.data->__store;
+	struct msi_desc *desc;
+	unsigned long idx;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	xa_for_each_range(xa, idx, desc, first_index, last_index) {
+		if (msi_desc_match(desc, filter)) {
+			xa_erase(xa, idx);
+			msi_free_desc(desc);
+		}
+	}
 }
=20
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
@@ -72,139 +175,290 @@ void get_cached_msi_msg(unsigned int irq, struct msi_m=
sg *msg)
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
=20
-static ssize_t msi_mode_show(struct device *dev, struct device_attribute *at=
tr,
-			     char *buf)
+static void msi_device_data_release(struct device *dev, void *res)
 {
-	struct msi_desc *entry;
-	bool is_msix =3D false;
-	unsigned long irq;
-	int retval;
+	struct msi_device_data *md =3D res;
=20
-	retval =3D kstrtoul(attr->attr.name, 10, &irq);
-	if (retval)
-		return retval;
+	WARN_ON_ONCE(!xa_empty(&md->__store));
+	xa_destroy(&md->__store);
+	dev->msi.data =3D NULL;
+}
=20
-	entry =3D irq_get_msi_desc(irq);
-	if (!entry)
-		return -ENODEV;
+/**
+ * msi_setup_device_data - Setup MSI device data
+ * @dev:	Device for which MSI device data should be set up
+ *
+ * Return: 0 on success, appropriate error code otherwise
+ *
+ * This can be called more than once for @dev. If the MSI device data is
+ * already allocated the call succeeds. The allocated memory is
+ * automatically released when the device is destroyed.
+ */
+int msi_setup_device_data(struct device *dev)
+{
+	struct msi_device_data *md;
+	int ret;
=20
-	if (dev_is_pci(dev))
-		is_msix =3D entry->msi_attrib.is_msix;
+	if (dev->msi.data)
+		return 0;
=20
-	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
+	md =3D devres_alloc(msi_device_data_release, sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return -ENOMEM;
+
+	ret =3D msi_sysfs_create_group(dev);
+	if (ret) {
+		devres_free(md);
+		return ret;
+	}
+
+	xa_init(&md->__store);
+	mutex_init(&md->mutex);
+	dev->msi.data =3D md;
+	devres_add(dev, md);
+	return 0;
+}
+
+/**
+ * msi_lock_descs - Lock the MSI descriptor storage of a device
+ * @dev:	Device to operate on
+ */
+void msi_lock_descs(struct device *dev)
+{
+	mutex_lock(&dev->msi.data->mutex);
+}
+EXPORT_SYMBOL_GPL(msi_lock_descs);
+
+/**
+ * msi_unlock_descs - Unlock the MSI descriptor storage of a device
+ * @dev:	Device to operate on
+ */
+void msi_unlock_descs(struct device *dev)
+{
+	/* Invalidate the index wich was cached by the iterator */
+	dev->msi.data->__iter_idx =3D MSI_MAX_INDEX;
+	mutex_unlock(&dev->msi.data->mutex);
+}
+EXPORT_SYMBOL_GPL(msi_unlock_descs);
+
+static struct msi_desc *msi_find_desc(struct msi_device_data *md, enum msi_d=
esc_filter filter)
+{
+	struct msi_desc *desc;
+
+	xa_for_each_start(&md->__store, md->__iter_idx, desc, md->__iter_idx) {
+		if (msi_desc_match(desc, filter))
+			return desc;
+	}
+	md->__iter_idx =3D MSI_MAX_INDEX;
+	return NULL;
 }
=20
 /**
- * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
- * @dev:	The device(PCI, platform etc) who will get sysfs entries
+ * msi_first_desc - Get the first MSI descriptor of a device
+ * @dev:	Device to operate on
+ * @filter:	Descriptor state filter
+ *
+ * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
+ * must be invoked before the call.
  *
- * Return attribute_group ** so that specific bus MSI can save it to
- * somewhere during initilizing msi irqs. If devices has no MSI irq,
- * return NULL; if it fails to populate sysfs, return ERR_PTR
+ * Return: Pointer to the first MSI descriptor matching the search
+ *	   criteria, NULL if none found.
  */
-const struct attribute_group **msi_populate_sysfs(struct device *dev)
-{
-	const struct attribute_group **msi_irq_groups;
-	struct attribute **msi_attrs, *msi_attr;
-	struct device_attribute *msi_dev_attr;
-	struct attribute_group *msi_irq_group;
-	struct msi_desc *entry;
-	int ret =3D -ENOMEM;
-	int num_msi =3D 0;
-	int count =3D 0;
-	int i;
+struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter fil=
ter)
+{
+	struct msi_device_data *md =3D dev->msi.data;
=20
-	/* Determine how many msi entries we have */
-	for_each_msi_entry(entry, dev)
-		num_msi +=3D entry->nvec_used;
-	if (!num_msi)
+	if (WARN_ON_ONCE(!md))
 		return NULL;
=20
-	/* Dynamically create the MSI attributes for the device */
-	msi_attrs =3D kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
-	if (!msi_attrs)
-		return ERR_PTR(-ENOMEM);
-
-	for_each_msi_entry(entry, dev) {
-		for (i =3D 0; i < entry->nvec_used; i++) {
-			msi_dev_attr =3D kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-			if (!msi_dev_attr)
-				goto error_attrs;
-			msi_attrs[count] =3D &msi_dev_attr->attr;
-
-			sysfs_attr_init(&msi_dev_attr->attr);
-			msi_dev_attr->attr.name =3D kasprintf(GFP_KERNEL, "%d",
-							    entry->irq + i);
-			if (!msi_dev_attr->attr.name)
-				goto error_attrs;
-			msi_dev_attr->attr.mode =3D 0444;
-			msi_dev_attr->show =3D msi_mode_show;
-			++count;
+	lockdep_assert_held(&md->mutex);
+
+	md->__iter_idx =3D 0;
+	return msi_find_desc(md, filter);
+}
+EXPORT_SYMBOL_GPL(msi_first_desc);
+
+/**
+ * msi_next_desc - Get the next MSI descriptor of a device
+ * @dev:	Device to operate on
+ *
+ * The first invocation of msi_next_desc() has to be preceeded by a
+ * successful invocation of __msi_first_desc(). Consecutive invocations are
+ * only valid if the previous one was successful. All these operations have
+ * to be done within the same MSI mutex held region.
+ *
+ * Return: Pointer to the next MSI descriptor matching the search
+ *	   criteria, NULL if none found.
+ */
+struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filt=
er)
+{
+	struct msi_device_data *md =3D dev->msi.data;
+
+	if (WARN_ON_ONCE(!md))
+		return NULL;
+
+	lockdep_assert_held(&md->mutex);
+
+	if (md->__iter_idx >=3D (unsigned long)MSI_MAX_INDEX)
+		return NULL;
+
+	md->__iter_idx++;
+	return msi_find_desc(md, filter);
+}
+EXPORT_SYMBOL_GPL(msi_next_desc);
+
+/**
+ * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * @dev:	Device to operate on
+ * @index:	MSI interrupt index to look for (0-based)
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+unsigned int msi_get_virq(struct device *dev, unsigned int index)
+{
+	struct msi_desc *desc;
+	unsigned int ret =3D 0;
+	bool pcimsi;
+
+	if (!dev->msi.data)
+		return 0;
+
+	pcimsi =3D dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
+
+	msi_lock_descs(dev);
+	desc =3D xa_load(&dev->msi.data->__store, pcimsi ? 0 : index);
+	if (desc && desc->irq) {
+		/*
+		 * PCI-MSI has only one descriptor for multiple interrupts.
+		 * PCI-MSIX and platform MSI use a descriptor per
+		 * interrupt.
+		 */
+		if (pcimsi) {
+			if (index < desc->nvec_used)
+				ret =3D desc->irq + index;
+		} else {
+			ret =3D desc->irq;
 		}
 	}
+	msi_unlock_descs(dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(msi_get_virq);
=20
-	msi_irq_group =3D kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
-	if (!msi_irq_group)
-		goto error_attrs;
-	msi_irq_group->name =3D "msi_irqs";
-	msi_irq_group->attrs =3D msi_attrs;
+#ifdef CONFIG_SYSFS
+static struct attribute *msi_dev_attrs[] =3D {
+	NULL
+};
=20
-	msi_irq_groups =3D kcalloc(2, sizeof(void *), GFP_KERNEL);
-	if (!msi_irq_groups)
-		goto error_irq_group;
-	msi_irq_groups[0] =3D msi_irq_group;
+static const struct attribute_group msi_irqs_group =3D {
+	.name	=3D "msi_irqs",
+	.attrs	=3D msi_dev_attrs,
+};
=20
-	ret =3D sysfs_create_groups(&dev->kobj, msi_irq_groups);
-	if (ret)
-		goto error_irq_groups;
-
-	return msi_irq_groups;
-
-error_irq_groups:
-	kfree(msi_irq_groups);
-error_irq_group:
-	kfree(msi_irq_group);
-error_attrs:
-	count =3D 0;
-	msi_attr =3D msi_attrs[count];
-	while (msi_attr) {
-		msi_dev_attr =3D container_of(msi_attr, struct device_attribute, attr);
-		kfree(msi_attr->name);
-		kfree(msi_dev_attr);
-		++count;
-		msi_attr =3D msi_attrs[count];
+static inline int msi_sysfs_create_group(struct device *dev)
+{
+	return devm_device_add_group(dev, &msi_irqs_group);
+}
+
+static ssize_t msi_mode_show(struct device *dev, struct device_attribute *at=
tr,
+			     char *buf)
+{
+	/* MSI vs. MSIX is per device not per interrupt */
+	bool is_msix =3D dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
+
+	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
+}
+
+static void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc)
+{
+	struct device_attribute *attrs =3D desc->sysfs_attrs;
+	int i;
+
+	if (!attrs)
+		return;
+
+	desc->sysfs_attrs =3D NULL;
+	for (i =3D 0; i < desc->nvec_used; i++) {
+		if (attrs[i].show)
+			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr, msi_irqs_group.n=
ame);
+		kfree(attrs[i].attr.name);
 	}
-	kfree(msi_attrs);
-	return ERR_PTR(ret);
+	kfree(attrs);
 }
=20
+static int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *desc)
+{
+	struct device_attribute *attrs;
+	int ret, i;
+
+	attrs =3D kcalloc(desc->nvec_used, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	desc->sysfs_attrs =3D attrs;
+	for (i =3D 0; i < desc->nvec_used; i++) {
+		sysfs_attr_init(&attrs[i].attr);
+		attrs[i].attr.name =3D kasprintf(GFP_KERNEL, "%d", desc->irq + i);
+		if (!attrs[i].attr.name) {
+			ret =3D -ENOMEM;
+			goto fail;
+		}
+
+		attrs[i].attr.mode =3D 0444;
+		attrs[i].show =3D msi_mode_show;
+
+		ret =3D sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr, msi_irqs_group=
.name);
+		if (ret) {
+			attrs[i].show =3D NULL;
+			goto fail;
+		}
+	}
+	return 0;
+
+fail:
+	msi_sysfs_remove_desc(dev, desc);
+	return ret;
+}
+
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 /**
- * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
- * @dev:		The device(PCI, platform etc) who will remove sysfs entries
- * @msi_irq_groups:	attribute_group for device msi_irqs entries
+ * msi_device_populate_sysfs - Populate msi_irqs sysfs entries for a device
+ * @dev:	The device (PCI, platform etc) which will get sysfs entries
  */
-void msi_destroy_sysfs(struct device *dev, const struct attribute_group **ms=
i_irq_groups)
-{
-	struct device_attribute *dev_attr;
-	struct attribute **msi_attrs;
-	int count =3D 0;
-
-	if (msi_irq_groups) {
-		sysfs_remove_groups(&dev->kobj, msi_irq_groups);
-		msi_attrs =3D msi_irq_groups[0]->attrs;
-		while (msi_attrs[count]) {
-			dev_attr =3D container_of(msi_attrs[count],
-					struct device_attribute, attr);
-			kfree(dev_attr->attr.name);
-			kfree(dev_attr);
-			++count;
-		}
-		kfree(msi_attrs);
-		kfree(msi_irq_groups[0]);
-		kfree(msi_irq_groups);
+int msi_device_populate_sysfs(struct device *dev)
+{
+	struct msi_desc *desc;
+	int ret;
+
+	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+		if (desc->sysfs_attrs)
+			continue;
+		ret =3D msi_sysfs_populate_desc(dev, desc);
+		if (ret)
+			return ret;
 	}
+	return 0;
 }
=20
+/**
+ * msi_device_destroy_sysfs - Destroy msi_irqs sysfs entries for a device
+ * @dev:		The device (PCI, platform etc) for which to remove
+ *			sysfs entries
+ */
+void msi_device_destroy_sysfs(struct device *dev)
+{
+	struct msi_desc *desc;
+
+	msi_for_each_desc(desc, dev, MSI_DESC_ALL)
+		msi_sysfs_remove_desc(dev, desc);
+}
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACK */
+#else /* CONFIG_SYSFS */
+static inline int msi_sysfs_create_group(struct device *dev) { return 0; }
+static inline int msi_sysfs_populate_desc(struct device *dev, struct msi_des=
c *desc) { return 0; }
+static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc=
 *desc) { }
+#endif /* !CONFIG_SYSFS */
+
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
@@ -456,43 +710,38 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, =
struct device *dev,
 }
=20
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq, int nvec, msi_alloc_info_t *arg)
+			     int virq_base, int nvec, msi_alloc_info_t *arg)
 {
 	struct msi_domain_info *info =3D domain->host_data;
 	struct msi_domain_ops *ops =3D info->ops;
 	struct msi_desc *desc;
-	int ret =3D 0;
+	int ret, virq;
=20
-	for_each_msi_entry(desc, dev) {
-		/* Don't even try the multi-MSI brain damage. */
-		if (WARN_ON(!desc->irq || desc->nvec_used !=3D 1)) {
-			ret =3D -EINVAL;
-			break;
-		}
+	msi_lock_descs(dev);
+	ret =3D msi_add_simple_msi_descs(dev, virq_base, nvec);
+	if (ret)
+		goto unlock;
=20
-		if (!(desc->irq >=3D virq && desc->irq < (virq + nvec)))
-			continue;
+	for (virq =3D virq_base; virq < virq_base + nvec; virq++) {
+		desc =3D xa_load(&dev->msi.data->__store, virq);
+		desc->irq =3D virq;
=20
 		ops->set_desc(arg, desc);
-		/* Assumes the domain mutex is held! */
-		ret =3D irq_domain_alloc_irqs_hierarchy(domain, desc->irq, 1,
-						      arg);
+		ret =3D irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
 		if (ret)
-			break;
+			goto fail;
=20
-		irq_set_msi_desc_off(desc->irq, 0, desc);
-	}
-
-	if (ret) {
-		/* Mop up the damage */
-		for_each_msi_entry(desc, dev) {
-			if (!(desc->irq >=3D virq && desc->irq < (virq + nvec)))
-				continue;
-
-			irq_domain_free_irqs_common(domain, desc->irq, 1);
-		}
+		irq_set_msi_desc(virq, desc);
 	}
+	msi_unlock_descs(dev);
+	return 0;
=20
+fail:
+	for (--virq; virq >=3D virq_base; virq--)
+		irq_domain_free_irqs_common(domain, virq, 1);
+	msi_free_msi_descs_range(dev, MSI_DESC_ALL, virq_base, virq_base + nvec - 1=
);
+unlock:
+	msi_unlock_descs(dev);
 	return ret;
 }
=20
@@ -531,8 +780,59 @@ static bool msi_check_reservation_mode(struct irq_domain=
 *domain,
 	 * Checking the first MSI descriptor is sufficient. MSIX supports
 	 * masking and MSI does so when the can_mask attribute is set.
 	 */
-	desc =3D first_msi_entry(dev);
-	return desc->msi_attrib.is_msix || desc->msi_attrib.can_mask;
+	desc =3D msi_first_desc(dev, MSI_DESC_ALL);
+	return desc->pci.msi_attrib.is_msix || desc->pci.msi_attrib.can_mask;
+}
+
+static int msi_handle_pci_fail(struct irq_domain *domain, struct msi_desc *d=
esc,
+			       int allocated)
+{
+	switch(domain->bus_token) {
+	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_VMD_MSI:
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			break;
+		fallthrough;
+	default:
+		return -ENOSPC;
+	}
+
+	/* Let a failed PCI multi MSI allocation retry */
+	if (desc->nvec_used > 1)
+		return 1;
+
+	/* If there was a successful allocation let the caller know */
+	return allocated ? allocated : -ENOSPC;
+}
+
+#define VIRQ_CAN_RESERVE	0x01
+#define VIRQ_ACTIVATE		0x02
+#define VIRQ_NOMASK_QUIRK	0x04
+
+static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int v=
flags)
+{
+	struct irq_data *irqd =3D irq_domain_get_irq_data(domain, virq);
+	int ret;
+
+	if (!(vflags & VIRQ_CAN_RESERVE)) {
+		irqd_clr_can_reserve(irqd);
+		if (vflags & VIRQ_NOMASK_QUIRK)
+			irqd_set_msi_nomask_quirk(irqd);
+	}
+
+	if (!(vflags & VIRQ_ACTIVATE))
+		return 0;
+
+	ret =3D irq_domain_activate_irq(irqd, vflags & VIRQ_CAN_RESERVE);
+	if (ret)
+		return ret;
+	/*
+	 * If the interrupt uses reservation mode, clear the activated bit
+	 * so request_irq() will assign the final vector.
+	 */
+	if (vflags & VIRQ_CAN_RESERVE)
+		irqd_clr_activated(irqd);
+	return 0;
 }
=20
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
@@ -540,83 +840,103 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain,=
 struct device *dev,
 {
 	struct msi_domain_info *info =3D domain->host_data;
 	struct msi_domain_ops *ops =3D info->ops;
-	struct irq_data *irq_data;
-	struct msi_desc *desc;
 	msi_alloc_info_t arg =3D { };
+	unsigned int vflags =3D 0;
+	struct msi_desc *desc;
+	int allocated =3D 0;
 	int i, ret, virq;
-	bool can_reserve;
=20
 	ret =3D msi_domain_prepare_irqs(domain, dev, nvec, &arg);
 	if (ret)
 		return ret;
=20
-	for_each_msi_entry(desc, dev) {
+	/*
+	 * This flag is set by the PCI layer as we need to activate
+	 * the MSI entries before the PCI layer enables MSI in the
+	 * card. Otherwise the card latches a random msi message.
+	 */
+	if (info->flags & MSI_FLAG_ACTIVATE_EARLY)
+		vflags |=3D VIRQ_ACTIVATE;
+
+	/*
+	 * Interrupt can use a reserved vector and will not occupy
+	 * a real device vector until the interrupt is requested.
+	 */
+	if (msi_check_reservation_mode(domain, info, dev)) {
+		vflags |=3D VIRQ_CAN_RESERVE;
+		/*
+		 * MSI affinity setting requires a special quirk (X86) when
+		 * reservation mode is active.
+		 */
+		if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
+			vflags |=3D VIRQ_NOMASK_QUIRK;
+	}
+
+	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
 		ops->set_desc(&arg, desc);
=20
 		virq =3D __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
 					       desc->affinity);
-		if (virq < 0) {
-			ret =3D -ENOSPC;
-			if (ops->handle_error)
-				ret =3D ops->handle_error(domain, desc, ret);
-			if (ops->msi_finish)
-				ops->msi_finish(&arg, ret);
-			return ret;
-		}
+		if (virq < 0)
+			return msi_handle_pci_fail(domain, desc, allocated);
=20
 		for (i =3D 0; i < desc->nvec_used; i++) {
 			irq_set_msi_desc_off(virq, i, desc);
 			irq_debugfs_copy_devname(virq + i, dev);
+			ret =3D msi_init_virq(domain, virq + i, vflags);
+			if (ret)
+				return ret;
+		}
+		if (info->flags & MSI_FLAG_DEV_SYSFS) {
+			ret =3D msi_sysfs_populate_desc(dev, desc);
+			if (ret)
+				return ret;
 		}
+		allocated++;
 	}
+	return 0;
+}
=20
-	if (ops->msi_finish)
-		ops->msi_finish(&arg, 0);
+static int msi_domain_add_simple_msi_descs(struct msi_domain_info *info,
+					   struct device *dev,
+					   unsigned int num_descs)
+{
+	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
+		return 0;
=20
-	can_reserve =3D msi_check_reservation_mode(domain, info, dev);
+	return msi_add_simple_msi_descs(dev, 0, num_descs);
+}
=20
-	/*
-	 * This flag is set by the PCI layer as we need to activate
-	 * the MSI entries before the PCI layer enables MSI in the
-	 * card. Otherwise the card latches a random msi message.
-	 */
-	if (!(info->flags & MSI_FLAG_ACTIVATE_EARLY))
-		goto skip_activate;
-
-	for_each_msi_vector(desc, i, dev) {
-		if (desc->irq =3D=3D i) {
-			virq =3D desc->irq;
-			dev_dbg(dev, "irq [%d-%d] for MSI\n",
-				virq, virq + desc->nvec_used - 1);
-		}
+/**
+ * msi_domain_alloc_irqs_descs_locked - Allocate interrupts from a MSI inter=
rupt domain
+ * @domain:	The domain to allocate from
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @nvec:	The number of interrupts to allocate
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation/free.
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct dev=
ice *dev,
+				       int nvec)
+{
+	struct msi_domain_info *info =3D domain->host_data;
+	struct msi_domain_ops *ops =3D info->ops;
+	int ret;
=20
-		irq_data =3D irq_domain_get_irq_data(domain, i);
-		if (!can_reserve) {
-			irqd_clr_can_reserve(irq_data);
-			if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
-				irqd_set_msi_nomask_quirk(irq_data);
-		}
-		ret =3D irq_domain_activate_irq(irq_data, can_reserve);
-		if (ret)
-			goto cleanup;
-	}
+	lockdep_assert_held(&dev->msi.data->mutex);
=20
-skip_activate:
-	/*
-	 * If these interrupts use reservation mode, clear the activated bit
-	 * so request_irq() will assign the final vector.
-	 */
-	if (can_reserve) {
-		for_each_msi_vector(desc, i, dev) {
-			irq_data =3D irq_domain_get_irq_data(domain, i);
-			irqd_clr_activated(irq_data);
-		}
-	}
-	return 0;
+	ret =3D msi_domain_add_simple_msi_descs(info, dev, nvec);
+	if (ret)
+		return ret;
=20
-cleanup:
-	msi_domain_free_irqs(domain, dev);
+	ret =3D ops->domain_alloc_irqs(domain, dev, nvec);
+	if (ret)
+		msi_domain_free_irqs_descs_locked(domain, dev);
 	return ret;
 }
=20
@@ -629,52 +949,78 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, =
struct device *dev,
  *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec)
+int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int=
 nvec)
 {
-	struct msi_domain_info *info =3D domain->host_data;
-	struct msi_domain_ops *ops =3D info->ops;
+	int ret;
=20
-	return ops->domain_alloc_irqs(domain, dev, nvec);
+	msi_lock_descs(dev);
+	ret =3D msi_domain_alloc_irqs_descs_locked(domain, dev, nvec);
+	msi_unlock_descs(dev);
+	return ret;
 }
=20
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
-	struct irq_data *irq_data;
+	struct msi_domain_info *info =3D domain->host_data;
+	struct irq_data *irqd;
 	struct msi_desc *desc;
 	int i;
=20
-	for_each_msi_vector(desc, i, dev) {
-		irq_data =3D irq_domain_get_irq_data(domain, i);
-		if (irqd_is_activated(irq_data))
-			irq_domain_deactivate_irq(irq_data);
-	}
-
-	for_each_msi_entry(desc, dev) {
-		/*
-		 * We might have failed to allocate an MSI early
-		 * enough that there is no IRQ associated to this
-		 * entry. If that's the case, don't do anything.
-		 */
-		if (desc->irq) {
-			irq_domain_free_irqs(desc->irq, desc->nvec_used);
-			desc->irq =3D 0;
+	/* Only handle MSI entries which have an interrupt associated */
+	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+		/* Make sure all interrupts are deactivated */
+		for (i =3D 0; i < desc->nvec_used; i++) {
+			irqd =3D irq_domain_get_irq_data(domain, desc->irq + i);
+			if (irqd && irqd_is_activated(irqd))
+				irq_domain_deactivate_irq(irqd);
 		}
+
+		irq_domain_free_irqs(desc->irq, desc->nvec_used);
+		if (info->flags & MSI_FLAG_DEV_SYSFS)
+			msi_sysfs_remove_desc(dev, desc);
+		desc->irq =3D 0;
 	}
 }
=20
+static void msi_domain_free_msi_descs(struct msi_domain_info *info,
+				      struct device *dev)
+{
+	if (info->flags & MSI_FLAG_FREE_MSI_DESCS)
+		msi_free_msi_descs(dev);
+}
+
 /**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain assoc=
iated to @dev
+ * msi_domain_free_irqs_descs_locked - Free interrupts from a MSI interrupt =
@domain associated to @dev
  * @domain:	The domain to managing the interrupts
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are free
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation.
  */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct dev=
ice *dev)
 {
 	struct msi_domain_info *info =3D domain->host_data;
 	struct msi_domain_ops *ops =3D info->ops;
=20
-	return ops->domain_free_irqs(domain, dev);
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	ops->domain_free_irqs(domain, dev);
+	msi_domain_free_msi_descs(info, dev);
+}
+
+/**
+ * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain assoc=
iated to @dev
+ * @domain:	The domain to managing the interrupts
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are free
+ */
+void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_descs_locked(domain, dev);
+	msi_unlock_descs(dev);
 }
=20
 /**

