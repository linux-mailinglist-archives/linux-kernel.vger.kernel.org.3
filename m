Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58956461A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiGCJKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiGCJKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:10:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18963B7;
        Sun,  3 Jul 2022 02:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHflIwpFUGsLQUZA0LpORahXGMZY4MYq5C65a5Jloui3VehTTZ/xbaszxc16X1fwmMPtzNRfS6dqoyG7T2bcRtaMLj9oGw32xu7qnKHIqzDjdHvDZWR4V/k96yb6/b99yXdmOy0hCOgynZjfaDctnJ0LJpVrIm2MPXJgMlO5VUlL8bahMIg4UaGZk5pf129bcOi8SdCLmQpvVO8HwUl01MfRMABVY5gg5dyr7rLzSQ0OMT5OLtKaILyofh+DLKGqaXdsmC67rn0frphvCKtS3cKGuJnwmaNPQYsGc4U3v8y1334kVq5B+wS5FvL0BTS9mTiOHTQyWjqPoRjlQc3DbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsCBv03YMON/LGFRqdyaB7553gxFeYD3FG2+X/3brNs=;
 b=dZh8MPHNSNZ4Hxo4RymHF8DyZ/5ePNzQgyM+AQgce9OWJbv8KLb3/1WT6lojPbDaCcD1LsnABgJrGcfHm7lXdu4y4Eq02cGafZYDKYTvBzTKELtxHKhXZgQMZbsj1K58gT4KNYw23pzLgEUK8Ua7lZrzdCZIdqZsbGsMDTHVbhTX/2QkDFwYQzZdIS0CbmZK2T8O44WaPkt770QJX1qzEt+QdQf52fAykSUWXpTNiMJ4L6LjN1bE4n4E0EQnPUtN2MR5nS5PTy0fqpX5/K85pi4GFk/nIdG8nwGD9sBlpEHm85cYeiqmz9yvG2jtEjER35WC3rc7HA03jCoJkZ1xcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsCBv03YMON/LGFRqdyaB7553gxFeYD3FG2+X/3brNs=;
 b=cIFj/QoJ+L4zlDQn8KjPHi3ixqESNjZFXctzVwiTyPFPSixQqIZEJav6HaZ4kANCiPo+NR8YN/MDxpyZL3sWZhYxFVVzPssYIATDfknN3H/WPzXSpML80ihWTvKEjyEl+p0az9n328qwasU7b+2wijdA4ukJ3p4iYXO+3lhoGaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:10:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:10:34 +0000
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
Subject: [PATCH V3 05/10] interconnect: imx: set src node
Date:   Sun,  3 Jul 2022 17:11:27 +0800
Message-Id: <20220703091132.1412063-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92a5d24c-4c5b-424f-9ada-08da5cd3e2e7
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97NH1xBd8LNfUOiZlQvs05eVgrQ/BCdlL1Ofb0iK3J/1iy7qrdncAP4eipLVdKdejzmM71Q2M9q2douO4g0gHUoB7Sav/jeEkZ2oOVFGiHAia9SC+8LOqhiXKUzYOUC2FE8Swvq6j8+KVbUx2UJWHFWx1Nnqv7LznphJTzpLTtrwNKxwzBclsSE/HXnZLfEyPeq6/j1WjBd8/ZQEABV3ms1IwgRofZhhCmcFll8DU5AOrRLKaD4/LHlph7ChCUx+j2EKboio9+w3Ghzm8/NpQ4Bb7uzNHOEmimbmGJ4eIxKzZc0gec7yljEWB0E3Tyj7Qj+ajbVVIbKtUPyhmdJtR60sURzojYFPLOhJJIsBk1+Iu0YY1vXhL2FOgwqlD++FDmKnPOIARJA7BLPkLDZTZRI8F0cNr04h1eAKrWcajh7bRwkUEaVWH07hZq6h0hPS58s2IMPAfIjuMWTVFm5fsetenPoKkObUfEyRyZsqzA6dtDKG9EgIvzQqkF19cYa9SOJZy/mbr2QWsoN94r0FCr5aq9ZoCB6yRoAmCPgNBlzTp3uaM4xnGqz6uThyaLfZAEy7uLtdhM6DiDBK2tNH05yOaQOrHIZDjKJdzh6S0S0AncfB/zXLwYd8viZoKK0SotRZLKw1LY2mxueXDLvItz6zjZpGyfeRSOrfeUoOZSX6bzQJMIkM9ZG4o8JZeawvXKF4v+pwU+fNOT+JIukEv/ajkLyQQtspX8K/Yb8xJcDp4nY8wc+G+d5MeDhYRk/WZWqQavEOblL92dukwqrIak7Ft/mffpooQ90uYDyjO/af17ZNWlXKIZ4I4OSYw7FgN3IhDOAbP3Z64+FnGFIENw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(6666004)(2906002)(41300700001)(4744005)(316002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(1076003)(6506007)(52116002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VEtkbixxYHFGnrVWrL71m6XUuqsBEmvefoJgczDJWjtjx6pifFWkIt8BOIJ?=
 =?us-ascii?Q?IA2UXC0R4EIy3ldoHGkz/DhK8cZHb4jPzUJEeNPTHYFciy77w2BHozFHI33Z?=
 =?us-ascii?Q?61N5Qs0qwA4Y0QHPrvW8qdIQmNKJQlM60bCQCUeHLhjGAXa9hEdMcZR+l256?=
 =?us-ascii?Q?V9t2zzpQjOxRbQ1Vn8Cr4bct3UNhaBKLVeFEu5nwvZzsvrAMjRuHKm6wPggL?=
 =?us-ascii?Q?YF7TYDh6YoiaZPPmPN2yDk7KAoQCs8as90ynumRcUyvoT80YqmjB3ZwgVfjm?=
 =?us-ascii?Q?T0RTckvwN3TtWH/HzYizMjfnNMW0a2GaP3zZIrCxQq3o3sX8tLmlLt/WV9RM?=
 =?us-ascii?Q?bVGiI41ucMLEtYo0PMemQiHYul9F2ofhps0H3XScaJLkfM6ATr7qZ8rr27eY?=
 =?us-ascii?Q?1Itrh07e8Dn4yuP5D7lkjL5lfEvelx02jts9Q7iLxX0jz0fdzqUUS9GJ9JEY?=
 =?us-ascii?Q?flt7tC2iRM9aXMwWChpVIxTY+o5ZgEGCiO2y9PMPP20i+nb9ZU5wPoPZdZIp?=
 =?us-ascii?Q?yJzolD7HXVPFsp6UYpCjwS82sJ1HZy+zPFlGe6hJpNGWrgg7lV+hCPtMA8P2?=
 =?us-ascii?Q?i/VgrxsD88OD7FW+lAnJHOVw2CZar3dnbRkzrPyEqyKF+EQ3Hs+eErsMAYOQ?=
 =?us-ascii?Q?U0u8jmYEmrLhG0X3zfmtzvkOu0dfCntF8Cs5h5sBnM9gL8/kYkIUL4E4QLdc?=
 =?us-ascii?Q?rPnsOvJUT40rTt48pmpv7AdQjtEDutf1Ezs+cQ16g8I503G8kzlwqixFcPRu?=
 =?us-ascii?Q?tGVAarUegUR2V5gKCKmxxOLORcHl4HvPF/bNS0pyYUgm/s9q9mi58QcvlUXa?=
 =?us-ascii?Q?ohrwoK7G0bQvt56icDqygAi9D39EscJTKfZ/Ttpzts9s3XE1VuB85LOtMwLq?=
 =?us-ascii?Q?lk7FRS42qOtLBF/1Q2Pm/EXyjzJFV+4qWFM8NFnrGU0n3anMCbgTBRKvqGKk?=
 =?us-ascii?Q?FP2W/KaPX0omSrcnOWmUQ8di81/3FuYueru/SsJ0e4wsorgKH36NeH79kpsY?=
 =?us-ascii?Q?7C6LkRmdj9uZKLkzfHXahqwbI0EWvv9aQ8OJabFPOLhNAj06ftgY5jN2fqxI?=
 =?us-ascii?Q?SC7rqZ+vo8kDkINiGjUhTabdkvWxksXJgDWvGqF6/YYsXt+A4xQVCkk7th7Y?=
 =?us-ascii?Q?K6SGzpjNG6WneIbtPZk7xkCN5jrfmk+Js8Oi0FeEQ7Mk99M7TJs3W618Okxh?=
 =?us-ascii?Q?D1Frs2CPLy8MSmlKihuzJ0nY1oG7ztCVGIRlUwFBgWW7Weudx2vNIrD9HLJd?=
 =?us-ascii?Q?u6mlE3B2/lQEG7pHCO2XnV4eCCCV+0TaZmtmkLS5b4eTglHkiKG87K20d5DO?=
 =?us-ascii?Q?NNr7106g4FPJjZzyass7l0xjVMvbIo3n0+RYsNB6tJu+rfHRpXO0QKY8QgTr?=
 =?us-ascii?Q?YtEEA0eH0MAQ+UtI5O4ActxExRbH4vUe8qKPvJm5u+vNy36XSNaFaDB9NYT+?=
 =?us-ascii?Q?NCyGftpPY6lMSG6865VNcNe0vKbGJetirkHwptrtXJQmAgphm6bNplrSx7Dx?=
 =?us-ascii?Q?aTLabzVX0aRADkbGgy7wqle3HWRgrZdMl2h7opj49e0AT8IIkzKBgLcg7ULj?=
 =?us-ascii?Q?/blxWtXdh8jDZbMHZ0VKhI4DFZniH/eZbKWvtOWh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a5d24c-4c5b-424f-9ada-08da5cd3e2e7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:10:34.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvMLS/NgGI5Lytz8wu96gGahyfTK/UJ4elbs0goTJKXK2bKMJmYpK3ZE76TEH0OOLsTQVZ8ziOHZTh0Tmpn3Fg==
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

When set QoS for a icc path, only set dst icc node is not enough,
also need to set src icc node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 4406ec45fa90..9b83f69945d8 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -61,6 +61,12 @@ static int imx_icc_node_set(struct icc_node *node)
 
 static int imx_icc_set(struct icc_node *src, struct icc_node *dst)
 {
+	int ret;
+
+	ret = imx_icc_node_set(src);
+	if (ret)
+		return ret;
+
 	return imx_icc_node_set(dst);
 }
 
-- 
2.25.1

