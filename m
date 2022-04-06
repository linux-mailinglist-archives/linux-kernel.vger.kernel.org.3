Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC94F5E21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiDFM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiDFM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:28:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6E0373C61;
        Wed,  6 Apr 2022 01:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7qvILzBuxK/5yR4nErzbmd5M18ElXBFUil3Az8RWN1U3TN6nN27SmylcdJVN10l8aO6/EkYQhhwBiKM8e+ysru2l2yXYMWvCT0w7xUp6x+UUI2r66E85a+gohchmGIfPajtnpD+bZvpgrMAjNx59nm1DIdGLPRiLQ3RZTR32tPLTBBUdUx64S38Dgl1WO6C9KSJhsfckWWDdptn42OxItWLiknSzHRfBZUBbLIoPROhd8lHB8DWW9jmHbKVxcJnt78OqqP+ArdEEKUEo7ufJzT3waWyKFD+xoRxSw+6NSHpcr9T9zqWpb90lpo7CjvSF6ERxgA5ZZSbTYMrkd9qEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGM0GlgvDDujK/qoex7518ZPOdaTEzinQ3lLKEMK6RY=;
 b=ZHlzpB6VD0FsWFkEqwO4PtQgk3dn2ndgYwiGi33QSAqYj7VZNLZUs6ljSl8q1a492dUJvQNMR+uLWQox5b5YwV4YXsrraVHQGABOzhSeNPk0gf1lpQyrMzyMXxxyHvwTyOhjsyWjq/qXNi9rx6O8FmOQxEpJEDDs6MBvQnnqmd5EwHkjfbEO6tB4E6fJbl2pKVgfKDy1yDgDTSwCAJVFuIYFtVqgU5WWPyYZwWdDm+2f86TUNpPExAMMME2v7ovam5WLSLpH8KlfbH2w1CHkMcP5+drjIeJ9hy6cpbj9gX0gltu4fxlM6+yyripEPfxgPTCsSUy6RRAwFmgLPMvaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGM0GlgvDDujK/qoex7518ZPOdaTEzinQ3lLKEMK6RY=;
 b=k8Tm0rNY1ZtA+o2YTK2OX4jivWzdpquK3qXGOxP7cFZaRl7YBqUROXz752Xs+2DZdD/ck/wX4eojl9tyqKRz0iKOBh4kipJoXyb/pyZKdk9dv+SOmrH3VpTRGxnpI+Z5QB0xZnNPqq9dF0IW/i/D1yqtbqCr5GhkUryJon5UvOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 08:21:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:21:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/5] soc: imx: imx8m-blk-ctrl: support i.MX8MP media blk ctrl noc settings
