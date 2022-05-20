Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05B52ECAB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349629AbiETMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349591AbiETMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:51:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571143B283;
        Fri, 20 May 2022 05:51:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BFF531F462BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653051104;
        bh=82AzsQEjRUi2HwF6h/SdIW38pOVcKxedGJa6T0RPfFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNowLvhoAMnRbvtEzS6N8rshccKOmDp/1c46XxhXb+GF6xzaC/Xa68snSNt6zIVok
         IwURp1T3eMi4Ytuq304dXgSTClvDfH5VVrVRNANxX8bkea8RZ1UfmqIEH7DjLmcuJv
         ajjcJsQLBS0hx9FIcNzYb3zVby+5Wr97ilxs4wIX4WiMNRTk70bjpzK/sKQwBXT9wH
         BTexZLr3mOUR5A3QOTM9ldzdeZJ1c59mBQxj0DIrcVImvm1/9mrPLw/CVnF9Tm8sU3
         AT7eP96cXjSLW/+U+0kwbX/zOrugY743STRUe1v6mWyAEFJ6gU24sQjibGDVb/KECt
         Hn+uxc5F/tDZg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Input: mtk-pmic-keys - Move long press debounce mask to mtk_pmic_regs
Date:   Fri, 20 May 2022 14:51:31 +0200
Message-Id: <20220520125132.229191-5-angelogioacchino.delregno@collabora.com>
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

As the second and last step of preparation to add support for more
PMICs in this driver, move the long press debounce mask to struct
mtk_pmic_regs and use that in mtk_pmic_keys_lp_reset_setup() instead
of directly using the definition.

While at it, remove the MTK_PMIC_RST_DU_{MASK,SHIFT} definitions, as
these can be expressed with the GENMASK macro and a new name was
chosen for that, as to uniform the definition names with the others
found in this driver.

Lastly, it was necessary to change the function signature of
mtk_pmic_keys_lp_reset_setup() to now pass a pointer to the main
mtk_pmic_regs structure, since that's what contains the reset
debounce mask now and, for readability purposes, for this function,
all of the references to keys->regmap were changed to use a local
'rmap' pointer, or the calls to regmap_{set,clear}_bits would be
~94 columns long.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 33 +++++++++++++++-----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index d8285612265f..acd5aefac5f9 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -18,11 +18,9 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#define MTK_PMIC_RST_DU_MASK		0x3
-#define MTK_PMIC_RST_DU_SHIFT		8
-
 #define MTK_PMIC_MT6397_HOMEKEY_RST_EN	BIT(5)
 #define MTK_PMIC_MT6397_PWRKEY_RST_EN	BIT(6)
+#define MTK_PMIC_MT6397_RST_DU_MASK	GENMASK(9, 8)
 
 #define MTK_PMIC_PWRKEY_INDEX	0
 #define MTK_PMIC_HOMEKEY_INDEX	1
@@ -58,10 +56,12 @@ struct mtk_pmic_keys_regs {
  * struct mtk_pmic_regs - PMIC Keys registers
  * @keys_regs:           Specific key registers
  * @pmic_rst_reg:        PMIC Keys reset register
+ * @rst_lprst_mask:      Long-press reset timeout bitmask
  */
 struct mtk_pmic_regs {
 	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
 	u32 pmic_rst_reg;
+	u32 rst_lprst_mask;
 };
 
 static const struct mtk_pmic_regs mt6397_regs = {
@@ -72,6 +72,7 @@ static const struct mtk_pmic_regs mt6397_regs = {
 		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
 		0x10, MT6397_INT_RSV, 0x8, MTK_PMIC_MT6397_HOMEKEY_RST_EN),
 	.pmic_rst_reg = MT6397_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_MT6397_RST_DU_MASK,
 };
 
 static const struct mtk_pmic_regs mt6323_regs = {
@@ -82,6 +83,7 @@ static const struct mtk_pmic_regs mt6323_regs = {
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
 		0x4, MT6323_INT_MISC_CON, 0x8, MTK_PMIC_MT6397_HOMEKEY_RST_EN),
 	.pmic_rst_reg = MT6323_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_MT6397_RST_DU_MASK,
 };
 
 static const struct mtk_pmic_regs mt6358_regs = {
@@ -94,6 +96,7 @@ static const struct mtk_pmic_regs mt6358_regs = {
 				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
 				   MTK_PMIC_MT6397_HOMEKEY_RST_EN),
 	.pmic_rst_reg = MT6358_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_MT6397_RST_DU_MASK,
 };
 
 /**
@@ -135,24 +138,26 @@ enum mtk_pmic_keys_lp_mode {
 };
 
 static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
-		u32 pmic_rst_reg)
+					 const struct mtk_pmic_regs *regs)
 {
 	int ret;
+	struct regmap *rmap;
 	u32 long_press_mode, long_press_debounce;
 	const struct mtk_pmic_keys_regs *kregs_pwr;
 	const struct mtk_pmic_keys_regs *kregs_home;
 
 	kregs_pwr = keys->keys[MTK_PMIC_PWRKEY_INDEX].regs;
 	kregs_home = keys->keys[MTK_PMIC_HOMEKEY_INDEX].regs;
+	rmap = keys->regmap;
 
 	ret = of_property_read_u32(keys->dev->of_node,
 		"power-off-time-sec", &long_press_debounce);
 	if (ret)
 		long_press_debounce = 0;
 
-	regmap_update_bits(keys->regmap, pmic_rst_reg,
-			   MTK_PMIC_RST_DU_MASK << MTK_PMIC_RST_DU_SHIFT,
-			   long_press_debounce << MTK_PMIC_RST_DU_SHIFT);
+	regmap_update_bits(rmap, regs->pmic_rst_reg,
+			   regs->rst_lprst_mask,
+			   long_press_debounce << ffs(regs->rst_lprst_mask));
 
 	ret = of_property_read_u32(keys->dev->of_node,
 		"mediatek,long-press-mode", &long_press_mode);
@@ -161,16 +166,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
 
 	switch (long_press_mode) {
 	case LP_ONEKEY:
-		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
-		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
+		regmap_set_bits(rmap, regs->pmic_rst_reg, kregs_pwr->rst_en_mask);
+		regmap_clear_bits(rmap, regs->pmic_rst_reg, kregs_home->rst_en_mask);
 		break;
 	case LP_TWOKEY:
-		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
-		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
+		regmap_set_bits(rmap, regs->pmic_rst_reg, kregs_pwr->rst_en_mask);
+		regmap_set_bits(rmap, regs->pmic_rst_reg, kregs_home->rst_en_mask);
 		break;
 	case LP_DISABLE:
-		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
-		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
+		regmap_clear_bits(rmap, regs->pmic_rst_reg, kregs_pwr->rst_en_mask);
+		regmap_clear_bits(rmap, regs->pmic_rst_reg, kregs_home->rst_en_mask);
 		break;
 	default:
 		break;
@@ -378,7 +383,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs->pmic_rst_reg);
+	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs);
 
 	platform_set_drvdata(pdev, keys);
 
-- 
2.35.1

