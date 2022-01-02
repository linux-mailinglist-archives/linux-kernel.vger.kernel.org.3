Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64BC482AEC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiABLyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 06:54:14 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39918
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232992AbiABLyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 06:54:08 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 74ECF402E1
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 11:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641124444;
        bh=GLucnQoVmCjvNl/S0Fq7Tqg4p+UN45ngVPp3CxahAeA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fjiKG+yo1aOZzbfn1uS1uv/V5GPwfdZBvUsCuiUpjkXKT94qXSOHtSg2kL6hHco8e
         ryzEG5Gs/KNXyTGMKeUMWMwxJRbViNWzlWy1xHBJH07GipqZL9oi0++RGhUYBL9ASY
         u/SGGW+7iQA3H0mq88PwCyTkCQNfHMBpX8n1RHWb0r1ZD/Oc9sXYMwv2hdhcp6sn3w
         EYRKVS7ECvCIUGffWFe77AlBlztuowPKznrxK4pLl3VaDSXXXJtnKs705ppJ3G/w3n
         6pO+pI0O8MHPFHq7crKMB8jBXUunVIugWh4o2fGnxLx0ti7p2EEF8hzzh6nIi5znQW
         YNslmsV5+oZHA==
Received: by mail-lf1-f69.google.com with SMTP id m8-20020a0565120a8800b00425edb1a456so5765635lfu.16
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 03:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLucnQoVmCjvNl/S0Fq7Tqg4p+UN45ngVPp3CxahAeA=;
        b=DXYmuaKCLumle0dvT2VxPCM98aaT8Y7Om6txlZ6+xCgXqY9Uhd5UOqyknTokhBu2Wx
         279vqNTUrzAoV2Rv5oxeVKVkL/SlWkJirJxemm5cpYhKX9l6HCuj+YnioniHrcFSXIIv
         ldKAsoWbF24WuCMcH3GipGEfLwmH2mbeWQ+T5knjogB2mZDn32iF0PvsVvxMIvxk2w5x
         I6719z0DXdHkfBNenCCugMbygW8sCWIMz5/4ko5W9IPsjp+GfxyTyVIyFr/sNqzuFPRG
         h78saAjj1Cx4THxnV8GNOhlimPqz3JR2K97GwnI36jSvEJmqaH3LoF2fBtAHbdcPcXJj
         9tvA==
X-Gm-Message-State: AOAM531Va0+EOKF/YwdJBRlvaH6TX4JQEFiTTIC1NSzsE9PtVV+9nqhZ
        Ug2y/fmG8oTwLloBQMcuk7nHTm2YMfz3wx/rK1f3ChZI1Lz/SaH+EhgZnggq/oe4FCLMedCiBtE
        5jIAapPlVL0PVW1uwCNYvyV6skiVZgA8PgAfrk6irmg==
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr2076290lfr.570.1641124443439;
        Sun, 02 Jan 2022 03:54:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/AeJ3ms8UKlEGPR66Xi8BRT7BUpc65Emh7Q57mWlD0w+ev1F5XRgpcdd+KRtHZSBOzN8yHw==
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr2076271lfr.570.1641124443120;
        Sun, 02 Jan 2022 03:54:03 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l2sm2368014lja.51.2022.01.02.03.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 03:54:02 -0800 (PST)
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
Subject: [PATCH 3/8] dt-bindings: clock: samsung: convert Exynos5433 to dtschema
Date:   Sun,  2 Jan 2022 12:53:51 +0100
Message-Id: <20220102115356.75796-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos5433 SoC clock controller bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/exynos5433-clock.txt       | 507 -----------------
 .../clock/samsung,exynos5433-clock.yaml       | 524 ++++++++++++++++++
 2 files changed, 524 insertions(+), 507 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5433-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
