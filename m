Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B652D48D57B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiAMKNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:13:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34852 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiAMKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:13:21 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642068799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kPHP2PGj8qeBBx0StSTpQUEfdU6icgHk/WUz0l3hajk=;
        b=beehgXMsHL5OYgHEB+Zb4FDhhROPjS3TxNXIF5dvWz9lAdmGAZ+EgNnY74vEQAM3dQ8N3s
        e+uSMofbK6sQNALhEFu2rtn7Umi1rR3+LFiUqNmcsCj7m9uez2c9JqqqRaCgFEpDbvEntT
        NYElqOekIlzp/+uX0zvD+vvipqi6xupfTwW+z7Nx8nruXwIBE2LI+wh3M14DcTcH2NxcYf
        w9TGeqR2f0z3sjGUn1JpZi1DYlascE0MJsi1Qa6m6+0Uq0sZxB2suqywBJnbpptxM2ppou
        roOh97XsJSHS5XHalPYg8y3VEo9fp4zlA3eFouXJfxW8zxetaozG57uCNOSNnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642068799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kPHP2PGj8qeBBx0StSTpQUEfdU6icgHk/WUz0l3hajk=;
        b=junIozUrnBFnsfvAoBnl/l5AeO3KM23zxa83v6w6I16Wn5ml00rupGmSsdvz/4Ya/Pc+AV
        Hr7GFq3DmjWgqTAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v5.17-rc1
Message-ID: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Thu, 13 Jan 2022 11:13:19 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-01=
-13

up to:  67d50b5f9114: Merge tag 'irqchip-5.17' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/maz/arm-platforms into irq/core

Updates for the interrupt subsystem:

 Core:
=20
  - Provide a new interface for affinity hints to provide a separation
    between hint and actual affinity change which has become a hidden
    property of the current interface

  - Fix up the in tree usage of the affinity hint interfaces

 Drivers:

  - No new irqchip drivers!

  - Fix GICv3 redistributor table reservation with RT across kexec
   =20
  - Fix GICv4.1 redistributor view of the VPE table across kexec
   =20
  - Add support for extra interrupts on spear-shirq
   =20
  - Make obtaining some interrupts optional for the Renesas drivers
   =20
  - Various cleanups and bug fixes

Thanks,

	tglx

------------------>
Herve Codina (1):
      irqchip/spear-shirq: Add support for IRQ 0..6

Kees Cook (1):
      irqchip/ingenic-tcu: Use correctly sized arguments for bit field

Lad Prabhakar (2):
      irqchip/renesas-irqc: Use platform_get_irq_optional() to get the interr=
upt
      irqchip/renesas-intc-irqpin: Use platform_get_irq_optional() to get the=
 interrupt

Marc Zyngier (1):
      irqchip/gic-v4: Disable redistributors' view of the VPE table at boot t=
ime

Nitesh Narayan Lal (13):
      iavf: Use irq_update_affinity_hint()
      i40e: Use irq_update_affinity_hint()
      scsi: megaraid_sas: Use irq_set_affinity_and_hint()
      scsi: mpt3sas: Use irq_set_affinity_and_hint()
      RDMA/irdma: Use irq_update_affinity_hint()
      enic: Use irq_update_affinity_hint()
      be2net: Use irq_update_affinity_hint()
      ixgbe: Use irq_update_affinity_hint()
      mailbox: Use irq_update_affinity_hint()
      scsi: lpfc: Use irq_set_affinity()
      hinic: Use irq_set_affinity_and_hint()
      net/mlx5: Use irq_set_affinity_and_hint()
      net/mlx4: Use irq_update_affinity_hint()

Peng Fan (1):
      irqchip/imx-gpcv2: Mark imx_gpcv2_instance with __ro_after_init

Rikard Falkeborn (1):
      genirq/generic_chip: Constify irq_generic_chip_ops

Thomas Gleixner (1):
      genirq: Provide new interfaces for affinity hints

Valentin Schneider (3):
      irqchip/gic-v3-its: Give the percpu rdist struct its own flags field
      irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve
      irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime

Xiang wangx (1):
      irqchip/gic-v2m: Add const to of_device_id


 drivers/infiniband/hw/irdma/hw.c                  |  4 +-
 drivers/irqchip/irq-gic-v2m.c                     |  2 +-
 drivers/irqchip/irq-gic-v3-its.c                  | 82 +++++++++++++++++++++=
--
 drivers/irqchip/irq-gic-v3.c                      | 17 +++++
 drivers/irqchip/irq-imx-gpcv2.c                   |  2 +-
 drivers/irqchip/irq-ingenic-tcu.c                 |  4 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c         |  9 +--
 drivers/irqchip/irq-renesas-irqc.c                |  9 +--
 drivers/irqchip/spear-shirq.c                     |  2 +
 drivers/mailbox/bcm-flexrm-mailbox.c              |  4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c       |  8 +--
 drivers/net/ethernet/emulex/benet/be_main.c       |  4 +-
 drivers/net/ethernet/huawei/hinic/hinic_rx.c      |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       |  8 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c       |  8 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 10 +--
 drivers/net/ethernet/mellanox/mlx4/eq.c           |  8 +--
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c |  8 +--
 drivers/scsi/lpfc/lpfc_init.c                     |  4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c         | 27 ++++----
 drivers/scsi/mpt3sas/mpt3sas_base.c               | 21 +++---
 include/linux/interrupt.h                         | 53 ++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h                |  4 +-
 include/linux/irqdomain.h                         |  2 +-
 kernel/irq/generic-chip.c                         |  2 +-
 kernel/irq/manage.c                               |  8 +--
 26 files changed, 228 insertions(+), 86 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/h=
