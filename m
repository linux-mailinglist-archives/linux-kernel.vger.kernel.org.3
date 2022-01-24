Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78737498235
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiAXO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:29:24 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:47732 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiAXO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:18 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220124142916epoutp044a8671168a998d831e3d63c9b1c6e459~NOzlNkZc82106421064epoutp04X
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220124142916epoutp044a8671168a998d831e3d63c9b1c6e459~NOzlNkZc82106421064epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034556;
        bh=X4P4/RUc4HQY4WOkHr5CasdTWfaWf8RCN9U8LI6lYeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tni+zbMN3/sy5vIVo24Qcv33GA1g9BbKvmwr5zlGCxWpAnyYILT8om71qpyzjZQ7j
         hOmO0B9VPi2KJgU2n9CzUClS5rGMnkD6hnnKMxvE1a8neblGCk+JztcCUWUCHGcrxs
         s9fJcG1dPJqhxU8BdvNbe2Qiq4u1njGPgSK9m2JE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220124142915epcas5p3326e54af4ce36f2afb6e3856f16ff69c~NOzkfpgzE0627306273epcas5p3u;
        Mon, 24 Jan 2022 14:29:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JjC6H6k48z4x9Pv; Mon, 24 Jan
        2022 14:29:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.24.05590.7B7BEE16; Mon, 24 Jan 2022 23:29:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220124142911epcas5p2e68f16158121a34e42e1763354ba8a4f~NOzgmfJl_0974109741epcas5p2S;
        Mon, 24 Jan 2022 14:29:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220124142911epsmtrp19f897327c17e6ca70259446a7a866171~NOzglhs0n2858928589epsmtrp1c;
        Mon, 24 Jan 2022 14:29:11 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-64-61eeb7b727ca
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.AB.08738.7B7BEE16; Mon, 24 Jan 2022 23:29:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142906epsmtip1f9e6376549b0ccccc455349fe4b52217~NOzcdlYgv1678816788epsmtip1y;
        Mon, 24 Jan 2022 14:29:06 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH v5 04/16] clk: samsung: fsd: Add initial clock support
