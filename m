Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E616A564639
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiGCJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiGCJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:10:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652B163F3;
        Sun,  3 Jul 2022 02:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVKAQFIK6PapyZGNNNgC0K6eZW8M/89CFucJVg3nEWluebFANcV/ghfEQv9UOn6bFRi4ia00O8ATZmTqze3SRB2CbSQmMdTvsbEfhQoRmfkb5GgXxsVCfDrc1g0f/IukRDxyQRWGemzHik5U2JwxinT5caIWSklR8v60qmUlaWv4gS/E7YmGsfQO4HjKQod2nrg3SB8KDmPvGY4/IonDy48pdhrfCYju0R4q7zsUTRNuovB1b5dPjSY7S4Q1kFEeXcBHLW7o+I9v3wpG+mwohZ0t30dv8aVWS3PfTLs8zIYgwMI2u2jXz1LRZx14qC4zCi5RhlZT1iQZ7WRpnkV/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWyzgB4lxvE+GkVHz5FxBusaeR3EUW16OkLZlY3dGMo=;
 b=mDYA+DnHjrZz9KFIOtnGgLuh/oUNd2ieOzvHZmPNW74ZyH6AaX0WkIJfWZ1n01h8j127hAyaBRmJNAKlRKVC7TahkK5VLKSHf9LODoTM93vQJVjhIPTIiL9A8f5pyfa2mhQFu5vLs+M7EyyP4zkOZTQg0EPK6Qwdpe6S11lXATJTI1hwm71IqP7fKB+ve8AKvFVxoAx04Y477EUUNvRUb37pzbtfEGV9e+KU3JG/MMXsZ3UKUYDMRLN1FWa5xryr06N31GkjW5z6VdfjJr57eUzHvY5jfeoadLvb3KxdTIcKCr6YmWeCTe/oD03l22+9EJ4C3lLcZq3QTMwjx9Nbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWyzgB4lxvE+GkVHz5FxBusaeR3EUW16OkLZlY3dGMo=;
 b=eCivvZfpJTjxx4fQ7MY2Nl3Z+5OHwQcrn8T5oWGXqqaUTF+oEjmT8L6lS6fwNhCA4xXWrMWLfjtq6iT9uojR27+odAYfHQFI2S+kGdHBflBevcr2MjoUsG9cf/yJ8kyZf7OTaXCs/1Dh1GQ4JRZ2cbTZKJJr/RFAOEO9TTuxK5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:10:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:10:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 07/10] interconnect: imx: configure NoC mode/prioriry/ext_control
