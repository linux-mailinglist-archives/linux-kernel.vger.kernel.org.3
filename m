Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520E849824A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiAXOaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:12 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42044 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiAXO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:41 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220124142939epoutp031663d3481737cf613caebd2d9191e328~NOz6uBhst1357213572epoutp03Q
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220124142939epoutp031663d3481737cf613caebd2d9191e328~NOz6uBhst1357213572epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034579;
        bh=qTVoMiSTH12K4fl+27xJQfTYoC4Gy70PZPpBFOYTktg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6UTfI5hADhKfVeyhGE6ZaKThkZx1bRjzNYuX5MxCt5mzA0DPOCM0I6Sf8Gvcts2D
         3GpBcQ7+Pusrnt9nQrB60OXmkOO9+bxXYGY3dxGJ7DbNmQS4lyh9Tn8cKPHBUhqksZ
         GAbVZeElfwe26VOqXxdlYWCiO/2G+TQ00oYhbUUc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220124142938epcas5p17b1ca0d0838aab9a03cb29b612db93f1~NOz6RS8kn3199131991epcas5p17;
        Mon, 24 Jan 2022 14:29:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JjC6k1vPQz4x9Pt; Mon, 24 Jan
        2022 14:29:34 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.5D.46822.076BEE16; Mon, 24 Jan 2022 23:23:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220124142933epcas5p4e69babee0d9ea6f94fef365d79329e20~NOz1GFOqv0105701057epcas5p4G;
        Mon, 24 Jan 2022 14:29:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220124142933epsmtrp1644d0584adf5a8933cc1b153b7e1b9a9~NOz1FBQcU2858928589epsmtrp1f;
        Mon, 24 Jan 2022 14:29:33 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-50-61eeb670da6b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.EA.29871.DC7BEE16; Mon, 24 Jan 2022 23:29:33 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142929epsmtip131167a2419084190b74a1ebb155e2255~NOzxjRdXZ1678816788epsmtip12;
        Mon, 24 Jan 2022 14:29:29 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [PATCH v5 09/16] clk: samsung: fsd: Add cmu_mfc block clock
 information
Date:   Mon, 24 Jan 2022 19:46:37 +0530
Message-Id: <20220124141644.71052-10-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmlm7BtneJBrPXWls8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi7p5tjBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdMfnWJteC/ccWtezdYGhi7dLsYOTkk
        BEwkNjQ/Zepi5OIQEtjNKHG/6R0LSEJI4BOjxNfF8hCJb4wSO45fZIPpeNR3hx2iaC+jxJGb
        LBBFLUwSz/vmMIMk2AS0Je5O38IEYosIuEncaOwAW8EssJJZonfWJbAiYYEgiUk32lhBbBYB
        VYnOrq1gDbwCthKTFy9jhdgmL7F6wwGwek6g+LyF38AGSQjs4JBYf+UvC0SRi8TZczegGoQl
        Xh3fwg5hS0m87G8DsjmA7GyJnl3GEOEaiaXzjkG12kscuDKHBaSEWUBTYv0ufZAwswCfRO/v
        J0wQnbwSHW1CENWqEs3vrkJ1SktM7O6GWuoh8aPlNzMkHCYwSnxu3cM4gVF2FsLUBYyMqxgl
        UwuKc9NTi00LjPJSy+HxlJyfu4kRnFS1vHYwPnzwQe8QIxMH4yFGCQ5mJRHeqpR3iUK8KYmV
        ValF+fFFpTmpxYcYTYFBNpFZSjQ5H5jW80riDU0sDUzMzMxMLI3NDJXEeU+nb0gUEkhPLEnN
        Tk0tSC2C6WPi4JRqYPKsDLgucKr2S0z+xA5Jd10VO/tJPAdO8Wr8/bfpiM7jF4+Mrp9tX+r7
        3XC1Xov8qcz5mQvCf+9L/xPQmOUgVu20S4l1Y0mgeNHzyvlH2t5amxZI/TmxQZMtz16xztLo
        6pZy9lVZEUvs5CU+e3w1e53F+Ger/5qtSy3+3fXdeTOMVZ4puCJa9IHZ1/kO1Ufy/m79c0bw
        5enTklnV3ivj20WmLpKXi/HbPM8szpX5Y8FX+3MC53UKXy1keHXXWka+7/CqAr6vu4xvN27J
        WHhufaHz4hWXT6+wYXPfeviy1MZF+095hK7rYPA+kPRhv9zO2T/SrZ4ksOmVarVcvbBw1uYX
        aUt3cj6Iei551e2u03UlluKMREMt5qLiRACOB/qOMwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO7Z7e8SDd49F7J4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HdtI4vF3T3bGC0eX//D5iDksWbeGkaP378mMXrMauhl89i0qpPN
        4861PWwem5fUe1w50cTq0bdlFaPHv6a57B6fN8kFcEVx2aSk5mSWpRbp2yVwZUx+dYm14L9x
        xa17N1gaGLt0uxg5OSQETCQe9d1hB7GFBHYzSszdyA8Rl5a4vnECO4QtLLHy33MgmwuopolJ
        Yu3V/WAJNgFtibvTtzCB2CICHhJt/+4xgxQxC+xmltg3eSErSEJYIEDicfcssCIWAVWJzq6t
        YDavgK3E5MXLWCE2yEus3nCAGcTmBIrPW/gNqIYDaJuNxLnfKhMY+RYwMqxilEwtKM5Nzy02
        LDDMSy3XK07MLS7NS9dLzs/dxAiOCC3NHYzbV33QO8TIxMF4iFGCg1lJhLcq5V2iEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxy+U82SZxPfhG/68H0
        pfdtVCZ13+/IWat419R68gKOi5WWTUv9Mh/5a/KzLk2t7y479u/ljmnVabtlrHx5HBpfcn61
        i0wX4XtQ1efPqXroYElcdFPcd/GQGKX967a2v8wN9PTLnRxpdLvD3izr9oQKs31xBxhWSVXO
        CbX4ebpnZuCmfZvMM1W+zC2qXC7nmHJRY0Kox9otKhuPHxZ94yqhkl2eo9vGGuslL/Hs0J+p
        rnWSqtaiPOFHmdqnLljxe6Xp9KKdCsyCK5expSjJZleVBJrKyXeuNis2WD6R++v2dC4Wza1H
        5smt7e89r3NhliXPq1PNIf27p6rk2oTuk9l4M3dVqf8UvxJpMZPVSizFGYmGWsxFxYkAAf7V
        TPcCAAA=
