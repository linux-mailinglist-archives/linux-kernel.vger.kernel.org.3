Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74D58CD84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiHHSQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242542AbiHHSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:16:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB03718E29
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:16:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l4so11745653wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=83irNhDoKtTRO4s+Jq6dHPApkH8GLqji/9NTuZsd3t4=;
        b=QVTPEDE41SYwmLG4AB+vEqZ6WwP53DIKCKty9/c7SHulo4iKOPI0/U8+DPEfz6rYwV
         vbHDDsMVp7ahk6oRtiEkyarHwP01sR9dReOjWf0wHTx/bpqFE0I3Fig/3IXcQdNngjAq
         1hG6nzs0kPx7KxiiQXGRzZJ/asbq32/j+OjBnNaLn95M4eKSd6SAws+1rUbeb3CrM0vO
         hAPFBG03KsH4xh9G3F3uNB+jbXK2Ox7Y7Y/pH7brE7u+Q/QiuAGvR2IbCZrbehNQT9JP
         XCvzw6UVGdhtueBXaTG+1E1vfMLHEzCFirp7RUIYYWEnyehgOX4r5CaaXyGOKt3ULta9
         mCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=83irNhDoKtTRO4s+Jq6dHPApkH8GLqji/9NTuZsd3t4=;
        b=wb4j9704SGHqh26E7gNvSqJ47vdAA7iObvb/Tf7MYroLDfc/WJ6qOCPohjbRwlJiVM
         DwhQnc/f02t96PV0CD/og6AH3w9rzD/A+IAE09OsKY7eCT4NZROJ8uvC5FBHEjILqWVr
         G4d2iMvxt3IxzjDjCGn6EnPBK1AaZMy1+faEEpbmTCk6lkiMaC1zh8dsmpQhT2VISNBe
         8HVkQa8yoVVoYWfpGyFhztyGl6gB6pTgm4VGshlrNuvBXEJkGw4TTySUMhQBft/sKUx6
         NsL3bAOLffJBcstE75chKiGxXPAI34vs4k3ERBsPfN4kz1WkkysGYJ3d8Nl1YOFrvJB6
         WcqA==
X-Gm-Message-State: ACgBeo0/7C3QowTpn2/5q4YuDYoFAM9bjCrEml/31GL/+85aA2UAS1Bd
        OgqXBznfrAkLDjqaZFllwr+9LQ==
X-Google-Smtp-Source: AA6agR4r5Fo3RnHu5LbLsvZ2JIwej8wBPQQRTT7xADgkNCkSEMK2KEYnrTKNyr0VrZJcm7tiEaL3kw==
X-Received: by 2002:a05:6000:4083:b0:21f:fb6:9293 with SMTP id da3-20020a056000408300b0021f0fb69293mr11895640wrb.303.1659982565675;
        Mon, 08 Aug 2022 11:16:05 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003a302fb9df7sm20055875wmq.21.2022.08.08.11.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:16:05 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] clk: samsung: exynos850: Implement CMU_IS domain
Date:   Mon,  8 Aug 2022 21:16:04 +0300
Message-Id: <20220808181604.10648-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMU_IS clock domain provides clocks for IS IP-core (Image Signal
Processing Subsystem). According to Exynos850 TRM, CMU_IS generates
CSIS, IPP, ITP, VRA and GDC clocks for BLK_IS.

This patch adds next clocks:
  - bus clocks in CMU_TOP needed for CMU_IS
  - all internal CMU_IS clocks
  - leaf clocks for IS IP-core, CSIS (Camera Serial Interface Slave),
    D_TZPC (TrustZone Protection Controller), CSIS DMA, GDC (Geometric
    Distortion Correction), IPP (Image Preprocessing Processing core),
    ITP (Image Texture Processing core), MCSC (Multi-Channel Scaler),
    VRA (Visual Recognition Accelerator), PPMU (Platform Performance
    Monitoring Unit), SysMMU and SysReg

