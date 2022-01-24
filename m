Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404BD49824B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbiAXOaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:20 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42026 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbiAXO3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:33 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220124142930epoutp02f36c3857285c75c1c5cb47fe9324dc98~NOzyd4Mae3161931619epoutp02j
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220124142930epoutp02f36c3857285c75c1c5cb47fe9324dc98~NOzyd4Mae3161931619epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034570;
        bh=ZJVEujEapOwOL/s9rVEUimiTpeqc892oLUrwQ0tUa1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiRvhkK7RHMsUM1582GUgdKOh1y2m8rJuM5buY+UAUAG1iu3roD6zQhaV2GYI731c
         ccncDsLtS5tihMoBkBtDc656oax1K8C/ZvCUOSd9jszmkP6hVxvxHyLEBZeW+yxza3
         8rUlqNduFJ5Jbg5i59PT5WXVCASO0jvCq+uRhpA8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220124142930epcas5p2f195b4f1f987528522a8c077840a7b56~NOzx6zvC50974109741epcas5p29;
        Mon, 24 Jan 2022 14:29:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JjC6X2C3nz4x9Pp; Mon, 24 Jan
        2022 14:29:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.8E.06423.4C7BEE16; Mon, 24 Jan 2022 23:29:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142923epcas5p17cffd89f734eda4c7e9515ac4ec79fb5~NOzsJRfXr1531415314epcas5p1R;
        Mon, 24 Jan 2022 14:29:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142923epsmtrp23b6e6a7df82399f0f4536d0254214dc2~NOzsIKBur1656816568epsmtrp21;
        Mon, 24 Jan 2022 14:29:23 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-5c-61eeb7c44940
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.EA.29871.3C7BEE16; Mon, 24 Jan 2022 23:29:23 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142921epsmtip195b36b2cbd0f8a04af5ba366f5c0f8f1~NOzpix5OP1063810638epsmtip1g;
        Mon, 24 Jan 2022 14:29:20 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH v5 07/16] clk: samsung: fsd: Add cmu_fsys1 clock information
Date:   Mon, 24 Jan 2022 19:46:35 +0530
Message-Id: <20220124141644.71052-8-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfVCTdRy/3/Nszwbc8Gla/gIVeIwUEmTJ5g+OGRfCPRkZnnV0dkVP7LnB
        bWxrzyAhX4DSDJi8XJeAMAIDOyDeJPSQcbwFnjs1jjU6HQZBRhagUrsK5Nr2UP33/X6+n8/3
        XYxLLUSAOFNnYo06RksRvoKe4bAdESOXF5koV6EPGlgaFKBpSw+BHleMitBSUwlAdSM3hahz
        4U8Mfbp6EUNdsw4helhyV4hm7qeiid4aAlXe6sfQ9cllAjV8/bsInbKOiNDwbx8L0ZqjU4Bm
        J1eJeCndamkF9MrfFYCuzjcTdFfzJwTtdPQR9KUvTtL2a4VC+mx3M6DXCmtF9HLXthTfI5q4
        DJZRscZgVpeuV2Xq1Erq5cNpCWlyRZQsQhaD9lLBOiaLVVL7k1MikjK17qGo4BxGm+2GUhiO
        o3bvizPqs01scIaeMykp1qDSGqINkRyTxWXr1JE61hQri4p6Xu4mvqPJeLSiMawcPtrwyyrI
        B/YDRUAshmQ0/Hn89SLgK5aSVwFsH30o5J1HAPYXtGO84wKwvnzc7fh4FeV35nGPLSWtAC6c
        CuBJH2FwrrNC5AkQ5HNw6ly3V7CJTILfF5zxZsLJL3FY0uzyBjaSyXClpFjk6UNAhkLnla0e
        WELGQWftTwK+WBBs6RjwFvMhldBS7/LmgWSfGE7OfyvkSfvhTMXCumAjvD/WLeLtALi8aCX4
        OTWwpHcPDx+DjZbRdfoLcMBeI/BQcDIMtvfu9sA46Q/NK3MYr5TAM6elPDsUfrj43boyEJYX
        F683QMPpq3Uifg1lALY6z4EysLX6/6yfA9AMnmYNXJaa5eQGmY59/78rpeuzuoD3UcNfugKm
        ph9EDgFMDIYAFOPUJkmeapGRSlRMbh5r1KcZs7UsNwTk7o2V4wFPpuvdn64zpcmiY6KiFQpF
        dMwehYzaLLGpOxgpqWZMrIZlDazxXx0m9gnIx94YdzyO1ST740rNA4NctTfE2WfcckNvP+1j
        TfzgVyzSFnI+jMx1mtGheN+8bbd3JVTfy73rx4ytvV35pn7fBeUJGBdyIfHHJnNZ7fayy7ab
        OaY718PNSRdtiYMyrLUKb5D62UtfC885+cfssD02wVZzqcJ5cMOJym/eOz51z1zwor8qcEes
        9cgT7Y6xXTslLW1PTVn9Jl4NUveVVRkONiqK15KRllTOUz1hP2woPppai1Ov+AkbJ1BQiPit
        r0Lb2BupMtehpLampVKboLpK131s8zN+/fJ4Qt8yGDjZXTqxs0a7MNf4V/015bylzlFFcxm3
        Z453vOu6VXTgs6Fnt6gpAZfByMJxI8f8A8S6hlIxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO7h7e8SDWb3aFkceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Mj79zi74HVyx
        6OUfxgbGK15djJwcEgImEhNvv2AGsYUEdjNKfFxUDRGXlri+cQI7hC0ssfLfcyCbC6imiUli
        za55rCAJNgFtibvTtzCB2CICHhJt/+4xgxQxC+xilujuPAGWEBbwkfjd0w3UzcHBIqAqcWeH
        LEiYV8BG4s7cpywQC+QlVm84AHYEp4CtxLyF35hAyoWAas79VpnAyLeAkWEVo2RqQXFuem6x
        YYFhXmq5XnFibnFpXrpecn7uJkZwNGhp7mDcvuqD3iFGJg7GQ4wSHMxKIrxVKe8ShXhTEiur
        Uovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCqujw3aa/NDqPikFkp
        uVedVhlq3P/18+OEKZcnXvAWkjxV7NOuLlV6skmsOfWAsab8o7gTB1+syv164D7H77JOp8Co
        6XsiVf/+KMr99cvt98JTXm8P84VnHTi6ePFakSWK/QrsrRcD9FdUCKU4OSdkbL5pfMh+t0HO
        oSWa2WKzmHa+q88QYv675Y5p5dJD1bOOlW3lcVsQM81lddCkY013Px9fPFtC+kq0LF+Bt832
        vd8nHtrQoNb34u5hpfoU24A+9q4MiYyUsjnbd82bNuNIvfn3oOD6AodKvvoW87bbPfkfGnUc
        hYSs5vzcEn69sv/c4S+qZXm1r4waT52dOHuPlckzfdXpzXmv2ew7RP4psRRnJBpqMRcVJwIA
        zTmCe/UCAAA=
