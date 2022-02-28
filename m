Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017D94C60C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiB1CIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiB1CIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:08:10 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED65F93;
        Sun, 27 Feb 2022 18:07:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB7BoRUUYF+uuBLIxZq3gmr59l0+PIKhqp01BL1DAdMCAwC68xHmL0Ypgl4y7M9UWD0TpKwM1ZoH5aj2B1v0MPFhMGjXaGcoiMLsFYzOTZYMX7PLkjxfxqnuZmgsedJ3WiyAW1Cn2HW0GkDunSLUtt9sITthBsL2EEL4Z2Y4KOhQppeCF0d3G3N5AzMWrWB/t4mgIc2P0+BCrsmj0WD5SoF9YRn8U4PCi6MHl/aO9tlXrhne7yQaWPoRWhKwuYPFllb1UfBiWdn/BWITYekjBrxM01JIAWnlBuL2M4v5cYzOgmFQ98UNKKTOcgnMa59aVPxsLpLU4uQAH6mGR1Hkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3icRufR1+Q6GrwAJ2fyfPfGy5Q5kI4BF5mkdFzZlcR4=;
 b=NLxmtexO4/eh2R5Ku/OGpygFryvypPkgRPR2GKXwVC1qZxefR9yYItMwNizZxAjAXqMv5Ldhdai0TQ6dlp7clUVmxRF7EgRv7J5HkBOL3756SygLUN0VMyPkL8RioDoc801vzGGvtg+MWJLmo+UY8sgW29G4cXLxXXRolhWdeNIz5Sfzub8oBzmmt+VxMCqw5OIw+zTQxHpTIGAdaVkg1AL/vjtahPTWovQHN/rqjp74KiBxbcxSLyu2POQq2J59UprAbtwaVDw28XWNPOAB1EP4hfxsC+ejbIDSKwHwNAJE6CZi6mKcS8gnlO7vPcZ5kbkNWiYz63aEhHJtJRapZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3icRufR1+Q6GrwAJ2fyfPfGy5Q5kI4BF5mkdFzZlcR4=;
 b=asq0io7PwqP0qqoUBG0AZvkq5E8p4n2rPHcj4rRanZOMXHvzIYsY++01SnEvfuEZ22KyCjc1v2sMMRywKVFp1l7Irj+LcVKmqR5Q8iumsuKOWUHdpsk+P4hk9UfBsr54eU7MFCsSKDUmhNgj0ciqfNYN/vCe+I24F24kftrurp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:07:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:07:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V6 2/5] dt-bindings: clock: add i.MX93 clock definition
