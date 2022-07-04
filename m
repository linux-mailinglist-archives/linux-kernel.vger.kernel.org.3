Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642365651D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiGDKNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiGDKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:13:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77064D10F;
        Mon,  4 Jul 2022 03:13:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FBA1660198A;
        Mon,  4 Jul 2022 11:13:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656929611;
        bh=bu6B2YcCIYZ6plXvXeLwW+wNbSXcWtCS4ehbelYtopY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlURyK2nUwWnjHb+c0TDCo2Tfh/NkIrknxQVESdZEZRZygtrTNuim9574RnoXze9j
         P+8Yhaz04DubblJ0OyS6xMm4CbT4TdDx0FG4HH3Yf8UAVSU64uWnVprqq+qRPil/EF
         WxpMJThx59EwQr5PWZqyknUi2EnL+rkbGwhFonE7Vyx+9TmN+V9NRH2/9oXTPM0FlF
         frbWAEPFKVm12lGDuYhfO1bMNZ7bcZSiwXH4Uv/JyP+7n4IGpRAFCHCMZ4obh8mvk+
         kSO6E9qVh4BsVmR/Mqn3WXNKAEnsSSTX0iaempFszgrXo27xo2lNzPnvxDv2rCcmt6
         Er0+PtHviP8+w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 03/11] arm64: dts: mediatek: cherry: Add platform regulators layout and config
Date:   Mon,  4 Jul 2022 12:13:13 +0200
Message-Id: <20220704101321.44835-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
References: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the regulators layout for this platform, including the basic power
rails controlled by the EC (and/or always on).
Moreover, include the MT6359 PMIC devicetree and add some configuration
for its regulators, essential to keep the machine alive after booting.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 7406d7bbf725..f4c3d33843a7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include "mt8195.dtsi"
+#include "mt6359.dtsi"
 
 / {
 	aliases {
@@ -19,6 +20,109 @@ memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
 	};
+
+	/* system wide LDO 3.3V power rail */
+	pp3300_z5: regulator-pp3300-ldo-z5 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_ldo_z5";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* separately switched 3.3V power rail */
+	pp3300_s3: regulator-pp3300-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_s3";
+		/* automatically sequenced by PMIC EXT_PMIC_EN2 */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&pp3300_z2>;
+	};
+
+	/* system wide 3.3V power rail */
+	pp3300_z2: regulator-pp3300-z2 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_z2";
+		/* EN pin tied to pp4200_z2, which is controlled by EC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide 4.2V power rail */
+	pp4200_z2: regulator-pp4200-z2 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp4200_z2";
+		/* controlled by EC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide switching 5.0V power rail */
+	pp5000_s5: regulator-pp5000-s5 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp5000_s5";
+		/* controlled by EC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide semi-regulated power rail from battery or USB */
+	ppvar_sys: regulator-ppvar-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+/* for CPU-L */
+&mt6359_vcore_buck_reg {
+	regulator-always-on;
+};
+
+/* for CORE */
+&mt6359_vgpu11_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_sshub_buck_reg {
+	regulator-always-on;
+	regulator-min-microvolt = <550000>;
+	regulator-max-microvolt = <550000>;
+};
+
+/* for CORE SRAM */
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+/* for GPU SRAM */
+&mt6359_vsram_others_ldo_reg {
+	regulator-always-on;
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <750000>;
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-always-on;
 };
 
 &uart0 {
-- 
2.35.1

