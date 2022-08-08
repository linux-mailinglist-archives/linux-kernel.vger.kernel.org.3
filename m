Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB4D58CD83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbiHHSQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244223AbiHHSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:16:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C03418B17
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:16:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z12so11772537wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tuLfOr4aK0aG7aUyn9vMmiah0JX1RotqMuzARpnKm8o=;
        b=IShjjvfIHip9KAOzOMkjRWB3+w6rS6UvfLMBi5LHAzaDP1TyKJ71QIwHw+ij9eBp6R
         cbrSUOAhSIOUzn/q6UKpp/ZPNAlVvZmZyBfnu/AXVHfhheVsxzrC3sNTMvuzz6XS9ABm
         pWmBLwPJRIWjxKD0fg5LetRm8cozV+SmjIX7S6olqCjFnTWlHdLOhcUsg0a5qRyxEwgX
         hrkaW+6JOQmkoh8qM47+SWi9YeiU79h03SDNDIq84SaWbneqDRm+uxoEHftaG1HbUjbe
         fn7mWLgxx+qQJZ5dQ2hhAeq8MxAa72z8j8LMIFxFw0owvikwQKEOu8saMXfg/T8TNpu+
         DuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tuLfOr4aK0aG7aUyn9vMmiah0JX1RotqMuzARpnKm8o=;
        b=bT7WTobPQWp+Gx4+1L/a6unIYIVyq1Uv7eA+2E4vfd+JY8em6Kj4hcJY+PK7ng2xQ/
         sfJefJjxpOD95DaVUB71tyP+Rt69ZfURk2td1OpLfSv9B1qPpBivRq2L7r/FB2oeOR/N
         idLo7klTFpAiIlsvjs/Yo2OedFXsojaZW/AG6r5f+6jizBP/aqVsu2NnMiA9WsNmAMDg
         LNbAHd0WBwkUxqIIvLFmdSUMVOgHVTPrPf3KsQ3O4l6GQR+gmsZpV+dm/C6W1/dGnbiU
         mDmfCkl8LB6RcwsE0quHW+wjKeMG6YzREb9cNdp2jnkYMeqh5QQxFbDZGBqLH2EM2fAH
         uGgQ==
X-Gm-Message-State: ACgBeo0pnfOhOmkiaJNWlbKKAbu8evTMJ/vySHw4uWkNX55ZmETeVJzN
        o2xXBqRHfmTMibhVDxiz5oXI2g==
X-Google-Smtp-Source: AA6agR4JoAt6pENUA81V0lZU6Q5ASbEETCzSZ+LBZbQYL8aOEnup13mpmU8EjgMwkekyqY7RkpgQYw==
X-Received: by 2002:a05:6000:184d:b0:220:8235:132 with SMTP id c13-20020a056000184d00b0022082350132mr12402319wri.178.1659982564345;
        Mon, 08 Aug 2022 11:16:04 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d48c1000000b0021e6277bc50sm14103837wrs.36.2022.08.08.11.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:16:03 -0700 (PDT)
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
Subject: [PATCH 5/7] clk: samsung: exynos850: Implement CMU_AUD domain
Date:   Mon,  8 Aug 2022 21:16:03 +0300
Message-Id: <20220808181603.10595-1-semen.protsenko@linaro.org>
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

CMU_AUD clock domain provides clocks for ABOX IP-core (audio subsystem).
According to Exynos850 TRM, CMU_AUD generates Cortex-A32 clock, bus
clock and audio clocks for BLK_AUD.

This patch adds next clocks:
  - bus clocks in CMU_TOP needed for CMU_AUD
  - all internal CMU_AUD clocks
  - leaf clocks for Cortex-A32, Speedy FM, UAIF0..UAIF6 (Unified Audio
    Interface), CNT (counter), ABOX IP-core, ASB (Asynchronous Bridge),
    DAP (Debug Access Port), I2S Codec MCLK, D_TZPC (TrustZone
    Protection Controller), GPIO, PPMU (Platform Performance Monitoring
    Unit), SysMMU, SysReg and WDT

ABOX clock was marked as CLK_IGNORE_UNUSED, as system hangs on boot
otherwise. Once ABOX driver is implemented, maybe it can be handled
there instead.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 302 ++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index ef32546d3090..c91984f3f14f 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -30,6 +30,7 @@
 #define PLL_CON0_PLL_SHARED1			0x0180
 #define PLL_CON3_PLL_SHARED1			0x018c
 #define CLK_CON_MUX_MUX_CLKCMU_APM_BUS		0x1000
