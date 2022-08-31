Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A85A7801
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiHaHsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiHaHsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:48:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7B2A4070;
        Wed, 31 Aug 2022 00:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgG2IAAF0H4bqLICrH/1ggq5uGeN4HIrxs7KzpNor0tAhW4dmQG320BNT7TqFofvNB6X/UUEWMtZyG7DOq8bI/mCm69hUYLeCkwUmFOoSsLTa5xGmq7+5L8h4qcp4rz2i5Pb7d2QNqz1VnVdV9lavP4knOs8zuMSWJ1hXWn4gTbiGQLolNI6FUMqzy2vnSSeUNNKgVwf5BH7JORKvlfeAG+bcAHqwzx2Lc3rnHaM0JI+w4EN+JWzLteeGiV1Tanw+y641BYQcWnNdyYZP4vqkZaakt+I9ZQvJRC/eanDpjF8Y5b5S4aqGVZjat8psBdgnvXPKJ7sjn74tas1pw6bOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ippOlNqd5UmdfRUkRfCkORm6rXTWeIEm/pyL3TWCcrw=;
 b=SuQrnPK+VJGZUws+kUS/0A+hOmRrBQPcsK9px3TSvSHQBOqqMpCFjNl70PB9nV8OZNjvBzTf8z9HDOZFsHvqcAmVISgpnxgPoIXu1EPio5Px6d8+t++4UNQylLf9MAiHcUGtVT7hau1ltZ9T7wqks3MBtGzU/GtEoBRXQqa46Uk0dBj9J3sFmehVNAZuYC35Iyn5AEEsiKZb0VOff+bPdQmyUi6txBep/xdE+VPcwPFpzDxzPWrHacWzb5xQpmLUADAFzL+PsDZ2wY4/gqOGDNCLceKAxbtpOIWhvEatoaCOctqCoqMP3BIYPs0c8tvB90JQpwGZxZSQ/LqMF/TtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ippOlNqd5UmdfRUkRfCkORm6rXTWeIEm/pyL3TWCcrw=;
 b=MvD1WPyvdBRX6b4hm5HhniaQ5J3k2KDMciQUeH3kW6AVaNiBEn68fqOENTYWfDwJhoTL6WxGQw7Y2vUBWV/MxkHWAbkpufQs4NdP3iGU84ZJ6jJAECKLEaDOgkmfcJ5s36BVgUV/ctfKNBATsSINo7z4v4tPevyXHUfVbshgoWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 07:47:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:47:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/8] dt-bindings: soc: imx: add binding for i.MX9 syscon
