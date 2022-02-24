Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523EC4C25CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiBXIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiBXIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:21:52 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B85C26A38D;
        Thu, 24 Feb 2022 00:21:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkjxocKG8pkO75+86iHAf0hgJRAQWufCP0OPixRTtBXn9xsRHTrdCDpPYDHLYikSjYPKz7ORfbwNcUu2I6sTLeAteNoFMkURh/XXOjunh4rX7m57O2ORDwRlpGaPbFqcNXDtSzfibm0IJ9EMJcZJ+WCeer4qgP+qUgAjUA/sOdoe6HtwQgQrImI4gKotomfYQ+4DSQUWrWcDi0/v6vw4h1ogPt4EbhrodQvDZAzGGK3z71CND02/jipb2f/6PDmFNvRNGnpsxb2KoY+/MdHu/gz1lhP2kxbDnqJnkV2mDULhaHhhz63vxwORI80HWOwNU/krW9NsZwZdN+v08x8zuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsIoD+Rm35M7bCVMdlHQ/gLxalO1B+CIoUQOhx7X3kE=;
 b=RPIHwV1wpbLgo5aeSh+QIQqE+9zLBMC06FXbHmOB+/mxipVmcvSnkZ9JYMH+ORqf6utS2ISahUk9MRByhYDNbP37M6T2jVHuHFzmmd5FHfnD0G+z59A9Su2eTFybQCaD0htqc8xV+F/7H1kf0VjQuRuhd0fhzCaWHOooUcNHV5p8kGEkDcgG/prvD8oKsMzagUP8wBVRX0t8+GsMgghfM4e7Set/JHy1HMLC0FQbGmVfcpvGiYzuGArzB0qu9p2IdHG7uaS9awQi/tZmUFH0R3o7XXT72UfNnIlBSAZ/0MGH0IHXMysl7D7Q8wogNrM/dY//7JYuLdjAyVYvQMyWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsIoD+Rm35M7bCVMdlHQ/gLxalO1B+CIoUQOhx7X3kE=;
 b=jRT1LEG9GulHgiYVeDCaYpO/ZOZfS21SG7ihHxfQdaPTNd4Z2V5wvPGAfOOAh00mecbrOOrJjSJByqEBZkR507rD7YFYXnCltfUnICszPPLC/tPBwcWf5oGsvaHgwRaL9yCZyb4e0yxbK6fsYGr5p5QlfZOQFlQJi1/J1KkflKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6423.eurprd04.prod.outlook.com (2603:10a6:20b:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 08:21:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 08:21:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH V4 2/5] dt-bindings: clock: add i.MX93 clock definition
