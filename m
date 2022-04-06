Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C74F6330
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiDFPXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiDFPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:23:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B545F38F0;
        Wed,  6 Apr 2022 05:23:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 89D031F4452C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649246250;
        bh=KeK63JgstL220HZeT8Eh0tNYtvHxor/1CeEp/mCXIg4=;
        h=From:To:Cc:Subject:Date:From;
        b=g0BD1LF33XBXk5bDckOc92DJvC+EWtN1wj7NORKaXCUpqG+9cOPZJVgOq5Ni+3ahf
         yjytUdiXEX9nXSsF3TjVgJ0WnzitjiZNCezEc9aH2Y11lfMJnHdYu3s06VCFmnBPJV
         wxEt11fauvCuNSXhoeHvrn7G7IJ5gR6N6nyDMvZ9HECatNjEG3lJbhggZZgG3+JAE1
         hqvpI12iQoRdBuCagB70QJZYL37OvkwqFAbVFrEpIcn2FFTCkJQpVDPu11Uf1QEl8M
         xZu/3hEzTQ8L8cjszOX4LFERAwFSwm6YeaJYSJ29lx4SJwiWTgbVM9uEcan1HPEzjC
         M8Y4tHajnI0RQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        lv.ruyi@zte.com.cn, m.felsch@pengutronix.de,
        angelogioacchino.delregno@collabora.com, fengping.yu@mediatek.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: mt6779-keypad: Move iomem pointer to probe function
Date:   Wed,  6 Apr 2022 13:56:54 +0200
Message-Id: <20220406115654.115093-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

The mmio base address is used for the only purpose of initializing
regmap for this driver, hence it's not necessary to have it in the
main driver structure, as it is used only in the probe() callback.
Move it local to function mt6779_keypad_pdrv_probe().

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mt6779-keypad.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index 0dbbddc7f298..2e7c9187c10f 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -24,7 +24,6 @@ struct mt6779_keypad {
 	struct regmap *regmap;
 	struct input_dev *input_dev;
 	struct clk *clk;
-	void __iomem *base;
 	u32 n_rows;
 	u32 n_cols;
 	DECLARE_BITMAP(keymap_state, MTK_KPD_NUM_BITS);
@@ -91,6 +90,7 @@ static void mt6779_keypad_clk_disable(void *data)
 static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
 {
 	struct mt6779_keypad *keypad;
+	void __iomem *base;
 	int irq;
 	u32 debounce;
 	bool wakeup;
@@ -100,11 +100,11 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
 	if (!keypad)
 		return -ENOMEM;
 
-	keypad->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(keypad->base))
-		return PTR_ERR(keypad->base);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
-	keypad->regmap = devm_regmap_init_mmio(&pdev->dev, keypad->base,
+	keypad->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					       &mt6779_keypad_regmap_cfg);
 	if (IS_ERR(keypad->regmap)) {
 		dev_err(&pdev->dev,
-- 
2.35.1