deleted file mode 100644
index 183c327a7d6b..000000000000
--- a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
+++ /dev/null
@@ -1,507 +0,0 @@
-* Samsung Exynos5433 CMU (Clock Management Units)
-
-The Exynos5433 clock controller generates and supplies clock to various
-controllers within the Exynos5433 SoC.
-
-Required Properties:
-
-- compatible: should be one of the following.
-  - "samsung,exynos5433-cmu-top"   - clock controller compatible for CMU_TOP
-    which generates clocks for IMEM/FSYS/G3D/GSCL/HEVC/MSCL/G2D/MFC/PERIC/PERIS
-    domains and bus clocks.
-  - "samsung,exynos5433-cmu-cpif"  - clock controller compatible for CMU_CPIF
-    which generates clocks for LLI (Low Latency Interface) IP.
-  - "samsung,exynos5433-cmu-mif"   - clock controller compatible for CMU_MIF
-    which generates clocks for DRAM Memory Controller domain.
-  - "samsung,exynos5433-cmu-peric" - clock controller compatible for CMU_PERIC
-    which generates clocks for UART/I2C/SPI/I2S/PCM/SPDIF/PWM/SLIMBUS IPs.
-  - "samsung,exynos5433-cmu-peris" - clock controller compatible for CMU_PERIS
-    which generates clocks for PMU/TMU/MCT/WDT/RTC/SECKEY/TZPC IPs.
-  - "samsung,exynos5433-cmu-fsys"  - clock controller compatible for CMU_FSYS
-    which generates clocks for USB/UFS/SDMMC/TSI/PDMA IPs.
-  - "samsung,exynos5433-cmu-g2d"   - clock controller compatible for CMU_G2D
-    which generates clocks for G2D/MDMA IPs.
-  - "samsung,exynos5433-cmu-disp"  - clock controller compatible for CMU_DISP
-    which generates clocks for Display (DECON/HDMI/DSIM/MIXER) IPs.
-  - "samsung,exynos5433-cmu-aud"   - clock controller compatible for CMU_AUD
-    which generates clocks for Cortex-A5/BUS/AUDIO clocks.
-  - "samsung,exynos5433-cmu-bus0", "samsung,exynos5433-cmu-bus1"
-    and "samsung,exynos5433-cmu-bus2" - clock controller compatible for CMU_BUS
-    which generates global data buses clock and global peripheral buses clock.
-  - "samsung,exynos5433-cmu-g3d"  - clock controller compatible for CMU_G3D
-    which generates clocks for 3D Graphics Engine IP.
-  - "samsung,exynos5433-cmu-gscl"  - clock controller compatible for CMU_GSCL
-    which generates clocks for GSCALER IPs.
-  - "samsung,exynos5433-cmu-apollo"- clock controller compatible for CMU_APOLLO
-    which generates clocks for Cortex-A53 Quad-core processor.
-  - "samsung,exynos5433-cmu-atlas" - clock controller compatible for CMU_ATLAS
-    which generates clocks for Cortex-A57 Quad-core processor, CoreSight and
-    L2 cache controller.
-  - "samsung,exynos5433-cmu-mscl" - clock controller compatible for CMU_MSCL
-    which generates clocks for M2M (Memory to Memory) scaler and JPEG IPs.
-  - "samsung,exynos5433-cmu-mfc"  - clock controller compatible for CMU_MFC
-    which generates clocks for MFC(Multi-Format Codec) IP.
-  - "samsung,exynos5433-cmu-hevc" - clock controller compatible for CMU_HEVC
-    which generates clocks for HEVC(High Efficiency Video Codec) decoder IP.
-  - "samsung,exynos5433-cmu-isp" - clock controller compatible for CMU_ISP
-    which generates clocks for FIMC-ISP/DRC/SCLC/DIS/3DNR IPs.
-  - "samsung,exynos5433-cmu-cam0" - clock controller compatible for CMU_CAM0
-    which generates clocks for MIPI_CSIS{0|1}/FIMC_LITE_{A|B|D}/FIMC_3AA{0|1}
-    IPs.
-  - "samsung,exynos5433-cmu-cam1" - clock controller compatible for CMU_CAM1
-    which generates clocks for Cortex-A5/MIPI_CSIS2/FIMC-LITE_C/FIMC-FD IPs.
-  - "samsung,exynos5433-cmu-imem"   - clock controller compatible for CMU_IMEM
-    which generates clocks for SSS (Security SubSystem) and SlimSSS IPs.
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-- #clock-cells: should be 1.
-
-- clocks: list of the clock controller input clock identifiers,
-	from common clock bindings. Please refer the next section
-	to find the input clocks for a given controller.
-
-- clock-names: list of the clock controller input clock names,
-	as described in clock-bindings.txt.
-
-	Input clocks for top clock controller:
-		- oscclk
-		- sclk_mphy_pll
-		- sclk_mfc_pll
-		- sclk_bus_pll
-
-	Input clocks for cpif clock controller:
-		- oscclk
-
-	Input clocks for mif clock controller:
-		- oscclk
-		- sclk_mphy_pll
-
-	Input clocks for fsys clock controller:
-		- oscclk
-		- sclk_ufs_mphy
-		- aclk_fsys_200
-		- sclk_pcie_100_fsys
-		- sclk_ufsunipro_fsys
-		- sclk_mmc2_fsys
-		- sclk_mmc1_fsys
-		- sclk_mmc0_fsys
-		- sclk_usbhost30_fsys
-		- sclk_usbdrd30_fsys
-
-	Input clocks for g2d clock controller:
-		- oscclk
-		- aclk_g2d_266
-		- aclk_g2d_400
-
-	Input clocks for disp clock controller:
-		- oscclk
-		- sclk_dsim1_disp
-		- sclk_dsim0_disp
-		- sclk_dsd_disp
-		- sclk_decon_tv_eclk_disp
-		- sclk_decon_vclk_disp
-		- sclk_decon_eclk_disp
-		- sclk_decon_tv_vclk_disp
-		- aclk_disp_333
-
-	Input clocks for audio clock controller:
-		- oscclk
-		- fout_aud_pll
-
-	Input clocks for bus0 clock controller:
-		- aclk_bus0_400
-
-	Input clocks for bus1 clock controller:
-		- aclk_bus1_400
-
-	Input clocks for bus2 clock controller:
-		- oscclk
-		- aclk_bus2_400
-
-	Input clocks for g3d clock controller:
-		- oscclk
-		- aclk_g3d_400
-
-	Input clocks for gscl clock controller:
-		- oscclk
-		- aclk_gscl_111
-		- aclk_gscl_333
-
-	Input clocks for apollo clock controller:
-		- oscclk
-		- sclk_bus_pll_apollo
-
-	Input clocks for atlas clock controller:
-		- oscclk
-		- sclk_bus_pll_atlas
-
-	Input clocks for mscl clock controller:
-		- oscclk
-		- sclk_jpeg_mscl
-		- aclk_mscl_400
-
-	Input clocks for mfc clock controller:
-		- oscclk
-		- aclk_mfc_400
-
-	Input clocks for hevc clock controller:
-		- oscclk
-		- aclk_hevc_400
-
-	Input clocks for isp clock controller:
-		- oscclk
-		- aclk_isp_dis_400
-		- aclk_isp_400
-
-	Input clocks for cam0 clock controller:
-		- oscclk
-		- aclk_cam0_333
-		- aclk_cam0_400
-		- aclk_cam0_552
-
-	Input clocks for cam1 clock controller:
-		- oscclk
-		- sclk_isp_uart_cam1
-		- sclk_isp_spi1_cam1
-		- sclk_isp_spi0_cam1
-		- aclk_cam1_333
-		- aclk_cam1_400
-		- aclk_cam1_552
-
-	Input clocks for imem clock controller:
-		- oscclk
-		- aclk_imem_sssx_266
-		- aclk_imem_266
-		- aclk_imem_200
-
-Optional properties:
-  - power-domains: a phandle to respective power domain node as described by
-	generic PM domain bindings (see power/power_domain.txt for more
-	information).
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume.
-
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/exynos5433.h header and can be used in device
-tree sources.
-
-Example 1: Examples of 'oscclk' source clock node are listed below.
-
-	xxti: xxti {
-		compatible = "fixed-clock";
-		clock-output-names = "oscclk";
-		#clock-cells = <0>;
-	};
-
-Example 2: Examples of clock controller nodes are listed below.
-
-	cmu_top: clock-controller@10030000 {
-		compatible = "samsung,exynos5433-cmu-top";
-		reg = <0x10030000 0x0c04>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"sclk_mphy_pll",
-			"sclk_mfc_pll",
-			"sclk_bus_pll";
-		clocks = <&xxti>,
-		       <&cmu_cpif CLK_SCLK_MPHY_PLL>,
-		       <&cmu_mif CLK_SCLK_MFC_PLL>,
-		       <&cmu_mif CLK_SCLK_BUS_PLL>;
-	};
-
-	cmu_cpif: clock-controller@10fc0000 {
-		compatible = "samsung,exynos5433-cmu-cpif";
-		reg = <0x10fc0000 0x0c04>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk";
-		clocks = <&xxti>;
-	};
-
-	cmu_mif: clock-controller@105b0000 {
-		compatible = "samsung,exynos5433-cmu-mif";
-		reg = <0x105b0000 0x100c>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"sclk_mphy_pll";
-		clocks = <&xxti>,
-		       <&cmu_cpif CLK_SCLK_MPHY_PLL>;
-	};
-
-	cmu_peric: clock-controller@14c80000 {
-		compatible = "samsung,exynos5433-cmu-peric";
-		reg = <0x14c80000 0x0b08>;
-		#clock-cells = <1>;
-	};
-
-	cmu_peris: clock-controller@10040000 {
-		compatible = "samsung,exynos5433-cmu-peris";
-		reg = <0x10040000 0x0b20>;
-		#clock-cells = <1>;
-	};
-
-	cmu_fsys: clock-controller@156e0000 {
-		compatible = "samsung,exynos5433-cmu-fsys";
-		reg = <0x156e0000 0x0b04>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"sclk_ufs_mphy",
-			"aclk_fsys_200",
-			"sclk_pcie_100_fsys",
-			"sclk_ufsunipro_fsys",
-			"sclk_mmc2_fsys",
-			"sclk_mmc1_fsys",
-			"sclk_mmc0_fsys",
-			"sclk_usbhost30_fsys",
-			"sclk_usbdrd30_fsys";
-		clocks = <&xxti>,
-		       <&cmu_cpif CLK_SCLK_UFS_MPHY>,
-		       <&cmu_top CLK_ACLK_FSYS_200>,
-		       <&cmu_top CLK_SCLK_PCIE_100_FSYS>,
-		       <&cmu_top CLK_SCLK_UFSUNIPRO_FSYS>,
-		       <&cmu_top CLK_SCLK_MMC2_FSYS>,
-		       <&cmu_top CLK_SCLK_MMC1_FSYS>,
-		       <&cmu_top CLK_SCLK_MMC0_FSYS>,
-		       <&cmu_top CLK_SCLK_USBHOST30_FSYS>,
-		       <&cmu_top CLK_SCLK_USBDRD30_FSYS>;
-	};
-
-	cmu_g2d: clock-controller@12460000 {
-		compatible = "samsung,exynos5433-cmu-g2d";
-		reg = <0x12460000 0x0b08>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"aclk_g2d_266",
-			"aclk_g2d_400";
-		clocks = <&xxti>,
-		       <&cmu_top CLK_ACLK_G2D_266>,
-		       <&cmu_top CLK_ACLK_G2D_400>;
-		power-domains = <&pd_g2d>;
-	};
-
-	cmu_disp: clock-controller@13b90000 {
-		compatible = "samsung,exynos5433-cmu-disp";
-		reg = <0x13b90000 0x0c04>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"sclk_dsim1_disp",
-			"sclk_dsim0_disp",
-			"sclk_dsd_disp",
-			"sclk_decon_tv_eclk_disp",
-			"sclk_decon_vclk_disp",
-			"sclk_decon_eclk_disp",
-			"sclk_decon_tv_vclk_disp",
-			"aclk_disp_333";
-		clocks = <&xxti>,
-		       <&cmu_mif CLK_SCLK_DSIM1_DISP>,
-		       <&cmu_mif CLK_SCLK_DSIM0_DISP>,
-		       <&cmu_mif CLK_SCLK_DSD_DISP>,
-		       <&cmu_mif CLK_SCLK_DECON_TV_ECLK_DISP>,
-		       <&cmu_mif CLK_SCLK_DECON_VCLK_DISP>,
-		       <&cmu_mif CLK_SCLK_DECON_ECLK_DISP>,
-		       <&cmu_mif CLK_SCLK_DECON_TV_VCLK_DISP>,
-		       <&cmu_mif CLK_ACLK_DISP_333>;
-		power-domains = <&pd_disp>;
-	};
-
-	cmu_aud: clock-controller@114c0000 {
-		compatible = "samsung,exynos5433-cmu-aud";
-		reg = <0x114c0000 0x0b04>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk", "fout_aud_pll";
-		clocks = <&xxti>, <&cmu_top CLK_FOUT_AUD_PLL>;
-		power-domains = <&pd_aud>;
-	};
-
-	cmu_bus0: clock-controller@13600000 {
-		compatible = "samsung,exynos5433-cmu-bus0";
-		reg = <0x13600000 0x0b04>;
-		#clock-cells = <1>;
-
-		clock-names = "aclk_bus0_400";
-		clocks = <&cmu_top CLK_ACLK_BUS0_400>;
-	};
-
-	cmu_bus1: clock-controller@14800000 {
-		compatible = "samsung,exynos5433-cmu-bus1";
-		reg = <0x14800000 0x0b04>;
-		#clock-cells = <1>;
-
-		clock-names = "aclk_bus1_400";
-		clocks = <&cmu_top CLK_ACLK_BUS1_400>;
-	};
-
-	cmu_bus2: clock-controller@13400000 {
-		compatible = "samsung,exynos5433-cmu-bus2";
-		reg = <0x13400000 0x0b04>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk", "aclk_bus2_400";
-		clocks = <&xxti>, <&cmu_mif CLK_ACLK_BUS2_400>;
-	};
-
-	cmu_g3d: clock-controller@14aa0000 {
-		compatible = "samsung,exynos5433-cmu-g3d";
-		reg = <0x14aa0000 0x1000>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk", "aclk_g3d_400";
-		clocks = <&xxti>, <&cmu_top CLK_ACLK_G3D_400>;
-		power-domains = <&pd_g3d>;
-	};
-
-	cmu_gscl: clock-controller@13cf0000 {
-		compatible = "samsung,exynos5433-cmu-gscl";
-		reg = <0x13cf0000 0x0b10>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"aclk_gscl_111",
-			"aclk_gscl_333";
-		clocks = <&xxti>,
-			<&cmu_top CLK_ACLK_GSCL_111>,
-			<&cmu_top CLK_ACLK_GSCL_333>;
-		power-domains = <&pd_gscl>;
-	};
-
-	cmu_apollo: clock-controller@11900000 {
-		compatible = "samsung,exynos5433-cmu-apollo";
-		reg = <0x11900000 0x1088>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk", "sclk_bus_pll_apollo";
-		clocks = <&xxti>, <&cmu_mif CLK_SCLK_BUS_PLL_APOLLO>;
-	};
-
-	cmu_atlas: clock-controller@11800000 {
-		compatible = "samsung,exynos5433-cmu-atlas";
-		reg = <0x11800000 0x1088>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk", "sclk_bus_pll_atlas";
-		clocks = <&xxti>, <&cmu_mif CLK_SCLK_BUS_PLL_ATLAS>;
-	};
-
-	cmu_mscl: clock-controller@105d0000 {
-		compatible = "samsung,exynos5433-cmu-mscl";
-		reg = <0x105d0000 0x0b10>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"sclk_jpeg_mscl",
-			"aclk_mscl_400";
-		clocks = <&xxti>,
-		       <&cmu_top CLK_SCLK_JPEG_MSCL>,
-		       <&cmu_top CLK_ACLK_MSCL_400>;
-		power-domains = <&pd_mscl>;
-	};
-
-	cmu_mfc: clock-controller@15280000 {
-		compatible = "samsung,exynos5433-cmu-mfc";
-		reg = <0x15280000 0x0b08>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk", "aclk_mfc_400";
-		clocks = <&xxti>, <&cmu_top CLK_ACLK_MFC_400>;
-		power-domains = <&pd_mfc>;
-	};
-
-	cmu_hevc: clock-controller@14f80000 {
-		compatible = "samsung,exynos5433-cmu-hevc";
-		reg = <0x14f80000 0x0b08>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk", "aclk_hevc_400";
-		clocks = <&xxti>, <&cmu_top CLK_ACLK_HEVC_400>;
-		power-domains = <&pd_hevc>;
-	};
-
-	cmu_isp: clock-controller@146d0000 {
-		compatible = "samsung,exynos5433-cmu-isp";
-		reg = <0x146d0000 0x0b0c>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"aclk_isp_dis_400",
-			"aclk_isp_400";
-		clocks = <&xxti>,
-		       <&cmu_top CLK_ACLK_ISP_DIS_400>,
-		       <&cmu_top CLK_ACLK_ISP_400>;
-		power-domains = <&pd_isp>;
-	};
-
-	cmu_cam0: clock-controller@120d0000 {
-		compatible = "samsung,exynos5433-cmu-cam0";
-		reg = <0x120d0000 0x0b0c>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"aclk_cam0_333",
-			"aclk_cam0_400",
-			"aclk_cam0_552";
-		clocks = <&xxti>,
-		       <&cmu_top CLK_ACLK_CAM0_333>,
-		       <&cmu_top CLK_ACLK_CAM0_400>,
-		       <&cmu_top CLK_ACLK_CAM0_552>;
-		power-domains = <&pd_cam0>;
-	};
-
-	cmu_cam1: clock-controller@145d0000 {
-		compatible = "samsung,exynos5433-cmu-cam1";
-		reg = <0x145d0000 0x0b08>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"sclk_isp_uart_cam1",
-			"sclk_isp_spi1_cam1",
-			"sclk_isp_spi0_cam1",
-			"aclk_cam1_333",
-			"aclk_cam1_400",
-			"aclk_cam1_552";
-		clocks = <&xxti>,
-		       <&cmu_top CLK_SCLK_ISP_UART_CAM1>,
-		       <&cmu_top CLK_SCLK_ISP_SPI1_CAM1>,
-		       <&cmu_top CLK_SCLK_ISP_SPI0_CAM1>,
-		       <&cmu_top CLK_ACLK_CAM1_333>,
-		       <&cmu_top CLK_ACLK_CAM1_400>,
-		       <&cmu_top CLK_ACLK_CAM1_552>;
-		power-domains = <&pd_cam1>;
-	};
-
-	cmu_imem: clock-controller@11060000 {
-		compatible = "samsung,exynos5433-cmu-imem";
-		reg = <0x11060000 0x1000>;
-		#clock-cells = <1>;
-
-		clock-names = "oscclk",
-			"aclk_imem_sssx_266",
-			"aclk_imem_266",
-			"aclk_imem_200";
-		clocks = <&xxti>,
-			<&cmu_top CLK_DIV_ACLK_IMEM_SSSX_266>,
-			<&cmu_top CLK_DIV_ACLK_IMEM_266>,
-			<&cmu_top CLK_DIV_ACLK_IMEM_200>;
-	};
-
-Example 3: UART controller node that consumes the clock generated by the clock
-	   controller.
-
-	serial_0: serial@14c10000 {
-		compatible = "samsung,exynos5433-uart";
-		reg = <0x14C10000 0x100>;
-		interrupts = <0 421 0>;
-		clocks = <&cmu_peric CLK_PCLK_UART0>,
-			 <&cmu_peric CLK_SCLK_UART0>;
-		clock-names = "uart", "clk_uart_baud0";
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart0_bus>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
new file mode 100644
index 000000000000..edd1b4ac4334
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
@@ -0,0 +1,524 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos5433-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos5433 SoC clock controller
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Tomasz Figa <tomasz.figa@gmail.com>
+
+description: |
+  Expected external clocks, defined in DTS as fixed-rate clocks with a matching
+  name::
+    - "oscclk" - PLL input clock from XXTI
+
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/exynos5433.h header.
+
+properties:
+  compatible:
+    enum:
+        # CMU_TOP which generates clocks for
+        # IMEM/FSYS/G3D/GSCL/HEVC/MSCL/G2D/MFC/PERIC/PERIS domains and bus
+        # clocks
+      - samsung,exynos5433-cmu-top
+        # CMU_CPIF which generates clocks for LLI (Low Latency Interface) IP
+      - samsung,exynos5433-cmu-cpif
+        # CMU_MIF which generates clocks for DRAM Memory Controller domain
+      - samsung,exynos5433-cmu-mif
+        # CMU_PERIC which generates clocks for
+        # UART/I2C/SPI/I2S/PCM/SPDIF/PWM/SLIMBUS IPs
+      - samsung,exynos5433-cmu-peric
+        # CMU_PERIS which generates clocks for PMU/TMU/MCT/WDT/RTC/SECKEY/TZPC IPs
+      - samsung,exynos5433-cmu-peris
+        # CMU_FSYS which generates clocks for USB/UFS/SDMMC/TSI/PDMA IPs
+      - samsung,exynos5433-cmu-fsys
+      - samsung,exynos5433-cmu-g2d
+        # CMU_DISP which generates clocks for Display (DECON/HDMI/DSIM/MIXER) IPs
+      - samsung,exynos5433-cmu-disp
+      - samsung,exynos5433-cmu-aud
+      - samsung,exynos5433-cmu-bus0
+      - samsung,exynos5433-cmu-bus1
+      - samsung,exynos5433-cmu-bus2
+      - samsung,exynos5433-cmu-g3d
+      - samsung,exynos5433-cmu-gscl
+      - samsung,exynos5433-cmu-apollo
+        # CMU_ATLAS which generates clocks for Cortex-A57 Quad-core processor,
+        # CoreSight and  L2 cache controller
+      - samsung,exynos5433-cmu-atlas
+        # CMU_MSCL which generates clocks for M2M (Memory to Memory) scaler and
+        # JPEG IPs
+      - samsung,exynos5433-cmu-mscl
+      - samsung,exynos5433-cmu-mfc
+      - samsung,exynos5433-cmu-hevc
+        # CMU_ISP which generates clocks for FIMC-ISP/DRC/SCLC/DIS/3DNR IPs
+      - samsung,exynos5433-cmu-isp
+        # CMU_CAM0 which generates clocks for
+        # MIPI_CSIS{0|1}/FIMC_LITE_{A|B|D}/FIMC_3AA{0|1} IPs
+      - samsung,exynos5433-cmu-cam0
+        # CMU_CAM1 which generates clocks for
+        # Cortex-A5/MIPI_CSIS2/FIMC-LITE_C/FIMC-FD IPs
+      - samsung,exynos5433-cmu-cam1
+        # CMU_IMEM which generates clocks for SSS (Security SubSystem) and
+        # SlimSSS IPs
+      - samsung,exynos5433-cmu-imem
+
+  clocks:
+    minItems: 1
+    maxItems: 10
+
+  clock-names:
+    minItems: 1
+    maxItems: 10
+
+  "#clock-cells":
+    const: 1
+
+  power-domains:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-top
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: oscclk
+            - const: sclk_mphy_pll
+            - const: sclk_mfc_pll
+            - const: sclk_bus_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-cpif
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: oscclk
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-mif
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: oscclk
+            - const: sclk_mphy_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-fsys
+    then:
+      properties:
+        clocks:
+          minItems: 10
+          maxItems: 10
+        clock-names:
+          items:
+            - const: oscclk
+            - const: sclk_ufs_mphy
+            - const: aclk_fsys_200
+            - const: sclk_pcie_100_fsys
+            - const: sclk_ufsunipro_fsys
+            - const: sclk_mmc2_fsys
+            - const: sclk_mmc1_fsys
+            - const: sclk_mmc0_fsys
+            - const: sclk_usbhost30_fsys
+            - const: sclk_usbdrd30_fsys
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-g2d
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_g2d_266
+            - const: aclk_g2d_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-disp
+    then:
+      properties:
+        clocks:
+          minItems: 9
+          maxItems: 9
+        clock-names:
+          items:
+            - const: oscclk
+            - const: sclk_dsim1_disp
+            - const: sclk_dsim0_disp
+            - const: sclk_dsd_disp
+            - const: sclk_decon_tv_eclk_disp
+            - const: sclk_decon_vclk_disp
+            - const: sclk_decon_eclk_disp
+            - const: sclk_decon_tv_vclk_disp
+            - const: aclk_disp_333
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-aud
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: oscclk
+            - const: fout_aud_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-bus0
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: aclk_bus0_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-bus1
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: aclk_bus1_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-bus2
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_bus2_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-g3d
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_g3d_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-gscl
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_gscl_111
+            - const: aclk_gscl_333
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-apollo
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: oscclk
+            - const: sclk_bus_pll_apollo
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-atlas
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: oscclk
+            - const: sclk_bus_pll_atlas
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-mscl
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: oscclk
+            - const: sclk_jpeg_mscl
+            - const: aclk_mscl_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-mfc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_mfc_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-hevc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_hevc_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-isp
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_isp_dis_400
+            - const: aclk_isp_400
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-cam0
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_cam0_333
+            - const: aclk_cam0_400
+            - const: aclk_cam0_552
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-cam1
+    then:
+      properties:
+        clocks:
+          minItems: 7
+          maxItems: 7
+        clock-names:
+          items:
+            - const: oscclk
+            - const: sclk_isp_uart_cam1
+            - const: sclk_isp_spi1_cam1
+            - const: sclk_isp_spi0_cam1
+            - const: aclk_cam1_333
+            - const: aclk_cam1_400
+            - const: aclk_cam1_552
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-cmu-imem
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: oscclk
+            - const: aclk_imem_sssx_266
+            - const: aclk_imem_266
+            - const: aclk_imem_200
+      required:
+        - clock-names
+        - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5433.h>
+    xxti: clock {
+        compatible = "fixed-clock";
+        clock-output-names = "oscclk";
+        #clock-cells = <0>;
+        clock-frequency = <24000000>;
+    };
+
+    clock-controller@10030000 {
+        compatible = "samsung,exynos5433-cmu-top";
+        reg = <0x10030000 0x1000>;
+        #clock-cells = <1>;
+
+        clock-names = "oscclk",
+                      "sclk_mphy_pll",
+                      "sclk_mfc_pll",
+                      "sclk_bus_pll";
+        clocks = <&xxti>,
+                 <&cmu_cpif CLK_SCLK_MPHY_PLL>,
+                 <&cmu_mif CLK_SCLK_MFC_PLL>,
+                 <&cmu_mif CLK_SCLK_BUS_PLL>;
+    };
-- 
2.32.0

