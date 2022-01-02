Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286B0482AF5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 12:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiABLyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 06:54:12 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39910
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233000AbiABLyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 06:54:08 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E09B53FFDB
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641124442;
        bh=PYVPvF74SBOWa9/k92S7rpFE0dteEa1FzvINjf+Vn48=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YTrsD/ZHke7KYtYAb/k1YbnRluHfSaHpXOhu7X+x/2BSkwrOulAmrsGCeH0oClgEt
         6OJyE4i0HwREAX8zg2PxbKtziTFmQU47hSEaWWiRDCgFCy71sC8oO4pRTc+eMbcia4
         MOy63fzuniE4y79Mk0mw+Vf2aRPYSlzaHA9rm/gDCtYWcEKjX2AZ8cZHGdOxB0p6WV
         D3hjBK0JJd8mL/ZVtvl/3b8sAWNkmR5+IkZa9Fa1sivLtR5Oz3FuhyTOEXartFSRjZ
         /Y7XqRJDctMpKzbdPOePb0CYekfAM+fFHyy9esg6apcS7uJqVn3gfrIv/IfZjoLERf
         lpoqIotRkqf3g==
Received: by mail-lf1-f69.google.com with SMTP id n7-20020a056512388700b0042a063bb38cso1977711lft.14
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 03:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYVPvF74SBOWa9/k92S7rpFE0dteEa1FzvINjf+Vn48=;
        b=wnvvfUKPWJ+7/bDwDm0o+MEpoJdAfcX+X8MQ0plBvQBHxwv6oSWk3F25c0bRLQ87C2
         y0GjP4Zv7H+wSSupMJC8UAAtBAY5GpFTkFAHk23frdymWyiXX+tSnx3F+WmskgQX3VmN
         nK60kKUX1NYriVLvQ0SReFxsPLUmEnL0fRftXGZu4oYyI5gionpluGSq9otJzE+eOJVr
         hmWnFiSvoQhTKb1GaWQ50sKoiu0SLOroUaawZCJu0aiDVmPqjamzlqD7A1cheIQYjzRV
         4BPpvRIVsSR1PLQUTflWAypIpBt1iszgC8TzJRb6OvdeF6vuAI3hzo6iKidB4kmmxY4p
         wMag==
X-Gm-Message-State: AOAM531+BNSFCqm61Kv3p1C9NbzI8D51IRqX6K5v8VRghUy4+8in70yC
        XDJ7ee5hBXshgQsIaAuLPgLzDoP+yV7RbioBX/d+v7e9livvDRcywvhBfrsqeIarh7RDyUE/EU1
        bi4BVxPl6u4tAgMKcM1xM5lARGMBi/fPWN5s55vsH8g==
X-Received: by 2002:a05:6512:2305:: with SMTP id o5mr37998519lfu.564.1641124442034;
        Sun, 02 Jan 2022 03:54:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkbntghZTvhtOFsV3NRi7zM2S6Qwme5B8dsNVqtjEkVoqNAWLZ6h5gWbJHITN8oagYoXcFxw==
X-Received: by 2002:a05:6512:2305:: with SMTP id o5mr37998513lfu.564.1641124441849;
        Sun, 02 Jan 2022 03:54:01 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l2sm2368014lja.51.2022.01.02.03.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 03:54:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] ARM: dts: exynos: add necessary clock controller inputs in Exynos5260
Date:   Sun,  2 Jan 2022 12:53:50 +0100
Message-Id: <20220102115356.75796-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos5260 bindings require to feed clock controllers with certain clock
inputs.  The IO clocks are expected to be provided by the board.  The
PHY clocks are usually followed by mux which can choose between the PHY
clock and main 24 MHz oscillator, so skip defining them and just use the
latter one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5260-xyref5260.dts |  21 ++++
 arch/arm/boot/dts/exynos5260.dtsi          | 128 +++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 0dc2ec16aa0a..c404fdb0fe19 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -29,6 +29,27 @@ fin_pll: xxti {
 		#clock-cells = <0>;
 	};
 
