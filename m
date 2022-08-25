Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBED5A06DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiHYBqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiHYBpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:45:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998F69AFCE;
        Wed, 24 Aug 2022 18:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhxNAC4Zi6Q89IyLvpp0afqRGrsSy2Ku/RyANF07w7HoYL6SmRdqWCMAO9RNwPb40C4Yc2cikeqGGQpMb0qjX3oDW5bKdXYKbc4pWoULJuSnDpswErEXL8P82Cu76I9ot8KoxJLxoj4CLXccbXv+2idbPjsliicJxBkyw9XkJiPQjV5D2AVM6ekpnlGapwm62c0MqW29w+HfKLk3NLrhTjroR3l0N/YruFG3cfCJRzG+UCMZQb21jH2liz3EtVz4/79rk61L3sgjkscco7ZI1KX8hZXjAbfpfQzHtFHXJZLj00gCqhTXPpXDoseBrdoKAKD6bK9WBavqYWOXneS4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+vQZc1Xp+mfCzOKt+qDyO7pbDQ8PP2rP3BBVH+/EOY=;
 b=AUdtCgqaf/OyuP1o5ekADAfhnD0JkeokFVm0nGDek0oiW/xeJJh/aXyJ7FIfutVtMooQz8AetUky+g6LERH7dBVCAOmhfvvuqoCgksj5pLS88gLswADjPYmCu+2T94SQC6SRhLeioKYaI2AjhdjTIOZ7vyRACbkLyzoOAmwS+VwQR60wDZPtNENkHNpGkdlJWSNQbl+iJ1V/ln/5f2ydB1fCpZHqebeF66hNaeQiOMtMHrv813X604UNe0681Fo1uyW0MiHgOpjUwTJMINHgs25PbadctVCEay/1idYjRe7RFgJYAsB9uS3WKGW2mUq1o+YJBUwCEy6hsT2DNdzSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+vQZc1Xp+mfCzOKt+qDyO7pbDQ8PP2rP3BBVH+/EOY=;
 b=mKtF7gWp0ZvgG6QN84YRcDMrx6/wRGsy+wlqs1OQElX5YBMg6UmOjq1Bt9qXPVwO2qIkpGFwTMbn5gvM99/6YPFf20w6WtOPySkq/sP2odZIVNuV9rCzKT6OGvbkAM+oc7+n+qZzcYz/K9RzjhN2xVl4kIMvUVgQhWoPRdkoIvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6162.eurprd04.prod.outlook.com (2603:10a6:208:147::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 01:39:27 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.027; Thu, 25 Aug 2022
 01:39:27 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/4] media: amphion: encoder add support for contiguous planes
