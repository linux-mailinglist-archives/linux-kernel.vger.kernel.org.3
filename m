Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9076E58D410
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiHIGvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiHIGvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:51:37 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC297205E3;
        Mon,  8 Aug 2022 23:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7Y9OlGSRJf40sfwJu93kH/5AREUYouQCOzhEdHmwbZRLc71X/AnEdeYdZEpyR5XTci8G9eMbWnS0oqyKZuDPONY7WE2TJ4RZuCrE4ZQB/OIjVkDOGJW87kqHluzyS/tKqinhKcicatYarw+hTXY9i6xMsoKVE96jWJcREHURqF03jhocvJWrUJWi9fg1V1lpZixgkd8zxVF6zn9PJIJqM/wgMiQ2lgaTmLygaNQk6FP/Wpm7v3WYfH/Bz9Ua740E0whTHEjNjieNVQl2tCBee9y7KvMSsaFU/YWnMWi2rxx5JSCJts3LscBiGJIh5w7wDLv1q5RPQnOvYGDH2nLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJYhZrcRoC1KxJoTFrpUAz7bIxwoJsSJXdJ3vCcbV18=;
 b=O/mBHPcJBa5Gt1L8jgqmxXNVupjblLyUIjt1u0YOvWOsmNOeuTQdXHf21tsDnShWgR3j2N96ybboQ+203DasE7A9RoNd9lAIza5+2WxAwEJzu/msrWrCIaTxKCsxZ+7MjZ3/trZxn0OPyOd9EtdbfZVU28i0nlu0fHhgt924J8XO7hLKwG7BSPiLk7k99Hf196nseJ0+1H+KQNrIWYeqKO4yd+Hx7Ku7M1sFX6Hb3Zy+y0jRSnLjF5mclIGp3aIDwwxJTOQUZP6mYPt6OzUydW5Mmfk5wkY0ADEsDK7grOAG/DiwSy2ckLo04wQwKZqKyvfN5Y/BvCHLX1gg6hbb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJYhZrcRoC1KxJoTFrpUAz7bIxwoJsSJXdJ3vCcbV18=;
 b=VgX6a6Y0nUtUtS2C9xm2oUUqLY6w1fWEXendkvNFkDVrMsoPCoBiHunSD4a94gNkjbbS4ElBFuft875vXkEjQe+QGjRYpcGUwKlQ3JxJYI0eDyxrIO1BcEUR7lvIkrkCUSU1gwLEQWfHfiMg5o/qcYubiEryZDAuC32lHgOgmQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Tue, 9 Aug
 2022 06:51:29 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.017; Tue, 9 Aug 2022
 06:51:29 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] media: amphion: tell and handle contiguous and non contiguous format
