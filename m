Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B337D48D799
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiAMMYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:24:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24978 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiAMMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:23:54 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220113122353epoutp03b9b18e6e58f370f0830553f15aae2dde~J0-9l4jjm1485214852epoutp03G
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220113122353epoutp03b9b18e6e58f370f0830553f15aae2dde~J0-9l4jjm1485214852epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076633;
        bh=HVIRzwgEu4DOzsYJSj9a9BUkaQT56g8+KCqt3H7clX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnfXDA6IC2XlY9tM2FxPgcooH4kor3MGItywWdsqvQ9htG2ZEsY0TzITCP5rOQXIe
         7nd7gffEkz9H9urSc+k8Z/wbVg/ocTnlxAF2dW3zKFCINeL1QyYMnv6nF6nzBYefc4
         JpuxpD+NqGsvJn0S2huiM3tPp5KQxyv6Vab1A6RI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220113122352epcas5p3110b35f1fd5d2d61d8cbae3cacfd0539~J0-86YGiW2339223392epcas5p3i;
        Thu, 13 Jan 2022 12:23:52 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JZNrg2JJGz4x9Px; Thu, 13 Jan
        2022 12:23:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.51.05590.2D910E16; Thu, 13 Jan 2022 21:23:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220113122346epcas5p41a7d6712c07544e99795ef5465f1f106~J0-33-9g13143231432epcas5p4X;
        Thu, 13 Jan 2022 12:23:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122346epsmtrp2ab9e9216472f61736219e750a1c4035f~J0-36j-Vj3027830278epsmtrp2X;
        Thu, 13 Jan 2022 12:23:46 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-c5-61e019d25b30
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.98.29871.2D910E16; Thu, 13 Jan 2022 21:23:46 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122344epsmtip2bf84dcf435361f1a609dcf1070ad646c~J0-1lI_Ad1246112461epsmtip2R;
        Thu, 13 Jan 2022 12:23:44 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Smitha T Murthy <smitha.t@samsung.com>
Subject: [PATCH 08/23] clk: samsung: fsd: Add cmu_mfc block clock
 information
Date:   Thu, 13 Jan 2022 17:41:28 +0530
Message-Id: <20220113121143.22280-9-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmhu4lyQeJBlM2mVg8mLeNzeL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4uGrcIvLu+awWcw4v4/J4tT1z2wWi7Z+Ybdo
        3XuE3eLwm3ZWi7t7tjFaPL7+h81BwGPNvDWMHrMaetk8Nq3qZPO4c20Pm8fmJfUeV040sXr0
        bVnF6PGvaS67x+dNcgGcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5
        qbZKLj4Bum6ZOUBfKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz
        0vXyUkusDA0MjEyBChOyM248/c9cMNO4Yk7DY7YGxnU6XYycHBICJhK9TxYxdjFycQgJ7GaU
        2D57PjOE84lR4tztHVCZb4wSSza0MsG03P41nQkisZdR4tPPG2wQTguTxMr3u9lBqtgEtCXu
        Tt8C1iEi4CZxo7EDrINZoI1ZYvbjJ4wgCWEBf4ktE84xg9gsAqoSt3Z3Ak3i4OAVsJG4cF8P
        Ypu8xOoNB5hBwpwCthJ3V+WBjJEQWMohcedgNwtEjYvEm7kz2SFsYYlXx7dA2VISn9/tBRsp
        IZAt0bPLGCJcI7F03jGoVnuJA1fmsICUMAtoSqzfpQ8SZhbgk+j9/YQJopNXoqNNCKJaVaL5
        3VWoTmmJid3drBC2h8SBM7OhQTKBUWLDobesExhlZyFMXcDIuIpRMrWgODc9tdi0wDgvtRwe
        T8n5uZsYwWlTy3sH46MHH/QOMTJxMB5ilOBgVhLh7S+6nyjEm5JYWZValB9fVJqTWnyI0RQY
        YBOZpUST84GJO68k3tDE0sDEzMzMxNLYzFBJnPdU+oZEIYH0xJLU7NTUgtQimD4mDk6pBiYZ
        qSk1US8t+L1fWJkoT3uqWXB/v8KGlxNuuzH/U/7tasN++K9i6sZaq7hpNrsWz8+Z3/r7zboj
        e5oXVSw+V2v5WchA/oxbrMLCZCGG1gAGc5bSz3GH9sjHBD3oVD5bl/d0rdVdvkcibNqJnTun
        KukcmJ8ntfS95Zp8r19S7UczQ4Ludj5dImZV9EFlxvqnaruuvI2bfMKjZ1ZP7/9np7Mvc/6X
        t7NYV5oyeep6gQvTCo/5eu0OMjdNsJ0nxH7C1LYhvTZv5lWjVX0Ovcd+vFF0NY0+fpQ75l30
        Rk7BezrlM06dNf7lqB17MDpS+J/R6XYDpac8XfNuTk7WYbfmic7r+JJeKh44v8v82J9Pnkos
        xRmJhlrMRcWJAOYfhCkkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvO4lyQeJBqsuy1g8mLeNzeL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4uGrcIvLu+awWcw4v4/J4tT1z2wWi7Z+Ybdo
        3XuE3eLwm3ZWi7t7tjFaPL7+h81BwGPNvDWMHrMaetk8Nq3qZPO4c20Pm8fmJfUeV040sXr0
        bVnF6PGvaS67x+dNcgGcUVw2Kak5mWWpRfp2CVwZN57+Zy6YaVwxp+ExWwPjOp0uRk4OCQET
        idu/pjN1MXJxCAnsZpRY/OwuO0RCWuL6xglQtrDEyn/PwWwhgSYmieffwWw2AW2Ju9O3MIHY
        IgIeEm3/7jGDDGIWmMYs8bLnJjNIQljAV+LSncVgDSwCqhK3dneydTFycPAK2EhcuK8HMV9e
        YvWGA8wgYU4BW4m7q/IgVtlInHu1nm0CI98CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6
        yfm5mxjBAa+luYNx+6oPeocYmTgYDzFKcDArifD2F91PFOJNSaysSi3Kjy8qzUktPsQozcGi
        JM57oetkvJBAemJJanZqakFqEUyWiYNTqoEp56kmz+obasez350492metsruostxlikn1GYH
        lfQaOUT5tDLJdyhMsugp0V8xp4EzwmTl1A2vjK+zu7843KwyffHpl2YZ7hqHe/+rsF+O+JY8
        84uOa5sVh+amL0cv7/pbFOzf9un0k//P5lfHdgm6q57Mt1vRPkH7cc6uR3FqUg1iDQeV79y2
        /VfA7+6270y+Qe2G7T/0siY5WD248YEnTldv7bPVUxp/OD/fJ8/wR1evrbNor2uU3Md4r21z
        nm9eUrXLrtzI1OzUxs0qCtJzA5ZO5DQIrZ70MO3SZCFjwxRlPXm+OG5enZXrZqQ9VHnBu+cN
        s7fepZcTHi5dIXlql0TuJM+Pa9KkJ8Wr7V2gxFKckWioxVxUnAgAG3JdSOcCAAA=
X-CMS-MailID: 20220113122346epcas5p41a7d6712c07544e99795ef5465f1f106
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122346epcas5p41a7d6712c07544e99795ef5465f1f106
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122346epcas5p41a7d6712c07544e99795ef5465f1f106@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds clock related to MFC IP.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 121 ++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index dc252e63099d..927b310ce4a4 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1467,6 +1467,124 @@ static void __init fsd_clk_imem_init(struct device_node *np)
 
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
@@ -1510,6 +1628,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
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
2.17.1

