Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBE4C0887
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiBWCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbiBWCc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:32:56 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50050.outbound.protection.outlook.com [40.107.5.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB76580F7;
        Tue, 22 Feb 2022 18:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3Q+VJZsphzXdp5J4DVNGpK55+8chevbcfa/HppidQxm/qFNZ4S7gJcU8+W9XQd5E1lJ2lCZVi3nU/iTcPUDRkekWP1lPOvgZoZ3rVHqBc4ETvfz21XcGH2mJbKPqvoJC621healdsyhhhYea08BXmIo1h35sb6ISMKMX7olXKitvPAtT0mrib86kIHXz29w9jt10yv+WvNZHagtd9BazBscU/v8fgEaS3hE9gz67rFCdwoQSedDWmssPG7qsnstvyThxnTEsq7ZMXXKEXKmQ5pe0Q+/noqoErhytt5fxR61momhaGUhcBYc8VSxd1n5tZZ+YXDGjnkJ+tMA/5IkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNcEpdyvLTOUk68LLfw48fPizjghW3J1eutmmHQeUHA=;
 b=hc3ss0aXNs3/G1Zf1VbgFfyfu6BOTSsHq+H8ES2UWAhr/6rIYf1aAG0eNxDHXZJBFJ4itKFsH2CvfTO/wtGTm60xgDeb3nBOIb5OZc02sSCctFtvKXZIU/AgHPZ36mtgcM48py4ugjjyMBrbbgAnGDws9ITwKSC2MgvreTd1Qny33EK18d5sSWJ8n6qDjUIRcpwDUqYO6itzzd2hpiGuxr87bkoOW8bSl3nrePHkcl4smDzbz0hwF34gvlLfgUhbqxwCcHJ0ET5B0jn5d/EHsPU00bdl74bUnHlEYrCqKSehMpkfVrmIueztC4UnyvhX+SyoUYn6xk73g6vz8vLmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNcEpdyvLTOUk68LLfw48fPizjghW3J1eutmmHQeUHA=;
 b=J18Vl0WVoPzEhTvH8luHsKn49DmCyaRKwMEvUofDLGeonleCm59rEAJcdJA6JkUi/yZA4VPLs50KsqbAiv5BZXyKmO5E1LhEWR3j6E5wIUGnkeYpUm0QWquCZ/dTbz4c3I4bP2Gc1CMQGhkWwJmgM55oqKPUJv1eipO+qXebNL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7311.eurprd04.prod.outlook.com (2603:10a6:800:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 02:30:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 02:30:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V4 1/5] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Date:   Wed, 23 Feb 2022 10:31:53 +0800
Message-Id: <20220223023157.3478540-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
References: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74355401-903b-4ae8-743d-08d9f6746c19
X-MS-TrafficTypeDiagnostic: VE1PR04MB7311:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB73115500C18CB8A1900E751FC93C9@VE1PR04MB7311.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWH8IePlZg46nbdOWQ2dE896+daSWGA6BfWu2AB00um5cUwCja41IIJK0v2xrjQ9hmEFnfFqRn5eFHFQlCHhdAZ0b43+TbUEvuwPVuYxlU2UXY5MaWOsDzMM0QqN8gbj1eM5mkphiW2sPSUhITLYXgrWUdonAOyK77whrmVqI7J+bjLt+i/4eilqwt+u+3wz3pxgfk8IC89vfdcXsoEdJQxfslH78CP13i+XnvUqT9JCvp3hcqNgDIgubhCjZENXtiFqyMMne9Wuy8Bm0YKiax+eQC1+w1sY9VE+azBLga/rnkh/1EWXhN4hLO1iRiz1WJAvDDFmLeTorHT8sBuhuEdQnhhCAomD6gDIZK2c3nx/gOBExLDWb5KQ9r3nKB4IfoZKuvoxWH/lpWBlh9/c1TMUsOoJWEyXAgULY3LzzIt2xbMrKwPP+LdRVwvQjRXvF0vr40qZmnHkZuEFBDAsHIna1+GKxPQ9rnx+hwOnHkueqE+TV41U6OhmcXnl3DwOvk0xh/yhbCY6DXYVafdfYCz0tHNytJUzLpnx33Z/u1dUY6hYvAKoJEt9pQ6/dlS61DG7otjBb+0iGIa9j0ZSsje9mqelEuoAN+UaqwPZk2/dqZgi/2LbRjZOuG+p8+AjGMqVBn9ZDKf0ypi3XH6zp+FXgAvyiw8cZXPDJSxyKMsJGaRF9BiY0pom7puSAYamSOuVh26ZKzbg495EnJMuXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(316002)(54906003)(86362001)(26005)(2616005)(186003)(1076003)(38100700002)(38350700002)(83380400001)(508600001)(52116002)(6666004)(6512007)(6506007)(8936002)(4744005)(5660300002)(8676002)(15650500001)(66476007)(4326008)(66556008)(2906002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+bVIDQkbvLqUrA+lUPrG6pCxjve2jr7iZbpFoB0QDZj5kRMgWpiOSXf1Wf4?=
 =?us-ascii?Q?d9g8XksqVsOnWAUhegF3fGrjwng8Tqj07ZxsF7CpG95joM9RrxTk51y9i1GK?=
 =?us-ascii?Q?S1b0VvCcFfJfUPunK08Zq64nrUYM0hmomeVFLulLcdiXrrjj5tHoeRiFYFBA?=
 =?us-ascii?Q?XxSo9TaJN9CAsJyRUSUd15tA0cXPmyOVSknO0Yzf7g0L6LZwtgrEySKt85lf?=
 =?us-ascii?Q?Hir/Zp1AiLs/IacN7GvfwZVfYu1vJnA6o6ZvlxU80XslJIeJBbLLBaz6gx/b?=
 =?us-ascii?Q?6VBxkmTn0PEzZRU2BoF24XAleJU5ztMg1kYADm3WOc36FTBdESPyfsMK4C46?=
 =?us-ascii?Q?MCOKwFvUHvX9OHxSGUKIM+q01dtLHmxjDhwl6NYHn4+4ESDO7ZG9Gqht8Zl8?=
 =?us-ascii?Q?w4xKtf7P9Qq4Dwl+MxxznUXrqbGOL37aRtW2J2LMfpjnm6jaazjKesLlHvRY?=
 =?us-ascii?Q?AtIY0ouKgs+AZtaaUE3cSs0jEE1hlsBnFzL0odzyklLy7EUaeV5wDSW/EFGH?=
 =?us-ascii?Q?x7G4uoGekUTtNs0On5P/9+FQmfEtSgub0MexDcF+QhjLEa1SBV9/Gb9jQ2qA?=
 =?us-ascii?Q?BLexaf+4juViu49rxA16d4UMV7W+aE5R316F31nmZfKYmpJ/6ohY1dHhwhwM?=
 =?us-ascii?Q?X1tAKCVc+sYUKhXHXyV6xqwlnKnF3s/IaVUd34jCrkQF3g1RjaC9xbV3nTUe?=
 =?us-ascii?Q?E1HPwXhqfbrzGQQUlpQZKtcAjhYNhIje7fzP9QcWuM8HDw2dUNQI8Muufpqu?=
 =?us-ascii?Q?CFPZDzZ1ogJ/ieS+hQqrO/S49NFezJ18VznWi/kDqhzaQGub3NbeHq0TZkKy?=
 =?us-ascii?Q?Rd8W+6fkInvQ/A8slzkTwNfisW74NEXHxGnyBZW7ibxjjD07LIw5txaGMGmP?=
 =?us-ascii?Q?uF4n4lPuJ7ESMjBIA4aw5DwGlISsyvo6i4TJvV9nNUw/Aij5vUnT2yAjFCAX?=
 =?us-ascii?Q?BgmFyagxsttmk+um94GkRcYbysmk2BymkJ2TKUwaUN+3QuWWbWEvcQytcY1p?=
 =?us-ascii?Q?Qp7Dbit2QVQ/P+mcEkLSYfKblLdiaixs1qKsDhODWhjJFxymS9jVdl5xirsf?=
 =?us-ascii?Q?XHgPsYWfLeqTEiWXP4bcnCeA8XwtpQgnmsaZwJn0ANAXrvvlph+vxZJNurQg?=
 =?us-ascii?Q?piixgKAJdpgQr0q932x7OJgvOtAKqUJa95cP+h8n4EbJUVZSQ99SUKZusuEe?=
 =?us-ascii?Q?xgBmm6nOvdNRhPlYVUNfUb5oZ4DnMCJXnQ3oiDiTzDUoX7Ca8v0GJnIkw8OW?=
 =?us-ascii?Q?DKvFBsBRGuwz7J9UFGvY4DN4BZoLDhYqIwIRTQIs3EN+y3Rip/NeUcz4/RwG?=
 =?us-ascii?Q?cq+mhK7yP/LWgJPRgNAXDXkEKeo+z7ZjvKkXvzlCNAT7xJ1iGp5QS6jyIgFB?=
 =?us-ascii?Q?jvVaW/R+7szZl0AtBg+CwP83Nw/5/x5Olf7PbnrAsytPg1Zo1tejw6KkZ5Fo?=
 =?us-ascii?Q?G/3d/8RA89FhzaJIQxi0tcvfTx9DiBtPRVlq5kJ7sBzBqE+lJBZfu6r+1Sxu?=
 =?us-ascii?Q?JrvNJ4TgRRSVTJMKocUU6/p2F7nMWsbyRqjA884G5e+z4Gpg3EpuyE2T3iIu?=
 =?us-ascii?Q?CCk9bNXZUWYMMIyivRBgE0t8XMd2jN1z7OmfAPx9/17Lg+sXOovIRD9N1GvQ?=
 =?us-ascii?Q?8YiiWqfIeh2FQtK7MtosviA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74355401-903b-4ae8-743d-08d9f6746c19
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:30:14.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKYKV1b8JLwzIXHuvsT9EGEB8fYybCFTzkFAFY9xNq992/cAb0/j9QYo1nmIV++IeipVBOCUx8XtQVLA9Y0k+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7311
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 MU which derived from i.MX8ULP

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index f865b806ae6a..6d056d5e16bf 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -30,6 +30,9 @@ properties:
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
       - const: fsl,imx8ulp-mu-s4
+      - items:
+          - const: fsl,imx93-mu
+          - const: fsl,imx8ulp-mu
       - items:
           - enum:
               - fsl,imx7s-mu
-- 
2.25.1

