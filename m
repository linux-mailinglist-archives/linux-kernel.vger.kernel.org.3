Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA52B534F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347361AbiEZMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347325AbiEZMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:33:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCCB48C;
        Thu, 26 May 2022 05:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im8A4iFgAJ5UkLrhuTN/4H188V/D9vNJEuVpzrCtVnpKyGzIXdtiYyQcNq9N7dTeVdJSgTzML+cwPM6xHuaeutyrSbAD+bPF14g/IBPX/r7JVH+qv/imwre5sJ3V4+ejQN+LGCWLGT4JK+y6qDLEfmkI4F9EJE3LJwRdGdZRKCngUkJw7k7pMlsy8t4Zi8+X5XLzUjx+7sTkivYDnkgJLl2Axt5vftp8hf7EelvYBxabbi6NmiuFAeaPGrKRSHSDP37xQwy4nkrr8ji1Auehe51UGumB/NKPd/FyKcEQaVbpjwPXeJ3JbWt0xigYTizxHvc/vYaY22Ym/LsxhFzS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OctA8AA/HMLuFGkzae2+DvrmpYerQJrTtF7o0ybrJlQ=;
 b=XR/AGgs8Ou+uhwjlB4iiujdptM+9fuWkDZwE9zbZX6JalTp2csJFt7Me768DR/EM9SazeTb8D5A3ydcEN2669E8AKrU5a6oaLwtjoTZy6gITqn08sLxHMrrjs5J1ryvf7Csf8K+lgmd8sfWh5bGcerPYnhSUXLjwDHx5QvA9rtehR4SjbU8No3XTHIworn/sQ/lwoE1uO2jf+kUJvR9DkwlmbUW/Ybm+WjvShffLTR0VwlZc8aTFU61Jw9vk4bhzSD1lFmrUJm9eE/ovdrV7Lc1oJMZDddBWgRJp+uJoZn+EblR4tL+RvWsz6wGlvx/VqQxM4Rc6YqZXGa2ykU3Clw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OctA8AA/HMLuFGkzae2+DvrmpYerQJrTtF7o0ybrJlQ=;
 b=VM3eLaGywvZYNyV3lGawkuXQD/EQMd3Msj8abbXj8r2wHuCpkaDJjfdlLAIu08s+Rb31wq98EiinLO9pu2InO1JiS6rywLG/8eKLR4hPiIpUn9UwrPlg9qdQ5cfQS/tRLUREpcnafACfP0+cw6PbxGpbEM9hRfub2z7enNgP6r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:32:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 12:32:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/7] soc: imx: add i.MX93 media blk ctrl driver
