Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5842E4C60C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiB1CIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiB1CIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:08:04 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CDAF58;
        Sun, 27 Feb 2022 18:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PymE8mMxpQYNfPWQj/x0A8P+Yr8qEWz8/WgGdJsdWBMJDRr3rv822Jv3AH16jlEm6RpNuRdrpVzYFaAyXbHXvMDSkuoeFAQcYvi21IygkMKEqXo1rv7pEfWyOhwyLlpgbS91Qe57JSHBXtSSLXyS8KTDbNHvigkCpUR5zio0HClpvXdxRiEHSIu9TulrBtVf8uGy1VH9+ZQqXN7jHT2cxRD/XM8K0LH/03O0TRbXfU1BIap7fPvROX7e3UjsOpCfq/JdY7mj3nb4ZSHrVH68ZcE0Oq8tuMdxbXfDalSJE+OR2Kf9Tqn+UiVklqsK148xo5NjthyGC/P7aKS2vpEU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfxoNE7z6Hyi+Q3mn76fncy6hzarE1sT1es6AX49ELU=;
 b=Jc6AZVtwx6tDQo7ecScMF1Y1qOU4d/xSWg0Wm3QpYV9G1C1bohxeebq04X5o1gH5bG6+zMvmY2GNuT0Jdkx+pK1szX77n/XCtj2O6Nm6OZwNnTbTMUQ8KKr3ZdWDPIyWWwwTkXqMnEimU0wj0qZECzuk33ZPG7jjptqLjj+BIJmvCbwq9GScrhHYMNZbidCo2dVMsj76kE9WzSKlSwb5adwtJ62VIbxe0ac7J8X9UxX4XLFomLTFu12UV8nW3+l6ZoKxzflKqy8PkhsVD6tAQwxUi33n35FmbqUEImiD7VM8lBHoyeqBschqeGxA88+vn+9VRp+d3Gtiay/tcKM0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfxoNE7z6Hyi+Q3mn76fncy6hzarE1sT1es6AX49ELU=;
 b=UFPx/2G6dMXGqg67Gwngl9cTEcgZF+n4dI1N7RX3BIr8epRe6xZfW1+FfG37gfkVrieYTyCuc39AyKWJRscAzDvUvSiM9t2BCgVdpXEpaRR9R52+NeHcgrmLlv7VXkK1xKIsLv77sMW22WNisYwrPeDRGKE2+VcVS7HJNZWoFjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:07:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:07:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V6 1/5] dt-bindings: clock: Add imx93 clock support
