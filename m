Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5795F57E1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiGVM4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiGVM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B578EEC7;
        Fri, 22 Jul 2022 05:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPPLfuL+XLL2z9hvFZv6d0RtUvjH9pp8EqkN3hCOdWZ8pM6Bgkte4qJqnA/uaNPZbx7X4/7Ge2PUxl+cx6UieSz8lGpv+7TZ1JCKedzOH6E7qDJTQ1Lk+ERxZ4QxEsbfgeBQ5xc6iInQdjWwdFkn/uzjG17UI3isAi/EHZEeBe1vy1HKrPxwWxJIYRsHLolODO5NA8J8Z6t4grIEimxOHQz3UK3ApghF4o584FvRoyFp1pu+t4bKhCNGBtGPhxycRIu5omkIDGJ714EP/FtBGbkQsz5mlg1PX+ARrMSR8AcHfhtinkXJ2dDH5FE4uAVVnsga0HWAe+vQft1QJLbZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhTaW1Xny6e/bRzpPamQ8D3YJtl+FsI9iZcFBdiOv2o=;
 b=DgmWIuxPj94Tnn9JKUGqWQ3sc2pJIDJYNaDyfGu/nke63gSco4xBWpgd9bbaT9AvWpLaOnuvo5YHcWFaCn+uawqLALyg009MinPGcMb7slInXkzSw/yKZaIGzbTR8IRcKbHiFO9ucMfedbwHbEYQW8BNtEt8uvBb7G0HM8UXZeRHSspuoNFGy8EWaPAA2qDy3e66Cpo82ZvXTM3Xx0Lgvt9dfeHRpbKgK7zf7WJ+T5k2usr6Wu5RRnGCwglAQFPpqcMKHV7lJ8Q/QlxB4EC3ZHqbSApJ/rsvfNV/965V+HMyw6+yLFSSflB06B3g+cor14Pe4l5C1wGSm0x83OFbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhTaW1Xny6e/bRzpPamQ8D3YJtl+FsI9iZcFBdiOv2o=;
 b=SFiPs7uIZGpOahei3oHBVPFJiWjev6BXNqUIXCGHeLeC4j0feyOCW38qp6IEmjkad6LDAc+8IsJ9WOVSih4SzgfOrZaTOwiCVCkSwo5XU19G4IfalP3C+NkSZNW3mX/zi4sRydOEdJ5YXxA/WATPr1fiJnSYmHKzRrB9p0YSCdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 12:56:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:56:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/8] dt-bindings: soc: imx: add interconnect property for i.MX8MM vpu blk ctrl
