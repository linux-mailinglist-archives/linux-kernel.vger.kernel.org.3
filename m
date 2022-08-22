Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8423559BBA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiHVIaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiHVI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:29:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A34425EB2;
        Mon, 22 Aug 2022 01:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDTRC++rd5iyIo/qtQHHVInOsH1egK3qEudsKRGu/H+gX5+/aiTDareoxAITihwGNo1qbAHgVnBTcaGyOV/JjRhlKxUiprvtI+2SD+DhgHwHv8cIIogERAjxUmIQDaKupSZTSFEGVGOQ8Y70Be+J+k0lfLo6cHu5RjvRvWueev0I5so1dEDTeovUhg6qLDy/OPu/Rr1YJwIsQPwnmIA3nMalzzDAxfaeLU1pMTsuZr5ymbHoh2fDRd/yHVmdMXVRP8IlcKPpj/YUaH0puFZhYt/URU1FnOyzDP7qYudEwc5d3bMmyH/33bZQdh+HbJAUvAK42Z71p+jeavD7VflsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsCaRBpQ/Qo6ngtFJicRPgXAFRru6zsj2tgUwW/6xtM=;
 b=GlbzTCbK6l1GBuJstXmVMF/IPEhBh7EBT3z86HvioUyH8KvVpl1h46NpITgOQiVfCZwg4bYeC1YRRr9Y71uilCKWUQ0IXI3EiTcr5DxGO0vFaVeTQQ2nTSSm0MCYhJUUuyAEJFoF31oxjC79XFTFatODJ5YzHenZ75k4JuZvZ8RW+pEauEgBNiIrBEF1LUSkcco2xZikhy4CRKjrEvPGe2kKqtDecRIzliyf6Iitn3qrgkEhcUReFeUXsDJ4V8VWtfaaU3a5lHDE2+4G1MiiD14KEkZexmuVSmGiE4bFvjlBWWL49c/Wgb3Gs0kQ7B0Dgr9TXz9aLQOqwiMtYTe4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsCaRBpQ/Qo6ngtFJicRPgXAFRru6zsj2tgUwW/6xtM=;
 b=l/fe3wYM7DYZA0h/lQqUe9Yl8n5zw9JlsGUZcczxEVY8RIvkSyHpKrpU181cvIGh5V2JkHOWqzpqq9Old+CeykFVxfwy/3qC9qVEo0UpWUr3xNj7m9Z6PCO9xP71pjA//z9pYhwDUy4xUyDbHEqoGuncOgDFPqKSRDY7sAEu6FA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB3997.eurprd04.prod.outlook.com (2603:10a6:803:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 08:29:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 08:29:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 3/6] soc: imx: add i.MX93 SRC power domain driver
