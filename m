Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFB7561F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiF3PeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiF3Pdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F003ED2C;
        Thu, 30 Jun 2022 08:33:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5EA0D6601979;
        Thu, 30 Jun 2022 16:33:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656603213;
        bh=UHGvuNhuUk7L5c7BKtAhAhJRqJa8V9GWgDdTDxtXvvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lssvneloFtoaJ59J9UcbKSZwHCwGiqV6tWJ5ePbZXkha7i7mmKQ2GXp8StPv8sQ0w
         xY5AOgCbS+K8uHBmBcy6jQ9JIgAwsk0Ltgr5gzlgSgRMSxQQuCx/adzp8KLtj5K+es
         6+M1HHqO5hEt26ijSUqRfkb775kRvpFJUY0O/hv+B+8B7+KQ1LOIDT019onrD2NFKu
         AEfvOhIC+4X/fAwiiMp1gQ1uFGH3GcQuDYWimFI8t2MlpwrMGMGO1ySXs5GkBKRvxH
         XS5sVuk9tCm+au1k7MZGkaOFS4lHV5JYNsNxdqyqp4z4HLaT25PVnx4zOxp4WQHvtw
         mkI4Jo/mzD5Mg==
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
Subject: [PATCH 10/11] arm64: dts: mediatek: cherry: Enable support for the SPI NOR flash
Date:   Thu, 30 Jun 2022 17:33:15 +0200
Message-Id: <20220630153316.308767-11-angelogioacchino.delregno@collabora.com>
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

This platform has a SPI NOR: enable support for it, completing the
storage compartment enablement for the entire platform.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 1668aa1be373..2687c6d40ac1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -231,6 +231,21 @@ &mt6359_vufs_ldo_reg {
 	regulator-always-on;
 };
 
+&nor_flash {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_pins_default>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+	};
+};
+
 &pio {
 	mediatek,rsel-resistance-in-si-unit;
 	pinctrl-names = "default";
@@ -513,6 +528,22 @@ pins-rst {
 		};
 	};
 
+	nor_pins_default: nor-default-pins {
+		pins-ck-io {
+			pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO141__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO143__FUNC_SPINOR_IO1>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO140__FUNC_SPINOR_CS>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up;
+		};
+	};
+
 	pio_default: pio-default-pins {
 		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
-- 
2.35.1