+	ioclk_pcm: clock-pcm-ext {
+		compatible = "fixed-clock";
+		clock-frequency = <2048000>;
+		clock-output-names = "ioclk_pcm_extclk";
+		#clock-cells = <0>;
+	};
+
+	ioclk_i2s: clock-i2s-cd {
+		compatible = "fixed-clock";
+		clock-frequency = <147456000>;
+		clock-output-names = "ioclk_i2s_cdclk";
+		#clock-cells = <0>;
+	};
+
+	ioclk_spdif: clock-spdif-ext {
+		compatible = "fixed-clock";
+		clock-frequency = <49152000>;
+		clock-output-names = "ioclk_spdif_extclk";
+		#clock-cells = <0>;
+	};
+
 	xrtcxti: xrtcxti {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 524d244050e0..56271e7c4587 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -113,78 +113,206 @@ clock_top: clock-controller@10010000 {
 			compatible = "samsung,exynos5260-clock-top";
 			reg = <0x10010000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&clock_mif MIF_DOUT_MEM_PLL>,
+				 <&clock_mif MIF_DOUT_BUS_PLL>,
+				 <&clock_mif MIF_DOUT_MEDIA_PLL>;
+			clock-names = "fin_pll",
+				      "dout_mem_pll",
+				      "dout_bus_pll",
+				      "dout_media_pll";
 		};
 
 		clock_peri: clock-controller@10200000 {
 			compatible = "samsung,exynos5260-clock-peri";
 			reg = <0x10200000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&ioclk_pcm>,
+				 <&ioclk_i2s>,
+				 <&ioclk_spdif>,
+				 <&fin_pll>,
+				 <&clock_top TOP_DOUT_ACLK_PERI_66>,
+				 <&clock_top TOP_DOUT_SCLK_PERI_UART0>,
+				 <&clock_top TOP_DOUT_SCLK_PERI_UART1>,
+				 <&clock_top TOP_DOUT_SCLK_PERI_UART2>,
+				 <&clock_top TOP_DOUT_SCLK_PERI_SPI0_B>,
+				 <&clock_top TOP_DOUT_SCLK_PERI_SPI1_B>,
+				 <&clock_top TOP_DOUT_SCLK_PERI_SPI2_B>,
+				 <&clock_top TOP_DOUT_ACLK_PERI_AUD>;
+			clock-names = "fin_pll",
+				      "ioclk_pcm_extclk",
+				      "ioclk_i2s_cdclk",
+				      "ioclk_spdif_extclk",
+				      "phyclk_hdmi_phy_ref_cko",
+				      "dout_aclk_peri_66",
+				      "dout_sclk_peri_uart0",
+				      "dout_sclk_peri_uart1",
+				      "dout_sclk_peri_uart2",
+				      "dout_sclk_peri_spi0_b",
+				      "dout_sclk_peri_spi1_b",
+				      "dout_sclk_peri_spi2_b",
+				      "dout_aclk_peri_aud";
 		};
 
 		clock_egl: clock-controller@10600000 {
 			compatible = "samsung,exynos5260-clock-egl";
 			reg = <0x10600000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&clock_mif MIF_DOUT_BUS_PLL>;
+			clock-names = "fin_pll",
+				      "dout_bus_pll";
 		};
 
 		clock_kfc: clock-controller@10700000 {
 			compatible = "samsung,exynos5260-clock-kfc";
 			reg = <0x10700000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&clock_mif MIF_DOUT_MEDIA_PLL>;
+			clock-names = "fin_pll",
+				      "dout_media_pll";
 		};
 
 		clock_g2d: clock-controller@10a00000 {
 			compatible = "samsung,exynos5260-clock-g2d";
 			reg = <0x10A00000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&clock_top TOP_DOUT_ACLK_G2D_333>;
+			clock-names = "fin_pll",
+				      "dout_aclk_g2d_333";
 		};
 
 		clock_mif: clock-controller@10ce0000 {
 			compatible = "samsung,exynos5260-clock-mif";
 			reg = <0x10CE0000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>;
+			clock-names = "fin_pll";
 		};
 
 		clock_mfc: clock-controller@11090000 {
 			compatible = "samsung,exynos5260-clock-mfc";
 			reg = <0x11090000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&clock_top TOP_DOUT_ACLK_MFC_333>;
+			clock-names = "fin_pll",
+				      "dout_aclk_mfc_333";
 		};
 
 		clock_g3d: clock-controller@11830000 {
 			compatible = "samsung,exynos5260-clock-g3d";
 			reg = <0x11830000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>;
+			clock-names = "fin_pll";
 		};
 
 		clock_fsys: clock-controller@122e0000 {
 			compatible = "samsung,exynos5260-clock-fsys";
 			reg = <0x122E0000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&clock_top TOP_DOUT_ACLK_FSYS_200>;
+			clock-names = "fin_pll",
+				      "phyclk_usbhost20_phy_phyclock",
+				      "phyclk_usbhost20_phy_freeclk",
+				      "phyclk_usbhost20_phy_clk48mohci",
+				      "phyclk_usbdrd30_udrd30_pipe_pclk",
+				      "phyclk_usbdrd30_udrd30_phyclock",
+				      "dout_aclk_fsys_200";
 		};
 
 		clock_aud: clock-controller@128c0000 {
 			compatible = "samsung,exynos5260-clock-aud";
 			reg = <0x128C0000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&clock_top TOP_FOUT_AUD_PLL>,
+				 <&ioclk_i2s>,
+				 <&ioclk_pcm>;
+			clock-names = "fin_pll",
+				      "fout_aud_pll",
+				      "ioclk_i2s_cdclk",
+				      "ioclk_pcm_extclk";
 		};
 
 		clock_isp: clock-controller@133c0000 {
 			compatible = "samsung,exynos5260-clock-isp";
 			reg = <0x133C0000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&clock_top TOP_DOUT_ACLK_ISP1_266>,
+				 <&clock_top TOP_DOUT_ACLK_ISP1_400>,
+				 <&clock_top TOP_MOUT_ACLK_ISP1_266>;
+			clock-names = "fin_pll",
+				      "dout_aclk_isp1_266",
+				      "dout_aclk_isp1_400",
+				      "mout_aclk_isp1_266";
 		};
 
 		clock_gscl: clock-controller@13f00000 {
 			compatible = "samsung,exynos5260-clock-gscl";
 			reg = <0x13F00000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&clock_top TOP_DOUT_ACLK_GSCL_400>,
+				 <&clock_top TOP_DOUT_ACLK_GSCL_333>;
+			clock-names = "fin_pll",
+				      "dout_aclk_gscl_400",
+				      "dout_aclk_gscl_333";
 		};
 
 		clock_disp: clock-controller@14550000 {
 			compatible = "samsung,exynos5260-clock-disp";
 			reg = <0x14550000 0x10000>;
 			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&fin_pll>,
+				 <&ioclk_spdif>,
+				 <&clock_top TOP_DOUT_ACLK_PERI_AUD>,
+				 <&clock_top TOP_DOUT_ACLK_DISP_222>,
+				 <&clock_top TOP_DOUT_SCLK_DISP_PIXEL>,
+				 <&clock_top TOP_DOUT_ACLK_DISP_333>;
+			clock-names = "fin_pll",
+				      "phyclk_dptx_phy_ch3_txd_clk",
+				      "phyclk_dptx_phy_ch2_txd_clk",
+				      "phyclk_dptx_phy_ch1_txd_clk",
+				      "phyclk_dptx_phy_ch0_txd_clk",
+				      "phyclk_hdmi_phy_tmds_clko",
+				      "phyclk_hdmi_phy_ref_clko",
+				      "phyclk_hdmi_phy_pixel_clko",
+				      "phyclk_hdmi_link_o_tmds_clkhi",
+				      "phyclk_mipi_dphy_4l_m_txbyte_clkhs",
+				      "phyclk_dptx_phy_o_ref_clk_24m",
+				      "phyclk_dptx_phy_clk_div2",
+				      "phyclk_mipi_dphy_4l_m_rxclkesc0",
+				      "phyclk_hdmi_phy_ref_cko",
+				      "ioclk_spdif_extclk",
+				      "dout_aclk_peri_aud",
+				      "dout_aclk_disp_222",
+				      "dout_sclk_disp_pixel",
+				      "dout_aclk_disp_333";
 		};
 
 		gic: interrupt-controller@10481000 {
-- 
2.32.0

