Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B365651E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiGDKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiGDKNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:13:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75354CE2E;
        Mon,  4 Jul 2022 03:13:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D66F66017F7;
        Mon,  4 Jul 2022 11:13:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656929616;
        bh=Uny8EAV7GcwYYEBS06gASsjFwmXHUY5/gKfjVQ6IThs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxAXfGrtTmOPgixovjTav8w5OaniqIxuDNFoENTxcmvpnrHRD+OQ/U+t2e4MGs4Kd
         Sf2odbj9t3iM5uMnwplgihE1rPJGa83IZ67hb/4XZnc8LvtcsGfM4YUP/4+XIjtJHE
         1fKZU8GwJ8NnD/OlKiU//s61mXz83c5hxPEAar3K7Vb3+zB03/9NQWy0Yt4H23BA2t
         +MRT8+KwzOcdHAgj7mDmPSptU7Hm7gN11KnSEXIo4x01q7LVbAF4fQM0hFX5CfVcZC
         3NthdRT8xp8iuAuxF+FZblkJT62QS+hm4TTBh+AX3ftLvwvPId5AzsTcYL+yLpJK4N
         +yeOGs87DuyBQ==
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
Subject: [PATCH v2 08/11] arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers
Date:   Mon,  4 Jul 2022 12:13:18 +0200
Message-Id: <20220704101321.44835-9-angelogioacchino.delregno@collabora.com>
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

Add USB functionality by enabling the required PHYs and the XHCI
controllers.
This enables all of the supported USB ports on the Cherry boards.

Please note that u3phy1 also enables u3port1, which is configured
to be a PCI-Express PHY for the second PCIe controller that is
found on the MT8195 SoC, which will be enabled in a later commit.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 20a4a3a32ab9..f68d8ff05b4d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -95,6 +95,15 @@ ppvar_sys: regulator-ppvar-sys {
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

