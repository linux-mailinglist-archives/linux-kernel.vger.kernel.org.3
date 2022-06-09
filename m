Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDF4544C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiFIMtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiFIMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:49:32 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30055.outbound.protection.outlook.com [40.107.3.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF24314005;
        Thu,  9 Jun 2022 05:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQFJR1bRo12l2dk3z5m2inDHF3BJcEiu/GZ0JMbCeIEXTtqIz6igwhdQz5BFe7wDMn0ZhiX8NXhKvTItEpXbkJV/6Uore3sOl7978paB2BYFg6gUtOHW07q7o+8Ds/ld1yABOnghqsrXk+ZUTNMvYmQ+VmLqu3QYUpv6mNunGrQO1KGpaWYnXuyFblzvZ0zJyMgbP+PxgAu0bVOQ2FpHHYLa1U+pa5oCLDpr0i8Q/dUXqB+WnQr/BvhqlY+8DHWCs2RsZ+BlmFFyYfJXeimWxfxjUvt8P+RlQOyMGw7ezsw/MwV4ZiZCJEdqupb3aNWk+T3jG7lFf3uf3iP84E78nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxbXU1r1y4blcWg6dpEAhXMgwwEmnQfsrTbk+ZKiotI=;
 b=N/HuTLvZ1GYGc57hLXdO5sX3q+3nhW94+1cGKrZRAdRR7SnEmdb0WVQydAquOs79nZm0MdONtCDhDzI4thpz3Lxi5QrkQbsz+B6qyFWVsDaf40iMI6xVaHchXGV8Ki4HpDFqdySaBByTWTDTJrDS2uXARIbuxmJcCkczKMMkiX0BFkLJa+8zfklRr4PZVhUxWsm2zEAIozPTHP2kGFLS1aTTIB41WZF+l8W+/U5eFqTN4YX22eIT1MrIdPzXnSnZSXvcE1rrSoYGytsdmzQLW4zhbbzFvOUmzPxjXwh3poM185+CW9JmmVlRuMoabIX4Yf9mnb4VzUnQfWuXr5K4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxbXU1r1y4blcWg6dpEAhXMgwwEmnQfsrTbk+ZKiotI=;
 b=lCj0PwBOe+xJ2yFi5ghdH2JgUmX/Z8kvenzYn34lwlmdUDPo8zmcwm1mXe7NvnkgSquNcJWCoMgds34gYB8ABXaOAA7/ZEftZ5H/vhYXuZg7lpAshvzo2C6fvQa2SJmrcdTzSZmtCnxiKJOQ3DouKajLen6zYerNpQYykned+3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 12:49:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:49:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 2/7] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Date:   Thu,  9 Jun 2022 20:50:55 +0800
