Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5846B03D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbhLGB7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhLGB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:58:57 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1DDC0698C3;
        Mon,  6 Dec 2021 17:55:13 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i9so12191481ilu.1;
        Mon, 06 Dec 2021 17:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2Fm6dWc0a7+XOgJFn0Wt/EroGCK7h79J9FUWbkFAFU=;
        b=G2HYHzbdjxUJbtEeR3Os3Or3mcq2aUaj1uFlbZcGiz6F7622cW1x3Q1wVyTgnNYc7X
         ivDpHgSXwdzxWpNd3p3nlBbZ2cgyVdQoil1dvKLSPVzmaypwuZe+SRmH0PvId5F1hbcx
         9VfrBh/W+0+vh9vBl4yAC3mBReomcOpvllCxZF9sl1pt1ptJbSU5tLbXQcvdDygQLT1o
         MHbrVDn4qG0RdBT6NNf0yIdwdfpGSBlRLT5rUoK4jauoKxfSPGnqTPqQ9YeKo2AQlZRy
         b8vik5ATTgBMLn8rnxcnDF/qLQSyBpaGoPV08e7FddLiQjjF28havCOhS97YxidFWu/2
         dIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2Fm6dWc0a7+XOgJFn0Wt/EroGCK7h79J9FUWbkFAFU=;
        b=JbDdRD9O//8+s+d3MPoZAnjx0JeFS7+Z5RCaz0P8tAXT96O8iWTK3f/bCxMpvZmi+j
         l4A3w5MD91uAhTPUdFpxjfIgr2EpoO9z2A6ceKdHxlf9OB++xioP5XqIszVccimRRjDx
         DuMKnHhiyXEvdDfh2CYhQIu339WPv3/7KfU6KOyNHNLTkYP9hXehr6zwXXwNkXPP6g4P
         2U4fjmSQoNTYtJEAYppIHe9NSrsyk8TPy48PyP73wf0bftMLdsCSx2ujaKHJkZlOHufz
         RCuiqHLoV3gFGRmKuJuzJXEwpo8z14S4R4BG18pbEU73dt2hgstZ/J4pEyyiMfkgPkf5
         V5iQ==
X-Gm-Message-State: AOAM530GfC1d34luwFV2ajzI/7BF4CKnR1XQpMTyoF+770xqZOgimzTr
        YH/I9p9MqQ4OHeEoE43gSnUHm6VsLuIuzkid
X-Google-Smtp-Source: ABdhPJwFLGfSdq9wLBvEJKWPqQo0SPqabYFCnQeXCrib2XsGTtaB0FmNDVOawUKEl716ZhKkS/S3Kg==
X-Received: by 2002:a05:6e02:c94:: with SMTP id b20mr35622714ile.257.1638842112590;
        Mon, 06 Dec 2021 17:55:12 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6db8:c9e4:6f6d:f38e])
        by smtp.gmail.com with ESMTPSA id j21sm8623639ila.6.2021.12.06.17.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 17:55:11 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     cphealy@gmail.com, benjamin.gaignard@collabora.com,
        hverkuil@xs4all.nl, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [RFC V2 6/6] arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
Date:   Mon,  6 Dec 2021 19:54:45 -0600
Message-Id: <20211207015446.1250854-7-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211207015446.1250854-1-aford173@gmail.com>
References: <20211207015446.1250854-1-aford173@gmail.com>
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

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 972766b67a15..3ed2644bd500 100644
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
+			compatible = "fsl,imx8mq-vpu-blk-ctrl";
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

