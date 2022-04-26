Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9457C50FFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351254AbiDZN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351208AbiDZN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:56:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B215DD43
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so12337177wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gbDSzBgFUstx3vAtmhMB1WWymTnfkPpJ2BBVAe7qM8=;
        b=rKgrTIQRTjHY+QtRVm3uhXuRFy9GFwVJ+lzbD98t1fgh6Poc221of/XAj8KerkZ42P
         C+ZpiNzei59SNOB+AUmWV1elGYyJXlD6pwT3ljgBTCzetjBTv1c59yHXNpqqge4WmlQk
         wwFEZYUhg2JR/SuOq9ZImZumt/sgw1EifvF+gqLEkzjxoMYwF+iK4EQZHUBqyjqAFPvX
         G5cKhophLSD4/4JyT/A59hgiD+wBF5X6tnmj6VrHc0x8DHoqfYPvvyPCkc/QmPE4xAiK
         GeX3jgVTSWIiM0DauIDMHuhIMOU6Hm0djgvd/jX4ajMRk+EkVGdcOp2W9TNeRNLUTY2T
         pnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gbDSzBgFUstx3vAtmhMB1WWymTnfkPpJ2BBVAe7qM8=;
        b=rhzJFNiLQZ5qu9TvjHxQ2eUohZv0/wtdw31/EPZ8NXsxDKPQkvPKLKUU9eJTovSIlQ
         kfH3a+QhMROmJHR7j9j2hMw0/ArvkhkarGcxAoMQIYDZxgLeZwXci6PV14i7xbaRCqhp
         nDMKwcMTRPZtAio2rjcAVw+Kyk8tJ/s96jOQNdYOmo7dX1770MTBeJNk6GZ+ChqUWq0y
         ujv7feloDxXcAG91qTjphYPdq//DhKAD2YcSJ+Oku2UqRKYMzWQ0nC5AfXbTj4ybPV0A
         TC4g4ShIKqsgjyUvwz9Cx9Hj1LhTjVHWiveos0/O9kMx/iKwUfp2e+pqB6Pb02NyDuqb
         CfyQ==
X-Gm-Message-State: AOAM532buAw3aZ9EeXMHv7r6EYXEFLVko0PO6ifXbJAjMMIniuVZAkam
        BLWHTB/cZxa70tAC1k3VOY0IFA==
X-Google-Smtp-Source: ABdhPJzGergTCkU6GvmqVNI+eV3Y2g5B9Ab+BVFa+qIK916IBxpfV6Rc8j9IOJ8+9NUGUw3fktwZMg==
X-Received: by 2002:a05:6000:1789:b0:20a:9fbc:b1b5 with SMTP id e9-20020a056000178900b0020a9fbcb1b5mr18208596wrg.581.1650981212914;
        Tue, 26 Apr 2022 06:53:32 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b00393ebe201a6sm5504775wms.44.2022.04.26.06.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:53:32 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] Input: mtk-pmic-keys: rename platform data struct
Date:   Tue, 26 Apr 2022 15:53:09 +0200
Message-Id: <20220426135313.245466-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426135313.245466-1-fparent@baylibre.com>
References: <20220426135313.245466-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the struct that is given to the .data field of the of_device_id
entries to reflect that this structure will not only contain register
definitions but also other platform data.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on mt8183-pumpkin
---
v2: no changes

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
2.36.0

