Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB7564AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiGDAVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiGDAVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:21:01 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 772BF60E3;
        Sun,  3 Jul 2022 17:21:00 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Jul 2022 09:20:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 084AC205845A;
        Mon,  4 Jul 2022 09:20:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 4 Jul 2022 09:20:56 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B6B091DDD;
        Mon,  4 Jul 2022 09:20:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 7/9] ARM: dts: uniphier: Add ahci controller and glue layer nodes for PXs2
Date:   Mon,  4 Jul 2022 09:20:24 +0900
Message-Id: <1656894026-15707-8-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ahci controller and glue layer nodes including reset and phy.
This supports for PXs2 and the boards without PXs2 vodka board that
doesn't implement any SATA connectors.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts |  4 +++
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 40 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index 759384b60663..5f18b926c50a 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -99,3 +99,7 @@ &usb0 {
 &usb1 {
 	status = "okay";
 };
+
+&ahci {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 7d8c437b8f8b..04e9467734c4 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -599,6 +599,46 @@ mdio: mdio {
 			};
 		};
 
+		ahci: ahci@65600000 {
+			compatible = "socionext,uniphier-pxs2-ahci",
+				     "generic-ahci";
+			status = "disabled";
+			reg = <0x65600000 0x10000>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_clk 28>;
+			resets = <&sys_rst 28>, <&ahci_rst 0>;
+			ports-implemented = <1>;
+			phys = <&ahci_phy>;
+		};
+
+		ahci-glue@65700000 {
+			compatible = "socionext,uniphier-pxs2-ahci-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65700000 0x100>;
+
+			ahci_rst: reset@0 {
+				compatible = "socionext,uniphier-pxs2-ahci-reset";
+				reg = <0x0 0x4>;
+				clock-names = "link";
+				clocks = <&sys_clk 28>;
+				reset-names = "link";
+				resets = <&sys_rst 28>;
+				#reset-cells = <1>;
+			};
+
+			ahci_phy: phy@10 {
+				compatible = "socionext,uniphier-pxs2-ahci-phy";
+				reg = <0x10 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 28>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 28>, <&sys_rst 30>;
+				#phy-cells = <0>;
+			};
+		};
+
 		usb0: usb@65a00000 {
 			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
 			status = "disabled";
-- 
2.25.1

