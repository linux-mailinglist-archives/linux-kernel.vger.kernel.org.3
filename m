Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155E65651E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiGDKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiGDKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:13:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D0C5F6C;
        Mon,  4 Jul 2022 03:13:38 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82A956601985;
        Mon,  4 Jul 2022 11:13:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656929617;
        bh=cYCFPkI9Ox4t3aj8urLrA3wqMRp1z1bSxEhnMr1wUSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qdw82P7jQP9czqM3dF4d1Az22FRnHzS7I6TPRQ0FQjKV5s/uF4Xv+aXHBbCZaAVRz
         M/NPUhNyxdzPxVTQ/aRV/DQImMihGL5z8Te/Mvq80i8vmbkuhZK0CNmHH31wjOX9BO
         pgUhcNm4BJQ5+LTT5TqQnG7eOseHxMrtBQEfu8VQZaxxDhx85x1s0RId39gPUrJHnn
         yC5rBUEylLu5ipsxkbI2tx4wxPVqduJRbHTkka5bKOz6qL9xoNd1jpwUriDXqj6U1P
         jS2jLzyv4ikQjA/Ft/ujbvcjVODGUbaybO0cxc+m69mfFMj7HxKui5b6rDzWhZU6+W
         xgdT/4tFs0xUw==
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
Subject: [PATCH v2 09/11] arm64: dts: mediatek: cherry: Enable MT6360 sub-pmic on I2C7
Date:   Mon,  4 Jul 2022 12:13:19 +0200
Message-Id: <20220704101321.44835-10-angelogioacchino.delregno@collabora.com>
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

All devices of the Cherry platform have a MT6360 sub-pmic,
providing two LDOs. Add the required node to enable the PMIC
but without regulators yet, as these will be added in a
later commit.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index f68d8ff05b4d..c07d3ac79f62 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -161,6 +161,18 @@ &i2c7 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c7_pins>;
+
+	pmic@34 {
+		#interrupt-cells = <1>;
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

