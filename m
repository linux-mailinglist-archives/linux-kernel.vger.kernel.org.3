Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3406759D0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbiHWFvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbiHWFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:50:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB97F5EDF6;
        Mon, 22 Aug 2022 22:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR16Qd2iDbqaIfwuvtRmpFooC8ONMdxVyDWlDc6Kmk2p0/5zqnRO9wOXs1fjUvZG/DRWeBhfeoAtG19P7lYBS+kR6Ff3QQHzY1eX+W/ZPsiBaUQ3FLZr2uxOHUy7Ev7ESMnvUtx4AS9TPTzSpVS5Lkicbed8TisJkRTjAWK/Z1qlTwqCW/ngAZxUMulFmQ99wQ/GK8NywmvoTetVWveDUjfAfZYnPgNShL9M9zr09RjBey5rNtqMfiI0gmUbzbf5cFZlhG9qDF7NAOB411NdnnCJrY/80BlOfwtl3+rYSYTaPi8NkdbRqmYj9EIrNLpJdBDXoyDkUvd4j+h8cpxrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9flqTY3HhpRXXamDrEXa7UYd1epnnjh+YjM5oByybk=;
 b=XHWpmhOaUJbm1C+yDa5+i+cYZzswC+8LurqLZA7YOtNwdDUvYAvzCJBnA1d8aedKls7OM7k4feEHbny27hmm3ZCExEkMs588NMKVynv0T/9BE26yqyp+LLQZvNvtuYPdqzM44ZoVTWhjOUOR6j7TGUXK82o0S6jDwcbu7BIa+4qcBpwZm1qpLBH4nNoa1DVSTxbHSkUfJVYrRMvYWtu2ZkYCcYo+AczZ2uPLk65/Q/8CnvHkPI9VqQasM0dh9iZ86Z/6BP+uPYWYTiw+4kF2NV7tM5Gip0iILFj7PxgZY/19q1z/dZSDL/DYSgMBDu4pZVqkPYY6vyFW1bC7e+aCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9flqTY3HhpRXXamDrEXa7UYd1epnnjh+YjM5oByybk=;
 b=EVfI/f6ZR0j5xlThv+CCyIRBziY5D12mx5DNzmbQ9nLw20SpJlJPg7dB1+qsAyqq3ICGzd92mRFr1lNSP1U7VBEXw3UqbiNAsyDQHUiHQ0M7qLwTHSbGkcMmW3J+KHKu/FWIY502PmpPtQwbJsnGfKAlulVhzQIwTI+VxFgfrDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:50:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 05:50:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH V8 4/6] soc: imx: add i.MX93 media blk ctrl driver
