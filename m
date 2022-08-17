Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF274596D88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiHQL2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHQL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:28:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DFF3ECE1;
        Wed, 17 Aug 2022 04:28:47 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:60d6:460b:e0dc:41ba])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DBDD66016B7;
        Wed, 17 Aug 2022 12:28:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660735725;
        bh=UeD9LKoISKrO+nXV/BN1UsrQ0MC+VColES2tNfzcAwc=;
        h=From:To:Cc:Subject:Date:From;
        b=XG7/FagfRvq8yNoHni9iiKw2u8OlWaxRIrFWKENKLC3k5XplbMWUpUtvWjrMqYYEY
         5MDOELZIQnwc6JvpvKouRxlcueoCSZAoFl+85wFlmOzGGd/3x1o2s0Emyt1l48W7XX
         NJovL/7zI8IH7ah+RsLVGH3Kbc/HsEbgKeCHXpgA41X5pGelcLySknCqd1GHzXy9VX
         jyJSnP9ELpvtvNwP3uvbvw29fvg6FkljnqKf167DH5EWPzl1419gv7ynPOBDCC5X8G
         2Xi9dIluM9QtpaOrsDFlWsBUo9n10agkJargKMIUTrs3C/xUZONNd/9ryi1WPlNmZ/
         c/XY3DlG1VVrw==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] gpio: pca953x: Support for pcal6534
Date:   Wed, 17 Aug 2022 12:28:17 +0100
Message-Id: <20220817112818.787771-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcal6534[1] is a 34-bit I/O expander with more than a passing
resemblance to the pcal6524[2] currently supported by the gpio-pca953x
driver, however whilst the registers seem to functionally match
perfectly, the alignment of the register banks in the chips address
space do not follow the pattern expected by the existing driver. For
instance, as the chip provides 34 I/O, which requires bannks of 5 8-bit
registers to provide input state, output state, etc. as do the 40 I/O
variants, however the 40 I/O variants layout the banks of registers on
8-byte boundaries, whilst the pcal6534 does not space out the banks at
all. Additionally the extended functionality starts at 30h rather than
40h and I suspect there will be other similar differences that I've not
yet discovered.

I suspect that this may add some additional complexity to the driver and
I'm not sure whether this will be welcome. I've done a few cursory
searches to see if there are other chips which follow the pattern of the
pcal6534 and have so far only found the pi4ioe5v6534q[3], which appears
to be funcitonaly identical to the pcal6534.

I'm currently wondering whether a submission to extend the pcal6534
is likely to be deemed acceptable. If so whether something like the
attached approach would be OK, or whether anyone has better ideas on how
to achieve this. Alternatively I'd be happy to create a new driver to
support the pcal6534 if that's deemed more appropriate.

[1] https://www.nxp.com/docs/en/data-sheet/PCAL6534.pdf
[2] https://www.nxp.com/docs/en/data-sheet/PCAL6524.pdf
[3] https://www.diodes.com/assets/Datasheets/PI4IOE5V6534Q.pdf

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Just to note that I'm currently awaiting delivery if hardware, so the
below patch is not just incomplete, it also untested.

 drivers/gpio/gpio-pca953x.c | 46 ++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index ecd7d169470b..413bcda68935 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -68,6 +68,8 @@
 #define PCA957X_TYPE		BIT(13)
 #define PCA_TYPE_MASK		GENMASK(15, 12)
 
