Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28B557CE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiGUOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiGUOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:50:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3FF252A9;
        Thu, 21 Jul 2022 07:50:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B803E6601AAE;
        Thu, 21 Jul 2022 15:50:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658415029;
        bh=c9v3l9FdU2UcsKgOUHjJo+v/EkJQURQSMnGUGxmVLvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnPIhqFHkbBbo3n1vL+fu46KmMrjOPabN0u76tdWr2UHBKNcXpRuxfjg5RAYka+1L
         bsqKjEIJXwIh4l1H57RjOfi2IUF5c0z3jPdJMg1GWjpTkFQVySXWk8ps4H4j3nB/cq
         SVAM5bE1d2bUUyX4QXu80WjL8BXNd1PGHC6f3UvCbj87sBieaKZ5ZbC4nCrVBf6jbq
         Xs5vPgIYQLT5nvdV7DY3YAcJlwNTcpnYA2u2FaA0dPC2756IOcfZUdcsl087PFyecH
         sMQ+J2vzPRpCmprDIpDLiSjTwMTynO7pIJDunQWUbmwVVF7s8+vWH5GbfJvvublW+G
         W3ipKOQXuj9Hw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/8] arm64: dts: mediatek: cherry: Enable the System Companion Processor
Date:   Thu, 21 Jul 2022 16:50:10 +0200
Message-Id: <20220721145017.918102-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 features a SCP like some other older SoCs, and Cherry uses it
for various tasks. Add the required pin configuration and DMA pool
and enable the node.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index fcc600674339..feebbe367e93 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -104,6 +104,18 @@ usb_vbus: regulator-5v0-usb-vbus {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scp_mem: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+	};
 };
 
 &i2c0 {
@@ -600,6 +612,14 @@ pins-low-power-pupd {
 		};
 	};
 
+	scp_pins: scp-default-pins {
+		pins-vreq {
+			pinmux = <PINMUX_GPIO76__FUNC_SCP_VREQ_VAO>;
+			bias-disable;
+			input-enable;
+		};
+	};
+
 	spi0_pins: spi0-default-pins {
 		pins-cs-mosi-clk {
 			pinmux = <PINMUX_GPIO132__FUNC_SPIM0_CSB>,
@@ -643,6 +663,14 @@ &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&scp {
+	status = "okay";
+
+	memory-region = <&scp_mem>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&scp_pins>;
+};
+
 &spi0 {
 	status = "okay";
 
-- 
2.35.1