Date:   Mon, 28 Feb 2022 10:09:05 +0800
Message-Id: <20220228020908.2810346-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
References: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6650152e-b3cc-4c40-8595-08d9fa5f1080
X-MS-TrafficTypeDiagnostic: PAXPR04MB8734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8734BE468FEF8AFC41A3FFD2C9019@PAXPR04MB8734.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZaYAfFWWqJo6VLCyj3dtChmGu9TFN1joYp16Ys6HxYhySiHhHVAe1LRUSwLKZyZ+wMtwLNeFNsKs2YOpeJvuxJDHdrzd5L1Mu5EGzHH3cXDBKd5lzppODGbpzPWL7IFJbDhnAVowIN65U9bK6fWA/dOlbcBmcou9XlMEQykpoNElaqv8B6xB5Oi6NuawL8AXtpQQ1FzOm9wZ+9oOGNju+6yF11sEmjJpqjwVuL2F5fSayhmgTExcYrMSxcGqyz3KLia8dTkOJWndqSoyLB0+BJmfjmiKtqrVaG4oJYruXzH57wZXqzm8opWHQ+CKHMFUfMMW8knVHZoJ6kR/cYwPXJqmFFShkHyIkkj2E8F4uGE9ibH/PyAsF6cJPNTkdgLUJjCy/MiJUJ1WCvQas4iqmaodmTx5ES99FJZlUn6sV2PVoM3yWyGrpkDmjhvKLDiln4qgs+TLD+ME//8QNhLm+UQO+AVwQEczDpcZRE1ZrB08ra4/ty7zsh4FcrC1p+QZIj4OjH+UXc/qzoU5Uly88+bMleN6NVKZdmdjg6MT784T0gLdAPvxSRenwpiFWp8udeXUvrjCDi428u8fca+iXgiZqzXphTKuskD2wzREGzG/JfUmHm+ETRW2y4W/c41WcSUuUPvCacdX6SnbeEuX3NemYTJbwzumzeApVnT+yMx13xsjPP34bru7NXvZ2dRCRvbAJttrnUqi8vyh0DHvYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(66946007)(7416002)(66556008)(1076003)(86362001)(83380400001)(4326008)(8936002)(508600001)(186003)(26005)(6486002)(6506007)(52116002)(8676002)(6666004)(38100700002)(38350700002)(316002)(2906002)(54906003)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rNgja8aKj4UBMlZD6oiEQjzkoNkk3+g4aCiASkWkkP93xZCdDcumv0ar6B5p?=
 =?us-ascii?Q?Gs/vAvIuB5xttHMHYiWOBEUHVPEj0Z0W47LgHwPjQLg9ow0cr2zKZ4R/8g/B?=
 =?us-ascii?Q?u28RSxBnHerwtnIgnfglgc1jRlUa6BpgToShRofohEylzO+6ONE/BgJVa5i/?=
 =?us-ascii?Q?8xCNdwd9rhknDirG1oDtx/akkkEb2NZVRPo8zoeSgbaIBmEY2aGUI3ja6lf3?=
 =?us-ascii?Q?z5anKiFvAcRLuOFrSIvXPmjcgXGedl7cFw8TiVg5ZAz2SWW7ADxEa747gU+3?=
 =?us-ascii?Q?mdXBWKOoamU8P3ai2JYUHNsAqOgdkVvcIVXO1ngzAMtUW7BgwCihbPABmAJA?=
 =?us-ascii?Q?2srTDCjg9CgcgdBVElK3NESxegDSQVqOF6TYbbronqm9wALJsw6m8FsOvkst?=
 =?us-ascii?Q?sA/kCmUXUhQMhdvHl7pu93BRDVOIGrMAOwZOlP4xNqH9uOu2hzj0qGNhFyzp?=
 =?us-ascii?Q?GdgQCJOMt/ZPdWtK2GkJfpdlGV7tuUN5xcoWiTwtVyg55tbOz0DB4XO11tOO?=
 =?us-ascii?Q?r2OtxU7kXoWvoLAW8t+OlbmczocAZfzP5f6ICXFn2Y9ZXisicJlh/LqEIPjw?=
 =?us-ascii?Q?r+idOGEcUbU0X8nP1gZftGZLph5aafxQ6SSPJpPFqMks5PS+HmUkysL2ULtI?=
 =?us-ascii?Q?9oskwJ4EtDx6ppcL7EQ7dxJzRtLQ+cXYh9rYRrMAeOMYUvRkVdcv8daqcgS+?=
 =?us-ascii?Q?SQhlaT6JVFadoaJMIXI50bb69OizIs0wfgoUkZjfG5qFWHZ6aNMfy7cCni9T?=
 =?us-ascii?Q?bp7lhsSqPtAAsGdTQQ9E7dlRBvfS5lapnItBYJDILxgJFeksUlGJmVEauWq5?=
 =?us-ascii?Q?JnavD/hGmXzafXVXolQyIn6GmICUvJT3AHv05r+/2+Im4r1M7vD2urMXVr0V?=
 =?us-ascii?Q?G9eSAHuYGOxrqEfZJAOp20z0tnWEzYONXerMYIJT2QkyENHxg6JrRDk06iZo?=
 =?us-ascii?Q?u56dE5IuJI/jzCk3I/g6VxDeXe+P4UKbBa8BlWPfWU70nG0u8A/SH7234J58?=
 =?us-ascii?Q?PfGJF69JTWXfXfkTRM6J9vrzb2HRn9OneA8aqj8Yrg/xGF3FHHDjgKVwJTju?=
 =?us-ascii?Q?YAvb4k9ixqQZeJ7aCl79l0bYrC5UeEoWJ2KjV+58zwP+Y0lxFIRAqrvB42oY?=
 =?us-ascii?Q?pklLE0k44/NG+U8mL0ukBcbDQeE5OoLjc88H2QknJWmHRnv7BlJOxt2W9Toq?=
 =?us-ascii?Q?AreyQotELBtzbDngKP3+nmqOU+1JoDxMXPtM/gzhlz94OfZQwUVgS/gJ8esC?=
 =?us-ascii?Q?/tUJpKvDugAd2AlmXkYA7rVmzmWNp1OsuMoQ4aYurLSmKSrGvZNKBheEA+Mx?=
 =?us-ascii?Q?wNNsazGv2b/McbplTUWEfulX9JiE+yuEBLWKRpDQJk7DedYR1FbDL8VuGrSF?=
 =?us-ascii?Q?bjcsbP5p1RU1ywFAloyHiGZJXZKjbamNhkLIWRcad9gh07VjuDe6llgb8l/7?=
 =?us-ascii?Q?db8bBx0Z9zy12lNQOgGCtPvd8bIWE22MCE2eyEgfFftPH35MVxgM4lzHYpp1?=
 =?us-ascii?Q?KiP59tZcMPD2/KO4lcxF0PSP/+ETzA/byHdnK152aqP3MuEDZJLe1zmjM7Ms?=
 =?us-ascii?Q?dLNzKnw1oKPHVAn46Go+RsdpztZ8XotOo3LbbbueqaD70XtR37IApHjpPzre?=
 =?us-ascii?Q?R9XrKWwemuQbZIapDAONgcc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6650152e-b3cc-4c40-8595-08d9fa5f1080
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:07:25.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpQG8SWlPmd+g6vnYRNF8SRXLh4Rz8BDHaVDvEBeF5RGWPKtK2LgJOllYv6Wc0A14d3m5G9o8Xy5jiDv6T9A9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734
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
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
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

