Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5DA57944D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGSHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiGSHeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:34:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45EB33A2D;
        Tue, 19 Jul 2022 00:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR0T2FuuWdcta0Z4dy6D5GMI0eBFRchJRhgioDSicA8Q8kghIikWXDgylDfYNIIjr5XlB5b1KaWtVo9Ska18C2ZbCko1aQ5SwV6OJDlIjEl0d/gAPXwRqvC8KCelJVlnCvbNxlt1uPeJ2PUwcvksyBbWPsR0qivXMMnNLPhgb9B42N3YL4oVCA1U5fH3+zjfOrPrU7H0aSnQmbHxPOtEWWYd3V3Zt/tI42UVnqlbB2ctXTZjdKi8iAhNVk//u9Xy6/mOGNztyrRVv1CFttNRGlNWlIRI0xyWPZ5skAH1UyyCl0YA4dund3P1LGvbqdsxE2QuhWL3qC2AkBXeGdYKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S79pV74eJBAb7LbBVc7vkbPAG7WWTIoZohKoHg2Z1sc=;
 b=A5PTTckpCux3SuM81tyEzC9ifh1du0uWcFOYbId+/SkvdpkWRSTaZ6Pi/HaV5g81PGKdeueG3Tj3FLtdjvLb3R9qUkekvMCo62N+jDRbZLdLV8BL+n4wSHMnKm+/+jw2IhRmIM0A+cdBQy6jziT2wsXYSbjk7pdnPIGPTW3mbiBjXnZOT296+ntu/oZ29CA59Fv6rqFacsU4Yx+vMFQdX2WhQ7dP/3nUlUQQBIN7c4YOWSHiXZo1YVpUNFbcBPcoE7dFxWY3KbNGZJnc/9HQEqIhuGu645R/rt2+BEGl6NipYUXsmTnq741Yf6A9AE+TNd+K2iFion9KfZ7cJYypfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S79pV74eJBAb7LbBVc7vkbPAG7WWTIoZohKoHg2Z1sc=;
 b=BaEuhKnu1R3MT3u6mNH2Kc7TQ8nvtFenGKH0uDLN5StMTk5QZD56fiTboHXGM63koa3cDfGfZi0Z4LazfAVqQwHt37kmbRmGxDFkKdNW2CIfI620Eodh6R/hsFXPv/eeHqQwZDnQgqdr/hcfmFu8tFbNf6Jp3uteBMn10eWQTMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:17::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 07:34:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:34:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 4/6] soc: imx: add i.MX93 media blk ctrl driver
