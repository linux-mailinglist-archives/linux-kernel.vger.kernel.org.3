Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5773C5542AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350800AbiFVGOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350879AbiFVGNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F7711F;
        Tue, 21 Jun 2022 23:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1tWf8JvJRlM5mZVvxaLi+U7dfq8NYGE1Hc40z9YEqsLmU3E27CGGaTSK9Chf10bar+QPfDer0sgbnhTt4O4MTwcVfFPxrHjJL9jFjVujvHdlX9EyyE9mHPjX/8GGbNM+jBxZzBnDCqZ+FyPsMSFs5E/rD1zvMZd/mP8YRm+1M0G9CCTcJmfekK6FQBQOUXPyAbPmVRtKPJZD6Y2iCyO/f+5MquplgIF16/kQ7QSieNuRQGyUgDEM3I+OAYSTgJwHyAxdnGnhbm7yP9YhA2p3ZhztWlfi6ifPv2JJLKBpPtNqxWpLa6MQH/6FOBOO4kA56wcewxIhhRQ+/eEP7rgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8gZFuwikCs9pXVvIjwLYIcHCz5Q3AES8lInqJrgZX8=;
 b=TaVswUpOOh6Eb3i7TZGj30UwrXlsUdT2eSWniBwaCf5NlkFXFT+w9krrDJ1RgOu9gRFwQ6oGv0NgG7v/AxHmUJlPBk1UIdH9lVU2An14hAOzZrRuKV0vylWK/BXf3QbcOskHLZKps7GywGHvYvfA8Jz4KRTf1BRjstOOtOcjrhNkQnsJpczspZAIhdHLbwQb01W1WAXWYOFNLROAGVlb2hdx1+OI1ogbcaspbSIPDdpfyQhPsOi8kWGoYf+nwUc5UmW0PXvvDhTUkzl1ydPHO2ScJjVVPoRWw3sYiDRSvO9gB3vdPk1slqS5HZJxAOkn20VXseLsmrzpmrtnqNEsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8gZFuwikCs9pXVvIjwLYIcHCz5Q3AES8lInqJrgZX8=;
 b=CEWTuZcfVP/KPxPUb9+smJcPuyPOiMfVpZhqbrLE6yNpuy4mK93OorE5Pm/x5D9IN+JaWlRsLeRC/bkmPD0MNYvQrr5yXPe2f7Lu5TNm/aNN2b98oZLVXO7hm8QCvCvE8eu2r1pwfYpa+2wWqa5nORiYAW67HovV6XNhCAZmyXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 10/14] arm64: dts: imx8mp-venice-gw74xx: correct pad settings