Date:   Tue,  9 Aug 2022 14:50:39 +0800
Message-Id: <4af9766eb664a02d1c5884cb48fadef24dec142f.1660027440.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660027440.git.ming.qian@nxp.com>
References: <cover.1660027440.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acddd6ef-2f3b-4a69-21c7-08da79d39635
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQMQQe1LzFpnOUWeOm2bq9THnIP6V4qdvplp4PQ+wgz+8BvdaBRej+KP5viEI1YNIuxIxXtD9fN2Kpd4BrCz8OUT9WpDRvqbcyxjFXQ+IYhMzGQyEsZF4VxrgfEhU744+an0TUw8evGCmGvHao4934VVebxlzMghq8HAFmjams+kXnlFQdBAQBI7YJBfrxsaeyFik4U1mCQcawaqLYC05E/pqW23HYjUmxGaUSVBdjiiyNfor4itcR1hHksaVhIhbrQ6D2VPzuF0iQ5V3m3fagv3HzoSMy8oIA7EMwrvMjl6QXbV4/wagmEjiGhq89Lss+wU1nDJJqroSKa9Zk/WIgpw4csLyIqlv5mS/JzDY50oNl3cSkRRHx20ob3LvHxaAtoWTMb1FNC4RDqqIKSyIrblMwUpV161/quOJ0Gf8iITWDrucNJryYWHVeCJzvcfGiwdNOqltW1vG96PIEguLaa4T4jmpo+Wl6yY1XWLnYsdn4b5F8KdYtnNp9NJZmGT6BxPThfz8I7zkgZmKB1gUN+uyR9qQA/ipkFcrj4ObZO9FVyqAFIGU1WsiSdAP08cfUJj4X2COZBHxWOSoTlt5iTbrLTT0wVIpZUXQgNGUPGxOf6Y6Q3ToCeZpRpY7aEO6NiKFyDfCo0dDHRtDejFCtY5qru6EKjLQb1A1vCsjIozmIqV3FCHgRYUhMi9BRjgAINsqglBapJ+MhLziEBJZzpG7QIQsuWz35HQD+Hi6ZPVUoFamrQmk94czS9sTiEr17Ec1x7nU099dw4w0A6tj3bC9j21qfIWzasE+6zwVIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(6486002)(478600001)(52116002)(6666004)(6506007)(41300700001)(36756003)(86362001)(2906002)(6512007)(2616005)(186003)(26005)(83380400001)(30864003)(8936002)(44832011)(316002)(4326008)(8676002)(66556008)(66946007)(66476007)(5660300002)(7416002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4MZhE5GKrqRE7Z2kgP1zJKmo0T34HdCS9zbE4f91vc4Vo01e6XZcfYKCd1+E?=
 =?us-ascii?Q?6Naeyi8b+JvSYLhz56MLJH3aviQ9ER3GT4xDYOfQOSrOldGkXvbSws4clWDo?=
 =?us-ascii?Q?1HTiKLfFm4rkexOE4NqCXZfqGI2TQCodQNL/O5yztI/Eu/kspjw+UtaWWqWJ?=
 =?us-ascii?Q?WZ0EliO7DhS8lqv1Lo2fyupMRGaJdWllIXxE2DbUvT6DTEdOdEX6Ty5zeUdV?=
 =?us-ascii?Q?Qd12vfe46tkP0RSICk8Zf+B55dLf6Svc8EY6UazTBlJ4uEQaUNNCPeXQ+vRX?=
 =?us-ascii?Q?Sgd9cwfW3iVWobTrqGHHr87dj8NPv9oU3azCp65JBZNKcGedSMCLrDbIW6mW?=
 =?us-ascii?Q?nNRcg/bsFi8Jch7jJrPfjcsmdrN/5NWe7PUN5jGa4ZzXUXOxC1SkXH1JODK3?=
 =?us-ascii?Q?MIguhjeiYXRJYeoDyl4EZxnxTpReUOXP5Br9tbgy+Jn7S1RD0pPZN6QMHU0X?=
 =?us-ascii?Q?h5jcyPuE7dw1e5OLTfrDJEEqfeIc2Oe33r9fVi+H03/nSm3YyhS6mDcJZZBh?=
 =?us-ascii?Q?6BhRRyHnbE+wSq6NN+lCIcGzR7oO8bkchJU9HV1zLbqbKx2ENP29zqCKdH21?=
 =?us-ascii?Q?K2MbhfDYOUr4gKzj0RGAFfmWy8P6VsNIEGLaaOv4T/IghMIoYBYudl8VfdiV?=
 =?us-ascii?Q?lCufhTnDlVG9RNMyK2WEO5WCU34j3QVoy9citxU9m9VwGJ9VgV8e9q/BOgVs?=
 =?us-ascii?Q?VTjD5gN8mJx8AZYajGhlnFBYlmNpODb/By7HqIEifZSZRI7VKi5TjCvRwzxH?=
 =?us-ascii?Q?DHoOsfAEj8Zc/oDdMGYtAwcTr1HXKIPXdmBHzVkNnVUxZCno4sMw5XgI/srS?=
 =?us-ascii?Q?DCLU3PQZ53i3z8e/ddnlcT5rDMr3Pftljr5jW6+qua4COY0F4b/j2XEWLuWK?=
 =?us-ascii?Q?w7KJycvQzg498z1yRi4eqFpxCw11U3MUdSwDjIIWB0RWXqO9L9+HdWkr3I1Y?=
 =?us-ascii?Q?0YlPg/px/Akli32UEojD1nuz5OEI6QWZmWJK+etE5A005/Ge9OR8gKKAhm4g?=
 =?us-ascii?Q?M3W+gVjll6/wJ5/GoFCz100CsVrwDDDO4xqcnLEwUfbL6Gd/J2UYKFYISaV0?=
 =?us-ascii?Q?LofnEHzHfA+LGhtpsL1i3Ko2aWfAZrTlxnKRdMRaRY2+IbrIuvHBkv4BqzPQ?=
 =?us-ascii?Q?fe8MswIdQRiu0uWbWW+ABNwxDMKd3JqXCLaVHLmJ3JxoaNxutU99+NRRN9lm?=
 =?us-ascii?Q?VELq61Y4kjBzD6TnFzIlqeubP08rhc/oqSy4iorG6o50fiiWwcSBKdYODhJH?=
 =?us-ascii?Q?ut68bcdmA53REwhFrLvc295TiKF0IureazhHeNJbpxlCPG3+IUVYXvDgQsAS?=
 =?us-ascii?Q?l2AXQK2F82O2swDG6MFruASqBSGc6IAE4RxVD8Y4j+9rmdl/co7Uob0Spuo/?=
 =?us-ascii?Q?fXffDIPog/xPEjREjiCd10DbsvKKw/CXAEXzufWMkmiz/CnrGEwgnoytU89x?=
 =?us-ascii?Q?/mFL2xgmhNp28q8h85i3NoGHM/pf1S/gyXQeKwL/qciDDRJJXHiPK+SIn9sn?=
 =?us-ascii?Q?iKQ8vOAPeCsJaRxT5g+rR5TaHqj7LLKdL4I3QsXyj0IU/Y/wsj+whLJzXWAF?=
 =?us-ascii?Q?pkRwu3O3vZSOHOEs9PI/lz+cRJieV0QeyJ9NT04l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acddd6ef-2f3b-4a69-21c7-08da79d39635
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 06:51:29.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNtNLSD2THysWZqYtA/KQ+JqpjEcOiuZWxJHXA3rTW56uY3q1ngRr9UWBEbxpX8CJLi4aJswHlqQbNJjGj6Xsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver should tell the number of memory planes and component planes.
the amphion vpu support non contiguous planes,
but for compatibility with other device
that only support contiguous planes.
driver can add support for contiguous planes in the same time.
Then the mem_planes can be different from the comp_planes.
driver need to handle buffer according mem_planes and comp_planes.

So driver can support NV12 and NV12M.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c        | 187 ++++++++++---------
 drivers/media/platform/amphion/venc.c        |  33 ++--
 drivers/media/platform/amphion/vpu.h         |   4 +-
 drivers/media/platform/amphion/vpu_dbg.c     |   8 +-
 drivers/media/platform/amphion/vpu_helpers.c |  48 ++++-
 drivers/media/platform/amphion/vpu_helpers.h |   2 +
 drivers/media/platform/amphion/vpu_malone.c  |   3 +-
 drivers/media/platform/amphion/vpu_v4l2.c    | 168 ++++++++++++-----
 drivers/media/platform/amphion/vpu_v4l2.h    |   3 +-
 drivers/media/platform/amphion/vpu_windsor.c |   8 +-
 10 files changed, 299 insertions(+), 165 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index feb75dc204de..48ab664fa7ef 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -69,72 +69,85 @@ struct vdec_t {
 static const struct vpu_format vdec_formats[] = {
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M_8L128,
-		.num_planes = 2,
+		.mem_planes = 2,
+		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M_10BE_8L128,
-		.num_planes = 2,
+		.mem_planes = 2,
+		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264_MVC,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_HEVC,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_MPEG2,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_MPEG4,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_XVID,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_VP8,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H263,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{0, 0, 0, 0},
 };
@@ -256,23 +269,22 @@ static int vdec_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
 	int ret = -EINVAL;
 
 	vpu_inst_lock(inst);
-	if (!V4L2_TYPE_IS_OUTPUT(f->type) && vdec->fixed_fmt) {
-		if (f->index == 0) {
-			f->pixelformat = inst->cap_format.pixfmt;
-			f->flags = inst->cap_format.flags;
-			ret = 0;
-		}
+	if (V4L2_TYPE_IS_CAPTURE(f->type) && vdec->fixed_fmt) {
+		fmt = vpu_get_format(inst, f->type);
+		if (f->index == 1)
+			fmt = vpu_helper_find_sibling(inst, f->type, fmt->pixfmt);
+		if (f->index > 1)
+			fmt = NULL;
 	} else {
 		fmt = vpu_helper_enum_format(inst, f->type, f->index);
-		memset(f->reserved, 0, sizeof(f->reserved));
-		if (!fmt)
-			goto exit;
-
-		f->pixelformat = fmt->pixfmt;
-		f->flags = fmt->flags;
-		ret = 0;
 	}
+	if (!fmt)
+		goto exit;
 
+	memset(f->reserved, 0, sizeof(f->reserved));
+	f->pixelformat = fmt->pixfmt;
+	f->flags = fmt->flags;
+	ret = 0;
 exit:
 	vpu_inst_unlock(inst);
 	return ret;
@@ -289,14 +301,14 @@ static int vdec_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	cur_fmt = vpu_get_format(inst, f->type);
 
 	pixmp->pixelformat = cur_fmt->pixfmt;
-	pixmp->num_planes = cur_fmt->num_planes;
+	pixmp->num_planes = cur_fmt->mem_planes;
 	pixmp->width = cur_fmt->width;
 	pixmp->height = cur_fmt->height;
 	pixmp->field = cur_fmt->field;
 	pixmp->flags = cur_fmt->flags;
 	for (i = 0; i < pixmp->num_planes; i++) {
 		pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
-		pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+		pixmp->plane_fmt[i].sizeimage = vpu_get_fmt_plane_size(cur_fmt, i);
 	}
 
 	f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
@@ -311,10 +323,19 @@ static int vdec_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct vpu_inst *inst = to_inst(file);
 	struct vdec_t *vdec = inst->priv;
-
-	vpu_try_fmt_common(inst, f);
+	struct vpu_format fmt;
 
 	vpu_inst_lock(inst);
+	if (V4L2_TYPE_IS_CAPTURE(f->type) && vdec->fixed_fmt) {
+		struct vpu_format *cap_fmt = vpu_get_format(inst, f->type);
+
+		if (!vpu_helper_match_format(inst, cap_fmt->type, cap_fmt->pixfmt,
+					     f->fmt.pix_mp.pixelformat))
+			f->fmt.pix_mp.pixelformat = cap_fmt->pixfmt;
+	}
+
+	vpu_try_fmt_common(inst, f, &fmt);
+
 	if (vdec->fixed_fmt) {
 		f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
 		f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
@@ -334,7 +355,7 @@ static int vdec_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 static int vdec_s_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
-	const struct vpu_format *fmt;
+	struct vpu_format fmt;
 	struct vpu_format *cur_fmt;
 	struct vb2_queue *q;
 	struct vdec_t *vdec = inst->priv;
@@ -349,36 +370,30 @@ static int vdec_s_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
 	if (vb2_is_busy(q))
 		return -EBUSY;
 
-	fmt = vpu_try_fmt_common(inst, f);
-	if (!fmt)
+	if (vpu_try_fmt_common(inst, f, &fmt))
 		return -EINVAL;
 
 	cur_fmt = vpu_get_format(inst, f->type);
 	if (V4L2_TYPE_IS_OUTPUT(f->type) && inst->state != VPU_CODEC_STATE_DEINIT) {
-		if (cur_fmt->pixfmt != fmt->pixfmt) {
+		if (cur_fmt->pixfmt != fmt.pixfmt) {
 			vdec->reset_codec = true;
 			vdec->fixed_fmt = false;
 		}
 	}
-	cur_fmt->pixfmt = fmt->pixfmt;
 	if (V4L2_TYPE_IS_OUTPUT(f->type) || !vdec->fixed_fmt) {
-		cur_fmt->num_planes = fmt->num_planes;
-		cur_fmt->flags = fmt->flags;
-		cur_fmt->width = pixmp->width;
-		cur_fmt->height = pixmp->height;
-		for (i = 0; i < fmt->num_planes; i++) {
-			cur_fmt->sizeimage[i] = pixmp->plane_fmt[i].sizeimage;
-			cur_fmt->bytesperline[i] = pixmp->plane_fmt[i].bytesperline;
-		}
-		if (pixmp->field != V4L2_FIELD_ANY)
-			cur_fmt->field = pixmp->field;
+		memcpy(cur_fmt, &fmt, sizeof(*cur_fmt));
 	} else {
-		pixmp->num_planes = cur_fmt->num_planes;
+		if (vpu_helper_match_format(inst, f->type, cur_fmt->pixfmt, pixmp->pixelformat)) {
+			cur_fmt->pixfmt = fmt.pixfmt;
+			cur_fmt->mem_planes = fmt.mem_planes;
+		}
+		pixmp->pixelformat = cur_fmt->pixfmt;
+		pixmp->num_planes = cur_fmt->mem_planes;
 		pixmp->width = cur_fmt->width;
 		pixmp->height = cur_fmt->height;
 		for (i = 0; i < pixmp->num_planes; i++) {
 			pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
-			pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+			pixmp->plane_fmt[i].sizeimage = vpu_get_fmt_plane_size(cur_fmt, i);
 		}
 		pixmp->field = cur_fmt->field;
 	}
@@ -678,9 +693,11 @@ static struct vpu_vb2_buffer *vdec_find_buffer(struct vpu_inst *inst, u32 luma)
 static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 {
 	struct vdec_t *vdec = inst->priv;
+	struct vpu_format *cur_fmt;
 	struct vpu_vb2_buffer *vpu_buf;
 	struct vb2_v4l2_buffer *vbuf;
 	u32 sequence;
+	int i;
 
 	if (!frame)
 		return;
@@ -699,6 +716,7 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 		return;
 	}
 
+	cur_fmt = vpu_get_format(inst, inst->cap_format.type);
 	vbuf = &vpu_buf->m2m_buf.vb;
 	if (vbuf->vb2_buf.index != frame->id)
 		dev_err(inst->dev, "[%d] buffer id(%d, %d) dismatch\n",
@@ -707,9 +725,9 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 	if (vpu_get_buffer_state(vbuf) != VPU_BUF_STATE_DECODED)
 		dev_err(inst->dev, "[%d] buffer(%d) ready without decoded\n", inst->id, frame->id);
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
-	vb2_set_plane_payload(&vbuf->vb2_buf, 0, inst->cap_format.sizeimage[0]);
-	vb2_set_plane_payload(&vbuf->vb2_buf, 1, inst->cap_format.sizeimage[1]);
-	vbuf->field = inst->cap_format.field;
+	for (i = 0; i < vbuf->vb2_buf.num_planes; i++)
+		vb2_set_plane_payload(&vbuf->vb2_buf, i, vpu_get_fmt_plane_size(cur_fmt, i));
+	vbuf->field = cur_fmt->field;
 	vbuf->sequence = sequence;
 	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
 
@@ -747,15 +765,17 @@ static void vdec_stop_done(struct vpu_inst *inst)
 static bool vdec_check_source_change(struct vpu_inst *inst)
 {
 	struct vdec_t *vdec = inst->priv;
-	const struct vpu_format *fmt;
-	int i;
+	const struct vpu_format *sibling;
 
 	if (!inst->fh.m2m_ctx)
 		return false;
 
+	sibling = vpu_helper_find_sibling(inst, inst->cap_format.type, inst->cap_format.pixfmt);
+	if (sibling && vdec->codec_info.pixfmt == sibling->pixfmt)
+		vdec->codec_info.pixfmt = inst->cap_format.pixfmt;
+
 	if (!vb2_is_streaming(v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx)))
 		return true;
-	fmt = vpu_helper_find_format(inst, inst->cap_format.type, vdec->codec_info.pixfmt);
 	if (inst->cap_format.pixfmt != vdec->codec_info.pixfmt)
 		return true;
 	if (inst->cap_format.width != vdec->codec_info.decoded_width)
@@ -772,14 +792,6 @@ static bool vdec_check_source_change(struct vpu_inst *inst)
 		return true;
 	if (inst->crop.height != vdec->codec_info.height)
 		return true;
-	if (fmt && inst->cap_format.num_planes != fmt->num_planes)
-		return true;
-	for (i = 0; i < inst->cap_format.num_planes; i++) {
-		if (inst->cap_format.bytesperline[i] != vdec->codec_info.bytesperline[i])
-			return true;
-		if (inst->cap_format.sizeimage[i] != vdec->codec_info.sizeimage[i])
-			return true;
-	}
 
 	return false;
 }
@@ -787,27 +799,21 @@ static bool vdec_check_source_change(struct vpu_inst *inst)
 static void vdec_init_fmt(struct vpu_inst *inst)
 {
 	struct vdec_t *vdec = inst->priv;
-	const struct vpu_format *fmt;
-	int i;
+	struct v4l2_format f;
 
-	fmt = vpu_helper_find_format(inst, inst->cap_format.type, vdec->codec_info.pixfmt);
-	inst->out_format.width = vdec->codec_info.width;
-	inst->out_format.height = vdec->codec_info.height;
-	inst->cap_format.width = vdec->codec_info.decoded_width;
-	inst->cap_format.height = vdec->codec_info.decoded_height;
-	inst->cap_format.pixfmt = vdec->codec_info.pixfmt;
-	if (fmt) {
-		inst->cap_format.num_planes = fmt->num_planes;
-		inst->cap_format.flags = fmt->flags;
-	}
-	for (i = 0; i < inst->cap_format.num_planes; i++) {
-		inst->cap_format.bytesperline[i] = vdec->codec_info.bytesperline[i];
-		inst->cap_format.sizeimage[i] = vdec->codec_info.sizeimage[i];
-	}
+	memset(&f, 0, sizeof(f));
+	f.type = inst->cap_format.type;
+	f.fmt.pix_mp.pixelformat = vdec->codec_info.pixfmt;
+	f.fmt.pix_mp.width = vdec->codec_info.decoded_width;
+	f.fmt.pix_mp.height = vdec->codec_info.decoded_height;
 	if (vdec->codec_info.progressive)
-		inst->cap_format.field = V4L2_FIELD_NONE;
+		f.fmt.pix_mp.field = V4L2_FIELD_NONE;
 	else
-		inst->cap_format.field = V4L2_FIELD_SEQ_TB;
+		f.fmt.pix_mp.field = V4L2_FIELD_SEQ_TB;
+	vpu_try_fmt_common(inst, &f, &inst->cap_format);
+
+	inst->out_format.width = vdec->codec_info.width;
+	inst->out_format.height = vdec->codec_info.height;
 }
 
 static void vdec_init_crop(struct vpu_inst *inst)
@@ -966,7 +972,10 @@ static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_buffer *vb
 	info.tag = vdec->seq_tag;
 	info.luma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 0);
 	info.luma_size = inst->cap_format.sizeimage[0];
-	info.chroma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 1);
+	if (vbuf->vb2_buf.num_planes > 1)
+		info.chroma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 1);
+	else
+		info.chroma_addr = info.luma_addr + info.luma_size;
 	info.chromau_size = inst->cap_format.sizeimage[1];
 	info.bytesperline = inst->cap_format.bytesperline[0];
 	ret = vpu_session_alloc_fs(inst, &info);
@@ -975,7 +984,7 @@ static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_buffer *vb
 
 	vpu_buf->tag = info.tag;
 	vpu_buf->luma = info.luma_addr;
-	vpu_buf->chroma_u = info.chromau_size;
+	vpu_buf->chroma_u = info.chroma_addr;
 	vpu_buf->chroma_v = 0;
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_INUSE);
 	vdec->slots[info.id] = vpu_buf;
diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 37212f087fdd..060a1ee78b17 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -69,13 +69,16 @@ struct venc_frame_t {
 static const struct vpu_format venc_formats[] = {
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M,
-		.num_planes = 2,
+		.mem_planes = 2,
+		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
 	},
 	{0, 0, 0, 0},
 };
@@ -173,14 +176,14 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	cur_fmt = vpu_get_format(inst, f->type);
 
 	pixmp->pixelformat = cur_fmt->pixfmt;
-	pixmp->num_planes = cur_fmt->num_planes;
+	pixmp->num_planes = cur_fmt->mem_planes;
 	pixmp->width = cur_fmt->width;
 	pixmp->height = cur_fmt->height;
 	pixmp->field = cur_fmt->field;
 	pixmp->flags = cur_fmt->flags;
 	for (i = 0; i < pixmp->num_planes; i++) {
 		pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
-		pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+		pixmp->plane_fmt[i].sizeimage = vpu_get_fmt_plane_size(cur_fmt, i);
 	}
 
 	f->fmt.pix_mp.colorspace = venc->params.color.primaries;
@@ -194,8 +197,9 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 static int venc_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct vpu_inst *inst = to_inst(file);
+	struct vpu_format fmt;
 
-	vpu_try_fmt_common(inst, f);
+	vpu_try_fmt_common(inst, f, &fmt);
 
 	return 0;
 }
