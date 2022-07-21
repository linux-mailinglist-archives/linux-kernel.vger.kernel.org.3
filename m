Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809C557D21C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiGUQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiGUQ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:57:25 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCAA489EB4;
        Thu, 21 Jul 2022 09:57:22 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,183,1654527600"; 
   d="scan'208";a="126927675"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jul 2022 01:57:21 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E89414011419;
        Fri, 22 Jul 2022 01:57:18 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] arm64: dts: renesas: rzg2l-smarc-som: Add PHY interrupt support for ETH{0/1}
Date:   Thu, 21 Jul 2022 17:57:01 +0100
Message-Id: <20220721165701.17888-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
and ETH1 respectively.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Used macros of IRQ numbers
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 9410796c8ad6..3ffda0d3fa01 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -94,6 +94,8 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -120,6 +122,8 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ3 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -171,7 +175,8 @@ eth0_pins: eth0 {
 			 <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
 			 <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
 			 <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
-			 <RZG2L_PORT_PINMUX(26, 1, 1)>; /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
 	};
 
 	eth1_pins: eth1 {
@@ -189,7 +194,8 @@ eth1_pins: eth1 {
 			 <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
 			 <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
 			 <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
-			 <RZG2L_PORT_PINMUX(36, 0, 1)>; /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
 	};
 
 	gpio-sd0-pwr-en-hog {
-- 
2.25.1

