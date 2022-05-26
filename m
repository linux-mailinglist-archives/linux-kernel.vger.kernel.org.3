Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86597534F31
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347338AbiEZMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347305AbiEZMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:32:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E779FD2;
        Thu, 26 May 2022 05:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/+NC+bYgmd/lyUjjCLRJgnVqXMWq0aL4WVXuAD1rrbDLTRZAThAzjnADExlnBpDLrMUKSQo6Q6rUS8MFndStrHv6ls5y65p2FFjQD8FVNnx/gKcmjwsPMzjHcMYcg6FeoIhEM+wNAGiIRNw0wd9hMZEX9FNEtIKAf8dBPmvGQwjVU3djODYn0fjvNk4l1yLc04YdLlVESxfv8A09y6gmthcm3zWSwM1q/L90oZH7nLljocm9iPWZfwsFbNrp10UIuMDIay86d58+1EqLF1gXnEfcRHnZE8Jyjn6W/5QSn0/3HrrBiK5S35oY/KakcA976E1lavBBdYSalvzGAdlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbFd6RXXWumFShmNL4DP0nO9hfrnj7j2ZCPhB8uxCZ4=;
 b=TwJXkfZ+1HXYPW4fN7CCRGzUq/fs8sCD8tjbC/NQuJhT+shnh2fXL7BYev+ilsIWzVeEf7n/6lBid/VHyaclVqroD2wiOuNJ8fbJLuILIX+JbgHH4uHIm/UO7iwuKJLMlz4zVROXXMhs64Rs2jxKiXl9xqMBYY1JDI4v+CJcEUR7b6oXL8xSi+fI9eW83fr38drgZxXPXttVQVq6nGGd9vOlLXKFOFSe9XKsn5BPCaQBvmIHs7SH9E6GL51M+jVM3+MXTxL7fhUCPbbs5M4Slo8xkMTV4Un+gy2A1rC/QjFV3VYc4nf+XHA2oUB6ThkIrJq7xKytT11apnmQpwph3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbFd6RXXWumFShmNL4DP0nO9hfrnj7j2ZCPhB8uxCZ4=;
 b=lqRcFGxNEW0+2ThBkIUm147zKVsQ3cpKDSpjJwspmJucql4bEuktRszd3Qh7tMoEGSR+bJrFSSHQDdRZOqLQSOYHVqINWlVrr3X8EaSdLe1aFwFzCtH0bORcE/rnEYrnQVvPBZxc6Utptz77bvvYCVXhtNtSyDziBwPJjW3jS0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6515.eurprd04.prod.outlook.com (2603:10a6:208:16f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:32:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 12:32:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/7] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Date:   Thu, 26 May 2022 20:34:06 +0800
