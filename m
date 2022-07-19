Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9710D579444
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiGSHeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiGSHeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:34:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911D33410;
        Tue, 19 Jul 2022 00:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdQHl++ubdupxiJZRkIf7vo8TNu/ch8zYURYk+5x64z4wE5eqEGqDMxuJr1dm646UvnEZOfufRztgnZXXVcPtvQdNut/RUkRlcQvmbE5SuJrYYVcrrB83uW8S6aIxWS3w4/bVwIE37lV49vkD8rxx36g7vkibkn/CUWYmWUx+wajC/BSYH1NO16YYZrH7p+/1onb08xku7qRY1WYOf8Ww92jbBC/SQTAGCI9yihDb+gWqlA0x6KYKzHyuMAdOIveIrPpqz6lXyEIdt1asnxd10VdDqgxUS/RiwTCu2Lr0YJGC6+sbNkpvhMWVs1DrAShGZqvOtNx/loC3IdWQ8iTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioaVtNlKCc6uK4kUFy+KaAPEM5UIafRzbGaHeGUXRYc=;
 b=EcshQ9NmZ3P7q6QX+h/DQTk6pKeQoX3yTLNDhnGLG7yJWvT5HXkT31nec4b/kTaaw0wqpFcPKjxaKuP73mtDve0rCzE1FKnshVDYwI58btcmMkIoc3k8d3JU9Hm2VRFxEKNWzBDepMxK3xlSGCLFrfCqVgchOtLSRnvoxPRJCGNyKDYtmsOTIZBbDWKoOlwe/jLY+J/9BIX0iADypU/3zanUWbKSRSnnlwldZGTPhiewV6kRLweEb9355l8tFVyhC6X9+ZbCV3WYJFBgH7E259HwjjBIXG6KmvKZoC/qWuGpbAas8sP1DttFRn4/uAFjQTto6e7+xLh9B9Aqwhkxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioaVtNlKCc6uK4kUFy+KaAPEM5UIafRzbGaHeGUXRYc=;
 b=MXGR/5fxkSApSkK28QvcQiBGg6MD0MBh3ZzEpzWBw/ZQtccrTW5qrleTkmOUAiyL2Sek71PSfF7Ns9BNe06rca7uglVDW8fDBo+H12Sevc4nsxgTrOPWmt+DdPpIFhQKtjhNM6Y8WYr2NPFz/pKaumHGMmfN1YcE/VQLOlgLwP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:17::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 07:34:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:34:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 3/6] soc: imx: add i.MX93 SRC power domain driver
