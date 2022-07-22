Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB2F57E1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiGVM4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiGVM4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F68A0B85;
        Fri, 22 Jul 2022 05:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITjLvPdX6Xdt9A1x/RNFCF+z1r5AJSzVZ3SNsOcDCKRJMMjyxc2A4ILiOu/ZgUGrFO85NgCQkWv6U3G+z+sq/Rh2UXYk4wSkdLW6Sg+YZZXDlXcsyfdP00D93vgqOT41Sv+4GRlSJhEwPe8MansKh+Dfcpqb12DbSIio0ALj2f93GZzPylNsx+4Duf33WLa1U9eMeZ99l0Rr1Lyh+TwxSoncui+Xy2b+onsN26HcGzv8ll9WIPda8BJR5exvPXaekbLeSa++BWlD9L8o3fZC5o95NHdGQDvzAaYCqGBvmBfT7B/FY348Utd/8Ta3oLwqj6+SFJr3p0XpS0TDPHk2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V0xo7cNM5mox/SZPLO9GcfyDPaEBjyglPFVy5CgB1A=;
 b=MqR1jhXDAHWDZTijETXF63BPDzLGCmK4G2AIR8vNV9o1bVrHcC/LRAv68sX3rZ/yieolS/TWHoQmXjuhBiHh7fIM42mFEylvyAhJtW6ia4uf+GyhiVfT0t8ZmbpFcNlQb2yRnKwCORcUvTegOZ8HV+dl88c2yQHRuzUg4tZCE5g44hmiw/fa1iDgmXfyPt8n4k8ELM8MnVnvQaXnwAMHnn/9/5+2/NMgTHnzrWLznTX4femYmR9aA0E5O4QdqvVNVfbEAxSgjgdmZEozwg4jH9oYshqSTWuAQPp7ut5mK0OViYDDsrT+UwlKds1BoffRQifvxSLBwM7gWc+83RXYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V0xo7cNM5mox/SZPLO9GcfyDPaEBjyglPFVy5CgB1A=;
 b=ORyuTbO6ggulQmf/AB25l8nZHX7T3ZC0jjRA00wqZiHvB7g+aFnaArpa2IsLDEfkxiSpJ/XYu0CxVgKZUZFywTzKwuPNO42px2A1/WaXuf0ViPgt8vtP44G20t4YENj0EzguR39HjJSffI20mjPfP1XL18o15ZktnRLqZJVELeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3565.eurprd04.prod.outlook.com (2603:10a6:803:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 12:56:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:56:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/8] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Date:   Fri, 22 Jul 2022 20:57:26 +0800
