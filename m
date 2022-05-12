Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC975256BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358529AbiELU5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358580AbiELU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:57:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DA16928F;
        Thu, 12 May 2022 13:56:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id B734F1F45AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652388998;
        bh=oen+/Gb8r5CVD7w+WMrsnQB9YhJdlf1/8shCrq8Zx0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GskHdfBKxcpmG8k23Wmh35zEM4lO+jrgugX00nQAHsGJNvbilMGeQQDMyKckAVan4
         nQg2qBMWLR2CakJnlWheApUbHIwav3PNRwsLZ7OMS55SGBbK5W0MKdO7m2MaPeL+2V
         zXOn4OTSngs3m3IJjajwBLAz5wJpbgWoMJFhgdfrPSTpPh2aL6zrV/BDa6If2yvQ9i
         qPtRa0eTgsq6VDq4x7vYtF9qye7zC2/oCufKXLuGpog8qExGGF4+sraTaVw9bh5n/D
         aQbed6V00oFqN1XXhkIVWSbIFBFGddbKlxrw2XGS0p5z0h0wDpAvK6XuHLXn0qsoXn
         1Lcaiz7sy9rlw==
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
Subject: [PATCH v3 11/16] arm64: dts: mediatek: asurada: Add I2C touchscreen
Date:   Thu, 12 May 2022 16:55:57 -0400
Message-Id: <20220512205602.158273-12-nfraprado@collabora.com>
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

All machines of the Asurada platform have a touchscreen at address 0x10
in the I2C0 bus, but the devices vary: Spherion has the Elan eKTH3500
touchscreen, while Hayato has a generic HID-over-i2c touchscreen.

Add common support for the touchscreens on the platform and the
specifics in each board file.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---

(no changes since v1)

 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  7 ++++++
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  4 +++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 25 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index ca18fcf2ad4f..1e91491945f6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -38,3 +38,10 @@ MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
 		CROS_STD_MAIN_KEYMAP
 	>;
 };
+
+&touchscreen {
+	compatible = "hid-over-i2c";
+	post-power-on-delay-ms = <10>;
+	hid-descr-addr = <0x0001>;
+	vdd-supply = <&pp3300_u>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index 30b03895de41..42db81e95fae 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -40,3 +40,7 @@ MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
 		CROS_STD_MAIN_KEYMAP
 	>;
 };
+
+&touchscreen {
+	compatible = "elan,ekth3500";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index a63b3c86d650..d9c9852339a8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -92,6 +92,13 @@ &i2c0 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
+
+	touchscreen: touchscreen@10 {
+		reg = <0x10>;
+		interrupts-extended = <&pio 21 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+	};
 };
 
 &i2c1 {
@@ -458,6 +465,24 @@ pins-int-n {
 			mediatek,pull-up-adv = <3>;
 		};
 	};
+
+	touchscreen_pins: touchscreen-default-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO21__FUNC_GPIO21>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO137__FUNC_GPIO137>;
+			output-high;
+		};
+
+		pins-report-sw {
+			pinmux = <PINMUX_GPIO138__FUNC_GPIO138>;
+			output-low;
+		};
+	};
 };
 
 &spi1 {
-- 
2.36.1

