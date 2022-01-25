Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9749BA11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587473AbiAYRRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351081AbiAYRNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:48 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E059C061798;
        Tue, 25 Jan 2022 09:12:41 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z199so9995184iof.10;
        Tue, 25 Jan 2022 09:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Fgh1nk6bqmgjEB35c+6+OTIRLm49vWerHy0VwTjFfA=;
        b=JRv3J1nreHukF3sNMoJlxNtHRLd1VrLRYGu3QGs2B51RS4vU6NKGLOZSyaG9u1B2La
         BYvhmp5VkBkY6HcjUPbTp337Q2sWf6iITu73IzEcN0pwa7CYn/wzCleFcdzgwFUQhOgZ
         rtF82CCF5jfI5+041yUIiY1OS5D/zVccINyD/8CfRtixC3sk2UGjbss6+JO2FTL0MWxZ
         mFVE7zxJkMCsxKNjAu/4gaVuwAFzho6CA50ybHKaw/jq66LGdzBjBl/xDKax4fi/UPul
         twmRZAPG+w1ncVjECHsevFW3qeknE/l/eQAzQkAJXJZ3rpIjR95N0KCI6klHZefED0fC
         ifyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Fgh1nk6bqmgjEB35c+6+OTIRLm49vWerHy0VwTjFfA=;
        b=vxmODQwLu5TOnj6HycGK/c76Ic2zhAOgSLr63p8Q9FaLNZ0zd5etfjrhh2CnOx7H0v
         18t9qCLQkc677ylwOgP5uqTlm0B2ln/I9gl3su/koCWu1aSjXB4ksXM+FaU1i08PfJ9Z
         LuHakbGQt5Y2KzwA5Ewa6ZeoIMbz7WiFGVUjqs7aJyibYHa3PtFb4Sml4LxVOwchunhq
         vaCtRmhAsFQldIoQV0gQtnpeKt3v9jCzzIg+jdySyY8qKMkgqlqboyYmo5DsfIT4+LoQ
         Ce+Juhu4Cm+j6+Og2xtT6U4JIxuMUrIPy0Kfjc5VoJNsDCTLyzDu5/u1YqnvZdW1K6UA
         fALA==
X-Gm-Message-State: AOAM531eUHJKYPWjPlLZB8bKGtDyuUPUEZ/O3fJjewXbifhXLmbz5EXp
        /tUaxCiAXT6xcW83XlLmiCsmY2KsBtE=
X-Google-Smtp-Source: ABdhPJw2f9fHugzpGy8WQ5VRzztIY7SoE7JffPhzvR/nASXAOulv8gkOea4PmFQklaw2/mig6Imtqw==
X-Received: by 2002:a02:7758:: with SMTP id g85mr4991280jac.125.1643130760248;
        Tue, 25 Jan 2022 09:12:40 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:39 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Adam Ford <aford173@gmail.com>,
        kernel test robot <lkp@intel.com>,
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
Subject: [PATCH V4 07/11] arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl
Date:   Tue, 25 Jan 2022 11:11:24 -0600
Message-Id: <20220125171129.472775-8-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125171129.472775-1-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Hantro G1 and G2 now setup to run independently, update
the device tree to allow both to operate.  This requires the
vpu-blk-ctrl node to be configured.  Since vpu-blk-ctrl needs
certain clock enabled to handle the gating of the G1 and G2
fuses, the clock-parents and clock-rates for the various VPU's
to be moved into the pgc_vpu because they cannot get re-parented
once enabled, and the pgc_vpu is the highest in the chain.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 2df2510d0118..549b2440f55d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -737,7 +737,21 @@ pgc_gpu: power-domain@5 {
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
@@ -1457,30 +1471,31 @@ usb3_phy1: usb-phy@382f0040 {
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
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
+			power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
+		};
+
+		vpu_g2: video-codec@38310000 {
+			compatible = "nxp,imx8mq-vpu-g2";
+			reg = <0x38310000 0x10000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
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

