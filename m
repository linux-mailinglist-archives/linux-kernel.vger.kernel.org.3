Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3936848F981
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiAOVJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiAOVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:09:15 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB99FC061574;
        Sat, 15 Jan 2022 13:09:14 -0800 (PST)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C4728223EA;
        Sat, 15 Jan 2022 22:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642280953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5tn68llnv3Y3QD1FEMzUGnRcOKYr1qqq3usYUvxU2k=;
        b=fHwyiNWeiVEP7yxZ7+GMJh8yNjX2WdU9oFL8ZAOJtpziKQd7IqpsYoDtRQ0ZuSBLKUOlbH
        xG4nRyB4d1mDAb2a0srTGYTSWgosk3UhUkQbMJXT38MjOyqXEdzQ6vJ5zewAZmVL9M85Z0
        77zTAz5+mf8hZhuXU+aZ1serg6Symbg=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Biwen Li <biwen.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] Revert "arm64: dts: ls1028a: add flextimer based pwm nodes"
Date:   Sat, 15 Jan 2022 22:09:07 +0100
Message-Id: <20220115210907.451189-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220115210907.451189-1-michael@walle.cc>
References: <20220115210907.451189-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes to the device tree look very wrong. There are now two
devices with the same base address: pwm0 and ftm_alarm0. Both are using
the Flex Timer Module. It seems like this should either be one driver or
and MFD driver. Either way, there should only be one node in the device
tree. Revert the offending changes to avoid getting a broken device tree
in circulation.

This reverts commit 71799672ea24d2935322d655d2407c1ccd7db9ff.

Fixes: 71799672ea24 ("arm64: dts: ls1028a: add flextimer based pwm nodes")
Signed-off-by: Michael Walle <michael@walle.cc>
---

Btw, the nodes are also not sorted by the address. Otherwise it should have
been spotted easily.

 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 95 -------------------
 1 file changed, 95 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 1ef26cbc79cb..d3cc8cbaf768 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -66,13 +66,6 @@ CPU_PW20: cpu-pw20 {
 		};
 	};
 
-	rtc_clk: rtc-clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "rtc_clk";
-	};
-
 	sysclk: sysclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -1245,94 +1238,6 @@ ierb@1f0800000 {
 			reg = <0x01 0xf0800000 0x0 0x10000>;
 		};
 
-		pwm0: pwm@2800000 {
-			compatible = "fsl,vf610-ftm-pwm";
-			#pwm-cells = <3>;
-			reg = <0x0 0x2800000 0x0 0x10000>;
-			clock-names = "ftm_sys", "ftm_ext",
-				      "ftm_fix", "ftm_cnt_clk_en";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&rtc_clk>, <&clockgen 4 1>;
-			status = "disabled";
-		};
-
-		pwm1: pwm@2810000 {
-			compatible = "fsl,vf610-ftm-pwm";
-			#pwm-cells = <3>;
-			reg = <0x0 0x2810000 0x0 0x10000>;
-			clock-names = "ftm_sys", "ftm_ext",
-				      "ftm_fix", "ftm_cnt_clk_en";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&rtc_clk>, <&clockgen 4 1>;
-			status = "disabled";
-		};
-
-		pwm2: pwm@2820000 {
-			compatible = "fsl,vf610-ftm-pwm";
-			#pwm-cells = <3>;
-			reg = <0x0 0x2820000 0x0 0x10000>;
-			clock-names = "ftm_sys", "ftm_ext",
-				      "ftm_fix", "ftm_cnt_clk_en";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&rtc_clk>, <&clockgen 4 1>;
-			status = "disabled";
-		};
-
-		pwm3: pwm@2830000 {
-			compatible = "fsl,vf610-ftm-pwm";
-			#pwm-cells = <3>;
-			reg = <0x0 0x2830000 0x0 0x10000>;
-			clock-names = "ftm_sys", "ftm_ext",
-				      "ftm_fix", "ftm_cnt_clk_en";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&rtc_clk>, <&clockgen 4 1>;
-			status = "disabled";
-		};
-
-		pwm4: pwm@2840000 {
-			compatible = "fsl,vf610-ftm-pwm";
-			#pwm-cells = <3>;
-			reg = <0x0 0x2840000 0x0 0x10000>;
-			clock-names = "ftm_sys", "ftm_ext",
-				      "ftm_fix", "ftm_cnt_clk_en";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&rtc_clk>, <&clockgen 4 1>;
-			status = "disabled";
-		};
-
-		pwm5: pwm@2850000 {
-			compatible = "fsl,vf610-ftm-pwm";
-			#pwm-cells = <3>;
-			reg = <0x0 0x2850000 0x0 0x10000>;
-			clock-names = "ftm_sys", "ftm_ext",
-				      "ftm_fix", "ftm_cnt_clk_en";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&rtc_clk>, <&clockgen 4 1>;
-			status = "disabled";
-		};
-
-		pwm6: pwm@2860000 {
-			compatible = "fsl,vf610-ftm-pwm";
-			#pwm-cells = <3>;
-			reg = <0x0 0x2860000 0x0 0x10000>;
-			clock-names = "ftm_sys", "ftm_ext",
-				      "ftm_fix", "ftm_cnt_clk_en";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&rtc_clk>, <&clockgen 4 1>;
-			status = "disabled";
-		};
-
-		pwm7: pwm@2870000 {
-			compatible = "fsl,vf610-ftm-pwm";
-			#pwm-cells = <3>;
-			reg = <0x0 0x2870000 0x0 0x10000>;
-			clock-names = "ftm_sys", "ftm_ext",
-				      "ftm_fix", "ftm_cnt_clk_en";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&rtc_clk>, <&clockgen 4 1>;
-			status = "disabled";
-		};
-
 		rcpm: power-controller@1e34040 {
 			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
-- 
2.30.2

