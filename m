Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8BA531E72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiEWWQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiEWWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:16:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B313978929;
        Mon, 23 May 2022 15:16:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so14283397plk.8;
        Mon, 23 May 2022 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pJTRgXjYxPKGivC1ddsBnyqDyotE4GS4vzjjb/S5WBE=;
        b=ESCC6/40VtCzAGtorsLZn0r0V2dBdWiAOt/cG6gTdpQvsDw+mGlgVg7Rk53aHsoQQp
         0+uIQkSr3+LV3ofNC3mJgx8gX9WwjMSSnmnZddXeQKgw56PdhYP6Dpkq7qNvcqOfJqdv
         T7SdjCVb57q7FlX/b0P0C7c5IJDFGC2tczw4YqAlFOIc7KvyWtLLtVdSccSr234CejTZ
         /zPS5dQ3UeU2+8yW1jlkkiuqf4goS0Lz/gAX8rZ5QdmW7/pF94+serdUK5wna9OzJ/gb
         /RRupefhXyaSG4Ep9gxcObKqnFHrT/5dS5XIwIukTLs3fzer6b5uHSKFz2pWYneFUqUa
         Wp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pJTRgXjYxPKGivC1ddsBnyqDyotE4GS4vzjjb/S5WBE=;
        b=eDTwiql2C2rmUmBwa0s7bqfoMku8ACch4yFs5Sp1AUhLan/UmGLxAFP/9OuGrcs8GH
         qcvqvhlZymf91fnMKyVmUUlB6Vzy3E7DgXOuKHwWmDM/ORA4QPTTdtgJEdZhM97iSs+X
         DvdDCh5D5erYYpSZRhBS9HaKiNHo6yZF2AXVaoqNXZCC3MOJdZKr1Y3Zbql8cL73R1WL
         PSVOJC2YLrl2pJ1boNZtEo7MpftX6VPKxTqyYaN8MaoVtZL21UVY2cZpTrVllAC9bT2D
         rSAFmZlgalH3/oIcmDi+7XzNBgm4pFcgnjH1faevvJu1Vv0h7p/ciCFw/YNYStoGmzDT
         EoNQ==
X-Gm-Message-State: AOAM5306L2Xzbx2nvymB0JSwbcYqi6V/Th2xZGiRdQh8cixuQI8r/G2b
        04ucGWPm4DkTDwkAL6nXPhyTrhHyUeo=
X-Google-Smtp-Source: ABdhPJzOKCF/I42KUqWTL8cfnDA/0/qAdvt/GNLcSeZ9wgnwBO24anbaidWzuyLvAGG0ZvkiJfSv4A==
X-Received: by 2002:a17:90a:aa8c:b0:1df:359a:1452 with SMTP id l12-20020a17090aaa8c00b001df359a1452mr1170029pjq.75.1653344213190;
        Mon, 23 May 2022 15:16:53 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ce25:f34f:c90d:61fa])
        by smtp.gmail.com with ESMTPSA id ck18-20020a17090afe1200b001cb6527ca39sm214063pjb.0.2022.05.23.15.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 15:16:52 -0700 (PDT)
Date:   Mon, 23 May 2022 15:16:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: mtk-pmic-keys - use single update when configuring
 long press behavior