Date:   Wed,  6 Apr 2022 16:23:29 +0800
Message-Id: <20220406082330.2681591-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe7c39c7-a48b-4c09-1f22-08da17a684ef
X-MS-TrafficTypeDiagnostic: AM9PR04MB8970:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB8970D061103AB335C54F8248C9E79@AM9PR04MB8970.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcur9weRxZV20saucYlSYYLLKpvdKab3NjZl5DJX0JnR0BGjmk9+1scn9aC1gT70liJ1AkPCy0ffrNxEFSjAR7Fl23ljhj+yeayYBBZpUd6MAK4Pur5Kn6jfw6OGAwJTrXkCMkktmsCTLXwQ+DCVjCZIP4g53bqp0lvTR2A9GxnxzHmhDHtmrumPBHfGu+3PCLGbH/CBL1cYgasH5UuUE5mepQIgReeRhDNupOUKh9FAtNubJAqLzu4RHDApBY+cSEXHiKE88ekTiJooKKT46HAxrOF7ecodB1yYZBT5Qk7Z18rUwmo7C5sHDOjTqPvha1QVWYYo8CmT3qdrmr53OnHgIOTLVXqxEbnEzY9eT5NtNaJz/rNQgGP9BfXrOHeQNc56kKRW9UO84jJyyO6d7R/WuvJhh2IwYpd5+WZ91/HquszRMu9lYYVyrfu4cGHhTFaJ+cTiQGl4vD/OScxqbzJ0g6F9rEsTATm629IOGvWu/K7FkAxeYHWDb/XCMBvKdqU9BiDAR8AQSqkPPH7OVlX70yHSMPXQzEzvmbwbBn3O0zGyTJUWpYspnmV8Ux7Yb3qOg6blrjLZB9OBmG36RvLZU8pGmfXJOJpzD24opQapY7d0/ATBWxL2B0LlMRV9cHnD5gf9kzfx7RIi3V6Wzar6FIwdDZm92lou7Io4DAF3jQW8Gf/7f+3vaBKKUErBmkFsbaVjx+bK/FSyVFYYLk5361gUp/7dAFGBMNK3BiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(5660300002)(1076003)(26005)(2616005)(186003)(86362001)(83380400001)(7416002)(6666004)(6512007)(52116002)(6506007)(8936002)(66946007)(38350700002)(38100700002)(2906002)(4326008)(66556008)(316002)(66476007)(8676002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4/kEsCvOmohutrYGfotdfpJ0Qgz/SF1IQYR+aPIgll1RTZgxt6bJ6uBCAF7I?=
 =?us-ascii?Q?CFTNvHpY3eY9/aivd4aIh3OFT7VS0nB5zLFgCdRe/HynX/Y6aqO5BJIIgoZR?=
 =?us-ascii?Q?LLcKIGiEdBMKBNC0rpuwtx0Qb1j+vOrTZgGSja6M16stsSLOP9XrSSJLU6S0?=
 =?us-ascii?Q?81ZVxwQ0DU8O1iXfhoMmJDPPkZXDQy2GmIDI1Jut6+jdA55K5PWZr4bifi0p?=
 =?us-ascii?Q?I89lXa4Kog9AEXI/ukgq0ALyboB7ryPEE1HdsLP/EnoVkODM74LiF5N4x1ox?=
 =?us-ascii?Q?vXRvzsBSe3HZcl1EhyFoP6nBvkQ15uJtJvISYUvdc3lCYIXBbpNWrzXDu6Xo?=
 =?us-ascii?Q?LkziBkp6qVjbKrhlGGrcU14yvMGZatZGHOdVz3BLb1AImazYPrWpT+QZC/LN?=
 =?us-ascii?Q?6NduAkfu4aGigR6pATMqUK/yDncjFfNQbGUs5i+rNL8+AqXhM62ImZVKSXPM?=
 =?us-ascii?Q?ypIeIRDDXtTF2G0zAKzOPB8IB22kKD7Jokrs1Pax9jRGne/270e2cP9PO7EJ?=
 =?us-ascii?Q?Z12lkrpGMW81DBpEYa32TS04Xw7xKwVZ73xbhmfeKsr+XFTDy98POU5ECSSq?=
 =?us-ascii?Q?j1Ye43NVg4y/qLp78Z0CLoVEzjCUKkslMkWsN+zUbRGjVBMtX2DViQMnkNnR?=
 =?us-ascii?Q?yVwrhEh1Bsb5CjGLgs/MQOecO6tlwUw9CubEerPQ+8yX9vuDegfZ1VFsxkXI?=
 =?us-ascii?Q?nJKEG2zfhd5e0OhmwsXqsu0zjMUVFFSjO2g26jcHnb+6/YQ+c9bPYZYDVQ29?=
 =?us-ascii?Q?E3El7MIKtdUlA1gtIJ2CM4ycWCFmDMp78viaC03RkZ0hLCzXCr06/gp5kNJv?=
 =?us-ascii?Q?l0BuNc+x9fBVnfGo43W75xTYblnLCYDhVEKMNf4SY0BGTeOThfZePWolmUkC?=
 =?us-ascii?Q?cRUMStYGtPdOYukrRM+shASxKdQRwPQft8+0s1qN4xtfxGu1gNH/x5XF3t8r?=
 =?us-ascii?Q?icvGV7eZF5xuln+63uooeVqjKHPvbeZpwAbyUliJqwLRQtXlS2XpUV4NUmuT?=
 =?us-ascii?Q?pTYj8kvXLySgyiC0shqkgS2YrV8qPyFyR1F0Dc9nGGlcqKT+x+fLzmKt1+0w?=
 =?us-ascii?Q?An5pkmwl3HjG7FqVE9FC8qwyoaQ2oDFprPAA1/yt8PiDggaThuK47Iwy8PTe?=
 =?us-ascii?Q?YSSeFc+SUPYaHzLOL4MW3omBDpNObdF591FKLMFDrFSIzvASNBuWjK5ZPDVF?=
 =?us-ascii?Q?+GlWNgjnMokPIr4c9x97rMjV4a2FlFp/sjgIwOmrN5jdBdUGYWBabnGfWxw1?=
 =?us-ascii?Q?PPRpubRcRm7edJtOizJLKOjef4tw+BIdDrSXKfsjl6VOyPL3idqcLJSFmlG0?=
 =?us-ascii?Q?GyBtkbXJ3z8b++jgTTuPuXzrAcOeHiMzfjVCD9ABpnLlsqk/0752nEiKpMaN?=
 =?us-ascii?Q?UxuENrVQoioOi3yA3lcDQ+Xsb7eJkjofNoLxoKUfyq9nJwnc77tEBge2+7EO?=
 =?us-ascii?Q?ue5Qd0d+R5ABnnwlD7axf9P3pYY7nEyhF3pWlGkGERe+ItZ3i1/7zK6207xq?=
 =?us-ascii?Q?w6OkX0ZcYqcKx7D9QE5EI+g99Ct6vnlagfZMOOYbLSL5m5awgzDcQ7G8FVcL?=
 =?us-ascii?Q?F4jAHe64Nr6DFKCLNNQHI1erfM0Z48rRskGvf29ZJhHHx/APM9Xn5D27EIld?=
 =?us-ascii?Q?rHjvjPAXXxNCrhlIpKgj1W4eO0hHNCwSvaObcjT7EyvSiAW0rG45FHwAkbmY?=
 =?us-ascii?Q?Qiy8YidoggsN0e4E4IbCPnCHqMl8i0UByeenUrO8hylTCooupjapYIz3cRru?=
 =?us-ascii?Q?PBWfNl6y7A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7c39c7-a48b-4c09-1f22-08da17a684ef
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 08:21:59.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCixDio5VVhBBo4pfXU5e3I8+Vi6DdPmPQ9Iy5SZixuk5+2cP9kUoA9ANAAnER+vqrxoxOduvGeb0ObBGK+3Lg==
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

The out of reset value of NoC is not a valid value, we need
set it to a correct value. We only need to set it after power on.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 109 +++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 3a6abd70520c..5b382b4e6a64 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -12,6 +12,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/mfd/syscon.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
@@ -29,10 +30,19 @@ struct imx8m_blk_ctrl {
 	struct notifier_block power_nb;
 	struct device *bus_power_dev;
 	struct regmap *regmap;
+	struct regmap *noc_regmap;
 	struct imx8m_blk_ctrl_domain *domains;
 	struct genpd_onecell_data onecell_data;
 };
 
+struct imx8m_blk_ctrl_noc_data {
+	u32 off;
+	u32 priority;
+	u32 mode;
+	u32 extctrl;
+};
+
+#define DOMAIN_MAX_NOC	4
 struct imx8m_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
@@ -49,6 +59,7 @@ struct imx8m_blk_ctrl_domain_data {
 	 * register.
 	 */
 	u32 mipi_phy_rst_mask;
+	const struct imx8m_blk_ctrl_noc_data *noc_data[DOMAIN_MAX_NOC];
 };
 
 #define DOMAIN_MAX_CLKS 3
@@ -66,6 +77,7 @@ struct imx8m_blk_ctrl_data {
 	notifier_fn_t power_notifier_fn;
 	const struct imx8m_blk_ctrl_domain_data *domains;
 	int num_domains;
+	bool has_noc;
 };
 
 static inline struct imx8m_blk_ctrl_domain *
@@ -74,6 +86,27 @@ to_imx8m_blk_ctrl_domain(struct generic_pm_domain *genpd)
 	return container_of(genpd, struct imx8m_blk_ctrl_domain, genpd);
 }
 
