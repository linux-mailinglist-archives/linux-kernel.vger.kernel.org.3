Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4357ED29
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiGWJmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGWJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:41:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C02FFF2;
        Sat, 23 Jul 2022 02:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0DF/fWVay+9mZSFvaQel/mFZWXles6r1KOMGe5OnamAU2NGk/3V8vWyWrJIsI8VLVVwQUoc3KUIAaP6mAGJAZIbaDGJnIo3gfYe0MsPlbml5YTI9ET/53zX2WL2ip5E9SY2J/QO1soQ76K6mDWKhsXNmx5bn94k+tGbsUyE9UcVeQ/ToG+ftxU47iQExEliF79Od8thERUFGRqREWCiUTnkUOd/t9GYZf/RlUihN/1ruf2tRBUB73gt6pzOkzIOVC4DJkL0H7sES0cg44iIqSAjgw9ww3A3r8wqHc8lFz5QURDVj3vOc0OAFQlhDsX1axLlwOO1C9aga8GndyhclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4lMyhPGZ4Say+VrWXFSjUh7VBAHR35D4Q1L2aJwVaQ=;
 b=MZGbaU2jCKA/MhphQcfuf1N4A1f72OdmDWzbGOVXttsSnTrcx0evkyOvLg2pKic5mHgskyjQCPhd1QwbFZ+llqom7ENnn4nfYyZJKh5TmCTu1X0yHrHUWH0odtbHo8zGFQAaI6Yv7dX27yGDMvX5NQZVR79mYCfbCt11RMLYFxMCgDLCdnEUXARAVzQvsCS2plCG/bEfh9Sx7mhd+NLYodEA9PB7he7ZPAoVx8oQlH8FRMxzAjdgpYWmmFfGP1rZAU3JvtuCgUFyqizhhERPyx0S1FFrGF7IsgGFx4QFcTxIVxQkJUqZCDcTLPTSyRKXLex3lI/CKHxE92WzwXr+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4lMyhPGZ4Say+VrWXFSjUh7VBAHR35D4Q1L2aJwVaQ=;
 b=Z0AN+xgMR29bAmIyQDchmovUpz8T3sJMEamW31bS8eiffa7+o+dGKKjL5iQQ5aqOmp3vapE/8DtF2O5zafTr7nBYaTvUn60gT16+wffF6bgw5H4j9pd04lz1lUXBRHL3gI0dT5HvSQhv9yNfWAf7hzoxfkk9h6yR7dvGx2MkSzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3685.eurprd04.prod.outlook.com (2603:10a6:209:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 09:41:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:41:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/9] dt-bindings: pinctrl: imx: use minItems
