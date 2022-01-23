Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F46497524
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiAWTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:44 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52813 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbiAWTU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:28 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220123192026epoutp0142226d76bc51a13942dd686456f79bf8~M-Ihk3Phh2234222342epoutp01D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220123192026epoutp0142226d76bc51a13942dd686456f79bf8~M-Ihk3Phh2234222342epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965626;
        bh=wZ7PtuZok47SxFdXeEhGgmrUkFf4vCwDm2YTZISZTCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABAWQD3eeTYY9avBD15OG+W4OlIqSnx/j59vkV/E75MQoeeuvuvEZyKYLXOcPN8xs
         1qZge3Vc3btX9I8DHnoHAcfed4R0mhdVVYGidiHasa0ajkZuUi2eR3Z1AM7/qK8ogG
         YtLEJVJJL9n27asDmcQICsixd/yNOrUDQqMz9+ZE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220123192026epcas5p4078ded7601e83f236efa27f093441d8f~M-IhIq76B0241002410epcas5p4k;
        Sun, 23 Jan 2022 19:20:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jhjcc281gz4x9Pv; Sun, 23 Jan
        2022 19:20:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.73.46822.539ADE16; Mon, 24 Jan 2022 04:15:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192015epcas5p18f837be62b7d2b129e3a2d61e2e9f4c0~M-IXK9NAx0430304303epcas5p1A;
        Sun, 23 Jan 2022 19:20:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220123192015epsmtrp165edc0b78b1bac1ebb4e205af062a68a~M-IXKAG9R3102531025epsmtrp1L;
        Sun, 23 Jan 2022 19:20:15 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-6d-61eda9356b3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.C9.08738.F6AADE16; Mon, 24 Jan 2022 04:20:15 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192012epsmtip14f931051f3c0333348eda757ca74dbd9~M-IUr7a3k0551905519epsmtip1Y;
        Sun, 23 Jan 2022 19:20:12 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Sathyakam M <sathya@samsung.com>
Subject: [PATCH v4 10/16] clk: samsung: fsd: Add cam_csi block clock
 information
Date:   Mon, 24 Jan 2022 00:37:23 +0530
Message-Id: <20220123190729.1852-11-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhq7pyreJBn92y1s8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNafDnymtHi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGccnPePqeBEfMWvVbvZGxi/hXQxcnJI
        CJhI7F/yiaWLkYtDSGA3o8SCh2fZQBJCAp8YJSb/UoKwPzNKNB+pgWno3z2bEaJhF6PErymP
        WSCKWpgkVh4vAbHZBLQl7k7fwgRiiwi4Sdxo7GACaWAWWMws8e7WDLCEsECQxITuY2DbWARU
        JfZMbQcbxCtgI3F1w3smiG3yEqs3HGAGsTmB4r2vPrCCDJIQOMAh8eBjGyNEkYvEp8MvmSFs
        YYlXx7ewQ9hSEi/724BsDiA7W6JnlzFEuEZi6bxjLBC2vcSBK3NYQEqYBTQl1u/SBwkzC/BJ
        9P5+wgTRySvR0SYEUa0q0fzuKlSntMTE7m5WCNtDouP1GWiY9DNKfFh+mW0Co+wshKkLGBlX
        MUqmFhTnpqcWmxYY5aWWw6MpOT93EyM4pWp57WB8+OCD3iFGJg7GQ4wSHMxKIrwF+a8ShXhT
        EiurUovy44tKc1KLDzGaAoNsIrOUaHI+MKnnlcQbmlgamJiZmZlYGpsZKonznk7fkCgkkJ5Y
        kpqdmlqQWgTTx8TBKdXAJMlu4GOufzdyaWJ5g7y/xNS5uxZZNXnM8Xln7MX20v1nw9tJDOuk
        ygPaLqtOVBTYcErQ6Gig5CwlV9+S0JaLfWw5j9hfMHU4qvcqy7K3ah8OVBBm3+U+bVv8hYwO
        u42RChMKVga1v9wX9mbhKddik6yuVQ0W17+WPIxe3uHvZnTAZtf+/5MCQ00lLvB8SGVZ4+Gn
        NWnihnWRcgFqmy7yW3k4l9dp8ms/2T3jr4+Ar7vv6zAtJ55tbXkMUltNmo68U7zt/Xmr6inR
        qnOPY7Z8Dru/7d1V+3tHn7D+PcL5/cPfQ3ukf3c9W+xpyZKmK2FrGXfWY3+Cx3pui9ZQv8QP
        f71O70p7N2umzA27381KLMUZiYZazEXFiQA+ik9BMgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnG7+qreJBscXKlg8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNafDnymtHi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Mg7O+8dUcCK+
        4teq3ewNjN9Cuhg5OSQETCT6d89m7GLk4hAS2MEosXzSO2aIhLTE9Y0T2CFsYYmV/56zQxQ1
        MUlc6HnABpJgE9CWuDt9CxOILSLgIdH27x4zSBGzwFZmic/7v7CCJIQFAiTWv/nJAmKzCKhK
        7JnaDmbzCthIXN3wnglig7zE6g0HwDZzAsV7X30A6uUA2mYtMeGo3ARGvgWMDKsYJVMLinPT
        c4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjQktrB+OeVR/0DjEycTAeYpTgYFYS4S3If5UoxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9Oe2L+yH4Km7D7S
        L1a9dg3Php9enKfSF61Wmbe/+NtT9jt689z8omXCPc+EzvNI/7E366//fEv28zlM/yO9VHKv
        nlSMEs/SmqLe0GO3rmLOPe2f68XaK57WthjqSjWEBE5a9nrR6vhra/6t19HeY3a2WP3HiuK7
        XxbJxptqFd/0eGWrtsmxVTtC+mne87CXGpdZviX2f2/WnZHG6PyRpfC272JbizkmBTeEXKW3
        bGnRXfSq2+nJv9SXn95Y57IY5AbLntrzet5+m0DdL2l2cXIVnTeysgsy66/M23Zim9iBT5VB
        3e9Z369iaHvrtv7Xzjqmo1xz/j5nfnXE58UaDqftZ+yrJ+lqH7h1IX3byYVKLMUZiYZazEXF
        iQBSbhLE+AIAAA==
