Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC447199A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 11:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhLLKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 05:34:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhLLKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 05:34:22 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639305261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fU9XDxaCBJJYdNV9QK2WKootRBMRWpuGvjydtA4dt0Q=;
        b=ri8pGwzXIWmEoYcmRXHvqDn7tXECIuQ9m83FoSAPE7o3eypidtdDQp4NFASBr34YyX71bn
        11NoMHAIYntP5HIQIB79qY4qT99WEmLlgcmM+qvBgvstRJBvjVOKTVIp0T7Z0q5dk2C+Do
        EwwsuoLqTyfi2fkDBxfH9ZU5GVBrYvk+YttJY6IFP/01ayt0bLlI8zCTS/ZqWet714KVxt
        C3UJMdGml94pr4ghet9hA1BGasEah0aUn+nZ9PkIF1IFEGNM3i+0no7+NGilIFdF3ZraYy
        HM0kKPhRCUK9UwS2bn45NU6e1YeiWEDBLH03voQOLWbNIL3uIe25caSBsTImGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639305261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fU9XDxaCBJJYdNV9QK2WKootRBMRWpuGvjydtA4dt0Q=;
        b=naTNNNVK/1BVi/cb+wNqypVHSdW6PEM1ou76YbNO4CCReOz/TPRYIsH2+P7ve29cG+b1Jo
        g8V7Be8iunO/5PAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.16-rc5
Message-ID: <163930519667.2118055.7751610896538340816.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 12 Dec 2021 11:34:20 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-=
12-12

up to:  b7fd35a0ad97: Merge tag 'irqchip-fixes-5.16-2' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


A set of interrupt chip driver fixes:

 - Fix the multi vector MSI allocation on Armada 370XP.

 - Do interrupt acknowledgement correctly in the aspeed-scu driver.

 - Make the IPR register offset correct in the NVIC driver.

 - Make redistribution table flushing correct by issueing a SYNC command to
   ensure that the invalidation command has been executed.

 - Plug a device tree node reference leak in the bcm7210-l2 driver.

 - Trivial fixes in the MIPS GIC and the Apple AIC drivers


Thanks,

	tglx

------------------>
Billy Tsai (1):
      irqchip/aspeed-scu: Replace update_bits with write_bits.

Donghyeok Kim (1):
      irqchip/apple-aic: Mark aic_init_smp() as __init

Geert Uytterhoeven (1):
      irqchip/mips-gic: Use bitfield helpers

Pali Roh=C3=A1r (2):
      irqchip/armada-370-xp: Fix return value of armada_370_xp_msi_alloc()
      irqchip/armada-370-xp: Fix support for Multi-MSI interrupts

Vladimir Murzin (1):
      irqchip: nvic: Fix offset for Interrupt Priority Offsets

Wudi Wang (1):
      irqchip/irq-gic-v3-its.c: Force synchronisation when issuing INVALL

Ye Guojin (1):
      irqchip/irq-bcm7120-l2: Add put_device() after of_find_device_by_node()


 drivers/irqchip/irq-apple-aic.c     |  2 +-
 drivers/irqchip/irq-armada-370-xp.c | 16 ++++++----------
 drivers/irqchip/irq-aspeed-scu-ic.c |  4 ++--
 drivers/irqchip/irq-bcm7120-l2.c    |  1 +
 drivers/irqchip/irq-gic-v3-its.c    |  2 +-
 drivers/irqchip/irq-mips-gic.c      |  4 ++--
 drivers/irqchip/irq-nvic.c          |  2 +-
 7 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 3759dc36cc8f..2543ef65825b 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -707,7 +707,7 @@ static const struct irq_domain_ops aic_ipi_domain_ops =3D=
 {
 	.free =3D aic_ipi_free,
 };