+#define CLK_CON_MUX_MUX_CLKCMU_AUD		0x1004
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_BUS		0x1014
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_CCI		0x1018
 #define CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD	0x101c
@@ -42,6 +43,7 @@
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_IP		0x1074
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_UART	0x1078
 #define CLK_CON_DIV_CLKCMU_APM_BUS		0x180c
+#define CLK_CON_DIV_CLKCMU_AUD			0x1810
 #define CLK_CON_DIV_CLKCMU_CORE_BUS		0x1820
 #define CLK_CON_DIV_CLKCMU_CORE_CCI		0x1824
 #define CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD	0x1828
@@ -60,6 +62,7 @@
 #define CLK_CON_DIV_PLL_SHARED1_DIV3		0x189c
 #define CLK_CON_DIV_PLL_SHARED1_DIV4		0x18a0
 #define CLK_CON_GAT_GATE_CLKCMU_APM_BUS		0x2008
+#define CLK_CON_GAT_GATE_CLKCMU_AUD		0x200c
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_BUS	0x201c
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_CCI	0x2020
 #define CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD	0x2024
@@ -83,6 +86,7 @@ static const unsigned long top_clk_regs[] __initconst = {
 	PLL_CON0_PLL_SHARED1,
 	PLL_CON3_PLL_SHARED1,
 	CLK_CON_MUX_MUX_CLKCMU_APM_BUS,
+	CLK_CON_MUX_MUX_CLKCMU_AUD,
 	CLK_CON_MUX_MUX_CLKCMU_CORE_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_CORE_CCI,
 	CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD,
@@ -95,6 +99,7 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_MUX_MUX_CLKCMU_PERI_IP,
 	CLK_CON_MUX_MUX_CLKCMU_PERI_UART,
 	CLK_CON_DIV_CLKCMU_APM_BUS,
+	CLK_CON_DIV_CLKCMU_AUD,
 	CLK_CON_DIV_CLKCMU_CORE_BUS,
 	CLK_CON_DIV_CLKCMU_CORE_CCI,
 	CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD,
@@ -113,6 +118,7 @@ static const unsigned long top_clk_regs[] __initconst = {
 	CLK_CON_DIV_PLL_SHARED1_DIV3,
 	CLK_CON_DIV_PLL_SHARED1_DIV4,
 	CLK_CON_GAT_GATE_CLKCMU_APM_BUS,
+	CLK_CON_GAT_GATE_CLKCMU_AUD,
 	CLK_CON_GAT_GATE_CLKCMU_CORE_BUS,
 	CLK_CON_GAT_GATE_CLKCMU_CORE_CCI,
 	CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD,
@@ -148,6 +154,9 @@ PNAME(mout_shared1_pll_p)	= { "oscclk", "fout_shared1_pll" };
 PNAME(mout_mmc_pll_p)		= { "oscclk", "fout_mmc_pll" };
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_APM */
 PNAME(mout_clkcmu_apm_bus_p)	= { "dout_shared0_div4", "pll_shared1_div4" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_AUD */
+PNAME(mout_aud_p)		= { "fout_shared1_pll", "dout_shared0_div2",
+				    "dout_shared1_div2", "dout_shared0_div3" };
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_CORE */
 PNAME(mout_core_bus_p)		= { "dout_shared1_div2", "dout_shared0_div3",
 				    "dout_shared1_div3", "dout_shared0_div4" };
@@ -190,6 +199,10 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_CLKCMU_APM_BUS, "mout_clkcmu_apm_bus",
 	    mout_clkcmu_apm_bus_p, CLK_CON_MUX_MUX_CLKCMU_APM_BUS, 0, 1),
 
+	/* AUD */
+	MUX(CLK_MOUT_AUD, "mout_aud", mout_aud_p,
+	    CLK_CON_MUX_MUX_CLKCMU_AUD, 0, 2),
+
 	/* CORE */
 	MUX(CLK_MOUT_CORE_BUS, "mout_core_bus", mout_core_bus_p,
 	    CLK_CON_MUX_MUX_CLKCMU_CORE_BUS, 0, 2),
@@ -240,6 +253,10 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	DIV(CLK_DOUT_CLKCMU_APM_BUS, "dout_clkcmu_apm_bus",
 	    "gout_clkcmu_apm_bus", CLK_CON_DIV_CLKCMU_APM_BUS, 0, 3),
 
+	/* AUD */
+	DIV(CLK_DOUT_AUD, "dout_aud", "gout_aud",
+	    CLK_CON_DIV_CLKCMU_AUD, 0, 4),
+
 	/* CORE */
 	DIV(CLK_DOUT_CORE_BUS, "dout_core_bus", "gout_core_bus",
 	    CLK_CON_DIV_CLKCMU_CORE_BUS, 0, 4),
@@ -286,6 +303,10 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_CLKCMU_APM_BUS, "gout_clkcmu_apm_bus",
 	     "mout_clkcmu_apm_bus", CLK_CON_GAT_GATE_CLKCMU_APM_BUS, 21, 0, 0),
 
+	/* AUD */
+	GATE(CLK_GOUT_AUD, "gout_aud", "mout_aud",
+	     CLK_CON_GAT_GATE_CLKCMU_AUD, 21, 0, 0),
+
 	/* DPU */
 	GATE(CLK_GOUT_DPU, "gout_dpu", "mout_dpu",
 	     CLK_CON_GAT_GATE_CLKCMU_DPU, 21, 0, 0),
@@ -462,6 +483,284 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
 	.clk_name		= "dout_clkcmu_apm_bus",
 };
 
