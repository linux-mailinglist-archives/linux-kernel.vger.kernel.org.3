Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D90497762
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbiAXCcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbiAXCb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:56 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82595C06173D;
        Sun, 23 Jan 2022 18:31:56 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id a18so12641262ilq.6;
        Sun, 23 Jan 2022 18:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2uTm/BD2isTXWldGmoljdaacGOnVbR7Md5p5huP0LI=;
        b=JmMDFkLadGqdIsUwAjemoOsUPgfceF0iUcKiswWmYTYrcE7n0bzZ/Z9tSNY6D4fDNQ
         1EMCefN6u0VGCDqVHP2IOJs1hE9fFQ4rNuAeXJ29WNvjoqXy6kmpG1TCMyeZmfjzxRKJ
         D3bJNlPPVwj0wkSUjvE2mmI9W2Z6z95kj6RDHnof2xAGvib4QIKv6Dx6XoApeBSPV83w
         pjaiQNuTC1XxpSi7nzZjmvrznr3JCej2YCoZq2ZXAjWGdEGwB0IceLrTDTZaSI60Rovj
         nU/dqrFpv6d3mx8SguU5ITyk2raZu5ROKJxC6pM6/QPVlGXU3qRyfyfzG+Y9BFJvTN3x
         FNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2uTm/BD2isTXWldGmoljdaacGOnVbR7Md5p5huP0LI=;
        b=31z8MEAYR8JmyBExv+HyEtQTBW2+kN0DRZ7fPjTQecU1uJE4aAoeIdqrzAPkqxcFe4
         lrK4boMYsBDRDzbHIoc5zmwLi3XEnZLaf0zVOmusDXf0XzYmnm4wfmZl6/Ha8vuyEx5K
         i89tOf39mpWkJf3W3Xn96oaL4kzgh3GH9T0PKhewQk0XQlKA1055D62ahd/MOgwvgjr8
         zEGXY+6nIFQEK616eSblpL6l9+vyPTWT2dlxZ0GvYZ9LMkSFjzfF5JmL66ATwqqZiMZc
         tMekLyqohUuoIVgA6p50dwSKkRB4JslB5nlzyAeRnK+ZEmMqsTTGKiVjR0XoAPPUEJs4
         LoAg==
X-Gm-Message-State: AOAM530ICuaAem5agUuVcbGqF87GGG+/yqEP4pj61W2XISZBP7QYKHmt
        MNhotqBcfgOoyWSgUBYFU8EL7/xTuRU=
X-Google-Smtp-Source: ABdhPJzKUaRunuyBFbmDoIVKwmFF8W+zvBreaT8xlFp7AUwcmOghFLRUo5hbPrelnPoJRUglaPqf3g==
X-Received: by 2002:a92:b10:: with SMTP id b16mr7624374ilf.187.1642991515536;
        Sun, 23 Jan 2022 18:31:55 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:54 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 10/10] arm64: dts: imx8mm: Enable Hantro G1 and G2 video decoders
Date:   Sun, 23 Jan 2022 20:31:24 -0600
Message-Id: <20220124023125.414794-11-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124023125.414794-1-aford173@gmail.com>
References: <20220124023125.414794-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two decoders on the i.MX8M Mini controlled by the
vpu-blk-ctrl.  The G1 supports H264 and VP8 while the
G2 support HEVC and VP9.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 0c7a72c51a31..98aec4421713 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1272,6 +1272,22 @@ gpu_2d: gpu@38008000 {
 			power-domains = <&pgc_gpu>;
 		};
 
+		vpu_g1: video-codec@38300000 {
+			compatible = "nxp,imx8mm-vpu-g1";
+			reg = <0x38300000 0x10000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MM_CLK_VPU_G1_ROOT>;
+			power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G1>;
+		};
+
+		vpu_g2: video-codec@38310000 {
+			compatible = "nxp,imx8mq-vpu-g2";
+			reg = <0x38310000 0x10000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MM_CLK_VPU_G2_ROOT>;
+			power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G2>;
+		};
+
 		vpu_blk_ctrl: blk-ctrl@38330000 {
 			compatible = "fsl,imx8mm-vpu-blk-ctrl", "syscon";
 			reg = <0x38330000 0x100>;
@@ -1282,6 +1298,12 @@ vpu_blk_ctrl: blk-ctrl@38330000 {
 				 <&clk IMX8MM_CLK_VPU_G2_ROOT>,
 				 <&clk IMX8MM_CLK_VPU_H1_ROOT>;
 			clock-names = "g1", "g2", "h1";
+			assigned-clocks = <&clk IMX8MM_CLK_VPU_G1>,
+					  <&clk IMX8MM_CLK_VPU_G2>;
+			assigned-clock-parents = <&clk IMX8MM_VPU_PLL_OUT>,
+						 <&clk IMX8MM_VPU_PLL_OUT>;
+			assigned-clock-rates = <600000000>,
+					       <600000000>;
 			#power-domain-cells = <1>;
 		};
 
-- 
2.32.0

