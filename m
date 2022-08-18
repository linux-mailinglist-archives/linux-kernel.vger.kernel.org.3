Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF829599074
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbiHRWSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbiHRWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:18:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D2422F4;
        Thu, 18 Aug 2022 15:18:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b16so3570043edd.4;
        Thu, 18 Aug 2022 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=51WkINtcJCwwZeTUq8gJb/7vQB3zosS0zhRrac+XlkA=;
        b=WX2MKH/oITajh7YgxK6UcGZZPvGAjMPfOCTvt9UEFj0oG45r/R3a87IQ/1mOgCibUx
         uX7VTXQCxP1DpOnjMi4t3p3WwtE9l6ojWoB5L0xsWZrNIauioIW39yodh2wj42nHXXG7
         kq4MsvfgT6bOjUKl4kveePprTto4ZI8xTSpFCtFyBz96i0fQ2sNYBHOlOMb5kIdCVDDc
         MH+tNmXMFcrfn61GHMfv9IOgf2Zl69DVJ15GbP/Gs470NU0y9He/dZdaZWavexJAwcYK
         5Jt4/sEQm36+r+o0kS0UkSx4WzOCw3drLLPTZzD4etI6V2y7OAwE58M1NfoCH21QpbO3
         8cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=51WkINtcJCwwZeTUq8gJb/7vQB3zosS0zhRrac+XlkA=;
        b=qmtViPymLpRKCOgD6mrhim6PVBOGZO4dxloLJPBmZwr4Tql/M2z1SrKvIHCpN8gnAI
         /koFyIXCDVxtGcq5IlKmu5vPMSEMuQjN15CegfqIOEDzuMXGMZZJQLgecHMwEwNMjDMI
         pSstxRAZW58ewZgzkO+h0tpWrw1uJ8pu2FV0y/LAKPZ5WYsj0k/6kSXOgxNINBtsVYKo
         KEXyykaYfREfQwceLTSFKE4DZ3CuHbuj26Ky+/HZAE/Hz75qxHSDCvpkrVbbHjE0Gt2o
         +PcynkOFhpB+/7SogTCoURxTXaxPWbBM3UCSaJHaIJxwOn6WL7LEz49akuGPArUosx7u
         +Jpg==
X-Gm-Message-State: ACgBeo0n2WjKGz15EQItHm7+zahGGYbLx39Rt2jGK8Hnml9fYlLnwKJ/
        o7K90Xo9ekyXhDmpaLiNCzk=
X-Google-Smtp-Source: AA6agR7z3fTHjKGGciJeJMpkyqAJDuQJ60lx9PoffTbI9ylIW2U2ckFqm1JvoRMHMSAeXUrtXTuUVg==
X-Received: by 2002:aa7:d94a:0:b0:446:3372:9eba with SMTP id l10-20020aa7d94a000000b0044633729ebamr892768eds.170.1660861101771;
        Thu, 18 Aug 2022 15:18:21 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id t19-20020a1709060c5300b00731747c3107sm1378315ejf.73.2022.08.18.15.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:18:21 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v8 4/5] arm64: dts: qcom: add PMP8074 DTSI
Date:   Fri, 19 Aug 2022 00:18:14 +0200
Message-Id: <20220818221815.346233-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818221815.346233-1-robimarko@gmail.com>
References: <20220818221815.346233-1-robimarko@gmail.com>
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

Add DTSI for it providing GPIO, regulator, RTC and VADC support.

RTC is disabled by default as there is no built-in battery so it will
loose time unless board vendor added a battery, so make it optional.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v7:
* Dual license with BSD-3-Clause
* Use "-" instead of underscores in node names

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
index 000000000000..ceb2e6358b3d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
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
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			vref-vadc@2 {
+				reg = <ADC5_VREF_VADC>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pmic_die: die-temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+			};
+
+			xo_therm: xo-temp@76 {
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
+			vph-pwr@131 {
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
2.37.2

