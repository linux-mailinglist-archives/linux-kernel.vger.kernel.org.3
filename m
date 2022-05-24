Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D253268B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiEXJfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiEXJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:35:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1725EDEE;
        Tue, 24 May 2022 02:35:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7A2871F42BEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653384914;
        bh=Xhl1Ow9x+DfI22vAa93ClvjHOF/I+FiiBOeSds25YTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4vFnxIF9ogphwvw7dLm0NgNSMeMWAg7IAzMqwNoXMo13W3QMH4cQ2y0+HmUCjGkT
         87u3iSPM5l8YK6rEv2YFa6SWQDeYUzJ5EoiUO9qEZWXsfvTbKgqoyZJshIaxftCT+L
         tCNqi2r/77M7huV+MV+auYaOS7jQcrq308P9vGll0J5tCX81bJHLqXqS4MdMV8BLN3
         jyAWjfapKTQQv2TxQtvnVPPSTEpghzpViKaTiRctQfYX8GSptUdCTAWh+pnk2ae9sW
         nSiZHizCH10aAZjE/rEcoyxE2p13kg67RXqlATeYaXK6BzgZbPtwm1SX+ZQ8qAPkEW
         uuJTFltedrGtg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Input: mtk-pmic-keys - Add support for MT6331 PMIC keys
Date:   Tue, 24 May 2022 11:35:05 +0200
Message-Id: <20220524093505.85438-4-angelogioacchino.delregno@collabora.com>
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

