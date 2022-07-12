Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83D4572131
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiGLQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiGLQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:41:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C01C3AFE;
        Tue, 12 Jul 2022 09:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23BDBCE1C9F;
        Tue, 12 Jul 2022 16:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC12C341CD;
        Tue, 12 Jul 2022 16:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657644086;
        bh=17y76lSzSc7hAMgtMuJKp71vtfM+9WHafoK+k81GIYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBRkSUxYGpA/O42WOco2Rp4+DQ6ckIV3Q16e+CXlKF9Ut6HYNBVhglsDz+VF4UAvZ
         gAP0chkaOTZWAQU+iEaUZRfIx7Y2U5r3uuklCDK/qZjShWv/fNV3dpFeXbsouq5rIG
         /xfoA+F/iRrTYBRumksXlmt6ekkz35EaRB5VgQpRs7UtWZbkvz0f42xdAV/t3iIlFB
         /NavUXhHrwZsvk1KE1mV4Xq08KceoO/ZiD0q5RWxm73tUra7KHtW/OffEbElvGgqBP
         FUV/aKEG5rHqJSz0tBKNNfBgdD5qPUs1oVdTGsOE3mE0AR970i1c7hU2JXAVZNPyEx
         vmHyJ47o4RvlA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 06/10] ARM: dts: armada-xp-mv78260.dtsi: Add definitions for PCIe legacy INTx interrupts
Date:   Tue, 12 Jul 2022 18:41:04 +0200
Message-Id: <20220712164108.30262-7-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712164108.30262-1-kabel@kernel.org>
References: <20220712164108.30262-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Add definitions for PCIe legacy INTx interrupts.

This is required for example in a scenario where a driver requests only
one of the legacy interrupts (INTA). Without this, the driver would be
notified on events on all 4 (INTA, INTB, INTC, INTD), even if it
requested only one of them.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 126 +++++++++++++++++++----
 1 file changed, 108 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 2d85fe8ac327..0714af52e607 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -98,16 +98,26 @@ pcie1: pcie@1,0 {
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
@@ -116,16 +126,26 @@ pcie2: pcie@2,0 {
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
@@ -134,16 +154,26 @@ pcie3: pcie@3,0 {
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
@@ -152,16 +182,26 @@ pcie4: pcie@4,0 {
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
@@ -170,16 +210,26 @@ pcie5: pcie@5,0 {
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
@@ -188,16 +238,26 @@ pcie6: pcie@6,0 {
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
@@ -206,16 +266,26 @@ pcie7: pcie@7,0 {
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
@@ -224,16 +294,26 @@ pcie8: pcie@8,0 {
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
@@ -242,16 +322,26 @@ pcie9: pcie@9,0 {
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
 		};
 
-- 
2.35.1

