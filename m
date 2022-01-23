Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9428D49750C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiAWTUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:13 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:45303 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiAWTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:01 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220123191959epoutp046cceda9b05d1d2d2317824ebd612e830~M-IISFhPT0640306403epoutp04W
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:19:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220123191959epoutp046cceda9b05d1d2d2317824ebd612e830~M-IISFhPT0640306403epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965599;
        bh=j9aTZhrih+PjTrp55yaGicTDrz1Y+HTbrGOna855YgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjHxQnk/lLTfoBP9D8blHbK1pD83fBc7ptJHXta2Iq0lwnN28HrsyXIv2q73Wm4P5
         cW0Gyg3FZiwUuNsnJzCmdumLy0F/3kVwTnuAqo4pVs+W9z+aslsVqc0B4wIpr24dZz
         ukYNHBvuT6fTdxu9JdYTWkmMubw+sKuC25eStJto=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220123191958epcas5p3c91e15a64c1db4354b0b7680367bfb3f~M-IHBoqhu1076210762epcas5p3j;
        Sun, 23 Jan 2022 19:19:58 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jhjc96K5mz4x9Pv; Sun, 23 Jan
        2022 19:19:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.37.06423.95AADE16; Mon, 24 Jan 2022 04:19:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220123191953epcas5p2d015b75800b2e431689457fc7b7505c1~M-ICfYoT31893418934epcas5p2n;
        Sun, 23 Jan 2022 19:19:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220123191953epsmtrp15987580ecb988c27056ce9b29e475572~M-ICeN1Fk3102531025epsmtrp1C;
        Sun, 23 Jan 2022 19:19:53 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-6c-61edaa596db2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.F7.29871.95AADE16; Mon, 24 Jan 2022 04:19:53 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191950epsmtip1157f7f3e7a4c8665e84cd2560c19c39e~M-H-X9z_q0562105621epsmtip1H;
        Sun, 23 Jan 2022 19:19:49 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Niyas Ahmed S T <niyas.ahmed@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH v4 05/16] clk: samsung: fsd: Add cmu_peric block clock
 information
Date:   Mon, 24 Jan 2022 00:37:18 +0530
Message-Id: <20220123190729.1852-6-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmum7kqreJBudX6lsceH+QxeLBvG1s
        Fn8nHWO3OLR5K7vF+2U9jBbzj5xjtThyagmTxca3P5gspvxZzmSx6fE1VouPPfdYLR6+Cre4
        vGsOm8WM8/uYLJ5MecRqcer6ZzaLRVu/sFvMurCD1aJ17xF2i8Nv2lkt/l3byGLx+PofNovb
        b9axOoh7rJm3htHj969JjB6zGnrZPDat6mTzuHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fn
        TXIBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        3yoplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxM
        gQoTsjO23/7HVHBmA2PF/h3eDYz9cxm7GDk5JARMJNo23gSzhQR2M0qsm67TxcgFZH9ilOh9
        +4wNwvnGKPF72T4WmI7+K30sEIm9jBLtR26xQzgtTBJXe2+zglSxCWhL3J2+hQnEFhFwk7jR
        2MEEUsQs8INF4saMh2wgCWGBEInT6xaBNbAIqEq8mLcP7BBeAWuJVzseMkGsk5dYveEAM4jN
        KWAj0fvqAyvIIAmBFxwSJ+5sAbqDA8hxkdizXw+iXlji1fEt7BC2lMTL/jZ2iJJsiZ5dxhDh
        Goml845BfWMvceDKHLApzAKaEut36YOEmQX4JHp/P2GC6OSV6GgTgqhWlWh+dxWqU1piYnc3
        K4TtIdF3+S80TPoZJaZO2Mg+gVF2FsLUBYyMqxglUwuKc9NTi00LDPNSy+ERlZyfu4kRnIi1
        PHcw3n3wQe8QIxMH4yFGCQ5mJRHegvxXiUK8KYmVValF+fFFpTmpxYcYTYEhNpFZSjQ5H5gL
        8kriDU0sDUzMzMxMLI3NDJXEeU+nb0gUEkhPLEnNTk0tSC2C6WPi4JRqYOL+btfxsiuL7fL1
        KQldDzgP909485Fn7SLd2pndx1kz0oPSc+z3ut2cL2Flvdzx0OL5IbJ7epwzHK0WN53cIv+q
        b9f9hq4dStsYfnyZ7LWkN+qH2Bsrh55vT+2vej580Swj6XDFxFKRsfGm/I4ffismHLhaGf31
        8dfgh5HnJ1TerXmV1W/TOffQFgud2TnGZbp+kitnhxfO4/vA9thVfWbo1LDJtzPrBc6d6v1d
        zp5WNXHjjB8lllkpOmvsLM5essi8w/hjtkL+vN1v9j/fln/D486SpTN7jtqeP8y51fXzh9jm
        vvJ5NeWrU/jTPij/MY84elm0fQr7Ul9FZ8OGz30zLKek+DyIlzHlfK3k1qPEUpyRaKjFXFSc
        CACPNRoQTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnG7kqreJBh0zBS0OvD/IYvFg3jY2
        i7+TjrFbHNq8ld3i/bIeRov5R86xWhw5tYTJYuPbH0wWU/4sZ7LY9Pgaq8XHnnusFg9fhVtc
        3jWHzWLG+X1MFk+mPGK1OHX9M5vFoq1f2C1mXdjBatG69wi7xeE37awW/65tZLF4fP0Pm8Xt
        N+tYHcQ91sxbw+jx+9ckRo9ZDb1sHptWdbJ53Lm2h81j85J6jysnmlg9+rasYvT41zSX3ePz
        JrkArigum5TUnMyy1CJ9uwSujO23/zEVnNnAWLF/h3cDY/9cxi5GTg4JAROJ/it9LF2MXBxC
        ArsZJbovnoBKSEtc3ziBHcIWllj57zk7RFETk8TZ6QdZQRJsAtoSd6dvYQKxRQQ8JNr+3WMG
        KWIW6GOV2N/+jRkkISwQJNE/cRYLiM0ioCrxYt4+sA28AtYSr3Y8ZILYIC+xesMBsHpOARuJ
        3lcfgBZwAG2zlphwVG4CI98CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBcaSl
        uYNx+6oPeocYmTgYDzFKcDArifAW5L9KFOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBA
        emJJanZqakFqEUyWiYNTqoEp0WSD5J4I/V0HDrzpudS9zPrV5emtLRPeFXyeJ9mZKsVuHPqY
        ++yJrsL0m1n7+R5+vZb5bU1ns26sedzCju7HSvarcjPluPN/KUx5cE5+Ra3DVWuRrAjjRZy1
        nTtNv555vpr/kNi1Ou7PuWvYVun8EpeNe7dxydX/W2aoscpe3BMwn+dyVGvR3LMtn0Xc6iO6
        Jr/qrGpfZHWKeYPXvU+/93A0xjpZzTy3wvdIZiNnjZa48qab2zW5YxZvnrBrmp8wv/LNcKtv
        Vd8XXM66d2J9VN7EeanTDI+yTrnzcPNf55/BR58fWHns7/HSSWlybw689v1y/MIWkVgL0d9f
        r/VNfnj9pM2+J17fNsvqXdA5nKrEUpyRaKjFXFScCADg8LqPEgMAAA==
