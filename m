Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A859988C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347714AbiHSJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346826AbiHSJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:09:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144DF0760;
        Fri, 19 Aug 2022 02:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C43DB81F65;
        Fri, 19 Aug 2022 09:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B41C433D7;
        Fri, 19 Aug 2022 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660900182;
        bh=LUSLArIjZVGEJGr7HaA5jN1R84iWYbA8vizX1CTJoig=;
        h=From:To:Cc:Subject:Date:From;
        b=k1UnI1aLycCotRcOx7jv7hGQ7B5fbng4Q1s1U+bCrsS+OZm3PdB1BNdvZv39oZLCR
         GOmHexaykxMMB02WS/k7bgvm4oq4q5NqvtjP0cs2ODefolgPu2CDPWFaStNffRIpju
         BRy0QvhIqT8uBKoudU1X9fd7GIDovGTxk33QyV9MddpWTQv4Nqt3IJcif3fhC9XQus
         1J0LD9B0yielWpYa3p/6P+UK6crtd1Bc9jzOiCh9tvYeVxnrMlVn/p6VDOjKC+Dcjt
         HVy53UOLsVqqH90n423d5l91Ku8ccslrkFTyrboskcyjVWWni1Ta3BllbA4gQPv+me
         3z6mpr10Y0yWg==
Received: by pali.im (Postfix)
        id CEB25761; Fri, 19 Aug 2022 11:09:38 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/85xx: DTS: Add CPLD definitions for P1021RDB Combo Board CPL Design
Date:   Fri, 19 Aug 2022 10:44:33 +0200
Message-Id: <20220819084433.26011-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P1021RDB Combo Board CPLD Design is used on following Freescale boards:
P1021RDB-PC, P1020RDB-PD, P1020MBG-PC, P1020UTM-PC and P2020RDB-PCA.

Add CPLD definitions for all these boards for which already exist DTS file.

CPLD has bank size 128kB, it is connected via CS3 on LBC and mapped to
memory range 0xFFA00000~0xFFA1FFFF.

As CPLD firmware is common on all these boards, use just one compatible
string "fsl,p1021rdb-pc-cpld".

In some DTS files is CPLD already defined, but definition is either
incomplete or wrong. So fix it.

All these boards have via CPLD connected max6370 watchdog at offset 0x2
with GPIO 11, status led at offset 0x8 and reset controller at offset 0xd.
Additionally P1020MBG-PC and P1020RDB-PD boards have FXO led at offset 0x9
and FXS leds at offset 0xa.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi    | 92 +++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts |  6 +-
 arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts |  6 +-
 arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts     | 44 +++++++--
 arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi    | 37 ++++++++
 arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts |  4 +-
 arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts |  4 +-
 arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi    | 37 ++++++++
 arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts |  5 +-
 arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts |  5 +-
 arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi    | 33 ++++++-
 11 files changed, 251 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
index a24699cfea9c..c73996dcd809 100644
--- a/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
@@ -83,6 +83,95 @@
 		compatible = "vitesse-7385";
 		reg = <0x2 0x0 0x20000>;
 	};
