Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89475B168D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiIHIL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiIHILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:11:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714F5D0C9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:10:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w8so26381656lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iPVQmciwDU5l9xQEUoTRli5ZxjsltpZ7/BU9vnSvS1U=;
        b=PCEA+EbJxcxLWvroaJMvPvIoys/PDUNxLIe7Bbcy9HWEVKarFIx8eMGgHMyf5x8Tk4
         OEySCgUmZhwkPSq6aH2vjn4E+uTnN2wBh4MVfsUBklO0KanykgOtNlu1SaWV5vVpephs
         w6SSs7mDeR38LgJ4ZsrHVYzLENinYM93QJVGfy+UfAoZracyrOx6GxsCcNGBfY+qABFc
         pTyPi4+8eK3b0r6ZiLQduod/p2YwSYokCQBMNCZW7f9LueLZb3IYqmciVHmbFeE2xsni
         VOTviTerOREhyF6nXC2SyCMrqObDsTIaqDOovrebuLjPGu7s8x8D8UdM4bs6ll4xIKMK
         d17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iPVQmciwDU5l9xQEUoTRli5ZxjsltpZ7/BU9vnSvS1U=;
        b=zcq0dJWn5uzfqfr60CbVsOPdVVRf+5hk7uQdDEvmldkHsAeGz/9G2gfkWOhfapBdYR
         I8qQD3eh/ucmIfHj01E6Xj2Uwnh1ju0omk6/ZJ6DlkSTIt4EhvkkY9CeYn4LYxuoiWcs
         QhuOmxICPpjNo9OVB4t8R9brzMvxYCNkYBLDia4lnGwX0hiQRPMPHuGybCvWl265fZAO
         WDQJ6Ax0BLN6vM9QWv/lBgfU2BITbBCj6Xrp/om0LA9OQHWwXmCwpXtkQ46eMZ5IR7P9
         TxwGNYbawu/kjZsbIGQrUKxLGVSFYS0eE1Z0ThH86LvGD79iGm+2RTsjETXIaGGLXDWg
         qxxQ==
X-Gm-Message-State: ACgBeo0Sa49E/jNBYeON5rpOdGfCJEn9igwVRMcVXaR0BNTyPTOGhtN+
        dy6gzAyZQpx1RvQvc2FMJEaHaA==
X-Google-Smtp-Source: AA6agR5jiMpcpc9CfMHmCEuL44Mr/DiSeIbg/2pT3W+l/xVVA+SqJYueNhHr0/zl9WxGlgN00iOzQA==
X-Received: by 2002:a05:6512:e98:b0:492:cf3c:8860 with SMTP id bi24-20020a0565120e9800b00492cf3c8860mr2280479lfb.603.1662624656211;
        Thu, 08 Sep 2022 01:10:56 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020a05651c131200b00261e7e7b698sm3075777lja.123.2022.09.08.01.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:10:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] arm64: dts: qcom: msm8996-xiaomi: align PMIC GPIO pin configuration with DT schema
Date:   Thu,  8 Sep 2022 10:10:48 +0200
Message-Id: <20220908081050.29751-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908081050.29751-1-krzysztof.kozlowski@linaro.org>
References: <20220908081050.29751-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect PMIC GPIO pin configuration nodes to be named with
'-state' suffix:

  qcom/msm8996-xiaomi-scorpio.dtb: pmic@0: gpio@c000: 'irled-default', 'keypad-default' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Drop also additional indentation via "pinconf" to make the code a bit
smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi     | 16 +++++++---------
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts     | 16 +++++++---------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 6d6e0fb4d270..78a1977d0593 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -651,15 +651,13 @@ vdd_gfx: s2 {
 };
 
 &pm8994_gpios {
-	irled_default: irled-default {
-		pinconf {
-			pins = "gpio5";
-			function = PMIC_GPIO_FUNC_FUNC1;
-			output-low;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
-			power-source = <PM8994_GPIO_S4>;
-			bias-disable;
-		};
+	irled_default: irled-default-state {
+		pins = "gpio5";
+		function = PMIC_GPIO_FUNC_FUNC1;
+		output-low;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		power-source = <PM8994_GPIO_S4>;
+		bias-disable;
 	};
 
 	wlan_en_default: wlan-en-state {
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
index d287fa77e45a..895050831267 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
@@ -278,15 +278,13 @@ &pm8994_gpios {
 		"UIM_BATT_ALARM",	/* GPIO_21 */
 		"NC";			/* GPIO_22 */
 
-	keypad_default: keypad-default {
-		pinconf {
-			pins = "gpio7", "gpio10";
-			function = PMIC_GPIO_FUNC_FUNC1;
-			output-low;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
-			power-source = <PM8994_GPIO_S4>;
-			bias-disable;
-		};
+	keypad_default: keypad-default-state {
+		pins = "gpio7", "gpio10";
+		function = PMIC_GPIO_FUNC_FUNC1;
+		output-low;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <PM8994_GPIO_S4>;
+		bias-disable;
 	};
 };
 
-- 
2.34.1

