Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954A4C25C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiBXIWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiBXIVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:21:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02426A38A;
        Thu, 24 Feb 2022 00:21:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqlNwE97t88r8leaibAs4g0jEjlz2iqu5dcYXBBpGmYnQfo+Ow+FWdw+KTkum2QjAlltp8juFXcTHZFaIidWNp6PDsF+xlOeC7H09+1ow07MBDvMZatOlZbSJZprKZcOgbK+kdNtjVzkP6qbMDLmtd2QIenBQu9A6yFbXL+esGsr3216AcS7ciGp/Bzp57X5tyg6NOMwXX/YQFF9Kvw772RZVkwwALErHvRumYHN4ag3cosxvAUM4hNx1aV8iqms44wa7/+bvAnhQ97I6vZvkpXcQIo34PjWJNlcWL9Ju5ufgYSZ+YByhQ2AGAuUOgAeJF4APvCYv9iq1ytSWdyUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95IDiUFtvRZ0WigCxqiNnm/vDbrI1VwXxaIzhdy3oT0=;
 b=Wo1GWbJcB1N5sUfWpUUnieyITETAsWymZf7t5vqdoY8c74X8YtctT/Xi8lzMlB3NShTw1oYa7ebJCiC5XQfi293KQ+65e+Ypirm6ff4lm1aVd0RiRgJsT23nCJtIvG4ObSiP9ydbTQw342t1j9xbORJxc7BaP3DrpSZILTWxkv3eNXR7tkGVy4XM1J83lb/si0nym0a6vqnydOks24JgVVQOoZB4DHi/fkuEmyB99VHvtM/4zXsJ+5dRiSet2yINAdUCi2NYr/KbTustM9iTpRuwPAQL28uWZ6VCAWlS9j3otIKunpzpxf42eQHREWHf/R7Uaq0L+/VgWWIYmsgbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95IDiUFtvRZ0WigCxqiNnm/vDbrI1VwXxaIzhdy3oT0=;
 b=NXXCY27sxlZCxMxa7yfeAGpeb0ei0apfNHMceFtLZ3XYZaRFCnK5HX5ZBHvydBHhYzsT2/Q4UZA+lAF29br4G/3oRIhSuQaKImQVT7Q+PgCW8Hk+kJeFz8LI7RcpAyOb2tLkLG1eWu6APFfIuFC60f8HS0Nbmxr4Exmv9c2qHtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6423.eurprd04.prod.outlook.com (2603:10a6:20b:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 08:21:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 08:21:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/5] clk: imx: add i.MX93 composite clk
