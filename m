Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8579E5542C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350077AbiFVGNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349287AbiFVGND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9115BE28;
        Tue, 21 Jun 2022 23:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJB6MCDgnbcCQtsYAzNtYq9uKV4IzcvOtebN5eVIq6yEZYDu8Oy5SDLCbA11vBJU7bruTj4mEzkR/0gh3mtkNB1h06JeQZlnABtwj7+KKc+UpF9KDMpLOLiAoeieu9/02QfdMkJjhw9ay2JZ5HKFHG5o/Je+Sulzv1o+GUSBdbTxI4X9VQ0pzQRdDs7K5YIj+Oyiz/Fdym15Z0maSouXZIlecfb8JTxWMqN5mLGYobYhl4nAbVdALAW2AhuDZ66x3PU8VMO4JNzVze+0vf9J8OhUlc0U5AaIR/eg4M5dElvS61jJvPqY0DpvFYcICm43TlRHlfh+VDaw5Af3RwkMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja9DLDG177IS/jKq9QdxJSL/IfSgLun9+QXkdKbbrPQ=;
 b=UFFHdd9LnPrqp6Uhy3juvU+2W/mGee77hlkFrqy2OAwfCC9rvniHBWWEO1ZF8LdEmyFn0Q5X36QAe4VjevDOYdy+grHYtXhG4xgfScChlYLURvbqplCjKL7209I1GIiKbmpzVkriYNOU03WCFusxRnFYYcaFmNspxcDu4OQXGXI4tDidksg3HQ2HHPzzqjka/jlRd9w7z+hJPxBy4ZS34gana39npDhGVUm7lpfErGuO3cQmA/lKubD+n5842cMTCwV2psF5nfuqeQFFKQxzeSnXCSheD2ZPTY1hAB6ktTShlF0Y+y3hZ7t6fTLG16DzL468S/V3DFpFQnFJzo9rZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja9DLDG177IS/jKq9QdxJSL/IfSgLun9+QXkdKbbrPQ=;
 b=bx6HH9RlB82poWsLIEjoEsAMfAIhTjyrZpap/KfnZ+GkUdGl6Cy/s0PQE1jp6KEe/tIojsgjLUBokqORXJDvUScGvUmEqDO88bELzdh1nHbg7S8GpEjzSENA+l8tDtzflZgUE9RrV5lM5HeKIyqmzRVgWio4BqYCVFec6LId+Xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2796.eurprd04.prod.outlook.com (2603:10a6:3:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:12:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:12:55 +0000
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
Subject: [PATCH 04/14] arm64: dts: imx8mp-evk: correct vbus pad settings
Date:   Wed, 22 Jun 2022 14:14:00 +0800
Message-Id: <20220622061410.853301-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90772048-c83b-4720-753d-08da54163efe
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2796:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2796059E434960FEAFEC09C5C9B29@HE1PR0402MB2796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMXGSQWsuWEPsmkVZhI8yUzQIpJ24ccjHa9hApJXs+6Q+Z3BSPu8/v9DTKMOQs6byb/rM48IUIL8UdLpC2DA+/rSjqDJHhasmeXnZpJBm81CqYnDXjKVOMj+lzFb58Fec4tYMu5llOMpkYJ/0oFStk3N6QAI20iK6ju7F9l4cyhe98Q/6+GvVPQqtahNv2IYykR75Hq/fwCVjfIRXH09AsgcfA2OVw06zQbH/jBMIXfscHqK+SpTuvYOHVjXbdn1lzDqJncPmmWYCxQOSPD0wDhRHikZvAZcclsnmnTQpsNGIwRkhUNDwaRVo4iyaGZBbns1OOmlnx/H/lSTUpxc/tMJFgmUmDklwdktZrt/lzOrGG9P8r70f2KmkL2DqWm3Rc/Pxj3GK5xDT8lj0OVonDUzFRAgoOWC1yweaJxK32J8bM5BbV4q0cB+SEoJGNluREwd/o+vPbrpofO3kuhWqafxuddcVFeD9HJzdJehbRpga3ULq4PzwhgpyJgu01O5c+LlRF4ixhhrC7HikFWEBLH0dPRAjsnVJ1lJyjEQ7FCsodSH+yLZErTwDt+DuvcBfOi0qqceVWcvc5etiRgjh6SCy+hcvJwCecGdJzxavELkMfA2H+pC3YqIn8G7bG1tz9GXah2l9AbcK3urG65QtkzBRXiiuVjjrMVGs5mrabiixxd6Jh7IPEEAt2F3QQMTslR00UXhn3vJMoPDxpT3BWNwjyKERC7NtpnmLvW25Q/7Cex/0xDux8f/YAxHQ7wef4azU1YdZuBCrEyYAcSUfJdTKJUP5UQOSls0/KbuHDA4H+XocK0aTTKdvtnv2Y8jK+qPVs/rGMvblUTQwZI6uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(478600001)(4326008)(8936002)(66476007)(186003)(316002)(66556008)(1076003)(66946007)(83380400001)(2616005)(6486002)(5660300002)(41300700001)(6512007)(38350700002)(6506007)(86362001)(26005)(7416002)(4744005)(52116002)(2906002)(38100700002)(6666004)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qn7n/SW0KdJJQQTOJOlP4UiMIzvMxT9mDi/bvIFO8otzv7W0ClUw8G1efE/L?=
 =?us-ascii?Q?sOr8X0GoZivOrvVfqh+9kjKIUhItCvN1ofOMUAMxWbV/9/lnKtZ/apfdw4RT?=
 =?us-ascii?Q?CIgvHejs3g1tOc4aI5znPIseBLmp366BJhnXIEuqrwVTT6d9ehOxUM4EIMZK?=
 =?us-ascii?Q?WRDzqnijTuoSIZ1vQvbP9ETXajQEwi70K8pK7l/CRF/qXpPBpWEOCCqR0EHS?=
 =?us-ascii?Q?86CJQX9dGhN9KjZ62A5OxRHyzKRnnMwOWXkEh2ilGyiPaa9Wv25JUxQtTaUS?=
 =?us-ascii?Q?9eGFBHsnKKQ5cc96rmMkfMmxT2Har0lKY4vj/4XwIFYzWYmsq+FUR/s5fuSa?=
 =?us-ascii?Q?hiJxv1jqlMK+sHs7EqKQgycOpknB0DsvsJGaG1HLGMUqbN8CdHnJJDVxiMZx?=
 =?us-ascii?Q?WKI9o8A5Bvw6xYKysXw5tKpjqo445RrRx00Xqhk0D66hZlpBSqKJmQ7XKNWK?=
 =?us-ascii?Q?YzPiEbbOhbLV0BRxq60RuIBa+zBlV5KppPbIPBHD9Fh96tLprU9ghcY03OY6?=
 =?us-ascii?Q?c4F3AtC6h3ZOi+cqbaAV8fyZowYjFxmVEnoGTH77xzMlTJ58Gi/HyuBGRaKO?=
 =?us-ascii?Q?r1cpz7QaA9Y5bAODlFJJ/dM/SfYWRY5yZpZimB3c3l2U2wdYghG4W7cK3ex6?=
 =?us-ascii?Q?SxYlSxf+hLYjcGFdQXZ6OPPHaPABVHzqgFEH6FCQt5H2W8a2zZgEqpKJOgXf?=
 =?us-ascii?Q?K/N1/NXEUWV0T12RSapzOuxT3ys7zRyMMRdxeSx5VXpQ6PpkFVdHY/cOMDAH?=
 =?us-ascii?Q?SiAQ1Yx4j0tBAXLeTMGUm2ZEJI+vq+O9EFz1Eg7zMRbJyDA50FW7OesG++q+?=
 =?us-ascii?Q?IGGJ1Q4FUqlsHusM8olWIIolamKl7sjd+MgXbagR6fwqA+mvA7vVNuYI0TQv?=
 =?us-ascii?Q?H+MMz74la5gX8DglrXbhFMO+5lAoGPH2igRCK2n+4w6HA+4dKT0fUPDXQYBL?=
 =?us-ascii?Q?4e4Yqu+KGsZRuoNwkhyWSO8u4E+gqSmT4friEYnQGD9YqDw4fXT6GRIG98Qa?=
 =?us-ascii?Q?5YVL29QSdUtw51eNlnn0LTut38PsijzgitczMEcn6DklzeDGOmoVpwwjS5wu?=
 =?us-ascii?Q?TjlHWQ849sULEbFzBI8Rs0z83lz6vtM45y6LHaWCXWHfzB1HBg5J6Tj6Lit6?=
 =?us-ascii?Q?t1bROnnymqiyZqwLYKZfkgtLOlqGYbbW7r41ZoteflrnK2xT+yy5ZBFOYC4U?=
 =?us-ascii?Q?0XjLMohsfT64ulvRojDoXq4m1GwSVJHWxV9TFpaoOVpGmb4+Bn4MaGM8yrZC?=
 =?us-ascii?Q?7U2woy0LUpy9qA6nA2XWlaqIg97MIuM4tlmSCHezq5QMFKvU8ge7ir8b+6mo?=
 =?us-ascii?Q?HQNScL7wg4WoKJZ2nfVtHxGg1OXNromq3Awn35OeF7G/nnf7QqWSci8eDZSy?=
 =?us-ascii?Q?TSnA+WTrhvSsUcERiHHo8Ol37ERAaEoZtmsZVyt4rMR/BWp03dSi5qBcPWoZ?=
 =?us-ascii?Q?gEP5+42Gw6+9jKYEtnQLKaCxu/zWbnB9tViWUpJTjOMAnxCVJaulKxgr44sx?=
 =?us-ascii?Q?Lis3Wl0mxeQK5XwVx3s23XiFPzF5sRbWu+QnqGj5NRAGf0Or3mSV4PUaJQwe?=
 =?us-ascii?Q?TT1+35Ful7cy49LkgrPSYI8mLBHE9yptZ8CveN+5ByR8Cjb98oihy7Hjl/Ac?=
 =?us-ascii?Q?/PUVd3I1eyrzLS5SzgSIOeu3ALJqe2x7kByficAy2mDt/T/oaMEod8Oi3il6?=
 =?us-ascii?Q?zZ5fut9vB9f/iTKO8IZzYt7AFa5aWIAJ7XHPEvHEnTSnAKIFbOdCRlbxyrUQ?=
 =?us-ascii?Q?fSxhT3Zpnw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90772048-c83b-4720-753d-08da54163efe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:12:55.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rr/R4zxiFZ+g6F3vEhoHGlT15y6p+6u93N45CYFaABn5qJu6FokNt7hUBICTlHJ67XOqcosLbf1ULD1YhmoQNQ==
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

0x19 is not a valid setting. According to RM bit layout, BIT3 and BIT0
are reserved.
  8  7   6   5   4   3  2 1  0
 PE HYS PUE ODE FSEL X  DSE  X

Not set reserved bit.

Fixes: 43da4f92a611 ("arm64: dts: imx8mp-evk: enable usb1 as host mode")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 0e94e10a38fe..a3195e65c742 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -529,7 +529,7 @@ MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
 
 	pinctrl_usb1_vbus: usb1grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x19
+			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
 		>;
 	};
 
-- 
2.25.1

