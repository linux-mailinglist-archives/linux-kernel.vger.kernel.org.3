Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA07590C94
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbiHLHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiHLHdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:33:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B0BA598E;
        Fri, 12 Aug 2022 00:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+xF4KUgih2zXe2NP77XcA2Yz1aW+fJsGo1on1flv8p0kQtEcsQun069PocH2vLL4rLrLdDDQNh941Dffp3fIiuAh4xHDEmzJQO49X7R80eKgJcze4gpXEGRfPQ0l01v8pKmWU0QBkMEM/sCrzvZ9Mm9FIx1XMXpNgwICR30SGoe63lOq3ZHL/U1f0mhQqZhLJURjGd5sO62O9sB9nGcxM3nz/isANG9eeDbwMGWU62iKHMbjHjL+4uz8E2zwHLUug0S7k4kapNXm/DOzDfQlLiqaVdhYIwR2hlgV2UiUmHUXM64nU/MJvjbgXlW4YiCzwmAsFp3nVctTpvLzvJaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk4VjtvDCF0QsEnhM2S/wHwXAEPyy6C7bFQYJf8uwOM=;
 b=Mdv+ULcsSrMQD0BaEPAgHdo1lmu4TUrf8HKTCT5ci/GbsBP1oqUhCCvyl6wI/vF051KZ8xp623eW1kmocPi17030pVznm1WGgwqXOJDt7YasT138BFfItPGN9S8Dje/ih+NjgL8RTGjzwpR8aOAUCU6HFcQersPwRXf4X+O+tgqfVH575pnm3Aj6qMkp4L4TLcOr/TEVpMYxkRBWE15mU5/AJFgY2ea240pG3p71x0OU4ZaeNSnn7qRIbh10aJvo/X5iDwxytQTRX7FvuiuTJfjy/uYO37emLX4asyJSjUoFpUCE+lm8Uf8aW7ht5UZn+oHE58ERmKJdJCy2Z+J/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk4VjtvDCF0QsEnhM2S/wHwXAEPyy6C7bFQYJf8uwOM=;
 b=d7YWnRhSiRfmh+E//ckgqmQEEtL8ZLx0a3ClyY41/nyoORcG+vddjDIuwKAqwVCJGqs9jetaEY824mur8MxtUikHwn7aH9X7rzh3BD3WgAaa7LDt8BungxBa05k1dtsRS3QHIMj4uz9q1KOc1js1dtd719cWE+v4vV02+ZcEtVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6984.eurprd04.prod.outlook.com (2603:10a6:20b:de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 07:33:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:33:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xiaoning.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: lpspi: add dmas property
