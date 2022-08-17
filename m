Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76D59782A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbiHQUoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbiHQUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:44:13 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E639A99ED;
        Wed, 17 Aug 2022 13:44:12 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 18C0C200280;
        Wed, 17 Aug 2022 22:44:11 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50A4C200274;
        Wed, 17 Aug 2022 22:44:10 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id BE07F40AA2;
        Wed, 17 Aug 2022 13:44:05 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 1/6] arm64: dts: ls2080a-qds: add mdio mux nodes from on-board FPGA
Date:   Wed, 17 Aug 2022 15:43:52 -0500
Message-Id: <20220817204357.21753-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220817204357.21753-1-leoyang.li@nxp.com>
References: <20220817204357.21753-1-leoyang.li@nxp.com>
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

Add mmio mdio mux nodes from the on-board FPGA.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls2080a-qds.dts    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
index f6c3ee78ace0..ef79c9a78f89 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
@@ -23,3 +23,72 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 };
+
+/* Update DPMAC connections to external PHYs, under SerDes 0x2a_0x49. */
+&dpmac9 {
+	phy-handle = <&mdio0_phy12>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac10 {
+	phy-handle = <&mdio0_phy13>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac11 {
+	phy-handle = <&mdio0_phy14>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac12 {
+	phy-handle = <&mdio0_phy15>;
+	phy-connection-type = "sgmii";
+};
+
+&ifc {
+	boardctrl: board-control@3,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,tetra-fpga", "fsl,fpga-qixis", "simple-mfd";
+		reg = <3 0 0x300>;
+		ranges = <0 3 0 0x300>;
+
+		mdio-mux-emi1@54 {
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
+			mdio-parent-bus = <&emdio1>;
+			reg = <0x54 1>;		/* BRDCFG4 */
+			mux-mask = <0xe0>;	/* EMI1_MDIO */
+
+			#address-cells=<1>;
+			#size-cells = <0>;
+
+			/* Child MDIO buses, one for each riser card:
+			 * reg = 0x0, 0x20, 0x40, 0x60, 0x80, 0xa0.
+			 * VSC8234 PHYs on the riser cards.
+			 */
+
+			mdio_mux3: mdio@60 {
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mdio0_phy12: mdio_phy0@1c {
+					reg = <0x1c>;
+				};
+
+				mdio0_phy13: mdio_phy1@1d {
+					reg = <0x1d>;
+				};
+
+				mdio0_phy14: mdio_phy2@1e {
+					reg = <0x1e>;
+				};
+
+				mdio0_phy15: mdio_phy3@1f {
+					reg = <0x1f>;
+				};
+			};
+		};
+	};
+};
+
-- 
2.37.1

