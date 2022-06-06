Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5921E53DF7F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352058AbiFFBs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352051AbiFFBs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:48:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB1B4EF55;
        Sun,  5 Jun 2022 18:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXEExAsm6lj0UNbT9i8kNFwNrhdk2wYZBhcvPO4jpCT7mN+ll6lhVaMCup22f58a/T0XNAI7XOluYXK5nADG32wBTI6O7NxIMpHzXspnBDS4gb7cI35QGlxxFdE5ZYh9U6XGaZnjTdaXRUL2QNheUZJFVDAp4ThutZB0reraXDx812pmXUk8j4zaAs5dIsbQs5Rqw3uVj4Z7KOBfIG38N3Vq/23ivgnmZYI22E6h4wHGAmew1DXzEz3KBtIX+CI/Gzhc7eRKXpD9fM0iPA8fqtfw1hABB0vIiN5Bz+YDLZBdQ1/VnjO8fVOltL/KlU0Ray0oC4LTZa9GuSCjDl0rxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64tCl/gvybKf97tOdjZGCJj84QYQelV/iYaYcawaYtw=;
 b=fDZZoF2ucItQrenuCT6fsySCydtgukm5jwRr8N0Sr93CvNEghrs8Zb2/ow7anTDlNclQXIM0I1yzxriLcbLqKp3XNGp/v+ZU1PPhZn9uvX0Cq6EPiOC8QgGoUmuRZzIAn5VqP0ZdnGJHRoEZWB+8pQDKqOFs2h53Gv1LuXyfQJSXKQxtu5u1wsKXKjbcV3iPrRJmc8vRPqK5yzf9UjFMS9072Bx1sAz3uJfTF3H1yBNkXQKpTNHLUM0Cvb9Tj+gG4qOasYpQnxQCsZZW4pmZ8G/vNZwb7RMYkaypETruDHI+b3mi8RsMT9vLF0jIlfgWZ6BKYic1OvJsrwd64wuyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64tCl/gvybKf97tOdjZGCJj84QYQelV/iYaYcawaYtw=;
 b=hmjh1PLXk1rgZAC+IJeoRINOaEH8fbfHucoHaXvmmlzNd88vZZrw/4fAXkh4hNnNAJCNndgi/mHSWPTGbyAanoz2L/vAyFcy/EjduZjLL8zfmvAieSbxPIm46+jI60XbMLebdy5owz4A9lrvrE2SW5H+AlwnUcVp5GDXoC8312o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR04MB4840.eurprd04.prod.outlook.com (2603:10a6:20b:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 01:48:52 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 01:48:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/7] dt-bindings: soc: add i.MX93 SRC
