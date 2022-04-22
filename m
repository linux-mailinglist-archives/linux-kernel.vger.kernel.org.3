Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0350BBE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449518AbiDVPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449484AbiDVPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:44:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2039.outbound.protection.outlook.com [40.92.20.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BC5D666;
        Fri, 22 Apr 2022 08:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA96rVOzg29fYHcBPPT8HnyWhKRh/+lumGCcHGTtvahvUQ3wJ3E3mlaFVr/GvzF0r9YNozCQiNad7DQUU0en9pRwju5u3xUa5gXfGBt/xDgWdBQgJnGY8YqEStNQ9tmrlE69XDy4s/oqF2Tkouhla92+fl0BqjUlmbbe7l2Wy4bLcI9CwId7C3/1fJi5eq5XYX67+vFBehy6s1f4sohhk+M3fxkmNAaK/262TAVFnwKQtYXRMlNjbjR8oe+VxAlydCZ+AzKeAzBAS7x6pHWNk3/X4zRK8oW+TKV4yr28fFm2OVUJCpcxrOJvpV0DbIbh7MdQzf/21UXf885Ymubt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roogEa8pBffpTYgqGK1UOaKed/mmzT1i+52IJi07xcA=;
 b=bhqUTAU4EW0BiKQ3ckyawCWUVTPqKrxya7hLGscNjIMNILUUFz9dyRs7IQlMcjvL3D+vAsPrDbyEzrHZKX2VksZTbFRP6UfeKdzedbmXyVNSl55/rwtQdL7d6Rbye2AxA+wbiXaS10+ORcN03PMEtHAk8BXbqGlrymrbj6e+pOVH/fRBn841VjHsR0ktXYOUzRtTaTRkLuYW5n0yhFVnTR9ER3SacRsq3a03F8PWb1Uh6dwyt/NZd4Ql0gX+wqgn1sexCKJpr6nTKDnGNhS6JpV3TJ/Cz/z6QzRvkzoCoUT+XDLJNl0qIfcyOJz0heiAFInbKjJIil7ekGVTbE3txA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roogEa8pBffpTYgqGK1UOaKed/mmzT1i+52IJi07xcA=;
 b=YIi5tSOfOTTjhnnRkjTbRkrIrn5nDc+jKI9IwpINfz3r3pJxie44WATkf5R6YKe9Xt5RmYKLBplggqsVa8HsXoAxq59/RDcwW9pI/uQP1Cuvk/61FTqEmoDGzBrq1K7ui3Tp+t+cjb8Dv+qC5lS62cMu+Nd6ybZB+i9kmH/SY+EHTP6OVKmSWm+gAxsf8dq2ayprRPQaLhXeXam/t14Si5phJBHr50a0Z0ngic3kEBxyj+ukL0jJZkUZfa+frHX+RTurWFit/gyO40D16AO4iLu0HuqvTDfdVJA0aBdqMn6NXuq/dadoHDIfqgMPjRbFtWDjM6/330savwSt1fg0Pg==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by SJ0PR20MB3642.namprd20.prod.outlook.com (2603:10b6:a03:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:42:00 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:42:00 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 06/12] clk: sunxi=ng: add support for R329 CCUs
Date:   Fri, 22 Apr 2022 23:41:09 +0800
Message-ID: <BYAPR20MB2472930AAFFBDC0ACB9A7487BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [f7yl8T+H04mOrJGsRd/eS29W0XDCe6P9]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-4-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59cbdd17-15dc-4480-6428-08da2476a40c
X-MS-TrafficTypeDiagnostic: SJ0PR20MB3642:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rX0eaALO/7E6tJVGnVCCrkD9IusyY9PaBHWveXya55PXW0YFXQ76hHHRvEKyvyuIfZDiHox+Nl4oyQHPyNUZwLUUdebz6QtkK8kyQ066lhGzxqjq5p7g4eAIci+msyN4K3RP3Fhiz1lNwwTlAKbRH2wsn+znhTB6SMWhXcaekEaR08mKcKrR15bqR0VN73UroI0bcU0FNkxi0Ol3AS2ePOdfeEKq2Ud4rpBXpSbQVdH5ritvdEa8vQY4q7t4fvSBGQIctJYfvZN4yGg23T16TiSME+CsXLw7gLCo6xce2aohZSm+xk4jNRrDEhpAZvhSgSE+STE3TfGE8WiV1LO+NNuvLE6knQPRd1wSOqvodtJdpM5l6KFj/w3OT5pV5SYcKfvPe0DjtZdMr8NsfG/WeljS59RzQg11WTRwBbTRmoCSrgAkv+ArWjFg63Se0udcrLJgWcSj3eOV/RMyW1ef7+EpiG4zZuUO6s2zglneXiDdAi3BSF9RlHEu2Mr8ASja+rI9q4NHTq415ZKgN6GnZOndLQySqmGYZ4h0xTOxLg/CUA5t5wsc5PoBNn1XcfPh3JOZ+hCJ3zFAoO0NpRhHug==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSwQthAZtG8Avz4GgzZc0EwrHfRfDkNP2RWkUIvlSiDhEUkp6S0RBO4X1VzY?=
 =?us-ascii?Q?46xCqFsIyMV9v3kS7m86komsII5tn/4t17ZmAINFyR0IjBC+ktT/3PTRLt3o?=
 =?us-ascii?Q?koDJXVIfMvHDbjwcOESZThTIUsEcRAltMZIrgPbR2p4aOByvJC4Tp8wkTWdX?=
 =?us-ascii?Q?/CxM8Lt4eGNAHg/yuj2r1zLOZL5w1jMzafm9v6zWNS1R76y79zJfPh0zUmxs?=
 =?us-ascii?Q?c/NT62KxbqzrxfrS/frpPsBPvY70XDPKzIlDNLnHddgQhc4KGeb++D4dD0Ic?=
 =?us-ascii?Q?KD5w2UPUU+l1xbRyN57oFmMSwmFauBsTgYEvfKLZEx1QpU5H6cOOB+upS0Mu?=
 =?us-ascii?Q?qVbCT5/gbXhjQr3z9G+Naa3WccZDaqe82HBTLALKoPXBtrC8D4uzs8ISxBJU?=
 =?us-ascii?Q?hU5JsyK9fAlZLtHbjmzvJz0+NoQXjfwi5rHQO268+oUWaNkAPTVLz4fmpa9g?=
 =?us-ascii?Q?ih5nn8Pjv+bjGFpBNHNtTzs3FPIRdhPXq5n4NIAvK13Ytugh2xBnAHnWD5bN?=
 =?us-ascii?Q?AJjhTuxGUSnIO2qxnrxqrzwbCEFmXkHzGyrzWjtCz8arkZ+7wB6EsLzIW6ZV?=
 =?us-ascii?Q?KjqWXNT5G6NYbuO65+gpLoZ0PMrU3dKCm7tq7VF2bt2GoylSohVYHLk9OjOS?=
 =?us-ascii?Q?/5agocUmXCcsf+yZs7bs0JU3Cj9C0wK8BPRPxwf+VlXzQfi3MHz05SaVS4QL?=
 =?us-ascii?Q?PAmad8ESGQDOGjCG2LatY3Q1mFe0IBW9848gtiNwav5x2QXtQ8wv1sclTlC1?=
 =?us-ascii?Q?e8JU8xpqc2FSvsqZCcZXDJnFtXobq7nLTaMeKt967Nl6WeoAnpCagxW4IK98?=
 =?us-ascii?Q?bQxGTQBQoXjLrvur2Y0RwYkKLp/YDxZ0PNhYRHSO/zNZrQbFl7LfXbGYpteV?=
 =?us-ascii?Q?H8n3nNmQwuIfFm9AszYb8nkBAtVeSeNMS0rRpw88Gu/97l51f1khxyz4Zn0J?=
 =?us-ascii?Q?/SjJqfYj9jrbMHilJ3Z/rHfp3FD47lifuH6KtHX8/IJAPETSZTiqQPbmN+5i?=
 =?us-ascii?Q?u6fpLQXjaIDPDTibleLz3F2mNiK/+cetDIhmw+/DSDrrvgk8eag8whztC03R?=
 =?us-ascii?Q?SXwA5W0WmXimcv4TV9y954dwTNgZ/2tWXprqh1Pym+sbkZ6wnvq8KJaO2gey?=
 =?us-ascii?Q?ROAwssTDlNOinrnaZnNx4A1icnOm8XKlgjkNbUoKMBj4oQHBQIR0DHiSqgXN?=
 =?us-ascii?Q?YKokcoIc+xP9PCVeVcDoUjf8B1PvpQU1F1L1eDVI2bOP9PbYPaQQk6VDV+0t?=
 =?us-ascii?Q?vz8PPdIZzR+DEWcscM/QClVi0pEXzHDvaJGVOPMxAG6PxzylY3st6NudhPj0?=
 =?us-ascii?Q?g6K+FIHKK6ZsIP32AE0O0dirc13nEqY2Qul6wvIAJaLMqV6gFoAYvbmf7tSZ?=
 =?us-ascii?Q?uGMudT1a5c+JgiPVpY5iwNe6Q8FoPwSsgRriU1AZIF+iLFp9k8F+YnT6MVVo?=
 =?us-ascii?Q?4cuJKDpN6yU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cbdd17-15dc-4480-6428-08da2476a40c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:42:00.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB3642
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner R329 has two CCUs, one in CPUX and another in PRCM.

Add support for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/Kconfig             |  10 +
 drivers/clk/sunxi-ng/Makefile            |   4 +
 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c | 401 ++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h |  25 +
 drivers/clk/sunxi-ng/ccu-sun50i-r329.c   | 587 +++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-r329.h   |  32 ++
 6 files changed, 1059 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 461537679c04..2ae2a5a65c05 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -52,6 +52,16 @@ config SUN50I_H6_R_CCU
 	default ARM64 && ARCH_SUNXI
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
+config SUN50I_R329_CCU
+	tristate "Support for the Allwinner R329 CCU"
+	default ARM64 && ARCH_SUNXI
+	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+
+config SUN50I_R329_R_CCU
+	tristate "Support for the Allwinner R329 PRCM CCU"
+	default ARM64 && ARCH_SUNXI
+	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+
 config SUN4I_A10_CCU
 	tristate "Support for the Allwinner A10/A20 CCU"
 	default MACH_SUN4I
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 6b3ae2b620db..7cf4c708e4b2 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -33,6 +33,8 @@ obj-$(CONFIG_SUN50I_A100_R_CCU)	+= sun50i-a100-r-ccu.o
 obj-$(CONFIG_SUN50I_H6_CCU)	+= sun50i-h6-ccu.o
 obj-$(CONFIG_SUN50I_H6_R_CCU)	+= sun50i-h6-r-ccu.o
 obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
+obj-$(CONFIG_SUN50I_R329_CCU)	+= sun50i-r329-ccu.o
+obj-$(CONFIG_SUN50I_R329_R_CCU)	+= sun50i-r329-r-ccu.o
 obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
 obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= sun6i-a31-ccu.o
@@ -58,6 +60,8 @@ sun50i-a100-r-ccu-y		+= ccu-sun50i-a100-r.o
 sun50i-h6-ccu-y			+= ccu-sun50i-h6.o
 sun50i-h6-r-ccu-y		+= ccu-sun50i-h6-r.o
 sun50i-h616-ccu-y		+= ccu-sun50i-h616.o
+sun50i-r329-ccu-y		+= ccu-sun50i-r329.o
+sun50i-r329-r-ccu-y		+= ccu-sun50i-r329-r.o
 sun4i-a10-ccu-y			+= ccu-sun4i-a10.o
 sun5i-ccu-y			+= ccu-sun5i.o
 sun6i-a31-ccu-y			+= ccu-sun6i-a31.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
new file mode 100644
index 000000000000..5533b768b45b
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Sipeed
+ * Based on the H616 CCU driver, which is:
+ *   Copyright (c) 2020 Arm Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+#include "ccu_mult.h"
+#include "ccu_nk.h"
+#include "ccu_nkm.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+
+#include "ccu-sun50i-r329-r.h"
+
+static const struct clk_parent_data osc24M[] = {
+	{ .fw_name = "hosc" }
+};
+
+/*
+ * The M factor is present in the register's description, but not in the
+ * frequency formula, and it's documented as "The bit is only for
+ * testing", so it's not modelled and then force to 0.
+ */
+#define SUN50I_R329_PLL_CPUX_REG	0x1000
+static struct ccu_mult pll_cpux_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.mult		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.common		= {
+		.reg		= 0x1000,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-cpux", osc24M,
+							   &ccu_mult_ops,
+							   CLK_SET_RATE_UNGATE),
+	},
+};
+
+#define SUN50I_R329_PLL_PERIPH_REG	0x1010
+static struct ccu_nm pll_periph_base_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= 0x1010,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-periph-base", osc24M,
+							   &ccu_nm_ops,
+							   CLK_SET_RATE_UNGATE),
+	},
+};
+
+static SUNXI_CCU_M(pll_periph_2x_clk, "pll-periph-2x", "pll-periph-base",
+		   0x1010, 16, 3, 0);
+static SUNXI_CCU_M(pll_periph_800m_clk, "pll-periph-800m", "pll-periph-base",
+		   0x1010, 20, 3, 0);
+static CLK_FIXED_FACTOR_HW(pll_periph_clk, "pll-periph",
+			   &pll_periph_2x_clk.common.hw, 2, 1, 0);
+
+#define SUN50I_R329_PLL_AUDIO0_REG	0x1020
+static struct ccu_sdm_setting pll_audio0_sdm_table[] = {
+	{ .rate = 1548288000, .pattern = 0xc0070624, .m = 1, .n = 64 },
+};
+
+static struct ccu_nm pll_audio0_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1),
+	.sdm		= _SUNXI_CCU_SDM(pll_audio0_sdm_table,
+					 BIT(24), 0x1120, BIT(31)),
+	.common		= {
+		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
+		.reg		= 0x1020,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-audio0", osc24M,
+							   &ccu_nm_ops,
+							   CLK_SET_RATE_UNGATE),
+	},
+};
+
+static SUNXI_CCU_M(pll_audio0_div2_clk, "pll-audio0-div2", "pll-audio0",
+		   0x1020, 16, 3, 0);
+static SUNXI_CCU_M(pll_audio0_div5_clk, "pll-audio0-div5", "pll-audio0",
+		   0x1020, 20, 3, 0);
+
+/*
+ * PLL-AUDIO1 has 3 dividers defined in the datasheet, however the
+ * BSP driver always has M0 = 1 and M1 = 2 (this is also the
+ * reset value in the register).
+ *
+ * Here just module it as NM clock, and force M0 = 1 and M1 = 2.
+ */
+#define SUN50I_R329_PLL_AUDIO1_REG	0x1030
+static struct ccu_sdm_setting pll_audio1_4x_sdm_table[] = {
+	{ .rate = 45158400, .pattern = 0xc001288d, .m = 12, .n = 22 },
+	{ .rate = 49152000, .pattern = 0xc00126e9, .m = 12, .n = 24 },
+	{ .rate = 180633600, .pattern = 0xc001288d, .m = 3, .n = 22 },
+	{ .rate = 196608000, .pattern = 0xc00126e9, .m = 3, .n = 24 },
+};
+static struct ccu_nm pll_audio1_4x_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(16, 6),
+	.fixed_post_div	= 2,
+	.sdm		= _SUNXI_CCU_SDM(pll_audio1_4x_sdm_table,
+					 BIT(24), 0x1130, BIT(31)),
+	.common		= {
+		.features	= CCU_FEATURE_FIXED_POSTDIV |
+				  CCU_FEATURE_SIGMA_DELTA_MOD,
+		.reg		= 0x1030,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-audio1-4x", osc24M,
+							   &ccu_nm_ops,
+							   CLK_SET_RATE_UNGATE),
+	},
+};
+
+static CLK_FIXED_FACTOR_HW(pll_audio1_2x_clk, "pll-audio1-2x",
+			   &pll_audio1_4x_clk.common.hw, 2, 1,
+			   CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HW(pll_audio1_clk, "pll-audio1",
+			   &pll_audio1_4x_clk.common.hw, 4, 1,
+			   CLK_SET_RATE_PARENT);
+
+static const struct clk_parent_data r_bus_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph_2x_clk.common.hw },
+	{ .hw = &pll_audio0_div2_clk.common.hw },
+};
+
+static SUNXI_CCU_MP_DATA_WITH_MUX(r_ahb_clk, "r-ahb", r_bus_parents, 0x000,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX(r_apb1_clk, "r-apb1", r_bus_parents, 0x00c,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX(r_apb2_clk, "r-apb2", r_bus_parents, 0x010,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  0);
+
+static SUNXI_CCU_GATE(r_bus_gpadc_clk, "r-bus-gpadc", "r-apb1",
+		      0x0ec, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_ths_clk, "r-bus-ths", "r-apb1", 0x0fc, BIT(0), 0);
+
+static SUNXI_CCU_GATE(r_bus_dma_clk, "r-bus-dma", "r-apb1", 0x10c, BIT(0), 0);
+
+static const struct clk_parent_data r_pwm_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(r_pwm_clk, "r-pwm", r_pwm_parents, 0x130,
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static SUNXI_CCU_GATE(r_bus_pwm_clk, "r-bus-pwm", "r-apb1", 0x13c, BIT(0), 0);
+
+static const char * const r_audio_parents[] = { "pll-audio0-div5", "pll-audio0-div2",
+						"pll-audio1-1x", "pll-audio1-4x" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_codec_adc_clk, "r-codec-adc", r_audio_parents, 0x140,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_codec_dac_clk, "r-codec-dac", r_audio_parents, 0x144,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_GATE(r_bus_codec_clk, "r-bus-codec", "r-apb1",
+		      0x14c, BIT(0), 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_dmic_clk, "r-dmic", r_audio_parents, 0x150,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_GATE(r_bus_dmic_clk, "r-bus-dmic", "r-apb1", 0x15c, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_lradc_clk, "r-bus-lradc", "r-apb1",
+		      0x16c, BIT(0), 0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_i2s_clk, "r-i2s", r_audio_parents, 0x170,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_MP_WITH_MUX_GATE(r_i2s_asrc_clk, "r-i2s-asrc",
+				  r_audio_parents, 0x174,
+				  0, 5,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_GATE(r_bus_i2s_clk, "r-bus-i2s", "r-apb1", 0x17c, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_uart_clk, "r-bus-uart", "r-apb2", 0x18c, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_i2c_clk, "r-bus-i2c", "r-apb2", 0x19c, BIT(0), 0);
+
+static const struct clk_parent_data r_ir_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(r_ir_clk, "r-ir", r_ir_parents, 0x1c0,
+				       0, 5,		/* M */
+				       8, 2,		/* P */
+				       24, 3,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(r_bus_ir_clk, "r-bus-ir", "r-apb1", 0x1cc, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_msgbox_clk, "r-bus-msgbox", "r-apb1",
+		      0x1dc, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_spinlock_clk, "r-bus-spinlock", "r-apb1",
+		      0x1ec, BIT(0), 0);
+static SUNXI_CCU_GATE(r_bus_rtc_clk, "r-bus-rtc", "r-ahb",
+		      0x20c, BIT(0), 0);
+
+static struct ccu_common *sun50i_r329_r_ccu_clks[] = {
+	&pll_cpux_clk.common,
+	&pll_periph_base_clk.common,
+	&pll_periph_2x_clk.common,
+	&pll_periph_800m_clk.common,
+	&pll_audio0_clk.common,
+	&pll_audio0_div2_clk.common,
+	&pll_audio0_div5_clk.common,
+	&pll_audio1_4x_clk.common,
+	&r_ahb_clk.common,
+	&r_apb1_clk.common,
+	&r_apb2_clk.common,
+	&r_bus_gpadc_clk.common,
+	&r_bus_ths_clk.common,
+	&r_bus_dma_clk.common,
+	&r_pwm_clk.common,
+	&r_bus_pwm_clk.common,
+	&r_codec_adc_clk.common,
+	&r_codec_dac_clk.common,
+	&r_bus_codec_clk.common,
+	&r_dmic_clk.common,
+	&r_bus_dmic_clk.common,
+	&r_bus_lradc_clk.common,
+	&r_i2s_clk.common,
+	&r_i2s_asrc_clk.common,
+	&r_bus_i2s_clk.common,
+	&r_bus_uart_clk.common,
+	&r_bus_i2c_clk.common,
+	&r_ir_clk.common,
+	&r_bus_ir_clk.common,
+	&r_bus_msgbox_clk.common,
+	&r_bus_spinlock_clk.common,
+	&r_bus_rtc_clk.common,
+};
+
+static struct clk_hw_onecell_data sun50i_r329_r_hw_clks = {
+	.hws	= {
+		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
+		[CLK_PLL_PERIPH_BASE]	= &pll_periph_base_clk.common.hw,
+		[CLK_PLL_PERIPH_2X]	= &pll_periph_2x_clk.common.hw,
+		[CLK_PLL_PERIPH_800M]	= &pll_periph_800m_clk.common.hw,
+		[CLK_PLL_PERIPH]	= &pll_periph_clk.hw,
+		[CLK_PLL_AUDIO0]	= &pll_audio0_clk.common.hw,
+		[CLK_PLL_AUDIO0_DIV2]	= &pll_audio0_div2_clk.common.hw,
+		[CLK_PLL_AUDIO0_DIV5]	= &pll_audio0_div5_clk.common.hw,
+		[CLK_PLL_AUDIO1_4X]	= &pll_audio1_4x_clk.common.hw,
+		[CLK_PLL_AUDIO1_2X]	= &pll_audio1_2x_clk.hw,
+		[CLK_PLL_AUDIO1]	= &pll_audio1_clk.hw,
+		[CLK_R_AHB]		= &r_ahb_clk.common.hw,
+		[CLK_R_APB1]		= &r_apb1_clk.common.hw,
+		[CLK_R_APB2]		= &r_apb2_clk.common.hw,
+		[CLK_R_BUS_GPADC]	= &r_bus_gpadc_clk.common.hw,
+		[CLK_R_BUS_THS]		= &r_bus_ths_clk.common.hw,
+		[CLK_R_BUS_DMA]		= &r_bus_dma_clk.common.hw,
+		[CLK_R_PWM]		= &r_pwm_clk.common.hw,
+		[CLK_R_BUS_PWM]		= &r_bus_pwm_clk.common.hw,
+		[CLK_R_CODEC_ADC]	= &r_codec_adc_clk.common.hw,
+		[CLK_R_CODEC_DAC]	= &r_codec_dac_clk.common.hw,
+		[CLK_R_BUS_CODEC]	= &r_bus_codec_clk.common.hw,
+		[CLK_R_DMIC]		= &r_dmic_clk.common.hw,
+		[CLK_R_BUS_DMIC]	= &r_bus_dmic_clk.common.hw,
+		[CLK_R_BUS_LRADC]	= &r_bus_lradc_clk.common.hw,
+		[CLK_R_I2S]		= &r_i2s_clk.common.hw,
+		[CLK_R_I2S_ASRC]	= &r_i2s_asrc_clk.common.hw,
+		[CLK_R_BUS_I2S]		= &r_bus_i2s_clk.common.hw,
+		[CLK_R_BUS_UART]	= &r_bus_uart_clk.common.hw,
+		[CLK_R_BUS_I2C]		= &r_bus_i2c_clk.common.hw,
+		[CLK_R_IR]		= &r_ir_clk.common.hw,
+		[CLK_R_BUS_IR]		= &r_bus_ir_clk.common.hw,
+		[CLK_R_BUS_MSGBOX]	= &r_bus_msgbox_clk.common.hw,
+		[CLK_R_BUS_SPINLOCK]	= &r_bus_spinlock_clk.common.hw,
+		[CLK_R_BUS_RTC]		= &r_bus_rtc_clk.common.hw,
+	},
+	.num = CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun50i_r329_r_ccu_resets[] = {
+	[RST_R_BUS_GPADC]	= { 0x0ec, BIT(16) },
+	[RST_R_BUS_THS]		= { 0x0fc, BIT(16) },
+	[RST_R_BUS_DMA]		= { 0x10c, BIT(16) },
+	[RST_R_BUS_PWM]		= { 0x13c, BIT(16) },
+	[RST_R_BUS_CODEC]	= { 0x14c, BIT(16) },
+	[RST_R_BUS_DMIC]	= { 0x15c, BIT(16) },
+	[RST_R_BUS_LRADC]	= { 0x16c, BIT(16) },
+	[RST_R_BUS_I2S]		= { 0x17c, BIT(16) },
+	[RST_R_BUS_UART]	= { 0x18c, BIT(16) },
+	[RST_R_BUS_I2C]		= { 0x19c, BIT(16) },
+	[RST_R_BUS_IR]		= { 0x1cc, BIT(16) },
+	[RST_R_BUS_MSGBOX]	= { 0x1dc, BIT(16) },
+	[RST_R_BUS_SPINLOCK]	= { 0x1ec, BIT(16) },
+	[RST_R_BUS_RTC]		= { 0x20c, BIT(16) },
+};
+
+static const struct sunxi_ccu_desc sun50i_r329_r_ccu_desc = {
+	.ccu_clks	= sun50i_r329_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_r329_r_ccu_clks),
+
+	.hw_clks	= &sun50i_r329_r_hw_clks,
+
+	.resets		= sun50i_r329_r_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_r329_r_ccu_resets),
+};
+
+static const u32 pll_regs[] = {
+	SUN50I_R329_PLL_CPUX_REG,
+	SUN50I_R329_PLL_PERIPH_REG,
+	SUN50I_R329_PLL_AUDIO0_REG,
+	SUN50I_R329_PLL_AUDIO1_REG,
+};
+
+static int sun50i_r329_r_ccu_probe(struct platform_device *pdev)
+{
+	void __iomem *reg;
+	int i;
+	u32 val;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	/* Enable the lock bits and the output enable bits on all PLLs */
+	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
+		val = readl(reg + pll_regs[i]);
+		val |= BIT(29) | BIT(27);
+		writel(val, reg + pll_regs[i]);
+	}
+
+	/*
+	 * Force the I/O dividers of PLL-AUDIO1 to reset default value
+	 *
+	 * See the comment before pll-audio1 definition for the reason.
+	 */
+
+	val = readl(reg + SUN50I_R329_PLL_AUDIO1_REG);
+	val &= ~BIT(1);
+	val |= BIT(0);
+	writel(val, reg + SUN50I_R329_PLL_AUDIO1_REG);
+
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_r329_r_ccu_desc);
+}
+
+static const struct of_device_id sun50i_r329_r_ccu_ids[] = {
+	{ .compatible = "allwinner,sun50i-r329-r-ccu" },
+	{ }
+};
+
+static struct platform_driver sun50i_r329_r_ccu_driver = {
+	.probe	= sun50i_r329_r_ccu_probe,
+	.driver	= {
+		.name			= "sun50i-r329-r-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun50i_r329_r_ccu_ids,
+	},
+};
+module_platform_driver(sun50i_r329_r_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h b/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
new file mode 100644
index 000000000000..1e04772b6515
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _CCU_SUN50I_R329_R_H
+#define _CCU_SUN50I_R329_R_H
+
+#include <dt-bindings/clock/sun50i-r329-r-ccu.h>
+#include <dt-bindings/reset/sun50i-r329-r-ccu.h>
+
+/* PLLs exported for main CCU except a virtual base */
+
+#define CLK_PLL_PERIPH_BASE	1
+
+/* R_AHB exported for RTC */
+/* R_APB1 exported for PIO */
+
+#define CLK_R_APB2		13
+
+/* All module / bus gate clocks exported */
+
+#define CLK_NUMBER	(CLK_R_BUS_RTC + 1)
+
+#endif /* _CCU_SUN50I_R329_R_H */
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-r329.c b/drivers/clk/sunxi-ng/ccu-sun50i-r329.c
new file mode 100644
index 000000000000..652770f1b9c8
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-r329.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Based on the H616 CCU driver, which is:
+ *   Copyright (c) 2020 Arm Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+#include "ccu_mult.h"
+#include "ccu_nk.h"
+#include "ccu_nkm.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+
+#include "ccu-sun50i-r329.h"
+
+/*
+ * An external divider of PLL-CPUX is controlled here. As it's similar to
+ * the external divider of PLL-CPUX on previous SoCs (only usable under
+ * 288MHz}, ignore it.
+ */
+static const struct clk_parent_data cpux_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .fw_name = "pll-cpux" },
+	{ .fw_name = "pll-periph" },
+	{ .fw_name = "pll-periph-2x" },
+	{ .fw_name = "pll-periph-800m" },
+};
+static SUNXI_CCU_MUX_DATA(cpux_clk, "cpux", cpux_parents,
+			  0x500, 24, 3, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x500, 0, 2, 0);
+static SUNXI_CCU_M(cpux_apb_clk, "cpux-apb", "cpux", 0x500, 8, 2, 0);
+
+static const struct clk_parent_data ahb_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .fw_name = "pll-periph" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX(ahb_clk, "ahb",
+				  ahb_parents, 0x510,
+				  0, 2,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  0);
+
+static const struct clk_parent_data apb_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .hw = &ahb_clk.common.hw },
+	{ .fw_name = "pll-periph" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX(apb1_clk, "apb1", apb_parents, 0x520,
+				  0, 2,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX(apb2_clk, "apb2", apb_parents, 0x524,
+				  0, 2,		/* M */
+				  8, 2,		/* P */
+				  24, 3,	/* mux */
+				  0);
+
+static const struct clk_parent_data ce_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "pll-periph-2x" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 1,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_ce_clk, "bus-ce", "ahb",
+		      0x68c, BIT(0), 0);
+
+static const struct clk_parent_data aipu_parents[] = {
+	{ .fw_name = "pll-periph-2x" },
+	{ .fw_name = "pll-periph-800m" },
+	{ .fw_name = "pll-audio0-div2" },
+	{ .fw_name = "pll-audio0-div5" },
+	{ .fw_name = "pll-cpux" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(aipu_clk, "aipu", aipu_parents, 0x6f0,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 3,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_aipu_clk, "bus-aipu", "ahb",
+		      0x6fc, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_dma_clk, "bus-dma", "ahb",
+		      0x70c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_msgbox_clk, "bus-msgbox", "ahb",
+		      0x71c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_spinlock_clk, "bus-spinlock", "ahb",
+		      0x72c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_hstimer_clk, "bus-hstimer", "ahb",
+		      0x73c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(avs_clk, "avs", "osc24M", 0x740, BIT(31), 0);
+
+static SUNXI_CCU_GATE(bus_dbg_clk, "bus-dbg", "ahb",
+		      0x78c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x7ac, BIT(0), 0);
+
+static const struct clk_parent_data dram_parents[] = {
+	{ .fw_name = "pll-periph-2x" },
+	{ .fw_name = "pll-periph-800m" },
+	{ .fw_name = "pll-audio0-div2" },
+	{ .fw_name = "pll-audio0-div5" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(dram_clk, "dram", dram_parents, 0x800,
+				       0, 2,		/* M */
+				       8, 2,		/* P */
+				       24, 2,		/* mux */
+				       BIT(31),		/* gate */
+				       CLK_IS_CRITICAL);
+
+
+static SUNXI_CCU_GATE(mbus_dma_clk, "mbus-dma", "dram",
+		      0x804, BIT(0), 0);
+static SUNXI_CCU_GATE(mbus_ce_clk, "mbus-ce", "dram",
+		      0x804, BIT(2), 0);
+static SUNXI_CCU_GATE(mbus_r_dma_clk, "mbus-r-dma", "dram",
+		      0x804, BIT(3), 0);
+static SUNXI_CCU_GATE(mbus_nand_clk, "mbus-nand", "dram",
+		      0x804, BIT(5), 0);
+static SUNXI_CCU_GATE(mbus_aipu_clk, "mbus-aipu", "dram",
+		      0x804, BIT(16), 0);
+
+static SUNXI_CCU_GATE(bus_dram_clk, "bus-dram", "ahb",
+		      0x80c, BIT(0), CLK_IS_CRITICAL);
+
+static const struct clk_parent_data nand_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "pll-periph" },
+	{ .fw_name = "pll-audio0-div2" },
+	{ .fw_name = "pll-periph-2x" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(nand0_clk, "nand0", nand_parents, 0x810,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 3,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(nand1_clk, "nand1", nand_parents, 0x814,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 3,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_nand_clk, "bus-nand", "ahb", 0x82c, BIT(0), 0);
+
+static const struct clk_parent_data mmc_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "pll-periph" },
+	{ .fw_name = "pll-periph-2x" },
+	{ .fw_name = "pll-audio0-div2" },
+};
+
+static struct ccu_mp mmc0_clk = {
+	.enable	= BIT(31),
+	.m	= _SUNXI_CCU_DIV(0, 4),
+	.p	= _SUNXI_CCU_DIV(8, 2),
+	.mux	= _SUNXI_CCU_MUX(24, 2),
+	.fixed_post_div	= 2,
+	.common	= {
+		.reg		= 0x830,
+		.features	= CCU_FEATURE_FIXED_POSTDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("mmc0",
+							   mmc_parents,
+							   &ccu_mp_ops,
+							   0),
+	}
+};
+
+static struct ccu_mp mmc1_clk = {
+	.enable	= BIT(31),
+	.m	= _SUNXI_CCU_DIV(0, 4),
+	.p	= _SUNXI_CCU_DIV(8, 2),
+	.mux	= _SUNXI_CCU_MUX(24, 2),
+	.fixed_post_div	= 2,
+	.common	= {
+		.reg		= 0x834,
+		.features	= CCU_FEATURE_FIXED_POSTDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("mmc1",
+							   mmc_parents,
+							   &ccu_mp_ops,
+							   0),
+	}
+};
+
+static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb", 0x84c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb", 0x84c, BIT(1), 0);
+
+static SUNXI_CCU_GATE(bus_uart0_clk, "bus-uart0", "apb2", 0x90c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_uart1_clk, "bus-uart1", "apb2", 0x90c, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_uart2_clk, "bus-uart2", "apb2", 0x90c, BIT(2), 0);
+static SUNXI_CCU_GATE(bus_uart3_clk, "bus-uart3", "apb2", 0x90c, BIT(3), 0);
+
+static SUNXI_CCU_GATE(bus_i2c0_clk, "bus-i2c0", "apb2", 0x91c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_i2c1_clk, "bus-i2c1", "apb2", 0x91c, BIT(1), 0);
+
+static SUNXI_CCU_GATE(bus_scr_clk, "bus-scr", "apb2", 0x93c, BIT(0), 0);
+
+static const struct clk_parent_data spi_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "pll-periph" },
+	{ .fw_name = "pll-periph-2x" },
+	{ .fw_name = "pll-audio0-div2" },
+	{ .fw_name = "pll-audio0-div5" },
+};
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi0_clk, "spi0", spi_parents, 0x940,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 3,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi1_clk, "spi1", spi_parents, 0x944,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 3,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_spi0_clk, "bus-spi0", "ahb", 0x96c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_spi1_clk, "bus-spi1", "ahb", 0x96c, BIT(1), 0);
+
+static CLK_FIXED_FACTOR_FW_NAME(emac_25m_div_clk, "emac-25m-div", "pll-periph",
+				2, 1, 0);
+static SUNXI_CCU_GATE(emac_25m_clk, "emac-25m", "emac-25m-div", 0x970,
+		      BIT(31) | BIT(30), 0);
+
+static SUNXI_CCU_GATE(bus_emac_clk, "bus-emac", "ahb", 0x97c, BIT(0), 0);
+
+static const struct clk_parent_data ir_parents[] = {
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .fw_name = "pll-periph" },
+	{ .fw_name = "pll-audio0-div2" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(ir_rx_clk, "ir-rx", ir_parents, 0x990,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 2,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_ir_rx_clk, "bus-ir-rx", "apb1", 0x99c, BIT(0), 0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(ir_tx_clk, "ir-tx", ir_parents, 0x9c0,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 2,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_ir_tx_clk, "bus-ir-tx", "apb1", 0x9cc, BIT(0), 0);
+
+static const struct clk_parent_data audio_parents[] = {
+	{ .fw_name = "pll-audio1" },
+	{ .fw_name = "pll-audio1-4x" },
+	{ .fw_name = "pll-audio0-div2" },
+	{ .fw_name = "pll-audio0-div5" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(i2s0_clk, "i2s0", audio_parents, 0xa10,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 2,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(i2s1_clk, "i2s1", audio_parents, 0xa14,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 2,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_i2s0_clk, "bus-i2s0", "apb1", 0xa20, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_i2s1_clk, "bus-i2s1", "apb1", 0xa20, BIT(1), 0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spdif_clk, "spdif", audio_parents, 0xa20,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 2,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_spdif_clk, "bus-spdif", "apb1", 0xa2c, BIT(0), 0);
+
+/*
+ * There are OHCI 12M clock source selection bits for 2 USB 2.0 ports.
+ * We will force them to 0 (12M divided from 48M).
+ */
+#define SUN50I_R329_USB0_CLK_REG		0xa70
+#define SUN50I_R329_USB1_CLK_REG		0xa74
+
+static SUNXI_CCU_GATE(usb_ohci0_clk, "usb-ohci0", "osc12M", 0xa70, BIT(31), 0);
+static SUNXI_CCU_GATE(usb_phy0_clk, "usb-phy0", "osc24M", 0xa70, BIT(29), 0);
+
+static SUNXI_CCU_GATE(usb_ohci1_clk, "usb-ohci1", "osc12M", 0xa74, BIT(31), 0);
+static SUNXI_CCU_GATE(usb_phy1_clk, "usb-phy1", "osc24M", 0xa74, BIT(29), 0);
+
+static SUNXI_CCU_GATE(bus_ohci0_clk, "bus-ohci0", "ahb", 0xa8c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_ohci1_clk, "bus-ohci1", "ahb", 0xa8c, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_ehci0_clk, "bus-ehci0", "ahb", 0xa8c, BIT(4), 0);
+static SUNXI_CCU_GATE(bus_otg_clk, "bus-otg", "ahb", 0xa8c, BIT(8), 0);
+
+static const struct clk_parent_data ledc_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "pll-periph" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ledc_parents, 0xbf0,
+				       0, 4,		/* M */
+				       8, 2,		/* P */
+				       24, 1,		/* mux */
+				       BIT(31),		/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_ledc_clk, "bus-ledc", "apb1", 0xbfc, BIT(0), 0);
+
+/* Fixed factor clocks */
+static CLK_FIXED_FACTOR_FW_NAME(osc12M_clk, "osc12M", "hosc", 2, 1, 0);
+
+static struct ccu_common *sun50i_r329_ccu_clks[] = {
+	&cpux_clk.common,
+	&axi_clk.common,
+	&cpux_apb_clk.common,
+	&ahb_clk.common,
+	&apb1_clk.common,
+	&apb2_clk.common,
+	&ce_clk.common,
+	&bus_ce_clk.common,
+	&aipu_clk.common,
+	&bus_aipu_clk.common,
+	&bus_dma_clk.common,
+	&bus_msgbox_clk.common,
+	&bus_spinlock_clk.common,
+	&bus_hstimer_clk.common,
+	&avs_clk.common,
+	&bus_dbg_clk.common,
+	&bus_pwm_clk.common,
+	&dram_clk.common,
+	&mbus_dma_clk.common,
+	&mbus_ce_clk.common,
+	&mbus_r_dma_clk.common,
+	&mbus_nand_clk.common,
+	&mbus_aipu_clk.common,
+	&bus_dram_clk.common,
+	&nand0_clk.common,
+	&nand1_clk.common,
+	&bus_nand_clk.common,
+	&mmc0_clk.common,
+	&mmc1_clk.common,
+	&bus_mmc0_clk.common,
+	&bus_mmc1_clk.common,
+	&bus_uart0_clk.common,
+	&bus_uart1_clk.common,
+	&bus_uart2_clk.common,
+	&bus_uart3_clk.common,
+	&bus_i2c0_clk.common,
+	&bus_i2c1_clk.common,
+	&bus_scr_clk.common,
+	&spi0_clk.common,
+	&spi1_clk.common,
+	&bus_spi0_clk.common,
+	&bus_spi1_clk.common,
+	&emac_25m_clk.common,
+	&bus_emac_clk.common,
+	&ir_rx_clk.common,
+	&bus_ir_rx_clk.common,
+	&ir_tx_clk.common,
+	&bus_ir_tx_clk.common,
+	&i2s0_clk.common,
+	&i2s1_clk.common,
+	&bus_i2s0_clk.common,
+	&bus_i2s1_clk.common,
+	&spdif_clk.common,
+	&bus_spdif_clk.common,
+	&usb_ohci0_clk.common,
+	&usb_phy0_clk.common,
+	&usb_ohci1_clk.common,
+	&usb_phy1_clk.common,
+	&bus_ohci0_clk.common,
+	&bus_ohci1_clk.common,
+	&bus_ehci0_clk.common,
+	&bus_otg_clk.common,
+	&ledc_clk.common,
+	&bus_ledc_clk.common,
+};
+
+static struct clk_hw_onecell_data sun50i_r329_hw_clks = {
+	.hws	= {
+		[CLK_OSC12M]		= &osc12M_clk.hw,
+		[CLK_CPUX]		= &cpux_clk.common.hw,
+		[CLK_AXI]		= &axi_clk.common.hw,
+		[CLK_CPUX_APB]		= &cpux_apb_clk.common.hw,
+		[CLK_AHB]		= &ahb_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB2]		= &apb2_clk.common.hw,
+		[CLK_CE]		= &ce_clk.common.hw,
+		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
+		[CLK_AIPU]		= &aipu_clk.common.hw,
+		[CLK_BUS_AIPU]		= &bus_aipu_clk.common.hw,
+		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
+		[CLK_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
+		[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
+		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
+		[CLK_AVS]		= &avs_clk.common.hw,
+		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
+		[CLK_BUS_PWM]		= &bus_pwm_clk.common.hw,
+		[CLK_DRAM]		= &dram_clk.common.hw,
+		[CLK_MBUS_DMA]		= &mbus_dma_clk.common.hw,
+		[CLK_MBUS_CE]		= &mbus_ce_clk.common.hw,
+		[CLK_MBUS_R_DMA]	= &mbus_r_dma_clk.common.hw,
+		[CLK_MBUS_NAND]		= &mbus_nand_clk.common.hw,
+		[CLK_MBUS_AIPU]		= &mbus_aipu_clk.common.hw,
+		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
+		[CLK_NAND0]		= &nand0_clk.common.hw,
+		[CLK_NAND1]		= &nand1_clk.common.hw,
+		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
+		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
+		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
+		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
+		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
+		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
+		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
+		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
+		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
+		[CLK_BUS_SCR]		= &bus_scr_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
+		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
+		[CLK_EMAC_25M_DIV]	= &emac_25m_div_clk.hw,
+		[CLK_EMAC_25M]		= &emac_25m_clk.common.hw,
+		[CLK_BUS_EMAC]		= &bus_emac_clk.common.hw,
+		[CLK_IR_RX]		= &ir_rx_clk.common.hw,
+		[CLK_BUS_IR_RX]		= &bus_ir_rx_clk.common.hw,
+		[CLK_IR_TX]		= &ir_tx_clk.common.hw,
+		[CLK_BUS_IR_TX]		= &bus_ir_tx_clk.common.hw,
+		[CLK_I2S0]		= &i2s0_clk.common.hw,
+		[CLK_I2S1]		= &i2s1_clk.common.hw,
+		[CLK_BUS_I2S0]		= &bus_i2s0_clk.common.hw,
+		[CLK_BUS_I2S1]		= &bus_i2s1_clk.common.hw,
+		[CLK_SPDIF]		= &spdif_clk.common.hw,
+		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
+		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
+		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
+		[CLK_USB_PHY1]		= &usb_phy1_clk.common.hw,
+		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
+		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
+		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
+		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
+		[CLK_LEDC]		= &ledc_clk.common.hw,
+		[CLK_BUS_LEDC]		= &bus_ledc_clk.common.hw,
+	},
+	.num = CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun50i_r329_ccu_resets[] = {
+	[RST_MBUS]		= { 0x540, BIT(30) },
+
+	[RST_BUS_CE]		= { 0x68c, BIT(16) },
+	[RST_BUS_AIPU]		= { 0x6fc, BIT(16) },
+	[RST_BUS_DMA]		= { 0x70c, BIT(16) },
+	[RST_BUS_MSGBOX]	= { 0x71c, BIT(16) },
+	[RST_BUS_SPINLOCK]	= { 0x72c, BIT(16) },
+	[RST_BUS_HSTIMER]	= { 0x73c, BIT(16) },
+	[RST_BUS_DBG]		= { 0x78c, BIT(16) },
+	[RST_BUS_PWM]		= { 0x7ac, BIT(16) },
+	[RST_BUS_DRAM]		= { 0x80c, BIT(16) },
+	[RST_BUS_NAND]		= { 0x82c, BIT(16) },
+	[RST_BUS_MMC0]		= { 0x84c, BIT(16) },
+	[RST_BUS_MMC1]		= { 0x84c, BIT(17) },
+	[RST_BUS_UART0]		= { 0x90c, BIT(16) },
+	[RST_BUS_UART1]		= { 0x90c, BIT(17) },
+	[RST_BUS_UART2]		= { 0x90c, BIT(18) },
+	[RST_BUS_UART3]		= { 0x90c, BIT(19) },
+	[RST_BUS_I2C0]		= { 0x91c, BIT(16) },
+	[RST_BUS_I2C1]		= { 0x91c, BIT(17) },
+	[RST_BUS_SCR]		= { 0x93c, BIT(16) },
+	[RST_BUS_SPI0]		= { 0x96c, BIT(16) },
+	[RST_BUS_SPI1]		= { 0x96c, BIT(17) },
+	[RST_BUS_EMAC]		= { 0x97c, BIT(16) },
+	[RST_BUS_IR_RX]		= { 0x99c, BIT(16) },
+	[RST_BUS_IR_TX]		= { 0x9cc, BIT(16) },
+	[RST_BUS_I2S0]		= { 0xa1c, BIT(16) },
+	[RST_BUS_I2S1]		= { 0xa1c, BIT(17) },
+	[RST_BUS_SPDIF]		= { 0xa2c, BIT(16) },
+
+	[RST_USB_PHY0]		= { 0xa70, BIT(30) },
+	[RST_USB_PHY1]		= { 0xa74, BIT(30) },
+
+	[RST_BUS_OHCI0]		= { 0xa8c, BIT(16) },
+	[RST_BUS_OHCI1]		= { 0xa8c, BIT(17) },
+	[RST_BUS_EHCI0]		= { 0xa8c, BIT(20) },
+	[RST_BUS_OTG]		= { 0xa8c, BIT(24) },
+
+	[RST_BUS_LEDC]		= { 0xbfc, BIT(16) },
+};
+
+static const struct sunxi_ccu_desc sun50i_r329_ccu_desc = {
+	.ccu_clks	= sun50i_r329_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_r329_ccu_clks),
+
+	.hw_clks	= &sun50i_r329_hw_clks,
+
+	.resets		= sun50i_r329_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_r329_ccu_resets),
+};
+
+static const u32 sun50i_r329_usb_clk_regs[] = {
+	SUN50I_R329_USB0_CLK_REG,
+	SUN50I_R329_USB1_CLK_REG,
+};
+
+static int sun50i_r329_ccu_probe(struct platform_device *pdev)
+{
+	void __iomem *reg;
+	u32 val;
+	int i;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	/*
+	 * Force OHCI 12M clock sources to 00 (12MHz divided from 48MHz)
+	 *
+	 * This clock mux is still mysterious, and the code just enforces
+	 * it to have a valid clock parent.
+	 */
+	for (i = 0; i < ARRAY_SIZE(sun50i_r329_usb_clk_regs); i++) {
+		val = readl(reg + sun50i_r329_usb_clk_regs[i]);
+		val &= ~GENMASK(25, 24);
+		writel(val, reg + sun50i_r329_usb_clk_regs[i]);
+	}
+
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_r329_ccu_desc);
+}
+
+static const struct of_device_id sun50i_r329_ccu_ids[] = {
+	{ .compatible = "allwinner,sun50i-r329-ccu" },
+	{ }
+};
+
+static struct platform_driver sun50i_r329_ccu_driver = {
+	.probe	= sun50i_r329_ccu_probe,
+	.driver	= {
+		.name	= "sun50i-r329-ccu",
+		.of_match_table	= sun50i_r329_ccu_ids,
+	},
+};
+module_platform_driver(sun50i_r329_ccu_driver);
+
+MODULE_IMPORT_NS(SUNXI_CCU);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-r329.h b/drivers/clk/sunxi-ng/ccu-sun50i-r329.h
new file mode 100644
index 000000000000..144ac9954ef3
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-r329.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _CCU_SUN50I_R329_H_
+#define _CCU_SUN50I_R329_H_
+
+#include <dt-bindings/clock/sun50i-r329-ccu.h>
+#include <dt-bindings/reset/sun50i-r329-ccu.h>
+
+#define CLK_OSC12M		0
+
+/* CPUX exported for DVFS */
+
+#define CLK_AXI			2
+#define CLK_CPUX_APB		3
+#define CLK_AHB			4
+
+/* APB1 exported for PIO */
+
+#define CLK_APB2		6
+
+/* Peripheral module and gate clock exported except for DRAM ones */
+
+#define CLK_DRAM		18
+
+#define CLK_BUS_DRAM		24
+
+#define CLK_NUMBER		(CLK_BUS_LEDC + 1)
+
+#endif /* _CCU_SUN50I_R329_H_ */
-- 
2.35.1