IS related gate clocks in CMU_TOP were marked as CLK_IS_CRITICAL,
because:
  1. All of those have to be enabled in order to read
     /sys/kernel/debug/clk/clk_summary file
  2. When some user driver (e.g. exynos-sysmmu) disables some derived
     leaf clock, it can lead to CMU_TOP clocks disable, which then makes
     the system hang. To prevent that, the CLK_IS_CRITICAL flag is used,
     as CLK_IGNORE_UNUSED is not enough.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 199 ++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index c91984f3f14f..18a36d58101e 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -39,6 +39,10 @@
 #define CLK_CON_MUX_MUX_CLKCMU_HSI_BUS		0x103c
 #define CLK_CON_MUX_MUX_CLKCMU_HSI_MMC_CARD	0x1040
 #define CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD	0x1044
+#define CLK_CON_MUX_MUX_CLKCMU_IS_BUS		0x1048
+#define CLK_CON_MUX_MUX_CLKCMU_IS_GDC		0x104c
+#define CLK_CON_MUX_MUX_CLKCMU_IS_ITP		0x1050
+#define CLK_CON_MUX_MUX_CLKCMU_IS_VRA		0x1054
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_BUS		0x1070
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_IP		0x1074
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_UART	0x1078
@@ -52,6 +56,10 @@
 #define CLK_CON_DIV_CLKCMU_HSI_BUS		0x1848
 #define CLK_CON_DIV_CLKCMU_HSI_MMC_CARD		0x184c
 #define CLK_CON_DIV_CLKCMU_HSI_USB20DRD		0x1850
+#define CLK_CON_DIV_CLKCMU_IS_BUS		0x1854
+#define CLK_CON_DIV_CLKCMU_IS_GDC		0x1858
+#define CLK_CON_DIV_CLKCMU_IS_ITP		0x185c
+#define CLK_CON_DIV_CLKCMU_IS_VRA		0x1860
 #define CLK_CON_DIV_CLKCMU_PERI_BUS		0x187c
 #define CLK_CON_DIV_CLKCMU_PERI_IP		0x1880
 #define CLK_CON_DIV_CLKCMU_PERI_UART		0x1884
@@ -71,6 +79,10 @@
 #define CLK_CON_GAT_GATE_CLKCMU_HSI_BUS		0x2044
 #define CLK_CON_GAT_GATE_CLKCMU_HSI_MMC_CARD	0x2048
 #define CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD	0x204c
+#define CLK_CON_GAT_GATE_CLKCMU_IS_BUS		0x2050
+#define CLK_CON_GAT_GATE_CLKCMU_IS_GDC		0x2054
+#define CLK_CON_GAT_GATE_CLKCMU_IS_ITP		0x2058
+#define CLK_CON_GAT_GATE_CLKCMU_IS_VRA		0x205c
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_BUS	0x2080
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_IP		0x2084
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_UART	0x2088
@@ -95,6 +107,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_MUX_MUX_CLKCMU_HSI_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_HSI_MMC_CARD,
 	CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD,
+	CLK_CON_MUX_MUX_CLKCMU_IS_BUS,
+	CLK_CON_MUX_MUX_CLKCMU_IS_GDC,
+	CLK_CON_MUX_MUX_CLKCMU_IS_ITP,
+	CLK_CON_MUX_MUX_CLKCMU_IS_VRA,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_IP,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_UART,
@@ -108,6 +124,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_DIV_CLKCMU_HSI_BUS,
 	CLK_CON_DIV_CLKCMU_HSI_MMC_CARD,
 	CLK_CON_DIV_CLKCMU_HSI_USB20DRD,
+	CLK_CON_DIV_CLKCMU_IS_BUS,
+	CLK_CON_DIV_CLKCMU_IS_GDC,
+	CLK_CON_DIV_CLKCMU_IS_ITP,
+	CLK_CON_DIV_CLKCMU_IS_VRA,
 	CLK_CON_DIV_CLKCMU_PERI_BUS,
 	CLK_CON_DIV_CLKCMU_PERI_IP,
 	CLK_CON_DIV_CLKCMU_PERI_UART,
