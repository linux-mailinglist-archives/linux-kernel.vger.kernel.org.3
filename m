Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF65A59FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiH3Dag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiH3DaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:30:25 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10082.outbound.protection.outlook.com [40.107.1.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6963F2B;
        Mon, 29 Aug 2022 20:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVcw+ZHDbZq6C82xrSMkvXS+Tht3+91or1edCeuVMgOgxBsSbGkWQNbsqOFXTS3HLq7qXP5rBJhk2na696aEmFhEAZ28Q0ht7nVvl22Gb0G7V4YgoEabu2ZsPc5X5s+iciszbOA4tDFe73fIHY2+wSRRqcA4BSVftzNyzQWs6jnHLZbEVHv1YNVWHWAajgOsAkA2htZOl6hsNShrTPaGbtp7GfK0yG5yvDr55fC97bQZARz0aWnZbYpM+EEJHMgFgRXO4xVU3ILXJKEfKV05JmGL8+JK2fyQq9nwl4VsEkhx6WbIemwr9R52JD1zoczAHRzE7Y3fAFMAfg2ARvvn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx9I+YTeZ4i5ucTlp5yJ1mlYxQbkus0sTQKb/qFub5U=;
 b=JLs6CJirTby6V1SdtPkjqh/7DVEZYBqbNkKY49h9Oq83cTSdYHFqUUbI+0gQCj9j57g5O2W3WDdqGp+tIDdFAy5xDrtsDgFekUS0ucSOOCSwV3EHcRXGNKcRQt+Jr8kVqrLGPJcNL87z8yuIf5fYI41HjS8OADe1DccoPiRBzBzX8TXFRP1IKrVKm+AVU9d5qFh9I2B8RCkyRcpT9u6d+lYpgaCVfONSY06uiXNrYRElwy77gcWUjN5TwezJ84pONl5nu8EdFPOfEbjDHNKqcXa8FCiRlmZYWbWOJo7x0bawBvyubcJxNy6FfLoBkZc/2yICfTS9WWCoKBVGuhRWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx9I+YTeZ4i5ucTlp5yJ1mlYxQbkus0sTQKb/qFub5U=;
 b=kdGNj36NBa7Gil8IBlkJABRV1RSjxUejSy9cT8UQzpULgKckADLI0TwWGOrZ7jJ6YWXZVtqVnkyp20ukU0hss2vjl7uOWiI+KY3QB14LYHkaDmJbzPYr8GF6rzc6kFzGmv7flluyUuWevzYMhcah13pbd27WCzqaV9WXl9QT3eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 3/8] clk: imx: clk-composite-93: check slice busy