+/* ---- CMU_AUD ------------------------------------------------------------- */
+
+#define PLL_LOCKTIME_PLL_AUD			0x0000
+#define PLL_CON0_PLL_AUD			0x0100
+#define PLL_CON3_PLL_AUD			0x010c
+#define PLL_CON0_MUX_CLKCMU_AUD_CPU_USER	0x0600
+#define PLL_CON0_MUX_TICK_USB_USER		0x0610
+#define CLK_CON_MUX_MUX_CLK_AUD_CPU		0x1000
+#define CLK_CON_MUX_MUX_CLK_AUD_CPU_HCH		0x1004
+#define CLK_CON_MUX_MUX_CLK_AUD_FM		0x1008
+#define CLK_CON_MUX_MUX_CLK_AUD_UAIF0		0x100c
+#define CLK_CON_MUX_MUX_CLK_AUD_UAIF1		0x1010
+#define CLK_CON_MUX_MUX_CLK_AUD_UAIF2		0x1014
+#define CLK_CON_MUX_MUX_CLK_AUD_UAIF3		0x1018
+#define CLK_CON_MUX_MUX_CLK_AUD_UAIF4		0x101c
+#define CLK_CON_MUX_MUX_CLK_AUD_UAIF5		0x1020
+#define CLK_CON_MUX_MUX_CLK_AUD_UAIF6		0x1024
+#define CLK_CON_DIV_DIV_CLK_AUD_MCLK		0x1800
+#define CLK_CON_DIV_DIV_CLK_AUD_AUDIF		0x1804
+#define CLK_CON_DIV_DIV_CLK_AUD_BUSD		0x1808
+#define CLK_CON_DIV_DIV_CLK_AUD_BUSP		0x180c
+#define CLK_CON_DIV_DIV_CLK_AUD_CNT		0x1810
+#define CLK_CON_DIV_DIV_CLK_AUD_CPU		0x1814
+#define CLK_CON_DIV_DIV_CLK_AUD_CPU_ACLK	0x1818
+#define CLK_CON_DIV_DIV_CLK_AUD_CPU_PCLKDBG	0x181c
+#define CLK_CON_DIV_DIV_CLK_AUD_FM		0x1820
+#define CLK_CON_DIV_DIV_CLK_AUD_FM_SPDY		0x1824
+#define CLK_CON_DIV_DIV_CLK_AUD_UAIF0		0x1828
+#define CLK_CON_DIV_DIV_CLK_AUD_UAIF1		0x182c
+#define CLK_CON_DIV_DIV_CLK_AUD_UAIF2		0x1830
+#define CLK_CON_DIV_DIV_CLK_AUD_UAIF3		0x1834
+#define CLK_CON_DIV_DIV_CLK_AUD_UAIF4		0x1838
+#define CLK_CON_DIV_DIV_CLK_AUD_UAIF5		0x183c
+#define CLK_CON_DIV_DIV_CLK_AUD_UAIF6		0x1840
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_CNT	0x2000
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF0	0x2004
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF1	0x2008
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF2	0x200c
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF3	0x2010
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF4	0x2014
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF5	0x2018
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF6	0x201c
+#define CLK_CON_GAT_GOUT_AUD_ABOX_ACLK		0x2048
+#define CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_SPDY	0x204c
+#define CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_ASB	0x2050
+#define CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_CA32	0x2054
+#define CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_DAP	0x2058
+#define CLK_CON_GAT_GOUT_AUD_CODEC_MCLK		0x206c
+#define CLK_CON_GAT_GOUT_AUD_TZPC_PCLK		0x2070
+#define CLK_CON_GAT_GOUT_AUD_GPIO_PCLK		0x2074
+#define CLK_CON_GAT_GOUT_AUD_PPMU_ACLK		0x2088
+#define CLK_CON_GAT_GOUT_AUD_PPMU_PCLK		0x208c
+#define CLK_CON_GAT_GOUT_AUD_SYSMMU_CLK_S1	0x20b4
+#define CLK_CON_GAT_GOUT_AUD_SYSREG_PCLK	0x20b8
+#define CLK_CON_GAT_GOUT_AUD_WDT_PCLK		0x20bc
+
+static const unsigned long aud_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_AUD,
+	PLL_CON0_PLL_AUD,
+	PLL_CON3_PLL_AUD,
+	PLL_CON0_MUX_CLKCMU_AUD_CPU_USER,
+	PLL_CON0_MUX_TICK_USB_USER,
+	CLK_CON_MUX_MUX_CLK_AUD_CPU,
+	CLK_CON_MUX_MUX_CLK_AUD_CPU_HCH,
+	CLK_CON_MUX_MUX_CLK_AUD_FM,
+	CLK_CON_MUX_MUX_CLK_AUD_UAIF0,
+	CLK_CON_MUX_MUX_CLK_AUD_UAIF1,
+	CLK_CON_MUX_MUX_CLK_AUD_UAIF2,
+	CLK_CON_MUX_MUX_CLK_AUD_UAIF3,
+	CLK_CON_MUX_MUX_CLK_AUD_UAIF4,
+	CLK_CON_MUX_MUX_CLK_AUD_UAIF5,
+	CLK_CON_MUX_MUX_CLK_AUD_UAIF6,
+	CLK_CON_DIV_DIV_CLK_AUD_MCLK,
+	CLK_CON_DIV_DIV_CLK_AUD_AUDIF,
+	CLK_CON_DIV_DIV_CLK_AUD_BUSD,
+	CLK_CON_DIV_DIV_CLK_AUD_BUSP,
+	CLK_CON_DIV_DIV_CLK_AUD_CNT,
+	CLK_CON_DIV_DIV_CLK_AUD_CPU,
+	CLK_CON_DIV_DIV_CLK_AUD_CPU_ACLK,
+	CLK_CON_DIV_DIV_CLK_AUD_CPU_PCLKDBG,
+	CLK_CON_DIV_DIV_CLK_AUD_FM,
+	CLK_CON_DIV_DIV_CLK_AUD_FM_SPDY,
+	CLK_CON_DIV_DIV_CLK_AUD_UAIF0,
+	CLK_CON_DIV_DIV_CLK_AUD_UAIF1,
+	CLK_CON_DIV_DIV_CLK_AUD_UAIF2,
+	CLK_CON_DIV_DIV_CLK_AUD_UAIF3,
+	CLK_CON_DIV_DIV_CLK_AUD_UAIF4,
+	CLK_CON_DIV_DIV_CLK_AUD_UAIF5,
+	CLK_CON_DIV_DIV_CLK_AUD_UAIF6,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_CNT,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF0,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF1,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF2,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF3,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF4,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF5,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF6,
+	CLK_CON_GAT_GOUT_AUD_ABOX_ACLK,
+	CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_SPDY,
+	CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_ASB,
+	CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_CA32,
+	CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_DAP,
+	CLK_CON_GAT_GOUT_AUD_CODEC_MCLK,
+	CLK_CON_GAT_GOUT_AUD_TZPC_PCLK,
+	CLK_CON_GAT_GOUT_AUD_GPIO_PCLK,
+	CLK_CON_GAT_GOUT_AUD_PPMU_ACLK,
+	CLK_CON_GAT_GOUT_AUD_PPMU_PCLK,
+	CLK_CON_GAT_GOUT_AUD_SYSMMU_CLK_S1,
+	CLK_CON_GAT_GOUT_AUD_SYSREG_PCLK,
+	CLK_CON_GAT_GOUT_AUD_WDT_PCLK,
+};
+
+/* List of parent clocks for Muxes in CMU_AUD */
+PNAME(mout_aud_pll_p)		= { "oscclk", "fout_aud_pll" };
+PNAME(mout_aud_cpu_user_p)	= { "oscclk", "dout_aud" };
+PNAME(mout_aud_cpu_p)		= { "dout_aud_cpu", "mout_aud_cpu_user" };
+PNAME(mout_aud_cpu_hch_p)	= { "mout_aud_cpu", "oscclk" };
+PNAME(mout_aud_uaif0_p)		= { "dout_aud_uaif0", "ioclk_audiocdclk0" };
+PNAME(mout_aud_uaif1_p)		= { "dout_aud_uaif1", "ioclk_audiocdclk1" };
+PNAME(mout_aud_uaif2_p)		= { "dout_aud_uaif2", "ioclk_audiocdclk2" };
+PNAME(mout_aud_uaif3_p)		= { "dout_aud_uaif3", "ioclk_audiocdclk3" };
+PNAME(mout_aud_uaif4_p)		= { "dout_aud_uaif4", "ioclk_audiocdclk4" };
+PNAME(mout_aud_uaif5_p)		= { "dout_aud_uaif5", "ioclk_audiocdclk5" };
+PNAME(mout_aud_uaif6_p)		= { "dout_aud_uaif6", "ioclk_audiocdclk6" };
+PNAME(mout_aud_tick_usb_user_p)	= { "oscclk", "tick_usb" };
+PNAME(mout_aud_fm_p)		= { "oscclk", "dout_aud_fm_spdy" };
+
+/*
+ * Do not provide PLL table to PLL_AUD, as MANUAL_PLL_CTRL bit is not set
+ * for that PLL by default, so set_rate operation would fail.
+ */
+static const struct samsung_pll_clock aud_pll_clks[] __initconst = {
+	PLL(pll_0831x, CLK_FOUT_AUD_PLL, "fout_aud_pll", "oscclk",
+	    PLL_LOCKTIME_PLL_AUD, PLL_CON3_PLL_AUD, NULL),
+};
+
+static const struct samsung_fixed_rate_clock aud_fixed_clks[] __initconst = {
+	FRATE(IOCLK_AUDIOCDCLK0, "ioclk_audiocdclk0", NULL, 0, 25000000),
+	FRATE(IOCLK_AUDIOCDCLK1, "ioclk_audiocdclk1", NULL, 0, 25000000),
+	FRATE(IOCLK_AUDIOCDCLK2, "ioclk_audiocdclk2", NULL, 0, 25000000),
+	FRATE(IOCLK_AUDIOCDCLK3, "ioclk_audiocdclk3", NULL, 0, 25000000),
+	FRATE(IOCLK_AUDIOCDCLK4, "ioclk_audiocdclk4", NULL, 0, 25000000),
+	FRATE(IOCLK_AUDIOCDCLK5, "ioclk_audiocdclk5", NULL, 0, 25000000),
+	FRATE(IOCLK_AUDIOCDCLK6, "ioclk_audiocdclk6", NULL, 0, 25000000),
+	FRATE(TICK_USB, "tick_usb", NULL, 0, 60000000),
+};
+
+static const struct samsung_mux_clock aud_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p,
+	    PLL_CON0_PLL_AUD, 4, 1),
+	MUX(CLK_MOUT_AUD_CPU_USER, "mout_aud_cpu_user", mout_aud_cpu_user_p,
+	    PLL_CON0_MUX_CLKCMU_AUD_CPU_USER, 4, 1),
+	MUX(CLK_MOUT_AUD_TICK_USB_USER, "mout_aud_tick_usb_user",
+	    mout_aud_tick_usb_user_p,
+	    PLL_CON0_MUX_TICK_USB_USER, 4, 1),
+	MUX(CLK_MOUT_AUD_CPU, "mout_aud_cpu", mout_aud_cpu_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_CPU, 0, 1),
+	MUX(CLK_MOUT_AUD_CPU_HCH, "mout_aud_cpu_hch", mout_aud_cpu_hch_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_CPU_HCH, 0, 1),
+	MUX(CLK_MOUT_AUD_UAIF0, "mout_aud_uaif0", mout_aud_uaif0_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_UAIF0, 0, 1),
+	MUX(CLK_MOUT_AUD_UAIF1, "mout_aud_uaif1", mout_aud_uaif1_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_UAIF1, 0, 1),
+	MUX(CLK_MOUT_AUD_UAIF2, "mout_aud_uaif2", mout_aud_uaif2_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_UAIF2, 0, 1),
+	MUX(CLK_MOUT_AUD_UAIF3, "mout_aud_uaif3", mout_aud_uaif3_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_UAIF3, 0, 1),
+	MUX(CLK_MOUT_AUD_UAIF4, "mout_aud_uaif4", mout_aud_uaif4_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_UAIF4, 0, 1),
+	MUX(CLK_MOUT_AUD_UAIF5, "mout_aud_uaif5", mout_aud_uaif5_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_UAIF5, 0, 1),
+	MUX(CLK_MOUT_AUD_UAIF6, "mout_aud_uaif6", mout_aud_uaif6_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_UAIF6, 0, 1),
+	MUX(CLK_MOUT_AUD_FM, "mout_aud_fm", mout_aud_fm_p,
+	    CLK_CON_MUX_MUX_CLK_AUD_FM, 0, 1),
+};
+
+static const struct samsung_div_clock aud_div_clks[] __initconst = {
+	DIV(CLK_DOUT_AUD_CPU, "dout_aud_cpu", "mout_aud_pll",
+	    CLK_CON_DIV_DIV_CLK_AUD_CPU, 0, 4),
+	DIV(CLK_DOUT_AUD_BUSD, "dout_aud_busd", "mout_aud_pll",
+	    CLK_CON_DIV_DIV_CLK_AUD_BUSD, 0, 4),
+	DIV(CLK_DOUT_AUD_BUSP, "dout_aud_busp", "mout_aud_pll",
+	    CLK_CON_DIV_DIV_CLK_AUD_BUSP, 0, 4),
+	DIV(CLK_DOUT_AUD_AUDIF, "dout_aud_audif", "mout_aud_pll",
+	    CLK_CON_DIV_DIV_CLK_AUD_AUDIF, 0, 9),
+	DIV(CLK_DOUT_AUD_CPU_ACLK, "dout_aud_cpu_aclk", "mout_aud_cpu_hch",
+	    CLK_CON_DIV_DIV_CLK_AUD_CPU_ACLK, 0, 3),
+	DIV(CLK_DOUT_AUD_CPU_PCLKDBG, "dout_aud_cpu_pclkdbg",
+	    "mout_aud_cpu_hch",
+	    CLK_CON_DIV_DIV_CLK_AUD_CPU_PCLKDBG, 0, 3),
+	DIV(CLK_DOUT_AUD_MCLK, "dout_aud_mclk", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_MCLK, 0, 2),
+	DIV(CLK_DOUT_AUD_CNT, "dout_aud_cnt", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_CNT, 0, 10),
+	DIV(CLK_DOUT_AUD_UAIF0, "dout_aud_uaif0", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_UAIF0, 0, 10),
+	DIV(CLK_DOUT_AUD_UAIF1, "dout_aud_uaif1", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_UAIF1, 0, 10),
+	DIV(CLK_DOUT_AUD_UAIF2, "dout_aud_uaif2", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_UAIF2, 0, 10),
+	DIV(CLK_DOUT_AUD_UAIF3, "dout_aud_uaif3", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_UAIF3, 0, 10),
+	DIV(CLK_DOUT_AUD_UAIF4, "dout_aud_uaif4", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_UAIF4, 0, 10),
+	DIV(CLK_DOUT_AUD_UAIF5, "dout_aud_uaif5", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_UAIF5, 0, 10),
+	DIV(CLK_DOUT_AUD_UAIF6, "dout_aud_uaif6", "dout_aud_audif",
+	    CLK_CON_DIV_DIV_CLK_AUD_UAIF6, 0, 10),
+	DIV(CLK_DOUT_AUD_FM_SPDY, "dout_aud_fm_spdy", "mout_aud_tick_usb_user",
+	    CLK_CON_DIV_DIV_CLK_AUD_FM_SPDY, 0, 1),
+	DIV(CLK_DOUT_AUD_FM, "dout_aud_fm", "mout_aud_fm",
+	    CLK_CON_DIV_DIV_CLK_AUD_FM, 0, 10),
+};
+
+static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_AUD_CA32_CCLK, "gout_aud_ca32_cclk", "mout_aud_cpu_hch",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_CA32, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_ASB_CCLK, "gout_aud_asb_cclk", "dout_aud_cpu_aclk",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_ASB, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_DAP_CCLK, "gout_aud_dap_cclk", "dout_aud_cpu_pclkdbg",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_CCLK_DAP, 21, 0, 0),
+	/* TODO: Should be enabled in ABOX driver (or made CLK_IS_CRITICAL) */
+	GATE(CLK_GOUT_AUD_ABOX_ACLK, "gout_aud_abox_aclk", "dout_aud_busd",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_AUD_GPIO_PCLK, "gout_aud_gpio_pclk", "dout_aud_busd",
+	     CLK_CON_GAT_GOUT_AUD_GPIO_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_PPMU_ACLK, "gout_aud_ppmu_aclk", "dout_aud_busd",
+	     CLK_CON_GAT_GOUT_AUD_PPMU_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_PPMU_PCLK, "gout_aud_ppmu_pclk", "dout_aud_busd",
+	     CLK_CON_GAT_GOUT_AUD_PPMU_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_SYSMMU_CLK, "gout_aud_sysmmu_clk", "dout_aud_busd",
+	     CLK_CON_GAT_GOUT_AUD_SYSMMU_CLK_S1, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_SYSREG_PCLK, "gout_aud_sysreg_pclk", "dout_aud_busd",
+	     CLK_CON_GAT_GOUT_AUD_SYSREG_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_WDT_PCLK, "gout_aud_wdt_pclk", "dout_aud_busd",
+	     CLK_CON_GAT_GOUT_AUD_WDT_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_TZPC_PCLK, "gout_aud_tzpc_pclk", "dout_aud_busp",
+	     CLK_CON_GAT_GOUT_AUD_TZPC_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_CODEC_MCLK, "gout_aud_codec_mclk", "dout_aud_mclk",
+	     CLK_CON_GAT_GOUT_AUD_CODEC_MCLK, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_CNT_BCLK, "gout_aud_cnt_bclk", "dout_aud_cnt",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_CNT, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_UAIF0_BCLK, "gout_aud_uaif0_bclk", "mout_aud_uaif0",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF0, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_UAIF1_BCLK, "gout_aud_uaif1_bclk", "mout_aud_uaif1",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF1, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_UAIF2_BCLK, "gout_aud_uaif2_bclk", "mout_aud_uaif2",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF2, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_UAIF3_BCLK, "gout_aud_uaif3_bclk", "mout_aud_uaif3",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF3, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_UAIF4_BCLK, "gout_aud_uaif4_bclk", "mout_aud_uaif4",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF4, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_UAIF5_BCLK, "gout_aud_uaif5_bclk", "mout_aud_uaif5",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF5, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_UAIF6_BCLK, "gout_aud_uaif6_bclk", "mout_aud_uaif6",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_UAIF6, 21, 0, 0),
+	GATE(CLK_GOUT_AUD_SPDY_BCLK, "gout_aud_spdy_bclk", "dout_aud_fm",
+	     CLK_CON_GAT_GOUT_AUD_ABOX_BCLK_SPDY, 21, 0, 0),
+};
+
+static const struct samsung_cmu_info aud_cmu_info __initconst = {
+	.pll_clks		= aud_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(aud_pll_clks),
+	.mux_clks		= aud_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(aud_mux_clks),
+	.div_clks		= aud_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(aud_div_clks),
+	.gate_clks		= aud_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(aud_gate_clks),
+	.fixed_clks		= aud_fixed_clks,
+	.nr_fixed_clks		= ARRAY_SIZE(aud_fixed_clks),
+	.nr_clk_ids		= AUD_NR_CLK,
+	.clk_regs		= aud_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
+	.clk_name		= "dout_aud",
+};
+
 /* ---- CMU_CMGP ------------------------------------------------------------ */
 
 /* Register Offset definitions for CMU_CMGP (0x11c00000) */
@@ -1026,6 +1325,9 @@ static const struct of_device_id exynos850_cmu_of_match[] = {
 	{
 		.compatible = "samsung,exynos850-cmu-apm",
 		.data = &apm_cmu_info,
+	}, {
+		.compatible = "samsung,exynos850-cmu-aud",
+		.data = &aud_cmu_info,
 	}, {
 		.compatible = "samsung,exynos850-cmu-cmgp",
 		.data = &cmgp_cmu_info,
-- 
2.30.2

