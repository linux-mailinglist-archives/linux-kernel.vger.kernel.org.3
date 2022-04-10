Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB4D4FADD1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiDJM0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiDJM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:26:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE759F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 05:24:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649593440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wbzLQSGcP/oPIn5CnOWXYz9lPuorrybKkMQRJJxMa10=;
        b=aUsbmJ3FvdoG/PCj4QBpohpPsejOZ0teF/xE5Ivb+ClUcWRBtg6Jua2nMDqiayDc7mPTR2
        nBsYvjyPvVu8vsF6J1ekoaGVfhEo6SsMvOP/DjYdtE4NOcMCDubja6WgD5vnM/bI8iIfQU
        pr5iNJiFbcslY3RE8aJJuhwaUm186/AZmxnFR7KN9ruPdA9ZJBc7sgdEIcmdNSktoAddzM
        19OMZuuZIFp11hoeJDuJXMrUwxZZhkiaV7zbRSirsqw3693tsv2qs3A9Wz3xYYyrTrcbuT
        fxiv9plAXXjhILKhPr8yzA94SZzOhRYNb5wLUKPMYERuT52NCySTSK5TySWAbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649593440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wbzLQSGcP/oPIn5CnOWXYz9lPuorrybKkMQRJJxMa10=;
        b=RcB/0RclzvdRe3aaPayqxm6tfBAph6YvsmclK7tB+jeXm9VxeCKo7f7fRRUSm0BV2/LEdL
        8zgCdPCalV+/QXDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.18-rc2
Message-ID: <164959340965.293972.6241179986026423856.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 10 Apr 2022 14:23:59 +0200 (CEST)
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
04-10

up to:  63ef1a8a07ef: Merge tag 'irqchip-fixes-5.18-1' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

A set of interrupt chip driver fixes:

  - A fix for a long standing bug in the ARM GICv3 redistributor polling
    which uses the wrong bit number to test.

  - Prevent translation of bogus ACPI table entries which map device
    interrupts into the IPI space on ARM GICs.

  - Don't write into the pending register of ARM GICV4 before the scan
    in hardware has completed.

  - A set of build and correctness fixes for the Qualcomm MPM driver

Thanks,

	tglx

------------------>
Andre Przywara (1):
      irqchip/gic, gic-v3: Prevent GSI to SGI translations

Marc Zyngier (2):
      irqchip/gic-v4: Wait for GICR_VPENDBASER.Dirty to clear before deschedu=
ling
      irqchip/gic-v3: Fix GICR_CTLR.RWP polling

Yang Yingliang (1):
      irqchip/irq-qcom-mpm: fix return value check in qcom_mpm_init()

YueHaibing (1):
      irq/qcom-mpm: Fix build error without MAILBOX


 drivers/irqchip/Kconfig          |  1 +
 drivers/irqchip/irq-gic-v3-its.c | 28 +++++++++++++++++++---------
 drivers/irqchip/irq-gic-v3.c     | 14 ++++++++++----
 drivers/irqchip/irq-gic.c        |  6 ++++++
 drivers/irqchip/irq-qcom-mpm.c   |  2 +-
 5 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 680d2fcf2686..15edb9a6fcae 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -433,6 +433,7 @@ config QCOM_PDC
 config QCOM_MPM
 	tristate "QCOM MPM"
 	depends on ARCH_QCOM
+	depends on MAILBOX
 	select IRQ_DOMAIN_HIERARCHY
 	help
 	  MSM Power Manager driver to manage and configure wakeup
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index cd772973114a..a0fc764ec9dc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3011,18 +3011,12 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
=20
-static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
+static u64 read_vpend_dirty_clear(void __iomem *vlpi_base)
 {
 	u32 count =3D 1000000;	/* 1s! */
 	bool clean;
 	u64 val;
=20
-	val =3D gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-	val &=3D ~GICR_VPENDBASER_Valid;
-	val &=3D ~clr;
-	val |=3D set;
-	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
-
 	do {
 		val =3D gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 		clean =3D !(val & GICR_VPENDBASER_Dirty);
@@ -3033,10 +3027,26 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_b=
ase, u64 clr, u64 set)
 		}
 	} while (!clean && count);
=20
-	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
+	if (unlikely(!clean))
 		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
+
+	return val;
+}
+
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
+{
+	u64 val;
+
+	/* Make sure we wait until the RD is done with the initial scan */
+	val =3D read_vpend_dirty_clear(vlpi_base);
+	val &=3D ~GICR_VPENDBASER_Valid;
+	val &=3D ~clr;
+	val |=3D set;
+	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	val =3D read_vpend_dirty_clear(vlpi_base);
+	if (unlikely(val & GICR_VPENDBASER_Dirty))
 		val |=3D GICR_VPENDBASER_PendingLast;
-	}
=20
 	return val;
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0efe1a9a9f3b..b252d5534547 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -206,11 +206,11 @@ static inline void __iomem *gic_dist_base(struct irq_da=
ta *d)
 	}
 }
=20
-static void gic_do_wait_for_rwp(void __iomem *base)
+static void gic_do_wait_for_rwp(void __iomem *base, u32 bit)
 {
 	u32 count =3D 1000000;	/* 1s! */
=20
-	while (readl_relaxed(base + GICD_CTLR) & GICD_CTLR_RWP) {
+	while (readl_relaxed(base + GICD_CTLR) & bit) {
 		count--;
 		if (!count) {
 			pr_err_ratelimited("RWP timeout, gone fishing\n");
@@ -224,13 +224,13 @@ static void gic_do_wait_for_rwp(void __iomem *base)
 /* Wait for completion of a distributor change */
 static void gic_dist_wait_for_rwp(void)
 {
-	gic_do_wait_for_rwp(gic_data.dist_base);
+	gic_do_wait_for_rwp(gic_data.dist_base, GICD_CTLR_RWP);
 }
=20
 /* Wait for completion of a redistributor change */
 static void gic_redist_wait_for_rwp(void)
 {
-	gic_do_wait_for_rwp(gic_data_rdist_rd_base());
+	gic_do_wait_for_rwp(gic_data_rdist_rd_base(), GICR_CTLR_RWP);
 }
=20
 #ifdef CONFIG_ARM64
@@ -1466,6 +1466,12 @@ static int gic_irq_domain_translate(struct irq_domain =
*d,
 		if(fwspec->param_count !=3D 2)
 			return -EINVAL;
=20
+		if (fwspec->param[0] < 16) {
+			pr_err(FW_BUG "Illegal GSI%d translation request\n",
+			       fwspec->param[0]);
+			return -EINVAL;
+		}
+
 		*hwirq =3D fwspec->param[0];
 		*type =3D fwspec->param[1];
=20
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 58ba835bee1f..09c710ecc387 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1123,6 +1123,12 @@ static int gic_irq_domain_translate(struct irq_domain =
*d,
 		if(fwspec->param_count !=3D 2)
 			return -EINVAL;
=20
+		if (fwspec->param[0] < 16) {
+			pr_err(FW_BUG "Illegal GSI%d translation request\n",
+			       fwspec->param[0]);
+			return -EINVAL;
+		}
+
 		*hwirq =3D fwspec->param[0];
 		*type =3D fwspec->param[1];
=20
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index eea5a753618c..d30614661eea 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -375,7 +375,7 @@ static int qcom_mpm_init(struct device_node *np, struct d=
evice_node *parent)
 	raw_spin_lock_init(&priv->lock);
=20
 	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
-	if (!priv->base)
+	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
=20
 	for (i =3D 0; i < priv->reg_stride; i++) {

