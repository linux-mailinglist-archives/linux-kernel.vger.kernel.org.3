Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92EB530F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiEWL33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiEWL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:29:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C64EDEE;
        Mon, 23 May 2022 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oks8pWt/9FH9SvHIWplKDlV/ydQN1e+mXEycXrzyUFHDm7hZYHy6D2BE6xZ3qpm2pcukGw//uhnTNsGZvfJJYD5xtT8PRcklUX62TIIt4AWR/QwnUXYYoizO4cG0QzDyLljQqPdB8W45bC0w6mDaKkpwdoiPnzxFDA9YjQJ0wExj8YHSF66gfUX63Z+K44LXTf2UIvDxVRlPepC6x+Eg2MhgzBzrreztz2S2ijcSVxBFMSN26R3NVGoJWfzXg7eaQgHr+RkvicWUARlj7+8CsoAhLTNfa2ktOiT1bZjJwCQ5VtgyimN4/kidxBrXNHtARq7edlELTxulvn3JK0OyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OctA8AA/HMLuFGkzae2+DvrmpYerQJrTtF7o0ybrJlQ=;
 b=jzcWMS3hMeN3rr1ZZU3xLPs60f3nxC4pgsyUxRjbaqhLI5bgGzHnJ/mhRm3f5n0viiLxF+wD7msNzxowsBiX4OtFL9a+sP2TO8AjsM14bSXg1W55NRIKe1ivC180b7twr8ZpZ1oXZWTPv32CnSguWCS0lrYdth36WNJlAceKeo1/8OI7k0tv8U/0O6c+gQD6oUJmMYeRuZqANOo+jKbY0oaN3hZ4nP8HBC7i1J4X2MBDO4cBnIs2LmW53QnHjDK5W7ykvVxIoMfGnwt5sg7VvhDHlSjOqc72liWwkLvNbTQ5TeLcoVn+Z4orpk9ikmeRnwqRI2UU66AR8udnEDX00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OctA8AA/HMLuFGkzae2+DvrmpYerQJrTtF7o0ybrJlQ=;
 b=Tcrx5ybXFH/51pXRyzGTGcz5fc1jILn5HrYnZh1ZTZAqK8puLAyvUGCdKr1Yjp31pR9GVW9w60UQVsP3BUPwT6/JYCst2R0cJBcteXlCUv05HoIzIYQ8JLkCAmn7di3RWWUzp8dDV1xMmIeq22AQjH2S+VZbeAn6VldrojSlwZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6296.eurprd04.prod.outlook.com (2603:10a6:20b:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:29:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 11:29:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/7] soc: imx: add i.MX93 media blk ctrl driver