Date:   Mon, 22 Aug 2022 16:31:03 +0800
Message-Id: <20220822083106.156914-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822083106.156914-1-peng.fan@oss.nxp.com>
References: <20220822083106.156914-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1bac5f0-22a4-433a-a042-08da84187564
X-MS-TrafficTypeDiagnostic: VI1PR04MB3997:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AMj+wwIHFwDVCgaSuklTX7jOGknLdq2BR+zNP7Ocv7fjvVr9xCs5WHyJL+fUcyYpeLL/6ORqtY+zoGF8GtJDrl409UOezKIVP3FXqhIN8yT7yq+u/3Dwb9FfNoAzz8IukG5yR3Wf7cRjLpqThp0OY9ePOlpczbQSL8w26aB7uFQJZ6SMm8zVp7z1flXYQaiKg/Jg00a8Za6iFupK8vsd523HYldGz80IM6vezMEV5bcMPd/tOvpz1kQLVtMR871ZE8gTPKWzoKWMHo0Cl1rOhCrQRbgB7CIWb7auWg2pc+w5ktjFkGYXPdlgihMSgU3WK3WeqRi8TKk0BTjYUnyV1smQmMZsWb2IE6JQvj/gTaWGAE9xeelF2ECEJULx7kNTKoOmRTpDAGjhwKeEm9rdmfTst7Midg3IPZyBDCZSbBh/xPcxEfjLpDFmNy+km13CWhusWLX7DsXKOzlAGhcFrP9u78lsHLdGYb0V57oucml46PihlC5xmXJJQq7YIlmf31Dtm4SlEaHeLKTx5c4XvBk4g4DL3gS8hyS/wGk4wyVFbFelIOKkHvqLV9OoAw+6NW0HaLKbpILRxhx0lYrKRy7jWqrIF0RnrSOPXCKrZXAPuQgQJ7yKbn7ZY+HHrMyysU15C8zNLpAWRrrNfNzI6Be62tLHj+BDVt72Jjp31YEGXP82G06xx7eKbpxBnAfcaXyX4qlSVYH7e6jShxKDRe8HmvIw+omvpqMrAs/9EwHHe5rwdzNksoPRMOgarf5oHRVR7/MBqjo+bmNpGgu8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(83380400001)(86362001)(38350700002)(38100700002)(66946007)(66556008)(8676002)(66476007)(4326008)(478600001)(6486002)(5660300002)(8936002)(316002)(6512007)(26005)(2906002)(186003)(2616005)(1076003)(6506007)(52116002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90lKwrbNSeTDar0fTuM1OVCI0nOExBkvFU0RHm8tLRMsCTlYWIyLjlYCC//7?=
 =?us-ascii?Q?DM+VqA7wtZjctBsoNSr1NpQG4Ry3hk3eCjSPMeqlR1HqCJ18dtMbAHLBFFCG?=
 =?us-ascii?Q?6CUxblM3/dlFINqBHy7CuyWVAoQhShhHHc58dz1isENH6igVDEDGx1i4tkfs?=
 =?us-ascii?Q?fA6tMMN7OaeVGN7SFtlJ4Pp+BQRveX255S1Ltgtdds178UK+YZzHJ3d7ZikO?=
 =?us-ascii?Q?qHoHq13akIbhCnbgDt+DwrudUck65MqIhr3oAhHavSjpu9w9VNuGMWpkUCdw?=
 =?us-ascii?Q?deFUXRt0PGgDso1GwAfyBNqO4+8ddi76+PT7xlLaLCEpHv7clq/xQfHVdMiq?=
 =?us-ascii?Q?he7mP7t2AXnz5y553g+TpnOhupHeTAFEFWNbGtnRox310XX0o3Hoy+KsB/d+?=
 =?us-ascii?Q?TWzL2pImssebEHSu4XE65Dd09w9yq0KuI4ZIXEmdQaONA1mEXZIeumlz+o7e?=
 =?us-ascii?Q?+DoVRcRqnaESsjd7eUMV+ros4F3FxlctuVRjOdOhf3z8HH3ZkutBOufkD5dk?=
 =?us-ascii?Q?pzeXRfWz/efRa/XlIVmSjIIngtESd2KeZMYaDTBkwnpDaRPg3f21rvkZd7bg?=
 =?us-ascii?Q?VItJTr36E0vkeDk/KblzzP55zyun7IMtrYq2NOVctzMbnSDz4NFiCq/CUYKN?=
 =?us-ascii?Q?3vWCarJvOBwakSIvnbEXrl52ju7jBRrjCn0N93hhb/eEthoE4Df/7+/wN5qY?=
 =?us-ascii?Q?orvA4sUjHE0cZbwNJNL4cHYcDYdVCrLlRpW9neP98EKYuozUWgzLR78HPBO7?=
 =?us-ascii?Q?IWjTdnWbadzB4OHcqSjgZEpFjKM9AQABkqZLyRIjg5oY6bTgJBn1A6Br5+wK?=
 =?us-ascii?Q?H1GM8TdXm6AgGCMmH5gnHZxvVYjUxBb5iheSf25VjctCeusvVtv/hwfton/+?=
 =?us-ascii?Q?EZEUd0NKO6whs7bGI+450sRdtq+2bK2wRuxDsWlpOg7qQAt8chtCZMJSqydK?=
 =?us-ascii?Q?Em7XkZlqTnyyNMUNVrYyXeEk1bLGY92EPohuja73wFs0KgOih7isk597eby6?=
 =?us-ascii?Q?wOk7iAQzXJkTx6VohOuAut5+qMzSz6TtHz13iABuwqPVX/hhjvYSRhKlWS3g?=
 =?us-ascii?Q?d2fMA/sgJnzv/s8yui7Ox4kE+CIf+dfrZ7B55uqef1RdankK6P8bUqEH4lm9?=
 =?us-ascii?Q?wxR+b5SsBgA49Dz6MxLyfUWR6dSWbuU2OT2UEUGX7j0WuxOzPZltyugqEgq+?=
 =?us-ascii?Q?uJhFqRCO/f/4cv6IzgcbhcVRLszthPP9la5iTQUtzU3c84A/zA8YAbe/YhTi?=
 =?us-ascii?Q?wJVYKX9+asWEI2FpY6WPl97uaOJ9+FtJ7He5KsCrW/cCUmly5Kbzx3ZfJ15W?=
 =?us-ascii?Q?FvNFWc7Ax/xOjFrtWzRZZYoTJGXDaFq2Qm2fXfiCzV9W7BonFcqWLK8Y03FQ?=
 =?us-ascii?Q?wBGb98nk/6Wk6eallXuBMJEC7NpZYCH1WrLc1n3vx5RB9nAieecXFMikvyI2?=
 =?us-ascii?Q?ucm/bnVETJoWFFH5pfWFnmvuJcUK0v0Vd+TOcZjMhgFZg06az+5YkIKT09n6?=
 =?us-ascii?Q?tguVnP7VsbthrLu9iaG9gPguj7/Apg2d6bs91QPRtDEfe8roPvoXgulE9GsD?=
 =?us-ascii?Q?ZccpSodm4zWv9K0uPungUmV4TobUQhAmF3XqGg67?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bac5f0-22a4-433a-a042-08da84187564
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:29:41.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCfBh17pqekN62FksdliCvE9xdACrb9wJTd+xQNDodFHJxNQeRM8lri9VlYZlBJjdZNHysGKkLiKFPmw/T0VuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Support controlling power domain managed by System Reset
Controller(SRC). Current supported power domain is mediamix power
domain.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Kconfig     |   8 ++
 drivers/soc/imx/Makefile    |   1 +
 drivers/soc/imx/imx93-pd.c  | 164 ++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/imx93-src.c |  33 ++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 drivers/soc/imx/imx93-src.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a840494e849a..4b906791d6c7 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -20,4 +20,12 @@ config SOC_IMX8M
 	  support, it will provide the SoC info like SoC family,
 	  ID and revision etc.
 
+config SOC_IMX9
+	tristate "i.MX9 SoC family support"
+	depends on ARCH_MXC || COMPILE_TEST
+	default ARCH_MXC && ARM64
+	select SOC_BUS
+	help
+	  If you say yes here, you get support for the NXP i.MX9 family
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 63cd29f6d4d2..a0baa2a01adb 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
new file mode 100644
index 000000000000..042a89cb53da
--- /dev/null
+++ b/drivers/soc/imx/imx93-pd.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/of_device.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+
+#define MIX_SLICE_SW_CTRL_OFF		0x20
+#define SLICE_SW_CTRL_PSW_CTRL_OFF_MASK	BIT(4)
+#define SLICE_SW_CTRL_PDN_SOFT_MASK	BIT(31)
+
+#define MIX_FUNC_STAT_OFF		0xB4
+
+#define FUNC_STAT_PSW_STAT_MASK		BIT(0)
+#define FUNC_STAT_RST_STAT_MASK		BIT(2)
+#define FUNC_STAT_ISO_STAT_MASK		BIT(4)
+
+struct imx93_power_domain {
+	struct generic_pm_domain genpd;
+	struct device *dev;
+	void __iomem *addr;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	bool init_off;
+};
+
+#define to_imx93_pd(_genpd) container_of(_genpd, struct imx93_power_domain, genpd)
+
+static int imx93_pd_on(struct generic_pm_domain *genpd)
+{
+	struct imx93_power_domain *domain = to_imx93_pd(genpd);
+	void __iomem *addr = domain->addr;
+	u32 val;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+	if (ret) {
+		dev_err(domain->dev, "failed to enable clocks for domain: %s\n", genpd->name);
+		return ret;
+	}
+
+	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
+	val &= ~SLICE_SW_CTRL_PDN_SOFT_MASK;
+	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
+
+	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
+				 !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
+	if (ret) {
+		dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx93_pd_off(struct generic_pm_domain *genpd)
+{
+	struct imx93_power_domain *domain = to_imx93_pd(genpd);
+	void __iomem *addr = domain->addr;
+	int ret;
+	u32 val;
+
+	/* Power off MIX */
+	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
+	val |= SLICE_SW_CTRL_PDN_SOFT_MASK;
+	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
+
+	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
+				 val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
+	if (ret) {
+		dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
+		return ret;
+	}
+
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+
+	return 0;
+};
+
+static int imx93_pd_remove(struct platform_device *pdev)
+{
+	struct imx93_power_domain *domain = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	if (!domain->init_off)
+		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+
+	of_genpd_del_provider(np);
+	pm_genpd_remove(&domain->genpd);
+
+	return 0;
+}
+
+static int imx93_pd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct imx93_power_domain *domain;
+	int ret;
+
+	domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	domain->addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(domain->addr))
+		return PTR_ERR(domain->addr);
+
+	domain->num_clks = devm_clk_bulk_get_all(dev, &domain->clks);
+	if (domain->num_clks < 0)
+		return dev_err_probe(dev, domain->num_clks, "Failed to get domain's clocks\n");
+
+	domain->genpd.name = dev_name(dev);
+	domain->genpd.power_off = imx93_pd_off;
+	domain->genpd.power_on = imx93_pd_on;
+	domain->dev = dev;
+
+	domain->init_off = readl(domain->addr + MIX_FUNC_STAT_OFF) & FUNC_STAT_ISO_STAT_MASK;
+	/* Just to sync the status of hardware */
+	if (!domain->init_off) {
+		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+		if (ret) {
+			dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
+				domain->genpd.name);
+			return ret;
+		}
+	}
+
+	ret = pm_genpd_init(&domain->genpd, NULL, domain->init_off);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, domain);
+
+	return of_genpd_add_provider_simple(np, &domain->genpd);
+}
+
+static const struct of_device_id imx93_dt_ids[] = {
+	{ .compatible = "fsl,imx93-src-slice" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, imx93_dt_ids);
+
+static struct platform_driver imx93_power_domain_driver = {
+	.driver = {
+		.name	= "imx93_power_domain",
+		.owner	= THIS_MODULE,
+		.of_match_table = imx93_dt_ids,
+	},
+	.probe = imx93_pd_probe,
+	.remove = imx93_pd_remove,
+};
+module_platform_driver(imx93_power_domain_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX93 power domain driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/imx/imx93-src.c b/drivers/soc/imx/imx93-src.c
new file mode 100644
index 000000000000..830cbb9541c1
--- /dev/null
+++ b/drivers/soc/imx/imx93-src.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+static int imx93_src_probe(struct platform_device *pdev)
+{
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static const struct of_device_id imx93_dt_ids[] = {
+	{ .compatible = "fsl,imx93-src" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, imx93_dt_ids);
+
+static struct platform_driver imx93_src_driver = {
+	.driver = {
+		.name	= "imx93_src",
+		.owner	= THIS_MODULE,
+		.of_match_table = imx93_dt_ids,
+	},
+	.probe = imx93_src_probe,
+};
+module_platform_driver(imx93_src_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX93 src driver");
+MODULE_LICENSE("GPL");
-- 
2.37.1

