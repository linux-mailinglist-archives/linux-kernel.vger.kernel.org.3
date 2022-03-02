Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BCD4C9B23
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiCBCY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiCBCY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:24:28 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF1A88AD;
        Tue,  1 Mar 2022 18:23:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw2cUIR7dSqn1PZxTQjA4BZnIeZvKqe0v0gWS4dsOjkhVARQp1sS5DsYPhVsBd4OsYYROAzK1+d+Qz+F2C9ow7YSGE7Z8UeSxconeExE39f0+KaZ9TzgwGW9D3rtIE0XmIV7rCsij2MzhpD/SQGTlBbXQCHSXuANbGtQmDvYyb+auMBQxf8vhL/ulIl2MbG6DpS8JTgbku0nu0opxUJD9q1tW7k07Vcv4VF9GWliKw1lNACCZH0WAGEeN/NK8bdxp89yVqpPKrT6z9qMyn/LeHNXhROVz4/x7Rbc+JD7RCC6L7RF3NMYpq5x/QH8yzLOQywlzizPGow2z/og4TrYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNcEpdyvLTOUk68LLfw48fPizjghW3J1eutmmHQeUHA=;
 b=P0bANIwJUnN1f2Sd0VMn8/G0NG+3iZoYWn4Xo2u7kTr8WcvQhWJiDVU4rAs1DitvnYzD7+/pE3i/+KgZyG1AInC4eH0wu/0m8u1yBdxqNlO2mAvZ98FQmsXBr1q0DNHiyil17GiTfnOzmQgpm/LEk4TM8WkixH+ib0gJevC5rqsraLFGrYy+8efSH/gSv2NRaVTOJYil1YmOrHagBnGdC7n/x5fumSdp34xjckE3+mr4Vhxv6BVhDMhPOokOWl2M7CU7UTeO7ecsGbNCx0RAQ5LnvUtcOgjpS3D0Aa+DiwTMeFR8mxTk3235hZpK47d4QgcK88sahhckuTX1Nc5RwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNcEpdyvLTOUk68LLfw48fPizjghW3J1eutmmHQeUHA=;
 b=ABN/Lt8eMHf9kQB006o9Bh57TOK2Grvkodfcf4mtMXeHZ2SRNzX8yH4rws+SLqatrUXWwiqQfA8Qxs/YT79Ut6h3jjIqIfKropxFg5OspSjrffOM+11VMGo3JIVSt717zxWoen0HhWYsJY+q67gRJW0xWRKIgbEjQBtr+lIxXNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4144.eurprd04.prod.outlook.com (2603:10a6:803:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 02:23:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 2 Mar 2022
 02:23:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V6 1/5] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Date:   Wed,  2 Mar 2022 10:25:18 +0800
