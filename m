Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A500659D0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiHWFvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiHWFuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:50:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0555F100;
        Mon, 22 Aug 2022 22:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLqy6tyeQhAP7VudN9m4SHu4slkVcsDMqGTzvmInfzRM1WnzwRa9UGUCY46YtjQwhy7ZcdT0ULpgKQsEVGB8N9xJEdjB9y1TVHWDfbdM0NQhypGch/ylDJLpFJA1vViHQbBzhCmAh+zqokojIt+awpiUuHQP3nnpeElgYMSSKxMOfaMtvJ5262Kzuvl2D+QtPiha/S8r0NiOdedmtF4+UlVdanNS8VCayL3FYyaAUFXAAn/0UUyKshd0ZZxgcVTFsHsErQ3pVkL1W52jpVFthxPurUxh44v9NqNz0rO8GyNhSUueQafYuaZk726wEL6dcZdDvufwKVj6kREQysjW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsCaRBpQ/Qo6ngtFJicRPgXAFRru6zsj2tgUwW/6xtM=;
 b=KULV4CWx2353YmwxnZ1DImPp6hbDQU2u51BskBN659HkETUoFVhruLkxQvsXo5nVMM+DgGF/SVRJHU1nPHgTWfoauHgXyCxGr4DV3nkvD+L5DBHOSVF1dhDH1C4eVbI5hvxF9nRwI0xR4vfcQQR1um4T6MwzLLLgjYd5V6ey5pdQ5bIXPhg3TKGC7jCT6kJkm7sj7+XiCzlUKi8/Wa7C5Ooy89vrLy59NKMTSbAWhrTTd27pZrxUIiC1+FwYeg3vAV7ZpoOKQRbBdYBVDO13Ga7/wEG+0JPqQn35vdc+JklgbhNNtwZ84IdpfDYFzR1h81VMton43wfQKHof/bXG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsCaRBpQ/Qo6ngtFJicRPgXAFRru6zsj2tgUwW/6xtM=;
 b=YUOLzsbp6krM1bf+7nNXBUHPPyCP5hBvx4rMG0Q4zYF7CgsQOkrLUBiZdCHJrzWkCBXN8WFDU9XhGAe2mxhjv4Q+RQCMR9PQhgrqHzIYHPHed+hiPQMhPFW+A7KhzY7DrscMQgFrKpXZ6R+SAWVM53gztfjxSRAZKnV21yRVkmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:50:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 05:50:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 3/6] soc: imx: add i.MX93 SRC power domain driver
