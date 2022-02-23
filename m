Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF004C089B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiBWCdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiBWCce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:32:34 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584275A082;
        Tue, 22 Feb 2022 18:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHOAlvi6pJ2N/II+4wJ17BThzhlH0xTaPwuyun9lstrndorrxzGemPR70vs4/YhI5sgK5IB/B/OdEiSW1C78ZiMIMJX5wVkPMff2KzTNNSKLPhRmRZkZp/0qb07Js3dzglrl8wwtjDmSqPNNmikZ9LkHNlJkCa+AAZ0XljaWFCN6jp7wTWGIlIW8Y/u+LM/5NY+UHwHSPIK+4ahI7aiwrdFyIFZwQgaIjbB05K/Bdq7+ADZLmQCvFTmPaqCFH/5E0Dw0EgAGI4K6wFABD0hPjjgVfpUpjSA37cR0YNBd+bBSckkvXholErNstJ3eHpT3Yc83YRcF9GIHQ615EV800A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cSOgWSHlQmXfkVxX6zlg3rfq6P32NeWFc3L06O2big=;
 b=ZscCByaJoT92Udy41Iz5H5Rdkm469gLr4NXSQGLNdnEhBj8+N0sVcUvKq8yTx1fcQ9Z2SzzP6goUXwqWeCaCGe6n0v94dGyONYRddnikn4h9PlmyPCff6BVErWOMbnW6UAXBarwyCypGPjGSXK9VOU5V+dEMiHIHX8XZ/Bgu+jgrQDMAqx4gDIWfj0xJrwdsAcjElbp4TDMkac2x3lj2N2NyGAYNFrbSUfL4x6RjKQu5Lxqdh3nxsPg3YdMIBHSlYnfwCbKBJP8Xs08eKLD1u7WxGzHAOO9ClelwjpqDo0MK3Loq92M8rBvX227I+eVP+RIknK1I4hk13SEYQpVM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cSOgWSHlQmXfkVxX6zlg3rfq6P32NeWFc3L06O2big=;
 b=TwYqhWEajKsaJYOU0o0LZ+byTZznPk5/Wd4T5BVdWlhm//G6UgFQWDyfuowtRdkGT2r6UPSY9YrZfTZxDWKfnYeH7yYQdqJH6sBoysQTR7CW81nuHl/vKmd4VldmcFMceSb2v+sC5IxToPy64SpcFx6z/fdf9H8eG95VGpcunRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7311.eurprd04.prod.outlook.com (2603:10a6:800:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 02:30:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 02:30:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
