Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A165354BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbiEZUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348974AbiEZUly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:41:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D96F11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:41:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so5052092ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NirdJU9gakSOEf0/biWAegVUfbDc1cYXBP4JPaZuak=;
        b=rcZAkYncob/5o2iccAW6Ie+EhfiJLFddbUpXelbFYasIYfL/13n7FFQucfot5f4NUx
         lwHJPO+PDCym0CRchKugBmlevFK5MhcJQHr4/iUTNhUZKNvi3Y7QMzwQmtfPOsigUlID
         MtMswciYLDpPkYCAicibbBhRp9agDMg219MglGoSw4z4otF29tb2ZfhwD0PpjF2S5W0A
         pyRFGYAYPSsR2qjzVUNDTSTe0oc0yvGgBSXrEZOS1rTN/7wgdfgxzJYB8ERG0vIKSc5p
         dPicQJ0ueyRpkXEZ4M7jpd75l1LsFc3/K+/UFDuXF/w6A5GyxhT2UkUyrGaALowKRcfK
         e7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NirdJU9gakSOEf0/biWAegVUfbDc1cYXBP4JPaZuak=;
        b=v7Ro3i89dNG9pON1ZEAMtEBwsm61BEwv2AzFAc1W1Y+UGsraX7xuQniuigCig/Gihi
         Kuke0Sm4ZM1+3pVuDQpMSGkT4QzpYEHvBfGCOx38s3lE8tL+cDdmPrizP0C8+SHO2Cqk
         jSmdk5kynjLiWakTDgZLbYh/oVYZjmTLr6Mn7PsXw59PMDvssohKd5X3jhP9dSPy9CLh
         U3MlQ9F1SxfAINciM5HbjTqdYlMsY+bgWFQ4235Wd+rf96j4hQwrkNpbGYlKah6B8MyV
         4rpSqbEldY+JXgYgiRhcosYlLLNQa2eqQQemazhDP+lF22kqyTrwWAgyMTdcazMdBxSO
         3bLQ==
X-Gm-Message-State: AOAM533It3XUC829q1H7SNUlkd+49PJB9TJfPMJhtGC7k1ZW3WHw+Hj5
        G7kueyOBqsN7QmbvFzM2UmsbXQ==
X-Google-Smtp-Source: ABdhPJy19dvLmcUOoavXT/DJazec82BcV8AoeCrbn9cgQZm/7ZZ//5ow4A1OMUqbO+/ZLHQTY88p1Q==
X-Received: by 2002:a17:907:a407:b0:6fe:fb39:47ec with SMTP id sg7-20020a170907a40700b006fefb3947ecmr16111634ejc.215.1653597707997;
        Thu, 26 May 2022 13:41:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906a40b00b006f3ef214ddbsm829547ejz.65.2022.05.26.13.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:41:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ARM: dts: keystone: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:41:38 +0200
Message-Id: <20220526204139.831895-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
References: <20220526204139.831895-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  | 26 +++++++++++-----------
 arch/arm/boot/dts/keystone-k2e.dtsi        |  6 ++---
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi  |  2 +-
 arch/arm/boot/dts/keystone-k2g.dtsi        | 18 +++++++--------
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi | 12 +++++-----
 arch/arm/boot/dts/keystone-k2hk.dtsi       |  4 ++--
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  | 18 +++++++--------
 arch/arm/boot/dts/keystone-k2l.dtsi        |  8 +++----
 arch/arm/boot/dts/keystone.dtsi            | 18 +++++++--------
 9 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
