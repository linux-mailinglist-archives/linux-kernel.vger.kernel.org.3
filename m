Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC834C06BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiBWBPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbiBWBO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:14:57 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30046.outbound.protection.outlook.com [40.107.3.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8763E39835;
        Tue, 22 Feb 2022 17:14:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI6xlZR7JTeamZBwrc7Q611AbxhJbdQSVw1C6HlYgX6HdLMxG7fMIZE5hbUIrPVVTY1bJBzf5WF0W5ahs+9sJCbWOSfxLIW4Ae6edTAE8JLFWOdrTHV6kQaDaSdaKJ689FaECVkkvlpu7V2XdfllHTwKoPjgqYnFkuuwsndCZH4odLWDA/htEnz3ITMbBXRp7W4Av5cF202Mv4FLUWd0fTNO7bV9y2T2ChN9d8il84aiiO6S2jKmdP2Zkr2JA+UOWAKQjLeJuQVxpUe2Ejzd5ODZLy6yfWfzh0LnZuoAdHmt/amabMY123a1JbDT0jZnA0AM0Lc704QxtQDrAQ/oMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dueg2xyemPcexX25l0BSpT6IB9dUdweTBMFcsPJBTY4=;
 b=jmOsaXoEXqFWLOP3i3MsC0gF2IaQLq3mCAlo43F8Fr+3mgfe98TPadGkJSWQIngCFoI+Yh1kLvrzWgqUOc23VCXBslTXuIk/0RSYz8ZQa2gna9RxcoSDF8iLgJyC37cCxd/ETaMYdyvJ2RbrueL0NdDp5V1C/gajK51w/uenOtbvOHSAa1KDdiumrji5Y7L+EYtiRR3fShOdlkPN8ZuTDweph8rOkYgr+4fJ06sS115uj96FQqtpGa/Yjn1IvUdQKc5P+K3A0W67T4uv2agXrV6D8mlIJpDBfGK2wwTJWc4zxx78tcQ/Zho2Ag7TCScKrB1syaH6C59XCPwygoIYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dueg2xyemPcexX25l0BSpT6IB9dUdweTBMFcsPJBTY4=;
 b=IZjvyZGulhOZReh1oaOdjl3ogjCcb7uDSBS8Ki0q5JQbzh6k2uCHL2bh0Wa6on878M8sZ3F2dn+MeoXrppSvvmxMxkEGgvKf7tAnaGw5hKmJchdF9JTIncUz6VpVG9jl/ntCnjgD3Ny7qWhG+0e799rlSn4ke7TNL3QYhJ7rK6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 01:14:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 01:14:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/5] dt-bindings: clock: add i.MX93 clock definition