w.c
index b4c657f5f2f9..4b1b16e7a75b 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -550,7 +550,7 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
 	struct irdma_sc_dev *dev =3D &rf->sc_dev;
=20
 	dev->irq_ops->irdma_dis_irq(dev, msix_vec->idx);
-	irq_set_affinity_hint(msix_vec->irq, NULL);
+	irq_update_affinity_hint(msix_vec->irq, NULL);
 	free_irq(msix_vec->irq, dev_id);
 }
=20
@@ -1100,7 +1100,7 @@ irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct ird=
ma_ceq *iwceq,
 	}
 	cpumask_clear(&msix_vec->mask);
 	cpumask_set_cpu(msix_vec->cpu_affinity, &msix_vec->mask);
-	irq_set_affinity_hint(msix_vec->irq, &msix_vec->mask);
+	irq_update_affinity_hint(msix_vec->irq, &msix_vec->mask);
 	if (status) {
 		ibdev_dbg(&rf->iwdev->ibdev, "ERR: ceq irq config fail\n");
 		return IRDMA_ERR_CFG;
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 9349fc68b81a..f2d252dff5f3 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -405,7 +405,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *f=
wnode,
 	return ret;
 }
=20
-static struct of_device_id gicv2m_device_id[] =3D {
+static const struct of_device_id gicv2m_device_id[] =3D {
 	{	.compatible	=3D "arm,gic-v2m-frame",	},
 	{},
 };
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 0cb584d9815b..d25b7a864bbb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -46,6 +46,10 @@
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
=20
+#define RD_LOCAL_LPI_ENABLED                    BIT(0)
+#define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
+#define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
+
 static u32 lpi_id_bits;
=20
 /*
@@ -3044,7 +3048,7 @@ static void its_cpu_init_lpis(void)
 	phys_addr_t paddr;
 	u64 val, tmp;
=20
-	if (gic_data_rdist()->lpi_enabled)
+	if (gic_data_rdist()->flags & RD_LOCAL_LPI_ENABLED)
 		return;
=20
 	val =3D readl_relaxed(rbase + GICR_CTLR);
@@ -3063,15 +3067,13 @@ static void its_cpu_init_lpis(void)
 		paddr &=3D GENMASK_ULL(51, 16);
=20
 		WARN_ON(!gic_check_reserved_range(paddr, LPI_PENDBASE_SZ));
-		its_free_pending_table(gic_data_rdist()->pend_page);
-		gic_data_rdist()->pend_page =3D NULL;
+		gic_data_rdist()->flags |=3D RD_LOCAL_PENDTABLE_PREALLOCATED;
=20
 		goto out;
 	}
=20
 	pend_page =3D gic_data_rdist()->pend_page;
 	paddr =3D page_to_phys(pend_page);
-	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
=20
 	/* set PROPBASE */
 	val =3D (gic_rdists->prop_table_pa |
@@ -3158,10 +3160,11 @@ static void its_cpu_init_lpis(void)
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
-	gic_data_rdist()->lpi_enabled =3D true;
+	gic_data_rdist()->flags |=3D RD_LOCAL_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
-		gic_data_rdist()->pend_page ? "allocated" : "reserved",
+		gic_data_rdist()->flags & RD_LOCAL_PENDTABLE_PREALLOCATED ?
+		"reserved" : "allocated",
 		&paddr);
 }
=20
@@ -5138,7 +5141,7 @@ static int redist_disable_lpis(void)
 	 *
 	 * If running with preallocated tables, there is nothing to do.
 	 */
-	if (gic_data_rdist()->lpi_enabled ||
+	if ((gic_data_rdist()->flags & RD_LOCAL_LPI_ENABLED) ||
 	    (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED))
 		return 0;
=20
@@ -5200,6 +5203,51 @@ int its_cpu_init(void)
 	return 0;
 }
