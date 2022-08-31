Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9830A5A7FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiHaONb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiHaONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:13:18 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50054.outbound.protection.outlook.com [40.107.5.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D94D7CDF;
        Wed, 31 Aug 2022 07:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM14TFD0GHZ/u9u4vq6tqBWktk/kfOIeuqM1o3tb2Id+UQB28Gq5NobyraiXYBd3bIeegdpgyKwXg57qxMNXFnUK0XPQfkuAClAomEvt5T3+QbEo57fGR4tBXCVSdY38Xd9OZAcFfIMGURqL1417Mej5HKrtfHAvLS0q91uawxEkziUC/xA6tzAG3oGkEpvwDXGx4wBZknur7loppWjkoLACG3vRBEBJrrXdiUXXO1W+wuSJzVhgYwKnXimKJUqE/oNtbZ93Q5PwffpwaIfZc0VaKys5Hphf1HddQbxGmur9IKZZ+hjU+lfzEGeYyIXdiY96vmcFFK8S1bP97/J+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUM7aOtmmyPF22pctpZGtVcz9UxFrxDNpAzxq5Th8t4=;
 b=f1KG4yDI9g28X/iA1risIcfWORVfNDEiZICSzw33ZdLiPaXphzwKi73K5DaCFMRU/OK1+MuXugGJlB3sqEdJ/x7QSuIx2T6K5ll4MRNwsUPZxhYx/F4ocx+pvT0adRq3lnxlsztcz14O2GFdZpbAHhd69tmlCipWFUMHqP5AceOtXR6MGX4HAYD0Pp2hnNRqrKMm4O60ZTzaJBnXaiys9HSOCPmPPNadxmcotnGL80w2nl8akUJwquKkDZV0c0LALvVcfenzmxoDW3aNPjsrI1paImYDIo1uZCzbXMOvoXEsDJTtAQqv/qyjH5GRnks0cYXbnRurcwastksWaxCSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUM7aOtmmyPF22pctpZGtVcz9UxFrxDNpAzxq5Th8t4=;
 b=DDRffMM/e083nXd7x2HkbSz+99M6M3rirB7J3oVuTLFtfR59vFMPdRAIm2ZjeJfVr7/ORVC0RoVvAG+en1rcU+sacVMUS4us+/8AQBG2TWyP0j87JmBwkbOImWzYyCe+tZnz7WOw/tKsfaoIMy4wAQY6F7YNVlK3cOM8po3LTNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:13:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:13:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 5/8] arm64: dts: imx93: add blk ctrl node
