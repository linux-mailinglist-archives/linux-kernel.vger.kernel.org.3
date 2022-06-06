Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4453DF8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348247AbiFFBth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352101AbiFFBtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:49:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872C4F9CC;
        Sun,  5 Jun 2022 18:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTwjSPqLlyOMxdv5cDCIWcpABWZfO7q1ukdYCMQ4r3sRQ/q0R7VLK2EyfM7Vy3fnJvSUB1tbKgBJ1L75xLsVKTMAfYSM3reObBriZvQYFuXyN/Ls6+inI2hYua9kCHBsoHrmB39wTpZlu4Lny31SeMHYaWFOxBxP8mVkquSr/uKk75wbKMcTrizL//vOn2MlAVizec686PK9oWmxXFiQzDGhRzoM0VbSpqPC+oCHL6KSJj2h+ohp5/LArQqzre0PYdpFhVp64NJIf0Trz4DRutZG2H6BB8xGqQFMAMgLS/1ALYkfgqGxzUShcwi32qFiO8a4hepEKeGdNr2v3PrDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OctA8AA/HMLuFGkzae2+DvrmpYerQJrTtF7o0ybrJlQ=;
 b=eQe75ndkUtj0qhbb1aLfoe05GdKjc6UNOBvtOMe+oo9q+AxEvO5R+V6KWyXescDPfP/JA3OGhQg5O/k98o8xXMsYFtWbflIqWPyQ0pSqfYGYeg9dzM8A3RiyjigcE3Z3gO2nLa9IIsjIWgHWBTR2hvw7hhUktzZfEAq1qoY+EFPr/DD0zFQCFqvUmEnmWL1XwKUGZREfF5Dre+4JYv6BbgHkwpEOzdLuzXUyRKcYGpILipjKIyTcvbk1/WqNcQ9xHqnEPHIaohknC8jaBdjltbmsuVvbugDaZFTBz3kLw2C336X69lr3ryNgY9nXW36DwxQ1Ks2fzS3DaRbdeku/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OctA8AA/HMLuFGkzae2+DvrmpYerQJrTtF7o0ybrJlQ=;
 b=Vgi5sBjPTR6ey6G7PCElWgzVWkeTSNndzJ0LOOtl47s+RP8psS5G9QrbqMiYv1fjrbXgWGOfXCyZS/hQJLzgPL9LHKCpVa2D93xhK07odaUsw+qnq3cBxBalPBjX6Ysx/r1GTf9S6Hf/io41hVGXHlHokR7+WBKZ+aUfBVgsAEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR04MB4840.eurprd04.prod.outlook.com (2603:10a6:20b:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 01:49:14 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 01:49:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 5/7] soc: imx: add i.MX93 media blk ctrl driver
