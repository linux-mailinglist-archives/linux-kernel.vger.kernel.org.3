Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92F25542B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbiFVGNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbiFVGNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F3614F;
        Tue, 21 Jun 2022 23:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzlL9FQpGMQ4VUiH5EjyVISB1XXkYHj3+gjiGSxcL6PtBvSuO1IPIXQ6oO6gA/4dTiC3R03wruTD4OMArFE3a52cGRRpML9uJqVO88OGt7BgESIPJX8KSr+eYPmtWaiGqF3wnN0X58Mqu8ICpmMXhYE+aItyg4+qs0cDtxN2JZRDDHyupy2L7FDiNYQNRzHoDXdbOvKL8GITsfWnk3516g085g4ovMZJ6RTG361YNKBWC0WSvSoTeKDe6jVcnvNWdBWPBlInHVZFEjvQSCBMiCsqmR7SM4wdBVFFimUcXVEY53TSLetDUFg8AhGYany4FSA03XjXdF4u09qH3Ec8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZb4jcmDUsWvakvLuePewLmM5WC0vD9lZWYTpW90V7s=;
 b=fgAC570AvGtb9Odj3UbFdEUirQE+vuvBTugG/HNbl3NbdZ4aAwNLTex1+tDYZSssDut4YZqO0WV+68lZGxX5LtU3meU5l/sbhH4sgPRfWEi1wnuxt31twlLy445QYl1mfZBtGoGaeRGB/u/MH9QLZunWw1j31dBYsQ8ksz+ID1subuNWembHeqKa5yqJYhDrTNdTWxgS1xoV7zcr6Ckn5EpwUCu50svtlxp304UUtAtm2HMEbfrda5qOSSJnKEcXNZl923VvTAZKGjffY13Cv/vh0wvDytlLylnyWW45sGdRYMlUIvyHTITiezxCQzsrIHdO9Efo5fU6N72I+TnoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZb4jcmDUsWvakvLuePewLmM5WC0vD9lZWYTpW90V7s=;
 b=fZZ10eQ0mZ1HxMfcsw0//vOc8Nt8jmXMUEg5i2hDR4bzOFnAiNCfdnGJR8URf5SWN1tZWOeKbH8wjUhUsguXLDAUhEIpRtX5fHqQcg5IrQqwzlIoDQbYoGi5o/NtLQFMnETSyhXvJrE8xi5VahlOtk6wPmyZCSc9PN6QAXltIsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2796.eurprd04.prod.outlook.com (2603:10a6:3:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:00 +0000
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
Subject: [PATCH 05/14] arm64: dts: imx8mp-evk: correct eqos pad settings
Date:   Wed, 22 Jun 2022 14:14:01 +0800
Message-Id: <20220622061410.853301-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e48de5f2-2eeb-452c-8b73-08da54164256
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2796:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0402MB279627BAB006EF84A2026589C9B29@HE1PR0402MB2796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QZBIaq2o/d2XdqoVLqSXh+zooIxBsZxJLx9yTlQlcMiyi7j9vy0IP0sddf1SuYPSwjhE7u+a5ahtMB9TLNB/hicqtQ/zHliYLldGce2MazzAk6A+i1UAG26Qu4t3/7A+pXt7DhYNTsLZVVzidp+4zEfB75L5tVqsIOgKKzVnY1qiZ+JzLd1A3xTeAqxNCpRlazR/xZlqEUZZK6xusG1F+yhH9e6GUv02ObaUl1WbnJAjJySJMldPGio8xD59k3/KMLNJeTSw2PwMkhhdMNmLiR1BnXvVjt1Sl8LpTYssfPSPxoNlFFPcD3pvJNY2fmW/n4gzJOj/dx39A37+cdAhQTfq76cJ9y2AJrwQ0pdqHmoMS/p/Mf423KyMiLALRmnftkR6RzRT5CrJbyzj9UJlmoa5tuUU8HGiVHc2PICvKhqfCJYRrk4ASSD0nokhkoeuvJmX8pA+uWyoJYn+C2fFofyE+PxTOXuxfz4C381lvieVjs5oCy21afPDwqwI4YO1IXSI9EdiDUYg2H5LwJStH9k0V2+h0E+NWy5MhS8wyjqmNC7OmmLbkSWYRs1wVo6fMKxi/VVegrT3I52Rc80+9uy1Zb5ID48NyC72VWcJabl7jIyme4m28tkJHvpo2FgDqBl465RwNt2c8BzkFpWYsqJvXATRd4r3q59pk2+ABh3RgRGREu6xX642AG+NmaRMPu7wdJUwUPyJoyTo/QqNDnPz17iHlbwMazLq/mGQUW+IZUhAE+XG8YZmsp8l0cfB8vvuH4r70eaXtF2lr5U8YEPy0VWT8MMvs06gXD2CF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(478600001)(4326008)(8936002)(66476007)(186003)(316002)(66556008)(1076003)(66946007)(83380400001)(2616005)(6486002)(5660300002)(41300700001)(6512007)(38350700002)(6506007)(86362001)(26005)(7416002)(52116002)(2906002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Seoxkd5o0rWBJwQ0lcwhV3fXgiAXNzaybM0nbNFJCLInV1VL20c6hMl8VbD?=
 =?us-ascii?Q?UxW5rLhqxkkw4roN5jAQyJEmfauufFjk1bLUaUp4U9/lzrCHaAx38CsGe4kC?=
 =?us-ascii?Q?XoBXjMy99DjJy9AdDDNfFRkQtQF8ODQOSwc0s1K2pqpBPw5wbJrysHojeKwO?=
 =?us-ascii?Q?P3xvcCDWVUtkpkETnVTSsEh7PfLAyklPBaY6qtBcM3lOmOdmXwtFW9NukgHM?=
 =?us-ascii?Q?r9CVX5pEmIEaR5we1w6hFe57PYSweDg7dfSklXMMf/7lix0TNP96IJaZvkIz?=
 =?us-ascii?Q?bZyGUzr0EsbGaoPoGRJtZNvkwsw3RW17R5KaxXOnXMjYxltRd+M4D59Gowda?=
 =?us-ascii?Q?VK6EgEiGACndMsnf0eohZTJzSNg4P1zvYWZt7MXur0U07pVRwUjWzxKHbu5L?=
 =?us-ascii?Q?nuRNrybPHJZskcqQwFg+nToFouwD39+uf0Qs0tRLJ3TMscpqgSMT3UShJNeI?=
 =?us-ascii?Q?kZrnjElODkByP+t9XSvcKBu9acGZuZCNlfAR4TUNmyNB8f/ddsXYtBFN6NnZ?=
 =?us-ascii?Q?ge2EkcvHQ8zRxNiOOrP6Hhp3s6KiGP/mMi3zQRnxhqhTnG1Jtkg9488NKicK?=
 =?us-ascii?Q?w37s96nChUAaUvbPy2IqhUAUGlug4sG/rKjL8rG5LfUFftYHMPfRrueE3yal?=
 =?us-ascii?Q?XuKpdb+4w09ugoobn4Wln3sNZvOB4okuuOeLGMsZdPNoZXm3ja2sd5pekE3s?=
 =?us-ascii?Q?ElyK7nJX6W4b8hIYG8pqkAmMUilZV9hQ2TatFhFHztqLKvV5/RMZTj5ATgNg?=
 =?us-ascii?Q?ggEIZra/7Afn1uGnQghEpLK60cYY6jcceJn2Smfnuc4YnOdKrEduKWa4c4Tr?=
 =?us-ascii?Q?yxL446ccXDgr4KWmH2EUK+LJscIq/8XlpeDRDPsEh3yuZ4OS6O8pSnoquys+?=
 =?us-ascii?Q?4h5lOmFiScAK9VzE32jqtu90f43/7VgzaB0r/e5Om8ec8RYI8+IQdatEieeR?=
 =?us-ascii?Q?ekTgJkT6LjvhnFTzv8JrjwSaIjMLhpOc36IeH1TocLTCEs+02wmkDseoC1kh?=
 =?us-ascii?Q?F+OeJ+1pmX140cwABnmfg3kUSvmBumpZir3DO21bgtuv5IX45YecwhIUVS3T?=
 =?us-ascii?Q?WjflSI+r5yNhD2Lmltf6/KKAGiRWiuaH5mZjSlCAKvVjPMYdKuBjbDk4xABx?=
 =?us-ascii?Q?3iHK1kvmkqc1EolAiLWDmdHS8N6JkUGTg4BuFuwf85FdeLBLpUWfjTbpbH9U?=
 =?us-ascii?Q?q+3k7mMRIqG9NVAXlsrsMYiWSAm9Vdz4oJYppi2OWdL2y5OhwcPd6XxPxlQm?=
 =?us-ascii?Q?L6dGX+kNeYG6PhlLO4ht/UXrvLlhoe6f1KpD8/fvTtYgo7GT+7ygxDM4AE1j?=
 =?us-ascii?Q?M0f7Z6nevXImeLf2CTanVUTgpF0u8va7qHlkNx87F6O75wi5Ca2inNxcvJW2?=
 =?us-ascii?Q?KWTtzdiBxylCxSjyBLo74qhumcyXnv+WpIaee82L37acIVDoCoORAC6r4OwU?=
 =?us-ascii?Q?yCrca4cFfMh0BATvEnNGXaJKfu+CuwobC1Vh4EmAjFvvPNPORNPTj7pNGjg2?=
 =?us-ascii?Q?snCMYHOyUKm95EF6aTGHE86PiJ0QEz/id9VENXxVYjn4oTAH9HkONsIHh5vd?=
 =?us-ascii?Q?kymxChG6Q46kIEJrfxkx3HWAC5qw977hN3P+VJZ3C5fSfbH2OYqi4/MTl7Nb?=
 =?us-ascii?Q?3Muq9gpc1OHy+fIePjcULWJBkkawo1vEZoicN0Vf/hpynosYLc9D0rZ+2p1f?=
 =?us-ascii?Q?xjzDxvTbB4frpVp7ClHSLIgLFuY0aX9p4/F54x3egnoKB6JPqnJoj1LX/qNq?=
 =?us-ascii?Q?uG5Zgrb2Wg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48de5f2-2eeb-452c-8b73-08da54164256
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:00.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wysjeOsrO74Fm6qRInIQrmiM4rXNDvtMO1q2H8u1hWYUUymckcWefan7v0EQTaglnoHtzLoLSx34BqkrSYGd5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2796
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

Although function is not broken, we should not set reserved bit.

Fixes: dc6d5dc89bad ("arm64: dts: imx8mp-evk: enable EQOS ethernet")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 30 ++++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index a3195e65c742..fbcf554618d6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -411,21 +411,21 @@ &wdog1 {
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
-			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22				0x19
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
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22				0x10
 		>;
 	};
 
-- 
2.25.1