Message-Id: <20220722125730.3428017-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 484aae72-6ed2-4573-2caa-08da6be1919f
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3565:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tpNuJAjPZUldhmy91/yPRTKXA4y8MUy74OzoFVOU7YGrK3IeWzWnUzIGSTokfi3bBecMWDBQlp/Fj6jx/8T7CJhxl8rVmE47CngCUh5TaSrv84igobsu5qkChD70yYY13Tfyfnix7y3hFLipE+P/0wYZiR34JT+6fYUVhBol1GQRvZxiNGd2mrOy8WATW75y+SCB9tDWwrapzkuc0B4svBhpiCNvX+hBSTSWHi90gY87CM7YUHeCE9btXaKvjJ5PqmGFu5320xAhwyFoAFjxfQisEKp2Pjq824KVYsdSSnqT0+d8ieBff9OTcmzMzgnNE9dUjFPjSIfW4ZGpCMeMABDinfey3FUPyrDm/f+y0LAGGlP9pQH6R/G2dvpSfn43CFuD9ZZX+D93RFZNtQvrbZ9Q/A6U4hB5RpfDEDYzdWjRA0sfHPk3pKsqkILjBA/TppwlVyQerK3HU5OLWCgj+Mnw9xG6UBrgLb8vA7CZtHhX0yGFICDFZR73CcuMt4ss4n5rSIq7Jk/KVhB5pY1a8/vwvVxX/ez83nj/0WQWSVd6MZaLIdmlJ/vcm6PkZmQjNf4UPBrtkkr5ZoXr3igXMpWAiDI0hVijnMp3781veMCmf36ISB76Sk+5lFJ+KBuIFYP78cOylO5+nSqqfQk0p2OX7weARna0FTFekiPXNBkSPPQUH5LlVubB5YPRC7KlIiY0myzJ3bTFAuYJrPfVYWwUIwgMUcpIu3LFbpdLvl3e1tMQRdL0i/2WPWBEU0FGscQlzj0jwd5TQqCECjvN279wR7B9KU32W6e1j64YcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(186003)(1076003)(26005)(86362001)(6666004)(38100700002)(6506007)(6512007)(52116002)(83380400001)(316002)(41300700001)(66476007)(66946007)(2906002)(38350700002)(4326008)(7416002)(478600001)(5660300002)(8936002)(66556008)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4cg7yOSAAFfktqPQYRXPO+Mjir6AmHgCKnJRYoqxQUOXVzMAsAPxnT7aMZqP?=
 =?us-ascii?Q?KBJ7WH/OM8zj/Gs037LTzUUQh/avxMVWLqmww+ulIG42uiq2UghRW0yLeErq?=
 =?us-ascii?Q?awsLfKUUuQSRNy3m40vpCNgZhtuSzm1dKtD9uwFnXZD51x3CXSQ2JO+VZtzK?=
 =?us-ascii?Q?tnt0p5a7Zcc/E6tLue8eBUWKgJUmC+05VG+owJ4WJclAqFU1CFW/2oS/dk/w?=
 =?us-ascii?Q?s8scR5RDNeFJnxR3JGHKrtNr243YB4KwPWxsONZ9skLx0cseWOJtO9WZfTZU?=
 =?us-ascii?Q?89vRcfaCY5bQII4t5Uy8IfaiBNiVuUUEi6S5guAlvA94Ie9+P0Xk0Zzkv422?=
 =?us-ascii?Q?a+8LxQHASPttuh3ZSu7hk1SirEK2w7V1ic7QXz5wOoAlDGE0mCNbNC4/aMHU?=
 =?us-ascii?Q?Y9IDHXoVkkx84974PUiFcTgSw6jSpKn85wgfw2LGBXsjmJ68s/i6lhz+4Tny?=
 =?us-ascii?Q?GuUbgbm6S+7Xgcm8OMlBtO87vWHHfVniQMqpU0/Jau+pGHMpPZ+Qf2dz2vdg?=
 =?us-ascii?Q?E8NieQNlKwl5zNqt8L31DBa9m9KoC1HpjE/fdXtkPIxg2dzkNSBgCoASQqSG?=
 =?us-ascii?Q?dC8k+Njv4Hq4kKnmcS1vMwe4H/z5bO1ppu5b50xaL7Fm3+axt/q/3MbMic14?=
 =?us-ascii?Q?6JwBGEAnR7dI8OfDTR0C78dvsDVYraAPds0A8t7tL5m8LiRHLPKrpOqIKnSb?=
 =?us-ascii?Q?cr+X+3Ne57IS0vqEaXepqjBgjkZ6WfPEzwKmKiB8yFQfZe9K5tbVKlcL4Vri?=
 =?us-ascii?Q?6BBKnCN54qxhoaAdbU8wuQFl6uO6NIZRaxiLwHUpB7QSWBNzIsmOF8BNILS3?=
 =?us-ascii?Q?YJWN4ZCwPAFm+ZNkO/72RgJ+S/o4wDwMuCBOdGtHbuByu4knU2HXnEihxC6o?=
 =?us-ascii?Q?heg5atYduEACjooUqg06NknPXCvAg3Eco1i/NSbbbkQhrz6lDJ4p2awT3Pwh?=
 =?us-ascii?Q?NItEFKqfHWkv9oXVphU25USCJVcTWzwwyOzoaV7EmzYgNewHpgLAMWY8Hh8+?=
 =?us-ascii?Q?QQmzEOD7A9IVkbiDTYgI8MfOLXx3FuEy1R3V9+HC9nQuzRU5fESzwXX2hxk5?=
 =?us-ascii?Q?uY9+FHPfRyDG0cUCduyVoi0HsPSLGt10jV8U1NBgky3d9BH44sKNfVToV4hi?=
 =?us-ascii?Q?DqpkvaEr4mmYrGnlwd9CdfeYyi1G95965bIUL+DRTuYPj2yGZsjpJDIzWfK4?=
 =?us-ascii?Q?ZPQUEI0C6dFGzYr0K70ojcQ/chkH5vvA489iP5F6v5RzUR46+eGGaEP8ZIF1?=
 =?us-ascii?Q?6qazy4vc5/bXIUOCmyZPZ35tMDo5sF4q6wUxE5dtA4V4PrTZxNcnf1Bzff6T?=
 =?us-ascii?Q?PlyNPfzGsuKhgHpBtPX4NsEvgxjwqL/GgUXJFMoM1hlOhXyEX5MuokYcTXHp?=
 =?us-ascii?Q?iaKpRTAKO47gpei0suqBE8Wom3nT3wmACLqtMRVOW9gLgdBIXXW/n1Z+3THg?=
 =?us-ascii?Q?z4Lt4zIm/7e1r7ZeHc1PfXmJHc2eBmdTgkzqcdxBaWUZ6ZmyniYXm3pHNq4Z?=
 =?us-ascii?Q?I++iPb26f07QX4w3yr8ZthcgKHPdSgFnQKaU8wyFOHPedFTxCcPhcw2UB29C?=
 =?us-ascii?Q?nTc7Wz9XXkPNk8MtXslo8wewXsEAlAMz710X3oX8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484aae72-6ed2-4573-2caa-08da6be1919f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:56:18.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUa/MfnM2tOLPOdEs+f4AXAv4PpvXh+LN0lZ7dbobwVkKpKkitRxRH2dVPquefSsYfW6h1CWVW8dtJgFUpbsPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3565
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
the i.MX8MM VPU blk ctrl yaml file. And add description for the items.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 112 +++++++++++++++---
 include/dt-bindings/power/imx8mp-power.h      |   4 +
 2 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index d79e5d2634d6..d71bb20d4907 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -30,32 +30,19 @@ properties:
     maxItems: 4
 
   power-domain-names:
-    items:
-      - const: bus
-      - const: g1
-      - const: g2
-      - const: h1
+    maxItems: 4
 
   clocks:
     maxItems: 3
 
   clock-names:
-    items:
-      - const: g1
-      - const: g2
-      - const: h1
+    maxItems: 3
 
   interconnects:
-    items:
-      - description: G1 decoder interconnect
-      - description: G2 decoder interconnect
-      - description: H1 encoder power domain
+    maxItems: 3
 
   interconnect-names:
-    items:
-      - const: g1
-      - const: g2
-      - const: h1
+    maxItems: 3
 
 required:
   - compatible
@@ -65,6 +52,97 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mm-vpu-blk-ctrl
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: bus power domain
+            - description: G1 decoder power domain
+            - description: G2 decoder power domain
+            - description: H1 encoder power domain
+
+        power-domain-names:
+          items:
+            - const: bus
+            - const: g1
+            - const: g2
+            - const: h1
+
+        clocks:
+          items:
+            - description: G1 decoder clk
+            - description: G2 decoder clk
+            - description: H1 encoder clk
+
+        clock-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: h1
+
+        interconnects:
+          items:
+            - description: G1 decoder interconnect
+            - description: G2 decoder interconnect
+            - description: H1 encoder power domain
+
+        interconnect-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: h1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mp-vpu-blk-ctrl
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: bus power domain
+            - description: G1 decoder power domain
+            - description: G2 decoder power domain
+            - description: VC8000E encoder power domain
+
+        power-domain-names:
+          items:
+            - const: bus
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
+        clocks:
+          items:
+            - description: G1 decoder clk
+            - description: G2 decoder clk
+            - description: VC8000E encoder clk
+
+        clock-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
+        interconnects:
+          items:
+            - description: G1 decoder interconnect
+            - description: G2 decoder interconnect
+            - description: VC8000E encoder interconnect
+
+        interconnect-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/power/imx8mp-power.h b/include/dt-bindings/power/imx8mp-power.h
index 14b9c5ac9c82..2fe3c2abad13 100644
--- a/include/dt-bindings/power/imx8mp-power.h
+++ b/include/dt-bindings/power/imx8mp-power.h
@@ -52,4 +52,8 @@
 #define IMX8MP_HDMIBLK_PD_HDCP				7
 #define IMX8MP_HDMIBLK_PD_HRV				8
 
+#define IMX8MP_VPUBLK_PD_G1				0
+#define IMX8MP_VPUBLK_PD_G2				1
+#define IMX8MP_VPUBLK_PD_VC8000E			2
+
 #endif
-- 
2.25.1

