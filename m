Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598435651DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiGDKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiGDKNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:13:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB5CE2A;
        Mon,  4 Jul 2022 03:13:36 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79F60660198D;
        Mon,  4 Jul 2022 11:13:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656929615;
        bh=FHgSrJU3WzqM39AkIrMiTStk5IDquSuk3dITN0i8HE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZI0Y2gmu5P3Eq2L8o5RGwZqqX1pUhxTKWLVllEIFsDD9807bWlhEU4XztQ2bsVKw
         u4n8wodV9IDbeft3QFkRcM1uUEOSmVf4IczSVty0AM6twl+0AprAeKZVaCD3en7w3k
         u7qXUjBM657dQXvXrinFwiqaT3gwj0PAj0r1mRTjR3o2pQFGVH4him1o4ZIaikXhSj
         G6ABGEStkczi5SbGnMx8g0PGWxU9EyFU1lAdenuVwThLlrKNF6pGL6+NcEDQZSSTIc
         Q0yhj7vgRArqGjy372fOeNJ2oJv3HFr1uTw7fTFagSvFxYZ3+AVwJ6h3+HdT+Mb11O
         mP5iJJHTRzYVA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 07/11] arm64: dts: mediatek: cherry: Enable I2C and SPI controllers
Date:   Mon,  4 Jul 2022 12:13:17 +0200
Message-Id: <20220704101321.44835-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
References: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This platform uses eight I2C controllers and one SPI controller:
in preparation for enabling devices attached to these controllers,
add basic configuration to enable the busses.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index f00565466328..20a4a3a32ab9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -9,6 +9,13 @@
 
 / {
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c7 = &i2c7;
 		mmc0 = &mmc0;
 		serial0 = &uart0;
 	};
@@ -90,6 +97,63 @@ ppvar_sys: regulator-ppvar-sys {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+};
+
+&i2c1 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	i2c-scl-internal-delay-ns = <12500>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+};
+
+&i2c2 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+};
+
+&i2c3 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
+
+&i2c4 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+};
+
+&i2c5 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+};
+
+&i2c7 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c7_pins>;
+};
+
 &mmc0 {
 	status = "okay";
 
@@ -302,6 +366,68 @@ &pio {
 		"AP_SPI_FLASH_MOSI",
 		"AP_SPI_FLASH_MISO";
 
+	i2c0_pins: i2c0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
+				 <PINMUX_GPIO9__FUNC_SCL0>;
+			bias-disable;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c1_pins: i2c1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO10__FUNC_SDA1>,
+				 <PINMUX_GPIO11__FUNC_SCL1>;
+			bias-pull-up = <1000>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c2_pins: i2c2-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
+				 <PINMUX_GPIO13__FUNC_SCL2>;
+			bias-disable;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c3_pins: i2c3-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO14__FUNC_SDA3>,
+				 <PINMUX_GPIO15__FUNC_SCL3>;
+			bias-pull-up = <1000>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c4_pins: i2c4-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
+				 <PINMUX_GPIO17__FUNC_SCL4>;
+			bias-pull-up = <1000>;
+			drive-strength = <4>;
+		};
+	};
+
+	i2c5_pins: i2c5-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO29__FUNC_SCL5>,
+				 <PINMUX_GPIO30__FUNC_SDA5>;
+			bias-disable;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c7_pins: i2c7-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO27__FUNC_SCL7>,
+				 <PINMUX_GPIO28__FUNC_SDA7>;
+			bias-disable;
+		};
+	};
+
 	mmc0_pins_default: mmc0-default-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
@@ -409,12 +535,34 @@ pins-low-power-pupd {
 			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
+
+	spi0_pins: spi0-default-pins {
+		pins-cs-mosi-clk {
+			pinmux = <PINMUX_GPIO132__FUNC_SPIM0_CSB>,
+				 <PINMUX_GPIO134__FUNC_SPIM0_MO>,
+				 <PINMUX_GPIO133__FUNC_SPIM0_CLK>;
+			bias-disable;
+		};
+
+		pins-miso {
+			pinmux = <PINMUX_GPIO135__FUNC_SPIM0_MI>;
+			bias-pull-down;
+		};
+	};
 };
 
 &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&spi0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	mediatek,pad-select = <0>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.35.1

