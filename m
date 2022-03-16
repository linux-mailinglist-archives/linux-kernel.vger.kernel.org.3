Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899AF4DB49C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357204AbiCPPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357159AbiCPPPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:15:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076845792;
        Wed, 16 Mar 2022 08:13:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 298211F4467E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647443617;
        bh=t5bAb94VXfBDVM8bnyfOVDys57n3UV6MaXzdmkwM90Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RynSvKpHpCH/C9/GmIJFRLeCD+h1B58erwCcKUaBI73V7AdzKqYo9Fc6IH6tJAuXm
         K8vwVs1T3lgiiRe6vl06lF6sWt5G0TNZfVRaI8HNhj00mH5KZZWis4WPXuv4Lqi7Dg
         1YmAu8XI4fBnrDO6rMkIUEax//HIMKeDWWX3GoPOY9HIbvsumQxXDTkb6HONA7p71Y
         1HQph4mPPUN1bPtz2kIOeKqcLoZba6TgediAI5/LFek38xMhPr3zRwoUX5vqB/j0VZ
         xqgJG+N1MiHZ4574DAToifvHMvOQwA2gV5Rpg1V1FVD/AlpIA2s0ASc7twa2l1d8bV
         sSK1K93d39NAw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 04/10] arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
Date:   Wed, 16 Mar 2022 11:13:21 -0400
Message-Id: <20220316151327.564214-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316151327.564214-1-nfraprado@collabora.com>
References: <20220316151327.564214-1-nfraprado@collabora.com>
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

The Asurada platform has five I2C controllers and two SPI controllers
that are used. In preparation for enabling the devices connected to
these controllers, enable and configure their busses.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 5cb7580a13cf..3c5b1e475cf6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -85,6 +85,47 @@ ppvar_sys: ppvar-sys {
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
@@ -311,6 +352,95 @@ &pio {
 			  "AUD_DAT_MOSI1",
 			  "AUD_DAT_MISO0",
 			  "AUD_DAT_MISO1";
+
+	i2c0_pins: i2c0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO204__FUNC_SCL0>,
+				 <PINMUX_GPIO205__FUNC_SDA0>;
+			bias-pull-up;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <7>;
+		};
+	};
+
+	i2c1_pins: i2c1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO118__FUNC_SCL1>,
+				 <PINMUX_GPIO119__FUNC_SDA1>;
+			bias-pull-up;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <7>;
+		};
+	};
+
+	i2c2_pins: i2c2-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO141__FUNC_SCL2>,
+				 <PINMUX_GPIO142__FUNC_SDA2>;
+			bias-pull-up;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <0>;
+		};
+	};
+
+	i2c3_pins: i2c3-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO160__FUNC_SCL3>,
+				 <PINMUX_GPIO161__FUNC_SDA3>;
+			bias-disable;
+			mediatek,drive-strength-adv = <7>;
+		};
+	};
+
+	i2c7_pins: i2c7-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO124__FUNC_SCL7>,
+				 <PINMUX_GPIO125__FUNC_SDA7>;
+			bias-disable;
+			mediatek,drive-strength-adv = <7>;
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
2.35.1

