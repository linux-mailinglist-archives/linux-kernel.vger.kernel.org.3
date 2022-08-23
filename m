Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9C59F000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiHWXtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiHWXt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:49:26 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CE8B2D6;
        Tue, 23 Aug 2022 16:49:25 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 45BCB1A0C74;
        Wed, 24 Aug 2022 01:49:24 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 037D11A0C78;
        Wed, 24 Aug 2022 01:49:24 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id A115C40AA3;
        Tue, 23 Aug 2022 16:49:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>
Subject: [PATCH v3 1/5] arm64: dts: ls208xa-qds: add mdio mux nodes from on-board FPGA
Date:   Tue, 23 Aug 2022 18:49:09 -0500
Message-Id: <20220823234913.30325-2-leoyang.li@nxp.com>
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

Update the cpld node name to be generic board-contrl and add mmio mdio
mux nodes from the on-board FPGA.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi   | 65 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index 6fab73d484b6..f598669e742f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -9,6 +9,27 @@
  *
  */
 
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
 &esdhc {
 	mmc-hs200-1_8v;
 	status = "okay";
@@ -36,9 +57,47 @@ nand@2,0 {
 	     reg = <0x2 0x0 0x10000>;
 	};
 
-	cpld@3,0 {
-	     reg = <0x3 0x0 0x10000>;
-	     compatible = "fsl,ls2080aqds-fpga", "fsl,fpga-qixis";
+	boardctrl: board-control@3,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,ls208xaqds-fpga", "fsl,fpga-qixis", "simple-mfd";
+		reg = <3 0 0x1000>;
+		ranges = <0 3 0 0x1000>;
+
+		mdio-mux-emi1@54 {
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
+			mdio-parent-bus = <&emdio1>;
+			reg = <0x54 1>;		/* BRDCFG4 */
+			mux-mask = <0xe0>;	/* EMI1_MDIO */
+			#address-cells=<1>;
+			#size-cells = <0>;
+
+			/* Child MDIO buses, one for each riser card:
+			 * reg = 0x0, 0x20, 0x40, 0x60, 0x80, 0xa0.
+			 * VSC8234 PHYs on the riser cards.
+			 */
+			mdio_mux3: mdio@60 {
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mdio0_phy12: mdio-phy0@1c {
+					reg = <0x1c>;
+				};
+
+				mdio0_phy13: mdio-phy1@1d {
+					reg = <0x1d>;
+				};
+
+				mdio0_phy14: mdio-phy2@1e {
+					reg = <0x1e>;
+				};
+
+				mdio0_phy15: mdio-phy3@1f {
+					reg = <0x1f>;
+				};
+			};
+		};
 	};
 };
 
-- 
2.37.1

