Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7E465EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355908AbhLBHzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:55:07 -0500
Received: from st43p00im-ztfb10071701.me.com ([17.58.63.173]:34540 "EHLO
        st43p00im-ztfb10071701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355883AbhLBHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431482; bh=76mruFJ49IAr5T04xlb/bYwFlY2+homydb38Elm0URU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=FA1klEOZLFDhN7QQXiN1WvBXWzFFQ3CqidTdBHUrfuVMBuDm4dt+vrvTH9mMXSDFA
         3ETe5uZVzS3jh6MJ3qCSq2MTJWRgxA+GgpsrJuDm3x+wSoak2SoEe93lXILoXCHPjO
         4F/8YyB7o7FWlfcoHMI6WCIYXeql78wP4GaKS4262nZFeJ+1rjgnD366oLfxJrImkP
         xdNsDd3VFbgdou0Mtqv5QJBwj2AGWsK8By2NUWnKYMdEttFDGQ7rAdsmeZ+JTQar/U
         JeMJhbRiRlBNZaAcIqtS9Momd0XuVGWAoGNM99mF35wzk+c2V5IjpNNabPzowrDS0w
         5le0meQ+IbW5g==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id DC5808A080A;
        Thu,  2 Dec 2021 07:51:21 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 02/12] ARM: dts: sti: ensure unique unit-address in stih410-clock
Date:   Thu,  2 Dec 2021 08:50:55 +0100
Message-Id: <20211202075105.195664-3-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-01_01:2021-11-30,2021-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=835 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112020046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move quadfs and a9-mux clocks nodes into clockgen nodes so
that they can get the reg property from the parent node and
ensure only one node has the address.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih410-clock.dtsi | 100 +++++++++++++--------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 6b0e6d4477a3..abac98a1810b 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -32,7 +32,7 @@ clocks {
 		 */
 		clockgen-a9@92b0000 {
 			compatible = "st,clkgen-c32";
-			reg = <0x92b0000 0xffff>;
+			reg = <0x92b0000 0x10000>;
 
 			clockgen_a9_pll: clockgen-a9-pll {
 				#clock-cells = <1>;
@@ -40,29 +40,29 @@ clockgen_a9_pll: clockgen-a9-pll {
 
 				clocks = <&clk_sysin>;
 			};
-		};
 
-		/*
-		 * ARM CPU related clocks.
-		 */
-		clk_m_a9: clk-m-a9@92b0000 {
-			#clock-cells = <0>;
-			compatible = "st,stih407-clkgen-a9-mux", "st,clkgen-mux";
-			reg = <0x92b0000 0x10000>;
-
-			clocks = <&clockgen_a9_pll 0>,
-				 <&clockgen_a9_pll 0>,
-				 <&clk_s_c0_flexgen 13>,
-				 <&clk_m_a9_ext2f_div2>;
 			/*
-			 * ARM Peripheral clock for timers
+			 * ARM CPU related clocks.
 			 */
-			arm_periph_clk: clk-m-a9-periphs {
+			clk_m_a9: clk-m-a9 {
 				#clock-cells = <0>;
-				compatible = "fixed-factor-clock";
-				clocks = <&clk_m_a9>;
-				clock-div = <2>;
-				clock-mult = <1>;
+				compatible = "st,stih407-clkgen-a9-mux", "st,clkgen-mux";
+
+				clocks = <&clockgen_a9_pll 0>,
+					 <&clockgen_a9_pll 0>,
+					 <&clk_s_c0_flexgen 13>,
+					 <&clk_m_a9_ext2f_div2>;
+
+				/*
+				 * ARM Peripheral clock for timers
+				 */
+				arm_periph_clk: clk-m-a9-periphs {
+					#clock-cells = <0>;
+					compatible = "fixed-factor-clock";
+					clocks = <&clk_m_a9>;
+					clock-div = <2>;
+					clock-mult = <1>;
+				};
 			};
 		};
 
@@ -87,14 +87,6 @@ clk_s_a0_flexgen: clk-s-a0-flexgen {
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
@@ -113,6 +105,13 @@ clk_s_c0_pll1: clk-s-c0-pll1 {
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
 				compatible = "st,flexgen", "st,flexgen-stih410-c0";
@@ -142,18 +141,17 @@ clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
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
 				compatible = "st,flexgen", "st,flexgen-stih410-d0";
@@ -166,18 +164,17 @@ clk_s_d0_flexgen: clk-s-d0-flexgen {
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
@@ -192,18 +189,17 @@ clk_s_d2_flexgen: clk-s-d2-flexgen {
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

