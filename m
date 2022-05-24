Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB38532682
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiEXJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiEXJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:35:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37305FF3D;
        Tue, 24 May 2022 02:35:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3223E1F42BE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653384912;
        bh=/HUYMQUZzdBAjQXE3aaXZwy4OOxFI8w5rmaGmz21Fek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bam8Hv+/gwV41nT/XOqLQaKPSnGOtK97i9xkzVh/TtlvLEvimHUaivlBprBgN3QGS
         PjGbwHRz2hID4cFt6uOsbEK83LU4au39vdbkn8aIB/eA6lAy3/i4YL+0MIEsT9zDjw
         BnxH0JO+7u99irflF/mGFagkAMFYnhKjkTpe3dyC7yLma+RBX0wli7743MdbgAfVY8
         L8Qc4B59tS3CEfpffYyilrPwcTq8lANrGMJvCipI9rLfmLbqhl2V8cAdjTX1pN9oHD
         uXYxIUVEKTmlOVzp+X0Kcx+PSLuM6R176sb7zlOe3iVXWFjMd3wku9XnNwix50IhEn
         1kM+8PiTObalA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Input: mtk-pmic-keys - Transfer per-key bit in mtk_pmic_keys_regs
Date:   Tue, 24 May 2022 11:35:03 +0200
Message-Id: <20220524093505.85438-2-angelogioacchino.delregno@collabora.com>
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

Place the key bit in struct mtk_pmic_keys_regs to enhance this
driver's flexibility, in preparation for adding support for more
PMICs.

While at it, remove the definition of MTK_PMIC_RST_KEY_MASK as
we are now dynamically setting the keymask relatively to the keys
that are defined in the newly added rst_en_mask variable, on a
per-key basis.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 30 ++++++++++++++++----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index d2f0db245ff6..2509a349a173 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -20,7 +20,6 @@
 
 #define MTK_PMIC_RST_DU_MASK	GENMASK(9, 8)
 #define MTK_PMIC_RST_DU_SHIFT	8
-#define MTK_PMIC_RST_KEY_MASK	GENMASK(6, 5)
 #define MTK_PMIC_PWRKEY_RST	BIT(6)
 #define MTK_PMIC_HOMEKEY_RST	BIT(5)
 
@@ -33,15 +32,17 @@ struct mtk_pmic_keys_regs {
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
 
 struct mtk_pmic_regs {
@@ -52,30 +53,32 @@ struct mtk_pmic_regs {
 static const struct mtk_pmic_regs mt6397_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6397_CHRSTATUS,
-		0x8, MT6397_INT_RSV, 0x10),
+		0x8, MT6397_INT_RSV, 0x10, MTK_PMIC_PWRKEY_RST),
 	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
-		0x10, MT6397_INT_RSV, 0x8),
+		0x10, MT6397_INT_RSV, 0x8, MTK_PMIC_HOMEKEY_RST),
 	.pmic_rst_reg = MT6397_TOP_RST_MISC,
 };
 
 static const struct mtk_pmic_regs mt6323_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
-		0x2, MT6323_INT_MISC_CON, 0x10),
+		0x2, MT6323_INT_MISC_CON, 0x10, MTK_PMIC_PWRKEY_RST),
 	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
-		0x4, MT6323_INT_MISC_CON, 0x8),
+		0x4, MT6323_INT_MISC_CON, 0x8, MTK_PMIC_HOMEKEY_RST),
 	.pmic_rst_reg = MT6323_TOP_RST_MISC,
 };
 
 static const struct mtk_pmic_regs mt6358_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
-				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5),
+				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5,
+				   MTK_PMIC_PWRKEY_RST),
 	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
-				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa),
+				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
+				   MTK_PMIC_HOMEKEY_RST),
 	.pmic_rst_reg = MT6358_TOP_RST_MISC,
 };
 
@@ -104,10 +107,14 @@ enum mtk_pmic_keys_lp_mode {
 static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
 					 u32 pmic_rst_reg)
 {
+	const struct mtk_pmic_keys_regs *kregs_home, *kregs_pwr;
 	u32 long_press_mode, long_press_debounce;
 	u32 value, mask;
 	int error;
 
+	kregs_home = keys->keys[MTK_PMIC_HOMEKEY_INDEX].regs;
+	kregs_pwr = keys->keys[MTK_PMIC_PWRKEY_INDEX].regs;
+
 	error = of_property_read_u32(keys->dev->of_node, "power-off-time-sec",
 				     &long_press_debounce);
 	if (error)
@@ -124,15 +131,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
 
 	switch (long_press_mode) {
 	case LP_TWOKEY:
-		value |= MTK_PMIC_HOMEKEY_RST;
+		value |= kregs_home->rst_en_mask;
 		fallthrough;
 
 	case LP_ONEKEY:
-		value |= MTK_PMIC_PWRKEY_RST;
+		value |= kregs_pwr->rst_en_mask;
 		fallthrough;
 
 	case LP_DISABLE:
-		mask |= MTK_PMIC_RST_KEY_MASK;
+		mask |= kregs_home->rst_en_mask;
+		mask |= kregs_pwr->rst_en_mask;
 		break;
 
 	default:
-- 
2.35.1

