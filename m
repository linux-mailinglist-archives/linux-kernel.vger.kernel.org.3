Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1555B4C3B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiBYBld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbiBYBl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:41:28 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFE1294FD2;
        Thu, 24 Feb 2022 17:40:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2n3hVFHCp/7Plak/ErZ9eJJkc0shqtYMdlSn+vAtRLa8LlKI8pLPABb+tyEmg/t81Danx7jCiOZSt/31E3Gw7kLb5V+MwOs48fGqtYgYHmZWphnRS+Pw5XEtu6ARYEPtr2BRQ4WKrvcE2V3PeEWSxQ/0Ce+Rm7yQlMWcC+R18VwOxW0ReHHJYEWFf6+IcBe0t/8NJ1H3gu8CahV/1RaCtnIIQeUiOcft4si7zm7I8XXpLyA8v0bhkEtCSg42yt62toSQf9Xh2zPf23KV80UdQj2CwhR7bNvZ13z0iGK98x/HNdknOgo3bx4ilz/7o54G4q4c+PAA6otVxVGPeCq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoGw+pt5GV/yatYjec2iLBkRZMn7BMljR1MVO4EMpOY=;
 b=fK8j/LI0q1J9unu4uwamCE+Uhl+JqAaZJEmhAf2r713z9SgRL4pwuJBrYlp7ls1XaZM9m09BpGeXv/WcYqgLZVH1LxWGwWXZzDhIArcqijV5KOgaFdF8sy+oLtj4VHoOIEwYyR1Y5h1bPC7Lb26YpRfXftw28XYOo97BSCNjCS7t/plXgzLS9Ta6HlzrmShadOIvuzDejxaRnYtwXEh6qzrLhQVfWjhdm/Q/4j7np8OEGCusc8IvSssi3ke4FRh0yKL4VNU0WwRZWxCyyjddHJ+tSUaJ8TfSfTBtLtG+ATycEo3Fvaru45ksyGv5Dl/Vw5UXaAv3EG9pLWeItg5POQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoGw+pt5GV/yatYjec2iLBkRZMn7BMljR1MVO4EMpOY=;
 b=inqxpbY/NI6l6u6wYfswQucIl4qhd9p2e6LWumce5uEjIiSirQKQOYW5r3lvfw6oEmAlvoPaj9s9EDesOtczHDBwhftbqd73wk0qU5GHv93nFcj0OnPEk3UcFYuga+tZon+kUu2CUpHEakv2k6+q1cK+3ddoW26t6C22bD1PZwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5316.eurprd04.prod.outlook.com (2603:10a6:208:d0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 01:40:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 01:40:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V5 2/5] dt-bindings: clock: add i.MX93 clock definition