@@ -127,6 +147,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_GAT_GATE_CLKCMU_HSI_BUS,
 	CLK_CON_GAT_GATE_CLKCMU_HSI_MMC_CARD,
 	CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD,
+	CLK_CON_GAT_GATE_CLKCMU_IS_BUS,
+	CLK_CON_GAT_GATE_CLKCMU_IS_GDC,
+	CLK_CON_GAT_GATE_CLKCMU_IS_ITP,
+	CLK_CON_GAT_GATE_CLKCMU_IS_VRA,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_BUS,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_IP,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_UART,
@@ -176,6 +200,15 @@ PNAME(mout_hsi_mmc_card_p)	= { "oscclk", "dout_shared0_div2",
 				    "oscclk", "oscclk" };
 PNAME(mout_hsi_usb20drd_p)	= { "oscclk", "dout_shared0_div4",
 				    "dout_shared1_div4", "oscclk" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_IS */
+PNAME(mout_is_bus_p)		= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared1_div3" };
+PNAME(mout_is_itp_p)		= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared1_div3" };
+PNAME(mout_is_vra_p)		= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared1_div3" };
+PNAME(mout_is_gdc_p)		= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared1_div3" };
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_PERI */
 PNAME(mout_peri_bus_p)		= { "dout_shared0_div4", "dout_shared1_div4" };
 PNAME(mout_peri_uart_p)		= { "oscclk", "dout_shared0_div4",
@@ -225,6 +258,16 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_HSI_USB20DRD, "mout_hsi_usb20drd", mout_hsi_usb20drd_p,
 	    CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD, 0, 2),
 
+	/* IS */
+	MUX(CLK_MOUT_IS_BUS, "mout_is_bus", mout_is_bus_p,
+	    CLK_CON_MUX_MUX_CLKCMU_IS_BUS, 0, 2),
+	MUX(CLK_MOUT_IS_ITP, "mout_is_itp", mout_is_itp_p,
+	    CLK_CON_MUX_MUX_CLKCMU_IS_ITP, 0, 2),
+	MUX(CLK_MOUT_IS_VRA, "mout_is_vra", mout_is_vra_p,
+	    CLK_CON_MUX_MUX_CLKCMU_IS_VRA, 0, 2),
+	MUX(CLK_MOUT_IS_GDC, "mout_is_gdc", mout_is_gdc_p,
+	    CLK_CON_MUX_MUX_CLKCMU_IS_GDC, 0, 2),
+
 	/* PERI */
 	MUX(CLK_MOUT_PERI_BUS, "mout_peri_bus", mout_peri_bus_p,
 	    CLK_CON_MUX_MUX_CLKCMU_PERI_BUS, 0, 1),
@@ -279,6 +322,16 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	DIV(CLK_DOUT_HSI_USB20DRD, "dout_hsi_usb20drd", "gout_hsi_usb20drd",
 	    CLK_CON_DIV_CLKCMU_HSI_USB20DRD, 0, 4),
 
+	/* IS */
+	DIV(CLK_DOUT_IS_BUS, "dout_is_bus", "gout_is_bus",
+	    CLK_CON_DIV_CLKCMU_IS_BUS, 0, 4),
+	DIV(CLK_DOUT_IS_ITP, "dout_is_itp", "gout_is_itp",
+	    CLK_CON_DIV_CLKCMU_IS_ITP, 0, 4),
+	DIV(CLK_DOUT_IS_VRA, "dout_is_vra", "gout_is_vra",
+	    CLK_CON_DIV_CLKCMU_IS_VRA, 0, 4),
+	DIV(CLK_DOUT_IS_GDC, "dout_is_gdc", "gout_is_gdc",
+	    CLK_CON_DIV_CLKCMU_IS_GDC, 0, 4),
+
 	/* PERI */
 	DIV(CLK_DOUT_PERI_BUS, "dout_peri_bus", "gout_peri_bus",
 	    CLK_CON_DIV_CLKCMU_PERI_BUS, 0, 4),
@@ -319,6 +372,17 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_HSI_USB20DRD, "gout_hsi_usb20drd", "mout_hsi_usb20drd",
 	     CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD, 21, 0, 0),
 
