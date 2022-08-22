Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0559BBA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiHVIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiHVI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:29:55 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EA328E2B;
        Mon, 22 Aug 2022 01:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpG5woNRIFJiFJYWS7QqoBd8y2Um0edhHtMDtG534mKc2NX0BnXaUu6cq1rNRS30HWGjBQE6wiF0be9Zwk/gSLJwyvL+Kb09rX+FYl7uR8AE6JohMIt4pozHUVtRo2nbNzc1rsEgGiCmVlxCWTDP7A++WIQRgqF7SWGIediTuF/cYAvICW7VSY2TRsoZdKO8nFQ6YsoIeXx1Tigvjq73iozdNMWSk01Az5bSZ4LyvGmke7aeJy/O/3jA500PryzyA+nWV98+/DG2kr6nvaTp6DOY5o58HMHXjtyZ+i+bWxnBiHXaLzjCYc/e4o6pyrigdYfqhC7OK3Y8LnNk/MOj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnbTKGSOYFMBepElaGopKFAbIkpT+8vsRfCvnOF/2Jk=;
 b=odt3Ktxi5MKqZ12aiT0i8p0xO1PS1CXkk4m12PTGtEQkojS1H+D5D07u+zxIOspacX5KJ6qeizYelwm3lYuWSQPVMOHVsiKsfyPOSNxwYN8xX1NkH77hydwPqjKEaohVxWJwRIMbuOMj4iClL2VSjMaVyi2ZOwWev1/hjnH3Ae4xqwK+9zG20x/lQcZB4Y5GTxek0D9FHbYFnUsLWtFddX2T32GI5IdQwEy53zKmKRrvf89RQQ2SeYyyxrUZ92e98XKXDPtd3VphXRWVR8kiiS9JFyAz+AS0CzfhiCUFJQM4OCctSeS9y+a+NKa9ZNODNJNOR5oC3/wVOA0AIMC6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnbTKGSOYFMBepElaGopKFAbIkpT+8vsRfCvnOF/2Jk=;
 b=bfduLnPb4oBm7RDdNV2d4hpLwed6eidh7RibRXwAVo1SoOrBEK21ce7zwSi8RfTAVVdxIB1GGo25KRV/wIwEbKZrZtwDyEms5l+OXtvydmcHVW/62xP591Pa4Mk2O3yNfGgOBW7m2ICFwc8RdIWUXUKSDbyewNPJWUjKD/pqLwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB3997.eurprd04.prod.outlook.com (2603:10a6:803:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 08:29:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 08:29:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 4/6] soc: imx: add i.MX93 media blk ctrl driver
