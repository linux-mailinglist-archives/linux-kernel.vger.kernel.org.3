Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869D2468CA9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhLESU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbhLESUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:20:14 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B01C061359;
        Sun,  5 Dec 2021 10:16:47 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id b187so10333579iof.11;
        Sun, 05 Dec 2021 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+A19AMS3FcCbKFMkiqJgqoCgdphaPyPa3g/qmWJ+CgE=;
        b=mbtmONrktIpHdPAXu8gK/tZkvc6AKDTYPWMcriMiUe50ViMZlFAdlGnR3U4xDVj483
         J6EhF6nBLEtFvNL7YyErIUJ9sgSyiwlcGS0K7YJnkf0SgzlfYrMnB17TjVf5rp5tvz3D
         7vYVvLCpIbwZTD91iMcutiD2PF4dDGEGv/XxzZoxP0UNVNqEmOrA0cLubwdmNYMbpxGK
         N9poifoxBwf298Wen2wLEf+PyDCja2CTiO8douJkX8Uf7gNFPM/FxWNtr2AdAGVzg2Gj
         Bfy884Sc1HBRWjkhD4+AJan8/Ogs1E+LhWiIYo5KxzpZ0i5FNxDGzMC2g7gFPHEq8XEt
         ndHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+A19AMS3FcCbKFMkiqJgqoCgdphaPyPa3g/qmWJ+CgE=;
        b=xyboIq/0ugTVBWIXnpHHPrCutG5OGnAwZtUeORsYY0Po2owomt+ObU0ukf5HM9kyIK
         uWxHIhdk/uqbgBc0p/7c6VedTbvjOkguAK8JPZJNA2wC/V5AbAw5Bhm+ER2W6ZWc++Fo
         gHYllDjVtsCjvNiHYmb0REdoSDvIP/TDXkXQ4sd7I7SNwqDe0XiEZqUhp2rUyykj9KTj
         Kt7oRJez2UbAldHeUu4zsF3qcPP6SbnUGkyMf/k5UMmW9yVNGvmUcvM74x6zIzv2+qu/
         pzBiCNK7xPzhoSs8/cFs1ZSvHUkjMx0un93w4nVd2K5bQ3rZcNUxiadJQdBpiMckzMRa
         J3lQ==
X-Gm-Message-State: AOAM53250kcCqsZTemtTWWn4vVsCbzA+1HyrRdemYCwio5Jq/0ZfSkFG
        QESqUMCH+a3Gv2VA4aiBa1b+imFYCYNkvw==
X-Google-Smtp-Source: ABdhPJxUD4PGhm5f8vPBx+gx5+Nr0RDU/Xdp53jkJBIAmnEDfXpwWuC7JCIkZ2ynBhvgDKgg9bSbGg==
X-Received: by 2002:a05:6638:4091:: with SMTP id m17mr36529663jam.41.1638728205925;
        Sun, 05 Dec 2021 10:16:45 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:9ea0:bb99:b16a:6159])
        by smtp.gmail.com with ESMTPSA id z12sm5808164ilu.27.2021.12.05.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 10:16:45 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        nicolas@ndufresne.ca, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [RFC 5/5] arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
Date:   Sun,  5 Dec 2021 12:16:18 -0600
Message-Id: <20211205181618.1041699-6-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211205181618.1041699-1-aford173@gmail.com>
References: <20211205181618.1041699-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Hantro G1 and G2 now setup to run independently, update
the device tree to enable it again.  This requires the vpu-blk-ctrl
node to be configured, and the clock-parents and clock-rates for
the various VPU's to be moved into the pgc_vpu because they cannot
get re-parented once enabled, and the pgc_vpu is the highest
in the chain.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 69 +++++++++++++++--------
 1 file changed, 45 insertions(+), 24 deletions(-)

This clock rates and parents were moved to the pgc_vpu node because the vpu-blk-ctrl is 
expecting certain clocks to be operational, and they cannot be re-parented once they are
runing.

