Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1128A5256B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358558AbiELU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358613AbiELU5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:57:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE91869CD5;
        Thu, 12 May 2022 13:56:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 79CEF1F45AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652389004;
        bh=i7Z2W6YC5XDeB3fbg7wPBOxu/CQV/7/SaA7a+o0HOSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9+Fvbu8wTUi1CFOOJfCnD2jxLfrwNzOZxzZ/fboIaNLXkDYcSHLCf6qL1o3C18MP
         1JUo7sQqTr7QHGmPEbjUVG13aqSXCTfXR1syo/RPGzBsoZ/0C0QP4EkNthe/5aRExS
         AsFRMSEGaswkzPIx+uFdFuK8pmwa9juMTzWIwkSNe/8QueDTRDgixBVeHIDvq0CdUB
         CcFidUoXzQ72XxV25ZIRpRd1veVcO9J425Lm8bSbf03SRmBOzvqKooz0GpI91OHoaJ
         4AIoYMeiADPJAyH09C1u1+b3eo5IM54g4Hf2AQp7sRTUbTDVd1RjrKWI4TyMKC/kmV
         vjUpXF4ijxuaw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 14/16] arm64: dts: mediatek: asurada: Enable PCIe and add WiFi
Date:   Thu, 12 May 2022 16:56:00 -0400
Message-Id: <20220512205602.158273-15-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512205602.158273-1-nfraprado@collabora.com>
References: <20220512205602.158273-1-nfraprado@collabora.com>
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

Enable MT8192's PCIe controller and add support for the MT7921e WiFi
card that is present on that bus for the Asurada platform.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

Changes in v3:
- Renamed regulator node to be generic

Changes in v2:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index ecae2730789e..dde4de27ec61 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -66,6 +66,19 @@ pp3300_u: regulator-3v3-u {
 		vin-supply = <&pp3300_g>;
 	};
 
+	pp3300_wlan: regulator-3v3-wlan {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_wlan";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp3300_wlan_pins>;
+		enable-active-high;
+		gpio = <&pio 143 GPIO_ACTIVE_HIGH>;
+	};
+
 	/* system wide switching 5.0V power rail */
 	pp5000_a: regulator-5v0-a {
 		compatible = "regulator-fixed";
@@ -84,6 +97,17 @@ ppvar_sys: regulator-var-sys {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		wifi_restricted_dma_region: wifi@c0000000 {
+			compatible = "restricted-dma-pool";
+			reg = <0 0xc0000000 0 0x4000000>;
+		};
+	};
 };
 
 &i2c0 {
@@ -144,6 +168,28 @@ &i2c7 {
 	pinctrl-0 = <&i2c7_pins>;
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+
+	pcie0: pcie@0,0 {
+		device_type = "pci";
+		reg = <0x0000 0 0 0 0>;
+		num-lanes = <1>;
+		bus-range = <0x1 0x1>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		wifi: wifi@0,0 {
+			reg = <0x10000 0 0 0 0x100000>,
+			      <0x10000 0 0x100000 0 0x100000>;
+			memory-region = <&wifi_restricted_dma_region>;
+		};
+	};
+};
+
 &pio {
 	/* 220 lines */
 	gpio-line-names = "I2S_DP_LRCK",
@@ -434,6 +480,34 @@ pins-bus {
 		};
 	};
 
+	pcie_pins: pcie-default-pins {
+		pins-pcie-wake {
+			pinmux = <PINMUX_GPIO63__FUNC_PCIE_WAKE_N>;
+			bias-pull-up;
+		};
+
+		pins-pcie-pereset {
+			pinmux = <PINMUX_GPIO64__FUNC_PCIE_PERESET_N>;
+		};
+
+		pins-pcie-clkreq {
+			pinmux = <PINMUX_GPIO65__FUNC_PCIE_CLKREQ_N>;
+			bias-pull-up;
+		};
+
+		pins-wifi-kill {
+			pinmux = <PINMUX_GPIO145__FUNC_GPIO145>; /* WIFI_KILL_L */
+			output-high;
+		};
+	};
+
+	pp3300_wlan_pins: pp3300-wlan-pins {
+		pins-pcie-en-pp3300-wlan {
+			pinmux = <PINMUX_GPIO143__FUNC_GPIO143>;
+			output-high;
+		};
+	};
+
 	spi1_pins: spi1-default-pins {
 		pins-cs-mosi-clk {
 			pinmux = <PINMUX_GPIO157__FUNC_SPI1_A_CSB>,
-- 
2.36.1

