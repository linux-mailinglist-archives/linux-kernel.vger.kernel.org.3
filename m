Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA8F56D49A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiGKGXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGKGX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:23:26 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A906F1929D;
        Sun, 10 Jul 2022 23:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtE77Vwxg6y4IUel2k/rUknjoMGFwKlwU2GqofvRv8Dd7Y0DchynoRaenE1wZgXe/aY8nklx33F2dpkNGSMvtcD4ntRSaafvWpXc2QT4i3dfHpR8HjUA1PSm6YOgEjPetl4ECAaQj75JroC9O7qWXQR5jxvQnzOjG9/N+fSddBSh8tkqHZqfRHxjLAcd/MCiuqGaQKYDSdNeyMUW/AEjB6Qmpv5mf8nKnlYkgDJmVp1RIfy9WQT218q7Uqats/QLQQ5ja/ON/9gDU6YVfnQCIvwOrzYtk7Fb2kdt4wrqu25v6QI+mHL+cT/oOkry/5OyFW6106ZDpjuwaj3VYZc4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYqteWnq0EMa8IWuaaYYRk7VojM+EMQNIMUSx/73P/8=;
 b=DTUGIeX4Fnfjiz14g0IEvGtYgdwZ6h2//FKGnpIMMS7WZwdMAfI5mkIY79GkhkOGywdsf8sJiNo4ZdBeqRsbb0XcZWY5qalGYVkZyGXhI5bhDToAaHxlAZCqPmChfkVLlE0gk9Wle5Ckq09Sp4csMP+5FKk2AyPapPGHSsQQtogfI+//wYnifo4odUeZpkZuToriLVdZcyddImtmS2oPabcpshuq3DPl7S2JiVcWcHb/rNFbw4douBwB3UU7jcgUsTIB4gYbOpFRqx3aRw2jjocGZg7/gnKZm8feY0clJB95voO6ZwUQ+2vQxkQVPRYe+azLW1pn522us1i7RdYA1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYqteWnq0EMa8IWuaaYYRk7VojM+EMQNIMUSx/73P/8=;
 b=C7Ol4fFTNoWVcC2hm+0ZBmP/reeWr+YRUmoOO2oi/7zv7p3OkXmnqllIYAY1ePK3ZGN3mL68yQbvrn+NqTko9A6RezqjAbW3NHMAs/R+2f/kOMYo3QtXyLAjcFklfP7SrNnBrxh21ZFKhwoo00YmRGQiYgAJqRVIO+ZxqIePbcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 06:23:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:23:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V5 2/6] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Date:   Mon, 11 Jul 2022 14:24:48 +0800
