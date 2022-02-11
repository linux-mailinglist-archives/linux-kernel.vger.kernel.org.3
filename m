Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE12A4B2CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352536AbiBKSQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:16:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbiBKSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:16:45 -0500
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFFFD50
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1644603401; bh=76mruFJ49IAr5T04xlb/bYwFlY2+homydb38Elm0URU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=T2ZKsYChS91UXye9hoq64FHSt0Y3gDIlAya8kK5f/5d+qVF1Y2zWSZTy0uCXxGouv
         x0owX7Sg7aIBYRGbWLrO8xUrocfX4A6kCROPC4l9LRxbjqLejIoZfk84sSrqslv81U
         p8HMt8m+lc3oQBVOiWKedS0Nr0mtLVewdLpyFGH9yrO4IUhP38COe66nCxGpyMIHdI
         XYBjbEQ9w0ismBQM/PlWLKr4lvt9EJQjrY/oPuOmfNXDS6X5qFvgu86qkmYii8Hy+0
         uBR5tm7czjHi9WyPnp1+lTsPIqvJdNZcT8jptgVKie9okVUIiprD+U9EbIJm8ZVR4p
         A3q/j0C96t7Ow==
Received: from localhost (lfbn-lyo-1-306-208.w2-7.abo.wanadoo.fr [2.7.142.208])
        by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 22257A03FD;
        Fri, 11 Feb 2022 18:16:39 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 2/7] ARM: dts: sti: ensure unique unit-address in stih410-clock
Date:   Fri, 11 Feb 2022 19:16:09 +0100
Message-Id: <20220211181614.683497-3-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211181614.683497-1-avolmat@me.com>
References: <20220211181614.683497-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-11_05:2022-02-11,2022-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=710 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2202110099
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

