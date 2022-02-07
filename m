Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DDE4AB864
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351987AbiBGKJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352076AbiBGJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:59:37 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90491C043181;
        Mon,  7 Feb 2022 01:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgG0XU5YRIjPW5uw5vdzo+q5mwLFevUTAH4ub1xJiUdLI6Gjn7DZFKeVp6DKbSFLCljzXRM9GEhRhBp+IQul87trtBbbhjRVZDRV/Ql3doMLfo2Vo7S81GaC/Mpv9jQce5daOkAcLQErZ8MWB8wao6l8Ti6K9vT8ggYuGASIfrb8rWPq+++EI9t1Vq7bDcTK2FN6dpL8SLTOq/AmTyp5U6nPDjMBtIXcBRc47nba50U4NHZ4YjtkXI8iY/VThQ0CtiJHkFRThgiEHlQxzgM+t9YOE+GkziQwTiV+zHLZmia2Ms0YUVySlNyqkoMJd3LInPRyHQHRDSXSGX63LCEgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXlT6IrSGUSmZ+cQdsvQMg/H/ouJ1YxR2rVDnbBq2OA=;
 b=jOX27UMaU/iavgtcmFLxxsiH4mIE8wyaSpFd2DJpNwL1t2iJq6pE8hz/V1wMc/sxQwNdVZ4Fd9mJ67AXt/P7+8In9ncETpjJezmMZqKxqk7jJ9fh6XBX4TrtStXqFSgthAh3J6g8UlOEqUMK4tCwjj7nqLy2r3EuZ098T97MKLNWDjMNmFkB7GJ2QmwNp+tskv8eetBcmGvWfzSLYTJzCmoDS6sBwDv2Zcs3KrvrbBExrI4XYNbNep7s2ms7e+AemQI9TYYjmOmkYGOc+gyvWDgMnml8qPkTz/D1l47ilrzMd0oNQ6YDbbnzegxvoyNRuIpww8mubg1S6ityznyMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXlT6IrSGUSmZ+cQdsvQMg/H/ouJ1YxR2rVDnbBq2OA=;
 b=aJta+VIRweiZlJ807AcXUhoc/dfKKEjVafnJ45H3bztH/aCRbr/TzUlR3D6Z8VmCUfVBP1gGt7zMp/2DUg6myBY1lWDv7aOJg/FCevFZXl3JeRci5sT0yDbO1tpADu/s/HeNQU6Fn+EyPTR+A0Deukq/RCR2NMIgSBEdSgzWMXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5163.eurprd04.prod.outlook.com (2603:10a6:10:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 09:59:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 09:59:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
Date:   Mon,  7 Feb 2022 17:58:29 +0800
Message-Id: <20220207095832.1590225-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
References: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3369905-f3ff-4668-f197-08d9ea208a76
X-MS-TrafficTypeDiagnostic: DB7PR04MB5163:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB51639117BB7498774A1212D3C92C9@DB7PR04MB5163.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gERdgj+pks12zT2NcNkOK4OKydxdsyOhpFoMvDCAGugrijIsZgqw1MeExwv7Gas2VSX+1KsaC9Tx6rGs04xKwY6S44MqAy2b75zVWD86pGod+4NeKC9O21dA7hTV8lYpsta8V7onAXss4VL9CjYV0w4zFEk2TySdvqI6Vj7zr9tvuH5Q47iETMH5SnUyzcwJocHSTpIWqkVaM4l6vcj09FYeZaEk7G5G2AcDMuDD96E/YDhUvlDhqorD+rhDGVBUi3XZquIm37+YWmvGG7F9usi1pSv9gsU1u/ReCwhSDLQQ7k+lfhTzPyjIBNL0+7NLRRJAEwaBBYsTbavBuraSQryFea/3QRUYFpcFLj6Ae9Y69HcMxxGOPiqSefQsPKiEwZn7lHFuXtTzf+04tuRVoTwkFcSvj7/yGbZgS88/g2GFRiDEbamY73F8/tPmXZchXi6pU3VS15XZ73JJ/SoM9eHpDEembX9yFozXskcZbQJTxWi9k4KQ6Y38qO5mxpybf9+E8+DLf5Ic7MdplGHbuSh2LlgskmYFspjMKc6jZZDdfaOajXIM0652CvdtnQhh5ChlL53r4030EqORJA64rhzgdxFqvdTTqAm/qN5iZdBpGwTyCWgekjOaWzuYXT3SFcEA8sz1puvdVFo5f3DsNMW6wWDRs7o5BLM7ChwrBwQYUBtQWMetEsr43wSd1lHDDjW25X4jHJj14ye5DkeorQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(38100700002)(38350700002)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(83380400001)(2906002)(15650500001)(6486002)(5660300002)(508600001)(6506007)(2616005)(6666004)(6512007)(1076003)(26005)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0xMWPAiJry3jwgASVksX3rxEdj0kWx52LJxXx1c+r0LUsXU6r3iLfTN5E/yT?=
 =?us-ascii?Q?A0pQhStHWvrWCipUG3zyblXXwkYWSh+1q/Wo7zKqf1CtC+l/ML3pvbbYODv2?=
 =?us-ascii?Q?RPfOZdW8Gwdc63+stpkwQkXmUM4OGv29+xwfJANcPPnX8YK2ZRIH8OeZ8zMB?=
 =?us-ascii?Q?xCclzGocbyZdG4qSKLhuN0d1FsEtRWNEfdcTcCs1xmtY0sEoKNXKaqBOB03u?=
 =?us-ascii?Q?dd5D4iFcZmclEPQRKJEzEkAFUT/NKjaYbwZi3CqlgaRa8LyasIGsf4ipTT0O?=
 =?us-ascii?Q?9XP1tGO8B0L0EMLs9ue9qXc7rFJftDLZWmDE6zh6KF3DxHGmsN0W0Unggfth?=
 =?us-ascii?Q?Z1KlJTfa3HqaK99QFniPBvxs27ndGhBEOgIGchhVYdVjSviBkTm/X5H3a0k+?=
 =?us-ascii?Q?/4k2uRDwdtR9BixLpg6fDDwRAl0scPN9HG3p1MxgXLkdlp/prLqQ4WwW65vA?=
 =?us-ascii?Q?C82D1dwi+S+bSyVk9E64mLrRLh4hXxjijMaMXFvyHuOLE+tcrypx/lMRFKmr?=
 =?us-ascii?Q?rtE8j3zeCpPoM38Cdlez/R1HjTwd7KAg6QVUxv7pI+X+v0EN+NyRfnuCGlAL?=
 =?us-ascii?Q?ttqMiPnLSimokih2733DEdYzFuELgDYz9LnOr7eGLrRPm4MaCGbdKs8H6dIK?=
 =?us-ascii?Q?qKXrybgm6DormSCSfSdF6OU5Psoli5aUQ9vKEb2tckPMRtG6qSRR2VUbUHXX?=
 =?us-ascii?Q?VPl3r+nTk19jBvq+GVik6I4M+bhkDP7dK2xaO0snEMc942+jmy+eyZKTnBrm?=
 =?us-ascii?Q?CAKluw9ofyHc9LwafkMWWOs+Yb2JQdNtZbdijWxMfPGcX/CWyEMU+ZqcRDWi?=
 =?us-ascii?Q?PuLyapXacW92kryPyhCgQpDxwIV1C9e2rHKcij9z+8f+jRP2P5g+x0XRQyzQ?=
 =?us-ascii?Q?unxDYYCIg2JHfF1EHEfcwKh1/lfoZQUgD4s4YrbUVKYaN67fCWcFgV9i73aB?=
 =?us-ascii?Q?vREITglngRqs1Gh5Vsknu+Sx70IY5+TVtRZLdNgmLwb/VMZC0S3yhkMKqf/2?=
 =?us-ascii?Q?hKqFjc8IIQlvq57Ozn4jq2Q8qG+f6gF07/GqopYq/fUwBfQjpGnCBz6JPMUV?=
 =?us-ascii?Q?K8IOYifqVVvno6gTClYLwim44RtEp5Uk6YNoFknX9dsvRNCfXPX5wntZy88q?=
 =?us-ascii?Q?F5r4oAkY/VnXTw9poMknP3EWzwmeHDW5FcqAKcOpCR3B5aEPfeVdXcpdL1xi?=
 =?us-ascii?Q?P+K6isRNGCS1Opf8eRK2inpe7TmETZ2B10fne+bxt2v12zJXALFezywmnOGF?=
 =?us-ascii?Q?n/7b/oygba+Byi6vvCHHKPV5WOIGaIwz9xRUCUywTIg7s8qLNBN6L9SKPOky?=
 =?us-ascii?Q?AuLMRhDDp8f5lKFnlkakYHLClzBfKSG8TxsroVmBGk3JQFjR0YREfP1oYD7B?=
 =?us-ascii?Q?Vb0C2ACJ03YOAAhzlmVduiyh2iRFFW2N5vOoXc9KKDhD1RvjS1eiQTWWe+iS?=
 =?us-ascii?Q?cwZu+1C8rfMvlSfQnxv6KGdtfrIiqeU2PKt23d11njynOpL00WLwO6AdtxQP?=
 =?us-ascii?Q?ARpKQtZEW+IT2KsFlYpEBFgPkpGD3uf7P8QVqQvgdNdC4hixKdf+jb3OPhGY?=
 =?us-ascii?Q?QsMgde7shTTzJUh7BP7Ogi4mAmopOHJgQwC2Q9g+7hVbRxCUaBiD163/FTqZ?=
 =?us-ascii?Q?2dv91W0UsA+rlJ9zlYV469A=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3369905-f3ff-4668-f197-08d9ea208a76
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:59:33.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDHp7Ke1nLYXP16b4xqQ6Rhrob5TlrriPpZi2vxXaUkgMi1CXEQHsQ5mbdA63qUvT8cixTuNOzAmsexI+f4Hlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5163
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
between Sentinel and Cortex-A cores from hardware design, it could not be
reused for other purpose.

However i.MX93 S4 MU use seperate tx/rx interrupt, so update
interrupts and add interrupt-names property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 713cb847cd8c..f99890ae1813 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,10 +29,11 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
+      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
       - items:
-          const: fsl,imx93-mu
-          const: fsl,imx8ulp-mu
+          - const: fsl,imx93-mu
+          - const: fsl,imx8ulp-mu
       - items:
           - enum:
               - fsl,imx7s-mu
@@ -55,7 +56,14 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: txirq
+      - const: rxirq
 
   "#mbox-cells":
     description: |
-- 
2.25.1

