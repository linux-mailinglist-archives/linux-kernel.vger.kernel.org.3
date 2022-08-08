Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E558CD86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbiHHSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbiHHSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:16:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA81900C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:16:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q30so11750590wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Cby4aozMWzXB/hTB0ZRMU7iNV7nfo1iiJKTXiU2QhVw=;
        b=Pbf2HIrxN8LsZP0H/mI7xoLqtdVYO95Hj59I5SZ/2Ow/7QSieo+CIKDGlJ1cbuT5Rb
         bVywyeD/0kSqvAQu4vU1pef1koRMrejDiZxknxQiwJ7CB1DZVQEot2is+FdiPy70CAT2
         E6IMx1F8X6a2NTCd064R4ugL7O1YnzPRlbq8TfDzslV86dkfixtsT1+X/QM/psDjVSob
         oGXB/7fD4XnThjcjq8sXLBT/I788SU3KjIhl0Pk2c6XXpqSeHdouQs0F0QwqeRtmq7s1
         +mZ0tguHF0ifKbmL4Uw8dB7ta4xeSMh7HywZQazDKl43PEP3E3Mj7HNUsfeo6MC2Cbmj
         gV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Cby4aozMWzXB/hTB0ZRMU7iNV7nfo1iiJKTXiU2QhVw=;
        b=AdaYgpbjUO+LgVtGhsd43OsTA/kRVAGqwDDr6xTITNtgS9D9WVNC4n7ZPYO0Sltqc2
         ECvSifLbHZZW1tT9vfgdhDVCGrfgDMCFELSt4PClzbtgaM06lHzdLfyR2zVaWF9vmgac
         j8cET7mD0G62XAxYk2Lay60pTOW4LhgV9qHNeM5+hQvGbJvzlZ0FUuQjExmE/NKsUV9B
         Kpe9k5SPSsd0g4okcuk3pdN1QfrCbFJuuYUtnpD8pjiJoVbnMDTaJ+GSJhDFL+BtW0zS
         b2EDM61Dknh115NXd8hJeSlNnU8Ltwssrxw6xjifNHyGRbWbXEY+EySm9V49yzWxSLa1
         2qJg==
X-Gm-Message-State: ACgBeo0G7pHKbiB5KGQgm8KwLtPrriKYjcBOalSP77knLHoMgRlEn1YN
        Dd9G6mGPvQ6JWHeDzFbimiELwA==
X-Google-Smtp-Source: AA6agR5E61YiWXImS6Q+U/NxtvT+m9hwkKJy5BTaXIcC5ElFJWyY3tfjJpQdSbt7yNlcTTDsm9kEmQ==
X-Received: by 2002:a5d:648b:0:b0:222:cb51:a57 with SMTP id o11-20020a5d648b000000b00222cb510a57mr4163040wri.287.1659982567754;
        Mon, 08 Aug 2022 11:16:07 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b003a35516ccc3sm14400515wmb.26.2022.08.08.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:16:07 -0700 (PDT)
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
Subject: [PATCH 7/7] clk: samsung: exynos850: Implement CMU_MFCMSCL domain
Date:   Mon,  8 Aug 2022 21:16:06 +0300
Message-Id: <20220808181606.10701-1-semen.protsenko@linaro.org>
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

CMU_MFCMSCL clock domain provides clocks for MFC (Multi-Format Codec),
JPEG Codec and Scaler IP-cores. According to Exynos850 TRM, CMU_MFCMSCL
generates MFC, M2M, MCSC and JPEG clocks for BLK_MFCMSCL.

This patch adds next clocks:
  - bus clocks in CMU_TOP for CMU_MFCMSCL
  - all internal CMU_MFCMSCL clocks
  - leaf clocks for MFCMSCL, TZPC (TrustZone Protection Controller),
    JPEG codec, M2M (Memory-to-Memory), MCSC (Multi-Channel Scaler),
    MFC (Multi-Format Codec), PPMU (Platform Performance Monitoring
    Unit), SysMMU and SysReg

MFCMSCL related gate clocks in CMU_TOP were marked as CLK_IS_CRITICAL,
because:
  1. All of those have to be enabled in order to read
     /sys/kernel/debug/clk/clk_summary file
  2. When some user driver (e.g. exynos-sysmmu) disables some derived
     leaf clock, it can lead to CMU_TOP clocks disable, which then makes
     the system hang. To prevent that, the CLK_IS_CRITICAL flag is used,
     as CLK_IGNORE_UNUSED is not enough.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 176 ++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 18a36d58101e..541761e96aeb 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -43,6 +43,10 @@
 #define CLK_CON_MUX_MUX_CLKCMU_IS_GDC		0x104c
 #define CLK_CON_MUX_MUX_CLKCMU_IS_ITP		0x1050
 #define CLK_CON_MUX_MUX_CLKCMU_IS_VRA		0x1054
