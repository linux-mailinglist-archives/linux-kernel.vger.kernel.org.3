Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23BA48D792
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiAMMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:23:54 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59004 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiAMMXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:23:47 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220113122346epoutp0487fadb445d1006d3ef1e577fe781c1d6~J0-3kFpA_2323623236epoutp04Z
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220113122346epoutp0487fadb445d1006d3ef1e577fe781c1d6~J0-3kFpA_2323623236epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076626;
        bh=XID+/ixJpzyhrGo/q7u4jozH/X496Ara4sjuWi0oF6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKzFa+i+9Ay2IIULmHLID2WElSVgjMR3ye6oSuzD7WKabKmIHSmVLJIFKoaf+IIyg
         s5umW/+NcYW9UunZozsrgliFDyjJXqW4JcAeyJLStL3c0VcfZQdqtGcYM6kZh3xvfA
         JVWoTbHt4ABusKtXr8M7ZCg7od88HjQimQbx7wL4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220113122345epcas5p411f23ad15ac6f58a11435d150cda4a5f~J0-2Q58OV2464824648epcas5p4E;
        Thu, 13 Jan 2022 12:23:45 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNrW4NSZz4x9Pw; Thu, 13 Jan
        2022 12:23:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.11.46822.BC910E16; Thu, 13 Jan 2022 21:23:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220113122338epcas5p17ad3a31077b98388c0a6779904ee651e~J0-wdC7Z51610816108epcas5p1p;
        Thu, 13 Jan 2022 12:23:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122338epsmtrp1d4fa041460a4cb73e603fa4e15a8c08f~J0-waIEc41911119111epsmtrp1v;
        Thu, 13 Jan 2022 12:23:38 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-49-61e019cb375c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.99.08738.AC910E16; Thu, 13 Jan 2022 21:23:38 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122336epsmtip2dd77e2e3a5569e0bcc6db8c7670a975b~J0-t-pnJd1247412474epsmtip2k;
        Thu, 13 Jan 2022 12:23:36 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH 06/23] clk: samsung: fsd: Add cmu_fsys1 clock information
Date:   Thu, 13 Jan 2022 17:41:26 +0530
Message-Id: <20220113121143.22280-7-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmhu5pyQeJBt+bNCwOvD/IYvFg3jY2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w+Yg4LFm3hpGj1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36
        tqxi9PjXNJfd4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
        VFslF58AXbfMHKAvlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
        6Xp5qSVWhgYGRqZAhQnZGbNfr2Au2BFc8WXrM6YGxmleXYycHBICJhIv35xg7WLk4hAS2M0o
        cWtFGwuE84lR4mTPByjnM6PE7SezGGFajh68ygiR2MUosfTnQ6iqFiaJPS8esIBUsQloS9yd
        voUJxBYRcJO40djBBFLELNDKLDG/dTszSEJYwFPiZMMzMJtFQFVi1/XLYDavgI3Ey11L2SDW
        yUus3nAAKM7BwSlgK3F3VR7IHAmBpRwSCz7egqpxkZjzvxnqPGGJV8e3sEPYUhIv+9vYQXol
        BLIlenYZQ4RrJJbOO8YCYdtLHLgyhwWkhFlAU2L9Ln2QMLMAn0Tv7ydMEJ28Eh1tQhDVqhLN
        765CdUpLTOzuZoWwPST+ne8As4UEJjBKnH+sO4FRdhbC0AWMjKsYJVMLinPTU4tNC4zyUsvh
        8ZScn7uJEZw2tbx2MD588EHvECMTB+MhRgkOZiUR3v6i+4lCvCmJlVWpRfnxRaU5qcWHGE2B
        ATaRWUo0OR+YuPNK4g1NLA1MzMzMTCyNzQyVxHlPp29IFBJITyxJzU5NLUgtgulj4uCUamBa
        eerm+fcn7Ofqh15cxXJ6XXmx8rI3804vvvmeZ/6vUKtnlzc5pj/Urt00WzzpSQv/gYt6zfZv
        X6qc3qYsO2ul0c6TP1l2f1imvoip0lizYE9t5N8Mx73/ljrsuXYjedaigucddQ3HQm4WZqn9
        uLLGi633+wej6sw5p/yTHFSMHrlmtqzcskXJm//cnYqTQU+CX/34cCRQaWJTfN6G8O+OFbcM
        J0wOjTnFtH2rtfQe84k7CrYraWbtqcmxCEo/cd7G4Ex6rtmpq4+EuUsnWKpJX+K3t/OpOizx
        PIO39vO7tg9PzoXMknh6oClts8ylLsunhlzxkc/7LJJTfXUyEvadqHvKc7ue1eqhZQ17rGKN
        EktxRqKhFnNRcSIANBdNQCQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvO4pyQeJBpP7xC0OvD/IYvFg3jY2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w+Yg4LFm3hpGj1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36
        tqxi9PjXNJfd4/MmuQDOKC6blNSczLLUIn27BK6M2a9XMBfsCK74svUZUwPjNK8uRk4OCQET
        iaMHrzJ2MXJxCAnsYJR4smYDM0RCWuL6xgnsELawxMp/z9khipqYJLYunMQKkmAT0Ja4O30L
        E4gtIuAh0fbvHjNIEbPAVGaJVRu6wCYJC3hKnGx4BmazCKhK7Lp+GczmFbCReLlrKRvEBnmJ
        1RsOAMU5ODgFbCXursoDCQsBlZx7tZ5tAiPfAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnp
        esn5uZsYwUGvpbWDcc+qD3qHGJk4GA8xSnAwK4nw9hfdTxTiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBaXXk/mz/hauTmGP+B645GpJ72/lslF0E508G
        U3seqalKK+87p+pkH3witFPs1r3DShs/MjVcfRvKe4HD8E/GoVSNq7M5ZLSsbf/bcyfIpFws
        8cyU+OL4wCnwfXXQpiIHqXeXpqxctL3kachBncikyoObP4WeLgvef1vlcKqS/qduF37p2gfP
        iu59YVM+cbFQZeVvP4vrAV/7u+NcetgXRjdtUtnuKhO6/KWHQqZY44sHmzc/W62dJfi96Pjp
        jwy2getNV9xQve1w5/cpu/h1/d4nLL+kL6qZ8iO1NY9xoZFelkTfWidhmS9/uuZuv7vyUOyL
        iwwXTwU7f/RnY6x+/mPN3WPlYXciBJRTm57uUWIpzkg01GIuKk4EAFimcVXpAgAA
X-CMS-MailID: 20220113122338epcas5p17ad3a31077b98388c0a6779904ee651e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122338epcas5p17ad3a31077b98388c0a6779904ee651e
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122338epcas5p17ad3a31077b98388c0a6779904ee651e@epcas5p1.samsung.com>
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
index 8a7a668eb4be..d06afab39d37 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -1012,6 +1012,178 @@ static const struct samsung_cmu_info fsys0_cmu_info __initconst = {
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
@@ -1052,6 +1224,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
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
2.17.1

