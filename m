Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7955ADDFD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiIFD1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiIFD07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:26:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A94363A;
        Mon,  5 Sep 2022 20:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCyhgNin5EZv7hdDEySJpXLHQk1s59DRmniqd27jf/OTfnc4ohlvKJWj4aJu43VuBTjcQzz6gFGIpYRmKBHca5HYxCX2/Vk+w+0nNMIcuQGJnKfB9VSyNH/oJwbpS3VTkVVLyvc0DclaaClaGkc+XNYJSzoWp4nd1jgQxH9qJj5n2PxBItwIW05yaX1Sx9F7q5LX4TUFU9LaZXyvI68c2jOsBwIUuzs3HXOooSWuOLgrpBxSI+hY2YVpbo+KrxW0A0QHRrFGZeRsTqbVikDMOwVF9pH6o5hEQIywNkT+7ghSLxBOd9HI8LLRPcwPtYn3hU5YfJWVnSFuNkEGsJur0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuK7XUTufmEgkuBnQ6dszlry2p8iz8a2zi1XV2BjEnM=;
 b=d3egN7wjG8vXqNoQZNAtKr20E8GwTw4Sd9i+wZ5F9bBguKTdWw8zJvkDlFGhhexqXTSuOGUsdrWV1NUsn3arNrpCaJ3IWhFzqnxUcOzFkh2F89r5CoIVWlUXCvqYhfx1ZEymx6gqDsVm1v4baEPfnjnrV/HXWpWkjCojlwMxJFo0QyivS9raTzMzouml2HtYvfNRcDT5wFN+7Mfmu7BGVjusPwP65PzKeBDH+F69Mt1j07lBKbJIHt8lopFoAcRe7SxjNWByEjH5hSXctZDHWb0R/2zX8rwFJKP7iCt01OEw8A2lD1jIbBbajDqW0FCGWEdUU2LH/uoZ5M4fxU6LCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuK7XUTufmEgkuBnQ6dszlry2p8iz8a2zi1XV2BjEnM=;
 b=dS2k3UAdx6fQDB7JtuHnqLCkKmAPBL0mxEqdpjSdWuSryKFTnGvcZaJ4mPKmIU5frul4JbBLhCYUDRLr3HBgtgmO4gniFNf9F0M7zoast8OJPfz4tUo6Ki/9dkUj62KFeILnCjKgEW9vP3d82agel82PXbC1RwoAy4Wt3Ou1CDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3714.eurprd04.prod.outlook.com (2603:10a6:208:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 03:26:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 03:26:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V9 3/6] soc: imx: add i.MX93 SRC power domain driver