Date:   Tue, 19 Jul 2022 15:35:38 +0800
Message-Id: <20220719073541.197788-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6bb6e79-434d-4149-bb7a-08da695913a1
X-MS-TrafficTypeDiagnostic: DB7PR04MB4298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqNc9g3/L2fu2GmnL2w/TEcnDoB2y/Z/JRFGO6U4jf8zcx/iKA/e8bYLAk79aNt1I8cbEF6G2Q3B+9q7JD5mQb9MRkGXSNDkKDrxawofpY9LY2VXjU14azcdZaelgDtOnVHGLRyS2mAORM0/Eb9DOERrNzCOr8gqptwqBoUkPD9AYJxAyxUSpJ/ozdr6TxF3TcSVl9HoFs7xY5vsc62lWzw6IgUfN6AoIlt4OHAeTiybpd9zwXpqXsH5RiDHc+fuYT/FunVsCOsnSYDeLsEDJaZytwJCMUbv3JlskFQC/04ENBZeBRGhQKnBukQurwV6+mmgMilOBbJxxfOqC5A8v5Gbdyh+Cv+zdy6yiIPhS4rll7gjDVg6/zFE7Nux7mhGS2yG25vjZ180Y9gObz0eHV3hmV8mWTY7nt0S43v5hon66dAKLS5YfrdgSIqsvtytwZVulCyL7HhzSksCHv4pansiMr+rgxdny+t30fg9Z7hpISSMue1bw4uKkW2J4lXPLckv4MegrUISEW0mqEecMmRqT6rIXWiCH3DYdQ5kcIdizkBPWqAcE5l0xhw8+/Sghc79yA7+b197kPAFgs309cWK0dFCgzUF6w/1vaFpYkHz89pZc+uU2aK61ZX2ePAh23O+R6YcD9rEumniH43cr9qqkL0PcWFKTG1dM1aNTNqlQY0ek1pJrvDANm8feER5uFr6e3eAoK+V1BYK+4/pnX+y0BzVSN9EWaWNu7v/vvT5p9xr6EqxxWrfwl4MI6mlhgkdPsfjvHw0UBdGxkCdXFoSMZlPJiB4GOeoDtqk+U1VnNSvpBU6qljlJxRI9m/g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(38350700002)(38100700002)(316002)(66556008)(66946007)(4326008)(66476007)(8676002)(2906002)(41300700001)(26005)(6666004)(83380400001)(186003)(6512007)(478600001)(2616005)(7416002)(5660300002)(6486002)(8936002)(86362001)(1076003)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0Fs0OgPEhx9JvVzXPIV0zPZi+W4JzQrObCbrep7VFvzutg9LLI6YNt+dzw8?=
 =?us-ascii?Q?J6FRTz+wl7oBnM2GqbDGU7fZ5Et5EAsNljfWoTINi3OfCPzdHMZS7qqOS8mb?=
 =?us-ascii?Q?J3ymWFo5nGsx0yKqoUWGco5ZTrL/4sr87yS2Q7VBzq+wKmlASuOo4GjcCTtF?=
 =?us-ascii?Q?jjBXgRvTsjNCf/54452RABUiuxPz4yf9a1oxB5JUCpPsuvtMRVc4eSoIDUf2?=
 =?us-ascii?Q?VHhLaePQPTaoMQ+VjfnyHAzouwmyRII3wG3bG4fu8j6U9sEFt59bJV1p+dI0?=
 =?us-ascii?Q?4H/sJnemjnPAQXSkDgP58G5+S4MG31TiLZrJwjPGXYKJecF8QN1n6QPLjgi6?=
 =?us-ascii?Q?pwCdKYiJ6ptgjeh1BTXOQ0kJqX3qeW/TLtCZwyb3vdT2CHxa9N41hcp5dikE?=
 =?us-ascii?Q?q+rKdgguOu1Rn53+RkV+71SH3b1n0jx6pDf2mJ/3Fxh+PxaiOggW/0RiMdiL?=
 =?us-ascii?Q?9f7iZ+DLqg32hNM+iWT4/SQOAX86Ifn7pacb1T+/QPiiulNExYN04AUj7GWJ?=
 =?us-ascii?Q?vQTfrG8NZQKDplmw8JkWqQkUdn8VFSOfSLnRjQ6VUYJBL734Ho4xjRnaxWlh?=
 =?us-ascii?Q?jByI3/q64ZagiXX+UK7lQ17ZtLjfJcqC57k4QF1NiVQaN9J99p+vIFh7dRrs?=
 =?us-ascii?Q?SfkcqA0fiV50zqbHgpMKh/R7nHio+UEsMothQPKXv2fn98LPQfnGvZuzv7Ep?=
 =?us-ascii?Q?6j9PYbe2bUSxdyN99++wpbLL2k6Yq5lhWqgoZzDjR1r6Em9GZdTPi3RHnhJx?=
 =?us-ascii?Q?0OZWTWm8pl8ayjsj1zQysv5POaaZ4vZKxcZ0BcJvSStz2NGw3F29OelbEpGv?=
 =?us-ascii?Q?6NrVD2qMwZPCtXQYJKFpFEIO6t89VI1a8kaExyrg+Y5jWq60AfbgVSaNS0/w?=
 =?us-ascii?Q?N7Tnrjg8g7MPvUis+XLjrAHqCiubale5BHZ3XlZsw1eVrTb51VVtaN6THXUG?=
 =?us-ascii?Q?CEdCrw3eHM41jsYk5hx7t68lfKDTIicHMr3nlUyNOPfvAja7ua0VUWryHkHt?=
 =?us-ascii?Q?Za6ovAh52IOv6KAUNwmp3KF7QlQy5cedS75JVq9Q5tGioWYmfauYc80X2fjd?=
 =?us-ascii?Q?uMQa8tyujaywpHX7DFzGJlTMlMI7WalKv1pMSStUPAL075PDC4MeDscTcsEg?=
 =?us-ascii?Q?H1crfUksZ/DkwX9yz5oVSn8fBoXkn3pkDuDmsR+ICbgbQ2bk8RROPbhvMazn?=
 =?us-ascii?Q?pGfwXNOJyeKQV//Auaj/FHsnB7e64zcRmHFMqZp8DsOtOjbMMnjsjbTuesm7?=
 =?us-ascii?Q?c3R+gLWhtU/yl4Gc6WTAFRshVHzTxraJkeJo58YUFSIs7jUA4vaJqbWOZ/TZ?=
 =?us-ascii?Q?1KHYmb2/Rve1I/SqirBM5d68inH3Mac50cYVwJd7w3taagxZ1Z9rAvO4AkUl?=
 =?us-ascii?Q?ZvcHW9ummcQACzd1FXHMmO5a0Fkp0S3n+PBamODoJItbTEC3nBpRmJyEAbTl?=
 =?us-ascii?Q?5HQrah9ISsXuXpdfyhvu1gvvIsWCYSp+2Wmc7uGOSoNsWdFr7BOMfha+ei5I?=
 =?us-ascii?Q?rh0/ijt9b8NRWaXU62pNYL0cYnXkrjmV8EUl/uNU9Xo1e4/GVTXbqcKpqF4u?=
 =?us-ascii?Q?TIM7rQi7HWwbmSZkdO7s9kBZpyoQh+TBrYWBr+BL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bb6e79-434d-4149-bb7a-08da695913a1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 07:34:13.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnkdePlwS/XPmRLbkyylJC7lqelzPweg8ZoE4eCi/mNcUtfLWPdtAE21XIoNXu1ZbbjNiALJyK9LxVI3VuEx9A==
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

Support controlling power domain managed by System Reset
Controller(SRC). Current supported power domain is mediamix power
domain.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Kconfig     |   8 ++
 drivers/soc/imx/Makefile    |   1 +
 drivers/soc/imx/imx93-pd.c  | 163 ++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/imx93-src.c |  32 +++++++
 4 files changed, 204 insertions(+)
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
index 000000000000..48437c303b78
--- /dev/null
+++ b/drivers/soc/imx/imx93-pd.c
@@ -0,0 +1,163 @@
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
+	domain->addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(domain->addr))
+		return PTR_ERR(domain->addr);
+
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
+			return 0;
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
index 000000000000..6f14c241538e
--- /dev/null
+++ b/drivers/soc/imx/imx93-src.c
@@ -0,0 +1,32 @@
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
2.25.1

