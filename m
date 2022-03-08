Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D90C4D1460
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbiCHKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbiCHKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDED2D1F4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:10:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v4so16704760pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HzDn1y9bF4mL2TwPHFzwmvmpvjVc5+8wRjfSvBXPFs=;
        b=iX9EgdxUqNlM3gsr2/giz0GMRZ7bA8G6QFObBSKiSEpOkj2vpQRNOSg03hc6ae67fD
         2W+QPLh/2foXuuGGfi1XOmJyciVx+XHCljWyFIZihandnYlSuaMNn7faS/Bw9rSZRuyG
         yo0xpbSt3Y46GeTP+XGHuklHBz1XBxcsX5GE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HzDn1y9bF4mL2TwPHFzwmvmpvjVc5+8wRjfSvBXPFs=;
        b=cdVRtYFaR8nNUSnJUEZO8LRYn5lbLMK6jgYlGUF5OMpPpgJx2xPIz6CMYqA4DseHpk
         4Y9bdLKUN2mLSUs6WNCRavRnLmlhHPZaWOqdQ4Pxnz+MLBdGwwZoJGZ3n67MVE/HvCjy
         pom8De3WJXzgE2061H+jnegVgjZzgvs+J+ilOvFj1yvTB2ib6ZhShz59kksHw2KiQPEf
         Qi0w/VhwMMKhIDnPp2IESDjrK4eS450TDFAP1pBW3Kv+ElAadT74bSeej6+p9VoFzWU6
         tG+rQnqJiQQypZJXjpIm1+AbGkzspVgpm0CiUDw7gQnvIFo1zXOiwSA9DfDlRlNGsVDM
         18pQ==
X-Gm-Message-State: AOAM532yVTBtHxFS2cA3EdE+pNBRksM/kdUIRu0NA7G6r3t/5xjMfcsT
        HJjJ9r2yN/HhTkHk8FDfpSD6WA==
X-Google-Smtp-Source: ABdhPJyMrd0GH2X+Hm3rLZPvZtvquwQZkf1dabtzsGZyJ4pmxvqJFooM2QYqDOrllOdyMj2FrLUjmQ==
X-Received: by 2002:a17:90a:8987:b0:1be:dde1:c672 with SMTP id v7-20020a17090a898700b001bedde1c672mr3830895pjn.208.1646734220894;
        Tue, 08 Mar 2022 02:10:20 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:73f8:5e3f:6894:8f44])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm1707553pfu.106.2022.03.08.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:10:20 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 08/11] pinctrl: mediatek: paris: Support generic PIN_CONFIG_DRIVE_STRENGTH_UA
Date:   Tue,  8 Mar 2022 18:09:53 +0800
Message-Id: <20220308100956.2750295-9-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308100956.2750295-1-wenst@chromium.org>
References: <20220308100956.2750295-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the MediaTek chips that utilize the Paris pinctrl driver library
support a lower drive strength (<= 1mA) than the standard drive strength
settings (2~16 mA) on certain pins. This was previously supported by the
custom MTK_PIN_CONFIG_DRV_ADV parameter along with the
"mediatek,drive-strength-adv" device tree property.

The drive strength values for this hardware are 125, 250, 500, and 1000 mA,
and can be readily described by the existing "drive-strength-microamp"
property, which then gets parsed by the generic pinconf library into the
parameter PIN_CONFIG_DRIVE_STRENGTH_UA.

Add support for PIN_CONFIG_DRIVE_STRENGTH_UA while keeping the old
custom parameter around for backward compatibility.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 99 ++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 1ea3f3c54ef3..25d999848c2a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -48,6 +48,53 @@ static const char * const mtk_gpio_functions[] = {
 	"func12", "func13", "func14", "func15",
 };
 