Message-Id: <20220526123411.270083-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4313542-2331-4616-c9bc-08da3f13d38a
X-MS-TrafficTypeDiagnostic: AM0PR04MB6515:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB651589EB3D396C11483EA84DC9D99@AM0PR04MB6515.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0mlcQ6vSpSM1k/I0fDddzqYDwvmqcchoBBpcaAQdzOnTKVHD7e1Ap8+myl2ElSccOfLe6OyiE/Q9zlAvye+/albFavPv6hqG8VnhJ5fkyJ096q0ijVj0AY+zz9cWOHrgFqRiN0dSgAQWVmPo+s4FjocUIpfDn0kWSCtu9JhepkG2oREnetcMlfOjDfNgUVI0+sL7swr9VBxGcxcPLoLKTqXPJQPvesiNzG0V8Z57xewgSvi0hbmL7IoDnfUZgVlD/JZ1L1sxZtEN0m5nr9H1kqAUaNbrxcpZ9zuojX/tRVMWP1FDavsKzrKxWSGIYWp1q2HM0H9A7liKlQmHSkBhBE92yUjGzK2bnxn5zBOeU/engzKXdp4OPY0MOjvM8zdCBT8DU6IU9H1C4UKKu6Cc4PFUycTXfP2BZAitce0OJTSyCtuPgQoGJbQHrbg3btAftCrVRFnQhUbcDkvxelWbV0VEhja/4bi9yM0T2l3aj7KuvGH2aEnni6NpwY6o51JDOB+P7e4MX6XwyCye8HCQdA17JT5RKFQPIrz5ZMzZ2suHRRDraMwXQlsZtNQOb5Ce8kXFEAOAuq4UJMiudkUCWk5KWqiCK4Mmib0uGHH/GM22ry6byOe4dfl1VUIMmYMrDzXB3OZmTTjZXV8dJvu5laW9CZ9aERpMLSPAneD53/h5tydLbqdkQRQWqz5yQHxNuT+me/0yDTgWTWrNt9qHgWga6jchmuxIj61ElVxiKRonQIH43UwlwfR7qAEJlDa/Cfg5P8KVdfjuJPURwktMRigdXPoonN/zirUDR9xNZter8tIdMvyLP+G+IWY/G6+hGBsdJenzzdmqc0U8jVugw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(52116002)(966005)(2616005)(6512007)(86362001)(26005)(38100700002)(38350700002)(6506007)(66946007)(66476007)(66556008)(4326008)(8676002)(6666004)(5660300002)(8936002)(7416002)(508600001)(2906002)(83380400001)(186003)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohWiCKPfcOazX2sRZ29EVCHthaxezgpTaIWi0IQbJw+atv65deJRUSeX9c4H?=
 =?us-ascii?Q?q5althI2MrDbsyyOlRAf1jDSP+S6V04CFmfCjqeq5VfUDMYOQmwTZxj0Q+z5?=
 =?us-ascii?Q?NGju3go8Uww2xpUNOKztifNAwXSTeXNvbkLljlJ5F4DJD/qJ+lI2pD4Avw+s?=
 =?us-ascii?Q?Iw7OMEGDVNxk/NLNR6rXdR985G2rKqZEa9tXJqsjegVb5Hoyz1MZW03ZBh8n?=
 =?us-ascii?Q?Vcb6i/QcLRwD12kal/CBw8Y/havoO21fDXQlSef7A/KKLQrcXe7yM7/eP3Yi?=
 =?us-ascii?Q?ohoi+C2gFZenw3jnRD3J3AAbt6GJR4Z7pf0W0al1i6OHBToGBYeCiuwqcnek?=
 =?us-ascii?Q?/+n0xt90uVe1C0pTf9W2JGuxccJQnBIE1onWz0GCLb7mV0jTqVf/1u1bldXo?=
 =?us-ascii?Q?GGOJhvDNjJX1piAtKCIkhdO/5LQPuLj8S2uYynZCzeIM/LJhAWG6KNBbfkNq?=
 =?us-ascii?Q?MJcEraaYCvprs1g9bGMXRMDdON5LMOhGIiAH24KGj/AWxk7c+iyz6gBahzFu?=
 =?us-ascii?Q?1I+TGnIgrch2d/Stk1AmW59Cf2edl+x8mTc2TFkdbvZ1d0hwXevrxs4cbbmu?=
 =?us-ascii?Q?bQ1FSAi/+WTzQbFhYcvlYqe1ry1RhB1V8M+oiIZNTM2Rh0YMhXMqBRVNOGjW?=
 =?us-ascii?Q?jHrG2nrGuyApTUOpag69zqhxftA8ulYBDDrBfb/n8xeMWesGgjh81jdh87Q4?=
 =?us-ascii?Q?46zi8NNObTANa52Vh/A59BbZtJHcu+OrA8jsFo9CYXj5PsV89bfw0H7lK5sO?=
 =?us-ascii?Q?Z3OhVWHexrBmc7OyR68Da5s7ChBUXNyVWSLNJryKsfFrhXvkfj0ZWZvBMAsU?=
 =?us-ascii?Q?iu2P68s9qxLcndgbNuJCFvY6muZNsKUdpKi4p12l756XEyziKppsZjzT+1Jq?=
 =?us-ascii?Q?pl+iAjvhjOcBx37HORxNinGHmBtB3PGyPUWm/fr2M2tDmsJ7nWW+6o/DqktW?=
 =?us-ascii?Q?Qwti6rlh9071AJJve+a3OvxvLEajpemnkE8JVBXSwnl9JgPt2ib48z8waWiG?=
 =?us-ascii?Q?xGVlaJ5tc+6tm5b68Hg9hTMvA6f8HDG1SqE1ej/TbM817ZvQm1b6zvjcQXEj?=
 =?us-ascii?Q?QejrxCE/L3xgRgdAVtdCZxX1ObiIjfBCPd6RiubemwDZOa1PecUfRlNFMoA9?=
 =?us-ascii?Q?QI0IO0eXhdOoJF1frLj16aA4QKON/IYvv7OxST58Q8u8Zknb4sEjsTuz806l?=
 =?us-ascii?Q?p+b7MFNTSCLeUtC3T6gz5CmPNHtjLspI8DdtW+F3bVjQkhypSoJwoRzETAZm?=
 =?us-ascii?Q?b3TLK2R5lvPn+mEXcUayI4ZRgN8xi0BPKPBVfhxexzTRi0WbNchzVxLrti/f?=
 =?us-ascii?Q?ENquUvocflmv1PtKqYOWc7QyM45lomNyDK00EL2q2rCnuPQm6blMi98oZ5hB?=
 =?us-ascii?Q?AixO9z7I6jDCxol2iXI9eAZYYiBbkPFsErAh89Xv6CuO+Ve6mYB32AobWC2F?=
 =?us-ascii?Q?HOgZDud33QpJMtnV5taG0JjtYLfnQ/Wio4YhwOfPptLcaWVFloQOpOyfUoXe?=
 =?us-ascii?Q?P8Bupf7GWqPiRHM686Z4zmikFDDHBqm/PTz4U44GuQZmclwJSpE3H94FkM1T?=
 =?us-ascii?Q?gU9Wh0CNk/xGw/wyg1yGK18zJYR9IQ9ee3oJ9kIBw+DPMYPfKhcBkmyuXkWV?=
 =?us-ascii?Q?suXS4z+uqJ3HMVNk9ypv/y/6ER3CWHvmzdCzoGVPZIMEkbJzskksH9kCmxXQ?=
 =?us-ascii?Q?VIAUIwayXBr/5FoNe33/OgLZ/n6mp5aBGEwjNrXRcxQtYJM/MtjSHvFqbKMC?=
 =?us-ascii?Q?NvfGdCAHNw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4313542-2331-4616-c9bc-08da3f13d38a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:32:41.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXXgDBTZizl5DGbbQR/XV0C6KHvyoxT7SWebvuL6t6y678yw5vnkHPDM5QwJEz81B9nPmBzRFkKPL7i/asfYXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6515
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
---
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 80 +++++++++++++++++++
 include/dt-bindings/power/fsl,imx93-power.h   |  6 ++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml

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
index 27fb7df80f93..b3d2d9619d3a 100644
--- a/include/dt-bindings/power/fsl,imx93-power.h
+++ b/include/dt-bindings/power/fsl,imx93-power.h
@@ -8,4 +8,10 @@
 
 #define IMX93_POWER_DOMAIN_MEDIAMIX		0
 
+#define IMX93_MEDIABLK_PD_MIPI_DSI		0
+#define IMX93_MEDIABLK_PD_MIPI_CSI		1
+#define IMX93_MEDIABLK_PD_PXP			2
+#define IMX93_MEDIABLK_PD_LCDIF			3
+#define IMX93_MEDIABLK_PD_ISI			4
+
 #endif
-- 
2.25.1