The datasheet and the TRM both show different potential clock rates for the G2 CODEC.
It could be as low as 300MHZ or as high as 650 depending on what document is read, and
the operating voltage of the hardware.  Because of the uncertainty, the clock rates 
proposed here match those in NXP's 5.10 Release.

https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm64/boot/dts/freescale/imx8mq.dtsi?h=lf-5.10.y


diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 972766b67a15..0d3053bbfb2c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -711,7 +711,21 @@ pgc_gpu: power-domain@5 {
 					pgc_vpu: power-domain@6 {
 						#power-domain-cells = <0>;
 						reg = <IMX8M_POWER_DOMAIN_VPU>;
-						clocks = <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
+						clocks = <&clk IMX8MQ_CLK_VPU_DEC_ROOT>,
+							 <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
+							 <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
+						assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
+								  <&clk IMX8MQ_CLK_VPU_G2>,
+								  <&clk IMX8MQ_CLK_VPU_BUS>,
+								  <&clk IMX8MQ_VPU_PLL_BYPASS>;
+						assigned-clock-parents = <&clk IMX8MQ_VPU_PLL_OUT>,
+									 <&clk IMX8MQ_VPU_PLL_OUT>,
+									 <&clk IMX8MQ_SYS1_PLL_800M>,
+									 <&clk IMX8MQ_VPU_PLL>;
+						assigned-clock-rates = <600000000>,
+								       <600000000>,
+								       <800000000>,
+								       <0>;
 					};
 
 					pgc_disp: power-domain@7 {
@@ -1432,30 +1446,37 @@ usb3_phy1: usb-phy@382f0040 {
 			status = "disabled";
 		};
 
-		vpu: video-codec@38300000 {
-			compatible = "nxp,imx8mq-vpu";
-			reg = <0x38300000 0x10000>,
-			      <0x38310000 0x10000>,
-			      <0x38320000 0x10000>;
-			reg-names = "g1", "g2", "ctrl";
-			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "g1", "g2";
+		vpu_g1: video-codec@38300000 {
+			compatible = "nxp,imx8mq-vpu-g1";
+			reg = <0x38300000 0x10000>;
+			reg-names = "g1";
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g1";
+			clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
+			clock-names = "g1";
+			power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
+		};
+
+		vpu_g2: video-codec@38310000 {
+			compatible = "nxp,imx8mq-vpu-g2";
+			reg = <0x38310000 0x10000>;
+			reg-names = "g2";
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g2";
+			clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
+			clock-names = "g2";
+			power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
+		};
+
+		vpu_blk_ctrl: blk-ctrl@38320000 {
+			compatible = "fsl,imx8mq-vpu-blk-ctrl", "syscon";
+			reg = <0x38320000 0x100>;
+			power-domains = <&pgc_vpu>, <&pgc_vpu>, <&pgc_vpu>;
+			power-domain-names = "bus", "g1", "g2";
 			clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
-				 <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
-				 <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
-			clock-names = "g1", "g2", "bus";
-			assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
-					  <&clk IMX8MQ_CLK_VPU_G2>,
-					  <&clk IMX8MQ_CLK_VPU_BUS>,
-					  <&clk IMX8MQ_VPU_PLL_BYPASS>;
-			assigned-clock-parents = <&clk IMX8MQ_VPU_PLL_OUT>,
-						 <&clk IMX8MQ_VPU_PLL_OUT>,
-						 <&clk IMX8MQ_SYS1_PLL_800M>,
-						 <&clk IMX8MQ_VPU_PLL>;
-			assigned-clock-rates = <600000000>, <600000000>,
-					       <800000000>, <0>;
-			power-domains = <&pgc_vpu>;
+				 <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
+			clock-names = "g1", "g2";
+			#power-domain-cells = <1>;
 		};
 
 		pcie0: pcie@33800000 {
-- 
2.32.0

