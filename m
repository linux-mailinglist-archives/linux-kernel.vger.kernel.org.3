Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6F5ADE00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiIFD1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiIFD1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:27:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5505843603;
        Mon,  5 Sep 2022 20:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFYqHbV7voQwy8ipt7kczAb45TOPry38UUh24QTfUEGggioqrPy7vBcfxITdXlw3r46r9IY1NZ4CdYXI7ct+Hq/zCcFiwXUjTqeajkNI/eex/cilY2s3F6jRYXgFy0eMg38LN5fVA98eLHT/2GFEFpQy0qVg57iFMKIXRLwM+AcYNLV2BFsJsbOI0SjMYx0xSLy1+zLZgeL7l3+RgW9mV9atikV+QahwbTUNDLPwP/mLIOKo9dwT/aEYX12s3KBBRMP418Ix+R+gzeThvPK4Muj/sYT6/G4sTS0iElr03mCwEEXouYPLt9v/us+enhkCBwYYKT1KWwtg4s9kiALmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2obFs6n/0bvP9MS5rdhZH8RRVfwn54yqSHz26hUMXY=;
 b=U7UOaRIGrpFbZH2pSn2UcQAHUgt7q8Y7GZd53mPgW4h3IQbyA/rZAsh+fp7ijPe/uZu8MMzu8WPYa/z4x4Hz/tRbU7XWRrS+LNXrCuF3aHm0X1ylZUgEH2QiUw1inFX0kVQQ1gsEfT5CDLu5fYRcjRCf97nKCb9mgSQIQdpf0N8SSz+IkiG1rIKB4Y8dFzrz3u0xv4Zx+lrywOgYw/+ATOXzHUtNMIK4wHbR0Maj6Id7vlKFjVDwPAzbjEvkKITQEOEUkKahsyBC3+ojn9sguiGB6s1nLAhZgHVSbTrgXyxPFpMF3lhn7m1kAvE9R11xlDn1pYoQhiwKv+2uRpiRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2obFs6n/0bvP9MS5rdhZH8RRVfwn54yqSHz26hUMXY=;
 b=lGPse7OkXgViKBHnbUb/ceWRizUDaARUv2m94m41Lchbc8tMMN9MwKFo5Yf5YaAlcc7+iVWmmCezzghbuxXE6K4jGEGdnatDFbriW1cYQ4XQsJk3n2IJs6IgDCn1jjUp1KAa6EyVbVJgbSsjdx5+iOXBK5t3D4jvgMFZyGpu38I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3714.eurprd04.prod.outlook.com (2603:10a6:208:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 03:26:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 03:26:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V9 4/6] soc: imx: add i.MX93 media blk ctrl driver
