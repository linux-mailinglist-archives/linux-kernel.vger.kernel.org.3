Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18E248AC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349381AbiAKLXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349467AbiAKLXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:23:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64654C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:23:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hv15so10661071pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MO9C+/y7rlHj27Tk0Qv7Ks5nBGk0gl8cyNWfCGutHPg=;
        b=XMNyqW3ffjGD7aCP26DsYfNkvK9ie+mUzx3cG++ZVjFOqppMcKCPt/SaXT9UO5JD6W
         13iklO18M+gyAsiV7wMHy5puKvT6Pt4MaWcgg5Rj/64i+CICBfFPyisF5bhP4SCLrPMJ
         7dpzceifRZu8dB+5qU1lNWREKlqsVtIhxetVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MO9C+/y7rlHj27Tk0Qv7Ks5nBGk0gl8cyNWfCGutHPg=;
        b=psfRgsxV4PlabSMQgoO8UdnAcnMAVUQPZk2HbSF1pOiNLWT5eGBufDhsnlMhlW+doU
         puGmw8FMJI4Tpvo54AiuXFoE0beFDFy9soMKY6D24CbdJEBGXmQNLOemM830Lr4M+fSY
         +we4iXyDrL8W9Y4feS5lZSJehTYnsIhi9Pd5wJKyxWlLaiMvksT0Bf8TPe+4dsU9iMSl
         CJ6l9POq0QQTPcDBXnr/aM1l9FP5zW/2YR3DeWnaOXKGdx/hYkSRESeNFMo8YziWIvpI
         tvK/RqZgWKaZnNtIcXlGYVa6DLGe9PGGCrMDScaXsOpMEqL0xjCW2y4LAuMZ0jhZiFtp
         TVgg==
X-Gm-Message-State: AOAM531ADHKQGJiNbuj5S19zD+BNz3uD8jDe+uYHmLOUgMPk5a9fFEdz
        uHVGTNx36ygugs07ZhYQXdpDvgJCacIxZw==
X-Google-Smtp-Source: ABdhPJyjOgTnrtdJ0sLFZX6lDQMnLzWQ2b3meTpTPAGNIGTegsNduPt3LuE/Tfw99opR/kwqXQcJHg==
X-Received: by 2002:a17:902:9a02:b0:14a:6a3:6c68 with SMTP id v2-20020a1709029a0200b0014a06a36c68mr4116724plp.138.1641900185952;
        Tue, 11 Jan 2022 03:23:05 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e7ee:1824:8575:bc5c])
        by smtp.gmail.com with ESMTPSA id f9sm2053845pjh.18.2022.01.11.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:23:05 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH 7/7] pinctrl: mediatek: paris: Support generic PIN_CONFIG_DRIVE_STRENGTH_UA
Date:   Tue, 11 Jan 2022 19:22:44 +0800
Message-Id: <20220111112244.1483783-8-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220111112244.1483783-1-wenst@chromium.org>
References: <20220111112244.1483783-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the MediaTek chips that utilize the Paris pinctrl driver library
support a lower drive strength (<= 1mA) than the standard drive strength
settings (2~16 mA) on certain pins. This was previously supported by the
custom MTK_PIN_CONFIG_DRV_ADV parameter along with the
"mediatek,drive-strength-adv" device tree property.

The drive strength values for this hardware are 125, 250, 500, and 1000 mA,
and can be readily described by the existing "drive-strength-microamp",
which then gets parsed by the generic pinconf library into the parameter
PIN_CONFIG_DRIVE_STRENGTH_UA.

Add support for PIN_CONFIG_DRIVE_STRENGTH_UA while keeping the old
custom parameter around for backward compatibility.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

The indentation in the switch/case blocks is getting somewhat out of
control. I also have some cleanup changes to reverse the logic of the
if/break statements. Not sure if it should be done before or after this
patch though.

---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 84 ++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 678c8aa33012..5a94903ae372 100644
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
@@ -151,11 +198,38 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
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
 		if (hw->soc->drive_get)
 			err = hw->soc->drive_get(hw, desc, &ret);
 		else
 			err = -ENOTSUPP;
 		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		if (hw->soc->adv_drive_get) {
+			err = hw->soc->adv_drive_get(hw, desc, &ret);
+			if (err)
+				break;
+			err = mtk_drv_adv_to_uA(ret);
+			if (err < 0)
+				break;
+
+			ret = err;
+			err = 0;
+		} else {
+			err = -ENOTSUPP;
+		}
+		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
 		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
@@ -271,6 +345,16 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		else
 			err = -ENOTSUPP;
 		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		if (hw->soc->adv_drive_set) {
+			err = mtk_drv_uA_to_adv(arg);
+			if (err < 0)
+				break;
+			err = hw->soc->adv_drive_set(hw, desc, err);
+		} else {
+			err = -ENOTSUPP;
+		}
+		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
 		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
-- 
2.34.1.575.g55b058a8bb-goog

