Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A4B521122
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiEJJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiEJJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:42:06 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD68369CD;
        Tue, 10 May 2022 02:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d73XO11cAr/+JgVpka0AaqNscgWLnzXedBHzvdCcpYQZe61QNlbrhgNsf6iQRdTljdBstAuHNXlA+9ClrNuUdZSitCwVPGzpp7h4uS8uYcKH+hFNCHPwJ/YQKT4FhipkeiyJ+PrpNqJDX9G1joHC2Y85uI8rPwa12FjMrTZZpeWcbegwi+J9eyNLLhsbw32cPHPiYspLhl0xPEPliMyaLD6DCDrxpGb/uw443Db2QZs7iXiVBD2572Lo7Z576fP30rLjubyIOCatO8xmhOOEW71sq6cTXi7fLDDB7d2RFsZhE/TmA6fV/UZ/Yd7mbl6J/9AoMuwLsI6DE2PKu+Uo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfQqfowH4cATdg5QQ3Gzb596kLpXJEVflCBCrw9fjMM=;
 b=bABm21nqHjC1i4bWMRb24lp23OnNx+VxDz50nJ8vI/MAe6bTTPty6V4zTH5DsnC647IXeidFHWCc/MygLoqsWXB8h6VnisrnSa+u6NCS/ZoAr/Rpz89SqnZ1HHK/JFjCvHeReu0rQUAdJ541u8zMZbNMvVXVQ5GEWhKc74GxxxeZ6q7zlimwaLxRWJt2DcYFfZ89hU6pUaymkoz+0nppHohwZqHjW2rXO5AI8sdxE+HUX1a2/7+X1/DuITtPcTjwF55jfHn3Zv7E5PTk2fdoN9PhQfWiHxmK9nJWP8LCYiQ84ByOT9Kay0rYirsjyAWCypZiDOIyeut7exqoNkR41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfQqfowH4cATdg5QQ3Gzb596kLpXJEVflCBCrw9fjMM=;
 b=QgAOXcPdCIuV8PAl7UUX11+mscdA3AcddsyB3jpQ7/O12Hk2jaFmeAFJ2hpEP7oKPARB3y45tO4NcoFlvAVGuHJ5oBQWc7VIY/0HjQjo56PF+ZPNUGmIaS1Z999ahY+LhMy4pDNEQEdo7xYLxrmZBbYrfmTuvxwTuYLMffYbhdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 09:38:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:38:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V5 1/4] dt-bindings: arm: fsl: add imx93 11x11 evk board
