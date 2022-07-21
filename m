Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F357CC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiGUNm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:42:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECDE7E31D;
        Thu, 21 Jul 2022 06:42:35 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5AB8D6601AAE;
        Thu, 21 Jul 2022 14:42:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658410954;
        bh=akTb+gtu7ReGU7vaNrXZI/GzP5obrfG91xyx1IuWCT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y80YZP2S/6CF3IswsEqGwn3wtC0MpOrFK8QfIWWO1/6JCSR7ztz+LzVSO8296vSfB
         CMEpRj39aea0i2ZYb+jIIWtBpCspZK9iKSMLwvhI+wf0B8ObD38rRgOX9qLqKOcsbc
         MFftWcYIc3t9lgt+B8vrBwWGgkeK9LooeNH/gyKzfawBYazMO5RyhaplrrmRG+1jxy
         VYA0acB+ULdpIBfaqTtVRTHY/ogDJMSkyJ/le2fqblWP9ohkLup7ZrnCpF5SStL2yB
         ulM49iOcPewfTVMqmYD9CnaqAOU5klDURHZ409dMwBbPFO/09fe76Cf+P0vdlGGSoB
         nAnN8oU/PJGkw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/8] arm64: dts: mediatek: cherry: Enable Elantech eKTH3000 i2c trackpad
Date:   Thu, 21 Jul 2022 15:42:25 +0200
Message-Id: <20220721134228.310178-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721134228.310178-1-angelogioacchino.delregno@collabora.com>
References: <20220721134228.310178-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cherry platform uses an Elantech touchpad/trackpad: enable
probing it at address 0x15 on I2C1.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 8859957c7b27..58349d4c3c8b 100644
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
@@ -727,6 +737,14 @@ subpmic_pin_irq: pins-subpmic-int-n {
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
2.35.1