Message-ID: <YowH0Q5HAGU7Grx2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of doing 3 read-modify-write operations when configuring behavior
of long-press, consolidate everything into one.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 71 ++++++++++----------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c31ab4368388..d2f0db245ff6 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -18,17 +18,11 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
-#define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
-#define MTK_PMIC_HOMEKEY_RST_EN_MASK	0x1
-#define MTK_PMIC_HOMEKEY_RST_EN_SHIFT	5
-#define MTK_PMIC_RST_DU_MASK		0x3
-#define MTK_PMIC_RST_DU_SHIFT		8
-
-#define MTK_PMIC_PWRKEY_RST		\
-	(MTK_PMIC_PWRKEY_RST_EN_MASK << MTK_PMIC_PWRKEY_RST_EN_SHIFT)
-#define MTK_PMIC_HOMEKEY_RST		\
-	(MTK_PMIC_HOMEKEY_RST_EN_MASK << MTK_PMIC_HOMEKEY_RST_EN_SHIFT)
+#define MTK_PMIC_RST_DU_MASK	GENMASK(9, 8)
+#define MTK_PMIC_RST_DU_SHIFT	8
+#define MTK_PMIC_RST_KEY_MASK	GENMASK(6, 5)
+#define MTK_PMIC_PWRKEY_RST	BIT(6)
+#define MTK_PMIC_HOMEKEY_RST	BIT(5)
 
 #define MTK_PMIC_PWRKEY_INDEX	0
 #define MTK_PMIC_HOMEKEY_INDEX	1
@@ -108,53 +102,44 @@ enum mtk_pmic_keys_lp_mode {
 };
 
 static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
-		u32 pmic_rst_reg)
+					 u32 pmic_rst_reg)
 {
-	int ret;
 	u32 long_press_mode, long_press_debounce;
+	u32 value, mask;
+	int error;
 
-	ret = of_property_read_u32(keys->dev->of_node,
-		"power-off-time-sec", &long_press_debounce);
-	if (ret)
+	error = of_property_read_u32(keys->dev->of_node, "power-off-time-sec",
+				     &long_press_debounce);
+	if (error)
 		long_press_debounce = 0;
 
-	regmap_update_bits(keys->regmap, pmic_rst_reg,
-			   MTK_PMIC_RST_DU_MASK << MTK_PMIC_RST_DU_SHIFT,
-			   long_press_debounce << MTK_PMIC_RST_DU_SHIFT);
+	mask = MTK_PMIC_RST_DU_MASK;
+	value = long_press_debounce << MTK_PMIC_RST_DU_SHIFT;
 
-	ret = of_property_read_u32(keys->dev->of_node,
-		"mediatek,long-press-mode", &long_press_mode);
-	if (ret)
+	error  = of_property_read_u32(keys->dev->of_node,
+				      "mediatek,long-press-mode",
+				      &long_press_mode);
+	if (error)
 		long_press_mode = LP_DISABLE;
 
 	switch (long_press_mode) {
-	case LP_ONEKEY:
-		regmap_update_bits(keys->regmap, pmic_rst_reg,
-				   MTK_PMIC_PWRKEY_RST,
-				   MTK_PMIC_PWRKEY_RST);
-		regmap_update_bits(keys->regmap, pmic_rst_reg,
-				   MTK_PMIC_HOMEKEY_RST,
-				   0);
-		break;
 	case LP_TWOKEY:
-		regmap_update_bits(keys->regmap, pmic_rst_reg,
-				   MTK_PMIC_PWRKEY_RST,
-				   MTK_PMIC_PWRKEY_RST);
-		regmap_update_bits(keys->regmap, pmic_rst_reg,
-				   MTK_PMIC_HOMEKEY_RST,
-				   MTK_PMIC_HOMEKEY_RST);
-		break;
+		value |= MTK_PMIC_HOMEKEY_RST;
+		fallthrough;
+
+	case LP_ONEKEY:
+		value |= MTK_PMIC_PWRKEY_RST;
+		fallthrough;
+
 	case LP_DISABLE:
-		regmap_update_bits(keys->regmap, pmic_rst_reg,
-				   MTK_PMIC_PWRKEY_RST,
-				   0);
-		regmap_update_bits(keys->regmap, pmic_rst_reg,
-				   MTK_PMIC_HOMEKEY_RST,
-				   0);
+		mask |= MTK_PMIC_RST_KEY_MASK;
 		break;
+
 	default:
 		break;
 	}
+
+	regmap_update_bits(keys->regmap, pmic_rst_reg, mask, value);
 }
 
 static irqreturn_t mtk_pmic_keys_irq_handler_thread(int irq, void *data)
-- 
2.36.1.124.g0e6072fb45-goog


-- 
Dmitry