Date:   Mon, 22 Aug 2022 16:31:04 +0800
Message-Id: <20220822083106.156914-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f47b5862-34bb-4dbb-539e-08da841877a1
X-MS-TrafficTypeDiagnostic: VI1PR04MB3997:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fj0QYugle+a0dgaaavXdvTKfm6s/IOukTqb2wc8aImzsy9zSEMPHa6Q9Ufn1FOQDxvxUcUG0wq5CqsS83dfdcAIQmOgRU0VIVx1geXrZHOSuK32LNCSLcjoCOPNPiI4EjKwso8u4zbiZdOyULcrMWyHOznt22A+TD7JXOZaqUtPfU/Xy779IxMFUICQyG2WC2lTPp6KVcELcuZ71qKBtuW6HopZ7iHIOLpEV/WC14mQ95yiJ8ZRPrZ+wmyaN7cG5YiEv1uBAJf9zo60wchLobYlOrUx+V2PORMRj2LDGf/4a6ZMCcKgN54aIrfqJPBPNshUlSkMnuY3pD9lmz954ZJrxRPu6QmQTb+xO+ZWMiMxKV8g5uYLT9ISNcO2WVAWkg7WbYiok1MLA7x/4pV775WzV2MDXC4ppeuVuV8s8bsnc8+PlYOdJLcfOCmRzJFJAv+CRqavm4kxwikqff++TAJtZ1mipkdHxrNz1z8Sr5gynU5q5QfcYnVZpN+O3SoxfHwqOjRXeURJ4VsKEFzNCajT5jiyx84UBRcBcoBBoIeuyhp1s290rWm1tpVvg/eIEfA4ubDYJDFWgqu03M8V2k/hiyIHZgIxqSKhl8nT+vZhhHjWoN3SjBtxttQML77Ls3OXPW4P6doFjHjjBA1wftVSNxMiY1Oru+8MkQtFZLu5dYfkstVXupYA5OHEupWtmbWskmcuQVOxDDvb6UoSAw4LrbvGCvK9fxqFpa44q4ReLoHzi9jCV5MjsMhEVq10vSrOPybLuvVkBWrM371/lnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(83380400001)(86362001)(38350700002)(38100700002)(66946007)(66556008)(8676002)(66476007)(4326008)(478600001)(6486002)(5660300002)(8936002)(316002)(6512007)(26005)(2906002)(186003)(2616005)(1076003)(6506007)(52116002)(30864003)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xHjFSJEH6oy6eolRWc8iugEPjGQb0+QE+oXZQTbzpE1wPE/J7NvrlHP+4TdJ?=
 =?us-ascii?Q?ffzwNT2uK/Q/ehAfM536fUuywkakEMPskC8vo+3uigtkXzM1nJMKqDlTihkj?=
 =?us-ascii?Q?FoHFQ71cyzs1N17L0YlHomNanHF8IFu/z8O7jEgXt3UANnIAPUZawD837y9V?=
 =?us-ascii?Q?9SecKJRTdHvkYywC+dgFN0Zl4kAPa1VfaPJv0GO4rKhCHr4gBS5e64mx8Yqi?=
 =?us-ascii?Q?+KNFc4QKGCJdU1eojm391fQV5j+A9eX/2qaHIksKe4ubN1TfLN0wt4yyoVTm?=
 =?us-ascii?Q?s9CKDd3kKLiFhtyMRmpPEmc0cUTFHHBpShRkWimu1GsLrt1y7tJJhkqSspgs?=
 =?us-ascii?Q?Gr/Jr5Bgy/K+MPdXOkwik+FrHUCqD7R06FhYNlZwOfAL6prUJgqQXR79MYi+?=
 =?us-ascii?Q?2uFZYFOOSP7iOzgRM2B+pgUbsERWSuxo/iawx/5VUDnj0Vv0EB/vGIJ44Kty?=
 =?us-ascii?Q?Ptj8BK9VWkjRqKYD5MYKFgxRw82W92lBc2Yhhud2BVHFrt5wThUV+kR+5Bhn?=
 =?us-ascii?Q?FRZRsNwpMwFCRRviDWuYbzytBWqntUzN+DoYa7e5kydMKFR6U5XV2Guw1b03?=
 =?us-ascii?Q?dB+Y2/3dOkZPgEGpCZwl9IEW0ToxKOirStYmsEsGbpCe4ccegL0T5aYjdeka?=
 =?us-ascii?Q?+WjLfpzgZO/09lk1EH9t6TwUXREq6jjNNHjLS6ff6rwrIlKX8bFe1kfhkm1V?=
 =?us-ascii?Q?BVUBcp5KcxzPrzhJITHNQGUwpbU4yyL1QQJ9iV6wdcn3DQANTKsOO/lsl/M0?=
 =?us-ascii?Q?HeLw/ipMsGnMAIo2thJiC+gkjXqBIoG5iEOoiqHAhun1T47Vyntgw1zTPfUI?=
 =?us-ascii?Q?0y0lzaEJ2DD6furzdSCt6AsgGDLBbz6jpmMlOw8G9Cd7/6fU04bpbU/ceBaK?=
 =?us-ascii?Q?Kyr2Mn23WrUO4VRV39F4N+01nbBH6JmLYVnyRKZBIkkeUW9Gzd+wU4R7snV5?=
 =?us-ascii?Q?V0QVg5wFZ5mqxvXdNZCytd71Enq4Xv3g2yCeAIK/eiZkHTCDFfgxL+kjyLNC?=
 =?us-ascii?Q?ZSA37BFwxAFbOG7GziYES+Bcb/Yx2aoJzCEqVsQYKCszd12NyYHyRxU5iDVx?=
 =?us-ascii?Q?X+r9sjXG1nOc4rQUuc93Iutik0thG9piZHQyOOKAkpbI/smTXO3+bBgKlWeo?=
 =?us-ascii?Q?JqxV6Nu3e3o655yJ5M/yU5rpx1A2YkbbKk5K5XSadSGAWQY5UD3RzpbwdJiL?=
 =?us-ascii?Q?516UyaS4ggf4SBVEPnrNPJbgZ13cQEjHv20jwOPP6Mhh8u9qrr3cYpb9lBFT?=
 =?us-ascii?Q?1flAsK4oqYewz8gz9BR2A1oUjExgSBfS0Ea+XMaza1O79/mqn67KllpDM8dm?=
 =?us-ascii?Q?4ZF7zqV9YNSCS10WBZyXAduxG7kg3DY1EAj3+aY6gxlGIEvieT0lMi9deCp7?=
 =?us-ascii?Q?/g8XJjYlOGXHdgCQLLvvYs87GqPLoKfinSsZRrRoHVnwf0i1kb99KaN91Q2F?=
 =?us-ascii?Q?52n2rwq425pdWDoFxp78a52wpZjrcoLrhyI/Zhvvq6AcGQNL+zmvZhsWzV76?=
 =?us-ascii?Q?AWJwShuTq+uh45KJ0YUxndhGCdbyFluXycwpoauS9XvoEm2HSPQvbCu8mK33?=
 =?us-ascii?Q?QAMK8KUakwig6Yk7BeMCwTTUuCnKSwnY9PEmgeFk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47b5862-34bb-4dbb-539e-08da841877a1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:29:45.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEvlho+eQ8DQD+KfrPsJcPtHClzrWaHcIGzCPWNiStxLYKSgXw2GyRV5AUuRoef7vSgTQSviCt38yCvGUmMoAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
 drivers/soc/imx/Makefile         |   2 +-
 drivers/soc/imx/imx93-blk-ctrl.c | 451 +++++++++++++++++++++++++++++++
 2 files changed, 452 insertions(+), 1 deletion(-)
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
index 000000000000..52471ea42635
--- /dev/null
+++ b/drivers/soc/imx/imx93-blk-ctrl.c
@@ -0,0 +1,451 @@
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
+	u32 num_qos;
+	struct imx93_blk_ctrl_qos qos[DOMAIN_MAX_QOS];
+	const struct regmap_access_table *reg_access_table;
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
+	const struct imx93_blk_ctrl_domain_data *bus;
+	int num_domains;
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
+	struct device *dev = &pdev->dev;
+	const struct imx93_blk_ctrl_data *bc_data = of_device_get_match_data(dev);
+	const struct imx93_blk_ctrl_domain_data *bus = bc_data->bus;
+	struct imx93_blk_ctrl *bc;
+	void __iomem *base;
+	int i, ret;
+
+	struct regmap_config regmap_config = {
+		.reg_bits	= 32,
+		.val_bits	= 32,
+		.reg_stride	= 4,
+		.rd_table	= bus->reg_access_table,
+		.wr_table	= bus->reg_access_table,
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
+	bc->domains = devm_kcalloc(dev, bc_data->num_domains + 1,
+				   sizeof(struct imx93_blk_ctrl_domain),
+				   GFP_KERNEL);
+	if (!bc->domains)
+		return -ENOMEM;
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
+		regmap_reg_range(BLK_SFT_RSTN, BLK_CLK_EN),
+		regmap_reg_range(LCDIF_QOS_REG, ISI_CACHE_REG),
+		regmap_reg_range(ISI_QOS_REG, ISI_QOS_REG),
+};
+
+static const struct regmap_access_table imx93_media_blk_ctl_access_table = {
+	.yes_ranges	= imx93_media_blk_ctl_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx93_media_blk_ctl_yes_ranges),
+};
+
+static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_bus_data = {
+	.clk_names = (const char *[]){ "axi", "apb", "nic", },
+	.num_clks = 3,
+	.reg_access_table = &imx93_media_blk_ctl_access_table,
+};
+
+static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
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
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX93 BLK CTRL driver");
+MODULE_LICENSE("GPL");
-- 
2.37.1