+#define CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_JPEG	0x1058
+#define CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_M2M	0x105c
+#define CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_MCSC	0x1060
+#define CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_MFC	0x1064
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_BUS		0x1070
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_IP		0x1074
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_UART	0x1078
@@ -60,6 +64,10 @@
 #define CLK_CON_DIV_CLKCMU_IS_GDC		0x1858
 #define CLK_CON_DIV_CLKCMU_IS_ITP		0x185c
 #define CLK_CON_DIV_CLKCMU_IS_VRA		0x1860
+#define CLK_CON_DIV_CLKCMU_MFCMSCL_JPEG		0x1864
+#define CLK_CON_DIV_CLKCMU_MFCMSCL_M2M		0x1868
+#define CLK_CON_DIV_CLKCMU_MFCMSCL_MCSC		0x186c
+#define CLK_CON_DIV_CLKCMU_MFCMSCL_MFC		0x1870
 #define CLK_CON_DIV_CLKCMU_PERI_BUS		0x187c
 #define CLK_CON_DIV_CLKCMU_PERI_IP		0x1880
 #define CLK_CON_DIV_CLKCMU_PERI_UART		0x1884
@@ -83,6 +91,10 @@
 #define CLK_CON_GAT_GATE_CLKCMU_IS_GDC		0x2054
 #define CLK_CON_GAT_GATE_CLKCMU_IS_ITP		0x2058
 #define CLK_CON_GAT_GATE_CLKCMU_IS_VRA		0x205c
+#define CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_JPEG	0x2060
+#define CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_M2M	0x2064
+#define CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_MCSC	0x2068
+#define CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_MFC	0x206c
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_BUS	0x2080
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_IP		0x2084
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_UART	0x2088
@@ -111,6 +123,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_MUX_MUX_CLKCMU_IS_GDC,
 	CLK_CON_MUX_MUX_CLKCMU_IS_ITP,
 	CLK_CON_MUX_MUX_CLKCMU_IS_VRA,
+	CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_JPEG,
+	CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_M2M,
+	CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_MCSC,
+	CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_MFC,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_IP,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_UART,
@@ -128,6 +144,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_DIV_CLKCMU_IS_GDC,
 	CLK_CON_DIV_CLKCMU_IS_ITP,
 	CLK_CON_DIV_CLKCMU_IS_VRA,
+	CLK_CON_DIV_CLKCMU_MFCMSCL_JPEG,
+	CLK_CON_DIV_CLKCMU_MFCMSCL_M2M,
+	CLK_CON_DIV_CLKCMU_MFCMSCL_MCSC,
+	CLK_CON_DIV_CLKCMU_MFCMSCL_MFC,
 	CLK_CON_DIV_CLKCMU_PERI_BUS,
 	CLK_CON_DIV_CLKCMU_PERI_IP,
 	CLK_CON_DIV_CLKCMU_PERI_UART,
@@ -151,6 +171,10 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_GAT_GATE_CLKCMU_IS_GDC,
 	CLK_CON_GAT_GATE_CLKCMU_IS_ITP,
 	CLK_CON_GAT_GATE_CLKCMU_IS_VRA,
+	CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_JPEG,
+	CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_M2M,
+	CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_MCSC,
+	CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_MFC,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_BUS,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_IP,
 	CLK_CON_GAT_GATE_CLKCMU_PERI_UART,
