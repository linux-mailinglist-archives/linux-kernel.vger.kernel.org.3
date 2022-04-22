Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CD950BBE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449517AbiDVPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449524AbiDVPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:44:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2011.outbound.protection.outlook.com [40.92.20.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D435DA36;
        Fri, 22 Apr 2022 08:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw67f1ftOXO7hUDuNgCG1vQUklnpxfImQ6jSf9KNkKBqIc9Twi++eYQt+VJOshdY99KO41j6/usHfqEaNzDYhqTJXONL7fpfqfcMBc2P0Bn+nQQ/roPp9prAnQ2gpGJc1YYA45i2LQQMWPuYRUZtsT3TJPUR+bLP2ZU0zLwBJQlxpE6KmViwMpJP2+J6fGy9aE1GjZ9cBYHCJbxi0/RuANl1ljdWGblaeQCly2CaNfPNeuoaCU/Ur9vwg638udIQBcKx8ZZ8K1M8dl8DF28WA2UjOOf5NpEfKo9BbtIEOO/6cjYgx6T3dFw/7xMYl6B7Zs5a0Zldkqvtwa+Rbpnj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTm2p+MFk4Ilr7a7VTATxmtX9R+ACnsVz/s6cAaxXAM=;
 b=HebK+11wHP0s7TIN8KvrD+pAUvyGlMT3oKjxieWSoFTPqT5NJC+v0pjXxzU6WhiabLBY0hRzsBbUS0iBlQuyu0pDss3CxQ20SVN/QUq5jHNvDXPeP9mQEt0ReFu511HxGrgGZ20s3BDEZBvBkTvS52Lx6XCrYFoYwS4ypmURy3oDqWW+vsNToEPXJmBCXhV1hpn2xp9IncklvAqV1OJNkU2re0AgVy9hRW6Dsbt+CDQuW+VS98yc5T3BQJrkxsQCxxRWgzHmI2sbxPmy8lMbgnHE622rfN/P4RSC8zSBv0bFMMwzw9eKrWoKfuy3EYw5pYcCr3vi3BPRgse3i0qlhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTm2p+MFk4Ilr7a7VTATxmtX9R+ACnsVz/s6cAaxXAM=;
 b=Op0HAj1OADVVfS6g5IpOIKLyHR5BCFWLcFk6ezQN6kEo8vKDcq3ykzkAhFLUgzFGU7z49II5wM2Ikd0l1TGAqjJDwxzi5pOhMfyk4pDoyWj9QXHXcBJugOUxjFBl7niFpdjGvTtIgVYE516WsbuG4rS9h48L7+yxm/mCj0UlDd2iX/fSW/tPkf0tO73GAu2hTYTRp1h3RR8Q9qwjhPNd5wde88wC/emImSDSypixUPY44saeht1jEcPBs0wN1mvTHn0WOEuGcK2wBTvwF5rfouVxZYyvUioyiJ6X4LSUBXTEpf1vVMBk9YUlL5BI76iX5fJWwrpbmSJigefAVnxfLg==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by SJ0PR20MB3642.namprd20.prod.outlook.com (2603:10b6:a03:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:41:53 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:41:53 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 05/12] dt-bindings: clock: sunxi-ng: add bindings for R329 CCUs
Date:   Fri, 22 Apr 2022 23:41:08 +0800
Message-ID: <BYAPR20MB2472A5F7269F56C2C6BB3104BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [IDj6LQXZCwMxsHFSJCsiVyIxb3LGFoHb]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-3-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3b69eb5-5091-4448-992c-08da24769f9d
X-MS-TrafficTypeDiagnostic: SJ0PR20MB3642:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vngYVOjLn51xO8KqrgGUVyhVUcqDxn1GDDtmx0QDt+7Tlzr4Bmw6zW+KFYHD/XBHeKeme4LdbrpACFRITnsE5YTpgSiStrdgA3XGTiNxZJKAUMjVm8JMFZhz0rPrY5EJCNhfS83IH2nLztx59i229GJmtUSJK+RDQGa2I8GkiO19c0FMvbJs9wQnmjVVQVroyAgvdJ57/yy2XMQ4ECrPBRuuHLP2sfyRAwH3NHCY/KVGSCybjnOcOW3mNvm9KQXjrbBfTuaKcctIB8ykLdNg/pqCl9c/yzVwDbn6nshaTaYjkB/ht9FsNDwwy3V37BOxM3ZzJx+ezUisIgRcbSHLjMzXeOMaqLCdoNvaymDDxILmFP0lWnkKMOiGTMaroHXcpMnjGr/rk8J9qdO4Pa61R1qMlXh+QqnaDGaoAaoFRPs4vKvPDGDGxruldIil9Z/Mk26RC+hAOZLGzwTeNp123PW//FSponU98n29+Hasv6ifQh33s/LXL1x+/rGEklQ9tsWwjGsY8QYoGjhNkEgZuElH2lwVx39D44ji3WjX+wGmvgIV/0PThCiHdz338MGS2ii/Z0C8CcjBZuBD/ozKsA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MVmhDhedSKXrWxzPGtaXXmgQB4rHvtaPDEcq0zt3PHsNwANoZMY+K9wCLST3?=
 =?us-ascii?Q?acG581poWxiAebbg5hLZyMInyV9+aA5cDJCm/mxSzzlRvTZkSoUAvz8WlVoj?=
 =?us-ascii?Q?JE6iETUC0xsiDpNZ7W28Of3i3k8L8KUJZEx228vSGQQzYCnwBaiC6Er3QnF+?=
 =?us-ascii?Q?/jotC9OaXx0GcJBZNCIeA2SpEnT8yVqA6XzJ6JRSs/wnxb+NlEjzaEFOS20L?=
 =?us-ascii?Q?wpQBXuWMA/4cvBFZQ63d/fnF93UsA5aSO83vuQeIRW1q1nhf0bPJcZxUv4WP?=
 =?us-ascii?Q?48nbhhkoc8ET/DSzOl5PDSQLy5Nn/Gw3fC7Z9yG2K2BV8DVG0MBu3+zhDXVJ?=
 =?us-ascii?Q?/jiJWdb/+DIHIExOFtzW3/wFzXguQDFQjgvAICxW5rbuPx1YIL4GbLcXjN69?=
 =?us-ascii?Q?UYF75MF4YNiqAVnlmjDu0aFTZEaNq7DL5Ky6jKkDVcw5D0OKbLLA3/FtYz/n?=
 =?us-ascii?Q?t/ecOsYI3WADwqjDjRXS7LdK0hueB26BTfXpUbsdK3Jp1PCOH0aM+bmL+ZEL?=
 =?us-ascii?Q?WqPM7POt9mMlcUnsl+eJ0OsCF3WWRrpiox6JiSJnl66IDaNZc3DyUoOrw7oy?=
 =?us-ascii?Q?VNMAN0JAVTxaMQ9PuInbLzKfboPaX+PuEnc2t86WcjkSrET/lsdW1hyEUSyq?=
 =?us-ascii?Q?hYUZwR/X0kakzUpP3jveZHIsTW2XvC8+R4gFDts/KMx3eqlkVs8EKmQxr+Qp?=
 =?us-ascii?Q?p9g6t1aTeITLiqf/BV4okyJc2e02VzNaijh5/eQE5cXHSTkmFwxaIycuQAFj?=
 =?us-ascii?Q?vYcPi6QATJGcm8B29gjzJvpA8tgV6TXkb63mBX/DjnM82GsN9BesKzkkhOyk?=
 =?us-ascii?Q?A5LtLUAlcz75ygaE7+dfc1GB2qg9RGFLaOnvtIUf6Vfq5lNezoIzzvZ5uAbo?=
 =?us-ascii?Q?B1HUATgnZ7kOj10Ff97L+Okd+iq6Cu2PNdr//hlce2fFB2T1VbzY7zTIvY/U?=
 =?us-ascii?Q?23aT0hLpSB8ckYNYBUpXvGCi3UgPi/suFeU0e5ZstjB2Em5x+DvPnVUrvdDO?=
 =?us-ascii?Q?W79BKsC6YmkNV9m812U8HJDRrJKJJlyjSAcUMi8zXWUBusXFfZbVCGvGiJov?=
 =?us-ascii?Q?bJK/2H9Kpbn0RRGfk8zuAM/jmYhc+cHyoeFPVTX7omrH5teLpZFbk/jrOhEb?=
 =?us-ascii?Q?wyZCIOXOBxhaR+XKbMRgl13J2k3icqlpaKxIW530PZMQA2OeIpPeehGN6waP?=
 =?us-ascii?Q?BHnQrNqQHaPTFMTSG5jSbE+haDIVCLRxTSVay3AidbAa6mTPxZMqjJ/dVfUN?=
 =?us-ascii?Q?QWp2Gs0MNX/3LfypljSsJhJETlw2aGXvMtuSj46EVxR/UzHZEEVqWu988sfE?=
 =?us-ascii?Q?NAetwv12N0txrE/r+Evi4+3oaHHVNxnB25WaPOHqm5LHdc0fU5VmWfY7M+62?=
 =?us-ascii?Q?5WvaLmG0aSelM+f/T6axo2R1cdYDlFGJnJinCeqkOCq43xvpZ+M8RsHIT4+9?=
 =?us-ascii?Q?Y56JOdPs9Ik=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b69eb5-5091-4448-992c-08da24769f9d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:41:53.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB3642
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

R329 has a CPUX CCU and a R-CCU, with all PLLs in R-CCU.

Add bindings for them, with R-CCU only taking 3 oscillators as input and
main CCU taking oscillators + PLLs as input.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../clock/allwinner,sun4i-a10-ccu.yaml        | 62 ++++++++++++++--
 include/dt-bindings/clock/sun50i-r329-ccu.h   | 73 +++++++++++++++++++
 include/dt-bindings/clock/sun50i-r329-r-ccu.h | 45 ++++++++++++
 include/dt-bindings/reset/sun50i-r329-ccu.h   | 45 ++++++++++++
 include/dt-bindings/reset/sun50i-r329-r-ccu.h | 24 ++++++
 5 files changed, 241 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/clock/sun50i-r329-ccu.h
 create mode 100644 include/dt-bindings/clock/sun50i-r329-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-r329-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-r329-r-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 15ed64d35261..c7a429e55483 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -45,6 +45,8 @@ properties:
       - allwinner,sun50i-h6-r-ccu
       - allwinner,sun50i-h616-ccu
       - allwinner,sun50i-h616-r-ccu
+      - allwinner,sun50i-r329-ccu
+      - allwinner,sun50i-r329-r-ccu
       - allwinner,suniv-f1c100s-ccu
       - nextthing,gr8-ccu
 
@@ -106,6 +108,7 @@ else:
           - allwinner,sun50i-a100-ccu
           - allwinner,sun50i-h6-ccu
           - allwinner,sun50i-h616-ccu
+          - allwinner,sun50i-r329-r-ccu
 
   then:
     properties:
@@ -118,14 +121,57 @@ else:
         maxItems: 3
 
   else:
-    properties:
-      clocks:
-        minItems: 2
-        maxItems: 2
-
-      clock-names:
-        minItems: 2
-        maxItems: 2
+    if:
+      properties:
+        compatible:
+          const: allwinner,sun50i-r329-ccu
+    then:
+      properties:
+        clocks:
+          minItems: 13
+          maxItems: 13
+          items:
+            - description: High Frequency Oscillator (usually at 24MHz)
+            - description: Low Frequency Oscillator (usually at 32kHz)
+            - description: Internal Oscillator
+            - description: CPUX PLL
+            - description: Peripherals PLL
+            - description: Peripherals PLL (2x)
+            - description: Peripherals PLL derivated 800MHz clock
+            - description: Audio PLL 0
+            - description: Audio PLL 0 (/2)
+            - description: Audio PLL 0 (/5)
+            - description: Audio PLL 1
+            - description: Audio PLL 1 (2x)
+            - description: Audio PLL 1 (4x)
+
+        clock-names:
+          minItems: 13
+          maxItems: 13
+          items:
+            - const: hosc
+            - const: losc
+            - const: iosc
+            - const: pll-cpux
+            - const: pll-periph
+            - const: pll-periph-2x
+            - const: pll-periph-800m
+            - const: pll-audio0
+            - const: pll-audio0-div2
+            - const: pll-audio0-div5
+            - const: pll-audio1
+            - const: pll-audio1-2x
+            - const: pll-audio1-4x
+
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          minItems: 2
+          maxItems: 2
 
 additionalProperties: false
 
diff --git a/include/dt-bindings/clock/sun50i-r329-ccu.h b/include/dt-bindings/clock/sun50i-r329-ccu.h
new file mode 100644
index 000000000000..116f8d13a9b3
--- /dev/null
+++ b/include/dt-bindings/clock/sun50i-r329-ccu.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN50I_R329_CCU_H_
+#define _DT_BINDINGS_CLK_SUN50I_R329_CCU_H_
+
+#define CLK_CPUX		1
+
+#define CLK_APB1		5
+
+#define CLK_CE			7
+#define CLK_BUS_CE		8
+#define CLK_AIPU		9
+#define CLK_BUS_AIPU		10
+#define CLK_BUS_DMA		11
+#define CLK_BUS_MSGBOX		12
+#define CLK_BUS_SPINLOCK	13
+#define CLK_BUS_HSTIMER		14
+#define CLK_AVS			15
+#define CLK_BUS_DBG		16
+#define CLK_BUS_PWM		17
+
+#define CLK_MBUS_DMA		19
+#define CLK_MBUS_CE		20
+#define CLK_MBUS_R_DMA		21
+#define CLK_MBUS_NAND		22
+#define CLK_MBUS_AIPU		23
+
+#define CLK_NAND0		25
+#define CLK_NAND1		26
+#define CLK_BUS_NAND		27
+#define CLK_MMC0		28
+#define CLK_MMC1		29
+#define CLK_BUS_MMC0		30
+#define CLK_BUS_MMC1		31
+#define CLK_BUS_UART0		32
+#define CLK_BUS_UART1		33
+#define CLK_BUS_UART2		34
+#define CLK_BUS_UART3		35
+#define CLK_BUS_I2C0		36
+#define CLK_BUS_I2C1		37
+#define CLK_BUS_SCR		38
+#define CLK_SPI0		39
+#define CLK_SPI1		40
+#define CLK_BUS_SPI0		41
+#define CLK_BUS_SPI1		42
+#define CLK_EMAC_25M_DIV	43
+#define CLK_EMAC_25M		44
+#define CLK_BUS_EMAC		45
+#define CLK_IR_RX		46
+#define CLK_BUS_IR_RX		47
+#define CLK_IR_TX		48
+#define CLK_BUS_IR_TX		49
+#define CLK_I2S0		50
+#define CLK_I2S1		51
+#define CLK_BUS_I2S0		52
+#define CLK_BUS_I2S1		53
+#define CLK_SPDIF		54
+#define CLK_BUS_SPDIF		55
+#define CLK_USB_OHCI0		56
+#define CLK_USB_PHY0		57
+#define CLK_USB_OHCI1		58
+#define CLK_USB_PHY1		59
+#define CLK_BUS_OHCI0		60
+#define CLK_BUS_OHCI1		61
+#define CLK_BUS_EHCI0		62
+#define CLK_BUS_OTG		63
+#define CLK_LEDC		64
+#define CLK_BUS_LEDC		65
+
+#endif /* _DT_BINDINGS_CLK_SUN50I_R329_CCU_H_ */
diff --git a/include/dt-bindings/clock/sun50i-r329-r-ccu.h b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
new file mode 100644
index 000000000000..c327d1a1b602
--- /dev/null
+++ b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_
+
+#define CLK_PLL_CPUX		0
+#define CLK_PLL_PERIPH_2X	2
+#define CLK_PLL_PERIPH_800M	3
+#define CLK_PLL_PERIPH		4
+#define CLK_PLL_AUDIO0		5
+#define CLK_PLL_AUDIO0_DIV2	6
+#define CLK_PLL_AUDIO0_DIV5	7
+#define CLK_PLL_AUDIO1_4X	8
+#define CLK_PLL_AUDIO1_2X	9
+#define CLK_PLL_AUDIO1		10
+
+#define CLK_R_AHB		11
+#define CLK_R_APB1		12
+
+#define CLK_R_BUS_GPADC		14
+#define CLK_R_BUS_THS		15
+#define CLK_R_BUS_DMA		16
+#define CLK_R_PWM		17
+#define CLK_R_BUS_PWM		18
+#define CLK_R_CODEC_ADC		19
+#define CLK_R_CODEC_DAC		20
+#define CLK_R_BUS_CODEC		21
+#define CLK_R_DMIC		22
+#define CLK_R_BUS_DMIC		23
+#define CLK_R_BUS_LRADC		24
+#define CLK_R_I2S		25
+#define CLK_R_I2S_ASRC		26
+#define CLK_R_BUS_I2S		27
+#define CLK_R_BUS_UART		28
+#define CLK_R_BUS_I2C		29
+#define CLK_R_IR		30
+#define CLK_R_BUS_IR		31
+#define CLK_R_BUS_MSGBOX	32
+#define CLK_R_BUS_SPINLOCK	33
+#define CLK_R_BUS_RTC		34
+
+#endif /* _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun50i-r329-ccu.h b/include/dt-bindings/reset/sun50i-r329-ccu.h
new file mode 100644
index 000000000000..bb704a82443f
--- /dev/null
+++ b/include/dt-bindings/reset/sun50i-r329-ccu.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN50I_R329_CCU_H_
+#define _DT_BINDINGS_RST_SUN50I_R329_CCU_H_
+
+#define RST_MBUS		0
+#define RST_BUS_CE		1
+#define RST_BUS_AIPU		2
+#define RST_BUS_DMA		3
+#define RST_BUS_MSGBOX		4
+#define RST_BUS_SPINLOCK	5
+#define RST_BUS_HSTIMER		6
+#define RST_BUS_DBG		7
+#define RST_BUS_PWM		8
+#define RST_BUS_DRAM		9
+#define RST_BUS_NAND		10
+#define RST_BUS_MMC0		11
+#define RST_BUS_MMC1		12
+#define RST_BUS_UART0		13
+#define RST_BUS_UART1		14
+#define RST_BUS_UART2		15
+#define RST_BUS_UART3		16
+#define RST_BUS_I2C0		17
+#define RST_BUS_I2C1		18
+#define RST_BUS_SCR		19
+#define RST_BUS_SPI0		20
+#define RST_BUS_SPI1		21
+#define RST_BUS_EMAC		22
+#define RST_BUS_IR_RX		23
+#define RST_BUS_IR_TX		24
+#define RST_BUS_I2S0		25
+#define RST_BUS_I2S1		26
+#define RST_BUS_SPDIF		27
+#define RST_USB_PHY0		28
+#define RST_USB_PHY1		29
+#define RST_BUS_OHCI0		30
+#define RST_BUS_OHCI1		31
+#define RST_BUS_EHCI0		32
+#define RST_BUS_OTG		33
+#define RST_BUS_LEDC		34
+
+#endif /* _DT_BINDINGS_RST_SUN50I_R329_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun50i-r329-r-ccu.h b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
new file mode 100644
index 000000000000..40644f2f21c6
--- /dev/null
+++ b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2021 Sipeed
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_
+
+#define RST_R_BUS_GPADC		0
+#define RST_R_BUS_THS		1
+#define RST_R_BUS_DMA		2
+#define RST_R_BUS_PWM		3
+#define RST_R_BUS_CODEC		4
+#define RST_R_BUS_DMIC		5
+#define RST_R_BUS_LRADC		6
+#define RST_R_BUS_I2S		7
+#define RST_R_BUS_UART		8
+#define RST_R_BUS_I2C		9
+#define RST_R_BUS_IR		10
+#define RST_R_BUS_MSGBOX	11
+#define RST_R_BUS_SPINLOCK	12
+#define RST_R_BUS_RTC		13
+
+#endif /* _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_ */
-- 
2.35.1

