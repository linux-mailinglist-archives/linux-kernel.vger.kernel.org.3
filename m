Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574C352ECAC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiETMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349583AbiETMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:51:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54F233EB7;
        Fri, 20 May 2022 05:51:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2FCEC1F462BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653051103;
        bh=+QRSBoHse5q7vPQRO55UEJJKcrFXryf2svvX8jsupyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyuFBTkF79eteyDMwSvah/A/pUA/vOcE7Odgz8r6BhXRK6hrW4k+16RLhosbjd9iw
         sYXMKW2rJ06URdIX95Ij2XiLt46P0mgFIGFcv8nCW/DtOD/8SJZ8kPDJUlZyIozsGn
         q9ELUgVAztunisXSOuwaAh3XMxPP6qBAXLDAxhfVtI8z5YOUqAj0s5vRcqYbr/X32k
         VKsS4ZKjzi7KhNdb3+Ox0J5Uk8PqdDbzjCpc9srFjG6coI9jArqLKqWcTgSYkPbc5a
         he2RXHy0IsF8j2c0M62lBmRfyDxbvXJMtMUHVR1WrXjEenJvrYwFPeTX7SQqFbBQ5Y
         i3o6DFns8xLTA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: mtk-pmic-keys - Transfer per-key bit in mtk_pmic_keys_regs
Date:   Fri, 20 May 2022 14:51:30 +0200
Message-Id: <20220520125132.229191-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place the key bit in struct mtk_pmic_keys_regs to enhance this
driver's flexibility, in preparation for adding support for more
PMICs.

While at it, also remove the *_MASK and *_SHIFT definitions, as
these can be simply expressed as BIT(x), and "slightly rename"
the MTK_PMIC_{HOME,PWR}KEY_RST macro to better reflect the real
name for these bits.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 46 ++++++++++++++------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 83d0b90cc8cb..d8285612265f 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -18,17 +18,11 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
-#define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
-#define MTK_PMIC_HOMEKEY_RST_EN_MASK	0x1
-#define MTK_PMIC_HOMEKEY_RST_EN_SHIFT	5
 #define MTK_PMIC_RST_DU_MASK		0x3
 #define MTK_PMIC_RST_DU_SHIFT		8
 
-#define MTK_PMIC_PWRKEY_RST		\
-	(MTK_PMIC_PWRKEY_RST_EN_MASK << MTK_PMIC_PWRKEY_RST_EN_SHIFT)
-#define MTK_PMIC_HOMEKEY_RST		\
-	(MTK_PMIC_HOMEKEY_RST_EN_MASK << MTK_PMIC_HOMEKEY_RST_EN_SHIFT)
+#define MTK_PMIC_MT6397_HOMEKEY_RST_EN	BIT(5)
+#define MTK_PMIC_MT6397_PWRKEY_RST_EN	BIT(6)
 
 #define MTK_PMIC_PWRKEY_INDEX	0
 #define MTK_PMIC_HOMEKEY_INDEX	1
@@ -40,21 +34,24 @@
  * @deb_mask:            Bitmask of this key in status register
  * @intsel_reg:          Interrupt selector register
  * @intsel_mask:         Bitmask of this key in interrupt selector
+ * @rst_en_mask:         Bitmask of this key in PMIC keys reset register
  */
 struct mtk_pmic_keys_regs {
 	u32 deb_reg;
 	u32 deb_mask;
 	u32 intsel_reg;
 	u32 intsel_mask;
+	u32 rst_en_mask;
 };
 
 #define MTK_PMIC_KEYS_REGS(_deb_reg, _deb_mask,		\
-	_intsel_reg, _intsel_mask)			\
+	_intsel_reg, _intsel_mask, _rst_mask)		\
 {							\
 	.deb_reg		= _deb_reg,		\
 	.deb_mask		= _deb_mask,		\
 	.intsel_reg		= _intsel_reg,		\
 	.intsel_mask		= _intsel_mask,		\
+	.rst_en_mask		= _rst_mask,		\
 }
 
 /**
@@ -70,30 +67,32 @@ struct mtk_pmic_regs {
 static const struct mtk_pmic_regs mt6397_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6397_CHRSTATUS,
-		0x8, MT6397_INT_RSV, 0x10),
+		0x8, MT6397_INT_RSV, 0x10, MTK_PMIC_MT6397_PWRKEY_RST_EN),
 	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
-		0x10, MT6397_INT_RSV, 0x8),
+		0x10, MT6397_INT_RSV, 0x8, MTK_PMIC_MT6397_HOMEKEY_RST_EN),
 	.pmic_rst_reg = MT6397_TOP_RST_MISC,
 };
 
 static const struct mtk_pmic_regs mt6323_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
-		0x2, MT6323_INT_MISC_CON, 0x10),
+		0x2, MT6323_INT_MISC_CON, 0x10, MTK_PMIC_MT6397_PWRKEY_RST_EN),
 	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
-		0x4, MT6323_INT_MISC_CON, 0x8),
+		0x4, MT6323_INT_MISC_CON, 0x8, MTK_PMIC_MT6397_HOMEKEY_RST_EN),
 	.pmic_rst_reg = MT6323_TOP_RST_MISC,
 };
 
 static const struct mtk_pmic_regs mt6358_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
-				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5),
+				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5,
+				   MTK_PMIC_MT6397_PWRKEY_RST_EN),
 	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
-				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa),
+				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
+				   MTK_PMIC_MT6397_HOMEKEY_RST_EN),
 	.pmic_rst_reg = MT6358_TOP_RST_MISC,
 };
 
@@ -140,6 +139,11 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
 {
 	int ret;
 	u32 long_press_mode, long_press_debounce;
+	const struct mtk_pmic_keys_regs *kregs_pwr;
+	const struct mtk_pmic_keys_regs *kregs_home;
+
+	kregs_pwr = keys->keys[MTK_PMIC_PWRKEY_INDEX].regs;
+	kregs_home = keys->keys[MTK_PMIC_HOMEKEY_INDEX].regs;
 
 	ret = of_property_read_u32(keys->dev->of_node,
 		"power-off-time-sec", &long_press_debounce);
@@ -157,16 +161,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
 
 	switch (long_press_mode) {
 	case LP_ONEKEY:
-		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
-		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
+		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
+		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
 		break;
 	case LP_TWOKEY:
-		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
-		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
+		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
+		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
 		break;
 	case LP_DISABLE:
-		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
-		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
+		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
+		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
 		break;
 	default:
 		break;
-- 
2.35.1

