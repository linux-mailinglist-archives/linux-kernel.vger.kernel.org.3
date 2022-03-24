Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8FB4E9B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiC1PtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbiC1PqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:46:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1200E4A939;
        Mon, 28 Mar 2022 08:44:14 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 95F091E28E0;
        Thu, 24 Mar 2022 03:16:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 95F091E28E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648081006;
        bh=6Kd3qMHO00PfqoQRXxobfhr4JHDlRHPHTHTka6IvHzU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=R4S7cLafeqzKFMHAT7tnNTxpGXj1ZXiAbnolqppgbqxwV7H24GU4nU5y5mtydGP3W
         5RER6jTwF0ln2sWI+l1LinMGGnu5b+0hOVZ/Tcrx1VNGUJtJ33yooTv73s5yfyz9jF
         0NDRyJZIxiFM2rEpftYbEiMCh4FJ9TvobkY/mwcQ=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:46 +0300
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
Subject: [PATCH 20/21] ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
Date:   Thu, 24 Mar 2022 03:16:27 +0300
Message-ID: <20220324001628.13028-21-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
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
 drivers/ata/Kconfig    |  1 +
 drivers/ata/ahci_dwc.c | 86 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ab11bcf8510c..003f000a69a7 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -178,6 +178,7 @@ config AHCI_DWC
 	tristate "Synopsys DWC AHCI SATA support"
 	select SATA_HOST
 	default SATA_AHCI_PLATFORM
+	select MFD_SYSCON if (MIPS_BAIKAL_T1 || COMPILE_TEST)
 	help
 	  This option enables support for the Synopsys DWC AHCI SATA
 	  controller implementation.
diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index 9e294f994ed3..efcd5f74c2d4 100644
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
 #define DWC_AHCI_PORT_PHYCR		0x74
 #define DWC_AHCI_PORT_PHYSR		0x78
 
+/* Baikal-T1 AHCI SATA specific registers */
+#define BT1_AHCI_HOST_PHYCR		DWC_AHCI_HOST_GPCR
+#define BT1_AHCI_HOST_MPLM_MASK		GENMASK(29, 23)
+#define BT1_AHCI_HOST_LOSDT_MASK	GENMASK(22, 20)
+#define BT1_AHCI_HOST_CRR		BIT(19)
+#define BT1_AHCI_HOST_CRW		BIT(18)
+#define BT1_AHCI_HOST_CRCD		BIT(17)
+#define BT1_AHCI_HOST_CRCA		BIT(16)
+#define BT1_AHCI_HOST_CRDI_MASK		GENMASK(15, 0)
+
+#define BT1_AHCI_HOST_PHYSR		DWC_AHCI_HOST_GPSR
+#define BT1_AHCI_HOST_CRA		BIT(16)
+#define BT1_AHCI_HOST_CRDO_MASK		GENMASK(15, 0)
+
+/* Baikal-T1 CCU registers concerning the AHCI SATA module */
+#define BT1_CCU_SYS_SATA_REF		0x60
+#define BT1_CCU_SYS_SATA_REF_EXT	BIT(28)
+#define BT1_CCU_SYS_SATA_REF_INV	BIT(29)
+#define BT1_CCU_SYS_SATA_REF_BUF	BIT(30)
+
 struct dwc_ahci_plat_data {
 	unsigned int pflags;
 	unsigned int hflags;
@@ -106,6 +128,64 @@ struct dwc_ahci_host_priv {
 	u32 dmacr[AHCI_MAX_PORTS];
 };
 
+static int bt1_ahci_init(struct ahci_host_priv *hpriv)
+{
+	struct dwc_ahci_host_priv *dpriv = hpriv->plat_data;
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
+	sys_regs = syscon_regmap_lookup_by_phandle(dpriv->pdev->dev.of_node, "syscon");
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
 static struct ahci_host_priv *dwc_ahci_get_resources(struct platform_device *pdev)
 {
 	struct dwc_ahci_host_priv *dpriv;
@@ -415,9 +495,15 @@ struct dwc_ahci_plat_data dwc_ahci_plat = {
 	.pflags = AHCI_PLATFORM_GET_RESETS,
 };
 
+struct dwc_ahci_plat_data bt1_ahci_plat = {
+	.pflags = AHCI_PLATFORM_GET_RESETS | AHCI_PLATFORM_RST_TRIGGER,
+	.init = bt1_ahci_init,
+};
+
 static const struct of_device_id dwc_ahci_of_match[] = {
 	{ .compatible = "snps,dwc-ahci", &dwc_ahci_plat },
 	{ .compatible = "snps,spear-ahci", &dwc_ahci_plat },
+	{ .compatible = "baikal,bt1-ahci", &bt1_ahci_plat },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc_ahci_of_match);
-- 
2.35.1

