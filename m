Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515FF463C14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbhK3Qqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:46:37 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44240 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhK3Qqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:46:36 -0500
Received: from Monstersaurus.local (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F10911C5;
        Tue, 30 Nov 2021 17:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638290595;
        bh=w7su8/kwCx6CWfTEhlhNUnkf3j4MwZ1D2xFJ9I1Nk7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsH90Qz88wRxJDrhkv518x6vHUCBVBohBi4PvHE3lHueFf2TszcVJaatkt7cccjFA
         z1HwZWLXGWGMU4mNwzZNw4XdjQGP+cTESTxG3EWaaHujCd4JFVYPUwDTD81rmjXsVO
         AfxgfxgLgGhKTjQA3aYqQ4u0AQWwjDBaHaGqtLn8=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/2] arm64: dts: renesas: r8a779a0: Add DSI encoders
Date:   Tue, 30 Nov 2021 16:43:10 +0000
Message-Id: <20211130164311.2909616-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130164311.2909616-1-kieran.bingham+renesas@ideasonboard.com>
References: <20211130164311.2909616-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the two MIPI DSI encoders on the V3U and connect them to the DU
accordingly.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
v2
 - Fixup indentation

v3
 - Fix the clock references
 - Fixup dsi1 as well

-v4:
 - Use the correct pll clocks.

v5:
 - Remove dsi_out port endpoints.
 - They must be added by the definition that links them.

 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 60 +++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index 8ac1a31e4146..2bd241b2a588 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -2290,12 +2290,14 @@ ports {
 				port@0 {
 					reg = <0>;
 					du_out_dsi0: endpoint {
+						remote-endpoint = <&dsi0_in>;
 					};
 				};
 
 				port@1 {
 					reg = <1>;
 					du_out_dsi1: endpoint {
+						remote-endpoint = <&dsi1_in>;
 					};
 				};
 			};
@@ -2633,6 +2635,64 @@ isp3vin31: endpoint {
 			};
 		};
 
+		dsi0: dsi-encoder@fed80000 {
+			compatible = "renesas,r8a779a0-dsi-csi2-tx";
+			reg = <0 0xfed80000 0 0x10000>;
+			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+			clocks = <&cpg CPG_MOD 415>,
+				 <&cpg CPG_CORE R8A779A0_CLK_DSI>,
+				 <&cpg CPG_CORE R8A779A0_CLK_CL16MCK>;
+			clock-names = "fck", "dsi", "pll";
+
+			resets = <&cpg 415>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dsi0_in: endpoint {
+						remote-endpoint = <&du_out_dsi0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
+		dsi1: dsi-encoder@fed90000 {
+			compatible = "renesas,r8a779a0-dsi-csi2-tx";
+			reg = <0 0xfed90000 0 0x10000>;
+			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+			clocks = <&cpg CPG_MOD 415>,
+				 <&cpg CPG_CORE R8A779A0_CLK_DSI>,
+				 <&cpg CPG_CORE R8A779A0_CLK_CL16MCK>;
+			clock-names = "fck", "dsi", "pll";
+
+			resets = <&cpg 416>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dsi1_in: endpoint {
+						remote-endpoint = <&du_out_dsi1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
 		prr: chipid@fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
-- 
2.30.2

