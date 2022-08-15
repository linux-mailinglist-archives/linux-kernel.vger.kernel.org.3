Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47CE592772
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbiHOB3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiHOB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB89E12ACF;
        Sun, 14 Aug 2022 18:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdQvnht9MjzeWCG9NFxO5nfIkdHvGxlHH9mmleivSGIrcKBCeNrD329bv+8jMgPk/adTt2eaBFsAObSds4oicdsSZeDTpDu0gVRHH1PWelG8hewTeCOQpeU7XMRhO62QlHvKbES0FE7zFkYBkfp/U+DIRueiXoABScBSL/qBQjO741J6oJUopUEkc7brzVgG2fi0sFJ5Bm+3Ksk6Ck02oshd+n/xxp2v6sF3WDBBHTnXIIiHC3hWPpktv26GsAfLKCpaiiX9M7GVnb/RlhJaH7JfdIT5H6/utdtzPehMhBZTfXhazA0Vp6zDMl/KRw2yPGNixCOgV7UO6T51gfNEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivgKUzjDKNEQ0r5X3TQv2v5Y8znbdxKl89Cf0P7ewYE=;
 b=mXjLICghd8yznXFrLnuyTic/Yitkhi13Gwvy1mLRIxRteCvS58xLaANzVs052EpDf0NUKniXmE8r8qPIMRopTcGXfrQZ1gdOHKPmJkgYTXTIxMEp0n8AZ/fbvu1mOAfsPxzQpTqzzI8uCBCwRr7tK9NH88hWwgDfS2pKVa0GHFty4IwpuRPf4eYEXqFCTyJwdwyv3y95JPKskOe74948uRn+CeJNP30MjEXZMC6+GItWsDrdpg+dzJa5xlTbvogbnNAW5Ga+mJCj8W776SclJ+mBNCsJ4WXnA9vp8pUK2NXx4b0y4sj7PG0UiGypHPCt2MeLUvRkvbYwWwaNSFAbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivgKUzjDKNEQ0r5X3TQv2v5Y8znbdxKl89Cf0P7ewYE=;
 b=gL9GrbaJcldKZzXLpBBALO97RsCUFjH/TmfBbBWGh85NH1z7kkP4CiWCBYWKSdPxLXrTUFucjEE6C/gp5SQCiyUXRWNf/K+4jsDSR3FW5lGzLFlRGfBUwiBpjU6DMISlAdFzSZvlgOiCTsjhxEINJhTc5WPKGhWnHu55zfKKm5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3734.eurprd04.prod.outlook.com (2603:10a6:209:1b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:29:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 3/8] clk: imx: clk-composite-93: check slice busy
