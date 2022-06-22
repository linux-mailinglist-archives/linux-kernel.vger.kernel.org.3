Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF175542CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349132AbiFVGN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350371AbiFVGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:10 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE914099;
        Tue, 21 Jun 2022 23:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhI3f/jAd8aeH0G0DG2KxoyGad8q3BP44graz8r39IuVqNdPQ5gyPm+PJrDX01V53D6aHLifOHYcz8IFa9dvaDkbbJZjgG0RghbDUTRRKTGiZlgJDFxsrPBmW/9imd/NpIcry602YwX1VTMybBlEPl7TQXTNJnx1Bca3+IWeRjai/J53bGJwfyK5WFgppwfBUadZ+o17mHglx8ZI1R/UBwt05Z1f25bs2WD4CSLG3bjt6af6tnAqosLaOmzKXqGDon8RjGPoMYS3bQojpjLTjJ+l5npl6f07e56ld0T9mJHqhdPCkqMadpgnNHhCFxXUGqLj9ahd6dUDPxATpLJVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0madurGO+bYIiHg5/b+RvpiER9FHG8IfLPEja0pdAE=;
 b=Js8IDcjPzHLa1AGD3IWLaVRwrxswCUPezkXMdn0eAwbMoaVS6YDSH4Wc5ELwLuxkY08eYQ1zg3b4zyQfBkJYajMtHsexz6jMk/1oU4au5UbpKTHcgZu+Eq7tvcnMpPIY1gxjUVn/CdAMNVWVKAdjR1LO9czcxt10ze8MJRmyVrgOqNQk6EhZmWkCfS5cltqYZL8wDm9DPK0aoksl4y31VNYT7E37MG0+erfA0pqgziDAQQJKWLcN892dDHaI/94NWqKxUWODgEjdVbH+4ZitN2PNOHscK78akH15D9Bctby9Fwvi+4M6u23O5DmOLRnTGNvGG8MRCSnCAJIt++p1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0madurGO+bYIiHg5/b+RvpiER9FHG8IfLPEja0pdAE=;
 b=A0zk7oh3aReJOk25ZFC0bl7G4FuYnsPHlpH8R/wkOlmfWI5QE0uoeNJxke4gtwP/Q4TkUF6vZ6NNXR9iS11XE3GUJGwnjsNwsBaZ/GLtt6DZYZhRta3kuGCsf+V5lhfT/hdQaw0UtQGBsLO1gECeH/RmlhNBLuKprZOOET4pt9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2796.eurprd04.prod.outlook.com (2603:10a6:3:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:06 +0000
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
Subject: [PATCH 06/14] arm64: dts: imx8mp-evk: correct vbus pad settings
Date:   Wed, 22 Jun 2022 14:14:02 +0800
Message-Id: <20220622061410.853301-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1e93d2e-14c2-4c2e-1410-08da541645aa
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2796:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2796DC603FB83AB8ED66F761C9B29@HE1PR0402MB2796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpseZeCZx2n+4BRuxTV5EoMitJUxchHm6rP6YKlD6hM0w0U/1T0ToAWz8xip5UOv1hN9Kkqk5AqBaTkIHFcPpwqnXPMtflttr34BQX/ORG0wmKfaP64XnweJPg4X+EWLb1VeyPBoUgyRMsrLPZyj1XX5JsnFi0ITss2Vc1LrLHWK5TG9dZWOuXoOXt+AVAUmPu6xC1IioS45LFHniGHJLNfkY96IvNpqmXuK8HTXkkvz9A8n/HA09tkWpu+4VKt13stsOFsTzwfYTJxFKtXX4eyGlEHFZkxJRoT6DpXBn3hHnlyiAx8bmjJaU5qUUSVoFMtyrXjwnHoodNKhPgHzFqorcWs97pKMuZ2xQ/UvgRwTLL49GKJ0tm9SaJ51vY2ZPlZMaGI1/006DTRDADcfDGKDjZ41wz7W8NTYjZWitkYtTg0Wx96tRYUv+QkKGpi4bSMeqYGWqK5+nzy6zM/Kn+MwZ7g2AbZM3OSooUzWnSFvY+jYuIbpxJlsrrwO0EQiAfZakzCtD9//BM3qeSBtDg5ho+hjQcgl4jfhq2/CRqHa+HkahN7WSysaxOTjsVM33w5M0JzqFKqeyNl7nLxhm0aEpT3orZqcVLsf9hp9VCsQXnpSZq2xoRR5UqTA66NCEG7AI7e+SkoRsaGtn/EMfDzzoAlhuzH3S3ZY6+NI/YXV84yWrjEKRoIhpE5useDeIX+A8WQ/9PZ0CxX/tNSvD7Icv3mQr6CaWrDojPAdd4R5zO6ah0X7qZc4zQbv3TfWWttEdM9WxupH5AFM6xSCwk16BRpFlCqcAEJOsBCWj40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(478600001)(4326008)(8936002)(66476007)(186003)(316002)(66556008)(1076003)(66946007)(83380400001)(2616005)(6486002)(5660300002)(41300700001)(6512007)(38350700002)(6506007)(86362001)(26005)(7416002)(52116002)(2906002)(38100700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijAl2GXCTvIIhw0OejMft28wv1UR6PLYagOIhOp6Q5oA/Je/CGpcjEWkqy6H?=
 =?us-ascii?Q?LqQmnzsR61QzNl8glJKXJUhcXkPt4+FlGmAIzZb78EbnTHEv0nbWXSJKW783?=
 =?us-ascii?Q?Rj0u7ilfrkAp4HioFqCdsZ7pbqyQ2NWUmIh8bN/JggoeCui0Vtq2LH8KK0dI?=
 =?us-ascii?Q?zC8W6hpu6b5/etFQwHKsgdp3lKQCA+gvXq1WYWkWweMn9Iw+f3MiEt9PzODN?=
 =?us-ascii?Q?tq4p+Tcw0qcPzdw/LwvRLh2JAP8wXYe4uvETkQ86MKEyH8CqcJZzP1N79FNu?=
 =?us-ascii?Q?2Gt4QpODHVxuRjVyGu3F85NLK3INL3UuWfGvps8+kjwSsAHk1RMCvvWQCOFZ?=
 =?us-ascii?Q?FjrNmrb4AhJ0zX1s7y7zRxmQrCr41gEQez3licKk7QUbDIv863IU7ZR2m5np?=
 =?us-ascii?Q?3/RCaTr4LhGSu8ixRenAtfNf7bTOM9mYblAho8AMxRQpcehwDKJ4jkLuXTUw?=
 =?us-ascii?Q?QdLX8/N2hIKzCsxkshnbARPAJ9RDP3FlxgaIgzPGtQLYJ6RxQOgCfLtrEKFk?=
 =?us-ascii?Q?nNHEWMp/rIecQT4dIzi0GpY9ur1yjpZTR/pja/w1fZ7uk3lzqWbDtDNbptg+?=
 =?us-ascii?Q?sZFWGANJhaYn7qPKbaYEYp9UqiYzqxcQq0jTUrUHlloVJYcoTxMKfRfK5nhG?=
 =?us-ascii?Q?duWHNybdrTnQm/iI+kuqsAhbKyDg5xwscNxci+ip5RKz4mT5kKm+K7ht/toE?=
 =?us-ascii?Q?fpXmRRy2eYFa73dgHaVrbJrRSqtkaqjl71R/q7lpVkRPiJ3udydU0PWpIe1u?=
 =?us-ascii?Q?nIJCHA5HYzhjN0u66VGCDkdebnRVhSF8buHQSQF6qoAH9ZXoRuTRn527nPSS?=
 =?us-ascii?Q?yF5pwq5bL916V5XFMdGbDX8X+WT2cY7syuPQ851nJxD2HjhEN6ViQ20Wez9A?=
 =?us-ascii?Q?99oiKvWobXY8uN2FqXy7IMEe/dMiCGOJVYWhPVDZB4DWSEQgC5PYFDRxL7gU?=
 =?us-ascii?Q?MAOatwbCFKX5uVFsV6nrYe+Jnm2CvMMb96FrfJ6yMwq4xdQHQOOvz+GCfP5N?=
 =?us-ascii?Q?iB2NyJAC2dCMHuzqHQknI8epQ6AQS3qG9jpYpfM+DsK3ITUXs2fIovhU26Yw?=
 =?us-ascii?Q?dWMmbXkCQPwLqdiYEZ4p5tluaeREGl311XmiwM9CNnGHOgFE5y8i0jhYrMkD?=
 =?us-ascii?Q?Z7Lo7o/HY1ah95MirqqFFDb/p+JY3L/QRWv2Qi1sGvDVu8ra6pZoj3eUH2xq?=
 =?us-ascii?Q?dnCExSdCcJo+XDvQ0gdnIAkkA5Ibc7EXXkQNqsITEm457Y0r/CF8Q31sV+HS?=
 =?us-ascii?Q?Tg8lUBXbGsn0MhCNT9Tw3NwnOwz5dPbF+yIX8mV+KQwEo60RT4tU26pMj983?=
 =?us-ascii?Q?YCGFPTLwdoS3VUon00Xb5OhNECk2uiEl/ETEHca6wszRX5FEfRytqDbZ3Xf5?=
 =?us-ascii?Q?Bokt3YALqM0xHExYZuWEYBNjqKYiVPr5U6+lGXqW8Sp6liXJTWOF0063ZzSl?=
 =?us-ascii?Q?ID8X2f92EAyZi67PVCDheeBx5sPrGnP3nj6z+GKeMasnYEYgnLHxQYIbuYnV?=
 =?us-ascii?Q?Cuv4YoUgGq8h3WXqBMyFVNvQKFPexZ6yA69XnjQ4FPbHT5o1d82gkUGZoW9z?=
 =?us-ascii?Q?n0hNY+dxp8nxWxl3qm/h527UWx+jH9L9QWGQ21NcOVGmUrybVU8L3TEZlm0P?=
 =?us-ascii?Q?XTSM8fcuhl+/0NTrb/+rMiv4GL8FjyVikNTIy37tul2QWl6ekFeGm5Ta4SWQ?=
 =?us-ascii?Q?uoCRsWEAWFxA6D1Zac1Am+bRH4cbSftftxXDZqrH02bW3/ej8US+zia86t1J?=
 =?us-ascii?Q?TD5MuLPcSA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e93d2e-14c2-4c2e-1410-08da541645aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:06.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6keZ11aozpDb1umltU2ZI72OMVdAvByZbgR3FxaclCu2Gxo+BjRiD80HbSNp0SX6AdKfqjAbChsHuXGnNtpPbw==
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

Not set reserved bit.

Fixes: 9e847693c6f3 ("arm64: dts: freescale: Add i.MX8MP EVK board support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 30 ++++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index fbcf554618d6..ce4556dab385 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -431,21 +431,21 @@ MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22				0x10
 
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
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
-			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x19
+			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x2
+			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x2
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
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x10
 		>;
 	};
 
-- 
2.25.1

