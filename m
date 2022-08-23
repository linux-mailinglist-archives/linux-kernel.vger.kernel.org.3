Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11E759EFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiHWXte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiHWXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:49:27 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4C8B2D9;
        Tue, 23 Aug 2022 16:49:26 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45905200C92;
        Wed, 24 Aug 2022 01:49:25 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 024B2200C89;
        Wed, 24 Aug 2022 01:49:25 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 813CE4060D;
        Tue, 23 Aug 2022 16:49:23 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 2/5] arm64: dts: ls2080a-rdb: add phy nodes
Date:   Tue, 23 Aug 2022 18:49:10 -0500
Message-Id: <20220823234913.30325-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220823234913.30325-1-leoyang.li@nxp.com>
References: <20220823234913.30325-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Define PHY nodes on the board.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls2080a-rdb.dts    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
index 44894356059c..8b6915136997 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
@@ -14,6 +14,7 @@
 
 #include "fsl-ls2080a.dtsi"
 #include "fsl-ls208xa-rdb.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	model = "Freescale Layerscape 2080a RDB Board";
@@ -23,3 +24,71 @@ chosen {
 		stdout-path = "serial1:115200n8";
 	};
 };
+
+&dpmac5 {
+	phy-handle = <&mdio2_phy1>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac6 {
+	phy-handle = <&mdio2_phy2>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac7 {
+	phy-handle = <&mdio2_phy3>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac8 {
+	phy-handle = <&mdio2_phy4>;
+	phy-connection-type = "10gbase-r";
+};
+
+&emdio1 {
+	status = "disabled";
+
+	/* CS4340 PHYs */
+	mdio1_phy1: emdio1-phy@10 {
+		reg = <0x10>;
+	};
+
+	mdio1_phy2: emdio1-phy@11 {
+		reg = <0x11>;
+	};
+
+	mdio1_phy3: emdio1-phy@12 {
+		reg = <0x12>;
+	};
+
+	mdio1_phy4: emdio1-phy@13 {
+		reg = <0x13>;
+	};
+};
+
+&emdio2 {
+	/* AQR405 PHYs */
+	mdio2_phy1: emdio2-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x0>;
+	};
+
+	mdio2_phy2: emdio2-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x1>;
+	};
+
+	mdio2_phy3: emdio2-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x2>;
+	};
+
+	mdio2_phy4: emdio2-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x3>;
+	};
+};
-- 
2.37.1

