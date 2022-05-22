Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D9530448
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349206AbiEVP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349014AbiEVP63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:58:29 -0400
Received: from herzl.nuvoton.co.il (unknown [212.199.177.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE563B29E;
        Sun, 22 May 2022 08:58:26 -0700 (PDT)
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 24MFp9qj031643;
        Sun, 22 May 2022 18:51:09 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5B95663A4B; Sun, 22 May 2022 18:51:09 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 12/19] reset: npcm: Add NPCM8XX support
Date:   Sun, 22 May 2022 18:50:39 +0300
Message-Id: <20220522155046.260146-13-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220522155046.260146-1-tmaimon77@gmail.com>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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
- Some of the Reset Id and number of resets are
  different from NPCM7XX.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/reset-npcm.c | 157 ++++++++++++++++++++++++++++++-------
 1 file changed, 130 insertions(+), 27 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 0c963b21eddc..8d82a45dd580 100644
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
@@ -49,12 +56,17 @@
 #define NPCM_IPSRST3_USBPHY1	BIT(24)
 #define NPCM_IPSRST3_USBPHY2	BIT(25)
 
+#define NPCM_IPSRST4		0x74
+#define NPCM_IPSRST4_USBPHY3	BIT(25)
+#define NPCM_IPSRST4_USB_HOST2	BIT(31)
+
 #define NPCM_RC_RESETS_PER_REG	32
 #define NPCM_MASK_RESETS	GENMASK(4, 0)
 
 struct npcm_rc_data {
 	struct reset_controller_dev rcdev;
 	struct notifier_block restart_nb;
+	struct regmap *gcr_regmap;
 	u32 sw_reset_number;
 	void __iomem *base;
 	spinlock_t lock;
@@ -124,7 +136,7 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
 
 	offset = reset_spec->args[0];
 	if (offset != NPCM_IPSRST1 && offset != NPCM_IPSRST2 &&
-	    offset != NPCM_IPSRST3) {
+	    offset != NPCM_IPSRST3 && offset != NPCM_IPSRST4) {
 		dev_err(rcdev->dev, "Error reset register (0x%x)\n", offset);
 		return -EINVAL;
 	}
@@ -139,39 +151,28 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
 
 static const struct of_device_id npcm_rc_match[] = {
 	{ .compatible = "nuvoton,npcm750-reset"},
+	{ .compatible = "nuvoton,npcm845-reset"},
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
 
-	gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
-	if (IS_ERR(gcr_regmap)) {
-		dev_err(&pdev->dev, "Failed to find gcr syscon");
-		return PTR_ERR(gcr_regmap);
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
@@ -194,9 +195,9 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 	writel(iprst3, rc->base + NPCM_IPSRST3);
 
 	/* clear USB PHY RS bit */
-	regmap_update_bits(gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
 			   NPCM_USBXPHYCTL_RS, 0);
-	regmap_update_bits(gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
 			   NPCM_USBXPHYCTL_RS, 0);
 
 	/* deassert reset USB PHY */
@@ -206,9 +207,9 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 	udelay(50);
 
 	/* set USB PHY RS bit */
-	regmap_update_bits(gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
 			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
-	regmap_update_bits(gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
 			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
 
 	/* deassert reset USB devices*/
@@ -219,6 +220,108 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 	writel(iprst1, rc->base + NPCM_IPSRST1);
 	writel(iprst2, rc->base + NPCM_IPSRST2);
 	writel(iprst3, rc->base + NPCM_IPSRST3);
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
+			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
+	regmap_update_bits(rc->gcr_regmap, NPCM_USB3PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
+
+	/* deassert reset USB devices*/
+	iprst1 &= ~ipsrst1_bits;
+	iprst2 &= ~ipsrst2_bits;
+	iprst3 &= ~ipsrst3_bits;
+	iprst4 &= ~ipsrst4_bits;
+
+	writel(iprst1, rc->base + NPCM_IPSRST1);
+	writel(iprst2, rc->base + NPCM_IPSRST2);
+	writel(iprst3, rc->base + NPCM_IPSRST3);
+	writel(iprst4, rc->base + NPCM_IPSRST4);
+}
+
+/*
+ *  The following procedure should be observed in USB PHY, USB device and
+ *  USB host initialization at BMC boot
+ */
+static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+
+	rc->gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
+	if (IS_ERR(rc->gcr_regmap)) {
+		dev_err(&pdev->dev, "Failed to find gcr syscon");
+		return PTR_ERR(rc->gcr_regmap);
+	}
+
+	if (of_device_is_compatible(np, "nuvoton,npcm750-reset"))
+		npcm_usb_reset_npcm7xx(rc);
+	else if (of_device_is_compatible(np, "nuvoton,npcm845-reset"))
+		npcm_usb_reset_npcm8xx(rc);
+	else
+		return -ENODEV;
 
 	return 0;
 }
-- 
2.33.0

