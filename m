Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BBF492926
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbiARPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:01:12 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:45953 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345097AbiARPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:00:45 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220118150044epoutp02b7777fe0c0577a19de44ee5fe6afb356~LZXVv_NIo2347523475epoutp02H
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:00:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220118150044epoutp02b7777fe0c0577a19de44ee5fe6afb356~LZXVv_NIo2347523475epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518044;
        bh=a9+rEFKDpuc46fYnboJCmGPX0HyLLvXPANdOyXFJdSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnI7VG2+5PC3tpB6uDNywJwGSibZFlZhjjumrFHG2+Q1kzxiQf7Sgq3MMcggSB/Ic
         XOXYLP3ewejjydBRvPzYCx/moMVOlSPYinCR867VJVEgE9EeeVhUB4tjRXVBXo7yOD
         4YpQAbhetj4nhP2lv1R0M9KVDrRN7eoGA6IZMzS4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220118150042epcas5p431f010e787cd3a6e984a3e226e1ab149~LZXUTIre91990519905epcas5p4-;
        Tue, 18 Jan 2022 15:00:42 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JdX5L0Lwpz4x9Pt; Tue, 18 Jan
        2022 15:00:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.19.06423.516D6E16; Wed, 19 Jan 2022 00:00:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150037epcas5p1624361eb48fa14cdf9ed88de6f890db4~LZXPiGmPQ0561905619epcas5p1G;
        Tue, 18 Jan 2022 15:00:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220118150037epsmtrp272022c1bb0cc580ee6769aba42bb3fe0~LZXPhIb1D1935719357epsmtrp2U;
        Tue, 18 Jan 2022 15:00:37 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-1c-61e6d6151133
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.A1.29871.516D6E16; Wed, 19 Jan 2022 00:00:37 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150034epsmtip1fb9fbc35ae9c60a8e426c9aa0bf1ab8c~LZXMzvP1P0428804288epsmtip1h;
        Tue, 18 Jan 2022 15:00:34 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Shradha Todi <shradha.t@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH v2 06/16] clk: samsung: fsd: Add cmu_fsys0 clock information
