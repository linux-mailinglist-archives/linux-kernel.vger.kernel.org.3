Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B051949823F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiAXO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:29:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:41992 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbiAXO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:26 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220124142924epoutp026d431fd36902146c8ee2d4248631af64~NOztF_x2e3235432354epoutp02Z
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220124142924epoutp026d431fd36902146c8ee2d4248631af64~NOztF_x2e3235432354epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034564;
        bh=tmwAcXo/cjvGgtFIgEzsBlKcTm0IKVnazYEIFnLG2iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZkCySwsQVgs9mXPJRFusfxwm8vK81IzT0MIyHFuQjJPmeJ4b2GtLXAZNJULh3Smc
         KiMXx2HXv9+J8HRi43bG9qxAcSJq8RsT5TIvS24kJ7eEGaPEhsfuxAg00J2nSzzlTA
         Kpj06fNZHDliaRUPxrRY9eBWLupej3kYYnUjvHs8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220124142924epcas5p31104dcd05b9ecc9f5c757b612411a036~NOzsa2b4V0491504915epcas5p3K;
        Mon, 24 Jan 2022 14:29:24 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JjC6S396kz4x9Pv; Mon, 24 Jan
        2022 14:29:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.24.05590.0C7BEE16; Mon, 24 Jan 2022 23:29:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220124142919epcas5p3232941c11ef3c5ac8de2ca89b21131e2~NOzocY9CS0627406274epcas5p3r;
        Mon, 24 Jan 2022 14:29:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142919epsmtrp2f45aad55a8db25d2930949d51ce400df~NOzoa7mv41656816568epsmtrp20;
        Mon, 24 Jan 2022 14:29:19 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-7e-61eeb7c0c1ec
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.AB.08738.FB7BEE16; Mon, 24 Jan 2022 23:29:19 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142916epsmtip16c8b96146b61f2d49ff0be1b86b6d5bc~NOzlm9l9r0831608316epsmtip1h;
        Mon, 24 Jan 2022 14:29:16 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Shradha Todi <shradha.t@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH v5 06/16] clk: samsung: fsd: Add cmu_fsys0 clock information
