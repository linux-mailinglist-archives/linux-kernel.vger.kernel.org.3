Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6195684DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiGFKLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiGFKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:11:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E111581A;
        Wed,  6 Jul 2022 03:11:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D3DE566019AB;
        Wed,  6 Jul 2022 11:11:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102290;
        bh=Xhl1Ow9x+DfI22vAa93ClvjHOF/I+FiiBOeSds25YTo=;
        h=From:To:Cc:Subject:Date:From;
        b=krrLDBECxk0hdNlHvDKeZS2C+hDOHY3M44vURPYvwp1rLnnRGpRQn9y7VE/oW+IeX
         DhyIlEzxzCla5C9R4zyXioRvvUd8Ix+mmOsj7kBV11kMKbx2h9GS1jq7eRzRgOURoq
         iSySAHqvClcqZhNNe1GAnUrEP0pjqhckU8fFqo+7oXQ5WTiCe6w+6UigRq04h1H9+N
         RfvEmeMEoIHQFg5PiRfkqRFNfIddz09A9j4IzgtgiAtTTiIMZRu23tFC5nFK4nZtfT
         Xd6h8iHFgxnMFKIY27ojZfVWO6Li3oomo1XeyZh38nFKy6J1s0Xzp0IfDPtiOxUKo7
         WJEDgeCJXp2EA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] Input: mtk-pmic-keys - Add support for MT6331 PMIC keys
Date:   Wed,  6 Jul 2022 12:11:22 +0200
Message-Id: <20220706101122.201007-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

Add support for PMIC Keys of the MT6331 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 6404081253ea..9b34da0ec260 100644
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
 #define MTK_PMIC_PWRKEY_RST	BIT(6)
 #define MTK_PMIC_HOMEKEY_RST	BIT(5)
 
+#define MTK_PMIC_MT6331_RST_DU_MASK	GENMASK(13, 12)
+#define MTK_PMIC_MT6331_PWRKEY_RST	BIT(9)
+#define MTK_PMIC_MT6331_HOMEKEY_RST	BIT(8)
+
 #define MTK_PMIC_PWRKEY_INDEX	0
 #define MTK_PMIC_HOMEKEY_INDEX	1
 #define MTK_PMIC_MAX_KEY_COUNT	2
@@ -72,6 +77,19 @@ static const struct mtk_pmic_regs mt6323_regs = {
 	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6331_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x2,
+				   MT6331_INT_MISC_CON, 0x4,
+				   MTK_PMIC_MT6331_PWRKEY_RST),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x4,
+				   MT6331_INT_MISC_CON, 0x2,
+				   MTK_PMIC_MT6331_HOMEKEY_RST),
+	.pmic_rst_reg = MT6331_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_MT6331_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6358_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
@@ -255,6 +273,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
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

