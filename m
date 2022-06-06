Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823DC53DF83
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352070AbiFFBtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352069AbiFFBtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:49:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963114F476;
        Sun,  5 Jun 2022 18:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr5S1lU8CTvSNU2tkbTCHvc+inrcwPZCrh/DY35P1rA+vMjIhJtk9vm4ChwpgnuiyyvEBjV3n2ewcaGwj3l6KvYI2ybTdO8uIEQXEy2b6N419UflaN4S0pp8+JcZHskm6zKDe3mPyWSnvJMVsNGUaS2b5lBHqivt5uvWlBbUjk+wwPCRpOyNHEFc0ZPV/CVE7upLiCT6KPKX4oKSvH350+jx/hC1LyKVKzCWAZR9JRRhp1Z7F20py1VR3k6MEACSPv0QDfNvXecoYsDAfwfZbcPndDu5Z3pBwjKGBpQS0HKwbKpMqalzI993AgOraffoBwYxLR4+dMfRUylnAwDxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxbXU1r1y4blcWg6dpEAhXMgwwEmnQfsrTbk+ZKiotI=;
 b=V2pt+/78IKcFRImi/8OjSrxHHD3BS7xg7ngF9PPXJAeXPSM7p06wQnvO1PT0/Jm9bRXQ8Tr8SMJILD/PPgI+Gl10iVShPEZjpmuv3DJFxxIsLvNdI4SR56Mx1Ll8DtE4UymHMqYv/v7JrXwy+AtQ5VHmcswrc1ASy5VRyuIOfjLK8mIVu8+OBe3TyB1DPCB/6z4qnFsymBIwCjq0zAIcjzavbUqIL+Oig2Q0EGzNFx6TXn+W2Zr9guVAbpIY4512YHxJ8iaV39SL3Ba/trHOxRfeCRNhw6BsmM1/Y96cArxGkZc+RyPGbu2IDs90gVHVSE1x4h5xmBytEbfUYmGvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxbXU1r1y4blcWg6dpEAhXMgwwEmnQfsrTbk+ZKiotI=;
 b=kgnb+cnitp6mbbyMLdFd8PcupdGiBlL7obc/pLytXudbBOYUPbMfJfYgOotctB3KQN46/EeoZMnqrvhiwk44y9XT4GnI6C5Uehc10rlCziq59ZFKNW1bywleJJxDZ8A5Wbvk+0ConEUcZcKEqd+Bb72SsYzde21wB17Mav/HVo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR04MB4840.eurprd04.prod.outlook.com (2603:10a6:20b:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 01:48:58 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 01:48:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 2/7] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Date:   Mon,  6 Jun 2022 09:50:20 +0800