+
+	cpld@3,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,p1021rdb-pc-cpld", "simple-bus", "syscon";
+		reg = <0x3 0x0 0x20000>;
+		ranges = <0x0 0x3 0x0 0x20000>;
+
+		watchdog@2 {
+			compatible = "maxim,max6370";
+			reg = <0x2 0x1>;
+			gpios = <&gpio 11 1>;
+		};
+
+		led@8 {
+			compatible = "register-bit-led";
+			reg = <0x8 0x1>;
+			offset = <0x8>;
+			mask = <0x1>;
+			active-low;
+			default-state = "keep";
+			label = "status";
+			function = "status";
+			color = <6>; /* LED_COLOR_ID_YELLOW */
+		};
+
+		led@9 {
+			compatible = "register-bit-led";
+			reg = <0x9 0x1>;
+			offset = <0x9>;
+			mask = <0x1>;
+			active-low;
+			default-state = "keep";
+			label = "fxo";
+			color = <2>; /* LED_COLOR_ID_GREEN */
+		};
+
+		led@a,0 {
+			compatible = "register-bit-led";
+			reg = <0xa 0x1>;
+			offset = <0xa>;
+			mask = <0x1>;
+			active-low;
+			default-state = "keep";
+			label = "fxs0";
+			color = <2>; /* LED_COLOR_ID_GREEN */
+		};
+
+		led@a,1 {
+			compatible = "register-bit-led";
+			reg = <0xa 0x1>;
+			offset = <0xa>;
+			mask = <0x2>;
+			active-low;
+			default-state = "keep";
+			label = "fxs1";
+			color = <2>; /* LED_COLOR_ID_GREEN */
+		};
+
+		led@a,2 {
+			compatible = "register-bit-led";
+			reg = <0xa 0x1>;
+			offset = <0xa>;
+			mask = <0x4>;
+			active-low;
+			default-state = "keep";
+			label = "fxs2";
+			color = <2>; /* LED_COLOR_ID_GREEN */
+		};
+
+		led@a,3 {
+			compatible = "register-bit-led";
+			reg = <0xa 0x1>;
+			offset = <0xa>;
+			mask = <0x8>;
+			active-low;
+			default-state = "keep";
+			label = "fxs3";
+			color = <2>; /* LED_COLOR_ID_GREEN */
+		};
+
+		reboot@d {
+			compatible = "syscon-reboot";
+			reg = <0xd 0x1>;
+			offset = <0xd>;
+			mask = <0x1>;
+			value = <0x1>;
+		};
+	};
 };
 
 &soc {
@@ -93,6 +182,9 @@
 		};
 	};
 
+	gpio: gpio-controller@fc00 {
+	};
+
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
 			interrupts = <3 1 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts b/arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts
index b29d1fcb5e6b..29847d395f1f 100644
--- a/arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts
@@ -44,10 +44,10 @@
 	lbc: localbus@ffe05000 {
 		reg = <0x0 0xffe05000 0x0 0x1000>;
 
-		/* NOR and L2 switch */
+		/* NOR, L2 switch and CPLD */
 		ranges = <0x0 0x0 0x0 0xec000000 0x04000000
-			  0x1 0x0 0x0 0xffa00000 0x00040000
-			  0x2 0x0 0x0 0xffb00000 0x00020000>;
+			  0x2 0x0 0x0 0xffb00000 0x00020000
+			  0x3 0x0 0x0 0xffa00000 0x00040000>;
 	};
 
 	soc: soc@ffe00000 {
diff --git a/arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts b/arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts
index 678d0eec24e2..b0ce561c38ff 100644
--- a/arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts
@@ -44,10 +44,10 @@
 	lbc: localbus@fffe05000 {
 		reg = <0xf 0xffe05000 0x0 0x1000>;
 
-		/* NOR and L2 switch */
+		/* NOR, L2 switch and CPLD */
 		ranges = <0x0 0x0 0xf 0xec000000 0x04000000
-			  0x1 0x0 0xf 0xffa00000 0x00040000
-			  0x2 0x0 0xf 0xffb00000 0x00020000>;
+			  0x2 0x0 0xf 0xffb00000 0x00020000
+			  0x3 0x0 0xf 0xffa00000 0x00040000>;
 	};
 
 	soc: soc@fffe00000 {
diff --git a/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts b/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
index f2dc6c09be52..1c44a1690065 100644
--- a/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
@@ -47,8 +47,8 @@
 		/* NOR, NAND flash, L2 switch and CPLD */
 		ranges = <0x0 0x0 0x0 0xec000000 0x04000000
 			  0x1 0x0 0x0 0xff800000 0x00040000
-			  0x2 0x0 0x0 0xffa00000 0x00020000
-			  0x3 0x0 0x0 0xffb00000 0x00020000>;
+			  0x2 0x0 0x0 0xffb00000 0x00020000
+			  0x3 0x0 0x0 0xffa00000 0x00020000>;
 
 		nor@0,0 {
 			#address-cells = <1>;
@@ -128,16 +128,45 @@
 			};
 		};
 
-		cpld@2,0 {
-			compatible = "fsl,p1020rdb-pd-cpld";
+		L2switch@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "vitesse-7385";
 			reg = <0x2 0x0 0x20000>;
 		};
 
-		L2switch@3,0 {
+		cpld@3,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "vitesse-7385";
+			compatible = "fsl,p1021rdb-pc-cpld", "simple-bus", "syscon";
 			reg = <0x3 0x0 0x20000>;
+			ranges = <0x0 0x3 0x0 0x20000>;
+
+			watchdog@2 {
+				compatible = "maxim,max6370";
+				reg = <0x2 0x1>;
+				gpios = <&gpio 11 1>;
+			};
+
+			led@8 {
+				compatible = "register-bit-led";
+				reg = <0x8 0x1>;
+				offset = <0x8>;
+				mask = <0x1>;
+				active-low;
+				default-state = "keep";
+				label = "status";
+				function = "status";
+				color = <6>; /* LED_COLOR_ID_YELLOW */
+			};
+
+			reboot@d {
+				compatible = "syscon-reboot";
+				reg = <0xd 0x1>;
+				offset = <0xd>;
+				mask = <0x1>;
+				value = <0x1>;
+			};
 		};
 	};
 
