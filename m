Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5058E85F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiHJIF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHJIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:05:25 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E4718E00
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:05:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f20so20121141lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SY2OoAfsF4MYoa6h99uP/2obN/ZrDWllYHQX/C3kJVA=;
        b=FxhZVAucdj6VN0wr124P8kxAetiDiR8K0mOn6xHu5BJEA6s/S5v8/6kaWpBnS3CIaL
         lsf6WiwciuriDdNCoqEsf42dfhWqvR9/7xzbPT9euUR7mu1+TiSouF4+Ox+1LvRI+2Xn
         kL1Htd3LRxYBfZiwHtbReA3BAr6Ho20lHQwT4lrsR9XxamIUHAmKPaDpe7d+pKN6RGIr
         YQgrPIrkx18+v26Vh1gFXdL+nh2n1N0+kpwx8TKHJFbgcZ3qi0p/SWVznImxKYnZU8t5
         Gvp7AcYHuj+Dx+4TslOGxFIKakVbGxdZx7gyMoKzogi+uQ6Nr1JO38bjNJU7Jh0nHPll
         NtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SY2OoAfsF4MYoa6h99uP/2obN/ZrDWllYHQX/C3kJVA=;
        b=csrz5LLxyQxEvD6Nr3yIF6lmngkptLUnwTygHctOGa/3PJmWTVyfed3Pnp9u4aHu1R
         WIsg7KdpXSw6s8lJv2km4SVLvn6B+m4T4O8TnCs6gtzHFnT5XpaieDnUqndwhnmKze1W
         g8i/ILCWzc0CZhm3WTUUbdElkXZOIUWmysUzNL3PzDwah190vnzVmfe29Ps8gid7jZwB
         ZYmedxEEwIOkaIUvoUXnkWLfEZIPfIG9XccRykGizE0t6G5Zz31xCvhF8a2j1fK3sIOb
         ejixzF9KeHS/DmkeEy5SDtAffPWD1ag0DvaNzhEkgjzHetliqWQOnyF+58gUL7+wVldP
         aaUA==
X-Gm-Message-State: ACgBeo3MfQyg9GGkIyWg8grQY5pHtByVcPzcnBusTiFHa+4XHGCCa49d
        w2KNTVOQ5ev41Cr7aiuvwZlRIQ==
X-Google-Smtp-Source: AA6agR5ZxuXXlNZZnrf9zYBhLagTd8As9w8sPTAJKg/pEve75aXcYls4AGYGlb56gislzWrg/3OkWA==
X-Received: by 2002:a05:6512:3342:b0:48b:4178:e8a5 with SMTP id y2-20020a056512334200b0048b4178e8a5mr7706400lfd.43.1660118719855;
        Wed, 10 Aug 2022 01:05:19 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h12-20020a2ea48c000000b0025e040510e7sm309571lji.74.2022.08.10.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 01:05:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ARM: dts: qcom: msm8960: override nodes by label
Date:   Wed, 10 Aug 2022 11:05:13 +0300
Message-Id: <20220810080516.166866-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Using node paths to extend or override a device tree node is error
prone.  If there was a typo error, a new node will be created instead of
extending the existing node.  This will lead to run-time errors that
could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).  This also reduces the indentation making the code
easier to read.

