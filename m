Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE1D4B65ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiBOIVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:21:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiBOIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:21:14 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10062.outbound.protection.outlook.com [40.107.1.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356049BBA0;
        Tue, 15 Feb 2022 00:21:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCHI6u2aBrQgR4Bdo5SfOnAl+BDuz2cYP6aoIfZO+kfWD6Y/UDgkNqDZeVwSHqrxzbFPNU6Xv8bRuLfReyUyS1Xaom+D2XW3KBRc2uthFO/pz90/bS5CAMulDKnF50fi8O98VYcgMuFV8E8cjf2LIbIl/gwdfPlItHusm5UU6mD9JSSpZDFCB4xdUBn8VF3esQY4e3USSS7py6KYL3IfERG4wTgqrkVQEM0Uw4gsSKm+fEmcnsTgNHCObHElvLpWd4MKym0GPBAnOMV34FBksI0nQWdS2f2vVUd0CEyo3ubrKvquse/Cqlh4qs5TviaaEXoOxLkbaMBD1Jzup6AGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H3lqSpIieizRFIgp/0Hh8CONU/JskHK7ASjfUL4DQs=;
 b=eefsThRYqhePju431o6P7nOICVPfSoQ5jSLIzx5G73eRswyGH9zKHsLi2O+KYgel0J73Ti2m8S9e6oBFa46P0X7vSEcqLVQXSIJo/0xUXcNl/MsZaYjHLkPswSOYVirUdAI0zhkyH3uEdgtNxR1bo9VuglYnnzTgwMeCUcCnAq9ExpAaTWsqwbNgPsef6MA8LmQIhJS5tVJwkFwWpbK8dHY84es7Lwllu+S2+ASxNrflZPggu4qM91u94cnlP4wNoZkXw4UFptDPeY6Pd4CrX7vYnQnKLLBhbtIXaRFNApLsPWW+kpgNysBPojDqCimwFNSqGDTVEKRNEwsE4Lj1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H3lqSpIieizRFIgp/0Hh8CONU/JskHK7ASjfUL4DQs=;
 b=HY7wxg1qil5CRIhF9VmI2GVWWC0PaXHyX1qaeubiYqyXgdc2gA4CJH3YP0NqUbbB/67KojegpCzs1TqmhgVDuN3OsEyCpIYkiFJ17hOF/Zsqm/zM3HJlXLm8jVjBZVlfsKS3+aw19crTlXm8JSj3SwN5T9JG2sIKsEkzGRo3jHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5940.eurprd04.prod.outlook.com (2603:10a6:208:117::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 08:21:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:21:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linus.walleij@linaro.org, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: imx93: Add pinctrl binding
Date:   Tue, 15 Feb 2022 16:20:05 +0800
Message-Id: <20220215082006.790843-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae7353fd-3cdf-47f7-afce-08d9f05c1936
X-MS-TrafficTypeDiagnostic: AM0PR04MB5940:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB594065DD98E94C72E9A67295C9349@AM0PR04MB5940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdeXDt0uwWkKi9qN58YxdmR7Hrx0GB0SHodsHgqwoXoa6dHGfvAWh0HN6k/hoJcJIcpYkNGWyV3qWO0v/pyhRRQsdFAn9OElj3M+J/CjcAIiVFmMxzDQLEYzfFHLHi+PEWfSvvR5wNbFYUUeiELiqMYVZIaUTfakoxJjuivURQOmgWEnnF0Xei0Kjr7cCUnyDYFbmcwZ/tVKTSw/w8Yrm09coV5SOOlCPB2siw0cOA5tlBY1H4EY4Z1Z4XxDh2KHfWlsFgNzjQhC4nxVfUu0Yd+BVNqPAKT7NqdiG2VtOG7zcGM34Bp2gTX8zhqZN5gqGJWwD4jAYbgl2G5GO5yf7TV8Q1SIBguhj57iYfN0g9qx7U31ZLyIDrcTH+GeaAF9MmDL30A00xuevpUuI/UJAXFZAA5DCtx3ftmkwQjHF/GeaqxXR8+4XzpDtXPzDZZi7ZdPXn7oA6Fw2wcmqcCmjx7UEurMHdheLFhlWyCW8OChytWWotBUUTsrmlMGl7migS3kqcuT1VQXkwCCdbt1RVGkZbqegHpQ8npbVRPj1FRNAUnTzvkG497dyL03PPFR/QcWtaHtf0EZVp0n7/iGWtb7R1KOehQGLMxz+0ZrT2UQIZxKKM54RxkcOwN71cQo0P5FjWmExr8HaWOWVM8hVnaknZ1FF2DUG7qboNJTUOWZZPJkGG/tZPpTe5but1Y1zXqhX4OhIBsoeKwGs2shQAIlWsxMbx3sbbXEaeiszIiB1oRXrhLyPB3ziZrSuSEgXyMceVWeHGmbZtHaGNZnaCevLxReeMqZk5eDkMUV+BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(966005)(186003)(6486002)(26005)(5660300002)(1076003)(508600001)(86362001)(2616005)(2906002)(38100700002)(66946007)(66556008)(8936002)(66476007)(4326008)(7416002)(6512007)(52116002)(8676002)(6506007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R74ckp+ApKbWb1IqWTe6SVdEJ50Nmr6PYtKI0AvPOdMHKy0YHoDkb1B/WZJ2?=
 =?us-ascii?Q?HFu2fEuTLz6TWymEpPqBbt2SuyQRaeaK/7WPTgx6ZJB0ENE0P+SrJOzOazHr?=
 =?us-ascii?Q?kAwtq4P6dYvi9SLmTs8D8nNDanAkLUepszAHloSglPYBMIuzTjd96H0EMeJF?=
 =?us-ascii?Q?gT8tPy690pwiA66JvlnZuHxwbcKoLvw+dUF9t4ZwTUK00v9n4ccyNIfONQpk?=
 =?us-ascii?Q?prsmJsywCLkJecLYoezJdlZYqnibOdQR6QOhGXTcJn2/5QwlHH4CO9gGufk5?=
 =?us-ascii?Q?s4a6v4NSaKvop61Qk38/UeY3wIitBgyr/r1L28A+TYpkfa05nM2bSTLnByO+?=
 =?us-ascii?Q?3kID7poVDNy2XEBbwGIU97q3VpEihil5ukhi9I60euDtsvHhqK8qxaN5u7t8?=
 =?us-ascii?Q?1gQ2XsuUIR572Ud6mwhV6z5/WrDEbWIYGz0u3tGQwL98uZ52ZZ5JhyhXobjK?=
 =?us-ascii?Q?TZJ47Btv3ELOu7VM8dZCP+yAHhbvBEaJHPDrzfHd+QVDdrhk+XiMAtVdVAAN?=
 =?us-ascii?Q?FI1CACisY8B1eILXc+cf1+U91IqcvDgB4fyDH9PzyVgNBaSnGme8mAgFxDUY?=
 =?us-ascii?Q?lbL9qNTY21E3lyH4xB+nqRAyj5o/n1QsHE+FLkxJTxuIsG2ZHwIc1Aeg3a1n?=
 =?us-ascii?Q?jGErKm2aHBtCXWfJsA7p6kOWVFnTPFAI5zZPZZ8G8ak0bH94SEhUEwA7IKqA?=
 =?us-ascii?Q?bl7QwD8BuA0D4DmYI7r/NGYXdUQqf/SHwzWmXvGZPsrfabjwLoiMhQpx4B85?=
 =?us-ascii?Q?B91HvSDMd8FkFECfX6G25b27LhZgq2faA1bSv0H8NKLDrVvXMGvgWCi0iVvb?=
 =?us-ascii?Q?V7Tw1IIiLu8M3RkGJM4R9AxtQ+/fKmNXY7N7Z8IeH+dfjdf+QllFy5zlqysr?=
 =?us-ascii?Q?3g0IZRdafgEZfHNxKieEaAIkGkkPcHpNCJk4GOyKJ+7mGvobP2Jl4dwvJnlb?=
 =?us-ascii?Q?aiJpmGHh9JH1qnnTPW3nBhRCBjbY24YVCKFjyPi1Mw6s6GChI57p3asulCyw?=
 =?us-ascii?Q?xQOVxNIsSKoRUBvG12hh4Q5PpHNILUp4yHt5tfURJ/If/9F8pPrWs5y2ZyjU?=
 =?us-ascii?Q?qXAJOXIZhoDQBJp2ocarmW2YxDJUPieJZZTF3kDi8jL6ztu1oag/6eStRbvX?=
 =?us-ascii?Q?n3rCdrvkP5Xg+Wscpwe7WHWle6cc0fxSfxrjY7/DivDsWIKAtMf62T7XVkqC?=
 =?us-ascii?Q?PgYQQYfhWhqWmdJGq9fwtlwdLTiCszuxBGbGi38D1/tB8QzAgMtc1FA5je8i?=
 =?us-ascii?Q?eN87mGL7VRAYK/K3PeNEJkyge+FBh3hHgc5Ru9VINYOwhiitE9onHklT6Bci?=
 =?us-ascii?Q?NAvpTACFfOsX3NLp6YCJTpF8m0/ZTCuAbpXtT65Rbcxkq+JUjYNP+q30kD/U?=
 =?us-ascii?Q?WcKnpyRSBpn9PtBsRWXw5PE/k0NSVMbOy7q79o/4hlL1LBFTb19duEvSp1Zl?=
 =?us-ascii?Q?Ofkx8QnhgMa9rPibWYAg/xoVmKXUo5TbKTSGzL742bI8s6TzBXk2JMK/Pl5x?=
 =?us-ascii?Q?spxTnLpbDEn+dnCLVvMRfKiAiL9cjUpOcQ5sNKx2VbR9gLZL4A7ByHZWik5p?=
 =?us-ascii?Q?Y4lufSptTgcC+x5R6MPNm+gPVPkozMzF9XZbIm2mC0SNCasyU+0NGFIrszd/?=
 =?us-ascii?Q?mClUOle6631WRWBbF6izLWo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7353fd-3cdf-47f7-afce-08d9f05c1936
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:21:00.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xhb/7eCKtIrY+YTGWKMy19nJQxefCs+X9h54Ds/a/MtcAu5EKqyGEZpKqKSr9/xAgM/v9JwdELg+4W3gJy+SNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add pinctrl binding doc for i.MX93

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/pinctrl/fsl,imx93-pinctrl.yaml   | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
new file mode 100644
index 000000000000..95c87ea4c5c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,imx93-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale IMX93 IOMUX Controller
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description:
+  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
+  for common binding part and usage.
+
+properties:
+  compatible:
+    const: fsl,imx93-iomuxc
+
+  reg:
+    maxItems: 1
+
+# Client device subnode's properties
+patternProperties:
+  'grp$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      fsl,pins:
+        description:
+          each entry consists of 6 integers and represents the mux and config
+          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
+          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
+          be found in <arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h>. The last
+          integer CONFIG is the pad setting value like pull-up on this pin. Please
+          refer to i.MX8M Plus Reference Manual for detailed CONFIG settings.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            - description: |
+                "mux_reg" indicates the offset of mux register.
+            - description: |
+                "conf_reg" indicates the offset of pad configuration register.
+            - description: |
+                "input_reg" indicates the offset of select input register.
+            - description: |
+                "mux_val" indicates the mux value to be applied.
+            - description: |
+                "input_val" indicates the select input value to be applied.
+            - description: |
+                "pad_setting" indicates the pad configuration value to be applied.
+
+
+    required:
+      - fsl,pins
+
+    additionalProperties: false
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  # Pinmux controller node
+  - |
+    iomuxc: pinctrl@443c0000 {
+        compatible = "fsl,imx93-iomuxc";
+        reg = <0x30330000 0x10000>;
+
+        pinctrl_uart3: uart3grp {
+            fsl,pins =
+                <0x48 0x1f8 0x41c 0x1 0x0	0x49>,
+                <0x4c 0x1fc 0x418 0x1 0x0	0x49>;
+        };
+    };
+
+...
-- 
2.25.1

