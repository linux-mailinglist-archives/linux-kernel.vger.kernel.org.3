Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9042F57CC31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiGUNnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiGUNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:42:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971946FA02;
        Thu, 21 Jul 2022 06:42:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 138A46601AB2;
        Thu, 21 Jul 2022 14:42:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658410956;
        bh=wMIiEPoxAhEiKY22jDJpVVBvPTPTcpvE8DsrxOXPpJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiekTYt7ct2roixZMYW/tBDip+jdYZ4dfA5pHkwJqsU9TFI+kQxFNdiRy6JGdS2/A
         crpVrzx4emlQvlmqKYw6P6JBhuUoX8XCQ0DgJ+vBuF/uz5Ut9yZ6ACTTubUEsddTzz
         N0ihjwbCfIiTFP0Vdo+ln3COjCzfmuAGJIXjvfL8whuSEXYNkNL35lMatyW282ufIb
         LVE2JwdLGu6V/1deaF2+yNeo0mdsf9cZlBmJabmz4UhcFEQrwwlt8mTFnhDcWZAmeC
         qxVCKZXXIhrcl65bAVt2O/EHep1/Tm0Dc0/ahlD7sKzUJaCs5wkBpsm3UglDRXG4iy
         gxqHYKyDDCj+w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 8/8] arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus
Date:   Thu, 21 Jul 2022 15:42:28 +0200
Message-Id: <20220721134228.310178-9-angelogioacchino.delregno@collabora.com>
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

All machines in the Cherry platform use MT6315 over SPMI: add the
two instances, providing Vbcpu and Vgpu regulators.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         | 52 +------------------
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 42 +++++++++++++++
 2 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 04597ffc4286..ede7b208c882 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -1,54 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-burnet.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-cozmo.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel-sku1.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel-sku6.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel-sku7.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel14.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel14-sku2.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kenzo.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu-sku22.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku288.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-kingler.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-krabby.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196609.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
+
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
+
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 9086a440a995..6219544e9912 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/spmi/spmi.h>
 #include "mt8195.dtsi"
 #include "mt6359.dtsi"
 
@@ -979,6 +980,47 @@ usb_c1: connector@1 {
 	};
 };
 
+&spmi {
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	mt6315@6 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x6 SPMI_USID>;
+
+		regulators {
+			mt6315_6_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vbcpu";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-ramp-delay = <6250>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	mt6315@7 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x7 SPMI_USID>;
+
+		regulators {
+			mt6315_7_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vgpu";
+				regulator-min-microvolt = <625000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-ramp-delay = <6250>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 &u3phy0 {
 	status = "okay";
 };
-- 
2.35.1