+#define PCAL6534_ALIGN		BIT(16)
+
 #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
 
 static const struct i2c_device_id pca953x_id[] = {
@@ -91,6 +93,7 @@ static const struct i2c_device_id pca953x_id[] = {
 
 	{ "pcal6416", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal6524", 24 | PCA953X_TYPE | PCA_LATCH_INT, },
+	{ "pcal6534", 34 | PCA953X_TYPE | PCA_LATCH_INT | PCAL6534_ALIGN, },
 	{ "pcal9535", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9554b", 8  | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9555a", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
@@ -107,6 +110,8 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "tca9539", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "tca9554", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "xra1202", 8  | PCA953X_TYPE },
+
+	{ "pi4ioe5v6534q", 34 | PCA953X_TYPE | PCA_LATCH_INT | PCAL6534_ALIGN, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pca953x_id);
@@ -266,10 +271,19 @@ static int pca953x_bank_shift(struct pca953x_chip *chip)
 static bool pca953x_check_register(struct pca953x_chip *chip, unsigned int reg,
 				   u32 checkbank)
 {
-	int bank_shift = pca953x_bank_shift(chip);
-	int bank = (reg & REG_ADDR_MASK) >> bank_shift;
-	int offset = reg & (BIT(bank_shift) - 1);
+	int bank;
+	int offset;
+
+	if (chip->driver_data & PCAL6534_ALIGN) {
+		bank = (reg & REG_ADDR_MASK) / NBANK(chip);
+		offset = reg - (bank * NBANK(chip));
+	} else {
+		int bank_shift = pca953x_bank_shift(chip);
+		bank = (reg & REG_ADDR_MASK) >> bank_shift;
+		offset = reg & (BIT(bank_shift) - 1);
+	}
 
+	/* TODO: This needs looking at for PCAL6534 */
 	/* Special PCAL extended register check. */
 	if (reg & REG_ADDR_EXT) {
 		if (!(chip->driver_data & PCA_PCAL))
@@ -381,10 +395,20 @@ static const struct regmap_config pca953x_ai_i2c_regmap = {
 
 static u8 pca953x_recalc_addr(struct pca953x_chip *chip, int reg, int off)
 {
-	int bank_shift = pca953x_bank_shift(chip);
-	int addr = (reg & PCAL_GPIO_MASK) << bank_shift;
-	int pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;
-	u8 regaddr = pinctrl | addr | (off / BANK_SZ);
+	int bank_shift;
+	int addr;
+	int pinctrl;
+	u8 regaddr;
+
+	if (chip->driver_data & PCAL6534_ALIGN) {
+		addr = (reg & PCAL_GPIO_MASK) * NBANK(chip);
+	} else {
+		bank_shift = pca953x_bank_shift(chip);
+		addr = (reg & PCAL_GPIO_MASK) << bank_shift;
+	}
+	/* TODO: Do we need to handle the pinctrl offset differently for pcal6534? */
+	pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;
+	regaddr = pinctrl | addr | (off / BANK_SZ);
 
 	return regaddr;
 }
@@ -395,8 +419,11 @@ static int pca953x_write_regs(struct pca953x_chip *chip, int reg, unsigned long
 	u8 value[MAX_BANK];
 	int i, ret;
 
-	for (i = 0; i < NBANK(chip); i++)
+	for (i = 0; i < NBANK(chip); i++) {
 		value[i] = bitmap_get_value8(val, i * BANK_SZ);
+		dev_err(&chip->client->dev, "value[%d] = %x\n", i, value[i]);
+	}
+	dev_err(&chip->client->dev, "regaddr: %x\n", regaddr);
 
 	ret = regmap_bulk_write(chip->regmap, regaddr, value, NBANK(chip));
 	if (ret < 0) {
@@ -1239,6 +1266,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 
 	{ .compatible = "nxp,pcal6416", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_LATCH_INT), },
+	{ .compatible = "nxp,pcal6534", .data = OF_953X(34, PCA_LATCH_INT | PCAL6534_ALIGN), },
 	{ .compatible = "nxp,pcal9535", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9554b", .data = OF_953X( 8, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_LATCH_INT), },
@@ -1261,6 +1289,8 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "onnn,pca9655", .data = OF_953X(16, PCA_INT), },
 
 	{ .compatible = "exar,xra1202", .data = OF_953X( 8, 0), },
+
+	{ .compatible = "diodes,pi4ioe5v6534q", .data = OF_953X(34, PCA_LATCH_INT | PCAL6534_ALIGN), },
 	{ }
 };
 
-- 
2.35.1