Date:   Wed, 31 Aug 2022 15:49:16 +0800
Message-Id: <20220831074923.3085937-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9c79c99-7a9c-4ffd-8e2e-08da8b251d37
X-MS-TrafficTypeDiagnostic: PA4PR04MB9247:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9v82nXhXktY2GhFcqBsGE/gbaGK9vY8eYl1wk8Fxf9aRlD6Fmv+ssc6Mfag/4lYe+GveRXhI87/AVWmz5daMk4C/UbLYSjpoku4EYK5VJjH+tdfz8sYnv71nRR/DRDBJB9jr5Nup05J91RL5QgIWU6BA05rZfkCCp/PTOs/RaVvq8PV51y4AlvXEvXCoZOd8ixqqfGJo6uhhASVTtPuEOh4DR/PX0BPeztH+KV/r8wQNjjs7MmOYOp1Nlg/mGn4dxVZz4VTInukbbpvICigD1jSsvmgWrr8J1t+R8ad5fofQt7gqLvH0Rl9bKST95kSUiRznEaQlpc3mUy3UgjHMAIFrKwi2l2MOMktjcfhyOx7v3v/wwVsZfU27BTTQSTsi/znktqg3AOzh0ZH6MQQTECpwAVRjCmq6iTaaBVHU3qeSHk1S0eXb4EgLbIPOsFoCOVYe1ul1GRMomV+jigKAW+xu6TFS3UhnrRHZBKsG80ku6uTSC+ZfG60zE2I6urpSwlt8nvrJoJyYfupXUMwFzpu93sTjwJn8gaTuw4vdNO68rXeVRS6CVupeMV5jID2esMc7nnIJvC+YRu58TqiPHbJrU4mVKuxanPNqS5fK+HqY1Swy45IhOyDSd0R5jxT4OHFvEEe7avfXfR9WTL4TEM1sVqu2QDOHjyFI/J+xG/NRuLlhMCmwR+RSMZyBL4YzD/Z0F9o1Xqb7k8gL6jEaU+6qo3vK8Qa/9QLL0evFyNVErhBLHAvBzMpD6rADK9ZuH1f9gXXpLP09ml1n+sVUVI2K+tMG55x1lIDMe8Oxs/8ZR/i5seEjj/2ZDIZEAHgiCY/ogaodtHyksge9DnQQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66556008)(66946007)(86362001)(38350700002)(41300700001)(8936002)(66476007)(38100700002)(4326008)(8676002)(6486002)(478600001)(5660300002)(186003)(316002)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ej1w4rteexQmZyppDG0JQ+m7cBSyfOhdsjtew/MHbIJCcMgc9D/gIHUIg+s9?=
 =?us-ascii?Q?aiZJnUkAIPW6f6aJGfkbu9wbgG7g6RhTnt22jA/ja7ymUtI0BCBR+9DkwUNd?=
 =?us-ascii?Q?sLkt5Uo+dm4B9IScRqWuy02vsLn74Fb+ESX3RdZfY1vPQRZeh7P0SQ6tg/MT?=
 =?us-ascii?Q?hmuzwDemVJYknyLpWMPH4QUBWJ6b02nWSPVTc1FlMoYuLK5TvkAA+NZHSUcu?=
 =?us-ascii?Q?S8X/1Lqto3qwh+HOX80Zwvo5ZfJ4OD3fWygdxap8JNFO/QMAKQ4SFMAUN2Ai?=
 =?us-ascii?Q?s/jBvtfdiB7IwJgd9lgGnzy0jxAPU8J+mRQ4zAWFAUOrCsj/tuOeeL16creW?=
 =?us-ascii?Q?WHZ7LAoDPJEMkBIfD54LChSx1N3gnyuBfRUteMYZkmbzyPhBH0LGqctjDBuR?=
 =?us-ascii?Q?e/Wqp8PY59Yb4ToXNk1H9dYc6QnoVdRT7Ujh3cToQtkz7JkiGdz4oRQH3R4o?=
 =?us-ascii?Q?ZVA5kxV4pHjRkO4ZDj/Eqlg4OkfrMzmJYUWhjpBAs86DHw1eoOC1pIXP5r7o?=
 =?us-ascii?Q?zXy/NL4Msa2X7Ue6332SI/hhd53wKM8sQKerIwfb5cp8d5vPt0mEl+THCg8d?=
 =?us-ascii?Q?tIMaK5JM7fCsl0EPubOttZnM4GT1+sgn0amFtJ8ohS0yrlKDqHr5YUKY0wUM?=
 =?us-ascii?Q?r7ByOt2Xc5xgn/L9op1+3JU9qq7o0JR2alKlNFTtL6uOAzwsI+z1k62UPjZz?=
 =?us-ascii?Q?YnENwUTv9Ftjm/9Hzgu4ON4pjSNNWBT3TThaKYXx4bR2gt2P62X6MtLtoA/r?=
 =?us-ascii?Q?d0sDXiT1VeBpuL3ml5QygLFW3U4AaELjm/vrWSiGAZCZgBMMaxHYtzozDRoE?=
 =?us-ascii?Q?7KafcOVwoLhPVtU+y+y6DouNREGqXQjfw5445uJ7qV+8Q3t0bk+pqkoq327E?=
 =?us-ascii?Q?CZWkPwej6jBVZDJEesMJc6OIo5uyj17eWTXSgEXwPmweyFjshghSj24WDDeb?=
 =?us-ascii?Q?Q3jVCOzpi2zys1jzksEFxreEgmVNODYovjYuUVgzz9mvdur/7GAgI6jlrMIQ?=
 =?us-ascii?Q?0lGEhcXr7GVB2jw8KYUYdY81PGTA0QWC/VoM3UZSiHNoGe5wXSrmxGwTYbNk?=
 =?us-ascii?Q?oXwv0uNuWpCaqA2S6ZJAiXI28SrPVz8S78Xcq3IZeLBQ+31fxHu6CO/9yfE0?=
 =?us-ascii?Q?df4q1SFSngSzfOd8LkGPjOEluZxXnHrv80Mbtv5eXajhaoNYOFy0p3fQ4HZo?=
 =?us-ascii?Q?HTvJeu+5srJt4HUB4AifDxDgbQ3NOC8lZq/n/a0E80mfmQUOD0zA1hF/ILVO?=
 =?us-ascii?Q?ixVwldoxT+UU7B4e1R6XnhVWADFX8kKa0XYFOWrWRHt+7S/ujHGKVMS8yQaR?=
 =?us-ascii?Q?jYQ+Z1ApyCO7C6xqUp0+A1cSXvuuFLL5BHpllDxXjFvAOQ9rGBTX5aHj7M8r?=
 =?us-ascii?Q?NraCvyRj4fKKeOI8uNouKnbhWypvn/uixMqhQ0A1RbeYwcD1v00dixD9vy+p?=
 =?us-ascii?Q?UakUgYRtwdNWi+6p0Ic3P2TEukyqB40DtZ0sEd2VZhPypG7OzapYSavMiB9C?=
 =?us-ascii?Q?2E7ywD0iSCwqBAqHOmFYWZbcWUVnTD0zU+DCVkPq4GXPOdUsSah+n2bchv/5?=
 =?us-ascii?Q?Bglx04z7ZFA+LyU5PPeSs3bP4tFNWblmB7DWEJ/e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c79c99-7a9c-4ffd-8e2e-08da8b251d37
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:47:54.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CbkXF6VL1o06wblew5ZEj8HjnlL6pEcoUFSaFX0VDsa9jo3UWah1B9CElkLoRPvy4n2tagXc5Rvh9rc8Qkdpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add binding doc for i.MX9 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx9-syscon.yaml     | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
new file mode 100644
index 000000000000..90c5e354f86c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/imx/fsl,imx9-syscon.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NXP i.MX9 Platforms System Controller bindings
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx93-aonmix-ns-syscfg
+              - fsl,imx93-wakeupmix-syscfg
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    anomix_ns_gpr: syscon@44210000 {
+        compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
+        reg = <0x44210000 0x1000>;
+    };
+
+...
-- 
2.37.1

