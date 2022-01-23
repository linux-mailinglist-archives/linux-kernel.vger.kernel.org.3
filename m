Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E084974FF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiAWTTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:19:55 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:41263 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbiAWTTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:19:51 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220123191949epoutp03d67dc0c52bfa0c854a499dbc5c977f29~M-H_fjfKC2561025610epoutp03k
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:19:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220123191949epoutp03d67dc0c52bfa0c854a499dbc5c977f29~M-H_fjfKC2561025610epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965589;
        bh=Wox9HhWlqAWShRtdff4J3Oc6FxlUrzsyevoAhlB4FMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qN7yhjAZYB6Y5sUSjoWcIoETTY5EIdTdJHXiQ7KBXsO90N9kMDKnh3WE6zDT/KA9A
         oIr710vWfikqQ3vkr4sLr5GFfldLVwoPRhjZQPOFPFBJIZcO6tmBLsOsgpRmX+sxit
         XnZjYDi0N8G799gWkgDAS6mu/QFM2ql39A/tkcUE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220123191947epcas5p18b6980f59827b1d8ad6a7a0b2a9c809f~M-H86AclH0413404134epcas5p1w;
        Sun, 23 Jan 2022 19:19:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jhjby1sLVz4x9Pv; Sun, 23 Jan
        2022 19:19:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.ED.05590.E4AADE16; Mon, 24 Jan 2022 04:19:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191941epcas5p11eb602b49b63fc16551939a3278e9271~M-H3Y7sRx0430304303epcas5p12;
        Sun, 23 Jan 2022 19:19:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123191941epsmtrp2fbebd5bbe5f64503a1dbfdcd13c7078c~M-H3X78_Q2018820188epsmtrp2R;
        Sun, 23 Jan 2022 19:19:41 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-b8-61edaa4e812b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.E7.29871.D4AADE16; Mon, 24 Jan 2022 04:19:41 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191939epsmtip199be569208760c47e25bfc443c5f9542~M-H1Fam4z0799407994epsmtip1D;
        Sun, 23 Jan 2022 19:19:38 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v4 02/16] dt-bindings: clock: Add bindings definitions for
 FSD CMU blocks
