Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DC46AFC2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377575AbhLGB1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:27:46 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:52147 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1355012AbhLGB1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:27:43 -0500
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; 
   d="scan'208";a="103026631"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2021 10:24:12 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E4E084172F32;
        Tue,  7 Dec 2021 10:24:09 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 3/3] arm64: dts: renesas: r9a07g044: Add CRU node
Date:   Tue,  7 Dec 2021 01:23:51 +0000
Message-Id: <20211207012351.15754-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CRU node r9a07g044 (RZ/G2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 3f231968a762..dd459cf869ec 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -556,6 +556,65 @@
 			status = "disabled";
 		};
 
+		cru: video@10830000 {
+			compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
+			reg = <0 0x10830000 0 0x10000>;
+			clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
+				 <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+				 <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
+				 <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
+			clock-names = "sysclk", "vclk", "pclk", "aclk";
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "csi2_link_int", "image_conv_int",
+					  "image_conv_err_int", "axi_mst_err_int";
+			resets = <&cpg R9A07G044_CRU_CMN_RSTB>,
+				 <&cpg R9A07G044_CRU_PRESETN>,
+				 <&cpg R9A07G044_CRU_ARESETN>;
+			reset-names = "cmn-rstb", "presetn", "aresetn";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					/* parallel input */
+					reg = <0>;
+				};
+
+				port@1 {
+					/* input to CSI port */
+					reg = <1>;
+				};
+
+				port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+
+					csi2cru: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&crucsi2>;
+					};
+				};
+
+				port@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <3>;
+					crucsi2: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi2cru>;
+					};
+				};
+			};
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a07g044-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.17.1

