Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE0B4EFAE2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351805AbiDAUM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351712AbiDAUMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:12:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E9F21C074
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so4657919ejd.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUOVTelyybMbf5KREcp+WAToMZfPKCMger9ffEIgN3w=;
        b=Z+qOH/vJ/5x+18peisUe/O109HWwVCqO0jSz6iYYSjh3IAL/YlNV3fGNYWc/3/4GLE
         3LNAsFzCTZcCodP3XNIrB5IUdWiuw6QGGY1xim1Hr7QsCAuAeZKFmcC7wN4h1IasB8cy
         kfcyrx6aRBv0vddp/NBubj1bH/BS3P1za5M2g2NwncNzmE1wqBrFGVBaFGTBNl+Kt8qd
         dz/ajAZZm/6Dv+MVPQma2xGhXH/XBF1BWbZPBg8pRn1yhqCxQI/PEIuB6oNyirGqtcd+
         P0ydsw/kW8KRebU9IwuVZM2iK9tISYWqvA+F15WCfxM8cJoag6Z7q3MkdapDJ7DvXO1b
         IzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUOVTelyybMbf5KREcp+WAToMZfPKCMger9ffEIgN3w=;
        b=oAC7qIro0U2/W5bN50CmJ84mV1pw/3FTCmYgRJ5ninc10cEykTzeTXBsk0vFxtgFMb
         GJ7A4iWs7qRLdh9TGk5b5mlwSoNau0gG92aFuCYics0BTjwSWQ01ah6/pH3Mo8zOg3Mh
         Q4I9OsDeZGxs6s5nroPUTcBjdZaXyQ5VVOj8t7p3QY+XmAlL5tln+vYg+YMTnH4nE0J8
         7t9bq/Qv4NcVMP7uCmEJ5aFjMpDkPmVxRV06weAiH3QSLJtqureml6Eepw8WmfN8RADE
         twE5QBpmeRKLPcaZ8bJqs2v5JI7eE3M/r+rfdgZGzHV+Awt0587LAL6+Nh2woQXchsmv
         DnfA==
X-Gm-Message-State: AOAM532BZQk+HNZZWb9Z/rbp2Mv/HpgkutnRre44jWh5zALY1WOJ+hAC
        cWl6+2ps6Bc3gcB6n4uakPTb4w==
X-Google-Smtp-Source: ABdhPJxd+xQdXWK9Nhphj6GuURL9a9z4/opWshsIHpZlIcl/V8QfpwcFDqH5lvRVVOJoK69Te6HroQ==
X-Received: by 2002:a17:906:d554:b0:6df:c373:9e5f with SMTP id cr20-20020a170906d55400b006dfc3739e5fmr1173864ejc.645.1648843850275;
        Fri, 01 Apr 2022 13:10:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1509041edb.27.2022.04.01.13.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:10:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/10] ARM: dts: qcom: msm8974: override nodes by label
Date:   Fri,  1 Apr 2022 22:10:31 +0200
Message-Id: <20220401201035.189106-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
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

Using node paths to extend or override a device tree node is error
prone.  If there was a typo error, a new node will be created instead of
extending the existing node.  This will lead to run-time errors that
could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).  This also reduces the indentation making the code
easier to read.

Re-order the overrides by label name.  The pre/post DTBS are the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts |  614 +++++-----
 .../boot/dts/qcom-msm8974-fairphone-fp2.dts   |  581 +++++----
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 1075 ++++++++--------
 .../boot/dts/qcom-msm8974-samsung-klte.dts    | 1083 ++++++++---------
 .../dts/qcom-msm8974-sony-xperia-amami.dts    |  569 +++++----
 .../dts/qcom-msm8974-sony-xperia-castor.dts   |  908 +++++++-------
 .../dts/qcom-msm8974-sony-xperia-honami.dts   |  636 +++++-----
 arch/arm/boot/dts/qcom-msm8974.dtsi           |   16 +-
 8 files changed, 2730 insertions(+), 2752 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 83793b835d40..4c510701ff83 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -17,330 +17,324 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	soc {
-		serial@f991e000 {
-			status = "okay";
+};
+
+&blsp_i2c11 {
+	status = "okay";
+	clock-frequency = <200000>;
+	pinctrl-0 = <&i2c11_pins>;
+	pinctrl-names = "default";
+
+	eeprom: eeprom@52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+		pagesize = <32>;
+		read-only;
+	};
+};
+
+&blsp1_uart2 {
+	status = "okay";
+};
+
+&msmgpio {
+	i2c11_pins: i2c11 {
+		mux {
+			pins = "gpio83", "gpio84";
+			function = "blsp_i2c11";
 		};
+	};
 
-		sdhci@f9824900 {
-			bus-width = <8>;
-			non-removable;
-			status = "okay";
+	spi8_default: spi8_default {
+		mosi {
+			pins = "gpio45";
+			function = "blsp_spi8";
+		};
+		miso {
+			pins = "gpio46";
+			function = "blsp_spi8";
+		};
+		cs {
+			pins = "gpio47";
+			function = "blsp_spi8";
+		};
+		clk {
+			pins = "gpio48";
+			function = "blsp_spi8";
+		};
+	};
 
-			vmmc-supply = <&pm8941_l20>;
-			vqmmc-supply = <&pm8941_s3>;
+	sdhc1_pin_a: sdhc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strength = <16>;
+			bias-disable;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&sdhc1_pin_a>;
+		cmd-data {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <10>;
+			bias-pull-up;
 		};
+	};
 
-		sdhci@f98a4900 {
-			cd-gpios = <&msmgpio 62 0x1>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
-			bus-width = <4>;
-			status = "okay";
+	sdhc2_cd_pin_a: sdhc2-cd-pin-active {
+		pins = "gpio62";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
 
-			vmmc-supply = <&pm8941_l21>;
-			vqmmc-supply = <&pm8941_l13>;
+	sdhc2_pin_a: sdhc2-pin-active {
+		clk {
+			pins = "sdc2_clk";
+			drive-strength = <10>;
+			bias-disable;
 		};
 
-		usb@f9a55000 {
-			status = "okay";
-			phys = <&usb_hs2_phy>;
-			phy-select = <&tcsr 0xb000 1>;
-			extcon = <&smbb>, <&usb_id>;
-			vbus-supply = <&chg_otg>;
-			hnp-disable;
-			srp-disable;
-			adp-disable;
-			ulpi {
-				phy@b {
-					status = "okay";
-					v3p3-supply = <&pm8941_l24>;
-					v1p8-supply = <&pm8941_l6>;
-					extcon = <&smbb>;
-					qcom,init-seq = /bits/ 8 <0x1 0x63>;
-				};
-			};
-		};
-
-
-		pinctrl@fd510000 {
-			i2c11_pins: i2c11 {
-				mux {
-					pins = "gpio83", "gpio84";
-					function = "blsp_i2c11";
-				};
-			};
-
-			spi8_default: spi8_default {
-				mosi {
-					pins = "gpio45";
-					function = "blsp_spi8";
-				};
-				miso {
-					pins = "gpio46";
-					function = "blsp_spi8";
-				};
-				cs {
-					pins = "gpio47";
-					function = "blsp_spi8";
-				};
-				clk {
-					pins = "gpio48";
-					function = "blsp_spi8";
-				};
-			};
-
-			sdhc1_pin_a: sdhc1-pin-active {
-				clk {
-					pins = "sdc1_clk";
-					drive-strength = <16>;
-					bias-disable;
-				};
-
-				cmd-data {
-					pins = "sdc1_cmd", "sdc1_data";
-					drive-strength = <10>;
-					bias-pull-up;
-				};
-			};
-
-			sdhc2_cd_pin_a: sdhc2-cd-pin-active {
-				pins = "gpio62";
-				function = "gpio";
-
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			sdhc2_pin_a: sdhc2-pin-active {
-				clk {
-					pins = "sdc2_clk";
-					drive-strength = <10>;
-					bias-disable;
-				};
-
-				cmd-data {
-					pins = "sdc2_cmd", "sdc2_data";
-					drive-strength = <6>;
-					bias-pull-up;
-				};
-			};
-		};
-
-		i2c@f9967000 {
+		cmd-data {
+			pins = "sdc2_cmd", "sdc2_data";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+};
+
+&otg {
+	status = "okay";
+	phys = <&usb_hs2_phy>;
+	phy-select = <&tcsr 0xb000 1>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	ulpi {
+		phy@b {
 			status = "okay";
-			clock-frequency = <200000>;
-			pinctrl-0 = <&i2c11_pins>;
-			pinctrl-names = "default";
+			v3p3-supply = <&pm8941_l24>;
+			v1p8-supply = <&pm8941_l6>;
+			extcon = <&smbb>;
+			qcom,init-seq = /bits/ 8 <0x1 0x63>;
+		};
+	};
+};
+
+&rpm_requests {
+	pm8841-regulators {
+		s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-			eeprom: eeprom@52 {
-				compatible = "atmel,24c128";
-				reg = <0x52>;
-				pagesize = <32>;
-				read-only;
-			};
+		s2 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		s3 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		s4 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
 		};
 	};
 
-	smd {
-		rpm {
-			rpm_requests {
-				pm8841-regulators {
-					s1 {
-						regulator-min-microvolt = <675000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s2 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s3 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s4 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-				};
-
-				pm8941-regulators {
-					vdd_l1_l3-supply = <&pm8941_s1>;
-					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-					vdd_l4_l11-supply = <&pm8941_s1>;
-					vdd_l5_l7-supply = <&pm8941_s2>;
-					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
-					vin_5vs-supply = <&pm8941_5v>;
-
-					s1 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s2 {
-						regulator-min-microvolt = <2150000>;
-						regulator-max-microvolt = <2150000>;
-						regulator-boot-on;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l1 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l2 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l3 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l4 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l5 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l6 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l7 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l8 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l9 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l10 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-						regulator-always-on;
-					};
-
-					l11 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-					};
-
-					l12 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l13 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l14 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l15 {
-						regulator-min-microvolt = <2050000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					l16 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l17 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l18 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l19 {
-						regulator-min-microvolt = <3300000>;
-						regulator-max-microvolt = <3300000>;
-						regulator-always-on;
-					};
-
-					l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-allow-set-load;
-						regulator-boot-on;
-						regulator-system-load = <200000>;
-					};
-
-					l21 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l22 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					l23 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					l24 {
-						regulator-min-microvolt = <3075000>;
-						regulator-max-microvolt = <3075000>;
-
-						regulator-boot-on;
-					};
-				};
-			};
+	pm8941-regulators {
+		vdd_l1_l3-supply = <&pm8941_s1>;
+		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+		vdd_l4_l11-supply = <&pm8941_s1>;
+		vdd_l5_l7-supply = <&pm8941_s2>;
+		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+		vin_5vs-supply = <&pm8941_5v>;
+
+		s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+			regulator-boot-on;
+		};
+
+		s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		l3 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-boot-on;
+		};
+
+		l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-boot-on;
+		};
+
+		l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		l11 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
+		};
+
+		l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+
+		l17 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+
+		l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		l19 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-allow-set-load;
+			regulator-boot-on;
+			regulator-system-load = <200000>;
+		};
+
+		l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
+		};
+
+		l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+
+			regulator-boot-on;
 		};
 	};
 };
+
+&sdhci1 {
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+};
+
+&sdhci3 {
+	cd-gpios = <&msmgpio 62 0x1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+	bus-width = <4>;
+	status = "okay";
+
+	vmmc-supply = <&pm8941_l21>;
+	vqmmc-supply = <&pm8941_l13>;
+};
diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
index 6d77e0f8ca4d..f72a53a0e962 100644
--- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
@@ -55,345 +55,340 @@ vibrator {
 		vcc-supply = <&pm8941_l18>;
 	};
 