=20
+static void rdist_memreserve_cpuhp_cleanup_workfn(struct work_struct *work)
+{
+	cpuhp_remove_state_nocalls(gic_rdists->cpuhp_memreserve_state);
+	gic_rdists->cpuhp_memreserve_state =3D CPUHP_INVALID;
+}
+
+static DECLARE_WORK(rdist_memreserve_cpuhp_cleanup_work,
+		    rdist_memreserve_cpuhp_cleanup_workfn);
+
+static int its_cpu_memreserve_lpi(unsigned int cpu)
+{
+	struct page *pend_page;
+	int ret =3D 0;
+
+	/* This gets to run exactly once per CPU */
+	if (gic_data_rdist()->flags & RD_LOCAL_MEMRESERVE_DONE)
+		return 0;
+
+	pend_page =3D gic_data_rdist()->pend_page;
+	if (WARN_ON(!pend_page)) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+	/*
+	 * If the pending table was pre-programmed, free the memory we
+	 * preemptively allocated. Otherwise, reserve that memory for
+	 * later kexecs.
+	 */
+	if (gic_data_rdist()->flags & RD_LOCAL_PENDTABLE_PREALLOCATED) {
+		its_free_pending_table(pend_page);
+		gic_data_rdist()->pend_page =3D NULL;
+	} else {
+		phys_addr_t paddr =3D page_to_phys(pend_page);
+		WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
+	}
+
+out:
+	/* Last CPU being brought up gets to issue the cleanup */
+	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
+		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
+
+	gic_data_rdist()->flags |=3D RD_LOCAL_MEMRESERVE_DONE;
+	return ret;
+}
+
 static const struct of_device_id its_device_id[] =3D {
 	{	.compatible	=3D "arm,gic-v3-its",	},
 	{},
@@ -5383,6 +5431,26 @@ static void __init its_acpi_probe(void)
 static void __init its_acpi_probe(void) { }
 #endif
=20
+int __init its_lpi_memreserve_init(void)
+{
+	int state;
+
+	if (!efi_enabled(EFI_CONFIG_TABLES))
+		return 0;
+
+	gic_rdists->cpuhp_memreserve_state =3D CPUHP_INVALID;
+	state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				  "irqchip/arm/gicv3/memreserve:online",
+				  its_cpu_memreserve_lpi,
+				  NULL);
+	if (state < 0)
+		return state;
+
+	gic_rdists->cpuhp_memreserve_state =3D state;
+
+	return 0;
+}
+
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		    struct irq_domain *parent_domain)
 {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index daec3309b014..5e935d97207d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -920,6 +920,22 @@ static int __gic_update_rdist_properties(struct redist_r=
egion *region,
 {
 	u64 typer =3D gic_read_typer(ptr + GICR_TYPER);
=20
+	/* Boot-time cleanip */
+	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
+		u64 val;
+
+		/* Deactivate any present vPE */
+		val =3D gicr_read_vpendbaser(ptr + SZ_128K + GICR_VPENDBASER);
+		if (val & GICR_VPENDBASER_Valid)
+			gicr_write_vpendbaser(GICR_VPENDBASER_PendingLast,
+					      ptr + SZ_128K + GICR_VPENDBASER);
+
+		/* Mark the VPE table as invalid */
+		val =3D gicr_read_vpropbaser(ptr + SZ_128K + GICR_VPROPBASER);
+		val &=3D ~GICR_VPROPBASER_4_1_VALID;
+		gicr_write_vpropbaser(val, ptr + SZ_128K + GICR_VPROPBASER);
+	}
+
 	gic_data.rdists.has_vlpis &=3D !!(typer & GICR_TYPER_VLPIS);
=20
 	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-=
/ */
@@ -1802,6 +1818,7 @@ static int __init gic_init_bases(void __iomem *dist_bas=
e,
 	if (gic_dist_supports_lpis()) {
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 		its_cpu_init();
+		its_lpi_memreserve_init();
 	} else {
 		if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 			gicv2m_init(handle, gic_data.domain);
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 5b5a365dbd5e..b9c22f764b4d 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -26,7 +26,7 @@ struct gpcv2_irqchip_data {
 	u32			cpu2wakeup;
 };
=20
-static struct gpcv2_irqchip_data *imx_gpcv2_instance;
+static struct gpcv2_irqchip_data *imx_gpcv2_instance __ro_after_init;
=20
 static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 {
diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-=
tcu.c
index 34a7d261b710..3363f83bd7e9 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -28,6 +28,7 @@ static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
 	struct irq_chip_generic *gc =3D irq_get_domain_generic_chip(domain, 0);
 	struct regmap *map =3D gc->private;
 	uint32_t irq_reg, irq_mask;
+	unsigned long bits;
 	unsigned int i;
=20
 	regmap_read(map, TCU_REG_TFR, &irq_reg);
@@ -36,8 +37,9 @@ static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
 	chained_irq_enter(irq_chip, desc);
=20
 	irq_reg &=3D ~irq_mask;
+	bits =3D irq_reg;
=20
-	for_each_set_bit(i, (unsigned long *)&irq_reg, 32)
+	for_each_set_bit(i, &bits, 32)
 		generic_handle_domain_irq(domain, i);
=20
 	chained_irq_exit(irq_chip, desc);
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-=
renesas-intc-irqpin.c
index cb7f60b3b4a9..37f9a4499fdb 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -375,7 +375,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	struct intc_irqpin_priv *p;
 	struct intc_irqpin_iomem *i;
 	struct resource *io[INTC_IRQPIN_REG_NR];
-	struct resource *irq;
 	struct irq_chip *irq_chip;
 	void (*enable_fn)(struct irq_data *d);
 	void (*disable_fn)(struct irq_data *d);
@@ -418,12 +417,14 @@ static int intc_irqpin_probe(struct platform_device *pd=
ev)
=20
 	/* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
 	for (k =3D 0; k < INTC_IRQPIN_MAX; k++) {
-		irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, k);
-		if (!irq)
+		ret =3D platform_get_irq_optional(pdev, k);
+		if (ret =3D=3D -ENXIO)
 			break;
+		if (ret < 0)
+			goto err0;
=20
 		p->irq[k].p =3D p;
-		p->irq[k].requested_irq =3D irq->start;
+		p->irq[k].requested_irq =3D ret;
 	}
=20
 	nirqs =3D k;
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas=
-irqc.c
index 07a6d8b42b63..909325f88239 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -126,7 +126,6 @@ static int irqc_probe(struct platform_device *pdev)
 	struct device *dev =3D &pdev->dev;
 	const char *name =3D dev_name(dev);
 	struct irqc_priv *p;
-	struct resource *irq;
 	int ret;
 	int k;
=20
@@ -142,13 +141,15 @@ static int irqc_probe(struct platform_device *pdev)
=20
 	/* allow any number of IRQs between 1 and IRQC_IRQ_MAX */
 	for (k =3D 0; k < IRQC_IRQ_MAX; k++) {
-		irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, k);
-		if (!irq)
+		ret =3D platform_get_irq_optional(pdev, k);
+		if (ret =3D=3D -ENXIO)
 			break;
+		if (ret < 0)
+			goto err_runtime_pm_disable;
=20
 		p->irq[k].p =3D p;
 		p->irq[k].hw_irq =3D k;
-		p->irq[k].requested_irq =3D irq->start;
+		p->irq[k].requested_irq =3D ret;
 	}
=20
 	p->number_of_irqs =3D k;
diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
index 1518ba31a80c..7c17a6f643ef 100644
--- a/drivers/irqchip/spear-shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -149,6 +149,8 @@ static struct spear_shirq spear320_shirq_ras3 =3D {
 	.offset		=3D 0,
 	.nr_irqs	=3D 7,
 	.mask		=3D ((0x1 << 7) - 1) << 0,
+	.irq_chip	=3D &dummy_irq_chip,
+	.status_reg	=3D SPEAR320_INT_STS_MASK_REG,
 };
=20
 static struct spear_shirq spear320_shirq_ras1 =3D {
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexr=
m-mailbox.c
index 78073ad1f2f1..16982c13d323 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1298,7 +1298,7 @@ static int flexrm_startup(struct mbox_chan *chan)
 	val =3D (num_online_cpus() < val) ? val / num_online_cpus() : 1;
 	cpumask_set_cpu((ring->num / val) % num_online_cpus(),
 			&ring->irq_aff_hint);
-	ret =3D irq_set_affinity_hint(ring->irq, &ring->irq_aff_hint);
+	ret =3D irq_update_affinity_hint(ring->irq, &ring->irq_aff_hint);
 	if (ret) {
 		dev_err(ring->mbox->dev,
 			"failed to set IRQ affinity hint for ring%d\n",
@@ -1425,7 +1425,7 @@ static void flexrm_shutdown(struct mbox_chan *chan)
=20
 	/* Release IRQ */
 	if (ring->irq_requested) {
-		irq_set_affinity_hint(ring->irq, NULL);
+		irq_update_affinity_hint(ring->irq, NULL);
 		free_irq(ring->irq, ring);
 		ring->irq_requested =3D false;
 	}
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethern=
et/cisco/enic/enic_main.c
index aacf141986d5..2faba079b4fb 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -150,10 +150,10 @@ static void enic_set_affinity_hint(struct enic *enic)
 		    !cpumask_available(enic->msix[i].affinity_mask) ||
 		    cpumask_empty(enic->msix[i].affinity_mask))
 			continue;
-		err =3D irq_set_affinity_hint(enic->msix_entry[i].vector,
-					    enic->msix[i].affinity_mask);
+		err =3D irq_update_affinity_hint(enic->msix_entry[i].vector,
+					       enic->msix[i].affinity_mask);
 		if (err)
-			netdev_warn(enic->netdev, "irq_set_affinity_hint failed, err %d\n",
+			netdev_warn(enic->netdev, "irq_update_affinity_hint failed, err %d\n",
 				    err);
 	}
=20
@@ -173,7 +173,7 @@ static void enic_unset_affinity_hint(struct enic *enic)
 	int i;
=20
 	for (i =3D 0; i < enic->intr_count; i++)
-		irq_set_affinity_hint(enic->msix_entry[i].vector, NULL);
+		irq_update_affinity_hint(enic->msix_entry[i].vector, NULL);
 }
=20
 static int enic_udp_tunnel_set_port(struct net_device *netdev,
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethern=
et/emulex/benet/be_main.c
index d51f24c9e1b8..84b3ba9bdb18 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3491,7 +3491,7 @@ static int be_msix_register(struct be_adapter *adapter)
 		if (status)
 			goto err_msix;
=20
-		irq_set_affinity_hint(vec, eqo->affinity_mask);
+		irq_update_affinity_hint(vec, eqo->affinity_mask);
 	}
=20
 	return 0;
@@ -3552,7 +3552,7 @@ static void be_irq_unregister(struct be_adapter *adapte=
r)
 	/* MSIx */
 	for_all_evt_queues(adapter, eqo, i) {
 		vec =3D be_msix_vec_get(adapter, eqo);
-		irq_set_affinity_hint(vec, NULL);
+		irq_update_affinity_hint(vec, NULL);
 		free_irq(vec, eqo);
 	}
=20
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ether=
net/huawei/hinic/hinic_rx.c
index fed3b6bc0d76..b33ed4d92b71 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -548,7 +548,7 @@ static int rx_request_irq(struct hinic_rxq *rxq)
 		goto err_req_irq;
=20
 	cpumask_set_cpu(qp->q_id % num_online_cpus(), &rq->affinity_mask);
-	err =3D irq_set_affinity_hint(rq->irq, &rq->affinity_mask);
+	err =3D irq_set_affinity_and_hint(rq->irq, &rq->affinity_mask);
 	if (err)
 		goto err_irq_affinity;
=20
@@ -565,7 +565,7 @@ static void rx_free_irq(struct hinic_rxq *rxq)
 {
 	struct hinic_rq *rq =3D rxq->rq;
=20
-	irq_set_affinity_hint(rq->irq, NULL);
+	irq_update_affinity_hint(rq->irq, NULL);
 	free_irq(rq->irq, rxq);
 	rx_del_napi(rxq);
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethern=
et/intel/i40e/i40e_main.c
index 61afc220fc6c..2a3d8aef7f4e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3915,10 +3915,10 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi =
*vsi, char *basename)
 		 *
 		 * get_cpu_mask returns a static constant mask with
 		 * a permanent lifetime so it's ok to pass to
-		 * irq_set_affinity_hint without making a copy.
+		 * irq_update_affinity_hint without making a copy.
 		 */
 		cpu =3D cpumask_local_spread(q_vector->v_idx, -1);
-		irq_set_affinity_hint(irq_num, get_cpu_mask(cpu));
+		irq_update_affinity_hint(irq_num, get_cpu_mask(cpu));
 	}
=20
 	vsi->irqs_ready =3D true;
@@ -3929,7 +3929,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *v=
si, char *basename)
 		vector--;
 		irq_num =3D pf->msix_entries[base + vector].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		free_irq(irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;
@@ -4750,7 +4750,7 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
 			/* clear the affinity notifier in the IRQ descriptor */
 			irq_set_affinity_notifier(irq_num, NULL);
 			/* remove our suggested affinity mask for this IRQ */
-			irq_set_affinity_hint(irq_num, NULL);
+			irq_update_affinity_hint(irq_num, NULL);
 			synchronize_irq(irq_num);
 			free_irq(irq_num, vsi->q_vectors[i]);
=20
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethern=
et/intel/iavf/iavf_main.c
index e4439b095533..b1c161f9d706 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -492,10 +492,10 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter,=
 char *basename)
 		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
 		/* Spread the IRQ affinity hints across online CPUs. Note that
 		 * get_cpu_mask returns a mask with a permanent lifetime so
-		 * it's safe to use as a hint for irq_set_affinity_hint.
+		 * it's safe to use as a hint for irq_update_affinity_hint.
 		 */
 		cpu =3D cpumask_local_spread(q_vector->v_idx, -1);
-		irq_set_affinity_hint(irq_num, get_cpu_mask(cpu));
+		irq_update_affinity_hint(irq_num, get_cpu_mask(cpu));
 	}
=20
 	return 0;
@@ -505,7 +505,7 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, c=
har *basename)
 		vector--;
 		irq_num =3D adapter->msix_entries[vector + NONQ_VECS].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		free_irq(irq_num, &adapter->q_vectors[vector]);
 	}
 	return err;