Date:   Wed, 22 Jun 2022 14:14:06 +0800
Message-Id: <20220622061410.853301-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622061410.853301-1-peng.fan@oss.nxp.com>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc4651a-3c88-407b-2b3c-08da5416530a
X-MS-TrafficTypeDiagnostic: AM6PR04MB5623:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR04MB562307AB1D9287B2A49306D8C9B29@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4OYE1EvlM9Ayq+7tkkO9AOFUUutmJV45l9PNK5fXzg7ima8fsEfIhY0NtoraMWz+Fma759G6vnqUtjRgLdOTmEXYiXqdyyu25GOobUNqSdun6bVI/vGdWbr4o+08otnCL3pdNo+Nc5GyAbC3BkljgAHMkdbpaLBRZ/WmeO63jSe711DYnXyqww3MAUEO1uWxBxOdS5iwVw6hmWIbF18cug6F/y3SaArK53UAEnH42dQaHVnHvYPN2Ka83AnsLFrmR/zDujIeLwdjEy11eNUx4jRxdAd8e/LEHoHnawwTjjafqRgvKTUDi4RfVvP7xgBMZYsweE+hL8lyh8KpLwYm3RXzqEGYiYf8Idz1PhbRb4wglMkBpAl1jl1YAIueyLTkw9Q83PY/99MRcpSaxDkj0Ai6swY2ksZgZ0SkNJNkfYyJBvlvaWGXU0xUKDaEStvLBTtTF6CuX/GxNyjtraRerghP+xjAPTWS8zCZ25Q8w86NTPDjHYsaFaozXmBjhdQud1IC1ImZk4osgIKtgG1pyon6B9XWvvBI4DH3ePqLjQi7VSdUFpj2cw4hJyAixdYGLlbyaydZqxgKoBETUhIiIsZ7rbZjmPdEowBEMkpHTgf+SAv+Ob/vXfq0+kpZDaf8H3Be5AEXQTTea54nl9nEXpTgar/caHEL1R/N24wc6Tx7Iqjd37pwWYthom26fmawT0rmWbW6oWbCJW0v7sbZimRT42l6w5lNpmuTpYrOhq/amhEy9VmCVnYwDVYPDhMYllQgA6BkRl5zQlIsefoYjutwxZaZyWg7wqENw7plzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(6512007)(66946007)(4326008)(6666004)(66556008)(8676002)(86362001)(316002)(6506007)(52116002)(66476007)(26005)(6486002)(478600001)(1076003)(38100700002)(2616005)(8936002)(41300700001)(38350700002)(186003)(5660300002)(2906002)(83380400001)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vuVbP19MwaXwhHycn1kcviXzcRQ+XoHo/jcaSNgXVH5ihEn54AzRKxJe+R3s?=
 =?us-ascii?Q?5XvugIqtSD/r3tBAZmLS2rTL2m0F3R+SB3YtVSOy5zwnbxGQrNozLPC6nq1d?=
 =?us-ascii?Q?XBnZnjkarXIN8SXk3BS/eXCwmqCty1NNcuV4tnZyE2kq7HuxtD1dP8PZpPiM?=
 =?us-ascii?Q?Qjqrpm8OWBhpMLIz/d3wxcRfQ1RgJ3NxfzZIiDXrdxx/cmuREtqnv+UopZiF?=
 =?us-ascii?Q?AX809ffU39JXd+/Ncq5lPtB8Poz7NfKQU0/P6IVtBjNBmPJiMljDvbFdy+VU?=
 =?us-ascii?Q?Z6szlzjQvBR0w/mm3bMWChEAcVsV1hczJTrUaDtXSD7CfFn41y+MZPCszfck?=
 =?us-ascii?Q?BVS2pTzPaZJc7YWKEaoYl4dncE1XxEG0mIvKXqtckGf4ur/biGVURJOjqAy3?=
 =?us-ascii?Q?9dj7oJ1gI97W3QjCKySdR70EuXe8+dsa6OA6xbesXnRIrabmDO7Cn+N6yLvQ?=
 =?us-ascii?Q?nb6Uv8C3ICRjtd/GBVuTLXC8hy0HZpUbnwPYZjJlrEBkZIIhNzUQg0LOSkQl?=
 =?us-ascii?Q?FRJwyOjfH+gSfLYjS8a5cEeoRzVB6IB1sludaoLUdY+lOYRjLHwSOn6Z+/1o?=
 =?us-ascii?Q?atO4YmjrM/phKHIyObFN/2Dw+ztuqx4qqdO8WkgdPqlF7+RDRxTf3U2u7+A9?=
 =?us-ascii?Q?AJTGSTBzSMzdF9U2oqZkSAtoCSLsAxdr+nnVUkhhqEyk6/6qiOrl/Y7OOUTo?=
 =?us-ascii?Q?jjZyrrwwE4XSBzirCN3gIakSZ+Ult6+CZnM4YBkdwuwFYSQ6oAC1/OQo3YRk?=
 =?us-ascii?Q?5Ki+gSpGDvefcYyyCaQxHiW9o8HYJ9OmUTdoQ7OEr9dhXM1tSzgYAKI0l67Z?=
 =?us-ascii?Q?9ZY5swqOkpj1zo/h4LKVQkxIBMfVdpYjP3Qhitm02lwedhMoAEdVz9iymZvC?=
 =?us-ascii?Q?a4c2Btb8A+MNLubuEkMwixrgQ0WrfwZ8kvuffeG0ViNGQmtgTuY/Fu4t46Eb?=
 =?us-ascii?Q?I+7cuOFDL6ue9LVSMaDtS7h9NAxZpgZN7IUf9EAz7X9ZeNt2s74IrS7YbnBb?=
 =?us-ascii?Q?JRNYvO0c5hlbBEpMgDGIQthed80BADH7BhUxrTujJbWOq0m7n/NdubItyw+E?=
 =?us-ascii?Q?c58NNGl+PYgUeU+/IN7YkehmzLCTq/ygthyr/lRv5MzPSArznjWfR7JkCuf9?=
 =?us-ascii?Q?DDX38gn6BXPI+ZzkZH78Ev5VOMKwlGaKxEv6ItdFXYzCizAvtl0nRKUGqK0E?=
 =?us-ascii?Q?ASpot1Wd1QuriLD3Qj3FvmkC1rKAHnUuXdIj6jOfV1AHKw4SJptVcjLZTwCm?=
 =?us-ascii?Q?y9tYaSRlVvKwJHlsalVol6Mt5iM7GUOzDWlFpEabdtAnovmIbCZfZXcjwdAq?=
 =?us-ascii?Q?dAjz2GT/qRjFue2vVELI1M9Xo/Yy+LX+pK/ukxQlV9FcO9GQ2RMRDSgHSkBc?=
 =?us-ascii?Q?KL1hWmrdKnXlplVGrUdomRuYcGDvOsksgCBBihVM4mfyf+vufzrHg4vuzxUi?=
 =?us-ascii?Q?zAgDq57+WaoO7VEyfu+Ge69o8y0WHtXMK3S1Hl5mCTT7A/upkBNYbM5aUdLe?=
 =?us-ascii?Q?rUxxIp4PEFhxefNJ2UpjcphTuImxni5/QZTkcTlWpG9d/KYQqyBzhUu75tbj?=
 =?us-ascii?Q?Qe99ffNZeS/S5EDQfitMQZq/YWhI2rvAOE85GqeoH6ycokjuaaCCPp8tnCho?=
 =?us-ascii?Q?iILcyJc7DxI0QcuUu5lzgD4ISNTV+MhS4/aUK+Ncplq+uJCP5e3UG5DKi57B?=
 =?us-ascii?Q?g/itndiTGpnZKfsMHQ1NLm6xDpw53whxgy4+WdrvEK1vqPD738+Ra3H3rviN?=
 =?us-ascii?Q?afEnwUC6eQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc4651a-3c88-407b-2b3c-08da5416530a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:28.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXbrTLq4sknIT6yGgk/YT4mKwRgLZ80FUo0X6h6pc9i6FMt6uuIjD1tmL+NZDLY18dKF+0w4m5Ty4E2FUlm89w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5623
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM bit layout, BIT3 and BIT0 are reserved.
  8  7   6   5   4   3  2 1  0
 PE HYS PUE ODE FSEL X  DSE  X

