Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98DB4B5256
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354713AbiBNN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:56:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354704AbiBNN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:56:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13FD20F55;
        Mon, 14 Feb 2022 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644847000; x=1676383000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xp+E8x6cp/+S9XO0xoBl+LMOfRA1V8o491BFrDS7rf8=;
  b=qFePtPuqxzhqEwKGMzBSlMrcnkqn1z/FwGxtGaUEpAmGNG5dr4RdzDSv
   lc9akbBULBKI1VBWD/Lj+oQCLnEN+ltHoAs4yQF7sKq1F3fyIgOfdp+5O
   1af/TD+QY4PfAJI7VanJOBmTK+Uplq3vUvBiM19rb7XhwirCJ8trEHG38
   scfARkByhOZmAofJ9uZdxICdsfnjTOiZ6rYzDmkrGodsE8DQ6gSRCqBhd
   Qyi9WxnwMlXI2E9bdboOQXTGjo1yLLTDWGa70bFgRvduBX2OrrRRCb/uk
   yQyw3dqU3U5KONM1Mfy0dTe0pSkEznWJfbPahUY19olH1UO3zOXRa+3Ab
   g==;
IronPort-SDR: wc1mHIUGheJnmBF55xhVIjmMLeLe7Jo4ChNivm6PlS6zDKkbRXnd2S12SRNGw/iKr6GPNfXF9J
 8phZow53I0a8Tn0IvABTTsifSjibxpxXR5gkx4cmgUjh0rxKACWAn9o4p53GCf5ZJc6cboIEkq
 owIxUa+7O132zHmnW/YAXwWasYljFmRFsQ51PVZqF707OHCHuvJbHpQchRU/tiivb9ZDZD+rI8
 aJaSQQXdunIVL+KsReQVBOQnku3PmwC9naOg/lkvxNLK4NCjhlnyRVD/rx+bBlce6UoK1pakH8
 k+9YHCGLs5zldN1LlOrkrLsK
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="152982591"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2022 06:56:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Feb 2022 06:56:38 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Feb 2022 06:56:33 -0700
From:   <conor.dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <ivan.griffin@microchip.com>,
        <atishp@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v7 06/11] riscv: dts: microchip: use clk defines for icicle kit
Date:   Mon, 14 Feb 2022 13:58:36 +0000
Message-ID: <20220214135840.168236-7-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214135840.168236-1-conor.dooley@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Update the Microchip Icicle kit device tree by replacing clock
related magic numbers with their defined counterparts.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../microchip/microchip-mpfs-icicle-kit.dts   |  2 +-
 .../boot/dts/microchip/microchip-mpfs.dtsi    | 25 ++++++++++---------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 0c748ae1b006..6d19ba196f12 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -31,7 +31,7 @@ cpus {
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x40000000>;
-		clocks = <&clkcfg 26>;
+		clocks = <&clkcfg CLK_DDRC>;
 	};
 };
 
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 869aaf0d5c06..717e39b30a15 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020 Microchip Technology Inc */
 
 /dts-v1/;
+#include "dt-bindings/clock/microchip,mpfs-clock.h"
 
 / {
 	#address-cells = <2>;
@@ -14,7 +15,6 @@ cpus {
 		#size-cells = <0>;
 
 		cpu@0 {
-			clock-frequency = <0>;
 			compatible = "sifive,e51", "sifive,rocket0", "riscv";
 			device_type = "cpu";
 			i-cache-block-size = <64>;
@@ -22,6 +22,7 @@ cpu@0 {
 			i-cache-size = <16384>;
 			reg = <0>;
 			riscv,isa = "rv64imac";
+			clocks = <&clkcfg CLK_CPU>;
 			status = "disabled";
 
 			cpu0_intc: interrupt-controller {
@@ -32,7 +33,6 @@ cpu0_intc: interrupt-controller {
 		};
 
 		cpu@1 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -48,6 +48,7 @@ cpu@1 {
 			mmu-type = "riscv,sv39";
 			reg = <1>;
 			riscv,isa = "rv64imafdc";
+			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
 			status = "okay";
 
@@ -59,7 +60,6 @@ cpu1_intc: interrupt-controller {
 		};
 
 		cpu@2 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -75,6 +75,7 @@ cpu@2 {
 			mmu-type = "riscv,sv39";
 			reg = <2>;
 			riscv,isa = "rv64imafdc";
+			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
 			status = "okay";
 
@@ -86,7 +87,6 @@ cpu2_intc: interrupt-controller {
 		};
 
 		cpu@3 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -102,6 +102,7 @@ cpu@3 {
 			mmu-type = "riscv,sv39";
 			reg = <3>;
 			riscv,isa = "rv64imafdc";
+			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
 			status = "okay";
 
@@ -113,7 +114,6 @@ cpu3_intc: interrupt-controller {
 		};
 
 		cpu@4 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -129,6 +129,7 @@ cpu@4 {
 			mmu-type = "riscv,sv39";
 			reg = <4>;
 			riscv,isa = "rv64imafdc";
+			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
 			status = "okay";
 			cpu4_intc: interrupt-controller {
@@ -210,7 +211,7 @@ serial0: serial@20000000 {
 			interrupt-parent = <&plic>;
 			interrupts = <90>;
 			current-speed = <115200>;
-			clocks = <&clkcfg 8>;
+			clocks = <&clkcfg CLK_MMUART0>;
 			status = "disabled";
 		};
 
@@ -222,7 +223,7 @@ serial1: serial@20100000 {
 			interrupt-parent = <&plic>;
 			interrupts = <91>;
 			current-speed = <115200>;
-			clocks = <&clkcfg 9>;
+			clocks = <&clkcfg CLK_MMUART1>;
 			status = "disabled";
 		};
 
@@ -234,7 +235,7 @@ serial2: serial@20102000 {
 			interrupt-parent = <&plic>;
 			interrupts = <92>;
 			current-speed = <115200>;
-			clocks = <&clkcfg 10>;
+			clocks = <&clkcfg CLK_MMUART2>;
 			status = "disabled";
 		};
 
@@ -246,7 +247,7 @@ serial3: serial@20104000 {
 			interrupt-parent = <&plic>;
 			interrupts = <93>;
 			current-speed = <115200>;
-			clocks = <&clkcfg 11>;
+			clocks = <&clkcfg CLK_MMUART3>;
 			status = "disabled";
 		};
 
@@ -256,7 +257,7 @@ mmc: mmc@20008000 {
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>, <89>;
-			clocks = <&clkcfg 6>;
+			clocks = <&clkcfg CLK_MMC>;
 			max-frequency = <200000000>;
 			status = "disabled";
 		};
@@ -267,7 +268,7 @@ emac0: ethernet@20110000 {
 			interrupt-parent = <&plic>;
 			interrupts = <64>, <65>, <66>, <67>;
 			local-mac-address = [00 00 00 00 00 00];
-			clocks = <&clkcfg 4>, <&clkcfg 2>;
+			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
 			#address-cells = <1>;
@@ -280,7 +281,7 @@ emac1: ethernet@20112000 {
 			interrupt-parent = <&plic>;
 			interrupts = <70>, <71>, <72>, <73>;
 			local-mac-address = [00 00 00 00 00 00];
-			clocks = <&clkcfg 5>, <&clkcfg 2>;
+			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
 			status = "disabled";
 			clock-names = "pclk", "hclk";
 			#address-cells = <1>;
-- 
2.35.1