=20
-static int aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
+static int __init aic_init_smp(struct aic_irq_chip *irqc, struct device_node=
 *node)
 {
 	struct irq_domain *ipi_domain;
 	int base_ipi;
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 80906bfec845..5b8d571c041d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -232,16 +232,12 @@ static int armada_370_xp_msi_alloc(struct irq_domain *d=
omain, unsigned int virq,
 	int hwirq, i;
=20
 	mutex_lock(&msi_used_lock);
+	hwirq =3D bitmap_find_free_region(msi_used, PCI_MSI_DOORBELL_NR,
+					order_base_2(nr_irqs));
+	mutex_unlock(&msi_used_lock);
=20
-	hwirq =3D bitmap_find_next_zero_area(msi_used, PCI_MSI_DOORBELL_NR,
-					   0, nr_irqs, 0);
-	if (hwirq >=3D PCI_MSI_DOORBELL_NR) {
-		mutex_unlock(&msi_used_lock);
+	if (hwirq < 0)
 		return -ENOSPC;
-	}
-
-	bitmap_set(msi_used, hwirq, nr_irqs);
-	mutex_unlock(&msi_used_lock);
=20
 	for (i =3D 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
@@ -250,7 +246,7 @@ static int armada_370_xp_msi_alloc(struct irq_domain *dom=
ain, unsigned int virq,
 				    NULL, NULL);
 	}
=20
-	return hwirq;
+	return 0;
 }
=20
 static void armada_370_xp_msi_free(struct irq_domain *domain,
@@ -259,7 +255,7 @@ static void armada_370_xp_msi_free(struct irq_domain *dom=
ain,
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
=20
 	mutex_lock(&msi_used_lock);
-	bitmap_clear(msi_used, d->hwirq, nr_irqs);
+	bitmap_release_region(msi_used, d->hwirq, order_base_2(nr_irqs));
 	mutex_unlock(&msi_used_lock);
 }
=20
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed=
-scu-ic.c
index f3c6855a4cef..18b77c3e6db4 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -76,8 +76,8 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 		generic_handle_domain_irq(scu_ic->irq_domain,
 					  bit - scu_ic->irq_shift);
=20
-		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
-				   BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
+				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
 	}
=20
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l=
2.c
index d80e67a6aad2..bb6609cebdbc 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -238,6 +238,7 @@ static int __init bcm7120_l2_intc_probe(struct device_nod=
e *dn,
 	}
=20
 	data->num_parent_irqs =3D platform_irq_count(pdev);
+	put_device(&pdev->dev);
 	if (data->num_parent_irqs <=3D 0) {
 		pr_err("invalid number of parent interrupts\n");
 		ret =3D -ENOMEM;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index eb0882d15366..0cb584d9815b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -742,7 +742,7 @@ static struct its_collection *its_build_invall_cmd(struct=
 its_node *its,
=20
 	its_fixup_cmd(cmd);
=20
-	return NULL;
+	return desc->its_invall_cmd.col;
 }
=20
 static struct its_vpe *its_build_vinvall_cmd(struct its_node *its,
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d02b05a067d9..ff89b36267dd 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -9,6 +9,7 @@
=20
 #define pr_fmt(fmt) "irq-mips-gic: " fmt
=20
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/clocksource.h>
 #include <linux/cpuhotplug.h>
@@ -735,8 +736,7 @@ static int __init gic_of_init(struct device_node *node,
 	mips_gic_base =3D ioremap(gic_base, gic_len);
=20
 	gicconfig =3D read_gic_config();
-	gic_shared_intrs =3D gicconfig & GIC_CONFIG_NUMINTERRUPTS;
-	gic_shared_intrs >>=3D __ffs(GIC_CONFIG_NUMINTERRUPTS);
+	gic_shared_intrs =3D FIELD_GET(GIC_CONFIG_NUMINTERRUPTS, gicconfig);
 	gic_shared_intrs =3D (gic_shared_intrs + 1) * 8;
=20
 	if (cpu_has_veic) {
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 63bac3f78863..ba4759b3e269 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -26,7 +26,7 @@
=20
 #define NVIC_ISER		0x000
 #define NVIC_ICER		0x080
-#define NVIC_IPR		0x300
+#define NVIC_IPR		0x400
=20
 #define NVIC_MAX_BANKS		16
 /*

