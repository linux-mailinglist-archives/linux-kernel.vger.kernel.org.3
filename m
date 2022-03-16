Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF34DB4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357221AbiCPPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357224AbiCPPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:15:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876449F3D;
        Wed, 16 Mar 2022 08:13:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id DF5CA1F446A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647443623;
        bh=W2MR9JRQeWd3Gd2gjq9LLXv6OCGWn1HG5Yfu70CzhFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8EbRb6+7S3l8ZQ9BS1lCOzIh2eKSg06Y+KAhfn6SXeoJZWKOqdlVwZIVTgOHJwUn
         OSMsikWLNyZjbrphJYBKnt4OWn40JDFptSEx1n9gD6n9VyBzwLrHcgol2QN1wuJX9F
         OwtBWun4Sv6A7M+KdLybc1nrq+2QhqOKLAQCTcMSkllJa9Bk/1RSyy6d4ljRX3eUNW
         O6r8pZuprjZLvr6pIW7ijgPxcZxNlY6tj3xNoj20VovwBYygz/qnPPPhQIEm7KjSat
         e7vutsa/t0HlPFr9xR3OsMj7tf0SNmFI5tbq486WGzjlc24HTxmlC+vGOJH5xU8LQ+
         SudJPEp4spa8g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 09/10] arm64: dts: mediatek: asurada: Add I2C touchscreen
Date:   Wed, 16 Mar 2022 11:13:26 -0400
Message-Id: <20220316151327.564214-10-nfraprado@collabora.com>
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

All machines of the Asurada platform have a touchscreen at address 0x10
in the I2C0 bus, but the devices vary: Spherion has the Elan eKTH3500
touchscreen, while Hayato has a generic HID-over-i2c touchscreen.

Add common support for the touchscreens on the platform and the
specifics in each board file.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  7 ++++++
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  4 +++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 25 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index e18e14b13d61..22d187df1428 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -9,3 +9,10 @@ / {
 	model = "MediaTek Hayato rev1";
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
index b5372ce6bd95..20ae4a869c63 100644
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
index b911f4fc3038..6e5c2f8fd591 100644
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
2.35.1

