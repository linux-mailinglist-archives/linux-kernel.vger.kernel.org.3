Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4E4F5E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiDFM34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiDFM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:28:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE13235864;
        Wed,  6 Apr 2022 01:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvr/WLSj6XIbt+ldhGRjAASjOEA9tIExW05EM7u+7M+kHyt3aFj53lLytUnDlx8BBOmYrJ/ZZIhpFv3dIPtJgfHx5DvtEwAzMyzHMqWBkrDRFKgPCdR1shgWhV9q5mJas7Zez2n3CgeotQwjU+omZxjm9KoJWeFCn87WUB2z+0Yts62H8XUmaSnWNqFRb6mbTuWvCfpTWoSETjCb1D8DQPr7vxjHjNtAM/j5hOYg3A8xHx9GrOOdjbZw+JqXRldIeQsSWeXqHMYeePRiIrCs1yztq9e+ynIregXzBZgRFcoHSzSjLjNj1n5G+vD5gLVxJpegCZzkDEwN72r3RQLmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+o/qg80Ew6++aixaN9Tdz4T9QvQ/shVm/ZJ2ShgBmA=;
 b=gpbSjfW9TgYoyC74fO8VPT9A2c6Wxv863irSl6aXyN9nTSQxb+t1dNORsG48veSRjs637R0FztsEm5CFVbYBsbZr5OhCVO6kFC5VbbNans50phH6K0WNT/AZtWtvK/selSH9GEWh3VqW6Oz9+386+gnKogJugI25HpOcZ+LEybCTv3EO9Sow45hXE2VDPh9hZv/uZEOsVA2LuQLt35OxIdiJsuWSaZ1Jdu75KEGdti8t7EddhCmnyDAcvvaZ8eFUJ8uIH3BxxApmxcPuxrlqIs2iP0NWNqp/ofgyN4E64vJfAFpX8fagpRXrzLffLIPgZ6GGyOHca0XPBA5cyaJJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+o/qg80Ew6++aixaN9Tdz4T9QvQ/shVm/ZJ2ShgBmA=;
 b=Ha98RmvyNJaWnwyjajOfGnSjfuR93u3GKVmaPcrXU6Ndt3zd29O1EOn7DG5hWUycWUvR6onxgVoJiHOM3Jo0/UHxyPS54s6tnMW3gzHYhPBSll1DMur6TNo23SVYwci0wCrZ4ev8GR9ZOVyIHvGj6YJaz3DtwHi4Vqqyi1ZnTQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 08:22:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:22:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/5] soc: imx: imx8mp-blk-ctrl: introduce HSIO blk ctrl noc settings
