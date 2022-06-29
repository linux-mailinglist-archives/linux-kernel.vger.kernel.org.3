Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D4A560546
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiF2QAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiF2QAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CF21D33B;
        Wed, 29 Jun 2022 09:00:13 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D6E96601967;
        Wed, 29 Jun 2022 17:00:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518412;
        bh=RMpC7msGnNKAM7uk86ht5QA2izSfq/gh610fxQejVhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs0N+97WYD/VZ1ms59+wyryFPnLK72LcqPhyBx3T/gSa9LC8svbQftcYEo37GGW80
         efuaw1RDu1bPwZeGTN1E2a4i8Y3KicXyXa5gltDGQDp/yETI6e2KnQ1pI0wJHPoFFh
         dXxslJw+XPlPRFE392+X1Nq6UtQdk7o/47mjZFWBUdxul0gz5Wv1bGKbpP4M+vjrtK
         n/6l1tJPg+fT+SdyvVlb/2vbGPCtAHdYvUu6cTDHR88WC2KX26XoHdKP5+jpz1Iw/l
         indPvI3L4Ala69UDD8hCi7LX/xKRRBpjQqg1t3CYRfj6DIKQpfUB2+pnjsciYx4lOb
         RGi8d9TplkEdw==
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
Subject: [PATCH v4 06/19] arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
Date:   Wed, 29 Jun 2022 11:59:43 -0400
Message-Id: <20220629155956.1138955-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629155956.1138955-1-nfraprado@collabora.com>
References: <20220629155956.1138955-1-nfraprado@collabora.com>
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

The Asurada platform has five I2C controllers and two SPI controllers
that are used. In preparation for enabling the devices connected to
these controllers, enable and configure their busses.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

Changes in v4:
- Switched mediatek,drive-strength-adv for drive-strength-microamp
- Switched mediatek,pull-up-adv for bias-pull-up

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index ca55dd095e80..72dc974fe6fc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -85,6 +85,47 @@ ppvar_sys: regulator-var-sys {
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+};
+
+&i2c2 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	clock-stretch-ns = <12600>;
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
+&i2c7 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c7_pins>;
+};
+
 &pio {
 	/* 220 lines */
 	gpio-line-names = "I2S_DP_LRCK",
@@ -311,6 +352,91 @@ &pio {
 			  "AUD_DAT_MOSI1",
 			  "AUD_DAT_MISO0",
 			  "AUD_DAT_MISO1";
+
+	i2c0_pins: i2c0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO204__FUNC_SCL0>,
+				 <PINMUX_GPIO205__FUNC_SDA0>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c1_pins: i2c1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO118__FUNC_SCL1>,
+				 <PINMUX_GPIO119__FUNC_SDA1>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c2_pins: i2c2-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO141__FUNC_SCL2>,
+				 <PINMUX_GPIO142__FUNC_SDA2>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+		};
+	};
+
+	i2c3_pins: i2c3-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO160__FUNC_SCL3>,
+				 <PINMUX_GPIO161__FUNC_SDA3>;
+			bias-disable;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c7_pins: i2c7-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO124__FUNC_SCL7>,
+				 <PINMUX_GPIO125__FUNC_SDA7>;
+			bias-disable;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	spi1_pins: spi1-default-pins {
+		pins-cs-mosi-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_SPI1_A_CSB>,
+				 <PINMUX_GPIO159__FUNC_SPI1_A_MO>,
+				 <PINMUX_GPIO156__FUNC_SPI1_A_CLK>;
+			bias-disable;
+		};
+
+		pins-miso {
+			pinmux = <PINMUX_GPIO158__FUNC_SPI1_A_MI>;
+			bias-pull-down;
+		};
+	};
+
+	spi5_pins: spi5-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO38__FUNC_SPI5_A_MI>,
+				 <PINMUX_GPIO37__FUNC_GPIO37>,
+				 <PINMUX_GPIO39__FUNC_SPI5_A_MO>,
+				 <PINMUX_GPIO36__FUNC_SPI5_A_CLK>;
+			bias-disable;
+		};
+	};
+};
+
+&spi1 {
+	status = "okay";
+
+	mediatek,pad-select = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+};
+
+&spi5 {
+	status = "okay";
+
+	cs-gpios = <&pio 37 GPIO_ACTIVE_LOW>;
+	mediatek,pad-select = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi5_pins>;
 };
 
 &uart0 {
-- 
2.36.1

