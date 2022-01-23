Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E249750D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbiAWTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:17 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52561 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbiAWTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:08 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220123192006epoutp0102b18a5e7ed36fc6a67606f4bd752a75~M-IOUIYRe1778217782epoutp013
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220123192006epoutp0102b18a5e7ed36fc6a67606f4bd752a75~M-IOUIYRe1778217782epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965606;
        bh=tmwAcXo/cjvGgtFIgEzsBlKcTm0IKVnazYEIFnLG2iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCgs+qGlZvitMwMDspmNPO0OyLuOJURvjROUNmlvjhmPMBA4zpgrj2XGc/E9n6QmT
         EHLF5JQduTg6StDr3H6I9ZtOzD3oi2PDuXLcPJ0o1Bo1I+lCV1yWCGe+OCcCi5MG1f
         AI+Wk37tkbH1rDEUb8fybDC73MxcsxlUx4CWiStY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220123192004epcas5p23bd18abda8ae46fe3ba4aba130d543d9~M-INBlzrr2292122921epcas5p2w;
        Sun, 23 Jan 2022 19:20:04 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JhjcG4B7Lz4x9Pv; Sun, 23 Jan
        2022 19:19:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.73.46822.329ADE16; Mon, 24 Jan 2022 04:14:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220123191957epcas5p48578770a81acfbccd8550faed665ffa1~M-IGNp-iJ0895308953epcas5p46;
        Sun, 23 Jan 2022 19:19:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220123191957epsmtrp12999b3625844143242570ee531e466ce~M-IGMnL_L3102531025epsmtrp1D;
        Sun, 23 Jan 2022 19:19:57 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-53-61eda9231575
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.F7.29871.D5AADE16; Mon, 24 Jan 2022 04:19:57 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191954epsmtip14eb680de92ef359a647ca8812940c92a~M-IDdRemV0562405624epsmtip1O;
        Sun, 23 Jan 2022 19:19:54 +0000 (GMT)
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
Subject: [PATCH v4 06/16] clk: samsung: fsd: Add cmu_fsys0 clock information
Date:   Mon, 24 Jan 2022 00:37:19 +0530
Message-Id: <20220123190729.1852-7-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUxbVRTAc1/b10KCeWFMrjVj5ClZ2AZr+aiX0eLMSNcILiy6gCjgG31p
        SUtb2+LmFGSgrFIYMJYNGR/bss0UyYAOKmMDO0CGYBxGvgwINMDUhg5krsj40JaH+t/vnPs7
        9+Sce3ks/wacz8vSGGm9hlKTuC/b1hMaGvaSxUUJmk3hyL54n41m6mw42jjfx0WLN0sAqu/9
        gYN6B65jqMX1F4YurH+JIevsKAf9UTLFQQ5nMvqpowZHVQ+7MDQw9gRH19r+5KLPOnu5qGfh
        LAdtjrawUWlPLpodW8cPBcga6xqBbO3ZeSCrzi/FZdaGz3HZ5Og9XHb7+iey4f4CjuxcawOQ
        bRbUcmVPrEFJvqkqsZKm5LQ+mNZkauVZGoWETHgz43BGtEggDBPGoFfIYA2VTUvI+MSkMGmW
        2jMdGfwBpc7xpJIog4E8ECfWa3OMdLBSazBKSFonV+uidOEGKtuQo1GEa2jjQaFAEBHtEd9T
        KWtnLLjuWgU4VVg1BPLBxhlQDHg8SERB25SkGPjy/Im7AFYVtHOZYBnAjs4Zj+TjCdwAlv8W
        5GVvgcv8YFvqBLDw5jyHCT7FYKX7a8xr4cQ++Mul1i0OIKRw/IwJ80osYoUF7d+1bx3sIBLh
        oqmX7WU2EQKn560sL/sRsfBRVRmLabcbftVs32IfQgxLnUtb3SDxPQ+6L49wGCkeXi1q4zK8
        AzoftG4zH/5eVsRlBlXBko5IJv0xvFHXx2b4VWgfrmF7FRYRCps6DnjTLOI5WLo2hzGVftBU
        5M/YIbDw8ch25YuwwmzmMIoMPmx7i1lDGYDTjjWsHOyq/v/SKwA0gBdonSFbQRuidREa+uR/
        D5WpzbaCrU+79/V24JhZCu8GGA90A8hjkQF+Oq2T8veTUx+epvXaDH2OmjZ0g2jPxipY/J2Z
        Ws+v1xgzhFExgiiRSBQVEykSkoF+g4pmyp9QUEZaRdM6Wv9vHcbz4edjV885JuN4R54OTwa9
        VioWNzy2TNjyIvlpO5taQvgmn9Pp8rMbbq02LT455aOkkc3QYknxowlxo9SRfysib3C+K5Fe
        VY5IAtbvhN+3B0sTyheWn0+LTJ8eH3tDYcNu73HWp+6ZuzC+NKc9WJ94q+1yF6xMONmEH083
        v285Ntiyf/+3I1eGUEpXoPTZckeuOuhHzt/6TETmrvR/c6fGBmtJlevYF5YF/q8WqdNtV54I
        7JuVOyrz8uIuWl1vT0l3LxBHo6febXSzL949knrC9Q5feDTFbJ2sylS2zJhizSv7hl7u//ne
        qYHkbtHqKifWlawauzQhWK7Jrjj0dKC6+fAukm1QUsK9LL2B+geucPUcPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnG7sqreJBrsPCloceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBZHTi1hstj49geTxZQ/y5ksNj2+xmrxseceq8XDV+EWl3fNYbOY
        cX4fk8Wp65/ZLBZt/cJu0br3CLvF4TftrBb/rm1kseg9XGvx+PofNgcRjzXz1jB6/P41idFj
        VkMvm8emVZ1sHneu7WHz2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCuKyyYlNSezLLVI3y6B
        K2Pug5VsBYsmMlY0z7jA2MD4t5Gxi5GTQ0LAROJt93H2LkYuDiGB3YwSvcfbmCES0hLXN05g
        h7CFJVb+ew5mCwk0MUlM+CQNYrMJaEvcnb6FCcQWEfCQaPt3jxlkELNAN4vEjB0QCWEBH4n3
        HUdYQGwWAVWJ+083gS3gFbCWeDajH2qZvMTqDQfAbE4BG4neVx9Yuxg5gJZZS0w4KjeBkW8B
        I8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgONHS3MG4fdUHvUOMTByMhxglOJiV
        RHgL8l8lCvGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cAk
        7J6f6ul7dUr8pOsbH71TWNClunB9YZtxoY/moiu3d3k/qDsesNf/zxevqz/Etn9co5gZvvGt
        /XPv/RG3jTqeemxSOLjvrs6dyGbpZCFbY0mhuJMdZY7sLhtTss8utnC5plAiZ5dw0fajC8uq
        7XP4ha8sYKg4XfZhda6nwGT1tTvF2BvbdUVWRd+oqXbme+qTdjPL0HPDqhma75bHPzywTTas
        m8WAv9ow+331r7Vq2a8DbWcrhwqEfXvlqyZ92sDkw5Xqz299FQy+GTM5pn01SzzF+y9y+t/9
        V7Yr9HV8Wrp/194Xcn9K89R2bsqyUzDY2OvA9uPP4oyJqTX/TR1YFzuIPVWO/3/U22TTo2Il
        luKMREMt5qLiRADXkD/bAgMAAA==
X-CMS-MailID: 20220123191957epcas5p48578770a81acfbccd8550faed665ffa1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123191957epcas5p48578770a81acfbccd8550faed665ffa1
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123191957epcas5p48578770a81acfbccd8550faed665ffa1@epcas5p4.samsung.com>
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