@@ -557,7 +557,7 @@ static void iavf_free_traffic_irqs(struct iavf_adapter *a=
dapter)
 	for (vector =3D 0; vector < q_vectors; vector++) {
 		irq_num =3D adapter->msix_entries[vector + NONQ_VECS].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		free_irq(irq_num, &adapter->q_vectors[vector]);
 	}
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethe=
rnet/intel/ixgbe/ixgbe_main.c
index 45e2ec4d264d..7068ecb289f3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3247,8 +3247,8 @@ static int ixgbe_request_msix_irqs(struct ixgbe_adapter=
 *adapter)
 		/* If Flow Director is enabled, set interrupt affinity */
 		if (adapter->flags & IXGBE_FLAG_FDIR_HASH_CAPABLE) {
 			/* assign the mask for this irq */
-			irq_set_affinity_hint(entry->vector,
-					      &q_vector->affinity_mask);
+			irq_update_affinity_hint(entry->vector,
+						 &q_vector->affinity_mask);
 		}
 	}
=20
@@ -3264,8 +3264,8 @@ static int ixgbe_request_msix_irqs(struct ixgbe_adapter=
 *adapter)
 free_queue_irqs:
 	while (vector) {
 		vector--;
-		irq_set_affinity_hint(adapter->msix_entries[vector].vector,
-				      NULL);
+		irq_update_affinity_hint(adapter->msix_entries[vector].vector,
+					 NULL);
 		free_irq(adapter->msix_entries[vector].vector,
 			 adapter->q_vector[vector]);
 	}