+/*
+ * This section supports converting to/from custom MTK_PIN_CONFIG_DRV_ADV
+ * and standard PIN_CONFIG_DRIVE_STRENGTH_UA pin configs.
+ *
+ * The custom value encodes three hardware bits as follows:
+ *
+ *   |           Bits           |
+ *   | 2 (E1) | 1 (E0) | 0 (EN) | drive strength (uA)
+ *   ------------------------------------------------
+ *   |    x   |    x   |    0   | disabled, use standard drive strength
+ *   -------------------------------------
+ *   |    0   |    0   |    1   |  125 uA
+ *   |    0   |    1   |    1   |  250 uA
+ *   |    1   |    0   |    1   |  500 uA
+ *   |    1   |    1   |    1   | 1000 uA
+ */
+static const int mtk_drv_adv_uA[] = { 125, 250, 500, 1000 };
+
+static int mtk_drv_adv_to_uA(int val)
+{
+	/* This should never happen. */
+	if (WARN_ON_ONCE(val < 0 || val > 7))
+		return -EINVAL;
+
+	/* Bit 0 simply enables this hardware part */
+	if (!(val & BIT(0)))
+		return -EINVAL;
+
+	return mtk_drv_adv_uA[(val >> 1)];
+}
+
+static int mtk_drv_uA_to_adv(int val)
+{
+	switch (val) {
+	case 125:
+		return 0x1;
+	case 250:
+		return 0x3;
+	case 500:
+		return 0x5;
+	case 1000:
+		return 0x7;
+	}
+
+	return -EINVAL;
+}
+
 static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
 					  struct pinctrl_gpio_range *range,
 					  unsigned int pin)
@@ -145,8 +192,35 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		if (!hw->soc->drive_get)
 			break;
+
+		if (hw->soc->adv_drive_get) {
+			err = hw->soc->adv_drive_get(hw, desc, &ret);
+			if (!err) {
+				err = mtk_drv_adv_to_uA(ret);
+				if (err > 0) {
+					/* PIN_CONFIG_DRIVE_STRENGTH_UA used */
+					err = -EINVAL;
+					break;
+				}
+			}
+		}
+
 		err = hw->soc->drive_get(hw, desc, &ret);
 		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		if (!hw->soc->adv_drive_get)
+			break;
+
+		err = hw->soc->adv_drive_get(hw, desc, &ret);
+		if (err)
+			break;
+		err = mtk_drv_adv_to_uA(ret);
+		if (err < 0)
+			break;
+
+		ret = err;
+		err = 0;
+		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
 		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
@@ -252,6 +326,15 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 		err = hw->soc->drive_set(hw, desc, arg);
 		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		if (!hw->soc->adv_drive_set)
+			break;
+
+		err = mtk_drv_uA_to_adv(arg);
+		if (err < 0)
+			break;
+		err = hw->soc->adv_drive_set(hw, desc, err);
+		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
 		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
@@ -720,6 +803,8 @@ static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	struct mtk_pinctrl_group *grp = &hw->groups[group];
+	bool drive_strength_uA_found = false;
+	bool adv_drve_strength_found = false;
 	int i, ret;
 
 	for (i = 0; i < num_configs; i++) {
@@ -728,8 +813,22 @@ static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
 				      pinconf_to_config_argument(configs[i]));
 		if (ret < 0)
 			return ret;
+
+		if (pinconf_to_config_param(configs[i]) == PIN_CONFIG_DRIVE_STRENGTH_UA)
+			drive_strength_uA_found = true;
+		if (pinconf_to_config_param(configs[i]) == MTK_PIN_CONFIG_DRV_ADV)
+			adv_drve_strength_found = true;
 	}
 
+	/*
+	 * Disable advanced drive strength mode if drive-strength-microamp
+	 * is not set. However, mediatek,drive-strength-adv takes precedence
+	 * as its value can explicitly request the mode be enabled or not.
+	 */
+	if (hw->soc->adv_drive_set && !drive_strength_uA_found &&
+	    !adv_drve_strength_found)
+		hw->soc->adv_drive_set(hw, &hw->soc->pins[grp->pin], 0);
+
 	return 0;
 }
 
-- 
2.35.1.616.g0bdcbb4464-goog