Date:   Tue, 18 Jan 2022 20:18:41 +0530
Message-Id: <20220118144851.69537-7-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmuq7otWeJBpM+mVsceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBZHTi1hstj49geTxZQ/y5ksNj2+xmrxseceq8XDV+EWl3fNYbOY
        cX4fk8Wp65/ZLBZt/cJu0br3CLvF4TftrBa9h2stHl//w+Yg7LFm3hpGj9+/JjF6zGroZfPY
        tKqTzePOtT1sHpuX1HtcOdHE6tG3ZRWjx7+muewenzfJBXBFZdtkpCampBYppOYl56dk5qXb
        KnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAD2mpFCWmFMKFApILC5W0rezKcovLUlV
        yMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOuPPFreDOBMaK7Qc/MTYw7mlk
        7GLk5JAQMJG4e3g1mC0ksJtRYkabRxcjF5D9iVFiTvsWNgjnG6PE/63NQFUcYB2TeiQh4nsZ
        JdYsfw5V1MIk8WxRKzvIKDYBbYm707cwgdgiAm4SNxo7mECKmAWeMks8P9PEBpIQFvCRmPx2
        I9huFgFViQsHH4A18wrYSDzY18gEcZ+8xOoNB5hBbE4BW4mpDVPBtkkIHOGQWPzhIytEkYtE
        0/ITzBC2sMSr41vYIWwpic/v9rJBnJ0t0bPLGCJcI7F03jEWCNte4sCVOSwgJcwCmhLrd+mD
        hJkF+CR6fz9hgujklehoE4KoVpVofncVqlNaYmJ3NytEiYfE0l+mkGCYwCjR1XOTdQKj7CyE
        oQsYGVcxSqYWFOempxabFhjmpZbD4yk5P3cTIzi5annuYLz74IPeIUYmDsZDjBIczEoivFL1
        zxKFeFMSK6tSi/Lji0pzUosPMZoCQ2wis5Rocj4wveeVxBuaWBqYmJmZmVgamxkqifOeTt+Q
        KCSQnliSmp2aWpBaBNPHxMEp1cAUl3/0OqvvvvCqd7lL/a3sNq74LGW6fl9QU0PD0+hFl1QO
        2AY3L/u4+7Bf8ovkvyyxDP4hmaG5WnLH0gUX/93fezHknsXq7Y77E3+EVAT982FrjT2bfuHL
        dKX9Gs1fDS/mT3xtZHD3+vHtWayWRZFrDi/OalDI2Ry82Er9wZd23stlpRIrNb23z7/cp1b7
        tlLc6rTAtIq5S6uDo9mZZpoqyTOdNK2+dOGFq1G7RZViVFhj4svie+dXKHksOLt2w8kdj3PF
        1svsE5lwYHmW74byaSxBp37KLLMy9XsocEZjxqpNq+t3h5RpccYsDNCVXyJZ+8H5qYWk5+HL
        5f8iJj+UfPQrdan6g4NSum1JCbuVWIozEg21mIuKEwHV4GDwNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnK7otWeJBl96xSwOvD/IYvFg3jY2
        i7+TjrFbvF/Ww2gx/8g5Vosjp5YwWWx8+4PJYsqf5UwWmx5fY7X42HOP1eLhq3CLy7vmsFnM
        OL+PyeLU9c9sFou2fmG3aN17hN3i8Jt2Vovew7UWj6//YXMQ9lgzbw2jx+9fkxg9ZjX0snls
        WtXJ5nHn2h42j81L6j2unGhi9ejbsorR41/TXHaPz5vkAriiuGxSUnMyy1KL9O0SuDLufHEr
        uDOBsWL7wU+MDYx7Ghm7GDk4JARMJCb1SHYxcnEICexmlHg7YRVQnBMoLi1xfeMEdghbWGLl
        v+fsEEVNTBL33lxmBkmwCWhL3J2+hQnEFhHwkGj7d48ZpIhZ4DszUNElsISwgI/E5Lcbwaay
        CKhKXDj4AGwqr4CNxIN9jUwQG+QlVm84ADaUU8BWYmrDVDYQWwio5uLKacwTGPkWMDKsYpRM
        LSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjg4tzR2M21d90DvEyMTBeIhRgoNZSYRXqv5Z
        ohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MNcnvLM5W
        Beb7PotMfnX28YXo7t3xG712iS56/b3onn9OxZzK3zdvzDppVnPzPuv3JxJGX1vzC3tfTZC8
        Nv/ATf1JrGInN3tdOKh88NFMZ+bs5ZuZFT2ctvdYFSnPmlW0NSpzXd+JwqkSv3+K7lms/znb
        70il1bOY7xN/d2tq1t2+fu1ug3TxgX2L2jO0Z4iW/JbrbS9J1+5zVK31vC3yPUX7zfwF8v0a
        cTbsy31vpu/6uSplR5rxn/DQT+yVPa1/rSO3bKud8MXRg2n+sQc+T/vaGSe/fhbA/zH0+eIv
        7zytv7aETFjg3TybX4ozbXEd/xtR7+mzQ86tmah/N/h/vOs3/Syv/4/ZjNYG5pjsVGIpzkg0
        1GIuKk4EALFhLqj9AgAA
X-CMS-MailID: 20220118150037epcas5p1624361eb48fa14cdf9ed88de6f890db4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150037epcas5p1624361eb48fa14cdf9ed88de6f890db4
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150037epcas5p1624361eb48fa14cdf9ed88de6f890db4@epcas5p1.samsung.com>
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
index 02ea8d977f1a..9ae0a86ae762 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -671,6 +671,305 @@ static const struct samsung_cmu_info peric_cmu_info __initconst = {
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
@@ -693,6 +992,9 @@ static const struct of_device_id fsd_cmu_of_match[] = {
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