@@ -209,6 +233,15 @@ PNAME(mout_is_vra_p)		= { "dout_shared0_div2", "dout_shared1_div2",
 				    "dout_shared0_div3", "dout_shared1_div3" };
 PNAME(mout_is_gdc_p)		= { "dout_shared0_div2", "dout_shared1_div2",
 				    "dout_shared0_div3", "dout_shared1_div3" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_MFCMSCL */
+PNAME(mout_mfcmscl_mfc_p)	= { "dout_shared1_div2", "dout_shared0_div3",
+				    "dout_shared1_div3", "dout_shared0_div4" };
+PNAME(mout_mfcmscl_m2m_p)	= { "dout_shared1_div2", "dout_shared0_div3",
+				    "dout_shared1_div3", "dout_shared0_div4" };
+PNAME(mout_mfcmscl_mcsc_p)	= { "dout_shared1_div2", "dout_shared0_div3",
+				    "dout_shared1_div3", "dout_shared0_div4" };
+PNAME(mout_mfcmscl_jpeg_p)	= { "dout_shared0_div3", "dout_shared1_div3",
+				    "dout_shared0_div4", "dout_shared1_div4" };
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_PERI */
 PNAME(mout_peri_bus_p)		= { "dout_shared0_div4", "dout_shared1_div4" };
 PNAME(mout_peri_uart_p)		= { "oscclk", "dout_shared0_div4",
@@ -268,6 +301,16 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_IS_GDC, "mout_is_gdc", mout_is_gdc_p,
 	    CLK_CON_MUX_MUX_CLKCMU_IS_GDC, 0, 2),
 
+	/* MFCMSCL */
+	MUX(CLK_MOUT_MFCMSCL_MFC, "mout_mfcmscl_mfc", mout_mfcmscl_mfc_p,
+	    CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_MFC, 0, 2),
+	MUX(CLK_MOUT_MFCMSCL_M2M, "mout_mfcmscl_m2m", mout_mfcmscl_m2m_p,
+	    CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_M2M, 0, 2),
+	MUX(CLK_MOUT_MFCMSCL_MCSC, "mout_mfcmscl_mcsc", mout_mfcmscl_mcsc_p,
+	    CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_MCSC, 0, 2),
+	MUX(CLK_MOUT_MFCMSCL_JPEG, "mout_mfcmscl_jpeg", mout_mfcmscl_jpeg_p,
+	    CLK_CON_MUX_MUX_CLKCMU_MFCMSCL_JPEG, 0, 2),
+
 	/* PERI */
 	MUX(CLK_MOUT_PERI_BUS, "mout_peri_bus", mout_peri_bus_p,
 	    CLK_CON_MUX_MUX_CLKCMU_PERI_BUS, 0, 1),
@@ -332,6 +375,16 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	DIV(CLK_DOUT_IS_GDC, "dout_is_gdc", "gout_is_gdc",
 	    CLK_CON_DIV_CLKCMU_IS_GDC, 0, 4),
 
+	/* MFCMSCL */
+	DIV(CLK_DOUT_MFCMSCL_MFC, "dout_mfcmscl_mfc", "gout_mfcmscl_mfc",
+	    CLK_CON_DIV_CLKCMU_MFCMSCL_MFC, 0, 4),
+	DIV(CLK_DOUT_MFCMSCL_M2M, "dout_mfcmscl_m2m", "gout_mfcmscl_m2m",
+	    CLK_CON_DIV_CLKCMU_MFCMSCL_M2M, 0, 4),
+	DIV(CLK_DOUT_MFCMSCL_MCSC, "dout_mfcmscl_mcsc", "gout_mfcmscl_mcsc",
+	    CLK_CON_DIV_CLKCMU_MFCMSCL_MCSC, 0, 4),
+	DIV(CLK_DOUT_MFCMSCL_JPEG, "dout_mfcmscl_jpeg", "gout_mfcmscl_jpeg",
+	    CLK_CON_DIV_CLKCMU_MFCMSCL_JPEG, 0, 4),
+
 	/* PERI */
 	DIV(CLK_DOUT_PERI_BUS, "dout_peri_bus", "gout_peri_bus",
 	    CLK_CON_DIV_CLKCMU_PERI_BUS, 0, 4),
@@ -383,6 +436,17 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_IS_GDC, "gout_is_gdc", "mout_is_gdc",
 	     CLK_CON_GAT_GATE_CLKCMU_IS_GDC, 21, CLK_IS_CRITICAL, 0),
 
+	/* MFCMSCL */
+	/* TODO: These have to be always enabled to access CMU_MFCMSCL regs */
+	GATE(CLK_GOUT_MFCMSCL_MFC, "gout_mfcmscl_mfc", "mout_mfcmscl_mfc",
+	     CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_MFC, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_MFCMSCL_M2M, "gout_mfcmscl_m2m", "mout_mfcmscl_m2m",
+	     CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_M2M, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_MFCMSCL_MCSC, "gout_mfcmscl_mcsc", "mout_mfcmscl_mcsc",
+	     CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_MCSC, 21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_MFCMSCL_JPEG, "gout_mfcmscl_jpeg", "mout_mfcmscl_jpeg",
+	     CLK_CON_GAT_GATE_CLKCMU_MFCMSCL_JPEG, 21, CLK_IS_CRITICAL, 0),
+
 	/* PERI */
 	GATE(CLK_GOUT_PERI_BUS, "gout_peri_bus", "mout_peri_bus",
 	     CLK_CON_GAT_GATE_CLKCMU_PERI_BUS, 21, 0, 0),
