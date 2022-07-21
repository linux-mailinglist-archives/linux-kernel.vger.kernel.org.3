Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038A457CE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiGUOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiGUOud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:50:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA142019E;
        Thu, 21 Jul 2022 07:50:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EB346601AB4;
        Thu, 21 Jul 2022 15:50:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658415031;
        bh=V/+LAph7U+k+GMlqnvKVF6jJXNo43acPvSyK01bfszA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMQzVbMmKmURza+39h/65Dpdc1TwhpjlhfF4XEw3S3AWyd4Go5KmIaAHe5+LzF6pt
         aC6TxKTh/9rA1YFYFufbNG/uqJTJfAmkTKT9f+zbIv0aw/Z//2xRf6jGelrRvQLdfY
         hMjyEBR7spYH9OF9cC4wM6bZqttu9ZYw/agMr83jyZPmwpRzgK7S9tG3zXl3MvlNYF
         LBNODR0KonOqtzu0yejVj6KFgVFeaMDokaCtg1pV0OSowW5cLB6kSt2AnUA6yQG7Uw
         YJKE1ByzyNbSf/xtiZqYj4z9NJ2nHBdiV2mlw9g91ELHEBCWGPf4OI1EmR8zg/Yq2L
         M5ZxS81rSJLmw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 4/8] arm64: dts: mediatek: cherry: Enable secondary SD/MMC controller
Date:   Thu, 21 Jul 2022 16:50:13 +0200
Message-Id: <20220721145017.918102-5-angelogioacchino.delregno@collabora.com>
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

As of now, all of the boards based on the cherry platform have a
usable secondary SD/MMC controller, usually for SD cards: enable
it to allow both booting from it and generally accessing external
storage.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 2853f7f76c90..8859957c7b27 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -17,6 +17,7 @@ aliases {
 		i2c5 = &i2c5;
 		i2c7 = &i2c7;
 		mmc0 = &mmc0;
+		mmc1 = &mmc1;
 		serial0 = &uart0;
 	};
 
@@ -227,6 +228,24 @@ &mmc0 {
 	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
 };
 
+&mmc1 {
+	status = "okay";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&pio 54 GPIO_ACTIVE_LOW>;
+	max-frequency = <200000000>;
+	no-mmc;
+	no-sdio;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&mt_pmic_vmch_ldo_reg>;
+	vqmmc-supply = <&mt_pmic_vmc_ldo_reg>;
+};
+
 /* for CPU-L */
 &mt6359_vcore_buck_reg {
 	regulator-always-on;
@@ -575,6 +594,49 @@ pins-rst {
 		};
 	};
 
+	mmc1_pins_default: mmc1-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
 	nor_pins_default: nor-default-pins {
 		pins-ck-io {
 			pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
-- 
2.35.1

