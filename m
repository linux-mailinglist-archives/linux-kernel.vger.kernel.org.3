Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833B561F68
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiF3Pdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiF3Pdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CA6220D7;
        Thu, 30 Jun 2022 08:33:29 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2413C660196D;
        Thu, 30 Jun 2022 16:33:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656603207;
        bh=jogVEZhtKyX8PbDyMB9xCc1ckAJzJb39HZYE1/psFO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2gzTT5fHhXY5fdGABAYABEnjCRQqc/6aSezdn73L2uiPETndybCnk4KSmQ0nUih+
         WoeX7tqaaiMo5W+WfpSL72XjLCtHv7xwu/DuK0dHKd7goK3uNB1Ab42RBW1nrrluKx
         UNobQDPOlhypsSzhZTbVhP79bDl6uOV7sSg23OWQAgRCkK3xApTpVN8S9G63hez4aG
         EWfWRI4zfIvBOjOOt1p2d/PEF1TwpBb5VJq9PmNvq9AdMZRyGaziO8rPV2pRlT+bl3
         iY1z+5+mj5NljM1ZyGQ5mqXlrt/M+U6qB3VPcNfyQBsx4rNNanBEfnueWBLIonRuiM
         XAqoxz+Y+Agog==
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
Subject: [PATCH 04/11] arm64: dts: mediatek: cherry: Add platform regulators layout and config
Date:   Thu, 30 Jun 2022 17:33:09 +0200
Message-Id: <20220630153316.308767-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
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

Add the regulators layout for this platform, including the basic power
rails controlled by the EC (and/or always on).
Moreover, include the MT6359 PMIC devicetree and add some configuration
for its regulators, essential to keep the machine alive after booting.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 14f8f30b1eb3..091338f7d5ff 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include "mt8195.dtsi"
+#include "mt6359.dtsi"
 
 / {
 	aliases {
@@ -19,6 +20,107 @@ memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
 	};
+
+	/* system wide LDO 3.3V power rail */
+	pp3300_z5: regulator-3v3-pp3300-ldo-z5 {
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
+	pp3300_s3: regulator-3v3-pp3300-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_s3";
+		/* automatically sequenced by PMIC EXT_PMIC_EN2 */
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&pp3300_z2>;
+	};
+
+	/* system wide 3.3V power rail */
+	pp3300_z2: regulator-3v3-pp3300-z2 {
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
+	pp4200_z2: regulator-4v2-pp4200-z2 {
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
+	pp5000_s5: regulator-5v0-pp5000-s5 {
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
 
 &pmic {
-- 
2.35.1