Date:   Tue, 19 Jul 2022 15:35:39 +0800
Message-Id: <20220719073541.197788-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719073541.197788-1-peng.fan@oss.nxp.com>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7890670-5963-4bcb-ffd7-08da69591627
X-MS-TrafficTypeDiagnostic: DB7PR04MB4298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBC+ZS7AhHdGsoqJ/toV50JFfEHXAiMHHiVN++AGYpN3enKAKwBCPIz1uAtgGX4fCMK6l2mxKU5YVr9SjHT89iPDjH/VQr+zj1IfF59BNuWU3fZsgbCq52epLJJ+SSyOjiSmY+3c6q//Uc7N8sX0NZRoSUOPfXcF+FZSYdcViga9PybR9UsqaKJzf7jMlHY3IxoOZC9GQxedqr2HjNO45VGttjUnmQnKT2igaHuNvokqT61m0+MDKTE8fWOAVVa9DCqfrbIy4mcWQLmje7k1h6VF1hvspoVyNObDsZRi2BRBGOVfaok3AFdyUyoCZuNXWWpV785XwdszHY5LEeiVQHujUw2znVgwSb/I4CPLnuzbYXYOKjQFlMvDg3BElsyzOmzIxf2Ic4oSsbM9hXi6UexG0siO31jGUq2F0yInj4EiUe/vy9JmyUKeNbeRCiOIW6WcePAIbhxsVicEY6Vm2Lk7178rOS1n0+Uo5Cp3IcPEPoe0qWrvA0D23BQPNwWZFfOrasWca/Ht48IMpNW1PSoUZnmUlBPGdNFr5swk1TG6Zkk1cOCWjz0aMqO9SbTvbSXL6ckRu70l2Wf+gL9XaZUDmDdHYN7X71FJb+NqlFfExxmmTTLvO3hopgXHNk0xyAZUsHax3WktjYKUg+8F1GsohV+5UA1C+VapbZXbBp7T4uy3aql7rqKufedBK4SlWUYBJ0PJVaNfLqD/e11W7DtJaInzSZli8oFscsAL8ZdvZkZYCLMaNb6i/a/vG9SujslvAI9NK9vdO6iZskL7Wg/v6JHh9zwTcXiC8jnLOgkjt4y7fLGaAMoVE6ViP9mC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(38350700002)(38100700002)(316002)(66556008)(66946007)(4326008)(66476007)(8676002)(2906002)(41300700001)(26005)(6666004)(83380400001)(186003)(6512007)(478600001)(2616005)(7416002)(5660300002)(6486002)(8936002)(86362001)(1076003)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9X5CytcNsxfl8zte2xWY5RZAqeLpmnfmpTZlsKyA6RgC9LaFeX0/f+lx6W1?=
 =?us-ascii?Q?PdMq/WfhhOvE6gYo75eWmV6ltFfLkb9y7SDtQqjEo6tDXggqFmToUzkn4+Ka?=
 =?us-ascii?Q?dsozH6tZSOc1JBJ2qQousnUPZJKDuLDcp2iHwPWv3inh5X3iikCCn0RvHQWh?=
 =?us-ascii?Q?LRTnNqOt76eKd+YHVnB01WICEpuKq5c9puppe5reS20HhF9qVRor24x9uukS?=
 =?us-ascii?Q?RebT1fxhOp1XfY6Az6fWarqljVOzeTo6GJcCSyRU+6Z2HK3NWlkZeLZ+4RvO?=
 =?us-ascii?Q?t2OeHfG3Yeqnnrs3BlDItXpZBVkCg2IFrJMxfwDgiPPDnNKGg1JC0ekTIz49?=
 =?us-ascii?Q?W/6VR0OIm7JG0IFhJbVSgck6xWSAbkqasnLWuxmqpKH34r60UlylLnZ0e31/?=
 =?us-ascii?Q?oi7fanXKDteV5r/XsZy2DMixlvsGPkiWhT4Y95f5qXHi0gNR08Ptcy0vmida?=
 =?us-ascii?Q?MQYqUZFo4jDFtDL3y1x5sROqksb6+W2oz/IdoEni4k6ugMzHZtWO00kGH9uZ?=
 =?us-ascii?Q?H1Ab7hPn4hZra0UBvHufJ3Pgkoj/YcUbrs8XEsY3sjH4r8OFGJlnwUll6nmi?=
 =?us-ascii?Q?Jz6vcmLQywkdPx6Dgx6x0HuNbBvL/qiAPBFXbzt/4OdPFIlwkPzvgB2YUdiU?=
 =?us-ascii?Q?UVDIhfps4pEQ9ZzGQG1OL7EsuIj3Q6y11JEvrRqm3Dgy+IqsGrrecUaMXOI6?=
 =?us-ascii?Q?Qyf5Tr97yb6YDlEC6Jc01gxIA849f45HJIkfKymikNCk9dnD9wQPkON7qBAo?=
 =?us-ascii?Q?v3yxj6EYRjjHT+nkbQ/UAaLYb6t8OKoBNYe3r1vW3W89iPJUR3d3+w0rfsjU?=
 =?us-ascii?Q?kNgMeI3LqUi1AB8IIqLUg50zS4kcJWOx79CcALi3JS41BKh/EwpF3oyV61Gh?=
 =?us-ascii?Q?YgI1z0b1DLuP3oh8l+zCPTQGBCNFZXOr3qUmQOBv+3z+2JjnIm2HPGY/sSpp?=
 =?us-ascii?Q?foxf+Sr3HUCPN5znnlhpPtqd7JeXx3VbHSpslhGrQHG1/b0fbiPaaJmSvdMt?=
 =?us-ascii?Q?U5se7arR9co5pQoP4LQOCLXP0lxXwqFdhfsMDokgtYcm6eD3kSPSE2DKTGsS?=
 =?us-ascii?Q?u5/eSA54rQLqgYAaa8MrF5d72Nq+AAp8E7k3tAt7iyAH0NGs//nirP8NIf4Q?=
 =?us-ascii?Q?UfGpKQKGsea9TPauxi0SxtKjH3fZc1gLmOsc8BddcWP4DydFu4veiPzHrOCI?=
 =?us-ascii?Q?+F7l1tE7P+h/NiGEm4+bf+p1IK/Mm3n8PjcCaheS+U3S7Y5xtQDjb0N55yjM?=
 =?us-ascii?Q?nJM3bycin0UWGDRuJLII6eQKdDE+1mjdeKA3CPvaAKujx/0dvRYG9313ZwHe?=
 =?us-ascii?Q?ZwQJzm8ikW6vt1+Rok66M7dbgRAKkpUKR/aV+td9VaIgnFM+7qDOTprc25Bp?=
 =?us-ascii?Q?IjWSGX3bI/9DC1VpJfdSeRfFNWftI4cL8h3ftWKfnZR09EvPrh2D/SQr5XKB?=
 =?us-ascii?Q?U+jbFNnx4yyP6UQe4piBprLn1WbbxaaviC+2MzfB+90+MSet6xr1mtG+4Tq2?=
 =?us-ascii?Q?qPmYUAxrGKxY72PI5++oCXqulgy670OtlBwqyzrTwebkCY+vzZ3guMnLUI/A?=
 =?us-ascii?Q?7Rets0fDSykM1xdAJ2UShpxOOg5q5LMdbGzwdqmX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7890670-5963-4bcb-ffd7-08da69591627
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 07:34:17.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irLUEX4+oXzE4mojWODb4vXzvcWnqF+NqII4w+4dhxw1/sTX1hU+dbxJ3PlAx7QViIk614RcWe7ihRETkER/0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4298
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

