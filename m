Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74477550AC6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiFSNMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiFSNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:12:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6721AE4C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:12:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655644354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YMyjhZ3RbLH80EYhg2RzxTVpW/yKN668UdURKeQb3YM=;
        b=iZzVUu9i7J11qnRkBh/L3fgniNElypGWD0/kXOb+Rtd7o1buR7Z38cd4VnPG5SOVTisy4E
        aRUVxy6PvPZ2gip/V1elcTb7jxXYdNOoNKjWYO0gcw3szVNVk/F1jAF5EiFh1rsbQXQgNT
        v4bE3Dq9LL20Ke7GZqpvseTpTOlhrQnxrQzc2rxYCH3Dxh2yG/l7B7AgI5XaD2htlEBaLQ
        +STGtg/O7304hIEBba93D6ZIFKvphkebBoxeFJ+9Vrj8WzAsrv6ZpKlEWmFDrIMK/ILlwY
        lY5M1C5IYr+Rc+N1I9T/kyO8O2qqcKkroDVp7aFm5IbhSHeVXPYj9PZGmQjhlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655644354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YMyjhZ3RbLH80EYhg2RzxTVpW/yKN668UdURKeQb3YM=;
        b=GOge/z9TEBTjd2P98gJhChlOhdSywlgZy3ktQZW7h1K3u7pT8vFO1p10b5/Oj94DzdboGx
        SowUKtbXBEBlShDg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.19-rc3
Message-ID: <165564429738.1413209.17302088152547038708.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Jun 2022 15:12:33 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-=
06-19

up to:  6872fcac7158: Merge tag 'irqchip-fixes-5.19-1' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


A set of interrupt subsystem updates:

 Core:
	- Ensure runtime power management for chained interrupts

 Drivers:
	- A collection of OF node refcount fixes

        - Unbreak MIPS uniprocessor builds

	- Fix xilinx interrupt controller Kconfig dependencies

	- Add a missing compatible string to the Uniphier driver

Thanks,

	tglx

------------------>
Jamie Iles (1):
      irqchip/xilinx: Remove microblaze+zynq dependency

Jiaxun Yang (1):
      irqchip/loongson-liointc: Use architecture register to get coreid

Kunihiko Hayashi (2):
      dt-bindings: interrupt-controller/uniphier-aidet: Add bindings for NX1 =
SoC
      irqchip/uniphier-aidet: Add compatible string for NX1 SoC

Marc Zyngier (1):
      genirq: PM: Use runtime PM for chained interrupts

Miaoqian Lin (6):
      irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
      irqchip/apple-aic: Fix refcount leak in build_fiq_affinity
      irqchip/apple-aic: Fix refcount leak in aic_of_ic_init
      irqchip/gic-v3: Fix error handling in gic_populate_ppi_partitions
      irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions
      irqchip/realtek-rtl: Fix refcount leak in map_interrupts


 .../bindings/interrupt-controller/socionext,uniphier-aidet.yaml   | 1 +
 drivers/irqchip/Kconfig                                           | 2 +-
 drivers/irqchip/irq-apple-aic.c                                   | 2 ++
 drivers/irqchip/irq-gic-realview.c                                | 1 +
 drivers/irqchip/irq-gic-v3.c                                      | 7 +++++--
 drivers/irqchip/irq-loongson-liointc.c                            | 8 ++++++=
+-
 drivers/irqchip/irq-realtek-rtl.c                                 | 2 +-
 drivers/irqchip/irq-uniphier-aidet.c                              | 1 +
 kernel/irq/chip.c                                                 | 5 ++++-
 9 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext=
,uniphier-aidet.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/socionext,uniphier-aidet.yaml
index f89ebde76dab..de7c5e59bae1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphi=
er-aidet.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphi=
er-aidet.yaml
@@ -30,6 +30,7 @@ properties:
       - socionext,uniphier-ld11-aidet
       - socionext,uniphier-ld20-aidet
       - socionext,uniphier-pxs3-aidet
+      - socionext,uniphier-nx1-aidet
=20
   reg:
     maxItems: 1
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4ab1038b5482..1f23a6be7d88 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -298,7 +298,7 @@ config XTENSA_MX
=20
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
-	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
+	depends on OF
 	select IRQ_DOMAIN
 	help
 	  Support for the Xilinx Interrupt Controller IP core.
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 12dd48727a15..5ac83185ff47 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -1035,6 +1035,7 @@ static void build_fiq_affinity(struct aic_irq_chip *ic,=
 struct device_node *aff)
 			continue;
=20
 		cpu =3D of_cpu_node_to_id(cpu_node);
+		of_node_put(cpu_node);
 		if (WARN_ON(cpu < 0))
 			continue;
=20
@@ -1143,6 +1144,7 @@ static int __init aic_of_ic_init(struct device_node *no=
de, struct device_node *p
 		for_each_child_of_node(affs, chld)
 			build_fiq_affinity(irqc, chld);
 	}
