Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7A4C0CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiBWGnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiBWGmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:42:54 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9392C6D95A;
        Tue, 22 Feb 2022 22:42:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFaEBsdy3FPCRoyU5SU28OgQVBu/ybth7+1sf80OL7+L4u20Wk31IIA6b8CzYEukZcCP/XGwpEFxQ7rGL0eQxXDPxUEEf3FTI/UPdHTJW5Li75F9RjYOwQbB9T6tDmnxYYQfiBLHZ6yoV4QBlckNg+jDimUpFDZYQLXcd88fYenAh63+FKGfLFaCsFsQHIpi/PNgcRk77WNle2Nu6w0T92W7pb/7UeNxFc0Jz4+r2QYJKDbTNv29IKluCfH+B3AS9oTLLjhpBFc/DJD0l/fTOEOcYwrjrco5R9Fz+hepvobzpN3m4zw9MmvMamfjt0GG9TxEqO5dCDhJEdzGszpOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dueg2xyemPcexX25l0BSpT6IB9dUdweTBMFcsPJBTY4=;
 b=Akd5FXAQ3SDVLGcqpYKmcU5jFCP2IuqcQ2kx2MehdSc6k7/hfYamPymDo+F2hSnbOiuzubAUS7b9KGz8h6OEF1BFQzB1f3rDOsgIMrO/nHTOvOacEFBGmpScKP8FdS0eWT00qTqWiGOcy9WRWeMCo9p6AgxO8qi+1RmqkjiDKov6AleNGEcSNbglF4fa4n8f+7+rRSf2U96Z5sC8WnXILPvW79lXY6/Dzo2s1vYEy669UMTqoRU08At65ZAgrUFBZrZHO12v/OD3O2eQMwU3W0V8agBDfo/VA5wEgjwKRsOXXSN5mjgMiS2sVyl+G9AbE/2u8LwS/tC8LTTTXpPxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dueg2xyemPcexX25l0BSpT6IB9dUdweTBMFcsPJBTY4=;
 b=Pc34D18xPlfDlKC6y4/eoGFWCA+EdR45UED90XEA/HIgbyWC1CB93QF2eY9Y1uXEgCmJICGcuSjbydpI11j9by+0Inbp6Uhz6X60r5IWYwdegfvagMU52rUgmYK01Qu6tru1o3DCQY6NBi9auHGpCkBBLh19Ub7UUV/XyeGMEVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5542.eurprd04.prod.outlook.com (2603:10a6:20b:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Wed, 23 Feb
 2022 06:42:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 06:42:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/5] dt-bindings: clock: add i.MX93 clock definition