-	smd {
-		rpm {
-			rpm_requests {
-				pm8841-regulators {
-					s1 {
-						regulator-min-microvolt = <675000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s2 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1050000>;
-						regulator-max-microvolt = <1050000>;
-					};
-				};
-
-				pm8941-regulators {
-					vdd_l1_l3-supply = <&pm8941_s1>;
-					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-					vdd_l4_l11-supply = <&pm8941_s1>;
-					vdd_l5_l7-supply = <&pm8941_s2>;
-					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
-					vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
-					vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
-					vdd_l21-supply = <&vreg_boost>;
-
-					s1 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s2 {
-						regulator-min-microvolt = <2150000>;
-						regulator-max-microvolt = <2150000>;
-
-						regulator-boot-on;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l1 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l2 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l3 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l4 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l5 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l6 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l7 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l8 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l9 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l10 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l11 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1350000>;
-					};
-
-					l12 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l13 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l14 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l15 {
-						regulator-min-microvolt = <2050000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					l16 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l17 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l18 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l19 {
-						regulator-min-microvolt = <2900000>;
-						regulator-max-microvolt = <3350000>;
-					};
-
-					l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-						regulator-system-load = <200000>;
-						regulator-allow-set-load;
-					};
-
-					l21 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l22 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					l23 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					l24 {
-						regulator-min-microvolt = <3075000>;
-						regulator-max-microvolt = <3075000>;
-
-						regulator-boot-on;
-					};
-				};
-			};
+};
+
+&blsp1_uart2 {
+	status = "okay";
+};
+
+&imem {
+	status = "okay";
+
+	reboot-mode {
+		mode-normal	= <0x77665501>;
+		mode-bootloader	= <0x77665500>;
+		mode-recovery	= <0x77665502>;
+	};
+};
+
+&msmgpio {
+	sdhc1_pin_a: sdhc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		cmd-data {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <10>;
+			bias-pull-up;
+		};
+	};
+
+	sdhc2_pin_a: sdhc2-pin-active {
+		clk {
+			pins = "sdc2_clk";
+			drive-strength = <10>;
+			bias-disable;
+		};
+
+		cmd-data {
+			pins = "sdc2_cmd", "sdc2_data";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
+	wcnss_pin_a: wcnss-pin-active {
+		wlan {
+			pins =  "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
+			function = "wlan";
+
+			drive-strength = <6>;
+			bias-pull-down;
+		};
+
+		bt {
+			pins = "gpio35", "gpio43", "gpio44";
+			function = "bt";
+
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		fm {
+			pins = "gpio41", "gpio42";
+			function = "fm";
+
+			drive-strength = <2>;
+			bias-pull-down;
 		};
 	};
 };
 
-&soc {
-	serial@f991e000 {
-		status = "okay";
+&otg {
+	status = "okay";
+
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+
+	ulpi {
+		phy@a {
+			status = "okay";
+
+			v1p8-supply = <&pm8941_l6>;
+			v3p3-supply = <&pm8941_l24>;
+
+			extcon = <&smbb>;
+			qcom,init-seq = /bits/ 8 <0x1 0x64>;
+		};
 	};
+};
 
-	remoteproc@fb21b000 {
-		status = "okay";
+&pronto {
+	status = "okay";
 
-		vddmx-supply = <&pm8841_s1>;
-		vddcx-supply = <&pm8841_s2>;
+	vddmx-supply = <&pm8841_s1>;
+	vddcx-supply = <&pm8841_s2>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&wcnss_pin_a>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&wcnss_pin_a>;
 
-		smd-edge {
-			qcom,remote-pid = <4>;
-			label = "pronto";
+	smd-edge {
+		qcom,remote-pid = <4>;
+		label = "pronto";
 
-			wcnss {
-				status = "okay";
-			};
+		wcnss {
+			status = "okay";
 		};
 	};
+};
 
-	pinctrl@fd510000 {
-		sdhc1_pin_a: sdhc1-pin-active {
-			clk {
-				pins = "sdc1_clk";
-				drive-strength = <16>;
-				bias-disable;
-			};
+&rpm_requests {
+	pm8841-regulators {
+		s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-			cmd-data {
-				pins = "sdc1_cmd", "sdc1_data";
-				drive-strength = <10>;
-				bias-pull-up;
-			};
+		s2 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
 		};
 
-		sdhc2_pin_a: sdhc2-pin-active {
-			clk {
-				pins = "sdc2_clk";
-				drive-strength = <10>;
-				bias-disable;
-			};
+		s3 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+		};
+	};
 
-			cmd-data {
-				pins = "sdc2_cmd", "sdc2_data";
-				drive-strength = <6>;
-				bias-pull-up;
-			};
+	pm8941-regulators {
+		vdd_l1_l3-supply = <&pm8941_s1>;
+		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+		vdd_l4_l11-supply = <&pm8941_s1>;
+		vdd_l5_l7-supply = <&pm8941_s2>;
+		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+		vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
+		vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
+		vdd_l21-supply = <&vreg_boost>;
+
+		s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
-		wcnss_pin_a: wcnss-pin-active {
-			wlan {
-				pins =  "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
-				function = "wlan";
+		s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
 
-				drive-strength = <6>;
-				bias-pull-down;
-			};
+			regulator-boot-on;
+		};
 
-			bt {
-				pins = "gpio35", "gpio43", "gpio44";
-				function = "bt";
+		s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-				drive-strength = <2>;
-				bias-pull-down;
-			};
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			fm {
-				pins = "gpio41", "gpio42";
-				function = "fm";
+		l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
 
-				drive-strength = <2>;
-				bias-pull-down;
-			};
+			regulator-always-on;
+			regulator-boot-on;
 		};
-	};
 
-	sdhci@f9824900 {
-		status = "okay";
+		l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
 
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
+		l3 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-		bus-width = <8>;
-		non-removable;
+		l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc1_pin_a>;
-	};
+		l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-	sdhci@f98a4900 {
-		status = "okay";
+		l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-		vmmc-supply = <&pm8941_l21>;
-		vqmmc-supply = <&pm8941_l13>;
+			regulator-boot-on;
+		};
 
-		bus-width = <4>;
+		l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc2_pin_a>;
-	};
+			regulator-boot-on;
+		};
+
+		l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
 
-	usb@f9a55000 {
-		status = "okay";
+		l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
 
-		phys = <&usb_hs1_phy>;
-		phy-select = <&tcsr 0xb000 0>;
-		extcon = <&smbb>, <&usb_id>;
-		vbus-supply = <&chg_otg>;
+		l11 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1350000>;
+		};
 
-		hnp-disable;
-		srp-disable;
-		adp-disable;
+		l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-		ulpi {
-			phy@a {
-				status = "okay";
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-				v1p8-supply = <&pm8941_l6>;
-				v3p3-supply = <&pm8941_l24>;
+		l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
 
-				extcon = <&smbb>;
-				qcom,init-seq = /bits/ 8 <0x1 0x64>;
-			};
+			regulator-boot-on;
 		};
-	};
 
-	imem@fe805000 {
-		status = "okay";
+		l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+
+		l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
 
-		reboot-mode {
-			mode-normal	= <0x77665501>;
-			mode-bootloader	= <0x77665500>;
-			mode-recovery	= <0x77665502>;
+		l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		l19 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+		};
+
+		l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
+		};
+
+		l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+
+			regulator-boot-on;
 		};
 	};
 };
 
+&sdhci1 {
+	status = "okay";
+
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	bus-width = <8>;
+	non-removable;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+};
+
+&sdhci3 {
+	status = "okay";
+
+	vmmc-supply = <&pm8941_l21>;
+	vqmmc-supply = <&pm8941_l13>;
+
+	bus-width = <4>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc2_pin_a>;
+};
+
 &spmi_bus {
 	pm8941@0 {
 		gpios@c000 {
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 6d5fb60e798f..a72ef21b2fc7 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -40,209 +40,6 @@ volume-down {
 		};
 	};
 
-	smd {
-		rpm {
-			rpm_requests {
-				pm8841-regulators {
-					s1 {
-						regulator-min-microvolt = <675000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s2 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1050000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s4 {
-						regulator-min-microvolt = <815000>;
-						regulator-max-microvolt = <900000>;
-					};
-				};
-
-				pm8941-regulators {
-					vdd_l1_l3-supply = <&pm8941_s1>;
-					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-					vdd_l4_l11-supply = <&pm8941_s1>;
-					vdd_l5_l7-supply = <&pm8941_s2>;
-					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
-					vdd_l8_l16_l18_l19-supply = <&vreg_vph_pwr>;
-					vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
-					vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
-					vdd_l21-supply = <&vreg_boost>;
-
-					s1 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s2 {
-						regulator-min-microvolt = <2150000>;
-						regulator-max-microvolt = <2150000>;
-
-						regulator-boot-on;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l1 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l2 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l3 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l4 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l5 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l6 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l7 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l8 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l9 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l10 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l11 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-					};
-
-					l12 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l13 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l14 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l15 {
-						regulator-min-microvolt = <2050000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					l16 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l17 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l18 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l19 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-						regulator-system-load = <200000>;
-						regulator-allow-set-load;
-					};
-
-					l21 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l22 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					l23 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					l24 {
-						regulator-min-microvolt = <3075000>;
-						regulator-max-microvolt = <3075000>;
-
-						regulator-boot-on;
-					};
-				};
-			};
-		};
-	};
-
 	vreg_wlan: wlan-regulator {
 		compatible = "regulator-fixed";
 
@@ -256,464 +53,682 @@ vreg_wlan: wlan-regulator {
 		pinctrl-names = "default";
 		pinctrl-0 = <&wlan_regulator_pin>;
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pin_a>;
+
+		volume-up {
+			label = "volume_up";
+			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		volume-down {
+			label = "volume_down";
+			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
 };
 
-&soc {
-	serial@f991d000 {
-		status = "okay";
+&blsp1_uart1 {
+	status = "okay";
+};
+
+&blsp2_uart10 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp2_uart10_pin_a>;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pin>;
+
+		host-wakeup-gpios = <&msmgpio 42 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&msmgpio 62 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&msmgpio 41 GPIO_ACTIVE_HIGH>;
 	};
+};
 
-	pinctrl@fd510000 {
-		sdhc1_pin_a: sdhc1-pin-active {
-			clk {
-				pins = "sdc1_clk";
-				drive-strength = <16>;
-				bias-disable;
-			};
+&blsp_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	clock-frequency = <100000>;
+	qcom,src-freq = <50000000>;
 
-			cmd-data {
-				pins = "sdc1_cmd", "sdc1_data";
-				drive-strength = <10>;
-				bias-pull-up;
-			};
+	charger: bq24192@6b {
+		compatible = "ti,bq24192";
+		reg = <0x6b>;
+		interrupts-extended = <&spmi_bus 0 0xd5 0 IRQ_TYPE_EDGE_FALLING>;
+
+		omit-battery-class;
+
+		usb_otg_vbus: usb-otg-vbus { };
+	};
+
+	fuelgauge: max17048@36 {
+		compatible = "maxim,max17048";
+		reg = <0x36>;
+
+		maxim,double-soc;
+		maxim,rcomp = /bits/ 8 <0x4d>;
+
+		interrupt-parent = <&msmgpio>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&fuelgauge_pin>;
+
+		maxim,alert-low-soc-level = <2>;
+	};
+};
+
+&blsp_i2c2 {
+	status = "okay";
+
+	clock-frequency = <355000>;
+	qcom,src-freq = <50000000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
+	synaptics@70 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x70>;
+
+		interrupts-extended = <&msmgpio 5 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8941_l22>;
+		vio-supply = <&pm8941_lvs3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pin>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <1>;
 		};
 
-		sdhc2_pin_a: sdhc2-pin-active {
-			clk {
-				pins = "sdc2_clk";
-				drive-strength = <6>;
-				bias-disable;
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+		};
+	};
+};
+
+&blsp_i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <100000>;
+	qcom,src-freq = <50000000>;
+
+	avago_apds993@39 {
+		compatible = "avago,apds9930";
+		reg = <0x39>;
+		interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8941_l17>;
+		vddio-supply = <&pm8941_lvs1>;
+		led-max-microamp = <100000>;
+		amstaos,proximity-diodes = <0>;
+	};
+};
+
+&blsp_i2c11 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c11_pins>;
+	clock-frequency = <355000>;
+	qcom,src-freq = <50000000>;
+
+	led-controller@38 {
+		compatible = "ti,lm3630a";
+		status = "okay";
+		reg = <0x38>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			led-sources = <0 1>;
+			label = "lcd-backlight";
+			default-brightness = <200>;
+		};
+	};
+};
+
+&blsp_i2c12 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c12_pins>;
+	clock-frequency = <100000>;
+	qcom,src-freq = <50000000>;
+
+	mpu6515@68 {
+		compatible = "invensense,mpu6515";
+		reg = <0x68>;
+		interrupts-extended = <&msmgpio 73 IRQ_TYPE_EDGE_FALLING>;
+		vddio-supply = <&pm8941_lvs1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&mpu6515_pin>;
+
+		mount-matrix = "0", "-1", "0",
+			       "-1", "0", "0",
+			       "0", "0", "1";
+
+		i2c-gate {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ak8963@f {
+				compatible = "asahi-kasei,ak8963";
+				reg = <0x0f>;
+				gpios = <&msmgpio 67 0>;
+				vid-supply = <&pm8941_lvs1>;
+				vdd-supply = <&pm8941_l17>;
 			};
 
-			cmd-data {
-				pins = "sdc2_cmd", "sdc2_data";
-				drive-strength = <6>;
-				bias-pull-up;
+			bmp280@76 {
+				compatible = "bosch,bmp280";
+				reg = <0x76>;
+				vdda-supply = <&pm8941_lvs1>;
+				vddd-supply = <&pm8941_l17>;
 			};
 		};
+	};
+};
 
-		i2c1_pins: i2c1 {
-			mux {
-				pins = "gpio2", "gpio3";
-				function = "blsp_i2c1";
+&msmgpio {
+	sdhc1_pin_a: sdhc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strength = <16>;
+			bias-disable;
+		};
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+		cmd-data {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <10>;
+			bias-pull-up;
 		};
+	};
 
-		i2c2_pins: i2c2 {
-			mux {
-				pins = "gpio6", "gpio7";
-				function = "blsp_i2c2";
+	sdhc2_pin_a: sdhc2-pin-active {
+		clk {
+			pins = "sdc2_clk";
+			drive-strength = <6>;
+			bias-disable;
+		};
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+		cmd-data {
+			pins = "sdc2_cmd", "sdc2_data";
+			drive-strength = <6>;
+			bias-pull-up;
 		};
+	};
 
-		i2c3_pins: i2c3 {
-			mux {
-				pins = "gpio10", "gpio11";
-				function = "blsp_i2c3";
-				drive-strength = <2>;
-				bias-disable;
-			};
+	i2c1_pins: i2c1 {
+		mux {
+			pins = "gpio2", "gpio3";
+			function = "blsp_i2c1";
+
+			drive-strength = <2>;
+			bias-disable;
 		};
+	};
 
-		i2c11_pins: i2c11 {
-			mux {
-				pins = "gpio83", "gpio84";
-				function = "blsp_i2c11";
+	i2c2_pins: i2c2 {
+		mux {
+			pins = "gpio6", "gpio7";
+			function = "blsp_i2c2";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+			drive-strength = <2>;
+			bias-disable;
 		};
+	};
 
-		i2c12_pins: i2c12 {
-			mux {
-				pins = "gpio87", "gpio88";
-				function = "blsp_i2c12";
-				drive-strength = <2>;
-				bias-disable;
-			};
+	i2c3_pins: i2c3 {
+		mux {
+			pins = "gpio10", "gpio11";
+			function = "blsp_i2c3";
+			drive-strength = <2>;
+			bias-disable;
 		};
+	};
 
-		mpu6515_pin: mpu6515 {
-			irq {
-				pins = "gpio73";
-				function = "gpio";
-				bias-disable;
-				input-enable;
-			};
+	i2c11_pins: i2c11 {
+		mux {
+			pins = "gpio83", "gpio84";
+			function = "blsp_i2c11";
+
+			drive-strength = <2>;
+			bias-disable;
 		};
+	};
 
-		touch_pin: touch {
-			int {
-				pins = "gpio5";
-				function = "gpio";
+	i2c12_pins: i2c12 {
+		mux {
+			pins = "gpio87", "gpio88";
+			function = "blsp_i2c12";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-				drive-strength = <2>;
-				bias-disable;
-				input-enable;
-			};
+	mpu6515_pin: mpu6515 {
+		irq {
+			pins = "gpio73";
+			function = "gpio";
+			bias-disable;
+			input-enable;
+		};
+	};
 
-			reset {
-				pins = "gpio8";
-				function = "gpio";
+	touch_pin: touch {
+		int {
+			pins = "gpio5";
+			function = "gpio";
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+			drive-strength = <2>;
+			bias-disable;
+			input-enable;
 		};
 
-		panel_pin: panel {
-			te {
-				pins = "gpio12";
-				function = "mdp_vsync";
+		reset {
+			pins = "gpio8";
+			function = "gpio";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+			drive-strength = <2>;
+			bias-pull-up;
 		};
+	};
 
-		bt_pin: bt {
-			hostwake {
-				pins = "gpio42";
-				function = "gpio";
-			};
+	panel_pin: panel {
+		te {
+			pins = "gpio12";
+			function = "mdp_vsync";
 
-			devwake {
-				pins = "gpio62";
-				function = "gpio";
-			};
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-			shutdown {
-				pins = "gpio41";
-				function = "gpio";
-			};
+	bt_pin: bt {
+		hostwake {
+			pins = "gpio42";
+			function = "gpio";
 		};
 
-		blsp2_uart10_pin_a: blsp2-uart10-pin-active {
-			tx {
-				pins = "gpio53";
-				function = "blsp_uart10";
+		devwake {
+			pins = "gpio62";
+			function = "gpio";
+		};
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+		shutdown {
+			pins = "gpio41";
+			function = "gpio";
+		};
+	};
 
-			rx {
-				pins = "gpio54";
-				function = "blsp_uart10";
+	blsp2_uart10_pin_a: blsp2-uart10-pin-active {
+		tx {
+			pins = "gpio53";
+			function = "blsp_uart10";
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+			drive-strength = <2>;
+			bias-disable;
+		};
 
-			cts {
-				pins = "gpio55";
-				function = "blsp_uart10";
+		rx {
+			pins = "gpio54";
+			function = "blsp_uart10";
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+			drive-strength = <2>;
+			bias-pull-up;
+		};
 
-			rts {
-				pins = "gpio56";
-				function = "blsp_uart10";
+		cts {
+			pins = "gpio55";
+			function = "blsp_uart10";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+			drive-strength = <2>;
+			bias-pull-up;
 		};
-	};
 
-	sdhci@f9824900 {
-		status = "okay";
+		rts {
+			pins = "gpio56";
+			function = "blsp_uart10";
 
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+};
 
-		bus-width = <8>;
-		non-removable;
+&mdss {
+	status = "okay";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc1_pin_a>;
+	mdp@fd900000 {
+		status = "okay";
 	};
 
-	sdhci@f98a4900 {
+	dsi@fd922800 {
 		status = "okay";
 
-		max-frequency = <100000000>;
-		bus-width = <4>;
-		non-removable;
-		vmmc-supply = <&vreg_wlan>;
-		vqmmc-supply = <&pm8941_s3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc2_pin_a>;
+		vdda-supply = <&pm8941_l2>;
+		vdd-supply = <&pm8941_lvs3>;
+		vddio-supply = <&pm8941_l12>;
 
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		bcrmf@1 {
-			compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
-			reg = <1>;
+		ports {
+			port@1 {
+				endpoint {
+					remote-endpoint = <&panel_in>;
+					data-lanes = <0 1 2 3>;
+				};
+			};
+		};
 
-			brcm,drive-strength = <10>;
+		panel: panel@0 {
+			reg = <0>;
+			compatible = "lg,acx467akm-7";
 
 			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_sleep_clk_pin>;
+			pinctrl-0 = <&panel_pin>;
+
+			port {
+				panel_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
 		};
 	};
 
-	serial@f9960000 {
+	dsi-phy@fd922a00 {
 		status = "okay";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&blsp2_uart10_pin_a>;
+		vddio-supply = <&pm8941_l12>;
+	};
+};
 
-		bluetooth {
-			compatible = "brcm,bcm43438-bt";
-			max-speed = <3000000>;
+&otg {
+	status = "okay";
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&bt_pin>;
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
 
-			host-wakeup-gpios = <&msmgpio 42 GPIO_ACTIVE_HIGH>;
-			device-wakeup-gpios = <&msmgpio 62 GPIO_ACTIVE_HIGH>;
-			shutdown-gpios = <&msmgpio 41 GPIO_ACTIVE_HIGH>;
-		};
-	};
+	extcon = <&charger>, <&usb_id>;
+	vbus-supply = <&usb_otg_vbus>;
 
-	i2c@f9967000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c11_pins>;
-		clock-frequency = <355000>;
-		qcom,src-freq = <50000000>;
+	hnp-disable;
+	srp-disable;
+	adp-disable;
 
-		led-controller@38 {
-			compatible = "ti,lm3630a";
+	ulpi {
+		phy@a {
 			status = "okay";
-			reg = <0x38>;
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+			v1p8-supply = <&pm8941_l6>;
+			v3p3-supply = <&pm8941_l24>;
 
-			led@0 {
-				reg = <0>;
-				led-sources = <0 1>;
-				label = "lcd-backlight";
-				default-brightness = <200>;
-			};
+			qcom,init-seq = /bits/ 8 <0x1 0x64>;
 		};
 	};
+};
 
-	i2c@f9968000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c12_pins>;
-		clock-frequency = <100000>;
-		qcom,src-freq = <50000000>;
+&rpm_requests {
+	pm8841-regulators {
+		s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-		mpu6515@68 {
-			compatible = "invensense,mpu6515";
-			reg = <0x68>;
-			interrupts-extended = <&msmgpio 73 IRQ_TYPE_EDGE_FALLING>;
-			vddio-supply = <&pm8941_lvs1>;
+		s2 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&mpu6515_pin>;
-
-			mount-matrix = "0", "-1", "0",
-				       "-1", "0", "0",
-				       "0", "0", "1";
-
-			i2c-gate {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ak8963@f {
-					compatible = "asahi-kasei,ak8963";
-					reg = <0x0f>;
-					gpios = <&msmgpio 67 0>;
-					vid-supply = <&pm8941_lvs1>;
-					vdd-supply = <&pm8941_l17>;
-				};
+		s3 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-				bmp280@76 {
-					compatible = "bosch,bmp280";
-					reg = <0x76>;
-					vdda-supply = <&pm8941_lvs1>;
-					vddd-supply = <&pm8941_l17>;
-				};
-			};
+		s4 {
+			regulator-min-microvolt = <815000>;
+			regulator-max-microvolt = <900000>;
 		};
 	};
 
-	i2c@f9923000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_pins>;
-		clock-frequency = <100000>;
-		qcom,src-freq = <50000000>;
-
-		charger: bq24192@6b {
-			compatible = "ti,bq24192";
-			reg = <0x6b>;
-			interrupts-extended = <&spmi_bus 0 0xd5 0 IRQ_TYPE_EDGE_FALLING>;
+	pm8941-regulators {
+		vdd_l1_l3-supply = <&pm8941_s1>;
+		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+		vdd_l4_l11-supply = <&pm8941_s1>;
+		vdd_l5_l7-supply = <&pm8941_s2>;
+		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+		vdd_l8_l16_l18_l19-supply = <&vreg_vph_pwr>;
+		vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
+		vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
+		vdd_l21-supply = <&vreg_boost>;
+
+		s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			omit-battery-class;
+		s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
 
-			usb_otg_vbus: usb-otg-vbus { };
+			regulator-boot-on;
 		};
 
-		fuelgauge: max17048@36 {
-			compatible = "maxim,max17048";
-			reg = <0x36>;
+		s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-			maxim,double-soc;
-			maxim,rcomp = /bits/ 8 <0x4d>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			interrupt-parent = <&msmgpio>;
-			interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+		l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&fuelgauge_pin>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			maxim,alert-low-soc-level = <2>;
+		l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
 		};
-	};
 
-	i2c@f9924000 {
-		status = "okay";
+		l3 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-		clock-frequency = <355000>;
-		qcom,src-freq = <50000000>;
+		l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_pins>;
+		l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-		synaptics@70 {
-			compatible = "syna,rmi4-i2c";
-			reg = <0x70>;
+		l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-			interrupts-extended = <&msmgpio 5 IRQ_TYPE_EDGE_FALLING>;
-			vdd-supply = <&pm8941_l22>;
-			vio-supply = <&pm8941_lvs3>;
+			regulator-boot-on;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&touch_pin>;
+		l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+			regulator-boot-on;
+		};
 
-			rmi4-f01@1 {
-				reg = <0x1>;
-				syna,nosleep-mode = <1>;
-			};
+		l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			rmi4-f12@12 {
-				reg = <0x12>;
-				syna,sensor-type = <1>;
-			};
+		l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
 		};
-	};
 
-	i2c@f9925000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c3_pins>;
-		clock-frequency = <100000>;
-		qcom,src-freq = <50000000>;
+		l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
 
-		avago_apds993@39 {
-			compatible = "avago,apds9930";
-			reg = <0x39>;
-			interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
-			vdd-supply = <&pm8941_l17>;
-			vddio-supply = <&pm8941_lvs1>;
-			led-max-microamp = <100000>;
-			amstaos,proximity-diodes = <0>;
+		l11 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
 		};
-	};
 
-	usb@f9a55000 {
-		status = "okay";
+		l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-		phys = <&usb_hs1_phy>;
-		phy-select = <&tcsr 0xb000 0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-		extcon = <&charger>, <&usb_id>;
-		vbus-supply = <&usb_otg_vbus>;
+		l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
 
-		hnp-disable;
-		srp-disable;
-		adp-disable;
+			regulator-boot-on;
+		};
 
-		ulpi {
-			phy@a {
-				status = "okay";
+		l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-				v1p8-supply = <&pm8941_l6>;
-				v3p3-supply = <&pm8941_l24>;
+		l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
 
-				qcom,init-seq = /bits/ 8 <0x1 0x64>;
-			};
+		l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
 		};
-	};
 
-	mdss@fd900000 {
-		status = "okay";
+		l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
 
-		mdp@fd900000 {
-			status = "okay";
+		l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
 		};
 
-		dsi@fd922800 {
-			status = "okay";
+		l19 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
 
-			vdda-supply = <&pm8941_l2>;
-			vdd-supply = <&pm8941_lvs3>;
-			vddio-supply = <&pm8941_l12>;
+		l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+			regulator-boot-on;
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+		};
 
-			ports {
-				port@1 {
-					endpoint {
-						remote-endpoint = <&panel_in>;
-						data-lanes = <0 1 2 3>;
-					};
-				};
-			};
+		l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
 
-			panel: panel@0 {
-				reg = <0>;
-				compatible = "lg,acx467akm-7";
+			regulator-boot-on;
+		};
 
-				pinctrl-names = "default";
-				pinctrl-0 = <&panel_pin>;
+		l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
 
-				port {
-					panel_in: endpoint {
-						remote-endpoint = <&dsi0_out>;
-					};
-				};
-			};
+		l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
 		};
 
-		dsi-phy@fd922a00 {
-			status = "okay";
+		l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
 
-			vddio-supply = <&pm8941_l12>;
+			regulator-boot-on;
 		};
 	};
 };
 
+&sdhci1 {
+	status = "okay";
+
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	bus-width = <8>;
+	non-removable;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+};
+
+&sdhci3 {
+	status = "okay";
+
+	max-frequency = <100000000>;
+	bus-width = <4>;
+	non-removable;
+	vmmc-supply = <&vreg_wlan>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc2_pin_a>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bcrmf@1 {
+		compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+
+		brcm,drive-strength = <10>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_sleep_clk_pin>;
+	};
+};
+
 &spmi_bus {
 	pm8941@0 {
 		gpios@c000 {
diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
index 6e036a440532..ffa31625de17 100644
--- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
@@ -12,8 +12,8 @@ / {
 
 	aliases {
 		serial0 = &blsp1_uart1;
-		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
-		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		mmc0 = &sdhci1; /* SDC1 eMMC slot */
+		mmc1 = &sdhci2; /* SDC2 SD card slot */
 	};
 
 	chosen {
@@ -52,197 +52,6 @@ volume-up {
 		};
 	};
 
-	smd {
-		rpm {
-			rpm_requests {
-				pma8084-regulators {
-					compatible = "qcom,rpm-pma8084-regulators";
-					status = "okay";
-
-					pma8084_s1: s1 {
-						regulator-min-microvolt = <675000>;
-						regulator-max-microvolt = <1050000>;
-						regulator-always-on;
-					};
-
-					pma8084_s2: s2 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					pma8084_s3: s3 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-					};
-
-					pma8084_s4: s4 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					pma8084_s5: s5 {
-						regulator-min-microvolt = <2150000>;
-						regulator-max-microvolt = <2150000>;
-					};
-
-					pma8084_s6: s6 {
-						regulator-min-microvolt = <1050000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					pma8084_l1: l1 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					pma8084_l2: l2 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					pma8084_l3: l3 {
-						regulator-min-microvolt = <1050000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					pma8084_l4: l4 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					pma8084_l5: l5 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					pma8084_l6: l6 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					pma8084_l7: l7 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					pma8084_l8: l8 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					pma8084_l9: l9 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					pma8084_l10: l10 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					pma8084_l11: l11 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-					};
-
-					pma8084_l12: l12 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-						regulator-always-on;
-					};
-
-					pma8084_l13: l13 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					pma8084_l14: l14 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					pma8084_l15: l15 {
-						regulator-min-microvolt = <2050000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					pma8084_l16: l16 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					pma8084_l17: l17 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					pma8084_l18: l18 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					pma8084_l19: l19 {
-						regulator-min-microvolt = <3300000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					pma8084_l20: l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-allow-set-load;
-						regulator-system-load = <200000>;
-					};
-
-					pma8084_l21: l21 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-allow-set-load;
-						regulator-system-load = <200000>;
-					};
-
-					pma8084_l22: l22 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					pma8084_l23: l23 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					pma8084_l24: l24 {
-						regulator-min-microvolt = <3075000>;
-						regulator-max-microvolt = <3075000>;
-					};
-
-					pma8084_l25: l25 {
-						regulator-min-microvolt = <2100000>;
-						regulator-max-microvolt = <2100000>;
-					};
-
-					pma8084_l26: l26 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					pma8084_l27: l27 {
-						regulator-min-microvolt = <1000000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					pma8084_lvs1: lvs1 {};
-					pma8084_lvs2: lvs2 {};
-					pma8084_lvs3: lvs3 {};
-					pma8084_lvs4: lvs4 {};
-
-					pma8084_5vs1: 5vs1 {};
-				};
-			};
-		};
-	};
-
 	i2c-gpio-touchkey {
 		compatible = "i2c-gpio";
 		#address-cells = <1>;
@@ -353,493 +162,677 @@ adsp-pil {
 	};
 };
 
-&soc {
-	serial@f991e000 {
-		status = "okay";
-	};
+&blsp_i2c2 {
+	status = "okay";
 
-	/* blsp2_uart8 */
-	serial@f995e000 {
-		status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
 
-		pinctrl-names = "default", "sleep";
-		pinctrl-0 = <&blsp2_uart8_pins_active>;
-		pinctrl-1 = <&blsp2_uart8_pins_sleep>;
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
 
-		bluetooth {
-			compatible = "brcm,bcm43540-bt";
-			max-speed = <3000000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&bt_pins>;
-			device-wakeup-gpios = <&msmgpio 91 GPIO_ACTIVE_HIGH>;
-			shutdown-gpios = <&gpio_expander 9 GPIO_ACTIVE_HIGH>;
-			interrupt-parent = <&msmgpio>;
-			interrupts = <75 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "host-wakeup";
-		};
-	};
+		interrupt-parent = <&pma8084_gpios>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
 
-	pinctrl@fd510000 {
-		blsp2_uart8_pins_active: blsp2-uart8-pins-active {
-			pins = "gpio45", "gpio46", "gpio47", "gpio48";
-			function = "blsp_uart8";
-			drive-strength = <8>;
-			bias-disable;
+		vdd-supply = <&max77826_ldo13>;
+		vio-supply = <&pma8084_lvs2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pin>;
+
+		syna,startup-delay-ms = <100>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <1>;
 		};
 
-		blsp2_uart8_pins_sleep: blsp2-uart8-pins-sleep {
-			pins = "gpio45", "gpio46", "gpio47", "gpio48";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-pull-down;
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
 		};
+	};
+};
 
-		bt_pins: bt-pins {
-			hostwake {
-				pins = "gpio75";
-				function = "gpio";
-				drive-strength = <16>;
-				input-enable;
+&blsp_i2c6 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+
+	pmic@60 {
+		reg = <0x60>;
+		compatible = "maxim,max77826";
+
+		regulators {
+			max77826_ldo1: LDO1 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
 			};
 
-			devwake {
-				pins = "gpio91";
-				function = "gpio";
-				drive-strength = <2>;
+			max77826_ldo2: LDO2 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
 			};
-		};
 
-		sdhc1_pin_a: sdhc1-pin-active {
-			clk {
-				pins = "sdc1_clk";
-				drive-strength = <4>;
-				bias-disable;
+			max77826_ldo3: LDO3 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
 			};
 
-			cmd-data {
-				pins = "sdc1_cmd", "sdc1_data";
-				drive-strength = <4>;
-				bias-pull-up;
+			max77826_ldo4: LDO4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 			};
-		};
 
-		sdhc2_pin_a: sdhc2-pin-active {
-			clk-cmd-data {
-				pins = "gpio35", "gpio36", "gpio37", "gpio38",
-					"gpio39", "gpio40";
-				function = "sdc3";
-				drive-strength = <8>;
-				bias-disable;
+			max77826_ldo5: LDO5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 			};
-		};
 
-		sdhc2_cd_pin: sdhc2-cd {
-			pins = "gpio62";
-			function = "gpio";
+			max77826_ldo6: LDO6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
 
-			drive-strength = <2>;
-			bias-disable;
-		};
+			max77826_ldo7: LDO7 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
 
-		sdhc3_pin_a: sdhc3-pin-active {
-			clk {
-				pins = "sdc2_clk";
-				drive-strength = <6>;
-				bias-disable;
+			max77826_ldo8: LDO8 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 			};
 
-			cmd-data {
-				pins = "sdc2_cmd", "sdc2_data";
-				drive-strength = <6>;
-				bias-pull-up;
+			max77826_ldo9: LDO9 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 			};
-		};
 
-		i2c2_pins: i2c2 {
-			mux {
-				pins = "gpio6", "gpio7";
-				function = "blsp_i2c2";
+			max77826_ldo10: LDO10 {
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2950000>;
+			};
 
-				drive-strength = <2>;
-				bias-disable;
+			max77826_ldo11: LDO11 {
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <2950000>;
 			};
-		};
 
-		i2c6_pins: i2c6 {
-			mux {
-				pins = "gpio29", "gpio30";
-				function = "blsp_i2c6";
+			max77826_ldo12: LDO12 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+			};
 
-				drive-strength = <2>;
-				bias-disable;
+			max77826_ldo13: LDO13 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 			};
-		};
 
-		i2c12_pins: i2c12 {
-			mux {
-				pins = "gpio87", "gpio88";
-				function = "blsp_i2c12";
+			max77826_ldo14: LDO14 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
 
-				drive-strength = <2>;
-				bias-disable;
+			max77826_ldo15: LDO15 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 			};
-		};
 
-		i2c_touchkey_pins: i2c-touchkey {
-			mux {
-				pins = "gpio95", "gpio96";
-				function = "gpio";
-				input-enable;
-				bias-pull-up;
+			max77826_buck: BUCK {
+				regulator-min-microvolt = <1225000>;
+				regulator-max-microvolt = <1225000>;
 			};
-		};
 
-		i2c_led_gpioex_pins: i2c-led-gpioex {
-			mux {
-				pins = "gpio120", "gpio121";
-				function = "gpio";
-				input-enable;
-				bias-pull-down;
+			max77826_buckboost: BUCKBOOST {
+				regulator-min-microvolt = <3400000>;
+				regulator-max-microvolt = <3400000>;
 			};
 		};
+	};
+};
 
-		gpioex_pin: gpioex {
-			res {
-				pins = "gpio145";
-				function = "gpio";
+&blsp_i2c12 {
+	status = "okay";
 
-				bias-pull-up;
-				drive-strength = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c12_pins>;
+
+	fuelgauge@36 {
+		compatible = "maxim,max17048";
+		reg = <0x36>;
+
+		maxim,double-soc;
+		maxim,rcomp = /bits/ 8 <0x56>;
+
+		interrupt-parent = <&pma8084_gpios>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&fuelgauge_pin>;
+	};
+};
+
+&blsp1_uart2 {
+	status = "okay";
+};
+
+&blsp2_uart8 {
+	status = "okay";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart8_pins_active>;
+	pinctrl-1 = <&blsp2_uart8_pins_sleep>;
+
+	bluetooth {
+		compatible = "brcm,bcm43540-bt";
+		max-speed = <3000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pins>;
+		device-wakeup-gpios = <&msmgpio 91 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio_expander 9 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&msmgpio>;
+		interrupts = <75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wakeup";
+	};
+};
+
+&gpu {
+	status = "ok";
+};
+
+&mdss {
+	status = "ok";
+
+	mdp@fd900000 {
+		status = "ok";
+	};
+
+	dsi@fd922800 {
+		status = "ok";
+
+		vdda-supply = <&pma8084_l2>;
+		vdd-supply = <&pma8084_l22>;
+		vddio-supply = <&pma8084_l12>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			port@1 {
+				endpoint {
+					remote-endpoint = <&panel_in>;
+					data-lanes = <0 1 2 3>;
+				};
 			};
 		};
 
-		wifi_pin: wifi {
-			int {
-				pins = "gpio92";
-				function = "gpio";
+		panel: panel@0 {
+			reg = <0>;
+			compatible = "samsung,s6e3fa2";
 
-				input-enable;
-				bias-pull-down;
+			pinctrl-names = "default";
+			pinctrl-0 = <&panel_te_pin &panel_rst_pin>;
+
+			iovdd-supply = <&pma8084_lvs4>;
+			vddr-supply = <&vreg_panel>;
+
+			reset-gpios = <&pma8084_gpios 17 GPIO_ACTIVE_LOW>;
+			te-gpios = <&msmgpio 12 GPIO_ACTIVE_HIGH>;
+
+			port {
+				panel_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
 			};
 		};
+	};
 
-		panel_te_pin: panel {
-			te {
-				pins = "gpio12";
-				function = "mdp_vsync";
+	dsi-phy@fd922a00 {
+		status = "ok";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+		vddio-supply = <&pma8084_l12>;
+	};
+};
+
+&msmgpio {
+	blsp2_uart8_pins_active: blsp2-uart8-pins-active {
+		pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		function = "blsp_uart8";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	blsp2_uart8_pins_sleep: blsp2-uart8-pins-sleep {
+		pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	bt_pins: bt-pins {
+		hostwake {
+			pins = "gpio75";
+			function = "gpio";
+			drive-strength = <16>;
+			input-enable;
+		};
+
+		devwake {
+			pins = "gpio91";
+			function = "gpio";
+			drive-strength = <2>;
 		};
 	};
 
-	sdhc_1: sdhci@f9824900 {
-		status = "okay";
+	sdhc1_pin_a: sdhc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strength = <4>;
+			bias-disable;
+		};
+
+		cmd-data {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <4>;
+			bias-pull-up;
+		};
+	};
 
-		vmmc-supply = <&pma8084_l20>;
-		vqmmc-supply = <&pma8084_s4>;
+	sdhc2_pin_a: sdhc2-pin-active {
+		clk-cmd-data {
+			pins = "gpio35", "gpio36", "gpio37", "gpio38",
+				"gpio39", "gpio40";
+			function = "sdc3";
+			drive-strength = <8>;
+			bias-disable;
+		};
+	};
 
-		bus-width = <8>;
-		non-removable;
+	sdhc2_cd_pin: sdhc2-cd {
+		pins = "gpio62";
+		function = "gpio";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc1_pin_a>;
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	sdhc_2: sdhci@f9864900 {
-		status = "okay";
+	sdhc3_pin_a: sdhc3-pin-active {
+		clk {
+			pins = "sdc2_clk";
+			drive-strength = <6>;
+			bias-disable;
+		};
+
+		cmd-data {
+			pins = "sdc2_cmd", "sdc2_data";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
 
-		max-frequency = <100000000>;
+	i2c2_pins: i2c2 {
+		mux {
+			pins = "gpio6", "gpio7";
+			function = "blsp_i2c2";
 
-		vmmc-supply = <&pma8084_l21>;
-		vqmmc-supply = <&pma8084_l13>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-		bus-width = <4>;
+	i2c6_pins: i2c6 {
+		mux {
+			pins = "gpio29", "gpio30";
+			function = "blsp_i2c6";
 
-		/* cd-gpio is intentionally disabled. If enabled, an SD card
-		 * present during boot is not initialized correctly. Without
-		 * cd-gpios the driver resorts to polling, so hotplug works.
-		 */
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc2_pin_a /* &sdhc2_cd_pin */>;
-		// cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+			drive-strength = <2>;
+			bias-disable;
+		};
 	};
 
-	sdhci@f98a4900 {
-		status = "okay";
+	i2c12_pins: i2c12 {
+		mux {
+			pins = "gpio87", "gpio88";
+			function = "blsp_i2c12";
 
-		#address-cells = <1>;
-		#size-cells = <0>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-		max-frequency = <100000000>;
+	i2c_touchkey_pins: i2c-touchkey {
+		mux {
+			pins = "gpio95", "gpio96";
+			function = "gpio";
+			input-enable;
+			bias-pull-up;
+		};
+	};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc3_pin_a>;
+	i2c_led_gpioex_pins: i2c-led-gpioex {
+		mux {
+			pins = "gpio120", "gpio121";
+			function = "gpio";
+			input-enable;
+			bias-pull-down;
+		};
+	};
 
-		vmmc-supply = <&vreg_wlan>;
-		vqmmc-supply = <&pma8084_s4>;
+	gpioex_pin: gpioex {
+		res {
+			pins = "gpio145";
+			function = "gpio";
 
-		bus-width = <4>;
-		non-removable;
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+	};
 
-		wifi@1 {
-			reg = <1>;
-			compatible = "brcm,bcm4329-fmac";
+	wifi_pin: wifi {
+		int {
+			pins = "gpio92";
+			function = "gpio";
 
-			interrupt-parent = <&msmgpio>;
-			interrupts = <92 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "host-wake";
+			input-enable;
+			bias-pull-down;
+		};
+	};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_sleep_clk_pin &wifi_pin>;
+	panel_te_pin: panel {
+		te {
+			pins = "gpio12";
+			function = "mdp_vsync";
+
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
+};
 
-	usb@f9a55000 {
-		status = "okay";
+&mss_pil {
+	cx-supply = <&pma8084_s2>;
+	mss-supply = <&pma8084_s6>;
+	mx-supply = <&pma8084_s1>;
+	pll-supply = <&pma8084_l12>;
+};
 
-		phys = <&usb_hs1_phy>;
-		phy-select = <&tcsr 0xb000 0>;
-		/*extcon = <&smbb>, <&usb_id>;*/
-		/*vbus-supply = <&chg_otg>;*/
+&otg {
+	status = "okay";
 
-		hnp-disable;
-		srp-disable;
-		adp-disable;
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	/*extcon = <&smbb>, <&usb_id>;*/
+	/*vbus-supply = <&chg_otg>;*/
 
-		ulpi {
-			phy@a {
-				status = "okay";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
 
-				v1p8-supply = <&pma8084_l6>;
-				v3p3-supply = <&pma8084_l24>;
+	ulpi {
+		phy@a {
+			status = "okay";
 
-				/*extcon = <&smbb>;*/
-				qcom,init-seq = /bits/ 8 <0x1 0x64>;
-			};
+			v1p8-supply = <&pma8084_l6>;
+			v3p3-supply = <&pma8084_l24>;
+
+			/*extcon = <&smbb>;*/
+			qcom,init-seq = /bits/ 8 <0x1 0x64>;
 		};
 	};
+};
 
-	i2c@f9924000 {
+&rpm_requests {
+	pma8084-regulators {
+		compatible = "qcom,rpm-pma8084-regulators";
 		status = "okay";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_pins>;
+		pma8084_s1: s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-always-on;
+		};
 
-		touchscreen@20 {
-			compatible = "syna,rmi4-i2c";
-			reg = <0x20>;
+		pma8084_s2: s2 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-			interrupt-parent = <&pma8084_gpios>;
-			interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+		pma8084_s3: s3 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
 
-			vdd-supply = <&max77826_ldo13>;
-			vio-supply = <&pma8084_lvs2>;
+		pma8084_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&touch_pin>;
+		pma8084_s5: s5 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+		};
 
-			syna,startup-delay-ms = <100>;
+		pma8084_s6: s6 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+		pma8084_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-			rmi4-f01@1 {
-				reg = <0x1>;
-				syna,nosleep-mode = <1>;
-			};
+		pma8084_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
 
-			rmi4-f12@12 {
-				reg = <0x12>;
-				syna,sensor-type = <1>;
-			};
+		pma8084_l3: l3 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1200000>;
 		};
-	};
 
-	i2c@f9928000 {
-		status = "okay";
+		pma8084_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c6_pins>;
+		pma8084_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-		pmic@60 {
-			reg = <0x60>;
-			compatible = "maxim,max77826";
+		pma8084_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			regulators {
-				max77826_ldo1: LDO1 {
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-				};
+		pma8084_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-				max77826_ldo2: LDO2 {
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-				};
+		pma8084_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-				max77826_ldo3: LDO3 {
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-				};
+		pma8084_l9: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
 
-				max77826_ldo4: LDO4 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
+		pma8084_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
 
-				max77826_ldo5: LDO5 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
+		pma8084_l11: l11 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
 
-				max77826_ldo6: LDO6 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <3300000>;
-				};
+		pma8084_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
 
-				max77826_ldo7: LDO7 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
+		pma8084_l13: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
 
-				max77826_ldo8: LDO8 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <3300000>;
-				};
+		pma8084_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-				max77826_ldo9: LDO9 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
+		pma8084_l15: l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
 
-				max77826_ldo10: LDO10 {
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2950000>;
-				};
+		pma8084_l16: l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
 
-				max77826_ldo11: LDO11 {
-					regulator-min-microvolt = <2700000>;
-					regulator-max-microvolt = <2950000>;
-				};
+		pma8084_l17: l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
 
-				max77826_ldo12: LDO12 {
-					regulator-min-microvolt = <2500000>;
-					regulator-max-microvolt = <3300000>;
-				};
+		pma8084_l18: l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
 
-				max77826_ldo13: LDO13 {
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-				};
+		pma8084_l19: l19 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
 
-				max77826_ldo14: LDO14 {
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-				};
+		pma8084_l20: l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
 
-				max77826_ldo15: LDO15 {
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
 
-				max77826_buck: BUCK {
-					regulator-min-microvolt = <1225000>;
-					regulator-max-microvolt = <1225000>;
-				};
+		pma8084_l21: l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
 
-				max77826_buckboost: BUCKBOOST {
-					regulator-min-microvolt = <3400000>;
-					regulator-max-microvolt = <3400000>;
-				};
-			};
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
 		};
-	};
 
-	i2c@f9968000 {
-		status = "okay";
+		pma8084_l22: l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c12_pins>;
+		pma8084_l23: l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
 
-		fuelgauge@36 {
-			compatible = "maxim,max17048";
-			reg = <0x36>;
+		pma8084_l24: l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
 
-			maxim,double-soc;
-			maxim,rcomp = /bits/ 8 <0x56>;
+		pma8084_l25: l25 {
+			regulator-min-microvolt = <2100000>;
+			regulator-max-microvolt = <2100000>;
+		};
 
-			interrupt-parent = <&pma8084_gpios>;
-			interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		pma8084_l26: l26 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2050000>;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&fuelgauge_pin>;
+		pma8084_l27: l27 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1225000>;
 		};
-	};
 
-	adreno@fdb00000 {
-		status = "ok";
+		pma8084_lvs1: lvs1 {};
+		pma8084_lvs2: lvs2 {};
+		pma8084_lvs3: lvs3 {};
+		pma8084_lvs4: lvs4 {};
+
+		pma8084_5vs1: 5vs1 {};
 	};
+};
 
-	mdss@fd900000 {
-		status = "ok";
+&sdhci1 {
+	status = "okay";
 
-		mdp@fd900000 {
-			status = "ok";
-		};
+	vmmc-supply = <&pma8084_l20>;
+	vqmmc-supply = <&pma8084_s4>;
+
+	bus-width = <8>;
+	non-removable;
 
-		dsi@fd922800 {
-			status = "ok";
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+};
 
-			vdda-supply = <&pma8084_l2>;
-			vdd-supply = <&pma8084_l22>;
-			vddio-supply = <&pma8084_l12>;
+&sdhci2 {
+	status = "okay";
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+	max-frequency = <100000000>;
 
-			ports {
-				port@1 {
-					endpoint {
-						remote-endpoint = <&panel_in>;
-						data-lanes = <0 1 2 3>;
-					};
-				};
-			};
+	vmmc-supply = <&pma8084_l21>;
+	vqmmc-supply = <&pma8084_l13>;
 
-			panel: panel@0 {
-				reg = <0>;
-				compatible = "samsung,s6e3fa2";
+	bus-width = <4>;
 
-				pinctrl-names = "default";
-				pinctrl-0 = <&panel_te_pin &panel_rst_pin>;
+	/* cd-gpio is intentionally disabled. If enabled, an SD card
+	 * present during boot is not initialized correctly. Without
+	 * cd-gpios the driver resorts to polling, so hotplug works.
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc2_pin_a /* &sdhc2_cd_pin */>;
+	// cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+};
 
-				iovdd-supply = <&pma8084_lvs4>;
-				vddr-supply = <&vreg_panel>;
+&sdhci3 {
+	status = "okay";
 
-				reset-gpios = <&pma8084_gpios 17 GPIO_ACTIVE_LOW>;
-				te-gpios = <&msmgpio 12 GPIO_ACTIVE_HIGH>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-				port {
-					panel_in: endpoint {
-						remote-endpoint = <&dsi0_out>;
-					};
-				};
-			};
-		};
+	max-frequency = <100000000>;
 
-		dsi-phy@fd922a00 {
-			status = "ok";
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc3_pin_a>;
 
-			vddio-supply = <&pma8084_l12>;
-		};
-	};
+	vmmc-supply = <&vreg_wlan>;
+	vqmmc-supply = <&pma8084_s4>;
 
-	remoteproc@fc880000 {
-		cx-supply = <&pma8084_s2>;
-		mss-supply = <&pma8084_s6>;
-		mx-supply = <&pma8084_s1>;
-		pll-supply = <&pma8084_l12>;
+	bus-width = <4>;
+	non-removable;
+
+	wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+
+		interrupt-parent = <&msmgpio>;
+		interrupts = <92 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_sleep_clk_pin &wifi_pin>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
index 79e2cfbbb1ba..4f28ca3340de 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
@@ -57,339 +57,332 @@ memory@0 {
 		reg = <0 0x40000000>, <0x40000000 0x40000000>;
 		device_type = "memory";
 	};
+};
 
-	smd {
-		rpm {
-			rpm_requests {
-				pm8841-regulators {
-					s1 {
-						regulator-min-microvolt = <675000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s2 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s3 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s4 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-				};
-
-				pm8941-regulators {
-					vdd_l1_l3-supply = <&pm8941_s1>;
-					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-					vdd_l4_l11-supply = <&pm8941_s1>;
-					vdd_l5_l7-supply = <&pm8941_s2>;
-					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
-					vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
-					vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
-					vdd_l21-supply = <&vreg_boost>;
-
-					s1 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s2 {
-						regulator-min-microvolt = <2150000>;
-						regulator-max-microvolt = <2150000>;
-						regulator-boot-on;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s4 {
-						regulator-min-microvolt = <5000000>;
-						regulator-max-microvolt = <5000000>;
-					};
-
-					l1 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l2 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l3 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l4 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l5 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l6 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l7 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l8 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l9 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l11 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1350000>;
-					};
-
-					l12 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l13 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l14 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l15 {
-						regulator-min-microvolt = <2050000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					l16 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l17 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l18 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l19 {
-						regulator-min-microvolt = <3300000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-allow-set-load;
-						regulator-boot-on;
-						regulator-system-load = <200000>;
-					};
-
-					l21 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l22 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					l23 {
-						regulator-min-microvolt = <2800000>;
-						regulator-max-microvolt = <2800000>;
-					};
-
-					l24 {
-						regulator-min-microvolt = <3075000>;
-						regulator-max-microvolt = <3075000>;
-
-						regulator-boot-on;
-					};
-				};
-			};
+&blsp1_uart2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp1_uart2_pin_a>;
+};
+
+&blsp2_dma {
+	qcom,controlled-remotely;
+};
+
+&msmgpio {
+	blsp1_uart2_pin_a: blsp1-uart2-pin-active {
+		rx {
+			pins = "gpio5";
+			function = "blsp_uart2";
+
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		tx {
+			pins = "gpio4";
+			function = "blsp_uart2";
+
+			drive-strength = <4>;
+			bias-disable;
 		};
 	};
-};
 
-&soc {
-	sdhci@f9824900 {
-		status = "okay";
+	i2c2_pins: i2c2 {
+		mux {
+			pins = "gpio6", "gpio7";
+			function = "blsp_i2c2";
 
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-		bus-width = <8>;
-		non-removable;
+	sdhc1_pin_a: sdhc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strength = <16>;
+			bias-disable;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc1_pin_a>;
+		cmd-data {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <10>;
+			bias-pull-up;
+		};
 	};
 
-	sdhci@f98a4900 {
-		status = "okay";
+	sdhc2_cd_pin_a: sdhc2-cd-pin-active {
+		pins = "gpio62";
+		function = "gpio";
 
-		bus-width = <4>;
+		drive-strength = <2>;
+		bias-disable;
+	 };
 
-		vmmc-supply = <&pm8941_l21>;
-		vqmmc-supply = <&pm8941_l13>;
+	sdhc2_pin_a: sdhc2-pin-active {
+		clk {
+			pins = "sdc2_clk";
+			drive-strength = <10>;
+			bias-disable;
+		};
 
-		cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+		cmd-data {
+			pins = "sdc2_cmd", "sdc2_data";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+&otg {
+	status = "okay";
+
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+
+	ulpi {
+		phy@a {
+			status = "okay";
+
+			v1p8-supply = <&pm8941_l6>;
+			v3p3-supply = <&pm8941_l24>;
+
+			extcon = <&smbb>;
+			qcom,init-seq = /bits/ 8 <0x1 0x64>;
+		};
 	};
+};
+
+&rpm_requests {
+	pm8841-regulators {
+		s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-	serial@f991e000 {
-		status = "okay";
+		s2 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&blsp1_uart2_pin_a>;
+		s3 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		s4 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
 	};
 
+	pm8941-regulators {
+		vdd_l1_l3-supply = <&pm8941_s1>;
+		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+		vdd_l4_l11-supply = <&pm8941_s1>;
+		vdd_l5_l7-supply = <&pm8941_s2>;
+		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+		vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
+		vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
+		vdd_l21-supply = <&vreg_boost>;
+
+		s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-	pinctrl@fd510000 {
-		blsp1_uart2_pin_a: blsp1-uart2-pin-active {
-			rx {
-				pins = "gpio5";
-				function = "blsp_uart2";
+		s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+			regulator-boot-on;
+		};
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+		s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			tx {
-				pins = "gpio4";
-				function = "blsp_uart2";
+		s4 {
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
 
-				drive-strength = <4>;
-				bias-disable;
-			};
+		l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
-		i2c2_pins: i2c2 {
-			mux {
-				pins = "gpio6", "gpio7";
-				function = "blsp_i2c2";
+		l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+		l3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
 		};
 
-		sdhc1_pin_a: sdhc1-pin-active {
-			clk {
-				pins = "sdc1_clk";
-				drive-strength = <16>;
-				bias-disable;
-			};
+		l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-			cmd-data {
-				pins = "sdc1_cmd", "sdc1_data";
-				drive-strength = <10>;
-				bias-pull-up;
-			};
+		l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 		};
 
-		sdhc2_cd_pin_a: sdhc2-cd-pin-active {
-			pins = "gpio62";
-			function = "gpio";
+		l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-			drive-strength = <2>;
-			bias-disable;
-		 };
+			regulator-boot-on;
+		};
 
-		sdhc2_pin_a: sdhc2-pin-active {
-			clk {
-				pins = "sdc2_clk";
-				drive-strength = <10>;
-				bias-disable;
-			};
+		l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-			cmd-data {
-				pins = "sdc2_cmd", "sdc2_data";
-				drive-strength = <6>;
-				bias-pull-up;
-			};
+			regulator-boot-on;
 		};
-	};
 
-	dma-controller@f9944000 {
-		qcom,controlled-remotely;
-	};
+		l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-	usb@f9a55000 {
-		status = "okay";
+		l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
 
-		phys = <&usb_hs1_phy>;
-		phy-select = <&tcsr 0xb000 0>;
-		extcon = <&smbb>, <&usb_id>;
-		vbus-supply = <&chg_otg>;
+		l11 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
 
-		hnp-disable;
-		srp-disable;
-		adp-disable;
+		l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-		ulpi {
-			phy@a {
-				status = "okay";
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-				v1p8-supply = <&pm8941_l6>;
-				v3p3-supply = <&pm8941_l24>;
+		l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
 
-				extcon = <&smbb>;
-				qcom,init-seq = /bits/ 8 <0x1 0x64>;
-			};
+			regulator-boot-on;
+		};
+
+		l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+
+		l17 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+
+		l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		l19 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-allow-set-load;
+			regulator-boot-on;
+			regulator-system-load = <200000>;
+		};
+
+		l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
+		};
+
+		l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		l23 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+
+			regulator-boot-on;
 		};
 	};
 };
 
+&sdhci1 {
+	status = "okay";
+
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	bus-width = <8>;
+	non-removable;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+};
+
+&sdhci3 {
+	status = "okay";
+
+	bus-width = <4>;
+
+	vmmc-supply = <&pm8941_l21>;
+	vqmmc-supply = <&pm8941_l13>;
+
+	cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+};
+
 &spmi_bus {
 	pm8941@0 {
 		charger@1000 {
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
index e66937e3f7dd..f4b537294fb4 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
@@ -53,186 +53,6 @@ volume-up {
 		};
 	};
 
-	smd {
-		rpm {
-			rpm_requests {
-				pm8941-regulators {
-					vdd_l1_l3-supply = <&pm8941_s1>;
-					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-					vdd_l4_l11-supply = <&pm8941_s1>;
-					vdd_l5_l7-supply = <&pm8941_s2>;
-					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
-					vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
-					vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
-					vdd_l21-supply = <&vreg_boost>;
-
-					s1 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s2 {
-						regulator-min-microvolt = <2150000>;
-						regulator-max-microvolt = <2150000>;
-						regulator-boot-on;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-						regulator-always-on;
-						regulator-boot-on;
-
-						regulator-system-load = <154000>;
-					};
-
-					s4 {
-						regulator-min-microvolt = <5000000>;
-						regulator-max-microvolt = <5000000>;
-					};
-
-					l1 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l2 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l3 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l4 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l5 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l6 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l7 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l8 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l9 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l11 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1350000>;
-					};
-
-					l12 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l13 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l14 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l15 {
-						regulator-min-microvolt = <2050000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					l16 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l17 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l18 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l19 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-allow-set-load;
-						regulator-boot-on;
-						regulator-allow-set-load;
-						regulator-system-load = <500000>;
-					};
-
-					l21 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l22 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					l23 {
-						regulator-min-microvolt = <2800000>;
-						regulator-max-microvolt = <2800000>;
-					};
-
-					l24 {
-						regulator-min-microvolt = <3075000>;
-						regulator-max-microvolt = <3075000>;
-
-						regulator-boot-on;
-					};
-				};
-			};
-		};
-	};
-
 	vreg_bl_vddio: lcd-backlight-vddio {
 		compatible = "regulator-fixed";
 		regulator-name = "vreg_bl_vddio";
@@ -277,385 +97,559 @@ vreg_wlan: wlan-regulator {
 	};
 };
 
-&soc {
-	sdhci@f9824900 {
-		status = "okay";
+&blsp_i2c8 {
+	status = "okay";
 
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
+	clock-frequency = <355000>;
+	qcom,src-freq = <50000000>;
 
-		bus-width = <8>;
-		non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c8_pins>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc1_pin_a>;
-	};
+	synaptics@2c {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x2c>;
 
-	sdhci@f9864900 {
-		status = "okay";
+		interrupt-parent = <&msmgpio>;
+		interrupts = <86 IRQ_TYPE_EDGE_FALLING>;
 
-		max-frequency = <100000000>;
-		non-removable;
-		vmmc-supply = <&vreg_wlan>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd-supply = <&pm8941_l22>;
+		vio-supply = <&pm8941_lvs3>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc3_pin_a>;
+		pinctrl-0 = <&ts_int_pin>;
 
-		#address-cells = <1>;
-		#size-cells = <0>;
+		syna,startup-delay-ms = <10>;
 
-		bcrmf@1 {
-			compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
-			reg = <1>;
+		rmi-f01@1 {
+			reg = <0x1>;
+			syna,nosleep = <1>;
+		};
 
-			brcm,drive-strength = <10>;
+		rmi-f11@11 {
+			reg = <0x11>;
+			syna,f11-flip-x = <1>;
+			syna,sensor-type = <1>;
+		};
+	};
+};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_sleep_clk_pin>;
+&blsp_i2c11 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c11_pins>;
+	clock-frequency = <355000>;
+	qcom,src-freq = <50000000>;
+
+	lp8566_wled: backlight@2c {
+		compatible = "ti,lp8556";
+		reg = <0x2c>;
+		power-supply = <&vreg_bl_vddio>;
+
+		bl-name = "backlight";
+		dev-ctrl = /bits/ 8 <0x05>;
+		init-brt = /bits/ 8 <0x3f>;
+		rom_a0h {
+			rom-addr = /bits/ 8 <0xa0>;
+			rom-val = /bits/ 8 <0xff>;
+		};
+		rom_a1h {
+			rom-addr = /bits/ 8 <0xa1>;
+			rom-val = /bits/ 8 <0x3f>;
+		};
+		rom_a2h {
+			rom-addr = /bits/ 8 <0xa2>;
+			rom-val = /bits/ 8 <0x20>;
+		};
+		rom_a3h {
+			rom-addr = /bits/ 8 <0xa3>;
+			rom-val = /bits/ 8 <0x5e>;
+		};
+		rom_a4h {
+			rom-addr = /bits/ 8 <0xa4>;
+			rom-val = /bits/ 8 <0x02>;
+		};
+		rom_a5h {
+			rom-addr = /bits/ 8 <0xa5>;
+			rom-val = /bits/ 8 <0x04>;
+		};
+		rom_a6h {
+			rom-addr = /bits/ 8 <0xa6>;
+			rom-val = /bits/ 8 <0x80>;
+		};
+		rom_a7h {
+			rom-addr = /bits/ 8 <0xa7>;
+			rom-val = /bits/ 8 <0xf7>;
+		};
+		rom_a9h {
+			rom-addr = /bits/ 8 <0xa9>;
+			rom-val = /bits/ 8 <0x80>;
+		};
+		rom_aah {
+			rom-addr = /bits/ 8 <0xaa>;
+			rom-val = /bits/ 8 <0x0f>;
+		};
+		rom_aeh {
+			rom-addr = /bits/ 8 <0xae>;
+			rom-val = /bits/ 8 <0x0f>;
 		};
 	};
+};
+
+&blsp1_uart2 {
+	status = "okay";
 
-	sdhci@f98a4900 {
-		status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp1_uart2_pin_a>;
+};
 
-		bus-width = <4>;
+&blsp2_uart7 {
+	status = "ok";
 
-		vmmc-supply = <&pm8941_l21>;
-		vqmmc-supply = <&pm8941_l13>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp2_uart7_pin_a>;
 
-		cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+		pinctrl-0 = <&bt_host_wake_pin>,
+			    <&bt_dev_wake_pin>,
+			    <&bt_reg_on_pin>;
+
+		host-wakeup-gpios = <&msmgpio 95 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&msmgpio 96 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&pm8941_gpios 16 GPIO_ACTIVE_HIGH>;
 	};
+};
 
-	serial@f991e000 {
-		status = "okay";
+&msmgpio {
+	blsp1_uart2_pin_a: blsp1-uart2-pin-active {
+		rx {
+			pins = "gpio5";
+			function = "blsp_uart2";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&blsp1_uart2_pin_a>;
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		tx {
+			pins = "gpio4";
+			function = "blsp_uart2";
+
+			drive-strength = <4>;
+			bias-disable;
+		};
 	};
 
-	serial@f995d000 {
-		status = "ok";
+	blsp2_uart7_pin_a: blsp2-uart7-pin-active {
+		tx {
+			pins = "gpio41";
+			function = "blsp_uart7";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&blsp2_uart7_pin_a>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx {
+			pins = "gpio42";
+			function = "blsp_uart7";
 
-		bluetooth {
-			compatible = "brcm,bcm43438-bt";
-			max-speed = <3000000>;
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		cts {
+			pins = "gpio43";
+			function = "blsp_uart7";
+
+			drive-strength = <2>;
+			bias-pull-up;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&bt_host_wake_pin>,
-				    <&bt_dev_wake_pin>,
-				    <&bt_reg_on_pin>;
+		rts {
+			pins = "gpio44";
+			function = "blsp_uart7";
 
-			host-wakeup-gpios = <&msmgpio 95 GPIO_ACTIVE_HIGH>;
-			device-wakeup-gpios = <&msmgpio 96 GPIO_ACTIVE_HIGH>;
-			shutdown-gpios = <&pm8941_gpios 16 GPIO_ACTIVE_HIGH>;
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 
-	usb@f9a55000 {
-		status = "okay";
+	i2c8_pins: i2c8 {
+		mux {
+			pins = "gpio47", "gpio48";
+			function = "blsp_i2c8";
 
-		phys = <&usb_hs1_phy>;
-		phy-select = <&tcsr 0xb000 0>;
-		extcon = <&smbb>, <&usb_id>;
-		vbus-supply = <&chg_otg>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-		hnp-disable;
-		srp-disable;
-		adp-disable;
+	i2c11_pins: i2c11 {
+		mux {
+			pins = "gpio83", "gpio84";
+			function = "blsp_i2c11";
 
-		ulpi {
-			phy@a {
-				status = "okay";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-				v1p8-supply = <&pm8941_l6>;
-				v3p3-supply = <&pm8941_l24>;
+	lcd_backlight_en_pin_a: lcd-backlight-vddio {
+		pins = "gpio69";
+		drive-strength = <10>;
+		output-low;
+		bias-disable;
+	};
 
-				extcon = <&smbb>;
-				qcom,init-seq = /bits/ 8 <0x1 0x64>;
-			};
+	sdhc1_pin_a: sdhc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		cmd-data {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <10>;
+			bias-pull-up;
 		};
 	};
 
-	pinctrl@fd510000 {
-		blsp1_uart2_pin_a: blsp1-uart2-pin-active {
-			rx {
-				pins = "gpio5";
-				function = "blsp_uart2";
+	sdhc2_cd_pin_a: sdhc2-cd-pin-active {
+		pins = "gpio62";
+		function = "gpio";
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+		drive-strength = <2>;
+		bias-disable;
+	 };
 
-			tx {
-				pins = "gpio4";
-				function = "blsp_uart2";
+	sdhc2_pin_a: sdhc2-pin-active {
+		clk {
+			pins = "sdc2_clk";
+			drive-strength = <6>;
+			bias-disable;
+		};
 
-				drive-strength = <4>;
-				bias-disable;
-			};
+		cmd-data {
+			pins = "sdc2_cmd", "sdc2_data";
+			drive-strength = <6>;
+			bias-pull-up;
 		};
+	};
 
-		blsp2_uart7_pin_a: blsp2-uart7-pin-active {
-			tx {
-				pins = "gpio41";
-				function = "blsp_uart7";
+	sdhc3_pin_a: sdhc3-pin-active {
+		clk {
+			pins = "gpio40";
+			function = "sdc3";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+			drive-strength = <10>;
+			bias-disable;
+		};
 
-			rx {
-				pins = "gpio42";
-				function = "blsp_uart7";
+		cmd {
+			pins = "gpio39";
+			function = "sdc3";
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+			drive-strength = <10>;
+			bias-pull-up;
+		};
 
-			cts {
-				pins = "gpio43";
-				function = "blsp_uart7";
+		data {
+			pins = "gpio35", "gpio36", "gpio37", "gpio38";
+			function = "sdc3";
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+			drive-strength = <10>;
+			bias-pull-up;
+		};
+	};
 
-			rts {
-				pins = "gpio44";
-				function = "blsp_uart7";
+	ts_int_pin: synaptics {
+		pin {
+			pins = "gpio86";
+			function = "gpio";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+			drive-strength = <2>;
+			bias-disable;
+			input-enable;
 		};
+	};
 
-		i2c8_pins: i2c8 {
-			mux {
-				pins = "gpio47", "gpio48";
-				function = "blsp_i2c8";
+	bt_host_wake_pin: bt-host-wake {
+		pins = "gpio95";
+		function = "gpio";
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	bt_dev_wake_pin: bt-dev-wake {
+		pins = "gpio96";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&otg {
+	status = "okay";
+
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+
+	ulpi {
+		phy@a {
+			status = "okay";
+
+			v1p8-supply = <&pm8941_l6>;
+			v3p3-supply = <&pm8941_l24>;
+
+			extcon = <&smbb>;
+			qcom,init-seq = /bits/ 8 <0x1 0x64>;
+		};
+	};
+};
+
+&rpm_requests {
+	pm8941-regulators {
+		vdd_l1_l3-supply = <&pm8941_s1>;
+		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+		vdd_l4_l11-supply = <&pm8941_s1>;
+		vdd_l5_l7-supply = <&pm8941_s2>;
+		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+		vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
+		vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
+		vdd_l21-supply = <&vreg_boost>;
+
+		s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
-		i2c11_pins: i2c11 {
-			mux {
-				pins = "gpio83", "gpio84";
-				function = "blsp_i2c11";
+		s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+			regulator-boot-on;
+		};
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+		s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+
+			regulator-system-load = <154000>;
 		};
 
-		lcd_backlight_en_pin_a: lcd-backlight-vddio {
-			pins = "gpio69";
-			drive-strength = <10>;
-			output-low;
-			bias-disable;
+		s4 {
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
 		};
 
-		sdhc1_pin_a: sdhc1-pin-active {
-			clk {
-				pins = "sdc1_clk";
-				drive-strength = <16>;
-				bias-disable;
-			};
+		l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
 
-			cmd-data {
-				pins = "sdc1_cmd", "sdc1_data";
-				drive-strength = <10>;
-				bias-pull-up;
-			};
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
-		sdhc2_cd_pin_a: sdhc2-cd-pin-active {
-			pins = "gpio62";
-			function = "gpio";
+		l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
 
-			drive-strength = <2>;
-			bias-disable;
-		 };
+		l3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
 
-		sdhc2_pin_a: sdhc2-pin-active {
-			clk {
-				pins = "sdc2_clk";
-				drive-strength = <6>;
-				bias-disable;
-			};
+		l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-			cmd-data {
-				pins = "sdc2_cmd", "sdc2_data";
-				drive-strength = <6>;
-				bias-pull-up;
-			};
+		l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 		};
 
-		sdhc3_pin_a: sdhc3-pin-active {
-			clk {
-				pins = "gpio40";
-				function = "sdc3";
+		l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-				drive-strength = <10>;
-				bias-disable;
-			};
+			regulator-boot-on;
+		};
 
-			cmd {
-				pins = "gpio39";
-				function = "sdc3";
+		l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-				drive-strength = <10>;
-				bias-pull-up;
-			};
+			regulator-boot-on;
+		};
 
-			data {
-				pins = "gpio35", "gpio36", "gpio37", "gpio38";
-				function = "sdc3";
+		l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-				drive-strength = <10>;
-				bias-pull-up;
-			};
+		l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
 		};
 
-		ts_int_pin: synaptics {
-			pin {
-				pins = "gpio86";
-				function = "gpio";
+		l11 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
 
-				drive-strength = <2>;
-				bias-disable;
-				input-enable;
-			};
+		l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
-		bt_host_wake_pin: bt-host-wake {
-			pins = "gpio95";
-			function = "gpio";
+		l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
 
-			drive-strength = <2>;
-			bias-disable;
-			output-low;
+			regulator-boot-on;
 		};
 
-		bt_dev_wake_pin: bt-dev-wake {
-			pins = "gpio96";
-			function = "gpio";
+		l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			drive-strength = <2>;
-			bias-disable;
+		l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
 		};
-	};
 
-	i2c@f9964000 {
-		status = "okay";
+		l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
 
-		clock-frequency = <355000>;
-		qcom,src-freq = <50000000>;
+		l17 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c8_pins>;
+		l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
 
-		synaptics@2c {
-			compatible = "syna,rmi4-i2c";
-			reg = <0x2c>;
+		l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
 
-			interrupt-parent = <&msmgpio>;
-			interrupts = <86 IRQ_TYPE_EDGE_FALLING>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+			regulator-allow-set-load;
+			regulator-system-load = <500000>;
+		};
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+		l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
 
-			vdd-supply = <&pm8941_l22>;
-			vio-supply = <&pm8941_lvs3>;
+			regulator-boot-on;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&ts_int_pin>;
+		l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
 
-			syna,startup-delay-ms = <10>;
+		l23 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
 
-			rmi-f01@1 {
-				reg = <0x1>;
-				syna,nosleep = <1>;
-			};
+		l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
 
-			rmi-f11@11 {
-				reg = <0x11>;
-				syna,f11-flip-x = <1>;
-				syna,sensor-type = <1>;
-			};
+			regulator-boot-on;
 		};
 	};
+};
+
+&sdhci1 {
+	status = "okay";
+
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	bus-width = <8>;
+	non-removable;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+};
+
+&sdhci2 {
+	status = "okay";
+
+	max-frequency = <100000000>;
+	non-removable;
+	vmmc-supply = <&vreg_wlan>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc3_pin_a>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bcrmf@1 {
+		compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+
+		brcm,drive-strength = <10>;
 
-	i2c@f9967000 {
-		status = "okay";
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2c11_pins>;
-		clock-frequency = <355000>;
-		qcom,src-freq = <50000000>;
-
-		lp8566_wled: backlight@2c {
-			compatible = "ti,lp8556";
-			reg = <0x2c>;
-			power-supply = <&vreg_bl_vddio>;
-
-			bl-name = "backlight";
-			dev-ctrl = /bits/ 8 <0x05>;
-			init-brt = /bits/ 8 <0x3f>;
-			rom_a0h {
-				rom-addr = /bits/ 8 <0xa0>;
-				rom-val = /bits/ 8 <0xff>;
-			};
-			rom_a1h {
-				rom-addr = /bits/ 8 <0xa1>;
-				rom-val = /bits/ 8 <0x3f>;
-			};
-			rom_a2h {
-				rom-addr = /bits/ 8 <0xa2>;
-				rom-val = /bits/ 8 <0x20>;
-			};
-			rom_a3h {
-				rom-addr = /bits/ 8 <0xa3>;
-				rom-val = /bits/ 8 <0x5e>;
-			};
-			rom_a4h {
-				rom-addr = /bits/ 8 <0xa4>;
-				rom-val = /bits/ 8 <0x02>;
-			};
-			rom_a5h {
-				rom-addr = /bits/ 8 <0xa5>;
-				rom-val = /bits/ 8 <0x04>;
-			};
-			rom_a6h {
-				rom-addr = /bits/ 8 <0xa6>;
-				rom-val = /bits/ 8 <0x80>;
-			};
-			rom_a7h {
-				rom-addr = /bits/ 8 <0xa7>;
-				rom-val = /bits/ 8 <0xf7>;
-			};
-			rom_a9h {
-				rom-addr = /bits/ 8 <0xa9>;
-				rom-val = /bits/ 8 <0x80>;
-			};
-			rom_aah {
-				rom-addr = /bits/ 8 <0xaa>;
-				rom-val = /bits/ 8 <0x0f>;
-			};
-			rom_aeh {
-				rom-addr = /bits/ 8 <0xae>;
-				rom-val = /bits/ 8 <0x0f>;
-			};
-		};
+		pinctrl-0 = <&wlan_sleep_clk_pin>;
 	};
 };
 
+&sdhci3 {
+	status = "okay";
+
+	bus-width = <4>;
+
+	vmmc-supply = <&pm8941_l21>;
+	vqmmc-supply = <&pm8941_l13>;
+
+	cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+};
+
 &spmi_bus {
 	pm8941@0 {
 		charger@1000 {
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index a62e5c25b23c..a98aa3e11edf 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -57,388 +57,382 @@ memory@0 {
 		reg = <0 0x40000000>, <0x40000000 0x40000000>;
 		device_type = "memory";
 	};
+};
 
-	smd {
-		rpm {
-			rpm_requests {
-				pm8841-regulators {
-					s1 {
-						regulator-min-microvolt = <675000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s2 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s3 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-
-					s4 {
-						regulator-min-microvolt = <500000>;
-						regulator-max-microvolt = <1050000>;
-					};
-				};
-
-				pm8941-regulators {
-					vdd_l1_l3-supply = <&pm8941_s1>;
-					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
-					vdd_l4_l11-supply = <&pm8941_s1>;
-					vdd_l5_l7-supply = <&pm8941_s2>;
-					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
-					vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
-					vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
-					vdd_l21-supply = <&vreg_boost>;
-
-					s1 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s2 {
-						regulator-min-microvolt = <2150000>;
-						regulator-max-microvolt = <2150000>;
-						regulator-boot-on;
-					};
-
-					s3 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					s4 {
-						regulator-min-microvolt = <5000000>;
-						regulator-max-microvolt = <5000000>;
-					};
-
-					l1 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l2 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l3 {
-						regulator-min-microvolt = <1200000>;
-						regulator-max-microvolt = <1200000>;
-					};
-
-					l4 {
-						regulator-min-microvolt = <1225000>;
-						regulator-max-microvolt = <1225000>;
-					};
-
-					l5 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l6 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l7 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-boot-on;
-					};
-
-					l8 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l9 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-					};
-
-					l11 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1350000>;
-					};
-
-					l12 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-
-						regulator-always-on;
-						regulator-boot-on;
-					};
-
-					l13 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l14 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					l15 {
-						regulator-min-microvolt = <2050000>;
-						regulator-max-microvolt = <2050000>;
-					};
-
-					l16 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l17 {
-						regulator-min-microvolt = <2700000>;
-						regulator-max-microvolt = <2700000>;
-					};
-
-					l18 {
-						regulator-min-microvolt = <2850000>;
-						regulator-max-microvolt = <2850000>;
-					};
-
-					l19 {
-						regulator-min-microvolt = <3300000>;
-						regulator-max-microvolt = <3300000>;
-					};
-
-					l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-allow-set-load;
-						regulator-boot-on;
-						regulator-system-load = <200000>;
-					};
-
-					l21 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-
-						regulator-boot-on;
-					};
-
-					l22 {
-						regulator-min-microvolt = <3000000>;
-						regulator-max-microvolt = <3000000>;
-					};
-
-					l23 {
-						regulator-min-microvolt = <2800000>;
-						regulator-max-microvolt = <2800000>;
-					};
-
-					l24 {
-						regulator-min-microvolt = <3075000>;
-						regulator-max-microvolt = <3075000>;
-
-						regulator-boot-on;
-					};
-				};
-			};
+&blsp_i2c2 {
+	status = "okay";
+
+	clock-frequency = <355000>;
+	qcom,src-freq = <50000000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
+	synaptics@2c {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x2c>;
+
+		interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd-supply = <&pm8941_l22>;
+		vio-supply = <&pm8941_lvs3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_pin>;
+
+		syna,startup-delay-ms = <10>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f11@11 {
+			reg = <0x11>;
+			touchscreen-inverted-x;
+			syna,sensor-type = <1>;
 		};
 	};
 };
 
-&soc {
-	usb@f9a55000 {
-		status = "okay";
+&blsp1_uart2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&blsp1_uart2_pin_a>;
+};
 
-		phys = <&usb_hs1_phy>;
-		phy-select = <&tcsr 0xb000 0>;
-		extcon = <&smbb>, <&usb_id>;
-		vbus-supply = <&chg_otg>;
+&blsp2_dma {
+	qcom,controlled-remotely;
+};
 
-		hnp-disable;
-		srp-disable;
-		adp-disable;
+&msmgpio {
+	blsp1_uart2_pin_a: blsp1-uart2-pin-active {
+		rx {
+			pins = "gpio5";
+			function = "blsp_uart2";
 
-		ulpi {
-			phy@a {
-				status = "okay";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
 
-				v1p8-supply = <&pm8941_l6>;
-				v3p3-supply = <&pm8941_l24>;
+		tx {
+			pins = "gpio4";
+			function = "blsp_uart2";
 
-				extcon = <&smbb>;
-				qcom,init-seq = /bits/ 8 <0x1 0x64>;
-			};
+			drive-strength = <4>;
+			bias-disable;
 		};
 	};
 
-	sdhci@f9824900 {
-		status = "okay";
+	i2c2_pins: i2c2 {
+		mux {
+			pins = "gpio6", "gpio7";
+			function = "blsp_i2c2";
 
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 
-		bus-width = <8>;
-		non-removable;
+	sdhc1_pin_a: sdhc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strength = <16>;
+			bias-disable;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc1_pin_a>;
+		cmd-data {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <10>;
+			bias-pull-up;
+		};
 	};
 
-	sdhci@f98a4900 {
-		status = "okay";
+	sdhc2_cd_pin_a: sdhc2-cd-pin-active {
+		pins = "gpio62";
+		function = "gpio";
 
-		bus-width = <4>;
+		drive-strength = <2>;
+		bias-disable;
+	 };
 
-		vmmc-supply = <&pm8941_l21>;
-		vqmmc-supply = <&pm8941_l13>;
+	sdhc2_pin_a: sdhc2-pin-active {
+		clk {
+			pins = "sdc2_clk";
+			drive-strength = <10>;
+			bias-disable;
+		};
 
-		cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+		cmd-data {
+			pins = "sdc2_cmd", "sdc2_data";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+	ts_int_pin: touch-int {
+		pin {
+			pins = "gpio61";
+			function = "gpio";
+
+			drive-strength = <2>;
+			bias-disable;
+			input-enable;
+		};
 	};
+};
 
-	serial@f991e000 {
-		status = "okay";
+&otg {
+	status = "okay";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&blsp1_uart2_pin_a>;
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+
+	ulpi {
+		phy@a {
+			status = "okay";
+
+			v1p8-supply = <&pm8941_l6>;
+			v3p3-supply = <&pm8941_l24>;
+
+			extcon = <&smbb>;
+			qcom,init-seq = /bits/ 8 <0x1 0x64>;
+		};
 	};
+};
 
-	i2c@f9924000 {
-		status = "okay";
+&rpm_requests {
+	pm8841-regulators {
+		s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-		clock-frequency = <355000>;
-		qcom,src-freq = <50000000>;
+		s2 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_pins>;
+		s3 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
 
-		synaptics@2c {
-			compatible = "syna,rmi4-i2c";
-			reg = <0x2c>;
+		s4 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
+	};
 
-			interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+	pm8941-regulators {
+		vdd_l1_l3-supply = <&pm8941_s1>;
+		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+		vdd_l4_l11-supply = <&pm8941_s1>;
+		vdd_l5_l7-supply = <&pm8941_s2>;
+		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+		vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
+		vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
+		vdd_l21-supply = <&vreg_boost>;
+
+		s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			#address-cells = <1>;
-			#size-cells = <0>;
+		s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+			regulator-boot-on;
+		};
 
-			vdd-supply = <&pm8941_l22>;
-			vio-supply = <&pm8941_lvs3>;
+		s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&ts_int_pin>;
+		s4 {
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
 
-			syna,startup-delay-ms = <10>;
+		l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
 
-			rmi4-f01@1 {
-				reg = <0x1>;
-				syna,nosleep-mode = <1>;
-			};
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			rmi4-f11@11 {
-				reg = <0x11>;
-				touchscreen-inverted-x;
-				syna,sensor-type = <1>;
-			};
+		l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
 		};
-	};
 
-	pinctrl@fd510000 {
-		blsp1_uart2_pin_a: blsp1-uart2-pin-active {
-			rx {
-				pins = "gpio5";
-				function = "blsp_uart2";
+		l3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
 
-				drive-strength = <2>;
-				bias-pull-up;
-			};
+		l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
 
-			tx {
-				pins = "gpio4";
-				function = "blsp_uart2";
+		l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-				drive-strength = <4>;
-				bias-disable;
-			};
+		l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-boot-on;
 		};
 
-		i2c2_pins: i2c2 {
-			mux {
-				pins = "gpio6", "gpio7";
-				function = "blsp_i2c2";
+		l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-				drive-strength = <2>;
-				bias-disable;
-			};
+			regulator-boot-on;
 		};
 
-		sdhc1_pin_a: sdhc1-pin-active {
-			clk {
-				pins = "sdc1_clk";
-				drive-strength = <16>;
-				bias-disable;
-			};
+		l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			cmd-data {
-				pins = "sdc1_cmd", "sdc1_data";
-				drive-strength = <10>;
-				bias-pull-up;
-			};
+		l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
 		};
 
-		sdhc2_cd_pin_a: sdhc2-cd-pin-active {
-			pins = "gpio62";
-			function = "gpio";
+		l11 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
 
-			drive-strength = <2>;
-			bias-disable;
-		 };
+		l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 
-		sdhc2_pin_a: sdhc2-pin-active {
-			clk {
-				pins = "sdc2_clk";
-				drive-strength = <10>;
-				bias-disable;
-			};
+			regulator-always-on;
+			regulator-boot-on;
+		};
 
-			cmd-data {
-				pins = "sdc2_cmd", "sdc2_data";
-				drive-strength = <6>;
-				bias-pull-up;
-			};
+		l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
 		};
 
-		ts_int_pin: touch-int {
-			pin {
-				pins = "gpio61";
-				function = "gpio";
+		l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-				drive-strength = <2>;
-				bias-disable;
-				input-enable;
-			};
+		l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
 		};
-	};
 
-	dma-controller@f9944000 {
-		qcom,controlled-remotely;
+		l17 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+
+		l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		l19 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-allow-set-load;
+			regulator-boot-on;
+			regulator-system-load = <200000>;
+		};
+
+		l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
+		};
+
+		l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		l23 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+
+			regulator-boot-on;
+		};
 	};
 };
 
+&sdhci1 {
+	status = "okay";
+
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	bus-width = <8>;
+	non-removable;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+};
+
+&sdhci3 {
+	status = "okay";
+
+	bus-width = <4>;
+
+	vmmc-supply = <&pm8941_l21>;
+	vqmmc-supply = <&pm8941_l13>;
+
+	cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+};
+
 &spmi_bus {
 	pm8941@0 {
 		charger@1000 {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 412d94736c35..02b73739b6f3 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -742,7 +742,7 @@ blsp2_uart10: serial@f9960000 {
 			status = "disabled";
 		};
 
-		sdhci@f9824900 {
+		sdhci1: sdhci@f9824900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -756,7 +756,7 @@ sdhci@f9824900 {
 			status = "disabled";
 		};
 
-		sdhci@f9864900 {
+		sdhci2: sdhci@f9864900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -770,7 +770,7 @@ sdhci@f9864900 {
 			status = "disabled";
 		};
 
-		sdhci@f98a4900 {
+		sdhci3: sdhci@f98a4900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -835,7 +835,7 @@ rng@f9bff000 {
 			clock-names = "core";
 		};
 
-		remoteproc@fc880000 {
+		mss_pil: remoteproc@fc880000 {
 			compatible = "qcom,msm8974-mss-pil";
 			reg = <0xfc880000 0x100>, <0xfc820000 0x020>;
 			reg-names = "qdsp6", "rmb";
@@ -959,7 +959,7 @@ msmgpio: pinctrl@fd510000 {
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		i2c@f9923000 {
+		blsp_i2c1: i2c@f9923000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9923000 0x1000>;
@@ -970,7 +970,7 @@ i2c@f9923000 {
 			#size-cells = <0>;
 		};
 
-		i2c@f9924000 {
+		blsp_i2c2: i2c@f9924000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9924000 0x1000>;
@@ -1594,7 +1594,7 @@ dsi_phy0: dsi-phy@fd922a00 {
 			};
 		};
 
-		imem@fe805000 {
+		imem: imem@fe805000 {
 			status = "disabled";
 			compatible = "syscon", "simple-mfd";
 			reg = <0xfe805000 0x1000>;
@@ -1614,7 +1614,7 @@ rpm {
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests {
+			rpm_requests: rpm_requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
-- 
2.32.0

