Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9539F54DBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359254AbiFPHcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359435AbiFPHcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:32:13 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83145C67B;
        Thu, 16 Jun 2022 00:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG1NnP4Bf5935jGI8nWzrVtFcMU0MRS/O+zSe/JRFGdu30ryWMLJp7xRKQyDyMmK8V5LNFWYaUYw9dzIdEzlcsDrhs0GsOsoE6e+NwBww5vQIcptj6Az+/USwCoDkJkIw1dRQWCvS3W8ODrEyRVXQ18Fg/ozRYS8kY/H0NSZaAdBigwMLObjNVWHnxDkaOanV7hBWATCAmKrUBEB3f58mX/oeDIFOSN4iRvxUbtA6bKZduTmIYLAa/OdtVs8y0nWfWJ46azN6DYFvFidq6nKt01x4VF5HUACGmyEwbkC9M+kMR1e4tNOsq74AZskJqkPDGNS/5tohjBGeOr6p0ijzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnFrfn5UnzLFl40Nkg7G8mYn2FZ/F9QeYrn/MkSMNeA=;
 b=fcQRYoWVvM6W7PRtLhOq625YtrEPX8u1xge+KaSxf2xCUvrqYgzPqrgxr+fc75YXGLljU3BD5GE7vEj6C2TKWI0risvYWCwjxapyaOlAq00UVtOVV2vZW+b8XTg4LI/wwpXHqcUxeijhVKH4Q50rMEDVoYY/POxMv5uHrQVtZ1F2h9Lwtqi7glu1wqnImnVVF+ypOJ+a2kVy7RR6B7ry17hWRxA4hWK0F58LfJgf2A2g06c3CROrleAP9m7SqgOgtQetyJp0oKMZYS2RPrviCNQK02TZASzC1/P4pJrvoJqdtASQy+FvA/iUwwl3oWTK3yDJ6EHgPwbZyenmgWEahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnFrfn5UnzLFl40Nkg7G8mYn2FZ/F9QeYrn/MkSMNeA=;
 b=ZP271+B9afc79BN52J1s7GBAgw7r0hmr8KJ0hvvxl9cRpcrjDNLo1hex2Axj3HQTtTkF3ssSQcyiB9QGPrVlK5A6LUX9t4Qp6aBSbRTICbyIy0StfKbqee7gu0vDb7dOfwK+/BM2+Foq2kRa6NNddjevL0LD+klugdlsudQroUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8435.eurprd04.prod.outlook.com (2603:10a6:20b:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 07:32:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:32:05 +0000
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
Subject: [PATCH V2 4/9] interconnect: imx: fix max_node_id
Date:   Thu, 16 Jun 2022 15:33:15 +0800
Message-Id: <20220616073320.2203000-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 358c9767-04fb-4abc-0f3c-08da4f6a5027
X-MS-TrafficTypeDiagnostic: AS8PR04MB8435:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8435112C7BF13857D0354673C9AC9@AS8PR04MB8435.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HIDEGfr7JuQ6Xw21w7YOQ0LfPiKL+T8CcAXW872Ynjvp+aLmM2+663jHq0Feqf8gWHcKr7M0rV3+C4Z/FQ5W3F4gVHaHlcN/X8gUralrL9akW2zAqqzbZBVjoPfP5fZJm4h93eMjH3knJAAoWoj7y0pvep+CUUvAAgzRY+8kpJLYwLrtFSkNnZ16l4BFalh+moTGmcLCFqD1IQ+yWCh7cQ6sEPBp90ajTfAbl2hIBNU1RenhrjyxCsFJVklwIii/t374sRIoa4c2efgGWdOo/b+2m+Hd69vm36GCko+q/d2GMfvR6XtNB0ihmSrFcxsjTM8CIZNrr3LL2eO4Or+JIkES/yBiwbCX8XebRFgwFM+kf7fBY+71zW58oUI5F4OiG1i1mvyVbLOXEMM/5V7LAzDhqPyxzLdqjk+Tx6Z4jUXS/dxOSCtvDLjwaK4+tbcBONqZwSRnJAee0H6EvpsKVhPigMl5yY4+oBasqn423O+3Y2cRBQ3gLIJGIgwB+LusKUpfDTwhVGGXAfhFQ9cx30BwWZWVEWdhSqXsm6yj+xCNgkZzCDX/1/cTHeRWDHiU1ABDDGinPh/LI8b1UPsQQUyXQJ90ew2o5NRMRO7NjOQ0VKNbxJXUphuBGAs/yuo74W+IvE7EF7EOvungzEqI7yBjFC+7/sQXtZWV7fT3YcdTOnNac2PXt/hh0UM8ljZxaF3lWEl/QIJpIM9W7TcGNwifpORxwrEck1Osyb8jTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(316002)(6666004)(6512007)(52116002)(66946007)(66476007)(4326008)(66556008)(8676002)(2616005)(86362001)(83380400001)(6506007)(921005)(5660300002)(7416002)(38350700002)(38100700002)(508600001)(2906002)(6486002)(1076003)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rPwmhdMhkdKRZqyujmXZZg3mzlYiATbDRbTSm6UMaZ0g7l+F6iT49owLHKEX?=
 =?us-ascii?Q?2JMnTmUCsBJsrJ34WzaQuxNR48u5ZxHASMk6X3/TL+0E1avXh4YVQ6fdPxfs?=
 =?us-ascii?Q?1UkVLDg5lvj6sTCwZZru0LkWSFbXkJqcCjsdcnCTqWcPKrCCB0U0w9HlD6q4?=
 =?us-ascii?Q?WrbYyCWtzD5k+czD0p+JEd4cuZlK3REot7k+sLH5Uwm6jMquksrpQ+mWnzka?=
 =?us-ascii?Q?I69o21rZegnaZNahJeG6VaDjMQYfTFt9xxGBMCLINm1fzzZvlrAX/VCJoEWT?=
 =?us-ascii?Q?skqlTfEy1bBa6a0CuzZUzR9DR2dOJq1AwxmWsDuRKKsY+b9agDQJPit5PLGq?=
 =?us-ascii?Q?Bv1WmoKvBWIanhFg8wgNC4H/ycgCB6bmRG/PQ9EMuSomgxbek53wIFs768/m?=
 =?us-ascii?Q?sxPeuoCFlf5lW5HKXfR6kkUxBu8nMJ+bERykZP/DU2aXdKazj9E4eldOavY9?=
 =?us-ascii?Q?ATLmZzr1MdbVvKIU0GaoEAV3EuGv0NslehbtVVd1YqaL8a9qYaF7hKkScwNN?=
 =?us-ascii?Q?MGry0kt9ubkcduear/oyOlwbJwhjLuFxbDDIbqprEn9RvVlHCuHTnAowZkmt?=
 =?us-ascii?Q?7mhx5t3CCegwOev+D98O8S2lqQ4q2rlcNPjhFwX04TUKHT8iD8WBNq60CYE1?=
 =?us-ascii?Q?UEtzdTXoTpfCxFfChQPCzKipxRwuk6eFMH09jBfpPhjHmaieviFe5zKVunf7?=
 =?us-ascii?Q?XBYLZ4y92xVbP93aawsZQZLljtIgDo7pyIGsPHjVpcbcugaE5W0AXA5DyIIS?=
 =?us-ascii?Q?83k49c3duyPKuXD0hpiTcUBy40CIYBySeguBXXhkGklwqt3mlgBvDzzDUvmL?=
 =?us-ascii?Q?FOg9+U8VorXFAR35N6zPYP2hUuJdc3s6IIzNB+Aw4E5n4SWPql6NB9BZpQSp?=
 =?us-ascii?Q?uuRBbn2CIGM62z380C5lqIzBtNVa7qVEe7BUBP4QEYBxib1LyZ/venVQVLbC?=
 =?us-ascii?Q?9ugfR7lKMyau1mZ1S1R45MLKHSLg9th0V2k8fv+lG8BkTR9UPt0O87j9lO+u?=
 =?us-ascii?Q?lDe5ZeuaCn4ky6g/PoM+tWXxv8QSnSxAlkIbtccaPohayTODa86l5XLEvFUN?=
 =?us-ascii?Q?RHodzmKiHfZpX5qDtaCz+0kGRYmvWYJkmvJbbt+EjpAf5rmi1NP3yc5O/+Cm?=
 =?us-ascii?Q?9eiHqb+SPr9pK7CHWGpF4GS3Awmv0a5fVCrszB0FzGOhSaYCden5+1yDHqrk?=
 =?us-ascii?Q?XiBt75I+T//t//d7PndHoL5qD3tRT9Bpz9w5Gi39Twy3cm+2EYjzsmVICBu+?=
 =?us-ascii?Q?mB5di+SzXBcG55guNA/Ai0HJq5gXneWbRcijibBfkJnJ7FQ3jMR2EqBlFAqF?=
 =?us-ascii?Q?zFxY9K/auJcZm2ezu3NxvupvHpbTN6/cnqtkBYbaBJvsiY3tueHdxJTaF3xO?=
 =?us-ascii?Q?S2WDM4j11PAShM2rk7vyZQHTqlKL8qwyvsuMHuiGH9WsCahr8zMAzyz9BXNG?=
 =?us-ascii?Q?kVTnFeYxpAMQ85ITi6b56ohrsiTO559Km9kvmH4yu1yNu1eBKBWKki1ngy0r?=
 =?us-ascii?Q?60i1Xzff4ZngE0Z0nTeTKTy9fgtj4xELkAeQCtEPUFdPtzB8d1LZBu1EDIZE?=
 =?us-ascii?Q?RvLQS7l6qd0nbWiH+EZPiOWETJsVKayowqdIdDfzkXw2uBuHQgzY4+70fvhb?=
 =?us-ascii?Q?GN8pMgw5rmLuaxHW3OWgc93Vea/qrVtCgfSmyZaPrROGnu/1L3LSmFUTAUFx?=
 =?us-ascii?Q?Y16PnIp37R2B9gq9TnOGAKLTvg6IZTNbqA2eYL5WMHkgxYCC6OfDdxr4eJK8?=
 =?us-ascii?Q?B/LnzjY/3A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358c9767-04fb-4abc-0f3c-08da4f6a5027
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:32:05.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Q/qMw6gfRpaNf63MId/Ku2p2akiFjVWwdzGiz9CwUbLghcKML4UXTKbkeeGitr9f4ROLrCnLJM+Okfb0lgsDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8435
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

max_node_id not equal to the ARRAY_SIZE of node array, need increase 1,
otherwise xlate will fail for the last entry. And rename max_node_id
to num_nodes to reflect the reality.

Fixes: f0d8048525d7d("interconnect: Add imx core driver")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 249ca25d1d55..4406ec45fa90 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -234,16 +234,16 @@ int imx_icc_register(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	int max_node_id;
+	int num_nodes;
 	int ret;
 
 	/* icc_onecell_data is indexed by node_id, unlike nodes param */
-	max_node_id = get_max_node_id(nodes, nodes_count);
-	data = devm_kzalloc(dev, struct_size(data, nodes, max_node_id),
+	num_nodes = get_max_node_id(nodes, nodes_count) + 1;
+	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	data->num_nodes = max_node_id;
+	data->num_nodes = num_nodes;
 
 	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
 	if (!provider)
-- 
2.25.1

