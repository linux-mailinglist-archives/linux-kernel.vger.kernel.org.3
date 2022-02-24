Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E858E4C25CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiBXIWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiBXIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:22:05 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B693A26F4D5;
        Thu, 24 Feb 2022 00:21:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwUxORNlbr20fX7gmQc79+V8M56mrchb6SJvL8k9NobFJAAADOLN6aR/4dZPj+Kcma64H1bfh5/MNNRbqFsQMEjFmtNoWuENRcJ/s5ZfeAO9LVUUREF5rKUPPgHMpEZqoQPgsAyZNhkYEIhAQlUSaPuh8LJSZ0at9U3D8KX1seMUaaos8IwIIpjhptmz0NN0yywmBBVxHXcm61U3AE8IN1MzJzEB82LNEjDs51zaZywAAT6nsK0H4ckAHG7JKLCqdEADDk4w1hUeoxWZOMHjnPrhgzZqt2MNwU8iFgUktuaCjVQKPnWV6ANWC67mUxJT4hqk8Hlc/G+nDBZPpP1hoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KPWKLxGJItY6l7DuJQcCdGN1UwPVBjhDIjziAXHgY0=;
 b=GIMgqmOXqdTDpzZzMaw2xxaN89+v3/MtRnaro9dbCSA7+gpDUyFLmeHWFmcNu0RIoCPegJ95GrtXgB1SObZyS/OSgONnAOOkmYGZryVQK8aCx5qtx7RjrHK4a7C9Cr4t2BF6m13+e8sbJVPoJgQENUV5Pm947b5GvjVVjuDyXNqTIwP76dHPXfhTRRR6bUqRyQxC1ld7LVvquyctHGYktXxIHbBh8oN5mrfRIRf0RYna5lB0gs2u7LeUDQIK/xHGrIN7uIYPyiDTmqvAo/aut5IyHDwa/Ex4YAyJtTus1ju0T3QII2kyqvvn+Amgh3O74KDrvQ0bZ407iPkliWtrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KPWKLxGJItY6l7DuJQcCdGN1UwPVBjhDIjziAXHgY0=;
 b=RiD2PcrK0dPmpI3Cbs9lCDlboB4u/CQQQ89PYqT0exc3Byc6E9rZbQ8362tw2erA41jyijhPV3Iik5eP3M8O3hqyIo6sMICF0qR5S17ZviycpJj4iosEbw9w3uy3ZYjeZwJ98XQvrY5T0W7yzdd4JBU2n/ZEFeLXLuy5VFlZq4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6423.eurprd04.prod.outlook.com (2603:10a6:20b:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 08:21:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 08:21:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/5] clk: imx: support fracn gppll
