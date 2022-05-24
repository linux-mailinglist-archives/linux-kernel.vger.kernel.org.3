Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E650532687
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiEXJf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiEXJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:35:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA465FF1E;
        Tue, 24 May 2022 02:35:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D11401F42BEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653384913;
        bh=rg+O5GDCFPT74K8q7Q+BQyRmVOj5osZx/xFCPhBlHuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdOeDcJPmzWFsvEE+/BaU4R23GwaCQ12+xxG98ifXPrfHLgn17HL2LEMlmcKthnch
         qDPCGDAVhZpwKVk7JSeeSt4W+u008+NfjdtTgSvX6aONLcZg8YpP3Z9NpFAQ3VKsKC
         S1urtQuqGFfWHeC/k9vlWdR4wr8i3oFUwjS6N5Lx4rOtoCZnBiHKQ32kqMvq/GCKsW
         2QjTKqtbeNBhTw0EgdRKo1FQ1YWFUyr7tIji2uJYjTjPt0Uh7TtA6RTv8+qm7+J2CX
         43AOw/ndKVIGwI5/VaFJx3Zjy88O8uX+8CyKrFONo2wd2g+432QklU4swND6DolHDL
         4aq6t+9je/yGQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] Input: mtk-pmic-keys - Move long press debounce mask to mtk_pmic_regs
Date:   Tue, 24 May 2022 11:35:04 +0200
Message-Id: <20220524093505.85438-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
References: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
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

While at it, remove the definition for MTK_PMIC_RST_DU_SHIFT as we
are able to calculate it dynamically and spares us some unnecessary
new definitions around for future per-PMIC variations of RST_DU_MASK.

Lastly, it was necessary to change the function signature of
mtk_pmic_keys_lp_reset_setup() to now pass a pointer to the main
mtk_pmic_regs structure, since that's where the reset debounce
mask now resides.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 2509a349a173..6404081253ea 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -19,7 +19,6 @@
 #include <linux/regmap.h>
 
 #define MTK_PMIC_RST_DU_MASK	GENMASK(9, 8)
-#define MTK_PMIC_RST_DU_SHIFT	8
 #define MTK_PMIC_PWRKEY_RST	BIT(6)
 #define MTK_PMIC_HOMEKEY_RST	BIT(5)
 
@@ -48,6 +47,7 @@ struct mtk_pmic_keys_regs {
 struct mtk_pmic_regs {
 	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
 	u32 pmic_rst_reg;
+	u32 rst_lprst_mask; /* Long-press reset timeout bitmask */
 };
 
 static const struct mtk_pmic_regs mt6397_regs = {
@@ -58,6 +58,7 @@ static const struct mtk_pmic_regs mt6397_regs = {
 		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
 		0x10, MT6397_INT_RSV, 0x8, MTK_PMIC_HOMEKEY_RST),
 	.pmic_rst_reg = MT6397_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
 static const struct mtk_pmic_regs mt6323_regs = {
@@ -68,6 +69,7 @@ static const struct mtk_pmic_regs mt6323_regs = {
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
 		0x4, MT6323_INT_MISC_CON, 0x8, MTK_PMIC_HOMEKEY_RST),
 	.pmic_rst_reg = MT6323_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
 static const struct mtk_pmic_regs mt6358_regs = {
@@ -80,6 +82,7 @@ static const struct mtk_pmic_regs mt6358_regs = {
 				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
 				   MTK_PMIC_HOMEKEY_RST),
 	.pmic_rst_reg = MT6358_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
 struct mtk_pmic_keys_info {
@@ -105,7 +108,7 @@ enum mtk_pmic_keys_lp_mode {
 };
 
 static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
-					 u32 pmic_rst_reg)
+					 const struct mtk_pmic_regs *regs)
 {
 	const struct mtk_pmic_keys_regs *kregs_home, *kregs_pwr;
 	u32 long_press_mode, long_press_debounce;
@@ -120,8 +123,8 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
 	if (error)
 		long_press_debounce = 0;
 
-	mask = MTK_PMIC_RST_DU_MASK;
-	value = long_press_debounce << MTK_PMIC_RST_DU_SHIFT;
+	mask = regs->rst_lprst_mask;
+	value = long_press_debounce << (ffs(regs->rst_lprst_mask) - 1);
 
 	error  = of_property_read_u32(keys->dev->of_node,
 				      "mediatek,long-press-mode",
@@ -147,7 +150,7 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
 		break;
 	}
 
-	regmap_update_bits(keys->regmap, pmic_rst_reg, mask, value);
+	regmap_update_bits(keys->regmap, regs->pmic_rst_reg, mask, value);
 }
 
 static irqreturn_t mtk_pmic_keys_irq_handler_thread(int irq, void *data)
@@ -351,7 +354,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs->pmic_rst_reg);
+	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs);
 
 	platform_set_drvdata(pdev, keys);
 
-- 
2.35.1

