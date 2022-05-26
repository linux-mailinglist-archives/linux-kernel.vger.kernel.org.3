Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A019534F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbiEZMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbiEZMcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:32:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA56E6397;
        Thu, 26 May 2022 05:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9C/OWwrXCXDBuCjb9UXbUxX7hq+EVzKU+PKD18qc0NhgNSicJEwPw/d+qcEjQnHyutQpEYysmQb+CfHKzXvLnXYeqlbYUl4ccdrwS0cP7UPmV5dQUOmmKZkMeyt0dIufO5DmswDhnYZEHaGR/VBpa3pA51TKLdM6jXNWg4vkRWa3UlgjyZubLfwg6Ecv5qmUA3WKO8WV39fgDrot9TeutfdPLLtIKZaI67SyrjKg/XxqRndrPwTEl9qRL7QqLECtTHSv5W4OaQSKzNyOQBJoLQRW1tc3MoM1BCxoVCGmvX2VexUkDZLjLBYFG+bAHQVZf0qIL5Z5AIi/NJczhmDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PztbtRSY9f0/+1j5HQBOcivyHURgkJ/AfFY+kduUh8Y=;
 b=mf+IlmFPsTFSMMbWKFbVeKy4Rr31sgc8vV/sz3ctMpyzoVVNBvf2pKEqld9rSQx/fxNXmfFwDD9Cy571PsgA9dOO2PmoHS1VF80CFTatk0MWrm7CrPt0PDMhe3Lw1ThT5JCvS+f743a0P8jmRMVij2azwj0kiriIPO5bISHMNyeR4Ey0L07HWed1pfHWu+EHzEjCCCX6mVgQ707LhnzDJuuTT6MkXH5Wf5SrQklI02PrrAk3bvqL7g6KasNi5BSX12Lx4tlk1aY0ZoFprp5a52cMhHUpkb5YTrjCTj2nOt0UJiK5m08WMusZlUXnfpGR29lcYpQaOMn70nWBx4Y8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PztbtRSY9f0/+1j5HQBOcivyHURgkJ/AfFY+kduUh8Y=;
 b=Cveu2CE7HbpHWOZUpQjjSWUho4YpFxFCfr+F8vj7+Y1y3x74zJYxq2/o0EXBiWwWR7kbIm8Z3ALFPpnEeSE71k6TJAH5DgNX3r6l/GjRHpyod5HJEwdy8JH2s1EcvYZEOXdiYTOBPdnafwyVkgargV7LnwoB2z+uy7zNBe06eIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:32:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 12:32:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/7] dt-bindings: soc: add i.MX93 SRC
