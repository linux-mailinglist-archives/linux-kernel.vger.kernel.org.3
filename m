Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB3561F64
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiF3PeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiF3Pde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC14130A;
        Thu, 30 Jun 2022 08:33:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B9016601977;
        Thu, 30 Jun 2022 16:33:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656603212;
        bh=Z5AoNXePqDCnxXb8uAYZR8QzxcTn7tQFTixe292MpDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9EDnd81JFVrRCxiTNFt7rOMnjZSNr+4qseMa/IczEdoCewcK+wMLT2uYpCbgdU26
         90Tslt8i42cXFf+ZAgwjkVaRUPMctG2KgC5Ldp54TEqqGFK0vUbnBvpvDwH60cXST3
         vU4bc5fuV+tSV2yHkhTW81nMKV61DF03znoxt/jlEtJz7B+i+jOwThjpwJWDsaXGVU
         /xPWygGxtV1kLB2Ahk/momOOE/EsWCKeTvTRhiXP8GVT+u0s7Kx/1F/xwzOI2Rq0Do
         1eR1vOnxfVGYFFBf0Z4nujT8WbpNhbAYwr0mWypDdgZGalLgMCVUO0mEw/s2joztNh
         T3oigYwSDiqDA==
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
Subject: [PATCH 09/11] arm64: dts: mediatek: cherry: Enable MT6360 sub-pmic on I2C7
Date:   Thu, 30 Jun 2022 17:33:14 +0200
Message-Id: <20220630153316.308767-10-angelogioacchino.delregno@collabora.com>
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

All devices of the Cherry platform have a MT6360 sub-pmic,
providing two LDOs. Add the required node to enable the PMIC
but without regulators yet, as these will be added in a
later commit.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 379d0e5c4055..1668aa1be373 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -161,6 +161,18 @@ &i2c7 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c7_pin>;
+
+	pmic@34 {
+		#interrupt-cells = <2>;
+		compatible = "mediatek,mt6360";
+		reg = <0x34>;
+		interrupt-controller;
+		interrupts-extended = <&pio 130 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "IRQB";
+		pinctrl-names = "default";
+		pinctrl-0 = <&subpmic_default>;
+		wakeup-source;
+	};
 };
 
 &mmc0 {
@@ -558,6 +570,14 @@ pins-miso {
 			bias-pull-down;
 		};
 	};
+
+	subpmic_default: subpmic-default-pins {
+		subpmic_pin_irq: pins-subpmic-int-n {
+			pinmux = <PINMUX_GPIO130__FUNC_GPIO130>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
 };
 
 &pmic {
-- 
2.35.1

