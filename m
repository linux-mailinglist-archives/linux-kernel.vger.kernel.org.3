Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1905AA99E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiIBIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiIBIMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:12:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126FBB729D;
        Fri,  2 Sep 2022 01:12:13 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B64B6601F05;
        Fri,  2 Sep 2022 09:12:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662106331;
        bh=wp3o4Y17CxutbsfUPDmxWZ120aLT+CWRC1GPj2X5+Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLIpDl9BPR0MRTsh3do9lPthy0DgAYgsCPH4GemGyTGzHz9lWaDwkqHO0WxKBem4v
         Wcy8gU2uNsfRc2oKp/FmLEI3+4ylOnw4SQXOtcbDdxGVNhyws+OCmKfKX86rbaUT7+
         x1VNrmMFBstODhPVoSDkqRYK+twVdc5JBaVdn8fckjAO3XqPbaf2bzLTRJjzW556Eq
         Ca9i4ePUHoyvTgt/nnY851ls2jCotbrJ5Bmx7NsIjCui7eyuNR09SFnk+BCj5LW2+5
         ZMIIc4LHKHDydTIvw0SulkR130ir1D/adwcXpMH9RyfyZqMOEDleBN9CEnPl6n5Rkh
         EQCrsxgfaDtFg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 3/7] arm64: dts: mediatek: cherry: Add Google Security Chip (GSC) TPM
Date:   Fri,  2 Sep 2022 10:11:52 +0200
Message-Id: <20220902081156.38526-4-angelogioacchino.delregno@collabora.com>
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

Add support for the Cr50 Google Security Chip (GSC) found on this
platform on I2C3 to support TPM and to also use it as an entropy
source for the kernel.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 73f531f84fa2..a07e7fe66315 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -149,6 +149,14 @@ &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
+
+	tpm@50 {
+		compatible = "google,cr50";
+		reg = <0x50>;
+		interrupts-extended = <&pio 88 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cr50_int>;
+	};
 };
 
 &i2c4 {
@@ -426,6 +434,13 @@ &pio {
 		"AP_SPI_FLASH_MOSI",
 		"AP_SPI_FLASH_MISO";
 
+	cr50_int: cr50-irq-default-pins {
+		pins-gsc-ap-int-odl {
+			pinmux = <PINMUX_GPIO88__FUNC_GPIO88>;
+			input-enable;
+		};
+	};
+
 	cros_ec_int: cros-ec-irq-default-pins {
 		pins-ec-ap-int-odl {
 			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
-- 
2.37.2