@@ -203,12 +207,11 @@ static int venc_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct vpu_inst *inst = to_inst(file);
-	const struct vpu_format *fmt;
+	struct vpu_format fmt;
 	struct vpu_format *cur_fmt;
 	struct vb2_queue *q;
 	struct venc_t *venc = inst->priv;
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
-	int i;
 
 	q = v4l2_m2m_get_vq(inst->fh.m2m_ctx, f->type);
 	if (!q)
@@ -216,24 +219,12 @@ static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	if (vb2_is_busy(q))
 		return -EBUSY;
 
-	fmt = vpu_try_fmt_common(inst, f);
-	if (!fmt)
+	if (vpu_try_fmt_common(inst, f, &fmt))
 		return -EINVAL;
 
 	cur_fmt = vpu_get_format(inst, f->type);
 
-	cur_fmt->pixfmt = fmt->pixfmt;
-	cur_fmt->num_planes = fmt->num_planes;
-	cur_fmt->flags = fmt->flags;
-	cur_fmt->width = pix_mp->width;
-	cur_fmt->height = pix_mp->height;
-	for (i = 0; i < fmt->num_planes; i++) {
-		cur_fmt->sizeimage[i] = pix_mp->plane_fmt[i].sizeimage;
-		cur_fmt->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
-	}
-
-	if (pix_mp->field != V4L2_FIELD_ANY)
-		cur_fmt->field = pix_mp->field;
+	memcpy(cur_fmt, &fmt, sizeof(*cur_fmt));
 
 	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
 		venc->params.input_format = cur_fmt->pixfmt;
diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index f914de6ed81e..998591fa5b85 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -84,7 +84,8 @@ struct vpu_dev {
 
 struct vpu_format {
 	u32 pixfmt;
-	unsigned int num_planes;
+	u32 mem_planes;
+	u32 comp_planes;
 	u32 type;
 	u32 flags;
 	u32 width;
@@ -92,6 +93,7 @@ struct vpu_format {
 	u32 sizeimage[VIDEO_MAX_PLANES];
 	u32 bytesperline[VIDEO_MAX_PLANES];
 	u32 field;
+	u32 sibling;
 };
 
 struct vpu_core_resources {
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index f72c8a506b22..c41c9896912c 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -89,9 +89,9 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 			vq->last_buffer_dequeued);
 	if (seq_write(s, str, num))
 		return 0;
-	for (i = 0; i < inst->out_format.num_planes; i++) {
+	for (i = 0; i < inst->out_format.mem_planes; i++) {
 		num = scnprintf(str, sizeof(str), " %d(%d)",
-				inst->out_format.sizeimage[i],
+				vpu_get_fmt_plane_size(&inst->out_format, i),
 				inst->out_format.bytesperline[i]);
 		if (seq_write(s, str, num))
 			return 0;
@@ -113,9 +113,9 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 			vq->last_buffer_dequeued);
 	if (seq_write(s, str, num))
 		return 0;
-	for (i = 0; i < inst->cap_format.num_planes; i++) {
+	for (i = 0; i < inst->cap_format.mem_planes; i++) {
 		num = scnprintf(str, sizeof(str), " %d(%d)",
-				inst->cap_format.sizeimage[i],
+				vpu_get_fmt_plane_size(&inst->cap_format, i),
 				inst->cap_format.bytesperline[i]);
 		if (seq_write(s, str, num))
 			return 0;
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
index e9aeb3453dfc..db8f471b9187 100644
--- a/drivers/media/platform/amphion/vpu_helpers.c
+++ b/drivers/media/platform/amphion/vpu_helpers.c
@@ -59,6 +59,39 @@ const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type,
 	return NULL;
 }
 
+const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst *inst, u32 type, u32 pixelfmt)
+{
+	const struct vpu_format *fmt;
+	const struct vpu_format *sibling;
+
+	fmt = vpu_helper_find_format(inst, type, pixelfmt);
+	if (!fmt)
+		return NULL;
+	if (!fmt->sibling)
+		return NULL;
+	sibling = vpu_helper_find_format(inst, type, fmt->sibling);
+	if (!sibling)
+		return NULL;
+	if (sibling->sibling != fmt->pixfmt)
+		return NULL;
+	if (sibling->comp_planes != fmt->comp_planes)
+		return NULL;
+	return sibling;
+}
+
+bool vpu_helper_match_format(struct vpu_inst *inst, u32 type, u32 fmta, u32 fmtb)
+{
+	const struct vpu_format *sibling;
+
+	if (fmta == fmtb)
+		return true;
+
+	sibling = vpu_helper_find_sibling(inst, type, fmta);
+	if (sibling && sibling->pixfmt == fmtb)
+		return true;
+	return false;
+}
+
 const struct vpu_format *vpu_helper_enum_format(struct vpu_inst *inst, u32 type, int index)
 {
 	const struct vpu_format *pfmt;
@@ -123,9 +156,10 @@ static u32 get_nv12_plane_size(u32 width, u32 height, int plane_no,
 	u32 bytesperline;
 	u32 size = 0;
 
-	bytesperline = ALIGN(width, stride);
+	bytesperline = width;
 	if (pbl)
 		bytesperline = max(bytesperline, *pbl);
+	bytesperline = ALIGN(bytesperline, stride);
 	height = ALIGN(height, 2);
 	if (plane_no == 0)
 		size = bytesperline * height;
@@ -148,13 +182,13 @@ static u32 get_tiled_8l128_plane_size(u32 fmt, u32 width, u32 height, int plane_
 
 	if (interlaced)
 		hs++;
-	if (fmt == V4L2_PIX_FMT_NV12M_10BE_8L128)
+	if (fmt == V4L2_PIX_FMT_NV12M_10BE_8L128 || fmt == V4L2_PIX_FMT_NV12_10BE_8L128)
 		bitdepth = 10;
 	bytesperline = DIV_ROUND_UP(width * bitdepth, BITS_PER_BYTE);
-	bytesperline = ALIGN(bytesperline, 1 << ws);
-	bytesperline = ALIGN(bytesperline, stride);
 	if (pbl)
 		bytesperline = max(bytesperline, *pbl);
+	bytesperline = ALIGN(bytesperline, 1 << ws);
+	bytesperline = ALIGN(bytesperline, stride);
 	height = ALIGN(height, 1 << hs);
 	if (plane_no == 0)
 		size = bytesperline * height;
@@ -172,9 +206,10 @@ static u32 get_default_plane_size(u32 width, u32 height, int plane_no,
 	u32 bytesperline;
 	u32 size = 0;
 
-	bytesperline = ALIGN(width, stride);
+	bytesperline = width;
 	if (pbl)
 		bytesperline = max(bytesperline, *pbl);
+	bytesperline = ALIGN(bytesperline, stride);
 	if (plane_no == 0)
 		size = bytesperline * height;
 	if (pbl)
@@ -187,9 +222,12 @@ u32 vpu_helper_get_plane_size(u32 fmt, u32 w, u32 h, int plane_no,
 			      u32 stride, u32 interlaced, u32 *pbl)
 {
 	switch (fmt) {
+	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
 		return get_nv12_plane_size(w, h, plane_no, stride, interlaced, pbl);
+	case V4L2_PIX_FMT_NV12_8L128:
 	case V4L2_PIX_FMT_NV12M_8L128:
+	case V4L2_PIX_FMT_NV12_10BE_8L128:
 	case V4L2_PIX_FMT_NV12M_10BE_8L128:
 		return get_tiled_8l128_plane_size(fmt, w, h, plane_no, stride, interlaced, pbl);
 	default:
diff --git a/drivers/media/platform/amphion/vpu_helpers.h b/drivers/media/platform/amphion/vpu_helpers.h
index bc28350958be..0eaddb07190d 100644
--- a/drivers/media/platform/amphion/vpu_helpers.h
+++ b/drivers/media/platform/amphion/vpu_helpers.h
@@ -14,6 +14,8 @@ struct vpu_pair {
 int vpu_helper_find_in_array_u8(const u8 *array, u32 size, u32 x);
 bool vpu_helper_check_type(struct vpu_inst *inst, u32 type);
 const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type, u32 pixelfmt);
+const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst *inst, u32 type, u32 pixelfmt);
+bool vpu_helper_match_format(struct vpu_inst *inst, u32 type, u32 fmta, u32 fmtb);
 const struct vpu_format *vpu_helper_enum_format(struct vpu_inst *inst, u32 type, int index);
 u32 vpu_helper_valid_frame_width(struct vpu_inst *inst, u32 width);
 u32 vpu_helper_valid_frame_height(struct vpu_inst *inst, u32 height);
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 51e0702f9ae1..69d9a2269fce 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -583,7 +583,8 @@ bool vpu_malone_check_fmt(enum vpu_core_type type, u32 pixelfmt)
 	if (!vpu_imx8q_check_fmt(type, pixelfmt))
 		return false;
 
-	if (pixelfmt == V4L2_PIX_FMT_NV12M_8L128 || pixelfmt == V4L2_PIX_FMT_NV12M_10BE_8L128)
+	if (pixelfmt == V4L2_PIX_FMT_NV12_8L128 || pixelfmt == V4L2_PIX_FMT_NV12_10BE_8L128 ||
+	    pixelfmt == V4L2_PIX_FMT_NV12M_8L128 || pixelfmt == V4L2_PIX_FMT_NV12M_10BE_8L128)
 		return true;
 	if (vpu_malone_format_remap(pixelfmt) == MALONE_FMT_NULL)
 		return false;
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 8a3eed957ae6..87cce552e906 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -140,51 +140,135 @@ bool vpu_is_source_empty(struct vpu_inst *inst)
 	return true;
 }
 
-const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
+static int vpu_init_format(struct vpu_inst *inst, struct vpu_format *fmt)
+{
+	const struct vpu_format *info;
+
+	info = vpu_helper_find_format(inst, fmt->type, fmt->pixfmt);
+	if (!info) {
+		info = vpu_helper_enum_format(inst, fmt->type, 0);
+		if (!info)
+			return -EINVAL;
+	}
+	memcpy(fmt, info, sizeof(*fmt));
+
+	return 0;
+}
+
+static int vpu_calc_fmt_bytesperline(struct v4l2_format *f, struct vpu_format *fmt)
 {
 	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
-	u32 type = f->type;
+	int i;
+
+	if (fmt->flags & V4L2_FMT_FLAG_COMPRESSED) {
+		for (i = 0; i < fmt->comp_planes; i++)
+			fmt->bytesperline[i] = 0;
+		return 0;
+	}
+	if (pixmp->num_planes == fmt->comp_planes) {
+		for (i = 0; i < fmt->comp_planes; i++)
+			fmt->bytesperline[i] = pixmp->plane_fmt[i].bytesperline;
+		return 0;
+	}
+	if (pixmp->num_planes > 1)
+		return -EINVAL;
+
+	/*amphion vpu only support nv12 and nv12 tiled,
+	 * so the bytesperline of luma and chroma should be same
+	 */
+	for (i = 0; i < fmt->comp_planes; i++)
+		fmt->bytesperline[i] = pixmp->plane_fmt[0].bytesperline;
+
+	return 0;
+}
+
+static int vpu_calc_fmt_sizeimage(struct vpu_inst *inst, struct vpu_format *fmt)
+{
 	u32 stride = 1;
-	u32 bytesperline;
-	u32 sizeimage;
-	const struct vpu_format *fmt;
-	const struct vpu_core_resources *res;
 	int i;
 
-	fmt = vpu_helper_find_format(inst, type, pixmp->pixelformat);
-	if (!fmt) {
-		fmt = vpu_helper_enum_format(inst, type, 0);
-		if (!fmt)
-			return NULL;
-		pixmp->pixelformat = fmt->pixfmt;
+	if (!(fmt->flags & V4L2_FMT_FLAG_COMPRESSED)) {
+		const struct vpu_core_resources *res = vpu_get_resource(inst);
+
+		if (res)
+			stride = res->stride;
 	}
 
-	res = vpu_get_resource(inst);
-	if (res)
-		stride = res->stride;
-	if (pixmp->width)
-		pixmp->width = vpu_helper_valid_frame_width(inst, pixmp->width);
-	if (pixmp->height)
-		pixmp->height = vpu_helper_valid_frame_height(inst, pixmp->height);
+	for (i = 0; i < fmt->comp_planes; i++) {
+		fmt->sizeimage[i] = vpu_helper_get_plane_size(fmt->pixfmt,
+							      fmt->width,
+							      fmt->height,
+							      i,
+							      stride,
+							      fmt->field != V4L2_FIELD_NONE ? 1 : 0,
+							      &fmt->bytesperline[i]);
+		fmt->sizeimage[i] = max_t(u32, fmt->sizeimage[i], PAGE_SIZE);
+		if (fmt->flags & V4L2_FMT_FLAG_COMPRESSED) {
+			fmt->sizeimage[i] = clamp_val(fmt->sizeimage[i], SZ_128K, SZ_8M);
+			fmt->bytesperline[i] = 0;
+		}
+	}
+
+	return 0;
+}
+
+u32 vpu_get_fmt_plane_size(struct vpu_format *fmt, u32 plane_no)
+{
+	u32 size;
+	int i;
+
+	if (plane_no >= fmt->mem_planes)
+		return 0;
+
+	if (fmt->comp_planes == fmt->mem_planes)
+		return fmt->sizeimage[plane_no];
+	if (plane_no < fmt->mem_planes - 1)
+		return fmt->sizeimage[plane_no];
+	size = fmt->sizeimage[plane_no];
+	for (i = fmt->mem_planes; i < fmt->comp_planes; i++)
+		size += fmt->sizeimage[i];
+
+	return size;
+}
+
+int vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f, struct vpu_format *fmt)
+{
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	int i;
+	int ret;
+
+	fmt->pixfmt = pixmp->pixelformat;
+	fmt->type = f->type;
+	ret = vpu_init_format(inst, fmt);
+	if (ret < 0)
+		return ret;
+
+	fmt->width = pixmp->width;
+	fmt->height = pixmp->height;
+	if (fmt->width)
+		fmt->width = vpu_helper_valid_frame_width(inst, fmt->width);
+	if (fmt->height)
+		fmt->height = vpu_helper_valid_frame_height(inst, fmt->height);
+	fmt->field = pixmp->field == V4L2_FIELD_ANY ? V4L2_FIELD_NONE : pixmp->field;
+	vpu_calc_fmt_bytesperline(f, fmt);
+	vpu_calc_fmt_sizeimage(inst, fmt);
+	if ((fmt->flags & V4L2_FMT_FLAG_COMPRESSED) && pixmp->plane_fmt[0].sizeimage)
+		fmt->sizeimage[0] = clamp_val(pixmp->plane_fmt[0].sizeimage, SZ_128K, SZ_8M);
+
+	pixmp->pixelformat = fmt->pixfmt;
+	pixmp->width = fmt->width;
+	pixmp->height = fmt->height;
 	pixmp->flags = fmt->flags;
-	pixmp->num_planes = fmt->num_planes;
-	if (pixmp->field == V4L2_FIELD_ANY)
-		pixmp->field = V4L2_FIELD_NONE;
+	pixmp->num_planes = fmt->mem_planes;
+	pixmp->field = fmt->field;
+	memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
 	for (i = 0; i < pixmp->num_planes; i++) {
-		bytesperline = max_t(s32, pixmp->plane_fmt[i].bytesperline, 0);
-		sizeimage = vpu_helper_get_plane_size(pixmp->pixelformat,
-						      pixmp->width,
-						      pixmp->height,
-						      i,
-						      stride,
-						      pixmp->field > V4L2_FIELD_NONE ? 1 : 0,
-						      &bytesperline);
-		sizeimage = max_t(s32, pixmp->plane_fmt[i].sizeimage, sizeimage);
-		pixmp->plane_fmt[i].bytesperline = bytesperline;
-		pixmp->plane_fmt[i].sizeimage = sizeimage;
+		pixmp->plane_fmt[i].bytesperline = fmt->bytesperline[i];
+		pixmp->plane_fmt[i].sizeimage = vpu_get_fmt_plane_size(fmt, i);
+		memset(pixmp->plane_fmt[i].reserved, 0, sizeof(pixmp->plane_fmt[i].reserved));
 	}
 
-	return fmt;
+	return 0;
 }
 
 static bool vpu_check_ready(struct vpu_inst *inst, u32 type)
@@ -389,10 +473,10 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
 	cur_fmt = vpu_get_format(inst, vq->type);
 
 	if (*plane_count) {
-		if (*plane_count != cur_fmt->num_planes)
+		if (*plane_count != cur_fmt->mem_planes)
 			return -EINVAL;
-		for (i = 0; i < cur_fmt->num_planes; i++) {
-			if (psize[i] < cur_fmt->sizeimage[i])
+		for (i = 0; i < cur_fmt->mem_planes; i++) {
+			if (psize[i] < vpu_get_fmt_plane_size(cur_fmt, i))
 				return -EINVAL;
 		}
 		return 0;
@@ -402,9 +486,9 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
 		*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_out);
 	else
 		*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_cap);
-	*plane_count = cur_fmt->num_planes;
-	for (i = 0; i < cur_fmt->num_planes; i++)
-		psize[i] = cur_fmt->sizeimage[i];
+	*plane_count = cur_fmt->mem_planes;
+	for (i = 0; i < cur_fmt->mem_planes; i++)
+		psize[i] = vpu_get_fmt_plane_size(cur_fmt, i);
 
 	return 0;
 }
@@ -434,8 +518,8 @@ static int vpu_vb2_buf_prepare(struct vb2_buffer *vb)
 	u32 i;
 
 	cur_fmt = vpu_get_format(inst, vb->type);
-	for (i = 0; i < cur_fmt->num_planes; i++) {
-		if (vpu_get_vb_length(vb, i) < cur_fmt->sizeimage[i]) {
+	for (i = 0; i < cur_fmt->mem_planes; i++) {
+		if (vpu_get_vb_length(vb, i) < vpu_get_fmt_plane_size(cur_fmt, i)) {
 			dev_dbg(inst->dev, "[%d] %s buf[%d] is invalid\n",
 				inst->id, vpu_type_name(vb->type), vb->index);
 			vpu_set_buffer_state(vbuf, VPU_BUF_STATE_ERROR);
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 795ca33a6a50..ef5de6b66e47 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -16,7 +16,8 @@ unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf);
 int vpu_v4l2_open(struct file *file, struct vpu_inst *inst);
 int vpu_v4l2_close(struct file *file);
 
-const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f);
+u32 vpu_get_fmt_plane_size(struct vpu_format *fmt, u32 plane_no);
+int vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f, struct vpu_format *fmt);
 int vpu_process_output_buffer(struct vpu_inst *inst);
 int vpu_process_capture_buffer(struct vpu_inst *inst);
 struct vb2_v4l2_buffer *vpu_next_src_buf(struct vpu_inst *inst);
diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/amphion/vpu_windsor.c
index 1526af2ef9da..a454f142ae17 100644
--- a/drivers/media/platform/amphion/vpu_windsor.c
+++ b/drivers/media/platform/amphion/vpu_windsor.c
@@ -775,6 +775,8 @@ static int vpu_windsor_fill_yuv_frame(struct vpu_shared_addr *shared,
 				      u32 instance,
 				      struct vb2_buffer *vb)
 {
+	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vpu_format *out_fmt;
 	struct vpu_enc_yuv_desc *desc;
 	struct vb2_v4l2_buffer *vbuf;
 
@@ -782,6 +784,7 @@ static int vpu_windsor_fill_yuv_frame(struct vpu_shared_addr *shared,
 		return -EINVAL;
 
 	desc = get_yuv_desc(shared, instance);
+	out_fmt = vpu_get_format(inst, vb->type);
 
 	vbuf = to_vb2_v4l2_buffer(vb);
 	desc->frame_id = vbuf->sequence;
@@ -790,7 +793,10 @@ static int vpu_windsor_fill_yuv_frame(struct vpu_shared_addr *shared,
 	else
 		desc->key_frame = 0;
 	desc->luma_base = vpu_get_vb_phy_addr(vb, 0);
-	desc->chroma_base = vpu_get_vb_phy_addr(vb, 1);
+	if (vb->num_planes > 1)
+		desc->chroma_base = vpu_get_vb_phy_addr(vb, 1);
+	else
+		desc->chroma_base = desc->luma_base + out_fmt->sizeimage[0];
 
 	return 0;
 }
-- 
2.37.1

