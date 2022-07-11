Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E756D49D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiGKGXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGKGXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:23:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E27193C9;
        Sun, 10 Jul 2022 23:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrFtui4wmQWKfrTu+othYMdNnOnXaTjgwLdwTEeXV3zJPSb5RpTdvpcQ4tHiOUZUiRewclN76ZtH+QARJ7s2rYWC4FKVEalTmpVTPnkGk7pW8DLnYu1P6uWyjA8/gxNdmcvDPcjR+MJqiLBliBbBP2egwzVPsmbjWGXWN8T9glsGLC422G1/qrovI2EXDykvw2XONRAZ+wK2U0iQlNJkbkmaGmck7LWHPMKYo0daJoBoD5yTOPcRAnHCK4ATxzW9PYwGYz5Bj9/2Zu1DV59fyM5Kmj80w4cRbexDQrcU6z7KNdZy71sb6xEZPCwX1RP/2AP1YCbWsFjjHnYk2OXCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPhszB33Anic2jPAogYHbciOPr27jryovTlCbmTY8CY=;
 b=npvXOVpEWmreuHSpVaDmc6X76xoFlloXoAhQ1SW57yxehiV46hDuC8u5If15+yR+bNVY5AxZkr/gS3QJoGoVUDXqiyDYmTGpnOh7crN5eaq2EYB0uWX5cmq0UY5d1W5uwpjMFRjTmpNYs2cHO8szkA4ARNGFEYL82MmnyPHkUoI5X9ORIw1EmvVo1GQ6IWz3Ur5CWE4fV6ZPXIoBpQDSYUHS+YCJSamL4/wh6AyyS7luZD2cS8oZGttb7qwKOJSZIcx3CNq74v2oWeA68ep/2PuiS5WQaB8NMuJ1XpDtesSgERwBS2uzLuGyWgO06NzI7UVfnsS8r3AXlHRcyjly6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPhszB33Anic2jPAogYHbciOPr27jryovTlCbmTY8CY=;
 b=f5W8guYT+Tq5gODeKZigiHyPtT3R1CtWwkpsYdEo5jG5g37SbrU02A4DbUP3vDYi6MLaxbncV+CmsspTyhQpBlWC1kMkihKiz4khRkpFbrktT1ES8A0tihJvmThub88/z8Kr0rsfrUAkKjdUjLpL+7yROTDYLusJgkjTj8jLzQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 06:23:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:23:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 3/6] soc: imx: add i.MX93 SRC power domain driver