@@ -3398,7 +3398,7 @@ static void ixgbe_free_irq(struct ixgbe_adapter *adapte=
r)
 			continue;
=20
 		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(entry->vector, NULL);
+		irq_update_affinity_hint(entry->vector, NULL);
=20
 		free_irq(entry->vector, q_vector);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/m=
ellanox/mlx4/eq.c
index 9e48509ed3b2..414e390e6b48 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -244,9 +244,9 @@ static void mlx4_set_eq_affinity_hint(struct mlx4_priv *p=
riv, int vec)
 	    cpumask_empty(eq->affinity_mask))
 		return;
=20
-	hint_err =3D irq_set_affinity_hint(eq->irq, eq->affinity_mask);
+	hint_err =3D irq_update_affinity_hint(eq->irq, eq->affinity_mask);
 	if (hint_err)
-		mlx4_warn(dev, "irq_set_affinity_hint failed, err %d\n", hint_err);
+		mlx4_warn(dev, "irq_update_affinity_hint failed, err %d\n", hint_err);
 }
 #endif
=20
@@ -1123,9 +1123,7 @@ static void mlx4_free_irqs(struct mlx4_dev *dev)
 	for (i =3D 0; i < dev->caps.num_comp_vectors + 1; ++i)
 		if (eq_table->eq[i].have_irq) {
 			free_cpumask_var(eq_table->eq[i].affinity_mask);
-#if defined(CONFIG_SMP)
-			irq_set_affinity_hint(eq_table->eq[i].irq, NULL);
-#endif
+			irq_update_affinity_hint(eq_table->eq[i].irq, NULL);
 			free_irq(eq_table->eq[i].irq, eq_table->eq + i);
 			eq_table->eq[i].have_irq =3D 0;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/=
ethernet/mellanox/mlx5/core/pci_irq.c
index bcee30f5de0a..fd7a671eda33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -143,11 +143,11 @@ static void irq_release(struct mlx5_irq *irq)
 	struct mlx5_irq_pool *pool =3D irq->pool;
=20
 	xa_erase(&pool->irqs, irq->index);
-	/* free_irq requires that affinity and rmap will be cleared
+	/* free_irq requires that affinity_hint and rmap will be cleared
 	 * before calling it. This is why there is asymmetry with set_rmap
 	 * which should be called after alloc_irq but before request_irq.
 	 */
-	irq_set_affinity_hint(irq->irqn, NULL);
+	irq_update_affinity_hint(irq->irqn, NULL);
 	free_cpumask_var(irq->mask);
 	free_irq(irq->irqn, &irq->nh);
 	kfree(irq);
@@ -316,7 +316,7 @@ static struct mlx5_irq *irq_pool_create_irq(struct mlx5_i=
rq_pool *pool,
 	if (IS_ERR(irq))
 		return irq;
 	cpumask_copy(irq->mask, affinity);
-	irq_set_affinity_hint(irq->irqn, irq->mask);
+	irq_set_affinity_and_hint(irq->irqn, irq->mask);
 	return irq;
 }
=20
@@ -399,7 +399,7 @@ irq_pool_request_vector(struct mlx5_irq_pool *pool, int v=
ecidx,
 	if (!irq_pool_is_sf_pool(pool) && !pool->xa_num_irqs.max &&
 	    cpumask_empty(irq->mask))
 		cpumask_set_cpu(cpumask_first(cpu_online_mask), irq->mask);
-	irq_set_affinity_hint(irq->irqn, irq->mask);
+	irq_set_affinity_and_hint(irq->irqn, irq->mask);
 unlock:
 	mutex_unlock(&pool->lock);
 	return irq;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index ba17a8f740a9..945755266c49 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12709,7 +12709,7 @@ lpfc_irq_set_aff(struct lpfc_hba_eq_hdl *eqhdl, unsig=
ned int cpu)
 	cpumask_clear(&eqhdl->aff_mask);
 	cpumask_set_cpu(cpu, &eqhdl->aff_mask);
 	irq_set_status_flags(eqhdl->irq, IRQ_NO_BALANCING);
-	irq_set_affinity_hint(eqhdl->irq, &eqhdl->aff_mask);
+	irq_set_affinity(eqhdl->irq, &eqhdl->aff_mask);
 }
=20
 /**
@@ -12998,7 +12998,6 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 	for (--index; index >=3D 0; index--) {
 		eqhdl =3D lpfc_get_eq_hdl(index);
 		lpfc_irq_clear_aff(eqhdl);
-		irq_set_affinity_hint(eqhdl->irq, NULL);
 		free_irq(eqhdl->irq, eqhdl);
 	}
=20
@@ -13159,7 +13158,6 @@ lpfc_sli4_disable_intr(struct lpfc_hba *phba)
 		for (index =3D 0; index < phba->cfg_irq_chann; index++) {
 			eqhdl =3D lpfc_get_eq_hdl(index);
 			lpfc_irq_clear_aff(eqhdl);
-			irq_set_affinity_hint(eqhdl->irq, NULL);
 			free_irq(eqhdl->irq, eqhdl);
 		}
 	} else {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megarai=
d/megaraid_sas_base.c
index aeb95f409826..82e1e24257bc 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5720,7 +5720,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instan=
ce, u8 is_probe)
 				"Failed to register IRQ for vector %d.\n", i);
 			for (j =3D 0; j < i; j++) {
 				if (j < instance->low_latency_index_start)
-					irq_set_affinity_hint(
+					irq_update_affinity_hint(
 						pci_irq_vector(pdev, j), NULL);
 				free_irq(pci_irq_vector(pdev, j),
 					 &instance->irq_context[j]);
@@ -5763,7 +5763,7 @@ megasas_destroy_irqs(struct megasas_instance *instance)=
 {
 	if (instance->msix_vectors)
 		for (i =3D 0; i < instance->msix_vectors; i++) {
 			if (i < instance->low_latency_index_start)
-				irq_set_affinity_hint(
+				irq_update_affinity_hint(
 				    pci_irq_vector(instance->pdev, i), NULL);
 			free_irq(pci_irq_vector(instance->pdev, i),
 				 &instance->irq_context[i]);
@@ -5894,22 +5894,25 @@ int megasas_get_device_list(struct megasas_instance *=
instance)
 }
=20
 /**
- * megasas_set_high_iops_queue_affinity_hint -	Set affinity hint for high IO=
PS queues
- * @instance:					Adapter soft state
- * return:					void
+ * megasas_set_high_iops_queue_affinity_and_hint -	Set affinity and hint
+ *							for high IOPS queues
+ * @instance:						Adapter soft state
+ * return:						void
  */
 static inline void
-megasas_set_high_iops_queue_affinity_hint(struct megasas_instance *instance)
+megasas_set_high_iops_queue_affinity_and_hint(struct megasas_instance *insta=
nce)
 {
 	int i;
-	int local_numa_node;
+	unsigned int irq;
+	const struct cpumask *mask;
=20
 	if (instance->perf_mode =3D=3D MR_BALANCED_PERF_MODE) {
-		local_numa_node =3D dev_to_node(&instance->pdev->dev);
+		mask =3D cpumask_of_node(dev_to_node(&instance->pdev->dev));
=20
-		for (i =3D 0; i < instance->low_latency_index_start; i++)
-			irq_set_affinity_hint(pci_irq_vector(instance->pdev, i),
-				cpumask_of_node(local_numa_node));
+		for (i =3D 0; i < instance->low_latency_index_start; i++) {
+			irq =3D pci_irq_vector(instance->pdev, i);
+			irq_set_affinity_and_hint(irq, mask);
+		}
 	}
 }
=20
@@ -5998,7 +6001,7 @@ megasas_alloc_irq_vectors(struct megasas_instance *inst=
ance)
 		instance->msix_vectors =3D 0;
=20
 	if (instance->smp_affinity_enable)
-		megasas_set_high_iops_queue_affinity_hint(instance);
+		megasas_set_high_iops_queue_affinity_and_hint(instance);
 }
