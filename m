Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6A5542D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiFVGP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350531AbiFVGNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDBE140DC;
        Tue, 21 Jun 2022 23:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIWI67CKxAZl6/7QuR7bXQSL9zfKqzFTdT3KgDc3WF5L7+8LIJdlxKVVcdvo7Zuip+QesTGnWzsqFLeoBjnGadlQoILXxVLAdRQCryoIcCtmxTMQvvgOl15zHZd+hze2gWLatQACZ2cTMYcTD6Brl0VK7kXH/O7HBgEIiKBAkYPdGjNgbW46M1CyTxXFG6qD++tRTXvkzcE/N/lxOMczQI2dMtoT2+1aIp+KZ/dXBxVZ9t3D8+CRzwkmLFTgTMdCexKJV3OeuitoYP5aS5mgDRrjjW889DWd2ePlKnN7ITcDkNR0rwZ4Hv339RDLjLo6bEoNJjwUIxwpHJIrJjMeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAR2yCHzA1yZF/alGlxLhAUaNT2L/mJDJ1tl0pW4iD0=;
 b=Q02fxBdTbppe87x3WTyDEW+WBfwhRgKR5fxQj1KH/ggbRN9kR7qqUdpFx2QEK+vsH8D3R1NR9E6Yqa9uPzaCGI4wye3C7PXulUPjHEvrY8FjCQb8XS9ALtmYWLqJDC0r92rAFB4dwTaAwzTZGjE/fXPPzvX1SGj/PR03vgTpChspiN9Hbh249TgrENSPz17jaFckxQQY1qqSOJTuGsxki7JDvY5cZeior9txTb0YSOYaKPnjV5R9XydgKlvbBbtvKIkObeZakuZSrVLidqGgQ+Q6v6VLcK7uk1LFNlcNst88uvMYAn4C6bfWDvm7PlNnGSgDAIrB6Zat8jGi3andXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAR2yCHzA1yZF/alGlxLhAUaNT2L/mJDJ1tl0pW4iD0=;
 b=K+R7t5FlfAcMFPGVuBKXO/J+J1sqI26pWygUXcOa0Afb9J9zRSfyQc3dkWnS48JGPPNBGMV+bN3Lya5fsX+nht4xA06gsMJwxIHPbRPs/aFMp74nDndw4nOU5On8U6q0EzGIoASiNfIsGfjgATsF1hTchz4pWB1wny4zwGITJFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2796.eurprd04.prod.outlook.com (2603:10a6:3:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:12 +0000
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
Subject: [PATCH 07/14] arm64: dts: imx8mp-evk: correct I2C5 pad settings
Date:   Wed, 22 Jun 2022 14:14:03 +0800
Message-Id: <20220622061410.853301-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8d5901d-21b5-4a58-ad09-08da541648f1
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2796:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2796C2B7919FADE049410C83C9B29@HE1PR0402MB2796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxbPzcRtfiEN+oCn5ZBl0IZO4lLueEgbggBebKez8uXsfIouF2DRDOhq5OYY2xR5738xXiB52H5hRGZpjNJHf2m1TVlD9j8OHv/s8SN2OpqyTULNJbk6UoSdhTT0PBPvR6nVs6uaB+MczD6QSJ5z2Qh2iiZJw9Z6toILQdSKin54jknIztcDO5lKwMJ2n3L555qCssVzWO4BfLvbA1CaRgzzdOE6CL7OBX/ZApx09RJrrN53lLk2yFHqsKCy4oA6n2HpaNx7G5kGFS/lLGFLRL4GY2E7xlSG1qlnXtAXbugIt6ZxFk2EOhRimD0oPDwxh1vIuQty3ZKLDK+RoGv6sz0E87lDAAJzRHGm1jS2AxjvSjKFDHr2R6Kpscb7lb2Mvw1ByGFbmk+dX0d9ecOT36sHOdsKASW9ZAxIrxoBjWcIGQwfIrkK+qBu8TUAOeAY+jhFe+BcN0sPIxG448dF6ZGvGq6tS7IgQ7i9Ml1uZlhzKiqZoA+rq3Pf5AfXFVOIFDWi0bdPXYVDdwsZjo3Ofe4GNZOmtdUKDcZZ9Jx1sKqmHuc/LYaPaLlIxRSqIjFm/rGz50yTvNv1F037g4zLFnpwAOt6MGOID01Uijx50HI1E0IU9fmmhX2AT27/cX35HOa5unuPBtzz050ElUPdSI2nK5b+N0Q47SYq0SoRxFD4E01CeslyJ5bt05kyJa/bKWEHbr6Dlez7RhMub3KWD+vqmcMIRyGpLUsg3ZdUAJxyeKHvBvzUHMEmRTUIWLGVSo58qZkb4Tkm6SPYQzW+4EocxtonxucOaTtoqFCPNXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(478600001)(4326008)(8936002)(66476007)(186003)(316002)(66556008)(1076003)(66946007)(83380400001)(2616005)(6486002)(5660300002)(41300700001)(6512007)(38350700002)(6506007)(86362001)(26005)(7416002)(4744005)(52116002)(2906002)(38100700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jX+k991Fc+MCGMTm9gLqLsZrxDwnJJ+BjwTliE6XjkG0jfUZJ4H7yIw8yCP?=
 =?us-ascii?Q?Zsxb9TZUP25NcQsc21F+wd+ZjpJSUEdcd512Me56hh3shz5F9ZD3yP/Otnot?=
 =?us-ascii?Q?fgko4agwEoT4MdXlJr2aHXhBFbYQeMGN7L+Pw3SYlIstVnOBsNXpB1B9et8R?=
 =?us-ascii?Q?l9LJlKPvIEukWXUMmD7dUobIN79Pw62jt5k1GOOInjRAusdC+4Hdg0PGwjAs?=
 =?us-ascii?Q?mXnYpERlw7WTlpScfwv36VfOHDZRaZ1ai/U3Mr2IpoEyNKZZyG5ivqDv55LB?=
 =?us-ascii?Q?nrcgtaAC9tO8OwBHMH8Pbbah+F64beQFHtqlS6HRejq2AUbA5U/oIy0j37Yx?=
 =?us-ascii?Q?EG6ZJTT2+hsUow9+BM2dKwT1E0GE/lJaf+ET5ZOwXdJ23QVMr7xwdmkv0jks?=
 =?us-ascii?Q?svoNXVf0pV3W+m/ptrXGjgIeZl1umImIv90TWwW2ZkqpW/RGv47p6FhEwFmc?=
 =?us-ascii?Q?g9BU7vK6Uz5QMh3FqkYPb8Tg9+z1+iPq9TeoxAQQNGR78sKoOV4EGQEINA3a?=
 =?us-ascii?Q?EHYGjkyBgba/hhDiIhjrkzGP/8GiFlZvaE2xFfst1W/GMfhVzWU54VWiWDgb?=
 =?us-ascii?Q?Ms+KSxDy/7Z0V4incxAHA1B4/jOhRK/SVDh8pb2uayRe3lfGUi+jN0Z7z1Zd?=
 =?us-ascii?Q?OEdNGYzC55fhDtID113CN3d8w1iwmyr5ulRuOVqab7BtRQGb8Fe2SZOdOCp0?=
 =?us-ascii?Q?gLiFLhAYVeaDRPpFuAv1AX3B7gJOzmDfR3DhPPsEVJjq/KtrOirwHw4sJ839?=
 =?us-ascii?Q?fbsozSH7else9XF6ER+wVCt7Zymgga+GoFPaxe7dRXLyTVoAgoMaHZtEH8Nk?=
 =?us-ascii?Q?LF+6RsXy2+qjgAQO0QowGq1liuuK06c8uNBQFS99dkVA8UFgTooLirmcts+E?=
 =?us-ascii?Q?lRlAOmJVIGB3RHKh4Nv/ZATTkNQpm8yCJTOr6TwOAPMh1c+DDT2CB+Po8HU8?=
 =?us-ascii?Q?6U4EydkcMnK5qwx7GGeSnGGB/9f2KbAdwtWp4hvVgVDUESxMfBWcDtSIIMU0?=
 =?us-ascii?Q?xb/XYXFNo9e3tyrYyOyS6htJzo3JMHVJ8QCokcu3eYWvsBdTkZ+LXuH7NCKF?=
 =?us-ascii?Q?D2Zx7dV8F0Y9XUPcBKVbWrumutaySEjmwQdX+rDAGGQBi4qlcdoROgm/VYRl?=
 =?us-ascii?Q?NHvSbV1Q5q8lxkdwoks1b3ZCMYdCZ+nRNg4aQzxaui+0qVYOdYa01qd2boLk?=
 =?us-ascii?Q?OUWLSSMyhWDyEK1LEKnLMkjpKxaRusq3TbFvDvj5cOCQ39fgBe62B723ibYR?=
 =?us-ascii?Q?4mI8uZtmdt3YSq/MBiV9zhaUgF4EYECDj6ohB7IpVvfvBFjcD8EyY5/Oe6Us?=
 =?us-ascii?Q?x7IuwASiCOzEHnKtv02CLdxcFzUVZmnK3XzaAEe8VpHcR6G9Y6pXYO4DExLo?=
 =?us-ascii?Q?B+Z1N6OFCXKClCmmzITPdBglBafWdFPVIgAduzjPW1TWSNS1NLQSRfUM1Umh?=
 =?us-ascii?Q?P9mVDSv3xnmvt4h1wkgL8oMEaFib2KHh7XAE1HEKVTvU8g6pAwx0a/LwwqOC?=
 =?us-ascii?Q?kUEtAmgzJB0V796/U5GyXAw9TYpBZkWm7kAghIkVe/LQvxKkK0+747xSLgb6?=
 =?us-ascii?Q?TkVtsI/8C7OcXF+sTiT/HRLj9T1+/n6UsHTxb6tIugugdDyCkkB1jmWWEUqS?=
 =?us-ascii?Q?PhOsVwODJRq0Uv2yHswhmz2m3cXcN3/BWZzZ1viH47KvsN5kPUzE/awmVDbQ?=
 =?us-ascii?Q?WBLFRlUt6PtUyVxx6tGC06H1nw9fpAWUU6dtMj/IJDJ2ize+Vb9bG6mISZ2O?=
 =?us-ascii?Q?WlqjxzRifg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d5901d-21b5-4a58-ad09-08da541648f1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:11.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m73Iqq0rVGyuE1RFiFsKINdWghSAnRqbGAUQ9wCSAE09rudSrvLg3n0jtXGPQYozJKBeYrxopwfoD1LtxRopEQ==
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

Although function is not broken, we should not set reserved bit.

Fixes: 8134822db08d ("arm64: dts: imx8mp-evk: add support for I2C5")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index ce4556dab385..defba22da183 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -497,8 +497,8 @@ MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
 
 	pinctrl_i2c5: i2c5grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA         0x400001c3
-			MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c3
+			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA         0x400001c2
+			MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
 		>;
 	};
 
-- 
2.25.1

