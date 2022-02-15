Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0A94B65DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiBOIT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:19:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiBOITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:19:52 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30051.outbound.protection.outlook.com [40.107.3.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964489BBA6;
        Tue, 15 Feb 2022 00:19:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms+eD5+YlwrzOy+c8o09IgITu4jGY+t8KgLfm4owOI2gQsRzsuMMV0CI39mGB2WYSe5+Tba7e3Zlc0YZ+toJ2X+mH7XlzqH67gO2c5024JozI9bEqzcjKwTEGAjKzrdFc92H03iC5QSfrJt+SQ+OZZrxWucNZRZWjsL1MUh9Z/lXlG8MOZ99Tr9LriG2uQWe8cyueWdq8PMog1sSPX+AP6uJU8ERCFrG05yrgFzub6l5qapejPrgKug1wjUfm0TNfGiZi79YOh93iNkpg0+tWww7FWz4SLYnjx2grTp8mDgtiVfGjcL3X+Wv4291SKZOQjbt2UuVJ5dtRUX5B8IQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv7KBotc8BNY/uBI1+EuzJVScoAKf5ntuW9y8I47TmU=;
 b=KvahGoPGcKhbZjgWmMNNp6A1hnUJSYAwXhjgoOq6zf5HbEZYITOjEMK3nHzHe5T/T7obV2CtT7Hd9HzOGWDffGCcU0wUczy6TqTFEW01khU4pjvvjO/Whst8pcFEZioxVBzGT6V6M4fcYwK8zcmhOsZNCYqBgLIegls3s3M4rbySG0d5/CTl6/aQ4dw/arapGwCALDWpXNrH++X5beC6QVbX5NOsEyZYBoUi/VPQjVnhhqunkTlYlSSPZ+stZDsGEVk4e+W95oBSkGMk6E02mFjp2fXJTWi5s1V6TE/5ORWNDcpAeH7ZlG7etZkLccVuS1FRo+9FO5Ab8eEWiCG+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv7KBotc8BNY/uBI1+EuzJVScoAKf5ntuW9y8I47TmU=;
 b=O+517dypPFMzx69388Zja2frRzHtxTKTOW87rlpT18FzbXXJZGWsdHHOStwdfbnRhUA77pmgb+FnTUWwuMSY6MIjsbY1UgmHcXTplNMMrYhjvNH5KJ325y/Q0dgXcmdMlSqavgUhHSHQ9zsrrrxTP3ut6/GQkz4UuYWsFY99xkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5940.eurprd04.prod.outlook.com (2603:10a6:208:117::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 08:19:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:19:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] clk: imx: add i.MX93 composite clk
Date:   Tue, 15 Feb 2022 16:18:33 +0800
Message-Id: <20220215081835.790311-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215081835.790311-1-peng.fan@oss.nxp.com>
References: <20220215081835.790311-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9544e934-3b7b-4ba8-795d-08d9f05be906
X-MS-TrafficTypeDiagnostic: AM0PR04MB5940:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5940791F19ACECCF2B69FC96C9349@AM0PR04MB5940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIWkhvywty3j+D+0h0HJaaI2henXrrfEtt39RUo1KF687LInzBQtWUnsyN0GiVhy8t53bUA0eXK6bwzBv6vUM4iacJxooqOzqEEaZj+K1VU0qrXIDzTkzTJ0RCmG5sOkr8kFv2OZCi+ZoySAUy+6/2/CzIQzPObD7XsiqMcJngxSzJgVJnRGQTPh+AQqHwU020rJ5g/GeTFp/OXU7p7cpj2HfJotVsCs3QbGdApMRTD3ls3RcXhuHuTjD/rzpEf8vy5+9buIgI70J/yy+Ka4uykW2TMht9v70SMCzCrrM1dH9u6LBHpFP1rKfcpUqQsb6RFHao6XvqP02gBNTfRJPbgwX6IFaXveSHBipvTQ/X0YPHzhrJxXuOD8efIGZIJfjp+5Clw8XGcpCX5aeUzAvEphF/p4l7N8JY3joKRv32Vo5mGcA+/HJBlkhz03oJpcRG+wGW7J3od2iPCdMetReSDgZd2QguNTu0kCkyUGGD4BG3TXkmOxtH/If1L5eOW1yc0Gq/dcZtyXptvr/HjUgiL8M91FbD+/otxhlu7zVgyBrPvy1LOXQr1dXwMc7uuKgx3jYhidqsF4Ds4lRS+OmW/AJS64mWvYZ+wmTPH4I0Q4SMZayabA6ozOAHSj3XYb5AlnLtcPUWZ3YXJ5DI0ngOdjZ164MQAPLR407W9pj7O6fw7SMRqqVRX3o/Vuv9xH+9WbaiHhWlEncHE3vlYRYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(6486002)(26005)(83380400001)(5660300002)(1076003)(508600001)(86362001)(2616005)(6666004)(2906002)(38100700002)(66946007)(66556008)(8936002)(66476007)(4326008)(7416002)(6512007)(52116002)(8676002)(6506007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVcj2UlqiB+5f6QuV9HxWE3PGaGnxGNhpFZNzhfU3AWNXrz0YQt9aSPacthv?=
 =?us-ascii?Q?qL31+r7niUTS9cBS4mqz+gs1qoYeI1V7m9uiRdi2JUfT8wqgEI1yi5CmJJPO?=
 =?us-ascii?Q?JGdxJ0D4gN8j/bqjfo0x4TRm48Y00fu4ETPB1ysxXYvsh99bwLdWUOi6HYjT?=
 =?us-ascii?Q?z4RAHxRK/C1P37/Y4hWXT12f14vQtik+gA+5M8BPZiDkKBJ4C4EjGOBwRFB8?=
 =?us-ascii?Q?nZ+AhUpbPMGrCPHm5ofWr2ED6AD1N9NN14xHkGhkL3THlIHEKlQTdiFFzHqW?=
 =?us-ascii?Q?hCJlztaKGHBlo4pV7Irrs9NS927cy/eiwowgBvy2urbHyZlhYTFr3+FLTsAI?=
 =?us-ascii?Q?3BlcjAKuiZSbjsS7kucwbTbip3u7MMUpuHydJTQ+dlNOxlsIPP7OtJVqpmk1?=
 =?us-ascii?Q?eCqAlWcRT/k2nUDgYrcu5i85nzuD6aT4UZMkriBSjtugioe4KLmDpKVJpKhW?=
 =?us-ascii?Q?YqHtLZUuHw8Rle70A9jrXl8sbwWbJYwZdR8ScwJnqCdzxo3maPclt49TYdEi?=
 =?us-ascii?Q?xZ0Bugfe1fGcAmpvHUhu+mCFoUnIuWSrirwO7NXswYmGDDNhvhBv6Tis+c+U?=
 =?us-ascii?Q?uH8Pxwk1oBp4Byu74Jiaw43bchPVEZ2xf4punNtnvZAx57ZI+lkpUXMk/7b9?=
 =?us-ascii?Q?fa4fsCbuxui5BukuJTIaN7DskRq+jK9u3+zZ4MUEU45vehhQOXvI4gIN12Ju?=
 =?us-ascii?Q?pACth3lQF8sWBGF3hqB7A3tQM3NZbfm6fsItacyJgoaYjHUi9De+uOldFqZ1?=
 =?us-ascii?Q?u5SyGER9kqxLNCThKuav78HV+WiMP7frqHGsli5YNfWejppDUDw0MwJoRA/U?=
 =?us-ascii?Q?E86glNU96efUkgX3993/qmA3+Qoykun4+v9DNlb53GuqDkShhmMXfxcMTpyH?=
 =?us-ascii?Q?U4OqSFnI3BRMUVSQbl9/4IaXjEUZV1eObccrDpmGHfs4Chi48pNSEV7s8sik?=
 =?us-ascii?Q?+I+oJh8Z9rWrD3dhEEg3HknYTZAHa1nm7zxjxPC5RJ4reZjpeKC7muHBnQva?=
 =?us-ascii?Q?KezSN89+Ik28EVQOfeOztMpxnre0rUtQ+izjVbujtKXbYzsAIanaD8qTUHBU?=
 =?us-ascii?Q?1glxcP1o6E1EdrBRrEwWNY57OUIUtqhrZtBo25AO6EdubV0npsXW69IiWbLP?=
 =?us-ascii?Q?6KSr2H0UoohedIyghFnPqcnYBcb6AhTuJXWm9iJhxhHYmUXJRL3fG+pUNQ1T?=
 =?us-ascii?Q?d6wOwjDrvzdYtLRVf56OhUtq3Y9nGbl94CB/LTGdTu6ilj4MDTSxrtsRF7FS?=
 =?us-ascii?Q?/7nhfXPjmfp0DXlg3jn3d+udM6NcpuNxMWHMEImj0nrV3KN7zshO2WOpA3WR?=
 =?us-ascii?Q?HOsbL4joXkMzbFSIY6FbwPpaWg6zvhuUvpFndVFgSU2aH++wnIT/d7fPAXr4?=
 =?us-ascii?Q?fagoviLPLnOpVtePH6kd61PBw+LcTGzTNaN0+RFQH0d3uQMSbr2MxjS5uTXy?=
 =?us-ascii?Q?D7jXAix6YGUj35reZoqaoR3KQyBXJRYE8h8xhkKSUlSGikrVkHmY23zRNMyA?=
 =?us-ascii?Q?ke/1/kbnAe3PAvZOJafZS8VkcAOaIlWQkewWf5si/FesR/QC+aVTT2TRyxel?=
 =?us-ascii?Q?pRyk5ONbGfBKDaMuj71BugX4UmtILoGq50cu+Sti/X9G6zCmHRvMk4cWdcui?=
 =?us-ascii?Q?bVMW5gm2SYKAtTVL1TEtWo0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9544e934-3b7b-4ba8-795d-08d9f05be906
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:19:39.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnA2zoborvwgSfOsg3je4wlsZNBrzL17kIiQgauYuBeoyR+xQ7qp9Xi7p6g5WYS/7NDg3++eErQzzUqSz1VyIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5940
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
index b5e040026dfb..15549a1c332f 100644
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