Date:   Mon, 24 Jan 2022 19:46:32 +0530
Message-Id: <20220124141644.71052-5-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmhu727e8SDTbuNLY48P4gi8WDedvY
        LP5OOsZu8X5ZD6PF/CPnWC2OnFrCZLHx7Q8miyl/ljNZbHp8jdXiY889VouHr8ItLu+aw2Yx
        4/w+JotT1z+zWSza+oXdonXvEXaLw2/aWS3+XdvIYvH4+h82B2GPNfPWMHr8/jWJ0WNWQy+b
        x6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+Nc1l9/i8SS6AKyrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoMyWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbcpW/ZC472MFbsWvKesYHx
        VFUXIyeHhICJRO+DXUxdjFwcQgK7GSUOLPzKCpIQEvjEKPF6hTdE4jOjxOwL31hgOv4dns0G
        kdjFKDHj7CJWCKeFSeJz72lmkCo2AW2Ju9O3MIHYIgJuEjcaO8B2MAtcZJZobT7DDpIQBkp8
        nTqBDcRmEVCVmNTzGCzOK2AjcW55GyPEOnmJ1RsOgA3lFLCVmLfwG9ggCYEjHBLfFnxnhyhy
        kVj0fg2ULSzx6vgWKFtK4mV/G5DNAWRnS/TsMoYI10gsnXcM6h17iQNX5rCAlDALaEqs36UP
        EmYW4JPo/f2ECaKTV6KjTQiiWlWi+d1VqE5piYnd3awQtofEtI6X0ECZwChxf8c99gmMsrMQ
        pi5gZFzFKJlaUJybnlpsWmCcl1oOj6nk/NxNjOAUq+W9g/HRgw96hxiZOBgPMUpwMCuJ8Fal
        vEsU4k1JrKxKLcqPLyrNSS0+xGgKDLKJzFKiyfnAJJ9XEm9oYmlgYmZmZmJpbGaoJM57Kn1D
        opBAemJJanZqakFqEUwfEwenVAPTltKHmXyl/08stT0+VZXvt7TD6poVn+V+Zum9bTx+pMvs
        7aQbjEdWb/7TFHK1/PXrg6qSwnIbthe0xK4qDY9Xe7pj70rlTZcXvLgdsiBH/Y69Zr9Z+VZJ
        3juS9T2T138QMyo5c/nRd4ONTCs0WplZtzN2r8l60Pv2e0Sw3+8nHm0hF7jCg4IW742eWl37
        xzfK+X/PPEYlLduUg5XrD33warVf8fKj9HmRVVFbYpSv9Zhm98+es3Ze6v7zyt+tpM7cfcD0
        wleRJ05lnfNVh5BzX1jMc84vOQ3MWwbPNFsu3Dm0fx7Hs6PvjqTW7y7w075peV/ZRnT32m+Z
        28o/8Rydm14srLRxV3f3M/EjelIKSizFGYmGWsxFxYkAXOkEOToEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnO727e8SDa484bE48P4gi8WDedvY
        LP5OOsZu8X5ZD6PF/CPnWC2OnFrCZLHx7Q8miyl/ljNZbHp8jdXiY889VouHr8ItLu+aw2Yx
        4/w+JotT1z+zWSza+oXdonXvEXaLw2/aWS3+XdvIYvH4+h82B2GPNfPWMHr8/jWJ0WNWQy+b
        x6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+Nc1l9/i8SS6AK4rLJiU1J7MstUjfLoErY+7S
        t+wFR3sYK3Ytec/YwHiqqouRk0NCwETi3+HZbCC2kMAORolFN3Mh4tIS1zdOYIewhSVW/nsO
        ZHMB1TQxSew9tYQFJMEmoC1xd/oWJhBbRMBDou3fPWaQImaBx8wSDxY/ZgRJCAu4SXydOgFs
        A4uAqsSknsdgU3kFbCTOLW9jhNggL7F6wwFmEJtTwFZi3sJvQEM5gLYB1fxWmcDIt4CRYRWj
        ZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnB0aGntYNyz6oPeIUYmDsZDjBIczEoivFUp
        7xKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYGJX2PRi
        edrxTWmBzbOtH5U+TfpSnCKwdXGbl0NTwooq7Q365sqap3cdMlr7hkdAqOamoXHGq6Iu/cd5
        t0XOa4lfOXkj/Y1yz1TT4zafl14/e4hVceniBte6DQ8YNk6/6+RRkPlBdGLeX2EuVcNT0284
        evitvBvIk9Fx6tqdM49F7CYr6SpmWTK5TYqT6PB6sGC7uO0dx3LXJ+IuF+Z3z28In5yY+TZE
        LcFzIttuLrZ1MtozmL9o25zZE2UwRcRIuzpmYqGljPjfiIAH+bHfs7d/ivd7NvPmzAU1G1at
        e/vs3pLZN29znowT4DnJ2MNUpWL3S3TKn2c89hlrbb5JGAVuyCo2+sp1n2varB9p25RYijMS
        DbWYi4oTAa8Y02X9AgAA
X-CMS-MailID: 20220124142911epcas5p2e68f16158121a34e42e1763354ba8a4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142911epcas5p2e68f16158121a34e42e1763354ba8a4f
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142911epcas5p2e68f16158121a34e42e1763354ba8a4f@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial clock support for FSD (Full Self-Driving) SoC
which is required to bring-up platforms based on this SoC.

Also, fix the build error reported by the kernel test robot [1].

[1] https://lkml.org/lkml/2022/1/21/836

Cc: linux-fsd@tesla.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/Kconfig   |   8 +
 drivers/clk/samsung/Makefile  |   1 +
 drivers/clk/samsung/clk-fsd.c | 310 ++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-pll.c |   1 +
 drivers/clk/samsung/clk-pll.h |   1 +
 5 files changed, 321 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-fsd.c

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 0e18d6ff2916..5f64c58f120f 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -11,6 +11,7 @@ config COMMON_CLK_SAMSUNG
 	select EXYNOS_5410_COMMON_CLK if ARM && SOC_EXYNOS5410
 	select EXYNOS_5420_COMMON_CLK if ARM && SOC_EXYNOS5420
 	select EXYNOS_ARM64_COMMON_CLK if ARM64 && ARCH_EXYNOS
