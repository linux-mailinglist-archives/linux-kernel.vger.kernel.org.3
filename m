Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249974D1462
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345687AbiCHKLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbiCHKLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:16 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8095737A32
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:10:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z4so16000975pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AN8AQlXUHY8dzoH7tRwXIxVaLJny20Q1qo/2QYSwxHk=;
        b=bvMT2jkFovcX32w1PT4TTZsspSO3e8SRTk4q/igiSkmk1cUsE98JgeoEY/AL+dcqqr
         jS34mDr+t3NiSxzysNh51S4J/5tPFK4zct+75oThi+ZUuqpucK6VNZsvlnz481UDatKe
         G827DuIdlh6BrRcFNn62siIpYzUjZpPJMfngo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AN8AQlXUHY8dzoH7tRwXIxVaLJny20Q1qo/2QYSwxHk=;
        b=DBEzVXNo/X6H6VYgECJ0N1tPbE/kJUxXngARja+KBMs/6ZZ+Ft45h4ih7UfUdU76O+
         TbEPn0XeoQXloIoown7D/RylLaPN8FKBd1e2Hn8m2ZSQnpBPu/sLYCTeoHmoswpcBGes
         HKEezPCh/e3eQ/fnJAjDfXmC+5FpmrQzO8Lqv4FiIE4TtXHLsJeVAvBl7f/QXmQHE8T5
         MQOl970EHDhTR7FV+UTdQ6LGf6TNTKPuVYZ2dGu6QSq3sLBaBxCkkaBodQczzGfSiRIK
         Wfl14N9YKYtduvmjXy/vyiq6ByCzvLS3V8YSKgD8jxWVASEtMTrVFA4lzwJqwau9Jpm0
         rSxQ==
X-Gm-Message-State: AOAM530Ba3zR7tLyb+Cpx5U3uW+zMiFVmsZbGwAjsMShJUFgLjjswmVX
        BSz/HTCKBuIlgANjGtvzAeKvYg==
X-Google-Smtp-Source: ABdhPJwL9D+0SHRBS3XhC6nSpflTUI/0erBZkhgu01psg9Z8qe64mE6poyKANJlHUDzPcjgGtUO/Ag==
X-Received: by 2002:a63:2ccb:0:b0:37c:626c:d7e with SMTP id s194-20020a632ccb000000b0037c626c0d7emr13324616pgs.290.1646734218922;
        Tue, 08 Mar 2022 02:10:18 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:73f8:5e3f:6894:8f44])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm1707553pfu.106.2022.03.08.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:10:18 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 07/11] pinctrl: mediatek: paris: Rework mtk_pinconf_{get,set} switch/case logic
Date:   Tue,  8 Mar 2022 18:09:52 +0800
Message-Id: <20220308100956.2750295-8-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308100956.2750295-1-wenst@chromium.org>
References: <20220308100956.2750295-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code deals with optional features by testing for the
function pointers and returning -ENOTSUPP if it is not valid. This is
done for multiple pin config settings and results in the code that
handles the supporting cases to get indented by one level. This is
aggrevated by the fact that some features require another level of
conditionals.

Instead of assigning the same error code in all unsupported optional
feature cases, simply have that error code as the default, and break
out of the switch/case block whenever a feature is unsupported, or an
error is returned. This reduces indentation by one level for the useful
code.

Also replace the goto statements with break statements. The result is
the same, as the gotos simply exit the switch/case block, which can
also be achieved with a break statement. With the latter the intent
is clear and easier to understand.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 144 ++++++++++-------------
 1 file changed, 61 insertions(+), 83 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 39487e0c2726..1ea3f3c54ef3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -79,37 +79,34 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	u32 param = pinconf_to_config_param(*config);
-	int pullup, err, reg, ret = 1;
+	int pullup, reg, err = -ENOTSUPP, ret = 1;
 	const struct mtk_pin_desc *desc;
 
-	if (pin >= hw->soc->npins) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (pin >= hw->soc->npins)
+		return -EINVAL;
+
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_get_combo) {
-			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
-			if (err)
-				goto out;
-			if (ret == MTK_PUPD_SET_R1R0_00)
-				ret = MTK_DISABLE;
-			if (param == PIN_CONFIG_BIAS_DISABLE) {
-				if (ret != MTK_DISABLE)
-					err = -EINVAL;
-			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
-				if (!pullup || ret == MTK_DISABLE)
-					err = -EINVAL;
-			} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
-				if (pullup || ret == MTK_DISABLE)
-					err = -EINVAL;
-			}
-		} else {
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_get_combo)
+			break;
+		err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
+		if (err)
+			break;
+		if (ret == MTK_PUPD_SET_R1R0_00)
+			ret = MTK_DISABLE;
+		if (param == PIN_CONFIG_BIAS_DISABLE) {
+			if (ret != MTK_DISABLE)
+				err = -EINVAL;
+		} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
+			if (!pullup || ret == MTK_DISABLE)
+				err = -EINVAL;
+		} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
+			if (pullup || ret == MTK_DISABLE)
+				err = -EINVAL;
 		}
 		break;
 	case PIN_CONFIG_SLEW_RATE:
