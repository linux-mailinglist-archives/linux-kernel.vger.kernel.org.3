Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB61C56053C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiF2QBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiF2QAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691221E11;
        Wed, 29 Jun 2022 09:00:29 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 692CD660198D;
        Wed, 29 Jun 2022 17:00:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518428;
        bh=etvqQ1Sf4L9KOJ6PfLg/qIPZJ2SbAA+l1UyPzPWGVwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vp86zMw2GSlDu1PAFaueC5lnum0u0hTa4z3UyfBNZDukkMJJnem88oC876mYn+2TP
         ob9W5WbSl0j237TWLhuN2RXo7IDzA5pQhTGJLWba2FrqQqekpRsV7RPlgF3wGF+PPS
         V14L4WzyEPibYHKM5/ShK6sp2PwEW8EB0x+cz2idB0kC0/wdSRSn1skW6RlvpbsO5i
         N3G09TpbZ1h0EjWdrOvpQ9rvmZaoeQEK9AbR6zh9UIoueBG/rjFggRLSk16tIx5q1V
         mfttr/sLp8bVGga4vW5c3mAiQxYso0bWbL0+tk95f2shNXYgXJIE97CDTwjbgCQOt5
         hwmcC3ZuCoBMg==
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
Subject: [PATCH v4 17/19] arm64: dts: mediatek: asurada: Enable MMC
Date:   Wed, 29 Jun 2022 11:59:54 -0400
Message-Id: <20220629155956.1138955-18-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629155956.1138955-1-nfraprado@collabora.com>
References: <20220629155956.1138955-1-nfraprado@collabora.com>
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

Enable both MMC controllers present on Asurada. MMC0 is for
non-removable internal memory, while MMC1 is an SD card slot. MMC1 isn't
used on all machines, but in those cases the CD interrupt is never
triggered and thus it is basically as if it was disabled.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v4:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index d56c73e37633..7b89f6e552c5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -170,6 +170,46 @@ &i2c7 {
 	pinctrl-0 = <&i2c7_pins>;
 };
 
+&mmc0 {
+	status = "okay";
+
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_default_pins>;
+	pinctrl-1 = <&mmc0_uhs_pins>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	supports-cqe;
+	cap-mmc-hw-reset;
+	mmc-hs400-enhanced-strobe;
+	hs400-ds-delay = <0x12814>;
+	no-sdio;
+	no-sd;
+	non-removable;
+};
+
+&mmc1 {
+	status = "okay";
+
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_default_pins>;
+	pinctrl-1 = <&mmc1_uhs_pins>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cd-gpios = <&pio 17 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&mt6360_ldo5_reg>;
+	vqmmc-supply = <&mt6360_ldo3_reg>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	no-sdio;
+	no-mmc;
+};
+
 /* for CORE */
 &mt6359_vgpu11_buck_reg {
 	regulator-always-on;
@@ -503,6 +543,115 @@ pins-bus {
 		};
 	};
 
+	mmc0_default_pins: mmc0-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO184__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO188__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO185__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO193__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO186__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO189__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO187__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO190__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO183__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO192__FUNC_MSDC0_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO194__FUNC_MSDC0_RSTB>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO184__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO188__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO185__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO193__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO186__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO189__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO187__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO190__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO183__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <10>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO192__FUNC_MSDC0_CLK>;
+			drive-strength = <10>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO194__FUNC_MSDC0_RSTB>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO191__FUNC_MSDC0_DSL>;
+			drive-strength = <10>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	mmc1_default_pins: mmc1-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO54__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO56__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO55__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO53__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO52__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO51__FUNC_MSDC1_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO17__FUNC_GPIO17>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_uhs_pins: mmc1-uhs-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO54__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO56__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO55__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO53__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO52__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO51__FUNC_MSDC1_CLK>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
 	pcie_pins: pcie-default-pins {
 		pins-pcie-wake {
 			pinmux = <PINMUX_GPIO63__FUNC_PCIE_WAKE_N>;
-- 
2.36.1