X-CMS-MailID: 20220123192015epcas5p18f837be62b7d2b129e3a2d61e2e9f4c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192015epcas5p18f837be62b7d2b129e3a2d61e2e9f4c0
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192015epcas5p18f837be62b7d2b129e3a2d61e2e9f4c0@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds clocks for BLK_CAM_CSI block, this is needed for CSI to work.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sathyakam M <sathya@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 207 ++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index f9c4b4c5e0cb..5d009c70e97d 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1545,6 +1545,210 @@ static const struct samsung_cmu_info mfc_cmu_info __initconst = {
 	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
 };
 
+/* Register Offset definitions for CMU_CAM_CSI (0x12610000) */
+#define PLL_LOCKTIME_PLL_CAM_CSI		0x0
+#define PLL_CON0_PLL_CAM_CSI			0x100
+#define DIV_CAM_CSI0_ACLK			0x1800
+#define DIV_CAM_CSI1_ACLK			0x1804
+#define DIV_CAM_CSI2_ACLK			0x1808
+#define DIV_CAM_CSI_BUSD			0x180c
+#define DIV_CAM_CSI_BUSP			0x1810
+#define GAT_CAM_CSI_CMU_CAM_CSI_IPCLKPORT_PCLK	0x2000
+#define GAT_CAM_AXI2APB_CAM_CSI_IPCLKPORT_ACLK	0x2004
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI0	0x2008
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI1	0x200c
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI2	0x2010
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_SOC_NOC	0x2014
+#define GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__NOC		0x2018
+#define GAT_CAM_CSI0_0_IPCLKPORT_I_ACLK		0x201c
+#define GAT_CAM_CSI0_0_IPCLKPORT_I_PCLK		0x2020
+#define GAT_CAM_CSI0_1_IPCLKPORT_I_ACLK		0x2024
+#define GAT_CAM_CSI0_1_IPCLKPORT_I_PCLK		0x2028
+#define GAT_CAM_CSI0_2_IPCLKPORT_I_ACLK		0x202c
+#define GAT_CAM_CSI0_2_IPCLKPORT_I_PCLK		0x2030
+#define GAT_CAM_CSI0_3_IPCLKPORT_I_ACLK		0x2034
+#define GAT_CAM_CSI0_3_IPCLKPORT_I_PCLK		0x2038
+#define GAT_CAM_CSI1_0_IPCLKPORT_I_ACLK		0x203c
+#define GAT_CAM_CSI1_0_IPCLKPORT_I_PCLK		0x2040
+#define GAT_CAM_CSI1_1_IPCLKPORT_I_ACLK		0x2044
+#define GAT_CAM_CSI1_1_IPCLKPORT_I_PCLK		0x2048
+#define GAT_CAM_CSI1_2_IPCLKPORT_I_ACLK		0x204c
+#define GAT_CAM_CSI1_2_IPCLKPORT_I_PCLK		0x2050
+#define GAT_CAM_CSI1_3_IPCLKPORT_I_ACLK		0x2054
+#define GAT_CAM_CSI1_3_IPCLKPORT_I_PCLK		0x2058
+#define GAT_CAM_CSI2_0_IPCLKPORT_I_ACLK		0x205c
+#define GAT_CAM_CSI2_0_IPCLKPORT_I_PCLK		0x2060
+#define GAT_CAM_CSI2_1_IPCLKPORT_I_ACLK		0x2064
+#define GAT_CAM_CSI2_1_IPCLKPORT_I_PCLK		0x2068
+#define GAT_CAM_CSI2_2_IPCLKPORT_I_ACLK		0x206c
+#define GAT_CAM_CSI2_2_IPCLKPORT_I_PCLK		0x2070
+#define GAT_CAM_CSI2_3_IPCLKPORT_I_ACLK		0x2074
+#define GAT_CAM_CSI2_3_IPCLKPORT_I_PCLK		0x2078
+#define GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_D	0x207c
+#define GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_P	0x2080
+#define GAT_CAM_SYSREG_CAM_CSI_IPCLKPORT_PCLK	0x2084
+#define GAT_CAM_TBU_CAM_CSI_IPCLKPORT_ACLK	0x2088
+
+static const unsigned long cam_csi_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_CAM_CSI,
+	PLL_CON0_PLL_CAM_CSI,
+	DIV_CAM_CSI0_ACLK,
+	DIV_CAM_CSI1_ACLK,
+	DIV_CAM_CSI2_ACLK,
+	DIV_CAM_CSI_BUSD,
+	DIV_CAM_CSI_BUSP,
+	GAT_CAM_CSI_CMU_CAM_CSI_IPCLKPORT_PCLK,
+	GAT_CAM_AXI2APB_CAM_CSI_IPCLKPORT_ACLK,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI0,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI1,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI2,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_SOC_NOC,
+	GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__NOC,
+	GAT_CAM_CSI0_0_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI0_0_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI0_1_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI0_1_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI0_2_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI0_2_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI0_3_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI0_3_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI1_0_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI1_0_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI1_1_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI1_1_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI1_2_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI1_2_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI1_3_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI1_3_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI2_0_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI2_0_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI2_1_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI2_1_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI2_2_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI2_2_IPCLKPORT_I_PCLK,
+	GAT_CAM_CSI2_3_IPCLKPORT_I_ACLK,
+	GAT_CAM_CSI2_3_IPCLKPORT_I_PCLK,
+	GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_D,
+	GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_P,
+	GAT_CAM_SYSREG_CAM_CSI_IPCLKPORT_PCLK,
+	GAT_CAM_TBU_CAM_CSI_IPCLKPORT_ACLK,
+};
+
+static const struct samsung_pll_rate_table pll_cam_csi_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 1066000000U, 533, 12, 0),
+};
+
+static const struct samsung_pll_clock cam_csi_pll_clks[] __initconst = {
+	PLL(pll_142xx, 0, "fout_pll_cam_csi", "fin_pll",
+	    PLL_LOCKTIME_PLL_CAM_CSI, PLL_CON0_PLL_CAM_CSI, pll_cam_csi_rate_table),
+};
+
+PNAME(mout_cam_csi_pll_p) = { "fin_pll", "fout_pll_cam_csi" };
+
+static const struct samsung_mux_clock cam_csi_mux_clks[] __initconst = {
+	MUX(0, "mout_cam_csi_pll", mout_cam_csi_pll_p, PLL_CON0_PLL_CAM_CSI, 4, 1),
+};
+
+static const struct samsung_div_clock cam_csi_div_clks[] __initconst = {
+	DIV(0, "dout_cam_csi0_aclk", "mout_cam_csi_pll", DIV_CAM_CSI0_ACLK, 0, 4),
+	DIV(0, "dout_cam_csi1_aclk", "mout_cam_csi_pll", DIV_CAM_CSI1_ACLK, 0, 4),
+	DIV(0, "dout_cam_csi2_aclk", "mout_cam_csi_pll", DIV_CAM_CSI2_ACLK, 0, 4),
+	DIV(0, "dout_cam_csi_busd", "mout_cam_csi_pll", DIV_CAM_CSI_BUSD, 0, 4),
+	DIV(0, "dout_cam_csi_busp", "mout_cam_csi_pll", DIV_CAM_CSI_BUSP, 0, 4),
+};
+
+static const struct samsung_gate_clock cam_csi_gate_clks[] __initconst = {
+	GATE(0, "cam_csi_cmu_cam_csi_ipclkport_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI_CMU_CAM_CSI_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_axi2apb_cam_csi_ipclkport_aclk", "dout_cam_csi_busp",
+	     GAT_CAM_AXI2APB_CAM_CSI_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__clk_csi0", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI0, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__clk_csi1", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI1, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__clk_csi2", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_CSI2, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__clk_soc_noc", "dout_cam_csi_busd",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__CLK_SOC_NOC, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi_bus_d_cam_csi_ipclkport_clk__system__noc", "dout_cam_csi_busd",
+	     GAT_CAM_CSI_BUS_D_CAM_CSI_IPCLKPORT_CLK__SYSTEM__NOC, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI0_0_IPCLKPORT_I_ACLK, "cam_csi0_0_ipclkport_i_aclk", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI0_0_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi0_0_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI0_0_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI0_1_IPCLKPORT_I_ACLK, "cam_csi0_1_ipclkport_i_aclk", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI0_1_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi0_1_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI0_1_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI0_2_IPCLKPORT_I_ACLK, "cam_csi0_2_ipclkport_i_aclk", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI0_2_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi0_2_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI0_2_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI0_3_IPCLKPORT_I_ACLK, "cam_csi0_3_ipclkport_i_aclk", "dout_cam_csi0_aclk",
+	     GAT_CAM_CSI0_3_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi0_3_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI0_3_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI1_0_IPCLKPORT_I_ACLK, "cam_csi1_0_ipclkport_i_aclk", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI1_0_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi1_0_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI1_0_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI1_1_IPCLKPORT_I_ACLK, "cam_csi1_1_ipclkport_i_aclk", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI1_1_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi1_1_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI1_1_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI1_2_IPCLKPORT_I_ACLK, "cam_csi1_2_ipclkport_i_aclk", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI1_2_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi1_2_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI1_2_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI1_3_IPCLKPORT_I_ACLK, "cam_csi1_3_ipclkport_i_aclk", "dout_cam_csi1_aclk",
+	     GAT_CAM_CSI1_3_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi1_3_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI1_3_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI2_0_IPCLKPORT_I_ACLK, "cam_csi2_0_ipclkport_i_aclk", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI2_0_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi2_0_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI2_0_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI2_1_IPCLKPORT_I_ACLK, "cam_csi2_1_ipclkport_i_aclk", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI2_1_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi2_1_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI2_1_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI2_2_IPCLKPORT_I_ACLK, "cam_csi2_2_ipclkport_i_aclk", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI2_2_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi2_2_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI2_2_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CAM_CSI2_3_IPCLKPORT_I_ACLK, "cam_csi2_3_ipclkport_i_aclk", "dout_cam_csi2_aclk",
+	     GAT_CAM_CSI2_3_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_csi2_3_ipclkport_i_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_CSI2_3_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_ns_brdg_cam_csi_ipclkport_clk__psoc_cam_csi__clk_cam_csi_d",
+	     "dout_cam_csi_busd",
+	     GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_D, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_ns_brdg_cam_csi_ipclkport_clk__psoc_cam_csi__clk_cam_csi_p",
+	     "dout_cam_csi_busp",
+	     GAT_CAM_NS_BRDG_CAM_CSI_IPCLKPORT_CLK__PSOC_CAM_CSI__CLK_CAM_CSI_P, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_sysreg_cam_csi_ipclkport_pclk", "dout_cam_csi_busp",
+	     GAT_CAM_SYSREG_CAM_CSI_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cam_tbu_cam_csi_ipclkport_aclk", "dout_cam_csi_busd",
+	     GAT_CAM_TBU_CAM_CSI_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info cam_csi_cmu_info __initconst = {
+	.pll_clks		= cam_csi_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(cam_csi_pll_clks),
+	.mux_clks		= cam_csi_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(cam_csi_mux_clks),
+	.div_clks		= cam_csi_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(cam_csi_div_clks),
+	.gate_clks		= cam_csi_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(cam_csi_gate_clks),
+	.nr_clk_ids		= CAM_CSI_NR_CLK,
+	.clk_regs		= cam_csi_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(cam_csi_clk_regs),
+};
+
 /**
  * fsd_cmu_probe - Probe function for FSD platform clocks
  * @pdev: Pointer to platform device
@@ -1576,6 +1780,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
 	}, {
 		.compatible = "tesla,fsd-clock-mfc",
 		.data = &mfc_cmu_info,
+	}, {
+		.compatible = "tesla,fsd-clock-cam_csi",
+		.data = &cam_csi_cmu_info,
 	}, {
 	},
 };
-- 
2.25.1

