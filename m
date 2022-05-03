Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4417A518E61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbiECUPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbiECUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:14:04 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B05B710FC5;
        Tue,  3 May 2022 13:10:24 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 10159BCA;
        Tue,  3 May 2022 23:10:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 10159BCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651608657;
        bh=W0zpVpyp21FcmZKKvGW6SPQXo73H6PMb/goz++F2IU4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=MjTejYhr15EERK9tdO2fZAuNOrK5W0o3yj/CYvRsrxO5OsbUreTyIqUQdUJHUvuLV
         oQNsMIjddihdpGn3avu1VLHiGLWRKdJmsrBGwK0m34LCGOn5P3kgdYdPruGkrO/aFo
         szr5xAomabj24jgNVmmLKzQ/pRRM3yEt/lZ3JZuQ=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 May 2022 23:10:23 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 22/23] ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
Date:   Tue, 3 May 2022 23:09:37 +0300
Message-ID: <20220503200938.18027-23-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's almost fully compatible DWC AHCI SATA IP-core derivative except the
reference clocks source, which need to be very carefully selected. In
particular the DWC AHCI SATA PHY can be clocked either from the pads
ref_pad_clk_{m,p} or from the internal wires ref_alt_clk_{m,n}. In the
later case the clock signal is generated from the Baikal-T1 CCU SATA PLL.
The clocks source is selected by means of the ref_use_pad wire connected
to the CCU SATA reference clock CSR.

In normal situation it would be much more handy to use the internal
reference clock source, but alas we haven't managed to make the AHCI
controller working well with it so far. So it's preferable to have the
controller clocked from the external clock generator and fallback to the
internal clock source only as a last resort. Other than that the
controller is full compatible with the DWC AHCI SATA IP-core.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Rename 'syscon' property to 'baikal,bt1-syscon'.
- Change the local objects prefix from 'dwc_ahci_' to 'ahci_dwc_',
  from 'bt1_ahci_' to 'ahci_bt1_'. (@Damien)
---
 drivers/ata/Kconfig    |  1 +
 drivers/ata/ahci_dwc.c | 87 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 95e0e022b5bb..249717cdc74f 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -180,6 +180,7 @@ config AHCI_DWC
 	tristate "Synopsys DWC AHCI SATA support"
 	select SATA_HOST
 	default SATA_AHCI_PLATFORM
+	select MFD_SYSCON if (MIPS_BAIKAL_T1 || COMPILE_TEST)
 	help
 	  This option enables support for the Synopsys DWC AHCI SATA
 	  controller implementation.
diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index f987efa1ad59..d464db20f869 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -13,10 +13,12 @@
 #include <linux/kernel.h>
 #include <linux/libata.h>
 #include <linux/log2.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/regmap.h>
 
 #include "ahci.h"
 
@@ -90,6 +92,26 @@
 #define AHCI_DWC_PORT_PHYCR		0x74
 #define AHCI_DWC_PORT_PHYSR		0x78
 