Message-Id: <20220609125100.3496633-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a14e0c-6dc3-4a11-7b43-08da4a167be0
X-MS-TrafficTypeDiagnostic: AM7PR04MB6952:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB69526874202224970E1CA2D4C9A79@AM7PR04MB6952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFvq7bw8H6ykOF+/wEqeq8abbuuwSKlO3iRVWeIDK6Cerm5qvsp/0AGmp1Rj2/xp76JxvUmOhDwhJb7/9LjZNOMpWjsEkgtVfgBKFxIhxKr7ddpYs7ZLfFi9v51sQ4FWbecQvPDXsfxuHM40KxclqxdI+lBspfMUiZBnaL1KzrUBE7YpZLljaE37XKso5ICkg69z8bWgnEMAxN06iaUk9Q5dDscolR6/P3UPBwrYmgwhj53wwMrVofYdcpSWIDctch4AJVGdqhYCi5J2beapP1/HqIR4irLLrUWrBdSCdSmLAb2x7lEwdxdFXrMwXc8p2otHjlI0nhxb4nXoLlBpDJ9VnXQXzu585jQle6fF4WNxmolvkKVRjTvn0sBV9r7hxUiNQFGimzjxL+DD59JIlKi8AQ6y0sffhVkKRjo0FtrJE+kAa8WBmfI94bGrruxtGUBzXaAZ+L557D14cZw+sG+cKwQ0S6zgF8m0p2ETZLTuUXVA0Ja8Zkv0QsOBDUQjsVeTz4ckfcgzybzRVLq2irBA0FpLoI4h45v/U6dvAlWV9U7zKg0CAFrB/U8oEzCbLckFOCKZjfok6VSqPgEy5chRqHg+xHgWWzs999/dp9PNqpHbsSLLzPlRJJ6hm6Lxbv/BsPwhZt9CUncT2XpHofNB41+eqvDOJ84Cdhq7Zl5qTrmAtysoFen1MINeImPr/vV9AlHIl00bzC8UbQx9PnC+bC+8el19bN8pbva245SechlbM7qoPyGpgDacUYmiYqZ21rIvA1e2zfRzCATDTsibqg7viiJZ6VHkq9ZHAderaBafgZ3us2o1E8q/392nlxAMivsuJ5xTO+u8A9zykQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6512007)(66556008)(8676002)(2906002)(4326008)(66476007)(54906003)(26005)(6666004)(6506007)(38100700002)(52116002)(38350700002)(86362001)(316002)(8936002)(2616005)(508600001)(7416002)(1076003)(83380400001)(6486002)(966005)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXOetEhm3poUsE3kO7b8wb8NodKGSeyAsBpUelpz63hXbELVRM+uYzCI7nU9?=
 =?us-ascii?Q?C3LhdQxUwYSjBR8lsaDjCWiHi+v7578gUzhBNpYc9TGGPncbhEP8U+zMdBOX?=
 =?us-ascii?Q?VMdsYWd1z9FKzYrvj7womdS6lLK5ykJo20QfXhI7owOB+zRNcIAPxnyvJpMm?=
 =?us-ascii?Q?c3LKq543z/OtG73UgqCy8zrU4r/FFeXEa+wy5NZ2H0b50DLORbTE2qHdzXd+?=
 =?us-ascii?Q?pKn0lvX92HP9+1Wl91HoNyt1Pj/WXoEwbJEYeN+Zo8+GIA5J2XZ/9v6MKrkM?=
 =?us-ascii?Q?eAg4ohdTMW+rZXXVWNiSJOse23pkDkY+yW9VFC9R6ZxD2pBnfwUrkRlCtUcM?=
 =?us-ascii?Q?AcpfLfRr/PZ3V2Q+naA+dNXsXUSOfvEDImf1ONBszBY8PLTiFlaZodFUSChU?=
 =?us-ascii?Q?v1S2rlEIsq6hof6xpv9LQ0QuYIejHlGjjSCnUs+wnkGWsViFyNbklXwVIYKD?=
 =?us-ascii?Q?6EwpKt4JS1uChiXQRTAbNySSj6gSwbRuLCY05QeQX4PX5fx+BDgS/Lx8jexX?=
 =?us-ascii?Q?hgm2iGMUlQUFStja1lJjZ1Aep5gxG21RoTIkPn5AdjjNONoWjwk3RFIY2x65?=
 =?us-ascii?Q?qOPEnyb1/mu6l1zg1yP2wk+DG46M/sUrcci0XFWkVYgwc7hcxYgSURtINArm?=
 =?us-ascii?Q?jm8ZyRkjZ/SqSAbNxYQRItF0MSofSu8K6YT6Ox7zzAnPpmYGSniyGft8cmTZ?=
 =?us-ascii?Q?BuspaK5GtN6qhHQSkd/jklrTySXEhqI/ox/kwCo8P/oD33TeTa/rhggFTNVn?=
 =?us-ascii?Q?lBd60/Op+65mI2v+yhHrXVnfQhB+xlj85wZDKC4GbHmQwgCIhUBNDzkz0+Iu?=
 =?us-ascii?Q?MsqwUG4p8o0GjNwquJs2dcyfxuNLFzYT7k6kjx2uTI/2LME1Zohy/5WUB4FI?=
 =?us-ascii?Q?cjWd7vo7ukiQXF0R+PRQiaLoLJZmU48fPq0HEfIEcYJjHoZA2l2Jwwwb8GoS?=
 =?us-ascii?Q?shgg/EROAydR+kEQTHhqWGQ2o5DxSkjo7S9tqpWQnKyl+WoVsPWBIz5zgppy?=
 =?us-ascii?Q?B7oEb/2KL0cRPVbN69eDb3pRvn3ayyS+bv165aZebWlU49NDotuxrKTGbRzk?=
 =?us-ascii?Q?6luUe8dIVDmjyXiZS2lqa+tv/lR8c06Xv17IykquIu3I5SlO/swvwuMTEqVR?=
 =?us-ascii?Q?UDsCCM0VR0esFLbaoVJgYTBZ2rqduWfywjNHE3s34lzmTpz96uMNomZLwk8I?=
 =?us-ascii?Q?Nm05CHL2cl6sgze21Tv3/388xwG0edCfRIpsx+/0rSufoUhccf9cwNXVIFbN?=
 =?us-ascii?Q?dD2FbBOGCjd1mQmR1xyL6uucSYbu8pzbfe2t9wlWlWcsbhn9NaMgcj0Kx6v5?=
 =?us-ascii?Q?Xurcx3AeVhPk8ISxEaaYMdIb0JYP5G5GjPQct8fjpGMOYDAc7baIWf+/ypR9?=
 =?us-ascii?Q?n2zfUpwJ9yUT5/rA8src3EcWWbWqgGCNHiUHsoKAOTr01YbgCcWIreWjDKSA?=
 =?us-ascii?Q?5B6TpFaRUlhQRCgzU+XDAkqMbZlkUktBNKalaUW50qQzz/AJd4pemSHFoPKm?=
 =?us-ascii?Q?XYXFdwdpYPV4Cv/orgsOVl4g+NrdRlH9ImbjtMVX0aJbtFU9vpb86p59BQkJ?=
 =?us-ascii?Q?103tH2wwQM8aTeU+49s6To37B+VSr0bQrQkhvHzpHTqNjNhYgHky+jCuLv66?=
 =?us-ascii?Q?QFGfnXdk5n+lLXtFMc7L/Hv91kazXaVgzRcHoQf7BEj0ESF90Cwzg1arZcJc?=
 =?us-ascii?Q?07IPtCiLjjjD5Pw5QPc+ju5m6jLcl3Av+OssFMC38b2vpuRHV0dTxgh51RJo?=
 =?us-ascii?Q?lpbxkOknkg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a14e0c-6dc3-4a11-7b43-08da4a167be0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:25.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIA+CfhQNPVe0+OzWKajGFBgNdygUPlO9u+gY43VnOBbBXC0VvPemz28qS8AvNh6S7WV/IO8+kGQdIyDyIkJxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

