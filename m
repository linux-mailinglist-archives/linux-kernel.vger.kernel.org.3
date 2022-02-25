Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0804C3B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiBYBlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiBYBld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:41:33 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2DC28DDFC;
        Thu, 24 Feb 2022 17:41:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beDJz/82IkfSRBjLCHiFyyhkrJgfzeY5MKxBVeuwKGoQGbwT6LiAE9V7YrcoHdc4X0O/OhhuTlIgH9Ykm5QkBDB8ZqcD6VJHCf5hJKn4/VxbphwJJMeRBn2v30KauQZImiBGCwAc4VNj+PS3W/8027BTBDaHblOo6qnQf8GGR9yVwDYgqAlftae8kLcPpzzlZp3f4qxVt96N3djO8y24sdGZnrCYywmiCjnp7T9zJIpWvY6yNgyOjk1VQm3Rhyx1eH4Q/sVGhi26hIdcvVsuiJmsrtgTaKWUr2Z4ILScQQmbTe2AytUJ1LlIbAephmgz1roDUqJ6+cflyYfw9NtoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95IDiUFtvRZ0WigCxqiNnm/vDbrI1VwXxaIzhdy3oT0=;
 b=R1HHSgT2Wp7apZ8kvUr3hSOoCTOs/Eo8heQFRj69wkCRWWRIoJ5agExF5DoNabNADS1Jlq2breUSWCZYb66rGP9x3kH9c8gM14nUVsKjYo/jYO9/nL695BkoLGzPr5di3HfpnXTMzR8a2XU1lhF9uPBLf2Wutjzavh15PtJoAUhmiDCpwIAajgPWZSzs5g0iLazYoGq+0kQzw7UGJiifiwPapnLBbytaQVJ9L/yw+UdD1Eixos9QulHKK8Ook/e334LybSJOJJUTBafCoiFgkL2cra1U5Oum0rE7y7ND3hnZLsG1cB5pqZLhHPo00BPBqxuGGBN+qjgQFHdFNJhLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95IDiUFtvRZ0WigCxqiNnm/vDbrI1VwXxaIzhdy3oT0=;
 b=HQc+a2tOuxtgkjiU4qZuK5c0XpZ+AVK9aBsqwRQfNtNwoDuY8+lS9RwpCpRpfm0pBhjGG2cyBGXAmnmYBSHYfJBcWK3bZuAEmtEK64L/AYCQ99fEWa5T7qxxfgkgBFRwC74RGrmQQQRiTGW/SgtsF9WzrSFgHKRbf4vJidQqoEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5316.eurprd04.prod.outlook.com (2603:10a6:208:d0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 01:40:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 01:40:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 3/5] clk: imx: add i.MX93 composite clk
