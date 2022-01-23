Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D022497511
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbiAWTUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:25 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:45173 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239873AbiAWTUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:11 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220123192009epoutp02543e2508fb054fdae31a119306b3baae~M-IRa4XXD1706717067epoutp02C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220123192009epoutp02543e2508fb054fdae31a119306b3baae~M-IRa4XXD1706717067epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965609;
        bh=ZJVEujEapOwOL/s9rVEUimiTpeqc892oLUrwQ0tUa1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqvMxYlGVfABcFJ1wjLDIobVXfCLzeyhjFNPIWPkZcyOIHNAXOrcAjHjUWgV/Gn+9
         qn47GK01ElNZTmPyfzQryy3kDkL4gMolC8V/Qe7wOVqbYRV4jUre3FN0N3aR3jaQep
         Sxzdfbny0Lew1C3VmIJHitmybXDkAuy1FVrxNN6Y=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220123192007epcas5p281fe4ffcc680ac917d796ecd9bba619b~M-IQC-nF42307423074epcas5p2m;
        Sun, 23 Jan 2022 19:20:07 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JhjcK4wYrz4x9Px; Sun, 23 Jan
        2022 19:20:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.37.06423.16AADE16; Mon, 24 Jan 2022 04:20:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192001epcas5p1e5c0fcf841684b5996c5da8cab805899~M-IJqzwe70430304303epcas5p15;
        Sun, 23 Jan 2022 19:20:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123192001epsmtrp28cf845a5279cf81d89471e5139ae7c59~M-IJpM21l2018820188epsmtrp2b;
        Sun, 23 Jan 2022 19:20:01 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-77-61edaa61d7ff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.C9.08738.06AADE16; Mon, 24 Jan 2022 04:20:00 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191958epsmtip1db00822fb9b99f88aa5ba67c3643cd9e~M-IHJvDZK0560605606epsmtip1Y;
        Sun, 23 Jan 2022 19:19:58 +0000 (GMT)
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
Subject: [PATCH v4 07/16] clk: samsung: fsd: Add cmu_fsys1 clock information
Date:   Mon, 24 Jan 2022 00:37:20 +0530
Message-Id: <20220123190729.1852-8-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmpm7iqreJBgdfKVgceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGd8+p1d8Du4YtHLP4wNjFe8uhg5OSQE
        TCSOHfnL3sXIxSEksJtR4un8F2wQzidGieXbrrNAOJ8ZJd6t/8IC0/K6cQMjRGIXo8TKVQ+g
        qlqYJKYeucUKUsUmoC1xd/oWJhBbRMBN4kZjBxNIEbPACmaJnlXfwBLCAj4SX762MoPYLAKq
        Ep3/l7GD2LwC1hL/nzVBrZOXWL3hAFgNp4CNRO+rD6wggyQEDnBINFx6CFXkIjFhLshNILaw
        xKvjW9ghbCmJz+/2An3EAWRnS/TsMoYI10gsnXcMqtVe4sCVOSwgJcwCmhLrd+mDhJkF+CR6
        fz9hgujklehoE4KoVpVofncVqlNaYmJ3NyuE7SGx8eMPaDj2M0rc+nSYcQKj7CyEqQsYGVcx
        SqYWFOempxabFhjmpZbDIyo5P3cTIzitannuYLz74IPeIUYmDsZDjBIczEoivAX5rxKFeFMS
        K6tSi/Lji0pzUosPMZoCg2wis5Rocj4wseeVxBuaWBqYmJmZmVgamxkqifOeTt+QKCSQnliS
        mp2aWpBaBNPHxMEp1cDEERv6uuxi8PG+mGvZjhof/TOmCpluevIyvdus1/bqekU++U2f3ort
        4qo6wCu7wO/aszNPdk65+KNhl7/PZQn2imrRxGuHX017dW6Ke/Is9zTvfWYqm4ouTizVzGjZ
        94xL3pdR/h1fhSbHw7vsJ71q5p6y3bv1Etu0EtNtRwp3briqv0vxjNAWszWM7uaCqyVa4n4X
        sGz3nniU44rj0QjxrhXWP9ZbLDEN258kvnxjQF3luVfMu10W6/w+Pm3Bs02v5RP82bqfnpyc
        dD294enn5H6fVG4R0Tb/Zn33p8eWSIrW3M6zOTDvud2u1zqBUaoR1VF7olLFDStSrz6X5Jx/
        sC4s0OKk8trSDbJfjkgosRRnJBpqMRcVJwIA2lfQZzQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnG7CqreJBo2nbCwOvD/IYvFg3jY2
        i7+TjrFbvF/Ww2gx/8g5VouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmc
        uv6ZzWLR1i/sFq17j7BbHH7Tzmrx79pGFovH1/+wOQh5rJm3htHj969JjB6zGnrZPDat6mTz
        uHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fnTXIBXFFcNimpOZllqUX6dglcGZ9+Zxf8Dq5Y
        9PIPYwPjFa8uRk4OCQETideNGxi7GLk4hAR2MEo0vd3ADJGQlri+cQI7hC0ssfLfc3aIoiYm
        iVfPT7GBJNgEtCXuTt/CBGKLCHhItP27xwxSxCywi1miu/MEWEJYwEfiy9dWsKksAqoSnf+X
        gU3lFbCW+P+siQVig7zE6g0HwGo4BWwkel99YO1i5ADaZi0x4ajcBEa+BYwMqxglUwuKc9Nz
        iw0LjPJSy/WKE3OLS/PS9ZLzczcxgiNCS2sH455VH/QOMTJxMB5ilOBgVhLhLch/lSjEm5JY
        WZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDE29p9t3pK0sWrE1d
        le3TuSFi2ofL0Ytft9at7JmjOOnhMdZvd3d9kH48afsH521PHhWtm1jdeG+3u3PY5eiXU39E
        7rnyY02gBW9Khh7PW+nnEa5L2yV2HV2676/wlX15i1bfc5seJNm0od2EpaU5d8n7BK343kox
        o0yFZPWU9U4dk9/ouX05W3r/YrfQf8dLT9/eljsRZj5//8V/Jbd2WIfIz3fbcFzXRqJvXwV/
        97U/GT93qfpJzvNoDwnzmclks+jSZKvb+p7Llz8PZ1b3+2B19erH5JpHi4tuhOf/zoz4MYWl
        eOqXnAfKXqqFrYzT7p5I62b22vaQNVn/6lfz/QVpn/paphoEdD9/9MSlXUiJpTgj0VCLuag4
        EQCsBIyE9wIAAA==
X-CMS-MailID: 20220123192001epcas5p1e5c0fcf841684b5996c5da8cab805899
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192001epcas5p1e5c0fcf841684b5996c5da8cab805899
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192001epcas5p1e5c0fcf841684b5996c5da8cab805899@epcas5p1.samsung.com>
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

