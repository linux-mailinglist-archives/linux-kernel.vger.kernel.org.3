Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4092D5ACA1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiIEGAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiIEF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860432BBB;
        Sun,  4 Sep 2022 22:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljtJM6xdkPhUdfddgMkvjCcWChSsIL6xjxM3T8Gg+fUJ/pVN9ISRL8aO5laG1zRl/VfSGT86oIsUMyAzysGhzYXu9h79CfOfojFyrdWKsvshyRafuY21SWTcoimVSunEi4J0eZfLRrmv7gmO5gg4wNcwKAzPW0OWg9jBXC9RncgAkppi3zDzQmqZMtpCCuRFsumnKLN80ywKU361PZIcW/Pz7hWDUe5TFKTEiddtqeDrhpDa/laiPwQB+XqNERAPivYwPhwQ+IbhYHK8hno1Xt41WPKGSoh4X6/4EzwTCe6PtkPCUeFQzkW8WbKtXOGmJzy+gZmnCzietrEBPIeYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhwd3STDgfLHIufzxsFQV+G6oVtaeCUM153L072AOgg=;
 b=bKfm+AaFEFvG5J/xG96g101p93lbPiBfyeOnXnj78YvNk8OJZtMBSdva2cZCjFqQbqeFfJkI/M7o74OI+lRixM1cFJI7xv/f1Ea+D4Nd8ntrvuAqRiDDHle//+iU4PAhwhKaxn8LXCgfQucZCAaxBDh4Jzt3NF7QIyJNeH2KJV9DVJ+mbd+yDHlh9uY3Lj422clRkmHuCROmctsYsS3A51rz8Rkz/0ZkhoUlkcnId58YQ2jyZSmkET4l7XPABJOS/ad/KwcuhiZWYSOeBvQOln00xAacK1hX2VFOOXiK6cmqtxtJBg4O3AEW2uaJVAl2elPdsTFsDigJHn3AWLVzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhwd3STDgfLHIufzxsFQV+G6oVtaeCUM153L072AOgg=;
 b=jb2qwLwD50tZVTNHXFCGeKy4fwlze1LKMzmM8YUcCImfMtAjBjWkzG/WW88AwFXYPW0Jhshnv4IBPdd8Dbq+/OvnZRqafdLLiPIpVJS8N7gWquZOMPM9aE0VGZibwybI2nfAm6u7FdLc+4W4VA/D1Ol4lZ6/3Je7QIwlEF+fsHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8740.eurprd04.prod.outlook.com (2603:10a6:20b:42d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:58:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:58:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 8/8] arm64: dts: imx93: add lpspi nodes