Date:   Fri, 25 Feb 2022 09:42:32 +0800
Message-Id: <20220225014234.1766305-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dd1de25b-6fb1-427a-f4f5-08d9f7ffdf47
X-MS-TrafficTypeDiagnostic: AM0PR04MB5316:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB53167EA059D6CD8BEF2265D4C93E9@AM0PR04MB5316.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6q9w3d21M5XUTVOdkUPmEIHYRro2IRgW4OEcAyX/spx4Wr9TCs8cvieB4qn+5Mv0ZZD9luUx0sxH8ObQeiA3UH3wOqH5h2vpAgBWaq+1HPJMyFS0oftzHRvkX8QHiOODJbglYW8IFGmocx2auQ/PZ2bUPQ6BzFY0/lvW4zJoSPUTVCPEK+4TOVejHU6XCDjNnussF1smRWzhoCSt1tptXN8krI4iKShA3Im9tj2bZxdsazEa7x5x+X5rY2k66TLuFCMkrkrLpAHb9ILyNn9PVjvmRzXjTdxYiGewQ8W+ryyElLn0DwJT13/os5uU2im/2qc09XzrzciVo4VrDoW3Vp+RcRh2qzHnWNLpkFOVF8ohmqFk/gypQHPmpze2vT2XRmkzGiGd2GFvPUEUWvbynQmIT7H6Wt9fzikhX4/ulk0qRsP3mFCQTKCuJaIwTihxMGZbF1xzAuODAkWoeB16anL6FcycNJ28i65g5R6lRPyn7/zMPBKqmv0lDOycn4l9WjKznTzDfN3TQsoa/pcuaw4hwcflzFD9hGp6u5AVK6AK7xftqZUQqhrACjnHA78KbSxzjOXhtCwUyYfF+oY87AU2ZcBqZSXiJdBD4G85xkAR4gxsjl22GcTyzWnvNyRbCB463z7CCdGeHyOIicEs0I0KpMpLyyQJPZQ+0NzvUMHQ0wHdiSyWDUEsJASORrBLlHcxgNyoMJUlOuMdCtQigQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(38100700002)(83380400001)(38350700002)(6486002)(316002)(66946007)(5660300002)(7416002)(6512007)(6666004)(8676002)(86362001)(66476007)(66556008)(4326008)(52116002)(2906002)(2616005)(26005)(1076003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPYIE5iWIYKz5+IgvmPh6JdVerwtW9JaLjxk/RHmeZgDA0S67hCc1/sPzLao?=
 =?us-ascii?Q?ahmIPXVEZNjYimVCfEwiStbSQGf5uC3d3+0z8hqYiluHZ492p4iTAou4vurE?=
 =?us-ascii?Q?MbE4P7a8K3wX+7lICBAqpIEZg3sVuYunJCuwgnZJtUpgYvYP6TcqoYoRp3SI?=
 =?us-ascii?Q?VWoWn07HkhNwL4trEjmM8KSm3Za1yIiCRAm5AfB/hpfos9tv/Kpkxbagzz1A?=
 =?us-ascii?Q?rURzSTHOk6LA4vrA/sxxcDhaXCvIrjJWvkxrm+h2YM+cDS7BjmsG9EXB+Z4m?=
 =?us-ascii?Q?qFvJInLOKUDpAWAPyxRCguF86SulLDOIBhp41qHJpxIdr47afbDeT2iUd1fB?=
 =?us-ascii?Q?1vhdAhg3XSggOKx5UXt78V3gJYJhfrOkVR1u8uq0mE2dX8av7MZzSyrxXehP?=
 =?us-ascii?Q?zoizAei4XJeSMpIjH9xUuX+T7AdJZBzbx0oUFahjKqt+5UWBBJv8msx/LH3s?=
 =?us-ascii?Q?pR/0kv3gE9/GgekN89RODSnxb24dSs7fN4mCRSni9/YCN0b/MIB+t1VdZxY+?=
 =?us-ascii?Q?YUPnjUl3TzEm0Y98whb+bsVPB2fU298mFtmfI/xsfIkzI4PqQ/j3kLR7AxeW?=
 =?us-ascii?Q?nVhnfqukdPsQwXqfp7Dj7LyhIRdxN5ep/XIy+f+aYWxSUMKfvQzeN9+x9l+N?=
 =?us-ascii?Q?znttHmlZ1uSLV3r9ALG3i2gQu/L5hLBl6ULy9NJGM2BV9fHqHZrHs6H0KmbI?=
 =?us-ascii?Q?Hnv4o5UetfT7AWZ4LN9ulbnV0Mok9uaQULVlEbaFoxtmI+MqbTQcswJxL27f?=
 =?us-ascii?Q?7+GclSFwZE6KJaVpPhcvYQgR/kbhqR33mZQYM2B/hGEfXcAJ6H12uq+BUcq5?=
 =?us-ascii?Q?or/+NfYp4dviERFFPfscPlThuYZaVoGY47aSfvrB58NaRU4Jc5R/+v3VP9UD?=
 =?us-ascii?Q?3e2uUU9cgmFlgmJ7iljcJgDa14leF5NAOb2SprtGDkDsa0zWNVW8BCtBG2tP?=
 =?us-ascii?Q?lYwTibXhEeor78WG0Zqhp65+eAI4F5g8BiYFAi6uhtW3XQy+P0C1KDPsgiND?=
 =?us-ascii?Q?8o8+7e45xPUbIUvT+jSxhBuZPe7iowIESoaCcktvt/00o0bb69a1hexylIwX?=
 =?us-ascii?Q?PYpwApvoaNJeDtbloYkk8g/LILLAAC3uBcfQN6E2DO/mUELDzokyZoIALcDJ?=
 =?us-ascii?Q?fOtAhrHIpjfu81GR027imVPYkP8zsAKjZpt4F0iUCPEXihmXUiaZwFaAFbIm?=
 =?us-ascii?Q?cacLaS+/zHNNR6omqH0V7FR+JB5JB9iZuqh4C2PNjULhBgvh5D6D4xxG9mMT?=
 =?us-ascii?Q?GYRONXc4UmlRAInyTXEzv5PVl3ZovRn9Uyeh6m2e5DevhD5tjdS+eKDU23Xj?=
 =?us-ascii?Q?4WH6qQwXPufTbZsry2jnDLKDa7T7N2b4LkiLS4VFJdhx2u8YGrz4+BXuKyu8?=
 =?us-ascii?Q?ZNNMlO0SLk80z60LQHqzsvgz45z1p4XOLn8tK/QbXPdfvyuQLOXb0PY3QJFn?=
 =?us-ascii?Q?ZENt3CIsW9nqS5GuJ6Wh/RlIVzjeghv69tMl86PiUlILnSGnpaMMU4GkslQ+?=
 =?us-ascii?Q?+NsbBEe7bZBtXSRVZGTseHxU281pD2OylhW9ReJPDCkl87uI5TvMClhgKGzm?=
 =?us-ascii?Q?nn4rgTP0iHmDDjhl46x+ZJhD6BWEV8zW3pyJ3iGK35JpLIPSWUqXydH1KJGG?=
 =?us-ascii?Q?010hZRJDqo+KixPePGuH9Bo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1de25b-6fb1-427a-f4f5-08d9f7ffdf47
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 01:40:58.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmnYrb9rjjEzQzHfOSgxZDC2dUDvb7je73JJrQzjwZCQLdRfWUGVVHpIXeBoixE6bxOBgcWZblMwro3+aVpaMA==
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

i.MX93 CCM ROOT clock has a mux, gate and divider in one register, here
is to combine all these into one composite clk and simplify clk tree.
i.MX93 CCM is a new IP compared with i.MX8M, so introduce a new file.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Makefile           |  1 +
 drivers/clk/imx/clk-composite-93.c | 93 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h              |  9 +++
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite-93.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index aa8f5204d7e1..36c04922d789 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@ mxc-clk-objs += clk.o
 mxc-clk-objs += clk-busy.o
 mxc-clk-objs += clk-composite-7ulp.o
 mxc-clk-objs += clk-composite-8m.o
+mxc-clk-objs += clk-composite-93.o
 mxc-clk-objs += clk-cpu.o
 mxc-clk-objs += clk-divider-gate.o
 mxc-clk-objs += clk-fixup-div.o
diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
new file mode 100644
index 000000000000..b44619aa5ca5
--- /dev/null
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define CCM_DIV_SHIFT	0
+#define CCM_DIV_WIDTH	8
+#define CCM_MUX_SHIFT	8
+#define CCM_MUX_MASK	3
+#define CCM_OFF_SHIFT	24
+
+#define AUTHEN_OFFSET	0x30
+#define TZ_NS_SHIFT	9
+#define TZ_NS_MASK	BIT(9)
+
+struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *parent_names,
+					 int num_parents, void __iomem *reg,
+					 unsigned long flags)
+{
+	struct clk_hw *hw = ERR_PTR(-ENOMEM), *mux_hw;
+	struct clk_hw *div_hw, *gate_hw;
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	bool clk_ro = false;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto fail;
+
+	mux_hw = &mux->hw;
+	mux->reg = reg;
+	mux->shift = CCM_MUX_SHIFT;
+	mux->mask = CCM_MUX_MASK;
+	mux->lock = &imx_ccm_lock;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto fail;
+
+	div_hw = &div->hw;
+	div->reg = reg;
+	div->shift = CCM_DIV_SHIFT;
+	div->width = CCM_DIV_WIDTH;
+	div->lock = &imx_ccm_lock;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	if (!(readl(reg + AUTHEN_OFFSET) & TZ_NS_MASK))
+		clk_ro = true;
+
+	if (clk_ro) {
+		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+					       mux_hw, &clk_mux_ro_ops, div_hw,
+					       &clk_divider_ro_ops, NULL, NULL, flags);
+	} else {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			goto fail;
+
+		gate_hw = &gate->hw;
+		gate->reg = reg;
+		gate->bit_idx = CCM_OFF_SHIFT;
+		gate->lock = &imx_ccm_lock;
+		gate->flags = CLK_GATE_SET_TO_DISABLE;
+
+		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+					       mux_hw, &clk_mux_ops, div_hw,
+					       &clk_divider_ops, gate_hw,
+					       &clk_gate_ops, flags | CLK_SET_RATE_NO_REPARENT);
+	}
+
+	if (IS_ERR(hw))
+		goto fail;
+
+	return hw;
+
+fail:
+	kfree(gate);
+	kfree(div);
+	kfree(mux);
+	return ERR_CAST(hw);
+}
+EXPORT_SYMBOL_GPL(imx93_clk_composite_flags);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 7d220a01de1f..63eb7c53b123 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -419,6 +419,15 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 			IMX_COMPOSITE_FW_MANAGED, \
 			IMX_COMPOSITE_CLK_FLAGS_CRITICAL_GET_RATE_NO_CACHE)
 
+struct clk_hw *imx93_clk_composite_flags(const char *name,
+					 const char * const *parent_names,
+					 int num_parents,
+					 void __iomem *reg,
+					 unsigned long flags);
+#define imx93_clk_composite(name, parent_names, num_parents, reg) \
+	imx93_clk_composite_flags(name, parent_names, num_parents, reg, \
+				  CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
 struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
-- 
2.25.1