Date:   Wed, 23 Feb 2022 10:31:54 +0800
Message-Id: <20220223023157.3478540-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a38ef997-8bce-4071-e2e4-08d9f6746e98
X-MS-TrafficTypeDiagnostic: VE1PR04MB7311:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB73111332DB7101CA2CC5FD47C93C9@VE1PR04MB7311.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjGu5Uy8Cf4c41XPJM5tx1NiWpILtm7NdtRaw08X51tMB3xWStvnNLJ4fnbjSDTttxIVP8bJf3RQ7eklXpNpfTXcFjXSNj5m4lf5umg1Dk2ZZTMbVnfSXNGnGidnzg1qvVmTibaZGxLGtjvZcQO+yX/Q0oqzm6I2p4vWCG1G552M4x/pGuoB/ZNd2xEsghcGaQV7KU5bulQ0rvxrtstiDdUbAdvCXhx5PZX20eQ9ZgXJs9kp0l7bdHmcbdrEy/lB8PLRMEgS8ryN83orq5lmYlX1n7zmWtjyYdxYTAsAZVUv8ehQG1L9ujoUjUeyvJfGHDg+PfTN18xPFKbfLoKixmyT7I68e4kYjsV5cz6nLKczcpB9z5+IoUWoWOXGtBvPsUqFUDbbwVtbzL4qW5ibkuTfgxaA7ITEDKMTYayIoA15KFF1cZgYeU08FIkEXZWMJ7cpV/YqoVNhThzUIURee/eQATRHp9J/04rVguO+y4kEGo0HbTFzwaQLMj+M6bo9ybckgmmzJPioGEWQTHX+mOY9q7R24lX5PZY6iQsmkLRMOazSiRmq3Ox8JcVlWLLaEIw4nmq3u9sNVZY8fGhvtndGWfT+KBvZNywrwu1q0kqszp3DFtjM2LMbsR08iXHu+Yr04Tf45SY211YS7jh/TB9O4VCyrhaDAaVtobS2phlwkVXt4IWTBTaKpHs6t8iP10rksYfySMeu1GyPOWlDRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(316002)(86362001)(26005)(2616005)(186003)(1076003)(38100700002)(38350700002)(83380400001)(508600001)(52116002)(6666004)(6512007)(6506007)(8936002)(5660300002)(8676002)(15650500001)(66476007)(4326008)(66556008)(2906002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GqyCW04mEb8X1UGv9e9nwh2MFVPznV9ORLwiG980VcMVyblOAirms3ghr+L8?=
 =?us-ascii?Q?MfoU8nh36A2QEiDmIOkOQaR3mZCaAad8POk68OQ4w2NPigjNrFqKqxMYZtNu?=
 =?us-ascii?Q?Bho/n8ORawZCgXY3fZOGq8zmSj8acYZu8la5N7alRAJ6iCfsAQGKXZU5WY2R?=
 =?us-ascii?Q?1WqYsTAym/KO2p9zN4gDnq9dzGmmfBtIBV94ZHst1Z88y0lq+FEkQiEypaSS?=
 =?us-ascii?Q?YP/ucJ5s9J9b01gNLuS7fYMXApZfaU4vGHMrjk2RkIrDr5tanbdK5lvf4iAV?=
 =?us-ascii?Q?v4TChVAds4fblUhPHKJ8suwvLTUAWgjV7PeGrXhkM0fQHrdK6Rklmd5QiG/3?=
 =?us-ascii?Q?PSmMUhLj4bDv/wFuLxlUym9xjj6YnE/PVrXfvDW7UDzw0G2z5hMj45F1kXIQ?=
 =?us-ascii?Q?2NNqrp9n0wymvFo2lf7EHBS14BoUTL3kIdLVcrhCymwTfk0iSW5XWIWOfrEG?=
 =?us-ascii?Q?pq7EO/aIUEHwm0nlE/NtK4PEm5LCjyUcNKxc0fIu7UVr49nVAup59W3e/VI2?=
 =?us-ascii?Q?7cukt53Jt3KggOcljrhBDei3gkb/D9aV+CW7ygcdWshiD/rHjZZU6EnB0M8n?=
 =?us-ascii?Q?WdryRNuA4d8Im+QieTY+ruzbVSu3z2Lhs11W6dEEeziITo0BFcLPgHF3Wj92?=
 =?us-ascii?Q?OTmSw7Vk+PSyrvmzj/jjCNOIs58pB/9FaYbt9Lm822VaoMdyC6kOWJLSMx49?=
 =?us-ascii?Q?r2V2ZF6XfSDbKWMs4CTh6pqnjd7jxVeoxr8cfm92F9pbFN2dJEkJNS1QAtcT?=
 =?us-ascii?Q?GUku8CqgW7ui8NkFL7QssjbduUDny4os+Px/cdk4aEOhelJpe/funohMJ188?=
 =?us-ascii?Q?eRenCJfcqeMz09CWa2+cjmc5bzLMWiSkfJAwVK/SvtslDzFTIUFNy2DfjUpB?=
 =?us-ascii?Q?g8lwdC6gThoYr6MHFnTv5sPDNwVf9sePadI4HajKS4A2pfCqEqmJykDtEki9?=
 =?us-ascii?Q?wEGJkEHk30P2E6WjF5vS9LVON4DjVc8A98iwZKF8ucKGiIGjuFUWTEBXBdLd?=
 =?us-ascii?Q?fZrCm72vNYSTQtqybVrdHRXbIkOsFatwd4ZNItlPWYbIX+1qK+8iHUgD4ws7?=
 =?us-ascii?Q?u7sZlIeu758vot2OIqXXKujOK/3RESE5bFZG8/WhJ+7iLLjq4urcbrvAEg04?=
 =?us-ascii?Q?uDrtwGcZJw28gWHIK7y71apWCYU3smnRnQmLCExYOJXu2weE+co5+MZjihjJ?=
 =?us-ascii?Q?qDPC9UPKwanFrA5621BYVUKFA4u3OH7mu8T6+nW1NtWrv6l7NjhGhESYE+tC?=
 =?us-ascii?Q?uYHm9evjx9RHUjJ9zOf1nvohMU/aYSayTwJno5/uSfNc1CQ3Hgw7AFtlGcif?=
 =?us-ascii?Q?hhTnyYAipk50dh6vnmdbuslhkxj7ERMgyWvKeciar+12zDErhlGctKGSVf2k?=
 =?us-ascii?Q?/s7bmdrQYo2YkZrj+n8LTN4jmMAgNXOkhXgR2UG1+SzUUgzzDq87nO3LVCtM?=
 =?us-ascii?Q?uMzUyNoIqdxi9WhMe6PK46qo0+5hUHCFRbkRtWVv9kf9T9Vqhzx9VROQG7Ok?=
 =?us-ascii?Q?ZRHaQZg5RSAuWSn3B4ILoUouKExtBrF8lXeAM4YvYHfoljJdWs2XU0EskXII?=
 =?us-ascii?Q?o/JmusXm8hu4W7qJ3mKff8Ci1NVa//Z3Dn4LfbP7kWCOKgpg6rQXU6o3EZUA?=
 =?us-ascii?Q?LuHO7D2nDxPESQxzrlWMNRE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38ef997-8bce-4071-e2e4-08d9f6746e98
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:30:18.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDuOiteh7cbaFBLxJS/wFkwqA3DgJmlvpV1hKteB1LZ2MlF9n/Dt0Y+Au97Ua94vOg+Xy/WrBXxBM0QxTk7aWw==
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

Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
between Sentinel and Cortex-A cores from hardware design, it could not be
reused for other purpose.

However i.MX93 S4 MU use separate tx/rx interrupt, so update
interrupts and add interrupt-names property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 6d056d5e16bf..f5f9d501845d 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,6 +29,7 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
+      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
       - items:
           - const: fsl,imx93-mu
@@ -55,7 +56,13 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: tx
+      - const: rx
 
   "#mbox-cells":
     description: |
@@ -90,6 +97,24 @@ required:
   - interrupts
   - "#mbox-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx93-mu-s4
+    then:
+      properties:
+        interrupt-names:
+          minItems: 2
+        interrupts:
+          maxItems: 2
+
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