index 71064483d34f..42cf74db673c 100644
--- a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
@@ -12,9 +12,9 @@ qmss: qmss@2a40000 {
 	#size-cells = <1>;
 	clocks = <&chipclk13>;
 	ranges;
-	queue-range	= <0 0x2000>;
-	linkram0	= <0x100000 0x4000>;
-	linkram1	= <0 0x10000>;
+	queue-range = <0 0x2000>;
+	linkram0 = <0x100000 0x4000>;
+	linkram1 = <0 0x10000>;
 
 	qmgrs {
 		#address-cells = <1>;
@@ -176,40 +176,40 @@ cpts_refclk_mux: cpts-refclk-mux {
 			interfaces {
 				gbe0: interface-0 {
 					slave-port = <0>;
-					link-interface	= <1>;
-					phy-handle	= <&ethphy0>;
+					link-interface = <1>;
+					phy-handle = <&ethphy0>;
 				};
 				gbe1: interface-1 {
 					slave-port = <1>;
-					link-interface	= <1>;
-					phy-handle	= <&ethphy1>;
+					link-interface = <1>;
+					phy-handle = <&ethphy1>;
 				};
 			};
 
 			secondary-slave-ports {
 				port-2 {
 					slave-port = <2>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 				port-3 {
 					slave-port = <3>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 				port-4 {
 					slave-port = <4>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 				port-5 {
 					slave-port = <5>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 				port-6 {
 					slave-port = <6>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 				port-7 {
 					slave-port = <7>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index b8f152e7af7f..65c32946c522 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -141,7 +141,7 @@ pcie1: pcie@21020000 {
 			clock-names = "pcie";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			reg =  <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
+			reg = <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
 			ranges = <0x82000000 0 0x60000000 0x60000000
 				  0 0x10000000>;
 
@@ -185,14 +185,14 @@ pcie_intc1: legacy-interrupt-controller {
 		};
 
 		mdio: mdio@24200f00 {
-			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
+			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x24200f00 0x100>;
 			status = "disabled";
 			clocks = <&clkcpgmac>;
 			clock-names = "fck";
-			bus_freq	= <2500000>;
+			bus_freq = <2500000>;
 		};
 		/include/ "keystone-k2e-netcp.dtsi"
 };
diff --git a/arch/arm/boot/dts/keystone-k2g-netcp.dtsi b/arch/arm/boot/dts/keystone-k2g-netcp.dtsi
index d0e6a9a43402..f6306933ff42 100644
--- a/arch/arm/boot/dts/keystone-k2g-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g-netcp.dtsi
@@ -125,7 +125,7 @@ gbe: gbe@200000 {
 			interfaces {
 				gbe0: interface-0 {
 					slave-port = <0>;
-					link-interface	= <5>;
+					link-interface = <5>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 37198294f4b2..380dd9d637ee 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -262,7 +262,7 @@ pmmc: system-controller@2921c00 {
 			 */
 			ti,system-reboot-controller;
 			mbox-names = "rx", "tx";
-			mboxes= <&msgmgr 5 2>,
+			mboxes = <&msgmgr 5 2>,
 				<&msgmgr 0 0>;
 			reg-names = "debug_messages";
 			reg = <0x02921c00 0x400>;
@@ -326,13 +326,13 @@ gpio1: gpio@260a000 {
 
 		dss: dss@02540000 {
 			compatible = "ti,k2g-dss";
-			reg =	<0x02540000 0x400>,
+			reg = <0x02540000 0x400>,
 				<0x02550000 0x1000>,
 				<0x02557000 0x1000>,
 				<0x0255a800 0x100>,
 				<0x0255ac00 0x100>;
 			reg-names = "cfg", "common", "vid1", "ovr1", "vp1";
-			clocks =	<&k2g_clks 0x2 0>,
+			clocks = <&k2g_clks 0x2 0>,
 					<&k2g_clks 0x2 1>;
 			clock-names = "fck", "vp1";
 			interrupts = <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>;
@@ -348,7 +348,7 @@ dss: dss@02540000 {
 
 		edma0: edma@2700000 {
 			compatible = "ti,k2g-edma3-tpcc", "ti,edma3-tpcc";
-			reg =	<0x02700000 0x8000>;
+			reg = <0x02700000 0x8000>;
 			reg-names = "edma3_cc";
 			interrupts = <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>,
 					<GIC_SPI 216 IRQ_TYPE_EDGE_RISING>,
@@ -367,19 +367,19 @@ edma0: edma@2700000 {
 
 		edma0_tptc0: tptc@2760000 {
 			compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
-			reg =	<0x02760000 0x400>;
+			reg = <0x02760000 0x400>;
 			power-domains = <&k2g_pds 0x3f>;
 		};
 
 		edma0_tptc1: tptc@2768000 {
 			compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
-			reg =	<0x02768000 0x400>;
+			reg = <0x02768000 0x400>;
 			power-domains = <&k2g_pds 0x3f>;
 		};
 
 		edma1: edma@2728000 {
 			compatible = "ti,k2g-edma3-tpcc", "ti,edma3-tpcc";
-			reg =	<0x02728000 0x8000>;
+			reg = <0x02728000 0x8000>;
 			reg-names = "edma3_cc";
 			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
 					<GIC_SPI 219 IRQ_TYPE_EDGE_RISING>,
@@ -402,13 +402,13 @@ edma1: edma@2728000 {
 
 		edma1_tptc0: tptc@27b0000 {
 			compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
-			reg =	<0x027b0000 0x400>;
+			reg = <0x027b0000 0x400>;
 			power-domains = <&k2g_pds 0x4f>;
 		};
 
 		edma1_tptc1: tptc@27b8000 {
 			compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
-			reg =	<0x027b8000 0x400>;
+			reg = <0x027b8000 0x400>;
 			power-domains = <&k2g_pds 0x4f>;
 		};
 
diff --git a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
index 022d93c366c7..8a421c65f920 100644
--- a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
@@ -12,9 +12,9 @@ qmss: qmss@2a40000 {
 	#size-cells = <1>;
 	clocks = <&chipclk13>;
 	ranges;
-	queue-range	= <0 0x4000>;
-	linkram0	= <0x100000 0x8000>;
-	linkram1	= <0x0 0x10000>;
+	queue-range = <0 0x4000>;
+	linkram0 = <0x100000 0x8000>;
+	linkram1 = <0x0 0x10000>;
 
 	qmgrs {
 		#address-cells = <1>;
@@ -150,7 +150,7 @@ netcp: netcp@2000000 {
 	#size-cells = <1>;
 
 	/* NetCP address range */
-	ranges  = <0 0x2000000 0x100000>;
+	ranges = <0 0x2000000 0x100000>;
 
 	clocks = <&clkpa>, <&clkcpgmac>;
 	clock-names = "pa_clk", "ethss_clk";
@@ -207,11 +207,11 @@ gbe1: interface-1 {
 			secondary-slave-ports {
 				port-2 {
 					slave-port = <2>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 				port-3 {
 					slave-port = <3>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
index 8a9447703310..da6d3934c2e8 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -282,14 +282,14 @@ dsp7: dsp@17800000 {
 		};
 
 		mdio: mdio@2090300 {
-			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
+			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x02090300 0x100>;
 			status = "disabled";
 			clocks = <&clkcpgmac>;
 			clock-names = "fck";
-			bus_freq	= <2500000>;
+			bus_freq = <2500000>;
 		};
 		/include/ "keystone-k2hk-netcp.dtsi"
 };
diff --git a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
index e96ca664abc2..5ec6680a533d 100644
--- a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
@@ -12,9 +12,9 @@ qmss: qmss@2a40000 {
 	#size-cells = <1>;
 	clocks = <&chipclk13>;
 	ranges;
-	queue-range	= <0 0x2000>;
-	linkram0	= <0x100000 0x4000>;
-	linkram1	= <0x70000000 0x10000>; /* 1MB OSR mem */
+	queue-range = <0 0x2000>;
+	linkram0 = <0x100000 0x4000>;
+	linkram1 = <0x70000000 0x10000>; /* 1MB OSR mem */
 
 	qmgrs {
 		#address-cells = <1>;
@@ -174,24 +174,24 @@ cpts_refclk_mux: cpts-refclk-mux {
 			interfaces {
 				gbe0: interface-0 {
 					slave-port = <0>;
-					link-interface	= <1>;
-					phy-handle	= <&ethphy0>;
+					link-interface = <1>;
+					phy-handle = <&ethphy0>;
 				};
 				gbe1: interface-1 {
 					slave-port = <1>;
-					link-interface	= <1>;
-					phy-handle	= <&ethphy1>;
+					link-interface = <1>;
+					phy-handle = <&ethphy1>;
 				};
 			};
 
 			secondary-slave-ports {
 				port-2 {
 					slave-port = <2>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 				port-3 {
 					slave-port = <3>;
-					link-interface	= <2>;
+					link-interface = <2>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index dff5fea72b2f..421a02bbc9d3 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -47,7 +47,7 @@ uart2: serial@2348400 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			reg = <0x02348400 0x100>;
-			clocks	= <&clkuart2>;
+			clocks = <&clkuart2>;
 			interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>;
 		};
 
@@ -57,7 +57,7 @@ uart3:	serial@2348800 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			reg = <0x02348800 0x100>;
-			clocks	= <&clkuart3>;
+			clocks = <&clkuart3>;
 			interrupts = <GIC_SPI 435 IRQ_TYPE_EDGE_RISING>;
 		};
 
@@ -388,14 +388,14 @@ dsp3: dsp@13800000 {
 		};
 
 		mdio: mdio@26200f00 {
-			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
+			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x26200f00 0x100>;
 			status = "disabled";
 			clocks = <&clkcpgmac>;
 			clock-names = "fck";
-			bus_freq	= <2500000>;
+			bus_freq = <2500000>;
 		};
 		/include/ "keystone-k2l-netcp.dtsi"
 };
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index fc9fdc857ae8..50789f9e2215 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -14,7 +14,7 @@ / {
 	interrupt-parent = <&gic>;
 
 	aliases {
-		serial0	= &uart0;
+		serial0 = &uart0;
 		spi0 = &spi0;
 		spi1 = &spi1;
 		spi2 = &spi2;
@@ -61,11 +61,11 @@ pmu {
 	};
 
 	psci {
-		compatible	= "arm,psci";
-		method		= "smc";
-		cpu_suspend	= <0x84000001>;
-		cpu_off		= <0x84000002>;
-		cpu_on		= <0x84000003>;
+		compatible = "arm,psci";
+		method = "smc";
+		cpu_suspend = <0x84000001>;
+		cpu_off = <0x84000002>;
+		cpu_on = <0x84000003>;
 	};
 
 	soc0: soc@0 {
@@ -119,7 +119,7 @@ uart0: serial@2530c00 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			reg = <0x02530c00 0x100>;
-			clocks	= <&clkuart0>;
+			clocks = <&clkuart0>;
 			interrupts = <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>;
 		};
 
@@ -129,7 +129,7 @@ uart1:	serial@2531000 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			reg = <0x02531000 0x100>;
-			clocks	= <&clkuart1>;
+			clocks = <&clkuart1>;
 			interrupts = <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>;
 		};
 
@@ -301,7 +301,7 @@ pcie0: pcie@21800000 {
 			clock-names = "pcie";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			reg =  <0x21801000 0x2000>, <0x21800000 0x1000>, <0x02620128 4>;
+			reg = <0x21801000 0x2000>, <0x21800000 0x1000>, <0x02620128 4>;
 			ranges = <0x82000000 0 0x50000000 0x50000000
 				  0 0x10000000>;
 
-- 
2.34.1