Date:   Tue,  6 Sep 2022 11:28:14 +0800
Message-Id: <20220906032817.2090160-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
References: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5621e755-31e1-40a4-6372-08da8fb7a588
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3714:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kx1pwDejWZ24ysBY720s6XNynrocQIjlIZxcfS6duLxEq0/Nb9D8fxMObX9u7tLqbRCdwnCTI/qhk3tOQWiBj5vsKOPiKsfIcX96ld2EOEoR5F2flXXWjohPVSlws6jHqLEqhAZejKM390qNyn4ttgbTnXc5VbA9xUZ/50qGuGsLt0mOv7VDudtN9e9xFX2Gcu5SSa7/0WSHEZc5v+COhW+rB9yCOrjAPP1wPvOZTYRawMgDBXrEZEYcU4xWVfodVBylsK18IlaFz9sPZJq0LtZ2cc7wk+tM+yh16OTU8h6dB3PGnUUmvh3W1731dQorrvjH5fScbxwQzB5iNa5adWlFgJqJiqUmj14HBBo9SfulwU2Pr66eHbmogmT2+C2E/DN26oT8TG0k1VgRWHtpOpuIsMxZEsELFlo7BUQy29kaL9W2CxwikQEV74+cnoA03VkGcPFNqPHG3EBVB8HEuURSzkdAPNho6X+i8KCQkb9z6APyg3Wfln75kTR6P52aXRGVvaoj6HGmE5grMfSYEfUO7serx3eeHkGyn9jGQLaZh3wDTPcqM4IU+Adl7LO55EYy8YdOvpDqKdC+qeRnFPsI5ScZ2BnDwTOgUMom9et0zGV0ka9GJayWRptviS8FCz/Bru4oZa7iOH93BSiCk2aXhoGQ7lRypiayu5DDf9/EEsuqrubECsRpibfekoLsH0X2JZENmbMl3nVxZHshJatiSycCokfyOkAr2gm50dcelvwoi/eg6fSV1ZjcNyjCFdGBswbVpvb5kDFfoQa7PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(1076003)(38350700002)(38100700002)(6486002)(186003)(41300700001)(6512007)(6506007)(6666004)(52116002)(316002)(83380400001)(26005)(86362001)(8936002)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGhMOafOcuLZpm0Ot7wtyyQJWlReAlBvz+0TbLqR2PS3LZUAI0NsXZFZY+ev?=
 =?us-ascii?Q?TyqyPag63ALmKdkaohzN8SVK/Q5PLLBNIpF/rSi52v5Re7CdkVZzgp1hvG49?=
 =?us-ascii?Q?vBEqKFkoMkp5KXjDSkHpP4FBuLRFcmcZ5UYcAGCrXa23lFfLKecldChwCjnW?=
 =?us-ascii?Q?OOyGLPsxgilgZJq4ZXRL6+kOtfBya3qZo0yzlKc9SGAad3G5RwsRFAkXikDT?=
 =?us-ascii?Q?v3c/pl6wwo0ceWmVvOuLiOazCcDFmwQaQhlTvbSrTtcwV/1nht5B+mpmgeUl?=
 =?us-ascii?Q?mkq2g0j7ZZ5tgf0fgtJWznV4V0PK/Yk0BoqFa70RAt+XEu/QNh+ZEn0Ju7C2?=
 =?us-ascii?Q?+G/7YECYNqkjwFdyDttIKMa5xK0KIoTKIMzqj7kmPIko7gjRClHLHwpePsVW?=
 =?us-ascii?Q?/IVlOv6cDeaeJjxjFQw3mXhuLOUVCGAVwQ6F6pZepnF2CfQCnk8LsirTrrcl?=
 =?us-ascii?Q?N3/uvrpVs7lamB8kMXUeB2RWM4vn5eTJr4q6PVrF7d68SQ2Aj309Pt8qkHtU?=
 =?us-ascii?Q?q3s5tmcBvF4/wTQsaHiGNYoJGa/kuztht2ILvyEM7gSBRFOQdlfxcNbovL2p?=
 =?us-ascii?Q?J9MAG9MtiRhfUGZGK9VnfGB+W0gG9nFwM+1QLzNwf/IVJLam1LWjYwiA6qmi?=
 =?us-ascii?Q?NpwPyfdgPoDdXoNgFa9O46/tcGXO39SxzsIRjPXjHg2pnR3Otuk8ig6G2eLo?=
 =?us-ascii?Q?YdHRp/TeV53YLT3VLhh6b4U+bLWTqhLI5fwUZk8r0CKpuxer6OEaSr22Bw7p?=
 =?us-ascii?Q?2yiZOpyn7lQsyVb3ZWC7Kh4VCINkfgkLKmZKsvfBH6D/LbAIFcosqAwSNVQx?=
 =?us-ascii?Q?1vC2ud+lo6rJtTFYbrRwKCC3aDjsXbVYus4zb0GqiVRGCIr91YomrCpSyfln?=
 =?us-ascii?Q?DJX0qPLYCoTrAtZn1TqohebpfZ5kmxEa9SwQEbJGzCpIyO8g2tVlChuHiZDM?=
 =?us-ascii?Q?W9xhZIEUP19gSjQd1zYUaaAG27ncTNSRS4CFMVf/HS1/7grCU5g7V2LGt35W?=
 =?us-ascii?Q?SLX1Y6RipUDJo+yRHNXvzPwT647LPMOmWo+7t4/btkuk22IMrMtJrEdTN86P?=
 =?us-ascii?Q?W+vbrv1P8KobcIQpqslqyfAxTSDc4cHPUioOqN/EKFyMlEugoFCKAmI21gQ1?=
 =?us-ascii?Q?Slpw3VfFb6bk0u5NCGgtTrtJdWS9uvkUPP/vL6HQloPvRGjghPmMCaShSYJD?=
 =?us-ascii?Q?MBJxdOT+JOsWFo+NjJyGKafG+XMMSn50aq2LjZnSRjNZbGFW9he6IXSQUkW7?=
 =?us-ascii?Q?woiaAVY8Gtx5CF/hBgjRGGFpi92wzIdcVIMDUNAoTNhdnrnc0IVUavjPnxHj?=
 =?us-ascii?Q?n+rFSXHF+4TzmGJrx9WfsxWz1PgNoxCPtybBvQvLpCqyhrpNs3VuNSxHc0Bp?=
 =?us-ascii?Q?i2TUZmeO9SvItJug8wejFt+RVNfuOGZfyPcXNmNt2pdkTcsprtxhwy9WSRVk?=
 =?us-ascii?Q?JOHk1yCUAFNi3mMP0sYyXMhoSOoacSJxguTh7jgbPBKOtKLvY+kRy5GK+PTv?=
 =?us-ascii?Q?AbNzpm7xn8b9vVDVmzyOyuGSNx4+TzTv/0/1zJqYqkM/K+Y2AgBvxNuyUN+e?=
 =?us-ascii?Q?I1eOAvFcuTg4hBq3yP+meR6eH+tX/kj27mdIWfEJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5621e755-31e1-40a4-6372-08da8fb7a588
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:26:54.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CtLg0rLh2p1BzCBCz05bvIBf7lFJpTutgX/hasx/QlFnQ0oeXP3EDBaLRw2zYBYk2mYHWOioY3fiJOMMXfBtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3714
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
index 000000000000..1f3d7039c1de
--- /dev/null
+++ b/drivers/soc/imx/imx93-pd.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/of_device.h>
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
+static const struct of_device_id imx93_pd_ids[] = {
+	{ .compatible = "fsl,imx93-src-slice" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, imx93_pd_ids);
+
+static struct platform_driver imx93_power_domain_driver = {
+	.driver = {
+		.name	= "imx93_power_domain",
+		.owner	= THIS_MODULE,
+		.of_match_table = imx93_pd_ids,
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
index 000000000000..4d74921cae0f
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
+static const struct of_device_id imx93_src_ids[] = {
+	{ .compatible = "fsl,imx93-src" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, imx93_src_ids);
+
+static struct platform_driver imx93_src_driver = {
+	.driver = {
+		.name	= "imx93_src",
+		.owner	= THIS_MODULE,
+		.of_match_table = imx93_src_ids,
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

