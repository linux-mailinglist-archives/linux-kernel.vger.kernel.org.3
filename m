Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA5496429
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381863AbiAURlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:41:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16182 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349777AbiAURkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:40:55 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220121174053epoutp02fcc88370dd1ba03d488db646b374da90~MWfBpnG9_0803608036epoutp02L
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:40:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220121174053epoutp02fcc88370dd1ba03d488db646b374da90~MWfBpnG9_0803608036epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786853;
        bh=2RBVjNLL8YP4pDMAHVsoSEuC1ft47n3LC01cS8sPruo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1uW7U4e8EnNg9nqv68IU3KdA+k5fpvNy2NMFtPqFwJrcwVU7iY/k3ubRpu9X1NJu
         o3V7rp3bHsP80A8Ujz+2v2zwsGMoxwSJBuPzgCnSfmmjEGEorf+/GeGGgbO/bnFFrH
         aO0dPusboCb4fUPM377xIYMIjVeaMPXWT7TLQZe4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220121174052epcas5p21b3582e623ee9656f4240deda123d589~MWfAvcjfg2295422954epcas5p20;
        Fri, 21 Jan 2022 17:40:52 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JgRVl0cxVz4x9Pq; Fri, 21 Jan
        2022 17:40:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.20.06423.E10FAE16; Sat, 22 Jan 2022 02:40:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220121174046epcas5p4b32e4448d9d1cf589a19b878b6d174db~MWe7WVCgL0759707597epcas5p4-;
        Fri, 21 Jan 2022 17:40:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121174046epsmtrp11c595ac94a9307d60c7d0ade1e63571e~MWe7U7EZB2608726087epsmtrp1Q;
        Fri, 21 Jan 2022 17:40:46 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-c2-61eaf01e9db7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.86.29871.E10FAE16; Sat, 22 Jan 2022 02:40:46 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174043epsmtip293a025727a0f8e9aa5e9a857894b737b~MWe4d_Y6E1230312303epsmtip2e;
        Fri, 21 Jan 2022 17:40:43 +0000 (GMT)
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
Subject: [PATCH v3 06/16] clk: samsung: fsd: Add cmu_fsys0 clock information
Date:   Fri, 21 Jan 2022 22:58:30 +0530
Message-Id: <20220121172840.12121-7-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmpq7ch1eJBu2zrC0OvD/IYvFg3jY2
        i7+TjrFbvF/Ww2gx/8g5Vosjp5YwWWx8+4PJYsqf5UwWmx5fY7X42HOP1eLhq3CLy7vmsFnM
        OL+PyeLU9c9sFou2fmG3aN17hN3i8Jt2Vot/1zayWPQerrV4fP0Pm4OIx5p5axg9fv+axOgx
        q6GXzWPTqk42jzvX9rB5bF5S73HlRBOrR9+WVYwe/5rmsnt83iQXwBWVbZORmpiSWqSQmpec
        n5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD9J2SQlliTilQKCCxuFhJ386m
        KL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj/IQ+1oJFExkrTu5e
        yd7A+LeRsYuRk0NCwERi1t6fQDYXh5DAbkaJZb93skA4nxgltt7oZoJwvjFKPNv2AaiMA6zl
        fpsfRHwvo8SDK1fZIJwWJom2Z3NYQeayCWhL3J2+hQnEFhFwk7jR2AE2iVngO7PEgZM7wBLC
        Aj4S7T9ngTWwCKhK/Hu2mhnE5hWwkdj28xMTxIHyEqs3HACLcwrYSrw+O48ZZJCEwBkOiZZ1
        f1khilwk5n5dCPWRsMSr41vYIWwpiZf9bewQZ2dL9OwyhgjXSCydd4wFwraXOHBlDgtICbOA
        psT6XfogYWYBPone30+YIDp5JTrahCCqVSWa312F6pSWmNjdDXWAh8SSLU/AlgoJTGCUWH6u
        cgKj7CyEoQsYGVcxSqYWFOempxabFhjmpZbDYyo5P3cTIzjVannuYLz74IPeIUYmDsZDjBIc
        zEoivAX5rxKFeFMSK6tSi/Lji0pzUosPMZoCQ2wis5Rocj4w2eeVxBuaWBqYmJmZmVgamxkq
        ifOeTt+QKCSQnliSmp2aWpBaBNPHxMEp1cBUwiem9NMyiJPDepEsw8Lza642bLzb5sO1P/53
        52KnijfXtpzMMEr9XJBss87HS+K8CvPDlbNnlHFzLJgpsXtGt3/5+kSn38XR3yaZVylL+xhJ
        3vphM/nFhsLVecY3kuQWHF/bNDv44/vpMT3P7gZmtf3RED/9Iv/wBUehlOe8Yh8EGI5+fp7y
        o6s/Oz4n4qQ9gxqvQsfNGSv1BKWldpVtbtos5d7RYqE5qWqrmtbbtwxboqbJxNSIceplGS9b
        8UQownyb2nenFMG2q/kvYuZ5vHhx0+L0r+8Pj7/2bZNOdq1W29y8e/b9OS27ta8Y5wdErf8S
        WRi7o86k89qcKDGpiY8qtybOm90vxLhr0VYlluKMREMt5qLiRACvx7AUPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvK7ch1eJBvu/8loceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBZHTi1hstj49geTxZQ/y5ksNj2+xmrxseceq8XDV+EWl3fNYbOY
        cX4fk8Wp65/ZLBZt/cJu0br3CLvF4TftrBb/rm1kseg9XGvx+PofNgcRjzXz1jB6/P41idFj
        VkMvm8emVZ1sHneu7WHz2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCuKyyYlNSezLLVI3y6B
        K+P8hD7WgkUTGStO7l7J3sD4t5Gxi5GDQ0LAROJ+m18XIxeHkMBuRon2IzuA4pxAcWmJ6xsn
        sEPYwhIr/z1nhyhqYpJY/uweWBGbgLbE3elbmEBsEQEPibZ/95hBipgFulkkZuyASAgL+Ei0
        /5zFCmKzCKhK/Hu2mhnE5hWwkdj28xMTxAZ5idUbDoDFOQVsJV6fnQdmCwHVNM/ayjSBkW8B
        I8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgSNHS3MG4fdUHvUOMTByMhxglOJiV
        RHgL8l8lCvGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cAU
        13lvXZ5GMHsPz2GTS2oypfwd/0UVHVoaur1OT60V+iX2jnv37uomhTuiLyPS7xtv4Nr57nLt
        hkD7L3KKp09JKij6pxkrallGnXJoc/3J+0pRSTNL4eY+jnrFf8dMln7/0GMuv/7w4ptpD/es
        3vmm3vdZ2Ik6gfaXtQuTtS7qLNT0kZT/0Gm1u3PCl1d/J2u48EUoFR3ce73m5s7vOu51TDKz
        xWfq+CYJzEk4/OTLcdefj2OzOd/6u+r1yx0JZ7wzZ1ZS6Z7DeSJKi8oO5Tat47hobKLT3HFg
        2xydyINHX33KUr+k9j4gUIrR0PVqiWx3pI7XZD7xN9xK4lstn81lKtBZfIsn+vTyIxF33imx
        FGckGmoxFxUnAgCPspMDAwMAAA==
X-CMS-MailID: 20220121174046epcas5p4b32e4448d9d1cf589a19b878b6d174db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174046epcas5p4b32e4448d9d1cf589a19b878b6d174db
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174046epcas5p4b32e4448d9d1cf589a19b878b6d174db@epcas5p4.samsung.com>
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
index d190ceb7c1ab..8062afab75e3 100644
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

