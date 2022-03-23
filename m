Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E263D4E4EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbiCWJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiCWJIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:08:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0507523D;
        Wed, 23 Mar 2022 02:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeXuiyq4prF2Qj/JVZI108nNsZMj0nyGWf3Kd3Ws459wrXbgmWNJmO+LVRYq3dxmqCwKc7hVjmigNo1n2LtnxHRThOOMrJs+cD9h/W4O+wdwAtjv6SdB6M9uyoXxcp3toLSudzuIv9bbxIcZdzB/3IX1juYDXtkQ15EH77EkjWedR1oZu36Gnwc1o5ipogiMaDN9lCUS+dW/qwFWTCZlJl/F7V9JMi9BDylcUZi6W7q5QUyJXeagiA4X1wpcDCzF0jg+x6U3z32UbxCtItCAMlNpAGfozvOkjEjSvvqoSkXDntmw2VSpN/yus60XEqOU67gq13bgQrRBNVCLmgVZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgI6WfVd45h4vDMCaKFbnqdkIhyPrO10ugn9R9MRfSw=;
 b=bXMqyT1f2L7XPRXdj3OI6cNHRQuGEM6xNttnzWy9KAeFtUYOwoMVziL9E5f+Hchm8Z3io13t0j30rQL5i6Pb1Bmnxz2nIB2HdvwHRjAxgkeqPn5ucLuyIhC/63anvXuiE9bfyUGm1k0MrUSvpP+Gq2Q1N5wn2kN4Q7QOfEQ9Gq8xxv/T3sKyKhdLkxevjIYkf2phNq4TBfQhgaoADivTw0hKrv/Vz1xLOYPXCMG3vfaZI1A31CansaalAf6YpI4U15wtM5H9JJZMvpRCE9e59hkHlYzH988udPbHlqjReLrubZgVkXXaIY0DTr6B5Nvl0jqf5PQjIH50KQX+vAwn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgI6WfVd45h4vDMCaKFbnqdkIhyPrO10ugn9R9MRfSw=;
 b=HZU8pL4pTTFn2VIWa9XoJo9QYITPftk2BC9D9gyEDB1rrJsFL9R87LwOJ922K8rndjXJbNz6Z3q6zlkcmRkE/FlCl0nty2Xd57Y8ouNFLciT5LGs059g8qWDxVbaLZAVIXc/n0ntLNAmh+W0aQbOImL6OXc+09BKkZQHmEFnwsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBAPR04MB7317.eurprd04.prod.outlook.com (2603:10a6:10:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:06:33 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 09:06:33 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/5] media: imx-jpeg: Support dynamic resolution change