X-CMS-MailID: 20220123191953epcas5p2d015b75800b2e431689457fc7b7505c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123191953epcas5p2d015b75800b2e431689457fc7b7505c1
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123191953epcas5p2d015b75800b2e431689457fc7b7505c1@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CMU_PERIC block clock information needed for various IPs
functions found in this block.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 405 ++++++++++++++++++++++++++++++++++
 1 file changed, 405 insertions(+)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index ae35c4303b55..a3d328318814 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -8,14 +8,19 @@
  * Common Clock Framework support for FSD SoC.
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/clock/fsd-clk.h>
 
 #include "clk.h"
+#include "clk-exynos-arm64.h"
 
 /* Register Offset definitions for CMU_CMU (0x11c10000) */
 #define PLL_LOCKTIME_PLL_SHARED0			0x0
@@ -308,3 +313,403 @@ static void __init fsd_clk_cmu_init(struct device_node *np)
 }
 
 CLK_OF_DECLARE(fsd_clk_cmu, "tesla,fsd-clock-cmu", fsd_clk_cmu_init);
+
+/* Register Offset definitions for CMU_PERIC (0x14010000) */
+#define PLL_CON0_PERIC_DMACLK_MUX		0x100
+#define PLL_CON0_PERIC_EQOS_BUSCLK_MUX		0x120
+#define PLL_CON0_PERIC_PCLK_MUX			0x140
+#define PLL_CON0_PERIC_TBUCLK_MUX		0x160
+#define PLL_CON0_SPI_CLK			0x180
+#define PLL_CON0_SPI_PCLK			0x1a0
+#define PLL_CON0_UART_CLK			0x1c0
+#define PLL_CON0_UART_PCLK			0x1e0
+#define MUX_PERIC_EQOS_PHYRXCLK			0x1000
+#define DIV_EQOS_BUSCLK				0x1800
+#define DIV_PERIC_MCAN_CLK			0x1804
+#define DIV_RGMII_CLK				0x1808
+#define DIV_RII_CLK				0x180c
+#define DIV_RMII_CLK				0x1810
+#define DIV_SPI_CLK				0x1814
+#define DIV_UART_CLK				0x1818
+#define GAT_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I	0x2000
+#define GAT_GPIO_PERIC_IPCLKPORT_OSCCLK		0x2004
+#define GAT_PERIC_ADC0_IPCLKPORT_I_OSCCLK	0x2008
+#define GAT_PERIC_CMU_PERIC_IPCLKPORT_PCLK	0x200c
+#define GAT_PERIC_PWM0_IPCLKPORT_I_OSCCLK	0x2010
+#define GAT_PERIC_PWM1_IPCLKPORT_I_OSCCLK	0x2014
+#define GAT_ASYNC_APB_DMA0_IPCLKPORT_PCLKM	0x2018
+#define GAT_ASYNC_APB_DMA0_IPCLKPORT_PCLKS	0x201c
+#define GAT_ASYNC_APB_DMA1_IPCLKPORT_PCLKM	0x2020
+#define GAT_ASYNC_APB_DMA1_IPCLKPORT_PCLKS	0x2024
+#define GAT_AXI2APB_PERIC0_IPCLKPORT_ACLK	0x2028
+#define GAT_AXI2APB_PERIC1_IPCLKPORT_ACLK	0x202c
+#define GAT_AXI2APB_PERIC2_IPCLKPORT_ACLK	0x2030
+#define GAT_BUS_D_PERIC_IPCLKPORT_DMACLK	0x2034
+#define GAT_BUS_D_PERIC_IPCLKPORT_EQOSCLK	0x2038
+#define GAT_BUS_D_PERIC_IPCLKPORT_MAINCLK	0x203c
+#define GAT_BUS_P_PERIC_IPCLKPORT_EQOSCLK	0x2040
+#define GAT_BUS_P_PERIC_IPCLKPORT_MAINCLK	0x2044
+#define GAT_BUS_P_PERIC_IPCLKPORT_SMMUCLK	0x2048
+#define GAT_EQOS_TOP_IPCLKPORT_ACLK_I		0x204c
+#define GAT_EQOS_TOP_IPCLKPORT_CLK_RX_I		0x2050
+#define GAT_EQOS_TOP_IPCLKPORT_HCLK_I		0x2054
+#define GAT_EQOS_TOP_IPCLKPORT_RGMII_CLK_I	0x2058
+#define GAT_EQOS_TOP_IPCLKPORT_RII_CLK_I	0x205c
+#define GAT_EQOS_TOP_IPCLKPORT_RMII_CLK_I	0x2060
+#define GAT_GPIO_PERIC_IPCLKPORT_PCLK		0x2064
+#define GAT_NS_BRDG_PERIC_IPCLKPORT_CLK__PSOC_PERIC__CLK_PERIC_D	0x2068
+#define GAT_NS_BRDG_PERIC_IPCLKPORT_CLK__PSOC_PERIC__CLK_PERIC_P	0x206c
+#define GAT_PERIC_ADC0_IPCLKPORT_PCLK_S0	0x2070
+#define GAT_PERIC_DMA0_IPCLKPORT_ACLK		0x2074
+#define GAT_PERIC_DMA1_IPCLKPORT_ACLK		0x2078
+#define GAT_PERIC_I2C0_IPCLKPORT_I_PCLK		0x207c
+#define GAT_PERIC_I2C1_IPCLKPORT_I_PCLK		0x2080
+#define GAT_PERIC_I2C2_IPCLKPORT_I_PCLK		0x2084
+#define GAT_PERIC_I2C3_IPCLKPORT_I_PCLK		0x2088
+#define GAT_PERIC_I2C4_IPCLKPORT_I_PCLK		0x208c
+#define GAT_PERIC_I2C5_IPCLKPORT_I_PCLK		0x2090
+#define GAT_PERIC_I2C6_IPCLKPORT_I_PCLK		0x2094
+#define GAT_PERIC_I2C7_IPCLKPORT_I_PCLK		0x2098
+#define GAT_PERIC_MCAN0_IPCLKPORT_CCLK		0x209c
+#define GAT_PERIC_MCAN0_IPCLKPORT_PCLK		0x20a0
+#define GAT_PERIC_MCAN1_IPCLKPORT_CCLK		0x20a4
+#define GAT_PERIC_MCAN1_IPCLKPORT_PCLK		0x20a8
+#define GAT_PERIC_MCAN2_IPCLKPORT_CCLK		0x20ac
+#define GAT_PERIC_MCAN2_IPCLKPORT_PCLK		0x20b0
+#define GAT_PERIC_MCAN3_IPCLKPORT_CCLK		0x20b4
+#define GAT_PERIC_MCAN3_IPCLKPORT_PCLK		0x20b8
+#define GAT_PERIC_PWM0_IPCLKPORT_I_PCLK_S0	0x20bc
+#define GAT_PERIC_PWM1_IPCLKPORT_I_PCLK_S0	0x20c0
+#define GAT_PERIC_SMMU_IPCLKPORT_CCLK		0x20c4
+#define GAT_PERIC_SMMU_IPCLKPORT_PERIC_BCLK	0x20c8
+#define GAT_PERIC_SPI0_IPCLKPORT_I_PCLK		0x20cc
+#define GAT_PERIC_SPI0_IPCLKPORT_I_SCLK_SPI	0x20d0
+#define GAT_PERIC_SPI1_IPCLKPORT_I_PCLK		0x20d4
+#define GAT_PERIC_SPI1_IPCLKPORT_I_SCLK_SPI	0x20d8
+#define GAT_PERIC_SPI2_IPCLKPORT_I_PCLK		0x20dc
+#define GAT_PERIC_SPI2_IPCLKPORT_I_SCLK_SPI	0x20e0
+#define GAT_PERIC_TDM0_IPCLKPORT_HCLK_M		0x20e4
+#define GAT_PERIC_TDM0_IPCLKPORT_PCLK		0x20e8
+#define GAT_PERIC_TDM1_IPCLKPORT_HCLK_M		0x20ec
+#define GAT_PERIC_TDM1_IPCLKPORT_PCLK		0x20f0
+#define GAT_PERIC_UART0_IPCLKPORT_I_SCLK_UART	0x20f4
+#define GAT_PERIC_UART0_IPCLKPORT_PCLK		0x20f8
+#define GAT_PERIC_UART1_IPCLKPORT_I_SCLK_UART	0x20fc
+#define GAT_PERIC_UART1_IPCLKPORT_PCLK		0x2100
+#define GAT_SYSREG_PERI_IPCLKPORT_PCLK		0x2104
+
+static const unsigned long peric_clk_regs[] __initconst = {
+	PLL_CON0_PERIC_DMACLK_MUX,
+	PLL_CON0_PERIC_EQOS_BUSCLK_MUX,
+	PLL_CON0_PERIC_PCLK_MUX,
+	PLL_CON0_PERIC_TBUCLK_MUX,
+	PLL_CON0_SPI_CLK,
+	PLL_CON0_SPI_PCLK,
+	PLL_CON0_UART_CLK,
+	PLL_CON0_UART_PCLK,
+	MUX_PERIC_EQOS_PHYRXCLK,
+	DIV_EQOS_BUSCLK,
+	DIV_PERIC_MCAN_CLK,
+	DIV_RGMII_CLK,
+	DIV_RII_CLK,
+	DIV_RMII_CLK,
+	DIV_SPI_CLK,
+	DIV_UART_CLK,
+	GAT_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I,
+	GAT_GPIO_PERIC_IPCLKPORT_OSCCLK,
+	GAT_PERIC_ADC0_IPCLKPORT_I_OSCCLK,
+	GAT_PERIC_CMU_PERIC_IPCLKPORT_PCLK,
+	GAT_PERIC_PWM0_IPCLKPORT_I_OSCCLK,
+	GAT_PERIC_PWM1_IPCLKPORT_I_OSCCLK,
+	GAT_ASYNC_APB_DMA0_IPCLKPORT_PCLKM,
+	GAT_ASYNC_APB_DMA0_IPCLKPORT_PCLKS,
+	GAT_ASYNC_APB_DMA1_IPCLKPORT_PCLKM,
+	GAT_ASYNC_APB_DMA1_IPCLKPORT_PCLKS,
+	GAT_AXI2APB_PERIC0_IPCLKPORT_ACLK,
+	GAT_AXI2APB_PERIC1_IPCLKPORT_ACLK,
+	GAT_AXI2APB_PERIC2_IPCLKPORT_ACLK,
+	GAT_BUS_D_PERIC_IPCLKPORT_DMACLK,
+	GAT_BUS_D_PERIC_IPCLKPORT_EQOSCLK,
+	GAT_BUS_D_PERIC_IPCLKPORT_MAINCLK,
+	GAT_BUS_P_PERIC_IPCLKPORT_EQOSCLK,
+	GAT_BUS_P_PERIC_IPCLKPORT_MAINCLK,
+	GAT_BUS_P_PERIC_IPCLKPORT_SMMUCLK,
+	GAT_EQOS_TOP_IPCLKPORT_ACLK_I,
+	GAT_EQOS_TOP_IPCLKPORT_CLK_RX_I,
+	GAT_EQOS_TOP_IPCLKPORT_HCLK_I,
+	GAT_EQOS_TOP_IPCLKPORT_RGMII_CLK_I,
+	GAT_EQOS_TOP_IPCLKPORT_RII_CLK_I,
+	GAT_EQOS_TOP_IPCLKPORT_RMII_CLK_I,
+	GAT_GPIO_PERIC_IPCLKPORT_PCLK,
+	GAT_NS_BRDG_PERIC_IPCLKPORT_CLK__PSOC_PERIC__CLK_PERIC_D,
+	GAT_NS_BRDG_PERIC_IPCLKPORT_CLK__PSOC_PERIC__CLK_PERIC_P,
+	GAT_PERIC_ADC0_IPCLKPORT_PCLK_S0,
+	GAT_PERIC_DMA0_IPCLKPORT_ACLK,
+	GAT_PERIC_DMA1_IPCLKPORT_ACLK,
+	GAT_PERIC_I2C0_IPCLKPORT_I_PCLK,
+	GAT_PERIC_I2C1_IPCLKPORT_I_PCLK,
+	GAT_PERIC_I2C2_IPCLKPORT_I_PCLK,
+	GAT_PERIC_I2C3_IPCLKPORT_I_PCLK,
+	GAT_PERIC_I2C4_IPCLKPORT_I_PCLK,
+	GAT_PERIC_I2C5_IPCLKPORT_I_PCLK,
+	GAT_PERIC_I2C6_IPCLKPORT_I_PCLK,
+	GAT_PERIC_I2C7_IPCLKPORT_I_PCLK,
+	GAT_PERIC_MCAN0_IPCLKPORT_CCLK,
+	GAT_PERIC_MCAN0_IPCLKPORT_PCLK,
+	GAT_PERIC_MCAN1_IPCLKPORT_CCLK,
+	GAT_PERIC_MCAN1_IPCLKPORT_PCLK,
+	GAT_PERIC_MCAN2_IPCLKPORT_CCLK,
+	GAT_PERIC_MCAN2_IPCLKPORT_PCLK,
+	GAT_PERIC_MCAN3_IPCLKPORT_CCLK,
+	GAT_PERIC_MCAN3_IPCLKPORT_PCLK,
+	GAT_PERIC_PWM0_IPCLKPORT_I_PCLK_S0,
+	GAT_PERIC_PWM1_IPCLKPORT_I_PCLK_S0,
+	GAT_PERIC_SMMU_IPCLKPORT_CCLK,
+	GAT_PERIC_SMMU_IPCLKPORT_PERIC_BCLK,
+	GAT_PERIC_SPI0_IPCLKPORT_I_PCLK,
+	GAT_PERIC_SPI0_IPCLKPORT_I_SCLK_SPI,
+	GAT_PERIC_SPI1_IPCLKPORT_I_PCLK,
+	GAT_PERIC_SPI1_IPCLKPORT_I_SCLK_SPI,
+	GAT_PERIC_SPI2_IPCLKPORT_I_PCLK,
+	GAT_PERIC_SPI2_IPCLKPORT_I_SCLK_SPI,
+	GAT_PERIC_TDM0_IPCLKPORT_HCLK_M,
+	GAT_PERIC_TDM0_IPCLKPORT_PCLK,
+	GAT_PERIC_TDM1_IPCLKPORT_HCLK_M,
+	GAT_PERIC_TDM1_IPCLKPORT_PCLK,
+	GAT_PERIC_UART0_IPCLKPORT_I_SCLK_UART,
+	GAT_PERIC_UART0_IPCLKPORT_PCLK,
+	GAT_PERIC_UART1_IPCLKPORT_I_SCLK_UART,
+	GAT_PERIC_UART1_IPCLKPORT_PCLK,
+	GAT_SYSREG_PERI_IPCLKPORT_PCLK,
+};
+
+static const struct samsung_fixed_rate_clock peric_fixed_clks[] __initconst = {
+	FRATE(PERIC_EQOS_PHYRXCLK, "eqos_phyrxclk", NULL, 0, 125000000),
+};
+
+/* List of parent clocks for Muxes in CMU_PERIC */
+PNAME(mout_peric_dmaclk_p) = { "fin_pll", "cmu_peric_shared1div4_dmaclk_gate" };
+PNAME(mout_peric_eqos_busclk_p) = { "fin_pll", "dout_cmu_pll_shared0_div4" };
+PNAME(mout_peric_pclk_p) = { "fin_pll", "dout_cmu_peric_shared1div36" };
+PNAME(mout_peric_tbuclk_p) = { "fin_pll", "dout_cmu_peric_shared0div3_tbuclk" };
+PNAME(mout_peric_spi_clk_p) = { "fin_pll", "dout_cmu_peric_shared0div20" };
+PNAME(mout_peric_spi_pclk_p) = { "fin_pll", "dout_cmu_peric_shared1div36" };
+PNAME(mout_peric_uart_clk_p) = { "fin_pll", "dout_cmu_peric_shared1div4_dmaclk" };
+PNAME(mout_peric_uart_pclk_p) = { "fin_pll", "dout_cmu_peric_shared1div36" };
+PNAME(mout_peric_eqos_phyrxclk_p) = { "dout_peric_rgmii_clk", "eqos_phyrxclk" };
+
+static const struct samsung_mux_clock peric_mux_clks[] __initconst = {
+	MUX(0, "mout_peric_dmaclk", mout_peric_dmaclk_p, PLL_CON0_PERIC_DMACLK_MUX, 4, 1),
+	MUX(0, "mout_peric_eqos_busclk", mout_peric_eqos_busclk_p,
+	    PLL_CON0_PERIC_EQOS_BUSCLK_MUX, 4, 1),
+	MUX(0, "mout_peric_pclk", mout_peric_pclk_p, PLL_CON0_PERIC_PCLK_MUX, 4, 1),
+	MUX(0, "mout_peric_tbuclk", mout_peric_tbuclk_p, PLL_CON0_PERIC_TBUCLK_MUX, 4, 1),
+	MUX(0, "mout_peric_spi_clk", mout_peric_spi_clk_p, PLL_CON0_SPI_CLK, 4, 1),
+	MUX(0, "mout_peric_spi_pclk", mout_peric_spi_pclk_p, PLL_CON0_SPI_PCLK, 4, 1),
+	MUX(0, "mout_peric_uart_clk", mout_peric_uart_clk_p, PLL_CON0_UART_CLK, 4, 1),
+	MUX(0, "mout_peric_uart_pclk", mout_peric_uart_pclk_p, PLL_CON0_UART_PCLK, 4, 1),
+	MUX(PERIC_EQOS_PHYRXCLK_MUX, "mout_peric_eqos_phyrxclk", mout_peric_eqos_phyrxclk_p,
+		MUX_PERIC_EQOS_PHYRXCLK, 0, 1),
+};
+
+static const struct samsung_div_clock peric_div_clks[] __initconst = {
+	DIV(0, "dout_peric_eqos_busclk", "mout_peric_eqos_busclk", DIV_EQOS_BUSCLK, 0, 4),
+	DIV(0, "dout_peric_mcan_clk", "mout_peric_dmaclk", DIV_PERIC_MCAN_CLK, 0, 4),
+	DIV(PERIC_DOUT_RGMII_CLK, "dout_peric_rgmii_clk", "mout_peric_eqos_busclk",
+		DIV_RGMII_CLK, 0, 4),
+	DIV(0, "dout_peric_rii_clk", "dout_peric_rmii_clk", DIV_RII_CLK, 0, 4),
+	DIV(0, "dout_peric_rmii_clk", "dout_peric_rgmii_clk", DIV_RMII_CLK, 0, 4),
+	DIV(0, "dout_peric_spi_clk", "mout_peric_spi_clk", DIV_SPI_CLK, 0, 6),
+	DIV(0, "dout_peric_uart_clk", "mout_peric_uart_clk", DIV_UART_CLK, 0, 6),
+};
+
+static const struct samsung_gate_clock peric_gate_clks[] __initconst = {
+	GATE(PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I, "peric_eqos_top_ipclkport_clk_ptp_ref_i",
+	     "fin_pll", GAT_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_gpio_peric_ipclkport_oscclk", "fin_pll", GAT_GPIO_PERIC_IPCLKPORT_OSCCLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_ADCIF, "peric_adc0_ipclkport_i_oscclk", "fin_pll",
+	     GAT_PERIC_ADC0_IPCLKPORT_I_OSCCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_cmu_peric_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_PERIC_CMU_PERIC_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_pwm0_ipclkport_i_oscclk", "fin_pll", GAT_PERIC_PWM0_IPCLKPORT_I_OSCCLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_pwm1_ipclkport_i_oscclk", "fin_pll", GAT_PERIC_PWM1_IPCLKPORT_I_OSCCLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_async_apb_dma0_ipclkport_pclkm", "mout_peric_dmaclk",
+	     GAT_ASYNC_APB_DMA0_IPCLKPORT_PCLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_async_apb_dma0_ipclkport_pclks", "mout_peric_pclk",
+	     GAT_ASYNC_APB_DMA0_IPCLKPORT_PCLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_async_apb_dma1_ipclkport_pclkm", "mout_peric_dmaclk",
+	     GAT_ASYNC_APB_DMA1_IPCLKPORT_PCLKM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_async_apb_dma1_ipclkport_pclks", "mout_peric_pclk",
+	     GAT_ASYNC_APB_DMA1_IPCLKPORT_PCLKS, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_axi2apb_peric0_ipclkport_aclk", "mout_peric_pclk",
+	     GAT_AXI2APB_PERIC0_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_axi2apb_peric1_ipclkport_aclk", "mout_peric_pclk",
+	     GAT_AXI2APB_PERIC1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_axi2apb_peric2_ipclkport_aclk", "mout_peric_pclk",
+	     GAT_AXI2APB_PERIC2_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_bus_d_peric_ipclkport_dmaclk", "mout_peric_dmaclk",
+	     GAT_BUS_D_PERIC_IPCLKPORT_DMACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK, "peric_bus_d_peric_ipclkport_eqosclk",
+	     "dout_peric_eqos_busclk", GAT_BUS_D_PERIC_IPCLKPORT_EQOSCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_bus_d_peric_ipclkport_mainclk", "mout_peric_tbuclk",
+	     GAT_BUS_D_PERIC_IPCLKPORT_MAINCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK, "peric_bus_p_peric_ipclkport_eqosclk",
+	     "dout_peric_eqos_busclk", GAT_BUS_P_PERIC_IPCLKPORT_EQOSCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_bus_p_peric_ipclkport_mainclk", "mout_peric_pclk",
+	     GAT_BUS_P_PERIC_IPCLKPORT_MAINCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_bus_p_peric_ipclkport_smmuclk", "mout_peric_tbuclk",
+	     GAT_BUS_P_PERIC_IPCLKPORT_SMMUCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_EQOS_TOP_IPCLKPORT_ACLK_I, "peric_eqos_top_ipclkport_aclk_i",
+	     "dout_peric_eqos_busclk", GAT_EQOS_TOP_IPCLKPORT_ACLK_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I, "peric_eqos_top_ipclkport_clk_rx_i",
+	     "mout_peric_eqos_phyrxclk", GAT_EQOS_TOP_IPCLKPORT_CLK_RX_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_EQOS_TOP_IPCLKPORT_HCLK_I, "peric_eqos_top_ipclkport_hclk_i",
+	     "dout_peric_eqos_busclk", GAT_EQOS_TOP_IPCLKPORT_HCLK_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I, "peric_eqos_top_ipclkport_rgmii_clk_i",
+	     "dout_peric_rgmii_clk", GAT_EQOS_TOP_IPCLKPORT_RGMII_CLK_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_eqos_top_ipclkport_rii_clk_i", "dout_peric_rii_clk",
+	     GAT_EQOS_TOP_IPCLKPORT_RII_CLK_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_eqos_top_ipclkport_rmii_clk_i", "dout_peric_rmii_clk",
+	     GAT_EQOS_TOP_IPCLKPORT_RMII_CLK_I, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_gpio_peric_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_GPIO_PERIC_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_ns_brdg_peric_ipclkport_clk__psoc_peric__clk_peric_d", "mout_peric_tbuclk",
+	     GAT_NS_BRDG_PERIC_IPCLKPORT_CLK__PSOC_PERIC__CLK_PERIC_D, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_ns_brdg_peric_ipclkport_clk__psoc_peric__clk_peric_p", "mout_peric_pclk",
+	     GAT_NS_BRDG_PERIC_IPCLKPORT_CLK__PSOC_PERIC__CLK_PERIC_P, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_adc0_ipclkport_pclk_s0", "mout_peric_pclk",
+	     GAT_PERIC_ADC0_IPCLKPORT_PCLK_S0, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_DMA0_IPCLKPORT_ACLK, "peric_dma0_ipclkport_aclk", "mout_peric_dmaclk",
+	     GAT_PERIC_DMA0_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_DMA1_IPCLKPORT_ACLK, "peric_dma1_ipclkport_aclk", "mout_peric_dmaclk",
+	     GAT_PERIC_DMA1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_HSI2C0, "peric_i2c0_ipclkport_i_pclk", "mout_peric_pclk",
+	     GAT_PERIC_I2C0_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_HSI2C1, "peric_i2c1_ipclkport_i_pclk", "mout_peric_pclk",
+	     GAT_PERIC_I2C1_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_HSI2C2, "peric_i2c2_ipclkport_i_pclk", "mout_peric_pclk",
+	     GAT_PERIC_I2C2_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_HSI2C3, "peric_i2c3_ipclkport_i_pclk", "mout_peric_pclk",
+	     GAT_PERIC_I2C3_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_HSI2C4, "peric_i2c4_ipclkport_i_pclk", "mout_peric_pclk",
+	     GAT_PERIC_I2C4_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_HSI2C5, "peric_i2c5_ipclkport_i_pclk", "mout_peric_pclk",
+	     GAT_PERIC_I2C5_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_HSI2C6, "peric_i2c6_ipclkport_i_pclk", "mout_peric_pclk",
+	     GAT_PERIC_I2C6_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_HSI2C7, "peric_i2c7_ipclkport_i_pclk", "mout_peric_pclk",
+	     GAT_PERIC_I2C7_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_MCAN0_IPCLKPORT_CCLK, "peric_mcan0_ipclkport_cclk", "dout_peric_mcan_clk",
+	     GAT_PERIC_MCAN0_IPCLKPORT_CCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_MCAN0_IPCLKPORT_PCLK, "peric_mcan0_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_PERIC_MCAN0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_MCAN1_IPCLKPORT_CCLK, "peric_mcan1_ipclkport_cclk", "dout_peric_mcan_clk",
+	     GAT_PERIC_MCAN1_IPCLKPORT_CCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_MCAN1_IPCLKPORT_PCLK, "peric_mcan1_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_PERIC_MCAN1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_MCAN2_IPCLKPORT_CCLK, "peric_mcan2_ipclkport_cclk", "dout_peric_mcan_clk",
+	     GAT_PERIC_MCAN2_IPCLKPORT_CCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_MCAN2_IPCLKPORT_PCLK, "peric_mcan2_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_PERIC_MCAN2_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_MCAN3_IPCLKPORT_CCLK, "peric_mcan3_ipclkport_cclk", "dout_peric_mcan_clk",
+	     GAT_PERIC_MCAN3_IPCLKPORT_CCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_MCAN3_IPCLKPORT_PCLK, "peric_mcan3_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_PERIC_MCAN3_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PWM0_IPCLKPORT_I_PCLK_S0, "peric_pwm0_ipclkport_i_pclk_s0", "mout_peric_pclk",
+	     GAT_PERIC_PWM0_IPCLKPORT_I_PCLK_S0, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PWM1_IPCLKPORT_I_PCLK_S0, "peric_pwm1_ipclkport_i_pclk_s0", "mout_peric_pclk",
+	     GAT_PERIC_PWM1_IPCLKPORT_I_PCLK_S0, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_smmu_ipclkport_cclk", "mout_peric_tbuclk",
+	     GAT_PERIC_SMMU_IPCLKPORT_CCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_smmu_ipclkport_peric_bclk", "mout_peric_tbuclk",
+	     GAT_PERIC_SMMU_IPCLKPORT_PERIC_BCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_SPI0, "peric_spi0_ipclkport_i_pclk", "mout_peric_spi_pclk",
+	     GAT_PERIC_SPI0_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_SCLK_SPI0, "peric_spi0_ipclkport_i_sclk_spi", "dout_peric_spi_clk",
+	     GAT_PERIC_SPI0_IPCLKPORT_I_SCLK_SPI, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_SPI1, "peric_spi1_ipclkport_i_pclk", "mout_peric_spi_pclk",
+	     GAT_PERIC_SPI1_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_SCLK_SPI1, "peric_spi1_ipclkport_i_sclk_spi", "dout_peric_spi_clk",
+	     GAT_PERIC_SPI1_IPCLKPORT_I_SCLK_SPI, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_SPI2, "peric_spi2_ipclkport_i_pclk", "mout_peric_spi_pclk",
+	     GAT_PERIC_SPI2_IPCLKPORT_I_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_SCLK_SPI2, "peric_spi2_ipclkport_i_sclk_spi", "dout_peric_spi_clk",
+	     GAT_PERIC_SPI2_IPCLKPORT_I_SCLK_SPI, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_HCLK_TDM0, "peric_tdm0_ipclkport_hclk_m", "mout_peric_pclk",
+	     GAT_PERIC_TDM0_IPCLKPORT_HCLK_M, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_TDM0, "peric_tdm0_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_PERIC_TDM0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_HCLK_TDM1, "peric_tdm1_ipclkport_hclk_m", "mout_peric_pclk",
+	     GAT_PERIC_TDM1_IPCLKPORT_HCLK_M, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_TDM1, "peric_tdm1_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_PERIC_TDM1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_SCLK_UART0, "peric_uart0_ipclkport_i_sclk_uart", "dout_peric_uart_clk",
+	     GAT_PERIC_UART0_IPCLKPORT_I_SCLK_UART, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_UART0, "peric_uart0_ipclkport_pclk", "mout_peric_uart_pclk",
+	     GAT_PERIC_UART0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_SCLK_UART1, "peric_uart1_ipclkport_i_sclk_uart", "dout_peric_uart_clk",
+	     GAT_PERIC_UART1_IPCLKPORT_I_SCLK_UART, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(PERIC_PCLK_UART1, "peric_uart1_ipclkport_pclk", "mout_peric_uart_pclk",
+	     GAT_PERIC_UART1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "peric_sysreg_peri_ipclkport_pclk", "mout_peric_pclk",
+	     GAT_SYSREG_PERI_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info peric_cmu_info __initconst = {
+	.mux_clks		= peric_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(peric_mux_clks),
+	.div_clks		= peric_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(peric_div_clks),
+	.gate_clks		= peric_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(peric_gate_clks),
+	.fixed_clks		= peric_fixed_clks,
+	.nr_fixed_clks		= ARRAY_SIZE(peric_fixed_clks),
+	.nr_clk_ids		= PERIC_NR_CLK,
+	.clk_regs		= peric_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(peric_clk_regs),
+	.clk_name		= "dout_cmu_pll_shared0_div4",
+};
+
+/**
+ * fsd_cmu_probe - Probe function for FSD platform clocks
+ * @pdev: Pointer to platform device
+ *
+ * Configure clock hierarchy for clock domains of FSD platform
+ */
+static int __init fsd_cmu_probe(struct platform_device *pdev)
+{
+	const struct samsung_cmu_info *info;
+	struct device *dev = &pdev->dev;
+
+	info = of_device_get_match_data(dev);
+	exynos_arm64_register_cmu(dev, dev->of_node, info);
+
+	return 0;
+}
+
+/* CMUs which belong to Power Domains and need runtime PM to be implemented */
+static const struct of_device_id fsd_cmu_of_match[] = {
+	{
+		.compatible = "tesla,fsd-clock-peric",
+		.data = &peric_cmu_info,
+	}, {
+	},
+};
+
+static struct platform_driver fsd_cmu_driver __refdata = {
+	.driver	= {
+		.name = "fsd-cmu",
+		.of_match_table = fsd_cmu_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = fsd_cmu_probe,
+};
+
+static int __init fsd_cmu_init(void)
+{
+	return platform_driver_register(&fsd_cmu_driver);
+}
+core_initcall(fsd_cmu_init);
-- 
2.25.1

