Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095D2579446
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiGSHe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiGSHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:34:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5132DB5;
        Tue, 19 Jul 2022 00:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM+wDZS9t7bGQbyxlrR98U4RqJ5LVzgG7qYS6D9gV+swUqkow9M9BFRPxt9mD6r3gmF9OxssycYCFrzF0lAMYIM4rnbP1TbeTebUm/7uZqpKp2ADHAKssNGEpilcGbtr8S7rTPQrapXw6WGDs1+oKZ5S8EaIY0KaKeSn4s6KkR7FNXv1pTCbLXnjGoMOgTLq9yaTuAWwL0rIuHdo7s0cZ6ifamPJwiVFsbLjNPqaeF9HgdEfZMxevtZ7+OcLxrJPeka4dgTGTeu5ExDlwkiVL6jTpwqtuSykHnqJ2K3EVdyo6LrhiUU9x4SFYsE1nmTg1HWpZFWkXhPCirBpFDtzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYqteWnq0EMa8IWuaaYYRk7VojM+EMQNIMUSx/73P/8=;
 b=a8Dd3rdxzivCjvX9BXwkP/E8citFka7Wra+TezXfSvjDKdwQ1dwFLgstmGz1dpYlTcgVi5lT8lVaV+cy8vi76GEk3yOY6zNBKxFkj0jIVZBf6RqyirNjW3JD/b4PgdxIQL3PU9qe8Zb5C3q+mdYWxWXU2WcKNhqvmWg0LCQWwfZcmGW/Y/A54ZM5+6ULvnoSMi90amAAfOVADzOfaFDYd9FwFqxkwPpQ+pFf+4CkMTt7HTrZSakGXcw+LJk7Rg/nQcKFtm71io20tZcizHX6hcaQ7x68aKRreVkOvt3GolsJ00+1TWYo9ZFgv9fvJmaasqjWSbQf6wrZTqg1CJ2VHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYqteWnq0EMa8IWuaaYYRk7VojM+EMQNIMUSx/73P/8=;
 b=ll10DWrUz3iiQm/3a8CdKEe+ptoa7r8dWrj+sAF9Pnpb2+FfRd++Dmg18vJKy145+Cfh7mY83qqiT/JJxWTmiL6dhm6N8t33ekYvzV5pns+6jI2/Pl+ycQ2ACoN2NKROxa7LQgxzHP5k9ArnYv4NqbRm6C1aSg5+u/QA08rLN7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:17::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 07:34:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:34:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V6 2/6] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Date:   Tue, 19 Jul 2022 15:35:37 +0800