Date:   Wed, 23 Mar 2022 17:05:58 +0800
Message-Id: <93dd8b6a487a4f228984debb7a255d7ddde8f490.1648023273.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1648023273.git.ming.qian@nxp.com>
References: <cover.1648023273.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:3:1::24) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 899d3802-8a78-48b4-eb91-08da0cac6d61
X-MS-TrafficTypeDiagnostic: DBAPR04MB7317:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB73177BEA70E5C230FE6B5D37E7189@DBAPR04MB7317.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTO4qQoT08U52nOo3eCm3j8DgnJNIVOq42dpPP+tcw9SoVB1I7h7vryU31Twwm2khm+5jTnBEBzJq1PbRZ5uiULtH+22WeGv3sJQ8PR35Hrm60Rdxd5gL0wTslyZzJy6KotOVNFxrQe5563YDMbxb4t5IpNbt1wx7VSZfqGpcaEIt7L3QCbMflmXVsC2kWoxJ0NHgHGXdar/KJPIHYQl+uTtXsOqNLAHkf+8XRf2rYK9xrfBdBT8b8FlyNiSJn9Kz3Z95LzxlIVH38ZEoAm44v2bpis+8dwU6VtDbNmWDUh1Gyut1xMlfPYLMNA/xDp3ZAj3enw8x6W08Dna/G5zvXsodIgsYfkSCDW5mxq6+tuKB0YwvbHzQUZYvSh/IijR02iBZPRNcpZH0RSrxwHrsganPkxzeK98WoSicLWZNGmkmUKZUMBj2bDB3OIboPhvDl3W0IWnic+3UlvTXcLLQ/CwGKbdbG5o009nMCqYVaLLeytdK0Vmyp45JqcsCX1tL73tgs4TfQN2xAdPd9sL/AoCAq0NhMM2kn4mKf86Wq7mwVKLE1RoFkMEaXCqLXItddD0ESjNzRuevGoPbq/lloy84Hk7eFE1q/cUoLX0Y6N7BKyoYRGi+pBKeiAjR11ncwF9JF4B4tDC9tSb1HuEiwCKEnTtKW6x+npktLgCqPnIiRk010xOY53gDHYE3F2BFhZob8K0ZUIPODgMbKbkNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(5660300002)(38350700002)(38100700002)(83380400001)(2906002)(66556008)(66946007)(6486002)(7416002)(508600001)(4326008)(8676002)(44832011)(8936002)(316002)(26005)(52116002)(36756003)(86362001)(6666004)(6512007)(6506007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5zqcujfl4D3opzlaA7hOlLr8WkemqD1D+6UWxDF6sXeP240Xg9fdUdDEpVPe?=
 =?us-ascii?Q?JvTM37LBPULosQgUOT1B310U85CMpLaYG+0ntgdUBCim0L999IqzdBYuWi4R?=
 =?us-ascii?Q?7r21qL3B9k6/DMn610PmuzeRsmp2rljMgoBKpKDP0BSCx05Y3YPLht4G5oTv?=
 =?us-ascii?Q?FjpRg2AW48D4dYCNkDd5JmtV9M5bNudpHWpQQDUie0ClC+LfflMYkc5uj3Oo?=
 =?us-ascii?Q?fWd41iHlyaluCxNLs3EfaLAdZNCgB+trWsTehv0l4BFNzPScfKppBUGJjAKk?=
 =?us-ascii?Q?GTUI3Tg3kpIbe4p6xGFZIf6BiNVhToZ3p8/DycxardInevtewarWdWo6IY2D?=
 =?us-ascii?Q?th9usxxz6yGUM3TBWuiXW/e5D0i21EMS6Ssb5rFmFcgz+ij5xM7dUJHbqF31?=
 =?us-ascii?Q?RdnrhY8i/Z7ruVmsKh/2HCDXkq5LFvW8hI4qmf3IxnlZ/Dve8tsaqf0V3MK6?=
 =?us-ascii?Q?U43JGiVyzpzvtakXRLmoRX4LlwcwIqvZf61FNk++/lDpyk/e5wUkEcR7gzfn?=
 =?us-ascii?Q?3D7B93IjF5nxGYte8ScLNIp9UPWIdcbMm6vXcz2VDrWTANq28QE62V/HhtWV?=
 =?us-ascii?Q?SeT18pJym+7S2nVISDnvweOstZrMavlvuFzwuMGUMOLcpzQsE1X0jAhTQ1KG?=
 =?us-ascii?Q?HhauVQoOOshdUW6+kRN8X2xohqKTrBC5xx2sMm1dJ22sAJVdlEF1WM9lbwOf?=
 =?us-ascii?Q?TgxVq9CPVamNB7L4sEPgf6CK/DI2zhUBpgRjvK2yt+uP1uOYuGmaUMRmFPjG?=
 =?us-ascii?Q?zrGcmvZMOITkeh4IN6RuHsEV+OqjXLqADKg1Q48t5VTrJmyG182fpcxy4qT/?=
 =?us-ascii?Q?lsQM4QOOP6QzC9psZl+S4IxGp2YAKFrZd1RvoGuOxV/AuWNgiczPfqvpou8P?=
 =?us-ascii?Q?RoM7PQPnWFHm+dGtjm9RTG4t5YEjkCVpyqDiwwftOdOCQ+hOoMCMoQzedFxd?=
 =?us-ascii?Q?kbq8cybEn4JLuBh9j8jYzJMm5TgeBzzUVFakto7xAcAWzKs3xeqgD27syf1h?=
 =?us-ascii?Q?CVO8qpd5+HZbdRNfXtmJAfqBZJpFfgAQlSWQRMGEUE0BkNp5Fp8IlO7IGRrf?=
 =?us-ascii?Q?nkKbwSta+XNFCkAuwo6Mq93AE3Rb1PzdcVAhzqfwAHw/HaxpF/6kyYYKI7NW?=
 =?us-ascii?Q?XUK0aef+W8+Nn0otLrJzEbsV2Aq9Vpu/RMFTLTiMywbp2+glPwXrUasEJTgk?=
 =?us-ascii?Q?gWU3q9VqzO7A6BKHCF7kGGe/HodridvaTGU0ABPQ8juZeK7E6OZBlmNhugRw?=
 =?us-ascii?Q?gUt8sgvr4sod18TjTgv7KdBEZd8G1dHLVGirKEa6e1ICbew/8khmjgEMVFSR?=
 =?us-ascii?Q?6it7SH9rCMe9C0NHcmInh9GpSnsWkuxUUdHgyC4/5ztSH3VaA3X5lcD7RkoG?=
 =?us-ascii?Q?dnM1woL5mMU6h3gydE8elZZUbQxVSnhKTCeTRqbvAyje8JPPMg18I9RZ9DtF?=
 =?us-ascii?Q?kbeYFKDcjPIi5vJ/H3PpendGs8BAzhwS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899d3802-8a78-48b4-eb91-08da0cac6d61
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:06:33.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7HMsNOsewwkYXGdqLP3bbVLwkzJdyef2AA6d8p6G6OqCX43TB9UJv+O/kLvbCQYk7H23wykYAtQCU8TiRkRxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support dynamic resolution change,
driver should meet the following conditions:
1. the previous pictures are all decoded before source change event.
2. prevent decoding new resolution pictures with incorrect capture
   buffer, until user handle source change event and setup capture.
3. report correct fmt and resolution during source change.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 69 ++++++++++++++-----
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 30289f2be3dd..0c3a1efbeae7 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -933,13 +933,14 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 {
 	struct device *dev = ctx->mxc_jpeg->dev;
 	struct mxc_jpeg_q_data *q_data_cap;
-	bool src_chg = false;
 
 	if (!jpeg_src_buf->fmt)
-		return src_chg;
+		return false;
 
 	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
-	if (q_data_cap->w != jpeg_src_buf->w || q_data_cap->h != jpeg_src_buf->h) {
+	if (q_data_cap->fmt != jpeg_src_buf->fmt ||
+	    q_data_cap->w != jpeg_src_buf->w ||
+	    q_data_cap->h != jpeg_src_buf->h) {
 		dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
 			q_data_cap->w, q_data_cap->h,
 			jpeg_src_buf->w, jpeg_src_buf->h,
@@ -976,9 +977,16 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		mxc_jpeg_bytesperline(q_data_cap, jpeg_src_buf->fmt->precision);
 		mxc_jpeg_sizeimage(q_data_cap);
 		notify_src_chg(ctx);
-		src_chg = true;
+		ctx->source_change = 1;
 	}
-	return src_chg;
+	return ctx->source_change ? true : false;
+}
+
+static int mxc_jpeg_job_ready(void *priv)
+{
+	struct mxc_jpeg_ctx *ctx = priv;
+
+	return ctx->source_change ? 0 : 1;
 }
 
 static void mxc_jpeg_device_run(void *priv)
@@ -1028,6 +1036,13 @@ static void mxc_jpeg_device_run(void *priv)
 
 		return;
 	}
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE) {
+		if (ctx->source_change || mxc_jpeg_source_change(ctx, jpeg_src_buf)) {
+			spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
+			v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+			return;
+		}
+	}
 
 	mxc_jpeg_enable(reg);
 	mxc_jpeg_set_l_endian(reg, 1);