@@ -199,6 +228,9 @@
 			};
 		};
 
+		gpio: gpio-controller@fc00 {
+		};
+
 		mdio@24000 {
 			phy0: ethernet-phy@0 {
 				interrupts = <3 1 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi
index 7ea85eabcc5c..070296d96aac 100644
--- a/arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi
@@ -68,6 +68,40 @@
 			read-only;
 		};
 	};
+
+	cpld@3,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,p1021rdb-pc-cpld", "simple-bus", "syscon";
+		reg = <0x3 0x0 0x20000>;
+		ranges = <0x0 0x3 0x0 0x20000>;
+
+		watchdog@2 {
+			compatible = "maxim,max6370";
+			reg = <0x2 0x1>;
+			gpios = <&gpio 11 1>;
+		};
+
+		led@8 {
+			compatible = "register-bit-led";
+			reg = <0x8 0x1>;
+			offset = <0x8>;
+			mask = <0x1>;
+			active-low;
+			default-state = "keep";
+			label = "status";
+			function = "status";
+			color = <6>; /* LED_COLOR_ID_YELLOW */
+		};
+
+		reboot@d {
+			compatible = "syscon-reboot";
+			reg = <0xd 0x1>;
+			offset = <0xd>;
+			mask = <0x1>;
+			value = <0x1>;
+		};
+	};
 };
 
 &soc {
@@ -78,6 +112,9 @@
 		};
 	};
 
+	gpio: gpio-controller@fc00 {
+	};
+
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
 			interrupts = <3 1 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts b/arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts
index bc03ef611f98..9cc8f6726ca7 100644
--- a/arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts
@@ -46,8 +46,8 @@
 
 		/* NOR */
 		ranges = <0x0 0x0 0x0 0xec000000 0x02000000
-			  0x1 0x0 0x0 0xffa00000 0x00040000
-			  0x2 0x0 0x0 0xffb00000 0x00020000>;
+			  0x2 0x0 0x0 0xffb00000 0x00020000
+			  0x3 0x0 0x0 0xffa00000 0x00040000>;
 	};
 
 	soc: soc@ffe00000 {
diff --git a/arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts b/arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts
index 32766f6a475e..d60fb898399f 100644
--- a/arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts
@@ -46,8 +46,8 @@
 
 		/* NOR */
 		ranges = <0x0 0x0 0xf 0xec000000 0x02000000
-			  0x1 0x0 0xf 0xffa00000 0x00040000
-			  0x2 0x0 0xf 0xffb00000 0x00020000>;
+			  0x2 0x0 0xf 0xffb00000 0x00020000
+			  0x3 0x0 0xf 0xffa00000 0x00040000>;
 	};
 
 	soc: soc@fffe00000 {
diff --git a/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi
index 18f9b31602d0..e2c56ee01039 100644
--- a/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi
@@ -136,6 +136,40 @@
 		compatible = "vitesse-7385";
 		reg = <0x2 0x0 0x20000>;
 	};