Date:   Mon, 11 Jul 2022 14:24:49 +0800
Message-Id: <20220711062452.3575032-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8c93b84-0d20-4af6-4f23-08da6305dd10
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udRtE4INmxupQ9UEleRqBnlTp+D2KLACyBWtUG4RpJOsgmCKsnY2gJtznAZEndlDBiGgbeFfejbc21D5+Dk9SnbzzunyMCskez3KPfNcWIuVhFdj1Xl5BaG48qRqmYUyI8ENirMomk5Rh0iPPxB/KcnfsCYK0zDffk8sENade0pnqcbTSRGphElJr+c9cdaqkPfFWxNQRFbYGPlC4+WexhxQCeHB0YIXpFuugOH0mduSX2SyYgdALNCKhi8JZR9uIoptPYASXG/Jp+ziTJaJ4f/jgGUc42xLKfdJYOy51o3b1Yw9Bk5KSNbTeAGbkPd+YDu089cCY6ugEB5/QdK+ysptkfRNV0KapRGEDKO8Z0Cr9tZQrVep1/X/09Bq8qjPF51o1Bd6ktT6rLXR3SqC4AVTWWraIPFyvW/eh93HuOT5x0BVTX0czUJR+Sott1zd56D2ziCsJ6Fo1+uCbcfc8sb6m6Q1464+Sq1eOa/iDVTYOJ+qlCJXK7Rjm5I7QHWz9o7yAOR0IU5XUFhAbJ+m8DgzV8kEAsJH0f5BhL0WnDU/Isk2mAwj0lnx8uz7OicPN1901RrDjoU9h4gUTScAZbxImOKoCgf8r57obv79U+jJoxIP4tQBbitPO3j/LZ92bjSFtAE6nWpTjoDkFwllQhvGaeMgOKq+/kakG2AyrFbygk6p62RAqidSHfBhpCRdvoDafHU16uS447nfns1hstGMeP0ZROY9d4KO7sQuvu0HQiREFf6QsPnFTBola/WDazHeCYqpJ+xskiuwdHHse5GpC4YLTF8SiEEASjvMeMB6sD4YW8EdvN0LXeOgIR44
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(1076003)(66476007)(26005)(6512007)(66556008)(4326008)(8676002)(8936002)(5660300002)(186003)(2906002)(7416002)(316002)(83380400001)(86362001)(478600001)(6506007)(41300700001)(6666004)(52116002)(2616005)(38100700002)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T6cTvYfTQDHVspqsGLw2GVV5AQHF2ZoTgUvoJA1Ij3xqeQ4pv6F3Zd7P0eGS?=
 =?us-ascii?Q?hltmbrOQFgXmzemfRUA6qhwYjVFdj3lUUt4PTDp2xJwoJxnJaIPDflk60/sa?=
 =?us-ascii?Q?l/BNTEmGBGbe1UHAqLgLmLwz2AXYIkFsoIr5I/1sxnfHDi6INjh/1RwLsFyP?=
 =?us-ascii?Q?a6TOREzi6ctvFS+sHEXt7ZicCC+fr+GYHiD0feRjRLM1Aw2oF4zMsIbhqyIx?=
 =?us-ascii?Q?DgcmfXT0K6weDpfUqHMnGVPJsTMq4ra3G1+Q3Gd75nvqXblBfJUNIiDYCaQ3?=
 =?us-ascii?Q?sMJnwMlLEGvJbTBplfjY0jTPKFZJ74JJ2EPD3c6cXGVFlvWYIIujn/XdaL1H?=
 =?us-ascii?Q?G8772dI5lgMu96rdgqFYwT0y6TqCRjcSP4po9eCTVa5B/JwjTQoZdjM7tBme?=
 =?us-ascii?Q?1P1x/dBv2OsCymbnwhSafh+Svulef3q3t6mk6JzOfwqrjdWi6l+LR5qTphLI?=
 =?us-ascii?Q?Ixulbn9hILmCeUHWSm/l6PyeMsLHRipSITDrtfAGhKyVp1QVtHI+XgrXV/UL?=
 =?us-ascii?Q?uL6i1Dgv7oZRzcveWzY0w4kwX2jR3duM0JN1AMbaNAe2+oQXMv7sm2hUdCJr?=
 =?us-ascii?Q?LJaNiymplINkp+/rdj4wqWtPoBDdKt/v5FM+AmsfnTUue4Hk335bzEl/PWmm?=
 =?us-ascii?Q?T/onlyRmzLvlPaGVlUfpQvWGahxeMamJl7ZAlEdZHtpbYENKW/RC2sabZGwB?=
 =?us-ascii?Q?lkfB0NlykpixCxfaWm4TxfcdPeRfBxQdMH6DepLyabIf9E66OyEiMaXcYAbq?=
 =?us-ascii?Q?s2zc4Ji7KCO0sYbotz23h2hlinflgDF91N3YqHctdnlV1nsTarzwfmdaKp30?=
 =?us-ascii?Q?ZEIK/bv/Z4E9VUw6IyGS9aJBq8lr2SWslb37CP0jznHgFgUsreJqSCBfT0Wu?=
 =?us-ascii?Q?ZeRc5XeUiurJx3T8q+gz9KZv+hdgF7Byo+9B6B5ualumhYNFhAzyKeuVJvdS?=
 =?us-ascii?Q?p06IzwAt7b4REkyRjHXJH1qvAe8YYDOv7KoU1k6VX4onAy/hXqie+xlg6KYS?=
 =?us-ascii?Q?2mYJTliSBGb3mipRgtRXIgJSIbkl6nkIY/irem8rXZGpGwXk27iwToQjt2wC?=
 =?us-ascii?Q?kNvAmhjnYjS0UA2ZZnnOX37mh46/J3zBTl+Uuc0NnFnXD3yJYKfc9n4b9J2E?=
 =?us-ascii?Q?I+8CD92TW7bK2Ipx3mYArk6ZeYfNUmZwB6EI9L8waAuJXcWiOuJBQ3odqtrE?=
 =?us-ascii?Q?ZKRNx9GkJoyE3YF3WgOaJUc+35l7nsRwXdOAKNPlf9j/B+Q71eUxcjveZmOS?=
 =?us-ascii?Q?s5G2u3fk7z9EZyKGF6gvFS1nDUk3YO2FaLMLGbSX4Yt4qdUEW7aiqrmFGjcq?=
 =?us-ascii?Q?z7HCni22RvNLPD7il15Idh/Ru4pGW1bFzaHC8QxGN9p8jwGGM2b7/koD/DAg?=
 =?us-ascii?Q?touEHXLISOu5dRAxsYbdzoAnONvFgAbDmxBN337BYTyR9mBQ5pGSRGNYyTU4?=
 =?us-ascii?Q?fix8g18Fv0gKUrG3kt1SUqzonk6d7OYolVrS4A/bjLckHudAFRH4fjBl2a/+?=
 =?us-ascii?Q?6MzPV2QBR4XKus88EBh1hVi1dm/LrAYLzfhj3hPtK9B7N/wKOz6LgWVJY39w?=
 =?us-ascii?Q?pPs+G9lvhb/JFU0AV5bIxE7aM3YizxokgH934CzH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c93b84-0d20-4af6-4f23-08da6305dd10
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:23:26.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdQqrh0AY3syA+ovmkZ2f2+MaJxStGpJW4e6icj1q94S+/zt+COMIHZzynUTqJ3BK8cnAHGAHr0q/AIYEflmvA==
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

Support controlling power domain managed by System Reset
Controller(SRC). Current supported power domain is mediamix power
domain.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Kconfig     |  10 +++
 drivers/soc/imx/Makefile    |   1 +
 drivers/soc/imx/imx93-pd.c  | 163 ++++++++++++++++++++++++++++++++++++
 drivers/soc/imx/imx93-src.c |  32 +++++++
 4 files changed, 206 insertions(+)
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 drivers/soc/imx/imx93-src.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a840494e849a..5bfc1dfea28b 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -20,4 +20,14 @@ config SOC_IMX8M
 	  support, it will provide the SoC info like SoC family,
 	  ID and revision etc.
 
+config SOC_IMX9
+	tristate "i.MX9 SoC family support"
+	depends on ARCH_MXC || COMPILE_TEST
+	default ARCH_MXC && ARM64
+	select SOC_BUS
+	select PM_GENERIC_DOMAINS
+	help
+	  If you say yes here you get support for the NXP i.MX9 family
+	  support.
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
index 000000000000..ad52719dd288
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
+	void * __iomem addr;
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
+	void * __iomem addr = domain->addr;
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
+	void * __iomem addr = domain->addr;
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
+MODULE_LICENSE("GPL v2");
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
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