+/* Baikal-T1 AHCI SATA specific registers */
+#define AHCI_BT1_HOST_PHYCR		AHCI_DWC_HOST_GPCR
+#define AHCI_BT1_HOST_MPLM_MASK		GENMASK(29, 23)
+#define AHCI_BT1_HOST_LOSDT_MASK	GENMASK(22, 20)
+#define AHCI_BT1_HOST_CRR		BIT(19)
+#define AHCI_BT1_HOST_CRW		BIT(18)
+#define AHCI_BT1_HOST_CRCD		BIT(17)
+#define AHCI_BT1_HOST_CRCA		BIT(16)
+#define AHCI_BT1_HOST_CRDI_MASK		GENMASK(15, 0)
+
+#define AHCI_BT1_HOST_PHYSR		AHCI_DWC_HOST_GPSR
+#define AHCI_BT1_HOST_CRA		BIT(16)
+#define AHCI_BT1_HOST_CRDO_MASK		GENMASK(15, 0)
+
+/* Baikal-T1 CCU registers concerning the AHCI SATA module */
+#define BT1_CCU_SYS_SATA_REF		0x60
+#define BT1_CCU_SYS_SATA_REF_EXT	BIT(28)
+#define BT1_CCU_SYS_SATA_REF_INV	BIT(29)
+#define BT1_CCU_SYS_SATA_REF_BUF	BIT(30)
+
 struct ahci_dwc_plat_data {
 	unsigned int pflags;
 	unsigned int hflags;
@@ -106,6 +128,65 @@ struct ahci_dwc_host_priv {
 	u32 dmacr[AHCI_MAX_PORTS];
 };
 
+static int ahci_bt1_init(struct ahci_host_priv *hpriv)
+{
+	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
+	struct regmap *sys_regs;
+	u32 ref_ctl, mask;
+
+	/* APB and application clocks are required */
+	if (!ahci_platform_find_clk(hpriv, "pclk") ||
+	    !ahci_platform_find_clk(hpriv, "aclk")) {
+		dev_err(&dpriv->pdev->dev, "No system clocks specified\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * We need to select the PHY reference clock source. The signal
+	 * can be delivered either from the chip pads or from the internal
+	 * PLL. The source is selected by the PHY's ref_use_pad signal
+	 * tied up into one of the CCU SATA ref-ctl register field.
+	 */
+	sys_regs = syscon_regmap_lookup_by_phandle(dpriv->pdev->dev.of_node,
+						   "baikal,bt1-syscon");
+	if (IS_ERR(sys_regs)) {
+		dev_err(&dpriv->pdev->dev, "CCU syscon couldn't be found\n");
+		return PTR_ERR(sys_regs);
+	}
+
+	(void)regmap_read(sys_regs, BT1_CCU_SYS_SATA_REF, &ref_ctl);
+
+	/*
+	 * Prefer activating external reference clock if one is supplied.
+	 * If there is no external ref clock, then we have no choice but
+	 * to fall back to the internal signal coming from PLL. Alas
+	 * we haven't managed to make the interface working well when it's
+	 * used so far, but in no alternative let's at least try...
+	 */
+	if (ahci_platform_find_clk(hpriv, "ref_ext")) {
+		ref_ctl |= BT1_CCU_SYS_SATA_REF_EXT;
+		mask = BT1_CCU_SYS_SATA_REF_EXT;
+	} else if (ahci_platform_find_clk(hpriv, "ref_int")) {
+		ref_ctl &= ~BT1_CCU_SYS_SATA_REF_EXT;
+		ref_ctl |= BT1_CCU_SYS_SATA_REF_INV | BT1_CCU_SYS_SATA_REF_BUF;
+		mask = BT1_CCU_SYS_SATA_REF_EXT |
+		       BT1_CCU_SYS_SATA_REF_INV | BT1_CCU_SYS_SATA_REF_BUF;
+		dev_warn(&dpriv->pdev->dev, "Fallback to PLL-based ref clock!\n");
+	} else {
+		dev_err(&dpriv->pdev->dev, "No ref clock specified\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(sys_regs, BT1_CCU_SYS_SATA_REF, mask, ref_ctl);
+
+	/*
+	 * Fully reset the SATA AXI and ref clocks domain so to ensure the
+	 * state machine is working from scratch.
+	 */
+	ahci_platform_assert_rsts(hpriv);
+	return ahci_platform_deassert_rsts(hpriv);
+}
+
 static struct ahci_host_priv *ahci_dwc_get_resources(struct platform_device *pdev)
 {
 	struct ahci_dwc_host_priv *dpriv;
@@ -415,9 +496,15 @@ struct ahci_dwc_plat_data ahci_dwc_plat = {
 	.pflags = AHCI_PLATFORM_GET_RESETS,
 };
 
+struct ahci_dwc_plat_data ahci_bt1_plat = {
+	.pflags = AHCI_PLATFORM_GET_RESETS | AHCI_PLATFORM_RST_TRIGGER,
+	.init = ahci_bt1_init,
+};
+
 static const struct of_device_id ahci_dwc_of_match[] = {
 	{ .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
 	{ .compatible = "snps,spear-ahci", &ahci_dwc_plat },
+	{ .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_dwc_of_match);
-- 
2.35.1