Date:   Thu, 25 Aug 2022 09:38:32 +0800
Message-Id: <aa013b27c956a6a7b2949d24eb0f9091c548ccbe.1661390673.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1661390673.git.ming.qian@nxp.com>
References: <cover.1661390673.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb29b32-7670-460a-8b7b-08da863aa5db
X-MS-TrafficTypeDiagnostic: AM0PR04MB6162:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XnoDQO8xUInRIpvD0MGWMYhIVO/4PXXWUXU9R7Y4z3KC9AykSWNwc1/X2jj3NVrp6cghCFL71zkKlxfVmIp1yryqTggApRv7GfbeohOmoAD0vCW/gtBX6lQH7/5cFrsF3AzaZQYLwupwzFC8TsJ13qLSMA29JHXLXzCYn8c6bq1Va1PoRPeKSqK6lSXBrxgQhARfUV0fAIVhF0HgJzovUY8g8nNpQmQZKkDacD6VSZ1UM2ch5xIzGcP6HZqH+T2tnyvZqt0mlu1AMJ/4sCbmV0NuR0O+fHXEewAb+sy8fzIfBBduH3VjpSZhloKNfASUhZqBwD/2BTmPHrx11/I5trqVegeBXj/qUzHA/IRgooQY5aua5gHxb8XrrYj6HimkF/6jz/+DAB09dHP6eBJIE1X1ASHWDDxA4NIoWXYt2CUsUqskWvArLGh969b53xc0Css39z07psEfnGffqbzgreNDrfb9P8s2Wt2Vp0EA9eBqNSkGBEvNpEc3vFsSN6QO4+fFCgfdjwC7ZAtIUdGMHmkIA+LIsMjNtwi5x/sJcQ2nC9rPIyg19n9gUCFy10ghKb7T5u1H7grEWUQrjS3aNG+GCyZzofzTLrk6oHEXh4Z8C+LJqKGzkcz6A2Lq4xr56Gm2v9IlrOjvzC0elLeG0arl2z/fzMlE1kPqEHF04HVgGni9tKH5fjXXRq7DFlNuIla2Ivsmm/a4rKfuOGBVpGHjIWcv/MqodvOn5ejegHHxDmsfS/E6P2jcT2kbIjYTrnPKelPWht6vuOJhAN9Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6512007)(66946007)(38350700002)(38100700002)(6486002)(86362001)(6666004)(26005)(478600001)(6506007)(2616005)(52116002)(41300700001)(186003)(7416002)(8676002)(4744005)(2906002)(4326008)(66476007)(66556008)(36756003)(44832011)(5660300002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DuHCLr/pV6wBLuvLJR70G81Gsoz/xgvppwGz6yitPxkaXQyJCdSVTGgpcoA6?=
 =?us-ascii?Q?INr1DY8PDKrVAIVqOHUqaaxpKtJw2kQNWFbehgaKseaF8iUujG7MXr4Vlrjr?=
 =?us-ascii?Q?4Us2qqcIrXY31/megSgqRMn6Qwywxb3oU7RSxlgU66Q0OqIBuM6aXUeB8x3p?=
 =?us-ascii?Q?qOR7vZYNEKiJX2HHhOXRC3fcQ3TA8ZzMXexXfOtNzY3Gw9tn9r73H2K/I2tb?=
 =?us-ascii?Q?eqo8HTYTBlrOs3EYo9c01vVobEOzYxVRPQfmsA9EIUGjg5aQfQ4Vua0NM8Z0?=
 =?us-ascii?Q?oDThLgjGz4debMVqaMRomuBtPXnGEbx3g086jZ1Wvgyvqsd0c62MUnOQYCHZ?=
 =?us-ascii?Q?CCf4IDetPYQUtL4cfU0TcQ7+1RKG1XY5dTIy7WUFtzo2rvrdwxDR2gYUdZh0?=
 =?us-ascii?Q?CLSrOElgPuBhKsg0to3fMjCZ4M7QMVapzcQf4NRpovG2p1jjy4WN+f2/pvWU?=
 =?us-ascii?Q?l2YRCk/NcV0IkRLSDcuzK7cTG58Xj//44PNhy2sKNWM7MoF6Hp/qss9RHOXC?=
 =?us-ascii?Q?6CsYUCCu+B0/MihkmzQg+sYlySLID0nSHa2vCAasje0CwUnjSS+h12sKUOQa?=
 =?us-ascii?Q?vvlsDF02LcE9kgxpUDQhunVe085+T7AQSNrcEj/7gOaR4iGwxdGlG6AqXjse?=
 =?us-ascii?Q?xWxCFunh5Wsuzl51/j+ClZUOfFqS2WpN+/HQG9wWd60ZrSsIQLDaz7v57rAh?=
 =?us-ascii?Q?7sDDGs/OtmwFNGhKBDV+2lzB94hlo07tNlW62NCjZQed13f4Xs7x60R93w7n?=
 =?us-ascii?Q?pvgme72+HAJGV/uuyf7pGBGIENgvYYBp2sOutS9ajpwdssWjd905LJYZUP9v?=
 =?us-ascii?Q?mPHBzjt0hUeXlLVpYmk9jY1E/bxI/3kd9NkOMR9XYTKIm2O4O0HEAX9QOLvX?=
 =?us-ascii?Q?uJgbA3eFDiYYu+e7qc0CnM34jNXIITvAR8raOuGzHwMs2SqT3AheZI+17zuy?=
 =?us-ascii?Q?lG8JXtvBprCjUN+PLM3bwOVtF0A54DUJqXKNaufia14R7+pAivE3bVFxQPnw?=
 =?us-ascii?Q?lcO5PkIikEMsdqDL7vGN8+74fmkV8PeNrr0GLV24sMmyhwFrZ82WNPyRohTc?=
 =?us-ascii?Q?7ucTTu0TAkICov+29XmJrQsqnLWESCvz/e8BFdi/v5zhoop1Lhbihr+r9ZKK?=
 =?us-ascii?Q?RHumfl0cp8kI76YwXuFruQ6OlfwkhSQ0/TxI9u6lQQDkoP10TJQ6F1aVNHBe?=
 =?us-ascii?Q?6WM9wlPjwIc6+wLYdFp5Tai6HwKiU9WmuFdhYx4Ube79MMyHQdzMIjqxXgI4?=
 =?us-ascii?Q?inS9dZOG1eDGLRC4q43PkQFjJrOBB79KhV3xh1nYd6UoQhWIwmHiIjxnRKoX?=
 =?us-ascii?Q?GtL4DQeO18vUiLZ813oBDblWsFoJu6m2ONDoNzA8iQ7k4m5yhLAfEZgxeIQQ?=
 =?us-ascii?Q?3SOEZdg8CtOrBOI5sNORSuroCMgTZMmqDivRTOFS26Oj1MMoW5k45uTsV1LU?=
 =?us-ascii?Q?x+rP3C3tEndJtSPt7vTD6a9mtymxAFl402KaCPDmGIRbqgcv8m+Y8wgKQ3+h?=
 =?us-ascii?Q?vPsiuilqfQv0b943221d3d1u94JOZzlKDsqv6sFhQsxXY/Kbo4XzIIG/R2yp?=
 =?us-ascii?Q?e3dCkuwmovOE8McXLzsgOEJzhOdLnumNometdTKn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb29b32-7670-460a-8b7b-08da863aa5db
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 01:39:27.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATtiL7uHCWhrhLroXJfYtAPXsJUAcgN+xoCaVozpIt95D1Bn8ezLBUc4/m9b+y1XXWSnU/G+2tKKBWT8QlZFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

encoder add support for contiguous formats NV12

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 drivers/media/platform/amphion/venc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 060a1ee78b17..3cbe8ce637e5 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -72,6 +72,14 @@ static const struct vpu_format venc_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.37.1