Date:   Tue,  6 Sep 2022 11:28:15 +0800
Message-Id: <20220906032817.2090160-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbeb690a-11f6-47a5-4519-08da8fb7a7c7
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3714:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ytuc70R3wwfezc2TMIAo21FvTetCeMYYnr7dWjAGwvo0ZaunXeZISo6NDtf46qgTGif4QdkAkTsWPRD5cQjp5fpILLzGkLiAok1ZzAjRH74yW+U3dV2yIHiPr/sfpQwRiUvnfS0TcmC0IWILrfVLl/GIgVZ5d4nbU/mlZlbGRXet7E4ZoiwMFyPPxiMc+ECgzU17vgYXgYb+2/f3ZrMagWvtSyrUcdTc8aag3N3mUe/G9MeiW/Wai6aqvDTJLSyn4cLymmWW52EdNhyt9M/msE75q677E+fCCp7GcJKnHqHI6EuEcOBoU6lhnL+Tq5tMtwo4HU4/Act4wHoAmLoJGlQowibHUN77FgXQaYYoKiVkrtf9UH/gPVFxIiO0/aKkYh5ntwUfTpxpQpe/qz3dk+yqBp95XP7EEAxdlXnbrFXpBeXvf8vR7Opwl5v2FCyDZUFYUuMX2SR2In3JUK2YeclDTcnt5MN8sHSV1IRBBuCkS27lTs4o7V+Owzr3PIpMLIu8PeX0H2BNPkivG3h/+ijQfqxLknp0PcshnABJDIidNYYPpUfUNqPvSybErXiUcMiZDqeQStwBdKDxnAr/zAnKNt5ELw6bKbcqaaZ5F2eIfliPwLsi8C/KXXibCjGAfdw+BoS4BkXLvepeOo0a6aYgtUsiRwn8ABkbCllF3WqqQw1lDSliihuPoA/mO3bkKAAnJEfe3Lt5sm3IfLh9PQNLaLu2RFATkgfN0fkNhnQJ8w04VCGACjewyj+iRRK7hDjalHrCaXNSxvtwgJ9dYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(1076003)(38350700002)(38100700002)(6486002)(186003)(41300700001)(6512007)(6506007)(6666004)(52116002)(316002)(83380400001)(26005)(86362001)(8936002)(478600001)(5660300002)(2906002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7/96NCwY0xC6oOwl+No2QR4l4roYwirYk4iSnAzCZH+ENWTQA8bAMubCDke?=
 =?us-ascii?Q?vyY7kVBtN8QZaMTM4kOijA2VzpH3R41LUDTKS6CjdAhTCmAzE25sHxSUhPy8?=
 =?us-ascii?Q?V8aLzQFv/PoN4jjC5YY883XMLkjWztSjVQdF2AikClCW872tUJhOVjvdigtz?=
 =?us-ascii?Q?Yj7oF57Aelf72Pq7MWe18jjCJ6y8f3n+2wRpuLuRKXb7Smmr31a2TYcgEBiF?=
 =?us-ascii?Q?tYRv7dqlpVPHNo/cw4Lg7uGrDMWq5OMBjYbOcgR/YapV8PWUcWNKo6VzCGir?=
 =?us-ascii?Q?aMBKX3pPp+cEXgi5OxE8sLO9bSjlhhv3ErkuiBRUvNwotNUbsM/1OJNnB9+B?=
 =?us-ascii?Q?NA0K1Z7rSUUHJnkUZ8isGc3Hha0VA4JfdV4osJPheGLGNpXkj0NHZdK87j1Z?=
 =?us-ascii?Q?2WH+yOcsL/lXTXkoAzcHHhvh7ZULV/ynUOleUsdaFN0dhIYY0daOuD1IXzdA?=
 =?us-ascii?Q?S4UWbejDPbmZGMkpWkFLd4z3FIR1mKCnJMl33z+6/dSLw+qpYRhW/3KEJHrM?=
 =?us-ascii?Q?doj2PSP1dbqT/A9CW0PbxPLVQtMTuxaR+24PXwmoMB1jH1nQjbJtIJHNZY3q?=
 =?us-ascii?Q?ZZwqfxcLnkJPqg5Gf9VHv0zztNSoD/4RP9wD+CbH5JeZCpoyRd1YAR/eyKLw?=
 =?us-ascii?Q?3Ty/DBmUbtM3CEWmig7LddPSbxNd1vkSEnGXKh7sleNA7mBFjohSVhG4R4CP?=
 =?us-ascii?Q?TT7EqvoqC2gkPyIOJDsy+QZJA3Yl5LgmxjsAUQWv5VKB9SjaABuuUKBL/fEd?=
 =?us-ascii?Q?VQLdsxyMrBJeJurFvWCyIlVUXyFGgAAQZxniVBV5bA3M7bL1SLMTrivQhKX8?=
 =?us-ascii?Q?sp/Ug7YTofRBJIfk0UNMXDutYZHBwzcBeoKG8jhP5IoKy82W5HnZAIGw9dj+?=
 =?us-ascii?Q?kbx6+IC8NEvL3qgwegip8r/bM0/YDP5j95YBZ2EgtljpzSuvNzkY6HjepQYx?=
 =?us-ascii?Q?n9l96xIxSGwPvvtfBeIGt7GAalCZm5xT0Z1zHtVSESdnJD9QUmEs1IuK6WzS?=
 =?us-ascii?Q?6mNIxZ5P8bgj9S3EWrUaraotCx/LsaF7WTSLbusqNlx1ytKuI474t6+CVcu6?=
 =?us-ascii?Q?B/12mAOuJq1Hw0SiQAZo/JPdM2RalPvkBfxpUkQ91+ns4GeTFv2uyrNa74Ug?=
 =?us-ascii?Q?V+IDk4Xy1n9MI+IPCUbcTgf8zx6MKsW4L1GcyTc5tPjEv0XQm9kntf4ePaxo?=
 =?us-ascii?Q?TWPjnI024D7zUPxXN7F+Hu70ib2KK0f9OIXb/1I8x4S2dYYvF8fC2TlhidQv?=
 =?us-ascii?Q?dQrooHv9Sh/BSxb8mW8Nytmdh2kWB5k/1KRxidYcmjWKgYnpECBDVNPNoKaC?=
 =?us-ascii?Q?iix3pC2RaCY1XL0/RIQTI4mYH5l9fw2BFtETxjg9w5/79Okbj4KBYaMZ4eha?=
 =?us-ascii?Q?1K77OZ98KXyRsQtom5DvB229vT+NxPR9qNHlk6U9yTpApYkNnhIZWO6WWXHk?=
 =?us-ascii?Q?N1FNgNZL8qAifrRdZS4ovPxl50oyRc9nTZd7mRTVyzQr2xq9CG0wMRNW/gg6?=
 =?us-ascii?Q?IIwDXELI6ivpLxQvro7JDdWvXzPIOVXuc35VKD+K0SLqiT6dJhj/6jVhOShb?=
 =?us-ascii?Q?L8gno7XFE53+61YJTSQVH5v+2ZcWFtGkr4BEhSLv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbeb690a-11f6-47a5-4519-08da8fb7a7c7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:26:58.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5kdNjR2iIDHPhkdtOEIiCPYQrQeCgUMUojSHbGgu7y476DHH/AGcEtqg0GfDjdSEEZZukqvyqCQ8q3VL5yAuA==
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

Add i.MX93 mediamix blk ctrl support.

i.MX93 mediamix blk ctrl has registers to set QoS(priority) value.
It support default QoS value and cfg QoS value. Set an initial
value from i.MX design team. If LCDIF/ISI/PXP wanna a different QoS
value in future, they could use interconnect to request bandwidth.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Makefile         |   1 +
 drivers/soc/imx/imx93-blk-ctrl.c | 436 +++++++++++++++++++++++++++++++
 2 files changed, 437 insertions(+)
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index a0baa2a01adb..7b4099ceafd6 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
+obj-$(CONFIG_SOC_IMX9) += imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/soc/imx/imx93-blk-ctrl.c
new file mode 100644
index 000000000000..2c600329436c
--- /dev/null
+++ b/drivers/soc/imx/imx93-blk-ctrl.c
@@ -0,0 +1,436 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/sizes.h>
+
+#include <dt-bindings/power/fsl,imx93-power.h>
+
+#define BLK_SFT_RSTN	0x0
+#define BLK_CLK_EN	0x4
+#define BLK_MAX_CLKS	4
+
+#define DOMAIN_MAX_CLKS 4
+
+#define LCDIF_QOS_REG		0xC
+#define LCDIF_DEFAULT_QOS_OFF	12
+#define LCDIF_CFG_QOS_OFF	8
+
+#define PXP_QOS_REG		0x10
+#define PXP_R_DEFAULT_QOS_OFF	28
+#define PXP_R_CFG_QOS_OFF	24
+#define PXP_W_DEFAULT_QOS_OFF	20
+#define PXP_W_CFG_QOS_OFF	16
+
+#define ISI_CACHE_REG		0x14
+
+#define ISI_QOS_REG		0x1C
+#define ISI_V_DEFAULT_QOS_OFF	28
+#define ISI_V_CFG_QOS_OFF	24
+#define ISI_U_DEFAULT_QOS_OFF	20
+#define ISI_U_CFG_QOS_OFF	16
+#define ISI_Y_R_DEFAULT_QOS_OFF	12
+#define ISI_Y_R_CFG_QOS_OFF	8
+#define ISI_Y_W_DEFAULT_QOS_OFF	4
+#define ISI_Y_W_CFG_QOS_OFF	0
+
+#define PRIO_MASK		0xF
+
+#define PRIO(X)			(X)
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
+#define DOMAIN_MAX_QOS 4
+
+struct imx93_blk_ctrl_qos {
+	u32 reg;
+	u32 cfg_off;
+	u32 default_prio;
+	u32 cfg_prio;
+};
+
+struct imx93_blk_ctrl_domain_data {
+	const char *name;
+	const char * const *clk_names;
+	int num_clks;
+	u32 rst_mask;
+	u32 clk_mask;
+	int num_qos;
+	struct imx93_blk_ctrl_qos qos[DOMAIN_MAX_QOS];
+};
+
+struct imx93_blk_ctrl_domain {
+	struct generic_pm_domain genpd;
+	const struct imx93_blk_ctrl_domain_data *data;
+	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
+	struct imx93_blk_ctrl *bc;
+};
+
+struct imx93_blk_ctrl_data {
+	const struct imx93_blk_ctrl_domain_data *domains;
+	int num_domains;
+	const char * const *clk_names;
+	int num_clks;
+	const struct regmap_access_table *reg_access_table;
+};
+
+static inline struct imx93_blk_ctrl_domain *
+to_imx93_blk_ctrl_domain(struct generic_pm_domain *genpd)
+{
+	return container_of(genpd, struct imx93_blk_ctrl_domain, genpd);
+}
+
+static int imx93_blk_ctrl_set_qos(struct imx93_blk_ctrl_domain *domain)
+{
+	const struct imx93_blk_ctrl_domain_data *data = domain->data;
+	struct imx93_blk_ctrl *bc = domain->bc;
+	const struct imx93_blk_ctrl_qos *qos;
+	u32 val, mask;
+	int i;
+
+	for (i = 0; i < data->num_qos; i++) {
+		qos = &data->qos[i];
+
+		mask = PRIO_MASK << qos->cfg_off;
+		mask |= PRIO_MASK << (qos->cfg_off + 4);
+		val = qos->cfg_prio << qos->cfg_off;
+		val |= qos->default_prio << (qos->cfg_off + 4);
+
+		regmap_write_bits(bc->regmap, qos->reg, mask, val);
+
+		dev_dbg(bc->dev, "data->qos[i].reg 0x%x 0x%x\n", qos->reg, val);
+	}
+
+	return 0;
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
+		clk_bulk_disable_unprepare(bc->num_clks, bc->clks);
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
+	dev_dbg(bc->dev, "pd_on: name: %s\n", genpd->name);
+
+	return imx93_blk_ctrl_set_qos(domain);
+
+disable_clk:
+	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
+
+	clk_bulk_disable_unprepare(bc->num_clks, bc->clks);
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
+	dev_dbg(bc->dev, "pd_off: name: %s\n", genpd->name);
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
+static int imx93_blk_ctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx93_blk_ctrl_data *bc_data = of_device_get_match_data(dev);
+	struct imx93_blk_ctrl *bc;
+	void __iomem *base;
+	int i, ret;
+
+	struct regmap_config regmap_config = {
+		.reg_bits	= 32,
+		.val_bits	= 32,
+		.reg_stride	= 4,
+		.rd_table	= bc_data->reg_access_table,
+		.wr_table	= bc_data->reg_access_table,
+		.max_register   = SZ_4K,
+	};
+
+	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
+	if (!bc)
+		return -ENOMEM;
+
+	bc->dev = dev;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	bc->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
+	if (IS_ERR(bc->regmap))
+		return dev_err_probe(dev, PTR_ERR(bc->regmap),
+				     "failed to init regmap\n");
+
+	bc->domains = devm_kcalloc(dev, bc_data->num_domains,
+				   sizeof(struct imx93_blk_ctrl_domain),
+				   GFP_KERNEL);
+	if (!bc->domains)
+		return -ENOMEM;
+
+	bc->onecell_data.num_domains = bc_data->num_domains;
+	bc->onecell_data.domains =
+		devm_kcalloc(dev, bc_data->num_domains,
+			     sizeof(struct generic_pm_domain *), GFP_KERNEL);
+	if (!bc->onecell_data.domains)
+		return -ENOMEM;
+
+	for (i = 0; i < bc_data->num_clks; i++)
+		bc->clks[i].id = bc_data->clk_names[i];
+	bc->num_clks = bc_data->num_clks;
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
+		.num_qos = 2,
+		.qos = {
+			{
+				.reg = PXP_QOS_REG,
+				.cfg_off = PXP_R_CFG_QOS_OFF,
+				.default_prio = PRIO(3),
+				.cfg_prio = PRIO(6),
+			}, {
+				.reg = PXP_QOS_REG,
+				.cfg_off = PXP_W_CFG_QOS_OFF,
+				.default_prio = PRIO(3),
+				.cfg_prio = PRIO(6),
+			}
+		}
+	},
+	[IMX93_MEDIABLK_PD_LCDIF] = {
+		.name = "mediablk-lcdif",
+		.clk_names = (const char *[]){ "disp", "lcdif" },
+		.num_clks = 2,
+		.rst_mask = BIT(4) | BIT(5) | BIT(6),
+		.clk_mask = BIT(4) | BIT(5) | BIT(6),
+		.num_qos = 1,
+		.qos = {
+			{
+			.reg = LCDIF_QOS_REG,
+			.cfg_off = LCDIF_CFG_QOS_OFF,
+			.default_prio = PRIO(3),
+			.cfg_prio = PRIO(7),
+			}
+		}
+	},
+	[IMX93_MEDIABLK_PD_ISI] = {
+		.name = "mediablk-isi",
+		.clk_names = (const char *[]){ "isi" },
+		.num_clks = 1,
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+		.num_qos = 4,
+		.qos = {
+			{
+				.reg = ISI_QOS_REG,
+				.cfg_off = ISI_Y_W_CFG_QOS_OFF,
+				.default_prio = PRIO(3),
+				.cfg_prio = PRIO(7),
+			}, {
+				.reg = ISI_QOS_REG,
+				.cfg_off = ISI_Y_R_CFG_QOS_OFF,
+				.default_prio = PRIO(3),
+				.cfg_prio = PRIO(7),
+			}, {
+				.reg = ISI_QOS_REG,
+				.cfg_off = ISI_U_CFG_QOS_OFF,
+				.default_prio = PRIO(3),
+				.cfg_prio = PRIO(7),
+			}, {
+				.reg = ISI_QOS_REG,
+				.cfg_off = ISI_V_CFG_QOS_OFF,
+				.default_prio = PRIO(3),
+				.cfg_prio = PRIO(7),
+			}
+		}
+	},
+};
+
+static const struct regmap_range imx93_media_blk_ctl_yes_ranges[] = {
+	regmap_reg_range(BLK_SFT_RSTN, BLK_CLK_EN),
+	regmap_reg_range(LCDIF_QOS_REG, ISI_CACHE_REG),
+	regmap_reg_range(ISI_QOS_REG, ISI_QOS_REG),
+};
+
+static const struct regmap_access_table imx93_media_blk_ctl_access_table = {
+	.yes_ranges = imx93_media_blk_ctl_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(imx93_media_blk_ctl_yes_ranges),
+};
+
+static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
+	.domains = imx93_media_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
+	.clk_names = (const char *[]){ "axi", "apb", "nic", },
+	.num_clks = 3,
+	.reg_access_table = &imx93_media_blk_ctl_access_table,
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
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX93 BLK CTRL driver");
+MODULE_LICENSE("GPL");
-- 
2.37.1