Date:   Sun,  3 Jul 2022 17:11:29 +0800
Message-Id: <20220703091132.1412063-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fc7a4e5-5b1c-4711-69a6-08da5cd3eb28
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pqH01g/6M4CoZ1yzbRMPYedfEgrPRaaB/nv9b8pHFVDjfij/GqVWkPUY7xQeYww9/vZmZROnIeayL3128gqw2MNOEDda09TWVhRP+vaknEHyo5Ar7rJxjoe+/bDTggsawNJYm7N4O4KFhb3nHqkdQvS4uYJqIXd70NmJF7cnXqmFMiuWWnDHnWRh7nCdMRWv/4WugC01f7IQdj9O2dOEtdd8TN0h7GtQDQyKsSFQbzzcMF0OaSe/J19NvsxzFLVZ9cYSfbEu7jnYXDKg8H4cXhU6d3Z9vGTbVN9yYcxr+unvzmqMpgJFfgR0dbXKdojY4Y1Lr1JufzpBHOWRdn2vrSMkNemIydrcoNJ2jY5Y0iSob+Ysdv2xaMulC7aVroo0As5V8bC9/nvsUzIqhOvCXH1z/BvavMBeIARo0TOvnB4ZlaSD4+dfNaXTMv/GQybSTIr4YjsQ1oT3qzYkem0PTtg8QMl1fUBHo+7nWoOfDYyQDWhRDdqq/lDV/aNMDnHAFTNabfUNuMLP+wxbjvpb4ddAAMrqVja+jLilZ35a/YLLJ1YLfjeLVvY/9WrRobZj6VJGuzz3DyH0Ffrm4hU8LzoPV8fwB11CW3M1P9PXipqAEJ4ybl/BATwdfrhgJDbvDEp5UwYfe61mGvMfCIxrbhP1TMQYKzxGK+BwtJUMO1iU+h5QMGyPFHwFXz6c4MLR/qIaZB9LGbAXXc1Tl8UITFja7WrDf2FqFa8c3B3HKEEJ6vIh/Tys4GobQapEILCE1eNW0PrIphSwOjShC9BPAqkzs46eUdwHotFGh4LyAKk+E4CSKm6RlcincatFzzBlXU0YLnNnr3PN9W34zQejQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(6666004)(2906002)(41300700001)(316002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(83380400001)(1076003)(6506007)(52116002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d8i5RRhD2LPJv62iIQ7i/aiZGPPseLuoucPIYN03AXkhOI29kVg0AEf0IaTG?=
 =?us-ascii?Q?KeI/77nopjgSK6SAuLoAw4bGnuxkhws9fX28rOXGJtSipPLjSZLC0Hj4PL2Z?=
 =?us-ascii?Q?3xGxwXHdz7tRIIRdaxnOwQiyI8XYRbLRruL+6SQUoUxuAIOyFy/JxGnij+qh?=
 =?us-ascii?Q?tHhZ6JmjWTxJdYaybjdCMo9JFMLIq5/sw0A5CWIeDwohZuBF2B4Y2TGYIZnN?=
 =?us-ascii?Q?+J21aLVfsVUYoHUbvKhsVaI4lNdDpQJgDBRn1MlURRVp86gWJf9lb8DjnEsD?=
 =?us-ascii?Q?ZzxrQVIMvcx3RMsLVwuLL16ZX6aP0tMIxNCYL3cFV0a/cCxQRYVYYeEjvfr2?=
 =?us-ascii?Q?wV/k04SyZdzuizXNV35+876vel6FH50MwHROEB1BIOoLAPkmfSraTlLU7434?=
 =?us-ascii?Q?Gaduj4g0Q/zHnyVjWexLhOPMnuM0yfxcm7T2SGsoupNNp+l+GI2qRmv0jS6T?=
 =?us-ascii?Q?swxjtyoo6d8vqKrzxukM5ZXbqlw446DCpSAHVodSvsL7VQoPddAjYe5FuXHc?=
 =?us-ascii?Q?hK9FD617urNSShvYYs5z4nGYIXSKHZ2KIBQ/a6YbsE5ffCIJ76MMBcEiV7xq?=
 =?us-ascii?Q?2g++qWqcYZrnOSgRi2tAQEsyGHIuk78SSszTgpBDXsWTOHEbSlRDqGkACwYB?=
 =?us-ascii?Q?njeKDl8OLwkIVXD3kB+Zp+vKeyhem1EbQtEEVqc5VHQh0rNTT0LHkMVQH1Id?=
 =?us-ascii?Q?6dwCHcPAo2xADL9sl5JO2e2ocejgCjmDwo4xmaWerndOFl2jLuWE9VBmsux4?=
 =?us-ascii?Q?Q4Pc1n0KHrSXltuxbH8s9SzXQJtg+wxrh24z0CgO36qUoCUoqac8OAPYQMYU?=
 =?us-ascii?Q?ZPM54thZc16Xb8FrL3uyf994TtpM8+KgKGj6gmFdTsAwvNtQWOs+uGHpm7kL?=
 =?us-ascii?Q?squPzzt3m7wVkVu6UZnwOmCgAR6hlCV12yPaFW9GQcieyf4ZHFErfV4XxdLN?=
 =?us-ascii?Q?21IcYpciTBVzUQtZRZwRM7hpGwXHoTORMrkkbR+La2b5y4VJZ9SRIhcew48p?=
 =?us-ascii?Q?GtK+IPDkGWPaK3S5Qi/50hxUQjw+GfhFy983zrT5Cq0CaqKjnxL5sZeJ2ZfI?=
 =?us-ascii?Q?Q0tq5oR+cnUgxmstkp+oxGwwin1VUhQcJ4ZuDEQpaGnsL3StCP2s8BbCjlRO?=
 =?us-ascii?Q?qfWil3buHghHeQ4Pmb4hYFl8K4WwWAILMTYZRwKhjlUneGvQbUl8lMeFn/WX?=
 =?us-ascii?Q?1LgHs6mbPs+/Q0w4o1c1z5zRms6s2LVO9e0Rj7lo2ds0XKQHYyFnvtFoxKhx?=
 =?us-ascii?Q?F7tk9AwNSj+h0mF3CCl5qn4GTLZrh2l59SoWnQaHWXMo1X0ZzFJZy35w9aH7?=
 =?us-ascii?Q?2XtKLRbQb2OCnmFCikGnnZ3+2IJmkCnff/X7ZEl08oQgy8+JIKo0Dd14SM8N?=
 =?us-ascii?Q?CA1UHSAX7gEXmFsvGTR0QR3f/MqsF8FxauA7XYVIY+Q7vfCarZ+uPUBeZzBQ?=
 =?us-ascii?Q?oZRCsg/CfRdA80TdO5ZhIfYO66i2uyL3xDUCtaanPfgfzxT0abApnQ2OMMhs?=
 =?us-ascii?Q?9HFPWrz8Nb1JVVNMHwjewoVnMUcSqrDUOG8tq570RVSUiQvQrBl7J2TmbB9U?=
 =?us-ascii?Q?d2CPoYhpsOcwmCP5tljjh2GgJdpNc4iyfMxLXA4o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc7a4e5-5b1c-4711-69a6-08da5cd3eb28
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:10:48.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/XgJnspLlqtxjrNNzI+qbYPMMhb5uCAOIkwhSOfTdqWndPBHOVHHLIUvFxD7lCYSY1K3ZVYPS/Q+j72Od6C0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce imx_icc_noc_setting structure to describe a master port setting
Pass imx_icc_noc_setting as a parameter from specific driver
Set priority level, mode, ext control in imx_icc_node_set

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c    | 50 +++++++++++++++++++++++++++----
 drivers/interconnect/imx/imx.h    | 43 +++++++++++++++++++++++++-
 drivers/interconnect/imx/imx8mm.c |  2 +-
 drivers/interconnect/imx/imx8mn.c |  2 +-
 drivers/interconnect/imx/imx8mq.c |  2 +-
 5 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 1f16eedea21c..48ffd59953bf 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -21,8 +22,10 @@
 /* private icc_node data */
 struct imx_icc_node {
 	const struct imx_icc_node_desc *desc;
+	const struct imx_icc_noc_setting *setting;
 	struct device *qos_dev;
 	struct dev_pm_qos_request qos_req;
+	struct imx_icc_provider *imx_provider;
 };
 
 static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
@@ -37,8 +40,30 @@ static int imx_icc_node_set(struct icc_node *node)
 {
 	struct device *dev = node->provider->dev;
 	struct imx_icc_node *node_data = node->data;
+	void __iomem *base;
+	u32 prio;
 	u64 freq;
 
+	if (node_data->setting && node->peak_bw) {
+		base = node_data->setting->reg + node_data->imx_provider->noc_base;
+		if (node_data->setting->mode == IMX_NOC_MODE_FIXED) {
+			prio = node_data->setting->prio_level;
+			prio = PRIORITY_COMP_MARK | (prio << 8) | prio;
+			writel(prio, base + IMX_NOC_PRIO_REG);
+			writel(node_data->setting->mode, base + IMX_NOC_MODE_REG);
+			writel(node_data->setting->ext_control, base + IMX_NOC_EXT_CTL_REG);
+			dev_dbg(dev, "%s: mode: 0x%x, prio: 0x%x, ext_control: 0x%x\n",
+				node_data->desc->name, node_data->setting->mode, prio,
+				node_data->setting->ext_control);
+		} else if (node_data->setting->mode == IMX_NOC_MODE_UNCONFIGURED) {
+			dev_dbg(dev, "%s: mode not unconfigured\n", node_data->desc->name);
+		} else {
+			dev_info(dev, "%s: mode: %d not supported\n",
+				 node_data->desc->name, node_data->setting->mode);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	if (!node_data->qos_dev)
 		return 0;
 
@@ -135,7 +160,8 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 }
 
 static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
-					 const struct imx_icc_node_desc *node_desc)
+					 const struct imx_icc_node_desc *node_desc,
+					 const struct imx_icc_noc_setting *setting)
 {
 	struct icc_provider *provider = &imx_provider->provider;
 	struct device *dev = provider->dev;
@@ -164,6 +190,8 @@ static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
 	node->name = node_desc->name;
 	node->data = node_data;
 	node_data->desc = node_desc;
+	node_data->setting = setting;
+	node_data->imx_provider = imx_provider;
 	icc_node_add(node, provider);
 
 	if (node_desc->adj) {
@@ -187,7 +215,8 @@ static void imx_icc_unregister_nodes(struct icc_provider *provider)
 
 static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
 				  const struct imx_icc_node_desc *descs,
-				  int count)
+				  int count,
+				  const struct imx_icc_noc_setting *settings)
 {
 	struct icc_provider *provider = &imx_provider->provider;
 	struct icc_onecell_data *provider_data = provider->data;
@@ -199,7 +228,8 @@ static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
 		const struct imx_icc_node_desc *node_desc = &descs[i];
 		size_t j;
 
-		node = imx_icc_node_add(imx_provider, node_desc);
+		node = imx_icc_node_add(imx_provider, node_desc,
+					settings ? &settings[node_desc->id] : NULL);
 		if (IS_ERR(node)) {
 			ret = dev_err_probe(provider->dev, PTR_ERR(node),
 					    "failed to add %s\n", node_desc->name);
@@ -237,7 +267,8 @@ static int get_max_node_id(struct imx_icc_node_desc *nodes, int nodes_count)
 }
 
 int imx_icc_register(struct platform_device *pdev,
-		     struct imx_icc_node_desc *nodes, int nodes_count)
+		     struct imx_icc_node_desc *nodes, int nodes_count,
+		     struct imx_icc_noc_setting *settings)
 {
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
@@ -266,13 +297,22 @@ int imx_icc_register(struct platform_device *pdev,
 	provider->dev = dev->parent;
 	platform_set_drvdata(pdev, imx_provider);
 
+	if (settings) {
+		imx_provider->noc_base = devm_of_iomap(dev, provider->dev->of_node, 0, NULL);
+		if (IS_ERR(imx_provider->noc_base)) {
+			ret = PTR_ERR(imx_provider->noc_base);
+			dev_err(dev, "Error mapping NoC: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
 		return ret;
 	}
 
-	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count);
+	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count, settings);
 	if (ret)
 		goto provider_del;
 
diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 0ad2c654c222..e0a2ee173ecd 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -15,6 +15,32 @@
 
 #define IMX_ICC_MAX_LINKS	4
 
+/*
+ * High throughput priority level in Regulator mode
+ * Read Priority in Fixed/Limiter mode
+ */
+#define PRIORITY0_SHIFT	0
+/*
+ * Low throughput priority level in Regulator mode
+ * Write Priority in Fixed/Limiter mode
+ */
+#define PRIORITY1_SHIFT	8
+#define PRIORITY_MASK		0x7
+
+#define PRIORITY_COMP_MARK	BIT(31)	/* Must set */
+
+#define IMX_NOC_MODE_FIXED		0
+#define IMX_NOC_MODE_LIMITER		1
+#define IMX_NOC_MODE_BYPASS		2
+#define IMX_NOC_MODE_REGULATOR		3
+#define IMX_NOC_MODE_UNCONFIGURED	0xFF
+
+#define IMX_NOC_PRIO_REG	0x8
+#define IMX_NOC_MODE_REG	0xC
+#define IMX_NOC_BANDWIDTH_REG	0x10
+#define IMX_NOC_SATURATION	0x14
+#define IMX_NOC_EXT_CTL_REG	0x18
+
 struct imx_icc_provider {
 	void __iomem *noc_base;
 	struct icc_provider provider;
@@ -44,6 +70,20 @@ struct imx_icc_node_desc {
 	const struct imx_icc_node_adj_desc *adj;
 };
 
+/*
+ * struct imx_icc_noc_setting - Describe an interconnect node setting
+ * @reg: register offset inside the NoC
+ * @prio_level: priority level
+ * @mode: functional mode
+ * @ext_control: external input control
+ */
+struct imx_icc_noc_setting {
+	u32 reg;
+	u32 prio_level;
+	u32 mode;
+	u32 ext_control;
+};
+
 #define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\
 	{								\
 		.id = _id,						\
@@ -61,7 +101,8 @@ struct imx_icc_node_desc {
 
 int imx_icc_register(struct platform_device *pdev,
 		     struct imx_icc_node_desc *nodes,
-		     int nodes_count);
+		     int nodes_count,
+		     struct imx_icc_noc_setting *noc_settings);
 int imx_icc_unregister(struct platform_device *pdev);
 
 #endif /* __DRIVERS_INTERCONNECT_IMX_H */
diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
index 1083490bb391..ae797412db96 100644
--- a/drivers/interconnect/imx/imx8mm.c
+++ b/drivers/interconnect/imx/imx8mm.c
@@ -83,7 +83,7 @@ static struct imx_icc_node_desc nodes[] = {
 
 static int imx8mm_icc_probe(struct platform_device *pdev)
 {
-	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
 }
 
 static int imx8mm_icc_remove(struct platform_device *pdev)
diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
index ad97e55fd4e5..1ce94c5bdd8c 100644
--- a/drivers/interconnect/imx/imx8mn.c
+++ b/drivers/interconnect/imx/imx8mn.c
@@ -72,7 +72,7 @@ static struct imx_icc_node_desc nodes[] = {
 
 static int imx8mn_icc_probe(struct platform_device *pdev)
 {
-	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
 }
 
 static int imx8mn_icc_remove(struct platform_device *pdev)
diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index d7768d3c6d8a..7f00a0511c6e 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -82,7 +82,7 @@ static struct imx_icc_node_desc nodes[] = {
 
 static int imx8mq_icc_probe(struct platform_device *pdev)
 {
-	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
 }
 
 static int imx8mq_icc_remove(struct platform_device *pdev)
-- 
2.25.1

