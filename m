Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D22949292C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345934AbiARPBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:01:43 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:29100 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344431AbiARPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:00:49 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220118150047epoutp01d03f5829c052cace1d15037d7264747f~LZXYw_qXY3081430814epoutp01b
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:00:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220118150047epoutp01d03f5829c052cace1d15037d7264747f~LZXYw_qXY3081430814epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518047;
        bh=x/t8BcMBlV2lMivWk+wOuuf0jQzazG+TWfxzePwc9sE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EctNgzl3JQX3pmOeJrGZ3SiYM0DWrotgVrL6PG5ZXOvxbm/1/EukVeZeU9zZSQAk1
         VKKhTWP9UOg9nMG9Mq7/+ln0Sw+xyklAwoxS3yDI+4nYu8AD02mEQzmVa8kgscz42h
         JZidk9gvFQAdd2ARQJFCt8SqUIm2tR7LUTG6hBDo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220118150046epcas5p210a4a935ea2c0795427f8650be965c11~LZXYHTS_43044830448epcas5p2Q;
        Tue, 18 Jan 2022 15:00:46 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JdX5P4wqLz4x9Px; Tue, 18 Jan
        2022 15:00:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.98.05590.916D6E16; Wed, 19 Jan 2022 00:00:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220118150041epcas5p2634381919d0e9f60867d6087162fa134~LZXS7T6Cx3044830448epcas5p2J;
        Tue, 18 Jan 2022 15:00:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220118150041epsmtrp1d7b659e43d1757a32a5d10cf510037fc~LZXS6d_5n2079320793epsmtrp1t;
        Tue, 18 Jan 2022 15:00:41 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-23-61e6d6190588
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.F0.08738.916D6E16; Wed, 19 Jan 2022 00:00:41 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150038epsmtip1b1b2027ad8228a6ba564d39cc2ae9e10~LZXQgyCe-0468004680epsmtip1Y;
        Tue, 18 Jan 2022 15:00:38 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH v2 07/16] clk: samsung: fsd: Add cmu_fsys1 clock information
Date:   Tue, 18 Jan 2022 20:18:42 +0530
Message-Id: <20220118144851.69537-8-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmpq7ktWeJBld26VkceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMNzc3sxZsDa7Yu/kkewPjZK8uRk4OCQETiba7
        31m6GLk4hAR2M0qsb3vACOF8YpRY++86K4TzmVHi27kmZpiWh3/OQ1XtYpT42fWbHcJpYZJY
        t2EOG0gVm4C2xN3pW5hAbBEBN4kbjR1MIEXMAtOYJd68OcQIkhAW8JGY+n4R2FgWAVWJ842z
        WEFsXgEbicYTc1kh1slLrN5wAKyGU8BWYmrDVDaI+A4OiWnLAiBsF4mbh75AxYUlXh3fwg5h
        S0m87G8DsjmA7GyJnl3GEOEaiaXzjrFA2PYSB67MYQEpYRbQlFi/Sx8kzCzAJ9H7+wkTRCev
        REebEES1qkTzu6tQndISE7u7oY70kPjUfYMZEgwTGCXOzVnOPoFRdhbC1AWMjKsYJVMLinPT
        U4tNC4zzUsvhEZWcn7uJEZxMtbx3MD568EHvECMTB+MhRgkOZiURXqn6Z4lCvCmJlVWpRfnx
        RaU5qcWHGE2BITaRWUo0OR+YzvNK4g1NLA1MzMzMTCyNzQyVxHlPpW9IFBJITyxJzU5NLUgt
        gulj4uCUamBi8X6ianx0VXjjqlT5N4cDeiuZKjNmH1kd6lRS+VbXe23nre2if9aWfPx+LHPD
        3rCpl2L+/vgY8YJ1VUXtI5f7f36Kvp4fV+q+T8ShbMbZ7R0dvCvcrotezHvaP5X/1In3YgKX
        77RLb1JOD/NK7FJJT/+aJd5zbIPDmoO7Av4FZq5xY58VGevxqf3lZRuBwPglbnUT52XK1CTN
        sLPk4SqpjzotkNcbVl3Hrf/er+f78ZBFjw4Vpqpp+chuSV4fq5ETauzDfLXI5T1f85qrtvb/
        uMumPRP8LXWQZ+LSS6935dRknztUvHpPeUKM/IF5Qis8Di/+rPfl/a2vVb41r8tXrZ4+6aCg
        wgNzJdd6TTclluKMREMt5qLiRABob+pwLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnK7ktWeJBgveMVsceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8abm5tZC7YGV+zdfJK9
        gXGyVxcjJ4eEgInEwz/nGbsYuTiEBHYwSpzY/IgdIiEtcX3jBChbWGLlv+fsEEVNTBLdb36w
        gCTYBLQl7k7fwgRiiwh4SLT9u8cMUsQssIxZ4tSiz2wgCWEBH4mp7xcxg9gsAqoS5xtnsYLY
        vAI2Eo0n5rJCbJCXWL3hAFgNp4CtxNSGqWC9QkA1F1dOY57AyLeAkWEVo2RqQXFuem6xYYFR
        Xmq5XnFibnFpXrpecn7uJkZwLGhp7WDcs+qD3iFGJg7GQ4wSHMxKIrxS9c8ShXhTEiurUovy
        44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDyzuE+M2HNm+jaLwH3zWR1
        9KtOS17tXKrx0C6IN/P/dmVF3uu84ptdy2vjXLyy/7D5fkzsSVRSElA6d9f3i3T0sc/akRW9
        01NVZiq1h+52FL3yZ6P1dp3H01q2eImF8O4Ry358OEim6wlnTs2DnbJ979IOrT2WHB0kk+R4
        syZ2y2y+f5w3jR+off+fxhy2tvCnZlTGx5vNvpFTw25M6gk62vRu69plb89FpF3ryesWPaNa
        nLNAJnL5tTVH3hr+9go6KmRQ/mbZ/5VtMQxbttb3zeyTWyXls3H6k31985576jMd3nFm45U9
        huvNskrqjYTnRHp9UJPZ0/Th4ruDlU/LBE5uW5k1M5Wp1+LSFlslluKMREMt5qLiRAAsF3p8
        9AIAAA==
X-CMS-MailID: 20220118150041epcas5p2634381919d0e9f60867d6087162fa134
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150041epcas5p2634381919d0e9f60867d6087162fa134
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150041epcas5p2634381919d0e9f60867d6087162fa134@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds cmu_fsys1 block clock information which are needed
for PCIe IPs in block FSYS1.

Cc: linux-fsd@tesla.com
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 175 ++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 9ae0a86ae762..97973a629453 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -970,6 +970,178 @@ static const struct samsung_cmu_info fsys0_cmu_info __initconst = {
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
@@ -995,6 +1167,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
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

