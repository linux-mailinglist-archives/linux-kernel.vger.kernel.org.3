Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307C4C0CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiBWGnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiBWGnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:43:00 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1446C6D879;
        Tue, 22 Feb 2022 22:42:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic5GAeKaPGAdQH8ZDato3tmH+uqCTwR9XivWMdByo7uK2Hux4l8OE0sKZ6//PJCNjDGGlUDpJqvaAfMyH8DGpKZqb6cQrewXb65lPLjZM0HFEBNOOCcPBv1OnJXTlIf4qHpM7YUg3s+EU3YLrChKKZtCFd/Ra+K7srSqobb6ZThEV/qqMIXT3XhpVon2Rg4squ9GmbrszuopckPcxhTmGhApwcB9f3ykxxVYXM4b0Q+wxSmRiXjToOj8sGlc6WYA31TTga1AKv+2WDYJj0aiOmkGb/K3N8WE42xH/OR3Y3kfjEU50TkWgdN0CmGu5fHl2KK7n5jWM7+T0WHvePOhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBo6xUQstTajzmmzasfrW8BSwcQhXzhAHn0emp2VY/I=;
 b=NJRPN4xg90rQfu17TpUL5UAubd0TmN+LJRjo0bxrFuT0eijblH+HMb2apuHUZ6uADyt2EFkpIxegcENGmQI1STJaNXNCg4YJ94VTbQD6KwzXjWDVXN7dQsEeXYQko4qcqYaxdjrPu7V++aJlBdD+ypLIegiWbfNlDdDEqlWw1ej8d7oIr9US/AFqcy018w8iIkNO65p9KeATvyXNg6oG1JWEKawLGfhDHPvJT83klNUHtc5Qyo1OoEjSA3cjkwIznUdElc3+DUWCQhw9WCmvD/VmF8NcOWRfepIgc0AhWpwGxihtA0rv2OA7zIMeP45nVsUjwFD1trt6/QgELHCSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBo6xUQstTajzmmzasfrW8BSwcQhXzhAHn0emp2VY/I=;
 b=EoRCo37VntLLzB0s2EftAETcJbShDnwvi//n7JGBS1ivZW2zpnsN1uwBmoqUOiZ+gjFlG960ENQIz9eKUQ2YXPxM+Lh/urixjtY7vV9ReTl1rgGyMo9RpNY5kpHdWZhe2JYJYYh60S10uvR6e/5ofLpZaHUd5aKYR+oXWRS/TtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5542.eurprd04.prod.outlook.com (2603:10a6:20b:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Wed, 23 Feb
 2022 06:42:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 06:42:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/5] clk: imx: add i.MX93 composite clk