+	of_node_put(affs);
=20
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
diff --git a/drivers/irqchip/irq-gic-realview.c b/drivers/irqchip/irq-gic-rea=
lview.c
index b4c1924f0255..38fab02ffe9d 100644
--- a/drivers/irqchip/irq-gic-realview.c
+++ b/drivers/irqchip/irq-gic-realview.c
@@ -57,6 +57,7 @@ realview_gic_of_init(struct device_node *node, struct devic=
e_node *parent)
=20
 	/* The PB11MPCore GIC needs to be configured in the syscon */
 	map =3D syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (!IS_ERR(map)) {
 		/* new irq mode with no DCC */
 		regmap_write(map, REALVIEW_SYS_LOCK_OFFSET,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2be8dea6b6b0..5c1cf907ee68 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1932,7 +1932,7 @@ static void __init gic_populate_ppi_partitions(struct d=
evice_node *gic_node)
=20
 	gic_data.ppi_descs =3D kcalloc(gic_data.ppi_nr, sizeof(*gic_data.ppi_descs)=
, GFP_KERNEL);
 	if (!gic_data.ppi_descs)
-		return;
+		goto out_put_node;
=20
 	nr_parts =3D of_get_child_count(parts_node);
=20
@@ -1973,12 +1973,15 @@ static void __init gic_populate_ppi_partitions(struct=
 device_node *gic_node)
 				continue;
=20
 			cpu =3D of_cpu_node_to_id(cpu_node);
-			if (WARN_ON(cpu < 0))
+			if (WARN_ON(cpu < 0)) {
+				of_node_put(cpu_node);
 				continue;
+			}
=20
 			pr_cont("%pOF[%d] ", cpu_node, cpu);
=20
 			cpumask_set_cpu(cpu, &part->mask);
+			of_node_put(cpu_node);
 		}
=20
 		pr_cont("}\n");
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loo=
ngson-liointc.c
index aed88857d90f..8d05d8bcf56f 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -39,6 +39,12 @@
=20
 #define LIOINTC_ERRATA_IRQ	10
=20
+#if defined(CONFIG_MIPS)
+#define liointc_core_id get_ebase_cpunum()
+#else
+#define liointc_core_id get_csr_cpuid()
+#endif
+
 struct liointc_handler_data {
 	struct liointc_priv	*priv;
 	u32			parent_int_map;
@@ -57,7 +63,7 @@ static void liointc_chained_handle_irq(struct irq_desc *des=
c)
 	struct liointc_handler_data *handler =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc =3D handler->priv->gc;
-	int core =3D cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
+	int core =3D liointc_core_id % LIOINTC_NUM_CORES;
 	u32 pending;
=20
 	chained_irq_enter(chip, desc);
diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-=
rtl.c
index 50a56820c99b..56bf502d9c67 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -134,9 +134,9 @@ static int __init map_interrupts(struct device_node *node=
, struct irq_domain *do
 		if (!cpu_ictl)
 			return -EINVAL;
 		ret =3D of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
+		of_node_put(cpu_ictl);
 		if (ret || tmp !=3D 1)
 			return -EINVAL;
-		of_node_put(cpu_ictl);
=20
 		cpu_int =3D be32_to_cpup(imap + 2);
 		if (cpu_int > 7 || cpu_int < 2)
diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniph=
ier-aidet.c
index 89121b39be26..716b1bb88bf2 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -237,6 +237,7 @@ static const struct of_device_id uniphier_aidet_match[] =
=3D {
 	{ .compatible =3D "socionext,uniphier-ld11-aidet" },
 	{ .compatible =3D "socionext,uniphier-ld20-aidet" },
 	{ .compatible =3D "socionext,uniphier-pxs3-aidet" },
+	{ .compatible =3D "socionext,uniphier-nx1-aidet" },
 	{ /* sentinel */ }
 };
=20
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index e6b8e564b37f..886789dcee43 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1006,8 +1006,10 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_h=
andler_t handle,
 		if (desc->irq_data.chip !=3D &no_irq_chip)
 			mask_ack_irq(desc);
 		irq_state_set_disabled(desc);
-		if (is_chained)
+		if (is_chained) {
 			desc->action =3D NULL;
+			WARN_ON(irq_chip_pm_put(irq_desc_get_irq_data(desc)));
+		}
 		desc->depth =3D 1;
 	}
 	desc->handle_irq =3D handle;
@@ -1033,6 +1035,7 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_ha=
ndler_t handle,
 		irq_settings_set_norequest(desc);
 		irq_settings_set_nothread(desc);
 		desc->action =3D &chained_action;
+		WARN_ON(irq_chip_pm_get(irq_desc_get_irq_data(desc)));
 		irq_activate_and_startup(desc, IRQ_RESEND);
 	}
 }