Date:   Fri, 22 Jul 2022 20:57:25 +0800
Message-Id: <20220722125730.3428017-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9fc75d-aa5a-4bd4-4370-08da6be18e55
X-MS-TrafficTypeDiagnostic: AM9PR04MB7633:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkJS3ClvBLuUOl/CFc2SPkY6XbIkFMAWKE3iKRirZGakAyImqKCy1D/XG0W16GMjTtM5tSKVfCatn6uD4Ma/XQ5BVXzLE+tga0utVhL50+4c1FSst+v/VOV8kSsAhhlh3lKcgfX+Dz5wPE25ZZ4cIcuTU4P0nzr++mWH9IhCfzJVJmI0rKvft8scriBfJMEXyKk83ZBROhNhg7tcRmELRazprRvdn6dnSzjOk8krpUyFJSw3LkwbJAOEzwSkkzWI4aKhQ2YDlrDvTy7Fh/OzNHpTH92KMMi7cjsC/wfY5sBkq2RyrVbLhlyFyKw3ui85QSgrVRXyBx6NduxvEsU8O1a8hQyiqpX9I6kQYTd+vBMFCtRuif7Ts2g+Ys7Nwa8NLVabRX0T1RnT1GbyrkIGPmLdinhH42XmDHmE+2vhGg8MSeo/2Y+eyT875KuJ5ieh0RBeunOg+Z5OUvbFb/D2ewaz700RVKjdxcQrjE3JGu53zlbnLg8eHak0I1cBe/U3amml7/6AlrcMsGYqJDf/5/cO4VOYE023IV+lPg155lJ9EF5peo8dwa6t5wf4ZAu7A44wNjjBZMZChRipSStIxeDmaYevy3AkxHAgKszSM+P3AbNsMlLS7oWxJ1lJZd3WPh3sjGtiBuLstwggDlL805pVsjHARTs8J1xFqMor8Y4MjOvaTRicF2Pqk7TikBAy/WEzu3Ml+sRGbSY2oT3lE3ub2RYfeeXT2MQC3Xyrg3tANFxub3aWrRqsHpYrmkl32pgncklelsS3JcPjzLMHV4dYjWT0h+LtwLXisbUiTUTmLMilT96f4JtjPxN6Si4OpawjofL0efrtJFZ8gpBfvS5U05EncZqiAlE6OGJZkTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(66556008)(5660300002)(8676002)(66946007)(66476007)(6506007)(26005)(4326008)(8936002)(52116002)(186003)(7416002)(41300700001)(86362001)(6666004)(4744005)(2906002)(6512007)(38350700002)(6486002)(38100700002)(478600001)(316002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aG8mtIGi0k7Mi3h/t+d6K/KNG6m9t3rK1Dvm2FYKNPqiw1mGMDaxVnMaCgo4?=
 =?us-ascii?Q?V8WhbCe0phFj3qjLoFXJ7oykNT6/MHN/c0IQNf65607rJJexvnXoZ0fqT0U0?=
 =?us-ascii?Q?t1GUqIjaiyn0Iki1n6hN9Eb2XAWRhWkp2sSuQdIFDZBaIW+s+4ebcIPI1JfV?=
 =?us-ascii?Q?jUGMzWNtmNWcJn8IMbEBmcg89jeQRo8wwzpc29Nr6cN+CHrGXXvP/6xnIIgC?=
 =?us-ascii?Q?xAT0w/xDWVtaa8jRvQhfGSk/c1i8h/xblJQ8dntcAICA7/M4ZnlrOe+imNuF?=
 =?us-ascii?Q?oAVU8R3BQWhscqFlAi5KFm2r4siQuDbqBmqeAhmt6sMCIUFsK5g3x265dvtx?=
 =?us-ascii?Q?zUPPG1IYeLi/bb/OOHbZKZCnVsSfohZjLpXq2euStIrYIvMXdsKZh7Q2aF02?=
 =?us-ascii?Q?mNrqGx4vDoZrRM+/2zgXQUT7RjoKk0sjRVOs9Madih2htANdJzlkVYwNpb/a?=
 =?us-ascii?Q?HZIfE+qiBb3tKkWZb/12dtmR1aXByM4jJnSjR35SeAfcrSEUIRroT7oW6aD1?=
 =?us-ascii?Q?dDLUcwjXKZSd3vLEJHjwj8WslR4kE+e/OugVHyzLPk5+u0/Ghcpzy9sdnc68?=
 =?us-ascii?Q?S0qRYgk+4Ta14wDwpYl7DwGMGR8UKHPn0vpRVKNGfXTL0Su7ey+XnbvuwTmi?=
 =?us-ascii?Q?+4U2Vk+JTFEgDNaz0NJh56WMqbGYgcmeX+0byqmAwbx3OZ2/OisPfQkbprBS?=
 =?us-ascii?Q?+dz3yvQ46PGy+MtRxP2ZBSChiJEWgk/YktAuwCV8ZBVXRXN6qsovFD5SN6pN?=
 =?us-ascii?Q?dhTJnQmpGM/DXogCrbUNVeOUH8QtasbJ9j/vDouFc9sEUTjeB0yriu9BQXMR?=
 =?us-ascii?Q?4B3HoLf3aE5JGpcB7Hlp08VlXJf/zPGcvphb8NP1yxkGijo5YWAuKd8Tu7Il?=
 =?us-ascii?Q?lZ9U0dNtuLnKnGUPmlDmddhOM7MTI+y6agewUWz+E3lMQvmyoHQOz7JYouZg?=
 =?us-ascii?Q?gdzMxNpUM5pwuYplBw/5WMD0a/OsLhE86aYjSnMeAEdCPlnJtuOJvwZQmYrh?=
 =?us-ascii?Q?GQqtgBkcBOrqAv5MtSBtk1jeetYGzkk3tI9Sj3eLqyQ8St6+5ZVjmcnuJ36u?=
 =?us-ascii?Q?xh4+FuHSUX9mOO6v3O8OewfTdKTzqQYjGtScjgmCUFqKveymdPf+hpUo9zsi?=
 =?us-ascii?Q?lhWsB/xLMNaHClx6kkZ3seigDSufq3wsLT3KWN4ZNh/ydZI0H6tvk6SGm+Nx?=
 =?us-ascii?Q?82cna9QuShOr9NuUdiLaOnAzRCuQfNmphzkkItF7atkL9N5Uqhij2Kkm3o5J?=
 =?us-ascii?Q?SyJuHB/Ehpe/jofkwlXJ2Rlw/dMYdUPmisYi/qrJ0GxluCSjKwBPwnqFdQMC?=
 =?us-ascii?Q?JUXxVv59QQ2WLMf2/quZjk7kBGC7G8hL2m+vpBqlk40z5HWAJweOS9Ypv1I7?=
 =?us-ascii?Q?M1TxfYD0QCEQdlgtcOPSFAZeW0LnWqA6CrkBtdDNzIkvMUYUdCregko+UoFi?=
 =?us-ascii?Q?U1rHVVYVudYxk+y8xiYxtkfgvb4oqP5RR9Daxpi1eUJs/pW9IZSHGxNvcprs?=
 =?us-ascii?Q?NDDkcoYmiL3tlSmVMLzprnutBXUcocHUrSSVWoziB1JTZrtUyC6r+Dvsh96l?=
 =?us-ascii?Q?tYsYyW95omswfUHiudSwIfXeImuIjtBAWcwa7wiC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9fc75d-aa5a-4bd4-4370-08da6be18e55
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:56:12.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuVKLj2hXQ43M1fpniAkHoBl5FH+XIq+cAVqpXIDpCE5unTGOBpreaKzy5F5ytcvSK2NxyxZp1g54FAzzrk4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MM VPU support NoC QoS setting, so add interconnect property
for i.MX8MM VPU blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index b3fb529b399c..d79e5d2634d6 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -45,6 +45,18 @@ properties:
       - const: g2
       - const: h1
 
+  interconnects:
+    items:
+      - description: G1 decoder interconnect
+      - description: G2 decoder interconnect
+      - description: H1 encoder power domain
+
+  interconnect-names:
+    items:
+      - const: g1
+      - const: g2
+      - const: h1
+
 required:
   - compatible
   - reg
-- 
2.25.1