Date:   Sat, 23 Jul 2022 17:43:26 +0800
Message-Id: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4656b836-3c78-4e84-2b0e-08da6c8f9395
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3685:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4I7Q5xhkNN1H56tLJZ8X8YjQ/N7XeJ4qEOeRA4nppNtndIACxaie3qh3qCK8lbxoYgejUiXWnSvoBoS3GbrmOvruCoMcuu0Uhq3ae8o8NbzDcUPWYtTIEpZLoDYGbWY6UOxiEWFyqL8MAMcwzzWn+D0fQBOm7w7qs3XhcwianVGBWIaMdyBpjZO2BQ+vOcqXfh4sE2D7dTzgq6pLUrBmCCcXlZwZNL7hylwUx3NZiVwna07v/wCMkArm0uSs6hvvg+LSolEl8zc/LGonJH+B8GxUseNWG317ASJmo2ZS8J61EX00Sj/Z0wAb3xwd+1rmk5U8+ZjcC6XcudtkWZB7KwQavbTdwQXuooOrlFIxQu8EiZmy9AIQ2wShZlifqxF/5bSghlxbzPuv6vkvAqEnIDboaiGt+l4o2cvEyaNL2b+iDJLaRLGH0a/z8Pp9BGvFLPNIetMlXmGwlhZaC6hILaDl1XqwRhy9yxAq8wGZNYKGIMZEUJSf62eroM7qY5OSOrP6k6OOkILc1cMIxpMGWEWfmgzanm88rTP1Xvsshw4YLuPXVRYsK9NjDMaLyuKhpPNOK3K9kQKP1AvBJy2zOBQxTKM6XXNWqt9BQ2eA6yWLRp4nnGLwpnUYUWBY0+ZPLQRUlsxOSlQAM1KR21jmSs0AiNTJgBNav4LQS6MXVyV8ylbP1iVILlxh9u79lnQZTETn3coR5CrrkUB+9r4khM98TTM5eQZPR5jaBc9ERdA50KFimLrAfgKdS6maJaJdMMkiAkgmawaktWXYIT0rkhTy9wgbZbDf87NjdvVRI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(66476007)(4326008)(8936002)(6506007)(7416002)(6512007)(186003)(2906002)(66946007)(66556008)(83380400001)(8676002)(86362001)(52116002)(38100700002)(38350700002)(478600001)(6666004)(1076003)(6486002)(26005)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1f9BxQSEFUHcg1Y2yUXtPnovHBRn1myit6FLKXWa75dFnNG1Rccm+C7gwjpN?=
 =?us-ascii?Q?Bz69QZ1xMAodl7jD1FXLX02yEE76lBGo8Dm59Gs86c5ZZ88F0el2LinYwqOd?=
 =?us-ascii?Q?X0T89I7S2shSSuUe8DmBIXTu+QTib1NFX7M8Xx114zqsk38WfCHtENnSugTz?=
 =?us-ascii?Q?aJ1ge/voqk1ux0UEkOGvKvNqhKS263lau2gRTM3z0rdbnnXeZKojFOoeFOct?=
 =?us-ascii?Q?MEfeK5IcGtpMNo+22nCUCTDkjSdJy4vNeHvM9JMZBwCIAIhVlLXVj7x/dqI9?=
 =?us-ascii?Q?bBD9ZxMVQZGzBcjUD+VXOx1RckHInKxyK+WUxJtSyqQMsyHult82dO7ukoXu?=
 =?us-ascii?Q?ZXisiQ+OWv8a36jLB00VdIahAa4xk1/qGdJnBHb6aFks2s37b+x+e8oOY5j5?=
 =?us-ascii?Q?YSektPx5AEtSfWziynjk5+gqi81a9+R/wr43KwDEVGBnsrW9ZNm0lFYFUCe/?=
 =?us-ascii?Q?zV358izRE5JcV7XRKMpzFF3hH5bL4qnYs0aJoLIhOJU8197qSxw3q7vGQWap?=
 =?us-ascii?Q?UiZ4aQpdjtBT6ZbpYgGzTMsLmqiyXScpbxlOnyBnpIEZMzLTY7YA/43TLPzl?=
 =?us-ascii?Q?22gs8mEAlUwaeTSB7DErAO3nwD091QJ1VAsjv3VM0eERzWPWYCBn7Y+PE1nb?=
 =?us-ascii?Q?jIx/phJLck8nl5odDo9wmWhMll+7QyX2GwGOK4SkGbbkeUQgGkqV2PiehTli?=
 =?us-ascii?Q?qOhoySUEu+pV5qtXi1LJgM6GmmuKpQDvzaEg4sT7CMde5UKsa+QQK6eZBmZs?=
 =?us-ascii?Q?ecdP6mZasQ2vLn5A7VnoVVI3drmZTCgkmFX9NMPnSFG9w09MOyeqhWoHFOcZ?=
 =?us-ascii?Q?JzjUkWK5VrE2xzVmui5t/pVdaX2XJn8qihDi8RBxG49WsMxXjLQPMiOyns9K?=
 =?us-ascii?Q?O0e+EZS87vKl1hFwiK0BidJmdsNKqMLEcfb+w7f+l7eqFEf+DwJ39bsFt4iC?=
 =?us-ascii?Q?QZIILORzRAuJ2+BqaqinILdkhnSF9SmdohhM0I9yLnuhBBhn5aTu1Z/94r33?=
 =?us-ascii?Q?8AWXr7S8lbs+uPDQTvu0M9doEzswIqo04SWszoHa6nXmvSw3HcHoRKJIpDGd?=
 =?us-ascii?Q?WkARZY2k5PeagyDX3hYef6DfMoKu5+1G+O4433LnFQRQT2IHWZWKBiZj6ten?=
 =?us-ascii?Q?fqR1u5W+XI23agfKzFdnwguZOAmdDeT0iuH+CKc1kwg2Fs0rP6blae33ZvKm?=
 =?us-ascii?Q?xodDKyYPnlEzv93R9R2iRBJ7fSmxVdHb41/U1RlEPfk77AFXjE8/mxujvkbV?=
 =?us-ascii?Q?fOqV7PFmOfpPFTJW7w86iDYcdxuhMCJRgBCoBoznaQIouzUNpoYc9mIN5OQA?=
 =?us-ascii?Q?DHJ+kMyeiSZiQonQcd+H1kX7n/+K0utIPb5tCgad0DRQG/ggk0vHLclkm5Ba?=
 =?us-ascii?Q?paIA9gF5hEDZjJUNkwStreO/0pvIGr55zhXdZRlTqKY1N4Ka3ID9fC+BW9bZ?=
 =?us-ascii?Q?ouDLkzleMLP4JZ4quiHgMxt5lk766GcX8riAyPG3B6DsVBhHVD8S3hc9EQ1d?=
 =?us-ascii?Q?uRJcQQqyGv3mpvdNu5EvVvZF+6BBU9vyQWCM6ViHJHW6n+KSP+3ramRTumCj?=
 =?us-ascii?Q?KBe1mfKOGkikCGsA0LzH5biDHCLGpgGd3/xxG4YG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4656b836-3c78-4e84-2b0e-08da6c8f9395
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:41:54.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpm1b0BGaDyNyz9W3jK8o1Hs6q4TvdwShBj6Qd4vrcRdyKHCkti2Jca7+nDMdunlBOq91+Ob2B3vWIR3c5P2UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are many warnings when do dtbs_check: fsl,pins are too long,
so add minItems to address that.

Peng Fan (9):
  dt-bindings: pinctrl: imx8mm: use minItems for fsl,pins
  dt-bindings: pinctrl: imx8mn: use minItems for fsl,pins
  dt-bindings: pinctrl: imx8mq: use minItems for fsl,pins
  dt-bindings: pinctrl: imx8mp: use minItems for fsl,pins
  dt-bindings: pinctrl: imx8ulp: use minItems for fsl,pins
  dt-bindings: pinctrl: imx93: use minItems for fsl,pins
  dt-bindings: pinctrl: imx: scu: use minItems for fsl,pins
  dt-bindings: pinctrl: imx: scu: correct example
  dt-bindings: pinctrl: imx7d: use minItems for fsl,pins

 .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml    | 1 +
 .../devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml   | 1 +
 .../devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml   | 1 +
 .../devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml   | 1 +
 .../devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml   | 1 +
 .../devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml  | 1 +
 .../devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml    | 2 +-
 .../devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml      | 8 ++++----
 8 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.25.1

