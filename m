Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902F949BA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587722AbiAYRTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381178AbiAYRO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:14:29 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA7DC0617A8;
        Tue, 25 Jan 2022 09:12:52 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h7so6547462iof.3;
        Tue, 25 Jan 2022 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erjBKsHCbTFn1bNJZRE4/B4FWXxROM3zXPT4j5v41B0=;
        b=Qvc/4Q8LAUUm6mig1v7jRED7ZQR+Lmj876e5fQ7onKxHmsRvWUSdwQUaOqTJRlXL4J
         k0XAmAX926nfOedOT/dC9YXrqDhvYDcqkMqOkCr+EBQhSvjp+7utIdItkhsymSBgGBj8
         +q8K0QYu3ym9kjcFN3rWZ1H//vX7xk4wmpoM6KQvluqevX/ERkspc2VtnsvTLAhC3PFT
         eKIKqKTqKhmbAME3LYLBLQIi9D1SQl6NeUEeXCi8jm5wSXcXo/ZzjK43M/+KSDjEtqcV
         cG5wnNEv85Zd4Sv2/VVm/lPVWdDYF0gB4nbmuPRDShjS0j1ABaPWUKWHJQ1tZKxFNCT0
         3RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erjBKsHCbTFn1bNJZRE4/B4FWXxROM3zXPT4j5v41B0=;
        b=wF6TOZxAPq+f18vKLY0QS+jk2rRrQmDydT9EAb2dmzHnfj9PzJ6Z6f9HYvDXlDXU3Q
         AUh4tma3t2dR+TNNhgzUrYG2iU7nwIurcB23/Yz0BIfWqL9ojenArHGzmpw99C0FA8gO
         6yNSk9nJOYhm4OJTrrMLQNMK5yLvBqSuBlUAnJ4FQGvWKppAbYHX6bGyBLCmkLvbJgGT
         WKt/YcBDY44qusGj4SnAw7FFbXt3rY0clXxoLtoCHh4MH8xoJCf0HzVsOlg+G6Xu6Ovm
         uw0XJFjCwH3HOm4D+BgSoxVUwlrWReAYkAIyFzYxO5Mezv16210Ubu5RLz1xG8kwYLz/
         8iKQ==
X-Gm-Message-State: AOAM532lcIE8vCRbNVwQl0bOMwOY7Oja+Co8HC9lbShcHBLLG4PlCr93
        66v74+R5tuY62yhCDERega63lCdfTK0=
X-Google-Smtp-Source: ABdhPJwxZsBDj2g3gLA6p81rwxeZuPJpTDfsA/04BwXCKVHwGCrrRTsOIci3D55WHnEYjBtoZpqRzA==
X-Received: by 2002:a05:6638:32a5:: with SMTP id f37mr9733167jav.208.1643130771042;
        Tue, 25 Jan 2022 09:12:51 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:50 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Adam Ford <aford173@gmail.com>,
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
Subject: [PATCH V4 11/11] arm64: dts: imx8mm: Enable Hantro G1 and G2 video decoders
Date:   Tue, 25 Jan 2022 11:11:28 -0600
Message-Id: <20220125171129.472775-12-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125171129.472775-1-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two decoders on the i.MX8M Mini controlled by the
vpu-blk-ctrl.  The G1 supports H264 and VP8 while the
G2 support HEVC and VP9.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

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

