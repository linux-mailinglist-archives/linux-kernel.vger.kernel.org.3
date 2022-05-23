Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C9D530AED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiEWHdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiEWHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:32:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624696353
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:31:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nt2XZ-0002vX-IP; Mon, 23 May 2022 09:31:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nt2XZ-0042OT-Mz; Mon, 23 May 2022 09:31:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nt2XX-003GZz-Qr; Mon, 23 May 2022 09:31:43 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1] spi: imx: mx51-ecspi: fix clk polarity and phase configuration for CS > 4
Date:   Mon, 23 May 2022 09:31:43 +0200
Message-Id: <20220523073143.778664-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix support for boards with more then 4 chip select lines. Other wise if
CS > 4 is used, we will write trash to the clk configuration register.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/spi/spi-imx.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b2dd0a4d2446..2d29b893e9e0 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -265,6 +265,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
 #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
 #define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
+#define MX51_ECSPI_MAX_HW_CS		4
 
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
@@ -515,6 +516,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	u32 min_speed_hz = ~0U;
 	u32 testreg, delay;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
+	int chip_select;
 
 	/* set Master or Slave mode */
 	if (spi_imx->slave_mode)
@@ -528,8 +530,19 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	if (spi->mode & SPI_READY)
 		ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
 
-	/* set chip select to use */
-	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
+	if (spi->cs_gpiod) {
+		chip_select = 0;
+	} else {
+		if (spi->chip_select >= MX51_ECSPI_MAX_HW_CS) {
+			dev_err(spi_imx->dev, "Native chip_select is out of supported range: %i\n",
+				spi->chip_select);
+			return -EINVAL;
+		}
+
+		/* set HW chip select to use */
+		ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
+		chip_select = spi->chip_select;
+	}
 
 	/*
 	 * The ctrl register must be written first, with the EN bit set other
@@ -550,27 +563,27 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * BURST_LENGTH + 1 bits are received
 	 */
 	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
-		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(chip_select);
 	else
-		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(chip_select);
 
 	if (spi->mode & SPI_CPHA)
-		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(chip_select);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(chip_select);
 
 	if (spi->mode & SPI_CPOL) {
-		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
-		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(chip_select);
 	} else {
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(chip_select);
 	}
 
 	if (spi->mode & SPI_CS_HIGH)
-		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SSBPOL(chip_select);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(chip_select);
 
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
-- 
2.30.2

