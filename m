Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A95544C8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245480AbiFIMu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244368AbiFIMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:50:03 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30081.outbound.protection.outlook.com [40.107.3.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5C13B8F6;
        Thu,  9 Jun 2022 05:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCe8oBCICmInn0yu7osS8q1BLlkmNCxwQ+CUhhZQ5VtbPCWwo/CU/NZr+N9Z/BRUpLnIdyzhJnAmbut57j0HjiSBRCxOkyyz9N/S9kpQTySHYTfAJM9JVc3gtBoFoSG1J134ygmGUya8CxLsNxj9LTJNu9Nii9tihCpLR6E2zYELoRPoCQBvl+72tiBOY95KyE/03sFP+p8bOfNxDQ9cFq+rfH1J6ZZTqfYea2EVk7ShKQTX9GBv360xIQfUoP3HbYnePYQ6Y3oF40XrwWTyKco8Vt9lxhwbzd+phMBmKDsPx2BfCQGqiUd6bkXUdFsSUz0eDq8q+EQhKZVmKTfibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqGoqpBaSs2niTdrQf53Lh0KSihjbrum8Izxy3UI/F4=;
 b=ZA42NOPAgYy5YxwZvSdgAJvn/i7rjZUXhkgm2MrvSQW3lpkRNoBdjUxkKOHQk2tGFBFGVRG7iLlFNUn2wnQ5J5QXo+vUCpbnDw/RGBwpDjUql96tA12jeVRvziWGi206wKxOwmkyu2AcsRF7diNvhm/CY+HrXwHCJCR5TINdyI6XNqJgGL6QbWAjD2EmlWDg1eLIfrP0+e3VUj7Zb1qTxKvrAyfF4pTsmvCMMDk9oc0haTtiIlOAKUZ4vp5FeI6rzOFzoGqekDoxKPMoxFlJOmvCuiO5bp3wo8BmjeReXeTeZE4l6kycWZyLtfBHlpK/dMo4i3iajf8ZOz9xKmBHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqGoqpBaSs2niTdrQf53Lh0KSihjbrum8Izxy3UI/F4=;
 b=A0a9pH9VQl9faQ/utlFyZI+ygb03eG0kYa3RcrC/mX0ReCt+ZW8Y2OmAN3k7fWVCpnF/8yDZwQoTmlQf+vzTjSCp1+/lbuSkHAY3vyyCty/sVs0a6UwmcW/RKavNf0LJC3McupB6JGuDvTvf/u3FuE6JZgd9RdX2qqHE+vN4t9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 12:49:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:49:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 5/7] soc: imx: add i.MX93 media blk ctrl driver
