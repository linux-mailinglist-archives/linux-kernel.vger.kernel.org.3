Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A9502CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355482AbiDOPj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356309AbiDOPjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:39:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA4C3C712
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:37:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so4037228wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WDWruGhytuHi8Hvh9Dd5EXmCI8L1q6rKOX9fLidj6Ec=;
        b=7PMInzua21fpHF4kYL57dFlermowOW/PqKGwQW3jR3av/kD270Yz7hbxnumJtgBQZe
         qTv0oUPTjvZJ/BIK4h9Rfj2/YizFRGCoEJTPeJV7gLczJ9GUhdouEgHr4dTvJcvc7DWA
         ie3j/T1pAG0eWAf8WjtV3bekFzyv+C2k78Igwue3O8AULtfm08Hb0K5xw19m0BWHGPUL
         /0YZN1+SUuUsmv8pGx7v5SS6Mdpln+x0dEEX9NoSK5i5fdB+ZqNwDcGkZuPaB3q9g9HQ
         am556YuRXY6z19YPvt+WqjCMBWDsjvB5lX8ib7SaCcTkaBKkrVxYzfJdHgMY0U79NvcT
         veIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDWruGhytuHi8Hvh9Dd5EXmCI8L1q6rKOX9fLidj6Ec=;
        b=26W7lPmv4QWCjYo98ONrwFgOuYufeL0poe7HwCe6NHGCV3yw9+Zan3Is19Wwmf5IFN
         DGNSY81xMyQZVWkAXntuN8gTiybbAtpKyFs4dH4SCHkAPMA/Bnw4U82yG/qPDDnlbi3e
         Ax3Xp2Cl/sGOjbd84/cq4MOrYmNy0wj0rVaePQmZuho13oki05TiLB+cLzyUjqhcY6QR
         D5fHkWI7w/sGZWn/7nCqo2+Ulfn5DHDkXHtz7o3MXXjto8P8+WmXxj7F+NtnspY6Aboe
         nSMhnJRtnV7oA6TnGm5KtwdybOVZz2waqLvAjDX1M3AqXf429D4KUbAsKmfto+SXXCqL
         pFNA==
X-Gm-Message-State: AOAM531SDS7ppBfy99f9IxBMh6NuUVoLT8B77qzZBB6twwgKmXBAXxbp
        yQgn8UDRqWoCHhiEtHZ5U+Nh6A==
X-Google-Smtp-Source: ABdhPJw+A/iRYwe+lAeKns1b6yTF/VsCPkstrY3ipuTjcg6HrcxfTo54JB/+0tA8BqHvGSAeVJOP9Q==
X-Received: by 2002:a1c:2b05:0:b0:392:5bfb:a0e2 with SMTP id r5-20020a1c2b05000000b003925bfba0e2mr521128wmr.165.1650037021444;
        Fri, 15 Apr 2022 08:37:01 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm8459292wmb.15.2022.04.15.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:37:01 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] Input: mtk-pmic-keys: rename platform data struct
Date:   Fri, 15 Apr 2022 17:36:26 +0200
Message-Id: <20220415153629.1817202-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415153629.1817202-1-fparent@baylibre.com>
References: <20220415153629.1817202-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the struct that is given to the .data field of the of_device_id
entries to reflect that this structure will not only contain register
definitions but also other platform data.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c31ab4368388..a0da644fe93d 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -50,12 +50,12 @@ struct mtk_pmic_keys_regs {
 	.intsel_mask		= _intsel_mask,		\
 }
 
-struct mtk_pmic_regs {
+struct mtk_pmic_keys_pdata {
 	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
 	u32 pmic_rst_reg;
 };
 
-static const struct mtk_pmic_regs mt6397_regs = {
+static const struct mtk_pmic_keys_pdata mt6397_pdata = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6397_CHRSTATUS,
 		0x8, MT6397_INT_RSV, 0x10),
@@ -65,7 +65,7 @@ static const struct mtk_pmic_regs mt6397_regs = {
 	.pmic_rst_reg = MT6397_TOP_RST_MISC,
 };
 
-static const struct mtk_pmic_regs mt6323_regs = {
+static const struct mtk_pmic_keys_pdata mt6323_pdata = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
 		0x2, MT6323_INT_MISC_CON, 0x10),
@@ -75,7 +75,7 @@ static const struct mtk_pmic_regs mt6323_regs = {
 	.pmic_rst_reg = MT6323_TOP_RST_MISC,
 };
 
-static const struct mtk_pmic_regs mt6358_regs = {
+static const struct mtk_pmic_keys_pdata mt6358_pdata = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
 				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5),
@@ -255,13 +255,13 @@ static SIMPLE_DEV_PM_OPS(mtk_pmic_keys_pm_ops, mtk_pmic_keys_suspend,
 static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt6397-keys",
-		.data = &mt6397_regs,
+		.data = &mt6397_pdata,
 	}, {
 		.compatible = "mediatek,mt6323-keys",
-		.data = &mt6323_regs,
+		.data = &mt6323_pdata,
 	}, {
 		.compatible = "mediatek,mt6358-keys",
-		.data = &mt6358_regs,
+		.data = &mt6358_pdata,
 	}, {
 		/* sentinel */
 	}
@@ -277,7 +277,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	static const char *const irqnames[] = { "powerkey", "homekey" };
 	static const char *const irqnames_r[] = { "powerkey_r", "homekey_r" };
 	struct mtk_pmic_keys *keys;
-	const struct mtk_pmic_regs *mtk_pmic_regs;
+	const struct mtk_pmic_keys_pdata *mtk_pmic_keys_pdata;
 	struct input_dev *input_dev;
 	const struct of_device_id *of_id =
 		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
@@ -288,7 +288,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 
 	keys->dev = &pdev->dev;
 	keys->regmap = pmic_chip->regmap;
-	mtk_pmic_regs = of_id->data;
+	mtk_pmic_keys_pdata = of_id->data;
 
 	keys->input_dev = input_dev = devm_input_allocate_device(keys->dev);
 	if (!input_dev) {
@@ -310,7 +310,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	}
 
 	for_each_child_of_node(node, child) {
-		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
+		keys->keys[index].regs = &mtk_pmic_keys_pdata->keys_regs[index];
 
 		keys->keys[index].irq =
 			platform_get_irq_byname(pdev, irqnames[index]);
@@ -358,7 +358,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs->pmic_rst_reg);
+	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_keys_pdata->pmic_rst_reg);
 
 	platform_set_drvdata(pdev, keys);
 
-- 
2.35.2

