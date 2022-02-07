Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC24ABF39
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385298AbiBGNJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444328AbiBGMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:37:21 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130058.outbound.protection.outlook.com [40.107.13.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AC4C0401D1;
        Mon,  7 Feb 2022 04:26:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxIP7M4+jqt6lUmNEiS5ax8CAnzQPxkboG/g5nrVL7tRvWMey2eibr7leuo2Ro+LbResNNmEdz7fQ3zEIMLsxzdt7FOMt77zyqQXpFQXAA14nYYZ/v/tOckHAwGZ8+3Yi0HG5ZJko9HO5pwJBH2HhlCPSdUp0V7ny4oc4nfUM9WNO7dZs87MqSgxPG6phJmcb0w8bok9VuQGTmPjX3CJj4ylagL+JMtW48q+7JqRP996TFdWMBj9k3jmfW0wOLkvthwrOcLtO+ALJ2xDa4WYgZ8kmfVcjDVNKth1q7UKfEFxnM7FhoAr1VfUao7QnKr05bnXXV82JcAqmsLVV5wnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqAtWXts8T1rUt3c7wlsVzmPaXZzK3VgJYzOIx9sN2E=;
 b=aYrCW5faXb6BXicKMyltrrlPrSaHdpeEpzAzkxBXc2ZABlupotFnC8cb0jo3o5EEyKLGXfd+H30RdnrfGvMCCQ0P9isFyvEfVjz67wpNmAlseJ79xTkF9qhJrOb/9SMf+SrK1/WSLh7GLllUbYlh5m3JaEZFuOJlhkr6XkGUGY5HEj8PGLk48XYDLgT59KCbPmM/z80wgZRVYESM4hhLz68WzRVnW6JovkLjmcdzAMwsWKCcaBV9uejXhz+jF5F113Cb5sOatbxycTYWz7EMPbuMTycqKfI7jsJ5rJ04NTl4e+PgcHuY39lN7fAwO+6HlunpuYCM5olCFhLzSLUahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqAtWXts8T1rUt3c7wlsVzmPaXZzK3VgJYzOIx9sN2E=;
 b=THYm+5qlw28rahdRtRv+CQaL7Be28EMCmJilQXf/VCZN+1WhweP44TQ8kj3KVqsrKx9br0TxOfBh9RdVgKDWgy+OnR21ssqjZ5+MPvAJ0tuWXfo3+VbMZjDEneKkvIplhltlqQw64oD19GjakSWzegrERP5/urvzKn5RR+CKYAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB3296.eurprd04.prod.outlook.com (2603:10a6:802:7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 12:26:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 12:26:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org
Cc:     stefan@agner.ch, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: gpio: gpio-vf610: Add imx93 compatible string
Date:   Mon,  7 Feb 2022 20:25:30 +0800
Message-Id: <20220207122530.1609009-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a7c5f7c-9772-442c-e263-08d9ea350c00
X-MS-TrafficTypeDiagnostic: VI1PR04MB3296:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3296CCD4039C76BE8941B854C92C9@VI1PR04MB3296.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tj5qpdQGd0K791cPmvdg69K7w8WLrM6QfjDiD84hCwjyRNXmuLOvh3uCt46GbnmLv8CZmiz8TZNHcsWFWaRfWtXsdik4S5p6RPNjpEJsGwOYxsPQd4+Qgq8b/kuaBe3cCf0dPI1ngcgXwliO1sknjEMr8EQSXEBYo/aTe8x7XrY7co2zgTcDIyroqPLNJ9RZDRImYhVeK84Bh3jyFHP08T1hgPpwJzCLgwIa6UmZHnQN/Jhh9+RZ6hoUcfM9TapBcMns35Q7ogRGv2UpCDzzS4BkP6Nox1GMtq+uJrAOPRl9BrEw1pQb+PCp7jKIkMCeDDSbQkPJhIyHVB96gAfEgJjmNDdBZU1XaPy9HqgvL2KtyNGkyfUIQn9jTnDPSfftx/weVijAO2cuWIlT8WMouQq8dyE8ctNqpYeMJzZDBsGyR4lSVYtY1C+Mg/7Xj+DOKcIffBRQ/n/QG76DJPdzuJkN8Ui5Zbi/22FMSMPg18uEJEcVI4gbnTd0gBMiLDbvhjygbpcJV/0pBfL2TPrcpTxcaa1LEPUXybDUtfwgwBJAHnmYzz//JBnP5BMcIejZjEC7+YM9832K4uPHf1ofzBE6SFR6DfUm+jw6hCJIWy6aIzZrKs481zwofsjUAnP9l3PsuTVYNcOMmdSPv7rFvVeYuiy2UNQ9Uqnq4WJVQSI0hsnVvel0ucLXpJhCuBi+28Opvh66CTIlRP4rZegYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2616005)(1076003)(2906002)(186003)(26005)(38100700002)(38350700002)(6512007)(86362001)(508600001)(5660300002)(66476007)(52116002)(66556008)(316002)(66946007)(8676002)(4326008)(8936002)(4744005)(6666004)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJtZ8NjOogaimt6Qz9Vq8MC+siWyGjogmv2IH82xeIiAaPdwQRl3dV2xJ/Ix?=
 =?us-ascii?Q?wdmz83HyjHOi+HTAryNKw/xteA1Tk8pAujujK6h5RXv5NhlY0TS0uCYhvkRn?=
 =?us-ascii?Q?Cl7/md2PwRj/IMyHWqZM6QdHJBypu1f6N5trESLLi+KOTZioQGk3urrzZNEU?=
 =?us-ascii?Q?bCm5AHKqhphhqZh1ldQlKjulE8pb2dbNSNjGvFVOLIWDp4NvseR4LEofAOoP?=
 =?us-ascii?Q?H0Ydoy+RQJn4bCJRCToboRZYJoZqkls2v5HnGXfBQ4lzfOS3PsWQP1yo5eKW?=
 =?us-ascii?Q?8K7d3EHCy1RhQqacnG/WslG096Kv5jWRUlQm/FLk89/pDVziNtQ3oCUpM0ry?=
 =?us-ascii?Q?aJJ0TKeqMIk0h+P+Cv1cxHrSM86NmVmSU6FtwcYIdRYLCSQQDWjHCeOcTaZ5?=
 =?us-ascii?Q?B/ah4KrQgKCEUwGOeVYttt0/iadrVeWd3R575U5BQe/NR/4XA2tMAUJd/qyY?=
 =?us-ascii?Q?v/ajHlw2pZkt8Aj2e5Ak9cOJ99Ny83evp9G6YQC+gr+N7ljXtDA0l1YspMZ8?=
 =?us-ascii?Q?FKuYnSw2p6sdnTrNDkxHn1VLBVUlD5odMqYBJvMKyojGk/MPGQmVjILUvFdR?=
 =?us-ascii?Q?refZdRERXsB5NbB1hYfXCXbggqaX+wZuH4bHKxm5yHS/u6tqPRx2yn7L4ob0?=
 =?us-ascii?Q?CNhqr+bAwVbd9wJb5PE4VXk1OZ8gtopNYiGuq/zdZ2lMhSgw0GDjtBGvIvTL?=
 =?us-ascii?Q?RPaZZzu87ZNTLOLLX1ukrxgyaEdEtiNyoTuMyZYuJ48fSBBUZYnPEAQ0lWyc?=
 =?us-ascii?Q?NRXqPrhnlil2AMI1m+qyn5zpAjtdYjgXiP5Zs25myer7nQFlLf1TvjqlvFW8?=
 =?us-ascii?Q?2VlXAQfBiCFe9SrixWaeik9UVhSb5wMH4Eiqii6VmeK+I07mIXRirVhIZMKB?=
 =?us-ascii?Q?ienRUqVaNx7Aq3vdLWYIIj8HGekYC0Kz/RaKxHp9F3E2wpfQngbdiqLI5ROl?=
 =?us-ascii?Q?ez+b5kWtvahedoBDNjzq6PGoMWYgtrHZZ0p83sO6J1OlADJwlHPgEWkLVtnd?=
 =?us-ascii?Q?of2BSjlK6LQU+Nq1alEwDHmG8rNKchP7VOWsqiBuDNHrmpJTU2CoLREzfEWa?=
 =?us-ascii?Q?bhAbAcN4uIiBqq4i8i6WDEc+ik/uL0sqzNeup2acS2Uy3VFxEUcLDL0EglbF?=
 =?us-ascii?Q?LH7IoIwY5MaaR+2QjY+8WDdHZbU7XUQuVO3/WjNlXlAusgjXt73IItJZIDEt?=
 =?us-ascii?Q?4Tt/8Fmlk6exZMs80MTZ5XQJU8bdUkv3cr0wd92hSZNQ3pc4WtGBacDpggxm?=
 =?us-ascii?Q?+zGl4ynXKy2HuQErUagJW+vUNT5mWaiyVXvlRibUUPV3zMDaiBTgNZ0lPSxn?=
 =?us-ascii?Q?s6wAQfywvKMFOH01L09J7F3oEUjVj3YnHjHF2VHC9xpPnfazUDBh0FN3cqHW?=
 =?us-ascii?Q?he3+iInSQJ2FJvCZALYAxpT7FD7Tyf0TNUUEhyPHxrM7iYNpjfAHFNq3LCA9?=
 =?us-ascii?Q?b6YIoeEixoSZ7Ioe2n9u7CZG8LHkTctNBB9he4KtxW7RMEhwQGP0kh9dws0A?=
 =?us-ascii?Q?RBXDt+j0AP63hinc+pMuMMhbyRHmQ6KP+MhBE95ph1qlCHlRIV3jzRhmi6zv?=
 =?us-ascii?Q?fgt+gzLXI2RKy2z3M+sPOsW0g4i6LDPncd389GaVWQzCSgpX38h9A6fdh/iG?=
 =?us-ascii?Q?iJoWno6WmfTqdpZcRmww0lU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7c5f7c-9772-442c-e263-08d9ea350c00
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 12:26:20.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEIm02XmnxTrmja3U3bkotr3kqZri3z8g3alIC3//Xma8dgo0PGChNRKlHwNZrol57IfiIEcTO4p51CTtOSvRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3296
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the compatible string for i.MX93

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index e1359391d3a4..d2c39dba56ad 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -25,7 +25,9 @@ properties:
           - const: fsl,imx7ulp-gpio
           - const: fsl,vf610-gpio
       - items:
-          - const: fsl,imx8ulp-gpio
+          - enum:
+              - fsl,imx93-gpio
+              - fsl,imx8ulp-gpio
           - const: fsl,imx7ulp-gpio
 
   reg:
-- 
2.25.1