Date:   Wed, 31 Aug 2022 22:14:15 +0800
Message-Id: <20220831141418.38532-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831141418.38532-1-peng.fan@oss.nxp.com>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f00974d6-8d95-4275-3c30-08da8b5aea70
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ejL7It4qA9EjlTq12izpU7Oo5hSDqhMaOYPotT6+I6s5ZQhjy9bAan1yK9N2RzP7AxQP7NuaZcUlGNMIuvBhGx/XrWdSdochq4cwA9J+OaacYeW3/C9/1lY7lDNILp3agyfQ5WPPa0f8q4AM2qCSzSaiYNp9W+6fouRH+Ru/h+VK2+h5sdg5iLTkgz6AbQ6NPRy4t51TCyEWFgy7Hze3uD6lr1UzlQQyRroWiKcED6I/ZU9uKQOYPTSihPM7k4j1Bx6YUnSVNFCWYYGV29dhK15liSWKmXAu3ap0JGIaXyXj7g1gVgQbBLmfI1Y5lTdUbVpherbAGu1jd1Zbg0Fw9zQSgLvBzrc5v2zZjdBFswM6xODgie/rNqOhL3VVHq+bzDZPdjlN9zRi/GIkIHqbBUtYjDxbnMCns563B/elWZXjYSAG4RvYzBe0dcFmOGnZUFEc5klCwoadNJDnl58EmMCptgdov4d0PA/klTz2PB5D+m4CMcm6VVu095sgOHUBMgSsuJ1ATXx0VcXCrhUjRk83OX+JTDgjxfEcIVBfFNUEwwcjizrHPyPU4zgLcqZfw4I0lUQLr6xDj3fWdNUbgKnfZvUAVcTHsPL5/wwFMibHxEsCPe+xG5HNmrrXZpBmtYa/M8/Qt4imLxMQm2uqdRCdHI0s2qzj4AVImXSebXDDhI49w/v4lxvXsKzZeHNhYttv2nf8Qk5DOiA1ehN0UNWz8ctIh6ZY1t6+h1qEbHOg9MQzo2WtgSkWSjGFRpIJHy3KpRnKPLF3KzTCWpmSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(6666004)(86362001)(6486002)(478600001)(2906002)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4h90ENjMjxxzdksvCybKDUNjL2rKSqI2PZkxFM60jWINTXa8wyo+XEHxDVzX?=
 =?us-ascii?Q?1CCK4TmvWi5bKInPQC9OTb4HuV1C7zWhPE50d7yS0XjsIiZNc+1yI4GgtHxT?=
 =?us-ascii?Q?BRz/OPRp09lk2uNC+AT+2ytaAC58Lt4sZ0mtMjr81bDBT+ov1zxpO2u79l8g?=
 =?us-ascii?Q?HNptokqDqnSjhXqon5rSLU69fw5JQFGSiqmUwp3wcPni5kHYRNEP9GC9azth?=
 =?us-ascii?Q?DyAKgZirOhZFd69CGnOk1Mt4205uxKDGGoYyNk0hgZysVqjuLwFIemarzg0v?=
 =?us-ascii?Q?acYm95sjN88zLUs7uSf+DsP5qB/xsbIAf1nGcwhjF8mgzcXFuk0GX75bya30?=
 =?us-ascii?Q?mJ9q2bYamZ5oUEggU3BHgDW2PBvmN06v60JapShlNEJ6fMFRuTfAVs/zbGLA?=
 =?us-ascii?Q?sM3X6ZVD3HOiF7RzSdrsGEjzemQDStJha7g/GzUkKdB4+KF43yaEyAQy29mE?=
 =?us-ascii?Q?7KYkoWJbXIcg4l0Myc8LErt1aMGa68OOnVr+FJhAPxLL+DVfBwuKtNve/Qvo?=
 =?us-ascii?Q?Mv5RB2V+k2YHLLIwWnVJEx550iTouj6f10K4qaPRo4yrwpDJhjfOWneruH7I?=
 =?us-ascii?Q?HngiocPcGHa4xFRlCaw2GhnhiV7Y+H9FeXVY/eOXJpvylg9bwau03EWvpYzr?=
 =?us-ascii?Q?h12DLZ0tfiRIXHm4esw6T3liP9N1ld4QJGy5wK8p0N2FtthQJf6rhhZ5Vx+9?=
 =?us-ascii?Q?EwxYpENHEVzXpAyonXndw9l6yqc9/Sd5UcmQ55wiIYsQ15b4ArAL5NXlO++9?=
 =?us-ascii?Q?e6cHiqHWwi90cs55Wfaqi229DA5HMNXHS2vDegL3rChFzdJDPcSdENV6DqV7?=
 =?us-ascii?Q?Eoa5KutBRCrKx4X0/3TnqMx4JrpwqIrFC6ejHQG9puMxqQOQ6KLa7280MT7M?=
 =?us-ascii?Q?W4Pj9QqnxJML7ecJcYHI7UwbZy+kZ8jG8uqNBVSGUcVfsqUR9vPaAYWOFH/v?=
 =?us-ascii?Q?M1ikXb/YzFJRyhJkBjn5sVGNrEslXfp6zFFkN/st+w80ErwhyQws9KyLbfQW?=
 =?us-ascii?Q?ZmLlcuR3YqP6Gdo2iINdOmEGsrh5he0CuW8mY72nRhDaakHhHTpN/BsJl1xY?=
 =?us-ascii?Q?7yqASq+8NtaNkuVWdqFBpvG0u44phpSojDrd6BvoS6/XPuKhnhvCa9dp5dpg?=
 =?us-ascii?Q?4FVCYLOHZjEmb0XCqoKaPeOywHJN7iS5l3nJ3s5cC7TRhaHuGpuM+vDwR/ox?=
 =?us-ascii?Q?Ldb7rkewvvQqJlJbGzuGe3EGuTC2X5noTZIPgyS2E35VUtmznxxb7TB+6JtX?=
 =?us-ascii?Q?VV5wMl9j4dwnO3UWAqtCWXnvQinxg9MF49HuQAIABlu9InGICCQ1njrJ8QeN?=
 =?us-ascii?Q?+yq4nIUJiiZkb1b8ToxhIDhdt3AnnsE33OkEZ1TkISiXz8EqyxNbBGkuBsvo?=
 =?us-ascii?Q?6GVkypisJhUjI07UReCyyMOeTDAZpc2LVKvBK0lYsJyz6tVvP+Wm+8Wqq9s7?=
 =?us-ascii?Q?FTXflyqJr8Wyb7BC/ZTeoli3C93FhFcJ654Savyb05ybbE7zE5x8H1wLhmKi?=
 =?us-ascii?Q?gcoWWfJcdRQIZNAMTv9m1euxaBD6pnidTHR+RaMZJrS2Lpgm1s13BAYMMaG/?=
 =?us-ascii?Q?mBuzzRSW8277fJXy2OOQx9YZdXEbrXtjEh+ZhcFb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00974d6-8d95-4275-3c30-08da8b5aea70
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:13:02.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLV3LTCNCIYp7zLhGR9Gpa0VtIprpbwS32dn8uQI2wjg8ku/nxNXVbZGhY14tBbeoz0jxGAiZJ55SXyIOdhOOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 BLK CTRL MIX node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index dd76472ced46..47f98c634365 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -112,6 +112,11 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
+			anomix_ns_gpr: syscon@44210000 {
+				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
+				reg = <0x44210000 0x1000>;
+			};
+
 			mu1: mailbox@44230000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x44230000 0x10000>;
@@ -174,6 +179,11 @@ aips2: bus@42000000 {
 			#size-cells = <1>;
 			ranges;
 
+			wakeupmix_gpr: syscon@42420000 {
+				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
+				reg = <0x42420000 0x1000>;
+			};
+
 			mu2: mailbox@42440000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x42440000 0x10000>;
-- 
2.37.1

