Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A3248D78C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiAMMXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:23:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24856 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiAMMXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:23:41 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220113122339epoutp032ce25a4cd48c15aad182c6c5198c0c06~J0-xWV3rX1524915249epoutp03u
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220113122339epoutp032ce25a4cd48c15aad182c6c5198c0c06~J0-xWV3rX1524915249epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076619;
        bh=ssLVFORZtbA/D+i1S68Hlsny3z/vf9PUrh9EyzaIKXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXleXfxvM/nXhmhEePX45Qtc3pZMUVShPTV/Z2F4Rf2gB7NBYBHAEQnXRJ+LoVwLM
         2+UAXUFD7iQt+Uk+nH+Bfypi+DCaafeuN+w5m7bRX6rF1kqfO6k4W3y2e9px6lxLFM
         7SbT6eg0rV8lszJLN63PfXO0Z4ywOd/If0Vo6SsE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220113122339epcas5p20b2e7c183376335ed12dc9478956c762~J0-w29G9L1818018180epcas5p2G;
        Thu, 13 Jan 2022 12:23:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JZNrR3T6Jz4x9Q1; Thu, 13 Jan
        2022 12:23:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.41.05590.6C910E16; Thu, 13 Jan 2022 21:23:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122334epcas5p2d5958c77b0635e848f81ed2c5c98cdd5~J0-sfttW71818018180epcas5p2B;
        Thu, 13 Jan 2022 12:23:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122334epsmtrp1dd6ec4d72c808117addefd1eb29fca7a~J0-sfCK1p1911119111epsmtrp1p;
        Thu, 13 Jan 2022 12:23:34 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-af-61e019c69518
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.98.29871.6C910E16; Thu, 13 Jan 2022 21:23:34 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122332epsmtip2b737c7ffb5e55295e50874b04af3c986~J0-qCJ9mT1245412454epsmtip2Y;
        Thu, 13 Jan 2022 12:23:31 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Shradha Todi <shradha.t@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH 05/23] clk: samsung: fsd: Add cmu_fsys0 clock information
Date:   Thu, 13 Jan 2022 17:41:25 +0530
Message-Id: <20220113121143.22280-6-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmlu4xyQeJBgsP2lgceH+QxeLBvG1s
        Fu+X9TBazD9yjtXiyKklTBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndWi93CtxePrf9gchDzWzFvD6DGroZfNY9OqTjaPO9f2sHls
        XlLvceVEE6tH35ZVjB7/muaye3zeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCo
        a2hpYa6kkJeYm2qr5OIToOuWmQP0jpJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWn
        wKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PR+YVsBXcnMFbsO/CcsYFxbyNjFyMnh4SAiUR7
        wx0gm4tDSGA3o8T2G2eZIJxPjBLX509hhXC+MUo8ufyGBabl7I8WNojEXkaJE3PeQLW0MEls
        OnKXDaSKTUBb4u70LUwgtoiAm8SNxg6wImaBK8wSxxtXgxUJC3hKzP17EWg7BweLgKrEtY3u
        IGFeARuJO2/PsENsk5dYveEAM0gJp4CtxN1VeSBjJAR2cEhMOd0C9YSLROOK66wQtrDEq+Nb
        oHqlJF72t7GD9EoIZEv07DKGCNdILJ13DOoZe4kDV+awgJQwC2hKrN+lDxJmFuCT6P39hAmi
        k1eio00IolpVovndVahOaYmJ3d1QSz0k7l/9DHaMkMAERolph1ImMMrOQhi6gJFxFaNkakFx
        bnpqsWmBcV5qOTyikvNzNzGCU6mW9w7GRw8+6B1iZOJgPMQowcGsJMLbX3Q/UYg3JbGyKrUo
        P76oNCe1+BCjKTC8JjJLiSbnA5N5Xkm8oYmlgYmZmZmJpbGZoZI476n0DYlCAumJJanZqakF
        qUUwfUwcnFINTC8F6q8ETF7VY3hg6bHFzg8yVzz7/Dt5exIT19G5/0+cP2Q35ZhchaAQ8/JP
        +xdp6nHvOGR84+T+66ZGMzn3TZG/cG1tpsqaBZe5Hp7i9dZrZt/8bYJu+NmKp0+LXa6unKx3
        M/nk5vW/d0myTut7sI8tkpFx1u7YvMuX34gejPZ80Wb2svfUr01uKY/YromW8c1nSteVfKOy
        U+bLqjrG/iM6waxsmh+2WfIKnVjw29koL0t9yQ3Nb9aaRbt/dDcUxN85ePythWRl7ToZh833
        pfZUXb+VvKomLqmkP7bqdYl9inyO/RO5mLzjMYJHvhnufFP/OIdn8tQ7nlJLk00qmKWUTLQ1
        PafoHN5SyTWvtUCJpTgj0VCLuag4EQB6NTHwLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvO4xyQeJBr8OclkceH+QxeLBvG1s
        Fu+X9TBazD9yjtXiyKklTBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndWi93CtxePrf9gchDzWzFvD6DGroZfNY9OqTjaPO9f2sHls
        XlLvceVEE6tH35ZVjB7/muaye3zeJBfAGcVlk5Kak1mWWqRvl8CV8ej8QraCuxMYK/YdeM7Y
        wLi3kbGLkZNDQsBE4uyPFrYuRi4OIYHdjBJzV99ngkhIS1zfOIEdwhaWWPnvOTtEUROTxOb1
        N8C62QS0Je5O3wLWICLgIdH27x4zSBGzwDNmiQnbN7GAJIQFPCXm/r0I1MDBwSKgKnFtoztI
        mFfARuLO2zNQC+QlVm84wAxSwilgK3F3VR5IWAio5Nyr9WwTGPkWMDKsYpRMLSjOTc8tNiww
        zEst1ytOzC0uzUvXS87P3cQIjgQtzR2M21d90DvEyMTBeIhRgoNZSYS3v+h+ohBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MhrPkthiWvSmVmxRh4zBN
        fC6Pl7plPKcAC/vF+S97PwfZvXaamCcxd9/0NvvHz7XltS2dz+SvKp0eEPwvO+6U8/e6+Zsm
        hyyo2TX92cOAwueKXFc7lPd37+T9rPfUU/ScygyJ709l5wXb7Hp1+Jj1mzmcQreCf3vq7vP8
        xDB9m0CT6Z8thWrHBXSqn739J57o6FL4RzD5aJZkVeRmCYcVuY3T59x+oyzcdDnojnPxErPu
        JpfyyiJN/eLKuIpLuvKH32umPV38RjZ82rPqL4baGn8tX/0o4bVuOBWx5FLM9/XCDZOKuF5+
        uyMr2+vj9Foo3O5E72EdjQVCSbN/t/v/O3vy8sq9p9X0rC+rZB5WYinOSDTUYi4qTgQAoiZR
        yvMCAAA=
X-CMS-MailID: 20220113122334epcas5p2d5958c77b0635e848f81ed2c5c98cdd5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122334epcas5p2d5958c77b0635e848f81ed2c5c98cdd5
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122334epcas5p2d5958c77b0635e848f81ed2c5c98cdd5@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMU_FSYS0 block has IPs like UFS, EQOS, PCIe etc, lets add
the related clock information for the same.

Cc: linux-fsd@tesla.com
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 302 ++++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 6da20966ba99..8a7a668eb4be 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -713,6 +713,305 @@ static const struct samsung_cmu_info peric_cmu_info __initconst = {
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
@@ -750,6 +1049,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
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
2.17.1

