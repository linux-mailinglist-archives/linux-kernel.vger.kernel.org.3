Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605F84C3B20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiBYBln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiBYBlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:41:39 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13EF29DD06;
        Thu, 24 Feb 2022 17:41:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJ/TFDuUeZ3goPxvWohIxUKYywtWbwNgYsPckJnYV4Eyh9x8mkfkJl1kw+fUtAxRIMlBHAvbIjKgtOsxE3MhlIafffrfh3/QYZQiBh7vwR5ebLZDf7qVdKH0cTs91bocVrUkVMQ0H0QzGkzTr/LQVxzB0JdMcCARUPACAVe5iqL3mGtgx17HfFoNrhGPaYlam67zQtKUPp6vRxQtXpRcRMOGryMf7S6IGpGaUT0KxI56wMxNAkl57q3vcDvzoEJkf7Y5iOpoxJp0qH211vEUjPGC3LnuzCq/IrdyUYHuTyBL8LmSjpZ8W6l2eIH0kvJEq1r8UxCPJHo9F+YTq9g8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=472JtMyjDKwlsbwQ+gio1oaDgOuinj7d63Xp5NSztZw=;
 b=MmSmHjB/F6erUPBjja872TdpoaDnVRnSe7wr4I5jQ6Jx+RyfMX+T9BrROoezFFLGrYDi0p2nBOVL1D/ML+cwcXBXP7IHH6h7p9YwsACLU2LpSPNWUu+zBND2seU8IYnC0dy7U+QAv8QZS+WM3X37CSDP77PGhVMK9L+n0AU/So2p80cz0JZIEvS+5/jrML8K37hYTrkdYzWN3p0K7v+ci1FvK4rW/Jw6mVPzOneLoXNbcZ6hBZa7ycqnsRLzQwQcPrkOu0K4gG5e6i4r5/Z2kuM6cHacaShQC6/EGlvuAskVnn2f25XDm6i/BnVp63wgAjt3UfQ7JeSmVpTIlmkBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=472JtMyjDKwlsbwQ+gio1oaDgOuinj7d63Xp5NSztZw=;
 b=giZrCpgE0sCjJw9tLDA0y9GWcV1H4IAMoYg0Dyj181+AK4YTBOXrGLh+Q7CkqTlLPNs82n7Yez5ZirUUoZhqwDK8aDBBA+9XjqfxY06CLDqfpkEupV/erhu0RmyauFnrOkZ32fuOi5Hj8V7sTYf77QeiY4hKmX2X+4M6NWRSQ70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5316.eurprd04.prod.outlook.com (2603:10a6:208:d0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 01:41:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 01:41:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 4/5] clk: imx: support fracn gppll
