Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CFC4D5CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiCKHyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347289AbiCKHxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:53:48 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803DBA740;
        Thu, 10 Mar 2022 23:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pum9Dg448ENuENHezdP8vsI/On+VPDT5on1qEuP1Ot2TmkNsvUcCMjDy+46r/BtJiqTdkgG9hfd9rDFwWsBNIG9+i4UZpeBL12UeMP9tOJUXbyh8Z+0inz+VzGO2y4AYZUVCvsT7Qm21QKRmYvH63Zw+8pzTP2yXTKC1nlo2PMNCneUX6GkotmE5YrhH9zGXx3ILPvY5L1XNqIvLFTeNho4x+dTo+MdrM+wfQ7m8wyWMnZxl9D5Djvu57FsziA6Db9/z9eTRxanvxk8aJwUim1EpIhDfClqp1FootmvCkC+OBaTU5z0mQOv8OlCZfIJ9T85kWV0HlJhT+6XC1K1vQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prmxw1sdsDypUMG8otmd/XhaE7mFmMevqvhhIPGOk40=;
 b=fmNFkDnMPeAUsRX9MBjcfwsphm59BlwPqY8QNps1FUZ13S6yQNRjogSylVNkiPP8kdkE4MT+ym1acJmBMQM+Dbogo6/u97jgUh04ZF8mhfzhSrM/YHNKPGpUNtSDTqQhO/wGdF9eJ+/N069FKmE5ZigCC9D5ssgOZvtRlXT50HIMEEOBC/OePVSVx2I/JjveOuHo6GcHTgdQzbcZLCZd1GCZheKbdEuCL4cUsJNoN2nnCVXArQm1iT66wf8c9+/CwsCpnTf8oLD7Pz3tpLxapAlnlv1gXriRO/9ZzE1eRROXCSwd9X1A2nrcDFUyk2FIkhaFfCv13cCpGyLUBFAxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prmxw1sdsDypUMG8otmd/XhaE7mFmMevqvhhIPGOk40=;
 b=THBrFemfzQyuN0l9V9H8dPZHu6LXOuc5L+iUQLKwwzWjDeWIg3hdrfUGp1wcaqjqsj8dkIebiRw0IwAb+K7yIWXhSRyZNHgOmmkJUUatnMJFWXilzEOc4OkgCibr/Y0t54JlcEbV4w2vMF1otsWNEEcmDHY7odORglNyNtVIOW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4443.eurprd04.prod.outlook.com (2603:10a6:5:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 07:52:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:52:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] media: imx-jpeg: Support dynamic resolution change
