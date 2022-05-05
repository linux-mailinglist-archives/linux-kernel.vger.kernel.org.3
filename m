Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC7851C994
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385408AbiEETup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385358AbiEETub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:50:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B15E774;
        Thu,  5 May 2022 12:46:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id E54C31F45CCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651780006;
        bh=1u4qe9l+DHtHmHsuoC7WXDiH41P3SfBlsVHP90O4+hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUsc7EfC2p097+dI8XIPo9JDk6gX753g0G1/Si2UqCm3ikI747zz/stCNIK6Dpmqz
         P6BHLqVWuG19pE3sJUTgoqX8NbHjh6yg8cu2tXKEukziIva+Y7BkG1LZWgBE3fMQ2t
         502HkgGOGV8vDP51J/YRgaUXYprC9nR4i2QInYLc5wHX/9ZsgvUp+/Q5hMHNRriJ39
         ash6cLkfw5OvlDY86v2jxVxND0LSPmI6gUmVLiLsrqMYFZEJwjTzvX6HLEYMyhuhpD
         JxgTlUZmDEgiBJjniQ50ztDlvHyTlGiu9bKeVSk5VDAaEHWyp5vUISWZUrMs1CA8Nz
         LZOtzseQwk5aw==
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
Subject: [PATCH v2 11/16] arm64: dts: mediatek: asurada: Add I2C touchscreen
Date:   Thu,  5 May 2022 15:45:45 -0400
Message-Id: <20220505194550.3094656-12-nfraprado@collabora.com>
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

All machines of the Asurada platform have a touchscreen at address 0x10
in the I2C0 bus, but the devices vary: Spherion has the Elan eKTH3500
touchscreen, while Hayato has a generic HID-over-i2c touchscreen.

Add common support for the touchscreens on the platform and the
specifics in each board file.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

(no changes since v1)

 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  7 ++++++
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  4 +++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 25 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index 00c76709a055..b62c747e9e54 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -9,3 +9,10 @@ / {
 	model = "Google Hayato rev1";
 	compatible = "google,hayato-rev1", "google,hayato", "mediatek,mt8192";
 };
+
+&touchscreen {
+	compatible = "hid-over-i2c";
+	post-power-on-delay-ms = <10>;
+	hid-descr-addr = <0x0001>;
+	vdd-supply = <&pp3300_u>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index d384d584bbcf..35d9c5294fe0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -11,3 +11,7 @@ / {
 		     "google,spherion-rev1", "google,spherion-rev0",
 		     "google,spherion", "mediatek,mt8192";
 };
+
+&touchscreen {
+	compatible = "elan,ekth3500";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index a15e84d86449..c852cb0e8b63 100644
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
2.36.0

