Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F615256B1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358543AbiELU4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358517AbiELU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:56:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F7674F5;
        Thu, 12 May 2022 13:56:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id EF0091F4586A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652388982;
        bh=YqWlVpmLvyMqVh31pbNW57iaZRVckJ8tr9KyK+2OHmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADLIjj2n3ZAFp4Hg6jXTr9H+pg6wj9FtJseKNE+UWqtNdkGuQt7cl/xyEd9+WFulX
         3YM6Kf+h4JKJTI/YCaqGIfQKSWwfZHFRdqZXKAkcJM53wbRvdzhOYd9fNoVf1IhqHJ
         f/Iudlfq7KgMxpJNqGD1YfGsyvdX3wfsPXO3fbNUaTR0DM/AmBPjcLrGYJphLyk2Ci
         dhq0gyXO/01gc9TuUMkwxzajbL3W1ePojbvGRJQHxIL/8TwnBGQkxBkKTAPZ0GQkZv
         QUFMwk8kLK6mFcwJDYQw/48wgbYGxij+qnZdweqRGm5sqxc+hTNCe2tNfkVfsFg/N/
         EcRaHoqIqmjmw==
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
Subject: [PATCH v3 06/16] arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
Date:   Thu, 12 May 2022 16:55:52 -0400
Message-Id: <20220512205602.158273-7-nfraprado@collabora.com>
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

The Asurada platform has five I2C controllers and two SPI controllers
that are used. In preparation for enabling the devices connected to
these controllers, enable and configure their busses.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---

(no changes since v1)

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index ca55dd095e80..4fce48d0f653 100644
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
2.36.1

