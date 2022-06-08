Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857AB543989
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbiFHQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343537AbiFHQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:48 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82DE140DD;
        Wed,  8 Jun 2022 09:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmbi2g1hlsAU8dB6TTnM9pEHP3YFCX3ZL3sLD/ttVCyY5hBd+ilPDWh1ZDCm/g5R5PelCzEO8LHi7YHMPfUJPETein71qySeRwSpGuS/80CGcnBsk3mreLuc2iiF0kxetBocO67ItG20wWYViXDFTTJzkOWWN9L09kFzD8sIIZwdsqPT/8w+q8mnPEWsZp8nByyaxBb9LIQnxZvEcve6nirzXonw9vaeOi5j+1TmLrRlHX7P+T72aJe0uAEKBbLk+0l4SITBjxGhxxl34NQa3cRCJApbeUljynIfWXJ0Fq5kh5mrTd6Nto64upvo6XHXazSDtjh1hYG/NI9HOoKwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/ek+qP36fySCTuhTQ3FdPxgkExddf1k50hAyWUUKSk=;
 b=HD0eU22EamZ4pzQ4l93CvkIt1jMrl6jKjElb8D7zsg5EescFK2glnc6yww/9B4jYZnATDv7aezhgEY635nocVdGEwCL3MxonoV+XHgbJMLYDwb45qV0vbIv4PXhDrheieWr0DDs3FgiUdCtj4Wc5T/VStegeZah4BZY71kKQeb17qDp23ppFp5Hr/cKA+esu6QRxkfCl8XH0NTGso9+Fg6RjLgxKJr5SVO13iZw207KeevYvcWYa9ALjpzniEjArQQQv0GRVJFkkTt3UpUrr7U9rWLvanZIEg9ZI5gerw0KTdeB1McgxdvdnQFRsSeDpbFye0Mc3gJjkyhCFw8VMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/ek+qP36fySCTuhTQ3FdPxgkExddf1k50hAyWUUKSk=;
 b=S/6snDFZNx+t+sYwXvwqMWhxiHWCP9q/p0UK46b1jmC6NjUSLDEsdJqBusW1Keq+vd26gvHQrLr74dfUXXSCzRyzYSDvI3WHfqY5BE2dHRAw6F15HV7+221Lue6JoivyN+D/5V0iTJr/FJVNlu91ehBz5I9ci21embuhL3hv7F0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:44 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:44 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 01/10] dt-bindings: firmware: Add fsl,scu yaml file