Message-Id: <20220711062452.3575032-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
References: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bf0791f-1fb9-4e4a-c775-08da6305dab4
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 012U6GJwwxl8nOgDE9f4gNbUBOh7eYCfRKjNf5J9ZHcvSxV0frjNrIO5mjO7H74qZRFVEyfAMxP4CaB0NueQdckVT/ilroIW5VzEbNg/o7LW88ChwHe9hWfU8hpPC4F1X/dmMnqItGgkKFo6TWyL4Oy9h3geRfp+y8jIlyLxRW3NXTYhBtPbVEQT5A8BbnicgA0HfOOZX9RETh9IGkQI62ssQZXHjIAoYerpLW3OPsBShad4kEB3JO5npImScKA4OEecBl0h+bdHy28mZWiJ0xotagaVQjOZln1Buk6OfyqMDjvRxH9Yftyg0YePWJT/yVh8qOkznOhzDvveU8IrG78NBT3XY4CYMhNTDKsW549ZvR2SYJlD1dB1FNPtVtDbyl2ssvrG/SY6Yk6ZkxlbZOhtWi57jLack1WnHEL4z2ziewtaF8NwDnj/AzYm2Fke56r7Yj190tQC1ss68dGh/T0aKyEuIhbCRKcg1PTmoOOqxczsG29Ukc35W0zCK29xSaBxu34jZQFCc9/HvMOcb/pDKjywJDVUAxSLR6uDoSWW2m+IXVAkf/DP6RBUQDPnJNexDJV7qKMyxR82R83X4+oMXF5SXWM9IjqX6iHbesVOtGp8Y9TRPUdSfb5BolICT98RIL+Jd+jjOa7ZMeiasNfdbHmbWISPoW9FOYfNBwG/dTul6YHx5/JNcNpCAS/hBC2mDUGltQPKTXZs/477d6//Gi3ncb7b4Kw7MvAq1xq/K93Qf66kshNaeQ1QxxmqzC7tUp3hNGLxWvYxsbHZ/p6sH9QWSx7owHa8o1qv/cvGEvmft+13Ybzu1EQ4ANGpOfWXE8TFJgNapalM8vTIguQz5abpQJ7s9bq5HCq96CcGCWy2oPy1CCsGOyl+1yJ0gFrGFjT/enIEPBbs6oHChg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(1076003)(66476007)(26005)(6512007)(66556008)(4326008)(8676002)(8936002)(5660300002)(186003)(2906002)(7416002)(316002)(54906003)(83380400001)(86362001)(478600001)(6506007)(41300700001)(6666004)(52116002)(2616005)(38100700002)(38350700002)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wrLhbdEfVE6kVJcYT9EszJ5Nvbj9pskvzdoQN0Ci6BJWYmvOYZNLKxETKvpS?=
 =?us-ascii?Q?J+U4G/1NOZFXX6nzng3aM+ajjzi97U/beldgPdEbmLFxjWRbJBXDQipHsf0d?=
 =?us-ascii?Q?mO4dZSpEpgeiIwwB6u573BYZuJ5CbavqauCF1GaALNwjOFBVinW/goVc+VRN?=
 =?us-ascii?Q?CvWLzQUSBByJbKHQ+PSNm8o0VVSBQiJzTC/D6RH9F/guRIUQPb/lnXsIkbvu?=
 =?us-ascii?Q?Suz8K+feLIfE89QvtP4At8hvCi4D1UehDJi15noAiO+YEPbBjGg8/LVT4TTw?=
 =?us-ascii?Q?iL0P//L7J7HK/ej4BZ/IAmaZl+PdvKEmjLTSQHD9sKNaoxSL4wwDHSOqUzp6?=
 =?us-ascii?Q?tmrCTE0AlpNiSmZ0+U+sbRKr+favBCrIWvvc+QjZ9q9QlvV4QgqIC3ic3/yB?=
 =?us-ascii?Q?PMt7p6o0HOQahAkeEvRJE8J1l81geylSZfsuFPaahNp2FoHPcG/1Q4RrFYFU?=
 =?us-ascii?Q?qwqZVnqwsWFoC/LfGK/Sc8yzRJbhk9O3WBDZ5LQlcQM9nTU6eoPRc7REVuG7?=
 =?us-ascii?Q?fS0b88w5fgAXMX52+nok6vmGKqPwJ1Zj3EOUWb8G1YLzxXlYaunPUtPuKtTw?=
 =?us-ascii?Q?Jw1dtmdW3mz60wvGOOSwk46XOqdxaxqNVjp58R3v4C83hvrNzI1WbEf7dRUi?=
 =?us-ascii?Q?2Qy7cjNdlTtOyg+3x3heXX/NrpFk+emqeF7gZP6jqfLriFY7P/Q+yQxVXzPi?=
 =?us-ascii?Q?k7F4Ncbr1K2eQh+OsqeCv5rwXu/Zuo1NLKmNeQbNvZYpKuV/WcJjs2I5gTIY?=
 =?us-ascii?Q?dbEkl2kzaAIPfEDxhH5Ndxm8TW6H0JCQckm5rggcXdtOGW05TYd42DkAHxQo?=
 =?us-ascii?Q?Zt1yO5jWfX1ZazTYvrCHMXLBwwPF4PFYfh5gEEmm1rED+fTW++wOGZksLruv?=
 =?us-ascii?Q?fqWs707Dc1VqcQYPM21d3TOuEGN2xToZN7rSCGVzuEPWx5b5vvA1+Zikhh+3?=
 =?us-ascii?Q?DkRqExV1Dh9jzX4uUc3Wn6v2XIvlFt5CejUiDVUanI2nsixlN0JV3oJ/wKRP?=
 =?us-ascii?Q?iBSrHBBUNES/WxHjnUmDuIT5PkCozzhb+x0CFKHz2BmZYfKtBT4WnEHGVMtR?=
 =?us-ascii?Q?SG2ti4MOe/KERx3ek7VkzMNRdFJJglgkB1zqFsds0f0xwqANbkfxa1Ed3xVq?=
 =?us-ascii?Q?JtAOHBIg8bh6mdqGuVvlu4As6yPWHDH7EYNWp3B3vVo6qWeQ5hh22K0zqHLI?=
 =?us-ascii?Q?Uk5lX1k7CdOIZiWYRUU1Z2b67Zhciab+2hdhlfIAOWIPoe1/kRb6hlXZ5pnj?=
 =?us-ascii?Q?0V8YKRulA30IyiHdKyn4B/LwBEnOSAX1m0SYo5YCmMI57I44qW5J2z8sn28d?=
 =?us-ascii?Q?fDPzq8luhBNa133aFn9pMEGBpxITbko8dUUffDeiD+4VTNzCgJfrwiEWlQcg?=
 =?us-ascii?Q?ywuzp4M6u15cSJ6Qrh+BvRpTv1ZT0DUQtP+Hga5OmEpIzvxuYk44qZ3fszgF?=
 =?us-ascii?Q?8N2qKVFze6+r16K7Pxki7TE/qM1B6jLaEW5UzViAGKzmhsRkXlr5f+NEINzA?=
 =?us-ascii?Q?retxnXaf/UIWClwpA19Jb+s5K1cvn6etRuv2IZq0Es/CCW8JdJI3iDzQF68O?=
 =?us-ascii?Q?QiHdvS1BMWUQSRA3s15fxfcrkRIbRhC3qxkcdCTn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf0791f-1fb9-4e4a-c775-08da6305dab4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:23:22.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANgWwQVYAeI5oBuROzfTfSQU4y7ZOyHQZdx4xK3OM+SVMZigAFfw/x5kvN0Gr1Jc9J8Aasflhw40hk8NT4JU6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5212
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add DT bindings for i.MX93 MEDIAMIX BLK CTRL.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 80 +++++++++++++++++++
 include/dt-bindings/power/fsl,imx93-power.h   | 15 ++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
