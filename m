Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6A5AA99B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiIBIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiIBIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:12:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBEBD089;
        Fri,  2 Sep 2022 01:12:15 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7575F6601F09;
        Fri,  2 Sep 2022 09:12:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662106334;
        bh=4LxPwcVeTnZVaB30DwcaoVYhEeK36Lo9JgoJohkej1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+PfIFB+Tp4aImPoC1HbSDaSIOeVts+B3905EULsfoDYB3tzFSLz6jrtBr2kFxgiH
         Q6BSWoGfmNnWzb4q5UbAqYO+tZFv8/MFhC8r78gERpYGMP4pdKK0jvRtWDy1Wi9mjc
         1Lf3kjef9Q7Pz1OsXyFT2LU1VMMtPwcuDdxA3vCGuwyIBB+uF5bDoJIb1z28tS+50P
         CfpbyaLz6s118POTTIZAzxvoH2u2Ld1eJ3w692oTMLNiZSUHfuGfv8yKtzpAaIKtep
         6IHLvErbgETuEwIX10CWewHodnxwXtBaVOpP3oJu6QcMZq45KUY4BLTFuVYz3mentS
         mAeAvhk5GG+7Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 6/7] arm64: dts: mediatek: cherry: Enable Elantech eKTH3000 i2c trackpad
Date:   Fri,  2 Sep 2022 10:11:55 +0200
Message-Id: <20220902081156.38526-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902081156.38526-1-angelogioacchino.delregno@collabora.com>
References: <20220902081156.38526-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cherry platform uses an Elantech touchpad/trackpad: enable
probing it at address 0x15 on I2C1.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 0654a28e6782..ee59619068d9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -134,6 +134,16 @@ &i2c1 {
 	i2c-scl-internal-delay-ns = <12500>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
+
+	trackpad@15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
+		interrupts-extended = <&pio 6 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+		vcc-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
 };
 
 &i2c2 {
@@ -710,6 +720,14 @@ subpmic_pin_irq: pins-subpmic-int-n {
 		};
 	};
 
+	trackpad_pins: trackpad-default-pins {
+		pins-int-n {
+			pinmux = <PINMUX_GPIO6__FUNC_GPIO6>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
 	touchscreen_pins: touchscreen-default-pins {
 		pins-int-n {
 			pinmux = <PINMUX_GPIO92__FUNC_GPIO92>;
-- 
2.37.2

