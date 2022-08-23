Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5059D0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiHWFvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiHWFuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:50:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB45F10B;
        Mon, 22 Aug 2022 22:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahidGp5rTVZJdVjVPk1Mwy9mIofBb8a6DwEZ+T9nQKQBVdNAOih5P2oXXP9Y7XCspmwqcG+hQUpPufmvezGR6uGs2bJbTOEcqTvqalEmQRjLzr2/ps6pkp8z+WhK4m2mM0UgmcYUp5nXPFgoag5N8SrMd0f7DAHWvca+PwzH3/FETkUTIgS5zOTXOX/Z/UyALt7JLm1rQPTJLekjcvt7l/SYjse7oUIjQ1Ll+dD/0Qt7s4VyNw5tMceTBdi9RGleTy1vSZjKmVtv7u2pEfeDLRhE/v+KiOziK27UOMMOWsCAwzaNWlSCARHX8WwdTthqkpmukJnBx9cqpFzuVOGH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XgVov/aAL+68kSo7lADupymmzviYiPYf5BGaMcsJok=;
 b=i1Mg+RSNvH/AIm0NAhG9QvR0kXRNJ9J3NOGseea5sAaDmreayuLt3TXVmhRsMjbfLR5Pgnlgc/ph3jPoZaHUJyyVEFn8Fqj65AWkP1sqRdPGHSqcSH7yGm0ObbIiMda9TwErE0IgEKBMKxvRGROD/a7aU2Z3idpq+JRL1vU8PoNaftfQZWeSDlPm9WoCvyVBh19bL4/zd5gmqdPgKieGCXU3lJjyJpUFppONdUVus49Jq//ZYCZWW7BtYDpAXjNianKIV3a4FnphM37xGYRdG+cosbTMxOwfIVatsdtYqk4Oi2dqYzoKilvxPgScxgf76CQeRlTAc20vdsXrJygAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XgVov/aAL+68kSo7lADupymmzviYiPYf5BGaMcsJok=;
 b=GTMkkYX+FXaEcEZc+pw7dlBwbm6GP9pTjljZo/4KEI9yMXlnvSTxmQrleMt/Ib0CgbTEFx+zrr6nnfZ+V2EIpD3KGu1FXGsxyrkL4BaeEJHOpfzagIvi42beutFq/CsnhGzqOQRkh1wmgaNyqOBf9TQe6XukaFcpSC6oabsamPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:50:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 05:50:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V8 2/6] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Date:   Tue, 23 Aug 2022 13:52:11 +0800
