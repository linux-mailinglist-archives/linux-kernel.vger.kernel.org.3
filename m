Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DD54DBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359477AbiFPHcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359498AbiFPHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:32:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EFE5C74C;
        Thu, 16 Jun 2022 00:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUcaE0wgszq5gDktZRlZVVQDd9PkqfD7aTT19w4JsWcaWahJ39ZIK+5xt/ZxmTPifWmQ2iUxFBrbLW3g3CxRWfr5KMUcppdJZUmrRp4Hs1ytSw3z1oNdhij1C2ykNimnjAjMec+Iil1pdXxukNegusJEG6ba31mW+FVqWPlSR5kUp9lJZrfzmspKe89Ovmw4W3XbNXJhz4i43W7fqhkmNB1mAm+YsD9wdNzlcxAGGohSlpqISUxmJ1AYAfKg9hWBtqKJiGjOQqLALELGEvMjmwcQ0GtOsahiTTZqOeOhh50cLsDbhn8fwBClYRDDnKWY0eb7b+2+vI7OOMb1J9hK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMO9YkRud2Dgs7CFcVcpItGnH1I8/OM8YjyRzC2bGJ8=;
 b=DvNmsuMuSQpAboP10a/QjcGgQhS7BhFxTNNAXPN9rDnePK3Ma8sOl2oDArrVL+fXyx1s4QWtAzOh1X++6+SEuiwxG8rYHoaFiuBJlbiPuTarC2qK0em28pgcLBLLsLIUnkDbhmSzdkQIHEbN/CkNRc1eyBbc06uwoDQH9m3WuQ7vgcBJisMiySYclV9AFPWbFcAl3heVQlENtM7d2gEUAowBM/07+ufW6tE0FfPMS03UFC5rj9oXpZXHVP6eSkOPvXIjXC6eSHxHuJ6zzJloOhgAQyzk74JY270gCvb1tXkZipV6lao6Z8H9adwLdXdXAFvt7RmW7tFVpLBUdMJfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMO9YkRud2Dgs7CFcVcpItGnH1I8/OM8YjyRzC2bGJ8=;
 b=CofOh9YOUUVeVepDqXZ2ZCk3bC8iD+psBCz9OF3GQp8uGGU+3dT33Ua+QLLSos4vU32tR6272gB3Pe+Dnwez38TtCkwho54kg3JOKMH5gqtz/uK54xi9zOsvjCG3sPLjnyFEhRzUoRAshzrNET4qEbVr6VxKlNYbUzazzCFHf8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB4850.eurprd04.prod.outlook.com (2603:10a6:208:c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 07:32:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:32:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/9] interconnect: imx: introduce imx_icc_provider
