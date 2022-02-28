Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEFE4C60CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiB1CIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiB1CIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:08:20 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D14812778;
        Sun, 27 Feb 2022 18:07:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA/T3zlmqUfxy1pxdk5KaFTupsmmaY4kgi69FFFLcKIK+CPIYugZ29Vp4aszDNXqXrCH83VAMy8IMWHEsEMXzB881/EkvVAk9TKldw84P5ohgvOsBGNr4NGJFgN+MltEouYWASIVQ0YIRe3kQG6CLZqPjv8AjLpVHV8tbTrlieGw8jvA9hmPBjPemM1Gfto+zXlqE4StYFFYKXhD0Ej/WmmUmvxVKii4aICCEbTyRxKb71pHReHmy0Y/Bh2QBqqfbz6JlXH0AdCrlf4jwcYpBLxNt30RCg5YzwSDkf4qP0d47rpCE+EgQ+69brgT/O28ufP81znfk0proBUb3q8OTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7ujGCJMgvwG8xnLQHSLuzB9tKsxtRmW8CN/sPbqi4Q=;
 b=GO5I7AxCghcH/aXYO7nKPesYk/qbJ5HbF2XfJyBejxTZ3RjG3HSrWCZb0NMRYFv8Oxt23Aqy6HPyRHfRhtlmdkjgE33HijOeqTJTmcYwTUiVwDrPGz12d8K2yuRILt5t3mkpnNOQFUvjyhWgUGSgD5E+l5JwNS+/ffVp2P/xPtW3pd7uKluDbGpy9Cx3W1w6MadnLNFGlCNVPT3vtY/YTJl5iBRLn39ohunL6s56Wzz680LPY5kdOGOKTpdjNWzsL0vICzYCRI0SEqR0QWpfqZQRB781lDCaAGnPNEUu0lVwPVX6VQhB2pgT8kcDWnaJiix79jiAHYsucpbIp/KXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7ujGCJMgvwG8xnLQHSLuzB9tKsxtRmW8CN/sPbqi4Q=;
 b=XOYGAQA5jw7k+yH2tk9EPtJuzPqHYKBQ7i+jIOYEHDEVBceL/BZDJELrF+1717gcFtErzd8vA+76jd+bHl9Xb1v40fBk9ViYI9AhXLKTNxXiSDf5q9Jv//W4QeO1Lb+qeX8tm9JRQWvHIuBUcja+nzSOW3+OE2VRmiBLPcqH82U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:07:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:07:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 4/5] clk: imx: support fracn gppll
