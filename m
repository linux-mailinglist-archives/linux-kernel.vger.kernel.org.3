Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49B4AB33C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiBGBxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348207AbiBGBxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:53:47 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F05DC043183;
        Sun,  6 Feb 2022 17:53:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F00HeCEGosSrUvUk8k4WDj2Ihr07flTw7YqI8M3waUJKTXnDqtH2DO5Ckhk+iCQJf2NMvYak6HVv9o0YJE8oD6HrE5AOrMaOR6oU4a5iTpOGmMFLQmKKmcOFkkcjGQ6J3Ly/LoKRgm1JnrjMspqrual8qz4bd9feOwAF+Zb/djuqDM4nfv/XSteEOOB+ZJQAC4vSbXyzDLYSliOowS5cHyhVUYH19KNWVwX5rgo8+P93Nc1v1Q7uy7+ly+nmQHK++1EWbjugSeSzWUSZcpFcvtVMis/xGlLiQtmlXFQST+cr9tTOUh4t9Ox17BoLZBEG1c7PDp5N08ppKeAWQZWeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bULUEMd590ikObpv4WQrPTOAOgjCIgU2Vryb6sCI+Js=;
 b=IeUNQotql/b0wIkNFLCCadekMb8fn2dHKboCqXUwRfOSMTkBW1aGTV05FKZXUBwA+pJHDVpYegq9A+zxZE4weXIDJX9ZG4ILkSVAHdL3TqugNuTTJ8KBvVihLVxgoPd1pvhj1+IWt00IUmwzVn1xrKmcQ5yu96YrtgNhjTeUpjhd8rgTHFAZL3iEQu8xZxLuFh1Pak3FO6w8crTX8ryF03ell5nLnlnWesvJmKqpp7u9uynBzHV/jcwhUSeLq9PIE6vrpPuaGQuk19U56LXuu4J7hBePGA1CY9jRRfQ/FH31g03l3/xn/uzbpDswNgDOrUxw1iinE0pjraTY5CYxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bULUEMd590ikObpv4WQrPTOAOgjCIgU2Vryb6sCI+Js=;
 b=ZBGFWCXxLcZy/7ivyg2vmeWPMvGv3Ing/73OAxel2XQk057Xj2/M8Q2OCo9kR4aNb4U2f6owXOMYDvK0EKUmicBNwjFPq2U+YP4Zs5CQbod3SmJaGbdkFLl3NCOQe4vXVZCR+F0LGiZ6yEUDsm2gf317FhQsDNCyUNJ285DWS10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2493.eurprd04.prod.outlook.com (2603:10a6:800:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 01:53:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 01:53:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V2 4/6] dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU support