Date:   Tue, 23 Aug 2022 13:52:12 +0800
Message-Id: <20220823055215.1139197-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3596f5f-29a7-4c5f-fa67-08da84cb6e2f
X-MS-TrafficTypeDiagnostic: VI1PR04MB7165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duNZLnrPCEOSf+VFnJcZ6ecFtspViBiws76BPQkEc3mKw8qMBmiyT8u1mcy0l2NnNua4NVUs4JMXZe+9PmBZNxxnkQnOjhYbUqcprv5TV0H4QpUMNm/xoXMzpJeuwm4db18S9+sOz6Z9ZKnlG2bmj4bk7GIp1zDJUsU209l8cxEcO9uXM9jzDyATUYqZupPphbcm1kaOgeCLWG8hkU4o2xsjpVZRcwXN+HVJ7kubKqKvCU72YttqedTV7oZ/EchzHkJP4g5Mg2yMm8aRW7IMakqP49m2hecMp21mx8ObqkWYXjqjy6BagT5lxk914K7+IVESX3zyQEet0dx4deMFDkT2ejXtvDjKlDkN5dlTNTn1GUOFwtGY93p6MdakfmIdLFwMELFpiuiSb4DZeL1IdTQ+NCSho2HIX0VQElknbeLxnpVJTSCgl4FOA68tHNSVIpgFgpebAywC6PR3SnZwBUkFDKNpvJmoHCSLYau9QQk3Sweb0xCM8v+ZwOLwZanGlkNJA7X48FozlhmSLW8LAcbB1wkPduZbsZ4qLxYmuxzveHWCmV7RZaENaQRG+JfXara+SfRoGBZEDGLY3wgOoFHmmcZIo3r6+RmK/5sGjgx9f7XrSwgbiQwKMcbnd0dG2J2atCV2irO6Bc09JRAzsBomQrFIRY9xJJCe8EPOA8ibEi0MNQRLZ7M9i3YKN25+dmoN1+o7EkHkGdYAGPoOApxzmV1MJ3uUvtO6Xyume/losNYJgygLw9h1UsqLJX/JLBV7ioUl/UqCku4E2RsC8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(2616005)(83380400001)(38100700002)(38350700002)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(26005)(6512007)(6486002)(6666004)(86362001)(52116002)(6506007)(5660300002)(2906002)(186003)(41300700001)(1076003)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HOtrYIWJmF4Q3oTfy1gdY11lGHCUkQcddfWtJRGR98oK1ZVJAZg3gt/WNIdK?=
 =?us-ascii?Q?P0DpOJLvPY640RpEeHQppnU5kK3wjKY+PQRiymUtKiqQMhIrJI/BFXOX7Gql?=
 =?us-ascii?Q?F6a0FiZUCTYBsWq+VctLFH8Nql6vTzbovmiyFSNcd2B+lwxHK7MVMwrfvBFw?=
 =?us-ascii?Q?xdNBhkFmhD4TgKAxnrkroz6/SJ9tghZgYj5adLJlzUfc6AJdf8ClxrcSWsDF?=
 =?us-ascii?Q?0MDGQGi3aa2o6wFbc1+/QM543eA6l4/vIw4KBI8LpRzDMfDMp4ZyBxnvECKp?=
 =?us-ascii?Q?+QD8SH6jKhP4gIO4hYELN7KZO0HusXJZctZ6ZvXmDPZQQoWWPgtMI3J4MuZY?=
 =?us-ascii?Q?VEXJ8KJwwe47gUADwpzg1XdEsVYKv8cLecnn9lEOyEKbSPqSDffarvVBYqDd?=
 =?us-ascii?Q?aivlU2hO0x6Xp0/u3KgFnj1vtrCOIS9+1fjJFnwd0L/HQOmRDQvcKsSJitMw?=
 =?us-ascii?Q?NvmXhrJNBgG89nXk1OHX3ySU5yrDaaf9yh9iYtUSMm5WSUPz1TozTBFRm8FJ?=
 =?us-ascii?Q?Qo5M/J/sI4/Zet11cfbK4/SOohOeqVop1M5frNudOUIbHLMxlbrdJ49RBAXC?=
 =?us-ascii?Q?uRAk655qUr9CEMs0m8UiGjI0noNqCYBxJV4RSBhaTGSKfZGSs+W7U+y96dU2?=
 =?us-ascii?Q?9rfmgOdIN3SlPY7CrGtNvkcmQ7Mb5j6Gq1q65dZuNrzxXl68mjn0EsuccF1y?=
 =?us-ascii?Q?2i81WHNSqGJs6bjkbSV5GkvolGoC+s3O/ZNYtvv3PETGkQnJSWvMl3zhcU0H?=
 =?us-ascii?Q?R7vl4aAVDGsPuJD441xR/F3oe3vyRTgbGJLthI2ZPVfhD+NyItGUHZaW/0S5?=
 =?us-ascii?Q?ckqwcbYikFn4WplVPhsI+o9DPXE1tl1Vm1H3ZCWAIpT/PBk71Xs/oV1rZeRG?=
 =?us-ascii?Q?mBQVJmHTzr4EA771PUIsLosh9tZnpOtnMvodwgXgxkBDxc+j2t1+Kr1lVixt?=
 =?us-ascii?Q?eeS545F2YCQaOEtdZZVCKLv3nhfZZuyk7ufpAu/jnQyhKjAsEneqi9ATe9AI?=
 =?us-ascii?Q?UIj97OUTxtgegAhnUWXI5r633gGH4dpUHWmC0H59QPkWj1XS7XQ/SOaVOIul?=
 =?us-ascii?Q?MJe/YyGHLlfLSdGH2NPMVEgATHdWzhxvXu2aU9HD62/npx1hupO2OX/pMBfn?=
 =?us-ascii?Q?Bn5IJi25jv81/BTB5APt+An9FP0v/nW5YyJN8jqyFxdLNzxL7MDKRJhZLuC/?=
 =?us-ascii?Q?3ThWHpoopj/rAhJOaL8lBBHCr57z9dbjUCo7HI7Yo6FwJ9onBd2GaUkplRFZ?=
 =?us-ascii?Q?pl5/saxNoVRJndC20kRou1rNLUDCwqtxBocuNs5POwzNIGmcNvuCpKbb/47b?=
 =?us-ascii?Q?i1iHzULRif7I8En8knKXdNl7tFLv1Gm1G9MM9u+5QxgB81ZVdbsj6D+nCN7I?=
 =?us-ascii?Q?Ny/TbH3U2Alihmw2ky5yHaYt6csfO3Npn4UFT1Ql5wXAydGY2g7+KrdlCt7X?=
 =?us-ascii?Q?Eg66kJbh1kejKypvSoqAw4gYOOwhfy+QL7JPv+HTelvHmTWiFBv1S5KxTrM4?=
 =?us-ascii?Q?hrEFqt5vPwL3L6/PEZtWxhYXupVylGgmduJhhu2SahaTGh8En0Uc8mHcRsa9?=
 =?us-ascii?Q?DfxVzlNMUbfF1iA+VCVH3lnJcL3dp0n7f65Kkpr1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3596f5f-29a7-4c5f-fa67-08da84cb6e2f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 05:50:49.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Jqs4qLHECNyBeVSen0xVy5yx/rKpGXya6RzpZmVhEu2wCeEGYHAJAIgpwuklN9CrEroVxU+JPx48hwRrW5NgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

