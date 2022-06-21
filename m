Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CFB553355
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351645AbiFUNPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351300AbiFUNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:14:39 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 567FC1A041;
        Tue, 21 Jun 2022 06:14:34 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 55CA51C811AA;
        Tue, 21 Jun 2022 21:14:30 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 21
 Jun 2022 21:14:30 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 21 Jun
 2022 21:14:29 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Tue, 21 Jun 2022 21:14:29 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 812DE63A4D; Tue, 21 Jun 2022 16:14:27 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <jirislaby@kernel.org>,
        <shawnguo@kernel.org>, <bjorn.andersson@linaro.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <vkoul@kernel.org>, <biju.das.jz@bp.renesas.com>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robert.hancock@calian.com>,
        <j.neuschaefer@gmx.net>, <lkundrak@v3.sk>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 11/18] reset: npcm: Add NPCM8XX support
Date:   Tue, 21 Jun 2022 16:14:17 +0300
Message-ID: <20220621131424.162355-12-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220621131424.162355-1-tmaimon77@gmail.com>
References: <20220621131424.162355-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the NPCM reset driver to add
support for Nuvoton BMC NPCM8XX SoC.
As part of adding NPCM8XX support
- Add NPCM8XX specific compatible string.
- Add NPCM8XX USB reset.
- Add data to handle architecture-specific reset parameters.
- Some of the Reset Id and number of resets are
  different from NPCM7XX.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/reset-npcm.c | 205 +++++++++++++++++++++++++++++++------
 1 file changed, 172 insertions(+), 33 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 431ff2b602c5..e4801f2950fd 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -17,13 +17,20 @@
 
 /* NPCM7xx GCR registers */
 #define NPCM_MDLR_OFFSET	0x7C
-#define NPCM_MDLR_USBD0		BIT(9)
-#define NPCM_MDLR_USBD1		BIT(8)
-#define NPCM_MDLR_USBD2_4	BIT(21)
-#define NPCM_MDLR_USBD5_9	BIT(22)
+#define NPCM7XX_MDLR_USBD0	BIT(9)
+#define NPCM7XX_MDLR_USBD1	BIT(8)
+#define NPCM7XX_MDLR_USBD2_4	BIT(21)
+#define NPCM7XX_MDLR_USBD5_9	BIT(22)
+
+/* NPCM8xx MDLR bits */
+#define NPCM8XX_MDLR_USBD0_3	BIT(9)
+#define NPCM8XX_MDLR_USBD4_7	BIT(22)
+#define NPCM8XX_MDLR_USBD8	BIT(24)
+#define NPCM8XX_MDLR_USBD9	BIT(21)
 
 #define NPCM_USB1PHYCTL_OFFSET	0x140
 #define NPCM_USB2PHYCTL_OFFSET	0x144
+#define NPCM_USB3PHYCTL_OFFSET	0x148
 #define NPCM_USBXPHYCTL_RS	BIT(28)
 
 /* NPCM7xx Reset registers */
@@ -49,12 +56,38 @@
 #define NPCM_IPSRST3_USBPHY1	BIT(24)
 #define NPCM_IPSRST3_USBPHY2	BIT(25)
 
+#define NPCM_IPSRST4		0x74
+#define NPCM_IPSRST4_USBPHY3	BIT(25)
+#define NPCM_IPSRST4_USB_HOST2	BIT(31)
+
 #define NPCM_RC_RESETS_PER_REG	32
 #define NPCM_MASK_RESETS	GENMASK(4, 0)
 
