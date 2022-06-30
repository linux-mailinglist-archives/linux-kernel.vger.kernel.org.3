Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7443D561F60
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiF3PeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbiF3Pdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E773F8A2;
        Thu, 30 Jun 2022 08:33:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A0716601975;
        Thu, 30 Jun 2022 16:33:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656603211;
        bh=UVbfYKEp/UeHIzeeBg5jE/nWREPvL/7gFeHO3MKYGcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlXswnkJyVrkDmTAsWhmp5Z99o7Hiaq3mRZtf2oNn9/iD0BV+KoCVqjzZX35r3pHL
         380sjv28tpyf2rhw9uMiJizg20PflFEyzheDrlUUJJakZJrVCtib8ejsReLof9ZWNZ
         OURhxQ0WZ++rKBjOKzRvEQxe0jNrhs4M9rHB3ozrKlqK4ZtijZO8kJiGJFKDlwwN7F
         CW7X3lUsw28aJCFGn2ohH5E1csQa85iWc83Zcf7jbwlAmJrEq0oskLO1FD1kpGHuO1
         mDlzBWTOFnSYjd8yCXq5BlTfiYogoxE4pRpdX3fkYvH6rWnoS5CXHdNm8t4vSlY3OO
         N6dWFemSxkiDQ==
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
Subject: [PATCH 08/11] arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers
Date:   Thu, 30 Jun 2022 17:33:13 +0200
Message-Id: <20220630153316.308767-9-angelogioacchino.delregno@collabora.com>
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

Add USB functionality by enabling the required PHYs and the XHCI
controllers.
This enables all of the supported USB ports on the Cherry boards.

Please note that u3phy1 also enables u3port1, which is configured
to be a PCI-Express PHY for the second PCIe controller that is
found on the MT8195 SoC, which will be enabled in a later commit.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 23a86d07274c..379d0e5c4055 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -93,6 +93,15 @@ ppvar_sys: regulator-ppvar-sys {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	usb_vbus: regulator-5v0-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+	};
 };
 
 &i2c0 {
@@ -563,6 +572,52 @@ &spi0 {
 	mediatek,pad-select = <0>;
 };
 
+&u3phy0 {
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
+&u3phy3 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
+
+&xhci0 {
+	status = "okay";
+
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&usb_vbus>;
+};
+
+&xhci1 {
+	status = "okay";
+
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&usb_vbus>;
+};
+
+&xhci2 {
+	status = "okay";
+
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&usb_vbus>;
+};
+
+&xhci3 {
+	status = "okay";
+
+	/* MT7921's USB Bluetooth has issues with USB2 LPM */
+	usb2-lpm-disable;
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&usb_vbus>;
+};
-- 
2.35.1