Should not set reserved bit.

Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../dts/freescale/imx8mp-venice-gw74xx.dts    | 116 +++++++++---------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 101d31147603..521215520a0f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -622,15 +622,15 @@ &iomuxc {
 
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09	0x40000041 /* DIO0 */
-			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x40000041 /* DIO1 */
-			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x40000041 /* M2SKT_OFF# */
-			MX8MP_IOMUXC_SD2_DATA2__GPIO2_IO17	0x40000159 /* PCIE1_WDIS# */
-			MX8MP_IOMUXC_SD2_DATA3__GPIO2_IO18	0x40000159 /* PCIE2_WDIS# */
-			MX8MP_IOMUXC_SD2_CMD__GPIO2_IO14	0x40000159 /* PCIE3_WDIS# */
-			MX8MP_IOMUXC_NAND_DATA00__GPIO3_IO06	0x40000041 /* M2SKT_RST# */
-			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x40000159 /* M2SKT_WDIS# */
-			MX8MP_IOMUXC_NAND_ALE__GPIO3_IO00	0x40000159 /* M2SKT_GDIS# */
+			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09	0x40000040 /* DIO0 */
+			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x40000040 /* DIO1 */
+			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x40000040 /* M2SKT_OFF# */
+			MX8MP_IOMUXC_SD2_DATA2__GPIO2_IO17	0x40000150 /* PCIE1_WDIS# */
+			MX8MP_IOMUXC_SD2_DATA3__GPIO2_IO18	0x40000150 /* PCIE2_WDIS# */
+			MX8MP_IOMUXC_SD2_CMD__GPIO2_IO14	0x40000150 /* PCIE3_WDIS# */
+			MX8MP_IOMUXC_NAND_DATA00__GPIO3_IO06	0x40000040 /* M2SKT_RST# */
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x40000150 /* M2SKT_WDIS# */
+			MX8MP_IOMUXC_NAND_ALE__GPIO3_IO00	0x40000150 /* M2SKT_GDIS# */
 			MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01	0x40000104 /* UART_TERM */
 			MX8MP_IOMUXC_SAI3_TXFS__GPIO4_IO31	0x40000104 /* UART_RS485 */
 			MX8MP_IOMUXC_SAI3_TXC__GPIO5_IO00	0x40000104 /* UART_HALF */
@@ -639,47 +639,47 @@ MX8MP_IOMUXC_SAI3_TXC__GPIO5_IO00	0x40000104 /* UART_HALF */
 
 	pinctrl_accel: accelgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07	0x159
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07	0x150
 		>;
 	};
 
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x3
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x3
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0		0x91
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1		0x91
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2		0x91
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3		0x91
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x91
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0		0x1f
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1		0x1f
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2		0x1f
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3		0x1f
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x1f
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
-			MX8MP_IOMUXC_SAI3_RXD__GPIO4_IO30		0x141 /* RST# */
-			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x159 /* IRQ# */
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x2
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0		0x90
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1		0x90
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2		0x90
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3		0x90
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x90
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0		0x16
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1		0x16
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2		0x16
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3		0x16
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x16
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
+			MX8MP_IOMUXC_SAI3_RXD__GPIO4_IO30		0x140 /* RST# */
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x150 /* IRQ# */
 		>;
 	};
 
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
-			MX8MP_IOMUXC_SAI1_RXFS__ENET1_1588_EVENT0_IN	0x141
-			MX8MP_IOMUXC_SAI1_RXC__ENET1_1588_EVENT0_OUT	0x141
+			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x90
+			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x90
+			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x90
+			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x90
+			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x90
+			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
+			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x16
+			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x16
+			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x16
+			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x16
+			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x16
+			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x16
+			MX8MP_IOMUXC_SAI1_RXFS__ENET1_1588_EVENT0_IN	0x140
+			MX8MP_IOMUXC_SAI1_RXC__ENET1_1588_EVENT0_OUT	0x140
 		>;
 	};
 
