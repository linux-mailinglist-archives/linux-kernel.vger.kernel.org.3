Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945A56D4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiGKGXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGKGXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:23:34 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33501C14;
        Sun, 10 Jul 2022 23:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYtxz/54D18NjOn2LV8SDvt4F9AiKjDHuWa+ikOI9QRR4X74XQGC9fbRjVOQIQSeWuMDjfXSmsBvIutHJUHIvQ0Li2JL7ld2T3wPIXaCgu9VSzSqiQpMOMrw3536oCI6/ZqOwXFtWW90DOc9Zl6nN041BW1tmzBIy8ootc0lWPbUxO/VEQHGQIsjLQD5CIEu3HXy+yLzQdTAGB0H4A6cK6h7ctrkDfBoJAcQ9XMLI3gyIk1ddh2WvzClra/bFvaBozMfactkaooHGru/rwtNlBJE8U0Iw3nMX9Egtvimv8GbUkE5/f1Is18KHfdGNSyYVnr+kZWRarbjMZ/ugzreLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S79pV74eJBAb7LbBVc7vkbPAG7WWTIoZohKoHg2Z1sc=;
 b=e5on1FbIn5cCIUv2/kiT3P6BkfqxAH7sdIkQxG56IKjvqQLVNErcjgLYr5HPSTZkoMKySeJg3qHvj9A7YjEFznKegPmf5HzWda1SWbMoGE8FVS/1MzTeSwb+IdNqxsQhdpLQ3i50fizQl1lm6kHo/2owbAFh7MrnGdpu3wAwgbRJLz3f6PD4yrqdCGqvj6gxq6UDM9JV8FKJREYeyMTAafRV3WXIgviGIyDACAp3FBsQmXzkK0/4bhlPX1Ty/UtdTBtvMOc2O9U/vpoiTQ/AN3EBxWiKcJwZByUwD+QZQnB061dpTw2Iq+qyutkJ/3pVNQMbNb35YOaFJFvimqTeCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S79pV74eJBAb7LbBVc7vkbPAG7WWTIoZohKoHg2Z1sc=;
 b=UNAaOR/ched6zHCT4LMnjm1OTkl6U6vZk+K2F8nbZt+V9BHmVOBf5v4kwnvjn4HtFasxESCdUE4eLEXwQTzZn81RYyFU0sG5wvuMFPswgYgy5E5aZJQG/+x2VxLEX9tvPIlW+ilqZpUlGjiP8S5CGQ38du04LydjuIb2Oh5u7no=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 06:23:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:23:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 4/6] soc: imx: add i.MX93 media blk ctrl driver
