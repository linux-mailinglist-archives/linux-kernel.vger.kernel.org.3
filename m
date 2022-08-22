Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005B459BBAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiHVI35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiHVI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:29:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F091E3C5;
        Mon, 22 Aug 2022 01:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlno88qQ4/KBX9hKrO3rOsaqFcpiT2Hd5kV/XaA+wd1ZQ0rkxzcgK5iJJJzAO7P55lS4MDXR2JHLCdaJX83yWqoEnHcM1qmiUmlnGZVXUevRs59FJChAqlfHMhGOPwSi6WwF5uXlFBpKfYKsM2SWpFxnxdcjex/BzAIB6wxuwdqtuNQpLMkyuOtTsmXrcTDGloelIVlzO7hjWVRYdNtjolO/qEzjA1M0RUfZLEEyf9d7Cw27YySR0RC/47sD5o7hLpfFESo9fZFO3gBvxRZYjxarI2lecm7VLAyGRNKxWbt09Vkj64KX2wAdET1NymPO0JkYRoVIShGbMOn3WPdOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XgVov/aAL+68kSo7lADupymmzviYiPYf5BGaMcsJok=;
 b=OODlPZxBUNi/N/XCb8jUhxg23weoJs1EU3ASFC/ajCIFmwMnf112iB9AFrK1Kyu8ncGs2KwD6+/ytWb8FbgrV/wbA73hk/xc/pF3B5uKEVbekn5tU99A3t7VdpGk7bbPqS537C+NXBgi1x/dEHUaDbXuGdpmpdkW3Qsf3Z9v0RX94b0WI8GNfnTM/otS/bVpJOaDEJC3uHFqITi80Wx8x+XRQPycy/IcepoewusG7psetFRL/wp7vx42QRt9wKZdkNqj2POMG4/H6OuRF8CvIvLbu2LgCe/uXgAPc+ozXGtt6I7zgZie6+vULj+5xBak+c8Amn5jaQA+nr/p3kREmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XgVov/aAL+68kSo7lADupymmzviYiPYf5BGaMcsJok=;
 b=hVLlooG6gHcSmYEV8mgZf8LQGPBN8crvOGwdmt6Mw4lXMudO4sL8UGJG6wC7oz7+B6wNGxo1jOpHfeOkXNo7cO7tEHJ4wO9u6o4tjAK+5M41BRiZaqhnHocb8+UrQy5x0HMouNAVcLz1QdQcJHeZvgUnWsL9eO07AXyz/t1d/GY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6128.eurprd04.prod.outlook.com (2603:10a6:803:ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 08:29:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 08:29:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V7 2/6] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Date:   Mon, 22 Aug 2022 16:31:02 +0800
