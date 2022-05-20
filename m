Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7CA52ECA9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349620AbiETMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349566AbiETMvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:51:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F37527DC;
        Fri, 20 May 2022 05:51:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5A8E61F462C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653051104;
        bh=Fo+/ZjhNQoJvd6sqh6rdL7fraQLbd7Rg63FwzQi2DIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YB7ITXrEVoRW5GVcgydo4v1h+1GmiSWeKWfP1BVqjc5eIGbWZodCSo2wIOHHIPyWc
         lv4enyKopzi41y3XDRKn9hqUB31qEGNyYXWaVq0CEfx36dtUhTyJPUJJ/hULINQNJP
         H3xx2lePFETeyOXjFEkCp1YjTuB6ySC3CSzBds7SQLufnzAh2biDibBI3ohn1u+2m+
         Nyb2xFdin1VUV+bkiFZJ53MLKSJnet2aVrsfrikEhxLxrxaJh3Wjn9yD3cMt31tAZD
         RRrsv1SeUP5PuNpnDh5kMu6IE+F0bbhKUaYCWa3+P369ZlyR6/kjW+1bA450O0e/OC
         pkLXGJaeluFrQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Input: mtk-pmic-keys - Add support for MT6331 PMIC keys
Date:   Fri, 20 May 2022 14:51:32 +0200
Message-Id: <20220520125132.229191-6-angelogioacchino.delregno@collabora.com>
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

Add support for PMIC Keys of the MT6331 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index acd5aefac5f9..4a03fdfe8282 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/mt6323/registers.h>
+#include <linux/mfd/mt6331/registers.h>
 #include <linux/mfd/mt6358/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
@@ -22,6 +23,10 @@
 #define MTK_PMIC_MT6397_PWRKEY_RST_EN	BIT(6)
 #define MTK_PMIC_MT6397_RST_DU_MASK	GENMASK(9, 8)
 
+#define MTK_PMIC_MT6331_HOMEKEY_RST_EN	BIT(8)
+#define MTK_PMIC_MT6331_PWRKEY_RST_EN	BIT(9)
+#define MTK_PMIC_MT6331_RST_DU_MASK	GENMASK(13, 12)
+
 #define MTK_PMIC_PWRKEY_INDEX	0
 #define MTK_PMIC_HOMEKEY_INDEX	1
 #define MTK_PMIC_MAX_KEY_COUNT	2
@@ -86,6 +91,19 @@ static const struct mtk_pmic_regs mt6323_regs = {
 	.rst_lprst_mask = MTK_PMIC_MT6397_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6331_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x2,
+				   MT6331_INT_MISC_CON, 0x4,
+				   MTK_PMIC_MT6331_PWRKEY_RST_EN),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x4,
+				   MT6331_INT_MISC_CON, 0x2,
+				   MTK_PMIC_MT6331_HOMEKEY_RST_EN),
+	.pmic_rst_reg = MT6331_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_MT6331_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6358_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
@@ -284,6 +302,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt6323-keys",
 		.data = &mt6323_regs,
+	}, {
+		.compatible = "mediatek,mt6331-keys",
+		.data = &mt6331_regs,
 	}, {
 		.compatible = "mediatek,mt6358-keys",
 		.data = &mt6358_regs,
-- 
2.35.1

