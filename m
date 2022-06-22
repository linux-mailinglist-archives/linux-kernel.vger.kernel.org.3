Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198C45542B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiFVGMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbiFVGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:12:43 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA622530;
        Tue, 21 Jun 2022 23:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nd/uy4pxIl5DZFEn8OLFd/K62XSX8OkcabojUXdZc+hzmI0LrBRZySRB11eZhTHHIlxwksr+tXx0U5QEEDEzcLk1wKur/KFXTPdT68xtAZJPlnvhoezW+w8JSJr7UAR8Pbs1glkBfR5G0p4R615wIZ+jEqMUpZn0m+3v7SOP+wCvnnpT3iRvki7pa9kJIpK0VVaH00wsSaU0hfD8t+PvxrI8Zwl5t9xqd2DIc9tTtjVAim3k9Pcs9mGsBCf1tkbgVoqwXKVj53T/7W4/q7SNtBeaqA57gZpGaTJjC25R2JWMtBjmLIVYM3DqHfm3CCgFXe7mafaD7c5rk92i+aDHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73E6GvY3F2IMlrTGxoprIsWK974hBeYEPKS4wFG4e9I=;
 b=P4HRy/ZsYfV0R9rllvSfxkr5abkQDXp7nTmXKF14Hgiudhp4nAQnCZe7hQHvnRoViy5c0h8heV2azXhZmqJuPfXCmeMcQD64M2q71veUEKjRh8khyHFawsVDfd5uARAohP3lVMjbB6VJMCSUtpyHRI9DnK+tlji11mpnAtQketfnEoWujAap6il9HlfjX26NA4KbjA/OBVgo03tbnqEOvmp6PbxNJCsnhiDE1D+kCUmpN6gmrn/AEDlJ2i0SXfem48ANJmLnYoSl8tgMMFt0gP7ktoiaHlrYAkV8D1USznLL3Clalgc+BT3CJObY+Q1sajbLaY8YkoMkHanfu7Qz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73E6GvY3F2IMlrTGxoprIsWK974hBeYEPKS4wFG4e9I=;
 b=QTfVB+E6IEL6OOJ9o9z70i2l9Hgttpu4syqXHS0QVTJek95I4g4N/BQYAanoYIdHXZ4Du5R1D291k7khCoTSz156/+PxbQEO9psZcEzEcU/R81eh8x+c2Ln9HFIaLp/K2VWsD546y5DjWFasQkGlcaSQZG9brAEbrobITOkK/hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2796.eurprd04.prod.outlook.com (2603:10a6:3:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:12:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:12:37 +0000
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
Subject: [PATCH 01/14] arm64: dts: imx8mp-evk: correct mmc pad settings
Date:   Wed, 22 Jun 2022 14:13:57 +0800
Message-Id: <20220622061410.853301-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e52453fc-b958-48f1-46f2-08da541634a1
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2796:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0402MB27968B0B0A8435DE0EE2D85EC9B29@HE1PR0402MB2796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DWqhnydAAluoT3Mnl6ERjvkescanOH2hCdgE1j+Frr12fULcXIprU6nQuxU1NIrtaQkc8QMTMAj0Jci7fwsPshSzPM57eFeTe0CLBpOoshAzuCCnN8sTIRFY8f8KwO1/RlDSqw0d/6xhMiHB9kYj2ork62HG4HPeDe/pz6Q7lfRPcj7vjLidSXjAsGrF2QSQBv7aqnFP2kpdBqn25D5nk18wTSErG9/iUCoUrjV0vM4wpCEXxdAwRe1Wjw9y2zMkQENI/NaD2NNBTb0BzaZkDri5jPV+Uns2+v6wH3w0Gn2NWLge6oaVAWavjq1q03NebxMg4DSACJgfmW1CjDaTHZiyb3tjFb91kZ0kv05LSp6NdZkQMIrK+vkaC3b9fW33iGEWbeXIMcpTT+cPd9mPNGt9qJTz/RPCeWGL7xQIodT9h8FRsqrURoJWM3EBtR98ebOb8Bn9qM2gcEThL6wu5YA0/1SmWUeFqfR/e0W9Gn7LaOqjigZ5RzO/u876c6bLGaMAvQzK8vlGM+Bq2tbIcPfrC70DsN7msh/nFlLlQON0qm8/psQyeuPm2buUHc4+a76bctTWIpLktT+vBwSM6CJo6WaQy6ikIeTyPEk3oy40Ohz0FzDJNDBC5mkiNSDoJdBrWPiFFTtgrG3iuJSt0qKiPKV1A+MBWKWkCHhVCXpCErV5gQ4GhoOMGn3JCKZkz+X9SP8CgNrqy6uDiGq/Ltcj2SQKRFPbJv+YHdWNPKf2xFZh4bhSEAYsJ2IlBOuoUdEtFSdqJtu6RRNzAuZlW9MNx4SpTrLxGxcRg0Zn04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(478600001)(4326008)(8936002)(66476007)(186003)(316002)(66556008)(1076003)(66946007)(83380400001)(2616005)(6486002)(5660300002)(41300700001)(6512007)(38350700002)(6506007)(86362001)(26005)(7416002)(52116002)(2906002)(38100700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpWLyQfHPs+6wDXQGRzswmfHnt623vxh0adoDx8kTaueZRYC6mEvdGZXsj1U?=
 =?us-ascii?Q?ydvU07J9ZZUvH+BSosDI4+0teht5kuMxsH3icjtvJaqFA/6Bysw+2XT7NCfv?=
 =?us-ascii?Q?4NWcYE3Hr47g23jRce0qtFpXXxd99AvegnZAYgoEpF+LJiy6rJXtRfTCqHSz?=
 =?us-ascii?Q?zUYR3CeoxzTEXQpSOzgm1oiwmLB8LJR6S3MAuk7NORfHLczfdth5pDOdVt1X?=
 =?us-ascii?Q?q9Vg2mHMtxlkFc4y5xSeEL9UWM8B3k9+rOl3tBBX6jYHU37OQIqkXgNARqhm?=
 =?us-ascii?Q?Eof85kGoiuQIuF15SNjToeT7kdSp43yRwHEnLAh+qf2aFb//q+TZwk070eJj?=
 =?us-ascii?Q?lZWxzk5aAfcESyOmxEjC50sEQJsSTkmLuToohjmOhcuEd8Wtcn4n6qFKWhxb?=
 =?us-ascii?Q?OovRq0khXVaRFq9cOTYKux5qDODvD+vikFuIRuYuatbcc+MDra1vgT5y904l?=
 =?us-ascii?Q?Av3op0n7Zwdevc4fAnhYs+MwzmtHVQ6mQ/v2j8nsQuQB2aUI7/H+fzArCaaC?=
 =?us-ascii?Q?uXxmbCBgw+tH8Dam2zsyS9UuX7TlTyYvdj+WY0LCdj0hzVFAx4uosasVbf/S?=
 =?us-ascii?Q?6rFXUqdBEXHKVk9nPBzFzfVGlktg7vmF3HkWD3HzWHFyjqbNDc6P/WJ/L/km?=
 =?us-ascii?Q?qB4IW//ZUiws2q+ahHtEtpGu5HihlkbOqu+lI0ODzCAg+LmXICMOwuRxGAJN?=
 =?us-ascii?Q?myrzx7DgbKwSJrKhTDnWagqhNMBJp/jFituUEKalomJsmMKGOWJ6zL1kxj0P?=
 =?us-ascii?Q?dWUJCM4VvJ8sI+UOOxHKsD0XxRGpY2iD+27GK2SR5OhaVcIyqQkcfmcLgd21?=
 =?us-ascii?Q?UVcKtfcSvRGBtvBYL1cEJPymcz8Zb8QG1EewtdWWZDrhHfH9DZXs0vkM3whz?=
 =?us-ascii?Q?19l2Om2T7N8gnwlOgb2RQV44cNTnrFn1mDjlXfOibWKfR1d7TQFlwTOa/uh0?=
 =?us-ascii?Q?LOXpLK+Huzj8xRB6qXaOwW6g8xnxEsA8BRBQ32eRo3yLDw1oo4sdRQuCvyXE?=
 =?us-ascii?Q?t9qvtqt5UXhvm6JtrWhqS3SV2rqnPPb8QRvzD4hai9q0Lf30Jd2uwTPKMZAp?=
 =?us-ascii?Q?qj15d5tnx/IeXClOBzDSLZbcf+oNFy/YaoFZiICf2Pg5o46vrH4ZLvDbUmup?=
 =?us-ascii?Q?ATw0lVu9Bb858XTfaBpHv2qRhleYXxbrqfR760eVH7R3nMPtssjdtfnUgPpQ?=
 =?us-ascii?Q?jFI15faqOKvvLevTVgEzS/zt7D6BWvZcYGvBIKWAXzdyuTrq5Kp+TZbtWgu7?=
 =?us-ascii?Q?9TvaW33eaxWPaLT1WLkVG7OJI614We8OcZThiE9eEqnMcySwbgl6X1FJKg62?=
 =?us-ascii?Q?ukTZhnMQPCSI3LpUo5wsC+G7XkzzyqPdtvCTNYHn1x1lZ3nr6WF+nFiRyV7H?=
 =?us-ascii?Q?Zjxpk8t1ZjSKfILbwZDsEXTjhRjDUfOlP8oWY0/7eeU7fvxZjIpqcRnIe9zh?=
 =?us-ascii?Q?uATssOoE32CkkBAJ2MXQbjAAHTU8HdyxDxTyET3WDL+79dHW63vlUFe6Ms6w?=
 =?us-ascii?Q?tO+wpCEyGaYwuOjkmabWJNa3ixpqBfmoLj1rAeTx7lAM463LD/xLCopX4tTJ?=
 =?us-ascii?Q?qe2RULiA1C8Y4/GsNjPOTjDB4ZpVAidv/evQD/EBaiIkUXnlG59Fy0CPT4Xh?=
 =?us-ascii?Q?MgEOAZj4UB7qQus3cfA0estwZrAcQsUgCVzdeFTWa3VPE6c8hktInyppthDY?=
 =?us-ascii?Q?hTadH+4A8a4Yi7vNuHuCeolXykhxuiBaOSpn7bwOrIjqCNpWW/be5SKPnTp2?=
 =?us-ascii?Q?7IUbohoyIw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52453fc-b958-48f1-46f2-08da541634a1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:12:37.8156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/YEbBqNndqUSgg5CMz4jgTx+DFzdux/aVMzFfnsoQ412rLqaWCgsWUuCefWT6GfYiNlkRphWyS4lQWUtDnqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2796
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM bit layout, BIT3 and BIT0 are reserved.
  8  7   6   5   4   3  2 1  0
 PE HYS PUE ODE FSEL X  DSE  X

Not set reserved bit.

Fixes: 9e847693c6f3 ("arm64: dts: freescale: Add i.MX8MP EVK board support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 6975de72e3df..703b03a7b90b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -516,7 +516,7 @@ MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
 
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 		>;
 	};
 
@@ -541,7 +541,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
 		>;
 	};
 
@@ -553,7 +553,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
 		>;
 	};
 
@@ -565,7 +565,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc0
 		>;
 	};
 
-- 
2.25.1