Date:   Mon,  6 Jun 2022 09:50:23 +0800
Message-Id: <20220606015025.180840-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606015025.180840-1-peng.fan@oss.nxp.com>
References: <20220606015025.180840-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99c2446-767f-4dbe-5225-08da475ec1a4
X-MS-TrafficTypeDiagnostic: AM6PR04MB4840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4840FC449351B4D7D21238F4C9A29@AM6PR04MB4840.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxUG0ljbeJl6209cIQ86BNjG+pfnh+WLkBryE+TbMeTz72Y5w0ScyQabwqCxndlnC4nCI5RuSZLuZTDnxWsFhJfd1uR6zG4HSjgo0lvLRY2e05h6biJ9cgwwHac06qNCDoCUx1cvlg+15seR6U7nxU3WhTI0jIHxfIQbK6tpPVUBB1Wu5jcah6GwTi304fMpRLrrArd7nuuQtrbYsVd+OEt/vsBNybBIvRcSVVbEiBnMfmXhKvGByCS7PrNC1f3bTW9wpaUqRliQMT5JrprqQZTt+AA7p0Ik9Y6h1gwTXm8ADosLkyil1mVdHBFiLblMwFeyBHtlSvGe5+SX08eC9Tc/DbtthwfK93GTY/bb2jsOQRfQF7W/o+Fz4NtKuUCbnEFY/MtJ19n/c001YxSO3AG73uwVs/uzfJKyx/hOi6EvdAUeOj6y5JXpg19CJDCYc81spDHsyGGPFitH/wJGYOwRoR+ratmlkL0vEg7c4PpFWJh+RVeLwh8iivl4iIprUv8Gln8OUxUyeucw4I93y77JCvq9G5Jeg+oZgxSP9YRUHLV3ZwMTpsmhdrL43w/wGFkkxALffSGMEadf8hcgEDwZXS7YKAHjsj/0fcphMfY7jjWB7jplV1Zr0flWPU2aS2T3/FfKxVqd0aD8KWrZUAOxYBE9xLW0cnoYcOPF0GbnBEyRK0xEcMhOzTqzOjxezbuJGM/S1Q6VQUkbOozjMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66946007)(7416002)(66476007)(66556008)(5660300002)(2906002)(8676002)(186003)(316002)(26005)(83380400001)(1076003)(6512007)(508600001)(38100700002)(38350700002)(6506007)(6486002)(52116002)(86362001)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zhjQRNzMWCz/ObCsXtGa6pGAiQB3gcnCXk+XLRIX+b1ufs4mULa4VU858fbo?=
 =?us-ascii?Q?TFaFQuHgPHamzUT93b1aLmq2sgiFpVDEDGVTITkUoqWpQrAnzfTROEMCau10?=
 =?us-ascii?Q?3mNSz+0tnYfOmaudQDZKuD9rEyExx6syvPaoBuKNFd7D/pUasbAY+IEYwPRf?=
 =?us-ascii?Q?DBvSUS28y+PgpeZgCieGFuAbKBLdxZEp9wUz34BTyOLlCndhJR+MdgSQpmaI?=
 =?us-ascii?Q?6VGiYvmVHRCvgJd5xL8T4dmcRMX+U6LScnKCDw6iW/IR/YOeBx1Y5jBi1gRe?=
 =?us-ascii?Q?Cb7cMC+Ea7X7tTSi7ywQmye48+ZxlyXNnnlC98itvzqoQFma4M9Ni8DVoyvm?=
 =?us-ascii?Q?A4tD6Au3sExMYW/yK23wzN8OLuw6/WvmJByb0GHbTx5/rZJjoWg/DgCY9FdB?=
 =?us-ascii?Q?B0r+9oAujiCFxwJrM3qi0JM9XpNPdiNRk0jcv6VlskpQy5WCDfSigo7iGY7W?=
 =?us-ascii?Q?rGvAc3QdFUKBctMm4BinqT6MynWUqm2EBnSXcmzNW+xR3ggz6LQBIoULOrpc?=
 =?us-ascii?Q?6A760lqT4H2huhY7DW0bRohZfwLEjUGClMNXMgDyQzOFG7yAjajtkL8MuryO?=
 =?us-ascii?Q?ycu/xMqJtldH6cbKTSpVtaJ6TQyDEYUsOKSbMWCXO1GFG79Aby4dT2ui3J5U?=
 =?us-ascii?Q?WLcqm/RLJTOWecqY/RxtXdFfK+TvUXcA4X6KCix6QQiFsVqlXAkkvYv9/2aQ?=
 =?us-ascii?Q?xax1WK0p+ygRBy8kXt/1JSxEJEKwhKUC7E1ox2ERKaJ6buBFrKM9+ROQvLNy?=
 =?us-ascii?Q?0krmoYQ98NOJaolGAF4V8eqR1rpl984hJ8Th/1MU7ss28YKnlGlL3iBADrjc?=
 =?us-ascii?Q?QAzBv8JFp4WHKvkC8qRC+0dxbkP3cX0c6rNxNJZ8IFyYjgg1NzsYZAn2jplo?=
 =?us-ascii?Q?GzFbwl2qWtWp41ZAl0ai//I6YkVIgOGV4M2OwYh6R/6TGcEXckDLV1oymSqO?=
 =?us-ascii?Q?wQV8dcOAW3mYOYI6TthTmFE9C1eOAJSwJ+NBiudwHZW8eu5m6KL5tmaoEwNz?=
 =?us-ascii?Q?JP3dzOJF5Ee3ehRqVQj6qjb1/xdu3wEicCnEnLSPM7jHsdQTe2rjh0SdOK49?=
 =?us-ascii?Q?FFadYkj842ZUU4mPxHg7EjRrXSnI19sb8a6FUi0DaU3YsZtDheWHzqT2iX6i?=
 =?us-ascii?Q?xswlATdFgcmroLYu/J/YPBl3n3LG5IJH9SYb4B8KNioTfoGaAwugrLo8oz5E?=
 =?us-ascii?Q?8nfuk9cc0YBnHMn4CtB5PexNoGsEU31b3x/a+zQGUPTHcsnpFgnRiPolek5a?=
 =?us-ascii?Q?bN+0EZ2B0NgxSJczMrBBfK6FEymhiQIV5UDOjPhsjgdZNOQeY1ltN9KmYTJN?=
 =?us-ascii?Q?qxe8y7+/FOIGE0pkwCLyr39dePHvS0ZqLNH3lHWZHnG1Xj7YNlPClMTrkVYV?=
 =?us-ascii?Q?qyeH/SseOmWc5rnJ7jaHZfwIT4VQguahSdjERzuiW4RZf3dyrsGk384/qM0X?=
 =?us-ascii?Q?zYxZmdTjKi54PTpNy7EQwhaYDZfdgEBZwIAQG4Wao9eBYy0mviUE7qSE8TlV?=
 =?us-ascii?Q?yQEqDSiC9qcSqPiA/maMRyF7CWKFFyLMfodr7UJwZJFzTicd3YVMsz59k8/m?=
 =?us-ascii?Q?xMLNcWK/1kTv0t43VeAQTGdn7In0+bTt2Eu2maSHqNTFNgT9oFVS0nC1l5nw?=
 =?us-ascii?Q?UaFskcDb4IRZvOOBBlwbW0sgAPbIk1hbXXzmE2R8LbTjQN+d0eQ+3tMkttQM?=
 =?us-ascii?Q?uAQskjYiV/BTZl0ordX7lijO6YHOY78qpXjFV1bHas76M9PqQU10myAWTR7N?=
 =?us-ascii?Q?yI2zf7yvMg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99c2446-767f-4dbe-5225-08da475ec1a4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 01:49:13.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbZNGzdlg3iWDaHspO2g1PBYmJJyW/AmCTgsUJNiITlj5r8m358R62QphP3NKZTznsQVcZ6DM69lo2Q4lNN9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4840
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
index e3ed07a6bcf9..c532aa179f4d 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
-obj-$(CONFIG_SOC_IMX9) += imx93-pd.o
+obj-$(CONFIG_SOC_IMX9) += imx93-pd.o imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/soc/imx/imx93-blk-ctrl.c
new file mode 100644
index 000000000000..0f221a26e69e
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
+#include <dt-bindings/power/imx93-power.h>
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