+
+	cpld@3,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,p1021rdb-pc-cpld", "simple-bus", "syscon";
+		reg = <0x3 0x0 0x20000>;
+		ranges = <0x0 0x3 0x0 0x20000>;
+
+		watchdog@2 {
+			compatible = "maxim,max6370";
+			reg = <0x2 0x1>;
+			gpios = <&gpio 11 1>;
+		};
+
+		led@8 {
+			compatible = "register-bit-led";
+			reg = <0x8 0x1>;
+			offset = <0x8>;
+			mask = <0x1>;
+			active-low;
+			default-state = "keep";
+			label = "status";
+			function = "status";
+			color = <6>; /* LED_COLOR_ID_YELLOW */
+		};
+
+		reboot@d {
+			compatible = "syscon-reboot";
+			reg = <0xd 0x1>;
+			offset = <0xd>;
+			mask = <0x1>;
+			value = <0x1>;
+		};
+	};
 };
 
 &soc {
@@ -187,6 +221,9 @@
 		};
 	};
 
+	gpio: gpio-controller@fc00 {
+	};
+
 	usb@22000 {
 		phy_type = "ulpi";
 	};
diff --git a/arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts b/arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts
index d2b4710357ac..9721e5ecc86b 100644
--- a/arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts
@@ -44,10 +44,11 @@
 	lbc: localbus@ffe05000 {
 		reg = <0 0xffe05000 0 0x1000>;
 
-		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
+		/* NOR, NAND Flashes, Vitesse 5 port L2 switch and CPLD */
 		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
 			  0x1 0x0 0x0 0xff800000 0x00040000
-			  0x2 0x0 0x0 0xffb00000 0x00020000>;
+			  0x2 0x0 0x0 0xffb00000 0x00020000
+			  0x3 0x0 0x0 0xffa00000 0x00020000>;
 	};
 
 	soc: soc@ffe00000 {
diff --git a/arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts b/arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts
index e298c29e5606..edea14e5d806 100644
--- a/arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts
@@ -44,10 +44,11 @@
 	lbc: localbus@fffe05000 {
 		reg = <0xf 0xffe05000 0 0x1000>;
 
-		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
+		/* NOR, NAND Flashes, Vitesse 5 port L2 switch and CPLD */
 		ranges = <0x0 0x0 0xf 0xef000000 0x01000000
 			  0x1 0x0 0xf 0xff800000 0x00040000
-			  0x2 0x0 0xf 0xffb00000 0x00020000>;
+			  0x2 0x0 0xf 0xffb00000 0x00020000
+			  0x3 0x0 0xf 0xffa00000 0x00020000>;
 	};
 
 	soc: soc@fffe00000 {
diff --git a/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi
index 03c9afc82436..0be63fa76422 100644
--- a/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi
@@ -133,9 +133,35 @@
 	cpld@3,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "cpld";
+		compatible = "fsl,p1021rdb-pc-cpld", "simple-bus", "syscon";
 		reg = <0x3 0x0 0x20000>;
-		read-only;
+		ranges = <0x0 0x3 0x0 0x20000>;
+
+		watchdog@2 {
+			compatible = "maxim,max6370";
+			reg = <0x2 0x1>;
+			gpios = <&gpio 11 1>;
+		};
+
+		led@8 {
+			compatible = "register-bit-led";
+			reg = <0x8 0x1>;
+			offset = <0x8>;
+			mask = <0x1>;
+			active-low;
+			default-state = "keep";
+			label = "status";
+			function = "status";
+			color = <6>; /* LED_COLOR_ID_YELLOW */
+		};
+
+		reboot@d {
+			compatible = "syscon-reboot";
+			reg = <0xd 0x1>;
+			offset = <0xd>;
+			mask = <0x1>;
+			value = <0x1>;
+		};
 	};
 };
 
@@ -188,6 +214,9 @@
 		};
 	};
 
+	gpio: gpio-controller@fc00 {
+	};
+
 	usb@22000 {
 		phy_type = "ulpi";
 	};
-- 
2.20.1

