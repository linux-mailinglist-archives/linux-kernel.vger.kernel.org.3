Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AC48D784
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiAMMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:23:36 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24772 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiAMMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:23:31 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220113122330epoutp035fc4e975286e49ae1ef5b979cdef6249~J0-ogcdG41485214852epoutp036
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220113122330epoutp035fc4e975286e49ae1ef5b979cdef6249~J0-ogcdG41485214852epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076610;
        bh=qvbRgESJYskYARO1BZe+mJhNZPYtzDRw8BddfABm9N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3CygsaQY5LzllUJ0grYKY3v/N4wYTJV5XPoXmQzGXGVqMuFZwa4f91+EdOCuxBJR
         ZyEsB9Bz0kYo2LR88IHs21tNpztwP2V9etz4u0WqZfangGzKq0sxQXkXUo90cKwc5F
         dzd2m6zCyhLhNrU/wjTpSs3iOQqw1GhQEtYnvh3I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220113122329epcas5p31b641a4ac30ace3cb668a098090fc15b~J0-nh7dgt1599415994epcas5p39;
        Thu, 13 Jan 2022 12:23:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JZNrF1t57z4x9Pw; Thu, 13 Jan
        2022 12:23:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.01.46822.DB910E16; Thu, 13 Jan 2022 21:23:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220113122324epcas5p105c53b448b5801813a02a88c6107a2f3~J0-jYSVlv1099210992epcas5p1q;
        Thu, 13 Jan 2022 12:23:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122324epsmtrp2fbd040fdafbf176cc217f06a0bc70097~J0-jWLsVV3027830278epsmtrp2F;
        Thu, 13 Jan 2022 12:23:24 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-2e-61e019bdb00b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.99.08738.CB910E16; Thu, 13 Jan 2022 21:23:24 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122321epsmtip24caad52b05a0f45534a4eacfa42f852b~J0-gJdh9M1245812458epsmtip2h;
        Thu, 13 Jan 2022 12:23:21 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH 03/23] clk: samsung: fsd: Add initial clock support
Date:   Thu, 13 Jan 2022 17:41:23 +0530
Message-Id: <20220113121143.22280-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhu5eyQeJBuf+ilgceH+QxeLBvG1s
        Fu+X9TBazD9yjtXiyKklTBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi8fU/bA6CHmvmrWH0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CMyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCdsWD6Z8aC/82MFedePmJqYDxY3MXIySEhYCLx4dN/ti5G
        Lg4hgd2MEke2LGGBcD4xSjS8vMQO4XxmlDj56TZrFyMHWMvCc4oQ8V2MEk+uTWaEcFqYJK40
        LmQBmcsmoC1xd/oWJhBbRMBN4kZjBxNIEbPAOmaJY51bmUESwgLOEmeff2YEsVkEVCXuXJnD
        CmLzCthINDRMYYE4UF5i9YYDzCCbOQVsJe6uygOZIyGwg0Ni8qvp7BA1LhLnl39khbCFJV4d
        3wIVl5L4/G4vG8TV2RI9u4whwjUSS+cdgxpvL3HgyhwWkBJmAU2J9bv0QcLMAnwSvb+fMEF0
        8kp0tAlBVKtKNL+7CtUpLTGxuxtqqYfEtR8roAE3gVGiceY95gmMsrMQpi5gZFzFKJlaUJyb
        nlpsWmCUl1oOj6jk/NxNjOAUquW1g/Hhgw96hxiZOBgPMUpwMCuJ8PYX3U8U4k1JrKxKLcqP
        LyrNSS0+xGgKDLGJzFKiyfnAJJ5XEm9oYmlgYmZmZmJpbGaoJM57On1DopBAemJJanZqakFq
        EUwfEwenVAOT31Ln60wMZVInzINKT66qC5lScHZ/8Mv1T24c3HBAeMcFnbCjU2TnZzd5rTxx
        4dcXS5/m1dKVEhN2RtRkrqjuvstw0+BN6uZenYhpNteO2tcwHOdZNfOFXSijvkX8BtHZ8ZPf
        /n0qsWHtqblFn2xj3e5msK7Nc2xjYf9zKN7w66Jwx8eKct8sG8LZZblEWZeVuWoGX5R7tH0G
        f/TC4OtNJd85tR5P75Pl6tReZpd/4alvMX/hpeUvfJ5V/bwvlil3WseRY+3FWjHFt1dS81Yd
        j++ov6etG6V/vbPqUIOVeU7JqzTVv7/mB7pNb/0vs2zKpwcn45ferj+kvbKaIznB/XvHUrfb
        W4/tcj2c7L5ViaU4I9FQi7moOBEAFTq13yoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvO4eyQeJBkf6BC0OvD/IYvFg3jY2
        i/fLehgt5h85x2px5NQSJouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmc
        uv6ZzWLR1i/sFq17j7BbHH7Tzmrx+PofNgdBjzXz1jB6zGroZfPYtKqTzePOtT1sHpuX1Htc
        OdHE6tG3ZRWjx7+muewenzfJBXBGcdmkpOZklqUW6dslcGUsmP6ZseB/M2PFuZePmBoYDxZ3
        MXJwSAiYSCw8p9jFyMUhJLCDUeLny29MXYycQHFpiesbJ7BD2MISK/89Z4coamKSuP3vEBtI
        gk1AW+Lu9C1gDSICHhJt/+4xgxQxC+xjltiy8Q8LSEJYwFni7PPPjCA2i4CqxJ0rc1hBbF4B
        G4mGhiksEBvkJVZvOMAMchGngK3E3VV5IGEhoJJzr9azTWDkW8DIsIpRMrWgODc9t9iwwCgv
        tVyvODG3uDQvXS85P3cTIzj8tbR2MO5Z9UHvECMTB+MhRgkOZiUR3v6i+4lCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MDlGLfxX4r03yP6d/8+d39w+
        bmObcvn6jmVrH/0Sl/gekrd6jVj2zqPBiy91rU+vWrTzy2fT5Ppa7Yhr2ubfmGVYv0Vd+3RQ
        XeOdZXrjbq3oK8aNBUK/znZ1+K2etszcRm+p8JmrS6XmBAk+i5pUWVlpv8RG22yt4r0FJxIe
        moa/rWv5MG0ee4mhw4e7Vz49+H15hceDHWkFjsqrRWdMaJjnw7s0ySbtuVOE8c8Epvs8F1q3
        3u2faeK70/PbCXclQ5bNu/5wvg5h3LEm1epQf1SuifaeSTzPIh8tYVUr8lSvsKjezaJgE3fM
        NyLmS8+7Jq1Vf+pTpEJXylwNrRU+uTKkQdb3b8e7zOObG6Yb5imxFGckGmoxFxUnAgCv8H8H
        7gIAAA==