Date:   Wed,  6 Apr 2022 16:23:30 +0800
Message-Id: <20220406082330.2681591-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bde08ce-b00b-4969-c823-08da17a68796
X-MS-TrafficTypeDiagnostic: AM9PR04MB8970:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB897001566112BEE6C7BA283CC9E79@AM9PR04MB8970.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FTRQmYldPG2cGT85fjVnJIVHisxUORfzx1GnFnG4ifikGa/j2rYDAGiTgZSXtpOFlulZYIfRbRS3lfGoQsvvoyJjzVYobyWFnxSRqPtU/QzFy4c3IE0c7OCfpaYrpqd6lTrrYU9dXW1CYoWieeR4fEFx3JFPi5V34IK2zoorS/ooOh0OsaFEm2Vvakx+YnVb0mU38M59WdlE6oqRh6IamTWxDTsbtYMn+I5QooBSt0rdscCECe0aOzfSCpsr8ZsQZ/uoeQyy9PRG5ETCyw5MxUYG7dkfXPybTqP10no2mgJxV92faXZ9EQfY2MQeMhYawYLjT4G6Yq0NLHuRfbu67IW5bWlSMCUjDNvFpafVbO/Bdgh+x7dnpgd7Pvbzto2o4yraJumessysel8S34uxcZmvqcsJgmfLsSO3SBRanXLV3+OotWOial3q6OyzsuLhyh+1IFdC+rpbji2WkQm3rVJlaQObtk5iaCPQ+LDFSsXzwHSBLDSYJnp/TdV/JHYrkXqRcqhqQSaizLlpQt2Sg75a4fsesL+ZW7Z7KphVAEx/TBRxXbEJnjefbJkFxYHnvBZ+B6EmDcS0XrG4W/FvsQMKgBqwRKv5WWHtb8EzKAThYv0POL0Qeqn3aeBgzfcMdMMNvrUhXDDNxdXct6ByxktwJHeP826GeTUjtjYa7gUIwF9xhIEP2jlhOzamvpNr4HVBQI5dqFCyh+JhG2dR9tSPRag0laoFR9+Ey6jxpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(5660300002)(1076003)(26005)(2616005)(186003)(86362001)(83380400001)(7416002)(6666004)(6512007)(52116002)(6506007)(8936002)(66946007)(38350700002)(38100700002)(2906002)(4326008)(66556008)(316002)(66476007)(8676002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udkPeMrz2NL8sm11ZjGo/7YR5JM7yqZJL0OZjVJy2hWQt7nglPn4whGXJMce?=
 =?us-ascii?Q?E9iySn8zWO2s/Eah3rKEZlWuKiSEE/ZIt4SxQx5xgT/gYZ+/2i3Zvvgw8n76?=
 =?us-ascii?Q?p1f30V947yml5n5CS+oraSCHLqVdVNJViYiaK82349XRk95QCAHF10x8rprK?=
 =?us-ascii?Q?JgaD+CQ8wm+sUL0UhPDC/6/qmoyh088WKU5MIvYL0XMwXDOuAwjL+fgZAKrO?=
 =?us-ascii?Q?ywhJxvsyf6Q+17pS7iymxqg5aNcYjyQEdwbYBILrNMwizY2J3JcF3wYhKfK6?=
 =?us-ascii?Q?FG0hXJR0iFCCafk0bNGbbfBbXz6/IFav6dWORsrwUDHT3VpUvdmv8nM2YyBc?=
 =?us-ascii?Q?5Gj89CqZo/G5ujfCYIagzJCYWQMMYFqnSwatg/gf1n6b5bdod4tGqOvDGD3o?=
 =?us-ascii?Q?7XbEeufTk1BqVAvCGfyyWIXKsNkOPiJpEX03pleL9JdRleohaTTG4JbhXvJJ?=
 =?us-ascii?Q?0vqgYphX79JQerorpJyKvliTC9iNQl8sFX/AlIvhdNPXuhzkLdel7SLGThSQ?=
 =?us-ascii?Q?IV7K7SKl+BoS3TYiLWLw+df+peVmuMPbLEQcI5+XYFMiUUBBvEvIxG/OJDR/?=
 =?us-ascii?Q?TI7H46AjmVyzkawW5iTAwjJkJGDBKL9ceOvlhUNtNERhcuJIvrJi/xTtGOVP?=
 =?us-ascii?Q?K8f3Fedf78gwUod16KlQSsZbvq2SqTECcmAzX4uGkS9fP2hD5C+p27VzUF5A?=
 =?us-ascii?Q?pJGXPmzXOb3II94g1w7Zz9+le1jiX33S4WaySh3dk2y4Jm4N6KLhYY7qpR0L?=
 =?us-ascii?Q?RJl9Q81mCOrg38qvsOD6xTPJCj2+oqWkChmyZOE2hhIfT5ghuMOeQXSjz7VN?=
 =?us-ascii?Q?6ex8V/o6piF24pizMKSLejqNG7HUdujd/V68y+XWXcicolsu/WLPn/aTG2bS?=
 =?us-ascii?Q?6rCR0BHraRYC3Kl1xCUJkUgg2LG2qnUeOeLT6FTQ5g9DXHfXqwTzv1k6sZkt?=
 =?us-ascii?Q?yYelT1vCm3xrrPeZpJ3fWF2voxL6ZUQEuU4cMbOJVy2070u2PyFeVfMPAdn1?=
 =?us-ascii?Q?XP5M9mzv0DpiHzS0czLay4qmQ5LphGt4d996IMHH2ahxcYcvPPyy9lQWXC4Y?=
 =?us-ascii?Q?1U0465cQbAogOCBlH4HLva01mTs/BI+thYEYfAEmBLKrSssVnG+13aXn6IKq?=
 =?us-ascii?Q?YJbn6ZebqQwjYk1DHK+WUUP9WzOgWHNlS8fdePpCP2rYbtTab2yAulJzKZZ2?=
 =?us-ascii?Q?9X96JlWnq8D2SffA0JCfqo77vp2Fq1rC2mj+HF9Vxwk/BUUnG5v8VBuhxUcE?=
 =?us-ascii?Q?DhwWJa0oD9QVkFmgcucbYquP/mfcH9M8QX8pA/qEwY39f2FtMu29vkfPEdpL?=
 =?us-ascii?Q?N2nO7RDddNJlVBkOgudFtFVC1ZVVwjjOmBcYTsiiMB2fR7nC4AouxrBrrPYe?=
 =?us-ascii?Q?VM0li/XwR7EjenK2aCubMePh4tMlHahBoLwVQxzd3V5QsKcIzs6PKH9Xu/HG?=
 =?us-ascii?Q?xy0S5fD+XKXCdIdzWyDIGHmVchrnzuL0ZcaYsa3sSKLbxQoIwmNe4Koncpgi?=
 =?us-ascii?Q?UFniZDwOzEcJdJTXP81A95BPS/qgUx1yparowcxlVIiQ4mqVDtPcEq1+5GN+?=
 =?us-ascii?Q?cLu97UKWgED57cAzlo66Hn4aPRxHaSaecOT+C6nrOXYTKii7rga6HHhdash9?=
 =?us-ascii?Q?Vchxre+NGBp9LcvUzcvMMWCxtOWe9mOH241OmBC6GgyqkckSCm2Ul14yjAhe?=
 =?us-ascii?Q?P1p3gj706LmzC4FidVE3EoPv83OgGVWrYmVpm6W81g4SYNmI/LBD+4Dz0jOS?=
 =?us-ascii?Q?E/8+UMDf3w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bde08ce-b00b-4969-c823-08da17a68796
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 08:22:03.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19CqqGQspv7XVfOdfQe8XiCJJsczuMw1OfFzK/XhvBsngjiaxXvuHrILpDJ+nR5YBYWWzPNcjXdHs6H1mnOInA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The out of reset value of HSIO NoC is not a valid value, we need
set it to a correct value. We only need to set it after power on.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 74 +++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index e832c007b063..929fd9b770ae 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -12,6 +12,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <dt-bindings/power/imx8mp-power.h>
 
@@ -26,14 +27,24 @@ struct imx8mp_hsio_blk_ctrl {
 	struct notifier_block power_nb;
 	struct device *bus_power_dev;
 	struct regmap *regmap;
+	struct regmap *noc_regmap;
 	struct imx8mp_hsio_blk_ctrl_domain *domains;
 	struct genpd_onecell_data onecell_data;
 };
 
+struct imx8mp_hsio_blk_ctrl_noc_data {
+	u32 off;
+	u32 priority;
+	u32 mode;
+	u32 extctrl;
+};
+
+#define DOMAIN_MAX_NOC	2
 struct imx8mp_hsio_blk_ctrl_domain_data {
 	const char *name;
 	const char *clk_name;
 	const char *gpc_name;
+	const struct imx8mp_hsio_blk_ctrl_noc_data *noc_data[DOMAIN_MAX_NOC];
 };
 
 struct imx8mp_hsio_blk_ctrl_domain {
@@ -41,6 +52,7 @@ struct imx8mp_hsio_blk_ctrl_domain {
 	struct clk *clk;
 	struct device *power_dev;
 	struct imx8mp_hsio_blk_ctrl *bc;
+	const struct imx8mp_hsio_blk_ctrl_domain_data *data;
 	int id;
 };
 
@@ -50,6 +62,27 @@ to_imx8mp_hsio_blk_ctrl_domain(struct generic_pm_domain *genpd)
 	return container_of(genpd, struct imx8mp_hsio_blk_ctrl_domain, genpd);
 }
 
+static int imx8mp_hsio_noc_set(struct imx8mp_hsio_blk_ctrl_domain *domain)
+{
+	const struct imx8mp_hsio_blk_ctrl_domain_data *data = domain->data;
+	struct imx8mp_hsio_blk_ctrl *bc = domain->bc;
+	struct regmap *regmap = bc->noc_regmap;
+	int i;
+
+	if (!data || !regmap)
+		return 0;
+
+	for (i = 0; i < DOMAIN_MAX_NOC; i++) {
+		if (!data->noc_data[i])
+			continue;
+		regmap_write(regmap, data->noc_data[i]->off + 0x8, data->noc_data[i]->priority);
+		regmap_write(regmap, data->noc_data[i]->off + 0xc, data->noc_data[i]->mode);
+		regmap_write(regmap, data->noc_data[i]->off + 0x18, data->noc_data[i]->extctrl);
+	}
+
+	return 0;
+}
+
 static int imx8mp_hsio_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 {
 	struct imx8mp_hsio_blk_ctrl_domain *domain =
@@ -89,6 +122,8 @@ static int imx8mp_hsio_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	imx8mp_hsio_noc_set(domain);
+
 	return 0;
 
 clk_disable:
@@ -143,11 +178,39 @@ imx8m_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
 
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
+#define IMX8MP_HSIOBLK_NOC_PCIE	0
+#define IMX8MP_HSIOBLK_USB1	1
+#define IMX8MP_HSIOBLK_USB2	2
+#define IMX8MP_HSIOBLK_PCIE	3
+
+static const struct imx8mp_hsio_blk_ctrl_noc_data imx8mp_hsio_noc_data[] = {
+	[IMX8MP_HSIOBLK_NOC_PCIE] = {
+		.off = 0x780,
+		.priority = 0x80000303,
+	},
+	[IMX8MP_HSIOBLK_USB1] = {
+		.off = 0x800,
+		.priority = 0x80000303,
+	},
+	[IMX8MP_HSIOBLK_USB2] = {
+		.off = 0x880,
+		.priority = 0x80000303,
+	},
+	[IMX8MP_HSIOBLK_PCIE] = {
+		.off = 0x900,
+		.priority = 0x80000303,
+	},
+};
+
 static const struct imx8mp_hsio_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 	[IMX8MP_HSIOBLK_PD_USB] = {
 		.name = "hsioblk-usb",
 		.clk_name = "usb",
 		.gpc_name = "usb",
+		.noc_data = {
+			&imx8mp_hsio_noc_data[IMX8MP_HSIOBLK_USB1],
+			&imx8mp_hsio_noc_data[IMX8MP_HSIOBLK_USB2]
+		},
 	},
 	[IMX8MP_HSIOBLK_PD_USB_PHY1] = {
 		.name = "hsioblk-usb-phy1",
@@ -161,6 +224,10 @@ static const struct imx8mp_hsio_blk_ctrl_domain_data imx8mp_hsio_domain_data[] =
 		.name = "hsioblk-pcie",
 		.clk_name = "pcie",
 		.gpc_name = "pcie",
+		.noc_data = {
+			&imx8mp_hsio_noc_data[IMX8MP_HSIOBLK_NOC_PCIE],
+			&imx8mp_hsio_noc_data[IMX8MP_HSIOBLK_PCIE]
+		},
 	},
 	[IMX8MP_HSIOBLK_PD_PCIE_PHY] = {
 		.name = "hsioblk-pcie-phy",
@@ -215,6 +282,7 @@ static int imx8mp_hsio_blk_ctrl_probe(struct platform_device *pdev)
 	int num_domains = ARRAY_SIZE(imx8mp_hsio_domain_data);
 	struct device *dev = &pdev->dev;
 	struct imx8mp_hsio_blk_ctrl *bc;
+	struct regmap *regmap;
 	void __iomem *base;
 	int i, ret;
 
@@ -259,11 +327,17 @@ static int imx8mp_hsio_blk_ctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
 				     "failed to attach bus power domain\n");
 
+	regmap = syscon_regmap_lookup_by_compatible("fsl,imx8m-noc");
+	if (!IS_ERR(regmap))
+		bc->noc_regmap = regmap;
+
 	for (i = 0; i < num_domains; i++) {
 		const struct imx8mp_hsio_blk_ctrl_domain_data *data =
 				&imx8mp_hsio_domain_data[i];
 		struct imx8mp_hsio_blk_ctrl_domain *domain = &bc->domains[i];
 
+		domain->data = data;
+
 		if (data->clk_name) {
 			domain->clk = devm_clk_get(dev, data->clk_name);
 			if (IS_ERR(domain->clk)) {
-- 
2.25.1

