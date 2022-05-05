Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9922E51C97B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385354AbiEETuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385326AbiEETuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:50:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62CE5DA7B;
        Thu,  5 May 2022 12:46:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 448A11F45CD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651779993;
        bh=e74sZbpqUGhj6kx7s7bPANpIdoqwtDfemeI26ZuR+Yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iT1gT+XswaaRB3tvXjtX2P9YwdojMf8MvpLtpB6o39WkDOBggr7DqmJzXpXAckyGQ
         oDiBYI933R5vdaZddvqdrIBGSY/ArJnxm0p8R7tPuZd3yg9Pwsm5zUCzw4VWQdSLDC
         kEF9bppZUpFbd+HJZutnuiBEj9z+MBhI03uvQAJrGHXM+bWEq/FawTQZzYkFx8V2jx
         TZGKL//dB7u+ekP7npJFTZJoi19Tps2XE2frrhUbzUaoMS3OYGloZnigNvZSbiu6xb
         tD/7P/eqs5UsU37OcNKPF01TOoyONzX/xVC1epVd0gfL3Exwhg+fazLYMvDwnrffV3
         AnfBwHshSJNqA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 07/16] arm64: dts: mediatek: asurada: Add ChromeOS EC
Date:   Thu,  5 May 2022 15:45:41 -0400
Message-Id: <20220505194550.3094656-8-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505194550.3094656-1-nfraprado@collabora.com>
References: <20220505194550.3094656-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ChromeOS Embedded Controller present on the Asurada
platform. It is connected through the SPI1 bus and offers several
functionalities: base detection, PWM controller, I2C tunneling,
regulators, Type-C connector management, keyboard and Smart Battery
Metrics (SBS).

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v2:
- Renamed PWM subnode to avoid dt-binding warning (ec-pwm -> pwm)

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 3c5b1e475cf6..662207d0eb75 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -353,6 +353,14 @@ &pio {
 			  "AUD_DAT_MISO0",
 			  "AUD_DAT_MISO1";
 
+	cros_ec_int: cros-ec-irq-default-pins {
+		pins-ec-ap-int-odl {
+			pinmux = <PINMUX_GPIO5__FUNC_GPIO5>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
 	i2c0_pins: i2c0-default-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO204__FUNC_SCL0>,
@@ -432,6 +440,74 @@ &spi1 {
 	mediatek,pad-select = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins>;
+
+	cros_ec: ec@0 {
+		compatible = "google,cros-ec-spi";
+		reg = <0>;
+		interrupts-extended = <&pio 5 IRQ_TYPE_LEVEL_LOW>;
+		spi-max-frequency = <3000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cros_ec_int>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		base_detection: cbas {
+			compatible = "google,cros-cbas";
+		};
+
+		cros_ec_pwm: pwm {
+			compatible = "google,cros-ec-pwm";
+			#pwm-cells = <1>;
+
+			status = "disabled";
+		};
+
+		i2c_tunnel: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			google,remote-bus = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mt6360_ldo3_reg: regulator@0 {
+			compatible = "google,cros-ec-regulator";
+			reg = <0>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		mt6360_ldo5_reg: regulator@1 {
+			compatible = "google,cros-ec-regulator";
+			reg = <1>;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		typec {
+			compatible = "google,cros-ec-typec";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_c0: connector@0 {
+				compatible = "usb-c-connector";
+				reg = <0>;
+				label = "left";
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+			};
+
+			usb_c1: connector@1 {
+				compatible = "usb-c-connector";
+				reg = <1>;
+				label = "right";
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -446,3 +522,6 @@ &spi5 {
 &uart0 {
 	status = "okay";
 };
+
+#include <arm/cros-ec-keyboard.dtsi>
+#include <arm/cros-ec-sbs.dtsi>
-- 
2.36.0

