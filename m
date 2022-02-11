Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B24B2CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352589AbiBKSQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:16:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352541AbiBKSQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:16:49 -0500
Received: from st43p00im-zteg10062001.me.com (st43p00im-zteg10062001.me.com [17.58.63.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E9CEC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1644603407; bh=atvEIvkseRjsmGEEzVE2oDHcH5g5sH01wgK74hwKLOs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NQRvRJT6OrMayIZOWqm3YIyC7dCheiqTJm8Y/HQMN1aXbrM2Ph8eU2ehUo+8ZOVOB
         zgg6mTAU5LvjYuyjQPlP3jgLln0/y0HeH5ZszB2UlKXlhhFJB/maqD/L+yZTGVKh2X
         rqjDf07lYT8WterXe8Rcm1UMrwDNQ/9xFqHdKkrMHlDXpKkEwBXJwIo7HxXnJ8WIDx
         +Hu7CarE4wnwVlPzTECYeLfi1mDOkBSjhNJv2qfBAL+D+pH+re68YCTICT0Anz85Up
         TeTL8mLttUjxmwDuXTvbr9WPKuJ5V9Gf8gJgR+AbIA8tg67Shf0x0I7DCo83rtSNDS
         s0cXxUw5eKJvg==
Received: from localhost (lfbn-lyo-1-306-208.w2-7.abo.wanadoo.fr [2.7.142.208])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 95FA3801129;
        Fri, 11 Feb 2022 18:16:43 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 3/7] ARM: dts: sti: ensure unique unit-address in stih418-clock
Date:   Fri, 11 Feb 2022 19:16:10 +0100
Message-Id: <20220211181614.683497-4-avolmat@me.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/boot/dts/stih418-clock.dtsi | 101 +++++++++++++--------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index e84c476b83ed..e1749e92a2e7 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -32,7 +32,7 @@ clocks {
 		 */
 		clockgen-a9@92b0000 {
 			compatible = "st,clkgen-c32";
-			reg = <0x92b0000 0xffff>;
+			reg = <0x92b0000 0x10000>;
 
 			clockgen_a9_pll: clockgen-a9-pll {
 				#clock-cells = <1>;
@@ -40,30 +40,29 @@ clockgen_a9_pll: clockgen-a9-pll {
 
 				clocks = <&clk_sysin>;
 			};
-		};
-
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
 
@@ -88,14 +87,6 @@ clk_s_a0_flexgen: clk-s-a0-flexgen {
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
@@ -114,6 +105,13 @@ clk_s_c0_pll1: clk-s-c0-pll1 {
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
 				compatible = "st,flexgen", "st,flexgen-stih418-c0";
@@ -143,18 +141,17 @@ clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
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
@@ -167,18 +164,17 @@ clk_s_d0_flexgen: clk-s-d0-flexgen {
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
 				compatible = "st,flexgen", "st,flexgen-stih418-d2";
@@ -193,18 +189,17 @@ clk_s_d2_flexgen: clk-s-d2-flexgen {
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

