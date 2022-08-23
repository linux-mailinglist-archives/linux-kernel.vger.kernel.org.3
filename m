Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB2759D0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiHWFut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiHWFuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:50:44 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00055.outbound.protection.outlook.com [40.107.0.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2E5EDEA;
        Mon, 22 Aug 2022 22:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR5b5c3xYr4s/kVt/bOyE/ptAkiMWhA8iBIEsHbjbuqfBODMPKnhUpMyO1zWmXdHhP7BOs6XcfCMMmwoynzgWq4H+OeHaJzDP/TQYb7OKKkRQ3TdvnCYm/9+cROPSnpdWJm8naV++ISLI7JZbmAzjt3SGAlMm7mOT+fnobSR7sw3g8algmSgLYxjS+u7A93+mOwgPi6MTAR0piZ+4eKX5CsMPuwHbmtd6neybTVf5g+bov90+ENTyK/Qh37OfH7942gUoGn/jQOfa7dGTW+GCE8xtZEqzZcEseqLZU/aBinT+TQso4x1Q807uDTRtPohFDqCLvw1Zk/qIUF33z7E+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXFQpfR+mZ0VoTHP6un1sIy50S1d+DCNiXH0kglFrc4=;
 b=DtWpe6im8VepdRB1+DC+yvyELT39KveOEa1mz8uy9haon/UeMGWCHykLUvjMbs1yDspi6n9Szf/I42jLCiMsMPgVOmkMRRFzAULjirG/5Y7Mi8Z/L0TOic5lwUBCRp+seMC5qowwlHvYlTOSGnPWWx+RPUGZMx5BIVGPJbFHZZPKAYCXri0QJcfWVnVnnsWZAV+GsalZl3F37+EKj7fxHK5yLqwP5XE+DT/NIexS0crR9aC7RSJIhukZa51GwU+I2gF8ux8kaXAJjLC/fFuoQmdk7v/bVxl1Kb9+6+mZfbz6/aPO1kB4NC9OxFpQ4sdlMqHIajpoxBTcn7Q6dPygeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXFQpfR+mZ0VoTHP6un1sIy50S1d+DCNiXH0kglFrc4=;
 b=bMjU9mPgUdFY0kHRlHumxpoadAtLe5ovQlOrQe8VXrKrida4xCV4awm+AYE7ceqeXruH48X2x4GOsNlXE3pOAX8p8mui/hgK+7W63U5ob6oomsUPhPmTa9G1AnPocsxBRbphlswxJbDmOSbQNJOCa7UMx4PwCl3e7b4j0zXIbJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3778.eurprd04.prod.outlook.com (2603:10a6:208:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:50:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 05:50:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V8 1/6] dt-bindings: soc: add i.MX93 SRC
Date:   Tue, 23 Aug 2022 13:52:10 +0800
Message-Id: <20220823055215.1139197-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63cc4e6f-d6dc-4791-a62f-08da84cb6954
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3778:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hS6e65Bl/YkoyFRcGkMRmGWeNWOShgqZaoyGFd9OpKVCmiZ3VD4n630NJC4kC1DnJq1e47Ch21+JcYiRaMbqcaRfSNreDbAvwsbqdJhesukcrw1sVVLuCN7a9nYWJgpjOgF0p5P5ZpbTRvtEpqwHVveA+nj9Y4cIm6gbhBWwqiRcUVbPsetwkV6zvOASW3smzxNRSqFFI7O7MH9LElaoWYVuFoSnupM8Aus46mjDmHRHFJxyfbhjyl5XOzjkAQWDHAX+JyBXHOP6YMK6AiW/gFK9KBAezF3wNQd5BQkz/AuH8S4Zzef6Tx2SQG/rJfup1Phq0D068SSz+2Maa4JC5HgeasWNiPfB3UP2jkBjEwHoGoy6ioAXkT+fnoQ7KG7pHyuKT+bT+L9yLi2CSF3+O8A3W3zrRkUKXKaxxS+uYZh8jSW2gxzEZ2erTxdnJp3PRSZkfcsWbF3mE76uRkg6vpGlfVo9Ri3g70We+x7Z2m4zELhuNrPTKth+KqKHg+KtM3CcSPqhzmYosV6maAiRQOHjWfngMWmuIvgyhsfvQD+7gTHaAwBgP0nrZWDaHLFon1s+ek/3oh3KCE2QeNQ2JngiOCRU/3eJFsqUtqkZfyGnneyzwObyPhSPeVLVjaLPSyla6DAFfpTMn1uW3AtLdv6/yi06i93G03b+EosSfRWSQDuTDX06slx2T0AwtrRLHokWYp7bBrCqpYqBJ78zaHs2QTbwvqSkweyH8RYp67C3HujrFJJ6U2WBQ8GNo4RUHyLkP2Ew9935f2+rUhO7bxocHXwyYwS0ntkwAiS4LnNxH1+GbtPQWLybVFVa3OhNvmuWQ8Z7vBT9WNPC2sKKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(8936002)(2906002)(83380400001)(38350700002)(38100700002)(66946007)(316002)(66476007)(6486002)(66556008)(4326008)(478600001)(8676002)(6506007)(54906003)(86362001)(26005)(6512007)(966005)(2616005)(186003)(1076003)(41300700001)(7416002)(5660300002)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7wgw4ocM2gomyfACGDtSKAzGKXZhT0HDtgbjlQlN82ApmUEqyBaS9LVcwKHK?=
 =?us-ascii?Q?DHoEiWltWT/Uj+rZ1yU5ukSuzp3IibLtnPswrc2U1KLZU5a+c6bn0UpiLbt6?=
 =?us-ascii?Q?Y4GpAU4VAZb8O37OSXpq3QCY0VoB1+WyHiiZDCheY2UaqUgXcaOENwDS1m7c?=
 =?us-ascii?Q?0lQX9cLNAbmYB6pqmzyDeCOyoL0JulRN7oUAssJ0BvqUY/gRUhShzCc9PJk1?=
 =?us-ascii?Q?zTejchzxykIjdJrMrm9MnLIJdVcvQHq202hR5MJOe/LSKuOw2FXF0Zg8IkfW?=
 =?us-ascii?Q?goY4XIuDNFwh1jhVp7LR2Boj5B07Sw76ke0URURcoBYkyEImL+orK+786ScP?=
 =?us-ascii?Q?yGLIhq3I1R/6UD7y56YkgUm0IR5d8jYUf5aoqWQbT17khAIpLI1uFGnoX1aL?=
 =?us-ascii?Q?HjhpzoZeCypM15M/BmzCW7pIYrnoqQQSZtzZUPgEEOsz+VTUAatP0db6jMbA?=
 =?us-ascii?Q?HfPiADh6BB8ymdWO49J1ZrtLcDpkaWYGIife6VtVrOT4tttDLMVif6KWQve0?=
 =?us-ascii?Q?tM3UuScLUyO/u51POjdVrXb74ew0SLs7HOYc1ol/QEfedU8/fQzuZnT0Sen3?=
 =?us-ascii?Q?uQuaNUO1NE4SZv281352lJpeyjtl1YIeE/6FBmbBZs+87+jdq4Kpbeaaljtw?=
 =?us-ascii?Q?7komOZJ1PrORtYY4r2qwENvXMYQyOQqVbtqSEUdtSifI1qynDZkrouyTUbFe?=
 =?us-ascii?Q?2N5o2SmROQ+lME3XRDhch86XJt0oJm3mDejJ8mdK+VwY3hhbey5BkbIzTi05?=
 =?us-ascii?Q?7ARVBHlSlhuCBByfo3C0Zc2HEc8NTSQHi6Vje85zuzFDQ+gfNTIWbYMG9Wxw?=
 =?us-ascii?Q?uHEyDDG7wYuvu2qaUsxbKWMzPCBk8N+vOIJuW2jlL2GKmVLm8UHqYUyuvftV?=
 =?us-ascii?Q?ZnI2Ve0UsNBoDWnybXryuVJd2cBDOOODiDzjArfdipgJ/FOTcUVMmJkBIWsR?=
 =?us-ascii?Q?722wReKouwHmvD5waI76TahVY7qmawka8oMdjqLJUhCchqBfCBvA4q7cfw/a?=
 =?us-ascii?Q?PIonC/9RV100EkpIxxaq9pCeJb8D4EeXHLcdYsUq7QJiHxWCWGSUUfMqIhoh?=
 =?us-ascii?Q?HxA57XUcwqpgNfuRmbW5RBSL65ciIxM/wBPlR368z/yWarK+1xcCNcqcQCyz?=
 =?us-ascii?Q?1pAT2OT0fCoaaFhKShvq0R8/0B0cPYZ9UfEc1DcifSkzHvetsZ0fjtW9WPaR?=
 =?us-ascii?Q?bmYinspTwuH4BolEFhNIBreJ791tQ9yYYnHNPQ9xRCEl98VAw8H7s5BBMXU0?=
 =?us-ascii?Q?dW/3b3MQZQKJoM+LEcqCrfwMMPVA4oI5fuBcdtKmMv9o7WTtSs+UncBpOtRP?=
 =?us-ascii?Q?cNN6yDsORclnoUPeveS1+UzexSqAGPrb6azsll6n/d/Rd5Ui5L8quOaJZjc0?=
 =?us-ascii?Q?jwHXGN2Fy8TjVF4TTlGRTd0aTRTXbyYBv3AfwqPwaC4cA9SDilHRwrsDqKpT?=
 =?us-ascii?Q?Z2WucFqYCaLEuBx+RhKAstO92F7uGi0pEfCssSJsuHwWtYSG/KPCXmOd47eD?=
 =?us-ascii?Q?8UJ2VDAKD2oT2Or/A92czQb2cu0c7kH4h4aKCjpakT+Ti6p2+AKnJ+mFXJmN?=
 =?us-ascii?Q?LPuBPOC1Ruort1SSGtxeJy4xhwa/vsg0jNWVNKut?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cc4e6f-d6dc-4791-a62f-08da84cb6954
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 05:50:40.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGaVTLsj2kRgAKynuAPWp1xJsJtfR9O6btIUcS4jnicAYOlSLEb8dYOb0/klTzFq5YpNDRxc1HNl3h7idxcpbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3778
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