Date:   Mon,  7 Feb 2022 09:52:09 +0800
Message-Id: <20220207015211.394297-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207015211.394297-1-peng.fan@oss.nxp.com>
References: <20220207015211.394297-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f574073-41e4-4e31-bd7a-08d9e9dcabaf
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2493:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB249303CECEA0D0453AD5ACB8C92C9@VI1PR0401MB2493.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pb/a/6/tEoBkYXA9anLjVhzcUE9iRyhkUyCx0qgREiAUBf6iR6+gETNf9NyijUaqbcEW+y/d2QQaOXfEbXmzUy7aB6YJdHiBpKCQygn7UEgzPOE5bYhU6d9DSgWsJ0SkvEIszn/0DJgV3h9owOpO1q74lazzlGNDAwLUXrldjncoddLY/y6CCsDuo/x4cR6upzwjZfo1gDdsX7MDpQmbGt5PQYQGZOJ+8K9hMz7OL+6cKyiPtPR7nhbzR6X+b8XNSAEtlYkxxkJcu07FkV836M16imj0OAAGx6eXzpQUGVi0Uwo2wUbx7P/dTWvXTyxA+hm8QD+DCi9PxvGCjmh0Hf9omwMZQoeAkPqqbwh+V305KfDtWRcchmE9NReXbzi42n6Cz4PJF/4RbkvyOGeBWXbqSM+BqK7WYbC3ww1ks5qGd5SonmC3faf/O24uUJLyMSlE9Kuo4zE5ta63utcVaR6Ci/hYSXKwRtI8KtUgDraWZCxaUQwdjJ8dw8wp4l8Rus4NK7oSTH9x2p2AxmmZHq4YyfPZHCGxDnLLXd44WwwC6vPncUAQH4jIMIPpvpDrUvUXppchNwQkQzB5HzP/BzUh/qVI8/r9LhpGaDanwXRlWsSfiBMvRqY2WcSGzmzAup+HrDfD2P06+MnT06wkruR82a6HOTkCnV6zI7jXBcE17RodwqaLAglDid8aszFx2egd8WHs3WfMiYSaC2lD0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(1076003)(6512007)(6506007)(6666004)(8676002)(8936002)(66946007)(508600001)(2616005)(66556008)(66476007)(26005)(186003)(7416002)(38350700002)(54906003)(38100700002)(2906002)(316002)(6486002)(5660300002)(15650500001)(4744005)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQIJbbtjt20DyaRTCbVXpy/9watyjn7f2oeNEjtCiI86sh1813gBCV72qvs4?=
 =?us-ascii?Q?m0Sk0NIcO7DbGMA/GpNbTuSQEpq2mQGMd8mjbgZtHwY+dqK27CgBAFxHCQPo?=
 =?us-ascii?Q?kqJvBcVyoxY0PtO+0I6U7y9rw52IYlkhJXyoFIbhj7AkdxvllbY1sQeYSqyC?=
 =?us-ascii?Q?30cHxEo66VQFFKbdAr72dR887nt3nH4zsSpIFrmsJ9yHnLX9dHXcLIsdKth9?=
 =?us-ascii?Q?Qtve7VNyk8o4i65myZXDY6ETrX9Bn1/edYpLZSpWa0S1gD+hP5Cn4pSKpYMT?=
 =?us-ascii?Q?aA9SWPULrsGeNg6d0qdHFJ+lGFvRn2wOmZd/cL1VI/j9HXzuSrWXbGpFBVtK?=
 =?us-ascii?Q?u9xuaxgvPNVV9NBF80L3fE+lrgxosm32mJQFQz0yHBD650qTEr6XmRTFrZ6x?=
 =?us-ascii?Q?SLQC5oeKxw51HHH6BUrPpKcJBwztU0vGwJb1VWJJPd60uFTqdchnNY1g4zPd?=
 =?us-ascii?Q?7QpYCA4JLXd0BMMp8q08VelcQOElNaA28iVPRvTD7CkC4zyJVvB82p7jRkE5?=
 =?us-ascii?Q?dLQNy+/vOoJlZs32OmyCbWnHD3IQ57Z3uLp5ebMRlUPxTmiBFg811XMt5Qjz?=
 =?us-ascii?Q?YZnY/uVEJQZA9u6kK4u44re5hJ72NrpcyX6dy8qfVE2X236dNrjAmzwO+yTs?=
 =?us-ascii?Q?mLMTkjC3SFDb1kf2vGErzS3fZUkObz86qfuUFPtlPfx4k0rDtzwGAp0VsH5e?=
 =?us-ascii?Q?3nLlxc7UHoHrix1vOK5jx+07oYHnFTxEBzMCvwZWQX+1Q2OdbbhdrLil84+a?=
 =?us-ascii?Q?oWKO0ZaPBkUpMQzeB3XyiHW0rac9jYJFzoWTwczC6GJW/6jEQNWvJL9nzrUo?=
 =?us-ascii?Q?MbdV+nUJ6V7CrQjpmsvXj/Rs3Ir6jcmdp2qJIHoKM1m6qdxkRecGIrYy65ko?=
 =?us-ascii?Q?bvhS3gTiUU8Rxcr/nCzvF916yx71kcyaAX+5BK/I6g7fUgxTSnxYt5z+FxnU?=
 =?us-ascii?Q?/Q6ZaVQo3U1UqOZDU2WnQGSIswX8cfAjOeYJwh0dq3I1GjqEhFpzHjZuTF9m?=
 =?us-ascii?Q?k2iuUdYNUjW3M77fMFEMfSdzuqgkinML72W7SaQNcrx7d8+gNmxG5WiIgXrR?=
 =?us-ascii?Q?CJLVG7f5uXK47eTOp8AbHj1Swjcgn3yhA2F/tv2ZxVW+8hsH5/2tpT0L/q2D?=
 =?us-ascii?Q?CXSJBY+WfiL/m4uqlzkYBiyONl4CxBGZuZyKJkgiKdIKjjPlFBAbjLmM896c?=
 =?us-ascii?Q?pdd0hSzTwUtcn6X5bj2+TpSEEG2wPNkpGMgcHbiZ65MH4BVpevsTJJHs0lBZ?=
 =?us-ascii?Q?0BGAm2HIdep80MjW7izKRQQQopURWKeeBPSqDulCGiDy7qV2TXcDZ6q4L4hx?=
 =?us-ascii?Q?3QbqdKD9VWGNN4GitocsMHUCAzbEidQx9iibERprVl2Oa44Uw55tDNCYZxPt?=
 =?us-ascii?Q?8pDxMEn0IMTFC6KbIHlAwroK2HTYuE0+pPnV8AdmdPDGWs1W52+ZY+gOVBRD?=
 =?us-ascii?Q?qkal9hH3d4y5dAYbI82BERWg3PwGjUVGa2GGZ9ccrNANbEOWdxYMRHtqm9CQ?=
 =?us-ascii?Q?LiPdUs0uSsuC0wZGoh6oLqFFyavOlKTQd13Pg8P1P3U71VEWmScKjMvhrhAA?=
 =?us-ascii?Q?3x3l9xhn2zjhVJf1Qo/IeG1EhnjwqCvdpZjzf3krjj8w5vTkHX5mji9X7CHb?=
 =?us-ascii?Q?okmBZE4enm7ZPJ1T/1XSo5o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f574073-41e4-4e31-bd7a-08d9e9dcabaf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 01:53:43.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jG6ObUi4iwzdPuJqaSFuoq6G5T7Egf2kzhYqr0PQX+ok6D3kYCgHhwYBn0sf2CKmIh7YXx1BKXvfb66nvUz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8QM/QXP SCU, i.MX8 SECO MU is dedicated for
communication between SECO and Cortex-A cores from hardware design,
it could not be reused for other purpose. To use SECO MU more
effectivly, add "fsl,imx8-mu-seco" compatile to support fast IPC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index a337bcd80c4a..f865b806ae6a 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -28,6 +28,7 @@ properties:
       - const: fsl,imx7ulp-mu
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
+      - const: fsl,imx8-mu-seco
       - const: fsl,imx8ulp-mu-s4
       - items:
           - enum:
-- 
2.25.1