Date:   Fri, 11 Mar 2022 15:51:47 +0800
Message-Id: <b57b1bf40c56d77c42397a58dc9634509e03582f.1646983646.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1646983646.git.ming.qian@nxp.com>
References: <cover.1646983646.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d66dea7e-666b-4ad7-ac64-08da03341f9c
X-MS-TrafficTypeDiagnostic: DB7PR04MB4443:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB44438664EDDD0DCD3C9FA5BCE70C9@DB7PR04MB4443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/G0Mik3tIIbzSL/XCwmTXDm3joMQxnUoJhjTKcJSKJ+oQPZ8c5AoStx4LSQYw6DMmUZ2F3y9ZzS9E0FG9FRpZ/tGmQ2hlqKVLjhIwa/gMNPFRTFOOQGCXa47TpiRKjCK0Us8tgvN6jH3pneX7SjhJuSctHNJI7Zx5xzJ+Pd6ERkZx70fe7HLc6CRSDEGTwZfSOnsw8uExQ+ua7tE9YAZl4TlqBPUUYGBFcPnDOV3zWiFA4g2HujgVKlEfnC1MFfvFi+fbxhmCe+IEODxbqIsynHxnJdtZvyaS5//GTgQFQl5h7wk0lhTIi6+QNjofcB4x9z4BO6cyRfeK3hfWwB6h+kw2sRsRaV4cBTCJzww07osNxxXMYE2X/lsBPgJyW+4sNUAjmT9r29sF93ZZtYbhOlIvxoNGQIdeJ/h2MX8phxb+C0hPGZndMYH2nVH62Xc04z9lbTBsJ9aXg3Nfw4fPOas+8TCwyvtVnzEBfRjwnSGZaTXWNtge3z+ZQtrrpoPo2nPPfShPQ+4F3Oowqf95TckeAMWlaaSHyNUcGZaoCrJZz23+w3wm0FaNdCZldk1S4kjnPpCf4tsjvhrQ10sPmlW1kSArLjEyMxf63sndTcpHdcpMbOyURcoUBZ/g9xB4ZfppYAGMxXWMhbEsK+Lzn8CcIyNUQR5V3S8Rfpjjm3juFy8MG0DkQeRDzyDO9DCxxRkQjoZyPsD/E4IU1Hqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(26005)(52116002)(44832011)(2906002)(8676002)(6486002)(2616005)(508600001)(86362001)(4326008)(186003)(66946007)(6512007)(6506007)(5660300002)(66556008)(38350700002)(38100700002)(66476007)(316002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+5MVFyPthGV5O21pA6BuuEDixpiytqpdTaJNtkh1iUBsJ0gQaffRQXzG6Bi?=
 =?us-ascii?Q?CmKjfGs20fvYbMSXeKYun3nXA5vma/u7oYDdMfYKnlWBVGqkGGDnol7lx/J4?=
 =?us-ascii?Q?waMotatg7P2sLqoUiVxztOYnrP0Qmdi7s9vg9wXK16zEyag/IqmwWb/amUrn?=
 =?us-ascii?Q?A0+OHnmMUNrUHsxRWaBF4JplZzIghWGZ5DN2zxtPX0OpRXxvfeP0CDNknPeS?=
 =?us-ascii?Q?c0LRjCdIR/QD+edgcaOif2L1NQqZBPq9ND9yjpJdsUnXj5QECuX8q95E9faM?=
 =?us-ascii?Q?BKk+3pMXpziuav03fLYcTZX4jG8xYDeYp8nIgDGC89TLddSl9m1zusqallEo?=
 =?us-ascii?Q?NZIUnNh2zeubHx8QqKL9YW1SExTe3GFuk1v2TEzA41okak/7YraEBv3YdxCG?=
 =?us-ascii?Q?eepovDBnf05YZRlffWCW8oklJS3KmMxkeaecJXssXSrSCBSH1YPQ9MJFJuN9?=
 =?us-ascii?Q?RdBhoBmGMwNHosKHTSlzJze1xDDnhycQ7h8n+wg2j2KExXrbv5mBBP0hmO0g?=
 =?us-ascii?Q?asOjuYWqxrh71SOlQnrLcZuRQh27tCvQji9TYvn0PWXoMhxCnT52W21keZkt?=
 =?us-ascii?Q?j/3mbax/t64zqTQeMupsGVXo0MgxwbivYhUuFFBAn6R48zi27ybFDcuGUy3f?=
 =?us-ascii?Q?GZjM2UmJVO58rT0T2lyRu0f8dkIfC9B0nkGGA8HRRuK/Q0ZPdcsm4Q/c0w2h?=
 =?us-ascii?Q?JXwtJQIwVp6iwppYO5tKlMg3ztumUkFKrjlcpB8snanjE3T96XLlwrZ9DgJ7?=
 =?us-ascii?Q?DgrBVYiFZOYfw0gx+lvOcyzkGr6A++Smawv1HaiezboTzyzxo0fyhxpXcnbN?=
 =?us-ascii?Q?DL+gK4JidCKeFIPWa8+EQT2YLIhRDEo8Y6DnkYmSur4wkBHpT4sSGIGGCRSz?=
 =?us-ascii?Q?hFYG5F23kYjJyUwzp+IyAod52DnlwZqBQXTkt+r4o8Zs6BAysmeqsrZ2aN7i?=
 =?us-ascii?Q?coPxKORxd6t9MAi/+ig0lZtvt688EX7JBAV1RDONtdEVFYOvoQx7osayx1qb?=
 =?us-ascii?Q?L4HlclW6QhAVJjV9A3arc8BE7pb5Q3jS6sUNKm6gNafEHPOhg610u0N7iKsU?=
 =?us-ascii?Q?h+8PXGH2oDYhy3aiYWyvsTyPIzsst7nkXTP6eA6OAd9FlPnofP55jdjqTXk6?=
 =?us-ascii?Q?TKMMQNO9vdx08twED/nN31fYfIEEeWFhLX+k33sLRm3W6lCGXsgEwibS81cV?=
 =?us-ascii?Q?hvx97RwdWLSvUrETK/dsQbhHmLnJIZVfZYDonOlA3+cCTBn+mdyKNLSfiuWA?=
 =?us-ascii?Q?tHcxjetpXjWHZSAisFsd2E92BTXEiKK0SIXS4R+Jyz50+l2jhlaqhdvLv4Ff?=
 =?us-ascii?Q?Mf0eWGdcUnxCFDTYYiDS4T5pW8PXLlvElANo3rNVv3jN2WqpOnioeJx5U15D?=
 =?us-ascii?Q?iqDphXU8skrscy4qOlPF6NHgGFYcjx/s/LaAXbOsI7Wmxi53+R0KBaXqQuOZ?=
 =?us-ascii?Q?K/yjzTBaDeNpRpq3lm74jw5+vyFKgLacZwW17JR8z2hC+bkG7DTg5aq+w138?=
 =?us-ascii?Q?qeT9/nXsxMQgFY0bJsN1P4ranA3lO7+GggCCkyFMNUqlKC4pzc2VvqkDJxr5?=
 =?us-ascii?Q?M/jvZ0AJsHXiwoDfId0eJHl6z9bgUP2uI5czYrqUOx3JDL/z6z6wqtKWwKP2?=
 =?us-ascii?Q?BnB7oicCSMb6ZGWcEJ4ZJPo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66dea7e-666b-4ad7-ac64-08da03341f9c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:52:43.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxCk8la2bW0WNKuSxYuk9A+ojBpQero5ywROv2oXuQwms/gq90ZiXuQeJ1Tiw8I5nCrb3YmtJcw1wTW1nkHIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4443
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
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 69 +++++++++++++++++-----
 drivers/media/platform/imx-jpeg/mxc-jpeg.h |  2 +
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index dbcb83ed86e4..3a78673d6c6f 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
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
@@ -2013,6 +2049,7 @@ static const struct v4l2_file_operations mxc_jpeg_fops = {
 };
 
 static const struct v4l2_m2m_ops mxc_jpeg_m2m_ops = {
+	.job_ready      = mxc_jpeg_job_ready,
 	.device_run	= mxc_jpeg_device_run,
 };
 
diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
index 82b38cc2dfab..9ae56e6e0fbe 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
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