X-CMS-MailID: 20220124142923epcas5p17cffd89f734eda4c7e9515ac4ec79fb5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142923epcas5p17cffd89f734eda4c7e9515ac4ec79fb5
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142923epcas5p17cffd89f734eda4c7e9515ac4ec79fb5@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds cmu_fsys1 block clock information which are needed
for PCIe IPs in block FSYS1.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 175 ++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 785c493be2b6..19c3ea35a6ea 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -972,6 +972,178 @@ static const struct samsung_cmu_info fsys0_cmu_info __initconst = {
 	.clk_name		= "dout_cmu_fsys0_shared1div4",
 };
 
+/* Register Offset definitions for CMU_FSYS1 (0x16810000) */
+#define PLL_CON0_ACLK_FSYS1_BUSP_MUX			0x100
+#define PLL_CON0_PCLKL_FSYS1_BUSP_MUX			0x180
+#define DIV_CLK_FSYS1_PHY0_OSCCLK			0x1800
+#define DIV_CLK_FSYS1_PHY1_OSCCLK			0x1804
+#define GAT_FSYS1_CMU_FSYS1_IPCLKPORT_PCLK	0x2000
+#define GAT_FSYS1_PCIE_LINK0_IPCLKPORT_AUXCLK		0x2004
+#define GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_SOC_REF_CLK	0x2008
+#define GAT_FSYS1_PCIE_LINK1_IPCLKPORT_AUXCLK		0x200c
+#define GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_REF_XTAL	0x202c
+#define GAT_FSYS1_PHY0_OSCCLLK				0x2034
+#define GAT_FSYS1_PHY1_OSCCLK				0x2038
+#define GAT_FSYS1_AXI2APB_FSYS1_IPCLKPORT_ACLK		0x203c
+#define GAT_FSYS1_BUS_D0_FSYS1_IPCLKPORT_MAINCLK	0x2040
+#define GAT_FSYS1_BUS_S0_FSYS1_IPCLKPORT_M250CLK	0x2048
+#define GAT_FSYS1_BUS_S0_FSYS1_IPCLKPORT_MAINCLK	0x204c
+#define GAT_FSYS1_CPE425_0_FSYS1_IPCLKPORT_ACLK		0x2054
+#define GAT_FSYS1_NS_BRDG_FSYS1_IPCLKPORT_CLK__PSOC_FSYS1__CLK_FSYS1_D0	0x205c
+#define GAT_FSYS1_NS_BRDG_FSYS1_IPCLKPORT_CLK__PSOC_FSYS1__CLK_FSYS1_S0	0x2064
+#define GAT_FSYS1_PCIE_LINK0_IPCLKPORT_DBI_ACLK		0x206c
+#define GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_APB_CLK	0x2070
+#define GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_DRIVER_APB_CLK	0x2074
+#define GAT_FSYS1_PCIE_LINK0_IPCLKPORT_MSTR_ACLK	0x2078
+#define GAT_FSYS1_PCIE_LINK0_IPCLKPORT_SLV_ACLK		0x207c
+#define GAT_FSYS1_PCIE_LINK1_IPCLKPORT_DBI_ACLK		0x2080
+#define GAT_FSYS1_PCIE_LINK1_IPCLKPORT_I_DRIVER_APB_CLK	0x2084
+#define GAT_FSYS1_PCIE_LINK1_IPCLKPORT_MSTR_ACLK	0x2088
+#define GAT_FSYS1_PCIE_LINK1_IPCLKPORT_SLV_ACLK		0x208c
+#define GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_APB_CLK		0x20a4
+#define GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_REF_SOC_PLL	0x20a8
+#define GAT_FSYS1_SYSREG_FSYS1_IPCLKPORT_PCLK		0x20b4
+#define GAT_FSYS1_TBU0_FSYS1_IPCLKPORT_ACLK		0x20b8
+
+static const unsigned long fsys1_clk_regs[] __initconst = {
+	PLL_CON0_ACLK_FSYS1_BUSP_MUX,
+	PLL_CON0_PCLKL_FSYS1_BUSP_MUX,
+	DIV_CLK_FSYS1_PHY0_OSCCLK,
+	DIV_CLK_FSYS1_PHY1_OSCCLK,
+	GAT_FSYS1_CMU_FSYS1_IPCLKPORT_PCLK,
+	GAT_FSYS1_PCIE_LINK0_IPCLKPORT_AUXCLK,
+	GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_SOC_REF_CLK,
+	GAT_FSYS1_PCIE_LINK1_IPCLKPORT_AUXCLK,
+	GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_REF_XTAL,
+	GAT_FSYS1_PHY0_OSCCLLK,
+	GAT_FSYS1_PHY1_OSCCLK,
+	GAT_FSYS1_AXI2APB_FSYS1_IPCLKPORT_ACLK,
+	GAT_FSYS1_BUS_D0_FSYS1_IPCLKPORT_MAINCLK,
+	GAT_FSYS1_BUS_S0_FSYS1_IPCLKPORT_M250CLK,
+	GAT_FSYS1_BUS_S0_FSYS1_IPCLKPORT_MAINCLK,
+	GAT_FSYS1_CPE425_0_FSYS1_IPCLKPORT_ACLK,
+	GAT_FSYS1_NS_BRDG_FSYS1_IPCLKPORT_CLK__PSOC_FSYS1__CLK_FSYS1_D0,
+	GAT_FSYS1_NS_BRDG_FSYS1_IPCLKPORT_CLK__PSOC_FSYS1__CLK_FSYS1_S0,
+	GAT_FSYS1_PCIE_LINK0_IPCLKPORT_DBI_ACLK,
+	GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_APB_CLK,
+	GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_DRIVER_APB_CLK,
+	GAT_FSYS1_PCIE_LINK0_IPCLKPORT_MSTR_ACLK,
+	GAT_FSYS1_PCIE_LINK0_IPCLKPORT_SLV_ACLK,
+	GAT_FSYS1_PCIE_LINK1_IPCLKPORT_DBI_ACLK,
+	GAT_FSYS1_PCIE_LINK1_IPCLKPORT_I_DRIVER_APB_CLK,
+	GAT_FSYS1_PCIE_LINK1_IPCLKPORT_MSTR_ACLK,
+	GAT_FSYS1_PCIE_LINK1_IPCLKPORT_SLV_ACLK,
+	GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_APB_CLK,
+	GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_REF_SOC_PLL,
+	GAT_FSYS1_SYSREG_FSYS1_IPCLKPORT_PCLK,
+	GAT_FSYS1_TBU0_FSYS1_IPCLKPORT_ACLK,
+};
+
+static const struct samsung_fixed_rate_clock fsys1_fixed_clks[] __initconst = {
+	FRATE(0, "clk_fsys1_phy0_ref", NULL, 0, 100000000),
+	FRATE(0, "clk_fsys1_phy1_ref", NULL, 0, 100000000),
+};
+
+/* List of parent clocks for Muxes in CMU_FSYS1 */
+PNAME(mout_fsys1_pclkl_fsys1_busp_mux_p) = { "fin_pll", "dout_cmu_fsys1_shared0div8" };
+PNAME(mout_fsys1_aclk_fsys1_busp_mux_p) = { "fin_pll", "dout_cmu_fsys1_shared0div4" };
+
+static const struct samsung_mux_clock fsys1_mux_clks[] __initconst = {
+	MUX(0, "mout_fsys1_pclkl_fsys1_busp_mux", mout_fsys1_pclkl_fsys1_busp_mux_p,
+	    PLL_CON0_PCLKL_FSYS1_BUSP_MUX, 4, 1),
+	MUX(0, "mout_fsys1_aclk_fsys1_busp_mux", mout_fsys1_aclk_fsys1_busp_mux_p,
+	    PLL_CON0_ACLK_FSYS1_BUSP_MUX, 4, 1),
+};
+
+static const struct samsung_div_clock fsys1_div_clks[] __initconst = {
+	DIV(0, "dout_fsys1_clk_fsys1_phy0_oscclk", "fsys1_phy0_osccllk",
+	    DIV_CLK_FSYS1_PHY0_OSCCLK, 0, 4),
+	DIV(0, "dout_fsys1_clk_fsys1_phy1_oscclk", "fsys1_phy1_oscclk",
+	    DIV_CLK_FSYS1_PHY1_OSCCLK, 0, 4),
+};
+
+static const struct samsung_gate_clock fsys1_gate_clks[] __initconst = {
+	GATE(0, "fsys1_cmu_fsys1_ipclkport_pclk", "mout_fsys1_pclkl_fsys1_busp_mux",
+	     GAT_FSYS1_CMU_FSYS1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_pcie_phy0_ipclkport_i_ref_xtal", "clk_fsys1_phy0_ref",
+	     GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_REF_XTAL, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_phy0_osccllk", "mout_fsys1_aclk_fsys1_busp_mux",
+	     GAT_FSYS1_PHY0_OSCCLLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_phy1_oscclk", "mout_fsys1_aclk_fsys1_busp_mux",
+	     GAT_FSYS1_PHY1_OSCCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_axi2apb_fsys1_ipclkport_aclk", "mout_fsys1_pclkl_fsys1_busp_mux",
+	     GAT_FSYS1_AXI2APB_FSYS1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_bus_d0_fsys1_ipclkport_mainclk", "mout_fsys1_aclk_fsys1_busp_mux",
+	     GAT_FSYS1_BUS_D0_FSYS1_IPCLKPORT_MAINCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_bus_s0_fsys1_ipclkport_m250clk", "mout_fsys1_pclkl_fsys1_busp_mux",
+	     GAT_FSYS1_BUS_S0_FSYS1_IPCLKPORT_M250CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_bus_s0_fsys1_ipclkport_mainclk", "mout_fsys1_aclk_fsys1_busp_mux",
+	     GAT_FSYS1_BUS_S0_FSYS1_IPCLKPORT_MAINCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_cpe425_0_fsys1_ipclkport_aclk", "mout_fsys1_aclk_fsys1_busp_mux",
+	     GAT_FSYS1_CPE425_0_FSYS1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_ns_brdg_fsys1_ipclkport_clk__psoc_fsys1__clk_fsys1_d0",
+	     "mout_fsys1_aclk_fsys1_busp_mux",
+	     GAT_FSYS1_NS_BRDG_FSYS1_IPCLKPORT_CLK__PSOC_FSYS1__CLK_FSYS1_D0, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_ns_brdg_fsys1_ipclkport_clk__psoc_fsys1__clk_fsys1_s0",
+	     "mout_fsys1_aclk_fsys1_busp_mux",
+	     GAT_FSYS1_NS_BRDG_FSYS1_IPCLKPORT_CLK__PSOC_FSYS1__CLK_FSYS1_S0, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_LINK0_IPCLKPORT_DBI_ACLK, "fsys1_pcie_link0_ipclkport_dbi_aclk",
+	     "mout_fsys1_aclk_fsys1_busp_mux", GAT_FSYS1_PCIE_LINK0_IPCLKPORT_DBI_ACLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_pcie_link0_ipclkport_i_apb_clk", "mout_fsys1_pclkl_fsys1_busp_mux",
+	     GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_APB_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_pcie_link0_ipclkport_i_soc_ref_clk", "fin_pll",
+	     GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_SOC_REF_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_pcie_link0_ipclkport_i_driver_apb_clk", "mout_fsys1_pclkl_fsys1_busp_mux",
+	     GAT_FSYS1_PCIE_LINK0_IPCLKPORT_I_DRIVER_APB_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_LINK0_IPCLKPORT_MSTR_ACLK, "fsys1_pcie_link0_ipclkport_mstr_aclk",
+	     "mout_fsys1_aclk_fsys1_busp_mux", GAT_FSYS1_PCIE_LINK0_IPCLKPORT_MSTR_ACLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_LINK0_IPCLKPORT_SLV_ACLK, "fsys1_pcie_link0_ipclkport_slv_aclk",
+	     "mout_fsys1_aclk_fsys1_busp_mux", GAT_FSYS1_PCIE_LINK0_IPCLKPORT_SLV_ACLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_LINK1_IPCLKPORT_DBI_ACLK, "fsys1_pcie_link1_ipclkport_dbi_aclk",
+	     "mout_fsys1_aclk_fsys1_busp_mux", GAT_FSYS1_PCIE_LINK1_IPCLKPORT_DBI_ACLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_pcie_link1_ipclkport_i_driver_apb_clk", "mout_fsys1_pclkl_fsys1_busp_mux",
+	     GAT_FSYS1_PCIE_LINK1_IPCLKPORT_I_DRIVER_APB_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_LINK1_IPCLKPORT_MSTR_ACLK, "fsys1_pcie_link1_ipclkport_mstr_aclk",
+	     "mout_fsys1_aclk_fsys1_busp_mux", GAT_FSYS1_PCIE_LINK1_IPCLKPORT_MSTR_ACLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_LINK1_IPCLKPORT_SLV_ACLK, "fsys1_pcie_link1_ipclkport_slv_aclk",
+	     "mout_fsys1_aclk_fsys1_busp_mux", GAT_FSYS1_PCIE_LINK1_IPCLKPORT_SLV_ACLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_pcie_phy0_ipclkport_i_apb_clk", "mout_fsys1_pclkl_fsys1_busp_mux",
+	     GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_APB_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_LINK0_IPCLKPORT_AUX_ACLK, "fsys1_pcie_link0_ipclkport_auxclk", "fin_pll",
+	     GAT_FSYS1_PCIE_LINK0_IPCLKPORT_AUXCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_LINK1_IPCLKPORT_AUX_ACLK, "fsys1_pcie_link1_ipclkport_auxclk", "fin_pll",
+	     GAT_FSYS1_PCIE_LINK1_IPCLKPORT_AUXCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_pcie_phy0_ipclkport_i_ref_soc_pll", "dout_fsys1_clk_fsys1_phy0_oscclk",
+	     GAT_FSYS1_PCIE_PHY0_IPCLKPORT_I_REF_SOC_PLL, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_sysreg_fsys1_ipclkport_pclk", "mout_fsys1_pclkl_fsys1_busp_mux",
+	     GAT_FSYS1_SYSREG_FSYS1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys1_tbu0_fsys1_ipclkport_aclk", "mout_fsys1_aclk_fsys1_busp_mux",
+	     GAT_FSYS1_TBU0_FSYS1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info fsys1_cmu_info __initconst = {
+	.mux_clks		= fsys1_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(fsys1_mux_clks),
+	.div_clks		= fsys1_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(fsys1_div_clks),
+	.gate_clks		= fsys1_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(fsys1_gate_clks),
+	.fixed_clks		= fsys1_fixed_clks,
+	.nr_fixed_clks		= ARRAY_SIZE(fsys1_fixed_clks),
+	.nr_clk_ids		= FSYS1_NR_CLK,
+	.clk_regs		= fsys1_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(fsys1_clk_regs),
+	.clk_name		= "dout_cmu_fsys1_shared0div4",
+};
+
 /**
  * fsd_cmu_probe - Probe function for FSD platform clocks
  * @pdev: Pointer to platform device
@@ -997,6 +1169,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
 	}, {
 		.compatible = "tesla,fsd-clock-fsys0",
 		.data = &fsys0_cmu_info,
+	}, {
+		.compatible = "tesla,fsd-clock-fsys1",
+		.data = &fsys1_cmu_info,
 	}, {
 	},
 };
-- 
2.25.1

