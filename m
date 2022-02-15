Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35F04B65D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiBOITv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:19:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiBOITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:19:49 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB39AE45;
        Tue, 15 Feb 2022 00:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASjdTBwRju0s3+x0f/j4+tnXt+lq7kcaa/CmkGSxyDf1Avw3YVpTaVCZb6nI+R/QM+ZrWIY53UGMLohCEqXeZBjNjzWL6UG3rXleKlWCNjXlLWCGA+8k/Skff8rK+InBHsuOnxUS69Oazs/TWgIQi9cpvHb4xmxv+KBFk8fmHY87nlm4IbEaH6NqzHren75dWvXxVwpUK09C1DdAx41SHJCoWLpwJxwnpIc59xEiiIT3VUIHSlrPJ5gW7/iiD65K+uJXkJO1cnr+qgMrYQgukp1GjJnT3XVgXgy2Fyaz/TLiyv8rzXUNy5SVNBj8t08G2M2jpWqWI4HFxRngn7Pcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB2m5IdQLI9wN01tWb0NREx4NNs/7f2bdif/9tp9gho=;
 b=FKgO8Z/7PRmtwA17Wt37kDV39ExWeVN4ULR0WbI6z57snrGSRiAaMayGjlnSlxARIArWEWqGtjiyA9eWr7NNpx9qQiwPqLS36IAEMSZfZSFaZlIT3NfWhQdUnH50CIDd1yjCntJI88XpW2ZwV/vJ+S9K4BRZ6PWENdG857PKi6LFU3BD46kfHJgx5DTwg7YJWCDnMa1c9rek/qvOW+Cp5l6U9xkEC0iUfA9x3gUp/QBZ7IgXm7lU8chJO6KTf5ImfOGEjKNaoByLxdGLjjYzScDBf0m6KBTrn8KyJfHemxcj5n+1kCXYwFmx0dOe+XgcHnVIe50rYIHQmlfeqwGFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB2m5IdQLI9wN01tWb0NREx4NNs/7f2bdif/9tp9gho=;
 b=K0FWfVk0HlR4V8wjNyNW4lkbUGuiHkLjn+UZG2A1blb+YfyCDb+gIHkn/KnDB+yj06mTyy3cGpyeppKf+CZkSG77rG03UJ6no1m5rExZKav3HcfkTqDqgNxigahRHy+XtPHvf0iaLtZB3D/Dd6Noku0xVBsbt8wd4+my35lS7sA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5940.eurprd04.prod.outlook.com (2603:10a6:208:117::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 08:19:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:19:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] dt-bindings: clock: Add imx93 clock support