Date:   Mon, 24 Jan 2022 00:37:15 +0530
Message-Id: <20220123190729.1852-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmlq7fqreJBm+ncVg8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMmb92sxRsMKw49fkIYwNjo2YXIyeHhICJxNoz
        p9m6GLk4hAR2M0q0fd3LBOF8YpTon3WDBcL5xigx+edTJpiWl6v7oFr2MkpMOjOJHcJpYZJ4
        N+s3G0gVm4C2xN3pW8A6RATcJG40doDNZRb4zySxsWcZWJGwQLTEjssfmUFsFgFViRWrPoM1
        8ApYS9y5+JcdYp28xOoNB8BqOAVsJHpffWAFGSQhsIdD4tDt1VA3uUgsnfYayhaWeHV8C1Sz
        lMTnd3uBlnEA2dkSPbuMIcI1EkvnHWOBsO0lDlyZwwJSwiygKbF+lz5ImFmAT6L39xMmiE5e
        iY42IYhqVYnmd1ehOqUlJnZ3s0LYHhIHmy5AA6WfUWLxv+OsExhlZyFMXcDIuIpRMrWgODc9
        tdi0wDgvtRweU8n5uZsYwelUy3sH46MHH/QOMTJxMB5ilOBgVhLhLch/lSjEm5JYWZValB9f
        VJqTWnyI0RQYZBOZpUST84EJPa8k3tDE0sDEzMzMxNLYzFBJnPdU+oZEIYH0xJLU7NTUgtQi
        mD4mDk6pBibRqzqnz7h2ajAJnZ7r+qusnbHw0fwmP5+Wue5h4dUXLG/Eyzas/fXvY9eJlffn
        zgl8emdKxqv9jlbcc+MWxnAnamu3VDsl2mbPcDMOWbXYqnShVOmiruQZUyf4cvY/nnBsWU3X
        LVXWZ34FNbviAsS1NewrBTYaz7WI3167psfnzaKU+bf2rfgqkCaU3Gkz0T9igYSp8I1cv6DC
        8qdua3eW3f5jdSPsmpSnmM9Unh//oj40Vkx7IL5s03+X0EW5k1kPGemzOm7huBVZMtcul0+W
        h/X5tIn2Z397bH7mYNoTmLCsV8vYPmmS8EHu95+mZnImfNjPvIOxNlY0cXpQzyWlC0sPzfFe
        9KDlyyWT30osxRmJhlrMRcWJAEGZc44wBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK7vqreJBmt3ilk8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8bMX7tZCjYYVpz6fISx
        gbFRs4uRk0NCwETi5eo+ti5GLg4hgd2MEmfvLGCFSEhLXN84gR3CFpZY+e85O0RRE5PE1SVz
        wYrYBLQl7k7fwgRiiwh4SLT9u8cMUsQsMJFZYuPesywgCWGBSIn3nYsZQWwWAVWJFas+gzXw
        ClhL3Ln4F2qDvMTqDQeYQWxOARuJ3lcfgBZwAG2zlphwVG4CI98CRoZVjJKpBcW56bnFhgWG
        eanlesWJucWleel6yfm5mxjBkaCluYNx+6oPeocYmTgYDzFKcDArifAW5L9KFOJNSaysSi3K
        jy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoGpYWbi+XyJvI41rsIfr048
        Jlr1v999ueaB87P/nffXvO5+ZG4gu+zjwKz2qS/2/i8zOPYo/F9Azan+T9caj14pn5VW8M1w
        qwu3xqYVK8TOi84oarw8aZv12emZH3k3Hl5rceb44QYLzl0MpxwWTW1eub/UcrFbcIDgze1c
        q2uXNhSKxvz/t3GO1fapc5gNze+vuzgtPX7rjYXuJS4bP8q9U5riY/L/bv8yJd1A07e7C39P
        EatLuzRnFvtDzRZx4yyW05NkeFr+n0m4X9LgwTE9hy9BVzXyOCf/zuOdM2a3PykO6t52t+Gd
        6Pad55cFaSWu/blz2aXt54SW8CVf3rep4/DkPw/6G1oPLurh710xIVCJpTgj0VCLuag4EQCa
        DbzB8wIAAA==
X-CMS-MailID: 20220123191941epcas5p11eb602b49b63fc16551939a3278e9271
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123191941epcas5p11eb602b49b63fc16551939a3278e9271
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123191941epcas5p11eb602b49b63fc16551939a3278e9271@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock controller driver of FSD platform is designed to have separate
instances for each particular CMU. So clock IDs in this bindings header
also start from 1 for each CMU block.