Date:   Thu, 16 Jun 2022 15:33:17 +0800
Message-Id: <20220616073320.2203000-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0f9a624-3a01-470f-a84e-08da4f6a57ab
X-MS-TrafficTypeDiagnostic: AM0PR04MB4850:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4850ECEEB1727D90C05C1D44C9AC9@AM0PR04MB4850.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfwNLmghbBoBRfzZKVDloPCBKjyqCHfCHoZ6Q4AWhwpVtVr8AQIagDCpVDRUr7c66nY4zZIdJjtRFtRpq0RijPK1k8pEVITtj2eOYEBUznVwUkJc5TC6mcESwrSK+YK6OHuWkHWefiDzG14xw7dOgjOiXTb1r14SVk40cdlqT6xJJf/bd1dFsN0eWih2452NZpY+CYHMTzMpTe6yasbNIEJ0qyGYkK7p57OGBlpOMLBdVR1CrWj3vbP3o+uoi7PshzMdy5pqnhoo1z0NXqN+UKFDQy7+2NKrmhy027PWBy4NjPYLMMDirIEmtYYCHk9aab43DQOPCHCMHwrZlmslbY2lOqEhV0wcSBw9RzkF82IO4ALBh2zWKL2pK5BkuPqD3HXiKLlrG8jI7pb+W5QkFd4D/OaHTVluCnEOUO6+tQvuKDZjI1jGcTN3oV7flyePLSqG3o4yj/30b9ANoWJWiCsZ27fdi8pCOzyeAen8Z8BXbYDneEJGHzjcrSZHiSvGDavOOzsarHppQw0Ct2zeC2P95rfaPeijJ0za7KoKmQ5/hMWpqNAKdZwritFG5G3J2cdu+2VewhrWOrxXtLnsQBPdcw+RR8H8jI1Ax4ZMRWhbZnCt2bQq4LlS6UUaUh162czBFIbx/jGhopoyCC7JxfN9KW3qsbyTeMDI3TIcgF4hjcrSxlKN0Isvflz09S5tndph0/VFQA4WYFEmCj5Nctx89HYcUXitSs92uBeAmRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66476007)(26005)(52116002)(6506007)(4326008)(66946007)(6512007)(2906002)(66556008)(2616005)(86362001)(8936002)(38350700002)(316002)(38100700002)(8676002)(508600001)(7416002)(6486002)(1076003)(186003)(83380400001)(921005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VkY9mtj9rsiFA4BBh0wQ2QkcrVc14zvtqBXA8ZQV5z8JeiGRK+zYpa1YIVGs?=
 =?us-ascii?Q?1lUok++3lWQM61514KwFUdxqeqTpFWckDLRCiNcjqV7/G0EhbCUPtk8+18Uy?=
 =?us-ascii?Q?lgksLSHG6k7CVzFFwemZGs50EHFMqNsjq3TWR8kUdm0mxOp5VddrpSxD9j5X?=
 =?us-ascii?Q?JbmRFN1jyRcqMW9EikQW/xe1gUcgn0LxopsE5sq3fIplhK6z2zWqQbhTx1iO?=
 =?us-ascii?Q?UnKUun27GTg/mCKsXYx8X19g+/48L/JQmCJwre0y2x7q0+kfpPPjQAkLMW2n?=
 =?us-ascii?Q?2KbMk+CGl8vMq+JGPNgojovF+ZHiHsNECoHV+uL8kekgtEl+zo7ykYbnyoTc?=
 =?us-ascii?Q?JjTFDg4NMrylDH70XzSbnquhkjtzGQNTGKcdauDTzDUk1nfBsR93lc5U/AnU?=
 =?us-ascii?Q?S7isZ7+vNoKXjblj4yrE0UOdfBui5hNfqONKu6tM/6w292H9byY1WRjiKBzH?=
 =?us-ascii?Q?N/BHg3Xbr5KWr/nByGBx2hobnULi0y9Ncoiu0TA7ihlvmSOTcF4AyZu7HYjm?=
 =?us-ascii?Q?iTZPM/9CglAcZLy9SNMu/hn/UtHnbnsyq5AiyYBCr6wIostheN8RwGZDF3k4?=
 =?us-ascii?Q?03S0kwCJZpQP1Xlw2WvoaN9qIMI1cwSDstPlkv0VRFFNWVF51ch/BNNlT/27?=
 =?us-ascii?Q?I4ofZOE9aldyJ+LRPyozdXjHkI+vexOpIymoQojpXnBTTA0GBx3iJwxcUNVU?=
 =?us-ascii?Q?M6fbFA1j+i4pxa161CreMODgWBwq3Ib/QNC50Lrj6oqAkACCGNk2Og/KDGih?=
 =?us-ascii?Q?VWKDP/HuDA1F/lSwGc9mPenqzn0sNxacRgxvNhgxc++holmHsZpMJWxoXzDL?=
 =?us-ascii?Q?i16sxnXWGHRj9oMU9PLa1AghD1ExlXgajBaScFniWbWoDfZMAiuOErm5XCXt?=
 =?us-ascii?Q?YcFu0VhK6ge0HudSOfFFcf9ef3bUzsrq81EP4vkemiW8QXHEmpXoSX0LmjV8?=
 =?us-ascii?Q?2xY1GsbvmtBE3NwG6tnMSMo0R4st4by2F0eJFovf8640xCKOrwHmTOUIxXIM?=
 =?us-ascii?Q?1MBsNs2G4h+cp+EF8ZaDKxO7Y0mFkSDPOQexO6RI26BvfDl1bDcbHMJ3KWLL?=
 =?us-ascii?Q?iv0DFN+6tvRygm9RbJ1y+qFKDHHx6UCtigcBqiHCXsYxon1lOiFNz5kJGRh3?=
 =?us-ascii?Q?UV5Om16UkaOLz7zT2p4U5zsln9JDOsUklZ3/Tqut5eFKbBVpG5z0F4rUVV5B?=
 =?us-ascii?Q?VbCyYtDYPsljSdk6Ysc70OG043kMg2ciR+zGOCrFQgvZkfDOhiPv+O5suqqY?=
 =?us-ascii?Q?+RIWeciPCgz5q9b5C+9OF5Yubs6gMSl7E192xj8PSs3l6itisXii5dhZg++m?=
 =?us-ascii?Q?yBhQb4nqXv21aEyKU1mrHQeCE6q2kvl6koFekscTJPqb8Lx4mdYrhKWyvAo9?=
 =?us-ascii?Q?Uh7l1u8YypZvS4ejhKDTeIGRspiNMh7Q1Ww62cKe2EH+waz8F1Md4beLSj2G?=
 =?us-ascii?Q?By09jpNWnKFMjLf0BIcaDpS3YwM0HkhC103pgdmA+LYYerD2yZamUyzl/1N6?=
 =?us-ascii?Q?ZLsMpIcBzvjce1vU5VcuPZOYydLhnoI/Cj5RigP2A4XjPpulpDAyCWG/DoFu?=
 =?us-ascii?Q?EDD/MaB4YJW8bliGg+Qj5jJh/c2CIcppHAv8KzUuQdsF5wdl9WaDdHzos/H6?=
 =?us-ascii?Q?uMPIK7QHwYcunF/fqKWy0Yr6G9BhmJtAYGmJ2cJi4xJb/KPtnYCjOR1ix7nu?=
 =?us-ascii?Q?neoGRcG+4UM6XQFSXsr3K9W7M+3qa5iQRWhuLYaHTuFHAM7jxzs9AIzfiLfC?=
 =?us-ascii?Q?TB7Fy7ejRg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f9a624-3a01-470f-a84e-08da4f6a57ab
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:32:18.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkrjmMNh9TGcEGksObvYTSI0UBj3u2dEK9M+DFxxJ79/lJaNXCupm1HP633iStP9qxD1+f13e3y1fozgrqY6vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4850
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce imx_icc_provider as a wrapper of icc_provider to
add i.MX specific information.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 24 ++++++++++++++----------
 drivers/interconnect/imx/imx.h |  6 ++++++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 9b83f69945d8..1f16eedea21c 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -134,9 +134,10 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 				      DEV_PM_QOS_MIN_FREQUENCY, 0);
 }
 
