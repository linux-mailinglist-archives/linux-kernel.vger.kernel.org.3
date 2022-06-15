Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0954C7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347608AbiFOLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347229AbiFOLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAEE4EF79;
        Wed, 15 Jun 2022 04:50:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d14so15697623eda.12;
        Wed, 15 Jun 2022 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HENmXPwQgZrLvgBCOSxbn3j3qup91Vw70nnac08YVQI=;
        b=DUgSbBif0rvoVLNJXtj/ChM9YSBp5WGCaDECnnql+GX3hRdyoqgIuQ2xRZFqjedHAf
         cnEJo5iClqIkgWsSOUF8paCNyTTFWHdWmuvUrd0CEjfkhgikfT+jbe6lbSKDZrKwELoJ
         22EmOIDiL+3X0CxgGcJ3i5ogwduadexq5qYRuM1L03r294jQwybtnqgQdHrbmKzdgK8a
         De2+Y8SBzqolsZauWOELhNie/rBqvlLIMw3SflSQvAdwyAYNRfjUCH5oFZcgtv6XrKSP
         NcSF4PrhRiOXbY0o5a6a+3xvgGdk4fWeRuQx2TmqZjpReXX+XO6l+3KLKH97sniqnNUL
         LBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HENmXPwQgZrLvgBCOSxbn3j3qup91Vw70nnac08YVQI=;
        b=XCNdOFY+cG1rDk1Wys3GMerkMvGBRfsfQZBznBxCOVZcKda5fGsJ8qn36vgufM2b0C
         2uFAxwQIQkwbKj0VBrpSzjTGchBDIvXUTyMGFUyI4L04UBuAntCYFvv4peOSx31Pgl5i
         74n/1nI47+dM3VVNaPOrXXmdzQqneY2RXNwhgfx+8nHyKQlPwK7fb+7UmytPyyzv2VRL
         zG2AJ1hXJE4zgBPmnyH/qRd6bzL6rqzqy7YJZYI4bpai6tebk9PpDyFA69w51NYldL3V
         dQ4C2s3PiiqxOuhiMxXj/FhXOz5kx1whnxmcYsClPhWDJAZBCYcKEypVGixrF0tU4XGe
         bImw==
X-Gm-Message-State: AJIora8ay/MpcbixmrFkuKIR4hM/mIeUpmYne+2X6YtijsbCQeyb6Qgx
        ELJZHP6Bry5QsooqAlmvH0Q=
X-Google-Smtp-Source: ABdhPJxqZWDzakNuE6KjaWfgvQSS+/by8OipbRpgC430xggG4gd/kgHQG9SoHcWJf/IeTObyU0iXwA==
X-Received: by 2002:a05:6402:32a6:b0:42d:ed8b:3d8 with SMTP id f38-20020a05640232a600b0042ded8b03d8mr12220196eda.225.1655293858511;
        Wed, 15 Jun 2022 04:50:58 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:58 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/18] ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
Date:   Wed, 15 Jun 2022 13:50:00 +0200
Message-Id: <20220615115006.45672-13-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

The Apalis iMX6 modules allow connecting a mipi-csi video input.
Add support for our OV5640 camera module but have it disabled.
This allows to enable it in an overlay per the current system
configuration.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- Fixed '-' vs. '_' in node name as pointed out by Fabio
- Sorted properties alphabetical in the newly added node

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 67 ++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index b4742ad85f56..bbd838acb8d6 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -29,6 +29,12 @@
 		status = "disabled";
 	};
 
+	clk_ov5640_osc: clk-ov5640-osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -110,6 +116,26 @@
 		regulator-always-on;
 	};
 
+	reg_ov5640_1v8_d_o_vdd: regulator-ov5640-1v8-d-o-vdd {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "DOVDD/DVDD_1.8V";
+		/* Note: The CSI module uses on-board 3.3V_SW supply */
+		vin-supply = <&reg_module_3v3>;
+	};
+
+	reg_ov5640_2v8_a_vdd: regulator-ov5640-2v8-a-vdd {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-name = "AVDD/AFVDD_2.8V";
+		/* Note: The CSI module uses on-board 3.3V_SW supply */
+		vin-supply = <&reg_module_3v3>;
+	};
+
 	reg_usb_otg_vbus: regulator-usb-otg-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -452,7 +478,6 @@
 		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>;	/* MXM3_13 */
 		status = "disabled";
 	};
-
 };
 
 /*
@@ -631,6 +656,30 @@
 	scl-gpios = <&gpio3 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
+
+	ov5640_csi_cam: ov5640_mipi@3c {
+		compatible = "ovti,ov5640";
+		AVDD-supply = <&reg_ov5640_2v8_a_vdd>;
+		DOVDD-supply = <&reg_ov5640_1v8_d_o_vdd>;
+		DVDD-supply = <&reg_ov5640_1v8_d_o_vdd>;
+		clock-names = "xclk";
+		clocks = <&clks IMX6QDL_CLK_CKO2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cam_mclk>;
+		/* These GPIOs are muxed with the iomuxc node */
+		powerdown-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+		reg = <0x3c>;
+		reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		status = "disabled";
+
+		port {
+			ov5640_to_mipi_csi2: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&mipi_csi_from_ov5640>;
+			};
+		};
+	};
 };
 
 &ipu1_di1_disp1 {
@@ -661,6 +710,22 @@
 	};
 };
 
+&mipi_csi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "disabled";
+
+	port@0 {
+		reg = <0>;
+
+		mipi_csi_from_ov5640: endpoint {
+			clock-lanes = <0>;
+			data-lanes = <1 2>;
+			remote-endpoint = <&ov5640_to_mipi_csi2>;
+		};
+	};
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
2.20.1

