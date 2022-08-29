Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE05A4184
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiH2DgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2DgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:36:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BE2408D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD8QkYSXdrkBMDRRU9d3p/Ikb1SjvDB5CeF7jGyv3682IiYiEOAlxhFUu0fS/OBUJuw+uMcjSWea2QZgeZGF516ApCNPcC7xIZPB26zRgizbdAx81W7Gc8pIRujjiquvfKQxj19d1QOQlZ5isNYmFCckRQQnkBFc83kHm5+i/76ZLGuNaMKA5KMjoy7fxcwiUlkTUTWsldhl0Xq04QTwmU1Hg1JmY8jsrjL9ZW04VVzzOYHKndewJN9nemIfrdOJLg0IN6tavO4aCh8QAAJJcYMaW8KoZCO1e4Iz8+3USUu4vHmTjYxtOYMGd8pXY6fKT59K09htI8CZxU0GaOt+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0Flc9jSfIamibQZi9wp9EV1Bi18eBH9d5ekGS3ohuA=;
 b=bAwWi1p+eaw/yFIrA6kQQXgRoSCRQvSESTZthe4u99guaOo/uB9JxkKFTrvBrOXE+r9Un/IMdjvO8eKlLSpvtcIx4IX9QErbq3fp44I3NHfsRlIwvaT+9rPmVwvZU8BFVVTwHZ2ViflKOBR6jy1Zr81Wcn0qntK5n38FoTcHxgKUsO3JANJ31K0aSP/gUupS+j6MCJl7oXM87yrknn3KSjVq/8YaLZHWLJcB2ZNgB9OxXKnfSmvo/w+4flH2kHJS4JrV5Xvv7bRTkqymDa8JW7Cxv/BtnqDiGdk9mm2Cgd8bSKeJVHFuvhuwzd5HgRcM4cSuzPEa2euIx1gUaHEKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0Flc9jSfIamibQZi9wp9EV1Bi18eBH9d5ekGS3ohuA=;
 b=APrEiivr81gZ/gh7hFr4Spz5JZSfiH6e0HV0b8hDbiNAEzkK0kGuUcZkRbwMTdkLwY4xxkZC/EZoh5NA/03Jhu8hSW29VAlSJoSwppAOF3WMnHoOPBMW73De9WF3GdYzcPVzF8vBTf4OejH8bKd8Wy2L2LJoY+YM2xf/DXmhsDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB4754.eurprd04.prod.outlook.com (2603:10a6:208:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 03:36:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 03:36:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>
Subject: [PATCH] mailbox: imx: fix RST channel support
Date:   Mon, 29 Aug 2022 11:37:43 +0800
Message-Id: <20220829033743.2698606-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff6ba998-770f-452f-5796-08da896f9adb
X-MS-TrafficTypeDiagnostic: AM0PR04MB4754:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2S35aYW4Wd4w0ObrMQN0Drc1EIgImlK5hYt4gEfBrjWUNB6d+0zM1RyQV/3/emL6EG/88EM1NQC3aJXercQj68JkI7yhYHRzuYT1XD3phZj537uPAQKwNuaEVmKhBUbtwxCxtusKqAELtC7EMLPiw52IW7qhf1JM0mW3+LBUTaCvNN9fs5su67WrBSxWlNedYWMrS3YdCbuah6Y8r9WoD2vlLRyQRAimvUWzNXTGTUAnjQ+OVrc1jD9V2c0gF7iXU0+bB6YMbZksXegF4ocLGQAl9lTHkOTTB7FM3YwA5c3egP9TOLNdNtBMzhTsuaP3BsgR05juCrJxP6Lcn6N87mYPTDgN1aY8tv/5VJJjSLPi/DnN/UiltTclitFHRUPhs7N4QmXgpLXbsKrBsFZd9LkFtlGpuFGhtNjkVPmzxSTR2DBwAKQzat0NPklz8APFO4tT3uZxoCnsNjewg6xGGYdGGK8EULDOlWAFD+mJPFIDaNPve030Meo3z1xPNnl98IwTIFoi9tFy7BXuEF3yYonNcEKotmHvfWKqfOdHwgQ0sn6P5xVmztxNBzOy1t0JcU9oxhhcsO7ark4sO+kfC8td28M/pHUwtYEgQeU08iSCoSkjJuf6YAPA2byautQOgOU03d2xkuHp10m80l3Kih0X0InZke5LZnA0MLY/a8RZuEtINHgNY1s5oVKeCRIdHFE+0OY+NNWQ86y5hvWwSnQumapADRdJBMJDz2ZbyH658MNqTta8exG0iJPKpPxdw/Xeqm0mTm2BUnD4z2Cww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(6512007)(1076003)(26005)(54906003)(316002)(38100700002)(38350700002)(6506007)(8676002)(6486002)(41300700001)(8936002)(66946007)(6666004)(15650500001)(2906002)(52116002)(186003)(66556008)(4326008)(478600001)(86362001)(5660300002)(66476007)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GkXqqly+Nb9yR6kMGFS9rGGDoUtO1IZ0N+JKeCT9FfFZajtm3RgCKdL+4Ek?=
 =?us-ascii?Q?u+9XXcmhH6J7AG3IKuhkHeLTQZl1AkYyTskNNGPQOcLrl7rVhjIeaBeG4yhX?=
 =?us-ascii?Q?8R8r9+Ck/LmnqnTM0SjlgiUIqdu5f0S4Q3TPrRnDvLB7zs27YS0Q4XlsH2z7?=
 =?us-ascii?Q?KCKaLNhdE7HHHHraBhyJ43MbzaZgI62LGg/PF5E3s7e+9tReUWJoRkTlG69w?=
 =?us-ascii?Q?hzqorcSBsjjnTfCwcSN/apncfIdzFW6kS2XPIKiHuSNZApuE9fr8y8wzyJhF?=
 =?us-ascii?Q?q5QsPsZxemW0zfGdsXL6B1DH/Wxmv/olDDKQeAaMNoCEYncsuGOBRWjo/xl+?=
 =?us-ascii?Q?j0LzNXqagDst2TQ+JvtFha6677XqJoa6MZZEg7ub8eBSgEHDdQn44QitNB8Z?=
 =?us-ascii?Q?Jwva2Ap1uQP2fMxIl8iI2vAhEL6wQRlSLXkiFKD2e3c3ScvOpHl/biMl/ct9?=
 =?us-ascii?Q?ZrPkh/B/e83qR2VdSD2RSrz2HE9CcgkrpO4XWf/+qCGNPCfzlTdHeuxsH8aM?=
 =?us-ascii?Q?NkPPAT2/F4sLr8DG/kdoM5pWb+ZB0hBwtAouqhQZ9AGa28rW6CTfS60OEZVg?=
 =?us-ascii?Q?i0WafX8DNfyoA+hqSKVCwJbwbefeXFq572yP3EfoUfjQaBKfupjrbKIJij1C?=
 =?us-ascii?Q?7tdB7ico8ZIBbjVz/gA+6l125FwzRujXWdZc63k3QgC3O4eSJVlTqNVGUpCq?=
 =?us-ascii?Q?Q4jM5N02Teju1oi6ovNYW7Rv27h2Kn6sNbu6Acjt7vxseMc8og7KDt8yZ3mh?=
 =?us-ascii?Q?b9EY7Xa3+5Td16Hy6pBuW8XkAkgtSZh/Gxm5i3HV0fRfOF9ePd63HUST/nQv?=
 =?us-ascii?Q?UWkesc3CpTQrTohORTU8Aq6hH3UUtbkCcCrswyWuZo4Nm0O0WVu67e2DvqaD?=
 =?us-ascii?Q?WPELTF8ksPZ8LOxkNo+PYvsw6MeQMScixdYSSEh67gE2ItqmgiCD/lAPTX6N?=
 =?us-ascii?Q?B5r8Vp3OrjmnQVgX48xNdfkkEmNxYhMSljMhjDzwlxbkaouaiUX7rjX7G0Tq?=
 =?us-ascii?Q?ce0NRlHOWrp1hwGCnyonvqMTRa8TB1IhIWok0HvNVCr5aHBXmXERcW9VIsPu?=
 =?us-ascii?Q?QSPu7kiG+FQvA+QnIfS6VPm3pmacPi//9WDQG6cH6gJ4JvK9sGp54Y+BDkol?=
 =?us-ascii?Q?fhuR4FfvZdowlmOIOFdzZQ2sKlBqy3gXR0/3DYTCgRjqOCXetOMU74GbChfl?=
 =?us-ascii?Q?Cpj3773Z3UiTWF6i8RYmCLr3io/C5Ro8D5X6Ouc72MumjA8xxEqvYoKdhyZD?=
 =?us-ascii?Q?21zfMn5PUvUNn72crtN1VzNvjSL0SSn8CfSETN36vYrZQ6OQBbcDRtgjIYDk?=
 =?us-ascii?Q?RR7oICiofo3GbQGr54IrPBxCGKKMtPAe1iK+smjuP8ZU2BafPOIbAG336PcE?=
 =?us-ascii?Q?V1b+4blqVXp0bM7aWkccjl1E9wuyXvrNcSWQFBdj6uTpp/hLCLAlw82alZfl?=
 =?us-ascii?Q?IfdXki/uPTDkLspPVyVdchaegdoeSrbNNtpEXRicqXXbkccUFcR57MP09uBa?=
 =?us-ascii?Q?lDa9kRUxhQgVfsFIXBMgiFPRokk/Xx7XUU3uWnHj79PFlo2cp0qPhPJJox5y?=
 =?us-ascii?Q?t8awV1hZLCbln+RQaaiWjJ4FAg5Ou3FmebUzn4C/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6ba998-770f-452f-5796-08da896f9adb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 03:36:06.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPTDB4YaVHTKd61CJcu7D9oS5ISXpV8THjnBSMXBtVfsHnLkS1fQwqX192Hl5nwu4Xwh7V1+CVh3BNKZsO7W9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4754
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Because IMX_MU_xCR_MAX was increased to 5, some mu cfgs were not updated
to include the CR register. Add the missed CR register to xcr array.

Fixes: 3d38ac9c40bd ("mailbox: imx: fix RST channel support")
Reported-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Tested on i.MX93/8ULP/8QXP/7ULP

 drivers/mailbox/imx-mailbox.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 02922073c9ef..20f2ec880ad6 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -904,7 +904,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.xTR	= 0x20,
 	.xRR	= 0x40,
 	.xSR	= {0x60, 0x60, 0x60, 0x60},
-	.xCR	= {0x64, 0x64, 0x64, 0x64},
+	.xCR	= {0x64, 0x64, 0x64, 0x64, 0x64},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
@@ -927,7 +927,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
 	.xTR	= 0x200,
 	.xRR	= 0x280,
 	.xSR	= {0xC, 0x118, 0x124, 0x12C},
-	.xCR	= {0x110, 0x114, 0x120, 0x128},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
@@ -938,7 +938,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
 	.xTR	= 0x200,
 	.xRR	= 0x280,
 	.xSR	= {0xC, 0x118, 0x124, 0x12C},
-	.xCR	= {0x110, 0x114, 0x120, 0x128},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
@@ -949,7 +949,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
-	.xCR	= {0x24, 0x24, 0x24, 0x24},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco = {
@@ -960,7 +960,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_seco = {
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
-	.xCR	= {0x24, 0x24, 0x24, 0x24},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
 };
 
 static const struct of_device_id imx_mu_dt_ids[] = {
-- 
2.37.1

