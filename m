Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3563B4DCE54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiCQTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiCQTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:02:44 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED58B1E8CE4;
        Thu, 17 Mar 2022 12:01:27 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E321202DB6;
        Thu, 17 Mar 2022 20:01:26 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DDDD202DAA;
        Thu, 17 Mar 2022 20:01:26 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.145])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 19C754030F;
        Thu, 17 Mar 2022 12:01:25 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Sandeep Malik <sandeep.malik@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: ls208x: remove NXP Erratum A008585 from LS2088A.
Date:   Thu, 17 Mar 2022 14:01:09 -0500
Message-Id: <20220317190109.3742-6-leoyang.li@nxp.com>
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

From: Pankaj Bansal <pankaj.bansal@nxp.com>

NXP Erratum A008585 affects A57 core cluster used in LS2085rev1.
However this problem has been fixed in A72 core cluster used in LS2088.
Therefore remove the erratum from LS2088A. Keeping it only in LS2085.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Reviewed-by: Sandeep Malik <sandeep.malik@nxp.com>
Acked-by: Priyanka Jain <priyanka.jain@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 6f6667b70028..a2cadf757148 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -150,3 +150,7 @@ &pcie4 {
 	ranges = <0x81000000 0x0 0x00000000 0x16 0x00010000 0x0 0x00010000   /* downstream I/O */
 		  0x82000000 0x0 0x40000000 0x16 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 };
+
+&timer {
+	fsl,erratum-a008585;
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 3cb9c21d2775..d823d54a01a5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -239,13 +239,12 @@ map0 {
 		};
 	};
 
-	timer {
+	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 4>, /* Physical Secure PPI, active-low */
 			     <1 14 4>, /* Physical Non-Secure PPI, active-low */
 			     <1 11 4>, /* Virtual PPI, active-low */
 			     <1 10 4>; /* Hypervisor PPI, active-low */
-		fsl,erratum-a008585;
 	};
 
 	pmu {
-- 
2.25.1