Date:   Mon, 23 May 2022 19:30:27 +0800
Message-Id: <20220523113029.842753-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523113029.842753-1-peng.fan@oss.nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 264c72e6-05b8-4ad4-3cd4-08da3caf71f1
X-MS-TrafficTypeDiagnostic: AM6PR04MB6296:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6296B3BE4B2C464672527C01C9D49@AM6PR04MB6296.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZuggCxO/AJmXtuGT/piVyI5z9lZIDKCCwbDkxK5pb8VM6VWsPd7KdI0yCI6iwFNbcQDyqU+zLkHuA4uAuL5SOe8UnbFvVx4SM5k06N0UH23uOXmc8Pyec8+jLTorVid+jjASOixraOk6Le/cZAVxwCHePtZwPGfCH0mVzi2pZQBo9dMj0F85s3XVFd5JEN1A7xmxjPlqaApg9B6cooWhvlBq5mEjYdSgtn/8cKZUAVaAj04Xh2EuYVsBQ+1LqmERGbmcyyNTtkOmdlOG1G+pwOb0pM1C2abS+aC8c2Lw+yujG+DMz7bk5sbvKk/QVDGolxIE7VyekcceSiPMFmdP8QXWebO7wHENxERs4+NCnSF3XWRMuTEQmlEwb5iGHNfPHXYPUU1o2MMxesdfc+zUXeNd6hNkDOXWaiG4WM96f6HG+AX0QpbbnIRoGt+QseENS+4izSczHuCjK3zl7Z9fRQY2vCvx8pHGKkrd3Ro3mm+x8LVhlREt57jyvNF+dBkg1YEa15FYk2QV00nQWyC07SwD4ybeos1E395jGEyB2kWW0aPDhuNReg5udrnhKmf1QEx86uRwcsYSmHuIkvMJabz1GeaKsfjsR8k4fLdRHIVUzejX3iHflXhufo+JLMvyC3M3LBdThKeh+Pudrmsd0K2kY+9QKJitGEwqAeC+VVXM7pGBP5ltegHnlS/EQfLeUkhmbEkakLATM4wL+8kuzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6512007)(6506007)(66946007)(6666004)(38100700002)(52116002)(8936002)(7416002)(26005)(66476007)(66556008)(186003)(316002)(2616005)(2906002)(1076003)(4326008)(8676002)(6486002)(83380400001)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dqizkR++QmcR4cNVyrZVKGnENOF6HwNTal2BeysrFdwajvNuoL7w4too6Js9?=
 =?us-ascii?Q?TFtIFbmlI2YHbNx0aI8uwDRSXgGEjzl6uKIqZ/TL+q+P7+sAvTAe7wCbZV6b?=
 =?us-ascii?Q?5lvFBVRKhc5RcI3dQC0D4Cu2dqPFn4dWNaajgxrNbAtSez4mAJe+foIMF3OS?=
 =?us-ascii?Q?A9Eh+VCdt4DPIhAjiEG7ge4u3GBKEb58wO18rKwXScZfQIduufBKKRG5CrEj?=
 =?us-ascii?Q?C/vL42u9Ag+Z2YzSHCUWrCA5wx0KecE6rwn/uonr5OjhQoxEHk6LgaFrmUyc?=
 =?us-ascii?Q?f3+gl4Y168xvxcUwNaG1P9q38P0qbb1NTeOPhedrH7jm/o8vQqpgKxQaZw7A?=
 =?us-ascii?Q?yb3RmLIORgzEhsqLntJFiLXPfW8BtNotIFGeUH9G2nspZmRKpfNNYQG7mLwa?=
 =?us-ascii?Q?aHqEUUrON1koah6/+z8COwjjQWWCYSAQcE97aMPNKrnXsA8pea2t6R2kfX3o?=
 =?us-ascii?Q?E1552uU5hDUlG92AE22YPwyTgOScn/L/is3vjKSr3e8bd2IBtB4genovOVa4?=
 =?us-ascii?Q?S6G8Xba/57d29itWdBqwqGqbJjE6eNnxbHp5U1ZU7dPiGEig+8OUmgtz+zoC?=
 =?us-ascii?Q?Oga8ioLeZqim2GqaFPQrDhZOVNoAywL0kZ+SdZyZtEOdX1dt+g2ovOOUXD0s?=
 =?us-ascii?Q?00fyvEn0s2qkKwURWS98QWyJymngz4ahXU9fOR5BWL70BQwh8wHHee1bWbvB?=
 =?us-ascii?Q?klcGktjD+LY/MbLmD8ELl2qY9f7B5jhiTsNWKP6lgfqxN2Hu8KC1NdcWpx47?=
 =?us-ascii?Q?8AZgBXhOFISQiOW1uSucVp+W4SBgZilZ/Kp3p1TOntaY9JDlDgAQ/zpBk3Tq?=
 =?us-ascii?Q?SJgqgAyWVCR/aSLIwshqJTzXVlo/Vig1QGw3zdKNCnKJP+lruYyOsAxQS3TB?=
 =?us-ascii?Q?x2Ut4VuoDAhxr3SzzasI5lKkBrohTp0zgfS5OrHvw95LrUOpFU18jOjKgqF3?=
 =?us-ascii?Q?vedPd7jCh9QeH6Xolr8XnLqWhNeW1kmVJ0l6ouKBZVldY6p0Pb4nsj2BuEbG?=
 =?us-ascii?Q?+1tOAw0Qg3C458LwuuQIq4A/sU+6FAj42LiFijnLsduam1G4Bi2tuWxrw9e7?=
 =?us-ascii?Q?OKLZ/Zi9ljOcJQx/Ge3D5k1Zi3UKokE/C7QvtvfVBUq2urhnpUPw61lDKJsO?=
 =?us-ascii?Q?hDYDb2rFROFHygdWZczD8sGx0Jl2mdUdcqPNtovO9IhJ1jRtonLT6FLilKuH?=
 =?us-ascii?Q?eNBT0UMgQd7heI5UsP3DT3pxRfWcFMPdjN5/dGt9IJBdX1mkxEnL6vqR1PPS?=
 =?us-ascii?Q?xfZSGLdfjbSizYuANTCV9sAEM8XTLikiLMcnXLIVB5Q2J1AK3wfLszIxRakv?=
 =?us-ascii?Q?iORXzXLsis0SZoyK+1xjGoJqeAQIU5m9dKGK/tSC+6N1q8fca+IuiZ7qpb9o?=
 =?us-ascii?Q?MOSUhGmjAy1GB/uOqOd19XeiuiHu/yACDME2EiU4GSZ6HynxMM2nRJMxgg0m?=
 =?us-ascii?Q?klmjAUHmWUdut4HJJbu+qq9QHrNinyQgAklx0DJekRME+z+BZJUJO5tpiM4o?=
 =?us-ascii?Q?is61BGdjAgroimOgt6VbsPCpDUE9ARGgpCEN+8xRmV8JSOnb0MyKK9lumhA6?=
 =?us-ascii?Q?AKurrUZcJ0w2+hTWjUfEmKgd75tlf1S/9PjmJJUbrl8+lobqDZpG7bmObC+B?=
 =?us-ascii?Q?lZIbPB9gYkaf3T8pQ/IjxkSGsMS5RFBNkTXAT48B7hyCN5RwHfEoe6s7R31U?=
 =?us-ascii?Q?J1yqRwzvULNaACpAvHNaqLNe5y8GF7ZLoOHv+RTVw3Y9uGYGKn2FvRQjg3SI?=
 =?us-ascii?Q?ObX/S8ehmQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264c72e6-05b8-4ad4-3cd4-08da3caf71f1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:29:05.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+sQ8rE/ujOe2xMuX8z140EEwWfy02DNd3shu+vv/SULeD66vDd+sD3wxok6YhNXMwFRoHhfhcvqTQMTceJc5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6296
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

