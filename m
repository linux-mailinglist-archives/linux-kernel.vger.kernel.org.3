Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884214C6080
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiB1BAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 20:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiB1A76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:59:58 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00070.outbound.protection.outlook.com [40.107.0.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D37251E4B;
        Sun, 27 Feb 2022 16:59:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQfTwvuZErPrIR1Pk3jRqqjUpFEcgrjREtOzrpyPSeka+VBX039I2Mn1bjo0G6qzxqINzwPxO0QNQqgH4owcJ6n3n6jwtwwkKpa543PeDTQ043dujLjXnFVHow24mTnqf02KYNVaprJXY6XFYUpZT4sbWaB4cqrQ3SWRY3wiYz29FtBwKDlpdiAWc+NgR6n9u9cOwExlUw7e8/O5SM3Lu2CWgElvyXBOpOiBcP8CSllceSn+K/m2QNZayQ2yReJBE1F4Myc9xWnPLoxQFb6pkvDRZO5rPYFaPh1Ztd3gv1oVmq88e1lrUPTejJ8ofmD+VXlPAouwWWQOxGm9cyg7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGKavjKbIW6qbswC6VvNHvY0FT440kRE5Yir5/ONX7M=;
 b=K3A78wE4BqRwSSP7dVrjtD9lAazt0UstyuL7pHIotdkDo+KsQcfOAKEZVDxhFwzDoYY7bXNza85WNO4XmcYPOeFPjlZRc1JFi2zNfXiKgNQSjA5FZPiNCuIf8i9ikrJ7xOxDJ3gvQtzte1AQN90nmYYCIj9lxDV6TR+uJZQfu7SMa239gnAzXlPAm7k8mEfMlVr1hOaUh2vNcDrSI1bY+gFYniz/JRLMGn79/eOtz7DNWATkPhySgAhL/bh9oPXIFBeSKUj1X14zDzO3SyikwPr1pAJCD894GrA4ybxRxnix+N/Ig+YuY79vUn12ubICz6fb0GzCWTthqM14YTWoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGKavjKbIW6qbswC6VvNHvY0FT440kRE5Yir5/ONX7M=;
 b=iD40oLfVponNDl2rmM6W447HhQcYnHIhFi8nwGVNlQs1i4rXdILIXZE5b1bTXqzLU2o7D9YF7Dv15QUpCYkG0okeE4YVaV4JooGPPN8eTCNz8LQUO0ZhN+sOPZfM7Rlu19I1dTRJmg0Zlu34QdWkEbdimyuKGbKYY/QvX3kvtik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5412.eurprd04.prod.outlook.com (2603:10a6:208:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 00:59:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 00:59:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linus.walleij@linaro.org, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings: pinctrl: imx93: Add pinctrl binding
Date:   Mon, 28 Feb 2022 09:01:02 +0800
Message-Id: <20220228010103.2725893-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 613378bd-bd06-4ee2-3a70-08d9fa5589bf
X-MS-TrafficTypeDiagnostic: AM0PR04MB5412:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5412EBF5AD982912B6E604BBC9019@AM0PR04MB5412.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIXAvBItk9nhcQpr31zQCGYE+Bav3nnykaHIDNPPBD6dR3e6sE0NWScg8r96cbYeLHYMaqJIKFJJIl/hHwiRTiKryAnBYc7e5EGxTGio9M/hA8zAxbTZT8x5/dJlf4+FN0PbwvRPWaXCLWr0qD6cU3peJXrIIxK+OPkMyZ/ChKFpEoZkyMZ5vI0Lq+tkxotBjGFUuZhsqqFmRAXnsKYavwl74QIuTLTl0xVihkA2jnU7ySujG0PoQ60y0G/lafGsyI+A3pLo75in0afOcc4ImSYtpdBJf/EtFY8kDd6GP9qidjuKZ3hF5vpW37CK+zfY89ZE4N9qFaikS7KYCi8dNZ3s1GWcqqOs6bUdL47hMd6TgPMAbWQGSLlIQ3Gf9iIqt5C9qa65R93HtBbLCAZItyX2qtsP6AAJgRSRGVx2a+GJCKXck5c1nsnvLReJ9W+ugHy5rU8Necvoo/Cubrg4kcMU/yNsdsxuzBnbl0yBadTelBMSYaUoaQE7/zsC2xFbfB1Wfn30Vz3mmNl7MLiNY9fZDvAApAkFoupTT7bdaggZRDOevDo+xa36udMBxgTi+JAkgWJI7kyvx1HA9kVH8FhEWzZiw4t4TME398meDAkIif2xSlCKS3sPK3o8nBPiNTUt3/i/J7KC8qKxTBCw2ttUROpxogXXfSMyt5eHMleQTmxKOJGSTTk67eebQbz0Bul7mUl8aEpPzZbVlwlznUtODNw7vy7xqsjXSIxxQK955zAoKPxV+LbDuHtYH7+UFA6J2SJUL1NvKnadq8b3vrAb2jiQ95LN3L0X3Cbu6Mw0SoxieCZTu1ScfKF6i4ihMivr+6chCYxS87mGOv8jhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(6506007)(966005)(6486002)(52116002)(38350700002)(6666004)(2616005)(316002)(2906002)(83380400001)(6512007)(8936002)(7416002)(26005)(186003)(5660300002)(508600001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ipZuDPIy5sw2+hPy+ISk5tCTfoadziScZwdhJp10P6UDSGf9Bcd0jXl4JHad?=
 =?us-ascii?Q?MHec9UU3ROErttxkqSLkfw5vzLYB5PPPBZj5HUo/ZUqMKttscCIVUuMLl+jD?=
 =?us-ascii?Q?B85s27ayBQHM02DL1Cs6sBw4eapW6AXVVQVLSW22nsJAQ/x2feCPQEXJHrkQ?=
 =?us-ascii?Q?+ASmd6z0bUX9tUW/bWprcVqU3LvrkheBuW1uZgSwbFl+IJ4YlCayxCXodCnm?=
 =?us-ascii?Q?PJqAGOXyx1KknAWHTjMecfIAQmsmstYc1N90g6DqOgQscEfdrH2JoVxAZ6Yk?=
 =?us-ascii?Q?rdX+MeCsdR0E6i8+vJRz1EiPwo50nnfZ4trGW8G73hrU0f6TN2cP3UipZBc4?=
 =?us-ascii?Q?aOdHZGCHPnPPB4R9FzwOIVMZ1lHoD9U8e4+iDZwr+erTN4sVWPAD4YTOGjye?=
 =?us-ascii?Q?dU+XaH/xA/nJChIXLVJ8mxStw7EIHwXUN6ao3qnN5mKxgOuFUBS1Ef72kLYT?=
 =?us-ascii?Q?ZBt9KIrkvz4J1akDdhsbyMaCqu+s2QIkI6BPrGQF5jTjmwqEqcezOl8oASGq?=
 =?us-ascii?Q?m1wMiVbInvCoeIYZlYLfz+oYVAqau2lLHyS1V75VsdFrX4FQQ9t+/vD7/6JJ?=
 =?us-ascii?Q?atP91FuqFteHcin6SbO2nKYfFqH5OH2DkHO/eN281w+B/70/LmwcHbRCZw/G?=
 =?us-ascii?Q?rq8v1wQLC67FzH6/eNLRo50XLsGh/oJqmSZS1OHs+iJ+z0+Jla5VpQ9iKC/o?=
 =?us-ascii?Q?uTpnCyH4DSkft+CEXbMjlB46iN07wrEDrp3Enb+bzlHiea2GXBCT0gkXaGcu?=
 =?us-ascii?Q?3+01QilFA9iO/gfmMbjr37G1kTpRUjJsfRGzkFTIfi9Uf9j6NAdjAWLbrcVT?=
 =?us-ascii?Q?bgg+koZWfimDrIWSpNbrQwTNMdEBAnXOGuF7aUhUH5TPes0O+NeJAWFYHyrz?=
 =?us-ascii?Q?nIaR/2qHBRwx4vs9uVughtMinXQ5+xYTGEZ6fta2ygMe+aBcavm+YBWxbIjZ?=
 =?us-ascii?Q?jNLJ/sVFk8LQsSlsQrvIeyktHyevYeKqotW4sbZ7hAFS0t9N+0eqmV3SxJhR?=
 =?us-ascii?Q?2C/buFKBgp+7UzPCdKWNRbVfCkY+wNj1xDrOzdqaMkV8mJRTkm7qE0Wx5F9C?=
 =?us-ascii?Q?OgdtlwPTRFWxNoFJsrlX4oKybm0sWlIUaCIVvIplp50cgs4P4u2tzbWakEyM?=
 =?us-ascii?Q?6mYIBX9fjp0d6xwC53b95CLEqqCYAkmoXNDjUTBmKae87mtdqkVcschVnMKV?=
 =?us-ascii?Q?pdNSh6CopqAVOZ9EVRmyMW5HRjulddXjO1di/FHVXxKPMNSe5o5Atm+R5C2w?=
 =?us-ascii?Q?Pg6mNAoj1mOoyaXefsOHuKRjgMD+haz0Z1IQZLShLeudizeMDkU+kh4IoNLq?=
 =?us-ascii?Q?KvEx7nLGtBjeExIFnh8kXtLGh+eVZ1YGhxXYQLAzpO51SLDPTITBpEb6hRZb?=
 =?us-ascii?Q?k/7a4RvQZ5UinLhUuHfFw4mEgapy2xr8tRk3f0znMvEjkm63rxsQ2KpehosE?=
 =?us-ascii?Q?+A8TjiuK2JgvFIRMQ0PnKG/zmm6ihxRjYBpgFiCg5xv9W+yXsXG2whWA3Eho?=
 =?us-ascii?Q?rzeFKyUGZRZ9MRmc1r9r/jt1vWqcI2By8Hq3Tl/I2fAjP0pZITNgfNYWr8F5?=
 =?us-ascii?Q?ofR4iPQa3lxL2H92mTaHFCbwLaKS8blzDKbv6hYHFv7EGP+eJpBW6pGGaznM?=
 =?us-ascii?Q?VnwbB2bhJypRzSVHogRzTRE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613378bd-bd06-4ee2-3a70-08d9fa5589bf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 00:59:14.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tTGiur6+6XcoOHNeoUsVnU7q6z5hGN39kQ9gZ3j7ydjcEc4t+5UFeV1nMv7GerdkUjkPpDd2oGy5KYp+qFPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5412
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

V2:
 Licence update
 Move allOf above properties

 .../bindings/pinctrl/fsl,imx93-pinctrl.yaml   | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
new file mode 100644
index 000000000000..66baa6082a4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
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
+allOf:
+  - $ref: "pinctrl.yaml#"
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

