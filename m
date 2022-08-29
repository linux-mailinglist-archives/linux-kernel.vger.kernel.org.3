Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4CA5A4E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiH2Njz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiH2Njl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:39:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9B91D02;
        Mon, 29 Aug 2022 06:39:38 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:c9c8:35ca:a27e:68d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1ECC56601D96;
        Mon, 29 Aug 2022 14:39:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661780377;
        bh=tqK6VyVv7nQ6cJ2oC9czqWTr/HZRWOMBA23Gw1mUxZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAE3AOYC+gswFsAlwxgQqkMa7Lu5QAHgau0zckD6S5UGl55KH8KJSEcD5SpbssP4M
         IkP6bqXULyUnIlOuZsRMef7Jlql32uyM3YsVrKws4rirXCs/3kgOGyQPQASP31FmtN
         HK2hnn63rNgkEc7bP/1XluHqJ4FrtUpO8al2JC29OyxlcUBQ99njxhVCga7UkUZ2S9
         PMORd5qLhLxtrf4smDspvEpWT9n1U58ZfVGoNniqDuTwz4SO8tFEx+29qc7SXGzK82
         hrKRlIGM0D6Ps2KQWAMNRPbuaUoxRp/nEHt8saKjFKZILZ5MnC9aYoU8Ox5AQGCSbB
         EMNtb8wxQbcWA==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] gpio: pca953x: Add support for PCAL6534 and compatible
Date:   Mon, 29 Aug 2022 14:39:22 +0100
Message-Id: <20220829133923.1114555-5-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829133923.1114555-1-martyn.welch@collabora.com>
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the NXP PCAL6534 and Diodes Inc. PI4IOE5V6534Q. These
devices, which have identical register layouts and features, are broadly a
34-bit version of the PCAL6524.

However, whilst the registers are broadly what you'd expect for a 34-bit
version of the PCAL6524, the spacing of the registers has been
compacted. This has the unfortunate effect of breaking the bit shift
based mechanism that is employed to work out register locations used by
the other chips supported by this driver, resulting in special handling
needing to be introduced in pca953x_recalc_addr() and
pca953x_check_register().

Datasheet: https://www.nxp.com/docs/en/data-sheet/PCAL6534.pdf
Datasheet: https://www.diodes.com/assets/Datasheets/PI4IOE5V6534Q.pdf
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 drivers/gpio/gpio-pca953x.c | 101 +++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 19a8eb94a629..ef1f0a603007 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -66,8 +66,10 @@
 #define PCA_LATCH_INT		(PCA_PCAL | PCA_INT)
 #define PCA953X_TYPE		BIT(12)
 #define PCA957X_TYPE		BIT(13)
+#define PCAL653X_TYPE		BIT(14)
 #define PCA_TYPE_MASK		GENMASK(15, 12)
 