Message-Id: <20220606015025.180840-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d24a743-0d57-4069-50de-08da475eb880
X-MS-TrafficTypeDiagnostic: AM6PR04MB4840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB484077EAC3F7F4B56CF4FAB0C9A29@AM6PR04MB4840.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCtXk/RiHP9Edfe9va1wiPxXptXGLS+qgdZcVG5S10eKJ5Qy/6BvW3+GySD3B1CGXC3GSWD4X3KBZOvjkyMolSAn2tRi8pUsyJoRTUWKKrK6rl+Opw4vFmL+3iTZmycA0a8v6RMt7jDulBxMDOWM3ql5YU2Hza6WOwltBUik3QiTBHJagfrpP/YvqZ/m9mPHHU1+1Y0hDD/PAaRSPaKG4vIpLokX7bcBbJmEvBstuCvbAZbDvnGE/AeKRAd0ogNbWx2TtevML6LL/s6bqox3Kb5VpczM0DMZAeStbNiIC6Yez17387nUjc6Nmt5k4V6uDj9lwaRjURu0E6ZVkpB5fktKJ/Z+JnIS+9r8gTjNkV5K4HSmkQkfSMM4mGprddKrLp62+f7pKQ4Rr5O8tKZBIO7qbrvIXuGc2evu+K6fZ5y/trILwBNCesaqC1vTKhMJVvzOxkS3ikLsMIVzvT3VQdI6On+IDHlEKF7JmVbpajoLsTFL09eNYOMZ0J11Wr1Tz0dRYN9DAyrg/St82raVDmvenf5YjHINb1+LX66WUsWE5Ur3n7x9iiPPqYWmf9/unNLmvzM1KJnJjGIYIm3lYfra/7sb3QWBn4dGHFeWbiSkMi4B9loRB7M+mgX96qj5e4L74CP4wWovRCLoU6oo1F/JyJC4GBQ0xKqRdLSTnUwd7gR0zJsbtZLSrH7vB+bppRFz56QeWGl7dbA8HqYL1YRKfhbU5zFaX9QKxscISpN0vd9HaJA8Hok7scLo/wDJqmJSSjHcl9XAQzUDmTLoQEvVeSOOvjEmdEwYCkUKNztwIa1ud6UdqBvWH0NH1MS1i6cjNWPzPHRrEM8dYIKYEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66946007)(7416002)(66476007)(66556008)(5660300002)(2906002)(8676002)(186003)(316002)(26005)(83380400001)(1076003)(6512007)(54906003)(508600001)(38100700002)(38350700002)(6506007)(6486002)(52116002)(86362001)(4326008)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c+eVc05HHA7QI3cu7y13TLwOiGxotr4t8WS+GZ075N1GgNtGqc6BLTGRSKCz?=
 =?us-ascii?Q?EDj12Ck9ms1yGGbnu/dtSDx2bq2e24CUD4P28ExMTA51ROCtIml2ubHxPYvg?=
 =?us-ascii?Q?HYeKljbDMSVhgpWeXgPWLRAnR1ZWSemfHpMJ0s09x9yDWni0UkJxlrkVj9Vp?=
 =?us-ascii?Q?FxKt/hiITnjN5h+tfYw+CcmD6HejdSmTmQfGsol0ZzvALvVyuy0qxGviCETh?=
 =?us-ascii?Q?0tFde/UIX/MRIDDVtskPDTdB6Wv/D3SSam1+8qiIddKnAvq8KBASjNOm4L5O?=
 =?us-ascii?Q?0c2khPwDT2FoGdlsIGCj5Zv0vbm9KcRtwuG5oAEcWRHOJlbTprqw7Q20HD+E?=
 =?us-ascii?Q?qu/znOOsRNZSVIDHMhxSePn3gzZSF0pNBTsrwKF9VQ8qIh43ZlaLGRMPiCAO?=
 =?us-ascii?Q?mlSOVqX8fq7m8uT2fqvh+EpFT/B2SPsKwtepuVUTUcCY7tAvqgoqUYw12MwX?=
 =?us-ascii?Q?t+nWTf++k/qVsqIMoOiZElDZ9BEvsm9c6eKN9kB6YAH3YJ6kHe3byWrAN9u0?=
 =?us-ascii?Q?yAPf4/dPnKK1GK2TB6zHk5X9/B0psSFaUB+sT52wGr6DVDq8Qb27KU9dym2y?=
 =?us-ascii?Q?JfRSA1FUNNCM0UUlOQFRpH2DWWTPHVmyGKg9r/boQqENU1MxKk1Zx1w24Zil?=
 =?us-ascii?Q?NK/XccUvOSCFgdK0BOFUZF/zN/UCkaRpF5hjjY1lHd/PtDbN960HIcg4JeJ+?=
 =?us-ascii?Q?lHzjVX0+p+AoMyDrt3KBnejnW0RFycMM/in+nsKwxIKmLO0HIlrrO9GPE9mC?=
 =?us-ascii?Q?2f3MF37toeg5Or/am8wh3R/0fdkxDivCUkGFej0CXXg3n79QLsWku0O6iDop?=
 =?us-ascii?Q?0HIaoKziXm49YtjOIhV+vA24l1Ts1OA2IwXWRepsRs3t/1X/RB1k/mzDxBf4?=
 =?us-ascii?Q?sawa+C558RyiGcCMinRuDwwZGhQrlLM/BklMT59FyJ7x/ZPt5fQGYbsVzmZr?=
 =?us-ascii?Q?JMkef+NWOYm0U9X0QlEfJ0D29L4uCwdoGcU2PpjJJE2W2voMgbCNDapL4AI4?=
 =?us-ascii?Q?AYqOWfOx3ZdJXNZXD4EY6YTNk5phB3B9IcaDzxiXeQpKFHY+8zSPGkT3TwUs?=
 =?us-ascii?Q?aC4BlKm9jWcyMmVodZY6APp6XsOuPVCkgmq/48zD7Wkc4ZoU31ISY2wXJRCC?=
 =?us-ascii?Q?XXBMxmws8f3fu/elPkTGVCiimW4HE57XDzvKZaK2RoOdwsWMUvQIIXiSiRai?=
 =?us-ascii?Q?nOZOMogaKmNIbQYSKOC4fi8PBKzkBOLTX4PIfziLHq2fUEU83KXGr8/mZF7N?=
 =?us-ascii?Q?ijy3r9Ev6acWP6zTqmvsXyWVYpPyNOCrGiItMDMCONrOVBifZFVD5RRJb8OE?=
 =?us-ascii?Q?h5M5exsbDdlKtArHAmcuq0AFGytvTq1+VY5sAFjNuEl5r5AOiRlGJVCMeJl0?=
 =?us-ascii?Q?UNKdTYIZTcJ7/NhtI4w4A49Vy/ACpL1iCAk3UM0WQmxRdOe76e7ns7X60JZx?=
 =?us-ascii?Q?4lnYbVZdFuozoPwhtfCWnRfiXhRtLOaelIglFZhnC+Hrf8TXkHp9yUP6c5Hv?=
 =?us-ascii?Q?a45yusgZAyhr2BFjCpe67F45y8C5ky3OaHkF5Esxw8FIZJGIYlSHJq6pzHl4?=
 =?us-ascii?Q?NAttwfba5Bb/cYBBCxCLl9QDSsjPnqOCd1wtMYC6bG3MgpFuNRL1LNurleqy?=
 =?us-ascii?Q?imO8I8Jdquiy+ebLesQgTuZAKxLft4i67twBByjw8iKNpScAxpvLw6un5B4b?=
 =?us-ascii?Q?fIcSXgl4UnDYqm2Tex9+oyJE3eZF9iSzWtssy/urNh4YWWvL6eO/EQCInW4a?=
 =?us-ascii?Q?nspAhLXXbw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d24a743-0d57-4069-50de-08da475eb880
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 01:48:58.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wSPkIBPrc73TmIZrZMbELp1zxfnC9qNx3t1VuYdPiSTK8cJMKoG1R9sTODVIKVtCZ0bWjAsrO6iBBZA4YPZhA==
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