Date:   Tue, 15 Feb 2022 16:18:32 +0800
Message-Id: <20220215081835.790311-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215081835.790311-1-peng.fan@oss.nxp.com>
References: <20220215081835.790311-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abe1d82-137a-4be9-7923-08d9f05be69a
X-MS-TrafficTypeDiagnostic: AM0PR04MB5940:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB59402B16AB5AB8E84E37B033C9349@AM0PR04MB5940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OudEUCEMzChRib8FRh86RT4LcBEc5F3Gd+8BoALGZYifbx7ci02eC+wYtjxwoN8DTJGk4EA/Nt7WeiCebwkRZFCe3rjRHD8dOGaFpbNkeMvcEKPl231vGV2+FauQfnqbiwPCMjyP2OccuWNxmPoTBaijcv2VDEwj3+3zqcCIf/8ckcPXltzSIw+OlRrFHZZID37gsBzkbJ+4mM2+f6xEx1zNzIH7NcEcuveEk1MIbuE6yd/RQjdVT3/GYT7l0RmiD+bz0/0BPDb5Boe1YIuKHwgFoq5L9KbSRL9iowHMUwif1PVZ5Yt/ANIgNJw/q166Ul8DYsLSodOcelbsHHxA8ApFqJ74/FGjFfs/roptmGGI0/3BH3NQqenCCy0lC7pm0fh4knJr4d0KB8RQ8X+W/gVjuJfBhGLEAPcTU5O6aokM8Lx0eVuu8ehdfHTmcLGB7eSnMpPg+ABa/4oAhT2rnivP9W76LdwMGn7PsZO9JaqztzfYkagh6ivJAlcWQR1krvJclHJVZC0NvAd9y86LR2Ctv99kB1LmVsex8k3eIa+ByDjzFUg+1QxQH+RnAl4XoB9Jh6CefRZyUSXlOKUDGYKfxABlPHIgX/9GWqbKqpZNSq/GqQd8FGySAXl5vNmvg0cStz0b6jkQHsvr4l40wi9BI0cr9lVmQZRxXeIp7i5ePlRE3v3Dx6t1EpTFWM+SoCvW/UO3k7QDXd1k/TY6EGZUMkNA67kStaqA7VM10W7F5LBT74lTemNJHWhazSWEm2wI2xCtimSEWgLSgNxTPM6D7Iv8vA4rCBGBt9rTDTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(966005)(186003)(6486002)(26005)(83380400001)(5660300002)(1076003)(508600001)(86362001)(2616005)(6666004)(2906002)(38100700002)(66946007)(66556008)(8936002)(66476007)(4326008)(7416002)(6512007)(52116002)(8676002)(6506007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?es++1ju+CoeIAgvjXGjTh/JlHIWQqJEUXIFOHD9VUuuJfT/Q7+Dfp2dE2lQi?=
 =?us-ascii?Q?4mFglDfmkL472LVq9PNUytrm/YXlBmFgrofmdQtbIoz3WNDOlqanczTYqS5E?=
 =?us-ascii?Q?k8LGtEcbDyTTwfqXqNPubJHwac/18U/XaQpbkffjGjFRhZIfgE8D0/yW3PKf?=
 =?us-ascii?Q?WQoUHc6WsWArmU+foYe5rH+k5x8U3I+/AVZnnGhTkHwXPUFLrKEGrlkBmxbc?=
 =?us-ascii?Q?Sf+OAANZkDzN/M2HJbnHeEQ6HSJtsv9pWDFQ1R/uyzlwjAvWzC9adPHxB9wh?=
 =?us-ascii?Q?iAkdVoWNY4f0aigFMojSmBVC5E/Zpz33VpR6K9gWqhbN7npfy2n4SgF16o5b?=
 =?us-ascii?Q?um4X+s5sk4QG6l+4pRNKM2dkdxb9OXkoGsczNRtQT5xBk7R9tgtvBF1vzH/3?=
 =?us-ascii?Q?4NnoHo8K5dDhFG5MQP75T/xZMC58lXOC/QSH1kxzKeYyNcJm1+83WUsJNVrr?=
 =?us-ascii?Q?9XMsF6ch+BX5lXFvK71bEI+3touNBcpstd/+xwmuyYiyAOBeUW0qzO9hbwiD?=
 =?us-ascii?Q?+0lC3Wawu3HbNXESTSI6qgbf9pMdi2jlaC+X8rljwuBjXXDRTfZTZv9bRWdZ?=
 =?us-ascii?Q?GJP1Hs7pDLHwzO48yGGFsL5jkuVNC4GM8e/TRwW0/iKdmhUM1k9Tiollr1M5?=
 =?us-ascii?Q?+Zqbqp9L/wfJ3QaxwFlcyt2uPswKao5GNJx2sQopTQndEeOhsYw7uZXArxqF?=
 =?us-ascii?Q?RO95zUmN2x0fv0fY1r5Nn5FIJUxy+BVYrGOJ70uAT6w53PcnjPZMEhsvdUuH?=
 =?us-ascii?Q?27BHWckxDVq57vJzVs6lwlGW+YbMTSlMX0xE2C/gxENk7zbIJUwa9YyHwNid?=
 =?us-ascii?Q?ThPlMFx/emHCpBbn+z5eA6yc4cUaEpbVdyZUfF0OeDzDAxuuUYAOp0sbeelt?=
 =?us-ascii?Q?nWh7AICsw2ALawp97OKLqCnBmcDeK9JREWeSkyUBxxNnjtNXMwm7y1m96A8H?=
 =?us-ascii?Q?2omDC3HjvIumoKbMyxogpRITlmrO+ZDfWoFNrBIOVI8AW3HVwPfqMAb1UjYs?=
 =?us-ascii?Q?KLyDUBsrO6skdUfQnv4ClbhK8apMS99jGI6Be+k3exUuowxM2jjSlSGjzK/n?=
 =?us-ascii?Q?qlphABsN6+10OAeSycuKg8TXoZ3zci/0u8yj2VRb4OSOz/JAomBHKPC0JwR/?=
 =?us-ascii?Q?mRRy6uIbT4Yfcq5M6yrwn27+4R9dj4JF+x5y7PHNUDnTHLe8SyuoLNMV5JwF?=
 =?us-ascii?Q?i6vXZIsTkmnxz8blYA6pAHBF/FF0hEBVPx33k2Ha9unKVMe0DXHhfJ96Xea+?=
 =?us-ascii?Q?uOE/OVSWhOFHjcZNfhhJ9ocuMojhtT/iq5Sq3G1eAGzjp3eFqv9mwN11a7jO?=
 =?us-ascii?Q?KlrakwZZyGzPKalFNTpMXkCGr/lCLkSSYRqy9Cs7MF7mpqe7UGXvC+2kqklv?=
 =?us-ascii?Q?ycmdaHn2pshsRKkBjjAugRt8R3Gbfkaui1lHgcIcYFdJvOTRwSV39YagwhyD?=
 =?us-ascii?Q?iV1it3yY3PpTKdjJ0PrB+tEMUEJuZkK0xeWEbSP4jHjQqeiezDNpng88CqaP?=
 =?us-ascii?Q?/MfpV0gzLkJQ5bKn6jIHQFO9ugKQBzZRVFK3LopuZpW76b13g4rOjmTnWEHc?=
 =?us-ascii?Q?AHMiN02JutOxtQrQlpB0smMAoPrnOiAfb8Ff0BcaTE6/q9RdHbNtEmyIy46b?=
 =?us-ascii?Q?TveejCOC2u41BCCFQCyMzto=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abe1d82-137a-4be9-7923-08d9f05be69a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:19:35.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UAceEOzxB3nr4uiL4vYm55/xP8Ey54L/B5vW6XtavKzCkzMDroBlNzoY0NMGF8xqi7hhFAWveCwB0+QNzPhHw==
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

Add the clock dt-binding file for i.MX93.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/imx93-clock.yaml           |  63 ++++++
 include/dt-bindings/clock/imx93-clock.h       | 200 ++++++++++++++++++
 2 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
new file mode 100644
index 000000000000..a4c3ae23b8c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx93-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Clock Control Module Binding
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  i.MX93 clock control module is an integrated clock controller, which
+  includes clock generator, clock gate and supplies to all modules.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx93-ccm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      specify the external clocks used by the CCM module.
+    items:
+      - description: 32k osc
+      - description: 24m osc
+      - description: ext1 clock input
+
+  clock-names:
+    description:
+      specify the external clocks names used by the CCM module.
+    items:
+      - const: osc_32k
+      - const: osc_24m
+      - const: clk_ext1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx93-clock.h
+      for the full list of i.MX93 clock IDs.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    clock-controller@44450000 {
+        compatible = "fsl,imx93-ccm";
+        reg = <0x44450000 0x10000>;
+        #clock-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
new file mode 100644
index 000000000000..416e6fd7856d
--- /dev/null
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/*
+ * Copyright 2021 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX93_CLK_H
+#define __DT_BINDINGS_CLOCK_IMX93_CLK_H
+
+#define IMX93_CLK_DUMMY			0
+#define IMX93_CLK_24M			1
+#define IMX93_CLK_EXT1			2
+#define IMX93_CLK_SYS_PLL_PFD0		3
+#define IMX93_CLK_SYS_PLL_PFD0_DIV2	4
+#define IMX93_CLK_SYS_PLL_PFD1		5
+#define IMX93_CLK_SYS_PLL_PFD1_DIV2	6
+#define IMX93_CLK_SYS_PLL_PFD2		7
+#define IMX93_CLK_SYS_PLL_PFD2_DIV2	8
+#define IMX93_CLK_AUDIO_PLL		9
+#define IMX93_CLK_VIDEO_PLL		10
+#define IMX93_CLK_A55_PERIPH		11
+#define IMX93_CLK_A55_MTR_BUS		12
+#define IMX93_CLK_A55			13
+#define IMX93_CLK_M33			14
+#define IMX93_CLK_BUS_WAKEUP		15
+#define IMX93_CLK_BUS_AON		16
+#define IMX93_CLK_WAKEUP_AXI		17
+#define IMX93_CLK_SWO_TRACE		18
+#define IMX93_CLK_M33_SYSTICK		19
+#define IMX93_CLK_FLEXIO1		20
+#define IMX93_CLK_FLEXIO2		21
+#define IMX93_CLK_LPIT1			22
+#define IMX93_CLK_LPIT2			23
+#define IMX93_CLK_LPTMR1		24
+#define IMX93_CLK_LPTMR2		25
+#define IMX93_CLK_TPM1			26
+#define IMX93_CLK_TPM2			27
+#define IMX93_CLK_TPM3			28
+#define IMX93_CLK_TPM4			29
+#define IMX93_CLK_TPM5			30
+#define IMX93_CLK_TPM6			31
+#define IMX93_CLK_FLEXSPI1		32
+#define IMX93_CLK_CAN1			33
+#define IMX93_CLK_CAN2			34
+#define IMX93_CLK_LPUART1		35
+#define IMX93_CLK_LPUART2		36
+#define IMX93_CLK_LPUART3		37
+#define IMX93_CLK_LPUART4		38
+#define IMX93_CLK_LPUART5		39
+#define IMX93_CLK_LPUART6		40
+#define IMX93_CLK_LPUART7		41
+#define IMX93_CLK_LPUART8		42
+#define IMX93_CLK_LPI2C1		43
+#define IMX93_CLK_LPI2C2		44
+#define IMX93_CLK_LPI2C3		45
+#define IMX93_CLK_LPI2C4		46
+#define IMX93_CLK_LPI2C5		47
+#define IMX93_CLK_LPI2C6		48
+#define IMX93_CLK_LPI2C7		49
+#define IMX93_CLK_LPI2C8		50
+#define IMX93_CLK_LPSPI1		51
+#define IMX93_CLK_LPSPI2		52
+#define IMX93_CLK_LPSPI3		53
+#define IMX93_CLK_LPSPI4		54
+#define IMX93_CLK_LPSPI5		55
+#define IMX93_CLK_LPSPI6		56
+#define IMX93_CLK_LPSPI7		57
+#define IMX93_CLK_LPSPI8		58
+#define IMX93_CLK_I3C1			59
+#define IMX93_CLK_I3C2			60
+#define IMX93_CLK_USDHC1		61
+#define IMX93_CLK_USDHC2		62
+#define IMX93_CLK_USDHC3		63
+#define IMX93_CLK_SAI1			64
+#define IMX93_CLK_SAI2			65
+#define IMX93_CLK_SAI3			66
+#define IMX93_CLK_CCM_CKO1		67
+#define IMX93_CLK_CCM_CKO2		68
+#define IMX93_CLK_CCM_CKO3		69
+#define IMX93_CLK_CCM_CKO4		70
+#define IMX93_CLK_HSIO			71
+#define IMX93_CLK_HSIO_USB_TEST_60M	72
+#define IMX93_CLK_HSIO_ACSCAN_80M	73
+#define IMX93_CLK_HSIO_ACSCAN_480M	74
+#define IMX93_CLK_ML_APB		75
+#define IMX93_CLK_ML			76
+#define IMX93_CLK_MEDIA_AXI		77
+#define IMX93_CLK_MEDIA_APB		78
+#define IMX93_CLK_MEDIA_LDB		79
+#define IMX93_CLK_MEDIA_DISP_PIX	80
+#define IMX93_CLK_CAM_PIX		81
+#define IMX93_CLK_MIPI_TEST_BYTE	82
+#define IMX93_CLK_MIPI_PHY_CFG		83
+#define IMX93_CLK_ADC			84
+#define IMX93_CLK_PDM			85
+#define IMX93_CLK_TSTMR1		86
+#define IMX93_CLK_TSTMR2		87
+#define IMX93_CLK_MQS1			88
+#define IMX93_CLK_MQS2			89
+#define IMX93_CLK_AUDIO_XCVR		90
+#define IMX93_CLK_SPDIF			91
+#define IMX93_CLK_ENET			92
+#define IMX93_CLK_ENET_TIMER1		93
+#define IMX93_CLK_ENET_TIMER2		94
+#define IMX93_CLK_ENET_REF		95
+#define IMX93_CLK_ENET_REF_PHY		96
+#define IMX93_CLK_I3C1_SLOW		97
+#define IMX93_CLK_I3C2_SLOW		98
+#define IMX93_CLK_USB_PHY_BURUNIN	99
+#define IMX93_CLK_PAL_CAME_SCAN		100
+#define IMX93_CLK_A55_GATE		101
+#define IMX93_CLK_CM33_GATE		102
+#define IMX93_CLK_ADC1_GATE		103
+#define IMX93_CLK_WDOG1_GATE		104
+#define IMX93_CLK_WDOG2_GATE		105
+#define IMX93_CLK_WDOG3_GATE		106
+#define IMX93_CLK_WDOG4_GATE		107
+#define IMX93_CLK_WDOG5_GATE		108
+#define IMX93_CLK_SEMA1_GATE		109
+#define IMX93_CLK_SEMA2_GATE		110
+#define IMX93_CLK_MU_A_GATE		111
+#define IMX93_CLK_MU_B_GATE		112
+#define IMX93_CLK_EDMA1_GATE		113
+#define IMX93_CLK_EDMA2_GATE		114
+#define IMX93_CLK_FLEXSPI1_GATE		115
+#define IMX93_CLK_GPIO1_GATE		116
+#define IMX93_CLK_GPIO2_GATE		117
+#define IMX93_CLK_GPIO3_GATE		118
+#define IMX93_CLK_GPIO4_GATE		119
+#define IMX93_CLK_FLEXIO1_GATE		120
+#define IMX93_CLK_FLEXIO2_GATE		121
+#define IMX93_CLK_LPIT1_GATE		122
+#define IMX93_CLK_LPIT2_GATE		123
+#define IMX93_CLK_LPTMR1_GATE		124
+#define IMX93_CLK_LPTMR2_GATE		125
+#define IMX93_CLK_TPM1_GATE		126
+#define IMX93_CLK_TPM2_GATE		127
+#define IMX93_CLK_TPM3_GATE		128
+#define IMX93_CLK_TPM4_GATE		129
+#define IMX93_CLK_TPM5_GATE		130
+#define IMX93_CLK_TPM6_GATE		131
+#define IMX93_CLK_CAN1_GATE		132
+#define IMX93_CLK_CAN2_GATE		133
+#define IMX93_CLK_LPUART1_GATE		134
+#define IMX93_CLK_LPUART2_GATE		135
+#define IMX93_CLK_LPUART3_GATE		136
+#define IMX93_CLK_LPUART4_GATE		137
+#define IMX93_CLK_LPUART5_GATE		138
+#define IMX93_CLK_LPUART6_GATE		139
+#define IMX93_CLK_LPUART7_GATE		140
+#define IMX93_CLK_LPUART8_GATE		141
+#define IMX93_CLK_LPI2C1_GATE		142
+#define IMX93_CLK_LPI2C2_GATE		143
+#define IMX93_CLK_LPI2C3_GATE		144
+#define IMX93_CLK_LPI2C4_GATE		145
+#define IMX93_CLK_LPI2C5_GATE		146
+#define IMX93_CLK_LPI2C6_GATE		147
+#define IMX93_CLK_LPI2C7_GATE		148
+#define IMX93_CLK_LPI2C8_GATE		149
+#define IMX93_CLK_LPSPI1_GATE		150
+#define IMX93_CLK_LPSPI2_GATE		151
+#define IMX93_CLK_LPSPI3_GATE		152
+#define IMX93_CLK_LPSPI4_GATE		153
+#define IMX93_CLK_LPSPI5_GATE		154
+#define IMX93_CLK_LPSPI6_GATE		155
+#define IMX93_CLK_LPSPI7_GATE		156
+#define IMX93_CLK_LPSPI8_GATE		157
+#define IMX93_CLK_I3C1_GATE		158
+#define IMX93_CLK_I3C2_GATE		159
+#define IMX93_CLK_USDHC1_GATE		160
+#define IMX93_CLK_USDHC2_GATE		161
+#define IMX93_CLK_USDHC3_GATE		162
+#define IMX93_CLK_SAI1_GATE		163
+#define IMX93_CLK_SAI2_GATE		164
+#define IMX93_CLK_SAI3_GATE		165
+#define IMX93_CLK_MIPI_CSI_GATE		166
+#define IMX93_CLK_MIPI_DSI_GATE		167
+#define IMX93_CLK_LVDS_GATE		168
+#define IMX93_CLK_LCDIF_GATE		169
+#define IMX93_CLK_PXP_GATE		170
+#define IMX93_CLK_ISI_GATE		171
+#define IMX93_CLK_NIC_MEDIA_GATE	172
+#define IMX93_CLK_USB_CONTROLLER_GATE	173
+#define IMX93_CLK_USB_TEST_60M_GATE	174
+#define IMX93_CLK_HSIO_TROUT_24M_GATE	175
+#define IMX93_CLK_PDM_GATE		176
+#define IMX93_CLK_MQS1_GATE		177
+#define IMX93_CLK_MQS2_GATE		178
+#define IMX93_CLK_AUD_XCVR_GATE		179
+#define IMX93_CLK_SPDIF_GATE		180
+#define IMX93_CLK_HSIO_32K_GATE		181
+#define IMX93_CLK_ENET1_GATE		182
+#define IMX93_CLK_ENET_QOS_GATE		183
+#define IMX93_CLK_SYS_CNT_GATE		184
+#define IMX93_CLK_TSTMR1_GATE		185
+#define IMX93_CLK_TSTMR2_GATE		186
+#define IMX93_CLK_TMC_GATE		187
+#define IMX93_CLK_PMRO_GATE		188
+#define IMX93_CLK_32K			189
+#define IMX93_CLK_END			190
+#endif
-- 
2.25.1

