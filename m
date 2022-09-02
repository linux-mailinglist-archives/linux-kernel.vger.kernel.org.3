Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8B5AA99D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiIBIMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiIBIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:12:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6EBCCEC;
        Fri,  2 Sep 2022 01:12:14 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE57D6601F08;
        Fri,  2 Sep 2022 09:12:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662106333;
        bh=kikhFjYsB8fpNC7NnVXcUriNohFHIleRV+n+9fHCOGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyomPQIahsfs6RWYlKvHFzgV7+WcWnlb2ttOMedzpX6fL+Bhyd6aO0+xd1bvOkzbq
         o5a8x7V6ZYvV7Z60kzytKLjFvPTyfNZ/+6CwF0ifrD6oWWRIa0tRSKTZFPMECQR8v2
         OB7zJHJEPV2BHzpQ/RljDGK6m56b/aSdcjLdxqYqI1eDcQF2qze/JxRsiaPr6jtLF1
         Btdu6n6BP36aQJ4lAyFsWU+Rqbcqb+xEHLPln/wW8XOoCq845chB+x9S/uND7U2beF
         T5FHB1TjcMS6wYzD5tRnbzX1MueEmHWRmlxNHfU/yUlWZTEeEgFMPc64cv/SwpZTLv
         O4AgdpuGi4SQA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 5/7] arm64: dts: mediatek: cherry: Enable secondary SD/MMC controller
Date:   Fri,  2 Sep 2022 10:11:54 +0200
Message-Id: <20220902081156.38526-6-angelogioacchino.delregno@collabora.com>
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

As of now, all of the boards based on the cherry platform have a
usable secondary SD/MMC controller, usually for SD cards: enable
it to allow both booting from it and generally accessing external
storage.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 1174ab344e47..0654a28e6782 100644
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
+	pinctrl-0 = <&mmc1_pins_default>, <&mmc1_pins_detect>;
+	pinctrl-1 = <&mmc1_pins_default>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&mt_pmic_vmch_ldo_reg>;
+	vqmmc-supply = <&mt_pmic_vmc_ldo_reg>;
+};
+
 /* for CPU-L */
 &mt6359_vcore_buck_reg {
 	regulator-always-on;
@@ -575,6 +594,32 @@ pins-rst {
 		};
 	};
 
+	mmc1_pins_detect: mmc1-detect-pins {
+		pins-insert {
+			pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
+			bias-pull-up;
+		};
+	};
+
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
+	};
+
 	nor_pins_default: nor-default-pins {
 		pins-ck-io {
 			pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
-- 
2.37.2