+static int imx8m_blk_ctrl_noc_set(struct imx8m_blk_ctrl_domain *domain)
+{
+	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
+	struct imx8m_blk_ctrl *bc = domain->bc;
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
 static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 {
 	struct imx8m_blk_ctrl_domain *domain = to_imx8m_blk_ctrl_domain(genpd);
@@ -117,6 +150,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	if (data->mipi_phy_rst_mask)
 		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
 
+	imx8m_blk_ctrl_noc_set(domain);
+
 	/* disable upstream clocks */
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
@@ -172,6 +207,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	const struct imx8m_blk_ctrl_data *bc_data;
 	struct device *dev = &pdev->dev;
 	struct imx8m_blk_ctrl *bc;
+	struct regmap *regmap;
 	void __iomem *base;
 	int i, ret;
 
@@ -218,6 +254,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
 				     "failed to attach power domain\n");
 
+	regmap = syscon_regmap_lookup_by_compatible("fsl,imx8m-noc");
+	if (!IS_ERR(regmap))
+		bc->noc_regmap = regmap;
+
 	for (i = 0; i < bc_data->num_domains; i++) {
 		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
@@ -677,6 +717,55 @@ static int imx8mp_media_power_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+#define IMX8MP_MEDIABLK_LCDIF_RD	0
+#define IMX8MP_MEDIABLK_LCDIF_WR	1
+#define IMX8MP_MEDIABLK_ISI0		2
+#define IMX8MP_MEDIABLK_ISI1		3
+#define IMX8MP_MEDIABLK_ISI2		4
+#define IMX8MP_MEDIABLK_ISP0		5
+#define IMX8MP_MEDIABLK_ISP1		6
+#define IMX8MP_MEDIABLK_DWE		7
+
+static const struct imx8m_blk_ctrl_noc_data imx8mp_media_noc_data[] = {
+	[IMX8MP_MEDIABLK_LCDIF_RD] = {
+		.off = 0x980,
+		.priority = 0x80000202,
+		.extctrl = 1,
+	},
+	[IMX8MP_MEDIABLK_LCDIF_WR] = {
+		.off = 0xa00,
+		.priority = 0x80000202,
+		.extctrl = 1,
+	},
+	[IMX8MP_MEDIABLK_ISI0] = {
+		.off = 0xa80,
+		.priority = 0x80000202,
+		.extctrl = 1,
+	},
+	[IMX8MP_MEDIABLK_ISI1] = {
+		.off = 0xb00,
+		.priority = 0x80000202,
+		.extctrl = 1,
+	},
+	[IMX8MP_MEDIABLK_ISI2] = {
+		.off = 0xb80,
+		.priority = 0x80000202,
+		.extctrl = 1,
+	},
+	[IMX8MP_MEDIABLK_ISP0] = {
+		.off = 0xc00,
+		.priority = 0x80000707,
+	},
+	[IMX8MP_MEDIABLK_ISP1] = {
+		.off = 0xc80,
+		.priority = 0x80000707,
+	},
+	[IMX8MP_MEDIABLK_DWE] = {
+		.off = 0xd00,
+		.priority = 0x80000707,
+	},
+};
+
 /*
  * From i.MX 8M Plus Applications Processor Reference Manual, Rev. 1,
  * section 13.2.2, 13.2.3
@@ -708,6 +797,10 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "lcdif1",
 		.rst_mask = BIT(4) | BIT(5) | BIT(23),
 		.clk_mask = BIT(4) | BIT(5) | BIT(23),
+		.noc_data = {
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_LCDIF_RD],
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_LCDIF_WR],
+		},
 	},
 	[IMX8MP_MEDIABLK_PD_ISI] = {
 		.name = "mediablk-isi",
@@ -716,6 +809,11 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "isi",
 		.rst_mask = BIT(6) | BIT(7),
 		.clk_mask = BIT(6) | BIT(7),
+		.noc_data = {
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISI0],
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISI1],
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISI2],
+		},
 	},
 	[IMX8MP_MEDIABLK_PD_MIPI_CSI2_2] = {
 		.name = "mediablk-mipi-csi2-2",
@@ -733,6 +831,10 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "lcdif2",
 		.rst_mask = BIT(11) | BIT(12) | BIT(24),
 		.clk_mask = BIT(11) | BIT(12) | BIT(24),
+		.noc_data = {
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_LCDIF_RD],
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_LCDIF_WR],
+		},
 	},
 	[IMX8MP_MEDIABLK_PD_ISP2] = {
 		.name = "mediablk-isp2",
@@ -749,6 +851,10 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "isp1",
 		.rst_mask = BIT(16) | BIT(17) | BIT(18),
 		.clk_mask = BIT(16) | BIT(17) | BIT(18),
+		.noc_data = {
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISP0],
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_ISP1],
+		},
 	},
 	[IMX8MP_MEDIABLK_PD_DWE] = {
 		.name = "mediablk-dwe",
@@ -757,6 +863,9 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "dwe",
 		.rst_mask = BIT(19) | BIT(20) | BIT(21),
 		.clk_mask = BIT(19) | BIT(20) | BIT(21),
+		.noc_data = {
+			&imx8mp_media_noc_data[IMX8MP_MEDIABLK_DWE],
+		},
 	},
 	[IMX8MP_MEDIABLK_PD_MIPI_DSI_2] = {
 		.name = "mediablk-mipi-dsi-2",
-- 
2.25.1

