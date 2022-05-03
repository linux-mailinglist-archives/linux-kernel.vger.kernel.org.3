Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D7651844C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiECMcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiECMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:31:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929437A9D;
        Tue,  3 May 2022 05:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhSFtlbvYDhpTf/fa2gL8sKbHlnIXQTNUwFwX8wZgaoaEBkJlwH+HtR8oXb6aUGTaJjupTTqkZjWnFTW7Jwxha9VtN/L9zlshHtYb+cWqL9vNV4Sm3UMNep4Ft2ManJlxQoGzkMbl7XRs3HO0iHHMmdLgYNDMFgjJSRcdl4fiSckQ+vCNT6ZVP6RRgPT7JWIHrleOWZr8LwRfRnZQUyB5vh7DjAS8vYz7roBfYzeMlD1L6fQbLOY49mSjwrZB+AbCq9nGJhCnYtQanC0PCDFeOz4vGUQYZctHt93jeLnKVSjUdrYMWVmXXhHX3dpfUMM+ri5Sx0z9kOPXkZsiL3aSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMClMogRJ3dh5hkemoDxOTgjSreFRNHGDmeKiXjX2GI=;
 b=ex4phQ62I3QLeASlhirQY9+dY/VhwIqxDDLiK2+47YCzOAiSJ6cD/a2+V7IHoI9qMs3qa1Sy+k4aCcGhrpsv3554WCZcF/khwR6L5PxecudY/ZkBIq0g6mbIwIBQ+Z9NPOS7wY4Dg/BEB5Kq+WMCEkKBfvFJG30CfBSf05Y50LIw+RrKSSMz56wksj7J3sCYUubVO6MupV8k5X5q5nTBRBPihKEf2hA/sqXE0fX0Bg+cSozgOXOzVB5X7h8UBjD0EpGzqiDot9gSxLtt8bZgraHK02iHr9UUYv04G1TsSuIdm1OsdpXf4g3G8pTWBNZojTvL05bii9/573j71owtpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMClMogRJ3dh5hkemoDxOTgjSreFRNHGDmeKiXjX2GI=;
 b=hzwlsRYMIMd17z5U2/19aG00MdUOaJ47lwPJBiOZofUPELicayhjj6p77GY1niaeVqISTp0wVfdOyxY5TgoNnCud0OkWtjZMCne1H/ko/e5J58AJMOBRl6y/9B9u6b8GfN0Bg1qLPfnEFUa5BOfVzCCMLeo6xkeZqrEUzYk/Jfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB5774.eurprd04.prod.outlook.com (2603:10a6:803:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 12:28:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%5]) with mapi id 15.20.5206.014; Tue, 3 May 2022
 12:28:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/3] arm64: add i.MX93 support