Date:   Mon, 15 Aug 2022 09:30:34 +0800
Message-Id: <20220815013039.474970-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815013039.474970-1-peng.fan@oss.nxp.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f35a3eb5-8adf-4f7b-adbe-08da7e5d9467
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ri5GgJddhKxWchH490DnpSr6Ayd47xENYO97On1VKNoTBZG/RsJo9FXK0dCXeTkrQn0nh6J7J4Io19nR/5A3rw9oubVJoJJB7gN9jNo9dxeHaCZpLlrUk3WF6uXWMddTCZFdldNHSU6ZETg+joBgmLQZ6y0lBV6IXoGieeAEgbCsdcvDHsnw7vTDo3BxQry5E4oa5/9as/uAQNbXkAFruPjb0r4qlVAh5GdkYbfLi+fjaANnj9geqOlPYIBjPN4R/+jxUsjzYDPTIZUYV+LLavzxYYyZBrrNezM0nD0C13RAfkcV6EE7RbwFma8JS7OeRp4EwGKmtuOZ5BzwFePgYuT3cNoDRuP50zuYVR7XRfMOrdwv+8s6wm3MiyKrtG2WXUl5jkVqJTA/Z6ZelMP+Bm+LQooGVVCDbyi50/ncvSeIMEEw5KZ8+QZe1KvGvBXeLwmwz91La9jDsLuRge7KV7+eW0LnZZ4p+VVylEFHBOzluQTMHTBite1RvxtymA0Ga7hUmgc/9CG/TK5vFvkWRS7xr4aRHFvqeOgkVnsKA8Yn7xYqmBM3h3xfkFLkeK+c3IUfOjtkSe/F3khJDRSSVm+78O3037xMLYSBFGtjmBHVWoD+Tvp0RFTmKQ4H5ESUCeftz2PX/pRDr4nLxENNZKB14zFCGhk7PDpvTHE+4XDolZUKsVBo3kl+buAilfVX0UjVOiimvFzW5BH+gYIKv3FDVWQc3r/fLSZ1frHD10SyT6R7djPiQdzaMOthTuQC/SZwHhagENr1tufskI6+Swcd/N/U7/esj16SUF7lF+RP1Rvsjuw4CHMKECwXNnog
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(38350700002)(86362001)(52116002)(186003)(2616005)(26005)(83380400001)(6506007)(6512007)(1076003)(6666004)(6486002)(54906003)(41300700001)(478600001)(316002)(8936002)(5660300002)(7416002)(8676002)(66946007)(38100700002)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MnI5MHqNRAIbkPjE7pG1HAiFBTCUx4WLPfXsUDEMLRcAd4gci+sufVIUUsB6?=
 =?us-ascii?Q?1D8pgAxrGyVDcW1JVOEHbvFGWR2rw1CwJP/+7hPqZmIGM7hHEktwqZqXbKGv?=
 =?us-ascii?Q?bEAFjo2R2bxIJnEASJZRi9c3mdZX7Zawo4OlzViPeYFr9/TNLnzLu6yWW7rF?=
 =?us-ascii?Q?KgZh1tP2aGKS1VFBzf2OO2C56+0ULol5tyVPDU47Yj8CNvmtbHOUOYCziDKp?=
 =?us-ascii?Q?xXrG6KGgUVS2Pr+B5q5YZ/lTJxthOacFoNl5ByPAmKDMPLkD6PsJFLAw3nEu?=
 =?us-ascii?Q?aYeQRjQcxGg+A39647ntEW0pPhq+r/ay2PoCTVrF8C6XEtDtR/3CearLOhfA?=
 =?us-ascii?Q?joWlmFVWgTUD5FRLIZt4jipEGE5dSGkU/PwvP6Cnhqpo1MZ/SY1YBRXBv2PW?=
 =?us-ascii?Q?9TTsl8DSoitYpahIXLZF+psdBu7HdmZBRn+ES7E8LYZXg5Pk3kTJmW0fN+QN?=
 =?us-ascii?Q?wfPbiwG1zc3WZdvWr2RimeJsIHnjcrb4VrQN0JLYWueMWQnmTQ4VffKC5meM?=
 =?us-ascii?Q?NmaFtqsGfJhio15NTAo//jffdfxtUbseArO1qicTIZnnXDhoRx7ZUia8qxU9?=
 =?us-ascii?Q?Mhr2ON7UWXVxvtEC0VZlo22rd4jKqhbaQlcAd3Er4lgfN72dH5tG1FaJ23WI?=
 =?us-ascii?Q?Q0yi7+PvAhjVje2aNH0xZ13Vk9iG14pMvh9ovvN/TREvmT7x2714FMeTrRKO?=
 =?us-ascii?Q?iB4F3FunAy6T4t4JBXSN45sd49OYOTFwfUyjvPbp/v0GI8vcjYj/r2WRnvay?=
 =?us-ascii?Q?gIbtc/ADVK0Yi0l6DW4+J0PMIxySVA9tNfn3QjnG6Zongn2ViUVjW8UW2OsH?=
 =?us-ascii?Q?Nq+iwTFeeW4+tR9Mn9Xqr7JU93aM4lcHvY0k6EotqNhlicpHdzyb8SuQfoRO?=
 =?us-ascii?Q?WT51ucujFznIoStjOZErR1RdQhMyTE7IS+VljcbkkRrhN8i/d0MvyxO+c13j?=
 =?us-ascii?Q?c6Gg8F+5leUFGmcZQQchvpbIoMMdCVd+1xSz/lPSZve4NbC/BSiZnLecsu6H?=
 =?us-ascii?Q?n4I9lYDVgG7pQdIfDhY86MhRLjX4DzBBrj5e8wriNELY1xGpRceFjxbs0949?=
 =?us-ascii?Q?OKybl6YN6trcBkL04X6vRcdAEsJXuTPPgfb8hQiohUBVVTPwD/iWzog8UuZB?=
 =?us-ascii?Q?39UAd01+OzGftAEVI22933H/LXMB3KUyF6xyvm1QaKsg3O8SCmIQ3wY+niaI?=
 =?us-ascii?Q?/4CHAjw5y6Bn33yqtQQj/0/1ra17TKzj/UWtUF93xjsiyPcJsJdORcA09imR?=
 =?us-ascii?Q?wHDFq29K0fFOKB9weP/Ror60/0+BpHWchbAB1Lpci2+gdFKW0ySXuIi7AAk7?=
 =?us-ascii?Q?BB0lypT+1KW7z0sBOFZrHfswEyKIh0WXR2x3WnbZZ4gtblM59swfOHgZOV1x?=
 =?us-ascii?Q?BtXW5ig9+mlzWxKqTBkx/FQiRe0oFWeHm6RJ+VThDyC/N7VFIR31hP8e5tRJ?=
 =?us-ascii?Q?/c9JMrZ+4fPux8uaX+r/bMJpHbLUBtk08kDHNivHxFwhNZvhz8tm+7BXjARE?=
 =?us-ascii?Q?jr1LPSb1WJE3N3DNv4SVXeVsWJz4sfnZEuALQaFWZoWryLnIEHisS+kQungD?=
 =?us-ascii?Q?1F1QJvKSNmzRim80ZFTySJVvplKJ7P2UyyIJnorq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35a3eb5-8adf-4f7b-adbe-08da7e5d9467
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:21.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92PacVlsQEUlTu2q7STVnt/d9KIFf0/jnZtRQKwp4vSI2+wmbvs5AdgLBCHi328ONHNp925kTYZf2LatHXUXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
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

