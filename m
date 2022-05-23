Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED01530F85
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiEWL3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiEWL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:28:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831424EA3F;
        Mon, 23 May 2022 04:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5PsQjiY1IXJ4pO48/Lg5dlVaYir6zoxktTSpc43uo0EfuNumJSvSksq7WEAEM2q9UrPeBxWiY3KCJQOZhV6loBKR3dxrAB4MFOhzFqkt6rs7lUyvr2RiuXd7BDWXvgi1Vo/FD9oxTiYFCRePjbTnYF0Gn+gaylCvt6Yly7nUHcVEqjE9bQiHs64STWA4kneRTZrik4Bu4oxyYim8nHybKLDVs4ZNnrSik0f6ChAf2q34Hx53bemeDr5LtwE9uoL35M7MuHGW6lp0So7wqGjjjG03oq6kHYnvT0MQegow1JNmm5LA0dyBJ/a7YC59GvEAHl00mm2Nroi8vAVYYWm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBgXMssp8NwnGkKPC9/nsJRYSAxKOHMas+ax1COaKU0=;
 b=Wt7JVjB1BOqYQYG9tdCqZ1T+GY+ea0+aAhcvkhUE9C0cUsZhZ3wOu4mY7Z5fqPp1MSDr3eyaGB+vDRpM56axQ2LbH9iFncbXcZP36O658SEP8z4b2OFRHmwdtaswoeMeDEvyH3UG21SxBzUMwA01PjqKFEXUgY0Xo0dETQpoyWE73lUH1++4zu8VoKriOzcyB+aOYKMYLrDKAVwxya73SYHMp/400FBPH/Y8PRtbOBN92dHEHSJa4TjqlgPkAZkTsbNdulsu7o/4FfFn2SNSWHAsVs3pwRX3yLwvSyHfwlLg7ulSjrkBS+wWlCDDF9MxVYVAOSu6GNOo3aaW0F36SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBgXMssp8NwnGkKPC9/nsJRYSAxKOHMas+ax1COaKU0=;
 b=JdreJ6vTyykoVs4TLo6r2I0YPsyYPRtyRT2qRi9LOa57jG2pfgBEaMiOlEws4W3QNiBNMhbSPg6T68tREFjQENUnRxFgR3G4aiG9337nN3tC7cXIi2sFqScZDeOoNTrr72AvgvQ9ixsZ2h0j8yxTZdHWatpcjWKLbipOXAdQyps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6586.eurprd04.prod.outlook.com (2603:10a6:10:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:28:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 11:28:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/7] dt-bindings: soc: add bindings for i.MX93 mediamix blk ctrl
