Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747485691EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiGFSfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiGFSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB9201B5;
        Wed,  6 Jul 2022 11:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E934B81E8C;
        Wed,  6 Jul 2022 18:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E4C341CA;
        Wed,  6 Jul 2022 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657132492;
        bh=vIqNniLqctdxQJCjBxKrH8KKRQB3VszatfSqMTIQxKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtbExBuYHPWTIX69iI2gtHzUvpErU692AwIwCUHtBMeq+8uitugPayxl+9UhD78CW
         f9dDcHxEYxjVeA6Ta0F2uWamFZXrDxZsiIPTAUMWzJdz1FMRpzKJLS3Z+Z5aRd4Zej
         gKMy5J0i3/9zV3SiNlDTIvc+znxxC4iDTxfht4W7/ngLT3pzcCnnuVaghQ7Mqx9ouX
         4cNFJSH+FfRCx12dUqy93HAwNqicK5X+cghBxKdpdqTPKaWy0T1VkeRXDhNim9EQka
         RawB56L3ZCx56FJwvlhaR0UlBiGo0N5oMtUrcA9tzzM601nTp+8QuIdCV2SnUygwI5
         wXIlaJvWuZfhg==
Received: by pali.im (Postfix)
        id 3522F7BA; Wed,  6 Jul 2022 20:34:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] ARM: dts: armada-xp-mv78460.dtsi: Add definitions for PCIe legacy INTx interrupts
Date:   Wed,  6 Jul 2022 20:31:10 +0200
Message-Id: <20220706183114.30783-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220706183114.30783-1-pali@kernel.org>
References: <20220706183114.30783-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 140 +++++++++++++++++++----
 1 file changed, 120 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 230a3fd36b30..16185edf9aa5 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -119,16 +119,26 @@
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 58>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 58>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+						<0 0 0 2 &pcie1_intc 1>,
+						<0 0 0 3 &pcie1_intc 2>,
+						<0 0 0 4 &pcie1_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 5>;
 				status = "disabled";
+
+				pcie1_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie2: pcie@2,0 {
@@ -137,16 +147,26 @@
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 59>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 59>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie2_intc 0>,
+						<0 0 0 2 &pcie2_intc 1>,
+						<0 0 0 3 &pcie2_intc 2>,
+						<0 0 0 4 &pcie2_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <1>;
 				clocks = <&gateclk 6>;
 				status = "disabled";
+
+				pcie2_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie3: pcie@3,0 {
@@ -155,16 +175,26 @@
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 60>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 60>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie3_intc 0>,
+						<0 0 0 2 &pcie3_intc 1>,
+						<0 0 0 3 &pcie3_intc 2>,
+						<0 0 0 4 &pcie3_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <2>;
 				clocks = <&gateclk 7>;
 				status = "disabled";
+
+				pcie3_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie4: pcie@4,0 {
@@ -173,16 +203,26 @@
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 61>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
 					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 61>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie4_intc 0>,
+						<0 0 0 2 &pcie4_intc 1>,
+						<0 0 0 3 &pcie4_intc 2>,
+						<0 0 0 4 &pcie4_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <3>;
 				clocks = <&gateclk 8>;
 				status = "disabled";
+
+				pcie4_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie5: pcie@5,0 {
@@ -191,16 +231,26 @@
 				reg = <0x2800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 62>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
 					  0x81000000 0 0 0x81000000 0x5 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 62>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie5_intc 0>,
+						<0 0 0 2 &pcie5_intc 1>,
+						<0 0 0 3 &pcie5_intc 2>,
+						<0 0 0 4 &pcie5_intc 3>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 9>;
 				status = "disabled";
+
+				pcie5_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie6: pcie@6,0 {
@@ -209,16 +259,26 @@
 				reg = <0x3000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 63>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x6 0 1 0
 					  0x81000000 0 0 0x81000000 0x6 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 63>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie6_intc 0>,
+						<0 0 0 2 &pcie6_intc 1>,
+						<0 0 0 3 &pcie6_intc 2>,
+						<0 0 0 4 &pcie6_intc 3>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <1>;
 				clocks = <&gateclk 10>;
 				status = "disabled";
+
+				pcie6_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie7: pcie@7,0 {
@@ -227,16 +287,26 @@
 				reg = <0x3800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 64>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x7 0 1 0
 					  0x81000000 0 0 0x81000000 0x7 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 64>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie7_intc 0>,
+						<0 0 0 2 &pcie7_intc 1>,
+						<0 0 0 3 &pcie7_intc 2>,
+						<0 0 0 4 &pcie7_intc 3>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <2>;
 				clocks = <&gateclk 11>;
 				status = "disabled";
+
+				pcie7_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie8: pcie@8,0 {
@@ -245,16 +315,26 @@
 				reg = <0x4000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 65>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x8 0 1 0
 					  0x81000000 0 0 0x81000000 0x8 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 65>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie8_intc 0>,
+						<0 0 0 2 &pcie8_intc 1>,
+						<0 0 0 3 &pcie8_intc 2>,
+						<0 0 0 4 &pcie8_intc 3>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <3>;
 				clocks = <&gateclk 12>;
 				status = "disabled";
+
+				pcie8_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie9: pcie@9,0 {
@@ -263,16 +343,26 @@
 				reg = <0x4800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 99>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
 					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 99>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie9_intc 0>,
+						<0 0 0 2 &pcie9_intc 1>,
+						<0 0 0 3 &pcie9_intc 2>,
+						<0 0 0 4 &pcie9_intc 3>;
 				marvell,pcie-port = <2>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 26>;
 				status = "disabled";
+
+				pcie9_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie10: pcie@a,0 {
@@ -281,16 +371,26 @@
 				reg = <0x5000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&mpic 103>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0xa 0 1 0
 					  0x81000000 0 0 0x81000000 0xa 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 103>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie10_intc 0>,
+						<0 0 0 2 &pcie10_intc 1>,
+						<0 0 0 3 &pcie10_intc 2>,
+						<0 0 0 4 &pcie10_intc 3>;
 				marvell,pcie-port = <3>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 27>;
 				status = "disabled";
+
+				pcie10_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 
-- 
2.20.1