Date:   Thu, 26 May 2022 20:34:05 +0800
Message-Id: <20220526123411.270083-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526123411.270083-1-peng.fan@oss.nxp.com>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ab167c-39eb-47f0-fec2-08da3f13d0c8
X-MS-TrafficTypeDiagnostic: DB9PR04MB8363:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8363B94835B4A3F24FE4AAA7C9D99@DB9PR04MB8363.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7HaA+LBoqDZBpalSJlg6y4p/ghHVdHG9+Ed46G1M6q7A5YqQ6ZJNT7e2VNmsnvrw1KtpNw6vU1TinppUjP1tbv1hB7qmQavgSqO2xTpPd7dnostX5WWGCC6PjgO2du26o/nrvAfLvdDIib+adOg2ajI3JNZMJ1ud8irgCtj26QMxIhF71KWvb2Gj+gXDjbNn7YbHzux1JTYmmysHxHa5MCxKQrpidF42CRIxjOHYzDeTokgH4RSYDRDg2RS+zDSXxW9v0ana1VSr6cMVfQah7115/O4tV/UuyzEG8kW6tyPeBsW07PYmPTHVZPcdWgZplWWZKwT92k4Rytb9tcJVrLI8EH/+6NDtWUOPI0d3S7KOXJNnU7wFae3sPapOF1f7lM1SZmneIirQLp5wKIfQySvfr+rCCIyP6ZXhTwRokB/ZqM1RG6YAUy/gix9InlCUMyvO3UA3yZTYk+X2ALVD77+VdhHzlkL/HIJ2j8ALVR3JbwBnEbtdzN71oTpOweH/IRfAcRypvSXWlaVYYz0CW+9ytPgenX861XV8KbHvPIbgDE3Qqx/y47jKxo3WWyg0TQZpB1KIbdpv2XDz80pK26WT2IuEusSRIflGpl/P4ZtyM7UnOmXv8OD4zq4HgOsHgjH64xa18pJMbHWZwnyVIKkWPq3gGPT46AU2zj0X8unSwNKBrq5omp4vXSqAAnDzlI/pFILKLbsD7mNJXtndmXGnNW2VZ556Rwiu93uKq5SVRliub06SeRrZXtg54zTb7lWs9zDxFkIJ4iMQFYXp7nLSDSQCm5INqxJsgjjHwqnqEjl/rScMGVgUkVQq9xcFaMny7k+YgPHqlB92mQ1wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6486002)(186003)(966005)(2906002)(26005)(6512007)(66476007)(66946007)(83380400001)(66556008)(4326008)(38100700002)(7416002)(86362001)(5660300002)(2616005)(1076003)(8676002)(316002)(8936002)(6506007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VendIIYMigG4BTf3ClOf0gICvOLQN5xeMRpcWZH+e2TkDRPriKg6fQIBBLS4?=
 =?us-ascii?Q?PSRFkjoJrtYHV+JRjKeKuD+eewg+i+q/mAS3CnehspLqP1xZ90sx22I5seqA?=
 =?us-ascii?Q?jRVvqL8Ni4ziRry2H+Jse1UJudlqOKyohuz+30gGe7MNO4qpbiZ/thTYYQM9?=
 =?us-ascii?Q?3gjM1nr8KPTGmIF/rPlZiz4KvJJ5bQwRcnmp2Goo2OpYVflkQjzXNW+NEWEA?=
 =?us-ascii?Q?r2lyBreNx8mFrICE0E0Zy1r7YRb8PyVcB+VpXp0D1Wn5hMvUAnH5bhp3sJmd?=
 =?us-ascii?Q?Ar4Iwe26uv4UU05YTqe2xePa6nQxgvKqN8/HIPXF/32NdhB8jm9vT3mi8fLy?=
 =?us-ascii?Q?nrB+umGhaRIpRmQ9mEP8FWKB/QTzZMi02ytHC21qY3W2lWL24Ho9rWa/m9xW?=
 =?us-ascii?Q?o+tpgPI4a9Y54JOnadbP0FECUqeF3jzXHi0mO+asc6R63m//+FZ+KkcNwH5u?=
 =?us-ascii?Q?gVYxI4QyzRBe2PtpjLIElqKhyo6g5ysUu5+Qu4uX4ayGmF0GCKVAkxjo2FAA?=
 =?us-ascii?Q?8oHgyjlwxRNdlzR3R+KFmbSd6i0zs+HPz8g3t1XgDAcT54ljCosOp3ykPB7U?=
 =?us-ascii?Q?65eosphsj92Jd/KhxlKRCuqRzHZV7ezABBDSFhoIKobQgNi+slbltkax8STF?=
 =?us-ascii?Q?MjDIyGqA2DwPfYYSqzwpYv7I7VHj5+ClQsNp9uJMbChp5XphQsp2YrsXJtr7?=
 =?us-ascii?Q?F+aWvix0QqKkNjur8kr4qU5j5ZnTmLUTppvWJwoNtpUMuliBRBb1fVLm4+ae?=
 =?us-ascii?Q?SqrzF0kHBIEZcNzxd6tGoTGAPofC0hDisW+P0O50oTELyUdbgEbMwUVaZ1r4?=
 =?us-ascii?Q?nGKxoN9AesVBPSMOyt2+3c+BiqgFt2EkVegyQikrjUWj43L5DI9hpESmhY7T?=
 =?us-ascii?Q?NHUpLqWkC3sz+SEO2bp0qPe4ucKvyp+wYnSyrBVGSXq6A7PILOrHDzDiY4K9?=
 =?us-ascii?Q?lDP2b5HJQNjpuDw5Z67QUfioGwB0EZVLHLFBmCi0JrTgegHI0fUEx4rkfHrB?=
 =?us-ascii?Q?zWfOift9P3aKxKM7OtrXBqMTTsx1IBKVrKxIeGz82rVoG5/BVnv46uwf8RjW?=
 =?us-ascii?Q?XXbMOv+KWe//rNf5yRIkxISD6+3UN9iV1Xefrb6ZYUIpLXY8to+7vlsRAgvg?=
 =?us-ascii?Q?9RwtOrEkn1h+2ehxRGTJOKFLbAW1ECTJEAzcxVt4PFXI5fMg3tAWq6FszeyV?=
 =?us-ascii?Q?RZaGVw/aYXCjyXlTOyp003ShoGf0B+QKVmakOs6SqAahkjY5yKbI3VFJlimi?=
 =?us-ascii?Q?X6GH/Vh+SP8a1FHZU4v6SEhCer6KjjgJuwlwnjmLwho5TScssOdArUpkzoa9?=
 =?us-ascii?Q?WICJMUsavKnbk8+ktbd7n3uVGm8FhEQRg5LU36+lPpup6b4nv4eEFw0R1zFf?=
 =?us-ascii?Q?fhN0Gh06TkETCWfH9EgLmpmBWkko0iw3DMQydpCfWYO7rrqUNQ0jze3GuOUt?=
 =?us-ascii?Q?hRm0y7zrItHXTd1gSfMYA5I8HzPGtvtoMPx98baJ5uLZPk7GgkTucph/rTPI?=
 =?us-ascii?Q?5LAgTFlsPEld2hri0dfFQsEAQehYfZSh33ChJ7ugQa6r3bMF9aTviv5H1BBy?=
 =?us-ascii?Q?xqdxLHIZ0z56h/I4rs9VF0Pu/ewe5F9OGyQF+bbrxa8GrNomvMA0/1EqUZyo?=
 =?us-ascii?Q?Jl+v6PpNwU5aSMwGN9CQnSO+faVnyu4zdHxK8AHIOXUu4n+LVERWJo0RuxCP?=
 =?us-ascii?Q?R3I2Zg4EesY1kbNWKxSvbkSpEWLX2VvtNT8mbs7MsN2zjvjn7T3Nchm79auw?=
 =?us-ascii?Q?BGfjZ+6fGg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ab167c-39eb-47f0-fec2-08da3f13d0c8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:32:36.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKcP9NPOuTfsZuL1g1IwAlmpifCvGNig7Fd5HlTXOX5Wh9AEPiq6i+93uoFbToV21EmXG3m3w0upg69Bi1jKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
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
 .../bindings/soc/imx/fsl,imx93-src.yaml       | 96 +++++++++++++++++++
 include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
new file mode 100644
index 000000000000..c20f0bb692fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-src.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX9 System Reset Controller
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
+  slice:
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
+  - slice
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
+        slice {
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

