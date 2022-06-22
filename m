Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB85542BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350323AbiFVGOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351561AbiFVGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861ADD66;
        Tue, 21 Jun 2022 23:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFm18Pk6YkJa4qKBjE5T7zPuS6OgrYTXD8kk7XEXqzLNsDm28pbpz09PA/k0vA4O7OX/QwJuZngMRA4vglg3rvZSrkuMh8ZLQK6AbOciFh6CoekfYpwuogougQYTWa+TvTMLhwM3zdrYmwDrs8YyM159v/Z7p44mQ3vPhpDtWmAfn0NXni1ESJghqxfiQc8vOYn1cmfIRiHGlQEkCxMFLwEN8tnpwRjIXwrFnQdHzQ6np+226P/v62bXsZ/YnMUdHV42/I74GRNTG+D7BYMWtFCpp1I4WRyIwueGVudMz+JxQosBS7MTWUh3ok8fnHnLJRRMzfyosozJ3v5xvJ5z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeq8RxR0zvm6rd+s4rpYB9GjbNt3yIYqaO3W3n+GKl4=;
 b=IsQgK7iq10gLTogC6gBnTUtmD5V7rOM5K13Gr7QbJpf7ORwHZrhLcXOQ8oe0AYgiSfEZl1hMgO/eULc5oJidcY6hPHLr9Z3KCUYF/fpGWRLVfVXjRB/3waYlBA8BySE2rBQEZ9JjNK1+yJxiFiBAeVlSb4vJvuHUpRVaVbRYNX5JvTxEljRZ7LMAQAbaaoED1RSycmHKQ0OhtNalAngJvzZ2r6njXVFidxHFSwjkuH6M8FigBue0qRSEy2h9Mj7QkBdXC1//yeeAt4jF7nYB69x6mITbGUmSXZ7lyxS2pSMka6w7erqVwipW3eoHZgmd6ktD5S6VL4rbz+XCKCbHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeq8RxR0zvm6rd+s4rpYB9GjbNt3yIYqaO3W3n+GKl4=;
 b=OHCrWAOAOmG9pt6OV5hs3S0/Fugf3IQFj0z8p9tWePijElHmeymbnO/mt6tngs2+6iJE9N0L+dftR38C1b8/IZtjF/e3E6POz/si/piwW85ijJeb+GJsqcxBw75delxpOt2ZX2cBe3qBV6pG+YYmv4mi/5h34WYUiSOYuoFBT/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:40 +0000
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
Subject: [PATCH 12/14] arm64: dts: imx8mp-phyboard-pollux-rdk: correct eqos pad settings
Date:   Wed, 22 Jun 2022 14:14:08 +0800
Message-Id: <20220622061410.853301-13-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 19fbd2a1-c2a0-4587-5ee9-08da541659f6
X-MS-TrafficTypeDiagnostic: AM6PR04MB5623:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR04MB562314FFA2FC3EC1D0D2907CC9B29@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iew/FkqYFTv692Jeuf0AP+s0U5zN2tpD0hwjm0iHaaWwXhU0qJ+FlKcqPg0f11bdea7rilCy8Oe3JTbGofWSzXG/ONqlky1s/4ml9zPfm5GDlDSKoNH/2psFnAqSFYPWB/L/owLuAHHBzkEKRRKInCvqJBOYRBDi87cE7QflWVY+/vbcYCm04NN2oa449pkE29MMOpcWWVsICMZGSRW8i59DbFPshv3S93vBD08CzpFYAo93lDiTc/qVaOSQ0dOVyNmFji1vawLaHinPIDGifKbBm1qOf/N/tByenHiSOs7FdhmTFgBpav/C99RElCX9JXDqm1mdzBYpjqTVuM39xJj2eG4zLBRXsl8xuA7sGOvOGt4L+jjwiff8RzupwxUcPJPNQb6OadVVOji2a7rczyziRHZmzMDTg671nQy1OV1bFovrS9AxNMujQiIzFe8Me+P+HbKRUBzOVCGunaRHwvNE9Em8aR9+eXFREtw1iNuH5BrEymWPP7EejC+kzLGJbnw/56C7L7AN8bOp7SKV1NgMoFL3qV59JYYbGstjJpsEwICHNTXjPeIbwWWuWS5Jf7sNuoaTvfAIEd4RzYqZ/JuaDraRGOpDcoJjtFWfe5dMkyWb15rBSC42vtp4Hrp+ARGDMmAb16tClFhcaNSuOQBcFcO79Xt4RFTMtXOYsKyltIrTX3gaeo710MOdjmFCsp7hZYoUL/nyu/VuOctVCeiH0XcIrLRiqUILx/rgl4mMuiuIgeJuzsu1MtESOtrK+bwHjl8gOahjm4UfVeCt++qmRnuFUQy5wcY689jX7Uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(6512007)(66946007)(4326008)(6666004)(66556008)(8676002)(86362001)(316002)(6506007)(52116002)(66476007)(26005)(6486002)(478600001)(1076003)(38100700002)(2616005)(8936002)(41300700001)(38350700002)(186003)(5660300002)(2906002)(83380400001)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QjAHVnnYcr9xIymnDcvzyLjNS5TNA899lIpP18y9V2/UtHpR3DvwM+Urkcef?=
 =?us-ascii?Q?yxnqHSaEtjCtBNTlF0OEcSdnUzyWUiKO5/AS7Hv0mvyv7Brc0f7qPODzWGMR?=
 =?us-ascii?Q?NAByuBexn0obaBgvum9p9Z9iOtBsnhjqwE+uURhOzyjMUmXZgwcfRNWVcEC9?=
 =?us-ascii?Q?5RA30W7s75ggXlQdUbUwJ8iY2nMKTgCwLdbaPCf7nkM7qPSfcLuykaE8cRAn?=
 =?us-ascii?Q?7B1akG+sv4PuCuCFsJxHltLB0xTxrxFNohiCySa+1R95WdjKnBWcYjtcjtKs?=
 =?us-ascii?Q?uFJqMXnYrjezFKUysYoHUUekLr7cmYPzjShIyq/t61Fv4HJ0R8+v2y/YMsFy?=
 =?us-ascii?Q?sIKLYJtjY33o1MqMh5xgaEOpE1rco19Z57ZJXjgYnnK7neuf7GqJyUFyt65W?=
 =?us-ascii?Q?z3PUREU7dYCOR6jnnBNg6I0AzCHPmihchYZ10FZQBzqlgYefzf25Hjv+LiMi?=
 =?us-ascii?Q?BYJkwMhAqDmTfwkpsHk0y4rBOJjekBHTSMIUEJEzuw0IDdrfhY1to3juZ+X8?=
 =?us-ascii?Q?HbtVzZ0hZJHXuLQWMgbVgeJC9rFMa723mBLgDcc8yYnhhgzsauVef02bBROO?=
 =?us-ascii?Q?DAQsht70GOM2gsZLRs2lJtC+eglKCitPkaHnltzgYzRFIoRNTFVGt7jq1nb3?=
 =?us-ascii?Q?m8qYma4wl+Q3BGmsdnWg1fNukl0yp0bI69JzF82fdBu/6BeEGn+zgYZdY0VU?=
 =?us-ascii?Q?x8DfRkEwYHqkAbHHcrfqLJVzn2W1K9Usz/DOk/atrHPCR3AuMdCHIgPIEs4I?=
 =?us-ascii?Q?PB/468s7gkn1CkOpiVTXZpd4zGngxHS0SNaZWZZZWz6AFXcXn+bzr+ZvQDlC?=
 =?us-ascii?Q?sH11124MBUk9TFkPzgxj8uuqkecojtReo1vSlPbwZIUSPaacasNGtekN+1kS?=
 =?us-ascii?Q?KMQK0Ok7fOcfUeM0fmZd/4kzokyhugc/7wEN56lCIDKajdLQYksodj9QhhPB?=
 =?us-ascii?Q?KLSM5oQnnz7TY7Swhuz8qg6jSXU1bwDAVmwQN5TP8vdeZQC17kv8UevzJs+G?=
 =?us-ascii?Q?5PpOTFcQW1coypThVJlfDu/FK3q4QHOQG9zeY76Q5gXcTVzLBLbRKXQNIyLC?=
 =?us-ascii?Q?Xg9APtoROIoQxaumnIheYEQTjn3rS4j3IDFT8Ef4mXMBLFpoS2Z4+tV8JTZ9?=
 =?us-ascii?Q?7GMhztR0LGcyUm1LTLOm5h/wtVZGaKbCaXc3i5ezWOroK2oZ6mP57+vzOvim?=
 =?us-ascii?Q?NhmANrQ9g+uvzSW87BYbeVTM6Ksi1GTmrUNqi+xzBRdkc4rhhAaIJwywwdJa?=
 =?us-ascii?Q?9I5upIRIky7JLS6luPJQ/4KxGxN8pjIsvNabs2pM6FtTkABdwKXgJcm0GLL8?=
 =?us-ascii?Q?SVcQdTDUnayfW3VfNwhKfA+XDpnGbbnAngEblGdvj2u7mucA677LbXwCEDDc?=
 =?us-ascii?Q?AhnQQ+a9jgw3qny2tJkrORfsYQCdreExkbqon19d86T/Kzhk6AeRZFdTiAis?=
 =?us-ascii?Q?sF+z2Wm/rJv+RmdRvPOoskm0GfQxLaXUSqkXak/gg+R3L9zgwr8vjZwzUTlQ?=
 =?us-ascii?Q?5yZmGm+khb+hXTRKDTVVQF3hgpV5aWx4YOOJgsVxqFU7CqUb8wQ8nUXQr/Zm?=
 =?us-ascii?Q?xi9/yh1fgwaHGJjs+y6Ao85N7iRt7c7EXolpoqehazKoxKbaI81rDrqwYz2S?=
 =?us-ascii?Q?KpoHIzdEuBCfcGzKsXPLCrQ+c90ogYyJhFbesQ1us3oDPLG2N9Hd872iSmXV?=
 =?us-ascii?Q?MJCS5/NFstBXKk3hzbyMV1lLnVy1wC5XuWSzJspOBbxPqFYJEFp6NHrB9oF4?=
 =?us-ascii?Q?3Zt0hvYTnQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fbd2a1-c2a0-4587-5ee9-08da541659f6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:40.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uhb+o+KsBj+T/n652vucBa3AN6mMaoJOh6Jp2jCy/THthFe6esb5eLyvQNQnXnESoTd2gUFZ2+JGLcRSntLjoQ==
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

Fixes: 6f96852619d5 ("arm64: dts: freescale: Add support EQOS MAC on phyBOARD-Pollux-i.MX8MP")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../freescale/imx8mp-phyboard-pollux-rdk.dts  | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index e34076954897..cefd3d36f93f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -116,20 +116,20 @@ &usdhc2 {
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC			0x3
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO			0x3
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
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC			0x2
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO			0x2
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
 			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20			0x10
 		>;
 	};
-- 
2.25.1