=20
 /**
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3s=
as_base.c
index 81dab9b82f79..511726f92d9a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3086,6 +3086,7 @@ _base_check_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 void
 mpt3sas_base_free_irq(struct MPT3SAS_ADAPTER *ioc)
 {
+	unsigned int irq;
 	struct adapter_reply_queue *reply_q, *next;
=20
 	if (list_empty(&ioc->reply_queue_list))
@@ -3098,9 +3099,10 @@ mpt3sas_base_free_irq(struct MPT3SAS_ADAPTER *ioc)
 			continue;
 		}
=20
-		if (ioc->smp_affinity_enable)
-			irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
-			    reply_q->msix_index), NULL);
+		if (ioc->smp_affinity_enable) {
+			irq =3D pci_irq_vector(ioc->pdev, reply_q->msix_index);
+			irq_update_affinity_hint(irq, NULL);
+		}
 		free_irq(pci_irq_vector(ioc->pdev, reply_q->msix_index),
 			 reply_q);
 		kfree(reply_q);
@@ -3167,18 +3169,15 @@ _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 ind=
ex)
  * @ioc: per adapter object
  *
  * The enduser would need to set the affinity via /proc/irq/#/smp_affinity
- *
- * It would nice if we could call irq_set_affinity, however it is not
- * an exported symbol
  */
 static void
 _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 {
-	unsigned int cpu, nr_cpus, nr_msix, index =3D 0;
+	unsigned int cpu, nr_cpus, nr_msix, index =3D 0, irq;
 	struct adapter_reply_queue *reply_q;
-	int local_numa_node;
 	int iopoll_q_count =3D ioc->reply_queue_count -
 	    ioc->iopoll_q_start_index;
+	const struct cpumask *mask;
=20
 	if (!_base_is_controller_msix_enabled(ioc))
 		return;
@@ -3201,11 +3200,11 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 		 * corresponding to high iops queues.
 		 */
 		if (ioc->high_iops_queues) {
-			local_numa_node =3D dev_to_node(&ioc->pdev->dev);
+			mask =3D cpumask_of_node(dev_to_node(&ioc->pdev->dev));
 			for (index =3D 0; index < ioc->high_iops_queues;
 			    index++) {
-				irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
-				    index), cpumask_of_node(local_numa_node));
+				irq =3D pci_irq_vector(ioc->pdev, index);
+				irq_set_affinity_and_hint(irq, mask);
 			}
 		}