Date:   Mon,  5 Sep 2022 13:59:15 +0800
Message-Id: <20220905055915.3878000-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
References: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1900ff93-3f3b-4ed1-c862-08da8f039e63
X-MS-TrafficTypeDiagnostic: AS8PR04MB8740:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VR6u/E4yWXBDtr+ouCAyHXFqUincXnVvLRVrV7royXs+hLWSEspdkFNeG55MkSo2hDJRsjqNZiRxpfgoreQmrhXoqxGHPzYmJWyB08qgdsA+Pu/TYs96gts8hesEPeMrkflN0hsddzrzdoPoLDDrgQJ98GrEJsTnIER3mu/FxPNVAP7TchGSx7cXdUEFMpq7FG8DYGVR5WALBw7TCXiKPfNfgPQmwpOGD/SoiZBcHWa0hmatSBqJlKmtsTGe8r3wfdm4PX80ikk21dz5hGzg/qBZffpfuDn2g7B62cB9ycQmGMc/unXI4M/yr3jk5t/1HWuqM7KmPqLoSYGyxKEYF8+ExdKEL7AuwhiyeRup1INic3Wfe7aRPp/Uk5RqUXtOdBqmHJLUbR3q2VKZS05FU54Ia4uzQemlQTIQA5btfi5sCMKO8hzv9KUf9/Js7i6juklZLbkJVgrcMIdZuTl6GZLgk76/zHF0W9G9dBhNxCOkoKd1OEwKsiBQXdHnvjHMbXyMpjqf0UXdTWhtQy9Li+W8Ysm1UjqzY93EWeHUzyCM2yGsUiJIClfIf2PtIZsaw5x4DgajgIqokKv8E6rnIZdKVwmOkaHdQlBE6BemGiwMaNgYf8d1c6HZrMh0gPeRwUBrAu0D0KxpRXiwUnFg4mBMi5LBQZZtJ9nxZWNls/UW9p4T0vY0cH9dMY/ReXYlDn+xqUMfjFF4ZFjUTkvEtXTzI3F0b+o38F8KocnSgFbaOWgbzAJJ4nV3UKu4xxwaAQhrNFImoflLZW0wAASow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(2906002)(83380400001)(38100700002)(316002)(4326008)(38350700002)(66476007)(66946007)(8676002)(66556008)(26005)(6506007)(52116002)(6512007)(8936002)(186003)(2616005)(1076003)(5660300002)(6486002)(478600001)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbxKwYt+IGQFEnNm3/LhpRsEegUNPJtWcLWhB94/HnwBD7PuAP3v03J+ZepP?=
 =?us-ascii?Q?MPuh7RTxYrvlNuSEmYDLS3ag55/qA1R1Hj+G3ecglJoGyqYFbAyzVC89NW1L?=
 =?us-ascii?Q?0C/wXn7P0/WoYTwlnTsDxBh1c5ysUHerym4NNgUHoTQQxmSAqk0UKDcV7g+T?=
 =?us-ascii?Q?PSoyYYYraEo3OodhzSwBV0O7bC4XpGNJTX+uiHAwhEuE+mWiM6PygAR3clPU?=
 =?us-ascii?Q?xC0BRc+C/jFSIeHdIcHM6FekyJll80/Kf5BbDjrMpfme7JmmNoIFh7TDqQDp?=
 =?us-ascii?Q?Xlgcb0d2IJr3s+jDfKOs8/JgkE7AqaqFi4uip9iuf06CDDHGB40+Yu/JCdHn?=
 =?us-ascii?Q?NtaAJdul8MduRLih7PKAgtEMnsCeD8pzSORB4yBYIiKr/LcMngs1QcUvVc5v?=
 =?us-ascii?Q?nIfUlSb6gaSFJF/izpx1PAO+i9zR8IZohCu1/guIU2JAdPChZ6Qvf4Z7KADX?=
 =?us-ascii?Q?5z0DhUn7uDC+8XGKZCXqJsQ39JNm6tvL7ChQkeqCWtqW2TEkItGAlC37qq8+?=
 =?us-ascii?Q?n6LBpFbSt/qLwMWZu7Yh6LjXDzLJ7HFnQdIfxGNaZLANgkLPYWHZ+qCjr6BB?=
 =?us-ascii?Q?PSjHMknBoS7ZtPtzEpnd1o5cKoF0ueDKdatfqSYIYnUvpGFOBX7HbyfdkFql?=
 =?us-ascii?Q?Ipc6k+mJsKjMas3Ba3fa0ZEGvhuNNZTPKg6VKDyBjF3gbizHmU3YP08LsNk5?=
 =?us-ascii?Q?GV0yZC3/tqT7BAbK9AmFiZ3oz+/4KL3Op5e+xyyL7+60vOT0lj4KWJaF0xhi?=
 =?us-ascii?Q?3aHRbAi7dtoABC/V/kagNdvDn4k6UeLG0vexogUqvec2b/BhJg11kgjd0PGI?=
 =?us-ascii?Q?0JaYN2ZI4Uik3hicHA4BHAMH52cC9tPmE2Tw6+TWU9EDxc4ki4m2dXifzNOf?=
 =?us-ascii?Q?4CxMsFNNCDy4y9ekRICHE3ukftmBy4oD/Wn1O0bHM3MwiVDv290hVErvGVIo?=
 =?us-ascii?Q?ZWXkv979F7XYTWzwQSYU3KdUg5i5mrbfHFMAVGd9g6RVxqv+5bhgCK6zHgpP?=
 =?us-ascii?Q?rrNYvd/SGGPvwe0uISQP2bNQqEImzEjFVTu9hC8vS6TL7/R1mqAvb2mJzy2H?=
 =?us-ascii?Q?NO72A9XwkqPZfUXXfb2Vbw/OriHw5qxYThkv25dE5aLJOARq78tbu1rwG5ou?=
 =?us-ascii?Q?uDgYOhvMNKUGlmJGbe5PGNlrn8honQZ/RDuwx/JlqUQSKHf821fW0HiEykqD?=
 =?us-ascii?Q?JjcOOXqXGusie7wzwBxnIgsp+rUPYIA4YuGwMwQlI751izUULB9fIMhqzQhp?=
 =?us-ascii?Q?4wulO1e532t47s0JnwG7EvhNwht9hLxek9m+BX6/gvaN5/7QZ9aVpsIT3Mdl?=
 =?us-ascii?Q?O20jMrySLaIRdmrrETcMmZHittiNqBux+anMcE68jwBs/Ign2tCq/qKh2l7q?=
 =?us-ascii?Q?hoIQ534HK1lkuUdCK05wjGBvVFFeGX0V8WmZJ1axZvzRs/CgMUAHBmE8BN4J?=
 =?us-ascii?Q?8eJBkD50GkjwvYrZthlZPXvDZRIB9jdV/i6+KWEwhxrfz9PZS0vS/jN/xKip?=
 =?us-ascii?Q?TfKYAWACQgrc9pqLIuJSijTDsZHIF2TKpXfrqclNkudMA2MyjhXOGlwEX2az?=
 =?us-ascii?Q?0S2xprRuCjBZ8lS58QQi5qrHM+4pMnmCe2pjnN2X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1900ff93-3f3b-4ed1-c862-08da8f039e63
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:58:13.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubn/ylYha1yNwyTi09H0Os5upYNBLwjnLq9HGbYl15JnH5glewUm2FfRn9lx2wuHf13r/PAyNtW3Cx+AppJAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8740
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 lpspi nodes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 1a5a6c51aec4..b3d82b13b524 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -166,6 +166,30 @@ lpi2c2: i2c@44350000 {
 				status = "disabled";
 			};
 
+			lpspi1: spi@44360000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x44360000 0x10000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
+					 <&clk IMX93_CLK_BUS_AON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi2: spi@44370000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x44370000 0x10000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
+					 <&clk IMX93_CLK_BUS_AON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 			lpuart1: serial@44380000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x44380000 0x1000>;
-- 
2.37.1