@@ -692,61 +692,61 @@ MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX		0x154
 
 	pinctrl_gsc: gscgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20	0x159
+			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20	0x150
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c3
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2
 		>;
 	};
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c3
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c2
 		>;
 	};
 
 	pinctrl_ksz: kszgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x159 /* IRQ# */
-			MX8MP_IOMUXC_SAI3_MCLK__GPIO5_IO02	0x141 /* RST# */
+			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x150 /* IRQ# */
+			MX8MP_IOMUXC_SAI3_MCLK__GPIO5_IO02	0x140 /* RST# */
 		>;
 	};
 
 	pinctrl_gpio_leds: ledgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD2_DATA0__GPIO2_IO15	0x19
-			MX8MP_IOMUXC_SD2_DATA1__GPIO2_IO16	0x19
+			MX8MP_IOMUXC_SD2_DATA0__GPIO2_IO15	0x10
+			MX8MP_IOMUXC_SD2_DATA1__GPIO2_IO16	0x10
 		>;
 	};
 
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07	0x141
+			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07	0x140
 		>;
 	};
 
 	pinctrl_pps: ppsgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x141
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x140
 		>;
 	};
 
@@ -758,13 +758,13 @@ MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19	0x154
 
 	pinctrl_reg_usb2: regusb2grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06	0x141
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06	0x140
 		>;
 	};
 
 	pinctrl_reg_wifi: regwifigrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x119
+			MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x110
 		>;
 	};
 
@@ -811,7 +811,7 @@ MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22	0x140
 
 	pinctrl_uart3_gpio: uart3gpiogrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_NAND_DATA02__GPIO3_IO08	0x119
+			MX8MP_IOMUXC_NAND_DATA02__GPIO3_IO08	0x110
 		>;
 	};
 
-- 
2.25.1