+enum {
+	BMC_NPCM7XX = 0,
+	BMC_NPCM8XX,
+};
+
+static const u32 npxm7xx_ipsrst[] = {NPCM_IPSRST1, NPCM_IPSRST2, NPCM_IPSRST3};
+static const u32 npxm8xx_ipsrst[] = {NPCM_IPSRST1, NPCM_IPSRST2, NPCM_IPSRST3,
+	NPCM_IPSRST4};
+
+struct npcm_reset_info {
+	u32 bmc_id;
+	u32 num_ipsrst;
+	const u32 *ipsrst;
+};
+
+static const struct npcm_reset_info npxm7xx_reset_info[] = {
+	{.bmc_id = BMC_NPCM7XX, .num_ipsrst = 3, .ipsrst = npxm7xx_ipsrst}};
+static const struct npcm_reset_info npxm8xx_reset_info[] = {
+	{.bmc_id = BMC_NPCM8XX, .num_ipsrst = 4, .ipsrst = npxm8xx_ipsrst}};
+
 struct npcm_rc_data {
 	struct reset_controller_dev rcdev;
 	struct notifier_block restart_nb;
+	const struct npcm_reset_info *info;
+	struct regmap *gcr_regmap;
 	u32 sw_reset_number;
 	void __iomem *base;
 	spinlock_t lock;
@@ -120,14 +153,24 @@ static int npcm_rc_status(struct reset_controller_dev *rcdev,
 static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
 			    const struct of_phandle_args *reset_spec)
 {
+	struct npcm_rc_data *rc = to_rc_data(rcdev);
 	unsigned int offset, bit;
+	bool offset_found = false;
+	int off_num;
 
 	offset = reset_spec->args[0];
-	if (offset != NPCM_IPSRST1 && offset != NPCM_IPSRST2 &&
-	    offset != NPCM_IPSRST3) {
+	for (off_num = 0 ; off_num < rc->info->num_ipsrst ; off_num++) {
+		if (offset == rc->info->ipsrst[off_num]) {
+			offset_found = true;
+			break;
+		}
+	}
+
+	if (!offset_found) {
 		dev_err(rcdev->dev, "Error reset register (0x%x)\n", offset);
 		return -EINVAL;
 	}
+
 	bit = reset_spec->args[1];
 	if (bit >= NPCM_RC_RESETS_PER_REG) {
 		dev_err(rcdev->dev, "Error reset number (%d)\n", bit);
@@ -138,44 +181,29 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
 }
 
 static const struct of_device_id npcm_rc_match[] = {
-	{ .compatible = "nuvoton,npcm750-reset"},
+	{ .compatible = "nuvoton,npcm750-reset", .data = &npxm7xx_reset_info},
+	{ .compatible = "nuvoton,npcm845-reset", .data = &npxm8xx_reset_info},
 	{ }
 };
 
-/*
- *  The following procedure should be observed in USB PHY, USB device and
- *  USB host initialization at BMC boot
- */
-static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
+static void npcm_usb_reset_npcm7xx(struct npcm_rc_data *rc)
 {
 	u32 mdlr, iprst1, iprst2, iprst3;
-	struct device *dev = &pdev->dev;
-	struct regmap *gcr_regmap;
 	u32 ipsrst1_bits = 0;
 	u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
 	u32 ipsrst3_bits = 0;
 
-	gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "nuvoton,sysgcr");
-	if (IS_ERR(gcr_regmap)) {
-		dev_warn(&pdev->dev, "Failed to find nuvoton,sysgcr search for nuvoton,npcm750-gcr for Poleg backward compatibility");
-		gcr_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
-		if (IS_ERR(gcr_regmap)) {
-			dev_err(&pdev->dev, "Failed to find nuvoton,npcm750-gcr");
-			return PTR_ERR(gcr_regmap);
-		}
-	}
-
 	/* checking which USB device is enabled */
-	regmap_read(gcr_regmap, NPCM_MDLR_OFFSET, &mdlr);
-	if (!(mdlr & NPCM_MDLR_USBD0))
+	regmap_read(rc->gcr_regmap, NPCM_MDLR_OFFSET, &mdlr);
+	if (!(mdlr & NPCM7XX_MDLR_USBD0))
 		ipsrst3_bits |= NPCM_IPSRST3_USBD0;
-	if (!(mdlr & NPCM_MDLR_USBD1))
+	if (!(mdlr & NPCM7XX_MDLR_USBD1))
 		ipsrst1_bits |= NPCM_IPSRST1_USBD1;
-	if (!(mdlr & NPCM_MDLR_USBD2_4))
+	if (!(mdlr & NPCM7XX_MDLR_USBD2_4))
 		ipsrst1_bits |= (NPCM_IPSRST1_USBD2 |
 				 NPCM_IPSRST1_USBD3 |
 				 NPCM_IPSRST1_USBD4);
-	if (!(mdlr & NPCM_MDLR_USBD0)) {
+	if (!(mdlr & NPCM7XX_MDLR_USBD0)) {
 		ipsrst1_bits |= (NPCM_IPSRST1_USBD5 |
 				 NPCM_IPSRST1_USBD6);
 		ipsrst3_bits |= (NPCM_IPSRST3_USBD7 |
@@ -198,9 +226,9 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 	writel(iprst3, rc->base + NPCM_IPSRST3);
 
 	/* clear USB PHY RS bit */
-	regmap_update_bits(gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
 			   NPCM_USBXPHYCTL_RS, 0);
-	regmap_update_bits(gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
 			   NPCM_USBXPHYCTL_RS, 0);
 
 	/* deassert reset USB PHY */
@@ -210,19 +238,130 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 	udelay(50);
 
 	/* set USB PHY RS bit */
-	regmap_update_bits(gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
+
+	/* deassert reset USB devices*/
+	iprst1 &= ~ipsrst1_bits;
+	iprst2 &= ~ipsrst2_bits;
+	iprst3 &= ~ipsrst3_bits;
+
+	writel(iprst1, rc->base + NPCM_IPSRST1);
+	writel(iprst2, rc->base + NPCM_IPSRST2);
+	writel(iprst3, rc->base + NPCM_IPSRST3);
+}
+
+static void npcm_usb_reset_npcm8xx(struct npcm_rc_data *rc)
+{
+	u32 mdlr, iprst1, iprst2, iprst3, iprst4;
+	u32 ipsrst1_bits = 0;
+	u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
+	u32 ipsrst3_bits = 0;
+	u32 ipsrst4_bits = NPCM_IPSRST4_USB_HOST2 | NPCM_IPSRST4_USBPHY3;
+
+	/* checking which USB device is enabled */
+	regmap_read(rc->gcr_regmap, NPCM_MDLR_OFFSET, &mdlr);
+	if (!(mdlr & NPCM8XX_MDLR_USBD0_3)) {
+		ipsrst3_bits |= NPCM_IPSRST3_USBD0;
+		ipsrst1_bits |= (NPCM_IPSRST1_USBD1 |
+				 NPCM_IPSRST1_USBD2 |
+				 NPCM_IPSRST1_USBD3);
+	}
+	if (!(mdlr & NPCM8XX_MDLR_USBD4_7)) {
+		ipsrst1_bits |= (NPCM_IPSRST1_USBD4 |
+				 NPCM_IPSRST1_USBD5 |
+				 NPCM_IPSRST1_USBD6);
+		ipsrst3_bits |= NPCM_IPSRST3_USBD7;
+	}
+
+	if (!(mdlr & NPCM8XX_MDLR_USBD8))
+		ipsrst3_bits |= NPCM_IPSRST3_USBD8;
+	if (!(mdlr & NPCM8XX_MDLR_USBD9))
+		ipsrst3_bits |= NPCM_IPSRST3_USBD9;
+
+	/* assert reset USB PHY and USB devices */
+	iprst1 = readl(rc->base + NPCM_IPSRST1);
+	iprst2 = readl(rc->base + NPCM_IPSRST2);
+	iprst3 = readl(rc->base + NPCM_IPSRST3);
+	iprst4 = readl(rc->base + NPCM_IPSRST4);
+
+	iprst1 |= ipsrst1_bits;
+	iprst2 |= ipsrst2_bits;
+	iprst3 |= (ipsrst3_bits | NPCM_IPSRST3_USBPHY1 |
+		   NPCM_IPSRST3_USBPHY2);
+	iprst2 |= ipsrst4_bits;
+
+	writel(iprst1, rc->base + NPCM_IPSRST1);
+	writel(iprst2, rc->base + NPCM_IPSRST2);
+	writel(iprst3, rc->base + NPCM_IPSRST3);
+	writel(iprst4, rc->base + NPCM_IPSRST4);
+
+	/* clear USB PHY RS bit */
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, 0);
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, 0);
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB3PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, 0);
+
+	/* deassert reset USB PHY */
+	iprst3 &= ~(NPCM_IPSRST3_USBPHY1 | NPCM_IPSRST3_USBPHY2);
+	writel(iprst3, rc->base + NPCM_IPSRST3);
+	iprst4 &= ~NPCM_IPSRST4_USBPHY3;
+	writel(iprst4, rc->base + NPCM_IPSRST4);
+
+	/* set USB PHY RS bit */
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
 			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
-	regmap_update_bits(gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB3PHYCTL_OFFSET,
 			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
 
 	/* deassert reset USB devices*/
 	iprst1 &= ~ipsrst1_bits;
 	iprst2 &= ~ipsrst2_bits;
 	iprst3 &= ~ipsrst3_bits;
+	iprst4 &= ~ipsrst4_bits;
 
 	writel(iprst1, rc->base + NPCM_IPSRST1);
 	writel(iprst2, rc->base + NPCM_IPSRST2);
 	writel(iprst3, rc->base + NPCM_IPSRST3);
+	writel(iprst4, rc->base + NPCM_IPSRST4);
+}
+
+/*
+ *  The following procedure should be observed in USB PHY, USB device and
+ *  USB host initialization at BMC boot
+ */
+static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
+{
+	struct device *dev = &pdev->dev;
+
+	rc->gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "nuvoton,sysgcr");
+	if (IS_ERR(rc->gcr_regmap)) {
+		dev_warn(&pdev->dev, "Failed to find nuvoton,sysgcr search for nuvoton,npcm750-gcr for Poleg backward compatibility");
+		rc->gcr_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
+		if (IS_ERR(rc->gcr_regmap)) {
+			dev_err(&pdev->dev, "Failed to find nuvoton,npcm750-gcr");
+			return PTR_ERR(rc->gcr_regmap);
+		}
+	}
+
+	rc->info = (const struct npcm_reset_info *)
+			of_match_device(dev->driver->of_match_table, dev)->data;
+	switch (rc->info->bmc_id) {
+	case BMC_NPCM7XX:
+		npcm_usb_reset_npcm7xx(rc);
+		break;
+	case BMC_NPCM8XX:
+		npcm_usb_reset_npcm8xx(rc);
+		break;
+	default:
+		return -ENODEV;
+	}
 
 	return 0;
 }
-- 
2.33.0

