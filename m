Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334F8496419
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381169AbiAURkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:40:43 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:58399 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbiAURki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:40:38 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220121174036epoutp03e53bdd33f676f8bce0e1ebd63bec4ec0~MWeyJd3Av0281502815epoutp03J
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220121174036epoutp03e53bdd33f676f8bce0e1ebd63bec4ec0~MWeyJd3Av0281502815epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786836;
        bh=Wox9HhWlqAWShRtdff4J3Oc6FxlUrzsyevoAhlB4FMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8AADCUkmv0ErtjamRVwLwH4k9S4Jv0r3gL64RmmG464YtE1OaazOpAev//X5lOtk
         x7/Z27ZHiwjFOEKp7ekcKZ2fKuI1lSXznE4r0bfXAtln4y9wcJmnsDGRu9/gSdSDrZ
         O8V6GReIc6/Z4sdkes8MRa3EGHLnXdiU9ZYMYFYw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220121174035epcas5p12901a7a7f787e89726a2cd00dd784bfc~MWexlHmK71336113361epcas5p1v;
        Fri, 21 Jan 2022 17:40:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JgRVP3pb1z4x9Pp; Fri, 21 Jan
        2022 17:40:29 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.A5.05590.D00FAE16; Sat, 22 Jan 2022 02:40:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174028epcas5p2797a0f7024ccd3e96be91c82cea66490~MWeqtEX762295422954epcas5p2d;
        Fri, 21 Jan 2022 17:40:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220121174028epsmtrp2c8b942b29cb3ddd0e86a8f580e659bb4~MWeqrJzDZ1824918249epsmtrp2i;
        Fri, 21 Jan 2022 17:40:28 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-ee-61eaf00d25b9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.B7.08738.C00FAE16; Sat, 22 Jan 2022 02:40:28 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174025epsmtip2fc2053e4fc7d3b96caae9858b6fa9e88~MWeoLpkHK1229812298epsmtip2Y;
        Fri, 21 Jan 2022 17:40:25 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v3 02/16] dt-bindings: clock: Add bindings definitions for
 FSD CMU blocks
Date:   Fri, 21 Jan 2022 22:58:26 +0530
Message-Id: <20220121172840.12121-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmui7vh1eJBhsapSwezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lkt/l3byGLx+PofNgdBjzXz1jB6/P41idFjVkMvm8emVZ1sHneu7WHz
        2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
        UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6B8lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
        ToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGzF+7WQo2GFac+nyEsYGxUbOLkZNDQsBEor3r
        InMXIxeHkMBuRonuxutMIAkhgU+MEv8u+ELYnxkldk5jhmlo/vyFFaJhF6PE3bm3WCCcFiaJ
        W+19YN1sAtoSd6dvAbNFBNwkbjR2MIEUMQv8Z5LY2LOMDSQhLBAtsfPhXxYQm0VAVWLnny6w
        OK+AjcTsq10sEOvkJVZvOAC2mlPAVuL12Xlgt0oI7OAA2jaTFaLIReLyylNQtrDEq+Nb2CFs
        KYnP7/YCDeUAsrMlenYZQ4RrJJbOOwY1317iwJU5LCAlzAKaEut36YOEmQX4JHp/P2GC6OSV
        6GgTgqhWlWh+dxWqU1piYnc31FIPiY6fEBOFBCYwSizoi5vAKDsLYegCRsZVjJKpBcW56anF
        pgXGeanl8GhKzs/dxAhOpFreOxgfPfigd4iRiYPxEKMEB7OSCG9B/qtEId6UxMqq1KL8+KLS
        nNTiQ4ymwBCbyCwlmpwPTOV5JfGGJpYGJmZmZiaWxmaGSuK8p9I3JAoJpCeWpGanphakFsH0
        MXFwSjUwLTuo+DvLjyOxRc69i7lOZ7bFg8/LRYpXr3WWWjfH5+JVxxu8DMFcC7Wenbowp8/V
        0W/Wj4dsbyOYWbr3bFLnDlpQHP1oWe6Jpc/1T2zfcChOLq76We3G2q2i82a/amn7qzMnvahK
        JPOa/sFbeeWy104KbHxbMPfA//yVjbdzmtS264azthzSYOJ33SByQENa+NOL0yt0b23OLoxt
        M5nZpiF7WDTgdp22Zs6dF3HHvj+RPR6yqfxWbW9M495Pe68/K97wY361au65vYc7f6b6NM9j
        ryk69bz1lEiufXNk4NmNp3ZraEQvFRCS9eG/+CrlhfkZz8weFn3+Jb95g4QzUxNW3jFgVA45
        2zm1pkVfiaU4I9FQi7moOBEAnUDd8S0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvC7Ph1eJBh9OiFk8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8bMX7tZCjYYVpz6fISx
        gbFRs4uRk0NCwESi+fMX1i5GLg4hgR2MElMW9bNDJKQlrm+cAGULS6z895wdoqiJSWL7u142
        kASbgLbE3elbmEBsEQEPibZ/95hBipgFJjJLbNx7lgUkISwQKfHhwDJmEJtFQFVi558usGZe
        ARuJ2Ve7WCA2yEus3nAArIZTwFbi9dl5YLYQUE3zrK1MExj5FjAyrGKUTC0ozk3PLTYsMMpL
        LdcrTswtLs1L10vOz93ECI4FLa0djHtWfdA7xMjEwXiIUYKDWUmEtyD/VaIQb0piZVVqUX58
        UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTJO+3bzgMX3eDueUmYwlZ2bv
        mhdxTj/vyqk1v2v33/E31zoWWXW2+970ORZLpgTpX7m16t0vGUmes9XbNvmvOPpavjnE8vqz
        pgamsrbaJ31ybN89FDcIKpfN4996VK2Qxbb+/TfZvUkbS0MNVpy4ccPtW2lia+Jv7u8ZwTEf
        bedN5L18exdngP7kH3wfY7kM2K4tdlAIUTqzUvseV5PJ4sQLizbqOO+e9Hry/f3fZHS+eUm0
        2/NoG0olhbGXFFtt3NPMWWg3UfzdayH9bdecVVZyl59/q8U3ecqjtzL9E3Mm1jAc/bJ77f55
        cZ9ssvpPb5qVmzSd+eQZgX+Fxt52qo9X1Tn877qn7tX4M/NgY54SS3FGoqEWc1FxIgC5z539
        9AIAAA==
X-CMS-MailID: 20220121174028epcas5p2797a0f7024ccd3e96be91c82cea66490
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174028epcas5p2797a0f7024ccd3e96be91c82cea66490
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174028epcas5p2797a0f7024ccd3e96be91c82cea66490@epcas5p2.samsung.com>
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

