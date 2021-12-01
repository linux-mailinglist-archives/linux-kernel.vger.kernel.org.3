Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0446448D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbhLABhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbhLABhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:37:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288F2C061756;
        Tue, 30 Nov 2021 17:33:43 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z18so28700325iof.5;
        Tue, 30 Nov 2021 17:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ap+Y2Tz8z5LcHzGO6SA2tif2EyiHYR6r3DF4Am/aoA=;
        b=OcbXRHDXrnBr8kivgFa/eyWQC8wj9OddkBPOFLlJP2uV0U47aHQn6gbTwG3IPOQM+3
         4IDeyBU8fV9k6Mw8DW+7GMii65R3Ud6uJGKaM5sFDo8e5VOy/JsP1+FnSOidK+nrwbJA
         +c6l1vZUjTDiaxHNCNh8Ix7WCaDA4EjTXaGRuTOb8RHT2q5x/jF5hKD4QTYgaHCYYDBJ
         4lqpVh3AdxNri9cq5zbgwLUKnAcHJsT0bnBqV4YcvvkbHsL+Slq0eT4zfjXk1latB2ir
         UZ9s+8Eh9J6f9I9oD5ruIY/EVu9CDQwKeJ1Gzj5wx4jwk5rtlKCeuTT+W/36K9mXC1/y
         kV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ap+Y2Tz8z5LcHzGO6SA2tif2EyiHYR6r3DF4Am/aoA=;
        b=Jyxu0nI7KQbPo6jh46Zz/yem+HXNrB8QToS4wt30NrpEIRciX5QESdehY66vDGQo/3
         tNsCAk1eB4FmpwtJkAjmBeVzq07bcKt9aL4LF+LDoifA5ZqPw679gTa0dDKs+KOHDBhd
         65zwt8RQqQ7+w+By2qINy/242K6629icYpHE28euNHLdIcG0SpnqBTAU8z93zisHJwqv
         VC/dAPWK3656JkuhwvhK6Q4ZmqO98orIP5iC7/+L/kzaI1ENKiIHWDuycp2Fk6vPc2KV
         nG+K6X3y9ScrwsXKXjg/wzbOEl5BJPjyWXj71Fpqxl2rY8BWykvnWI9qmF3rq3ZTn2+z
         It+A==
X-Gm-Message-State: AOAM532twnrh+mD+D+ZOamzRw7evJcjbEmnTIur5e/w8q+HEnAIJDqAu
        SZOHBZ6JLadphNMPqyaAj5aTjFYCWYwu+Bkc
X-Google-Smtp-Source: ABdhPJws3i9Y5kHYiQGhopk7urQguB9dlP7kNjGUVEgv5jDp6giKcZ6fFE4/yqGZACC+0c8Xw/Wdcg==
X-Received: by 2002:a02:9f87:: with SMTP id a7mr5568738jam.136.1638322422135;
        Tue, 30 Nov 2021 17:33:42 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:b7ee:f768:f33c:c028])
        by smtp.gmail.com with ESMTPSA id u24sm11856737ior.20.2021.11.30.17.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 17:33:41 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, hverkuil@xs4all.nl,
        tharvey@gateworks.com, nicolas@ndufresne.ca,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [RFC V2 2/2] arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
Date:   Tue, 30 Nov 2021 19:33:29 -0600
Message-Id: <20211201013329.15875-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201013329.15875-1-aford173@gmail.com>
References: <20211201013329.15875-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable two hardware Hantro decoders called G1 and G2.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..eb9dcd9d1a31 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1197,6 +1197,47 @@ gpu_2d: gpu@38008000 {
 			power-domains = <&pgc_gpu>;
 		};
 
+		vpu_g1: video-codec@38300000 {
+			compatible = "nxp,imx8mm-vpu";
+			reg = <0x38300000 0x10000>;
+			reg-names = "g1";
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g1";
+			clocks = <&clk IMX8MM_CLK_VPU_G1_ROOT>,
+				 <&clk IMX8MM_CLK_VPU_DEC_ROOT>;
+			clock-names = "g1", "bus";
+			assigned-clocks = <&clk IMX8MM_CLK_VPU_G1>,
+					  <&clk IMX8MM_CLK_VPU_BUS>,
+					  <&clk IMX8MM_VPU_PLL_BYPASS>;
+			assigned-clock-parents = <&clk IMX8MM_VPU_PLL_OUT>,
+						 <&clk IMX8MM_SYS_PLL1_800M>,
+						 <&clk IMX8MM_VPU_PLL>;
+			assigned-clock-rates = <600000000>,
+					       <800000000>,
+					       <0>;
+			power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G1>;
+		};
+
+		vpu_g2: video-codec@38310000 {
+			compatible = "nxp,imx8mm-vpu-g2";
+			reg = <0x38310000 0x10000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g2";
+			clocks = <&clk IMX8MM_CLK_VPU_G2_ROOT>,
+				 <&clk IMX8MM_CLK_VPU_DEC_ROOT>;
+			clock-names = "g2",  "bus";
+			assigned-clocks = <&clk IMX8MM_CLK_VPU_G2>,
+					 <&clk IMX8MM_CLK_VPU_BUS>,
+					 <&clk IMX8MM_VPU_PLL_BYPASS>;
+			assigned-clock-parents = <&clk IMX8MM_VPU_PLL_OUT>,
+						<&clk IMX8MM_SYS_PLL1_800M>,
+						<&clk IMX8MM_VPU_PLL>;
+			assigned-clock-rates = <600000000>,
+					       <800000000>,
+					       <0>;
+			power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G2>;
+		};
+
 		vpu_blk_ctrl: blk-ctrl@38330000 {
 			compatible = "fsl,imx8mm-vpu-blk-ctrl", "syscon";
 			reg = <0x38330000 0x100>;
-- 
2.32.0

