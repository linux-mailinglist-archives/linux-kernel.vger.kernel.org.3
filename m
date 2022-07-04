Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09261565F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiGDVYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiGDVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7E1208C;
        Mon,  4 Jul 2022 14:24:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lw20so18555876ejb.4;
        Mon, 04 Jul 2022 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUw3PSSlRTJ8Siy/LpJ4qyCzqMEIQDLkLGSj0kGh4nM=;
        b=L5Ru2/Iq910N1D2vdLEiHACiTAAlEbrbQY47KcrgJbPqdg0oPPlG5vS1CaIEsxXD4y
         0MZVCtC1+z+S5t6zYDOQoK/sduI4IK6B67hMNMTwepZWlMcqMqisIvkbdVp2WGH0+xzg
         26AMrIJBgWhMxyWyUNjge3ky5FWVlRoVjc1FCqOwOlf6tB3/Mx3r1dln5GeFfXUsI09C
         bKlNCZ6MHbOKN6uCq9zX/iSiw+sQJhqLtkjNa0biRnf7wuwPXBXDISkiXubpEHq2eJm6
         8B9fkTW8tEeTc3Yiti5X+YTTNhMl305hbd4LT6P/TYLKBrtK3RCqaq62/CV9s0tsVUk+
         LO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUw3PSSlRTJ8Siy/LpJ4qyCzqMEIQDLkLGSj0kGh4nM=;
        b=xcsV8OESne1nFO1U43K14uNa20OQOJwbPKUmFbMmxEHwATwUzPp2kShv46HzCYU4Ue
         E8lTNcEbRM7V2IOetrDhw3Y7kw8LK/7+stao8spST7q54mqWqPSkkLAxlspfTfGulKg5
         DBodwKLb530BL+0r05cdVhjN/UQGH/4R/CLJrFrc53RZTJbhSAJ13ABykr4WXaL6GDtU
         HwtbC8DZ1BJd1EgbREVXmSrfLlaJnbNWaw1Ob4ym3wf8NoBX0kJczuJjh3RaTeS5yMz/
         AbU9hqu78BQzGUZzdc51+19nY2JjBUTPNbIVk3WdqcX4INOHMB7XVjFLRCnnCiL/fN6Q
         pgyg==
X-Gm-Message-State: AJIora/idi+t7FRFOrbMxfuo9OwoybC3vcmL7pE121aG8L4QIharbnl6
        E1oovcn8i2NsHnRuutfHRJQ=
X-Google-Smtp-Source: AGRyM1v63nDbrX9Q49PmZPCQ06w390iIO7lnus7X1xPf2Uihbwg56K1h7Osvi1C5xIwBcdL5GBC1nw==
X-Received: by 2002:a17:906:b048:b0:6fe:be4a:3ecf with SMTP id bj8-20020a170906b04800b006febe4a3ecfmr31420321ejb.104.1656969857394;
        Mon, 04 Jul 2022 14:24:17 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:17 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 11/12] arm64: dts: qcom: add PMP8074 DTSI
Date:   Mon,  4 Jul 2022 23:24:01 +0200
Message-Id: <20220704212402.1715182-11-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMP8074 is a companion PMIC to the Qualcomm IPQ8074 series that is
controlled via SPMI.

Add DTSI for it providing GPIO, regulator and RTC support.

RTC is disabled by default as there is no built-in battery so it will
loose time unless board vendor added a battery, so make it optional.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v6:
* Add RTC and GPIO nodes

Changes in v5:
* Remove #address-cells and #size-cells as they are not required for
regulator subnodes
---
 arch/arm64/boot/dts/qcom/pmp8074.dtsi | 125 ++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmp8074.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
new file mode 100644
index 000000000000..a3b395e4d78f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
+&spmi_bus {
+	pmic@0 {
+		compatible = "qcom,pmp8074", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmp8074_adc: adc@3100 {
+			compatible = "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			ref_gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vref_1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vref_vadc@2 {
+				reg = <ADC5_VREF_VADC>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pmic_die: die_temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			xo_therm: xo_temp@76 {
+				reg = <ADC5_XO_THERM_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pa_therm1: thermistor1@77 {
+				reg = <ADC5_AMUX_THM1_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pa_therm2: thermistor2@78 {
+				reg = <ADC5_AMUX_THM2_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pa_therm3: thermistor3@79 {
+				reg = <ADC5_AMUX_THM3_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vph_pwr@131 {
+				reg = <ADC5_VPH_PWR>;
+				qcom,pre-scaling = <1 3>;
+			};
+		};
+
+		pmp8074_rtc: rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+			allow-set-time;
+			status = "disabled";
+		};
+
+		pmp8074_gpios: gpio@c000 {
+			compatible = "qcom,pmp8074-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmp8074_gpios 0 0 12>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pmp8074", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+
+		regulators {
+			compatible = "qcom,pmp8074-regulators";
+
+			s3: s3 {
+				regulator-name = "vdd_s3";
+				regulator-min-microvolt = <592000>;
+				regulator-max-microvolt = <1064000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			s4: s4 {
+				regulator-name = "vdd_s4";
+				regulator-min-microvolt = <712000>;
+				regulator-max-microvolt = <992000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			l11: l11 {
+				regulator-name = "l11";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
-- 
2.36.1