@@ -1074,6 +1089,7 @@ static void mxc_jpeg_set_last_buffer_dequeued(struct mxc_jpeg_ctx *ctx)
 	q->last_buffer_dequeued = true;
 	wake_up(&q->done_wq);
 	ctx->stopped = 0;
+	ctx->header_parsed = false;
 }
 
 static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
@@ -1167,6 +1183,8 @@ static int mxc_jpeg_start_streaming(struct vb2_queue *q, unsigned int count)
 	struct mxc_jpeg_q_data *q_data = mxc_jpeg_get_q_data(ctx, q->type);
 	int ret;
 
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE && V4L2_TYPE_IS_CAPTURE(q->type))
+		ctx->source_change = 0;
 	dev_dbg(ctx->mxc_jpeg->dev, "Start streaming ctx=%p", ctx);
 	q_data->sequence = 0;
 
@@ -1345,16 +1363,15 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 		dev_warn(dev, "Invalid user resolution 0x0");
 		dev_warn(dev, "Keeping resolution from JPEG: %dx%d",
 			 header.frame.width, header.frame.height);
-		q_data_out->w = header.frame.width;
-		q_data_out->h = header.frame.height;
 	} else if (header.frame.width != q_data_out->w ||
 		   header.frame.height != q_data_out->h) {
 		dev_err(dev,
 			"Resolution mismatch: %dx%d (JPEG) versus %dx%d(user)",
 			header.frame.width, header.frame.height,
 			q_data_out->w, q_data_out->h);
-		return -EINVAL;
 	}