Date:   Thu, 24 Feb 2022 16:22:48 +0800
Message-Id: <20220224082251.1397754-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
References: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0147.apcprd06.prod.outlook.com
 (2603:1096:1:1f::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae31402-6d7c-4272-64e8-08d9f76ea119
X-MS-TrafficTypeDiagnostic: AM6PR04MB6423:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB642330E0D4146156B83EC08EC93D9@AM6PR04MB6423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owMrwQuZzBybh7BXNevhj+3dHrkGZZnvdD8qsjNT3u5L2ELdMUnIjY0lMeEnlj60cIlxrNphlZt9OYDskApMQ+kw6ZQZnLU5VOOfS6FUua1tEprgEgtIIEHLbPftyXpihj3eo6GZWVtOeuM50T0NccGT50lsy3Ky0VJn//J/igYbbh3s0StilcTeYX3Xtbsb0k6qnrurOYJu3QGfkdsSJz39KcTEQolOqScVOZ2qRlY3otZ2I7GJl+5X+JuHutFyBm+v8ZeDECxA2FkwzhqhE5Z12cF68ZOvRnhztadmpBS2d9m3ltl5tdoR/pNNTokeNi/HPrJ+jSoG3jiQU0o4+BMs1lune0ECQXQCLiTSuGATzUz4dsDDbReAsg6aSiJZmdVH0Ej9qbi3igcuaINeKKfM1BhBrrQNbNRbcQFk3EQtzGEziVXDvkbvsB6UoW62KAB6EnCQiABICkEcUHJBwct3S5Ox6f1ejAQCknypSwSIg62+XNQRDLLDz3THfHr7+o099Jl1/NWS26iVe9QiOGmNnfg+IV7IkSGts24WmkHa/Z2/dV+ou4UcShyt9UTYppJDUdg/dpn80RsnH21cLPG7JqzP8rfx9mPDctRQJxUWwVcv/p6GPQuu0AcA0lkJLDmGkntXU1dVXwFLAi3l0+o8G8He3+lkLjjScn4Jg1M5G/EXx0THrphvSMZKcX7tcUbKsqhiY8j7rK5fdw6ZkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(1076003)(6486002)(186003)(54906003)(5660300002)(508600001)(6666004)(4326008)(26005)(6512007)(8676002)(7416002)(6506007)(52116002)(8936002)(66476007)(38350700002)(38100700002)(2616005)(86362001)(2906002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgR0o6E9XoQucOpFNwlxYaLWBZIHmrFsgsGfJmHpmRXys87YsV/oXRPM17rA?=
 =?us-ascii?Q?QAc2iDOaq3pTzCJtOM3VNN3OGwhOPBjNV4yMXZ8dmXEQZ9KsT+GPa1zYq8uP?=
 =?us-ascii?Q?aFfxPCZJfWEMPU8DP9kXz7fv4n6KvMipvRtQUSldnjsQXET6y7ZgaSJnSyoO?=
 =?us-ascii?Q?nRV7o/R1hGY0QPJzhw2WytfT4mbYbWLacEVReByscTn2Uon90fPvqkT/qm5y?=
 =?us-ascii?Q?rQxdnun2zu2ywIyhD+MYAWCMppa2WXxjBqou1yLaXaWcqu4lXxYSIwjlE4kj?=
 =?us-ascii?Q?nXvlUza38D4T8z4vTgwD1n3WlnT+7rmcnLVB2BnkL5nMDBS762qxF1IFXSvl?=
 =?us-ascii?Q?YTRzD2D4qMXuzH0fuYyZzDo5kDIKGsFsRGrlJHOcfNWWgV+m7IdqrZsqH7id?=
 =?us-ascii?Q?KwhSRnoS1+qiWCGHaawNFMA2vUCMyBLNKmN4VIIQYIVSpALgPDNYaobKA3mh?=
 =?us-ascii?Q?/ZVlI4mC15/lu1vaRTihgnXqY4Za9LAZ/7hBAeTy64GgXVv7rHg6q56xcki+?=
 =?us-ascii?Q?yN7CNAZWMaBqzPxvgc1otqDbNH8UBtStR9lmdCzcZfV8dx2fCXzUXGKKMbkN?=
 =?us-ascii?Q?gRikoUHj/u6eK243h05xhFGQ7NmFDKYTnc7nTK4ng9W4OvYYbEp8swh8lWIP?=
 =?us-ascii?Q?TZeLMK8oJ7kddjmEBATk2ylNGlKeIphbb+sQS/pdpwbuKJbVAXa10deGHPmW?=
 =?us-ascii?Q?x37tzC2R1zCDGgO0f6grZ9SG26h7zVrNZbMt4dmk2tVN2A+QqS2M5rnol+Pf?=
 =?us-ascii?Q?obk/1s+xJCvruOKYgp/STKSILi34+zSDZWeTe37Bz+qECCxRGwwXjPGkMqfz?=
 =?us-ascii?Q?p0vskpxMyoiWsBoFK+TgU2f0BXQOTD0sSUkQyKERl4fzVNrA0dzGthln9VEw?=
 =?us-ascii?Q?A73RclldU9D8w3KkONtD2+Sg1anj0nIIm4vpWq/s/ZmkVoOPPoPipTU6BxkT?=
 =?us-ascii?Q?/A5AOFrbgn9wHDCBlh7YO6NG9n9xZyt7X9Pje5qmUxFfvvxwzEFZCBccIwTG?=
 =?us-ascii?Q?fS8hkRSwkXV9iABtmLoUyigjsFBNIUwKSsQr87SIdvJstFHOYiM4x2nbP8XU?=
 =?us-ascii?Q?vjS5Q3KQIJY8PMcgMvobCCDxobhFbe73TsIoW0KsKie7cWVdY9o4vMRo+kk2?=
 =?us-ascii?Q?sslyoLXFXKj/TPoDV8vI1CM0GL5FdupfZxcjMCVzMvGIysbZi1D7/zDjM1uP?=
 =?us-ascii?Q?DMaDgYxAorlkEn4rIv0AFICgRv8aUoPrP8DA5srHr5zbu8FatWSgtf6s3GLL?=
 =?us-ascii?Q?0/ISbES3jMeoGUj++3cxI/wtdBoSjZ6IbvlAvvxR/9mvsLuEqfc2+QRnrVhF?=
 =?us-ascii?Q?Ug1XVWXzn/Am1r7niriSFEIM2NhzvPVRYscRTWoJrP/8nnfwC0hys2KTwWyc?=
 =?us-ascii?Q?D42H1zFXhHYYbeBScP30S/WoORIpXZaIH0MAagtUzfftuH8zwX+vTvdBUI0n?=
 =?us-ascii?Q?oUOjtLqJ7QA4yZqhcqrTnfu2nf1tGjjA6Ni4J/ntTtjIIhwTvM5ywwPafCBw?=
 =?us-ascii?Q?9tO2trflm9/8MnGHebq5aLrDdIeG5rGY8GEDeC7f+/BAAdA/7dQPxbQN3fOw?=
 =?us-ascii?Q?KqxA7vlC8DO2/PD8vq9XBuq4a4sZKe5KsTv5YCB6lQiUW/75Z5Y2sTcFwscP?=
 =?us-ascii?Q?Duz02I+4u73gKzxtuExcXTs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae31402-6d7c-4272-64e8-08d9f76ea119
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 08:21:17.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zup41ZXBXcVFJCeZR+PB8KScTxijkRypF1VZ4X066/TM0xmOa/P2AZs947PPdZX6fNGCKmq9H2rp3qzM+7MKMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6423
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