Date:   Fri, 25 Feb 2022 09:42:33 +0800
Message-Id: <20220225014234.1766305-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225014234.1766305-1-peng.fan@oss.nxp.com>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e80b7e-8d86-410e-04a0-08d9f7ffe1a8
X-MS-TrafficTypeDiagnostic: AM0PR04MB5316:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB53169F9FB9F365187E8E090CC93E9@AM0PR04MB5316.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdmHRA7lC5vHROEzwY3+7hpvrp+U5OrZ7jkDPCEyJnI17JAFRPQMeR05Bo3qQFIqhskYbzpxm3Mz+kRLII8f4r++5f23/+xtQ4O3kjYHlBOqKo9QmKUdSgPZy0Vtp1OONFQ5DGdLQCVMUnaSjbdE1bcKVBcberBKamGNkDK7WbG4WyZz2VkxXSoNsuRzBEK3HrgP4sVno8iEwJRj4QHX/inwngDnF9IP81HzKC6IrMxe5Il8iRwgilFLov8s5jArYpbGxUmEiL5HmxVZyVTCkYchLc8v65SGgoWKqHrl/Fh0BYQeRNh/LWHsIxUfX7Pp0w+Ql9tQhWSossqOALuSirDEjqbK4QKBbOKIX4zbQn62ZOMA0YARm5VgDbyDLltYMPN0RdJl7Soiby+7oaQwPOzghi/BQnaHPxVHRN6sewSNe9svl5u0rmTbibq72eIOZs/nLaASXopfSVxB4Fvmv0uScuDE+Sm8N6TajCQja+pHL6L48gZKZoGuWL0CVfdKAH0RS4BZFN3VjyoVk7KIrtOhQ84i6+tmO2y80Pu+RiCJD0J+2Fm232hIa0WJbcOjjzPFQV+C9cQrojqIp8uK6s/JF3PLkACcL4mQwdT9UqsAgyREUwmYUqeuWt/OexsrWnskEXRZCDwsLCehpOLboGc4duNjNgKaxRYmqluBeDGKpEQy8sWYh4YGdFy55AHI7ds9EHxztvszFasfGO/YUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(38100700002)(83380400001)(38350700002)(6486002)(316002)(66946007)(5660300002)(7416002)(6512007)(6666004)(8676002)(86362001)(66476007)(66556008)(4326008)(52116002)(2906002)(2616005)(30864003)(26005)(1076003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qx+LykGTbYyZ5ZS8oLO3dszaPZkZIWMqruBr77E2f90gzrowtDONeCRte/5o?=
 =?us-ascii?Q?PF/yGoJZ1zhW1II1xBzzvwgQidaO/Ow+VT/A2YVHbYTgssGjn+t5WDebwRTK?=
 =?us-ascii?Q?gvpXlC5Ji+gC4hiSeeD2VfqDg4+INCpdHE24lgZfQhsw1jhSzktADaVrHeVa?=
 =?us-ascii?Q?KkAXgeBIKAmCcd+TIicitSaCd2qD9XyrpkBdI/2eXmO3EAOMx7Or+P0YjriI?=
 =?us-ascii?Q?3JxcwLR1/cukRKAhzpZ8V4awdgDRNHAsOtzlWTCblXunsIdF6axpBqzlPH/x?=
 =?us-ascii?Q?YUcGl2TQEErCZj5YYN+UK6Xa9X0ftV7NgQPRRYCoOZ6UBuQGl+d0SfxIZ+9N?=
 =?us-ascii?Q?oN2A7pBMNuQ6ynTstLF/luDWvtuL16aBL9WUf/tyOEmaL5WVG71BVRIaQ1B8?=
 =?us-ascii?Q?QicmL7+2irU4m/lyEA1tUwiSOImNdWSxzSDQwSTJ4392S80r5g0tJfLm2xsF?=
 =?us-ascii?Q?lA52whV+WwRadTNv9Vbvd0eq9sZBx3Ve+QIDF57LB2GhFO0xoSCV2o84G1u9?=
 =?us-ascii?Q?tenkNRlkH7n7b8u/rF0MmgN8FjWE3SF2Isp4jEX8RNy3a+bryUup2y2R6bx+?=
 =?us-ascii?Q?3/8khzfE0ATRxRYWhT1z+MQ2s70DshFT28a6KGk89zzm7SHALPXmR8TcsHnB?=
 =?us-ascii?Q?HGb7SOwGCcslE2fzuBvo60rcakkW35XjvPUb8Sx06LojcXPoroG5oxwyHyIA?=
 =?us-ascii?Q?zBx2NvksbBS9HHZinP/AWcrtzGP6aQb9goWQYdE/s5ApJQy4mGpTu12ZcrOI?=
 =?us-ascii?Q?98OGrnL8hoI6OrzosyfLZoiTn3U792ZNLj/RK0YtGxS4l95x3M8EWHTyUX27?=
 =?us-ascii?Q?7FqXSa+1smoZdCvoCy4k0thmUcgYViCmXG8PWMcHDy+aWu7jCC0QzuJ26OuD?=
 =?us-ascii?Q?m9/V4+sQKFHgI4zgRt40/m2DuaZgrqbt5QNNY5MapXx1ea00VhVConsAiVGQ?=
 =?us-ascii?Q?lhlA7q4QbCOhS97Lvbei+4BLNEnj+9CFA35dKlcj5gDlopzwODFcqei7L7bU?=
 =?us-ascii?Q?q2D9usHih6Xocak9zWVwqCv5kPs+HdCzm/VL+TxN7AVqUYX4Y95tPoIyqIVK?=
 =?us-ascii?Q?PzybHXW84NqmuhAwV1ifFsPSwxEWVOkXQPmA9PUbkJPtoj3MYqbnK+lJvVE7?=
 =?us-ascii?Q?ZqEIdvyRHoOHuKVkxfJyWY+pMz9a2egsL0gnQt4zm0TdP9f2Zm/N/LxemiHY?=
 =?us-ascii?Q?S86/9v3YoXEm59AGiyemMI/G9QpiSNKOs0UsO8e84gwERf3LPZ5riN1+bgMP?=
 =?us-ascii?Q?x810drpBZUoNrcyeTld++NQA82lApfzwskUGfckaWak2Qk107gzIuzF3SGit?=
 =?us-ascii?Q?Qs5MtRzFAF9bYTQYqFUI+CuuzVOxibB1Cn+OvMovxiVrkaaOgBpQQZEI5emM?=
 =?us-ascii?Q?D3uuqbKRkiHHY7YK4HBV/7iZ/jrPx/sJyHuESSXHS0SL7gtgknJudtcIube2?=
 =?us-ascii?Q?4PTICRvDd3EZHpfAvH5llwvW1v40iuurNY9MQLvkKzpLHqLDODwjq07P7hiE?=
 =?us-ascii?Q?VXY6dx6KYKLuspf7hTuS8qnSp1sPYzyOmYh+qmNKfZ5FkcziE2H0XjI6DxgN?=
 =?us-ascii?Q?gLwvFkN2BilTM6CWksA7Ht++SHgpQO8c5ubgNrOj+ljKQtnbFJzSjzQm+1eK?=
 =?us-ascii?Q?WpdOnlUPVvZJz1WkQppKWys=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e80b7e-8d86-410e-04a0-08d9f7ffe1a8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 01:41:02.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIj0XqAP5LoC0IBLzwSHeHTqbYYgCdpxB3/fCL2Vmz5mbzWX05mk8oGKstLfO912tYD54ueHnhn3T9x/Od2Q2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This PLL module is a Fractional-N synthesizer,
supporting 30-bit numerator and denominator. Numerator is a signed
number. It has feature to adjust fractional portion of feedback
divider dynamically. This fracn gppll is used in i.MX93.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Makefile          |   1 +
 drivers/clk/imx/clk-fracn-gppll.c | 324 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h             |  21 ++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 36c04922d789..60c8a4bb7574 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -5,6 +5,7 @@ mxc-clk-objs += clk-busy.o
 mxc-clk-objs += clk-composite-7ulp.o
 mxc-clk-objs += clk-composite-8m.o
 mxc-clk-objs += clk-composite-93.o
+mxc-clk-objs += clk-fracn-gppll.o
 mxc-clk-objs += clk-cpu.o
 mxc-clk-objs += clk-divider-gate.o
 mxc-clk-objs += clk-fixup-div.o
diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
new file mode 100644
index 000000000000..57b38147f05a
--- /dev/null
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP
+ */
+
+#include <asm/div64.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+
+#include "clk.h"
+
+#define PLL_CTRL		0x0
+#define CLKMUX_BYPASS		BIT(2)
+#define CLKMUX_EN		BIT(1)
+#define POWERUP_MASK		BIT(0)
+
+#define PLL_ANA_PRG		0x10
+#define PLL_SPREAD_SPECTRUM	0x30
+
+#define PLL_NUMERATOR		0x40
+#define PLL_MFN_MASK		GENMASK(31, 2)
+
+#define PLL_DENOMINATOR		0x50
+#define PLL_MFD_MASK		GENMASK(29, 0)
+
+#define PLL_DIV			0x60
+#define PLL_MFI_MASK		GENMASK(24, 16)
+#define PLL_RDIV_MASK		GENMASK(15, 13)
+#define PLL_ODIV_MASK		GENMASK(7, 0)
+
+#define PLL_DFS_CTRL(x)		(0x70 + (x) * 0x10)
+
+#define PLL_STATUS		0xF0
+#define LOCK_STATUS		BIT(0)
+
+#define DFS_STATUS		0xF4
+
+#define LOCK_TIMEOUT_US		200
+
+#define PLL_FRACN_GP(_rate, _mfi, _mfn, _mfd, _rdiv, _odiv)	\
+	{							\
+		.rate	=	(_rate),			\
+		.mfi	=	(_mfi),				\
+		.mfn	=	(_mfn),				\
+		.mfd	=	(_mfd),				\
+		.rdiv	=	(_rdiv),			\
+		.odiv	=	(_odiv),			\
+	}
+
+struct clk_fracn_gppll {
+	struct clk_hw			hw;
+	void __iomem			*base;
+	const struct imx_fracn_gppll_rate_table *rate_table;
+	int rate_count;
+};
+
+/*
+ * Fvco = Fref * (MFI + MFN / MFD)
+ * Fout = Fvco / (rdiv * odiv)
+ */
+static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
+	PLL_FRACN_GP(650000000U, 81, 0, 0, 0, 3),
+	PLL_FRACN_GP(594000000U, 198, 0, 0, 0, 8),
+	PLL_FRACN_GP(560000000U, 70, 0, 0, 0, 3),
+	PLL_FRACN_GP(400000000U, 50, 0, 0, 0, 3),
+	PLL_FRACN_GP(393216000U, 81, 92, 100, 0, 5)
+};
+
+struct imx_fracn_gppll_clk imx_fracn_gppll = {
+	.rate_table = fracn_tbl,
+	.rate_count = ARRAY_SIZE(fracn_tbl),
+};
+EXPORT_SYMBOL_GPL(imx_fracn_gppll);
+
+static inline struct clk_fracn_gppll *to_clk_fracn_gppll(struct clk_hw *hw)
+{
+	return container_of(hw, struct clk_fracn_gppll, hw);
+}
+
+static const struct imx_fracn_gppll_rate_table *
+imx_get_pll_settings(struct clk_fracn_gppll *pll, unsigned long rate)
+{
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	for (i = 0; i < pll->rate_count; i++)
+		if (rate == rate_table[i].rate)
+			return &rate_table[i];
+
+	return NULL;
+}
+
+static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	/* Assuming rate_table is in descending order */
+	for (i = 0; i < pll->rate_count; i++)
+		if (rate >= rate_table[i].rate)
+			return rate_table[i].rate;
+
+	/* return minimum supported value */
+	return rate_table[pll->rate_count - 1].rate;
+}
+
+static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	u32 pll_numerator, pll_denominator, pll_div;
+	u32 mfi, mfn, mfd, rdiv, odiv;
+	u64 fvco = parent_rate;
+	long rate = 0;
+	int i;
+
+	pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
+	mfn = FIELD_GET(PLL_MFN_MASK, pll_numerator);
+
+	pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
+	mfd = FIELD_GET(PLL_MFD_MASK, pll_denominator);
+
+	pll_div = readl_relaxed(pll->base + PLL_DIV);
+	mfi = FIELD_GET(PLL_MFI_MASK, pll_div);
+
+	rdiv = FIELD_GET(PLL_RDIV_MASK, pll_div);
+	rdiv = rdiv + 1;
+	odiv = FIELD_GET(PLL_ODIV_MASK, pll_div);
+	switch (odiv) {
+	case 0:
+		odiv = 2;
+		break;
+	case 1:
+		odiv = 3;
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Sometimes, the recalculated rate has deviation due to
+	 * the frac part. So find the accurate pll rate from the table
+	 * first, if no match rate in the table, use the rate calculated
+	 * from the equation below.
+	 */
+	for (i = 0; i < pll->rate_count; i++) {
+		if (rate_table[i].mfn == mfn && rate_table[i].mfi == mfi &&
+		    rate_table[i].mfd == mfd && rate_table[i].rdiv == rdiv &&
+		    rate_table[i].odiv == odiv)
+			rate = rate_table[i].rate;
+	}
+
+	if (rate)
+		return (unsigned long)rate;
+
+	/* Fvco = Fref * (MFI + MFN / MFD) */
+	fvco = fvco * mfi * mfd + fvco * mfn;
+	do_div(fvco, mfd * rdiv * odiv);
+
+	return (unsigned long)fvco;
+}
+
+static int clk_fracn_gppll_wait_lock(struct clk_fracn_gppll *pll)
+{
+	u32 val;
+
+	return readl_poll_timeout(pll->base + PLL_STATUS, val,
+				  val & LOCK_STATUS, 0, LOCK_TIMEOUT_US);
+}
+
+static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
+				    unsigned long prate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate;
+	u32 tmp, pll_div, ana_mfn;
+	int ret;
+
+	rate = imx_get_pll_settings(pll, drate);
+
+	/* Disable output */
+	tmp = readl_relaxed(pll->base + PLL_CTRL);
+	tmp &= ~CLKMUX_EN;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Power Down */
+	tmp &= ~POWERUP_MASK;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Disable BYPASS */
+	tmp &= ~CLKMUX_BYPASS;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
+		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
+	writel_relaxed(pll_div, pll->base + PLL_DIV);
+	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
+	writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
+
+	/* Wait for 5us according to fracn mode pll doc */
+	udelay(5);
+
+	/* Enable Powerup */
+	tmp |= POWERUP_MASK;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Wait Lock */
+	ret = clk_fracn_gppll_wait_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable output */
+	tmp |= CLKMUX_EN;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	ana_mfn = readl_relaxed(pll->base + PLL_STATUS);
+	ana_mfn = FIELD_GET(PLL_MFN_MASK, ana_mfn);
+
+	WARN(ana_mfn != rate->mfn, "ana_mfn != rate->mfn\n");
+
+	return 0;
+}
+
+static int clk_fracn_gppll_prepare(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+	if (val & POWERUP_MASK)
+		return 0;
+
+	val |= CLKMUX_BYPASS;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	val |= POWERUP_MASK;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	val |= CLKMUX_EN;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	ret = clk_fracn_gppll_wait_lock(pll);
+	if (ret)
+		return ret;
+
+	val &= ~CLKMUX_BYPASS;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	return 0;
+}
+
+static int clk_fracn_gppll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+
+	return (val & POWERUP_MASK) ? 1 : 0;
+}
+
+static void clk_fracn_gppll_unprepare(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+	val &= ~POWERUP_MASK;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+}
+
+static const struct clk_ops clk_fracn_gppll_ops = {
+	.prepare	= clk_fracn_gppll_prepare,
+	.unprepare	= clk_fracn_gppll_unprepare,
+	.is_prepared	= clk_fracn_gppll_is_prepared,
+	.recalc_rate	= clk_fracn_gppll_recalc_rate,
+	.round_rate	= clk_fracn_gppll_round_rate,
+	.set_rate	= clk_fracn_gppll_set_rate,
+};
+
+struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
+				   const struct imx_fracn_gppll_clk *pll_clk)
+{
+	struct clk_fracn_gppll *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = pll_clk->flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.ops = &clk_fracn_gppll_ops;
+
+	pll->base = base;
+	pll->hw.init = &init;
+	pll->rate_table = pll_clk->rate_table;
+	pll->rate_count = pll_clk->rate_count;
+
+	hw = &pll->hw;
+
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		pr_err("%s: failed to register pll %s %d\n", __func__, name, ret);
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(imx_clk_fracn_gppll);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 63eb7c53b123..a7cbbcd1a3f4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -72,6 +72,27 @@ extern struct imx_pll14xx_clk imx_1416x_pll;
 extern struct imx_pll14xx_clk imx_1443x_pll;
 extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 
+/* NOTE: Rate table should be kept sorted in descending order. */
+struct imx_fracn_gppll_rate_table {
+	unsigned int rate;
+	unsigned int mfi;
+	unsigned int mfn;
+	unsigned int mfd;
+	unsigned int rdiv;
+	unsigned int odiv;
+};
+
+struct imx_fracn_gppll_clk {
+	const struct imx_fracn_gppll_rate_table *rate_table;
+	int rate_count;
+	int flags;
+};
+
+struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
+				   const struct imx_fracn_gppll_clk *pll_clk);
+
+extern struct imx_fracn_gppll_clk imx_fracn_gppll;
+
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
 
-- 
2.25.1