+	q_data_out->w = header.frame.width;
+	q_data_out->h = header.frame.height;
 	if (header.frame.width % 8 != 0 || header.frame.height % 8 != 0) {
 		dev_err(dev, "JPEG width or height not multiple of 8: %dx%d\n",
 			header.frame.width, header.frame.height);
@@ -1390,8 +1407,10 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 	jpeg_src_buf->fmt = mxc_jpeg_find_format(ctx, fourcc);
 	jpeg_src_buf->w = header.frame.width;
 	jpeg_src_buf->h = header.frame.height;
+	ctx->header_parsed = true;
 
-	mxc_jpeg_source_change(ctx, jpeg_src_buf);
+	if (!v4l2_m2m_num_src_bufs_ready(ctx->fh.m2m_ctx))
+		mxc_jpeg_source_change(ctx, jpeg_src_buf);
 
 	return 0;
 }
@@ -1468,6 +1487,7 @@ static void mxc_jpeg_buf_finish(struct vb2_buffer *vb)
 	if (list_empty(&q->done_list)) {
 		vbuf->flags |= V4L2_BUF_FLAG_LAST;
 		ctx->stopped = 0;
+		ctx->header_parsed = false;
 	}
 }
 
@@ -1613,26 +1633,42 @@ static int mxc_jpeg_enum_fmt_vid_cap(struct file *file, void *priv,
 				     struct v4l2_fmtdesc *f)
 {
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
+	struct mxc_jpeg_q_data *q_data = mxc_jpeg_get_q_data(ctx, f->type);
 
-	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE)
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE) {
 		return enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f,
 			MXC_JPEG_FMT_TYPE_ENC);
-	else
+	} else if (!ctx->header_parsed) {
 		return enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f,
 			MXC_JPEG_FMT_TYPE_RAW);
+	} else {
+		/* For the decoder CAPTURE queue, only enumerate the raw formats
+		 * supported for the format currently active on OUTPUT
+		 * (more precisely what was propagated on capture queue
+		 * after jpeg parse on the output buffer)
+		 */
+		if (f->index)
+			return -EINVAL;
+		f->pixelformat = q_data->fmt->fourcc;
+		strscpy(f->description, q_data->fmt->name, sizeof(f->description));
+		return 0;
+	}
 }
 
 static int mxc_jpeg_enum_fmt_vid_out(struct file *file, void *priv,
 				     struct v4l2_fmtdesc *f)
 {
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
+	u32 type = ctx->mxc_jpeg->mode == MXC_JPEG_DECODE ?  MXC_JPEG_FMT_TYPE_ENC :
+							     MXC_JPEG_FMT_TYPE_RAW;
+	int ret;
 
+	ret = enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f, type);
+	if (ret)
+		return ret;
 	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
-		return enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f,
-				MXC_JPEG_FMT_TYPE_ENC);
-	else
-		return enum_fmt(mxc_formats, MXC_JPEG_NUM_FORMATS, f,
-				MXC_JPEG_FMT_TYPE_RAW);
+		f->flags = V4L2_FMT_FLAG_DYN_RESOLUTION;
+	return 0;
 }
 
 static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fmt,
@@ -2018,6 +2054,7 @@ static const struct v4l2_file_operations mxc_jpeg_fops = {
 };
 
 static const struct v4l2_m2m_ops mxc_jpeg_m2m_ops = {
+	.job_ready      = mxc_jpeg_job_ready,
 	.device_run	= mxc_jpeg_device_run,
 };
 
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 82b38cc2dfab..9ae56e6e0fbe 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -94,6 +94,8 @@ struct mxc_jpeg_ctx {
 	unsigned int			stopping;
 	unsigned int			stopped;
 	unsigned int			slot;
+	unsigned int			source_change;
+	bool				header_parsed;
 };
 
 struct mxc_jpeg_slot_data {
-- 
2.33.0