Message-Id: <20220823055215.1139197-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f7cea21-ab29-453e-d680-08da84cb6bb7
X-MS-TrafficTypeDiagnostic: VI1PR04MB7165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDWvASwPTxp8Dc/dRDnbYojvu5IgKco9P0zuE5EvBOtfRuu4qdbCbTQ8GhkPXIVrJpWLc1jVBRBtJiYzK94d6Gl/L+gjPsviOYMl58yhlK5kQ2thnukcCUA6RZHO4ia9LRW00YApeG/wr8crgNWpLVVkDOoqqGSfX9HedMiAJH5JSzYHNbUeN3ueRSEO6FakCBIGXBmNpBKZdOGJz3qKI6EZNFFanq3OiB/rS+QokXTcfk/6Kybqlvq1LIIDtbQTqTsszevJAaLfyykvsIamG7kRMqARZKEdwxuM8xekM3AdJq3IQdx0LPD8WIakDRxlZvdO/tV3zBL54+LP/lqWb6J5wiLWaCW4z5MNLnJbsrVFbX+SzUYyohK19IzZKyXr69SBSUSxZYMmLxvHFhZ89+1IphPq4n4ocMMnYJOsVspIW5VRKd7suUQ/L0JxSbLSCgCcSSA4Im9NIfYBsDXC3aDFQrTBRf74NmqGkt5U4uFiqpdXwIEv7w9DfhLJ1F/rhUsCgK6tSGCd/xNXD+ucdSFWuCODi6x7G5zkql3OFmyXyr8ZTHzl0Ku5pel9vyp01aOK1GW+MhL1LtvLKZ2dwW8tvrOjzUzu8Mwp5cIZBy1tCsULAwv/tKKX9UN7494CMHQUnqV8ps77P+oyhG/+drRhJ7ztr8dO+YaIyg3cypsSlr9goHUQBHHj4ttFVbts/Q8Opnrh2x/Wh6aCJ7swWyviPaRDRIcRsts3XJdu0hY9O+qRM3I26Ft4Eij4dfaNd6aRi4GTQ0SjxJMsDWv7oXrGoQcGppk3wkhZGMv70p2u2nNy1LWHcOG7+B/Ltwpity84WPUJAd5WlyB8FrltWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(2616005)(83380400001)(38100700002)(38350700002)(54906003)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(26005)(6512007)(6486002)(6666004)(966005)(86362001)(52116002)(6506007)(5660300002)(2906002)(186003)(41300700001)(1076003)(478600001)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wgIpGFlQ8dq6LsGZsJcP97GjSSoTqe7ywSoG4rt9dqwy/QX0mZc/iFSStpfC?=
 =?us-ascii?Q?oga0YqKOArRJ6WOAUKooWEfWZYILwF6rAcOIzL0iDq2OELS1yukTXGeTKQko?=
 =?us-ascii?Q?Aa866+jbK7KpFjYiBfzVHigL6G0I1QhHsn0Fy2gIEXQd4Ypm0poRruV9s/O/?=
 =?us-ascii?Q?ewIDWJZ9Tw6pZFUU3ROZup98xaX/wR2A2VQvnD4OoKgtsGjcJ9YdZT+qYLUN?=
 =?us-ascii?Q?KiVxrrH7QPfzc0lmY9NQIAEdC2kScWV/my8bPVzSPudj3J4iruIzo3oHdzeu?=
 =?us-ascii?Q?0sgyF1pYrgZJtpqsJ50PFp+sHE0/1Zpqz5LwchdGQgYs6lZfeh0ZgDSnmTo1?=
 =?us-ascii?Q?H6Z9+UuU855+3xHwlMmJ2aErmtbb5g6W2Dsw4q9JOiBTJJuY4a7UmVQDPwm9?=
 =?us-ascii?Q?TYRBWXvS1btw5heniPY6lzY4Gd2ANCdchFjYUdrKPyHmJ3/uqpUj67FWB0nP?=
 =?us-ascii?Q?s9PAAhY5CehxQIQQ/jvOBi49QdQ1xg4Wz7ZpuX7y5laLIQuE0iDWPWuWCTbo?=
 =?us-ascii?Q?OJA0Ti6SphUdC74bw3EDNW+ulq2jYHaWmz+gGuegmD/EQdOffdwQ/LR7x57+?=
 =?us-ascii?Q?+f7raIDfrx2zFPsQCF0FzdHduEVidptqDwpbelYbpgxci9wXI8wkGvrtynhg?=
 =?us-ascii?Q?n8YJvSmpwt0n+jum/b1/+K070eLSombuiuxHlKFuJpOObqvXZBj0hnQNVog3?=
 =?us-ascii?Q?13RjHvxp6KQLUv0Jnx6T8aCBQjD5udWLBm/0gqdBBMuDDO6Ew21SoHBwq1zS?=
 =?us-ascii?Q?Sgn2/wWb/7aBRmaq7Fwt8vR0n6pqJeYnHe/0hyQ+m98yA/yzW8VzC5dD9VKp?=
 =?us-ascii?Q?cpAu47Im/GkQmn4nPEa9PHuREgUdBuQ4uTziXDNAp+qDuU2D1pXUl6Abty26?=
 =?us-ascii?Q?Te2kuhr4DFz/xmiDNSTygsR2H1h0xoyhugv9NPJ8w7Z4NNaT4DOHuglczMBu?=
 =?us-ascii?Q?XB1ENjXp0T6L5Pbbf+dGJrLaXa/Tmq9NucyBirLBwc3Ems/57uN3rDwwhyhS?=
 =?us-ascii?Q?P/FdRcJRkoXAwbYTHjUYFIfAzuZx+1UDBQQFkXny5wmNDSIoK5SCzM9D1rYV?=
 =?us-ascii?Q?DRDLYUgVoJo4I+YKJCra8Pm2fCZ7bEibgu/G1AY6ZpcgABUF+DHChgoHa2HX?=
 =?us-ascii?Q?DapzIEtYNPKX80AKrJFa0S/c2XHLFBzv0+KFVp5U0BSn1fLJ927zdsHI/Ho+?=
 =?us-ascii?Q?n5bHodWgHXNKo0733YbiXBduLltdaaQhdLX/E7rZEcDQmD+uarwfmTXaOxSG?=
 =?us-ascii?Q?JkGSLUu6F9eJDsmn0sCfl9YNtQW+zgMzOHIn+Yb/7bGL1DR98f4txlHrl+q9?=
 =?us-ascii?Q?m+bZJ3TjLfPtwen7d1SZqnwxrKlEaaNIFlgVCOIm8lsUCiOdhr5fXkAgBYNQ?=
 =?us-ascii?Q?BcCBbKknwHiRlY83AGcRP9C9L8KiBtsxtro3UIGHaqU+jdbsc1wrzdN7bdOM?=
 =?us-ascii?Q?JPyxTA2Yvs8t3KU44a18DY2681of98RSEyegWlX64s+zFALO8Shmo+AFMNpN?=
 =?us-ascii?Q?/xNU9QYGfYV2IdnkNrpvU0fIWxQ4q/lVRV9+A/J+Xwu7RE4Aa3/lGq5RucrR?=
 =?us-ascii?Q?WCl69IAGIP/tjbqBiZPkN50K7+c80/B8mHJ0HX9U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7cea21-ab29-453e-d680-08da84cb6bb7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 05:50:44.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR6gfXEN0kyAmmpA5JFsHfkKlRAYtLW7aDic8ej0NiGe68+MYOqVwtPq4H5978J85Nuq3RUdH6B5YdDUiMgRtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