Date:   Fri, 25 Feb 2022 09:42:31 +0800
Message-Id: <20220225014234.1766305-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225014234.1766305-1-peng.fan@oss.nxp.com>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc20c47-6db5-4fa5-bcc9-08d9f7ffdce2
X-MS-TrafficTypeDiagnostic: AM0PR04MB5316:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5316BA71A56CED9C2DED4B57C93E9@AM0PR04MB5316.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SksYIFLHSDMYTqfrDjTw0p+7KvsHdT7aJH/CaT9VFoUjXTcfOk1mAGZYwQ9MK/yMhUvzllckXwCk509F3C4OgAa861+esFBd2Aixcg3616nzglj7XK9Ac3xQ+ZTVK0FfzWuVSwALYSIFTBm75UFkgS2Ij8RhVRm3vc99MNFuDL6rQbOW9bnsfTnAokp/P41NtkRAOx6SToCyKfoYU8G3GXEh16cNhzIA1XASywZtW68gwyBRt6u6vh5QG/xQvMydmMY5jFbycLTo5bt3B/xeEP2V9brmh/RjpbkdUVcIO/04DTrH6hD4BVp7zsGJkrYMt76tBJJ87dxJeH1WuzQgtA7Y4grzey0R7xW5yYRupglnev2zV6pNKM4zMdTzNOgxUqYjfPjaANmrrWNuB+dDJ3SHBPMletv5/oJLZ0Ly1ZtcNOdZTgbMYqXZmcU/z4VWqi0iGol5A1thSxCUfzB11qZNaXkXtcNLMcUPv+iyd/3hkjcwpKO3lDLKgewzn8aRu/ZTGGEKYhh2FocrGMhIVixD+H64utSpBeYV7nC18LL7zAXdOPwMKehFbfb1E7qWaxUsY+Mw7tlIK3/apSPlt2VhTxuHYCd749ghUUr3c9xQqZ6GGKEcO5p+9K2zXeuv1PO/PiAxVk26g//RriAsMbVdZsgpEXNAX/ISK3h3SE61bH2V5QyJm3tEZLn1+8e1o2Q4k1FJWtXFxEtP9V57hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(38100700002)(83380400001)(38350700002)(54906003)(6486002)(316002)(66946007)(5660300002)(7416002)(6512007)(6666004)(8676002)(86362001)(66476007)(66556008)(4326008)(52116002)(2906002)(2616005)(26005)(1076003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2zfAe21PkkIhL/4KCEBC5DUKKj/pbb3cifGExhAHfk9nux2EVZxbHLSMFB8q?=
 =?us-ascii?Q?WHto3bFDKqhKe89UpYj876plTM9y8Gy/BmAlmAjYDBfr1J+lnKPLXhsYQFtF?=
 =?us-ascii?Q?1WgRN+EkSdUTnXiZqEb4LsBumj8phb2ZVmxr9HY96eTlwhDgkFJbE3aQpMfJ?=
 =?us-ascii?Q?MulSOojt8bfC1XMTLd9OkdZcaqzUQq8OQ8Z9tI0OrTjxMeQMz+E/++8ELoyb?=
 =?us-ascii?Q?PJucaWGI2ZM64z+6+A/Q58lx0d/ibwxS1h01NNP8BDraWLLZnE7mE1IRz46c?=
 =?us-ascii?Q?MHchENanhGIiXYLCmzTVI5mI3+MLFov1rHZFnHHSAk8oMcwZLLPob4tqTdo2?=
 =?us-ascii?Q?dtzHfiJrqDDR8jasf6ewW3GgBHaphTaXvsJpDDsn1RanagH08pau89YkIi1G?=
 =?us-ascii?Q?IyQtJOKKHC/KEw9BmDvti38k4tLZNNLUIzt9oOgLVDriWpgiav26nOcrScQv?=
 =?us-ascii?Q?UzV6RreDpFTfHpXZUlFUJ4Hr6IPunrkvgSwKs/N4Ma67mK3FvDPOD5Zv83YV?=
 =?us-ascii?Q?XMrRqDyOVwlRcg2SaJuD9ZbPfBrQNFtfZO72h7RoT9c1XtnSqU4gdiRSXf7h?=
 =?us-ascii?Q?Dc24dxuMZLh7d3MvQp1wIDvZI0hCVSeM1NGn5OGiioyK6jwvL0djyIOph2fx?=
 =?us-ascii?Q?y/VRdurTrK7vBDCEDLfpUoifg5/4fRpQcxOyqkjuwuL89+Qe0SJHTBH3RowB?=
 =?us-ascii?Q?Dxz4///Kwtgk+Ay7XjGx6oede2iDXyG6iv6RJNKSyxsWcU64am4ig4MAiyGg?=
 =?us-ascii?Q?jFdL2b/Z5oNHQkcZ/vRohtpONn5eUWi2V4mrLBEawierXIPXWKua92HjGy/A?=
 =?us-ascii?Q?ZfykJ4bENJcjYB7GXkvoYRxBWUO6rgz7emYzAf9oCh8+7PK+iribbP90oN6j?=
 =?us-ascii?Q?3LbKhJNnCdPyiuZnp5HxFB9SBHhHvTj9i2LZqDBK+Q+y7vOjfLynz+4wbIWk?=
 =?us-ascii?Q?y9OgtI0f8z18w9H3KNDLnoPDAbLNAeifQdsdPxPNiQv9KwYSmNVtLq6F9j4n?=
 =?us-ascii?Q?8tlC78VFjfQ/JI6b98AD3a3Egrj+XWJ/gjPDG4nA0rb0dUHOa4y50WAYfDAO?=
 =?us-ascii?Q?e0Ror688tsQp73yd6u1ctDPWnrjubU2I2/mlERy3yD9uDaoEJCsDsSNdrxSJ?=
 =?us-ascii?Q?ALWOwRublU1Ikj8gxOcVj8ZFyFKSJvRljxmfHRFEDXKG4+/6L0ce6rJnsq85?=
 =?us-ascii?Q?yx8DLYfKH9ljkIXkQNzkzQEWgNJihDyfXyMDqXEX67Y6vxUvCf+CbHS5Hdup?=
 =?us-ascii?Q?LULYM9jsurEiLcp5bUMKCwEq8E/PRYEXiyLMkK+mAxbUemLkjkigVhzDTKcX?=
 =?us-ascii?Q?tmAckXip2h8wXJAaKRrZEzXEBQz9kttRktTFv9GwixCv7wNOFGDk3oShHGcN?=
 =?us-ascii?Q?gUC/HGXPeP5MCSLMgXaXFPRXMk/MOWclDvVcqlQZSpxAp0gzsjNgIi2FbWhX?=
 =?us-ascii?Q?9OUaRICLROH314TPNuQd4CwwVHIHdPv2w7Jq1Yz3fPfN3dkOmCI0cjbIwMeP?=
 =?us-ascii?Q?L7q1s5VVNHroq8OEYXSCd/4qmqIutB+I+SwHIoEpupw7mF7k1Qyx9f9wI1JF?=
 =?us-ascii?Q?WeTF1mgaaFcBNX4njzVvzrvpoPb7Hz4mqsSP/kGtj2xZspqn1a5YB4+kojn2?=
 =?us-ascii?Q?hbQRLFOS+xTBlC8RZtdKaSM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc20c47-6db5-4fa5-bcc9-08d9f7ffdce2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 01:40:54.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3F6vfuRS7mynTXCbWaOpAGq2jTVkG1jbaXR/DRsbyXfmeGgJZiih6sdtk55SRicxXNbCS8JVAqHFP7yq+rdUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 clock definition

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/imx93-clock.h | 201 ++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
new file mode 100644
index 000000000000..21fda9c5cb5e
--- /dev/null
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/*
+ * Copyright 2022 NXP
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
+
+#endif
-- 
2.25.1