Date:   Mon, 24 Jan 2022 19:46:34 +0530
Message-Id: <20220124141644.71052-7-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmpu6B7e8SDdo3iFoceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBZHTi1hstj49geTxZQ/y5ksNj2+xmrxseceq8XDV+EWl3fNYbOY
        cX4fk8Wp65/ZLBZt/cJu0br3CLvF4TftrBb/rm1kseg9XGvx+PofNgcRjzXz1jB6/P41idFj
        VkMvm8emVZ1sHneu7WHz2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCsq2yYjNTEltUghNS85
        PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DslhbLEnFKgUEBicbGSvp1N
        UX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG3Acr2QoWTWSsaJ5x
        gbGB8W8jYxcjJ4eEgInE7yVTmboYuTiEBHYzSvza8ZgdwvnEKHHqyxpGCOczo0T/mvtwLe/u
        bWWGSOxilNiysx2qpYVJouH/NDaQKjYBbYm707cwgdgiAm4SNxo7wJYwC3xnljhwcgdYQljA
        R2LdpOOsIDaLgKpE681zLCA2r4CNxMpJLUwQ6+QlVm84wAxicwrYSsxb+A1skITAGQ6Jrptf
        2CGKXCSerWtihbCFJV4d3wIVl5L4/G4v0EUcQHa2RM8uY4hwjcTSecdYIGx7iQNX5rCAlDAL
        aEqs36UPEmYW4JPo/f2ECaKTV6KjTQiiWlWi+d1VqE5piYnd3awQJR4SHR8CIMEwgVHi360b
        zBMYZWchDF3AyLiKUTK1oDg3PbXYtMA4L7UcHlXJ+bmbGMHJVst7B+OjBx/0DjEycTAeYpTg
        YFYS4a1KeZcoxJuSWFmVWpQfX1Sak1p8iNEUGGITmaVEk/OB6T6vJN7QxNLAxMzMzMTS2MxQ
        SZz3VPqGRCGB9MSS1OzU1ILUIpg+Jg5OqQamJcui5fmP1LyMaPOtecu8PGLCHbn1axbYmP99
        KiEU9/L/LvY+e03pldofk2+Id4gnzz3GG1wbGCDDpRO7X1Z7wSKzTE7d7Li++cmuN/y4GTpL
        2pi/sz802eXYN8HI9LLezCN+9z5ssi+bIHT94By/z1nufhzJG8s5V5cu2PBt2RwJPuvOC0vv
        fdZazJw8qeYi49G/qondrkdKrvdNt7z9ivdZ4/Wco9c/Mcrlfe8sU/GueyC0earX1jvlgbsy
        Dm6uYPpf9i1I1fKj5AuVGju5vnOKu7b4770g/o3lsOHJIssgV9cGFv6FGk3/dqxuferlVeWp
        sHOjmJ0JQ9Kkkj9W3U/rI2SWvePjsuk4slaJpTgj0VCLuag4EQDXkgqjPwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO7+7e8SDZbtUrM48P4gi8WDedvY
        LP5OOsZu8X5ZD6PF/CPnWC2OnFrCZLHx7Q8miyl/ljNZbHp8jdXiY889VouHr8ItLu+aw2Yx
        4/w+JotT1z+zWSza+oXdonXvEXaLw2/aWS3+XdvIYtF7uNbi8fU/bA4iHmvmrWH0+P1rEqPH
        rIZeNo9NqzrZPO5c28PmsXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0C
        V8bcByvZChZNZKxonnGBsYHxbyNjFyMnh4SAicS7e1uZuxi5OIQEdjBKTPm2gh0iIS1xfeME
        KFtYYuW/5+wQRU1MEic/XWQCSbAJaEvcnb4FzBYR8JBo+3cPbBKzQDeLxIwdEAlhAR+JdZOO
        s4LYLAKqEq03z7GA2LwCNhIrJ7UwQWyQl1i94QAziM0pYCsxb+E3oDgH0DYbiXO/VSYw8i1g
        ZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcKVpaOxj3rPqgd4iRiYPxEKMEB7OS
        CG9VyrtEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpgs
        cppOvo+P8A3+VDfnwxm96dOYP72+t8ptydyXHz7bdi6IlUh4dPBDn1bTzLAql7+xdtbht9hX
        rdz/dJ3130bfH0tztr8VrJR/2pWz9FRJgskD7ts5YVG/l9kzM8tI/elbcUV72bKHnL8d296+
        +iGivuqZ01beLcFLXiwTjU3a8yM/f1O51Y9jE9/4POXgPn2hYaNnQKTeyS8bWlxfrGfo6DBv
        PFEyc8L7JQ03w74v2VeaE1Z2081x0epZS3aJqW8v/NOsGfer6W2pm5mp8dw7ZtqbKmcviFz6
        rEQxkquHgavrnlCutm1ttWvQl+VnXXesYHNS7CsI97YSsrD99s+Sp0TkgD6bxSXulU6Njxcq
        sRRnJBpqMRcVJwIAb3uK7AMDAAA=
X-CMS-MailID: 20220124142919epcas5p3232941c11ef3c5ac8de2ca89b21131e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142919epcas5p3232941c11ef3c5ac8de2ca89b21131e2
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142919epcas5p3232941c11ef3c5ac8de2ca89b21131e2@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMU_FSYS0 block has IPs like UFS, EQOS, PCIe etc, lets add
the related clock information for the same.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 302 ++++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index a3d328318814..785c493be2b6 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -673,6 +673,305 @@ static const struct samsung_cmu_info peric_cmu_info __initconst = {
 	.clk_name		= "dout_cmu_pll_shared0_div4",
 };
 