Date:   Mon, 28 Feb 2022 10:09:07 +0800
Message-Id: <20220228020908.2810346-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
References: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4097dc96-bac7-4349-57c8-08d9fa5f154f
X-MS-TrafficTypeDiagnostic: PAXPR04MB8734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8734BF8A055C145FDED0B175C9019@PAXPR04MB8734.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9vDP6rBn7v4iZI3nVWlaPEJZOmQFdNDAIikIM+oLgXYog8MgRxkMA+74VDpNb49GcB1oFSIW5f5U+E7d1ywi6CbXGjVGv+1OVrd8aJr6BkJbTcuJekBILJvUmkuMU2CExt21LfVv0AAckoWBNafynDOgZxydOmIu++f9M4Asrq9ef3CO66T2z6hB/gai7RdFYBpP9XI4EiNgytQ7mOjN9kPZV+M7JG3A0O4z7DoI14Vg94AjFC4r/cZ2U10sCDZk9A+x2QHjMoIRfqb9Ayy9/cyfFDPvAlYThNIpOrgvtEakx88DD673PXVT/uk0UIJdMT6QPc2gDvl9X8Gg8wYDWgdr67eN91su3i/ROxs9AAZ0D3/BppYF6oVkmchbZmo4wqHm66O8+4xgL6NcicExRSYHhfwPLvQ0vZy0nh8/uDVwUG9lLUlGsbpJjQAmCObhzrECN4+ZGyNGzLJxphQrmf/+QlnjRl+8LO6Cw46vma5+OUSHI3CAES0Sb4OLJoQhzbVloBhELPf2CJi+3YqYLQ1Gy0UPeyutQTK1s1RmdWqOwRX01YaaluKQFaQBCAZGD6TXfR0orUFmRvMQwhoUEb0dYgh+6hKMW6k/RBFOsZ88Ej11rDnqRBeq2MSQQjD0Ru1OUHbspWFaFFUmJJTD7nJuSD1qiajn/ff2GODiYICkZZDo4ER7PE4qDwyWfEorT5k09Su+jP14RvaTnQIsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(66946007)(7416002)(66556008)(1076003)(86362001)(83380400001)(4326008)(8936002)(508600001)(186003)(26005)(6486002)(6506007)(52116002)(8676002)(6666004)(38100700002)(38350700002)(30864003)(316002)(2906002)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5CH7bIC3Ip5y9eKqOwQ7mhGQ6Sn4qzLTKqMzEBZTYhJ1aWwQpSAMFNA3TA6?=
 =?us-ascii?Q?3NhhnIOd7fxCYJS0QE89mGeKXOWDp3AzLN5P4VEeJSEiMb/0KnZNIiesjan1?=
 =?us-ascii?Q?d++7RmJx7GuMJMJ1mKLe+dfGJCVKG6kpM46WZ9j09Gne2OfdRETD51OOi+5/?=
 =?us-ascii?Q?wHbHFcBJ/X9X4ykVba1eqpKfU8F79j0utOVuedPN4/YoP4vkIfgwU/mSm/Cy?=
 =?us-ascii?Q?MSdgq+M/5XhtK1zcF37y+9MqGnAC0dw9LN5Yl8sfyiVYgHe6PRUPR4qQXq9/?=
 =?us-ascii?Q?Dnxf4hy/EN0vXBjiX+2ff76K92rYDd7IzMrdr6WfzivuRqxNNe1g2r6NT7C2?=
 =?us-ascii?Q?z5pgx2jvNNw+afUNHqvN9AYjHmZzngFdcK/3SYpmgrDKbrqxkJQx6uKamxVP?=
 =?us-ascii?Q?S0lY+q/REPIMKGAf5rXH23L6+pLpGh/MsYnRcyhb/p1+2EhtAJNfAqzfT2WE?=
 =?us-ascii?Q?Ouw6lRI26qqexsL527Xc1yS8NU++PW6iFQ/kPBFIBD9D2SxOFDzbfMYkODJ0?=
 =?us-ascii?Q?nVM8eY3jNOHWxTAAaQMdLU7SrkpKgfYtA4YHr15hKzRjTtkTIQropvQQZhqz?=
 =?us-ascii?Q?Gl2GAr/7EHKNz8U2Q6YgmMr+cRUkT9qATjDJuCcwkuCGRz7D9L0ck1q6AtFD?=
 =?us-ascii?Q?ex/99j/Lu46Imsi4St9K8slAvzt7IQtl4JVu/yUeyMNd/1+kL21Oh1h3IwzA?=
 =?us-ascii?Q?fmJB1T2OWaoTx8YJTddTJA8hwRMkEou3Lmcy/+JfG78IY2xpfRyxfR+H93fl?=
 =?us-ascii?Q?RPwiDpNWJRboufWVLnsmcg04HccjpkkWXO1l3BCs6svKEyo2RgOeTTv9/GUm?=
 =?us-ascii?Q?Z7KJN8fgepXXUC64zEpA32HFQF1Weo/+n+RQmoZ1y01ECxrf1RZylwcYImI5?=
 =?us-ascii?Q?S10U2qo2YK5OZUh6Ysuac5izkHYsfGg3QTkOIECMCyYbs0kAj8YviT/P3V8R?=
 =?us-ascii?Q?+LAVQopxFR5gXrcRr1XmVSXo/k78On6mnf0qBpqDz4GUMppNhEkffrKJh/uq?=
 =?us-ascii?Q?h6mcxCurPdqZZbgiyOmAbINSXkZSu3fUN10Il3vwLRS92mOrbt0JyTJA5S/2?=
 =?us-ascii?Q?U8IF8JBS8XndPluhS6EUmCV6LaY6W2nmgdp4IR1PvQD3+RNhyqA/eai1aXh/?=
 =?us-ascii?Q?lTWawHVxnTUOzsuLjOUd+aCJ5VL+itIKsXFqVqEm0/2ObVVd+9n4leqj7XBC?=
 =?us-ascii?Q?FY3xGXUqNJWOZsFv2p2HCPqb1QVqeZFD8jItIW6t0QB0ajQ1JUFA3pGd+0jZ?=
 =?us-ascii?Q?Jh+B8eL0k4hgMuI5mL7t8gYdVCl9QGtOrEFNhjUdqUoST/I3Qi/XwJY/VEV8?=
 =?us-ascii?Q?YUoepHL3lyHPjLvH6xYIe6NcZwBpPp103iu1e1/f9hKzWRCgbaTG5do3kGSU?=
 =?us-ascii?Q?s5filMNgqPkRlEpq1iV5DfITMBy+XzVPSArw1+XINVUqqXOb51ZKnriLQfgt?=
 =?us-ascii?Q?hZhP/VaUkUyYZHUqwM26Cvq9+JGIACb4pNQY7xwsOvb42X6AJaNNFrENZIRy?=
 =?us-ascii?Q?33RVacv011utPDylV1lz8tDDHe/wR7u/oujSinr32ezbcoCdMtcfcFgLmwVL?=
 =?us-ascii?Q?qvGOLBQDwo5jYyJ/ojP0zT80A132FHBJboOKa8ih8HJWirOZUKsZkmG3Btxm?=
 =?us-ascii?Q?xpJDUpq9pv8CBMTykJSkM1o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4097dc96-bac7-4349-57c8-08d9fa5f154f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:07:33.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uimq56wnaveG8gqbRe87j+wqlAFrdGSFyx9dp9g3RNVT0gTpAyJJ4wk51hU2LNa+m+3cgYlAB1WPHdnC8X5f2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734
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
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Makefile          |   1 +
 drivers/clk/imx/clk-fracn-gppll.c | 323 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h             |  21 ++
 3 files changed, 345 insertions(+)
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
index 000000000000..71c102d950ab
--- /dev/null
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <asm/div64.h>
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

