Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F99B4C25D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiBXIVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiBXIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:21:44 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E026A38A;
        Thu, 24 Feb 2022 00:21:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ8d2dnySvIFkND1V4wouvcPIy9XCZJgxd1nwmgWUCMV21ce4L8HHiK/lgF7GeS4xN/ymAtqorTwZTOKg/6j07TysHvYJeDJ0uyrYPu2BxCM+hd8eL+qIb2S2eYv4ESYZ+GYjtazensx01fQu9g76F52gN4dpeUfdJ/msqvAfPRiLbZ+dyDNkNibb5qOx19feLy0iKzLZYbosTOycjfW7qZNSIXaqgItmHTKu3h5itVjy/3B7tLfJK13htJVPg8JIH/nb8TjYUI4iHC5SuCptPAAmTZBqcWdgxAStyVfd68a4GVYBvTzccn0r+3kF6cruLwWdmOeo5MM1MUfu0yEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7zgJYGQYaC/+1Q4SBdqjJt3E39U66YIS5W1o+q794o=;
 b=aMzzZHcQhFepDVSW4wTq9aZ4TpTk9YpYLdg/rafj0P6+aKVZUfBaFVRnzCXchf88P1CpgPj8XTiuz+CXyPoxzNBaU2vGuGrPh28OFjmdjpB9JmND7tvANkM5Pph6h8QXaUeLwKRh+iy7Sw8zvtckKqCx45SqY4ehgdBNffPpLCp+XyZufi4qsVXKx5k4WbuDHOy/xHm2uU/uk5q3pQOyJNUMEyhkDgxGCUBYmW0H+DLfb+7CcJwBWNXn934vazkP3EtaVvg87KZTd3ORm0M5besmVKD6YmhwloG0YPnxN8NfMVhZ0jelAJVRdFqJFJS6auAekOSevP/ImBHSOBohEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7zgJYGQYaC/+1Q4SBdqjJt3E39U66YIS5W1o+q794o=;
 b=e0bIBiAhCJkIFYoIxICRJYSVgY0rPyZeYmdszM6ckLuUrRwHRDIlsuJf1+3x8iAdFmuiRYVq1rL4svBlRzG9tF49VaxzfYS+aLn5/IH+VXsX81zAWd3q/Dj4jTvGEcuUTyxl6kmL0qIyY4vfAyKVUsyJnexERWRC4+e0rTGWuiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6423.eurprd04.prod.outlook.com (2603:10a6:20b:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 08:21:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 08:21:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/5] dt-bindings: clock: Add imx93 clock support
