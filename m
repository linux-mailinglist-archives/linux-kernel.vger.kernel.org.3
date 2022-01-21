Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1685B49642D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381934AbiAURla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:41:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16206 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381811AbiAURk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:40:59 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220121174056epoutp025dd83da79231c667749fd38c32add64e~MWfFMEP0R0803608036epoutp02N
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:40:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220121174056epoutp025dd83da79231c667749fd38c32add64e~MWfFMEP0R0803608036epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786857;
        bh=N0USqWL0+6NnGZZ5VniFOdeFAynuKtrr4Ae1XWNDNyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/8DPhrY2tB6//WFXfonyyJKffOFKxxDUiKkd9DWQ2ma7ZgjLBB+zD0y96ctRCYKM
         wFkIrMNg7HOSBmUbA7n1P3W7RgsTNLhzEFCpddJkChuF8QVSlzEvwjTQgKb+ZGvyHv
         aRt9MsH7Em2X7ZC1OKH4fBWKfT6TbtnILT/eSnAc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220121174056epcas5p27fa8f5dccc555c593365992dd6068ea5~MWfEnP58G0950309503epcas5p2Y;
        Fri, 21 Jan 2022 17:40:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JgRVq1swdz4x9Pt; Fri, 21 Jan
        2022 17:40:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.B5.05590.320FAE16; Sat, 22 Jan 2022 02:40:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220121174050epcas5p31341f66152e9f69200905a2936cc14ea~MWe_2inhw3091330913epcas5p31;
        Fri, 21 Jan 2022 17:40:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121174050epsmtrp13cab4ab7bc93a623ee850a589be574d3~MWe_1rsyS2608726087epsmtrp1T;
        Fri, 21 Jan 2022 17:40:50 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-14-61eaf023d817
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.B7.08738.220FAE16; Sat, 22 Jan 2022 02:40:50 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174047epsmtip2ce2962e782a7a7daa72a44d321269eb3~MWe8UmN6A1229812298epsmtip2Z;
        Fri, 21 Jan 2022 17:40:47 +0000 (GMT)
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
Subject: [PATCH v3 07/16] clk: samsung: fsd: Add cmu_fsys1 clock information
Date:   Fri, 21 Jan 2022 22:58:31 +0530
Message-Id: <20220121172840.12121-8-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmuq7yh1eJBmfecVgceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe8/mdW8Du4YvXxH6wNjFe8uhg5OSQE
        TCReLP3BBGILCexmlJi0ywHC/sQosaovrouRC8j+zCjReXgmM0zDzC3rWSESuxglft65xQzh
        tDBJ7PiwkR2kik1AW+Lu9C1gY0UE3CRuNHYwgRQxC6xgluhZ9Q0sISzgI7FxTi8biM0ioCpx
        Y0cDK4jNK2Ajsfn+XBaIdfISqzccAFvNKWAr8frsPLBtEgJ7OCQaPvxngyhykTi6qokRwhaW
        eHV8CzuELSXxsr8NyOYAsrMlenYZQ4RrJJbOOwY1317iwJU5LCAlzAKaEut36YOEmQX4JHp/
        P2GC6OSV6GgTgqhWlWh+dxWqU1piYnc3K0SJh8TEx6qQgJvAKPF8id8ERtlZCDMXMDKuYpRM
        LSjOTU8tNi0wzksth0dScn7uJkZwOtXy3sH46MEHvUOMTByMhxglOJiVRHgL8l8lCvGmJFZW
        pRblxxeV5qQWH2I0BQbYRGYp0eR8YELPK4k3NLE0MDEzMzOxNDYzVBLnPZW+IVFIID2xJDU7
        NbUgtQimj4mDU6qBKYXr1GnNE5WnduxoZv5nEKJ78rQ7/6vfN2cfmnz3jMfRgAnbetN8FNS/
        iD2RKKifdPay/5PeuK4rMux2TYdzuxdKuS0VilwlGCsvLRptrVEo4P5dR7FwZWJr60+OzoYl
        lTaFk/but3ymlR56fhm7ympDz8k5pz0fWC1Q/7e3Zktz2YPraVOUasozHnWqlsU9CxbwWi03
        OSlcT0D89czmRcJMps639gsHzmwLPbwr4biK+kInz3eLd63ht1n41/pehUqb7eqrYmuMzTum
        L+tMr4pNfPpheez9hz8fi4gWXVvd9iw6a6/RFaENS1K0w+RM9lXIPSy93lx7MtG01Of+g2WW
        R9msStcIsL8V/ymrxFKckWioxVxUnAgAZMYTGzAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvK7Sh1eJBg//s1kceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Ml7/Myv4HVyx
        +vgP1gbGK15djJwcEgImEjO3rGftYuTiEBLYwShx+/5PVoiEtMT1jRPYIWxhiZX/nrNDFDUx
        Sex4u5YRJMEmoC1xd/oWJhBbRMBDou3fPWaQImaBXcwS3Z0nwBLCAj4SG+f0soHYLAKqEjd2
        NIBt4BWwkdh8fy4LxAZ5idUbDjCD2JwCthKvz84Ds4WAappnbWWawMi3gJFhFaNkakFxbnpu
        sWGBUV5quV5xYm5xaV66XnJ+7iZGcExoae1g3LPqg94hRiYOxkOMEhzMSiK8BfmvEoV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgkr3U/vBx3ZZfdW90
        z2s2sZxYdGpt49JFdmI7b3D9ND6lvqhgMZOQ0r5M6/974pKnifF9va/8dm3ydf7TR+yOMzya
        xJW1prFpze97RaWVmeHz7aUUdBfaVTS4KvJ+UbCcsvlCY8izR0a9Buvqb9qeNJ/HMiWe4Yvo
        FB13Vt4TXhVFM7dx1c/hnC5kJinnHqVYbljaLsg7L9KrcH/mrJIdj4PlVngv9cndvLzXgC9S
        kGsTR+jHR1yKDVfOZVQwGh7Pn5iYELDf3FlSM/pd7oNc6zCWW2suHHT27JivL33CWGN6YKFx
        t2tMCr/cRzPDV9s7zlnO/8M2P8G+kuPZqqjQP5m6oozXbresO73slqESS3FGoqEWc1FxIgCo
        TVKJ+AIAAA==
X-CMS-MailID: 20220121174050epcas5p31341f66152e9f69200905a2936cc14ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174050epcas5p31341f66152e9f69200905a2936cc14ea
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174050epcas5p31341f66152e9f69200905a2936cc14ea@epcas5p3.samsung.com>
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
index 8062afab75e3..95367d151ab6 100644
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