The pre/post DTBS are the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 623 ++++++++++++-------------
 arch/arm/boot/dts/qcom-msm8960.dtsi    |   6 +-
 2 files changed, 314 insertions(+), 315 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index d1fd0fe12ffe..9157e3c4f48f 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -15,318 +15,6 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	soc {
-		gsbi@16400000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_I2C_UART>;
-			serial@16440000 {
-				status = "okay";
-			};
-		};
-
-		amba {
-			/* eMMC */
-			sdcc1: mmc@12400000 {
-				status = "okay";
-			};
-
-			/* External micro SD card */
-			sdcc3: mmc@12180000 {
-				status = "okay";
-			};
-		};
-
-		rpm@108000 {
-			regulators {
-				compatible = "qcom,rpm-pm8921-regulators";
-				vin_lvs1_3_6-supply = <&pm8921_s4>;
-				vin_lvs2-supply = <&pm8921_s4>;
-				vin_lvs4_5_7-supply = <&pm8921_s4>;
-				vdd_ncp-supply = <&pm8921_l6>;
-				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
-				vdd_l21_l23_l29-supply = <&pm8921_s8>;
-				vdd_l24-supply = <&pm8921_s1>;
-				vdd_l25-supply = <&pm8921_s1>;
-				vdd_l27-supply = <&pm8921_s7>;
-				vdd_l28-supply = <&pm8921_s7>;
-
-				/* Buck SMPS */
-				pm8921_s1: s1 {
-					regulator-always-on;
-					regulator-min-microvolt = <1225000>;
-					regulator-max-microvolt = <1225000>;
-					qcom,switch-mode-frequency = <3200000>;
-					bias-pull-down;
-				};
-
-				pm8921_s2: s2 {
-					regulator-min-microvolt = <1300000>;
-					regulator-max-microvolt = <1300000>;
-					qcom,switch-mode-frequency = <1600000>;
-					bias-pull-down;
-				};
-
-				pm8921_s3: s3 {
-					regulator-min-microvolt = <500000>;
-					regulator-max-microvolt = <1150000>;
-					qcom,switch-mode-frequency = <4800000>;
-					bias-pull-down;
-				};
-
-				pm8921_s4: s4 {
-					regulator-always-on;
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					qcom,switch-mode-frequency = <1600000>;
-					bias-pull-down;
-					qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
-				};
-
-				pm8921_s7: s7 {
-					regulator-min-microvolt = <1150000>;
-					regulator-max-microvolt = <1150000>;
-					qcom,switch-mode-frequency = <3200000>;
-					bias-pull-down;
-				};
-
-				pm8921_s8: s8 {
-					regulator-always-on;
-					regulator-min-microvolt = <2050000>;
-					regulator-max-microvolt = <2050000>;
-					qcom,switch-mode-frequency = <1600000>;
-					bias-pull-down;
-				};
-
-				/* PMOS LDO */
-				pm8921_l1: l1 {
-					regulator-always-on;
-					regulator-min-microvolt = <1050000>;
-					regulator-max-microvolt = <1050000>;
-					bias-pull-down;
-				};
-
-				pm8921_l2: l2 {
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					bias-pull-down;
-				};
-
-				pm8921_l3: l3 {
-					regulator-min-microvolt = <3075000>;
-					regulator-max-microvolt = <3075000>;
-					bias-pull-down;
-				};
-
-				pm8921_l4: l4 {
-					regulator-always-on;
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					bias-pull-down;
-				};
-
-				pm8921_l5: l5 {
-					regulator-min-microvolt = <2950000>;
-					regulator-max-microvolt = <2950000>;
-					bias-pull-down;
-				};
-
-				pm8921_l6: l6 {
-					regulator-min-microvolt = <2950000>;
-					regulator-max-microvolt = <2950000>;
-					bias-pull-down;
-				};
-
-				pm8921_l7: l7 {
-					regulator-always-on;
-					regulator-min-microvolt = <1850000>;
-					regulator-max-microvolt = <2950000>;
-					bias-pull-down;
-				};
-
-				pm8921_l8: l8 {
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <3000000>;
-					bias-pull-down;
-				};
-
-				pm8921_l9: l9 {
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3000000>;
-					bias-pull-down;
-				};
-
-				pm8921_l10: l10 {
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3000000>;
-					bias-pull-down;
-				};
-
-				pm8921_l11: l11 {
-					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <2850000>;
-					bias-pull-down;
-				};
-
-				pm8921_l12: l12 {
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					bias-pull-down;
-				};
-
-				pm8921_l14: l14 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					bias-pull-down;
-				};
-
-				pm8921_l15: l15 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <2950000>;
-					bias-pull-down;
-				};
-
-				pm8921_l16: l16 {
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					bias-pull-down;
-				};
-
-				pm8921_l17: l17 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <2950000>;
-					bias-pull-down;
-				};
-
-				pm8921_l18: l18 {
-					regulator-min-microvolt = <1300000>;
-					regulator-max-microvolt = <1300000>;
-					bias-pull-down;
-				};
-
-				pm8921_l21: l21 {
-					regulator-min-microvolt = <1900000>;
-					regulator-max-microvolt = <1900000>;
-					bias-pull-down;
-				};
-
-				pm8921_l22: l22 {
-					regulator-min-microvolt = <2750000>;
-					regulator-max-microvolt = <2750000>;
-					bias-pull-down;
-				};
-
-				pm8921_l23: l23 {
-					regulator-always-on;
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					bias-pull-down;
-				};
-
-				pm8921_l24: l24 {
-					regulator-min-microvolt = <750000>;
-					regulator-max-microvolt = <1150000>;
-					bias-pull-down;
-				};
-
-				pm8921_l25: l25 {
-					regulator-always-on;
-					regulator-min-microvolt = <1250000>;
-					regulator-max-microvolt = <1250000>;
-					bias-pull-down;
-				};
-
-				/* Low Voltage Switch */
-				pm8921_lvs1: lvs1 {
-					bias-pull-down;
-				};
-
-				pm8921_lvs2: lvs2 {
-					bias-pull-down;
-				};
-
-				pm8921_lvs3: lvs3 {
-					bias-pull-down;
-				};
-
-				pm8921_lvs4: lvs4 {
-					bias-pull-down;
-				};
-
-				pm8921_lvs5: lvs5 {
-					bias-pull-down;
-				};
-
-				pm8921_lvs6: lvs6 {
-					bias-pull-down;
-				};
-
-				pm8921_lvs7: lvs7 {
-					bias-pull-down;
-				};
-
-				pm8921_ncp: ncp {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					qcom,switch-mode-frequency = <1600000>;
-				};
-			};
-		};
-
-		gsbi@16000000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_SPI>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&spi1_default>;
-			spi@16080000 {
-				status = "okay";
-				ethernet@0 {
-					compatible = "micrel,ks8851";
-					reg = <0>;
-					interrupt-parent = <&msmgpio>;
-					interrupts = <90 8>;
-					spi-max-frequency = <5400000>;
-					vdd-supply = <&ext_l2>;
-					vdd-io-supply = <&pm8921_lvs6>;
-					reset-gpios = <&msmgpio 89 0>;
-				};
-			};
-		};
-
-		pinctrl@800000 {
-			spi1_default: spi1_default {
-				mux {
-					pins = "gpio6", "gpio7", "gpio9";
-					function = "gsbi1";
-				};
-
-				mosi {
-					pins = "gpio6";
-					drive-strength = <12>;
-					bias-disable;
-				};
-
-				miso {
-					pins = "gpio7";
-					drive-strength = <12>;
-					bias-disable;
-				};
-
-				cs {
-					pins = "gpio8";
-					drive-strength = <12>;
-					bias-disable;
-					output-low;
-				};
-
-				clk {
-					pins = "gpio9";
-					drive-strength = <12>;
-					bias-disable;
-				};
-			};
-		};
-	};
-
 	regulators {
 		compatible = "simple-bus";
 
@@ -340,6 +28,71 @@ ext_l2: gpio-regulator@91 {
 	};
 };
 
