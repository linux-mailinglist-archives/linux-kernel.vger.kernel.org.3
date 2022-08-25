Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42E05A06C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiHYBq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiHYBog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:44:36 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34199E111;
        Wed, 24 Aug 2022 18:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QppFJpYd2VQ4O7VZc3HIvKWhAiMsOBGFhdlxlOy0fxwp4VWTMwv5dSM36YfqtLSQ6pj3nr8WtCymeEA8i+ciWscqmyKEsn3OvMetGRmpOuuYNMwJrmiZvD/b8nrSxF8hGAl8IphuVg5RWPVD9rFMQG24Wg3WrCqnI/UG7gjs6rwEKgwSU7C/nPJmRcdEdvwP0oDvSUK9dJeAkvigUK4G78aG7q9+N4uZGG77hT2tuPcAG4hQohtRoLe5JWZTU/PD3AU1jEoYK3Q9S6ZQFmqg3cr6B4Snx2szXZPer0DgTSao7KMyEOj0fQx2MfNcUjLbzfccUGxQ1jM7lhWC35P/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rch1E4cmHaaGRNWOPA+W2O+I/XHm8NIZi7EBnWeVgmE=;
 b=W4CROm5oqE14JEU7bInaEY204wnJg8iuIqBcIW186h6negb2tyL+Nfdm0svpCnvJDRBRtG/IkhxfAPcnAIXo9pYNzEyownZI8yumsip+6uKADxjWqTBkt3smmrebU4U5w7ITPdP8X07fCI6DilCDdWu9v5j5R4FriGH9K63xB5CGzVAeepSmMcwabxn3spdbXn0JYCgVrtrK0bQhjiCM6E/KH42WLBx7WqS1vNnwBMmNkw2FR/T1QojfDIuFQ2ae+rCOK49SRUp7cXuj4396OoD3GZB4Ltipc9stvBQZKCoKCUm+++WJoQNnlSwazM//9OSYhUNkgcjcrKf5/bD/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rch1E4cmHaaGRNWOPA+W2O+I/XHm8NIZi7EBnWeVgmE=;
 b=YBugTwIvIQJrEjZ5lr8LllMobWjGWE8HHZ4WIDpjZ3wm9fJy+iYDxQqjdLvYwLZl8KotN1lkPF7bWQfw9zV6tCjg5lv3c6SA8YhbZJ9NzddYBfOvX7Us2DRYpP1ZZWVADfFI5WJcfyn8V+GqDh1+gvNdbFy7orS/IjISh6Z/rqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6162.eurprd04.prod.outlook.com (2603:10a6:208:147::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 01:39:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.027; Thu, 25 Aug 2022
 01:39:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/4] media: amphion: decoder add support for contiguous planes
