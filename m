Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECAB5598F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiFXMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFXMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:00:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4BA76698;
        Fri, 24 Jun 2022 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656072018; x=1687608018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L7CObdet2addz1owDfCnobhk+prLUKmCD2n9OZyHCsg=;
  b=VjCFyDG2opOkEf+Yo/6i5GrglXyLDCnR2kPteo5r+D1GFR4ixyVtduEv
   Hy2hG4WjwKyBWIMVnwGJa7RGq+6L5n18R5mSr9WLF3W9+gzr6XfN/hl4K
   fXOetOa6+1FCHCHsY6FwpJRrQdzof3q3oKzX9K9rUTe4l2tUbAhbDjuGW
   0RjCy9HEOyAYMb5i2vGC1/J2Dv0XNRtOkemRGFpOTqVH3VRIR5FoWzMIK
   jKjxOXI//nhlVkOTd5TxcEdrlj1nv+QMSS521Q9JAq0JxgwCuI+2lWs3+
   QCXh+IeKjvV3cPJPgoH6sAtTGlUiC5ZQ/ZWp+OmS0+vLN+kaW1z7md01f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="281029066"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="281029066"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="586552764"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2022 05:00:15 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH] arm64: dts: altera: socfpga_stratix10: move clocks out of soc node
Date:   Fri, 24 Jun 2022 19:59:11 +0800
Message-Id: <20220624115911.3389627-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624031017.3247656-1-niravkumar.l.rabara@intel.com>
References: <20220624031017.3247656-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

The clocks are not part of the SoC but provided on the board
(external oscillators). Moving them out of soc node.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 .../boot/dts/altera/socfpga_stratix10.dtsi    | 56 +++++++++----------
 .../dts/altera/socfpga_stratix10_socdk.dts    | 10 ++--
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index aa2bba75265f..5c7d926d18f7 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -97,6 +97,34 @@ intc: interrupt-controller@fffc1000 {
 		      <0x0 0xfffc6000 0x0 0x2000>;
 	};
 
+	clocks {
+		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+		};
+
+		cb_intosc_ls_clk: cb-intosc-ls-clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+		};
+
+		f2s_free_clk: f2s-free-clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+		};
+
+		osc1: osc1 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+		};
+
+		qspi_clk: qspi-clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -119,34 +147,6 @@ clkmgr: clock-controller@ffd10000 {
 			#clock-cells = <1>;
 		};
 
-		clocks {
-			cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-			};
-
-			cb_intosc_ls_clk: cb-intosc-ls-clk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-			};
-
-			f2s_free_clk: f2s-free-clk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-			};
-
-			osc1: osc1 {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-			};
-
-			qspi_clk: qspi-clk {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <200000000>;
-			};
-		};
-
 		gmac0: ethernet@ff800000 {
 			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff800000 0x2000>;
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 5159cd5771dc..48424e459f12 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -52,12 +52,6 @@ ref_033v: regulator-v-ref {
 	};
 
 	soc {
-		clocks {
-			osc1 {
-				clock-frequency = <25000000>;
-			};
-		};
-
 		eccmgr {
 			sdmmca-ecc@ff8c8c00 {
 				compatible = "altr,socfpga-s10-sdmmc-ecc",
@@ -113,6 +107,10 @@ &mmc {
 	bus-width = <4>;
 };
 
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.25.1