Date:   Thu,  9 Jun 2022 20:50:58 +0800
Message-Id: <20220609125100.3496633-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69b3b66a-d0e6-48b0-c235-08da4a16842b
X-MS-TrafficTypeDiagnostic: AM7PR04MB6952:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6952989BB0CB6883E9303305C9A79@AM7PR04MB6952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqZHy2QnxdBMUvYhIqSQ+EqftSTDLei+QhC5sICjbJU21UOOmFXwk1tUAqsxNs0FIk5O6iCydHjsHfmoiViQbWzEmuDGxPtHru9vOr91eN39AHbK0PBru8p9VlP8lXT2wsjk3Op1Cj+a+IMXZxFTQrhHOSZDWDykPkhJSa24Q/nS7rjfuN7tLYFRbpQ+AvPYefI4N8mR9hh2+rOrJ5DpwWuv6sN2ixseYbfadUgcH0ep6FrrtiyuiZC2706rq3NQPxEG8HFnjXS797Uq4GrpV7fgSd7N4LtAeiS8J316jEgJYKuvWW6b1QYMFVN1lslxAN6ehpIOXDzwJb+j4EX/rYP+556x2ZwgIo9T6HlcfopLpANhR5Bn8bqrK+j/X7oK+lHluFirJg1cNdR9CC4dm8VnQJ3wpecIo9O6zm8ABuP8xro2UVjaaDlyXbEgqBu3bIsVfBQ0GdpCjmhb1ymtae3igOFL0/UE132Q7DinXcsujNUhl390HXmHlG4O7UEUt+lmvJJ7xWLJPhMk21DWFAydpjd4Y7M6LYGG1qgotm/+c7gENN4xAN+sQ4QOn+Ai8uW+HSf9F9OtyVGvqlrRtAUwihezZt6YJuBFRslUjaHLPYsP6nQ9oE91B7CmrOLmeOk+83bvm/Y/WwYACxuktYP1p5n5dPPRGqsEfYLGWL7BIwDREamm9BB0+dzN/s/S1MMZ0TZbaWqARuz16R3fKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6512007)(66556008)(8676002)(2906002)(4326008)(66476007)(26005)(6666004)(6506007)(38100700002)(52116002)(38350700002)(86362001)(316002)(8936002)(2616005)(508600001)(7416002)(1076003)(83380400001)(6486002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?viSo6M8kxL80NZcCZQBYl2xLx6MoZ4zZncnk+yeo2DcOYRvrmBuLuV6jO0K1?=
 =?us-ascii?Q?SaxdwCaaN7fv7kUxUlGKDSLqaD9YmZn2TzbLy0tWl45q8XRncATPL25VFNZU?=
 =?us-ascii?Q?k3lyCsmFthJpLJBviXC3+SMW2x022m/DLPB3snsKWtNBsA9JyVu9skbr8xxf?=
 =?us-ascii?Q?AaoA0Lj6BZ6CU5kWClX2KdYoC058uo585xxxz4Mt1FGfyDYPzzBqIbpYMBn2?=
 =?us-ascii?Q?0r5b4GeRTl20+TRa2S5fQI//VL63JmCUvWtIN9KHHKCxQhu3M+GK08dRCPgG?=
 =?us-ascii?Q?+hIq9v9KqG2hh/yhOA9H5WgdvOvgpD2D9+45i8X6WTBa7SSQvgxXHdbBt0HW?=
 =?us-ascii?Q?Z9HZJlntvs12QLGs0rhk5ob2ZuxAIdDQIEm7Lyu+78TWA8oAnH//y2zq/Jcb?=
 =?us-ascii?Q?ZbE5JfxJ0KTuKPQgguuQLVpUwufRUiqOMEvUS65o8kBRcfR8WHwDdDDI5ARG?=
 =?us-ascii?Q?T/ZcPykHGFx7/ui5/ZP3b+2kNCVcTOIEQTEypkTtHc5+BOWgW1csNEPMSgq2?=
 =?us-ascii?Q?vepFo9P63+ccUXtctEW/DAERo/KgJIqDUPOnLC4fvTTln8mkDiqsp/7IR+EH?=
 =?us-ascii?Q?9C7992OFCTTfgf4cOjnJ3JLSM7I3N8MV0C7CLS5dbikdhmvboF2agF99gTgT?=
 =?us-ascii?Q?hi8FxfZXE+6w1jjxTs01PT7jQ9sN7HA1NnrB7o0MQDZIRuOcZmIpypO8ftY3?=
 =?us-ascii?Q?goBIR9moBzEmfuPotnGghzlAtRzJARo+Byg3CrLSYrSXVoxfKo4QRj48OsgI?=
 =?us-ascii?Q?FtoZGGqIG17skSS3CjLkDYfJqamqsVAdVMYwXK5f15UQamVe8FwBo+rShc0u?=
 =?us-ascii?Q?B36HHnu2w28NWpkCwpxj2F2lk/L1Gg9erq1sTj8PFr7esUzgURmBb74XnJke?=
 =?us-ascii?Q?P2HyxAxAu7HqDNgcpwdZG5hQxGf2MKIZld7Sd6h5w4HaaRzqe9xPMySwRmUn?=
 =?us-ascii?Q?jTBuuuNPzzcFYVekMJNKg6rK8abD+aLf/L8a82H0FfmQkHBodOFB6NMUDyWJ?=
 =?us-ascii?Q?U+PI5PDtFFVfG54p+dL6hkIpse4KoT0qfETUwX5PFT1AfiLnVGNx3mrUwNBe?=
 =?us-ascii?Q?N30awwYXcbRpOtOGoBF18ZdI5p8PIIScrP/Lx+AXuHstRwcPbyK4HrxpOno3?=
 =?us-ascii?Q?APlZNBnjwoyHDLDruLyx3sQtLKkT/msDIJfc9Mu2XZsijyDg6Zs+F7Pj0H6U?=
 =?us-ascii?Q?2JdCs+mPp5cGK4WlD4378uwZsPuvBDTr+qqJBvgxwCQWw9g17NaQfemzrNzG?=
 =?us-ascii?Q?x0rN+AoYqtn2lavRtXhynIYgP9rczkvxpL3QwwZJWxlo0oID9jFbiJ8oyw3n?=
 =?us-ascii?Q?WQyECC+yUaNpBJgivsxRL9swZ8IiT7gMTzUjqMGYO6vb/gD3zcAdrnju2xf6?=
 =?us-ascii?Q?f6guounD55YddSnkGHqFr+9fHSKLVkjRKe5x5pxSbcnFU6a4hs8aTmWJc3uP?=
 =?us-ascii?Q?fx0cIqS2cNJG8UmABqsd2cPLB7+U99Tv6n9jgFzXLviZQRXV+niWeDtlM58/?=
 =?us-ascii?Q?lYNwckQcdJvaNaDy5A56WmEJb1JpS6Svtn3V4O4J18eWwzy4rl/EugxjWd7N?=
 =?us-ascii?Q?n0LNBvsbinRVMakvkepdGEnRy7PPey8IiiFUB7jk5ddUnUKaBBrwQtv04n4R?=
 =?us-ascii?Q?ORJnvlx3bqg9m8lBhFHtffRmxcZysXgHZUOIYBteFRrLPkJNcF7RcRaN/gFr?=
 =?us-ascii?Q?oi25b65hqcfz+iEcXV/9ZpreLm+sPtyMldJBK1JInCXjnaEDC8izhW1Di0g/?=
 =?us-ascii?Q?tozPk66GWw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b3b66a-d0e6-48b0-c235-08da4a16842b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:39.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsL5JCXyp/HBlm5ELbNgmZL53jB3k8dXcRxaHlFMRdx7pDfRilcJjD0gTb5oVS2l6/3T5Ff9RdFOsESS2bVVDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

