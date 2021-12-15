Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E49474F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbhLOArA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbhLOAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DA0C061401;
        Tue, 14 Dec 2021 16:46:56 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y16so27349211ioc.8;
        Tue, 14 Dec 2021 16:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/jPY1taqvGfMrM5igJehLmGlv0TGkcErVZ/x91LIcA=;
        b=LVNigSxqvXMb5ea98oWfUtlyTRKBSfFtaCfWpL5Yppw08cuNlJyjs21PRG6Cd+TR4k
         jH/1obhyWG4Dvu7EwnRY3CniMcYfK9bWZ8kH9B+fHNE929HVq9Su+QnOzr2g6o85tliJ
         OU81dQN2hP4lUKYLzs7FfLEH+XBG5wkO5w9w6kwvwh7SBeelaVINaNEn1MqFtnaaqbwv
         Nt1TpqfQwB/5OCrDARlHoykRcJ9Kpd3DFibuYZkS/xCpbsskClJQqj3ppU30uakCitVK
         urW+y8aYGRfxLHAuJWSHdsQnp0YNlbKCborFYHtp0CgHJn64UnQv9c08dEc3WQmMZhMC
         n+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/jPY1taqvGfMrM5igJehLmGlv0TGkcErVZ/x91LIcA=;
        b=7IQiQsazhNl8tpxRS9F2/TP+FrT0sZUQedZEJdv7sZmYQsAYnEk78JCc3U/wK8/QAZ
         ByLhgSXj2Ls6EvDGKnKmIijVg9zVUyO3Hh3MX2QDkLK3ZxAEuIXVM40dLoGqVdeHCkJq
         P46VrGgAQdxQr+gxW9oPMx78+5Mn8pJ5uC+U9g2w3nXScVIDP1pwt7UktuLLpp/ojmHG
         TwU0PMDJm0p+r3CUV8hhp3KRhMibDcrnufP+9DwebsxhjI0NpB7vJTAHHtAIrfNN8r8l
         R6Ry8MYzRBc40j1fVA9cv93TBgkxZEuUfmIQJ2wd6SMPgSSsz7UJKA3M4JWg1AEvMHCv
         JZyg==
X-Gm-Message-State: AOAM530yLjTHCS4cYaPNZQ2S75lbIH0YitLLdqQwBmy5mrG960/ikaVd
        VonsyR3maDEc3Zy9ffWFygEZa6Mxv3G/hQ==
X-Google-Smtp-Source: ABdhPJxv4QvpvdqzrzDrKp2rFq5JL6GNUY4iVnVQURug1hLmLEKrXQdrqujrqrcRmkBKGPdQoW8xdg==
X-Received: by 2002:a02:704c:: with SMTP id f73mr4592747jac.633.1639529215785;
        Tue, 14 Dec 2021 16:46:55 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:55 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 9/9] arm64: dts: imx8mn: Enable GPU
Date:   Tue, 14 Dec 2021 18:46:26 -0600
Message-Id: <20211215004626.2241839-10-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M-Nano features a GC7000. The Etnaviv driver detects it as:

    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index dc3f66d284e5..99f0f5026674 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1116,6 +1116,32 @@ gpmi: nand-controller@33002000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@38000000 {
+			compatible = "vivante,gc";
+			reg = <0x38000000 0x8000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
+				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+				<&clk IMX8MN_CLK_GPU_SHADER>;
+			clock-names = "reg", "bus", "core", "shader";
+			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE>,
+					  <&clk IMX8MN_CLK_GPU_SHADER>,
+					  <&clk IMX8MN_CLK_GPU_AXI>,
+					  <&clk IMX8MN_CLK_GPU_AHB>,
+					  <&clk IMX8MN_GPU_PLL>;
+			assigned-clock-parents = <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_SYS_PLL1_800M>,
+						  <&clk IMX8MN_SYS_PLL1_800M>;
+			assigned-clock-rates = <400000000>,
+					       <400000000>,
+					       <800000000>,
+					       <400000000>,
+					       <1200000000>;
+			power-domains = <&pgc_gpumix>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
-- 
2.32.0