Date:   Wed, 23 Feb 2022 09:16:03 +0800
Message-Id: <20220223011606.3282165-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
References: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2da4189-5a0a-4c79-b031-08d9f669d585
X-MS-TrafficTypeDiagnostic: DU2PR04MB8533:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8533BF2874B838333867E1FAC93C9@DU2PR04MB8533.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3P06FL/4ii6pjG8+fmqiVGpF1pcm6Fy+cAtFq3RlggoKsqS6m3xvom1ur95ZDkb/Y0/aStprftq0+JLtBUVjajcdUnGlNB2hTjTllSqHsVywZrYz6kbWyUwMkMxg+NCWQ4MRFVB9qbqmEdk/ruJlClEwMaP7NaylxWF36Hs0UOYfKKvGxbdMqRoZSzzH12vhWerioG8RbkKovPdt4JFzR0ynVA2UUtrWN/8ZOysVeAa4TW7UItUciX7XHAPBPI926O92JBMUUIXEYsdLCZA3T1olDdKZnq5vUma8I3dkru9dp5QieBgPXduEDQ6yNNL603vHeKjvj1qcuVVVszc+4u/9p7h8d4bNB3ckFl0X2DzikXMe5q6i2U3PAv8tLxQTDyScDW6sIJF8bAMIbRRQmiOtD078FPiRxgWGnRDN4Fcasu3crrYqNf1fMW/9ditAcaBXB39aYWCYupXHjilgEHLZDQv3YJ1lv1BHRYQPw2+EYdWufB44ycPm1ceVedP+Z3ndmlb2aIJNO08DdEKY15EPeZ5DBoAmrR5Qsr5TYc/VpG7Vg8O+LV5YzIEZ5Ws/mfSmIjknzu9PaLCjTgQ5xaPH4GbV+S5Cc244ju/9v9Z4ubA9nhGbPal5O7pd1tN2a6gwKmkBC6b45sQCHsz8Esy8+09syNkxtoHqWtJxTIUQ4ndy8FFB0+XjWiohdrzKyyWbAa0EAlbitT5qw8oEoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(1076003)(2616005)(8936002)(2906002)(6506007)(52116002)(6666004)(7416002)(6512007)(5660300002)(86362001)(38100700002)(38350700002)(83380400001)(66476007)(316002)(4326008)(508600001)(8676002)(6486002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HozXhIxnPvU+vvdjqnDxn0xt8KJtYFNfCXRa6ZhrqzdK60UwPgcnN1dFU8vB?=
 =?us-ascii?Q?yhX0JNbGWQ26Y1A+DfvbRfV2MWr+ocSSa23kyK5yX+9t/Z+FW7rv4PBTnpkL?=
 =?us-ascii?Q?7WDjase/9WQScD0pAbD3U5TLvYPVle35fRjMQiNgjH+PxHBangORzvHipi0F?=
 =?us-ascii?Q?AxS0jwWVaQaNlLMQjLFbnbENX98ryXmU/Efy0PLsOkTzPWHUHtEnSmQokK6o?=
 =?us-ascii?Q?9k4F3DzHhjh2OGhZZj6BINDbcl5T9GV9NWbgnP9bXeF4nRjCnQir7xt+cjx8?=
 =?us-ascii?Q?hvfCsZRvVhZKVkKx9+bgpIPXo/kC/0Yk9atNIrjOFyLdnHDvKyLigcfrgs4q?=
 =?us-ascii?Q?XMT4kVipbrOdNWxyzvFQrVsj/NvwX2kBcn8kjjvNAA2vNeTuX+wiFTs6wcav?=
 =?us-ascii?Q?JUic06ANXrVfnW9U6HvAhE8hifg8LScD59KFcBg3ILGF97i2vVwB0FDMo6CO?=
 =?us-ascii?Q?8eJiTHfqF1jwPW9BlmAdpP38gHXLTokLUOXOQFwMOJP25z5w5XYXCvjqvxav?=
 =?us-ascii?Q?vuvaREf3Psyu4oZKLZz2lbaEk5cDDjmOesvIkUmoI/ug1c/QKlP400oJAqPi?=
 =?us-ascii?Q?o242y2Ak9PXQO3NzqKgSWt7BbsQ7LXLZWDuFYVjk0fIJQGYqbQJabxuMIN9R?=
 =?us-ascii?Q?HvYGh+jo/FKsME0ZmoXpcb12NA/jrma7w2fQkY7N6CXn10Bahgz8p05JGGwJ?=
 =?us-ascii?Q?cUfdVuC0X7/0QiPzrwwak1tevhIo7RuRFudanAwergCnkALAbA6Gis7aZtG9?=
 =?us-ascii?Q?h6AuEoIenrT3NjtnH6sC8rsN6Uh0fFOOYbIEduvDUqubFlO/TCACXbbBR7MZ?=
 =?us-ascii?Q?FDQU4T/4UGwOOfITRSi8oWGKYv3Ofz9z5GBpKc55KX/DuAa9Ppv8SIVj51s0?=
 =?us-ascii?Q?gyIGvxaSQ2OUrNCQkpCYcG3oT6a7rzH96Jj7Y4q4GiN4BZqcVyRRCNTMBHAy?=
 =?us-ascii?Q?mqY0jxtAaikVw3qI6qUrTGyvuNt5NH+OFW0oyuQtREgzNvDgeXIJ3R6OymPn?=
 =?us-ascii?Q?/lJu7tTIh0VYnn7ltC3adstx5rgRw3LI4SjO0lMiUho1nEIzX3qjcF00GDl+?=
 =?us-ascii?Q?S3gGnkySWer487Bxfzq/bs0oxAlT+cNTuESM22xRoDAU+VPCjd8SU9qFYRlg?=
 =?us-ascii?Q?3oYEQARTGZV8PUMw7+fjdG19pKlhaB6BZy5p1ATzqeJMDkiJNcWgtYQzhe1i?=
 =?us-ascii?Q?CNOJAETUFoYChUs67xVydT6tlSZYagVo34DrSDtXmJezvPF/G9RY+Uvo6NMg?=
 =?us-ascii?Q?jBNzF8qmzjq1XveIMaYTVkWEq3HVz8VlbLyQM7QbDKPcqdAZPHHqqnfPBBsO?=
 =?us-ascii?Q?+LlOGbC7dJWNJjdQhSBPkmMH//crMZCE4RDc8j/q5QZg8XosbEHNWywD2Q6o?=
 =?us-ascii?Q?Y2SFvA+Ioge3oBNW07lENUW1/gJPgIb2Kr5zZkYy617oo2NMMHkDR2qYNXRC?=
 =?us-ascii?Q?dosb/hW9wN9bHuj6LQjqHE1kcdrZh3FBXkyA6ZNlqYlxd0sGqX2PM8tZDMF+?=
 =?us-ascii?Q?jijIvEwQfxvLdr6qTQi5apgV7vc7qPmoOOCUvOo1uC+/0qONr3Y5oVjaABUJ?=
 =?us-ascii?Q?EHSvG1qo0VmkltK2NqOkNNdDMy261Qr3qUGnHouaihJw/8OwP/nWMWfoTlxT?=
 =?us-ascii?Q?SXSP7SHv/mIBzWggTKUM5HA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2da4189-5a0a-4c79-b031-08d9f669d585
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 01:14:26.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wb96ml5lYN6gNmb3hVTfX5w2gcfwdOZY90tLj/oeGvSTvBG0Gz9XR2eCsgDc/Kri9nicgrqUNPAPVYr8x2ISSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
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

