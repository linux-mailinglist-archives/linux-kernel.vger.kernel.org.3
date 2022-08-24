Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D568B5A047E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiHXXMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiHXXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:12:29 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD48034F;
        Wed, 24 Aug 2022 16:12:21 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F1CC31A13C6;
        Thu, 25 Aug 2022 01:12:18 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B0C421A1404;
        Thu, 25 Aug 2022 01:12:18 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 5F06B4060D;
        Wed, 24 Aug 2022 16:12:17 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Zhang Ying <ying.zhang22455@nxp.com>
Subject: [PATCH 7/9] arm64: dts: ls1046a: add gpios based i2c recovery information
Date:   Wed, 24 Aug 2022 18:11:58 -0500
Message-Id: <20220824231200.494-8-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220824231200.494-1-leoyang.li@nxp.com>
References: <20220824231200.494-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scl-gpios property for i2c recovery and add SoC specific compatible
string for SoC specific fixup.

Signed-off-by: Zhang Ying <ying.zhang22455@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index c7c6c82626fd..c95a990e2edd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -502,7 +502,7 @@ dspi: spi@2100000 {
 		};
 
 		i2c0: i2c@2180000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
@@ -516,35 +516,38 @@ i2c0: i2c@2180000 {
 		};
 
 		i2c1: i2c@2190000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
+			scl-gpios = <&gpio3 2 0>;
 			status = "disabled";
 		};
 
 		i2c2: i2c@21a0000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21a0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
+			scl-gpios = <&gpio3 10 0>;
 			status = "disabled";
 		};
 
 		i2c3: i2c@21b0000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1046a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21b0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
+			scl-gpios = <&gpio3 12 0>;
 			status = "disabled";
 		};
 
-- 
2.37.1