@@ -1148,6 +1212,115 @@ static const struct samsung_cmu_info is_cmu_info __initconst = {
 	.clk_name		= "dout_is_bus",
 };
 
+/* ---- CMU_MFCMSCL --------------------------------------------------------- */
+
+#define PLL_CON0_MUX_CLKCMU_MFCMSCL_JPEG_USER		0x0600
+#define PLL_CON0_MUX_CLKCMU_MFCMSCL_M2M_USER		0x0610
+#define PLL_CON0_MUX_CLKCMU_MFCMSCL_MCSC_USER		0x0620
+#define PLL_CON0_MUX_CLKCMU_MFCMSCL_MFC_USER		0x0630
+#define CLK_CON_DIV_DIV_CLK_MFCMSCL_BUSP		0x1800
+#define CLK_CON_GAT_CLK_MFCMSCL_CMU_MFCMSCL_PCLK	0x2000
+#define CLK_CON_GAT_GOUT_MFCMSCL_TZPC_PCLK		0x2038
+#define CLK_CON_GAT_GOUT_MFCMSCL_JPEG_ACLK		0x203c
+#define CLK_CON_GAT_GOUT_MFCMSCL_M2M_ACLK		0x2048
+#define CLK_CON_GAT_GOUT_MFCMSCL_MCSC_I_CLK		0x204c
+#define CLK_CON_GAT_GOUT_MFCMSCL_MFC_ACLK		0x2050
+#define CLK_CON_GAT_GOUT_MFCMSCL_PPMU_ACLK		0x2054
+#define CLK_CON_GAT_GOUT_MFCMSCL_PPMU_PCLK		0x2058
+#define CLK_CON_GAT_GOUT_MFCMSCL_SYSMMU_CLK_S1		0x2074
+#define CLK_CON_GAT_GOUT_MFCMSCL_SYSREG_PCLK		0x2078
+
+static const unsigned long mfcmscl_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_MFCMSCL_JPEG_USER,
+	PLL_CON0_MUX_CLKCMU_MFCMSCL_M2M_USER,
+	PLL_CON0_MUX_CLKCMU_MFCMSCL_MCSC_USER,
+	PLL_CON0_MUX_CLKCMU_MFCMSCL_MFC_USER,
+	CLK_CON_DIV_DIV_CLK_MFCMSCL_BUSP,
+	CLK_CON_GAT_CLK_MFCMSCL_CMU_MFCMSCL_PCLK,
+	CLK_CON_GAT_GOUT_MFCMSCL_TZPC_PCLK,
+	CLK_CON_GAT_GOUT_MFCMSCL_JPEG_ACLK,
+	CLK_CON_GAT_GOUT_MFCMSCL_M2M_ACLK,
+	CLK_CON_GAT_GOUT_MFCMSCL_MCSC_I_CLK,
+	CLK_CON_GAT_GOUT_MFCMSCL_MFC_ACLK,
+	CLK_CON_GAT_GOUT_MFCMSCL_PPMU_ACLK,
+	CLK_CON_GAT_GOUT_MFCMSCL_PPMU_PCLK,
+	CLK_CON_GAT_GOUT_MFCMSCL_SYSMMU_CLK_S1,
+	CLK_CON_GAT_GOUT_MFCMSCL_SYSREG_PCLK,
+};
+
+/* List of parent clocks for Muxes in CMU_MFCMSCL */
+PNAME(mout_mfcmscl_mfc_user_p)	= { "oscclk", "dout_mfcmscl_mfc" };
+PNAME(mout_mfcmscl_m2m_user_p)	= { "oscclk", "dout_mfcmscl_m2m" };
+PNAME(mout_mfcmscl_mcsc_user_p)	= { "oscclk", "dout_mfcmscl_mcsc" };
+PNAME(mout_mfcmscl_jpeg_user_p)	= { "oscclk", "dout_mfcmscl_jpeg" };
+
+static const struct samsung_mux_clock mfcmscl_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_MFCMSCL_MFC_USER, "mout_mfcmscl_mfc_user",
+	    mout_mfcmscl_mfc_user_p,
+	    PLL_CON0_MUX_CLKCMU_MFCMSCL_MFC_USER, 4, 1),
+	MUX(CLK_MOUT_MFCMSCL_M2M_USER, "mout_mfcmscl_m2m_user",
+	    mout_mfcmscl_m2m_user_p,
+	    PLL_CON0_MUX_CLKCMU_MFCMSCL_M2M_USER, 4, 1),
+	MUX(CLK_MOUT_MFCMSCL_MCSC_USER, "mout_mfcmscl_mcsc_user",
+	    mout_mfcmscl_mcsc_user_p,
+	    PLL_CON0_MUX_CLKCMU_MFCMSCL_MCSC_USER, 4, 1),
+	MUX(CLK_MOUT_MFCMSCL_JPEG_USER, "mout_mfcmscl_jpeg_user",
+	    mout_mfcmscl_jpeg_user_p,
+	    PLL_CON0_MUX_CLKCMU_MFCMSCL_JPEG_USER, 4, 1),
+};
+
+static const struct samsung_div_clock mfcmscl_div_clks[] __initconst = {
+	DIV(CLK_DOUT_MFCMSCL_BUSP, "dout_mfcmscl_busp", "mout_mfcmscl_mfc_user",
+	    CLK_CON_DIV_DIV_CLK_MFCMSCL_BUSP, 0, 3),
+};
+
+static const struct samsung_gate_clock mfcmscl_gate_clks[] __initconst = {
+	/* TODO: Should be enabled in MFC driver */
+	GATE(CLK_GOUT_MFCMSCL_CMU_MFCMSCL_PCLK, "gout_mfcmscl_cmu_mfcmscl_pclk",
+	     "dout_mfcmscl_busp", CLK_CON_GAT_CLK_MFCMSCL_CMU_MFCMSCL_PCLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_MFCMSCL_TZPC_PCLK, "gout_mfcmscl_tzpc_pclk",
+	     "dout_mfcmscl_busp", CLK_CON_GAT_GOUT_MFCMSCL_TZPC_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_MFCMSCL_JPEG_ACLK, "gout_mfcmscl_jpeg_aclk",
+	     "mout_mfcmscl_jpeg_user", CLK_CON_GAT_GOUT_MFCMSCL_JPEG_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_MFCMSCL_M2M_ACLK, "gout_mfcmscl_m2m_aclk",
+	     "mout_mfcmscl_m2m_user", CLK_CON_GAT_GOUT_MFCMSCL_M2M_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_MFCMSCL_MCSC_CLK, "gout_mfcmscl_mcsc_clk",
+	     "mout_mfcmscl_mcsc_user", CLK_CON_GAT_GOUT_MFCMSCL_MCSC_I_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_MFCMSCL_MFC_ACLK, "gout_mfcmscl_mfc_aclk",
+	     "mout_mfcmscl_mfc_user", CLK_CON_GAT_GOUT_MFCMSCL_MFC_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_MFCMSCL_PPMU_ACLK, "gout_mfcmscl_ppmu_aclk",
+	     "mout_mfcmscl_mfc_user", CLK_CON_GAT_GOUT_MFCMSCL_PPMU_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_MFCMSCL_PPMU_PCLK, "gout_mfcmscl_ppmu_pclk",
+	     "dout_mfcmscl_busp", CLK_CON_GAT_GOUT_MFCMSCL_PPMU_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_MFCMSCL_SYSMMU_CLK, "gout_mfcmscl_sysmmu_clk",
+	     "mout_mfcmscl_mfc_user", CLK_CON_GAT_GOUT_MFCMSCL_SYSMMU_CLK_S1,
+	     21, 0, 0),
+	GATE(CLK_GOUT_MFCMSCL_SYSREG_PCLK, "gout_mfcmscl_sysreg_pclk",
+	     "dout_mfcmscl_busp", CLK_CON_GAT_GOUT_MFCMSCL_SYSREG_PCLK,
+	     21, 0, 0),
+};
+
+static const struct samsung_cmu_info mfcmscl_cmu_info __initconst = {
+	.mux_clks		= mfcmscl_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(mfcmscl_mux_clks),
+	.div_clks		= mfcmscl_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(mfcmscl_div_clks),
+	.gate_clks		= mfcmscl_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(mfcmscl_gate_clks),
+	.nr_clk_ids		= MFCMSCL_NR_CLK,
+	.clk_regs		= mfcmscl_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(mfcmscl_clk_regs),
+	.clk_name		= "dout_mfcmscl_mfc",
+};
+
 /* ---- CMU_PERI ------------------------------------------------------------ */
 
 /* Register Offset definitions for CMU_PERI (0x10030000) */
@@ -1533,6 +1706,9 @@ static const struct of_device_id exynos850_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos850-cmu-is",
 		.data = &is_cmu_info,
+	}, {
+		.compatible = "samsung,exynos850-cmu-mfcmscl",
+		.data = &mfcmscl_cmu_info,
 	}, {
 		.compatible = "samsung,exynos850-cmu-core",
 		.data = &core_cmu_info,
-- 
2.30.2