Date:   Tue, 23 Aug 2022 13:52:13 +0800
Message-Id: <20220823055215.1139197-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 333e36a6-775e-450e-5584-08da84cb70b6
X-MS-TrafficTypeDiagnostic: VI1PR04MB7165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fewl+GbA+QcZ0nweFPZym2Gw0eU+iNWOWKd1OiZyFi9zUfhY3na3vc7EWTjWBrUFLgNiTfysc81IjULwfAnqVrYg11O+iED6/XRr0TwamRprs2jAeuxfzt2efcsq5+2Ht0MjGIZSYhad1f98s4w73ooft7oYny066Tp9LnF/K3iVACn0lU3/vb78XcDlix1wsxeWj553UseXMZLgnkhi9rPG/WVGCf2GbKIXGMXwcR4qn1zIJ0pfs+hIDJUxjdBD6MTbcFU7L3kgtEX6psp+y1P5Z4zi9lPMS1tIFx1H9iZEDeX9KqBe3wFXrjWfdT0quJ/WwJAJmd4Q2ySm/sUDBhrjBL49FzozZXFLdVamhAtxy/+jNcZR6ep2SzBGF1qF1d9vRw+CCD5Je66gfA156Bbbd3DKx/LsMyFUWfCGd9xpi8Y5Z2Mpgz5J7/jxISYdmi+pmoraLbG28klQuTcZxAWmENe4wwCTtYMC6eTIdavOoWKSxx1SYok1kUjVBB2KPPFMtXnIwfUcm0++Quj5TfIGj6urYHelsPFzUjj2qd1p/xNm2a5HmXu+/e7RH3yzHsejbuNReGpdlkDpCGhjpEM0heuomK7xhk7+NyTAxZT7FwBhModV4SMwhDaPnLLwzMq+a7Y4bwQ3UyRK2PsvqqJUzkpv2dR5u9nwrIEYQu9WVFmTQqqG9BbwWQv+rbyoN1HY62MLI4Czut44QNGo6OhJiRjnk8wJ+QfZLH060KgUhI0yJW7j4ggf5D/WLRvSeiDgx+UJXPwKyKZxx8VZCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(2616005)(83380400001)(38100700002)(38350700002)(54906003)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(26005)(6512007)(6486002)(6666004)(86362001)(52116002)(6506007)(5660300002)(2906002)(186003)(41300700001)(1076003)(478600001)(30864003)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e1P24QTtmUpW1UPOjZ57tnQMtrZgdYeHBKlPGcUnzjYzquK1PGXmS5NSEwZ8?=
 =?us-ascii?Q?XwMnu0PgEhBjY4iOpenRbgw6Q3oWlKv+etN9md+0LY96EAVidmxYDz+/HHTl?=
 =?us-ascii?Q?XoI3OtazprADM4hwLcfOTAb+aWNmI9G7T3lrAYtwMXQgmIG7IshEUf+jefn0?=
 =?us-ascii?Q?RGsV5H8RqFCqUcF6ynFROChqqmywgQjMv5RM5kMqWohS5BSqOEW6kPqBa0MK?=
 =?us-ascii?Q?pXVVbj7T7efyrUP6oBleSfncZWVXKkuQJIXFp5GtXQUgx0KARqKpennb3iOj?=
 =?us-ascii?Q?Y0ClfX/2fYeXcYk2P6vazvXCxLdbvX/xR+4ibVc9D0m3SvJbX2VK3l9R6hl/?=
 =?us-ascii?Q?2W5YIg6xNIfcE7b768h8reDzc3iVdqKCt8ovBuFaiCqm3qyrbtl2pHFaNjn9?=
 =?us-ascii?Q?zLaS1UyVAX1Pw/2S0pU+Nf7q6+gXgZgACpOs0zArIH84wn7EdRhUDvofIOn8?=
 =?us-ascii?Q?/ktnYG6XrFwzWiNMrseEBZ3myWuVCTj2153N/zANrDtH8zBnMMk5mYwwazQP?=
 =?us-ascii?Q?TKGT/o1RUSO/jVly9aBLRZ3kAMJ2hMYeJaV9NkM2HPNMwYC4fyqcZwZEjXnG?=
 =?us-ascii?Q?AKCbfcnXGLobvEo8FHINE2usPQ+sSVzo4FSkAYn4lTYkBSNcDmA++U2KRXeo?=
 =?us-ascii?Q?8vLlsOMXUhvFKzditwtImieyzA1NLpIfslpdp5tsVwpS8DVwtKmhGDhIKl21?=
 =?us-ascii?Q?SN64m76hl5o3kbAYEd/RwJmGTMUpi/yZ2vw095JWfa2qAaPYvzIidDw9brZI?=
 =?us-ascii?Q?4byIbvla4YaVAWSLXt4lODub/j+OwGyms7kCqHjZGapXiTZmfG9BkrNWoHQs?=
 =?us-ascii?Q?4CIXn7zS7I6SDwXAUHnIHy1RD6BDYZfGT7eLjqkQVDlyEaS70XncHbWpvuwL?=
 =?us-ascii?Q?CIU2/cHRLgDTEXs43PDWEs9DAhloOV7mRrXyy2G6JvqAU3ZwfmfPUBrGc1yo?=
 =?us-ascii?Q?ItSBiNadPbPD2/NMiSkubynYLYUO6jgPOPQ8mt7wjpC1Yn+iifWDs5TLW1bv?=
 =?us-ascii?Q?eei95NhGRubch+XFoHLJXbXVteIucLp7BOx7rRsrvlsngC/BeTCTGZLauYEc?=
 =?us-ascii?Q?L9NR0hePGy+7tmJyhCiGCVWkYmqggPQfPehh+hgr3cUmpyhEmfA58SfOyllo?=
 =?us-ascii?Q?S0Qnyh6GYiKDYcNqtxtaxDsNAeZxsr9nRWlCQEIycTCYubYL+hVnX/NdENOx?=
 =?us-ascii?Q?pNKY7Jmk1ErYhFQOyaZvgEtyqVhxMBjQ2gKyVlWuymQCCNpDCzyQKn4hr2SL?=
 =?us-ascii?Q?5h+Rob2moqjgQEEpJXAy8AdLX2B4LoN0g2ZpBL04yWnG+xMVmC6JqRjv8jhz?=
 =?us-ascii?Q?9Eh4P3S8JXEiohLfgeIoYq3T0khU6Qgz3XU0jwP0cB87L/hzqB43mMCePO5z?=
 =?us-ascii?Q?Oq/qqj495NrMexTSFms3xUdP+LBykIim+ZRtwU5BMkgNfjYx5YAyWe53gdmp?=
 =?us-ascii?Q?nZiiHGsoq+hPR+J07ZXqsGZlPXk4dsBi4pHxkXJbqxQuuM0o33va3FghBdzB?=
 =?us-ascii?Q?xaSlzlXKs1Osn/VAfYhVDiFbBlyLcI3SU3Q/L+G1wwdURfQkxuSj2NbcXzN/?=
 =?us-ascii?Q?+SKCxB8SK2h+4Op3ti+1fT4oP+jEAGdiirihx8Y6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333e36a6-775e-450e-5584-08da84cb70b6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 05:50:53.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: an6Z85/Q0DVkesm+F7PQqSRthF8V4+w8BdGtRdtzmaYmJMav6zCw3DyOqgBesXEpx2bjlW+xacm/7BkdvrzX7w==
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

Add i.MX93 mediamix blk ctrl support.

i.MX93 mediamix blk ctrl has registers to set QoS(priority) value.
It support default QoS value and cfg QoS value. Set an initial
value from i.MX design team. If LCDIF/ISI/PXP wanna a different QoS
value in future, they could use interconnect to request bandwidth.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Makefile         |   2 +-
 drivers/soc/imx/imx93-blk-ctrl.c | 452 +++++++++++++++++++++++++++++++
 2 files changed, 453 insertions(+), 1 deletion(-)
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
index 000000000000..12f4e635b46d
--- /dev/null
+++ b/drivers/soc/imx/imx93-blk-ctrl.c
@@ -0,0 +1,452 @@
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

