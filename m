Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44B561F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiF3PeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiF3Pdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125041618;
        Thu, 30 Jun 2022 08:33:35 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 41477660197D;
        Thu, 30 Jun 2022 16:33:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656603214;
        bh=SX4P7RsJewzaMEBrvT46jeE3YycPiAePm3ZFNcwi5O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuaUnODh1qw4OyIyA6rE3Sii52gGiK6JGI0LeZCFG/rtoiXjA51r6pC8Up3sWiBR/
         hxrwfQU4NsW7YyHFG/G+CZTkyPQvNwNiOBZeVJwGepNSWxEYENoeUry8zMj9hOJZOb
         QnrRqlXecmw7k+Z4Vn7rYgqe1v1eOuZ5kDrhhnMqnZyh/5OoLsSOmi9pHyqc1RCD+4
         myxssKckdPykteL25QLzc6Ggz97Ik6Yij1bFMdJxaeZfF2wM4AH88/I8wKsByx2zvN
         9BDzKjrRG3Lz0IUdXdY0Hl5PQzYlhzqa6ECWfLqam39/vR/qmhUXoyzNzbr0LhadNq
         485JB2fL0wSdA==
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
Subject: [PATCH 11/11] arm64: dts: mediatek: cherry: Add I2C-HID touchscreen on I2C4
Date:   Thu, 30 Jun 2022 17:33:16 +0200
Message-Id: <20220630153316.308767-12-angelogioacchino.delregno@collabora.com>
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

This platform carries a HID compatible I2C touchscreen on the i2c4 bus,
but it may either be at 0x10, or at 0x15, depending on the board model:
declare both as disabled in the common Cherry device-tree and enable
the required touchscreen node on a per-board basis.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  4 ++
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  4 ++
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  4 ++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 41 +++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 17e9e4d6f6ab..2837fb24c84c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -9,3 +9,7 @@ / {
 	model = "MediaTek Tomato (rev1) board";
 	compatible = "google,tomato-rev1", "google,tomato", "mediatek,mt8195";
 };
+
+&ts_10 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index ee5fd07ad573..4e1d1a1887c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -29,3 +29,7 @@ pins-low-power-pcie0-disable {
 		bias-pull-down;
 	};
 };
+
+&ts_10 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index 792f6c83e88b..4a45884203ea 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -30,3 +30,7 @@ pins-low-power-pcie0-disable {
 		bias-pull-down;
 	};
 };
+
+&ts_10 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 2687c6d40ac1..7a32c7006a5a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -143,6 +143,31 @@ &i2c4 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c4_pin>;
+
+	/* Depending on the machine, the TS may be at 0x10 or at 0x15 */
+	ts_10: touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+		hid-descr-addr = <0x0001>;
+		interrupts-extended = <&pio 92 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		post-power-on-delay-ms = <10>;
+		vdd-supply = <&pp3300_s3>;
+		status = "disabled";
+	};
+
+	ts_15: touchscreen@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		hid-descr-addr = <0x0001>;
+		interrupts-extended = <&pio 92 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		post-power-on-delay-ms = <10>;
+		vdd-supply = <&pp3300_s3>;
+		status = "disabled";
+	};
 };
 
 &i2c5 {
@@ -609,6 +634,22 @@ subpmic_pin_irq: pins-subpmic-int-n {
 			bias-pull-up;
 		};
 	};
+
+	touchscreen_pins: touchscreen-default-pins {
+		pins-int-n {
+			pinmux = <PINMUX_GPIO92__FUNC_GPIO92>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+		pins-rst {
+			pinmux = <PINMUX_GPIO56__FUNC_GPIO56>;
+			output-high;
+		};
+		pins-report-sw {
+			pinmux = <PINMUX_GPIO57__FUNC_GPIO57>;
+			output-low;
+		};
+	};
 };
 
 &pmic {
-- 
2.35.1