@@ -119,7 +116,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_OUTPUT_ENABLE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
 		if (err)
-			goto out;
+			break;
 		/*     CONFIG     Current direction return value
 		 * -------------  ----------------- ----------------------
 		 * OUTPUT_ENABLE       output       1 (= HW value)
@@ -134,23 +131,21 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
 		if (err)
-			goto out;
+			break;
 		/* return error when in output mode
 		 * because schmitt trigger only work in input mode
 		 */
 		if (ret) {
 			err = -EINVAL;
-			goto out;
+			break;
 		}
 
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SMT, &ret);
-
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		if (hw->soc->drive_get)
-			err = hw->soc->drive_get(hw, desc, &ret);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->drive_get)
+			break;
+		err = hw->soc->drive_get(hw, desc, &ret);
 		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
@@ -160,23 +155,18 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 	case MTK_PIN_CONFIG_PU_ADV:
 	case MTK_PIN_CONFIG_PD_ADV:
-		if (hw->soc->adv_pull_get) {
-			pullup = param == MTK_PIN_CONFIG_PU_ADV;
-			err = hw->soc->adv_pull_get(hw, desc, pullup, &ret);
-		} else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_pull_get)
+			break;
+		pullup = param == MTK_PIN_CONFIG_PU_ADV;
+		err = hw->soc->adv_pull_get(hw, desc, pullup, &ret);
 		break;
 	case MTK_PIN_CONFIG_DRV_ADV:
-		if (hw->soc->adv_drive_get)
-			err = hw->soc->adv_drive_get(hw, desc, &ret);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_drive_get)
+			break;
+		err = hw->soc->adv_drive_get(hw, desc, &ret);
 		break;
-	default:
-		err = -ENOTSUPP;
 	}
 
-out:
 	if (!err)
 		*config = pinconf_to_config_packed(param, ret);
 
@@ -188,33 +178,29 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	const struct mtk_pin_desc *desc;
-	int err = 0;
+	int err = -ENOTSUPP;
 	u32 reg;
 
-	if (pin >= hw->soc->npins) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (pin >= hw->soc->npins)
+		return -EINVAL;
+
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
 	switch ((u32)param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 0, MTK_DISABLE);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 0, MTK_DISABLE);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 1, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 1, arg);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 0, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 0, arg);
 		break;
 	case PIN_CONFIG_OUTPUT_ENABLE:
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
@@ -223,7 +209,7 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		 *  does not have SMT control
 		 */
 		if (err != -ENOTSUPP)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 				       MTK_OUTPUT);
@@ -232,7 +218,7 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		/* regard all non-zero value as enable */
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES, !!arg);
 		if (err)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 				       MTK_INPUT);
@@ -245,7 +231,7 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DO,
 				       arg);
 		if (err)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 				       MTK_OUTPUT);
@@ -257,15 +243,14 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		 */
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR, !arg);
 		if (err)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, !!arg);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		if (hw->soc->drive_set)
-			err = hw->soc->drive_set(hw, desc, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->drive_set)
+			break;
+		err = hw->soc->drive_set(hw, desc, arg);
 		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
@@ -275,26 +260,19 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		break;
 	case MTK_PIN_CONFIG_PU_ADV:
 	case MTK_PIN_CONFIG_PD_ADV:
-		if (hw->soc->adv_pull_set) {
-			bool pullup;
-
-			pullup = param == MTK_PIN_CONFIG_PU_ADV;
-			err = hw->soc->adv_pull_set(hw, desc, pullup,
-						    arg);
-		} else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_pull_set)
+			break;
+		err = hw->soc->adv_pull_set(hw, desc,
+					    (param == MTK_PIN_CONFIG_PU_ADV),
+					    arg);
 		break;
 	case MTK_PIN_CONFIG_DRV_ADV:
-		if (hw->soc->adv_drive_set)
-			err = hw->soc->adv_drive_set(hw, desc, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_drive_set)
+			break;
+		err = hw->soc->adv_drive_set(hw, desc, arg);
 		break;
-	default:
-		err = -ENOTSUPP;
 	}
 
-err:
 	return err;
 }
 
-- 
2.35.1.616.g0bdcbb4464-goog