+	/* IS */
+	/* TODO: These clocks have to be always enabled to access CMU_IS regs */
+	GATE(CLK_GOUT_IS_BUS, "gout_is_bus", "mout_is_bus",
+	     CLK_CON_GAT_GATE_CLKCMU_IS_BUS, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_IS_ITP, "gout_is_itp", "mout_is_itp",
+	     CLK_CON_GAT_GATE_CLKCMU_IS_ITP, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_IS_VRA, "gout_is_vra", "mout_is_vra",
+	     CLK_CON_GAT_GATE_CLKCMU_IS_VRA, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_IS_GDC, "gout_is_gdc", "mout_is_gdc",
+	     CLK_CON_GAT_GATE_CLKCMU_IS_GDC, 21, CLK_IS_CRITICAL, 0),
+
 	/* PERI */
 	GATE(CLK_GOUT_PERI_BUS, "gout_peri_bus", "mout_peri_bus",
 	     CLK_CON_GAT_GATE_CLKCMU_PERI_BUS, 21, 0, 0),
@@ -952,6 +1016,138 @@ static const struct samsung_cmu_info hsi_cmu_info __initconst = {
 	.clk_name		= "dout_hsi_bus",
 };
 
+/* ---- CMU_IS -------------------------------------------------------------- */
+
+#define PLL_CON0_MUX_CLKCMU_IS_BUS_USER		0x0600
+#define PLL_CON0_MUX_CLKCMU_IS_GDC_USER		0x0610
+#define PLL_CON0_MUX_CLKCMU_IS_ITP_USER		0x0620
+#define PLL_CON0_MUX_CLKCMU_IS_VRA_USER		0x0630
+#define CLK_CON_DIV_DIV_CLK_IS_BUSP		0x1800
+#define CLK_CON_GAT_CLK_IS_CMU_IS_PCLK		0x2000
+#define CLK_CON_GAT_GOUT_IS_CSIS0_ACLK		0x2040
+#define CLK_CON_GAT_GOUT_IS_CSIS1_ACLK		0x2044
+#define CLK_CON_GAT_GOUT_IS_CSIS2_ACLK		0x2048
+#define CLK_CON_GAT_GOUT_IS_TZPC_PCLK		0x204c
+#define CLK_CON_GAT_GOUT_IS_CLK_CSIS_DMA	0x2050
+#define CLK_CON_GAT_GOUT_IS_CLK_GDC		0x2054
+#define CLK_CON_GAT_GOUT_IS_CLK_IPP		0x2058
+#define CLK_CON_GAT_GOUT_IS_CLK_ITP		0x205c
+#define CLK_CON_GAT_GOUT_IS_CLK_MCSC		0x2060
+#define CLK_CON_GAT_GOUT_IS_CLK_VRA		0x2064
+#define CLK_CON_GAT_GOUT_IS_PPMU_IS0_ACLK	0x2074
+#define CLK_CON_GAT_GOUT_IS_PPMU_IS0_PCLK	0x2078
+#define CLK_CON_GAT_GOUT_IS_PPMU_IS1_ACLK	0x207c
+#define CLK_CON_GAT_GOUT_IS_PPMU_IS1_PCLK	0x2080
+#define CLK_CON_GAT_GOUT_IS_SYSMMU_IS0_CLK_S1	0x2098
+#define CLK_CON_GAT_GOUT_IS_SYSMMU_IS1_CLK_S1	0x209c
+#define CLK_CON_GAT_GOUT_IS_SYSREG_PCLK		0x20a0
+
+static const unsigned long is_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_IS_BUS_USER,
+	PLL_CON0_MUX_CLKCMU_IS_GDC_USER,
+	PLL_CON0_MUX_CLKCMU_IS_ITP_USER,
+	PLL_CON0_MUX_CLKCMU_IS_VRA_USER,
+	CLK_CON_DIV_DIV_CLK_IS_BUSP,
+	CLK_CON_GAT_CLK_IS_CMU_IS_PCLK,
+	CLK_CON_GAT_GOUT_IS_CSIS0_ACLK,
+	CLK_CON_GAT_GOUT_IS_CSIS1_ACLK,
+	CLK_CON_GAT_GOUT_IS_CSIS2_ACLK,
+	CLK_CON_GAT_GOUT_IS_TZPC_PCLK,
+	CLK_CON_GAT_GOUT_IS_CLK_CSIS_DMA,
+	CLK_CON_GAT_GOUT_IS_CLK_GDC,
+	CLK_CON_GAT_GOUT_IS_CLK_IPP,
+	CLK_CON_GAT_GOUT_IS_CLK_ITP,
+	CLK_CON_GAT_GOUT_IS_CLK_MCSC,
+	CLK_CON_GAT_GOUT_IS_CLK_VRA,
+	CLK_CON_GAT_GOUT_IS_PPMU_IS0_ACLK,
+	CLK_CON_GAT_GOUT_IS_PPMU_IS0_PCLK,
+	CLK_CON_GAT_GOUT_IS_PPMU_IS1_ACLK,
+	CLK_CON_GAT_GOUT_IS_PPMU_IS1_PCLK,
+	CLK_CON_GAT_GOUT_IS_SYSMMU_IS0_CLK_S1,
+	CLK_CON_GAT_GOUT_IS_SYSMMU_IS1_CLK_S1,
+	CLK_CON_GAT_GOUT_IS_SYSREG_PCLK,
+};
+
+/* List of parent clocks for Muxes in CMU_IS */
+PNAME(mout_is_bus_user_p)	= { "oscclk", "dout_is_bus" };
+PNAME(mout_is_itp_user_p)	= { "oscclk", "dout_is_itp" };
+PNAME(mout_is_vra_user_p)	= { "oscclk", "dout_is_vra" };
+PNAME(mout_is_gdc_user_p)	= { "oscclk", "dout_is_gdc" };
+
+static const struct samsung_mux_clock is_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_IS_BUS_USER, "mout_is_bus_user", mout_is_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_IS_BUS_USER, 4, 1),
+	MUX(CLK_MOUT_IS_ITP_USER, "mout_is_itp_user", mout_is_itp_user_p,
+	    PLL_CON0_MUX_CLKCMU_IS_ITP_USER, 4, 1),
+	MUX(CLK_MOUT_IS_VRA_USER, "mout_is_vra_user", mout_is_vra_user_p,
+	    PLL_CON0_MUX_CLKCMU_IS_VRA_USER, 4, 1),
+	MUX(CLK_MOUT_IS_GDC_USER, "mout_is_gdc_user", mout_is_gdc_user_p,
+	    PLL_CON0_MUX_CLKCMU_IS_GDC_USER, 4, 1),
+};
+
+static const struct samsung_div_clock is_div_clks[] __initconst = {
+	DIV(CLK_DOUT_IS_BUSP, "dout_is_busp", "mout_is_bus_user",
+	    CLK_CON_DIV_DIV_CLK_IS_BUSP, 0, 2),
+};
+
+static const struct samsung_gate_clock is_gate_clks[] __initconst = {
+	/* TODO: Should be enabled in IS driver */
+	GATE(CLK_GOUT_IS_CMU_IS_PCLK, "gout_is_cmu_is_pclk", "dout_is_busp",
+	     CLK_CON_GAT_CLK_IS_CMU_IS_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_IS_CSIS0_ACLK, "gout_is_csis0_aclk", "mout_is_bus_user",
+	     CLK_CON_GAT_GOUT_IS_CSIS0_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_IS_CSIS1_ACLK, "gout_is_csis1_aclk", "mout_is_bus_user",
+	     CLK_CON_GAT_GOUT_IS_CSIS1_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_IS_CSIS2_ACLK, "gout_is_csis2_aclk", "mout_is_bus_user",
+	     CLK_CON_GAT_GOUT_IS_CSIS2_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_IS_TZPC_PCLK, "gout_is_tzpc_pclk", "dout_is_busp",
+	     CLK_CON_GAT_GOUT_IS_TZPC_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_IS_CSIS_DMA_CLK, "gout_is_csis_dma_clk",
+	     "mout_is_bus_user",
+	     CLK_CON_GAT_GOUT_IS_CLK_CSIS_DMA, 21, 0, 0),
+	GATE(CLK_GOUT_IS_GDC_CLK, "gout_is_gdc_clk", "mout_is_gdc_user",
+	     CLK_CON_GAT_GOUT_IS_CLK_GDC, 21, 0, 0),
+	GATE(CLK_GOUT_IS_IPP_CLK, "gout_is_ipp_clk", "mout_is_bus_user",
+	     CLK_CON_GAT_GOUT_IS_CLK_IPP, 21, 0, 0),
+	GATE(CLK_GOUT_IS_ITP_CLK, "gout_is_itp_clk", "mout_is_itp_user",
+	     CLK_CON_GAT_GOUT_IS_CLK_ITP, 21, 0, 0),
+	GATE(CLK_GOUT_IS_MCSC_CLK, "gout_is_mcsc_clk", "mout_is_itp_user",
+	     CLK_CON_GAT_GOUT_IS_CLK_MCSC, 21, 0, 0),
+	GATE(CLK_GOUT_IS_VRA_CLK, "gout_is_vra_clk", "mout_is_vra_user",
+	     CLK_CON_GAT_GOUT_IS_CLK_VRA, 21, 0, 0),
+	GATE(CLK_GOUT_IS_PPMU_IS0_ACLK, "gout_is_ppmu_is0_aclk",
+	     "mout_is_bus_user",
+	     CLK_CON_GAT_GOUT_IS_PPMU_IS0_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_IS_PPMU_IS0_PCLK, "gout_is_ppmu_is0_pclk", "dout_is_busp",
+	     CLK_CON_GAT_GOUT_IS_PPMU_IS0_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_IS_PPMU_IS1_ACLK, "gout_is_ppmu_is1_aclk",
+	     "mout_is_itp_user",
+	     CLK_CON_GAT_GOUT_IS_PPMU_IS1_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_IS_PPMU_IS1_PCLK, "gout_is_ppmu_is1_pclk", "dout_is_busp",
+	     CLK_CON_GAT_GOUT_IS_PPMU_IS1_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_IS_SYSMMU_IS0_CLK, "gout_is_sysmmu_is0_clk",
+	     "mout_is_bus_user",
+	     CLK_CON_GAT_GOUT_IS_SYSMMU_IS0_CLK_S1, 21, 0, 0),
+	GATE(CLK_GOUT_IS_SYSMMU_IS1_CLK, "gout_is_sysmmu_is1_clk",
+	     "mout_is_itp_user",
+	     CLK_CON_GAT_GOUT_IS_SYSMMU_IS1_CLK_S1, 21, 0, 0),
+	GATE(CLK_GOUT_IS_SYSREG_PCLK, "gout_is_sysreg_pclk", "dout_is_busp",
+	     CLK_CON_GAT_GOUT_IS_SYSREG_PCLK, 21, 0, 0),
+};
+
+static const struct samsung_cmu_info is_cmu_info __initconst = {
+	.mux_clks		= is_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(is_mux_clks),
+	.div_clks		= is_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(is_div_clks),
+	.gate_clks		= is_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(is_gate_clks),
+	.nr_clk_ids		= IS_NR_CLK,
+	.clk_regs		= is_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(is_clk_regs),
+	.clk_name		= "dout_is_bus",
+};
+
 /* ---- CMU_PERI ------------------------------------------------------------ */
 
 /* Register Offset definitions for CMU_PERI (0x10030000) */
@@ -1334,6 +1530,9 @@ static const struct of_device_id exynos850_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos850-cmu-hsi",
 		.data = &hsi_cmu_info,
+	}, {
+		.compatible = "samsung,exynos850-cmu-is",
+		.data = &is_cmu_info,
 	}, {
 		.compatible = "samsung,exynos850-cmu-core",
 		.data = &core_cmu_info,
-- 
2.30.2