Date:   Mon,  6 Jun 2022 09:50:19 +0800
Message-Id: <20220606015025.180840-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606015025.180840-1-peng.fan@oss.nxp.com>
References: <20220606015025.180840-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2b67d1c-2696-48af-6924-08da475eb400
X-MS-TrafficTypeDiagnostic: AM6PR04MB4840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4840817F6B34E47942D38F64C9A29@AM6PR04MB4840.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0uPWfV/f5rUMoFXd2ZLF66VKpKtRxhdKbCkhDwkjwTchy6LdOvc8HyU7K1ThR1zZeyOTHHsDQrYcSWlzm9oPcyGtwcUtlNQmMxG+MJ/kXI3nEh1iLmpyhlThaywkICH4tqxq35wI2aZ9MXVy03PQig1qAt3vXzUp+XtQybT4kd4scTnsMx3cocPucmZAXRPMHO2gKgVdu3KCDimcDClI0b7mD6mvh7b6opovblk5GqNG2HsGxft3e2oU9/xFtHbtK+ScKZE63J12AyOjtpzm96DzFGrF347gJnicZSnLlRhGXL763c14mxlQryKKFsga6uCTPF3shBlh2gVhk9V1JtUFXJIIqejm12tm+7aK2EW7dUZXdGzSLcrLXr4M8tKXFrVAE2h1ItdPYymlwFyJehQHeeIalzzYuh7qMPWfOt+hL89r79+4ytauP0jM+kXB9S9XmyAi9JEtl6COCpJnOqlXw8pR+lMTjl6+amagp+No5lqPAPgV+bQXBuKzkMquEXxwPB6WhiiWvABtrHj6bIUlFGj07Onj9hq84QXYOSa9cuCdkoLMknTWcVkjtIqSAb9tlzoL06jIy3hDP0QC4+4/Y/ivoQUYEj5QsOlfNhJW8tCNHpcMamLiunXVzoaiFoq5J5p0fX0IV0j1slxeXamRnuMwdRM0MaJcXlhgGqlOMDgBXlr23KXiRsP/h1wSa5KHxK1ZAhmzylU6zRMA1MHEu0+eDl/AHfPEoVZkaHu6HMEdH/P7CGOLhqEzQW33zHB7Xb3+866fei2CWTkJQUt5gr5xCRUAjqNslOrI1g0DITfTyPrWsEjtWVG2h7t8FYNfrRP4j8hV8/Q4WLijg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66946007)(7416002)(66476007)(66556008)(5660300002)(2906002)(8676002)(186003)(316002)(26005)(83380400001)(1076003)(6512007)(508600001)(38100700002)(38350700002)(6506007)(6486002)(52116002)(86362001)(4326008)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2c2ZcfEZBXHBZXq67lXgfM0jTU/jkSlSbojN2lmjdZlQHPACzMgLgOCKzGEz?=
 =?us-ascii?Q?MSPgm5/bZw0qZTziS8mPG3yuqcAZzXZ+gc1ARkiuCLmEyuy9yFJ6i7g+cxHP?=
 =?us-ascii?Q?5V0T0Hv+eHlqpRv8lsOwnf/cimfBW0JBimVmRpOtwDVybtFMSpM8qrGOcf+4?=
 =?us-ascii?Q?xsymXH82bJm7rAyzMnfKF6mAzVVwbY2g+BQPjRVjfhqulN80soj21okM8q0d?=
 =?us-ascii?Q?ffzXYcrkiqE6RaxUCDfqyEgA1b75kNUFI5IxrRnN5mW8+w3dzB3lrkouJxn0?=
 =?us-ascii?Q?c3n90nIEfgMtxIooUxYidRfC9yG6GB3VWNSycpTfNEqNnuwvBPq2tJGCpou3?=
 =?us-ascii?Q?c7DOhrQAK565IsbSyna1ZqQsGIVOlgWSvoNFjiREcwmdHUoHywwU7vvIsu8S?=
 =?us-ascii?Q?7BSuWQrGK8fS7rGhgq+Z+7wdmYuT1Vs/ty+8uUG0+OBH0mO2/wdNp0G0T9YY?=
 =?us-ascii?Q?16h3wUQqoENsCfMasg4j65GZfKxIFQUv444mOZhc58w/CZoHFa9hIugNHHa1?=
 =?us-ascii?Q?UjYhoCavTcUNFQ6zy/NIfjPl3wArCQ8yI/GgReRRO0lVCnYIWxPbgxA9+db2?=
 =?us-ascii?Q?fQDrUeqC6zr0pKpJEy71008i/4k6eTTweilPyIlULmZyMsn2nnllHwsbxIak?=
 =?us-ascii?Q?OHwHUdSWmuZgeUQsRlSm4Dh9YiNiGML5eS6p6LJk5IMBeJENpozOk6SgcyKg?=
 =?us-ascii?Q?uQS5EQYul8+ZCqo8b4yNIEqHKgPDrDBlkqsMSpwj8Xs1wud+gR8nCkVLXz1z?=
 =?us-ascii?Q?OmlRJj4YxPbY+BSXkK3PlxageGEGuYvhv2UCXcVc5x2lAK7bLNhZFRrjyvop?=
 =?us-ascii?Q?8aGORsFbZFlthMuVHla25j5zWoEkpeX/iy0P3Ctd0C736whrs18M79ApnzUt?=
 =?us-ascii?Q?nfjZ7I3OmQ0vb7W0rRDQeEFB0+nCD0LUrPNYdoyDNm/j1qMtu3yy61y8s7fQ?=
 =?us-ascii?Q?UkRmhK1Ey/oM/gXfInsnv3sy4WppXdOcyJOur+Yi0Rd5bLHjeAqsh+owqZyh?=
 =?us-ascii?Q?f2MgYC80mrhptlI6ItTdii2PpIfn5hMLhV+3Xbw9L0DVbKDtMsGatM6G2mL5?=
 =?us-ascii?Q?LZRvGxzrcuCp/+Ys1nbrfs93Yv6GvqybBSxpIKCo2ZyhwhjyTI3kKKTrAyZh?=
 =?us-ascii?Q?SIoy7P0Cmkb9zU8VE8tSFQco4JLT2ov6RsKvg7tW6GlNNADlYsPKuLm+vw8W?=
 =?us-ascii?Q?NuDSGHIB2bGMH3eQGCS0xfdz6lfu6RR0oeTRs6UPf//xLZsN3sLzr3uqQbyC?=
 =?us-ascii?Q?0EMUglgwN1qMS09ARTk9cHWmUH4QXVXkKDJtandqGqT712awseYTJODN0NHj?=
 =?us-ascii?Q?nqAYG0mt1wip9yz1UARVfCKPKgwEG5HWc9JliPBxHRVWJBp5qtyeowRPvql1?=
 =?us-ascii?Q?BNEQdND+PKRY6R1vwnzK7aY+45l070hF+woSFcBcTC2s8OxAB5WnwQUssicf?=
 =?us-ascii?Q?dLFdcJYrij8H+4tYDTTLEUJZpHZ8sg77GrZbmxYY18mQ7E9TaonrdbsYP3WP?=
 =?us-ascii?Q?EqhbEMxevI+d87CXXJ6PPLN6wPUaAlIdFqezS4Ly5jRkU2MNkQC8Un01t8ia?=
 =?us-ascii?Q?+ofxztfduXZ0w0iWDwHuf+UxffMWmO2j3p/LLwrln0GuGfSNYywCxGbL4UUe?=
 =?us-ascii?Q?NmFmKxmArDvamnOitqis7X5VjrlEkimsx8/G/U9gpXPRZXq8p1S7ZiDjZzQt?=
 =?us-ascii?Q?emF10BoTNaM4asXJg5DVxuVYF9S/mhIUozy4rdLb0Qdtc2sqj7gQwq9bNnX+?=
 =?us-ascii?Q?hmprZJdktg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b67d1c-2696-48af-6924-08da475eb400
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 01:48:52.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qGb24+Doxx6VwGa+pO1Z3LcANY5azrQdffbqf35hfLtR/fOGm44ygMm8Pba2PpM8cy2/DMPbQEt/gm+PaL3ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
resets and power gating for mixes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/power/fsl,imx93-src.yaml         | 96 +++++++++++++++++++
 include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