Date:   Tue, 10 May 2022 17:39:43 +0800
Message-Id: <20220510093946.335036-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510093946.335036-1-peng.fan@oss.nxp.com>
References: <20220510093946.335036-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f4d5596-2f49-4598-34c0-08da3268c991
X-MS-TrafficTypeDiagnostic: DBBPR04MB7514:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7514265ADA3262019D4C0F69C9C99@DBBPR04MB7514.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZvAb9lu3DKq82RjzTTdfgo3agmxzNzRki+Du+flIZYYJkZfEVJc1fSVS9VfwsNFgYBhr2xUMekJD8Qf8oMsPpwt+FZUUv6NpeLKLJWP5lTZ7gpWz4JnCjSuvEfH3SegjEDr0L/SGDJu7wOqC5kYlxRM5AYl1bKBCMnNQBr/VKvo5Umb9qgiVYyh6dt0d8bPUBpCE8O2d2Z9D0Ho8VWHLgfQvX0GQGlFopxfnHpNT9m2pBYOa5uYF5IFLkpQ/HJOUcQ/kO1DO52E6zZWc5kPuX+DAfq44+YJzNoUJWu6F46N4KH+p/b1XsuY2Biz0JYXU4ozN71VqDBDRDwvLCUFrzv+kVUnGzBg53CT5hAqQGD8nYaXJPD4kIOq6cp9Y92WJAl4dMXYui17e02fuFjY46czbIpvIj0NZusmeghuOK4035Rx4aqLg/INZB6q1LRqH9rNJHhh8dhuZNJejm2gTMUQ1epwG8/xZ2ACQ7BR202o0NiuniN/Mh+J7sbt80ukK9V5MINjAe/nu/UCHLvzHkjAE/v5D4EY2K9xck/BtsWf/vghSFSE4RZYM61OrHi5a8mMS9gUhZ8liqvxbUICembnpI391eQPa1x1PbfDKgt9T302qJ5mHXYlyCro1Z/hrcjVwTGfhoLhcYF4vQNJ6Rhh8Lo41iH3c69mfvO56ttr7gbRrpCubHQLUaVVxYv1ii4cfH3Zcw3Mu0UojS5mlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(4744005)(7416002)(8936002)(38350700002)(38100700002)(5660300002)(4326008)(508600001)(186003)(1076003)(2616005)(66946007)(66476007)(8676002)(66556008)(54906003)(316002)(6506007)(52116002)(6486002)(26005)(86362001)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nf8oqItuyQeZUJIq+PmlW5nsi9DfX2wlBgYRcLyg9tsGwGTsozMoDG4lNVCv?=
 =?us-ascii?Q?8NhpSUoFKc5U8moPspX2gIoMn9mDjtxhwnTfTUBCHVTox1p0ty3G9TWtqlX9?=
 =?us-ascii?Q?vTpwuiZcqJZ6vXux2wfo65tW4AfsFqpRaksuS9MBUmGD5v2/aRi452FMsUlK?=
 =?us-ascii?Q?jfabwe/W54f9FMAnHt6bnBdFvYJv8+U0mc1I7Eu1HpNW802g1S1Lc5icWlT6?=
 =?us-ascii?Q?pzZDLNYAMlvtg7n5Tau3Q5YIb0Ed51sJuVks7o0x7+K3RqlWNSZPNpBXf4Va?=
 =?us-ascii?Q?+wLqujDgNfXQPfNKAiIlCjXrDTpQ3BhVXiIKDBlQALARAmlun2BTpJqjwYSy?=
 =?us-ascii?Q?OgGGpiTJti90Iej6GfxayMQ4o0p6jRQeCI3eAyyyfcPH63fHJHBOrVb3TG1q?=
 =?us-ascii?Q?cprWupNvh7HZhjOrUmkMCWjwaxR3QkV+Mj7L4ScgP4vZ03ffzpJhkYUaHNMn?=
 =?us-ascii?Q?y+q4QhNxysPQ+6GPMOaNLU8HIHJBJO3gpowHgQP0Fp6HrENC9XklbHcOkCD8?=
 =?us-ascii?Q?qeCUXcGXc+SxK1Y5R5yfgNau4/ZBagO3UzNYNJLpiJ5Zbxm6WLWnf//sPJKI?=
 =?us-ascii?Q?DuUQpcQCRbc/6eodLaYiwY4qt2B6DPrUFb/Mv31E/naymNOMKpOfGCSGg03h?=
 =?us-ascii?Q?021AdVAVimkBtl50fZ38fp5PdhTL9FiG7SbtH1ilhjahbQdfX9i9T4ZpsS45?=
 =?us-ascii?Q?207mcgeGW5Wz1nUB83LyrJL5NBbWig0wD0/V9LTQ79VZwVnwQYMXiA1MJW7G?=
 =?us-ascii?Q?tebDAopZ3LGEtvjOfCLm89VdaHRrRAQnBzGrU2wuKBVFoJZP8QUFgsze2Sp+?=
 =?us-ascii?Q?f+FZB82qt6oS1NlfKo4J/eZcsi234ofk/L8ygEKR/SSlmNq/LE1JKeV1oZQ4?=
 =?us-ascii?Q?BlhwXZSky2jzzMjUdmV990wSW/uLvsftux35hlYac9xtrGA0A0t25flH4AkA?=
 =?us-ascii?Q?Iaf1KR0elEVIMFQZ3jhAksNAIYMJaLCXlW1jJSMd6U69vY6zEv7vHAek+sex?=
 =?us-ascii?Q?lEagVecHY4plXhlnLkAMe3NMAScKIVWeMFT3Hf+YcR3lQbltqwmHcm/YczAk?=
 =?us-ascii?Q?j6Djpo3Y7BqAiwNrIpvqVLnSgHZCggQnmv/u4gtLWX4qmMVOM2dhgsl6jExc?=
 =?us-ascii?Q?2qouZvGgJX86Q44e8RAmU9SZWFHN3Cvh15jvB41JDXLXVpOzUU3+cz759FIb?=
 =?us-ascii?Q?aGwtn80osUPhoCsPIwxSC7+SURyPZZGrtHD3huWm9OACeO1XvFpMuaa2BqHc?=
 =?us-ascii?Q?2+vu4fo1lMbSgb7eAMXaLUyKbIQQHFY8LDKdsAAnAJrXFWvLHQUDN8V0lqyV?=
 =?us-ascii?Q?FP+3I8gvkccYDuSG9r/CPg15pjrBUh5H6KElH54fNa/SvC9gMXRGhsh18IhH?=
 =?us-ascii?Q?Oqg+zmb2i+SavyjykyVAlad+TJ+2fD7I056YIOv2kaND3NDRrDT0zHadHt/w?=
 =?us-ascii?Q?HGUop3WY/82YlAsv9IRUF8zSu2vYBbTzuJcWBk95X7q0ITUPueQnXc7SvjDs?=
 =?us-ascii?Q?el8A2rg9AUItnz4W/wYqa1oAgoY6xf+Yn/QnI/1RElEOzT8a9IGt8UuZCjaW?=
 =?us-ascii?Q?2ekdew+l6kavXJDcCFsu1eU+OQRJgPO6HUKWGDg3HXc/nXP+NIjUF85ANZJI?=
 =?us-ascii?Q?wy9MMtwi2CS1vS0foAGXBuqFraNUdwhq+OxYk8CFoNUsouqSECOlbe1jwB+r?=
 =?us-ascii?Q?B7AaZHh/uFr2ZGSZpLBhXLG7birXeEWfe9Ouv0nN4JNduz6I1H2Lxl5J0EBr?=
 =?us-ascii?Q?fZLjj0rzVg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4d5596-2f49-4598-34c0-08da3268c991
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:38:06.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk5ZS0rGUrxoP4XqtunmHekGVgJNzj/RpXNP3aOEzVskn5S/XUS1mXoWp2ihAN7s0r8vHP5IJjJO3zUnxo0kOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the board imx93-11x11-evk in the binding docuemnt.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..9e5d5725df65 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1020,6 +1020,12 @@ properties:
               - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
           - const: fsl,imx8ulp
 
+      - description: i.MX93 based Boards
+        items:
+          - enum:
+              - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.25.1