Date:   Thu, 24 Feb 2022 16:22:47 +0800
Message-Id: <20220224082251.1397754-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
References: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0147.apcprd06.prod.outlook.com
 (2603:1096:1:1f::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 514463f5-7a5b-4b7e-facc-08d9f76e9e6e
X-MS-TrafficTypeDiagnostic: AM6PR04MB6423:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB642389FA744CAEEDB5895772C93D9@AM6PR04MB6423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8/GYY+nPIMO4N2gIx9QA+fsUSqxcle91ZMKD2kXALt6F2aOP2xagKin42yU8iP2lJEEIsNBzTjjYBUmWEabh8hYOT3LRsKrgPOYF6N2kDVqJp0oZpZvhXXYSMlL+QJREcdogs6lNXX5g+hHYc6q4jy8Pkj91w4oozLMeud+jhKzBOzPStbVVi9EehqYvfjIrNfPQTeUtmPkiw5F+O8TAxh7NEi6bHRw1EHHiL8tIBMuQiQ/JpFKIrr9mZ2gzXlLhsCB3XVTUhZ5qRUHjV3JnqZvDddpIP3aTnZ9furZ2EUNy+QZIjWN8ks1UKKp4oHrzh/Bi1sXOT+sLuIR4P+odAevLHXaDDIaQeN3yzIGF71xIGZc7EM9HZuekku4fwq+oHIXBn8FDjy4gbcuVtEDLJiebhvPfJYGZZ0+gQtIrHJYKDzj/hw9uldkykBTTUbpj7TpeDqivMSCoB3z13FSQrWnpHd77gjiGpb6VCFlqSqn605CWYGV7OFV4+APeIvpYzmqfwLEgwdj28snpZPjdtcwOl5XgsmLncLu8E7+UE7OOAEAAPRcjgX++vFlHHefVPkcihCFpjTsPeeZb8TYtPsmmpG3E3dOpkn7xWvlJ/KqHeXJPaMhZ+LI22wPfzMnW6vTbsvcVTQtytAcRNh5oA+J5ifsiib/V6eHdn8UTJOFf1xJwHnruTGBtx1drAdY/WNpkH+oaAy9QX2jhX5LTeQ/M+5Yjyy07JePfQV6BLuTDesN6AAptH+rK8ej0duwePOdj1wYfCHP3OQWKRWZ1ANBaFX8cTAeV9c3hIMqpYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(1076003)(6486002)(966005)(186003)(5660300002)(508600001)(6666004)(4326008)(26005)(6512007)(8676002)(7416002)(6506007)(52116002)(8936002)(66476007)(38350700002)(38100700002)(2616005)(86362001)(2906002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWNJvcVf0vOZ3ysowYoNmd7OHN+5bwT00pBgk0txmY17BaGyZAGX0eaJeDm4?=
 =?us-ascii?Q?L0wCQOgycQDi+YKztJM754/0tiWdvVoTqO6xfRHp8+maUIppGquZ50NNz+yU?=
 =?us-ascii?Q?3dRfUmdFq0jvCTCloeey14rZucRfbjepDCUbPd/gJB+cgpA7el2zoUtzLwxp?=
 =?us-ascii?Q?9KuIPBSosclX3xAfB/oBnmlVrwq8tmtlhyXvNu9iman/+qoioU5kG63XQ6FY?=
 =?us-ascii?Q?q2tfnnzQJVNsAyUJ8MLe6i92SXWJEuOCCZsg0H7NIWukPXmIklJnoTrYEaGe?=
 =?us-ascii?Q?m0Obmxh6GLMs2XFWxdZ9qiflWTLL6tXFtQG+nkEzi1eN0G/H/AiY/XTefhav?=
 =?us-ascii?Q?B/6PGMpzAEmnHaRPltyHrMu8YZL7fKzx76RWNidkah2vKMwkeZLg2fo4pLyt?=
 =?us-ascii?Q?5MTfewNIrCfuDjEfENt3oBbDHCboZoc8VhETEc7Bo7NqOlDTrHeYIvpqKmB0?=
 =?us-ascii?Q?sV3aQUzxwvAJhxwMgUAtol/e45fsPZ2l/m7YHDlOw2q/aKWMYEiprVEJ40g+?=
 =?us-ascii?Q?q3PWg/QDJwArRvTyduQistv3Z4Gg6iea5kjSTWwSK/U9M7c5lBdXH8pYCk/E?=
 =?us-ascii?Q?NTpMyq44YocLvjmiz2jLjVEJQAyXA3Wsxm8bEWZfPuhqsD7zK+xg9FMPJfV9?=
 =?us-ascii?Q?bqtLyNU0YbMogTDWKQfQY873OhInuLy2pHzNmTIZE8vJ89mONJDBy7E+3Sl6?=
 =?us-ascii?Q?RjSFdoq0OP1ha2R0OtCmbJS8EeCyOCxyO9mF0aszvAQb8tgU+5nK7UR8yJe4?=
 =?us-ascii?Q?S4B6oPxezh43txVxwPQa16Z/W2FVp5i+SGxgrNTU8rv+g7MG4Z04CRVzJUej?=
 =?us-ascii?Q?5WOi36EAIfEZQDvetGpF+oBM8s6WU6+jnuaKniF4l1h2z1sF9GbDwvRYkLJM?=
 =?us-ascii?Q?H01cYP8MGrir1Pq7tySDUNth37bUEENfrgwuPY5IxkV3ofh3FNt0dRiKhLFz?=
 =?us-ascii?Q?gS6/ChA0SlbQ5VFTIaxHBZR+Z0ww7WHtYX6qejS9CCvu5j+RCRvTufdrJZOw?=
 =?us-ascii?Q?8Wo9jXbuEvWav8RVe5eh3C5wWYGPQhcvKQ3COCjj02cT7bK2VkLpPAv5g+aH?=
 =?us-ascii?Q?KyFb3XvIu+IBAuDTvtu15nm43xsop9mSBMfUFiV3kCpkpiZ2dmrOfpHr0ZXF?=
 =?us-ascii?Q?ilWvyydEXFOVBF5KmKuXxHnlYNWX93/0G5J4/Q6OsoO6CgbzbNBVYEFXDlK/?=
 =?us-ascii?Q?iyac63I/XxRoUB6TOnsk87mfiAgxEhv/fzjQdMjfeqeJhLQUzNfN3+SjdNrt?=
 =?us-ascii?Q?L+KZrOO1YrzGEOsucnC35eL8yrc8aoSCyuYdkHZ+ug6Gsx7Un1C77GCXFFLp?=
 =?us-ascii?Q?a67ZlXM4is2f8xjXwbwfRoRzAYhgbzOAEvQHryvSXR1Bz8XdRfzhiIBUlV/4?=
 =?us-ascii?Q?FpgAFSPi6k//2WUBHd2gDfkUVCHfxFywdYMjEdZaXPG8ZHlcPhrQe2sAGfTs?=
 =?us-ascii?Q?H3HMRA9XhReOwt5e6GJ+hMNG/gKlVbGWsj+9bpaFamBYzhV7VcH4xly1f4Le?=
 =?us-ascii?Q?HPm5ID9omVdvScg96+Wvr/nxwIaUYVzWZSmpmOen8Tw5+MOzyOrt0NaZILqD?=
 =?us-ascii?Q?Hyp1vPPpMpR7fNJ2qKNk9edYF2LZzPElGqLlVn5fHC1L0m4wIFZ89sv16Wfx?=
 =?us-ascii?Q?8a3IHKwkD602FCI/CYXZJKY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514463f5-7a5b-4b7e-facc-08d9f76e9e6e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 08:21:12.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSqOWfX3qfqdkw5e7KCOtJkeu61/03Y7BGk2M/3JGZFQGSwjui0ZHAQgjkxjYVVbKPG7ho52457/1sEtz4LmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6423
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the clock dt-binding file for i.MX93.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/imx93-clock.yaml           | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
new file mode 100644
index 000000000000..21a06194e4a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx93-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Clock Control Module Binding
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  i.MX93 clock control module is an integrated clock controller, which
+  includes clock generator, clock gate and supplies to all modules.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx93-ccm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      specify the external clocks used by the CCM module.
+    items:
+      - description: 32k osc
+      - description: 24m osc
+      - description: ext1 clock input
+
+  clock-names:
+    description:
+      specify the external clocks names used by the CCM module.
+    items:
+      - const: osc_32k
+      - const: osc_24m
+      - const: clk_ext1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See include/dt-bindings/clock/imx93-clock.h for the full list of
+      i.MX93 clock IDs.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    clock-controller@44450000 {
+        compatible = "fsl,imx93-ccm";
+        reg = <0x44450000 0x10000>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
2.25.1

