Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6484465EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355888AbhLBHyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:54:45 -0500
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:43747 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355867AbhLBHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431479; bh=mgjRMc/t3hJSZuo+CfZ8yOM9oXgwhCun+n3Gpc9EK2w=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=qsbdvJhneZrR95NoZQAUwRKnjz8H/MHGo1tYysYbXj64rsvKys1i4xBFjlmmBBXKw
         CUni+vmQLFWJSFhp0gb9DPT13n1AP9qdAb4pIeVhJ4TwZSWufDY42+cr7E/l4e68sj
         2Osiqa6DKzmQc+xDfq+oxlC/duq2ql8cHa8ItEZKFqcSWTyt7Fjxhb+5LG9HZ7La3N
         bmqdFb1bD0Up0jF0Is6vyi3NujaDgR3vHl7awjaC7UoJXccNuSJ6RC0OSrt9nZwZVC
         +/c0B98sfckW43sGWiA3fiDFHskvGwR5CZLdZabO49pzrsrkdUbfwGcyQn756M57lv
         cqZnis622217Q==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id B37EB8C0F77;
        Thu,  2 Dec 2021 07:51:18 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 01/12] ARM: dts: sti: ensure unique unit-address in stih407-clock
Date:   Thu,  2 Dec 2021 08:50:54 +0100
Message-Id: <20211202075105.195664-2-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move quadfs and a9-mux clocks nodes into clockgen nodes so
that they can get the reg property from the parent node and
ensure only one node has the address.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 101 ++++++++++++---------------
 1 file changed, 46 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 9cce9541e26b..350bcfcf498b 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -29,7 +29,7 @@ clocks {
 		 */
 		clockgen-a9@92b0000 {
 			compatible = "st,clkgen-c32";
-			reg = <0x92b0000 0xffff>;
+			reg = <0x92b0000 0x10000>;
 
 			clockgen_a9_pll: clockgen-a9-pll {
 				#clock-cells = <1>;
@@ -37,32 +37,27 @@ clockgen_a9_pll: clockgen-a9-pll {
 
 				clocks = <&clk_sysin>;
 			};
-		};
 
-		/*
-		 * ARM CPU related clocks.
-		 */
-		clk_m_a9: clk-m-a9@92b0000 {
-			#clock-cells = <0>;
-			compatible = "st,stih407-clkgen-a9-mux";
-			reg = <0x92b0000 0x10000>;
-
-			clocks = <&clockgen_a9_pll 0>,
-				 <&clockgen_a9_pll 0>,
-				 <&clk_s_c0_flexgen 13>,
-				 <&clk_m_a9_ext2f_div2>;
+			clk_m_a9: clk-m-a9 {
+				#clock-cells = <0>;
+				compatible = "st,stih407-clkgen-a9-mux";
 
+				clocks = <&clockgen_a9_pll 0>,
+					 <&clockgen_a9_pll 0>,
+					 <&clk_s_c0_flexgen 13>,
+					 <&clk_m_a9_ext2f_div2>;
 
-			/*
-			 * ARM Peripheral clock for timers
-			 */
-			arm_periph_clk: clk-m-a9-periphs {
-				#clock-cells = <0>;
-				compatible = "fixed-factor-clock";
+				/*
+				 * ARM Peripheral clock for timers
+				 */
+				arm_periph_clk: clk-m-a9-periphs {
+					#clock-cells = <0>;
+					compatible = "fixed-factor-clock";
 
-				clocks = <&clk_m_a9>;
-				clock-div = <2>;
-				clock-mult = <1>;
+					clocks = <&clk_m_a9>;
+					clock-div = <2>;
+					clock-mult = <1>;
+				};
 			};
 		};
 
@@ -87,14 +82,6 @@ clk_s_a0_flexgen: clk-s-a0-flexgen {
 			};
 		};
 
-		clk_s_c0_quadfs: clk-s-c0-quadfs@9103000 {
-			#clock-cells = <1>;
-			compatible = "st,quadfs-pll";
-			reg = <0x9103000 0x1000>;
-
-			clocks = <&clk_sysin>;
-		};
-
 		clk_s_c0: clockgen-c@9103000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9103000 0x1000>;
@@ -113,6 +100,13 @@ clk_s_c0_pll1: clk-s-c0-pll1 {
 				clocks = <&clk_sysin>;
 			};
 
+			clk_s_c0_quadfs: clk-s-c0-quadfs {
+				#clock-cells = <1>;
+				compatible = "st,quadfs-pll";
+
+				clocks = <&clk_sysin>;
+			};
+
 			clk_s_c0_flexgen: clk-s-c0-flexgen {
 				#clock-cells = <1>;
 				compatible = "st,flexgen", "st,flexgen-stih407-c0";
@@ -142,18 +136,17 @@ clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
 			};
 		};
 
-		clk_s_d0_quadfs: clk-s-d0-quadfs@9104000 {
-			#clock-cells = <1>;
-			compatible = "st,quadfs-d0";
-			reg = <0x9104000 0x1000>;
-
-			clocks = <&clk_sysin>;
-		};
-
 		clockgen-d0@9104000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9104000 0x1000>;
 
+			clk_s_d0_quadfs: clk-s-d0-quadfs {
+				#clock-cells = <1>;
+				compatible = "st,quadfs-d0";
+
+				clocks = <&clk_sysin>;
+			};
+
 			clk_s_d0_flexgen: clk-s-d0-flexgen {
 				#clock-cells = <1>;
 				compatible = "st,flexgen", "st,flexgen-stih407-d0";
@@ -166,18 +159,17 @@ clk_s_d0_flexgen: clk-s-d0-flexgen {
 			};
 		};
 
-		clk_s_d2_quadfs: clk-s-d2-quadfs@9106000 {
-			#clock-cells = <1>;
-			compatible = "st,quadfs-d2";
-			reg = <0x9106000 0x1000>;
-
-			clocks = <&clk_sysin>;
-		};
-
 		clockgen-d2@9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
 
+			clk_s_d2_quadfs: clk-s-d2-quadfs {
+				#clock-cells = <1>;
+				compatible = "st,quadfs-d2";
+
+				clocks = <&clk_sysin>;
+			};
+
 			clk_s_d2_flexgen: clk-s-d2-flexgen {
 				#clock-cells = <1>;
 				compatible = "st,flexgen", "st,flexgen-stih407-d2";
@@ -192,18 +184,17 @@ clk_s_d2_flexgen: clk-s-d2-flexgen {
 			};
 		};
 
-		clk_s_d3_quadfs: clk-s-d3-quadfs@9107000 {
-			#clock-cells = <1>;
-			compatible = "st,quadfs-d3";
-			reg = <0x9107000 0x1000>;
-
-			clocks = <&clk_sysin>;
-		};
-
 		clockgen-d3@9107000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9107000 0x1000>;
 
+			clk_s_d3_quadfs: clk-s-d3-quadfs {
+				#clock-cells = <1>;
+				compatible = "st,quadfs-d3";
+
+				clocks = <&clk_sysin>;
+			};
+
 			clk_s_d3_flexgen: clk-s-d3-flexgen {
 				#clock-cells = <1>;
 				compatible = "st,flexgen", "st,flexgen-stih407-d3";
-- 
2.25.1

