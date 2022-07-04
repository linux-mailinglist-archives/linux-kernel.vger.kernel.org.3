Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8A5651E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiGDKOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiGDKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:13:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1394D111;
        Mon,  4 Jul 2022 03:13:39 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 856F06601987;
        Mon,  4 Jul 2022 11:13:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656929618;
        bh=AFxHTqlOyeK1LCtC1MqBh69cl8u6Qrdx+4RcZLmfPmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7EdQ3Y5HL0jzjaagGKq2QTQYuaMQoHax6OdhjdlYsNW5q/fERJI7bAs8Hip404j4
         dSRxYanPBc5COovVCREukZCJMWyMFo/THiTmjugyDl73ZQ8YU/DK7UmeE612r0hwJG
         uUVA2sxiJwVoXjOaKGJ5ngR02HxJAZMd2iYuaTeCtMHyJ2H3Y5otZagmSlRqj7xGWu
         SCJ9dLjfAxVbnRl8yXxYxNBs7C19bPf7dG+64JQLlfrilHpGgCkdmGAWUaF1JRgXJP
         MXYj0AS8+sM458Xnc3R+GMNB8ZxyRs7GpvdlNk8+u5AbE6tO77mrEUWAA2VSVS63q9
         c+w7naWjDdjag==
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
Subject: [PATCH v2 10/11] arm64: dts: mediatek: cherry: Enable support for the SPI NOR flash
Date:   Mon,  4 Jul 2022 12:13:20 +0200
Message-Id: <20220704101321.44835-11-angelogioacchino.delregno@collabora.com>
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

This platform has a SPI NOR: enable support for it, completing the
storage compartment enablement for the entire platform.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index c07d3ac79f62..2c8b760d0da1 100644
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
+			drive-strength = <6>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO140__FUNC_SPINOR_CS>;
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
 	pio_default: pio-default-pins {
 		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
-- 
2.35.1