+
 #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
 
 static const struct i2c_device_id pca953x_id[] = {
@@ -91,6 +93,7 @@ static const struct i2c_device_id pca953x_id[] = {
 
 	{ "pcal6416", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal6524", 24 | PCA953X_TYPE | PCA_LATCH_INT, },
+	{ "pcal6534", 34 | PCAL653X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9535", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9554b", 8  | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9555a", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
@@ -107,6 +110,8 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "tca9539", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "tca9554", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "xra1202", 8  | PCA953X_TYPE },
+
+	{ "pi4ioe5v6534q", 34 | PCAL653X_TYPE | PCA_LATCH_INT, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pca953x_id);
@@ -261,20 +266,56 @@ static int pca953x_bank_shift(struct pca953x_chip *chip)
  * - Registers with bit 0x80 set, the AI bit
  *   The bit is cleared and the registers fall into one of the
  *   categories above.
+ *
+ *   Unfortunately, whilst the PCAL6534 chip (and compatibles) broadly follow
+ *   the same register layout as the PCAL6524, the spacing of the registers has
+ *   been fundamentally altered by compacting them and thus does not obey the
+ *   same rules, including being able to use bit shifting to determine bank.
+ *   These chips hence need special handling here.
  */
 
 static bool pca953x_check_register(struct pca953x_chip *chip, unsigned int reg,
 				   u32 checkbank)
 {
-	int bank_shift = pca953x_bank_shift(chip);
-	int bank = (reg & REG_ADDR_MASK) >> bank_shift;
-	int offset = reg & (BIT(bank_shift) - 1);
+	int bank;
+	int offset;
+
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCAL653X_TYPE) {
+		if (reg > 0x2f) {
+			/*
+			 * Reserved block between 14h and 2Fh does not align on
+			 * expected bank boundaries like other devices.
+			 */
+			int temp = reg - 0x30;
+
+			bank = temp / NBANK(chip);
+			offset = temp - (bank * NBANK(chip));
+			bank += 8;
+		} else if (reg > 0x53) {
+			/* Handle lack of reserved registers after output port
+			 * configuration register to form a bank.
+			 */
+			int temp = reg - 0x54;
+
+			bank = temp / NBANK(chip);
+			offset = temp - (bank * NBANK(chip));
+			bank += 16;
+		} else {
+			bank = reg / NBANK(chip);
+			offset = reg - (bank * NBANK(chip));
+		}
+	} else {
+		int bank_shift = pca953x_bank_shift(chip);
 
-	/* Special PCAL extended register check. */
-	if (reg & REG_ADDR_EXT) {
-		if (!(chip->driver_data & PCA_PCAL))
-			return false;
-		bank += 8;
+		bank = (reg & REG_ADDR_MASK) >> bank_shift;
+		offset = reg & (BIT(bank_shift) - 1);
+
+		/* Special PCAL extended register check. */
+		if (reg & REG_ADDR_EXT) {
+			if (!(chip->driver_data & PCA_PCAL))
+				return false;
+			bank += 8;
+		}
 	}
 
 	/* Register is not in the matching bank. */
@@ -381,10 +422,42 @@ static const struct regmap_config pca953x_ai_i2c_regmap = {
 
 static u8 pca953x_recalc_addr(struct pca953x_chip *chip, int reg, int off)
 {
-	int bank_shift = pca953x_bank_shift(chip);
-	int addr = (reg & PCAL_GPIO_MASK) << bank_shift;
-	int pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;
-	u8 regaddr = pinctrl | addr | (off / BANK_SZ);
+	int addr;
+	int pinctrl;
+	u8 regaddr;
+
+	if (PCA_CHIP_TYPE(chip->driver_data) == PCAL653X_TYPE) {
+		/* The PCAL6534 and compatible chips have altered bank alignment that doesn't
+		 * fit within the bit shifting scheme used for other devices.
+		 */
+		addr = (reg & PCAL_GPIO_MASK) * NBANK(chip);
+
+		switch (reg) {
+		case PCAL953X_OUT_STRENGTH:
+		case PCAL953X_IN_LATCH:
+		case PCAL953X_PULL_EN:
+		case PCAL953X_PULL_SEL:
+		case PCAL953X_INT_MASK:
+		case PCAL953X_INT_STAT:
+		case PCAL953X_OUT_CONF:
+			pinctrl = ((reg & PCAL_PINCTRL_MASK) >> 1) + 0x20;
+			break;
+		case PCAL6524_INT_EDGE:
+		case PCAL6524_INT_CLR:
+		case PCAL6524_IN_STATUS:
+		case PCAL6524_OUT_INDCONF:
+		case PCAL6524_DEBOUNCE:
+			pinctrl = ((reg & PCAL_PINCTRL_MASK) >> 1) + 0x1c;
+			break;
+		}
+		regaddr = pinctrl + addr + (off / BANK_SZ);
+	} else {
+		int bank_shift = pca953x_bank_shift(chip);
+
+		addr = (reg & PCAL_GPIO_MASK) << bank_shift;
+		pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;
+		regaddr = pinctrl | addr | (off / BANK_SZ);
+	}
 
 	return regaddr;
 }
@@ -1215,6 +1288,7 @@ static int pca953x_resume(struct device *dev)
 #endif
 
 /* convenience to stop overlong match-table lines */
+#define OF_653X(__nrgpio, __int) ((void *)(__nrgpio | PCAL653X_TYPE | __int))
 #define OF_953X(__nrgpio, __int) (void *)(__nrgpio | PCA953X_TYPE | __int)
 #define OF_957X(__nrgpio, __int) (void *)(__nrgpio | PCA957X_TYPE | __int)
 
@@ -1239,6 +1313,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 
 	{ .compatible = "nxp,pcal6416", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_LATCH_INT), },
+	{ .compatible = "nxp,pcal6534", .data = OF_653X(34, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9535", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9554b", .data = OF_953X( 8, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_LATCH_INT), },
@@ -1261,6 +1336,8 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "onnn,pca9655", .data = OF_953X(16, PCA_INT), },
 
 	{ .compatible = "exar,xra1202", .data = OF_953X( 8, 0), },
+
+	{ .compatible = "diodes,pi4ioe5v6534q", .data = OF_653X(34, PCA_LATCH_INT), },
 	{ }
 };
 
-- 
2.35.1