Date:   Thu, 24 Feb 2022 16:22:49 +0800
Message-Id: <20220224082251.1397754-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8af6ee14-81a2-4513-e79f-08d9f76ea37a
X-MS-TrafficTypeDiagnostic: AM6PR04MB6423:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6423C98BF1C125814E4D30B9C93D9@AM6PR04MB6423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+ViFgjlndINldLwWOedMN2jy8SfBmZzAjMWBI3ragpP2E8atXKIsUFLW/AdAQUZrA9qm4C7I7LWPh0nkGG9G40u1iFZiW8TNa4YZhxepi7wPQH61vQSaflyUVkcrXYzX1sEehsPhfrjmQtZ1QDifRkhrZzFTRD+cpca+zHGX+4rFRKPbxhbhJ8ivnehlZeV57HDR6LXpXVh0m1vZqZVauKCBW+M/8jpqNlDd1jaXIIsxGgEDz54IDE5QGV9s4T254BnLhLnBerinNEjNN8NkJrGBN4m9C5D4z0s02UJvOc+Jau0ESyb5mckdc1nzjmJjAqmXqSaOsaK/OJEyzt7xrqZIlt0lfpGY1lOfiNotRLHEnV0Itev+OSowwfp4ynMjOvpVzgnTFnnqnvmzzCpQHsHK9Usida4tuFaxVVacgwEgYb0HY/uEPsk1+T7ghQdwL1p7FOviaaQnabRJfTYqSYj8/UEdTn7sk6aR8AkgOQTFmcDsDOsWQb4fhukB1c5s5BtAQLU1n0bjuokxIklAxfMO/JJAl7AYmqkr/vnrhJ99x4ZEUQlt9DPQ4fRruFK3qN8IRHgJQbqw49P8Q6D312S6DwlBRtSiaJNP/d8gayuaH2ecf8fSRidlbEv75Dg86tnwD1hl3jbhnBbB63clqTfMYgtNdPqX5xBa7Yeoc+e0+j7L0F0ib2C7V8iLa6nhhILnCxCMgP0fB8OAaWLyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(1076003)(6486002)(186003)(5660300002)(508600001)(6666004)(4326008)(26005)(6512007)(8676002)(7416002)(6506007)(52116002)(8936002)(66476007)(38350700002)(38100700002)(2616005)(86362001)(2906002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d8gU/AslEsaFBqJHO1weZKY8CPUDqqBNnY91cT285go1fHF0RMsRfRkZC6l7?=
 =?us-ascii?Q?PtdQ40nkM5NNkoTfcJ+Dn1wJftObG1PakX/o83dlXjtLNSNDSRRbyRk436xh?=
 =?us-ascii?Q?5LImNibuwHjEQPwWqWTZHs7fVn6mqa2RVX9MvztWWWi676lR0Mcr+GsgwSFb?=
 =?us-ascii?Q?YNBqkJYvUjYqHvcYT48ymnBljrE2p15d/jNuxNjqBGTC9LISq6Qf7pwPDnwp?=
 =?us-ascii?Q?IZUzseTk1+5wi+Ke1syNkpJ30MBR1XAUgKd4Pjyr4ga5rm7I/uIevgPgWGQk?=
 =?us-ascii?Q?wMSOrNIxrwzld7MZerhxUWzUe3LDiXYU8Yf4CBwINzK8g+WK3K2aVQrTjFRJ?=
 =?us-ascii?Q?WdpXe0yQe4t0nIewF793vz7h7dzJGujvjHX4CEaMM7Lkzs0ulkbiWxuYBqyp?=
 =?us-ascii?Q?g50pxo0bWyELRSh7WE01BCA3u+mvtOQ0Z/1+cS0oFcSD9HrQMsdeg2ULamlZ?=
 =?us-ascii?Q?swnayhMqCD08lE2wVxsV5Nylah0f90xLNzJueuqBIaZUvvQM1j9dV0E6lQ1E?=
 =?us-ascii?Q?mFzZ5eeX2YzvIxjwDHL1kB5MnRbTf87crxMzAHKEbfCu5sTtlE14+3w38lfd?=
 =?us-ascii?Q?6UffP/15r6l7EkQXGnNV9VtEtUzqz/ljm+AwYEqqjQ2Dj/GLZxxTdhMcl6U1?=
 =?us-ascii?Q?0Venu3pMiWcOpcvoUNqRPHMdm1t2VhaHe+dJLmFN2mUxoPcEFnWRZb/3r9Tz?=
 =?us-ascii?Q?03KyLGxM7CjaI2wNdKcLXbr6sDcpBbH0siWWulqH8YgQBlSfshbe8kcmdbU1?=
 =?us-ascii?Q?VgdbwvxEWg/9ZnI7CYGOUo1WfSR4UjVrvt+G8duqiQYczKF9fuGEyd/b91PV?=
 =?us-ascii?Q?xQPEnzhONsQeIV/tGw3YLG9COxySMOV47ERh3nwDlLnfpyUANBSQzscp/y9k?=
 =?us-ascii?Q?xmFMIslMtx/kqcKH2tmFjkuZ83GXZEhfv3RdV6Eqgn4ENij3IolK/XIrhQvG?=
 =?us-ascii?Q?1729DSfVD+KC6b0DHTETZup9Ljp/19JUmt5Hc0yhAfGv3VQlPGSgP95ED99S?=
 =?us-ascii?Q?DoFcH8fyhzAOG2feKVS1zr/jM6kZClsb3xsVqIwugoQAEnNsxADHVVA0web1?=
 =?us-ascii?Q?kUpTcb+D6AhbMbKvvIG5gjc50DCo1DivrJEKck2L0p5KX6jG/P7Rqsy2LIWG?=
 =?us-ascii?Q?S4UnYT81qbZff/IPcWdd3gi0VY9NPnUxnbcaYE7E+kATYHKXKKqO9QJ1V5lG?=
 =?us-ascii?Q?TDDS1mRBU74nXVtJio3wCoGJT/DeQcpDfBYexAgKKjCJlrmHwGZ0R08Lnr1R?=
 =?us-ascii?Q?Yp07gMT+XwaZqr/CueoEkj2I5D9QvOtzRJVvHLVq3AVSsCIPGu67B0b3Bp6f?=
 =?us-ascii?Q?Kjdfw3WYRsertmLCa+rLoEssiQkmRgTKXeb0JjJm571VMdX09EdnrxQkVlbU?=
 =?us-ascii?Q?PwGJ2ZiKHKCj8YNheeljC93Wu256IbJwwO+8rrSpaVKfsn5kleYwbaDIoutK?=
 =?us-ascii?Q?gD1Gh6tfKBrfSa/d5z9kj9BupqnozvBQ5vJaOnV0vLIDvo3vnI01gYZ14SOm?=
 =?us-ascii?Q?KbmvUsH2CBfppWamWBL6peanW/pPss9kynfaAzR94V1mxx0gyhNiHtApMuX4?=
 =?us-ascii?Q?Yj1YWigCUNKwrZAMYQFmuGgFfoUnrApfPfzBME4nelxMm/ZqOlT8O/NqwukV?=
 =?us-ascii?Q?zsKQ/FVgCbP6zbtIvhh/lGQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af6ee14-81a2-4513-e79f-08d9f76ea37a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 08:21:21.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qG/QEjDBTZttiClgyLDZeEOnXN6YvzxqJrlLzmqLBgkALOyeLimfrCsvpSk0yUXr66yzJj2SXU+znB4uVBPJ1w==
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

