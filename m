Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723D85A042C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiHXWhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHXWhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:37:17 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585F7C773;
        Wed, 24 Aug 2022 15:37:15 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B12AF2014C0;
        Thu, 25 Aug 2022 00:37:13 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FA9A2014BD;
        Thu, 25 Aug 2022 00:37:13 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 1FF404060A;
        Wed, 24 Aug 2022 15:37:12 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Zhang Ying <ying.zhang22455@nxp.com>
Subject: [PATCH 08/11] arm64: dts: ls1043a: add gpio based i2c recovery information
Date:   Wed, 24 Aug 2022 17:36:59 -0500
Message-Id: <20220824223700.32442-9-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220824223700.32442-1-leoyang.li@nxp.com>
References: <20220824223700.32442-1-leoyang.li@nxp.com>
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
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index b37244acf16a..20888aceb5f4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -538,7 +538,7 @@ dspi1: spi@2110000 {
 		};
 
 		i2c0: i2c@2180000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
@@ -553,7 +553,7 @@ i2c0: i2c@2180000 {
 		};
 
 		i2c1: i2c@2190000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
@@ -561,11 +561,12 @@ i2c1: i2c@2190000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
+			scl-gpios = <&gpio4 2 0>;
 			status = "disabled";
 		};
 
 		i2c2: i2c@21a0000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21a0000 0x0 0x10000>;
@@ -573,11 +574,12 @@ i2c2: i2c@21a0000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
+			scl-gpios = <&gpio4 10 0>;
 			status = "disabled";
 		};
 
 		i2c3: i2c@21b0000 {
-			compatible = "fsl,vf610-i2c";
+			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21b0000 0x0 0x10000>;
@@ -585,6 +587,7 @@ i2c3: i2c@21b0000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
+			scl-gpios = <&gpio4 12 0>;
 			status = "disabled";
 		};
 
-- 
2.37.1