Date:   Thu, 25 Aug 2022 09:38:31 +0800
Message-Id: <3263e00d9b31f9f4d8621fedbb37a08d7a33a960.1661390673.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6f95814-98aa-4f60-9b1e-08da863aa39a
X-MS-TrafficTypeDiagnostic: AM0PR04MB6162:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRKGh4SWmqsKJruDwjL4lAddreFSS6FZv53YV76JVYx/OT5Gsmi2GVJCl9CM7yjSbnvvFDhmjTRD5YBVMg2jd2HaI4iaL72F8g0TBLiAPRi15qjMchILQYPAp3rTwGkR+knlFV7WFccQeyQ36j73w0lsGfqdaZfTg8NJIiDz3xgVKw31c3a6y3dvNnpEEsxgVDlf6jbxZo4nqzX+c3FnVR6uMc+Ih93UGkmNb1DNWY2fsvj7ynf0XCs1IdtcokXVLew6smb7fzyvLBRKyP6EjVo+uJt0ZrDj/2iNohWrKugwJmz7TvOLksCpWD4f66T+0wsW4dcKE45vyiWIaiFqX9cbaA2Ummaawp7N9iGmBGgxfm5tORpmobAKcSQzeU8Ao9ipgjrHN2dQt+vwIcBpgjicTRAT01YaCZy935GUe8Ghyh5wyeuj0zGpQUXdoDfYfe/1MV1UuhLywp26S/EfnZjOiwkgQLSFpdGh9Hz3OJhOgVQtvVnD4pTMU2QEEwQWnPk0jVfl4PuDLkJyJ9Qo5M/1AoL0EKKV0UDHoSfV5ej+9or++zc95hX7hSySuP0KZPcik9TH9k2tJKFclu/WAq0cR5TEuDG8m8H1WiKLcYpWs5vNQNUCXskW1NEEYpxrwKF/4YyUL7t0vYaQg+mVjUkbIr2FTSevZ8CQ9Q9HPi8M8UspnJKvvaQremsNYtbM0Evas3Ee6oyuFRexYeYgYKDsPnbu21HTfhn+ACnoX3NtAcD+37LYz//vluAwWOqWXrVF4UZPkb6/vetOLBsLGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6512007)(66946007)(38350700002)(38100700002)(6486002)(86362001)(6666004)(26005)(478600001)(6506007)(2616005)(52116002)(41300700001)(186003)(7416002)(8676002)(2906002)(4326008)(66476007)(66556008)(36756003)(44832011)(5660300002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LlbIGEFz3JPBfoKtBKxAeiNVoae2+4Y4BHw8hqibmjD+sBNdPqOnADoXkaJ?=
 =?us-ascii?Q?TrDBVQuw0bTUp3Mvv6d5d2mrY7PzifH/3jB/0xz13HI2RzimvIHcbP5ECP1k?=
 =?us-ascii?Q?KI50AAB6N/ri0rVlgi4dKmNeBqs6FnxIyFqff3QN+2kr9HkWSyGvvNRNChcp?=
 =?us-ascii?Q?HWJwaDqEkj+EDK/3FGqK8j8sONwMeTjoXq4Ywv88Pi4w03Pm0ty5pfNQvacr?=
 =?us-ascii?Q?aLZTt2Ig+41PdYuqPQeCu/QxAraH9npTzX87JeIWV4OB9mWU/GZJki5OkdGi?=
 =?us-ascii?Q?xRmRsa4NYyNHUz7PBKEy7w0YfLp53xunsAK+xxQknH5qbayR28ZaDCR6qE3j?=
 =?us-ascii?Q?+53wC05rzVwWnVNGcfDpqcydgJ430uabekV+aF3iu+4Aa7hN2ywK7hRd+XoV?=
 =?us-ascii?Q?4Vc+314utKMSiRPjMiRm42SYFq99EZ0aUmkvEXLfIlOWONm6iik+K6DK7Ul9?=
 =?us-ascii?Q?/yNuylqIZjDG+nN24iB+o66MzL8RdKfNm5bvatDAe8v38M7lc4VkudgVrWid?=
 =?us-ascii?Q?gYPSPpdHQGTMMSdH35boXik0i2ffC8G8iV/wrdeqe49VOKqdHldC0InElZKO?=
 =?us-ascii?Q?+xdKv+94uklziQDidPpVoInhLBTMivVNqlHiZ39jODAG4SjutbELrqDXsacD?=
 =?us-ascii?Q?x+EhMdXUF5yBGaEFoAFYncaCCatq/VWLw9I/EmWC+2gDGgTkMfr2qItolipm?=
 =?us-ascii?Q?2ZauzNQcLkGruKtILl/AnXF4cj3uL1tahhU4kgBdYzCqyFWuYnql/oKnxjMk?=
 =?us-ascii?Q?QxgzAzYG+mrrW/rdBuuApC6tyCGf4kd7UdhtBY0IzyvXAOJngD/S+dxRsHuw?=
 =?us-ascii?Q?EHo0BIma4vPlhRbMcclS+JyBUgPIGbwO9omJu7rJwOn8PvnLyRpaCP80NWPg?=
 =?us-ascii?Q?ZS1HjqPUq6dn7AyGCdDG4LQd2B8qxnfZtNay/NmJo3JFkz/XMcM8ZYuqRjwt?=
 =?us-ascii?Q?d9e7woR4LLdPQliEwi7q4TesY4OeIhyetS4ZK9eDi8DK9c8yEuj/r/LS3QlP?=
 =?us-ascii?Q?0qpOTrePKaSDXEu3Ciea9QzyzdkuKgsWg3x1CSANXI0Im8jLVCgCoE2YbQFN?=
 =?us-ascii?Q?l7lWhKl8/ZczOCFUvrz0oidnZ5k6H4rhm1b410Kog7Eg92Y8sj3hubCKyeNR?=
 =?us-ascii?Q?ShELybcYTQBJJAGlJme109jORdFyKXtf44DpwfknXJyGs3sAKyk7iOGPsNFn?=
 =?us-ascii?Q?07MBNCOmg3lwmuQbIhWUgwYST10K6j6L6q7awlNUoRJt1OPnagY0ahQ3zXjg?=
 =?us-ascii?Q?zDHVHdPE6s3wtIMnnGLVB3PxN9DaXsjNurJ6zjnY4EP+b5LtQ5bdSe0V/hWO?=
 =?us-ascii?Q?Nj83rPWJ20QegQYQ35lRG4HVd45Qh/Ny4vovDmHpXPJtRLLdgtus56nl3ny9?=
 =?us-ascii?Q?RfdoH49mOLiuMQTokiLumxC7FjiH08jYl6EIAyVCOk07FhPh5T1TdhylDA65?=
 =?us-ascii?Q?vfnO33LDYcZ1k75piod0AVqYJcVWIzAks33B2t+fDoVIydXKEEJGXP7DjCrV?=
 =?us-ascii?Q?1lyuOc1dFvLM7aL2Nv9YjcSe/7uKCiKqkRgmBPy21baKRuZjFoDml68FEhQf?=
 =?us-ascii?Q?pUoLUbnTWOf+HLGeGfpkskDmb51VMmnLccZ7fyDh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f95814-98aa-4f60-9b1e-08da863aa39a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 01:39:24.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD7z8/o8Y5KwsTU7CeR0s5pmaqpvL5PE53nLUPevfLOU/tW4MCcGgD1sYiunK8QOPbnadidsi6KheOhTHaTCCw==
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

decoder add support for contiguous formats
V4L2_PIX_FMT_NV12_8L128 and V4L2_PIX_FMT_NV12_10BE_8L128

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 drivers/media/platform/amphion/vdec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 48ab664fa7ef..9c3324717cbc 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -72,12 +72,28 @@ static const struct vpu_format vdec_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12_8L128,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12_8L128,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M_8L128,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M_10BE_8L128,
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12_10BE_8L128,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12_10BE_8L128,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M_10BE_8L128
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.37.1