+	select TESLA_FSD_COMMON_CLK if ARM64 && ARCH_TESLA_FSD
 
 config S3C64XX_COMMON_CLK
 	bool "Samsung S3C64xx clock controller support" if COMPILE_TEST
@@ -124,3 +125,10 @@ config S3C2443_COMMON_CLK
 	help
 	  Support for the clock controller present on the Samsung
 	  S3C2416/S3C2443 SoCs. Choose Y here only if you build for this SoC.
+
+config TESLA_FSD_COMMON_CLK
+	bool "Tesla FSD clock controller support" if COMPILE_TEST
+	depends on COMMON_CLK_SAMSUNG
+	help
+	  Support for the clock controller present on the Tesla FSD SoC.
+	  Choose Y here only if you build for this SoC.
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 0df74916a895..17e5d1cb9da2 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
 obj-$(CONFIG_S3C2443_COMMON_CLK)+= clk-s3c2443.o
 obj-$(CONFIG_S3C64XX_COMMON_CLK)	+= clk-s3c64xx.o
 obj-$(CONFIG_S5PV210_COMMON_CLK)	+= clk-s5pv210.o clk-s5pv210-audss.o
+obj-$(CONFIG_TESLA_FSD_COMMON_CLK)	+= clk-fsd.o
diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
new file mode 100644
index 000000000000..ae35c4303b55
--- /dev/null
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
+ *             https://www.samsung.com
+ * Copyright (c) 2017-2022 Tesla, Inc.
+ *             https://www.tesla.com
+ *
+ * Common Clock Framework support for FSD SoC.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include <dt-bindings/clock/fsd-clk.h>
+
+#include "clk.h"
+
+/* Register Offset definitions for CMU_CMU (0x11c10000) */
+#define PLL_LOCKTIME_PLL_SHARED0			0x0
+#define PLL_LOCKTIME_PLL_SHARED1			0x4
+#define PLL_LOCKTIME_PLL_SHARED2			0x8
+#define PLL_LOCKTIME_PLL_SHARED3			0xc
+#define PLL_CON0_PLL_SHARED0				0x100
+#define PLL_CON0_PLL_SHARED1				0x120
+#define PLL_CON0_PLL_SHARED2				0x140
+#define PLL_CON0_PLL_SHARED3				0x160
+#define MUX_CMU_CIS0_CLKMUX				0x1000
+#define MUX_CMU_CIS1_CLKMUX				0x1004
+#define MUX_CMU_CIS2_CLKMUX				0x1008
+#define MUX_CMU_CPUCL_SWITCHMUX				0x100c
+#define MUX_CMU_FSYS1_ACLK_MUX				0x1014
+#define MUX_PLL_SHARED0_MUX				0x1020
+#define MUX_PLL_SHARED1_MUX				0x1024
+#define DIV_CMU_CIS0_CLK				0x1800
+#define DIV_CMU_CIS1_CLK				0x1804
+#define DIV_CMU_CIS2_CLK				0x1808
+#define DIV_CMU_CMU_ACLK				0x180c
+#define DIV_CMU_CPUCL_SWITCH				0x1810
+#define DIV_CMU_FSYS0_SHARED0DIV4			0x181c
+#define DIV_CMU_FSYS0_SHARED1DIV3			0x1820
+#define DIV_CMU_FSYS0_SHARED1DIV4			0x1824
+#define DIV_CMU_FSYS1_SHARED0DIV4			0x1828
+#define DIV_CMU_FSYS1_SHARED0DIV8			0x182c
+#define DIV_CMU_IMEM_ACLK				0x1834
+#define DIV_CMU_IMEM_DMACLK				0x1838
+#define DIV_CMU_IMEM_TCUCLK				0x183c
+#define DIV_CMU_PERIC_SHARED0DIV20			0x1844
+#define DIV_CMU_PERIC_SHARED0DIV3_TBUCLK		0x1848
+#define DIV_CMU_PERIC_SHARED1DIV36			0x184c
+#define DIV_CMU_PERIC_SHARED1DIV4_DMACLK		0x1850
+#define DIV_PLL_SHARED0_DIV2				0x1858
+#define DIV_PLL_SHARED0_DIV3				0x185c
+#define DIV_PLL_SHARED0_DIV4				0x1860
+#define DIV_PLL_SHARED0_DIV6				0x1864
+#define DIV_PLL_SHARED1_DIV3				0x1868
+#define DIV_PLL_SHARED1_DIV36				0x186c
+#define DIV_PLL_SHARED1_DIV4				0x1870
+#define DIV_PLL_SHARED1_DIV9				0x1874
+#define GAT_CMU_CIS0_CLKGATE				0x2000
+#define GAT_CMU_CIS1_CLKGATE				0x2004
+#define GAT_CMU_CIS2_CLKGATE				0x2008
+#define GAT_CMU_CPUCL_SWITCH_GATE			0x200c
+#define GAT_CMU_FSYS0_SHARED0DIV4_GATE			0x2018
+#define GAT_CMU_FSYS0_SHARED1DIV4_CLK			0x201c
+#define GAT_CMU_FSYS0_SHARED1DIV4_GATE			0x2020
+#define GAT_CMU_FSYS1_SHARED0DIV4_GATE			0x2024
+#define GAT_CMU_FSYS1_SHARED1DIV4_GATE			0x2028
+#define GAT_CMU_IMEM_ACLK_GATE				0x2030
+#define GAT_CMU_IMEM_DMACLK_GATE			0x2034
+#define GAT_CMU_IMEM_TCUCLK_GATE			0x2038
+#define GAT_CMU_PERIC_SHARED0DIVE3_TBUCLK_GATE		0x2040
+#define GAT_CMU_PERIC_SHARED0DIVE4_GATE			0x2044
+#define GAT_CMU_PERIC_SHARED1DIV4_DMACLK_GATE		0x2048
+#define GAT_CMU_PERIC_SHARED1DIVE4_GATE			0x204c
+#define GAT_CMU_CMU_CMU_IPCLKPORT_PCLK			0x2054
+#define GAT_CMU_AXI2APB_CMU_IPCLKPORT_ACLK		0x2058
+#define GAT_CMU_NS_BRDG_CMU_IPCLKPORT_CLK__PSOC_CMU__CLK_CMU	0x205c
+#define GAT_CMU_SYSREG_CMU_IPCLKPORT_PCLK		0x2060
+
+static const unsigned long cmu_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_SHARED0,
+	PLL_LOCKTIME_PLL_SHARED1,
+	PLL_LOCKTIME_PLL_SHARED2,
+	PLL_LOCKTIME_PLL_SHARED3,
+	PLL_CON0_PLL_SHARED0,
+	PLL_CON0_PLL_SHARED1,
+	PLL_CON0_PLL_SHARED2,
+	PLL_CON0_PLL_SHARED3,
+	MUX_CMU_CIS0_CLKMUX,
+	MUX_CMU_CIS1_CLKMUX,
+	MUX_CMU_CIS2_CLKMUX,
+	MUX_CMU_CPUCL_SWITCHMUX,
+	MUX_CMU_FSYS1_ACLK_MUX,
+	MUX_PLL_SHARED0_MUX,
+	MUX_PLL_SHARED1_MUX,
+	DIV_CMU_CIS0_CLK,
+	DIV_CMU_CIS1_CLK,
+	DIV_CMU_CIS2_CLK,
+	DIV_CMU_CMU_ACLK,
+	DIV_CMU_CPUCL_SWITCH,
+	DIV_CMU_FSYS0_SHARED0DIV4,
+	DIV_CMU_FSYS0_SHARED1DIV3,
+	DIV_CMU_FSYS0_SHARED1DIV4,
+	DIV_CMU_FSYS1_SHARED0DIV4,
+	DIV_CMU_FSYS1_SHARED0DIV8,
+	DIV_CMU_IMEM_ACLK,
+	DIV_CMU_IMEM_DMACLK,
+	DIV_CMU_IMEM_TCUCLK,
+	DIV_CMU_PERIC_SHARED0DIV20,
+	DIV_CMU_PERIC_SHARED0DIV3_TBUCLK,
+	DIV_CMU_PERIC_SHARED1DIV36,
+	DIV_CMU_PERIC_SHARED1DIV4_DMACLK,
+	DIV_PLL_SHARED0_DIV2,
+	DIV_PLL_SHARED0_DIV3,
+	DIV_PLL_SHARED0_DIV4,
+	DIV_PLL_SHARED0_DIV6,
+	DIV_PLL_SHARED1_DIV3,
+	DIV_PLL_SHARED1_DIV36,
+	DIV_PLL_SHARED1_DIV4,
+	DIV_PLL_SHARED1_DIV9,
+	GAT_CMU_CIS0_CLKGATE,
+	GAT_CMU_CIS1_CLKGATE,
+	GAT_CMU_CIS2_CLKGATE,
+	GAT_CMU_CPUCL_SWITCH_GATE,
+	GAT_CMU_FSYS0_SHARED0DIV4_GATE,
+	GAT_CMU_FSYS0_SHARED1DIV4_CLK,
+	GAT_CMU_FSYS0_SHARED1DIV4_GATE,
+	GAT_CMU_FSYS1_SHARED0DIV4_GATE,
+	GAT_CMU_FSYS1_SHARED1DIV4_GATE,
+	GAT_CMU_IMEM_ACLK_GATE,
+	GAT_CMU_IMEM_DMACLK_GATE,
+	GAT_CMU_IMEM_TCUCLK_GATE,
+	GAT_CMU_PERIC_SHARED0DIVE3_TBUCLK_GATE,
+	GAT_CMU_PERIC_SHARED0DIVE4_GATE,
+	GAT_CMU_PERIC_SHARED1DIV4_DMACLK_GATE,
+	GAT_CMU_PERIC_SHARED1DIVE4_GATE,
+	GAT_CMU_CMU_CMU_IPCLKPORT_PCLK,
+	GAT_CMU_AXI2APB_CMU_IPCLKPORT_ACLK,
+	GAT_CMU_NS_BRDG_CMU_IPCLKPORT_CLK__PSOC_CMU__CLK_CMU,
+	GAT_CMU_SYSREG_CMU_IPCLKPORT_PCLK,
+};
+
+static const struct samsung_pll_rate_table pll_shared0_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 2000000000U, 250, 3, 0),
+};
+
+static const struct samsung_pll_rate_table pll_shared1_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 2400000000U, 200, 2, 0),
+};
+
+static const struct samsung_pll_rate_table pll_shared2_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 2400000000U, 200, 2, 0),
+};
+
+static const struct samsung_pll_rate_table pll_shared3_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 1800000000U, 150, 2, 0),
+};
+
+static const struct samsung_pll_clock cmu_pll_clks[] __initconst = {
+	PLL(pll_142xx, 0, "fout_pll_shared0", "fin_pll", PLL_LOCKTIME_PLL_SHARED0,
+	    PLL_CON0_PLL_SHARED0, pll_shared0_rate_table),
+	PLL(pll_142xx, 0, "fout_pll_shared1", "fin_pll", PLL_LOCKTIME_PLL_SHARED1,
+	    PLL_CON0_PLL_SHARED1, pll_shared1_rate_table),
+	PLL(pll_142xx, 0, "fout_pll_shared2", "fin_pll", PLL_LOCKTIME_PLL_SHARED2,
+	    PLL_CON0_PLL_SHARED2, pll_shared2_rate_table),
+	PLL(pll_142xx, 0, "fout_pll_shared3", "fin_pll", PLL_LOCKTIME_PLL_SHARED3,
+	    PLL_CON0_PLL_SHARED3, pll_shared3_rate_table),
+};
+
+/* List of parent clocks for Muxes in CMU_CMU */
+PNAME(mout_cmu_shared0_pll_p) = { "fin_pll", "fout_pll_shared0" };
+PNAME(mout_cmu_shared1_pll_p) = { "fin_pll", "fout_pll_shared1" };
+PNAME(mout_cmu_shared2_pll_p) = { "fin_pll", "fout_pll_shared2" };
+PNAME(mout_cmu_shared3_pll_p) = { "fin_pll", "fout_pll_shared3" };
+PNAME(mout_cmu_cis0_clkmux_p) = { "fin_pll", "dout_cmu_pll_shared0_div4" };
+PNAME(mout_cmu_cis1_clkmux_p) = { "fin_pll", "dout_cmu_pll_shared0_div4" };
+PNAME(mout_cmu_cis2_clkmux_p) = { "fin_pll", "dout_cmu_pll_shared0_div4" };
+PNAME(mout_cmu_cpucl_switchmux_p) = { "mout_cmu_pll_shared2", "mout_cmu_pll_shared0_mux" };
+PNAME(mout_cmu_fsys1_aclk_mux_p) = { "dout_cmu_pll_shared0_div4", "fin_pll" };
+PNAME(mout_cmu_pll_shared0_mux_p) = { "fin_pll", "mout_cmu_pll_shared0" };
+PNAME(mout_cmu_pll_shared1_mux_p) = { "fin_pll", "mout_cmu_pll_shared1" };
+
+static const struct samsung_mux_clock cmu_mux_clks[] __initconst = {
+	MUX(0, "mout_cmu_pll_shared0", mout_cmu_shared0_pll_p, PLL_CON0_PLL_SHARED0, 4, 1),
+	MUX(0, "mout_cmu_pll_shared1", mout_cmu_shared1_pll_p, PLL_CON0_PLL_SHARED1, 4, 1),
+	MUX(0, "mout_cmu_pll_shared2", mout_cmu_shared2_pll_p, PLL_CON0_PLL_SHARED2, 4, 1),
+	MUX(0, "mout_cmu_pll_shared3", mout_cmu_shared3_pll_p, PLL_CON0_PLL_SHARED3, 4, 1),
+	MUX(0, "mout_cmu_cis0_clkmux", mout_cmu_cis0_clkmux_p, MUX_CMU_CIS0_CLKMUX, 0, 1),
+	MUX(0, "mout_cmu_cis1_clkmux", mout_cmu_cis1_clkmux_p, MUX_CMU_CIS1_CLKMUX, 0, 1),
+	MUX(0, "mout_cmu_cis2_clkmux", mout_cmu_cis2_clkmux_p, MUX_CMU_CIS2_CLKMUX, 0, 1),
+	MUX(0, "mout_cmu_cpucl_switchmux", mout_cmu_cpucl_switchmux_p,
+	    MUX_CMU_CPUCL_SWITCHMUX, 0, 1),
+	MUX(0, "mout_cmu_fsys1_aclk_mux", mout_cmu_fsys1_aclk_mux_p, MUX_CMU_FSYS1_ACLK_MUX, 0, 1),
+	MUX(0, "mout_cmu_pll_shared0_mux", mout_cmu_pll_shared0_mux_p, MUX_PLL_SHARED0_MUX, 0, 1),
+	MUX(0, "mout_cmu_pll_shared1_mux", mout_cmu_pll_shared1_mux_p, MUX_PLL_SHARED1_MUX, 0, 1),
+};
+
+static const struct samsung_div_clock cmu_div_clks[] __initconst = {
+	DIV(0, "dout_cmu_cis0_clk", "cmu_cis0_clkgate", DIV_CMU_CIS0_CLK, 0, 4),
+	DIV(0, "dout_cmu_cis1_clk", "cmu_cis1_clkgate", DIV_CMU_CIS1_CLK, 0, 4),
+	DIV(0, "dout_cmu_cis2_clk", "cmu_cis2_clkgate", DIV_CMU_CIS2_CLK, 0, 4),
+	DIV(0, "dout_cmu_cmu_aclk", "dout_cmu_pll_shared1_div9", DIV_CMU_CMU_ACLK, 0, 4),
+	DIV(0, "dout_cmu_cpucl_switch", "cmu_cpucl_switch_gate", DIV_CMU_CPUCL_SWITCH, 0, 4),
+	DIV(DOUT_CMU_FSYS0_SHARED0DIV4, "dout_cmu_fsys0_shared0div4", "cmu_fsys0_shared0div4_gate",
+	    DIV_CMU_FSYS0_SHARED0DIV4, 0, 4),
+	DIV(0, "dout_cmu_fsys0_shared1div3", "cmu_fsys0_shared1div4_clk",
+	    DIV_CMU_FSYS0_SHARED1DIV3, 0, 4),
+	DIV(DOUT_CMU_FSYS0_SHARED1DIV4, "dout_cmu_fsys0_shared1div4", "cmu_fsys0_shared1div4_gate",
+	    DIV_CMU_FSYS0_SHARED1DIV4, 0, 4),
+	DIV(DOUT_CMU_FSYS1_SHARED0DIV4, "dout_cmu_fsys1_shared0div4", "cmu_fsys1_shared0div4_gate",
+	    DIV_CMU_FSYS1_SHARED0DIV4, 0, 4),
+	DIV(DOUT_CMU_FSYS1_SHARED0DIV8, "dout_cmu_fsys1_shared0div8", "cmu_fsys1_shared1div4_gate",
+	    DIV_CMU_FSYS1_SHARED0DIV8, 0, 4),
+	DIV(DOUT_CMU_IMEM_ACLK, "dout_cmu_imem_aclk", "cmu_imem_aclk_gate",
+	    DIV_CMU_IMEM_ACLK, 0, 4),
+	DIV(DOUT_CMU_IMEM_DMACLK, "dout_cmu_imem_dmaclk", "cmu_imem_dmaclk_gate",
+	    DIV_CMU_IMEM_DMACLK, 0, 4),
+	DIV(DOUT_CMU_IMEM_TCUCLK, "dout_cmu_imem_tcuclk", "cmu_imem_tcuclk_gate",
+	    DIV_CMU_IMEM_TCUCLK, 0, 4),
+	DIV(DOUT_CMU_PERIC_SHARED0DIV20, "dout_cmu_peric_shared0div20",
+	    "cmu_peric_shared0dive4_gate", DIV_CMU_PERIC_SHARED0DIV20, 0, 4),
+	DIV(DOUT_CMU_PERIC_SHARED0DIV3_TBUCLK, "dout_cmu_peric_shared0div3_tbuclk",
+	    "cmu_peric_shared0dive3_tbuclk_gate", DIV_CMU_PERIC_SHARED0DIV3_TBUCLK, 0, 4),
+	DIV(DOUT_CMU_PERIC_SHARED1DIV36, "dout_cmu_peric_shared1div36",
+	    "cmu_peric_shared1dive4_gate", DIV_CMU_PERIC_SHARED1DIV36, 0, 4),
+	DIV(DOUT_CMU_PERIC_SHARED1DIV4_DMACLK, "dout_cmu_peric_shared1div4_dmaclk",
+	    "cmu_peric_shared1div4_dmaclk_gate", DIV_CMU_PERIC_SHARED1DIV4_DMACLK, 0, 4),
+	DIV(0, "dout_cmu_pll_shared0_div2", "mout_cmu_pll_shared0_mux",
+	    DIV_PLL_SHARED0_DIV2, 0, 4),
+	DIV(0, "dout_cmu_pll_shared0_div3", "mout_cmu_pll_shared0_mux",
+	    DIV_PLL_SHARED0_DIV3, 0, 4),
+	DIV(DOUT_CMU_PLL_SHARED0_DIV4, "dout_cmu_pll_shared0_div4", "dout_cmu_pll_shared0_div2",
+	    DIV_PLL_SHARED0_DIV4, 0, 4),
+	DIV(DOUT_CMU_PLL_SHARED0_DIV6, "dout_cmu_pll_shared0_div6", "dout_cmu_pll_shared0_div3",
+	    DIV_PLL_SHARED0_DIV6, 0, 4),
+	DIV(0, "dout_cmu_pll_shared1_div3", "mout_cmu_pll_shared1_mux",
+	    DIV_PLL_SHARED1_DIV3, 0, 4),
+	DIV(0, "dout_cmu_pll_shared1_div36", "dout_cmu_pll_shared1_div9",
+	    DIV_PLL_SHARED1_DIV36, 0, 4),
+	DIV(0, "dout_cmu_pll_shared1_div4", "mout_cmu_pll_shared1_mux",
+	    DIV_PLL_SHARED1_DIV4, 0, 4),
+	DIV(0, "dout_cmu_pll_shared1_div9", "dout_cmu_pll_shared1_div3",
+	    DIV_PLL_SHARED1_DIV9, 0, 4),
+};
+
+static const struct samsung_gate_clock cmu_gate_clks[] __initconst = {
+	GATE(0, "cmu_cis0_clkgate", "mout_cmu_cis0_clkmux", GAT_CMU_CIS0_CLKGATE, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_cis1_clkgate", "mout_cmu_cis1_clkmux", GAT_CMU_CIS1_CLKGATE, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_cis2_clkgate", "mout_cmu_cis2_clkmux", GAT_CMU_CIS2_CLKGATE, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(CMU_CPUCL_SWITCH_GATE, "cmu_cpucl_switch_gate", "mout_cmu_cpucl_switchmux",
+	     GAT_CMU_CPUCL_SWITCH_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(GAT_CMU_FSYS0_SHARED0DIV4, "cmu_fsys0_shared0div4_gate", "dout_cmu_pll_shared0_div4",
+	     GAT_CMU_FSYS0_SHARED0DIV4_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_fsys0_shared1div4_clk", "dout_cmu_pll_shared1_div3",
+	     GAT_CMU_FSYS0_SHARED1DIV4_CLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_fsys0_shared1div4_gate", "dout_cmu_pll_shared1_div4",
+	     GAT_CMU_FSYS0_SHARED1DIV4_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_fsys1_shared0div4_gate", "mout_cmu_fsys1_aclk_mux",
+	     GAT_CMU_FSYS1_SHARED0DIV4_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_fsys1_shared1div4_gate", "dout_cmu_fsys1_shared0div4",
+	     GAT_CMU_FSYS1_SHARED1DIV4_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_imem_aclk_gate", "dout_cmu_pll_shared1_div9", GAT_CMU_IMEM_ACLK_GATE, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_imem_dmaclk_gate", "mout_cmu_pll_shared1_mux", GAT_CMU_IMEM_DMACLK_GATE, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_imem_tcuclk_gate", "dout_cmu_pll_shared0_div3", GAT_CMU_IMEM_TCUCLK_GATE, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_peric_shared0dive3_tbuclk_gate", "dout_cmu_pll_shared0_div3",
+	     GAT_CMU_PERIC_SHARED0DIVE3_TBUCLK_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_peric_shared0dive4_gate", "dout_cmu_pll_shared0_div4",
+	     GAT_CMU_PERIC_SHARED0DIVE4_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_peric_shared1div4_dmaclk_gate", "dout_cmu_pll_shared1_div4",
+	     GAT_CMU_PERIC_SHARED1DIV4_DMACLK_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_peric_shared1dive4_gate", "dout_cmu_pll_shared1_div36",
+	     GAT_CMU_PERIC_SHARED1DIVE4_GATE, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_uid_cmu_cmu_cmu_ipclkport_pclk", "dout_cmu_cmu_aclk",
+	     GAT_CMU_CMU_CMU_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_uid_axi2apb_cmu_ipclkport_aclk", "dout_cmu_cmu_aclk",
+	     GAT_CMU_AXI2APB_CMU_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_uid_ns_brdg_cmu_ipclkport_clk__psoc_cmu__clk_cmu", "dout_cmu_cmu_aclk",
+	     GAT_CMU_NS_BRDG_CMU_IPCLKPORT_CLK__PSOC_CMU__CLK_CMU, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(0, "cmu_uid_sysreg_cmu_ipclkport_pclk", "dout_cmu_cmu_aclk",
+	     GAT_CMU_SYSREG_CMU_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info cmu_cmu_info __initconst = {
+	.pll_clks		= cmu_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(cmu_pll_clks),
+	.mux_clks		= cmu_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(cmu_mux_clks),
+	.div_clks		= cmu_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(cmu_div_clks),
+	.gate_clks		= cmu_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(cmu_gate_clks),
+	.nr_clk_ids		= CMU_NR_CLK,
+	.clk_regs		= cmu_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(cmu_clk_regs),
+};
+
+static void __init fsd_clk_cmu_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &cmu_cmu_info);
+}
+
+CLK_OF_DECLARE(fsd_clk_cmu, "tesla,fsd-clock-cmu", fsd_clk_cmu_init);
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 70cdc87f714e..fe383471c5f0 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1469,6 +1469,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_1450x:
 	case pll_1451x:
 	case pll_1452x:
+	case pll_142xx:
 		pll->enable_offs = PLL35XX_ENABLE_SHIFT;
 		pll->lock_offs = PLL35XX_LOCK_STAT_SHIFT;
 		if (!pll->rate_table)
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index c83a20195f6d..a9892c2d1f57 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -39,6 +39,7 @@ enum samsung_pll_type {
 	pll_1460x,
 	pll_0822x,
 	pll_0831x,
+	pll_142xx,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
-- 
2.25.1