+&gsbi1 {
+	qcom,mode = <GSBI_PROT_SPI>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_default>;
+	status = "okay";
+};
+
+&gsbi1_spi {
+	status = "okay";
+
+	ethernet@0 {
+		compatible = "micrel,ks8851";
+		reg = <0>;
+		interrupt-parent = <&msmgpio>;
+		interrupts = <90 8>;
+		spi-max-frequency = <5400000>;
+		vdd-supply = <&ext_l2>;
+		vdd-io-supply = <&pm8921_lvs6>;
+		reset-gpios = <&msmgpio 89 0>;
+	};
+};
+
+&gsbi5 {
+	qcom,mode = <GSBI_PROT_I2C_UART>;
+	status = "okay";
+};
+
+&gsbi5_serial {
+	status = "okay";
+};
+
+&msmgpio {
+	spi1_default: spi1_default {
+		 mux {
+			pins = "gpio6", "gpio7", "gpio9";
+			function = "gsbi1";
+		 };
+
+		 mosi {
+			pins = "gpio6";
+			drive-strength = <12>;
+			bias-disable;
+		 };
+
+		 miso {
+			pins = "gpio7";
+			drive-strength = <12>;
+			bias-disable;
+		 };
+
+		 cs {
+			pins = "gpio8";
+			drive-strength = <12>;
+			bias-disable;
+			output-low;
+		 };
+
+		 clk {
+			pins = "gpio9";
+			drive-strength = <12>;
+			bias-disable;
+		 };
+	};
+};
+
 &pmicintc {
 	keypad@148 {
 		linux,keymap = <
@@ -352,3 +105,249 @@ MATRIX_KEY(0, 3, KEY_CAMERA)
 		keypad,num-columns = <5>;
 	};
 };