X-CMS-MailID: 20220124142933epcas5p4e69babee0d9ea6f94fef365d79329e20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142933epcas5p4e69babee0d9ea6f94fef365d79329e20
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142933epcas5p4e69babee0d9ea6f94fef365d79329e20@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds cmu_mfc clock related code, these clocks are
required for MFC IP.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 121 ++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index f15b5b6b8eca..f9c4b4c5e0cb 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1427,6 +1427,124 @@ static void __init fsd_clk_imem_init(struct device_node *np)
 
 CLK_OF_DECLARE(fsd_clk_imem, "tesla,fsd-clock-imem", fsd_clk_imem_init);
 
+/* Register Offset definitions for CMU_MFC (0x12810000) */
+#define PLL_LOCKTIME_PLL_MFC					0x0
+#define PLL_CON0_PLL_MFC					0x100
+#define MUX_MFC_BUSD						0x1000
+#define MUX_MFC_BUSP						0x1008
+#define DIV_MFC_BUSD_DIV4					0x1800
+#define GAT_MFC_CMU_MFC_IPCLKPORT_PCLK				0x2000
+#define GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKM			0x2004
+#define GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKS			0x2008
+#define GAT_MFC_AXI2APB_MFC_IPCLKPORT_ACLK			0x200c
+#define GAT_MFC_MFC_IPCLKPORT_ACLK				0x2010
+#define GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_D	0x2018
+#define GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_P	0x201c
+#define GAT_MFC_PPMU_MFCD0_IPCLKPORT_ACLK			0x2028
+#define GAT_MFC_PPMU_MFCD0_IPCLKPORT_PCLK			0x202c
+#define GAT_MFC_PPMU_MFCD1_IPCLKPORT_ACLK			0x2030
+#define GAT_MFC_PPMU_MFCD1_IPCLKPORT_PCLK			0x2034
+#define GAT_MFC_SYSREG_MFC_IPCLKPORT_PCLK			0x2038
+#define GAT_MFC_TBU_MFCD0_IPCLKPORT_CLK				0x203c
+#define GAT_MFC_TBU_MFCD1_IPCLKPORT_CLK				0x2040
+#define GAT_MFC_BUSD_DIV4_GATE					0x2044
+#define GAT_MFC_BUSD_GATE					0x2048
+
+static const unsigned long mfc_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_MFC,
+	PLL_CON0_PLL_MFC,
+	MUX_MFC_BUSD,
+	MUX_MFC_BUSP,
+	DIV_MFC_BUSD_DIV4,
+	GAT_MFC_CMU_MFC_IPCLKPORT_PCLK,
+	GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKM,
+	GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKS,
+	GAT_MFC_AXI2APB_MFC_IPCLKPORT_ACLK,
+	GAT_MFC_MFC_IPCLKPORT_ACLK,
+	GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_D,
+	GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_P,
+	GAT_MFC_PPMU_MFCD0_IPCLKPORT_ACLK,
+	GAT_MFC_PPMU_MFCD0_IPCLKPORT_PCLK,
+	GAT_MFC_PPMU_MFCD1_IPCLKPORT_ACLK,
+	GAT_MFC_PPMU_MFCD1_IPCLKPORT_PCLK,
+	GAT_MFC_SYSREG_MFC_IPCLKPORT_PCLK,
+	GAT_MFC_TBU_MFCD0_IPCLKPORT_CLK,
+	GAT_MFC_TBU_MFCD1_IPCLKPORT_CLK,
+	GAT_MFC_BUSD_DIV4_GATE,
+	GAT_MFC_BUSD_GATE,
+};
+
+static const struct samsung_pll_rate_table pll_mfc_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 666000000U, 111, 4, 0),
+};
+
+static const struct samsung_pll_clock mfc_pll_clks[] __initconst = {
+	PLL(pll_142xx, 0, "fout_pll_mfc", "fin_pll",
+	    PLL_LOCKTIME_PLL_MFC, PLL_CON0_PLL_MFC, pll_mfc_rate_table),
+};
+
+PNAME(mout_mfc_pll_p) = { "fin_pll", "fout_pll_mfc" };
+PNAME(mout_mfc_busp_p) = { "fin_pll", "dout_mfc_busd_div4" };
+PNAME(mout_mfc_busd_p) = { "fin_pll", "mfc_busd_gate" };
+
+static const struct samsung_mux_clock mfc_mux_clks[] __initconst = {
+	MUX(0, "mout_mfc_pll", mout_mfc_pll_p, PLL_CON0_PLL_MFC, 4, 1),
+	MUX(0, "mout_mfc_busp", mout_mfc_busp_p, MUX_MFC_BUSP, 0, 1),
+	MUX(0, "mout_mfc_busd", mout_mfc_busd_p, MUX_MFC_BUSD, 0, 1),
+};
+
+static const struct samsung_div_clock mfc_div_clks[] __initconst = {
+	DIV(0, "dout_mfc_busd_div4", "mfc_busd_div4_gate", DIV_MFC_BUSD_DIV4, 0, 4),
+};
+
+static const struct samsung_gate_clock mfc_gate_clks[] __initconst = {
+	GATE(0, "mfc_cmu_mfc_ipclkport_pclk", "mout_mfc_busp",
+	     GAT_MFC_CMU_MFC_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_as_p_mfc_ipclkport_pclkm", "mout_mfc_busd",
+	     GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_as_p_mfc_ipclkport_pclks", "mout_mfc_busp",
+	     GAT_MFC_AS_P_MFC_IPCLKPORT_PCLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_axi2apb_mfc_ipclkport_aclk", "mout_mfc_busp",
+	     GAT_MFC_AXI2APB_MFC_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(MFC_MFC_IPCLKPORT_ACLK, "mfc_mfc_ipclkport_aclk", "mout_mfc_busd",
+	     GAT_MFC_MFC_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ns_brdg_mfc_ipclkport_clk__pmfc__clk_mfc_d", "mout_mfc_busd",
+	     GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_D, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ns_brdg_mfc_ipclkport_clk__pmfc__clk_mfc_p", "mout_mfc_busp",
+	     GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_P, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ppmu_mfcd0_ipclkport_aclk", "mout_mfc_busd",
+	     GAT_MFC_PPMU_MFCD0_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ppmu_mfcd0_ipclkport_pclk", "mout_mfc_busp",
+	     GAT_MFC_PPMU_MFCD0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ppmu_mfcd1_ipclkport_aclk", "mout_mfc_busd",
+	     GAT_MFC_PPMU_MFCD1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_ppmu_mfcd1_ipclkport_pclk", "mout_mfc_busp",
+	     GAT_MFC_PPMU_MFCD1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_sysreg_mfc_ipclkport_pclk", "mout_mfc_busp",
+	     GAT_MFC_SYSREG_MFC_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_tbu_mfcd0_ipclkport_clk", "mout_mfc_busd",
+	     GAT_MFC_TBU_MFCD0_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_tbu_mfcd1_ipclkport_clk", "mout_mfc_busd",
+	     GAT_MFC_TBU_MFCD1_IPCLKPORT_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_busd_div4_gate", "mout_mfc_pll",
+	     GAT_MFC_BUSD_DIV4_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "mfc_busd_gate", "mout_mfc_pll", GAT_MFC_BUSD_GATE, 21, CLK_IS_CRITICAL, 0),
+};
+
+static const struct samsung_cmu_info mfc_cmu_info __initconst = {
+	.pll_clks		= mfc_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(mfc_pll_clks),
+	.mux_clks		= mfc_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(mfc_mux_clks),
+	.div_clks		= mfc_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(mfc_div_clks),
+	.gate_clks		= mfc_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(mfc_gate_clks),
+	.nr_clk_ids		= MFC_NR_CLK,
+	.clk_regs		= mfc_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
+};
+
 /**
  * fsd_cmu_probe - Probe function for FSD platform clocks
  * @pdev: Pointer to platform device
@@ -1455,6 +1573,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
 	}, {
 		.compatible = "tesla,fsd-clock-fsys1",
 		.data = &fsys1_cmu_info,
+	}, {
+		.compatible = "tesla,fsd-clock-mfc",
+		.data = &mfc_cmu_info,
 	}, {
 	},
 };
-- 
2.25.1