Message-Id: <20220719073541.197788-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719073541.197788-1-peng.fan@oss.nxp.com>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea8033af-1990-45fa-1710-08da6959111b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eneCh/GkICabq+YUd82/5+DpeU2PLfpn7UhTgO/I/pWB9StsG2YErWvVmr9EaEMVr7mOmTKy/kQsWIPt9AvAtUlhSFv7EhdOp/8E70uhn6WPr/6VYSDydsfmeTpbEqW4zJVI7FHoUcGvEpj2Y9tRq5ljYtcQkuq5vy/zqR7PUPVqNWA+BSbqjpaSVcqAPvXsRRGi15Jml+u4SJwRSMnKeHKOnRHh5OR9O3AtTCNAlavCH9/nEygtbhEgHlza/JGona9iZcLIflk1PsQ1Ff/gwUcv9AyL8+tCaRad9+fu2FlsTXxCQ/kY8LPDSsDz7Woc+i8dxTJpWVNFbmwJ+YlQGCgs86i7KDqmEowxBKVJKOsiYn86Afd//9zPRkEQ7jVAx0rowezHnakvZe0oqMuV2Fz4Ip7/7ekpgFY3Xi2tGDr7WR3xBLFPFtjXKM+4F9S4dMTy2qJSiyFhQjiMHFnCtt+5pcuMGjDfILfuqcwCRuKQ4HGKWqJI0GN1WRNjcspuYCcSpXL91C9d96rTlyoVzF1HKyMc/WIHJ7+PjkFgMQeKpISIFHs56Jfzvb7UOzaZ7+hYbxO1akjkm6wV7lnaHektSs+EX9S7QBN3ZG0grs7MDuPdjqG2Uq681bAN3GMgYZDM5/E95J+rOrzwivoR4sUmFr5Jpo31o7bYuXTHChngAUOid0hJlWEkegreiIqbLy1PhwAqj4T9BP3Lmu+KUI7hHvWiQ0hzTrBrGZkHIa9Ntb61GdLJxRa13jljZ1l5P0T1xwSA+O6Vd6CSgr7h86s58u9L+DYRXw+g+vMRIDkdcS24bS/o0GVbpJUeyMYgSyx/kJV/rfpXhXmluYnwq6e4kw2Y0+qKfFknk148sO/cuylc9E8fKeCG0tEp0oCl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(38350700002)(38100700002)(316002)(66556008)(66946007)(54906003)(4326008)(66476007)(8676002)(2906002)(41300700001)(26005)(6666004)(83380400001)(186003)(6512007)(478600001)(2616005)(7416002)(5660300002)(6486002)(966005)(8936002)(86362001)(1076003)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yHts2ajC47KhqPT1wTRuv8DoZrKzwdHxSTVDXnoZV82OPQHYToLf/KvEPoJ+?=
 =?us-ascii?Q?e6aTixtbE3qMj1JGeu3tP0HTNCByKktGk24BsAzop6uD2rs06wLeU3Pe0wPY?=
 =?us-ascii?Q?QRPC8rrdKJHtyumPwUq+yHzIzl4NbS03k0NusTQrBP3ayJTeZyXglSc712J4?=
 =?us-ascii?Q?0min+kMn173EXmOVm6hytahXBNeU2qlFtbgww+3VFJ0YfO2xPSgSyndy8/JH?=
 =?us-ascii?Q?AAU4RDzEYHTdVxmxkwHjoUFzloIVKkWS6SA2c0saw6jf8Da82YXTkgiHxoSx?=
 =?us-ascii?Q?NFqpf9KMjbfnzvg/yaHJankwQwj+k6GwPzFwa5jhai9S3oVFDFhhTG7NVwvK?=
 =?us-ascii?Q?aoDmlKR1JGYEeScddiSfvnyb8AIrLIQpaJDLISropj3CB3zCxJhyFtD7PJGP?=
 =?us-ascii?Q?E5PFqZfeuoo74L5mfqxhLA5qrDUEhzV3nwYJ5LJ+N6yiaz+fjyGqCs/EZLhF?=
 =?us-ascii?Q?pVqTd9mFfBWJxlJIgOebpoHamFq15t2Xo7R0qyTAsYQYjSAzPIbjPk0SI8dD?=
 =?us-ascii?Q?27ewNHlUCNPQZJh9BAgXfiyEtMMhQF2nHkTZESPIwuwaE5YxtadX6WMayCDg?=
 =?us-ascii?Q?gkUjk6jrrpeGnFtOLPlI0qL4O3Zo1bJaZDPIVUH1kMfYJtIJR/fxOGY+WJXv?=
 =?us-ascii?Q?SKi4cTgF34nIvoXHPCsUTOBvOEJAGMTUlz0Sr63BpoO9tVRKbiLq9fBG7iHe?=
 =?us-ascii?Q?3Eknut/C/SCiCBlAt8ArQiBh/i4zynM3+Ml3Xjh9esjD6hV57drsjB1kDt80?=
 =?us-ascii?Q?YHDpGfrGmgSEpKAmLC77BsCpu9bDJWJbmrZBIuB/SvmxmvfUNmbGTa8IrZIL?=
 =?us-ascii?Q?ZFLr2eDcfFJi5xuBN8Yc7evEtd+GraahZMCR56Zy+82ZrHP0HtBLEMBRt1+M?=
 =?us-ascii?Q?sKhEX/t4Rn3PCsFxIcWUCCq6cRyMWq/t29ufzudAoRtO8JWGvfpC0x2fWFuV?=
 =?us-ascii?Q?eBTsBkqWniV379Bn5JAVfKKZu9mZ1JeMRewA1qiYkybxvaxzutJr1LLRwES+?=
 =?us-ascii?Q?2RxX+FTazyoSKiEefmirhWL5fURS+9XlfpHkO/fhuwFGthvKoo35gic5/Ig/?=
 =?us-ascii?Q?fec+Q30ddvrwkRi9VqQSTE6O02fPGXv8C4N+UQRPesRcEQL2ag3HalWZjeA7?=
 =?us-ascii?Q?2JWep7FFIyPqtmkHVkzw8YGOJf5AvR64D0Hpa12ORO4WsNAGQ2LoE1eKeQjL?=
 =?us-ascii?Q?4/Do5bkhLbKoRhY9tEE7YAQvwsAKKwaZGBDX0KAsvuYBwgofTFZcoWEc9bnX?=
 =?us-ascii?Q?Mg3RAYPg7s+L3+E5bTc1n8rQghT4aJaQBHPa2RRBwDREvrS7MR+em8f8UYsm?=
 =?us-ascii?Q?OXxUyNgWjLnBRdgaqBZPZRd+tFbq7IQacSH5y3NegFEUbJhx1/wtmUEHBaHY?=
 =?us-ascii?Q?RW7BKwKVuWTqHw5BeODcDeNtZmow971BOzwKhjYfyWH0tNR95v47YnBXCimW?=
 =?us-ascii?Q?2SbQn4uzYIEbg1Xtq9M5w1Fa2Bm9Icky5lZk0ql4Sij/nDTP644kBE+yuDPd?=
 =?us-ascii?Q?haRY1xoQmlUp2kIxA+g597CQEvJchrENxKD1KzU4kKgPlVEwIAhlANGMGWpx?=
 =?us-ascii?Q?wMRgWFqX3+3qBVIjfAF5wr1CUmaT3fRDF2mvoAal?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8033af-1990-45fa-1710-08da6959111b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 07:34:08.8371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTZdix84hRnxPDfuJyP2zkrZYFQTkmKwQGzsqDTp7Rbtx9KzwzMfrI1Vaf+lOLoO+gnb3In7VvluIAj2cPcxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4298
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