Message-Id: <20220822083106.156914-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b753c5a6-2349-488a-1463-08da84187326
X-MS-TrafficTypeDiagnostic: VI1PR04MB6128:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5am+RAKEOzaNhyAECIQw4mAELuN+JbtqaHxI18McdVJnrNwrrPgaJ6Z9syFl9mLEwgnNnIk4+zLQrAc4c9i3v3Szj2chjH1KOxI8aMtkjubzfIpf5Un7v3EMaDooZGxFiZzSHK3Th2SwECa3tezlhj1CrwQdbFYSPHmxA1GzDH0C+uVmjVLPVw4LDKXePbdWn//OygES0LZpbSc8bLYq6Fzw2UzOWIzuj1ve4GO+ut5syfodrZ54Tpvg6Cw1Pa2sqVWL57+JbAuQITZgOuDSVA3sBtLEEtxiu4mDhF9TqIP6mBEhIPquwE0JCUDeYPmo87CGAO8AEIBBZelGGQ2sWaKjdhM8eN+PIjOJvMs/1Xo7ZUSlzI+fYDcpbS8QumyJ8ARNA1y4VOBELJ41/waQnXpn2FeUr+e3DxcC1rUdFgaT9Ebe3P3Y0n54wIH1F7gmQpLAcrR7wCZPB7WbaoErcgCUwiftpzvU4MAjFWR1I9VZ9hK9UQ7uojTYwU+s6QryY4PA6qvG3SNxM6sRJQvhXdl/KKyMlIUeae+jsOeMoifM3E/vc2RxI4FGC+c1aGCaiH8P3yeeJ6bYsE0ndR3dGFjPg7P5tX0BhSsQkoMs2CvOombNVh+tI4uQwMVq0bSnQjazkLbpqZ1JDfziIRFnA4duHK/KYcrRE3Q4vVbhR5vc29iJ2V79MgMJJfbgmBfzD0PFgJCtl9tKd255toUNuiel/cZUPUmTRoqJTxRd4ZytcqwBgfITm5i3c6s8epjZf6NF2Bu4ryht168N1NW8buBp5d9TspZcaGxdWNR3iluW3/SR2aMSfSkdoOzdH1eBJWzMPJrncaeUGnz6JaSUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(1076003)(186003)(83380400001)(54906003)(316002)(2616005)(26005)(86362001)(52116002)(6506007)(41300700001)(7416002)(6512007)(5660300002)(6666004)(38100700002)(38350700002)(966005)(6486002)(478600001)(66476007)(66946007)(4326008)(8676002)(66556008)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4zRJjoBFKZMrV++wovIEILlzVV6T4e7UlG+sRoSV2D8LV9HfdoEY4GPn6aU?=
 =?us-ascii?Q?SEND3u90BlGMaURWVHEKeUATy2gpKLHVxaAK27HKrpCN7IBvkIeSl41SqTO2?=
 =?us-ascii?Q?ViSVnZaM9RBaLIe2z2as8NSVmYUdtXi7m7LdiN7VEFk/aveFCb+NUl2jnKjd?=
 =?us-ascii?Q?G762KvIFmQfSxs5jtxfSDNSS2WABnk5xtZ0Ou2y6bWOMf69GcX05cR5faPK8?=
 =?us-ascii?Q?ESt1+kRmSVEUULRdDJIDvCkro4TZf39e5svLj6Iwqk4IoHSu/kQlq+jtZpt9?=
 =?us-ascii?Q?YQ6Dvrig+A3trRGYLwnqgW+E5vVblWokj9KEpZibsT7jRq38wQ1N9R862/Ix?=
 =?us-ascii?Q?fp6hK1ABeOq+D30pUAHaMh8wzIuCeIa3A53CGmwocQbx5dbjsIVyVyt2+efC?=
 =?us-ascii?Q?2R9vzX+z7GvEOGoYxGSdZhTatEVPedPePxZIjNvN0LEm0kxw5tinpmJzbWGh?=
 =?us-ascii?Q?OpdcXQKHeegwUDdsCwjm146c5T2QlMQcBbZlMQhoAJh9aSq2scvsFrKOnHaN?=
 =?us-ascii?Q?e44lERKD3Mn6K0dXzMUjwDMrEWR/f2I86nfEOI68cJ4KG4GZ0sm3SQDRYt+g?=
 =?us-ascii?Q?IQEA3q1JexT+SJvbINHC2lWncW4CAbE2/VGZ+dAkvn/wG+qL4DeUI7wwtw48?=
 =?us-ascii?Q?HbbLZpOkW+L1YEKSy7UVQqvyKk4rcEa1vxgirrFuAr+6azBRpHuIYgRNm3+D?=
 =?us-ascii?Q?XWtWg2Z8s+ZkA321kqocvRY0BTzYEEZ5bf9vJwkhtx0Q85lptYXw0+31hgT3?=
 =?us-ascii?Q?Z2lTqFlZnT4qML446rZZvIGu2kxDqBVELwmjNVUjg5foXjqmS16K6NSgJZwS?=
 =?us-ascii?Q?ejNLuypC9rl5MmqD41T2apuj7l2TX+WX5MN3OPA0ymYYN+j4CkdQk5GOKYbS?=
 =?us-ascii?Q?N8nTg9ixEYkNGvfcf0Xft7vpHABNGS2Xa4f+fhrW1KZrxny0FUZQCL5TCkCo?=
 =?us-ascii?Q?zTzi+LT987srr/lM3oFjcugYl3Ig8J5QNESSrJppcnDgmsJ0HrqOlzrf17KN?=
 =?us-ascii?Q?wm7ACr5QircFZuu2Q++PPLJwUv+S+pZpNfYSeYw6MTrPp6l7GjWGzBEhZm38?=
 =?us-ascii?Q?A9QXKpfGGz9eiZsSl4LkLgvKnVtXTRKUN6AJqmqmrkoQWD/yuj2fKaq/wgsa?=
 =?us-ascii?Q?od2jVMJTmDUtnt11zsjdlP9OAiE7xO2Ur/idIHDpd1mpCKC2Fn0EQy7TDpfq?=
 =?us-ascii?Q?mZwMkjq6kQMGlexO0SO4nRBSBfQ6iAX6QYybnzw+px4tRnljxpei6lhvVKQB?=
 =?us-ascii?Q?h4/MJm1XqL9OOKphqHbI8gG26K8m8dzqnEbPOVaxZMpkTZybDlMI6nanQYYu?=
 =?us-ascii?Q?CIlcnGakIJT5FezEbnMoBi5q5XyOleZyQNU87/kZQms/FOKiRqDMXuHyLHcu?=
 =?us-ascii?Q?JROHhXuyHDExwkIHsb4it30ZiVk0yRGR0stg4Rdp+jK23iRzvExaBZCxWIIr?=
 =?us-ascii?Q?eZ5ROLnWg5NzVpRdAEMkYE9QCg56nz2x4nWDqoQnVW++wMEaYxMCHGAYysWJ?=
 =?us-ascii?Q?b0V3ti/h3RKO3V0vdblNtZGp8+7COYxcOLQzVbL54q2qJqHlM9is5KMTO3NS?=
 =?us-ascii?Q?l7HpGJS9BWrFSFTg2b5lktikx1SHIwVmvnQs3KRa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b753c5a6-2349-488a-1463-08da84187326
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:29:37.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKvhoCIF2bA0NSDv9SUisLEJruXNk6Z3Xv6fCcj5dAH+jg4hIB0O8v3gz+fkP1TFd56Rj3NtFkVk/Nhtj7vnlA==
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

Add DT bindings for i.MX93 MEDIAMIX BLK CTRL.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
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
2.37.1

