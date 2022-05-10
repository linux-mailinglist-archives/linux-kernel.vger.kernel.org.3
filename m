Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B725215B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbiEJMpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241591AbiEJMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:44:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5281CB20;
        Tue, 10 May 2022 05:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th+QGsa8FCWQ/M/skzlsOxgx6ETDs6YT/I6n0t/7rC2il5nncDYHlpkr74i8OSkTdlyVKrsuzLF5xg/leGxgoUTuCR61RCMyZqfuqea/OWiYzFsOaLLfyzzgFMVZIQyEEVWSfL6eA7R6b/fcy4bnfp8mzTO9zKlRHTPmP9I1Y4BxrqLqix68pB6h+75uxGW2A2Bgd/bxeL+CdN2x9Tps40FxVBT0DKIErQc3OHqOgbT6fQVpiSCXiRccA7XlaxVNcTt1pwXNadLxmqahalApoKyAJU29IIWAWYbWZ4w2v1hZvR36+cvfXPK240qac+5SPx0OGQZPKWL4RVgHYUBheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbMI5ma4mTSyer68cWSBQvu1IMzxa7Q/pnlbtfpauUE=;
 b=cHITvUjs/uNvjMiUTmFvvMIjM7Sqc1su0sO02bvTDMMx0lZ8p16pRLTk9NZUz2KI//Tn8WzMTrVrbhVCDcSL4ZZFDsR3UgBP8kM3RVNYL9Sc2LSuXgAQcw7axwe+g5aNaYpsEixempTrTi2YdJ7djAOT1344HrT/EfMaTjU+E48qq8EK2NED2kjk3xEz/zAYSUJUixTJHygzS53EQn9ubKO9reW9scGzyvF5OrtSoc6ZKWov+OdjNlA9TVErEukdtwm/EKFRvzulzlQ4ogF2JpkanvE1jxCOEKfgyb2QVXDWnWMuCXiAchWS1HNqiQSxeapkRd+cf1OPHH4nq5XK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbMI5ma4mTSyer68cWSBQvu1IMzxa7Q/pnlbtfpauUE=;
 b=eTJYRXxZzyYQN2oIB/voX+dCJSkuaFvk52BaAeCi/HWNS/rV3wcX3pYiPHD9eGu8IFQS956TroLqF3/KNFO0ZXlv6OJdAEa3b1NNByDYVPQjcGpqIUSe3aJvWwYvbhjSbUGGkcszzCpg42CdhiS1yfAs43P2dSAVNkVNkHDI+ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by VI1PR04MB5677.eurprd04.prod.outlook.com (2603:10a6:803:ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 12:40:47 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 12:40:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8ulp: address build warning
Date:   Tue, 10 May 2022 20:42:36 +0800
Message-Id: <20220510124236.399407-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 350862d1-524a-420c-7ff6-08da32824e27
X-MS-TrafficTypeDiagnostic: VI1PR04MB5677:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5677F99CDAD0B4E1FD8879C5C9C99@VI1PR04MB5677.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: az0xyiE6vyKK9c2Wm4auwdO0TkaF+GgyEDeGMUJFjT2eJmdBpcUjZLWHtQf2+O4L80tzZ/FvY+As4m+doHZg9x0QudEgj0u05/VCRNo+zkdXj9DEAKhxVmRhMXEIOJxW27PG0vmYcjpo+bq232Bkuyizxzh4DkYuyzWLuHT34aGa3spWa1SRIdLIkdiomfvmDpm4AH9OFs47vTTQQBN3WGV5rN5BfVajSEjr6CRgjyxSahCTPn2HcDGdBO9SdF6F6VV/vl/H+vcm3zuQ64FpgpaMKooh+sQLfUIvfBiKoMDXwbNsiiNEfeMWFsaueiDn4COqneIaso3LfSKdkba+BWs5zpZ2jgZ3gCXR5rbw4CjmwNxZDkBh6LNP4nZj9KRipBtJr3hE/NxSUgYuXT1WI/LK9GYr1pOdcb9+qS98WKwv518PzYMIZfdvi5iALGv3ZCOYJK5rez3rwnpEfkFahRGux/rdAbntwSvJQxfn0B+eD9b0WhlNQGh7DkfilLstuPFW95izrSHKPZkkGrFCEdCxpeR5ggIxsDeN1zTsORsMPS1+SL6rocCpwfomzQwblfuXrbdf11abb5tDhLS8O/O0hHTVRt70g/PjnbVuD8aHmtLxs6r2kR7wT/KpBb2XfiN+zpiw3uFs4ezsYDbagV3dURYdt1xaYo+Eqq1ztSLKG8VIO6yjDjCWl1++g0QfnnEUuHg+flY8AU8QtAElhubbEFcOTQhrtI8ZfQIMWqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(1076003)(38100700002)(38350700002)(508600001)(8936002)(83380400001)(316002)(186003)(8676002)(6666004)(6506007)(52116002)(4326008)(2906002)(6512007)(66556008)(66476007)(26005)(66946007)(2616005)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QORr9th/REKnwsDgMGRNZC7oxgC/kZKm9k1dLmINf7ZJhElwzFEgU7Dx1a+Z?=
 =?us-ascii?Q?jTxaY2KjgHQ+uZF2mD6V4sjtfPZDrcNhZibqmkp7N0aqp9Q8R4vSjhVBC5L3?=
 =?us-ascii?Q?pPF03tWoRLIgQx6K8FasQwNMx71irDZrknKLDcFa19OycW7kN0RBcQbcuWTC?=
 =?us-ascii?Q?Of9Gxj7ok8HCUfJLzj68hJCe9WMEhrYxFD1XqlUnqhTDZIbSJJ/TmJMBNAw/?=
 =?us-ascii?Q?UdlZWRvLYcW/1eprLVZZCxFW+duLIa6AXXIPRxz8/BdhhRJm17/zbBe7MqjS?=
 =?us-ascii?Q?PbSY21tIccarebmaUQKDiY7qHmKiwfO9KpldpSEVq2Avoao1MAEtvhuxA5XM?=
 =?us-ascii?Q?HDLXitR2+0iHFh4N1AVoN30FG8LpuEeKjj6UATWmKXZUs9bjL9U3BbpPQNlb?=
 =?us-ascii?Q?XQmwPDPMnJxP62mSEBooALFWGBq9TzydD3PmbnwWXKqbm1tryA2/6/V8zhZF?=
 =?us-ascii?Q?41ihw7X563tmIz53P/XbCHLIiLV1L+L0a0XqkR/JK3PsD5uZcj+RW8sHGhLc?=
 =?us-ascii?Q?wze4boHaag0B1UhWPWAWjqdBz7Mdq6BhsCyDKYmz4HdKSSZ6C/90Qu3qwbIp?=
 =?us-ascii?Q?0rcBOsWarsALOuoRT2gdlRwmSzJkkPDVsKG8rHVTsWFt1F9zo4VBM9lvGCBl?=
 =?us-ascii?Q?/k1LqNGUPQ5q1sFxM4JGTjlp2WStnvACnfaWUzoC/bWdugnemlyty6ymicF9?=
 =?us-ascii?Q?QTO1YB8un7+p5vmMA/FOnHp2JxCTBBWEyoCZl0ns8wp8Hy7HJO1hXuLWHWbI?=
 =?us-ascii?Q?GqPf0RLKEehlw6L/SdRYsrTMKDI6SYdy4ECI2HqegvebNF4zNM49KAFJXk0p?=
 =?us-ascii?Q?kkzI2p64BuG3Gh6Q9mjAE24ZAENhAUlbL+00kmhZYMbgZF5tWItvdtdFwTAc?=
 =?us-ascii?Q?0hl3FFJ4EB+bIAHQInks0HDExK8QsjRISiu8pVayMe8Vki6MJi0EkaZytLGY?=
 =?us-ascii?Q?zSMUv4LEkLyG4zkEypvr84b6VtmtLPQPtUt3p7hUMOK4TKOwoQ3ToUlq3Gxj?=
 =?us-ascii?Q?o1NzTxWIhjKEqifTV4g7IrtOKX6ncUTkjWM+geiRT4fhLYKEpAMk0uZW7Sdy?=
 =?us-ascii?Q?9ql316SztzR0sszfZ94aZFsOFaO7homTMYLtYG6rritgkjrirr/IS/s/h+Y8?=
 =?us-ascii?Q?9MtOPTOrg/Sl8qSfAXAB9UQsdKPFPFW7rrVTMNXUCJBQKuX5TKQY1A88FbbC?=
 =?us-ascii?Q?DDGxmSowEyRqiAVNQFv7MOkI2r/lvSuZRxlWuxibrUoZ88u050N3+Wrtiu4P?=
 =?us-ascii?Q?3blWby2ZuqJ0TpNX1UL/VNzctfI9qXoj+EuXTWUv1xup4/pkRBCPOZdE3NEz?=
 =?us-ascii?Q?vqjYHl1ar4rJL9AZWXbA7yAckgvJXWQacaVFbb0aGF45ikACXVcIeMzMYT9+?=
 =?us-ascii?Q?ysmSelBnRlW3aHwsj+2qeW7ufQf/+T9d6ezHDi0Ryn5nb4ULxjbsdLoXX2xC?=
 =?us-ascii?Q?PIMZU9MnkE7rdrzrWRJVCH1ib8ne0rZte/y1vSLEhlYVcpXPNw7kJp1sUkzc?=
 =?us-ascii?Q?u11khcWIdueTnXQutQBv2a1ExAJixHJSTTfMWVV/SsSHojIjdA+1kBjF+JIX?=
 =?us-ascii?Q?YhXJaw5m//kFT40Lx9Vtrt3+PwtptOXGlNLQTpyqRKYXj/aurM58Iz9wa/9e?=
 =?us-ascii?Q?NzbhVJnfBurjT27AZbMvCrajvVni6OazFRXoFPwRSVcDyKPE1i8M/BLnmJhi?=
 =?us-ascii?Q?t/rbItTU+QS/LRVnuw6gd7TaaR8JdigXcid0yNxlcb+Wc2qx0JoqR1WGjKru?=
 =?us-ascii?Q?fpW67G3Zsg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350862d1-524a-420c-7ff6-08da32824e27
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 12:40:46.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yn5wNwPuGlJluXgv8+cS7PCHdSdFXgY+UBF0/mjuhgWrOIo5SS57xepxoLSgTQOUJmCT2PMX0Gofgrf21k/Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5677
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Fix warnings such as:
 Warning (simple_bus_reg): /soc@0/gpio@2e200000: simple-bus unit address
 format error, expected "2e200080"

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 09f7364dd1d0..1a1ad9619937 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -367,7 +367,7 @@ usdhc2: mmc@298f0000 {
 			};
 		};
 
-		gpioe: gpio@2d000000 {
+		gpioe: gpio@2d000080 {
 				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
 				reg = <0x2d000080 0x1000>, <0x2d000040 0x40>;
 				gpio-controller;
@@ -381,7 +381,7 @@ gpioe: gpio@2d000000 {
 				gpio-ranges = <&iomuxc1 0 32 24>;
 		};
 
-		gpiof: gpio@2d010000 {
+		gpiof: gpio@2d010080 {
 				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
 				reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
 				gpio-controller;
@@ -417,7 +417,7 @@ pcc5: clock-controller@2da70000 {
 			};
 		};
 
-		gpiod: gpio@2e200000 {
+		gpiod: gpio@2e200080 {
 			compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
 			reg = <0x2e200080 0x1000>, <0x2e200040 0x40>;
 			gpio-controller;
-- 
2.25.1