Date:   Wed, 23 Feb 2022 14:43:55 +0800
Message-Id: <20220223064358.4097307-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0110.apcprd06.prod.outlook.com
 (2603:1096:1:1d::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ed021d6-492a-47f2-a69f-08d9f697a2df
X-MS-TrafficTypeDiagnostic: AM6PR04MB5542:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB55424E42961E78D44E493FE6C93C9@AM6PR04MB5542.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9rE2GUtC0+gDnydblz4ooHlMxwtt8ynqpTOIRcy+ZL/aTIQ+WTBy9TZCv5slJZcnnWMH7U5JK1Oir5kEKHX5O1vTkacUzVSuYsmS9JigqA6+E/R5I0CAHZg0oixcJkpUx4NFKRA0fkkIQAH4e57u/r0BDiizaHPYV1blSwn03fED2XHJE96NTaF8+HyTQ+F++M2V+aZtaNwt4fM8cRzF5s9eCYS63u2YeB3ARFW0jHGgcQcvysDqac43CYPMVeRkJ8aMFcgJRRD0PM8bPcqLpU6fAgxk3K1ULrkLEtoxHSpHcNn5ZSTn1HtslIre9N1rVOi4A2d2p3ecHSEXoahGArUDWVtS5DpppWvgkysVuuS5/T9FYIUmsVZ4t/x+l28D/meBi0TA0tNWE58jB6cjboUuPCx5oN11ZHQWLqLpUyZylu9LnYRG0brt6y9RtWhFrVE8HhkaBz4WEQfknMViR3pdJovURgziBmiNfdFXn7p/WPuwH9yHXDHwI0RHXCJbDBd8/xBXIooe4stpsfin+VXWt8IFSIr7TDsfLmoH1Ga+jyc7XD/7rLUsTWB4VoiZZdevGvITfZTbWsLdneTQw7TipVoXE9MAO1PQUOdFfZ+zrnPmBYpT+lfOW76L48vKjVTvDjwb55H9Dprt5J4kYb0kWPrrp0/47BzzJ5d5DCV1DuXOPZcKkNCVWtIey7eSihV9uuyku9lwzYSdI0UxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(52116002)(4326008)(6666004)(66476007)(66556008)(1076003)(6506007)(66946007)(38350700002)(8676002)(186003)(2616005)(26005)(6512007)(508600001)(316002)(83380400001)(86362001)(8936002)(7416002)(6486002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?94+4U1LgMloBmv+ViIaumjUnUX3SX9snof54LrjrI/D+TjvAXsEVgpIaeYEJ?=
 =?us-ascii?Q?M4q/2MKvcj/HW0VkkM8VhBTZh1C/MCU9TtMhsS/jDQmg0kILMyrjGI4or3JC?=
 =?us-ascii?Q?u8gqYZoOzFeWt8gX3k0Dpl0wHrEirFHIDikgfMkwNPuDJPVLgH49Fx6n1HiZ?=
 =?us-ascii?Q?ETnhs5lSKmcgQhxSnUvbOjb622BSmDN6i4Ne6LVxO9jM8rTQhFjxMcaYArL3?=
 =?us-ascii?Q?sInf463ZdiM3l6vUer5j+QjoYmvG+hZNq1a3El3Us45SRySkCgtDJV/2mPOZ?=
 =?us-ascii?Q?YeUJtCfm5qjNT+EZINtpzWCT0qRx4fvmgaKt5EaZKm9JfFISXTVNiHB88MBI?=
 =?us-ascii?Q?ZImWid/brsnpAGptfB0TsTcsLo6lrrRbgXZw3qGiLvxi+yGhpqAkwykUoGjb?=
 =?us-ascii?Q?2CEq3AzUvma9YFdMBhqvRcTJGcBtQj0jTuyht3cnwl64yCASEtlHlgDctbt4?=
 =?us-ascii?Q?tBrAph5X2eWWeKPbw1wiDvlC8up9I1xtm8Wdck3f6Fh/k1dknroa59ObzIt8?=
 =?us-ascii?Q?ewZ0kYoD4Qd8hMp7GR2kVMf7HluOwWvIlJmBwbEIhAQvmlCSNdzhTAdgLRik?=
 =?us-ascii?Q?jNWBAUTYfvoQOw2vP+IFaAe0V6WjR/laWWk8pKrFQhRA955dk06YPx61rOPs?=
 =?us-ascii?Q?VFesZlStyaeScbLh7AA6M8LsTz8kn8y//nNAesfbz3pS/QMXJvWoGTp9etD5?=
 =?us-ascii?Q?lkXx2iW6a3s3T7hS2RkZBo6gk5cQlhS183fUOyjSCwU6iGMVNS353wQeC7OL?=
 =?us-ascii?Q?PJy6aJan7Ug1gqDfJMj4J0oH63WVhKP8dUXgM9tDK8DNj7bhQmSIq+sJ3YLp?=
 =?us-ascii?Q?B8iqC3lrLJJ4fMg6RFHH7HtGgCIB0+lq8wyg2rhlBgcOpj3N6VENhpbHfv2I?=
 =?us-ascii?Q?FOLGMAiN6v8kHRAOeZIZYNXxVQEZInssqRhI7FD/WCVvLTP/SdYI7thiKjbp?=
 =?us-ascii?Q?Hqw8aIm8/a37Y5D1KDxcCNE0d4V7jc3by0VaLNRdO0VN4JFjstO+ZLKfDHbg?=
 =?us-ascii?Q?sBTCfTaDfpKpE2u/QrCZTTrWOuUR3fsHlFQJrL5EmgOpF//FD7SAok12ELO8?=
 =?us-ascii?Q?rw7ZahjuSE8jpZzBbG3MWOYJ8QdPGdDaebQ9SZwTOgGgu5jSHenSGNG/Iowi?=
 =?us-ascii?Q?kijLJ0O6mkseYnRxRhnVCXwjd1DovBWwg/ywYvNAOVfdXz8d++NlVglXj7bO?=
 =?us-ascii?Q?dMzkVIl5GRQZW/Dj65FWhtwC5488h2jSm0PzjjBnQlAhABR30r//Fj0Cszv5?=
 =?us-ascii?Q?58lU3zNBJBdt/FalC0LAuszLVxYK6Cg+gYqN/x8M2YYTiFn5a8CZml5IIpkP?=
 =?us-ascii?Q?9nvdx/yXCEnSa8foRRhJn/EJfIMhCDPXL7xKhMom64IT6EeLPPTCDP3Tx+VC?=
 =?us-ascii?Q?3gOBhrFUQeqbodPMDXso/9TJ/khrafT/M6Tu+4ZyKRaFTgNaq0YoeqKRqAjG?=
 =?us-ascii?Q?1CbJ0jo5kdZN2SuJ7fOzq9N58kcTemcox0VHaj4lH7bysTgu1ddt8N6LXgvn?=
 =?us-ascii?Q?r3jcquY84X0gQSa9D/f2MW7XOxbr2sbwRBeg9unijA8NXR71AtVo2HKrAHwY?=
 =?us-ascii?Q?8vHmSJLNv8JvbLC6fUaQvoUPLsnNltvE5BEXXJtxuFSoc0/K5m4iWoOBNEi6?=
 =?us-ascii?Q?z19AkmLWR5tn0qCjPw2hWGc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed021d6-492a-47f2-a69f-08d9f697a2df
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 06:42:18.4571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+n2ouE0XWNEelnOkxwE4NK43p9w4wEZwUfWmuSNM+Dq6Typ8y8wBz5pUNsau8xv0cxf0BEX6xkirXS4sxJHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5542
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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 200 ++++++++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

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

