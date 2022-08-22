Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235C959BB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiHVI3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiHVI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:29:38 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FCF1261A;
        Mon, 22 Aug 2022 01:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlxxge+qcggoLRv+ms3Y2ipHjsiDg92Hjk4KNSh5TanpCqOuZrOKKlWgeN4BRTtmd4zooM2n/rbpVxduevXnFGxjVZZeCeC9M9dK54RRInixU6cBD9ES18StY81ot+XHHZMfGT3tmCpNWn+LSCuhsJDepwsxQTmkdzKo0yt1LHDlVBxVF5qKjmcdbzJ3NgEFuzZAW67s22DgMgd4V7D7ftUX+ysmmyuqcGcpLSTimC16TvYyJSnwWWnR5iRQTM7CDh3gzcGFsynPf4Wq9kCLXkudNWID2Jn7IOq7MPLMv/nSSUHHM0A4700KklHlbsgdLOiYhXn97Nzqzeu/KbZ0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXFQpfR+mZ0VoTHP6un1sIy50S1d+DCNiXH0kglFrc4=;
 b=btDOouFpPe9wkp9sxjbyhsQRVtPYFXhcfNSsbkXRbv24U2xFmMBAg+Om+QApDr+UqRyvYypi03yRhJqdFZo6r3m2EFxEQJdn2wCXCmblpPIrGwf7ItQGX0Ct0uJhq3Jt5wXcVBTU0z5pNhtu5KlzzOHT+lXzDTbC3vY2iobVoSQi1AA+ORnZbbaSPXmh7BoYKrLvXDtyLIvjJvmfOu5fd0XGL6AMBSBW/znmj1RWdug2BthpT2Cqfdk20Wf3O50r1AVEMBJy5IUTCFdhHYfJKKQ9t6M4HXpMNSYSob26pWaJsVqNXYVLtZ/qtoHH3YbWB5q2dAVIBV/0+dVPZi4+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXFQpfR+mZ0VoTHP6un1sIy50S1d+DCNiXH0kglFrc4=;
 b=JOIxApaB8igDITRUGj/a/CO3zUEW6RFMgKV/hZ5G27Ee8FQSRQFj0sVeHPV8h8LEmndJHH4uIzKdWLxfuALQaTdlDnfaHD83PtXou1+eP4NZSNapmteSQkYQNYWsn79XI+Q04+zBGyEsTn6xt6dzWuvquwnI3mvm/sh6heGK/Hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6128.eurprd04.prod.outlook.com (2603:10a6:803:ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 08:29:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 08:29:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V7 1/6] dt-bindings: soc: add i.MX93 SRC
