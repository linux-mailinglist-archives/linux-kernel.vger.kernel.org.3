Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0A9573EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbiGMVVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbiGMVVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:21:22 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50833B1D3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:20:47 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso141244fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDIsFRxXwtCqxyONdxF5c1K9paBtFr3+08L7z2qU5vA=;
        b=j6cOJrctkCf7KseVBRdjSV7xlcfNt+7koxFBfEzD+TqfkyzpEbWiMDN5+d1JFAlUR1
         4UWAlA7Y7QVimCdgfMGCV5T5leqdGRaLoe8ws+Uj9fgqQwS4b8SOpsIZtuehvXuI+xQo
         UFJKWvgemXRzSTOEgy/A+jHJpgXoPOrnxi+IEalxaNKcrp0DgtDTmzaU9N6aQ+abSW1S
         IilnnvVXk0xNL9DD52vVgrih36f14uWbKP9rFimyB5zdAH32DVassCoYu35wrNoqLNi7
         lk9demUWCLl4bQ8ke7GM5ZQOmqIJbWNNbduoF8eLZRDgNLeyQB3Ohsx8x5GSTbEkfbnL
         uufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDIsFRxXwtCqxyONdxF5c1K9paBtFr3+08L7z2qU5vA=;
        b=CRs9mxDIO7TaoqnXV0bIhDnr8vqlqUN+yUr9tX1SgeIx0XzrdK9ptZxU6KqU8mezLC
         bRS0fSd5tnmSGOuit6EV5M8Mn6kFbCicLOA2Hudatw/x3md19C9nzIKWLHWx4A10uAcD
         svl1ctt/zbXHyp34z8F5G4444rYJ3vbPptbDYMRzkICukPRYgae66pvAjIN4OzmoseVb
         6o0yKzjg8dMdHefpU5PgrXKwfnnYUFA80aJsUPnvJFW7tAviAuco6dXXqWxxh5uHR9dr
         GQ72RnADg6VBzF2Kc9hF0aijl3ES7aGkZWN0i42EURCRxgl3wQMlFZnzsYsQzAUd2CSe
         lhWQ==
X-Gm-Message-State: AJIora9b4Y2KWOc3qzOpU5+NoAGnih2E3IY8OhZcvO0XB7H8BDLuFZxi
        tIj8Kwn2g777avwNfZ1PsSPrdA==
X-Google-Smtp-Source: AGRyM1tJqqpZcbdmf0IjLs3JPzHYVSJn1XpT0FPSi1cB/Be9qVNnpyy+gRwJUYwTuBP+IukgYZYe8w==
X-Received: by 2002:a05:6870:41ca:b0:101:d588:6241 with SMTP id z10-20020a05687041ca00b00101d5886241mr5611485oac.175.1657747246489;
        Wed, 13 Jul 2022 14:20:46 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i19-20020a056871029300b0010c17e6c699sm6647897oae.47.2022.07.13.14.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:20:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: qcom: msm8974-sony: Enable LPG
Date:   Wed, 13 Jul 2022 14:23:09 -0700
Message-Id: <20220713212309.130230-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713212309.130230-1-bjorn.andersson@linaro.org>
References: <20220713212309.130230-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both Castor and Honami has RGB LEDs driven by the PM8941 LPG, define
these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Corrected unit addresses and sort order of channels

 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   | 30 +++++++++++++++++++
 ...-msm8974pro-sony-xperia-shinano-castor.dts | 30 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index d42b85bda33a..5a70683d9103 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -3,6 +3,7 @@
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
@@ -172,6 +173,35 @@ gpio_keys_pin_a: gpio-keys-active-state {
 	};
 };
 
+&pm8941_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+
+	rgb-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@5 {
+			reg = <5>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+
+		led@6 {
+			reg = <6>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@7 {
+			reg = <7>;
+			color = <LED_COLOR_ID_RED>;
+		};
+	};
+};
+
 &pm8941_wled {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 9fc696a7399a..3f45f5c5d37b 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -3,6 +3,7 @@
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
@@ -288,6 +289,35 @@ lcd_dcdc_en_pin_a: lcd-dcdc-en-active-state {
 
 };
 
+&pm8941_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+
+	rgb-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@5 {
+			reg = <5>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+
+		led@6 {
+			reg = <6>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@7 {
+			reg = <7>;
+			color = <LED_COLOR_ID_RED>;
+		};
+	};
+};
+
 &rpm_requests {
 	pm8941-regulators {
 		compatible = "qcom,rpm-pm8941-regulators";
-- 
2.35.1

