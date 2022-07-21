Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D092657CE30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiGUOu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiGUOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:50:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD062019E;
        Thu, 21 Jul 2022 07:50:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E4FA6601AB6;
        Thu, 21 Jul 2022 15:50:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658415032;
        bh=PxVOdo3kmX5GhVqhInInTAsKF/mvybao/JRyPYM/wN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhMOLexbI/J6DRhKHUs3stBIJKE/U0o04dE0zkTOM8ggsKjwROG3afPQVz3bBcBLn
         DyG80nCcYt0gd95FjWIlKFtR+tfw1RiqGkalb+s2hsDMyZMKrYOnKa07et2ve5DeKf
         xjTTtD7xsPUvgIRolrMlScGWAEx6qFZoCJKaZ/OI9E9l83Fi/mVGzefABXYiNwv7Zm
         AZLaLaOH5vHLsEjbrT1ygFY0j0Vz3XG60IKql3D2fYGcdIfgumuVHHSdbcm+Z8pXqj
         4bVbgL/N7jm2jvpwbce0dWTmXDklRN6nHPsiXzsB8l1rxnedzKFOoO064YFSb+HlMM
         AOp8vyH7e3KcA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 7/8] arm64: dts: mediatek: cherry: Enable keyboard PWM backlight
Date:   Thu, 21 Jul 2022 16:50:16 +0200
Message-Id: <20220721145017.918102-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
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

Add a pwm-leds node to enable the PWM controlled keyboard backlight.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index ca9955a97f8f..9086a440a995 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include "mt8195.dtsi"
 #include "mt6359.dtsi"
 
@@ -31,6 +32,18 @@ dmic_codec: dmic-codec {
 		wakeup-delay-ms = <50>;
 	};
 
+	led-controller {
+		compatible = "pwm-leds";
+
+		keyboard_backlight: keyboard-backlight {
+			default-state = "off";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			label = "cros_ec::kbd_backlight";
+			max-brightness = <1023>;
+			pwms = <&cros_ec_pwm 3>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
-- 
2.35.1

