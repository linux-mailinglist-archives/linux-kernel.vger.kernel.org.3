Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1151B4DCE58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbiCQTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiCQTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:02:39 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8872E1E5217;
        Thu, 17 Mar 2022 12:01:22 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B777202DAC;
        Thu, 17 Mar 2022 20:01:21 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F2A5E200022;
        Thu, 17 Mar 2022 20:01:20 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.145])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 03E404030F;
        Thu, 17 Mar 2022 12:01:19 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: ls2080a-rdb: add phy nodes
Date:   Thu, 17 Mar 2022 14:01:06 -0500
Message-Id: <20220317190109.3742-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220317190109.3742-1-leoyang.li@nxp.com>
References: <20220317190109.3742-1-leoyang.li@nxp.com>
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

Define PHY nodes on the board.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls2080a-rdb.dts    | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
index 44894356059c..1c8c99a74071 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
@@ -23,3 +23,71 @@ chosen {
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
+	mdio1_phy1: emdio1_phy@1 {
+		reg = <0x10>;
+	};
+
+	mdio1_phy2: emdio1_phy@2 {
+		reg = <0x11>;
+	};
+
+	mdio1_phy3: emdio1_phy@3 {
+		reg = <0x12>;
+	};
+
+	mdio1_phy4: emdio1_phy@4 {
+		reg = <0x13>;
+	};
+};
+
+&emdio2 {
+	/* AQR405 PHYs */
+	mdio2_phy1: emdio2_phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts = <0 1 0x4>; /* Level high type */
+		reg = <0x0>;
+	};
+
+	mdio2_phy2: emdio2_phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts = <0 2 0x4>; /* Level high type */
+		reg = <0x1>;
+	};
+
+	mdio2_phy3: emdio2_phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts = <0 4 0x4>; /* Level high type */
+		reg = <0x2>;
+	};
+
+	mdio2_phy4: emdio2_phy@4 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts = <0 5 0x4>; /* Level high type */
+		reg = <0x3>;
+	};
+};
-- 
2.25.1

