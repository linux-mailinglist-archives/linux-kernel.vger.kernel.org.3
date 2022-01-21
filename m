Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303B9496435
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381473AbiAURmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:42:12 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16264 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381868AbiAURlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:41:07 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220121174105epoutp02a87ff49b2674c3bd8625e25d694e3906~MWfNJ7tgP0775707757epoutp02e
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220121174105epoutp02a87ff49b2674c3bd8625e25d694e3906~MWfNJ7tgP0775707757epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786865;
        bh=WJWCI/tmYyu57P3UivtA7VMkm/RuuZ34Ng3G8ZQDCwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuFDruKEXLE74byabZiubeWxFdPpNcr0r1IuypzAFodd+LWAQVIumL2Ewcl+S/WRT
         ol5c+m3bWgkt/y1JjcHKrMItTWYJOMUWwLe8yfAi17Fx/eT0MqRrPqvyWuIe90vtA7
         HEgPi3JyW1CAOBvQ0AiBm1BpzJ8NhBMol0aJEoLs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220121174104epcas5p1e5ba2e8ead91f7c7bd6ac719c99f6179~MWfL9Juo_1336113361epcas5p1N;
        Fri, 21 Jan 2022 17:41:04 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JgRVy6HbPz4x9Pt; Fri, 21 Jan
        2022 17:40:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.B5.05590.A20FAE16; Sat, 22 Jan 2022 02:40:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220121174058epcas5p13276d857b7a9d3d24c84d5b46e0556fd~MWfGPyrIR1336113361epcas5p1J;
        Fri, 21 Jan 2022 17:40:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121174058epsmtrp1a9929ca218a8a4af20a5c4777d869052~MWfGO4lkh2608726087epsmtrp1X;
        Fri, 21 Jan 2022 17:40:58 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-1c-61eaf02a143b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.B7.08738.920FAE16; Sat, 22 Jan 2022 02:40:58 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174055epsmtip23611fff6122540c54ce2355ee76a13ac~MWfDzrKhp2322623226epsmtip2j;
        Fri, 21 Jan 2022 17:40:55 +0000 (GMT)
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
Subject: [PATCH v3 09/16] clk: samsung: fsd: Add cmu_mfc block clock
 information
Date:   Fri, 21 Jan 2022 22:58:33 +0530
Message-Id: <20220121172840.12121-10-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmlq7Wh1eJBn/WGVo8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi7p5tjBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGccffWfteCfccWF3l7WBsZO3S5GTg4J
        AROJ3Ru2MHYxcnEICexmlLj76R4ThPOJUWJm4x+ozGcg58xDVpiWnq17oap2MUq0L/jCAuG0
        MEm0d1xhBKliE9CWuDt9CxOILSLgJnGjsQOsg1lgJbNE76xLzCAJYYEgiQudPWBFLAKqElNW
        7weL8wrYSny+u50NYp28xOoNB8DinEDx12fnMYMMkhDYwyHxe0Uj1E0uEhtXX2CCsIUlXh3f
        wg5hS0m87G8DsjmA7GyJnl3GEOEaiaXzjrFA2PYSB67MYQEpYRbQlFi/Sx8kzCzAJ9H7+wkT
        RCevREebEES1qkTzu6tQndISE7u7oQ7wkDiw7SM7JBwmMErsn97GOIFRdhbC1AWMjKsYJVML
        inPTU4tNC4zzUsvhMZWcn7uJEZxYtbx3MD568EHvECMTB+MhRgkOZiUR3oL8V4lCvCmJlVWp
        RfnxRaU5qcWHGE2BQTaRWUo0OR+Y2vNK4g1NLA1MzMzMTCyNzQyVxHlPpW9IFBJITyxJzU5N
        LUgtgulj4uCUamA6Xui3PLP7GC+j+KX3u3o2ln8oOLLiYFTrql8i8i/nMPv6LLM/HqrLVOmb
        tXAVz9tV/sWWzD2Jnb5qbBWMD2eU3/p9uCm/+qDb3ZyiR+/n3rBZznD1fdE/gdRTh8JWm19v
        bXU+O3OPF2vxY5U5TjKGF3eFTXueylu08cy/ny0XOlddPF7QvfjE7nkRbpk3jt4Ve1febnj4
        flqwu/cVq8nNe2IvGD3ZtuNn3uVnJ//1KjLLsLd8Krtvtf7h3rMPGqWOBZyWyJfapcezkldo
        H98uZb2nDxcbRXGbPu7asf9B3FIPg1nru16sZvvxP2iOesRHcdOSnKSH+T+fXD+Z/eOtk/Y0
        dtM5TC65sxj9F53dpMRSnJFoqMVcVJwIALLajPE1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvK7Wh1eJBq82MVk8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi7p5tjBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Mo6++s9a8M+4
        4kJvL2sDY6duFyMnh4SAiUTP1r1MXYxcHEICOxgl/q/6yQqRkJa4vnECO4QtLLHy33N2iKIm
        JolLTS+ZQRJsAtoSd6dvYQKxRQQ8JNr+3WMGKWIW2M0ssW/yQrBJwgIBEh0T94HZLAKqElNW
        7wdr5hWwlfh8dzsbxAZ5idUbDoDFOYHir8/OA7OFBGwkmmdtZZrAyLeAkWEVo2RqQXFuem6x
        YYFRXmq5XnFibnFpXrpecn7uJkZwVGhp7WDcs+qD3iFGJg7GQ4wSHMxKIrwF+a8ShXhTEiur
        Uovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamAyO2o3i7eXa5OatbxO
        amzn0k/P7CcG8UsJlB6uMGg4xaImtWuen86fCMXpZ+eIKwTdX/Gj+6HZimtRR+8tdF+680FZ
        qjLzvweXjSbe3vZ7p0vRjumRZyVdZL7y8W4yEYpvfNU+6cu9K7UH3V3XGf0WcjzeocWf/3uH
        h1yI7IFj/kfaQtLPyy2d0f1lxpZHc12+WNY6mqVuvSwkHWKcnxZzrVWil+PrlbMSa1gZVCd+
        3rtngyt3iezeJ4LP18y9tlrLNn1/tFfMnlUsCQ3zrLKWfqruTjlwV/PyvYav990MYyc9D15r
        Inp2sq1At0hiwE1vnmCxA756qsIXNSMd3qa828dxn9X4lJCn7x2uvElKLMUZiYZazEXFiQC1
        ENev+QIAAA==
X-CMS-MailID: 20220121174058epcas5p13276d857b7a9d3d24c84d5b46e0556fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174058epcas5p13276d857b7a9d3d24c84d5b46e0556fd
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174058epcas5p13276d857b7a9d3d24c84d5b46e0556fd@epcas5p1.samsung.com>
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
index d39ec207213e..a9c4424b29ff 100644
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
+	PLL_35XX_RATE(24 * MHZ, 666000000, 111, 4, 0),
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