=20
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1f22a30c0963..9367f1cb2e3c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -329,7 +329,46 @@ extern int irq_force_affinity(unsigned int irq, const st=
ruct cpumask *cpumask);
 extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
=20
-extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
+extern int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask =
*m,
+				     bool setaffinity);
+
+/**
+ * irq_update_affinity_hint - Update the affinity hint
+ * @irq:	Interrupt to update
+ * @m:		cpumask pointer (NULL to clear the hint)
+ *
+ * Updates the affinity hint, but does not change the affinity of the interr=
upt.
+ */
+static inline int
+irq_update_affinity_hint(unsigned int irq, const struct cpumask *m)
+{
+	return __irq_apply_affinity_hint(irq, m, false);
+}
+
+/**
+ * irq_set_affinity_and_hint - Update the affinity hint and apply the provid=
ed
+ *			     cpumask to the interrupt
+ * @irq:	Interrupt to update
+ * @m:		cpumask pointer (NULL to clear the hint)
+ *
+ * Updates the affinity hint and if @m is not NULL it applies it as the
+ * affinity of that interrupt.
+ */
+static inline int
+irq_set_affinity_and_hint(unsigned int irq, const struct cpumask *m)
+{
+	return __irq_apply_affinity_hint(irq, m, true);
+}
+
+/*
+ * Deprecated. Use irq_update_affinity_hint() or irq_set_affinity_and_hint()
+ * instead.
+ */
+static inline int irq_set_affinity_hint(unsigned int irq, const struct cpuma=
sk *m)
+{
+	return irq_set_affinity_and_hint(irq, m);
+}
+
 extern int irq_update_affinity_desc(unsigned int irq,
 				    struct irq_affinity_desc *affinity);
