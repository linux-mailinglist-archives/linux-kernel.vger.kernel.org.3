Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E064DB4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357226AbiCPPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357131AbiCPPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:15:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BF95A08F;
        Wed, 16 Mar 2022 08:13:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 3F30E1F4468D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647443621;
        bh=iWCKuQcSEhS1E0/lZPLekaNrYJWzHrIOHJ2/Yty469k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6CEDyUVZ1jFrCdInFhpSC/7sqMyVyW4jVS8wNwJ1Ct6DfM7lptPfpO0GQvWJ/9IJ
         BvjLh0q/NBU/hyqyoUyxT+z1yBKIGti+Tkis0sDlnu+TJZDwzvnsPjGGrZG4RnVmeX
         8x1JQJo3vgASiaDuOmwu9MZ6tWdtLjJ77RRkYUXHhoO1T1CY3MYQ01mOBi/KmRfQwN
         qyGzgPAb0QnsQyBvG/zEcvp+YWT8XIIXlwOSKmSVJZKLPnnmaCgxK9i3AZoYYkx/VJ
         PrS2UwpSuO5Or//sM3gqxjKyJqpRNzw3Br1lGb25LvuK/pQoJBnvpaYic3uhorLdsT
         hvsjlQO0L83cA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 07/10] arm64: dts: mediatek: asurada: Add Cr50 TPM
Date:   Wed, 16 Mar 2022 11:13:24 -0400
Message-Id: <20220316151327.564214-8-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316151327.564214-1-nfraprado@collabora.com>
References: <20220316151327.564214-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Asurada platform has a Google Security Chip connected to the SPI5
bus. It runs the cr50 firmware and provides TPM functionality. Add
support for it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

 .../arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 1d1a4b9a989a..3b4c74d5d5c3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -5,6 +5,7 @@
  */
 /dts-v1/;
 #include "mt8192.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
@@ -353,6 +354,13 @@ &pio {
 			  "AUD_DAT_MISO0",
 			  "AUD_DAT_MISO1";
 
+	cr50_int: cr50-irq-default-pins {
+		pins-gsc-ap-int-odl {
+			pinmux = <PINMUX_GPIO171__FUNC_GPIO171>;
+			input-enable;
+		};
+	};
+
 	cros_ec_int: cros-ec-irq-default-pins {
 		pins-ec-ap-int-odl {
 			pinmux = <PINMUX_GPIO5__FUNC_GPIO5>;
@@ -517,6 +525,15 @@ &spi5 {
 	mediatek,pad-select = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi5_pins>;
+
+	cr50@0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		interrupts-extended = <&pio 171 IRQ_TYPE_EDGE_RISING>;
+		spi-max-frequency = <1000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cr50_int>;
+	};
 };
 
 &uart0 {
-- 
2.35.1

