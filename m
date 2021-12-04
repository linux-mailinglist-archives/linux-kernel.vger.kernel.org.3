Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57099468111
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383668AbhLDAUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:20:50 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41748 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383641AbhLDAUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:20:49 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D7F3D1A25BC;
        Sat,  4 Dec 2021 01:17:23 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DA2F1A25B8;
        Sat,  4 Dec 2021 01:17:23 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D30034057A;
        Fri,  3 Dec 2021 17:17:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Biwen Li <biwen.li@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 2/8] arm64: dts: ls1028a: add ftm_alarm1 node to be used as wakeup source
Date:   Fri,  3 Dec 2021 18:17:12 -0600
Message-Id: <20211204001718.8511-3-leoyang.li@nxp.com>
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

Add flextimer2 based ftm_alarm1 node and enable it to be the default rtc
wakeup source for rdb and qds boards instead of the original flextimer1
based ftm_alarm0.  The ftm_alarm0 node hence is disabled by default.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 6 +++++-
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 6 +++++-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 9 +++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 6e2a1da662fb..00d5b81bdef3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -25,7 +25,7 @@ aliases {
 		serial1 = &duart1;
 		mmc0 = &esdhc;
 		mmc1 = &esdhc1;
-		rtc1 = &ftm_alarm0;
+		rtc1 = &ftm_alarm1;
 	};
 
 	chosen {
@@ -234,6 +234,10 @@ mt35xu02g0: flash@0 {
 	};
 };
 
+&ftm_alarm1 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 7719f44bcaed..41900d351a92 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -21,7 +21,7 @@ aliases {
 		serial1 = &duart1;
 		mmc0 = &esdhc;
 		mmc1 = &esdhc1;
-		rtc1 = &ftm_alarm0;
+		rtc1 = &ftm_alarm1;
 	};
 
 	chosen {
@@ -132,6 +132,10 @@ mt35xu02g0: flash@0 {
 	};
 };
 
+&ftm_alarm1 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 9efcaf68578c..ef9d17df2afa 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1198,6 +1198,15 @@ ftm_alarm0: timer@2800000 {
 			reg = <0x0 0x2800000 0x0 0x10000>;
 			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		ftm_alarm1: timer@2810000 {
+			compatible = "fsl,ls1028a-ftm-alarm";
+			reg = <0x0 0x2810000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 	};
 
-- 
2.25.1

