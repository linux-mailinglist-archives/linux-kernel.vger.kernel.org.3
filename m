Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CEB564629
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiGCJKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiGCJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:10:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4A271A;
        Sun,  3 Jul 2022 02:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SENn7Rqwtt2LowfhpVBH+LLoenciUXugfcMQouVhWN/oJImVMUa713D3kKwFkq/2Qq2VakOOXY1lDHGKKvIZsmBm8zBNUIKg3tvnOVKL6tnhvp5/O4l9gdw0tmawBHzU1zv29MqvfPpEdXmdGnYiQ04OAUNZPVvAveBU7144bHzoH8o/UJynJb5iEqXojfxLQ7ibZl92oMcg3P78oXtVnsU6WsRGzVerMpCkCt+N3CKIl4IGKlv79uWQ2WT1h2eUHVwTvGpFk5EwJzYsj/4aHf7jX3VhMVbOBSBeIJYzDdrD5MHR+4o6IgHm5rgckVhV1oYpyUPZP1JjAVxFmDl0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU8LWmrwPaCR3Do8pD8tveFMkYcEpAVHChc309U7l/c=;
 b=YmWykxBrKJZ0PmHzD/VSbY9yPmFNN+lEuFDxXg5Q9BbZ+2x54XKockB+zw7pTwtt2LPbSE+MdadR+m585ig2U1vjvCqjmfId/XDeBDk7NhJ0D5puQF6q338ozfQIvAjImOZWuvOkc0MLsQ7NvWKRBKDnRdIkyUAWoeMJF/t8jFeuoMwo1W1Vi/sDKULYmtU1rw1wJF738GZ/zRRhWG1Sc4tj5XQGVsQNcX7uKZXZQyBj02jEVhQ+mJOMpu5Gkjfx63TRyBgTdZcXl+J7GQiCWpLr8O8VXUDYzYwgPFnDLzNfDHNYIgv4wk56XrW9DbkFEfc5u1S1gboMig40r9lPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU8LWmrwPaCR3Do8pD8tveFMkYcEpAVHChc309U7l/c=;
 b=jp8uTjZbR6KtkS0O5ueBcDow3hMgyz9OkKmY4IzqzWhTgLXGbfrQhHKuGmM9qqxdOAe6ymk53fYIOpl93h4Gh9l8IFchalI6Q/faSZIM77BfgMosYMTlJ4znc0qvyhcJ/Rvce7z/UfLZ4nOGurI/xk5ab9y5/XNnvsqZi4Plvvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:10:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:10:06 +0000
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
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 01/10] dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
Date:   Sun,  3 Jul 2022 17:11:23 +0800
Message-Id: <20220703091132.1412063-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7e8bb5f-b6db-4792-6e8e-08da5cd3d235
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPXyFAhWVRdttgpafrIMJVbNYLgP/V3hRL11IQF1dpMtYG/mteH121O5g2y2bjZJjWghwL4gZUwEGbhFu2veaiC6aKPqTngqdX4DQoWxMEVdO6tR//jVoN2/AbtCcgxjPe69QVbRRNJIGfin5z1LUUDmS1zJQ1N133spbKlZfLU1vh13YRY2haN2HUHhJd0QcZyEsgayeE2xsL7hZUxDoIYLCBwjKPhXSq6ZZxDyLHcXjwWC5jvyrCJMQ5n2dWqnnMsOCvy7ez44wLk7k3g3DV4HOgDuaZsLUWFHqHuew22MLRjBFidy7bzHrbGG9nuJEk0l2vP8fnY4HWShWrBObAAr+siBNo6EEY1mnykSes6vgXCU6X11mfiG9QkNzw0lVb1R3m7RCo9dSbSjVKDfTiw/8J1iBnb/SXJ1A8KBRiLmPnV54rDpofAgMlxWi8kdj769Xkqef+2NP7p4X75tRhr3mPjh8Bky9bcBnOgtzqOpet9Ec7fZ+dXM1UBwX9dKRTG7+P3CZBfiTrUWx+yg0Ai2vUi911iamvJK341BJDdUp4ypfn0x6OsL0BydrdXT+hQjP8NvTREn//g3XAUbfmqCyz1Y6vInB2ecHHOKMjWxvdDN/uX/ACCWUjRrIlJrGPZP8xmlgag771WVJZlsqU2C9Cpzr5NTumoOpjhdv5lD6Fvkqb4OBC9uZWbXP04XygYfp+GBMvasd3+Qnq+EH3/PPBN9+LCa5rXfKaiObezbE8YLsj0lU70niEwxorPW1/38Eh2QRzdOLfN/lqJqMP2foo88Y0afoCTTSIhS/1HW4BUQfvmhK3OLoEhQRZjNMc8XMu9j+aV8ojFtTiYR3Czh7PnCDp+A3CdeJfEqono=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(6666004)(2906002)(41300700001)(4744005)(316002)(7416002)(54906003)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(83380400001)(1076003)(6506007)(52116002)(26005)(2616005)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IWe7gzlcCjOhGPOEuN88nGvWJlaaPrKiVBrpgWzan+DzUjgTf0dOA5j/NFr8?=
 =?us-ascii?Q?3wPBzvfdz3g877qrrRRXvgh6SGKoglBMgb2Kjbfp9ysLuRJkwXmR0rX+QrtB?=
 =?us-ascii?Q?R8D/SVZTnpQx7oUW3kXlddAFxzPMJnAdJgzfA5xIXBB2w6DEjk98Q81dba33?=
 =?us-ascii?Q?mfIqTU2SBuR0uyEleqZFxerhjcIIIdsQnMDdIuvBzWrPWdgYk5RNjkAFEsV1?=
 =?us-ascii?Q?Sg0ioHNd/PFR0+fgTbp8S5uba5+t3i/JOVAVngkLlKRgoD1L8r9hEtJ4Q0C5?=
 =?us-ascii?Q?QSUSMYYP+EJw7e9tiElXU0ANrg1XDCRJM5sx1mgGvWCWgZoh81NloOHIx6Le?=
 =?us-ascii?Q?YNVvo751qHJ7l+U7zfpRbfUO+to5VuVPztTQt/pKZAZ3SI7K3S40INpCCs3f?=
 =?us-ascii?Q?+9nwsNE4+erROyZO0lJdP0beKcFtgrg+Os84Ihsr+vSe/C3Xr439AdmWWbgM?=
 =?us-ascii?Q?HBuRvQCMm0YEaFAlhKP2yefTC2ee1XA+R+4q0ZBp6oMsw5icrV+CcslGjB4i?=
 =?us-ascii?Q?A5VzKy+HShlSSCqqNfr67xi/vPDp1La+5jp8G8DKhRfpGQOqFNngQ+/1VJzm?=
 =?us-ascii?Q?45aSKc5qVqF5Zc85npI7Jovi103Ozgoln6VMDCN1htqIncETazI/rskYA3WS?=
 =?us-ascii?Q?8Xt6IaoO0YxtrP5xIgD1KH8WrRYk/+Ke8uqXQlle8YcTN/FI7TeNWBzu1Un/?=
 =?us-ascii?Q?jAA2ogv3QrrtmXexd1/9/bp2V0l2c29YHjb9H27kMx8Knm0Sgcz4QbgHShNZ?=
 =?us-ascii?Q?0t1xgW1Md/TWP2pVxQ1M010N7UfSRMBf/GsXfOm+iuC68IxxrqwuLgnvChfn?=
 =?us-ascii?Q?EZbfKbdln+c7EDfpvdVLmsWGoPcHKs2kFhfkXUP2nwLtK0CWvQPh6RoCe4sk?=
 =?us-ascii?Q?9ITFYEDiT6VF5TbBlmpEJ8bqnPB7IcJ9NS6CUjC6XisfYhLOqt4MYkJlN7e2?=
 =?us-ascii?Q?6XlFJOs+bwm6rYbrEApHHm9BoI9PtE7Thir32U4H+ujo8dL0t4oLOUMPMLOS?=
 =?us-ascii?Q?zC6Vb4Jw9ui8Pcy6WwMb0+a3UiH5NtVYTugjxmUeK+7waiJiZ43OK0P28In8?=
 =?us-ascii?Q?wj8CD/sMS0dNpTAid/H1/nbQWdAj5f2i0D3EM/NTIUeetO4iS0Sl3tb3YicG?=
 =?us-ascii?Q?OdSydB2fGCtTRJJqPtdc4r8SyEWsjhyjROb4va8J186WQSu3kn2OwrzglMEI?=
 =?us-ascii?Q?LR2Ndxn9J1cxnqmJnDUmu4B1V6H6Pz1j3RHYeMf7qITfSjZhhamrAdJs/xOk?=
 =?us-ascii?Q?6b6oVYIzVbfwp9v0uoDER9mLgXAma9gtbLiBprjPJqRf+tSia5+ZYcCBKmlj?=
 =?us-ascii?Q?eVxWQHiVGZNhkSytkasxNDH/+IKpvBwIfqhij6TTcMmLxtr77LMvtRpH2UwJ?=
 =?us-ascii?Q?ty1y6GVsq881wVz8axhLd11SxXLwXz1dPHfadmW7WrTR8CWOPf6tt+7w51h6?=
 =?us-ascii?Q?mfxQ6uHKXJwcdXt+lMXk9cMZAcsewgKsBR356ZNled5uBYuVGNNos3bjegch?=
 =?us-ascii?Q?MTl1G0tPVRi8zc7BXYLcQnc3LhWo4XvFRitVb3IBMWZ2nHsL8fooUDyqWEmz?=
 =?us-ascii?Q?dbdD0WIhzUBNz39s+RGcsHkHirIMcLTH3H/O3/B5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e8bb5f-b6db-4792-6e8e-08da5cd3d235
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:10:06.4667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmhhHuX+uoqnUZqK4CTrchQEYLJHsdXgn4DM6pg69QHwz+oZ63s6BwdnJ7sWUA/Xk2q3+7AheKaBHSkqjmYBqg==
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

i.MX8MP features same NoC/NIC as i.MX8MM/N/Q, and use two compatible
strings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index b8204ed22dd5..09c8948b5e25 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -26,14 +26,16 @@ properties:
     oneOf:
       - items:
           - enum:
-              - fsl,imx8mn-nic
               - fsl,imx8mm-nic
+              - fsl,imx8mn-nic
+              - fsl,imx8mp-nic
               - fsl,imx8mq-nic
           - const: fsl,imx8m-nic
       - items:
           - enum:
-              - fsl,imx8mn-noc
               - fsl,imx8mm-noc
+              - fsl,imx8mn-noc
+              - fsl,imx8mp-noc
               - fsl,imx8mq-noc
           - const: fsl,imx8m-noc
       - const: fsl,imx8m-nic
-- 
2.25.1

