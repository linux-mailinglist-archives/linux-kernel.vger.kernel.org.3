Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9A2544F84
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbiFIOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343962AbiFIOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:27 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A03322398;
        Thu,  9 Jun 2022 07:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOU06KJgTGabErWgIGVopy9B45iKQBy5jldvlpK58S5ZhnGAEPqqSEw2XtZjhnEm0LV1cbg4N9c8cPeDg16UasOWiniHAWilZPqYf6TPpdxibt79M8EjzqrId4CtpbVLyUd6shbeoqibjy+Dvz0gfXw+wAYNgX8sh6XyR0iZBQvn+rLoWbIqunM97Zgaggel1YZi475RR6Vx3Z/hF+L0q/6y8Ps2RZbX2DuPkWaVVzoIfkhL+y7z08VQFQfNg+vjDXE3ztPIFp/OMSoLNELimiSwv0TZFwY/LTIxPgKtDP9C/6KaArhh8ClR3JVmR76RVeHJVRGnsEnIJUf0Q0L9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxn6VwKm3B1HE+/6zBt/9mj0DY+8Z7EoqrVvFSKX+nA=;
 b=Tspbq0r/7RHzklQcwmb1YEkGADJ1phi15NEESssZnxPANZ4BAvH2a/aB4IZsqgwPU5nTot98JxYe0px5NyfpwPnwEbwh54lPC6lWomBhojwF4cdUOH0Xacht999pGB8Ei8L6InnmZHZ8zrrX++SYvh/NJPBVuyEzrjCTRP49R6ErGr0n7AXQh+4PtSRhGO7dXkSkTy26+ikY91G6wSHRg1TxTUnYmqNBfRC9DFow4UR/Zoihku1GFtoTrZ7py5+22KO7XYyqAePRFmtLNsbhxcauohYPatdtrHSpBEjfYGchvAyOOHN6t6aic1r7WHCaFxdLBnJRbBRuOiwHS7RB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxn6VwKm3B1HE+/6zBt/9mj0DY+8Z7EoqrVvFSKX+nA=;
 b=G3JjHW1NhjSzn7wtIfYh6xBbG5DUsLK55GkEfp+n7I6e7WpZHFZSaVzfxAskrkysNZUlKRFAQbhhjy5gtYRVvMAqL6+N9BMP4u6RkB8ukkGoU23b1ObxRexDlEC/Hx60Tq2P9OKFNP+603eGhnW19nUK8uKHbLwTz1OBnMGCfYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:00 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:00 +0000
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
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 01/10] dt-bindings: firmware: Add fsl,scu yaml file
Date:   Thu,  9 Jun 2022 17:34:14 +0300
Message-Id: <20220609143423.2839186-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220609143423.2839186-1-abel.vesa@nxp.com>
References: <20220609143423.2839186-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::29) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c7b3eb4-4cb8-406f-4b06-08da4a25351d
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB58858B6DA8335A59DD9C5A58F6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UH5NkwZ016bAkglgZw/rJTduv2pU7E5C569eiNLTtqgmNLHbMKFe2QIV2JaXZv584pK0iB5+GH1mKt5g5yCLaskS2T3JyTQLWNFGT5jSUpZL0M7m4grcoFryHOQjBXWwTH6bRxj3vhaZMf7KHX+ijOKDEjyJuHuU4xQxrgoawq48cdsWuv32VfBXX+luVGHHTJAvDWn2zLgeFBJQzWb0UBCRl/Ky5ceMCnk5UtnZSv836MpiCsNUhcjVjxvQLc4HCNkwozBWAvGSQithVotJYUQN3L/D6ciczIqKzFCmzDnM7XzTdsRCYZmZfSoni1x85pr/Yd3m+RSfUQ7AIVbhqtuLauLKRxQ2rh5Cmyy2Uw99ZLijSa7qB30UXs+sYRE0UDokGKK3sb7wDEs8KQnhqAKt7pFqFTApxTKtrNAaMQudFK3V5Pu0bLc+cXpcHfmkHPn/YjlHz47rRvjntS5Vu0TicATTIQer+GbWhhVKaXMQH1i0NOXhjSBzK87vr117R3waf+C6bpgPmL60oSPocXl+BT7dmYcLu+OmAHR4zEFSC9jDaayGv84rNNaEfBEO4ClCVJ+8tEHaTmB6vk9j3K1ZTq2EerQUMlhnQ1y97+qjKd90evXBqA4XJ9cnAi8Xelb4Ikc1MAOUwiYe77i5vCqirmUQbgn4vKJgZkuqzVlx4UqhmLrDLLrRnkkhsPuMhAWbR6zL6ZWA1XfXeHO4/FqSUWQId4iD2ylLAUyqz8eP3T+oNB2aSE9gSe9ro+37GdLugMVOqWkRNc7bzFSoz1K8GwAzxCoa8GUDxmwr5mqqswu82F7ferhl0bWh0lNc+RIzbGrC2PnBLartxwQoaJ+vfl/zMpVLWWwREGy0E4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(6666004)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QTe9Ri+ZnCDeaOIKhh/ex97dY0JMg4ETkQ/6cVY260vc6RdpIIB5/pyICgUB?=
 =?us-ascii?Q?KKHTSevkoeES1/iVX9VcoiqbmSnxjjlaDmJVqoydRg4pndyzsR7mqixOX6Ll?=
 =?us-ascii?Q?jCN8Nbw+VtGmSEeqOx6tPz0DJ/jm6/EwuskPnUMaiVq1Y/JTC0DxLuleW5FQ?=
 =?us-ascii?Q?5rFDUQsEAQ/nxlgN143J8nefzXvIRQe12iTA5Z31glTPMAq0C/KZ+CVWYiur?=
 =?us-ascii?Q?oUZ0SQEvDnAgyskRpE6Oc++5CbVSQ8o3bTVKbNlHBUui0AdEar8X8/1rZama?=
 =?us-ascii?Q?ACxF0/dPWfDP+Hkd6akCgq1+INAtaRm6YXGwCJ6Qh+i83c/sApIoVYzx6JO9?=
 =?us-ascii?Q?NG4qAeC2Cxb4TBa/a20AhDFoeItUNLvT96IZ/vkhRwccWg5196d2KoxJF/HM?=
 =?us-ascii?Q?34pvANQNGlQvBBytrHNrgvCLHW2b8MSlSDYTT1Hueff5lMdz8M+ruvpohquB?=
 =?us-ascii?Q?3nmGUrokqNgbHuPTpLzTaBeE/ceCreL9iMGxP4seaammYTjzYPxrb+BvJ1yM?=
 =?us-ascii?Q?MEPwvIrkaJXdf4HtaJCB65Fkq/O7H1RqU2ydIz6G7tzM8pHbAnQF57ZpsCYI?=
 =?us-ascii?Q?ca39nRuETHZzs8jbZFvZ+uydDq+bDh/y4cf1iywvrXUjXaBu83cj3GM6udEM?=
 =?us-ascii?Q?cvmTmNDEMuO/NmzokYxBqPq099hzXFuvj0PbIQcacP4wRG3TV7TQ2NXKWhIk?=
 =?us-ascii?Q?oez2N/RkfiKRQO2qeAZBhRZCi5NKtcAjO7U3l+snnptxL3mzbtaFBfbcDkKH?=
 =?us-ascii?Q?Ofeu4jeGp2pJMGKFXetjhdCxx/4G6wzf90kyPN6VFApfUTDlVQjPLQJaUAM7?=
 =?us-ascii?Q?aj4Y+yKL3AqWXZxY2ZiWecaRp55zvxNMaLj+5ieOjrNf6N8jbcVzf4lhKEVc?=
 =?us-ascii?Q?UUdF7ALLRwKwnxaJMXaXdoacXOnqYJiH0727OcttUvoJeQByqMMKv5/rJb2z?=
 =?us-ascii?Q?aR6cfv8DG3PIu1UGuTLDCECRkvmw/7rGbe8iXYrtJM5AkM+Cz3xv5cYSqC/+?=
 =?us-ascii?Q?5eBmx1X9pmsogW57Pegzg81q2sAfx6FIm8RczFKPGwvEfuEoPIMaOw4At/Fg?=
 =?us-ascii?Q?Idc8txpnYr5AOP/wZB8WwzbFu0EEg4VnP1kz5mD0PPfcBk8fWFRy59qgOgC6?=
 =?us-ascii?Q?VeYmnSMSAC0DxyY8+Q6UdjmPnjRnOeaw94aAz+ptaeyoJGxl0HuZ8hMfuJLw?=
 =?us-ascii?Q?yHabf0DKPMNhR7NwuKe2tPJrtvYRISpZr2dAo8Zm7/8neF5REZSmmpi27fqy?=
 =?us-ascii?Q?s24mdHr9Vx7BfsYsHNkV4Fd8AL55Zru4Td4tEZpMj4IEao7ckhhDK/DffXuj?=
 =?us-ascii?Q?pJfRTAXvD48TpomTkFSy8BXIAZMgbKAmW9iYB/OwohEDfj6+KosAaypakp1r?=
 =?us-ascii?Q?Ilf9XgE1yhL9yfH0i3frdDdH7l87edFVD1YtXytTZysTPE/F17Nxdzr7WDsn?=
 =?us-ascii?Q?M4bXkNUrQwU6wImS3PCcJ47TSNBryKzoTzAZ8g7sna7YYwboYBMibSMwP1ZO?=
 =?us-ascii?Q?6i2HrV75L+CKUSbNu/sSTqGHGAJJ/BdAao1oeMZxJREe00utoBhzveOYWtRC?=
 =?us-ascii?Q?STf7fAzSHmP6wTq8oXoTsD1wtzJ1WIeC0gJzG75bpiJsRI3MgTCVuCyLGftj?=
 =?us-ascii?Q?RAyRkew4/+UlwUqtCo0Ll60810XBsjgp0gqXWKKBVZnBcU1fBwra5jMrI+/g?=
 =?us-ascii?Q?KvafbORTCRTRtwXo0UixUMGkyuDg9t7IWjB98bf3iXCprjQJYSfRG29hyWfZ?=
 =?us-ascii?Q?yCAiSQw15g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7b3eb4-4cb8-406f-4b06-08da4a25351d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:34:49.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PQxuav0VGkJurM42McgoDsMOQSw5tu8IQpMJM8JRCP7m/tXYu7sOe7bhir3i/It0ZRXE0VX5O/7BDeu0R90GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..7dc6065a0703
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
+  - Dong Aisheng <aisheng.dong@nxp.com>
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

