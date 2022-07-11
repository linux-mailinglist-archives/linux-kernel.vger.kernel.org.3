Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF124570C04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGKUeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiGKUeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:34:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA07C3C8C4;
        Mon, 11 Jul 2022 13:34:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so7683239edc.4;
        Mon, 11 Jul 2022 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0aSwXJIcrACGMlyewZxFZJyC++87UB/pbC0lVzOZtM=;
        b=OM5+95mYy5o9YfxP6JQTAlQJUcYVhSDF9+PwlwZWebnB8RVciywfe2ejkaYZy3fcVb
         aGArOoZzDnLL038wsi7cU7O0mzbKLPm/qEtm8r+vt94Wdb8GwFKul5/eZUOf0MXmpx8V
         tTw5CsUr//97zv2ezQ4xDOaSdTAlHwHNpv6TyerTuJoos28B+/zfu1ITGSAj/fcZ1qtT
         /xUan8ef4oIACC0mKPRfbTQlKDbaH0v/n9TSgg+a9lV59CgfMqW+o5DNmFjV64fZxGxV
         xkVP1xKhbC7y0tl3LjtEYIWN4a2jOUY2NmRqHBWWc/TwPcXsEPpY9ovxELw9R2y+6zFr
         7Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0aSwXJIcrACGMlyewZxFZJyC++87UB/pbC0lVzOZtM=;
        b=aF96n1gds5MrXnDdFlHWbQpczdZFY6fq6ZM1G+wi52q79MFLHupWY2DQGAmG4Szm81
         FaYJhJgq689IYiGho7lag0Q+pxL5aTaYBVDoD0N8/YBapOg/C90dWoYPBhnVegRFU8CN
         GzdR7YNBIGSap7MjYEQA0rHKew8UdUT8zkHlurv4JoKYZH2hyIOXmvv77ChNkbgzo5yC
         Nlp1o4KrpcW8gUf+/84kVfJsSLId3MLuWuoPNg6CDEYFV/fcn14U3rI41MNRNTSUpWh0
         mDY3Q1mC2Qs/TA3FItPJehdJ2Obo7z7MMwsSLmGouPJuvJuFBUOlxy8gwwrXw3MouSSW
         5mrQ==
X-Gm-Message-State: AJIora9SYYJscVuGf7QCWojmOAg59n4NPEpzOuZ1mDLJF6ghGfbdIpKU
        L6vmFupDafF/h41H1U6McPLJs2VEhumZTw==
X-Google-Smtp-Source: AGRyM1tseyB/rmWgIKwNo6wZG/VLPHedoory/InQsLNVR2RGQFrjA4+KC7kxBCo2pNZTNYxyKfLYCg==
X-Received: by 2002:aa7:d143:0:b0:43a:88f4:4ec1 with SMTP id r3-20020aa7d143000000b0043a88f44ec1mr27736811edo.141.1657571658543;
        Mon, 11 Jul 2022 13:34:18 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id l11-20020a056402124b00b0043a422801f8sm4936264edw.87.2022.07.11.13.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:34:18 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, jic23@kernel.org, lars@metafoo.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 6/7] arm64: dts: qcom: add PMP8074 DTSI
Date:   Mon, 11 Jul 2022 22:34:07 +0200
Message-Id: <20220711203408.2949888-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711203408.2949888-1-robimarko@gmail.com>
References: <20220711203408.2949888-1-robimarko@gmail.com>
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
2.36.1