Date:   Mon, 22 Aug 2022 16:31:01 +0800
Message-Id: <20220822083106.156914-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822083106.156914-1-peng.fan@oss.nxp.com>
References: <20220822083106.156914-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d46f4ba-42d5-4f49-e3dc-08da841870ad
X-MS-TrafficTypeDiagnostic: VI1PR04MB6128:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li3GvBHQ1dZEyuhZoFyP9b8Rak/cwIipzH+iqn7Lveh3CfUrwo0Zmm/uq30jYesUnAy3lDaC585/frE3ZUC4fdyiW890gnyjZak6UW1rEijExW51Zq4Dyp9hb1WsPkijlYqd7JGAzkNm4CEbN/uySr1nVI1UYceHD/zff78Vdmb8PXcSzT1RiMZ1jlg8m/SG/HZy4VKZ8uGklI6uq/nXQaVl2/39ozDl/1KsgPdqD+sRsQW+daz752w5e3ah+zImzxYVtqQ+0wHnFKh6Xqx3LZyfb3lrsRCTTE99m7e4wweBUdOn39z2ZDc+yatK7DXIqw1dld0X/PWdjIxyYn/F9g+d/bhKjpTxcAPwKTb6GwXivtwb4Vb3YPtnEJhGfW/2wzDQOM68YUY2tSDwp3K8KoHCNOlgo48SjpHNDGLKUwaGnP1fs+QHW0PEjdZZ8Yzt9UUE5Bykoe4b+qw85tenrw0ikQ0MW1dU+F296w4Y5A+fwg09VGmUZEL5dZts8uDXhHbRB2QKgODsRo7FEMFwr4aXKp4POpN5/uq9v/oMGO3HI0lbjHxrqS7Hkg1K6yt8qsDN2Vfc4KV11XMkHkonxiDgodUBWkc0NOioVa7Qzepyt2J+74iEs/TDbKiSVXtSELNJEik0wzDxaeeKcmKtYyqlNt4WdCBze8JdfYK6XhEH//Oa2oFrndwiy6LwOlXsWGa/pKF9SG8itXC9eMUmnpJSWqsQRWsXPNlr52DeffGH+3Pgji5k4VZfsJ7Q0abThRLHFoo2d1UFZvjJIs6yuHhINaEpgx2vymteOeLzyMinP2UACXVtTy+BKZob+bcKEl9PlQlraex5Ww43YgQTmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(1076003)(186003)(83380400001)(54906003)(316002)(2616005)(26005)(86362001)(52116002)(6506007)(41300700001)(7416002)(6512007)(5660300002)(6666004)(38100700002)(38350700002)(966005)(6486002)(478600001)(66476007)(66946007)(4326008)(8676002)(66556008)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qLnw6b9ohhWNP/n9+SJheH8HWqC2ehOiPcPOwWWr7mJPFcodKHXcPtKZh+9b?=
 =?us-ascii?Q?NTbjqN0aoGWXg3p9E1EvqxABmbU6YRCi/4hVdUTQH5uOc3o8P+17uNt/lXgB?=
 =?us-ascii?Q?iQ8LJFnuddlS9ZJmuKUA5jAPCT7hawwv43hWYcLrm/iFmbsptL+1aB/kByee?=
 =?us-ascii?Q?fWQ1b0BcYZhOH5/lQp3aN0i85QDc6l+K8C76Vmoh7umfeB9Fe4NGiGPoTuss?=
 =?us-ascii?Q?fQFLbZTSg+hmeQfD5mwyG4KA1FQVnQQO5fWVWrU6iC+uefdpIV6ziJXYx4t0?=
 =?us-ascii?Q?afCMYnzUdj4fhzCgFdToxOiSohetPP3ZK15SLBmEFiSi7Q4ULxIM+JUpGVC3?=
 =?us-ascii?Q?TdSWFwo/t+E4v0IZReE1W+uyoIwPnI12hyUIAThXG0P2S25yrFI3EDJRy33Q?=
 =?us-ascii?Q?mN0OGIb326vT1YlbwLfatLsUwp89AYMGaI+Un+LudWWah6VOO5ot5Wo6qiZA?=
 =?us-ascii?Q?uD9oOhnHGdWhDKrhOZBXLRKkoa/hp4xgy5NAwI5KG6LfU+nlUV2UgwD4+V35?=
 =?us-ascii?Q?MytsPbXiJ2RVO0rFVpKmx68Ddi+rE9oLsw0u9uz3pK4b9scwxcXRC/udSec+?=
 =?us-ascii?Q?VAcZbiX6bVx5o2flXJjW2RE0i8Cpb95xr/y+ssv/H6qBMlPEXyPNSxyGX09+?=
 =?us-ascii?Q?30vStpi+qkjChWbtJMdSZlvour76Y13QS3+4jexIkPPOIS8V1y78d3rDZgat?=
 =?us-ascii?Q?7OP3DhQCV4eH2AxXBff6j3XBvLJMZnBfvxuZNhzL5EfboK970ysjyYCSIC2E?=
 =?us-ascii?Q?Anmx77p6/l6Mkb/lGDFUCSb5V1vUadpR4SVuGehHi+n46TPa7rrGp71hi1Z8?=
 =?us-ascii?Q?TK10yb7IlcQ1BlN5z6ZaQVVFbRq6c4tslU5S8Iu9BmatrvMAYxw8X9fk2c7i?=
 =?us-ascii?Q?VWnomp8IStf2ZgavJyz4M/iHkivo+Bv9x4c7MZfuPEUz9CqfymeKGj0MA0QA?=
 =?us-ascii?Q?Yl6k3AqqSrsR1PEpidVu9D2EvzPo1wIZTdJynCSVCAqDLh7VSPlBxzh/f98+?=
 =?us-ascii?Q?ck6qY/1Q1p6e7diZL/91DNZEI+TnJwwuFFjXWFrNkhIaWXHfKxnc3AIFsM+e?=
 =?us-ascii?Q?DH1VkVhi45OMvTwP0liE0olO8EkOQUl133YZ64uraAFFj+scKYyoCiTa4gxJ?=
 =?us-ascii?Q?NtyaA9H+tgUlJbC8yCEkXcZ3LpRUqyZEPX5RSeQv2xP5DmJoilzSfySpllM4?=
 =?us-ascii?Q?LmMSdtsb/fQRjEosaV1DDPSwx5iVIdPs0xTwQb9HpnNSZvtmbjEvyTX4mjQn?=
 =?us-ascii?Q?kje/u4jCxLW+dGNqAnXCUENJiJFswa2XeoGrbPt3wxcBsZQx49++BPScpI8/?=
 =?us-ascii?Q?C9C4RjKiu78E1LfJa1Skszu5Sd2GCsKJ7pATouHK9kgrtVFWqsIPLMAr3wzg?=
 =?us-ascii?Q?R/8pZzQxq2H7meFLv+AlclsXN4UUeFYay7S8otBu79H8m0+xhDdCoGeYBN6/?=
 =?us-ascii?Q?kTlW7b5V6ZIE5Eo5Z93Cp05Vds+EcIEqorGF/JZ7+1HiAEDMrWr/gH/90AWW?=
 =?us-ascii?Q?XBVcDjjnUlRTmFh8XoILGPhP2V1GOdhIjvaNIaBY5//xYaPJ80YZk6d5uQK+?=
 =?us-ascii?Q?LI73IzG5HdWqtw2qWkvFnasZBS0ynjDjEJwSQ0La?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d46f4ba-42d5-4f49-e3dc-08da841870ad
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:29:33.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtR1MJLJ6yMgFN6gDTWRtvR99qml9O5p4AxaFBciWpFY+2e5Y6M6LUm7VxRgCdZ+uPY7PgZ3OCITs3rCZLodDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6128
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx93-src.yaml       | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
new file mode 100644
index 000000000000..c1cc69b51981
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-src.yaml#
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
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "power-domain@[0-9a-f]+$":
+
+    type: object
+    properties:
+      compatible:
+        items:
+          - const: fsl,imx93-src-slice
+
+      '#power-domain-cells':
+        const: 0
+
+      reg:
+        items:
+          - description: mix slice register region
+          - description: mem slice register region
+
+      clocks:
+        description: |
+          A number of phandles to clocks that need to be enabled
+          during domain power-up sequencing to ensure reset
+          propagation into devices located inside this power domain.
+        minItems: 1
+        maxItems: 5
+
+    required:
+      - compatible
+      - '#power-domain-cells'
+      - reg
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    system-controller@44460000 {
+        compatible = "fsl,imx93-src", "syscon";
+        reg = <0x44460000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        mediamix: power-domain@0 {
+            compatible = "fsl,imx93-src-slice";
+            reg = <0x44462400 0x400>, <0x44465800 0x400>;
+            #power-domain-cells = <0>;
+            clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+                     <&clk IMX93_CLK_MEDIA_APB>;
+        };
+    };
-- 
2.37.1