new file mode 100644
index 000000000000..792ebecec22d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-media-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Media blk-ctrl
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description:
+  The i.MX93 MEDIAMIX domain contains control and status registers known
+  as MEDIAMIX Block Control (MEDIAMIX BLK_CTRL). These registers include
+  clocking, reset, and miscellaneous top-level controls for peripherals
+  within the MEDIAMIX domain
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx93-media-blk-ctrl
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 10
+
+  clock-names:
+    items:
+      - const: apb
+      - const: axi
+      - const: nic
+      - const: disp
+      - const: cam
+      - const: pxp
+      - const: lcdif
+      - const: isi
+      - const: csi
+      - const: dsi
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/power/fsl,imx93-power.h>
+
+    media_blk_ctrl: system-controller@4ac10000 {
+      compatible = "fsl,imx93-media-blk-ctrl", "syscon";
+      reg = <0x4ac10000 0x10000>;
+      power-domains = <&mediamix>;
+      clocks = <&clk IMX93_CLK_MEDIA_APB>,
+               <&clk IMX93_CLK_MEDIA_AXI>,
+               <&clk IMX93_CLK_NIC_MEDIA_GATE>,
+               <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+               <&clk IMX93_CLK_CAM_PIX>,
+               <&clk IMX93_CLK_PXP_GATE>,
+               <&clk IMX93_CLK_LCDIF_GATE>,
+               <&clk IMX93_CLK_ISI_GATE>,
+               <&clk IMX93_CLK_MIPI_CSI_GATE>,
+               <&clk IMX93_CLK_MIPI_DSI_GATE>;
+               clock-names = "apb", "axi", "nic", "disp", "cam",
+                             "pxp", "lcdif", "isi", "csi", "dsi";
+      #power-domain-cells = <1>;
+    };
diff --git a/include/dt-bindings/power/fsl,imx93-power.h b/include/dt-bindings/power/fsl,imx93-power.h
new file mode 100644
index 000000000000..17f9f015bf7d
--- /dev/null
+++ b/include/dt-bindings/power/fsl,imx93-power.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright 2022 NXP
+ */
+
+#ifndef __DT_BINDINGS_IMX93_POWER_H__
+#define __DT_BINDINGS_IMX93_POWER_H__
+
+#define IMX93_MEDIABLK_PD_MIPI_DSI		0
+#define IMX93_MEDIABLK_PD_MIPI_CSI		1
+#define IMX93_MEDIABLK_PD_PXP			2
+#define IMX93_MEDIABLK_PD_LCDIF			3
+#define IMX93_MEDIABLK_PD_ISI			4
+
+#endif
-- 
2.25.1

