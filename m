Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF00496421
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381579AbiAURku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:40:50 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:22088 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381191AbiAURkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:40:45 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220121174043epoutp04eb925f0c56b045f0937ff4d38bc17285~MWe4ktUIE2811028110epoutp04q
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:40:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220121174043epoutp04eb925f0c56b045f0937ff4d38bc17285~MWe4ktUIE2811028110epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786843;
        bh=WoWpgsv3bxyL+Fw0wFy2jEG8MIH1pcDMzqZh9nJ3Rzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b81MW6dza0cia9kuQurm5/ukMnH0i3t3SxKdvFNODW9BdejT7fkQKZjsdyucDGnz6
         kI4VFMgcbt99eXYrKWhEgS0xnDlapV4RSuqNdBvl85sX/A6D8VosYx46FuFrQrf1Ni
         Rq/a2B7NkEeWRn/G8UcRLmY1MmKgxWwS8Oes+gPA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220121174042epcas5p4f699630153ca3fbc223eb16c5521725f~MWe31DmaL0297102971epcas5p4E;
        Fri, 21 Jan 2022 17:40:42 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JgRVZ2g4tz4x9Pr; Fri, 21 Jan
        2022 17:40:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.20.06423.610FAE16; Sat, 22 Jan 2022 02:40:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220121174037epcas5p125c19dec012f7363570019db98f587b9~MWezO1TzQ2780827808epcas5p1H;
        Fri, 21 Jan 2022 17:40:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121174037epsmtrp14d8e5e6be96ea79efbef458bb4704b04~MWezM91Uz2608726087epsmtrp1H;
        Fri, 21 Jan 2022 17:40:37 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-b5-61eaf016c3fc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.86.29871.510FAE16; Sat, 22 Jan 2022 02:40:37 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174034epsmtip2c682b01b17e69ff455ab4b29b82bfd72~MWewgbAD21230312303epsmtip2c;
        Fri, 21 Jan 2022 17:40:34 +0000 (GMT)
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
Subject: [PATCH v3 04/16] clk: samsung: fsd: Add initial clock support
Date:   Fri, 21 Jan 2022 22:58:28 +0530
Message-Id: <20220121172840.12121-5-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmhq7Yh1eJBhdX8FkceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBZHTi1hstj49geTxZQ/y5ksNj2+xmrxseceq8XDV+EWl3fNYbOY
        cX4fk8Wp65/ZLBZt/cJu0br3CLvF4TftrBb/rm1ksXh8/Q+bg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFZVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0mZJCWWJOKVAoILG4WEnfzqYov7Qk
        VSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2NO9z3WgkXdjBX7l79laWA8
        WNnFyMkhIWAisap9DnsXIxeHkMBuRon5R/ugnE+MEo29f1kgnG+MEgem32DrYuQAa5l8ngsi
        vpdRYtbTJYwgo4QEWpgkvnWpgdhsAtoSd6dvYQKxRQTcJG40djCBNDALXGSWaG0+ww6SEAZK
        7Hv6gxnEZhFQldi77R5YA6+AjcS1r9eYIe6Tl1i94QCYzSlgK/H67DxmkEESAic4JPZuvckE
        UeQisbIF4goJAWGJV8e3sEPYUhIv+9vYIa7OlujZZQwRrpFYOu8YC4RtL3HgyhwWkBJmAU2J
        9bv0QcLMAnwSvb+fMEF08kp0tAlBVKtKNL+7CtUpLTGxu5sVwvaQ2P/vDRskTCYwSlw4dpdp
        AqPsLISpCxgZVzFKphYU56anFpsWGOallsMjKjk/dxMjOMFqee5gvPvgg94hRiYOxkOMEhzM
        SiK8BfmvEoV4UxIrq1KL8uOLSnNSiw8xmgKDbCKzlGhyPjDF55XEG5pYGpiYmZmZWBqbGSqJ
        855O35AoJJCeWJKanZpakFoE08fEwSnVwGSju9I7p9hod0PxNEGR6m61p70ratMDHWeUOpZP
        3P9x/9OrEw7vNvm/59LCRbYf7cLf5UYbfZjt1xk9f23zBbFJXmqrZU6+szCYqjxl7pz7/Jve
        zDy8e0/itIk8M3o1vvGkVH6eNkUi5qTukel2e1f88GtNZV/evbrsx1Op37rRy3Ruiwjm63x6
        G2iXn8S+UfqISdkHW2+pqayXzsqlvdER+sdYMn/78cgjMfFuL1ilTpU3TZrberK+zWjRvhpT
        r9rKX7vLFxuH7r+bktT8e15xIwfrt42ZJZubfTecWb5Ne8rBmENSukWOH5mnZ0sVFXyc+Kim
        Y9XCqG1JJ6Lfn9eRbX3l3K+8+tOCusR/li+VWIozEg21mIuKEwFINDz2OQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvK7oh1eJBs1PFS0OvD/IYvFg3jY2
        i7+TjrFbvF/Ww2gx/8g5Vosjp5YwWWx8+4PJYsqf5UwWmx5fY7X42HOP1eLhq3CLy7vmsFnM
        OL+PyeLU9c9sFou2fmG3aN17hN3i8Jt2Vot/1zayWDy+/ofNQdhjzbw1jB6/f01i9JjV0Mvm
        sWlVJ5vHnWt72Dw2L6n3uHKiidWjb8sqRo9/TXPZPT5vkgvgiuKySUnNySxLLdK3S+DKmNN9
        j7VgUTdjxf7lb1kaGA9WdjFycEgImEhMPs/VxcjFISSwm1Fi1aRtjF2MnEBxaYnrGyewQ9jC
        Eiv/PWeHKGpikvjXM4EZJMEmoC1xd/oWJhBbRMBDou3fPWaQImaBx8wSDxY/BpskLOAmse/p
        D7AGFgFVib3b7oE18ArYSFz7eo0ZYoO8xOoNB8BsTgFbiddn54HZQkA1zbO2Mk1g5FvAyLCK
        UTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4PrQ0dzBuX/VB7xAjEwfjIUYJDmYlEd6C
        /FeJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDtKbPv
        45jy6+mbWu6zrqzNPQmLDpuohAqXiM2v19PYz9aqsu3F15dPc56wGbq8zd4Y59EglBfMxFV5
        I80vY8+kzoDA8JyEtKztdx+/Pn302jwTJcd2HYXFkz4KC6+O/v360y1D9qgHE7lvSThu1167
        ft61t86urH0dodsMZG/GZzgweK+LY2bee8dixv0lL0KDwzbtenuU22W5F8uR8phmB7H9snrC
        zysdXhTYH79vxzstPP9rw9FD9jMupBzW1V3xS/7TndUfAu6sctrWJLepS/K/Y8JqceOQncw6
        BRvb/zubn72eMEnraNH5tK0SEbV3/r83zDW9/KFrg82+643/Ns56a//6841+tYzni0SUWIoz
        Eg21mIuKEwEMddtk/gIAAA==
X-CMS-MailID: 20220121174037epcas5p125c19dec012f7363570019db98f587b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174037epcas5p125c19dec012f7363570019db98f587b9
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174037epcas5p125c19dec012f7363570019db98f587b9@epcas5p1.samsung.com>
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
index 000000000000..1caa31d08fc0
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