X-CMS-MailID: 20220113122324epcas5p105c53b448b5801813a02a88c6107a2f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122324epcas5p105c53b448b5801813a02a88c6107a2f3
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122324epcas5p105c53b448b5801813a02a88c6107a2f3@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial clock support for FSD (Full Self-Driving) SoC
which is required to bring-up platforms based on this SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/Makefile  |   1 +
 drivers/clk/samsung/clk-fsd.c | 308 ++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-pll.c |   1 +
 drivers/clk/samsung/clk-pll.h |   1 +
 4 files changed, 311 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-fsd.c

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index c46cf11e4d0b..d66b2ede004c 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-exynos-audss.o
 obj-$(CONFIG_EXYNOS_CLKOUT)	+= clk-exynos-clkout.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
+obj-$(CONFIG_ARCH_TESLA_FSD)         += clk-fsd.o
 obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
 obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
 obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
new file mode 100644
index 000000000000..e47523106d9e
--- /dev/null
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common Clock Framework support for FSD SoC.
+ *
+ * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
+ *             https://www.samsung.com
+ * Copyright (c) 2017-2022 Tesla, Inc.
+ *             https://www.tesla.com
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+
+#include "clk.h"
+#include <dt-bindings/clock/fsd-clk.h>
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
+	PLL_35XX_RATE(24 * MHZ, 2000000000, 250, 3, 0),
+};
+
+static const struct samsung_pll_rate_table pll_shared1_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 2400000000, 200, 2, 0),
+};
+
+static const struct samsung_pll_rate_table pll_shared2_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 2400000000, 200, 2, 0),
+};
+
+static const struct samsung_pll_rate_table pll_shared3_rate_table[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 1800000000, 150, 2, 0),
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
index 83d1b03647db..e321036875f0 100644
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
index a739f2b7ae80..9ba5d7c867c5 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -38,6 +38,7 @@ enum samsung_pll_type {
 	pll_1460x,
 	pll_0822x,
 	pll_0831x,
+	pll_142xx,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
-- 
2.17.1