-static struct icc_node *imx_icc_node_add(struct icc_provider *provider,
+static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
 					 const struct imx_icc_node_desc *node_desc)
 {
+	struct icc_provider *provider = &imx_provider->provider;
 	struct device *dev = provider->dev;
 	struct imx_icc_node *node_data;
 	struct icc_node *node;
@@ -184,10 +185,11 @@ static void imx_icc_unregister_nodes(struct icc_provider *provider)
 		imx_icc_node_destroy(node);
 }
 
-static int imx_icc_register_nodes(struct icc_provider *provider,
+static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
 				  const struct imx_icc_node_desc *descs,
 				  int count)
 {
+	struct icc_provider *provider = &imx_provider->provider;
 	struct icc_onecell_data *provider_data = provider->data;
 	int ret;
 	int i;
@@ -197,7 +199,7 @@ static int imx_icc_register_nodes(struct icc_provider *provider,
 		const struct imx_icc_node_desc *node_desc = &descs[i];
 		size_t j;
 
-		node = imx_icc_node_add(provider, node_desc);
+		node = imx_icc_node_add(imx_provider, node_desc);
 		if (IS_ERR(node)) {
 			ret = dev_err_probe(provider->dev, PTR_ERR(node),
 					    "failed to add %s\n", node_desc->name);
@@ -239,6 +241,7 @@ int imx_icc_register(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
+	struct imx_icc_provider *imx_provider;
 	struct icc_provider *provider;
 	int num_nodes;
 	int ret;
@@ -251,16 +254,17 @@ int imx_icc_register(struct platform_device *pdev,
 		return -ENOMEM;
 	data->num_nodes = num_nodes;
 
-	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
-	if (!provider)
+	imx_provider = devm_kzalloc(dev, sizeof(*imx_provider), GFP_KERNEL);
+	if (!imx_provider)
 		return -ENOMEM;
+	provider = &imx_provider->provider;
 	provider->set = imx_icc_set;
 	provider->get_bw = imx_icc_get_bw;
 	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 	provider->dev = dev->parent;
-	platform_set_drvdata(pdev, provider);
+	platform_set_drvdata(pdev, imx_provider);
 
 	ret = icc_provider_add(provider);
 	if (ret) {
@@ -268,7 +272,7 @@ int imx_icc_register(struct platform_device *pdev,
 		return ret;
 	}
 
-	ret = imx_icc_register_nodes(provider, nodes, nodes_count);
+	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count);
 	if (ret)
 		goto provider_del;
 
@@ -282,11 +286,11 @@ EXPORT_SYMBOL_GPL(imx_icc_register);
 
 int imx_icc_unregister(struct platform_device *pdev)
 {
-	struct icc_provider *provider = platform_get_drvdata(pdev);
+	struct imx_icc_provider *imx_provider = platform_get_drvdata(pdev);
 
-	imx_icc_unregister_nodes(provider);
+	imx_icc_unregister_nodes(&imx_provider->provider);
 
-	return icc_provider_del(provider);
+	return icc_provider_del(&imx_provider->provider);
 }
 EXPORT_SYMBOL_GPL(imx_icc_unregister);
 
diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 75da51076c68..0ad2c654c222 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -10,10 +10,16 @@
 #ifndef __DRIVERS_INTERCONNECT_IMX_H
 #define __DRIVERS_INTERCONNECT_IMX_H
 
+#include <linux/interconnect-provider.h>
 #include <linux/kernel.h>
 
 #define IMX_ICC_MAX_LINKS	4
 
+struct imx_icc_provider {
+	void __iomem *noc_base;
+	struct icc_provider provider;
+};
+
 /*
  * struct imx_icc_node_adj - Describe a dynamic adjustable node
  */
-- 
2.25.1