+/* Register Offset definitions for CMU_FSYS0 (0x15010000) */
+#define PLL_CON0_CLKCMU_FSYS0_UNIPRO		0x100
+#define PLL_CON0_CLK_FSYS0_SLAVEBUSCLK		0x140
+#define PLL_CON0_EQOS_RGMII_125_MUX1		0x160
+#define DIV_CLK_UNIPRO				0x1800
+#define DIV_EQS_RGMII_CLK_125			0x1804
+#define DIV_PERIBUS_GRP				0x1808
+#define DIV_EQOS_RII_CLK2O5			0x180c
+#define DIV_EQOS_RMIICLK_25			0x1810
+#define DIV_PCIE_PHY_OSCCLK			0x1814
+#define GAT_FSYS0_EQOS_TOP0_IPCLKPORT_CLK_PTP_REF_I	0x2004
+#define GAT_FSYS0_EQOS_TOP0_IPCLKPORT_CLK_RX_I	0x2008
+#define GAT_FSYS0_FSYS0_CMU_FSYS0_IPCLKPORT_PCLK	0x200c
+#define GAT_FSYS0_GPIO_FSYS0_IPCLKPORT_OSCCLK	0x2010
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_PLL_REFCLK_FROM_XO	0x2014
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_PIPE_PAL_INST_0_I_IMMORTAL_CLK	0x2018
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_AUX_CLK_SOC	0x201c
+#define GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_MPHY_REFCLK_IXTAL24	0x2020
+#define GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_MPHY_REFCLK_IXTAL26	0x2024
+#define GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_MPHY_REFCLK_IXTAL24	0x2028
+#define GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_MPHY_REFCLK_IXTAL26	0x202c
+#define GAT_FSYS0_AHBBR_FSYS0_IPCLKPORT_HCLK	0x2038
+#define GAT_FSYS0_AXI2APB_FSYS0_IPCLKPORT_ACLK	0x203c
+#define GAT_FSYS0_BUS_D_FSYS0_IPCLKPORT_MAINCLK	0x2040
+#define GAT_FSYS0_BUS_D_FSYS0_IPCLKPORT_PERICLK	0x2044
+#define GAT_FSYS0_BUS_P_FSYS0_IPCLKPORT_MAINCLK	0x2048
+#define GAT_FSYS0_BUS_P_FSYS0_IPCLKPORT_TCUCLK	0x204c
+#define GAT_FSYS0_CPE425_IPCLKPORT_ACLK		0x2050
+#define GAT_FSYS0_EQOS_TOP0_IPCLKPORT_ACLK_I	0x2054
+#define GAT_FSYS0_EQOS_TOP0_IPCLKPORT_HCLK_I	0x2058
+#define GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RGMII_CLK_I	0x205c
+#define GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RII_CLK_I	0x2060
+#define GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RMII_CLK_I	0x2064
+#define GAT_FSYS0_GPIO_FSYS0_IPCLKPORT_PCLK	0x2068
+#define GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_D	0x206c
+#define GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_D1	0x2070
+#define GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_P	0x2074
+#define GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_S	0x2078
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_I_APB_PCLK	0x207c
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_PLL_REFCLK_FROM_SYSPLL	0x2080
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_PIPE_PAL_INST_0_I_APB_PCLK_0	0x2084
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_DBI_ACLK_SOC	0x2088
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK	0x208c
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_MSTR_ACLK_SOC	0x2090
+#define GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_SLV_ACLK_SOC	0x2094
+#define GAT_FSYS0_SMMU_FSYS0_IPCLKPORT_CCLK	0x2098
+#define GAT_FSYS0_SMMU_FSYS0_IPCLKPORT_FSYS0_BCLK	0x209c
+#define GAT_FSYS0_SYSREG_FSYS0_IPCLKPORT_PCLK	0x20a0
+#define GAT_FSYS0_UFS_TOP0_IPCLKPORT_HCLK_BUS	0x20a4
+#define GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_ACLK	0x20a8
+#define GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_CLK_UNIPRO	0x20ac
+#define GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_FMP_CLK	0x20b0
+#define GAT_FSYS0_UFS_TOP1_IPCLKPORT_HCLK_BUS	0x20b4
+#define GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_ACLK	0x20b8
+#define GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_CLK_UNIPRO	0x20bc
+#define GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_FMP_CLK	0x20c0
+#define GAT_FSYS0_RII_CLK_DIVGATE			0x20d4
+
+static const unsigned long fsys0_clk_regs[] __initconst = {
+	PLL_CON0_CLKCMU_FSYS0_UNIPRO,
+	PLL_CON0_CLK_FSYS0_SLAVEBUSCLK,
+	PLL_CON0_EQOS_RGMII_125_MUX1,
+	DIV_CLK_UNIPRO,
+	DIV_EQS_RGMII_CLK_125,
+	DIV_PERIBUS_GRP,
+	DIV_EQOS_RII_CLK2O5,
+	DIV_EQOS_RMIICLK_25,
+	DIV_PCIE_PHY_OSCCLK,
+	GAT_FSYS0_EQOS_TOP0_IPCLKPORT_CLK_PTP_REF_I,
+	GAT_FSYS0_EQOS_TOP0_IPCLKPORT_CLK_RX_I,
+	GAT_FSYS0_FSYS0_CMU_FSYS0_IPCLKPORT_PCLK,
+	GAT_FSYS0_GPIO_FSYS0_IPCLKPORT_OSCCLK,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_PLL_REFCLK_FROM_XO,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_PIPE_PAL_INST_0_I_IMMORTAL_CLK,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_AUX_CLK_SOC,
+	GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_MPHY_REFCLK_IXTAL24,
+	GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_MPHY_REFCLK_IXTAL26,
+	GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_MPHY_REFCLK_IXTAL24,
+	GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_MPHY_REFCLK_IXTAL26,
+	GAT_FSYS0_AHBBR_FSYS0_IPCLKPORT_HCLK,
+	GAT_FSYS0_AXI2APB_FSYS0_IPCLKPORT_ACLK,
+	GAT_FSYS0_BUS_D_FSYS0_IPCLKPORT_MAINCLK,
+	GAT_FSYS0_BUS_D_FSYS0_IPCLKPORT_PERICLK,
+	GAT_FSYS0_BUS_P_FSYS0_IPCLKPORT_MAINCLK,
+	GAT_FSYS0_BUS_P_FSYS0_IPCLKPORT_TCUCLK,
+	GAT_FSYS0_CPE425_IPCLKPORT_ACLK,
+	GAT_FSYS0_EQOS_TOP0_IPCLKPORT_ACLK_I,
+	GAT_FSYS0_EQOS_TOP0_IPCLKPORT_HCLK_I,
+	GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RGMII_CLK_I,
+	GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RII_CLK_I,
+	GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RMII_CLK_I,
+	GAT_FSYS0_GPIO_FSYS0_IPCLKPORT_PCLK,
+	GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_D,
+	GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_D1,
+	GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_P,
+	GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_S,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_I_APB_PCLK,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_PLL_REFCLK_FROM_SYSPLL,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_PIPE_PAL_INST_0_I_APB_PCLK_0,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_DBI_ACLK_SOC,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_MSTR_ACLK_SOC,
+	GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_SLV_ACLK_SOC,
+	GAT_FSYS0_SMMU_FSYS0_IPCLKPORT_CCLK,
+	GAT_FSYS0_SMMU_FSYS0_IPCLKPORT_FSYS0_BCLK,
+	GAT_FSYS0_SYSREG_FSYS0_IPCLKPORT_PCLK,
+	GAT_FSYS0_UFS_TOP0_IPCLKPORT_HCLK_BUS,
+	GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_ACLK,
+	GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_CLK_UNIPRO,
+	GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_FMP_CLK,
+	GAT_FSYS0_UFS_TOP1_IPCLKPORT_HCLK_BUS,
+	GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_ACLK,
+	GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_CLK_UNIPRO,
+	GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_FMP_CLK,
+	GAT_FSYS0_RII_CLK_DIVGATE,
+};
+
+static const struct samsung_fixed_rate_clock fsys0_fixed_clks[] __initconst = {
+	FRATE(0, "pad_eqos0_phyrxclk", NULL, 0, 125000000),
+	FRATE(0, "i_mphy_refclk_ixtal26", NULL, 0, 26000000),
+	FRATE(0, "xtal_clk_pcie_phy", NULL, 0, 100000000),
+};
+
+/* List of parent clocks for Muxes in CMU_FSYS0 */
+PNAME(mout_fsys0_clkcmu_fsys0_unipro_p) = { "fin_pll", "dout_cmu_pll_shared0_div6" };
+PNAME(mout_fsys0_clk_fsys0_slavebusclk_p) = { "fin_pll", "dout_cmu_fsys0_shared1div4" };
+PNAME(mout_fsys0_eqos_rgmii_125_mux1_p) = { "fin_pll", "dout_cmu_fsys0_shared0div4" };
+
+static const struct samsung_mux_clock fsys0_mux_clks[] __initconst = {
+	MUX(0, "mout_fsys0_clkcmu_fsys0_unipro", mout_fsys0_clkcmu_fsys0_unipro_p,
+	    PLL_CON0_CLKCMU_FSYS0_UNIPRO, 4, 1),
+	MUX(0, "mout_fsys0_clk_fsys0_slavebusclk", mout_fsys0_clk_fsys0_slavebusclk_p,
+	    PLL_CON0_CLK_FSYS0_SLAVEBUSCLK, 4, 1),
+	MUX(0, "mout_fsys0_eqos_rgmii_125_mux1", mout_fsys0_eqos_rgmii_125_mux1_p,
+	    PLL_CON0_EQOS_RGMII_125_MUX1, 4, 1),
+};
+
+static const struct samsung_div_clock fsys0_div_clks[] __initconst = {
+	DIV(0, "dout_fsys0_clk_unipro", "mout_fsys0_clkcmu_fsys0_unipro", DIV_CLK_UNIPRO, 0, 4),
+	DIV(0, "dout_fsys0_eqs_rgmii_clk_125", "mout_fsys0_eqos_rgmii_125_mux1",
+	    DIV_EQS_RGMII_CLK_125, 0, 4),
+	DIV(FSYS0_DOUT_FSYS0_PERIBUS_GRP, "dout_fsys0_peribus_grp",
+	    "mout_fsys0_clk_fsys0_slavebusclk", DIV_PERIBUS_GRP, 0, 4),
+	DIV(0, "dout_fsys0_eqos_rii_clk2o5", "fsys0_rii_clk_divgate", DIV_EQOS_RII_CLK2O5, 0, 4),
+	DIV(0, "dout_fsys0_eqos_rmiiclk_25", "mout_fsys0_eqos_rgmii_125_mux1",
+	    DIV_EQOS_RMIICLK_25, 0, 5),
+	DIV(0, "dout_fsys0_pcie_phy_oscclk", "mout_fsys0_eqos_rgmii_125_mux1",
+	    DIV_PCIE_PHY_OSCCLK, 0, 4),
+};
+
+static const struct samsung_gate_clock fsys0_gate_clks[] __initconst = {
+	GATE(FSYS0_EQOS_TOP0_IPCLKPORT_CLK_RX_I, "fsys0_eqos_top0_ipclkport_clk_rx_i",
+	     "pad_eqos0_phyrxclk", GAT_FSYS0_EQOS_TOP0_IPCLKPORT_CLK_RX_I, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_SUBCTRL_INST0_AUX_CLK_SOC,
+	     "fsys0_pcie_top_ipclkport_fsd_pcie_sub_ctrl_inst_0_aux_clk_soc", "fin_pll",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_AUX_CLK_SOC, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_fsys0_cmu_fsys0_ipclkport_pclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_FSYS0_CMU_FSYS0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0,
+	     "fsys0_pcie_top_ipclkport_pcieg3_phy_x4_inst_0_pll_refclk_from_xo",
+	     "xtal_clk_pcie_phy",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_PLL_REFCLK_FROM_XO, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(UFS0_MPHY_REFCLK_IXTAL24, "fsys0_ufs_top0_ipclkport_i_mphy_refclk_ixtal24",
+	     "i_mphy_refclk_ixtal26", GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_MPHY_REFCLK_IXTAL24, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(UFS0_MPHY_REFCLK_IXTAL26, "fsys0_ufs_top0_ipclkport_i_mphy_refclk_ixtal26",
+	     "i_mphy_refclk_ixtal26", GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_MPHY_REFCLK_IXTAL26, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(UFS1_MPHY_REFCLK_IXTAL24, "fsys0_ufs_top1_ipclkport_i_mphy_refclk_ixtal24",
+	     "i_mphy_refclk_ixtal26", GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_MPHY_REFCLK_IXTAL24, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(UFS1_MPHY_REFCLK_IXTAL26, "fsys0_ufs_top1_ipclkport_i_mphy_refclk_ixtal26",
+	     "i_mphy_refclk_ixtal26", GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_MPHY_REFCLK_IXTAL26, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_ahbbr_fsys0_ipclkport_hclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_AHBBR_FSYS0_IPCLKPORT_HCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_axi2apb_fsys0_ipclkport_aclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_AXI2APB_FSYS0_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_bus_d_fsys0_ipclkport_mainclk", "mout_fsys0_clk_fsys0_slavebusclk",
+	     GAT_FSYS0_BUS_D_FSYS0_IPCLKPORT_MAINCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_bus_d_fsys0_ipclkport_periclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_BUS_D_FSYS0_IPCLKPORT_PERICLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_bus_p_fsys0_ipclkport_mainclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_BUS_P_FSYS0_IPCLKPORT_MAINCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_bus_p_fsys0_ipclkport_tcuclk", "mout_fsys0_eqos_rgmii_125_mux1",
+	     GAT_FSYS0_BUS_P_FSYS0_IPCLKPORT_TCUCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_cpe425_ipclkport_aclk", "mout_fsys0_clk_fsys0_slavebusclk",
+	     GAT_FSYS0_CPE425_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(FSYS0_EQOS_TOP0_IPCLKPORT_ACLK_I, "fsys0_eqos_top0_ipclkport_aclk_i",
+	     "dout_fsys0_peribus_grp", GAT_FSYS0_EQOS_TOP0_IPCLKPORT_ACLK_I, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(FSYS0_EQOS_TOP0_IPCLKPORT_HCLK_I, "fsys0_eqos_top0_ipclkport_hclk_i",
+	     "dout_fsys0_peribus_grp", GAT_FSYS0_EQOS_TOP0_IPCLKPORT_HCLK_I, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(FSYS0_EQOS_TOP0_IPCLKPORT_RGMII_CLK_I, "fsys0_eqos_top0_ipclkport_rgmii_clk_i",
+	      "dout_fsys0_eqs_rgmii_clk_125", GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RGMII_CLK_I, 21,
+	      CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_eqos_top0_ipclkport_rii_clk_i", "dout_fsys0_eqos_rii_clk2o5",
+	     GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RII_CLK_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_eqos_top0_ipclkport_rmii_clk_i", "dout_fsys0_eqos_rmiiclk_25",
+	     GAT_FSYS0_EQOS_TOP0_IPCLKPORT_RMII_CLK_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_gpio_fsys0_ipclkport_pclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_GPIO_FSYS0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_gpio_fsys0_ipclkport_oscclk", "fin_pll",
+	     GAT_FSYS0_GPIO_FSYS0_IPCLKPORT_OSCCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_ns_brdg_fsys0_ipclkport_clk__psoc_fsys0__clk_fsys0_d",
+	     "mout_fsys0_clk_fsys0_slavebusclk",
+	     GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_D, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_ns_brdg_fsys0_ipclkport_clk__psoc_fsys0__clk_fsys0_d1",
+	     "mout_fsys0_eqos_rgmii_125_mux1",
+	     GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_D1, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_ns_brdg_fsys0_ipclkport_clk__psoc_fsys0__clk_fsys0_p",
+	     "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_P, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_ns_brdg_fsys0_ipclkport_clk__psoc_fsys0__clk_fsys0_s",
+	     "mout_fsys0_clk_fsys0_slavebusclk",
+	     GAT_FSYS0_NS_BRDG_FSYS0_IPCLKPORT_CLK__PSOC_FSYS0__CLK_FSYS0_S, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_pcie_top_ipclkport_pcieg3_phy_x4_inst_0_i_apb_pclk",
+	     "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_I_APB_PCLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0,
+	     "fsys0_pcie_top_ipclkport_pcieg3_phy_x4_inst_0_pll_refclk_from_syspll",
+	     "dout_fsys0_pcie_phy_oscclk",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_PCIEG3_PHY_X4_INST_0_PLL_REFCLK_FROM_SYSPLL,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_pcie_top_ipclkport_pipe_pal_inst_0_i_apb_pclk_0", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_PIPE_PAL_INST_0_I_APB_PCLK_0, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_pcie_top_ipclkport_pipe_pal_inst_0_i_immortal_clk", "fin_pll",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_PIPE_PAL_INST_0_I_IMMORTAL_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_SUBCTRL_INST0_DBI_ACLK_SOC,
+	     "fsys0_pcie_top_ipclkport_fsd_pcie_sub_ctrl_inst_0_dbi_aclk_soc",
+	     "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_DBI_ACLK_SOC, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_pcie_top_ipclkport_fsd_pcie_sub_ctrl_inst_0_i_driver_apb_clk",
+	     "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC,
+	     "fsys0_pcie_top_ipclkport_fsd_pcie_sub_ctrl_inst_0_mstr_aclk_soc",
+	     "mout_fsys0_clk_fsys0_slavebusclk",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_MSTR_ACLK_SOC, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(PCIE_SUBCTRL_INST0_SLV_ACLK_SOC,
+	     "fsys0_pcie_top_ipclkport_fsd_pcie_sub_ctrl_inst_0_slv_aclk_soc",
+	     "mout_fsys0_clk_fsys0_slavebusclk",
+	     GAT_FSYS0_PCIE_TOP_IPCLKPORT_FSD_PCIE_SUB_CTRL_INST_0_SLV_ACLK_SOC, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_smmu_fsys0_ipclkport_cclk", "mout_fsys0_eqos_rgmii_125_mux1",
+	     GAT_FSYS0_SMMU_FSYS0_IPCLKPORT_CCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_smmu_fsys0_ipclkport_fsys0_bclk", "mout_fsys0_clk_fsys0_slavebusclk",
+	     GAT_FSYS0_SMMU_FSYS0_IPCLKPORT_FSYS0_BCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_sysreg_fsys0_ipclkport_pclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_SYSREG_FSYS0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(UFS0_TOP0_HCLK_BUS, "fsys0_ufs_top0_ipclkport_hclk_bus", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_UFS_TOP0_IPCLKPORT_HCLK_BUS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(UFS0_TOP0_ACLK, "fsys0_ufs_top0_ipclkport_i_aclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(UFS0_TOP0_CLK_UNIPRO, "fsys0_ufs_top0_ipclkport_i_clk_unipro", "dout_fsys0_clk_unipro",
+	     GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_CLK_UNIPRO, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(UFS0_TOP0_FMP_CLK, "fsys0_ufs_top0_ipclkport_i_fmp_clk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_UFS_TOP0_IPCLKPORT_I_FMP_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(UFS1_TOP1_HCLK_BUS, "fsys0_ufs_top1_ipclkport_hclk_bus", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_UFS_TOP1_IPCLKPORT_HCLK_BUS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(UFS1_TOP1_ACLK, "fsys0_ufs_top1_ipclkport_i_aclk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(UFS1_TOP1_CLK_UNIPRO, "fsys0_ufs_top1_ipclkport_i_clk_unipro", "dout_fsys0_clk_unipro",
+	     GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_CLK_UNIPRO, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(UFS1_TOP1_FMP_CLK, "fsys0_ufs_top1_ipclkport_i_fmp_clk", "dout_fsys0_peribus_grp",
+	     GAT_FSYS0_UFS_TOP1_IPCLKPORT_I_FMP_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "fsys0_rii_clk_divgate", "dout_fsys0_eqos_rmiiclk_25", GAT_FSYS0_RII_CLK_DIVGATE,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(FSYS0_EQOS_TOP0_IPCLKPORT_CLK_PTP_REF_I, "fsys0_eqos_top0_ipclkport_clk_ptp_ref_i",
+	     "fin_pll", GAT_FSYS0_EQOS_TOP0_IPCLKPORT_CLK_PTP_REF_I, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info fsys0_cmu_info __initconst = {
+	.mux_clks		= fsys0_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(fsys0_mux_clks),
+	.div_clks		= fsys0_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(fsys0_div_clks),
+	.gate_clks		= fsys0_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(fsys0_gate_clks),
+	.fixed_clks		= fsys0_fixed_clks,
+	.nr_fixed_clks		= ARRAY_SIZE(fsys0_fixed_clks),
+	.nr_clk_ids		= FSYS0_NR_CLK,
+	.clk_regs		= fsys0_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(fsys0_clk_regs),
+	.clk_name		= "dout_cmu_fsys0_shared1div4",
+};
+
 /**
  * fsd_cmu_probe - Probe function for FSD platform clocks
  * @pdev: Pointer to platform device
@@ -695,6 +994,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
 	{
 		.compatible = "tesla,fsd-clock-peric",
 		.data = &peric_cmu_info,
+	}, {
+		.compatible = "tesla,fsd-clock-fsys0",
+		.data = &fsys0_cmu_info,
 	}, {
 	},
 };
-- 
2.25.1