Message-Id: <20220302022522.1789588-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
References: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e18167-fb83-4a74-7196-08d9fbf3aa36
X-MS-TrafficTypeDiagnostic: VI1PR04MB4144:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB41449512996FC751ACA3D11CC9039@VI1PR04MB4144.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAm5soVdrODfcCtcVx9loK7ukO9ib6B2OIceuqw/vb+nOqeBlNXM7QbRMlJnh6cKg+FSiOVTF7Z9GPinZKarpBG69W3GH3uYCBsMKTswuHF8PGyfstd5mn0eDhqN1I89u6r9IUgOuZiig3LJiPfiG5n+5dkTfzCg4mVQBdUWX3vZWSFELSm3tTAgYIs1fXJHTncTLgMndQ7kChsfjsbcHBxrrUgUWmrcDO33eBs6cfhnNdKDNsk+rMp7oLkekmMWMWa5QHuKHH92h7RN/RxmLkpIjLmAjjlFFjs2xPYToIfh3Q9Agz3EILBDEHGv8kFv5cWHz1zxb1GnEyh6ipHi2mAdMESCwkBai68khR6FjUIHovRxaxR/3jBEu8GPtgAC5/x4LZiyJVeKZ81c86wmY4XrTsGg/eR9ixUIdmVN5Wyh43z0p26FnQ1xkKU6SqlQda1GxnM3dLXaNyCkgjyOGbIri6NxZdbDmOiB+GfLPP7VCjj5h3Du+Oo1pGcYo2ZHAx88KLkZkSQGWhSi5++Mr2mhH6abaDbGCVbX7/Si07krtBOYevAA5GLzRmqp/w11UMJ0Rvkjzausg5caRLtZHZ80HwBWDYdM1Sjtx592GayR9pLidHRVe5nA8Gld5WS8bthgppha8OEX41dpXIJO2N545uMNZ4qukwiCTrn+xpeysbYl+I2CjwsQqLD9hNlDGWVHGq3rYXKDdmlOpuwiTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(4744005)(15650500001)(8936002)(7416002)(66946007)(54906003)(66476007)(66556008)(4326008)(8676002)(6486002)(316002)(6512007)(38100700002)(38350700002)(2616005)(6506007)(52116002)(6666004)(508600001)(2906002)(186003)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+N+P1AEIdM6tvl40qazD1hQ+jPNxk/85RKPyMi2GHMR+BGsrC7ue81Aucka?=
 =?us-ascii?Q?X4dOkogTkGM9BwC62CmXPu10Ia2VnIM7KelrHXbfbNhHkdEBoppnsIyeGX8h?=
 =?us-ascii?Q?Ka1UOaea95OScIf3FLabBMHitpb7yYDplbOM+1semnSBk6Qis6iZvlLECU01?=
 =?us-ascii?Q?rP7TBjfhkvNyteUH3Pv96OhTaaW7AbifgXaok+aZdhxUhWUEm1CUPAHKZZ2r?=
 =?us-ascii?Q?n4pIUYPb9WncRsHPz6T6Nm6MVjJzG/qUzA8Zi683cy/qWfmJ3oD25cm8d4n6?=
 =?us-ascii?Q?ftMdm3Lbq3X0x6nfjwyA2Zacqg09MZPtaYLO34zSJOBf+aFC1bnsjrVdfcxv?=
 =?us-ascii?Q?nfZ36jaxXWfC+IR010dpLDHZ09e1IJMRLhjtaKPLndo4TZZlaPiDOZDaXPHS?=
 =?us-ascii?Q?iNPWvaMbML9ltaVGuZDDWSWJq/Rw9P4/0/IgejE9cXwjqt/kcQElKrHUULXs?=
 =?us-ascii?Q?YmM5l2APJ0gYwJevOCK52UBkOlB7QxEOx7pjH2AqB3SQalnvzKcPIuZ7Q92E?=
 =?us-ascii?Q?GVCoQYTLn7iRLsW29C+LOwR2FdsMDw1lXL5LWm7VpoRfM8CloMXM7VLcC5ov?=
 =?us-ascii?Q?9Z0wEC/IWEr0vVehuRKLDJIWx8SD7Uqa8pZNROIqIRzXUYdb04geMCaJWLqQ?=
 =?us-ascii?Q?Hagoi+CC0EVL0tuNZtfTDtA9pPrLmttTJ0I9b4YLeebEhkrudmHi8gm3AXz3?=
 =?us-ascii?Q?w/jkNAzFb5Tm7Q+PjP8NewOR/g7IvNk1cTOF0SkAC9RgWzIA1RfII4H23Azr?=
 =?us-ascii?Q?S9jHnSB98Z3dBTgGdqBPEDYcL3oxjJ2eSYMBh4amFoctDVOt4iasbjiPsPyl?=
 =?us-ascii?Q?wpBxcxDEUa/X/roFj6a40svkWy9J8WyJKsA+CsSGyarciHZn/01O036gMXfx?=
 =?us-ascii?Q?EfvtnxB7hoGdnlhH/HJua4vltEi5IzxiYtR4n2HLTwdEQ2JL83mvrJ2ybAnM?=
 =?us-ascii?Q?9GYKHBBBBFLltLg7X7lzJ8dWxhD7Nay5rfIYVUI6WtMhNuq9vknrckuYqMvf?=
 =?us-ascii?Q?DxGQ7QueGpdIa+5uqYfzQwatO9pOWke+XntLDVQ+dV24mW0vymfAiMy95hlO?=
 =?us-ascii?Q?/tNW0vqELMeZ/DG0QECFcxnFmcAMQPYzi7vEUWYAj6jf1rAPFg9ZdOktB611?=
 =?us-ascii?Q?3r5+ULUPXn8MmNyh3xiZctjGEp9YZd0Lk/cnjxiCMIXFbHa0ZjK4FHwFSczA?=
 =?us-ascii?Q?La3bfhPV9EUGH+N/2v5q1hKZqPhE4Si1WwslGFHu8GYi4lpmrDJUjLiB5Pba?=
 =?us-ascii?Q?9jn11ITAG+G63M7sjqfKzWJN3GexpV9B++it/CLU8TNtYYkVaLQ2L4bm1y+w?=
 =?us-ascii?Q?u7AcTbey/8pzjVkjowiGH/oiuueFpHZrtPYCZZb1AKMGRnyngeIU+L7BVKLd?=
 =?us-ascii?Q?56bPtSMsTp2fc7SGp5Q4ZefFpXQ9/S5lAm/uV1Fm+Ka15bSO494p737FD7fr?=
 =?us-ascii?Q?dH6rnAMaHvQWCuPJ500Z3E0FP0+CfbhVatHQMwiwhrLfptz9x6CbGTGimvnZ?=
 =?us-ascii?Q?pSwU4qJ/LxjAQtx2+V+qI5uXa3VrmDWwihL8bHCvG8hLJZAlBFM7/EsoeGyw?=
 =?us-ascii?Q?ZV3ycu4ggaY9+yd4L3aXNanLnErCH5PAWGgN1oPMeMl3PDnEvd5SHPlE/C1K?=
 =?us-ascii?Q?BjEAuplIlreSn68/WsrDA4w=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e18167-fb83-4a74-7196-08d9fbf3aa36
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 02:23:40.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NF1pIEy+8HBk/cCKKOsIhUG7osrHNNF17q+IIQ3DoRMSiifEbywPa5sBadY0bEh9e9s1dLTR4uYH9ARcfvHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4144
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