Date:   Mon, 11 Jul 2022 14:24:50 +0800
Message-Id: <20220711062452.3575032-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
References: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ad76f5b-9a12-4e56-c3a0-08da6305df64
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2ZMj6kOZ271+JL3KPU0yPUmWYfVdJJEjOkGKPOHpshLHMH8PvD3gCgGxIpZxpBVUeHWZxlCk2RPKPVW+7MiVlwY7dqnr4kFc6DQbitATeHDUFXU3+3aKaaMs6Z3pgvjw/1R0NIQElIdDixOO1q9jWmKIFAMikkGQdpOdBKQOB3XZHcFjAmSwBUfcjA92YRjPlfwxMnE73RgDIwJXa89z6c/F1taxFjIdEZTEY8n2t/g2GBZ74nUtcQTGflwceXtfSPJoGDcpTM5hsBB+JBM+o2CJT1zgxjxQWS2pftQbF1r/xT8xfJFBM5z/p3skNK3nlYhl6cOyIc3Dgvvq/7/xTaw8vkaJeEWpqAOJQ+7FGXEok0JhKL9vK9ze4ydjrepUABJ4LBH2EsyTQ4Islc9oYC7WfMGWf3nPPb3FbABCycBYG7C7rXzbEmaPge4HdbfrdOrQmXc8AtsgsnuUnGnunF2cWlcB5Ld7j02lVoTyWtMDMcf0OHeT6TYxn1H7G1FED7T+QVWAojcnke5KxJuthqQcuaxhS2nY+EG47GJC4CbW7GtrSRz2xFs1RhME9SG74KjHpdtFcrh8lDDWcIsyk2hTbpajEdLaIzmH5o1VjcWVxonyJ45svnRP3O2iz1P5x2V3uUNRl0+iZpyRrcAslEFYhFvifGlBI9O1FPNOzUWkezaJNbUzkEpyDqHiYdB/w4nrFgzA0oQGJq/velMX2JAhAOdqSfttQ+g0Z34s+DJYcqrBE35LQT8a0YqQg8j/MZgQV3GYvIGKonUlindSFUgmmrc6W7JJ4j6r49OK1Ane2h3MGHROiq7tI/Yi79l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(1076003)(66476007)(26005)(6512007)(66556008)(4326008)(8676002)(8936002)(5660300002)(186003)(2906002)(7416002)(316002)(83380400001)(86362001)(478600001)(6506007)(41300700001)(6666004)(52116002)(2616005)(38100700002)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydlMqQhsGfmSa5qUQ6NgZVoUAOlVYb0tE47Y6KWXpT0Nlnf9mC2qnd6pruAR?=
 =?us-ascii?Q?Hk0r6r4uNwJr3Mk5VZpyYfp8mrI5q+cAkvdW3DciQPkp008sT0bv8RYY7qb2?=
 =?us-ascii?Q?jXg63nEL5RyXjhZx+qn/y1Uzk5OEnOjGebQQJd2w6+rYBGa/4AvVvg5eisal?=
 =?us-ascii?Q?T9slaSXBKObq6dQGuryIPlchfzCQoxmQq+sndID1opi93iYTZC/ZbPwt3Nlz?=
 =?us-ascii?Q?9NhUEZiAGGJ1IkCcUnK3PoxZwDkyGuQZmfDVRJHlLU+sE9MvLM2W9nrnLE+A?=
 =?us-ascii?Q?v8dRyPs6+5uVv3/VKurZ3+AIesARni/CE37UhhS64PVNr4ltQuTkCkV77p6X?=
 =?us-ascii?Q?LD07tC4R24nXC8qIAp0j2AaI5rURjoRHmG3t43jqBSVdVJqdiT1n/PUAcY+v?=
 =?us-ascii?Q?Wkui3WZlKbSqIp+S1HX7SWddlouwn+4bOPLkF6EQK1EkVU7DIssq6Ula3yiQ?=
 =?us-ascii?Q?aAL2SFLDYPd81KU35iQWrxrb1EDuFKcDDIFb26iY+j1XgHwL8S2NVqX6cVMb?=
 =?us-ascii?Q?C6WDmL1m441mk+sJtBJVA7/WBOU0nOANwIiVvqLPf57dPostVFP54ENZ3J1I?=
 =?us-ascii?Q?FHA9PD5drgWNNwxN/VjO2a4G0WFbRmIFf8s8mGMuVIEEnwXQygogI3qrmBUy?=
 =?us-ascii?Q?m6ed9DXKMJCPiyLKTxku/BKue9JUsvYnn9TuH7dIvIQ+5WnLt0EG0wgR/45z?=
 =?us-ascii?Q?QPD26m9RVsJ1+8hixMUJ1/lbg7GyY79jPHnixMxZU2OfiD6iBWD+dB2nrBiw?=
 =?us-ascii?Q?zSWHm9Vg6vixKbEeT0QqFMp9WW9+rIwGCIJWJS8hcCktv8a/npvlCVBTQU8X?=
 =?us-ascii?Q?YnClg/IsV+BfSVCaLGGYqIfZ4PlW6SQNL+KvTyGjVzanrUxruFxlN+K+IdTk?=
 =?us-ascii?Q?n1oWlfXLOLjxzafS5FDam3hdVS+gfTJH2gi8Gs5kglounR2nW4oy2GmEZCwa?=
 =?us-ascii?Q?4aqUuwCXmLaLKqKP9+IIoB9q381Ghl984FbJd62JEZsw3wkHhw5F6edniw64?=
 =?us-ascii?Q?ITQ4ofCG/DyuC0vFOEgsgy215wqxaD0006HobuWjyV4qmWN0MEdXgATPj5tp?=
 =?us-ascii?Q?1o6sKk8xI/c0/gQO7CB+kOkNnZWAPNri84iv4s8HEKGPzdbgcU42jUHcSBCk?=
 =?us-ascii?Q?9t55XI9eH4xQCcjHZGI5HppPpzZFlfPfbsullvVXW+OWkP7LHH+oFLTm/Fsf?=
 =?us-ascii?Q?RzTZHoiHyenQRtIiTfAMO0jfVqDtZuMHxX4oJ55qgR6FFpeNksXX3OXVNJOS?=
 =?us-ascii?Q?nAUDUiTMHqNHayXI+pHBjFjhtadHPWkvrTU5C3f3e9XCkFJtgm2nNyvjYBkM?=
 =?us-ascii?Q?+BfCJZDw7DD8stStD24vn7iCxG+gjDDjV02/D+7EyiCWAfHxz1/XnHiX1LxL?=
 =?us-ascii?Q?8sCul1CioOn6/fniUPI7AXxfXKYISIL783a81+p9IHakiLJR3lUxiVLsIOQg?=
 =?us-ascii?Q?MvNGXBX3PZ7OzelUolsJjSgYYy5CuIf0X3E/8VQTk/w992uzsXkfoQJ0gTu6?=
 =?us-ascii?Q?ONahWzpVjGMNjRegnZalRgOftAeXpj236Dx6OHrXxxypNPEZcAEMXuPK2IvR?=
 =?us-ascii?Q?GBXATiZGoLuTX++F0DrKQyUfDUqWcBamiudMpwUr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad76f5b-9a12-4e56-c3a0-08da6305df64
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:23:30.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qW3e2u8TXz0QqmFrYaJdK2yuc/JbmSS8mkfIkAuyH8oTJl4uI+3rs7c0ys8TBnWL/byY0vV8QEJgeO0hZ/dTSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5212
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 mediamix blk ctrl support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Makefile         |   2 +-
 drivers/soc/imx/imx93-blk-ctrl.c | 333 +++++++++++++++++++++++++++++++
 2 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index a0baa2a01adb..754866e0a10d 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
+obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/soc/imx/imx93-blk-ctrl.c
new file mode 100644
index 000000000000..42be09688cf1
--- /dev/null
+++ b/drivers/soc/imx/imx93-blk-ctrl.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/clk.h>
+
+#include <dt-bindings/power/fsl,imx93-power.h>
+
+#define BLK_SFT_RSTN	0x0
+#define BLK_CLK_EN	0x4
+
+#define BLK_MAX_CLKS 4
+
+struct imx93_blk_ctrl_domain;
+
+struct imx93_blk_ctrl {
+	struct device *dev;
+	struct regmap *regmap;
+	int num_clks;
+	struct clk_bulk_data clks[BLK_MAX_CLKS];
+	struct imx93_blk_ctrl_domain *domains;
+	struct genpd_onecell_data onecell_data;
+};
+
+struct imx93_blk_ctrl_domain_data {
+	const char *name;
+	const char * const *clk_names;
+	int num_clks;
+	u32 rst_mask;
+	u32 clk_mask;
+
+};
+
+#define DOMAIN_MAX_CLKS 4
+
+struct imx93_blk_ctrl_domain {
+	struct generic_pm_domain genpd;
+	const struct imx93_blk_ctrl_domain_data *data;
+	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
+	struct imx93_blk_ctrl *bc;
+};
+
+struct imx93_blk_ctrl_data {
+	int max_reg;
+	const struct imx93_blk_ctrl_domain_data *domains;
+	const struct imx93_blk_ctrl_domain_data *bus;
+	int num_domains;
+};
+
+static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_bus_data = {
+	.clk_names = (const char *[]){ "axi", "apb", "nic", },
+	.num_clks = 3,
+};
+
+static inline struct imx93_blk_ctrl_domain *
+to_imx93_blk_ctrl_domain(struct generic_pm_domain *genpd)
+{
+	return container_of(genpd, struct imx93_blk_ctrl_domain, genpd);
+}
+
+static int imx93_blk_ctrl_power_on(struct generic_pm_domain *genpd)
+{
+	struct imx93_blk_ctrl_domain *domain = to_imx93_blk_ctrl_domain(genpd);
+	const struct imx93_blk_ctrl_domain_data *data = domain->data;
+	struct imx93_blk_ctrl *bc = domain->bc;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(bc->num_clks, bc->clks);
+	if (ret) {
+		dev_err(bc->dev, "failed to enable bus clocks\n");
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
+	if (ret) {
+		dev_err(bc->dev, "failed to enable clocks\n");
+		return ret;
+	}
+
+	ret = pm_runtime_get_sync(bc->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(bc->dev);
+		dev_err(bc->dev, "failed to power up domain\n");
+		goto disable_clk;
+	}
+
+	/* ungate clk */
+	regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
+	/* release reset */
+	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
+
+	dev_info(bc->dev, "pd_on: name: %s\n", genpd->name);
+
+	return 0;
+
+disable_clk:
+	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
+
+	return ret;
+}
+
+static int imx93_blk_ctrl_power_off(struct generic_pm_domain *genpd)
+{
+	struct imx93_blk_ctrl_domain *domain = to_imx93_blk_ctrl_domain(genpd);
+	const struct imx93_blk_ctrl_domain_data *data = domain->data;
+	struct imx93_blk_ctrl *bc = domain->bc;
+
+	dev_info(bc->dev, "pd_off: name: %s\n", genpd->name);
+
+	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
+	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
+	pm_runtime_put(bc->dev);
+
+	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
+
+	clk_bulk_disable_unprepare(bc->num_clks, bc->clks);
+
+	return 0;
+}
+
+static struct generic_pm_domain *
+imx93_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
+{
+	struct genpd_onecell_data *onecell_data = data;
+	unsigned int index = args->args[0];
+
+	if (args->args_count != 1 ||
+	    index >= onecell_data->num_domains)
+		return ERR_PTR(-EINVAL);
+
+	return onecell_data->domains[index];
+}
+
+static int imx93_blk_ctrl_probe(struct platform_device *pdev)
+{
+	const struct imx93_blk_ctrl_data *bc_data;
+	struct device *dev = &pdev->dev;
+	struct imx93_blk_ctrl *bc;
+	void __iomem *base;
+	int i, ret;
+	const struct imx93_blk_ctrl_domain_data *bus;
+
+	struct regmap_config regmap_config = {
+		.reg_bits	= 32,
+		.val_bits	= 32,
+		.reg_stride	= 4,
+	};
+
+	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
+	if (!bc)
+		return -ENOMEM;
+
+	bc->dev = dev;
+
+	bc_data = of_device_get_match_data(dev);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap_config.max_register = bc_data->max_reg;
+	bc->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
+	if (IS_ERR(bc->regmap))
+		return dev_err_probe(dev, PTR_ERR(bc->regmap),
+				     "failed to init regmap\n");
+
+	bc->domains = devm_kcalloc(dev, bc_data->num_domains + 1,
+				   sizeof(struct imx93_blk_ctrl_domain),
+				   GFP_KERNEL);
+	if (!bc->domains)
+		return -ENOMEM;
+
+	bus = bc_data->bus;
+
+	bc->onecell_data.num_domains = bc_data->num_domains;
+	bc->onecell_data.xlate = imx93_blk_ctrl_xlate;
+	bc->onecell_data.domains =
+		devm_kcalloc(dev, bc_data->num_domains,
+			     sizeof(struct generic_pm_domain *), GFP_KERNEL);
+	if (!bc->onecell_data.domains)
+		return -ENOMEM;
+
+	for (i = 0; i < bus->num_clks; i++)
+		bc->clks[i].id = bus->clk_names[i];
+	bc->num_clks = bus->num_clks;
+
+	ret = devm_clk_bulk_get(dev, bc->num_clks, bc->clks);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to get bus clock\n");
+		return ret;
+	}
+
+	for (i = 0; i < bc_data->num_domains; i++) {
+		const struct imx93_blk_ctrl_domain_data *data = &bc_data->domains[i];
+		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
+		int j;
+
+		domain->data = data;
+
+		for (j = 0; j < data->num_clks; j++)
+			domain->clks[j].id = data->clk_names[j];
+
+		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to get clock\n");
+			goto cleanup_pds;
+		}
+
+		domain->genpd.name = data->name;
+		domain->genpd.power_on = imx93_blk_ctrl_power_on;
+		domain->genpd.power_off = imx93_blk_ctrl_power_off;
+		domain->bc = bc;
+
+		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to init power domain\n");
+			goto cleanup_pds;
+		}
+
+		bc->onecell_data.domains[i] = &domain->genpd;
+	}
+
+	pm_runtime_enable(dev);
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to add power domain provider\n");
+		goto cleanup_pds;
+	}
+
+
+	dev_set_drvdata(dev, bc);
+
+	return 0;
+
+cleanup_pds:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(&bc->domains[i].genpd);
+
+	return ret;
+}
+
+static int imx93_blk_ctrl_remove(struct platform_device *pdev)
+{
+	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
+	int i;
+
+	of_genpd_del_provider(pdev->dev.of_node);
+
+	for (i = 0; bc->onecell_data.num_domains; i++) {
+		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
+
+		pm_genpd_remove(&domain->genpd);
+	}
+
+	return 0;
+}
+
+static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
+	[IMX93_MEDIABLK_PD_MIPI_DSI] = {
+		.name = "mediablk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi" },
+		.num_clks = 1,
+		.rst_mask = BIT(11) | BIT(12),
+		.clk_mask = BIT(11) | BIT(12),
+	},
+	[IMX93_MEDIABLK_PD_MIPI_CSI] = {
+		.name = "mediablk-mipi-csi",
+		.clk_names = (const char *[]){ "cam", "csi" },
+		.num_clks = 2,
+		.rst_mask = BIT(9) | BIT(10),
+		.clk_mask = BIT(9) | BIT(10),
+	},
+	[IMX93_MEDIABLK_PD_PXP] = {
+		.name = "mediablk-pxp",
+		.clk_names = (const char *[]){ "pxp" },
+		.num_clks = 1,
+		.rst_mask = BIT(7) | BIT(8),
+		.clk_mask = BIT(7) | BIT(8),
+	},
+	[IMX93_MEDIABLK_PD_LCDIF] = {
+		.name = "mediablk-lcdif",
+		.clk_names = (const char *[]){ "disp", "lcdif" },
+		.num_clks = 2,
+		.rst_mask = BIT(4) | BIT(5) | BIT(6),
+		.clk_mask = BIT(4) | BIT(5) | BIT(6),
+	},
+	[IMX93_MEDIABLK_PD_ISI] = {
+		.name = "mediablk-isi",
+		.clk_names = (const char *[]){ "isi" },
+		.num_clks = 1,
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+	},
+};
+
+static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
+	.max_reg = 0x90,
+	.domains = imx93_media_blk_ctl_domain_data,
+	.bus = &imx93_media_blk_ctl_bus_data,
+	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
+};
+
+static const struct of_device_id imx93_blk_ctrl_of_match[] = {
+	{
+		.compatible = "fsl,imx93-media-blk-ctrl",
+		.data = &imx93_media_blk_ctl_dev_data
+	}, {
+		/* Sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
+
+static struct platform_driver imx93_blk_ctrl_driver = {
+	.probe = imx93_blk_ctrl_probe,
+	.remove = imx93_blk_ctrl_remove,
+	.driver = {
+		.name = "imx93-blk-ctrl",
+		.of_match_table = imx93_blk_ctrl_of_match,
+	},
+};
+module_platform_driver(imx93_blk_ctrl_driver);
-- 
2.25.1

