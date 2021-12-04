Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA04681BF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 02:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354734AbhLDBTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 20:19:09 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44608 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233023AbhLDBTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 20:19:08 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 21D8F1A07A5;
        Sat,  4 Dec 2021 02:15:43 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DC1F91A07D9;
        Sat,  4 Dec 2021 02:15:42 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 1459640576;
        Fri,  3 Dec 2021 18:15:42 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [PATCH 1/2] arm64: dts: ls1088a: Add reboot nodes
Date:   Fri,  3 Dec 2021 19:15:36 -0600
Message-Id: <20211204011537.8963-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ls1088a has a separate reset register block.  Define it in dts and use
it for reboot.

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f891ef6a3754..1eda080b497c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -206,6 +206,13 @@ sysclk: sysclk {
 		clock-output-names = "sysclk";
 	};
 
+	reboot {
+		compatible = "syscon-reboot";
+		regmap = <&reset>;
+		offset = <0x0>;
+		mask = <0x02>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -226,6 +233,11 @@ dcfg: dcfg@1e00000 {
 			little-endian;
 		};
 
+		reset: syscon@1e60000 {
+			compatible = "fsl,ls1088a-reset", "syscon";
+			reg = <0x0 0x1e60000 0x0 0x10000>;
+		};
+
 		isc: syscon@1f70000 {
 			compatible = "fsl,ls1088a-isc", "syscon";
 			reg = <0x0 0x1f70000 0x0 0x10000>;
-- 
2.25.1

