Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF985542CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbiFVGOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349948AbiFVGN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A32F8;
        Tue, 21 Jun 2022 23:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2UZA3PhiEonHKAT59GdWffqALNhVgUigwsDdnbl/HaH/r/VnzaeEuVHDTvqmxMUc7aq+ezR8j9MK9PJVsVYNZl9m92hzYGPXNNcfLtcxq/EHtTpZ3aEEdly6JrGOBYnMi/dceJT38luUffrEgng1rIkODJ91Vl1KqcFDXD7wEvwRI5hMH1AFJ0phE0oziaiIn1lh++jRdNahMTK/+//jYlGWsClV3ylZlAdt/+wCTfhPBilFgvS1f7gEehDkBMfxzp2w/wyRPtDGNfyEevYrycNgy0h/kXeShTm3ELSvmVavXhqrDlKPSmt29vo4c6rJaSLVjLH6lbNgjA8gWHKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJUsgEk1abS4b5W6i9FLNKPTGJglEZb9eRBupOwCLO0=;
 b=RKlsBIKUZ/eYU1FuTrLUXmJTaD0YO3R1IbzUHBpPwhJsJPYrn+O0xesTLHfJzxyrZuZEugPHwSwYy+/2WDYtJ3tofLe3xe5OtQIPD6qUhbOoisxyKBUuYBytTvk82Bt3Z+tnKPAuuxKL/lWzXf+5ZfDaTqAFHDbgSfircdnVbXyb4xZiyPeIkpqvbbbLrq/u4nWUIHU7xNJqg0pEaafAoCrha8Wl5u3dTjrePy4HxFgNPMgWufz9lVD0yh1LEDzGkD2o9q4+3HNRkAAIxCVPfBn8TDZ1ujsfT8dytH9hcYe8/SQ4cSNOMFFvP2mABZR81C89N8Knw+s5kJAii3fDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJUsgEk1abS4b5W6i9FLNKPTGJglEZb9eRBupOwCLO0=;
 b=hqqcxawn+CIFOs/4hCSMkIwCzF3T1DFa//WdZlgHPvVj/cVAGOHbtFJbYARERaeB1qQG30nuUiUoHa4oLjplnN69Wrccoo3cTX0T6+HJalLVeAt4AgwD7H46JSKoNNyxFYEwXpvfPeXcO2bBG2jO+FqQrWt48micngVKousKIbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:51 +0000
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
Subject: [PATCH 14/14] arm64: dts: imx8mp-icore-mx8mp-edim2.2: correct pad settings
Date:   Wed, 22 Jun 2022 14:14:10 +0800
Message-Id: <20220622061410.853301-15-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 307eb9b6-4b1c-4ad8-1403-08da5416608b
X-MS-TrafficTypeDiagnostic: AM6PR04MB5623:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR04MB5623360F2A0752F24575F690C9B29@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2ZI7MO8xJuuPRctBOnFCGah7l1YPBHj6pC2HVoDXKhlowHDbdmpv7anXiO84TLRVSSG954rA+tOvEaMc21pyUU3DXSZSnAT52OGvNfzRn80P3WNX7aR4ZtmYhKytCiBBT4Y088vlh5SUBoJu39cHNxabjOFkE+LH7w33amm9DWei/KQYxR307WogB6yt9C9o+gIozgwnxceEdJrAvnhxPTX14ZK0gMYJq2vJ880xjAufoFoBDQ2O3hMBW6GoBImRyY+4F+Zsp03janPWBNBFKy2Dre8OIi6X/Tt8mFzKSh9prvcod2DOgK9PsyH10ZuI0zzERzPBMGysvU8iUolkEt6mbHVZoBaHjZLfeQDwhScjMBFbie2TYhLWVldVspUhMbOC5ihhy3A5E1RzfSVUtfsL9jcvd5Q44ULThLOrsMVSvBPATGDOPExFhfTmg8kpGGJkzfEft1J8XH6A9pW8hvrUS81mBNo9z95UtQK0PVpLBKTko/T4j8EA2O4x32FKOc6nPltfHoe/PNcdnWr+8UtgpxMl1+YovYZjmB0DXfxVwxUe6vF4/rNaYfSuQHieZqizYuCeGgDPVLiniRZYFPvEDZUc/whBdeTvG3g6aEc3eXXT8H8PE3NpwevM4ipBNDNAMA0E+ibAlTJ4w0nZPRsH3JeINBI2SU+gw1dV+B0OsO2a+pp/VEhySOhhTKtPE4TuTE5rbzH8pNvyXpZpilIQ4ajNWbOze/Qh9Kk9CSajilbWRfx8d9QPP6ycjdZ2S35Xwiw4Ihxbj8GSckn5ggYoRygfTR3INtlYlJdm3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(6512007)(66946007)(4326008)(6666004)(66556008)(8676002)(86362001)(316002)(6506007)(52116002)(66476007)(26005)(6486002)(478600001)(1076003)(38100700002)(2616005)(8936002)(41300700001)(38350700002)(186003)(5660300002)(2906002)(83380400001)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SLWKMBnOOlPUOpUJCJ7WQc6EBjcoKJIPKN9FaV+iO7SIsl5eEa+YIMdDoMqV?=
 =?us-ascii?Q?hzNyQBFZreTzj1wDrGo2UKxLqww6RAIcI/KJN5DLjCZ7GUGTFJTn7Pmk9Ct9?=
 =?us-ascii?Q?STc9KXfFWKEEoElx4AT/hEyPoNhIDOhYROPAFQ82G6DrrBMwLaPAOlvm95Gc?=
 =?us-ascii?Q?lz5b6+DpSb6NecgCjtXdO9wPjPsSVEXDH0Iq3NELjZ/Y5HBrFMipYFQrHxuJ?=
 =?us-ascii?Q?TgnPW2Pem0m0tionLEMuSvvTcJ0r9T/x3wvS0VnHFDlGZHkATRu0c+1ilas5?=
 =?us-ascii?Q?2URHcjyEI47SqqxWOB9Rzb5uLu+ww/CGxeETXytgfxE66FnmG7peHuYQ0s6U?=
 =?us-ascii?Q?mrWk8T/1UWHN+WZsrZ2dhmB7RPhQ3c7FeXIVVHXN4yiIlzCeTbIy5q/Mmian?=
 =?us-ascii?Q?pBARewukvGRRBRAB1uvWSZ9yZxkNAXpzA5KDirY+eYo/kD6pWi7vZAauARLB?=
 =?us-ascii?Q?Np17UG8MpjvYWXJfFA2Eb4ULoty5y39cjfp16EZ0UUxx2YPO2AKUuyHI1XmV?=
 =?us-ascii?Q?icMMTQB+eSOrNfa/k/DadZqwvNhp680idcHFd9rbptcpK+Hg+iTZBPvhgrsF?=
 =?us-ascii?Q?3cxEQzJLdWslUbPw11bui8c2Sfho0LQWF3lNRgmdl0ktFcZD7hYHc5MVBprr?=
 =?us-ascii?Q?nGKSSshFez1c/yDVqYG64Zl70cRDT34H0pQBm44dZKNUpzOatvAFMoSbtNl0?=
 =?us-ascii?Q?mVVln+sD7lk5Ip0sI244XqhtcNB4NgxQTG/Hcmxy5OJk3zTx8cgbd1cfa8mf?=
 =?us-ascii?Q?Rc6IrPMSX9lLRawVZzqnSqfrw36LGMiekEwsqRkr8FsjApW5x0AbsezZhGkw?=
 =?us-ascii?Q?dYyCyzcV2MRk/QXlll5M2QnfDMlq8Vz8vbXUsNZXscvt2hK29oLL0JqMxRva?=
 =?us-ascii?Q?OOkeD4MTN+jcCES9fwndlwbV2b0tbgvrJOPAS42LbQJ97gS7KPnh18AuraDd?=
 =?us-ascii?Q?C5Of55JQQ7xIdlba9wo+EPn19ol4cNep6kHPRfCXhv52ckqXnlGq4grlmO5O?=
 =?us-ascii?Q?lZizCgsF9s5LM/0kejodxLYWDDdbIE2mBfJXJZEphdUCv6+/eVzW0JNMCs0g?=
 =?us-ascii?Q?hOcQnYC3iZHQMiyoqI0Bjqp7RMQh1JlAE2ciP0PdMlH9DhhfiT/NzncicKkv?=
 =?us-ascii?Q?JEvPG52fZtME9JKELLsyo6kVCH5y5zqCrGjO/LZEoKOETczbxh3x/fR3RGyr?=
 =?us-ascii?Q?X7A/MNfhLG11WyGjzAD4EfmhED8Cc3Ud+OzqYVm59pW5/6X0SByKtRR+1KzA?=
 =?us-ascii?Q?9xE+2nnynG4cXW3vVPC91T3nCY+4rZZp2TEdrYnMLdDRm7L8gRFi5Q8GusZy?=
 =?us-ascii?Q?jmwDFXmjr2Lz6R3rqkjF0kVhEN+5SBNFxlKRTlnt9nm7eV5o8eEUG2pvbUw1?=
 =?us-ascii?Q?MvUanDZ4/HWnJHetSqU81gwDlJ1TfthyVori2JK4LwCtaGj/GKUVGvy7mwlh?=
 =?us-ascii?Q?KbdKjxxdN35UwQ+tGiCtlyyHvGlkg4URMU2WZP/2W+8x8ktwyR7Kzrs0oURb?=
 =?us-ascii?Q?UqHx5EQg20yAWwmED2gg5VTLCsaWuAgioxTd12BNUAcpL9FKBxReAmSDx97K?=
 =?us-ascii?Q?3k7KL2FPkiyZ+KlyjYgtqEF6rPrFo+Fk2X3PTdEr9dzefw40C+LdCQCeiDmj?=
 =?us-ascii?Q?E4icNZfKb+/4jtxEkQuXqVQvwQsHikcEjg8BeL3uhddAPojfwQbrq9Fgjb5p?=
 =?us-ascii?Q?B9+Lg03oh6Dy9PHyXJi/QaOVGOH6yI36CQ67EMFMbV/JoUJtT6jbXdIXXtKh?=
 =?us-ascii?Q?RhMo27ThTg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307eb9b6-4b1c-4ad8-1403-08da5416608b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:51.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wawYeCoiQKymlDDTdyc8ap+AdGDPwgyNmhMEW4RvLr9cPXDH0CjItkP2KRXxCAJtYykC7e91LGMHnA3BopQ7pw==
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

BIT3 and BIT0 are reserved bits, should not touch.

Fixes: aec8ad34f7f2 ("arm64: dts: imx8mp: Add Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
index 70a701a624a6..dd703b6a5e17 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
@@ -110,28 +110,28 @@ &usdhc2 {
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x3
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x3
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x91
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x91
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x91
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x91
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x91
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x1f
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x1f
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x1f
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x1f
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x1f
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
-			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07				0x19
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x2
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x90
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x90
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x90
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x90
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x90
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x16
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x16
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x16
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x16
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x16
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
+			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07				0x10
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x49
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x49
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x40
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x40
 		>;
 	};
 
@@ -151,7 +151,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
 		>;
 	};
 
@@ -163,13 +163,13 @@ MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
 
 	pinctrl_reg_usb1: regusb1grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x19
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x10
 		>;
 	};
 
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 		>;
 	};
 };
-- 
2.25.1