Date:   Thu, 24 Feb 2022 16:22:50 +0800
Message-Id: <20220224082251.1397754-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
References: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0147.apcprd06.prod.outlook.com
 (2603:1096:1:1f::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd3ab2d-54ea-4f14-e400-08d9f76ea5e6
X-MS-TrafficTypeDiagnostic: AM6PR04MB6423:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB64235C5888F27499B7003E36C93D9@AM6PR04MB6423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbWwnxN66NWA54FCjFRrzlebg84YSO5GwV+4+tavurO2vC9qPebvHdvRbErPc9frZ/ouzVh7KPho8EKf4hNdly6BgUKRIv0jGxlTrdawd4RAs1MKKEg5Yp2pf/KgVfIy7B7xiOGuKgJhKKmb+DjEDiHjrRsnfyX8K5N5NqY2MmX7WDVIQWiGgnfzkKGKD6OGPIqji/y+mfPN/cTe7h9Baz2V4bCMDBzjp3+qzKwNARM7/5f0sXL3TqWv3wg4XzSPK8kd4I1NVFS6hsgelz2WCH5Da9ZqeDCOyHwRP6revvoqInc7DodvxiVUufuxvHK06J5nUaJPPUjGqtg6zNd6dzcX2AFAl/Hbn53r3tQ0pY/3oyHmi+mH2FTS0fLXr8x7OLOjLof3rsuQMTFjj0BxvXfGsOoRk78ksC5SZ/PhziboljjmO1Syc76eDV/ZB23SwNOWwOa3DUbOfS4md/x7Hvd3jLK51K7Y/4u7FbLZoRzvSHSymJPI5g7n3hLlyLN8C7cH7Z6N3pCtomtItrsapALXE4HZjsKe+QJ+V6t0r4K6KQsk3GvrmaYZ8d13MdokP+/8qcwl4RxlEYKQf17uT7XQCEWE6kn1QLGIT/kKEghu2xHPPkjOHaIfWBuZU4WZH+zOw2/4WHYm9ZplCmmTKTKZ5NPPHMnqyo3A2eGmPdGlIK66y58x+rv66z3vmZIwhLtnEhocpkUTQKeQDbCjnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(1076003)(6486002)(186003)(5660300002)(508600001)(6666004)(4326008)(26005)(6512007)(8676002)(30864003)(7416002)(6506007)(52116002)(8936002)(66476007)(38350700002)(38100700002)(2616005)(86362001)(2906002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jyPo/uLqRBzEiO7Ge033YsA50mYBWcjxvbzBRKJk7BV88WOfXf+1JWPedO8S?=
 =?us-ascii?Q?c1gt6LdnPNZPenqRAU3J/pFM8LuVzI1IfmyOMJiqr5tpRHMviMr+/mlZTSb1?=
 =?us-ascii?Q?vJS6TGTmY53P0jE+T2HUEyJQTJBVPNJdLa/dKHC9y6bBY/uANiUv2rqMiye7?=
 =?us-ascii?Q?4DDWnrgIMd43fZP2SveT9UFp9G48VqicvHUTrzfIbAkqn+WI//fyp//dVlBy?=
 =?us-ascii?Q?5gdi3wCd4j5UkT3e9WaK/aQQ2Zkd4pQpiR6HbYX7bC414oHoQO/cz4TCdtVc?=
 =?us-ascii?Q?pWqdsm3fUNjKXJjfyC99nGZAUd2lGNB99PrdUGq96A67ZN0lAWiXnOxnQlqo?=
 =?us-ascii?Q?yrFAWGCy5JJkSZmAZi3+Zwqt3mVW6cjXg9jSazVe5DZe/LhrYRzz90f29wYZ?=
 =?us-ascii?Q?yhcng7XbOo74/KfuRFmSLGzZyghPdUvHuiwWarQ6T7V+wWXGFNr+MDduT02J?=
 =?us-ascii?Q?ND2DnhRbYI/ezuk9axh3Gq4OSNpgNhqhkL8LI4FHdBSFhAId9t6SXqxZ2KrN?=
 =?us-ascii?Q?FKsMzgOlwZPeb82Gza2WE2ARdggJsVKjx/07CwvZsW9wU9/wcl1oUCCfdH+o?=
 =?us-ascii?Q?5ZPpVoyB207JuBIHThe+hN96LhIdQ2DOcmm4L36ZshWbc8GKyqhuMYbKnWdE?=
 =?us-ascii?Q?KC6RNp/knTniz+5NxwSfd10hqWc1buJMKkhwuuCjaWvpPuebHh1Ct/ivirXq?=
 =?us-ascii?Q?GSnAlQ4Pq2cFxPkog3ALpZ/WeKjnyavzfjom6/z1xF5eZwlyKLgyCf4P5Tay?=
 =?us-ascii?Q?LAlesT0OGC9BV2XVx4IrtAH42JRGV9iufF3vOd06CtXMxOXkK4e3byBbdu95?=
 =?us-ascii?Q?TwiARlQI0gEhnc2SQ6yxI+4TmmFYKFmvVmHNF3AZMhvqA474xdg2OVUh9XAe?=
 =?us-ascii?Q?UzY2Gm3Jtkv7dt6QdVpa1uWu9uicELWboiyLu1J4c2NeD8iEBCVC9xCG9zdv?=
 =?us-ascii?Q?c2j7NQP+CYeFyYxAmZV0SECaCe9irQJVHKWNQMD52J/XDdK7nSb31vqJVSF4?=
 =?us-ascii?Q?Oe6EHBL9zhTfLm9i9xS8d02RFy8Jw6Yr8iedp0y4cUrNMbHzPaA9KOavHH9a?=
 =?us-ascii?Q?J8DPZYdNz4HimYnHUzpSYgayWq3WnI7U46BPTe5kolcvyKyHqq8mi1VDXp8x?=
 =?us-ascii?Q?4IaiMNfUz7iXoMFwIUA1zAEoKAe0kkGN6ZFN1Lz3WeuY0uVdBFmRuI4aYVpL?=
 =?us-ascii?Q?RGprsMrhQfWFhr7GC7nMiA4n/qwORRhqOvPdELypIJKt32kDnK+3VSaZPpeq?=
 =?us-ascii?Q?0wFejJ5ScGPkJY5fbCHBktphiqPTDD51svHSiQcy1koT/Fy8YqYCWqQc0uKc?=
 =?us-ascii?Q?T7cXazLbcKc0w2E/Iq7FDCTFhcqjCijU7vIM8Vb2zM1eQchLVnF3zHzEfOnD?=
 =?us-ascii?Q?bqnX08kF+9mBtHKDcBhuh1atWs3g0QrxJ+cAjCT+vuyBO5w20sJti8SGbnls?=
 =?us-ascii?Q?nSCCK54wfLUDfg69TXcvPJ8vITcH8QuYkuCMiQ5A3PW2q3UoqRysGY4CIeTU?=
 =?us-ascii?Q?AXu9xUge2ckYvgUzYDf/y79mEbeWMIn6waDF1Jg11iz2b3c4o02jAUChvqDS?=
 =?us-ascii?Q?Jr+GOxfWwo5LBhsuNO5F44K5fIOH1L/D+/Edq4jjvt+rvk76pIWU8xOZwu4H?=
 =?us-ascii?Q?3QC7pJsf0JZShSsCQ8zeZEg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd3ab2d-54ea-4f14-e400-08d9f76ea5e6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 08:21:25.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX3+K9kLIOFazCGOoUrRteANF3VJi5grPFczLYC94z4ylqI4TN2IOB8wTaXvejX/kYWUsxmyh24bebGRNb55jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6423
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
 drivers/clk/imx/clk-fracn-gppll.c | 326 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h             |  21 ++
 3 files changed, 348 insertions(+)
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
index 000000000000..b6add3a2e472
--- /dev/null
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -0,0 +1,326 @@
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
+#define PLL_MFN_SHIFT		2
+
+#define PLL_DENOMINATOR		0x50
+#define PLL_MFD_MASK		GENMASK(29, 0)
+
+#define PLL_DIV			0x60
+#define PLL_MFI_MASK		GENMASK(24, 16)
+#define PLL_MFI_SHIFT		16
+#define PLL_RDIV_MASK		GENMASK(15, 13)
+#define PLL_RDIV_SHIFT		13
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
+	writel_relaxed(rate->mfn << PLL_MFN_SHIFT, pll->base + PLL_NUMERATOR);
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
+	ana_mfn = (readl_relaxed(pll->base + PLL_STATUS) & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
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