+
+&rpm {
+	regulators {
+		compatible = "qcom,rpm-pm8921-regulators";
+		vin_lvs1_3_6-supply = <&pm8921_s4>;
+		vin_lvs2-supply = <&pm8921_s4>;
+		vin_lvs4_5_7-supply = <&pm8921_s4>;
+		vdd_ncp-supply = <&pm8921_l6>;
+		vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+		vdd_l21_l23_l29-supply = <&pm8921_s8>;
+		vdd_l24-supply = <&pm8921_s1>;
+		vdd_l25-supply = <&pm8921_s1>;
+		vdd_l27-supply = <&pm8921_s7>;
+		vdd_l28-supply = <&pm8921_s7>;
+
+		/* Buck SMPS */
+		pm8921_s1: s1 {
+			regulator-always-on;
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+			qcom,switch-mode-frequency = <3200000>;
+			bias-pull-down;
+		};
+
+		pm8921_s2: s2 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			qcom,switch-mode-frequency = <1600000>;
+			bias-pull-down;
+		};
+
+		pm8921_s3: s3 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1150000>;
+			qcom,switch-mode-frequency = <4800000>;
+			bias-pull-down;
+		};
+
+		pm8921_s4: s4 {
+			regulator-always-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			qcom,switch-mode-frequency = <1600000>;
+			bias-pull-down;
+			qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
+		};
+
+		pm8921_s7: s7 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+			qcom,switch-mode-frequency = <3200000>;
+			bias-pull-down;
+		};
+
+		pm8921_s8: s8 {
+			regulator-always-on;
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+			qcom,switch-mode-frequency = <1600000>;
+			bias-pull-down;
+		};
+
+		/* PMOS LDO */
+		pm8921_l1: l1 {
+			regulator-always-on;
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			bias-pull-down;
+		};
+
+		pm8921_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			bias-pull-down;
+		};
+
+		pm8921_l3: l3 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+			bias-pull-down;
+		};
+
+		pm8921_l4: l4 {
+			regulator-always-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			bias-pull-down;
+		};
+
+		pm8921_l5: l5 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l6: l6 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l7: l7 {
+			regulator-always-on;
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l8: l8 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+			bias-pull-down;
+		};
+
+		pm8921_l9: l9 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			bias-pull-down;
+		};
+
+		pm8921_l10: l10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			bias-pull-down;
+		};
+
+		pm8921_l11: l11 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+			bias-pull-down;
+		};
+
+		pm8921_l12: l12 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			bias-pull-down;
+		};
+
+		pm8921_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			bias-pull-down;
+		};
+
+		pm8921_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l16: l16 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			bias-pull-down;
+		};
+
+		pm8921_l17: l17 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+			bias-pull-down;
+		};
+
+		pm8921_l18: l18 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			bias-pull-down;
+		};
+
+		pm8921_l21: l21 {
+			regulator-min-microvolt = <1900000>;
+			regulator-max-microvolt = <1900000>;
+			bias-pull-down;
+		};
+
+		pm8921_l22: l22 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+			bias-pull-down;
+		};
+
+		pm8921_l23: l23 {
+			regulator-always-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			bias-pull-down;
+		};
+
+		pm8921_l24: l24 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1150000>;
+			bias-pull-down;
+		};
+
+		pm8921_l25: l25 {
+			regulator-always-on;
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <1250000>;
+			bias-pull-down;
+		};
+
+		/* Low Voltage Switch */
+		pm8921_lvs1: lvs1 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs2: lvs2 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs3: lvs3 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs4: lvs4 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs5: lvs5 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs6: lvs6 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs7: lvs7 {
+			bias-pull-down;
+		};
+
+		pm8921_ncp: ncp {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			qcom,switch-mode-frequency = <1600000>;
+		};
+	};
+};
+
+/* eMMC */
+&sdcc1 {
+	status = "okay";
+};
+
+/* External micro SD card */
+&sdcc3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 19554f3b5196..a5f1eda707b5 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -152,7 +152,7 @@ l2cc: clock-controller@2011000 {
 			reg = <0x2011000 0x1000>;
 		};
 
-		rpm@108000 {
+		rpm: rpm@108000 {
 			compatible = "qcom,rpm-msm8960";
 			reg = <0x108000 0x1000>;
 			qcom,ipc = <&l2cc 0x8 2>;
@@ -307,7 +307,7 @@ tcsr: syscon@1a400000 {
 			reg = <0x1a400000 0x100>;
 		};
 
-		gsbi@16000000 {
+		gsbi1: gsbi@16000000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <1>;
 			reg = <0x16000000 0x100>;
@@ -317,7 +317,7 @@ gsbi@16000000 {
 			#size-cells = <1>;
 			ranges;
 
-			spi@16080000 {
+			gsbi1_spi: spi@16080000 {
 				compatible = "qcom,spi-qup-v1.1.1";
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.34.1