Date:   Fri, 12 Aug 2022 15:34:51 +0800
Message-Id: <20220812073452.45763-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f84868-930c-4ed4-e32b-08da7c34e903
X-MS-TrafficTypeDiagnostic: AM7PR04MB6984:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /djXMZ41hiqv6Sy80BCJD+/OPp3bKIDoDiWUqFeCmufbJ04YVpK5044XzzPKIAVOz7Bs3dixiNbuus+BxzSdifHGFYWeJv1plWVEndIuGYhSUFqxAg2epc+FL59XF1Mi5dPhl2W/L0A2tTayCdY797EB7Wm9024B0j8FWQWtgjBQ4KoyDJyuE1s/QZU46uYGQjU3FsMzLi/Nwcx/OeTmMLujkx8Ns+J4amIM4Jm9KBi/XWHn5Q1uf+lRRQwvR1vr0cJ2czgKzWbh8ZRCOuUOIRUaQHOAYz3Oq8ncXb0z96BXiv50BV2ZhoxbGQMnooVw3J7jRMh8Eu1RtaBLfGSMe4dWd1wL/Ux13bXdZwsvBYSPzWlGGhSHtwBF4FT+9aZTE5MFlZjFw5Qe7Pw9R85h9saqwUVvakQKZ87HDCyHyEBp5OT2WhCcrxJuUAjsa1j80qNT7BbaMepW6qCjsQBqxUJH0afmybDGG8RHb6QXs+apkY8E/QTWoABK8hVTjGZGqPDUmKcMDsoc9csrXD6LfGcHDgZp8mf9AFB/8R7t067haGeeVCYTz4TjDg6KQ7eY7uGYxFzor6DX3A1lGDb8jCsan/y2fkAJfnFXtGcVDbKE+PJhXDKsO68Kbg0j/5KzOYYkH0xdjMAw+BkQz7hYFviP3RBVodhKuSiKBRDp1pAjwx98Me86QX/NVhmLqEiwEj7MSTOypBeOfEah0NR9fmAv81qomBLxHENxuDskh5et2Gtd8l+/JJE0hTPkGQp7AcwhlkUfQJnSzq2SiaOt/66nWE51RZ+ePCRs3OqbQrQTlZ0MIln8dq7IqDI7dAwE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(41300700001)(2616005)(52116002)(6512007)(26005)(1076003)(6666004)(6506007)(316002)(86362001)(6486002)(186003)(38100700002)(38350700002)(478600001)(5660300002)(8936002)(66556008)(66476007)(66946007)(8676002)(4326008)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qHv9IozQdg+ngyY+pVdm+34X5dSoe+Pui3okmPzOne2O9Rhz7BgutzkCQjiY?=
 =?us-ascii?Q?oBiUwhTB3YKZ6kG8YyyJfMZCATx1yT9g9bbOSaWYkGF8G9l6YJbH84s0F5d3?=
 =?us-ascii?Q?qX6uTPt/8rxyt2nQJQXeFIMnxOEZkS7IEpeodOOC/9B4s6fk13g/vCuiw2eY?=
 =?us-ascii?Q?pLIhlBRjFwc+S1KJwyOjhkcqVVQwXM2z5Ky+vgK4szzxjuVQYyXPK4To3MKJ?=
 =?us-ascii?Q?vIwKOg2B++7lkOerfDhKn19a14fYbv3l2FqJ+47STOezTS70NUcqqr6+IVc9?=
 =?us-ascii?Q?2TwaDh8bCx4rGtV7t4aVlLblA0yn6s6TAnVdkD0iInVAVpW/eG2F1/p9lR2o?=
 =?us-ascii?Q?VfsUH+sH8bvZ67oBEf0ms8o90v+huCfYCfUTcE1pBDWCzl5w0nY1s7JNtIHp?=
 =?us-ascii?Q?4tWr9xxj8aCAWf1MniiKaz6RQK0kSQ4GjYLxF2+eS+oExDZqzn8xZIr8WSha?=
 =?us-ascii?Q?krj1Gsy+DxlLe/2ICeAUn84PtaVA31iHTpOnQddj6ZrbwY1MFlnH+uev78ij?=
 =?us-ascii?Q?k/1Z7yJLL8lIOI20BJKoXYPwoPhAYIUt4lytxssauccutIueVSUEE683wFTa?=
 =?us-ascii?Q?leG9cV5U1birnW81uDkU5h2O6vplOiM9oNb/iEvV3mKtPqVk9nwy+DwEob65?=
 =?us-ascii?Q?lDkzp7yYbSdFpiKFF5KpGKMOdiYdp4VZ4s7gPYtkjzlTC2i7YzzaEQCihJkE?=
 =?us-ascii?Q?G2bDnRYfoBNy+XZ6oYNog7KmU4sHgutGx2Yn7tKCSLQI7/IPAIZGFv48PGa/?=
 =?us-ascii?Q?cFiUEjT/TPjG7q8qYOXI8HmvZXgWu2fucRD16AMVqoHD53mAnv5AA82qKt5g?=
 =?us-ascii?Q?H4FpxVDMnFQIElTKpvXYhlNm55KAUd1Qn3/J26vsgmrBhsZJRb2g3/DqQIye?=
 =?us-ascii?Q?oVI3CNn/5+qkjZm7+i9zJ7ejY05HWu19x2DE8BI2HqTpPKinos59FwB/b8mt?=
 =?us-ascii?Q?f3mE82WRV1Z7cF7EZXRCYoSZ0kLEcQW6eqhfASWT1D/Lvwjlbke1P+2uxlT4?=
 =?us-ascii?Q?+0DNJaU4+6ldm26U6NQ8FgiX0ZbuFFXQXa+rVWuUBbSpOvw8Bqw8LxiU3LTi?=
 =?us-ascii?Q?lV60H7hFu01KK9hfGYA1HMo9MRyEr8j/ZKD7wWZOVSbVhyv8NakCqm9aX/ZZ?=
 =?us-ascii?Q?xRbPgmcZ4N+NNNYnpBHwoDvLpQA2c66HshJ5LTI8mnqNl1m5IF+Fartrryxe?=
 =?us-ascii?Q?7l8/HN88h/HsHCS6UDtHK6qrzQvAZJQPaH+aJZGNuTJ9yyZiE87F2ysfDhmx?=
 =?us-ascii?Q?j+ABaX5C18xAsDXTBRwa60VnbrhDKX6Kw6VSxo2zNA6d9dSlOtPw0mDHeEcB?=
 =?us-ascii?Q?e/RNCEnAnHXWJ2Wy43sdY9/6KKeweCW66PHg8VTRaExC3ajFbrTLeXNhqGjU?=
 =?us-ascii?Q?CLpRNHJpXmFo5Kih5mNtrLKozcb8WxL3tCrI9uyQkrO0169bQ+yCRBoFZ1RC?=
 =?us-ascii?Q?Oa7AgoH69BRGeZwwRh0QdMWYmYX8v1VkXSuqKpo8RLOR+qqUcKVs5+iqvXPU?=
 =?us-ascii?Q?CAbmgBmu4YVgulqGaf6end7nfzCSozVZIdEN+1cz0O9f+0bZoB8X5BWYCrbZ?=
 =?us-ascii?Q?3vpcAUtAGWLVvrf0Xtqrk1nmYu4j5iTJWxhwdhim?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f84868-930c-4ed4-e32b-08da7c34e903
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:33:11.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC2rrAPstbqSRJpXcR2ACVATKK8GZ9jXOPXs1u+x0xXGKDAmL3nJe034XhswvI+iq7LKuKsMiS3/FrooHYLXJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6984
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The LPSPI has dma capability, so add dma property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index 1d46877fe46a..f60b24a9a32d 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -37,6 +37,16 @@ properties:
       - const: per
       - const: ipg
 
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   fsl,spi-only-use-cs1-sel:
     description:
       spi common code does not support use of CS signals discontinuously.
-- 
2.37.1