Date:   Mon, 23 May 2022 19:30:24 +0800
Message-Id: <20220523113029.842753-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523113029.842753-1-peng.fan@oss.nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f1168e9-a314-427a-f01c-08da3caf69b8
X-MS-TrafficTypeDiagnostic: DB8PR04MB6586:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB65861DEA8024397F0192E575C9D49@DB8PR04MB6586.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEz5NNplEPJZBYxHRQny5nnscEsc2MQMsAIHu17cQ0i/IP3xqqh9TtwANFrrXMUnaqZQ2avCX5ciImW3bAA58cly6ExXZ54oIaaWRyL6kTauuLRT4D6XEHN20pgpa8tqtFb7XxAkdmvrrIrPLWAEFlYbdJnODN7miAPGsz/LVkGtokg0UGhjK8MQiJSwWYCpGuEU5quwCgcDu2UQvwFlVZtJWCBmUyumC1UY8q/G6715/FVrKs6HnY3anNGVlB9GQm+pfD4ZpaOftbiRkbjfhEWwJS/DO/g8eGs03NG/XpCg2bBAcfgXw7s1ygC/s15eBf9O0ctczy+p1GX0tdiFYCoVV+YdabMEGYw8tVgtOg6rgvMmKKC8fe6YlaK6Dz+Bj3H5wYPgmmpkv9H1TRoI1nhwLvlipZkGsPKHoSuagjRM9bCApQQEIsxL4KrecrnlYgu3QvvRORi27//w2DzViqtBlu2pKGsUSY2bEsTxqNGl4b5cCmRiNjEPW6DZ0+JuETumkfq3sz7GHSyCzwN5W6PuNi+/zJsz02+79w5T+BAZ3/3vTbUextmmaoOX4wlp6fooUqxK1WEa3qGC3Da6KNpY10tG5egHOWpsMDht7Q6rF41H/l5lhIdNiSdgJ63BMFXwbHnm+/GH34csqr/awMbB6XxW8J/7pnpfplHmjWPb4ZkcDDGNeCxm0o9wFKA6/jodRHahWXA4EEqPLcoLhZzdDyf86sB2IKI2DnBSD8NInjliipzhmzm8gGc+vS2eRxl0JaBzItcMzywqLJzHZTvLJXt8aWekkuyOtN2vyHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(2906002)(52116002)(6666004)(2616005)(186003)(26005)(66556008)(66476007)(8676002)(4326008)(66946007)(5660300002)(1076003)(508600001)(6486002)(966005)(6506007)(6512007)(86362001)(83380400001)(38350700002)(38100700002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahu7Ub6aiJkCyGvsvsvC7+u01eMQ+TL8cIp9bKwcwnEzmCvTiezGoOowKZ+M?=
 =?us-ascii?Q?kFQh38CGrB7VJLHfzWbFSE3lUB+tRC/UqMqX2owD1PjsbiqVKfTQYXJFZOmp?=
 =?us-ascii?Q?UeV8F+phLGZapAuA0u8ySang3oFiCr9BVPdKxanF1dDTNMIQihwOZfuaczKf?=
 =?us-ascii?Q?dm/WTwqnLGge4adWUeMwDitK5GnhO0MTSUQrUlfaY0E/q3dPD5pzSNj0iErK?=
 =?us-ascii?Q?2AyGHWEt5u4pj+UrMKcSatQHwLKVx8jfxjsGdmCzFuL3HNSSDo/XZ2368FYc?=
 =?us-ascii?Q?ZvuJOIuB9JPj2c3vanyYpGT+TS6T5qmWpApGvuZn0WXxCaOVj38yxntIUGZ8?=
 =?us-ascii?Q?hLOlBhybcTT8oVoqEmO3nCL4BKUpYfKMCqDraqIxJGb549Hv6itCr/EoPwyt?=
 =?us-ascii?Q?IS/xAZpn1b0B8hKkiAf4N0b/i23im+lvp0vvaha4Q2g/db5Z4suFDv8U9dEX?=
 =?us-ascii?Q?1LFGADhzbbNV+pwkvZKGP++psNmD81qYKQLQNy+P5y3ER/HMpdZDNSm5RvKA?=
 =?us-ascii?Q?rrvgqBaPjzYfAPmfKy1NP32bR8pXKONHfkK58dxKAOsmFyrm5njMJuxXaIzZ?=
 =?us-ascii?Q?RHkA37Cuw8ueyKsUbDfFMM616i6c0+rY1hhDpY5j5F3RlaRfSPJUcKQ6MXrX?=
 =?us-ascii?Q?8Wr4/1dfwy1CPWpzayCTfpoDZc3f6tfOR2oJ6M1SuqKAbjy2JxRIBq1pV0gZ?=
 =?us-ascii?Q?IHnBkgkHz0CZF2Do8G2b3zHYjsOtCo05LbAEX1mX3BzTcmEgQR05IpIWb7Vx?=
 =?us-ascii?Q?LTlIwoVKIqdgxW4/xFBfan6Az5oER1adtatrmFb1gA5z8701bfPwBnDXwQgE?=
 =?us-ascii?Q?9Ue1dRV6OYKIvS0NgbznRc3rKcjXlkuJtmVJKW0sy3jy/tjzdRzXecxkQPrv?=
 =?us-ascii?Q?NoSISfKE2NWuXKo8M/IWqGqpIzgabwfV11k4PbLk6TaxeDKGdi8jafKHeFEn?=
 =?us-ascii?Q?mpk3xRwX0h/xbqsmnWinZTk6GZkTvGP3jwL5OV+MhKtM7mrLVH/lIGNSK3zt?=
 =?us-ascii?Q?FZPhZjgsaVIY37PvL9FYkeY3vguR4LQsNLvAU2Qm/N0OIZXp4c7oupY0HftX?=
 =?us-ascii?Q?ePwS/2EVXMlzh6RMsHGbZDvnxu38M0dPiNmUHG40/AtfWM7JVXuGedZPZGEH?=
 =?us-ascii?Q?DKKh6eNMIp2IHt4+Thrv9OxjiJsOqwwOc+BcsxOg5iQlue+h4L5Tipp6A1Yh?=
 =?us-ascii?Q?B3MXZ9zLBhO7tvRrYl+bjWVVfzL8e3yp3KuKDdGDeTXMBhCd9zgNXR8t9mtD?=
 =?us-ascii?Q?dwfRtsR/NBDfCIbQYOOxylPg4fhTFS8cLfNCTpx1Gr3PECdQDkX26qyKqogs?=
 =?us-ascii?Q?CxFYdHeB/AM3XWAmVubQqhsj0b5guBmx71yk7HHa8xsqGEWqNr56bhHI3Z+P?=
 =?us-ascii?Q?7SHyQDfwA6hPUZSr3omsaBdIDB7Vgn+EkPMFEIQzr1XPaa9JXUE17p3BiHJI?=
 =?us-ascii?Q?9yY3Z8iXUE0RMle9LUk4pbIyLJnkar0Vlhg+lr9ObXPCtorAYs3vGYVSSSPu?=
 =?us-ascii?Q?v3hEV97yzWz4vekbXAbgMwul3H6S1GU9GLjq0Vlk9a2mSWyT5oXaEbxPo7dW?=
 =?us-ascii?Q?A3PNw8m/wExw9HtFPCKy91h45p23+E+ghDLkh5WH3eFldoYROViFiYkpWHUN?=
 =?us-ascii?Q?tRccuSH1W9NdI3D+ow8lWsEn2k/+JJ6KOg56K7IL/7/Tl8k5LODlfLzDY99d?=
 =?us-ascii?Q?H0gr/cr9VTEwL7f2zJR8fIrys+EwISwHruGjATjkGGtM3EskE5LOhavm2NKw?=
 =?us-ascii?Q?WaP8KA8PHQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1168e9-a314-427a-f01c-08da3caf69b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:28:51.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuXLHXiCJnlMYzuW6fPu/kpzej9RQIMsUyHVbvN8LAfIUpZWOMHYKMtz3MZdAY6vFel7lZqkXrNzbZzandJ4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6586
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
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 81 +++++++++++++++++++
 include/dt-bindings/power/imx93-power.h       |  6 ++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
new file mode 100644
index 000000000000..775c08d763b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
@@ -0,0 +1,81 @@
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
+    minItems: 10
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
+    #include <dt-bindings/power/imx93-power.h>
+
+    media_blk_ctrl: blk_ctrl@4ac10000 {
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
diff --git a/include/dt-bindings/power/imx93-power.h b/include/dt-bindings/power/imx93-power.h
index 27fb7df80f93..b3d2d9619d3a 100644
--- a/include/dt-bindings/power/imx93-power.h
+++ b/include/dt-bindings/power/imx93-power.h
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