Date:   Tue, 30 Aug 2022 11:31:32 +0800
Message-Id: <20220830033137.4149542-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e1a4e93-0588-448c-58d4-08da8a37f536
X-MS-TrafficTypeDiagnostic: AS1PR04MB9359:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egy16PSJr7N7/oK/ge0rZoXHjzfSJ4+gZ4qZx92qeYgfDcU2nVA+L5yTmIP3VOwP4/IL4suzKEUVVE6WrzLZTCuCfYMbHFH9LDnl/at3ENRNZddZDGuvZtzeThpuiGyvyNHur4bbns+CedYAinzr2N3WGXelnMW1FOdAKex/T9ZoaAnWrdMB7VzGq6K89SlCv9qMioQQ4IiKgvkKl6ywmCm0cwE41zX/ADRQz60FdpC9vlsjm3UZO0la39tcCm2x17PU2eHEmVruB+7xXPDxgxvUPi2jWm6fzIX0374mhcKW2EKnCsjWxNZxSpBuo2jSa4MNLRae1HWdWTV5mWwuxvOg/HXTDf8v5TAO0afoqjqHU1zD1M2eWKq4QDRlh3KQJwRq426qyFWfsuwnoRUFnFs5vnNyMTFonNRVRXfrrFgZhsccKWRj4jNTKxAHzH3CoBLc9zUNY73nYwSetN4AAUlqqdBIFgIM066RubRi7bpDNcqH5OMhLWBxvZavpPrTAIoIsYJx2NB5mjoJzr0cPud9lxFea4DBeKO2yTU5ZJCzidI5VidcadsbHo1eijmyNL6kwWjz2uJGbrlRdjQef28RHO1YC6QKOxnzZlXO23GctXvz3BgDs+271AnS0kMb3v3zYZx3PQ8+epuS1kPRRmlBV9cEK3NW/NLPoqWpXFzuPkupL4yqYbgiJtZRiwdlTRjCwaQACSu0c6UdIRDwbF3NAghItIM4eIjcS30WOOd2CKhnMLFpVSrOekNvfd3uNy6ZLSwBUN3zSi+wqMIXUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(8676002)(4326008)(66946007)(66556008)(38350700002)(38100700002)(86362001)(83380400001)(186003)(41300700001)(1076003)(7416002)(478600001)(6506007)(26005)(6666004)(6512007)(66476007)(2616005)(2906002)(54906003)(316002)(52116002)(5660300002)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kh6rSZ00ZldLB70lE/zX4WYlzvw2zDQ8es5u2dblg/CDhorq4ehpHQRLqnl1?=
 =?us-ascii?Q?o81Xl/Syq6y7bIWNaS6mlrrUb1zfZMWkjKkKCuhcSfdu89IpBJBAev7Oq2y1?=
 =?us-ascii?Q?PWHZiLYb1m3M0jGs6c9CaS7lPeFK1q6k7PizTXwct83TivNTKjW7en/upzBY?=
 =?us-ascii?Q?AHk/Eddz7a54cLrCNFFkNGdJqv5vOLddrmqUUv4uC2ra1wUYneiD0MilEwBj?=
 =?us-ascii?Q?p3YlVVhQ7Y8EsAt2lNTobUVF1Ydpv8FyodYc8rf6MIrimwILpaQmIyb59ZHE?=
 =?us-ascii?Q?XOaTmLgZTaSpVSe3ZjFzLS4l5olOYONh+/2z82WDtsSq80QX062en+12kFs9?=
 =?us-ascii?Q?60P4Vg4yAt6Uf2bzAHGLdQ8CMUyHhaFQmEFmRrdjU/8GUTthERh8T5K0HVdp?=
 =?us-ascii?Q?hpqKml8j1RBkQ+L7WEr5ugTUhElfLaNJTSdR6jH2aFWobtvbezgq3Ps/kKca?=
 =?us-ascii?Q?fM+rqBQfrPi0x+OOAH8m2ePYBwEkLjb2oL+/TQR5HDE48830uU6lyhgx/HHF?=
 =?us-ascii?Q?3bZlV5ihyrrdFomkS9oq0aT3vKPQ/+juR59fwJBqdg5h7hHS+HsfP/5pCPsV?=
 =?us-ascii?Q?EdDq+q1cq+KCM/gqVZR5q9S9/H2MO2ztz5pNbHRpRGaCTLZ9mYRs3X90tIl9?=
 =?us-ascii?Q?KOYZ9/tNF5FbZBkRERly9rp85pA4B0ZcxTXqS9h67lwPf/NcKd6IkVRWinvZ?=
 =?us-ascii?Q?A+ob+5Y4I/+4RXif0bKo8zP0Ddm6IuwTW90iCpVuN52tlc433VWggat/kRdF?=
 =?us-ascii?Q?JC++xQzNCgToQh3E+dCJjVzUc5qff3UuZ4Xc/SyK2GNjI0gQXys1rbC+3cM5?=
 =?us-ascii?Q?mmdte2BVmNEOrv75om3RRNB9+L44jauqoJDzRqNSL7sDG3Q/BMyXF79NYuaR?=
 =?us-ascii?Q?TfIbHM+zuaxge0wfiuxHxWLUHUF5dny+Eq+qQRsDcq4ys7gExKxCxrQGuO8q?=
 =?us-ascii?Q?za7+vqKHrN3VtzlZ/LffJei30RuHKIwI9C0y210eyb/pjtecpkU5WWLxTHf+?=
 =?us-ascii?Q?GpmoH59OgA/KHgPgI6jPdwztcvascgTS+TuUwQwxzX+ICzfMjk+xaZL4m221?=
 =?us-ascii?Q?/ULF01pNagrqIKvA2qO51p23t49/z2CcOpT0ouDA8u7foHdiwevMlgW/qABP?=
 =?us-ascii?Q?d2ZLObP9ZNlaNrAYM0HhHeJie1MaLmzwNku1VAXNZN/zeGfECdr0pp03NXkw?=
 =?us-ascii?Q?5LWb29YRpyYmjY/yrjf3hm9eNvrFlz1cH6qgv5Xwo1JkAQkFV6udcUM4rPgZ?=
 =?us-ascii?Q?Qp8ZlwE1DKXo+1IHXjV2h3K67qTD1Dqnp1B+zKDfZI27uWfLFBIw1ohB7m1k?=
 =?us-ascii?Q?83WVJCVT3YSZxfwaRhMfQbZY0JI3w4yZhxEvDwoO3xuwkipYBfAq6BtmAtq7?=
 =?us-ascii?Q?wFmUdDXm2898vye4IK6jD1s3PTkq4ZzFO80lxEveGZilXVwk5hb/I0uKTgZN?=
 =?us-ascii?Q?ZMsG8DXm4y0CibTVKa+3k/pBSBrpeui/KbpmS674lHw7VybP5+XeHaTRgP59?=
 =?us-ascii?Q?Lo3jcLHTTMRGKCFEAvk1A7Bw/9//fmojVpqw+5WSIO7/J8FWlLWvPARxFqmk?=
 =?us-ascii?Q?QFGagHfYGE8qtdNsFbJ7MxCAJsnO5E72nJUkDfGW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1a4e93-0588-448c-58d4-08da8a37f536
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:17.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWnGJ4erNo/kofbZaBNT08QwnhmIFC0RE/V+Hy6b1YH46rX60YQABrFyNZQfmbpGVJBQJ+HfWCt5CDgaO/P81Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 CCM ROOT STAT register has a SLICE_BUSY bit:
indication for clock generation logic is applying new setting.
0b - Clock generation logic is not busy.
1b - Clock generation logic is applying new setting.

