Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DE5691F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiGFSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiGFSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D32314A;
        Wed,  6 Jul 2022 11:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5314DB81E8F;
        Wed,  6 Jul 2022 18:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933E0C341CD;
        Wed,  6 Jul 2022 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657132490;
        bh=XNH2UJ1PPgNymXZEuVCkorclmy4IiwEMWJspPvtwpOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1HzeXUimoNrKp3NWuXF9XLFoNHLwRcfF6Et4QbV0wyYr7VNx2LyU2yAJH+DpxwVD
         Be3OpDRhppfBFrtLYIlGf9PmclayrRVnjRq87GizgKd9uAKRbuWh9SSEIWmSYw2Vyr
         PD6Sobp/1fnXSEfQGLeqZooQ+Uxq7ky1YXu3VNrVdAMrQNXqCwz8I57DiLEuL9apdb
         qJvYID/kcxH7pQeMUWzrpLFSJeUE6yWIk5OjhJkJkr/fNPTBvncTJO+Wi0okMGd0nn
         AKE5sdwukCmCJ/R5Vt/5w3gP828F6Df3pq+vEKxaLb68SxFeZdT63IKHGRnhLroSBd
         szjUGhQEaQjpQ==
Received: by pali.im (Postfix)
        id 4C75A7BA; Wed,  6 Jul 2022 20:34:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] ARM: dts: armada-xp-mv78230.dtsi: Add definitions for PCIe legacy INTx interrupts
Date:   Wed,  6 Jul 2022 20:31:08 +0200
Message-Id: <20220706183114.30783-6-pali@kernel.org>
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
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 70 ++++++++++++++++++++----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 8558bf6bb54c..bf9360f41e0a 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -83,16 +83,26 @@
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
@@ -101,16 +111,26 @@
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
@@ -119,16 +139,26 @@
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
@@ -137,16 +167,26 @@
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
@@ -155,16 +195,26 @@
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
 		};
 
-- 
2.20.1

