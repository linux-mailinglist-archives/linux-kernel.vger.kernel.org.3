Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F88468114
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383695AbhLDAU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:20:56 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54212 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383658AbhLDAUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:20:50 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 98CB620222C;
        Sat,  4 Dec 2021 01:17:24 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A88DD200B75;
        Sat,  4 Dec 2021 01:17:23 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 1B5E940576;
        Fri,  3 Dec 2021 17:17:23 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Biwen Li <biwen.li@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 3/8] arm64: dts: ls1028a: add flextimer based pwm nodes
Date:   Fri,  3 Dec 2021 18:17:13 -0600
Message-Id: <20211204001718.8511-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211204001718.8511-1-leoyang.li@nxp.com>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add pwm nodes using flextimer controller.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index ef9d17df2afa..5c17dfaa50de 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -66,6 +66,13 @@ CPU_PW20: cpu-pw20 {
 		};
 	};
 
+	rtc_clk: rtc-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "rtc_clk";
+	};
+
 	sysclk: sysclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -1186,6 +1193,94 @@ ierb@1f0800000 {
 			reg = <0x01 0xf0800000 0x0 0x10000>;
 		};
 
+		pwm0: pwm@2800000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2800000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				      "ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&rtc_clk>, <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@2810000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2810000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				      "ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&rtc_clk>, <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@2820000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2820000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				      "ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&rtc_clk>, <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@2830000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2830000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				      "ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&rtc_clk>, <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@2840000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2840000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				      "ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&rtc_clk>, <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@2850000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2850000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				      "ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&rtc_clk>, <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@2860000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2860000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				      "ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&rtc_clk>, <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@2870000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2870000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				      "ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&rtc_clk>, <&clockgen 4 1>;
+			status = "disabled";
+		};
+
 		rcpm: power-controller@1e34040 {
 			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
-- 
2.25.1