Date:   Mon, 28 Feb 2022 10:09:04 +0800
Message-Id: <20220228020908.2810346-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
References: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8643bd6e-3b2a-4da1-d13c-08d9fa5f0dbe
X-MS-TrafficTypeDiagnostic: PAXPR04MB8734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8734B63663646E2BDED773CDC9019@PAXPR04MB8734.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0GyO3v6y+lZIKnlhoouXaYB66CFAiPSm3iH4jQUQ/s8NqbUAXOKTSlDR/Y6t/MEOWCdnlDLhaqCl04T42Ysi2UJUJ3K1Os8E9vUw0otNxQPSTskKMa56n4DoVE5kzwZRlkBJrhzu1gVlDhpVyzrSIljwaFbeMztDqF7XVjK5dbctP9JtYSLTPsj0mMWcaabpWR0ng4Gd86kou/XNERd62kun5hEOXquK7HHmLjU6FP13NJsxQiE+R6xKKyJ50GlEQDn1V4wnWotf60QOe2CKZyqPDqK5bJEUFl5nmurAB6t78G91FdOI6+C3vIEPaiTpuaV6tdcapucMZBFWxlmPiKDQkKrDb26PCSIUuYqoFFO506KJ37OYFrJfCik0oqpLC9DgUbl6Jppv9QMSTQc9+NjNQUEQ92VoGaEoc8EyxoaSCK6Um0T3cR/L8Gl4NGWCsHKSVxCWz1BUaLdgJ7eDm8C5k9wSQ85WNNZmJAN76vRoGlL/ScP4Akg5+EKQAw6NAxXkTbQeDE/w+5wg8+BvA3Wm76Cs4vCIGXaEt+hsk0/0RbnWB+u/ObNtO1xl3gEm5lepjvbMJXCgFr0337QarbHp+CMY+uWfEECU7jxvVqkfjhN+m65O4X0/EuivPiT/f8LIqPxzgqudR06wqdzqQuhGoo1JNAy1pjePBBZsDGN0ekm16QwUd1w49mPf0IME2tkMqtS0vH2A7n2abKu555HsHVvjokCUamMwCUFtSd6d/BQ3VG07JVLAgpOGNqtiG8LnFaZxd7YwPamFKsEACQ165WTq1rMrkh/PWc0vf90cA0hbZNUObKlHrhCPv9ekMagwfOZQ4l0yuHb/beg0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(66946007)(7416002)(66556008)(1076003)(86362001)(83380400001)(4326008)(8936002)(508600001)(186003)(26005)(966005)(6486002)(6506007)(52116002)(8676002)(6666004)(38100700002)(38350700002)(316002)(2906002)(54906003)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MXKIv06x9515GqpPCGbcIlvG9wFuESOlfQt8r7RFwkis4lPhSR68tEjbj7OL?=
 =?us-ascii?Q?5+a4f6XUWFo05Tssy9OJvuU/s8LkcLkPT3GBbinx87EBXy4zxa8q5+LxG/WK?=
 =?us-ascii?Q?H9pXFpJWD19jAhqkC1cL+9fr8vEb7EA7POPhEaivQMf2WI9Ea8cS3ZnQlnMA?=
 =?us-ascii?Q?PGeHwYnPBfdiaTwp7BulN4vAQ0tDV2uRH2F+VizkZX8q0XaTW0KwzyeVt9KJ?=
 =?us-ascii?Q?pDghVVr0B9Cl20dRs8dfo8R8lThd1cG41+3fLEQlltwndS27MVZodXojBSSB?=
 =?us-ascii?Q?MAVT9i7Q89HFKxhRHXAUBvFWnn+2aWCYM3h+GMmONtTZJ1FDhBuzmkYVAf37?=
 =?us-ascii?Q?9x40gLlRJseIFgncJZpBJiFY8/2pYAV68+DS3/WUHI5+2uhxoNt6ltywthZ1?=
 =?us-ascii?Q?kmJUzPKTnrrFelKMFrqPOcpouCydEs1ADBLCI8Wo7uwTsZrz26IWh5IGnm6v?=
 =?us-ascii?Q?t7zQ9KxZ006t2/eRJjBgjRbPW3ozL5sSh287I3kCK1dK6N2iFnHKQgHGui8O?=
 =?us-ascii?Q?qzHLk7IOg4lSyqUOizUETucde7+PqOEfzUz96l14hKGQ6fQwduL7yA0o/UJA?=
 =?us-ascii?Q?yD3pknErnFtRkoR+KtV1Ggu6IDA+JqBQPGmigBifyVLw2QguH7jz9qyyO3u8?=
 =?us-ascii?Q?81btEUa7zBEBUVz/YdQvDrRgIcD2xOigpFTiuVfzEwNPaakKx3Fnqxga3a1d?=
 =?us-ascii?Q?dacIPDA4LQASVkxHKfNwxu8it2KOIgX7bGBE5U1NAhis6JEWeGKNLJneUuOT?=
 =?us-ascii?Q?PZLuUBiQesnJewo8IcJ+6zCp/rtbT2bDcbtvA6JCbY6AO0qFSrP5O5uSKr9B?=
 =?us-ascii?Q?9godsMbIrfmM9Uvs1yEf3C1Ei7jXgJU0Ze5W42QxZfFcU5AitYc5Z6MgGU/9?=
 =?us-ascii?Q?pud2AsKU/NMt3qy4usPNde2vkiLUHHIg0dgXrz31W1JNprx+Wgkjm1GoRkKf?=
 =?us-ascii?Q?vl9gntu15hoKhDsuXeqEOvH7dcHBT7BXy9mRs5N1iPCOUMy5Ww0EdptVd8he?=
 =?us-ascii?Q?0iPMr3JuCVC6LG1xfhYb4X2m+XXfD0G4y7/t8nl0XjCL+xOTrzjJ9ei80To2?=
 =?us-ascii?Q?DuG1awq3ga0dAdRcK/lmPFwvbtCVaYiz9jJe84uIQiGfxf/n7rXf1M0SZPJp?=
 =?us-ascii?Q?0255siWOSa+pNEFaStPJ70NQtftw2MZI97ZB/gWZMhEh+kYDX6XpzhDUTZZ8?=
 =?us-ascii?Q?z1iUkO9K52/k4YY2iWLcaCitDUj/YY78Bewbo/Q1xVIhoe7T+OK75LG0ddng?=
 =?us-ascii?Q?lJbojytrIR67DVTFIWMhjJmh/Qt6/u7YG4N3S1NmUueUcKK1RZPBItXUo4QK?=
 =?us-ascii?Q?4KwmC8nMFvGJcKO4bE3pSyRmNlL2zggmBHPWvslHbUh1P47slKdz5v3y8tkq?=
 =?us-ascii?Q?q54/cziir0l7VqoQrkMzHN52YCh7NEUVDefFxXOi6wmt+Ya+WJtTotioaQsU?=
 =?us-ascii?Q?wLb9uX0b35jGOcum3M8rpOifloJlZLgcWVP+ufd29XKEgtBTu7L6klJjjoYL?=
 =?us-ascii?Q?o8Je4q0anhdyJ9LfFsYlUt/dkEG7PBn+AKp2SWqmKzvzzH70vSpNajEn+Fmf?=
 =?us-ascii?Q?hR0J6hO8ayxHV4gOm2lHrCo4EAx/JbvFEbfhTFh54T8osgdhNpsIUWy6/kCA?=
 =?us-ascii?Q?pMXU6dNecdwGWNT7hyvjSaE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8643bd6e-3b2a-4da1-d13c-08d9fa5f0dbe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:07:21.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPRlHRAaQN+AJzeK//f6w71eD0/s9pRqfArnRMxI9T4xoLkJwntXUhksRHcM9+9n9FpX9UpHABrr0o6QtXAowA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734
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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
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