Date:   Wed,  8 Jun 2022 19:49:19 +0300
Message-Id: <20220608164928.2706697-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 243c60d4-e0e6-46ce-32c5-08da496ee371
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB74311D3A2D26C650A2187144F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m67BauRVc/dE9LvqShwGLJrHcUKR9yLaeojS3dBv2n3N/g1nHLxCKsc6NTrmwyWT7nrGjwrmWuYgXUCaHnteb/Oc8bDDJlT1wJzGb7jfIA1dLfOYOczRMZA3Oa8miluD+eaUfaaJGOS7xfg42lbZ8TfA2O6guR24uvDstwN3Vg3c2GlraimJCecL6W1I8//pf6rMSZ7koF+JZ9yL9vswxh2pzER9mhrlOkS0yqozruAvQuY5AQB3Ebx/7VIlJrN9OQ42LIzOoJBQgHlLE+aSCrLD/6O7A+0AekcRDJv/pnqqtBCDrs9nq8ymEaeFsru0drzIScfdePtWbwFLNr8vIbad/n1RVsvDZx6zGfhLm3n8eY9IKfMy+6Sml3Rt3hTV/vEB7d/PfI8ZPC8cLW0BZaj9qj0UQcW32Fz+fba+ByIsYFeFt7NemUawO+mdfYoG7jWS8gVWWDxvTfdhi/0YXI4F0If74LTbxbP3+Y8Fm10s0n2O20nTDFP3wLLOO0ppoR/jWA6GKGsmt7fgyc6jNnhVfT2o2LVaRhC4shNH43q2bZ2MgZY27GZ7nzyI+9ThWCfFnetDNmJB2/7jjijCWIKUlCrE0zTU5L+jd1jmI0swNhkf6l5bTAFN4mGg+ihoZBacJ8EL8iU24z9ENE1/mQo/galH9RELODvLlRfQEjrEN/h2IomlmfU8td6sM82l6XntWz1fKX07lraR0CCpIaGqnXG4k4Rf0DS0Cns4xLO/3wXcEfj1QmsJ1CCvGteR4yPU5hpgLNvdbeqEviC2Guk1RpEpOsDZu9fWVfaFmvM+JrvLAvJEwk1UfVTZwWN01uCcNN7s2cem145s76FdScJc/8VruZFDrT84mmOWyak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9/MSmKtOmPgdc9HaevtVlKDIc+gfWw0KhucihjhqyuBLTftWvqgx/uOp/LfF?=
 =?us-ascii?Q?l3mD+BFE9lfoR0Q2EMFyJcAjcPpa71AH9uKfKtP8hysWoGIia3x1oQGACQ9l?=
 =?us-ascii?Q?kpsZSMRni8D+mUsSAc0SbgNnyOOLIcj5NcLJGbn6nTdTmXY1pvLFiWZfKcAM?=
 =?us-ascii?Q?pOurPz0jx5bcGvf8NiVW4bGsabwE1uGzc8WMXBqqkst/6Swrjfi3ppHrjbgp?=
 =?us-ascii?Q?cEAytGtxAzCimuOJ3+rgciZJWE/nAebcYeglW7iSa5T3oLxQkvrLkQX1ztf7?=
 =?us-ascii?Q?CZCvrCjrcWgfVa1JL37MGVpsE2LC44nvPtN/puerZQH8+LoSWXkMTuLt+fOD?=
 =?us-ascii?Q?G6oSJj3tFUnk5bmrAnDp3XPQTUWVhS2jazS4OHkxKL8ByOm3ZBZu+TJYQTUx?=
 =?us-ascii?Q?pvcY7mUviBUJZUzZF89VRpSUvh0h5zZQnGBYvKpeEU88f8EgVFS73sxdBFYL?=
 =?us-ascii?Q?Ppm5Cv5ceKBGL8CNwA9beR36X6CywFjCGZNjBvIUkl5/4WADH0NxV4DatOXa?=
 =?us-ascii?Q?XFezz2OZXxV+NpUJx1LcwD/cr4CwsLGrpl7mO18C7LqvPcFmaTtHuPiOhNTO?=
 =?us-ascii?Q?U/VTQtuNhtTY3hVnjlZEchwhQmCouV0NgXUbSPxRI/o3jmybWLhkmK2NsFdb?=
 =?us-ascii?Q?2OpZkk7pbA5mzRROWRY+i87y8moSvxFi3raT/HhLaLQhkQjKWS9rWPVsBlb5?=
 =?us-ascii?Q?btoymsScEQ02QcDzbF/Nu++6whs6NiWBwvF/BCkwtBl5Dam3EgAX38pBnUDa?=
 =?us-ascii?Q?Ii928gJAMbergi+RQgI1+kW31RDbIK033TX+x3m6R2oXMm9z4HDXZVbtiUQh?=
 =?us-ascii?Q?gAdmzkiat2IAGbCw8Znn6iwchbBQ9UABu2nJ3eSRGZ9ffISm1aBD9htLdqUg?=
 =?us-ascii?Q?Wui1oFknAwIP7FJ/UdfL+MPgPLSE9TPcte7hHk+ow74h+vcc7Ub9iauc2Qq3?=
 =?us-ascii?Q?xAYMGR71zwup9P+D17djVuz3ejzTyBYIwL+ctFXMFnBn/WbrAG9iCCU8dSEz?=
 =?us-ascii?Q?DnF3lkRASOZJPYDkgX2/hWHhYBDSgntMyERpVZfec8/mu9noZUP1+l0lv3Qf?=
 =?us-ascii?Q?AOowb73MHajIdQJfoaG0+VY6zeQlPecqkFUEWR26WebknII/LRQWSzbAUQzz?=
 =?us-ascii?Q?rfRhWyEH39IEpJXgSgavK7GJP36T5JZdLuzfAtp4pvq0BkpSrITxgpuRjR9L?=
 =?us-ascii?Q?ZHtdV4InZSPAQs6ORFRusgq+g8gEakwqfOYst4pFedezKqND4ElzUhycsbP9?=
 =?us-ascii?Q?nJBXLgGGn2jC+bYdXrQRuI9eYrTQaDesoSmwWKXg5VzaZTAxrbZQs4JGyNtT?=
 =?us-ascii?Q?m/jM7nZc0yUVmEzYGML7OMZ3c54iI4U0PILRplP3/3vt23U/0dTd6rII6IhF?=
 =?us-ascii?Q?RucDzPJXZvuv1rxBiHGnlZUYob1V49DCEihQlP40p18eGoqdWEyzwxsg8dzn?=
 =?us-ascii?Q?ton/ub27bhvf/vhHOR4o5jT7c3c3lLAjB5Um5OA/QIbVQbVs49YkeMr9vTJs?=
 =?us-ascii?Q?6Adp9OZdY6UKE99E+dwOeQ6WRg+kjq2+bfUc/sZ01KC+DfsP+UrQ+sI/xUFq?=
 =?us-ascii?Q?RhwTqHGge4BXZ3JFGF+h0RnyXUS41CnL8g/CwYF1fejvYoJdHjltmOBwFV+l?=
 =?us-ascii?Q?lkSDWRiaPp7j5T2DrBxNZ5jFnJnDhKsDPw6+Gmn6YCW5TU43D2zsGQTq51WJ?=
 =?us-ascii?Q?tvI8jLt4kvxIT3greLUaaZNcPck2yai7dwdH7VXqFVgFwofrTjYmz17/5Twn?=
 =?us-ascii?Q?VqNiyCMzhg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243c60d4-e0e6-46ce-32c5-08da496ee371
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:43.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7H+2PY7sT/ZbPECRNy6LrzGMmbnXBRNeFLCOFQVn1yN3S4mBTPBUYSjCwY4iltOD++glJb4wgTdWFiLjSBcmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch adds the
fsl,scu.yaml in the firmware bindings folder. This one is only for
the main SCU node. The old txt file will be removed only after all
the child nodes have been properly switch to yaml.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,scu.yaml | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
new file mode 100644
index 000000000000..d0610887e80c
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX System Controller Firmware (SCFW)
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: System Controller Device Node
+  The System Controller Firmware (SCFW) is a low-level system function
+  which runs on a dedicated Cortex-M core to provide power, clock, and
+  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
+  (QM, QP), and i.MX8QX (QXP, DX).
+  The AP communicates with the SC using a multi-ported MU module found
+  in the LSIO subsystem. The current definition of this MU module provides
+  5 remote AP connections to the SC to support up to 5 execution environments
+  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
+  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
+  using the MSI bus.
+
+properties:
+  $nodename:
+    const: 'scu'
+
+  compatible:
+    const: fsl,imx-scu
+
+  clock-controller:
+    description: |
+      Clock controller node that provides the clocks controlled by the SCU
+
+  imx8qx-ocotp:
+    description: |
+      OCOTP controller node provided by the SCU
+
+  keys:
+    description: |
+      Keys provided by the SCU
+
+  mboxes:
+    description: |
+      $ref: /schemas/mailbox/fsl,mu.yaml
+      List of phandle of 4 MU channels for tx, 4 MU channels for
+      rx, and 1 optional MU channel for general interrupt.
+      All MU channels must be in the same MU instance.
+      Cross instances are not allowed. The MU instance can only
+      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
+      to make sure use the one which is not conflict with other
+      execution environments. e.g. ATF.
+    minItems: 1
+    maxItems: 10
+
+  mbox-names:
+    description:
+      include "gip3" if want to support general MU interrupt.
+    minItems: 1
+    maxItems: 10
+
+  pinctrl:
+    description: |
+      Pin controller provided by the SCU
+
+  power-controller:
+    description: |
+      Power domains controller node that provides the power domains
+      controlled by the SCU
+
+  rtc:
+    description: |
+      RTC controller provided by the SCU
+
+  thermal-sensor:
+    description: |
+      Thermal sensor provided by the SCU
+
+  watchdog:
+    description: |
+      Watchdog controller provided by the SCU
+
+required:
+  - compatible
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+    firmware {
+           scu {
+                   compatible = "fsl,imx-scu";
+                   mbox-names = "tx0", "tx1", "tx2", "tx3",
+                                "rx0", "rx1", "rx2", "rx3",
+                                "gip3";
+                   mboxes = <&lsio_mu1 0 0
+                            &lsio_mu1 0 1
+                            &lsio_mu1 0 2
+                            &lsio_mu1 0 3
+                            &lsio_mu1 1 0
+                            &lsio_mu1 1 1
+                            &lsio_mu1 1 2
+                            &lsio_mu1 1 3
+                            &lsio_mu1 3 3>;
+
+                   clock-controller {
+                            compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+                            #clock-cells = <2>;
+                   };
+
+                   pinctrl {
+                            compatible = "fsl,imx8qxp-iomuxc";
+
+                            pinctrl_lpuart0: lpuart0grp {
+                                   fsl,pins = <
+                                           IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
+                                           IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
+                                   >;
+                            };
+                   };
+
+                   imx8qx-ocotp {
+                            compatible = "fsl,imx8qxp-scu-ocotp";
+                            #address-cells = <1>;
+                            #size-cells = <1>;
+
+                            fec_mac0: mac@2c4 {
+                                   reg = <0x2c4 6>;
+                            };
+                   };
+
+                   power-controller {
+                            compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+                            #power-domain-cells = <1>;
+                   };
+
+                   rtc {
+                            compatible = "fsl,imx8qxp-sc-rtc";
+                   };
+
+                   keys {
+                            compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+                            linux,keycodes = <KEY_POWER>;
+                   };
+
+                   watchdog {
+                            compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+                            timeout-sec = <60>;
+                   };
+
+                   thermal-sensor {
+                            compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+                            #thermal-sensor-cells = <1>;
+                   };
+            };
+    };
-- 
2.34.3