Date:   Tue,  3 May 2022 20:29:48 +0800
Message-Id: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b5da05e-9baf-4dc2-7320-08da2d00695c
X-MS-TrafficTypeDiagnostic: VI1PR04MB5774:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB57743E2ED418E1A63C44F587C9C09@VI1PR04MB5774.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+tdiZrqSnpPuX1OXP2v7wcmlvXEa1eVom+rVBGVBxRctdrPD2H/hLv6oAvC8NJcYUW4Vyice1k51v4AvCzdorrLsxViDpBXvUsdxixYRMXazFX6mJSESL0sxU86uijLhU1O3QR3ns/N1C3ZWLYW1XXAVtnINHX/Xescl2p8AFmHavcL0Gy7A7GC5b9Z2p2U/0wxcD118gYVd+Ndgp6WGLrZdTAyoaVuTc9kMgJOCzV5u2P4Cfv6TzYA1ZlHN5oZAJQZR0y3y+Dfw3ka2CqC/3Ew7k6T5revmKeHRCKyfWT4nxjNr5XVYVK/G2zQFkGXe4kP532s+n48bzX/yeJRYYeYonjVgMt4fURqmLUtSqiP0g7xl52vWbFaBqNytmtzhdQHNMUqxMwGnd6+rcYQakuk7vlzSXkJoI8VizrUEJWvP8SyJ606LbR179yf+kV3RMPiV4LjlWAnvDTHFbRrzqsusi5nn35+xWg34Nran743+NSiUk96/pcHg9lMCiMDM5dECG3pLuQmC0K8aEORsRHuyw7KX1Mn3NPx/Atem7f7FCBwJBSqtc6PrOY4F92krOknw/pckQaDIwFJ/tx0fShzNWv5ubz9FTazPE/yge9h16j2lAAyzqgTnAgIi5rOIZUWwCfzyHZNUaWrR1KpjtE6avo7dIvsLuqW7XHUCLnH+vmFKMXGF1h0D5XwZw4PZ8egQ6osqWvcujrtta7ZOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(1076003)(52116002)(6666004)(6512007)(6506007)(83380400001)(316002)(86362001)(6486002)(508600001)(2906002)(38350700002)(5660300002)(8676002)(26005)(4326008)(66476007)(4744005)(38100700002)(66556008)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R66uCP609GiTSwNyE1Tyjviq49HRsHZEC9VD/+lJ037rWe4kdUyqWeRTSvUm?=
 =?us-ascii?Q?VroN4wk6pwDnTyiVP0HyyVc7x9DKtaWy1DeFbOlioB0c9CLmrpZAuyCKl4ba?=
 =?us-ascii?Q?txvNVekiRQFWd8YqvruoFyqlsGb36UQrW8S2KeFXREpGB1ykhl42XP7855wM?=
 =?us-ascii?Q?ifUmijmagtTBb5rsCBX+Ffg84hGVV5CtmujMJa8bCNoRCina/ymsRUxaL8iX?=
 =?us-ascii?Q?rL/nIXjKDRknnE5/7NhVa4HDWm+XUCYE5w61zLlRqT+Eq1PRiuAcakIgkNfT?=
 =?us-ascii?Q?kKQs4CZlJepxDB88gjADBXq6ePXDuUs+yfoaG442B/ktTzSoBx1WwJ+Oq//M?=
 =?us-ascii?Q?ZZJdYIHepgjx0Wjs/+XWL+q7gWzKOpzkykWpMctfBivou8y8BggtAkD9tt0P?=
 =?us-ascii?Q?W/o2s3ZWA4NuWJ5KoME+wBZ0yPOnXDWJgySHhe2RiUE4wR8GBTjKjIWfyZHK?=
 =?us-ascii?Q?qJA0xb1KCdCM0ICxa/Lqx4j/4D/NagVTtzbWwXu0f3H6JjOPcuSBJimlW1q8?=
 =?us-ascii?Q?Q0MqAOLeDBIsOnorK4sq8fi+ysUN9VKCI/6jY7kknUIkvxJcZ3YNyLWds6z+?=
 =?us-ascii?Q?qWnNYSfvVypoPITPDj2P+4QYY01QIhFF6abPZDYfMzRnZujcj242O3SeEWt6?=
 =?us-ascii?Q?6bgGOwykz7tCF2oMADexjI3cGZfjU96fuVnNFJ2Zh4UZQh+XK7vboEw8AQAa?=
 =?us-ascii?Q?KmwYlom43Y9Jf3WXI7q6FATdZXqeNm0pLOlP04oR/XV6vNCX3X0b0HD0GGkr?=
 =?us-ascii?Q?uW9cpwlY8zwALCWT9tFYlUUymxMgiV8NgcsXixOLeiv1QKPa1BMZ4hgkksun?=
 =?us-ascii?Q?kbjDuAdSVDtlK4OOQo9QxeFOV5VOh+ZjZc2xFD55ARqKBuylns9RRZz+c5Rf?=
 =?us-ascii?Q?vtoVlpUQ7tpf0wMo+64EVz/dRibicIc2tdTtQMW2ecpQtp/AXP2ECYgT7/3n?=
 =?us-ascii?Q?x8KMYDL/VzNRZodFhiaEhXTW8a/CU9nIPgPuPh5ABAQTkdKLB3Ypp2WdYPEX?=
 =?us-ascii?Q?CaqjaQQ1Gj7axZUp2xNQFB4krCWXI/0Tu88xSdbAEnAd/kmox0eFMRrY+GWF?=
 =?us-ascii?Q?cvH7JuBjTeFoDydy2Xp/DSsuAIv7T5IeyAwblZxtFXTUFfp0+8fchaPyGv3a?=
 =?us-ascii?Q?yICEW485UYifF/2OsVp7wd5JdaFA5axOIb2S4tY4GfZqaIrBCmxvEBHnZZuq?=
 =?us-ascii?Q?g2r89FKWI7+y2oiBz7pJFC3oEJ6VwvdVaSoyOkBIXCfVz+KvjvB+jSyaey8q?=
 =?us-ascii?Q?YmzLlcLMGiRGKNi5XRXqGzQDrJP7EzOBEnMZuzb6L/m2zxWbJD2ZHt6KOwoN?=
 =?us-ascii?Q?oiJ2XOlx/yvkf+b2oAbF6OAjAQeTv4Ff8cV0zpNJNn7sZumiZOIJfcSQnsxi?=
 =?us-ascii?Q?2jHxj5fhVEQ4P9EJqag5rqOOS6kOcRePp5jmjYZ7oAH8PsLInH6ObDmO3Hzf?=
 =?us-ascii?Q?vgToH26dRps9Iaknfhf4p6JnaubqkVuFv+zHKcP7anCPKPYaKmCbQgZuj/b7?=
 =?us-ascii?Q?jEVAQfii1aiglekkFK1wh84676t5HenzN8oG33oS6frLF5U9TAnir8UUuAcT?=
 =?us-ascii?Q?ZQ2vQe+qoAsX1nY5LwAen9eDFqMdnx4AzqEW1y3KWqaW7vtwT9lmzivyI0a2?=
 =?us-ascii?Q?LzUAWQOFDvT761uDppfVmVKIagHgEF74oWeIj3lHA3lHuKonu7bnOm2G9x7h?=
 =?us-ascii?Q?nPhPM0kNI/RiCce/dvm+7/0dpHLvKjykf0SqRlr6u8QpnXXkCn50o3B+qtPX?=
 =?us-ascii?Q?GHIqMV68RQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5da05e-9baf-4dc2-7320-08da2d00695c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 12:28:22.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4idDSrkXPxY216XqeXbgSt4cuuMBk2OdAsX6YqBAk64jlFgVs2CsNgYDZ0sil7laTeisOtM5x6R3oEWkD1+AeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5774
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


V2:
 Update License

Add i.MX93 dtsi and 11x11 evk board support

The required bindings and drivers has already been in tree.
There arem checkpatch error for the pin header files as other i.MX pin
pin header files.

Peng Fan (3):
  arm64: dts: freescale: Add i.MX93 dtsi support
  arm64: dts: freescale: add i.MX93 11x11 EVK basic support
  arm64: defconfig: enable i.MX93 clk & pinctrl

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 130 ++++
 arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 337 ++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 5 files changed, 1093 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
 create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi

-- 
2.25.1