=20
@@ -361,6 +400,18 @@ static inline int irq_can_set_affinity(unsigned int irq)
=20
 static inline int irq_select_affinity(unsigned int irq)  { return 0; }
=20
+static inline int irq_update_affinity_hint(unsigned int irq,
+					   const struct cpumask *m)
+{
+	return -EINVAL;
+}
+
+static inline int irq_set_affinity_and_hint(unsigned int irq,
+					    const struct cpumask *m)
+{
+	return -EINVAL;
+}
+
 static inline int irq_set_affinity_hint(unsigned int irq,
 					const struct cpumask *m)
 {
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-g=
ic-v3.h
index 81cbf85f73de..12d91f0dedf9 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -615,7 +615,7 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
-		bool		lpi_enabled;
+		u64             flags;
 		cpumask_t	*vpe_table_mask;
 		void		*vpe_l1_base;
 	} __percpu		*rdist;
@@ -624,6 +624,7 @@ struct rdists {
 	u64			flags;
 	u32			gicd_typer;
 	u32			gicd_typer2;
+	int                     cpuhp_memreserve_state;
 	bool			has_vlpis;
 	bool			has_rvpeid;
 	bool			has_direct_lpi;
@@ -632,6 +633,7 @@ struct rdists {
=20
 struct irq_domain;
 struct fwnode_handle;
+int __init its_lpi_memreserve_init(void);
 int its_cpu_init(void);
 int its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	     struct irq_domain *domain);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 553da4899f55..d476405802e9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -131,7 +131,7 @@ struct irq_domain_ops {
 #endif
 };
=20
-extern struct irq_domain_ops irq_generic_chip_ops;
+extern const struct irq_domain_ops irq_generic_chip_ops;
=20
 struct irq_domain_chip_generic;
=20
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 6f29bf4c8515..f0862eb6b506 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -451,7 +451,7 @@ static void irq_unmap_generic_chip(struct irq_domain *d, =
unsigned int virq)
=20
 }
=20
-struct irq_domain_ops irq_generic_chip_ops =3D {
+const struct irq_domain_ops irq_generic_chip_ops =3D {
 	.map	=3D irq_map_generic_chip,
 	.unmap  =3D irq_unmap_generic_chip,
 	.xlate	=3D irq_domain_xlate_onetwocell,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7405e384e5ed..f23ffd30385b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -486,7 +486,8 @@ int irq_force_affinity(unsigned int irq, const struct cpu=
mask *cpumask)
 }
 EXPORT_SYMBOL_GPL(irq_force_affinity);
=20
-int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
+int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
+			      bool setaffinity)
 {
 	unsigned long flags;
 	struct irq_desc *desc =3D irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK=
_GLOBAL);
@@ -495,12 +496,11 @@ int irq_set_affinity_hint(unsigned int irq, const struc=
t cpumask *m)
 		return -EINVAL;
 	desc->affinity_hint =3D m;
 	irq_put_desc_unlock(desc, flags);
-	/* set the initial affinity to prevent every interrupt being on CPU0 */
-	if (m)
+	if (m && setaffinity)
 		__irq_set_affinity(irq, m, false);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
+EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
=20
 static void irq_affinity_notify(struct work_struct *work)
 {