Cc: linux-fsd@tesla.com
Reported-by: kernel test robot <lkp@intel.com>
[robot: reported missing #endif]
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 include/dt-bindings/clock/fsd-clk.h | 150 ++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 include/dt-bindings/clock/fsd-clk.h

diff --git a/include/dt-bindings/clock/fsd-clk.h b/include/dt-bindings/clock/fsd-clk.h
new file mode 100644
index 000000000000..c8a2af1dd1ad
--- /dev/null
+++ b/include/dt-bindings/clock/fsd-clk.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017 - 2022: Samsung Electronics Co., Ltd.
+ *             https://www.samsung.com
+ * Copyright (c) 2017-2022 Tesla, Inc.
+ *             https://www.tesla.com
+ *
+ * The constants defined in this header are being used in dts
+ * and fsd platform driver.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_FSD_H
+#define _DT_BINDINGS_CLOCK_FSD_H
+
+/* CMU */
+#define DOUT_CMU_PLL_SHARED0_DIV4		1
+#define DOUT_CMU_PERIC_SHARED1DIV36		2
+#define DOUT_CMU_PERIC_SHARED0DIV3_TBUCLK	3
+#define DOUT_CMU_PERIC_SHARED0DIV20		4
+#define DOUT_CMU_PERIC_SHARED1DIV4_DMACLK	5
+#define DOUT_CMU_PLL_SHARED0_DIV6		6
+#define DOUT_CMU_FSYS0_SHARED1DIV4		7
+#define DOUT_CMU_FSYS0_SHARED0DIV4		8
+#define DOUT_CMU_FSYS1_SHARED0DIV8		9
+#define DOUT_CMU_FSYS1_SHARED0DIV4		10
+#define CMU_CPUCL_SWITCH_GATE			11
+#define DOUT_CMU_IMEM_TCUCLK			12
+#define DOUT_CMU_IMEM_ACLK			13
+#define DOUT_CMU_IMEM_DMACLK			14
+#define GAT_CMU_FSYS0_SHARED0DIV4		15
+#define CMU_NR_CLK				16
+
+/* PERIC */
+#define PERIC_SCLK_UART0			1
+#define PERIC_PCLK_UART0			2
+#define PERIC_SCLK_UART1			3
+#define PERIC_PCLK_UART1			4
+#define PERIC_DMA0_IPCLKPORT_ACLK		5
+#define PERIC_DMA1_IPCLKPORT_ACLK		6
+#define PERIC_PWM0_IPCLKPORT_I_PCLK_S0		7
+#define PERIC_PWM1_IPCLKPORT_I_PCLK_S0		8
+#define PERIC_PCLK_SPI0                         9
+#define PERIC_SCLK_SPI0                         10
+#define PERIC_PCLK_SPI1                         11
+#define PERIC_SCLK_SPI1                         12
+#define PERIC_PCLK_SPI2                         13
+#define PERIC_SCLK_SPI2                         14
+#define PERIC_PCLK_TDM0                         15
+#define PERIC_PCLK_HSI2C0			16
+#define PERIC_PCLK_HSI2C1			17
+#define PERIC_PCLK_HSI2C2			18
+#define PERIC_PCLK_HSI2C3			19
+#define PERIC_PCLK_HSI2C4			20
+#define PERIC_PCLK_HSI2C5			21
+#define PERIC_PCLK_HSI2C6			22
+#define PERIC_PCLK_HSI2C7			23
+#define PERIC_MCAN0_IPCLKPORT_CCLK		24
+#define PERIC_MCAN0_IPCLKPORT_PCLK		25
+#define PERIC_MCAN1_IPCLKPORT_CCLK		26
+#define PERIC_MCAN1_IPCLKPORT_PCLK		27
+#define PERIC_MCAN2_IPCLKPORT_CCLK		28
+#define PERIC_MCAN2_IPCLKPORT_PCLK		29
+#define PERIC_MCAN3_IPCLKPORT_CCLK		30
+#define PERIC_MCAN3_IPCLKPORT_PCLK		31
+#define PERIC_PCLK_ADCIF			32
+#define PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I  33
+#define PERIC_EQOS_TOP_IPCLKPORT_ACLK_I		34
+#define PERIC_EQOS_TOP_IPCLKPORT_HCLK_I		35
+#define PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I	36
+#define PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I	37
+#define PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK	38
+#define PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK	39
+#define PERIC_HCLK_TDM0				40
+#define PERIC_PCLK_TDM1				41
+#define PERIC_HCLK_TDM1				42
+#define PERIC_EQOS_PHYRXCLK_MUX			43
+#define PERIC_EQOS_PHYRXCLK			44
+#define PERIC_DOUT_RGMII_CLK			45
+#define PERIC_NR_CLK				46
+
+/* FSYS0 */
+#define UFS0_MPHY_REFCLK_IXTAL24		1
+#define UFS0_MPHY_REFCLK_IXTAL26		2
+#define UFS1_MPHY_REFCLK_IXTAL24		3
+#define UFS1_MPHY_REFCLK_IXTAL26		4
+#define UFS0_TOP0_HCLK_BUS			5
+#define UFS0_TOP0_ACLK				6
+#define UFS0_TOP0_CLK_UNIPRO			7
+#define UFS0_TOP0_FMP_CLK			8
+#define UFS1_TOP1_HCLK_BUS			9
+#define UFS1_TOP1_ACLK				10
+#define UFS1_TOP1_CLK_UNIPRO			11
+#define UFS1_TOP1_FMP_CLK			12
+#define PCIE_SUBCTRL_INST0_DBI_ACLK_SOC		13
+#define PCIE_SUBCTRL_INST0_AUX_CLK_SOC		14
+#define PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC	15
+#define PCIE_SUBCTRL_INST0_SLV_ACLK_SOC		16
+#define FSYS0_EQOS_TOP0_IPCLKPORT_CLK_PTP_REF_I 17
+#define FSYS0_EQOS_TOP0_IPCLKPORT_ACLK_I	18
+#define FSYS0_EQOS_TOP0_IPCLKPORT_HCLK_I	19
+#define FSYS0_EQOS_TOP0_IPCLKPORT_RGMII_CLK_I	20
+#define FSYS0_EQOS_TOP0_IPCLKPORT_CLK_RX_I	21
+#define FSYS0_DOUT_FSYS0_PERIBUS_GRP		22
+#define FSYS0_NR_CLK				23
+
+/* FSYS1 */
+#define PCIE_LINK0_IPCLKPORT_DBI_ACLK		1
+#define PCIE_LINK0_IPCLKPORT_AUX_ACLK		2
+#define PCIE_LINK0_IPCLKPORT_MSTR_ACLK		3
+#define PCIE_LINK0_IPCLKPORT_SLV_ACLK		4
+#define PCIE_LINK1_IPCLKPORT_DBI_ACLK		5
+#define PCIE_LINK1_IPCLKPORT_AUX_ACLK		6
+#define PCIE_LINK1_IPCLKPORT_MSTR_ACLK		7
+#define PCIE_LINK1_IPCLKPORT_SLV_ACLK		8
+#define FSYS1_NR_CLK				9
+
+/* IMEM */
+#define IMEM_DMA0_IPCLKPORT_ACLK		1
+#define IMEM_DMA1_IPCLKPORT_ACLK		2
+#define IMEM_WDT0_IPCLKPORT_PCLK		3
+#define IMEM_WDT1_IPCLKPORT_PCLK		4
+#define IMEM_WDT2_IPCLKPORT_PCLK		5
+#define IMEM_MCT_PCLK				6
+#define IMEM_TMU_CPU0_IPCLKPORT_I_CLK_TS	7
+#define IMEM_TMU_CPU2_IPCLKPORT_I_CLK_TS	8
+#define IMEM_TMU_TOP_IPCLKPORT_I_CLK_TS		9
+#define IMEM_TMU_GPU_IPCLKPORT_I_CLK_TS		10
+#define IMEM_TMU_GT_IPCLKPORT_I_CLK_TS		11
+#define IMEM_NR_CLK				12
+
+/* MFC */
+#define MFC_MFC_IPCLKPORT_ACLK			1
+#define MFC_NR_CLK				2
+
+/* CAM_CSI */
+#define CAM_CSI0_0_IPCLKPORT_I_ACLK		1
+#define CAM_CSI0_1_IPCLKPORT_I_ACLK		2
+#define CAM_CSI0_2_IPCLKPORT_I_ACLK		3
+#define CAM_CSI0_3_IPCLKPORT_I_ACLK		4
+#define CAM_CSI1_0_IPCLKPORT_I_ACLK		5
+#define CAM_CSI1_1_IPCLKPORT_I_ACLK		6
+#define CAM_CSI1_2_IPCLKPORT_I_ACLK		7
+#define CAM_CSI1_3_IPCLKPORT_I_ACLK		8
+#define CAM_CSI2_0_IPCLKPORT_I_ACLK		9
+#define CAM_CSI2_1_IPCLKPORT_I_ACLK		10
+#define CAM_CSI2_2_IPCLKPORT_I_ACLK		11
+#define CAM_CSI2_3_IPCLKPORT_I_ACLK		12
+#define CAM_CSI_NR_CLK				13
+
+#endif /*_DT_BINDINGS_CLOCK_FSD_H */
-- 
2.25.1