So when set parent/rate/gate, need check this bit.

Introduce specific ops to do the work.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/imx/clk-composite-93.c | 163 ++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index b44619aa5ca5..19f4037e6cca 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -9,20 +9,176 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/slab.h>
 
 #include "clk.h"
 
+#define TIMEOUT_US	500U
+
 #define CCM_DIV_SHIFT	0
 #define CCM_DIV_WIDTH	8
 #define CCM_MUX_SHIFT	8
 #define CCM_MUX_MASK	3
 #define CCM_OFF_SHIFT	24
+#define CCM_BUSY_SHIFT	28
 
+#define STAT_OFFSET	0x4
 #define AUTHEN_OFFSET	0x30
 #define TZ_NS_SHIFT	9
 #define TZ_NS_MASK	BIT(9)
 
+static int imx93_clk_composite_wait_ready(struct clk_hw *hw, void __iomem *reg)
+{
+	int ret;
+	u32 val;
+
+	ret = readl_poll_timeout_atomic(reg + STAT_OFFSET, val, !(val & BIT(CCM_BUSY_SHIFT)),
+					0, TIMEOUT_US);
+	if (ret)
+		pr_err("Slice[%s] busy timeout\n", clk_hw_get_name(hw));
+
+	return ret;
+}
+
+static void imx93_clk_composite_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	unsigned long flags;
+	u32 reg;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+
+	reg = readl(gate->reg);
+
+	if (enable)
+		reg &= ~BIT(gate->bit_idx);
+	else
+		reg |= BIT(gate->bit_idx);
+
+	writel(reg, gate->reg);
+
+	imx93_clk_composite_wait_ready(hw, gate->reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static int imx93_clk_composite_gate_enable(struct clk_hw *hw)
+{
+	imx93_clk_composite_gate_endisable(hw, 1);
+
+	return 0;
+}
+
+static void imx93_clk_composite_gate_disable(struct clk_hw *hw)
+{
+	imx93_clk_composite_gate_endisable(hw, 0);
+}
+
+static const struct clk_ops imx93_clk_composite_gate_ops = {
+	.enable = imx93_clk_composite_gate_enable,
+	.disable = imx93_clk_composite_gate_disable,
+	.is_enabled = clk_gate_is_enabled,
+};
+
+static unsigned long
+imx93_clk_composite_divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	return clk_divider_ops.recalc_rate(hw, parent_rate);
+}
+
+static long
+imx93_clk_composite_divider_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
+{
+	return clk_divider_ops.round_rate(hw, rate, prate);
+}
+
+static int
+imx93_clk_composite_divider_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	return clk_divider_ops.determine_rate(hw, req);
+}
+
+static int imx93_clk_composite_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+						unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	int value;
+	unsigned long flags = 0;
+	u32 val;
+	int ret;
+
+	value = divider_get_val(rate, parent_rate, divider->table, divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+
+	val = readl(divider->reg);
+	val &= ~(clk_div_mask(divider->width) << divider->shift);
+	val |= (u32)value << divider->shift;
+	writel(val, divider->reg);
+
+	ret = imx93_clk_composite_wait_ready(hw, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops imx93_clk_composite_divider_ops = {
+	.recalc_rate = imx93_clk_composite_divider_recalc_rate,
+	.round_rate = imx93_clk_composite_divider_round_rate,
+	.determine_rate = imx93_clk_composite_divider_determine_rate,
+	.set_rate = imx93_clk_composite_divider_set_rate,
+};
+
+static u8 imx93_clk_composite_mux_get_parent(struct clk_hw *hw)
+{
+	return clk_mux_ops.get_parent(hw);
+}
+
+static int imx93_clk_composite_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val = clk_mux_index_to_val(mux->table, mux->flags, index);
+	unsigned long flags = 0;
+	u32 reg;
+	int ret;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	reg = readl(mux->reg);
+	reg &= ~(mux->mask << mux->shift);
+	val = val << mux->shift;
+	reg |= val;
+	writel(reg, mux->reg);
+
+	ret = imx93_clk_composite_wait_ready(hw, mux->reg);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+
+	return ret;
+}
+
+static int
+imx93_clk_composite_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	return clk_mux_ops.determine_rate(hw, req);
+}
+
+static const struct clk_ops imx93_clk_composite_mux_ops = {
+	.get_parent = imx93_clk_composite_mux_get_parent,
+	.set_parent = imx93_clk_composite_mux_set_parent,
+	.determine_rate = imx93_clk_composite_mux_determine_rate,
+};
+
 struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *parent_names,
 					 int num_parents, void __iomem *reg,
 					 unsigned long flags)
@@ -74,9 +230,10 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 		gate->flags = CLK_GATE_SET_TO_DISABLE;
 
 		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
-					       mux_hw, &clk_mux_ops, div_hw,
-					       &clk_divider_ops, gate_hw,
-					       &clk_gate_ops, flags | CLK_SET_RATE_NO_REPARENT);
+					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
+					       &imx93_clk_composite_divider_ops, gate_hw,
+					       &imx93_clk_composite_gate_ops,
+					       flags | CLK_SET_RATE_NO_REPARENT);
 	}
 
 	if (IS_ERR(hw))
-- 
2.37.1