Date:   Wed, 23 Feb 2022 14:43:56 +0800
Message-Id: <20220223064358.4097307-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0110.apcprd06.prod.outlook.com
 (2603:1096:1:1d::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6825710-869b-4f28-86ce-08d9f697a544
X-MS-TrafficTypeDiagnostic: AM6PR04MB5542:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5542ECC14D5E67A614625309C93C9@AM6PR04MB5542.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Du/3xNSL+mrnFvHu2ckcc6YzqrxmoHi99Wxp+IHpC4WO/RSehire9CUrv7K/wCNIbeZNiOqCroxIBZkJrcNIdh+B2ue3XBAw/mY5/1GNe/Et4HCKZKsFnzNPN7QiKQ/8D+AY5Ue4YJRxbIDuOai/eXcRxruyZpaFS8IB07TT3GKXyhaOiOaD5Svv8cx7y+zor7tFQIQgpebiUlgbiboMp96Itce06OL1cxo+Af46Ca4Op/+FT4mAxoeEjTUY1aNex12XtRQLOnJGeqUHfdYQa3/HxmlbyoyU1tS2rWSo7JEHZp2OwsjAIfqNWlRWjylkqWEMt3QZjns+NpdpI9KvqmlJrMqun/oRPGuoaVHbCNTQBBZcLuPr2ZfGWaTdOnKj+C3kS91ffMJJw7XIPOx0+YJwf0XRIaVG5Fbj8qdfcdE4gK8IDzwfOfxO6Gk2xlHesAXeJfhfxrWb7/2cb8EpltpmPGlezRRl+yq2lbBiTLK2kNi6CCFFexJgvTJkP1YH4I4xg6iWsjvQXeVTzM9dUjQKssu1stfwbxr8gBydi4smSjWUDMCp4BZ+QcNM6pXPo47bwZ8qMkK2l1AUv5zeJm7c27VGECCLttZF6CyYwMAXJxNBzaWl7eiMzqnhZwgy/3ornJ/8iDwJquCIeZxWk8fAD27kN5a2jucrMn64r5yWSESW011LG4hRdEh6Vc5bDkudwkeCWsfknRBhnnswFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(52116002)(4326008)(6666004)(66476007)(66556008)(1076003)(6506007)(66946007)(38350700002)(8676002)(186003)(2616005)(26005)(6512007)(508600001)(316002)(83380400001)(86362001)(8936002)(7416002)(6486002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0H+a35zYia3cdbmaBZE1zpY+FmKid3cjdK9XvC8ycf1vcSdk2/CiCiOGMiag?=
 =?us-ascii?Q?YrHdDmSr3L1JrQH4HTYCpPKoNLJZBN4POM7QB2DJCSQbA+69BdWKyOWdtgqn?=
 =?us-ascii?Q?w8i4rFpjEIDK8DSE/leinq8mh6TSrOJXnRi4nH1+vFlozJhXWbqUIz/v1bAs?=
 =?us-ascii?Q?Lnog4S7nJFKDEf3s1OanazkCHmNsDKdgGl0YjZLyZ0cCK/g5B6B8lz6MykAW?=
 =?us-ascii?Q?mg1yzom+EH+H91CoJZMV6EUuHL8MfiNgKGxGBZLiWnk1e1WCqtjmTEVRCzkH?=
 =?us-ascii?Q?254r39ufEd0cPJZbThWFAC7IhhSdxVmcVpv98l32v0f/acG5n9IkE+lUu1wd?=
 =?us-ascii?Q?5cRt3B2gvNPuVF2y9XgFi7oYUkJv3VUkZp4J5s+yYZVttvawQP5mob49uwLr?=
 =?us-ascii?Q?qmiFOzkqs5gjaeRWgWwL7XOR0nem6svixI+Tm1Prh50rMlJGI+iykvzr0Piq?=
 =?us-ascii?Q?lpRG+W4ay1NRAhjA3acgEcOL00dHOYEtUqmS0N/bDz3to3NORdX3a8DZnxQQ?=
 =?us-ascii?Q?rvGu6cN0v9+IZuALKYXaBMAfk1PKAjhMavxB1Rnvxnaf3H5CGHZGDpKbObF8?=
 =?us-ascii?Q?TJr/42iImaFYSey68C3nxXd0tvGcj7+sL1mcBicBbNSAOwRAdCtnL8OUuDIs?=
 =?us-ascii?Q?FMXsJ8Sv+MjVFGI9Uye5lnTv60MHpKuv+fSkZkGnRgn1giMu+1IUpc0vdiyA?=
 =?us-ascii?Q?hLyTFTFvvEWxiyRCD3SAF8iLw5fWpk8Rzd2oHzlPfsjkcyXG6lULfNdOt78U?=
 =?us-ascii?Q?EQeEnWQvXaZqN1+0KsRw/YbAUnKDfe2dstsQgLWLmefn9eAtkYV4Z1ZUh4wL?=
 =?us-ascii?Q?XNYQ6Vx/HahB6Cn4O9ifYg75r0ZoCW+yjCSqyYWS0E4wS4qJ48qi7JsDuvrv?=
 =?us-ascii?Q?0qaIwaiN61/troeKmS4weB/DUCjfpG2uSKC2vEyyWmaJ1XFiJzlWRBaM5uIk?=
 =?us-ascii?Q?B6BtDf6is5604WTfQkFe3hrVX3qd8rA0o2v5rcEqnV2UxT9TAHFLOk0HwP62?=
 =?us-ascii?Q?0xUxJ0N+j/aPe1zVbKaI9ElhCfOoAwc5k1hOjMsAR0eB+9A6rbAdJQMcr/5w?=
 =?us-ascii?Q?8i/f+1NVV7HHxOO/8uCrvNADhuc5TCCY2aadZtwrHcthcHqK38TmnCjYfi/G?=
 =?us-ascii?Q?AAcX0QQg2JRpJPjZdzUKBtEIknziq0gxGbqtJ1lqpwoVyTsoiG2QJDzWBs42?=
 =?us-ascii?Q?v+tpA7F9v4xZAUPFgvPZI/7nVImiizmhAYveHNKyLwtfdH3jc8y0fKHueI1m?=
 =?us-ascii?Q?nTg6RleFwjcEKXB/a36A2tE3VimEKAzLPij30DMku5cNRZ7Gm/Eb2oa1J2eO?=
 =?us-ascii?Q?BRiEfdP/jVwOuHqLv7qPBh7Hfmha8mQhLOs4Kdj0JBq1P0m38XUJaumlZPC8?=
 =?us-ascii?Q?gFNSToF2rFAIQe7j4LK0/+sIbmfnadtWt5AYVuDbPVe7IWENsVC44kswMxwE?=
 =?us-ascii?Q?28/p2oXzK7pAwjD2voDc9cO6LAEU95kwd6fZpEnTReWvkEd1Sl4/cU3KyCdM?=
 =?us-ascii?Q?HRTmzS+hdQiCYdY6dIMjZHiDw5qsJE7v1p+BUxUZ7T1vXmy+bRJRb0q5sdmn?=
 =?us-ascii?Q?Q1khGc4uLUFoERBNtIBqfmTyeIbWO/fC7aK49FTieQWNkLcCu/NfhYUkCrhC?=
 =?us-ascii?Q?s5yGktIz6LnFMX2qEXN+0WA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6825710-869b-4f28-86ce-08d9f697a544
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 06:42:22.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WMDlKWmLRGCmbVa0YOMDNCS9rgQDQbDx2r6QWOD34xSFTM5o5/XiB5rHY4tKQdhHmGOc1OMRInH/sAwwvxrjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5542
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