Date:   Thu, 26 May 2022 20:34:09 +0800
Message-Id: <20220526123411.270083-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526123411.270083-1-peng.fan@oss.nxp.com>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a07f956-e38c-4cba-0ef5-08da3f13dbce
X-MS-TrafficTypeDiagnostic: DB9PR04MB8363:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8363C2E55218E4FE86143856C9D99@DB9PR04MB8363.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biRxHrcfFRDI+SRajmYYfPTFGTbtswI11PXngSDz9KRwFn1Z2+L5u74WE1ejOC4qgwOyZ1yudd6NJPMTKXF9NG9i6fO+IM90QFs+XcQH2LqiBKxQl2tlaYCjqn7RKkNdURF7JirCubkupO1jTc/awPgW9KUOEh7nQK7lI/ypyCPwZehcSn1qZbOpc9l5mqnVpCLtG3W3e+QR+gDE6IdmX7fOTBH5qXu/Lbf91dCTLcc5LxOvFlcZR9MqVKMZC/vdBRo8nBj0854aITmBeidVGVBi/WPtMruS+olNjoCXwkh4f6T2p13XFYRsXVHml6emYRJIbQq0zPY92v+usBgIosVYrEiee49NSFK0MXLgwCe/SLnM6SLjT3qXesAEtu6GYl3yFxGpBBAoWJzSk7p1wRhXpwiSSlGSIIo4JxhwRW0rkPH3lqaUikZrD3GDZMiI2dZiC7ObdgHQ700gACZpa4hJtE5cV1DgPQtPStztRD7af1ywa79aKZ3eKp3AZGQPJvMLxs9YbUiNpuI/H+e5LgnFXZeD9xNqOmsypQ5CfPFW/rUE87C8Cxw2BV4FWQA+uGoqfWGq8aM5TfpOiXhFQtIlEy2GyWCxVlcE5ZIUnbkU3MzckPzay86N5JsQlBukpRO4SC7IYktoa+Yd9YN6RB8Pb7GaqUKjVEoJU5FU8edORQ/aSPtsBL5EjfgnrMi/DKYQZvC+KrJq9QVZCE76Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6486002)(186003)(2906002)(26005)(6512007)(66476007)(66946007)(83380400001)(66556008)(4326008)(38100700002)(7416002)(86362001)(5660300002)(2616005)(1076003)(8676002)(316002)(8936002)(6506007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rnMLoQStsXlHqNW9yoJaMRZ+hNFO2IrsSqhs9+1GLwclq8gcEB/08TLnZOQw?=
 =?us-ascii?Q?rOjq5t3CyUAAilXYORCw8woniejqh0rm3qHZHJgVlqdk8Wb7lOzwKsr/Stxl?=
 =?us-ascii?Q?CGR6lyGINrgRoJFSybG9241QxOexFebsrM/1vTmif8IRmU9dNmx0o+d/2JWR?=
 =?us-ascii?Q?jCc+CX4vRsPghTZ08+kE4RKR0VR+buI9T5mn6JoqlAe5lUDWaFy4cvXJpBlq?=
 =?us-ascii?Q?hF1cFuE2q9I1OcG8f6oY5wlTdevcDx9vOlc9QHIXSSaJiT/ixJ8/laLGMC1e?=
 =?us-ascii?Q?Jw1sUNv8AoW/ReDRhmFjijCH607vQIhYCCEe+fVjrC/fIVIcMYoGCfKD4M+x?=
 =?us-ascii?Q?7eX9z75pmDWADHF5JUZFR+5yAbuv+7VKZTpJiwq0waCsSJlYYk4VMFS+blHG?=
 =?us-ascii?Q?RsUCccos4CopzyTrrKAxbI1tJK8aNP2+BO7fVYPe8akUujEH95rx9jaE6l4W?=
 =?us-ascii?Q?suRJUx2Zz4OiTP4zC7l+t4lOwehliJLNPwso8CMXAP89WL4xBJ7SIeDe+/+z?=
 =?us-ascii?Q?r7ET3ap0dD3q0OSOXqQ1pNcMwC3MuAGw+N2zz4Q3knyjB0FQRJOTa9sCipyV?=
 =?us-ascii?Q?iHDBeJ6ZHkjG2mW/WdMFfVVbv8Q+0BHJtaceuMaFRrF08oa1Ic5c1NuiDuIF?=
 =?us-ascii?Q?vsC5MZmkiIUeLz2dMvaAZMUKwDvSFcEK8Qd2vxueB3c4qJNp9QrWGIhwQYPW?=
 =?us-ascii?Q?QKJwKWtk6xJDcxZn5nlF5mMsHelnds1IueYs/QOGqqo5zOAkqvveLDdGEL9/?=
 =?us-ascii?Q?12AN6fQ75EgAvPbMAQbz9dRLDiTftJ5SbqaqwoYD9q2znjT0iDv/yyFKA1kR?=
 =?us-ascii?Q?aFi2I6IUCpzwJaoqEo3W9BSpV+2jPw9RXlIU6ItMIW8ppvUka8S7cqiIEod6?=
 =?us-ascii?Q?0huxDUs1kI4hq6jbMSNWAHO9gZ8Xa2NQ0GHQYhzUipxhqzN5KKfXxJgW6wty?=
 =?us-ascii?Q?Kb82RA1fHdNHIPTrfg/9faNXVsmi3jnXDJ0Mv2tcmyx/7h/2U/l+/sc4mmlF?=
 =?us-ascii?Q?NpjLtrhRqD5h/lagsuBPTCIe3gpFweNt7YOxNCW0t1T13o0o5KgN7pXnUkVF?=
 =?us-ascii?Q?JYPNvCHVvTcnXGy6oyrVjU4OVT5QLYFFEeYaB+64WPslbuGDRGzdNLUHw9T9?=
 =?us-ascii?Q?LaeCJ5TBySFmX8ETR7JXH35Yo55Sci91UBUii51w1hJu7s17et/An3HBgmD8?=
 =?us-ascii?Q?BVp7vywa5GmIqGOLqb79Tuf9z9R2RiWtBug05W5MH9i/1f4QUxdPlVz75zTo?=
 =?us-ascii?Q?HuM9jmvJqR/Si1w/+H74cBQ54DEMABDJl8YFUWl/w7MvNfogQPkRdYvhofFY?=
 =?us-ascii?Q?NTEavuWAAkL+bxvin72YVWRW4SPn/56J8ux+ttkzHCGfzorSA4ehJP8v5hCX?=
 =?us-ascii?Q?mqIEUFx7h3MVV7SIW71s6uB7dFDeaA+BwF/bNCFLH0P8ZwuksgTuqlBuIDSe?=
 =?us-ascii?Q?21ivyGkU3Ct6pqm8yEkJ5fOd6V2hzUz3cndFZVTZyWU2iZEMWnZIoYAhKUfk?=
 =?us-ascii?Q?bg4fxZNdb+dq2vSwiuQ4NHX10h15xzZQREhYzgFXKN6q/YrTrzUF3X01hvyI?=
 =?us-ascii?Q?ONEuTb8hwInsCkQezjR/YbRexKMNM8u6ZiXuAGlX6mJSu8e6E0ocvXB4/xt+?=
 =?us-ascii?Q?oisdfQGBXXnMPatdnV3ZUDZ5YYw42CSzJYByCc9iu5PkU/EgaCmQJlgZeCoL?=
 =?us-ascii?Q?uaWtnR1cDRc9SuybezsDtz3Z8fKL0NdXIyf25KMsvdIsUZ3Qoj/z+hGp7+9E?=
 =?us-ascii?Q?mBY0AL4LXQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a07f956-e38c-4cba-0ef5-08da3f13dbce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:32:55.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iD7dOIkDZDFhS3UYU5A+wdESdRttYqf9kNgP4dKaNM3XlKQ3GIyBYeL63rd1NLheWh2kK9wxtSt3KYfy6QdwIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
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