new file mode 100644
index 000000000000..880500a841f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,imx93-src.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 System Reset Controller
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  The System Reset Controller (SRC) is responsible for the generation of
+  all the system reset signals and boot argument latching.
+
+  Its main functions are as follows,
+  - Deals with all global system reset sources from other modules,
+    and generates global system reset.
+  - Responsible for power gating of MIXs (Slices) and their memory
+    low power control.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx93-src
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  slices:
+    type: object
+    description: list of power domains provided by this controller.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "power-domain@[0-9]$":
+        $ref: /schemas/power/power-domain.yaml#
+
+        type: object
+        properties:
+          '#power-domain-cells':
+            const: 0
+
+          reg:
+            description: |
+              Power domain index. Valid values are defined in
+              include/dt-bindings/power/imx93-power.h for fsl,imx93-src
+            maxItems: 1
+
+          clocks:
+            description: |
+              A number of phandles to clocks that need to be enabled
+              during domain power-up sequencing to ensure reset
+              propagation into devices located inside this power domain.
+            minItems: 1
+            maxItems: 5
+
+        required:
+          - '#power-domain-cells'
+          - reg
+
+required:
+  - compatible
+  - reg
+  - slices
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/power/fsl,imx93-power.h>
+
+    system-controller@44460000 {
+        compatible = "fsl,imx93-src", "syscon";
+        reg = <0x44460000 0x10000>;
+
+        slices {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                mediamix: power-domain@0 {
+                        reg = <IMX93_POWER_DOMAIN_MEDIAMIX>;
+                        #power-domain-cells = <0>;
+                        clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+                                 <&clk IMX93_CLK_MEDIA_APB>;
+                };
+        };
+    };
diff --git a/include/dt-bindings/power/fsl,imx93-power.h b/include/dt-bindings/power/fsl,imx93-power.h
new file mode 100644
index 000000000000..27fb7df80f93
--- /dev/null
+++ b/include/dt-bindings/power/fsl,imx93-power.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright 2022 NXP
+ */
+
+#ifndef __DT_BINDINGS_IMX93_POWER_H__
+#define __DT_BINDINGS_IMX93_POWER_H__
+
+#define IMX93_POWER_DOMAIN_MEDIAMIX		0
+
+#endif
-- 
2.25.1

