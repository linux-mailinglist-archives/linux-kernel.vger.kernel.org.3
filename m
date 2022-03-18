Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B297B4DD5FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiCRITa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiCRITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:19:20 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150082.outbound.protection.outlook.com [40.107.15.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E07222A1;
        Fri, 18 Mar 2022 01:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VafPXqKeynrwhy1vs/2neTLMsb0oq/OmkjwNWn0SdUzGLDWZPbqlPKq3YtQl8LI7guq/d22qh0jzOV2LSAkPxfKUhTTW3nzYN5Tx4+lw74JmYIfhBnmz0bJxE05PWlb8aIzvJY2NvuOP61d9JMSicakZRhc7NpUprWnfBEOUQVJGPahRuZo5eo1UaEUOIfMTWohzUrBaJTfX6E+kn5aE7pPsItCzzz20dNTrCnubgmKGzuuQsGubjf4EnuB/tUnEiZAnOqkdfH7b30oCU+pZu/9dnzET6eufsWhvDXLq2oMrr+L+BfetBVyRaej94WC7yUzZcAoa/ru2ufScS/XRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSP+wNzua7vbfftMiEf1QRK1mgGgsnw1qa5RCzCG5rA=;
 b=LytNgXmk+vN6bwWYvwjArrlqRlUDSA4Iqf4jj+w9ytZVavj9z3pBKHESCrR942YAzsPcupbNUWe5fpsSGL2PeYnQJqETfYfyiqSNPDAivgEmJb9nLSS/7ZlNCFwoWSHK2fQxA/0wWqLYtdlSHsw6kV2RCMNpiMFWuAK8f5EjmbSHIIQJKdaNEgwDTg+csw4LLdbradOuSiP7/Qu63U6IT2aninuBN8pH+SEx+PXdQPK8hCevnhG2NXnveAEWjwuIxZ2orY/CWLHu+1jqQUYIUl0EA8ZF0DZDH5il0W7pxbVNxyU/ifkeLYdcfqbbtVQlezERMYsyPJ8MYZPvatfV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSP+wNzua7vbfftMiEf1QRK1mgGgsnw1qa5RCzCG5rA=;
 b=sl0DvOoao/jITRqxfGVqLGr2oOaPRjBYSf505Icgwo0ccFTtVD+P+4wQYVvH7xLOtcKGYZqWJ7Qw1CgwJaqBi8dSKV2rucDrrEkFvkF2LKGN8od1fGM+etPQO9pTr25Q/8FEPYwOa9TboJZhSKVOCuhdi2tNSFbBomCs9wq7rBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by VI1PR04MB6285.eurprd04.prod.outlook.com (2603:10a6:803:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 08:17:55 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2%4]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:17:55 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] media: imx-jpeg: Support dynamic resolution change
Date:   Fri, 18 Mar 2022 16:16:55 +0800
Message-Id: <bd6d78391efb8ab118662611f80849cc1aaf99f5.1647590462.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1647590462.git.ming.qian@nxp.com>
References: <cover.1647590462.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DB8PR04MB6346.eurprd04.prod.outlook.com
 (2603:10a6:10:10c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f886b7a-7006-4713-ef7b-08da08b7cdbc
X-MS-TrafficTypeDiagnostic: VI1PR04MB6285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB62857DFF06B1DBBFB4C23275E7139@VI1PR04MB6285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqme/2NP/xc1Yer/DIFZXPse4aWAG07fqXZ3AUKHk0lvkaTEoRQUAH76sT+5I7QOUykHD5mijFyJMvHcXhFO6VlFZpNXq4qX5BZsFbC0Q3qo9JNc7ekeVM3Ay9VCfFciZKybgVNY/LeG59vgYbKNfLEo8cW7c98EBpuVBg6Qcf4M6YaIBk2XbJJbTBS4M9xCzZtD5BW1YlOGh348i+0auS0ay/I7gseSV487lQls10QOSYz0plfsaC9w7kAsB4U8ut1fL72aiUIes123smOUqitaElgMJiZC/q+wq5BJcPSkMdmye867bfz1oPRKaZYp35okYA3LaX6IYTqVPxupSN/dOcyQrGaJNkwvE+QgbhyYaydgdx+scLbJ5nemM4hhn2fvgR5y4HkGS2Skt24lLVVVh6Eqkk+Q0AWOh3Xl0w4jyD560d9YR9f1TsuVSkii/GKij/w9EMEXRdOGH4BHRorokbeK/h/Qpj4eMlFUc4xSk8ho/ahc2RiY2MkuycD1Ja504o9H9hK4UvzbEejPZuYeQg8HiMKb+Uta15q9RcK5DXXljTIunztrzOHbc8z+rIPwS1TBpKOfB1ORGHoysYafPJ0rYEi99qfaxRq+9gyLPDizkatdhyJQYwm1tFTPaLGnd7PRhk4T0pLKm3e4JXbZKRxfV8g6HKmzYjxkPjcXuGaLyLIwzv5vJopd+/mpp3IBKCyLFVcqSaT2rvtFNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38350700002)(26005)(38100700002)(5660300002)(6506007)(4326008)(8676002)(66946007)(66556008)(66476007)(52116002)(86362001)(7416002)(8936002)(44832011)(6512007)(2616005)(316002)(508600001)(83380400001)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LHHR8k5TGtiAYm1UVW1KHPv51aJFn92hi6F6A8vmUOtv1/X5ojs7XQLpY7JN?=
 =?us-ascii?Q?u6YlxGxZLDnVezveSU89/IC9NQ/WE0E3Qj6wZ4OP2EP9IFUBmk/C6JXl8ZQM?=
 =?us-ascii?Q?73nqGhw491ZZUbI4j3TlFmDnHqfYeWxHgmae1KUBaKJsl00iyrNFHCJiYF9F?=
 =?us-ascii?Q?rbUpZfi4axBFFOkAs/JVHeZRoEyfgaiIFfd7iJph0f3Zt53PNN669an4qn3v?=
 =?us-ascii?Q?axsvChHfHYPiJJPfxcXr5Bn27oPCxAEeo5lxf83/YKB5ESKjIf3wwJsJL7c4?=
 =?us-ascii?Q?ActzYKiMu3ovZzTNE9urzTmSrJqE2532p8jHWeW1jw8KqdJaKghRIiA4kQI0?=
 =?us-ascii?Q?ikW7GjIug1UJpIERBd7um2cyxnR1Rpyx8UeOQy1++oafsJkNxiC2jPCYc9Hk?=
 =?us-ascii?Q?J4ERTFCwem9Rf72nMiF9poTYXD+SwoY/AN4JiwYUf9c2QsFRW+/YvmJGUAma?=
 =?us-ascii?Q?iPjq7TFTSOnru336qxZjZrH62bsFGOOIxQuWASKCbjc6+d1hIE06q58j5MZS?=
 =?us-ascii?Q?ycZHZqrXJAAAn4jjudSFMaDyt+oNJi/zBI9Bz4+5KYSTx61QkifBAEbK2GBb?=
 =?us-ascii?Q?mslez/qxMmNH49oRD3tAGzqAhzso9nhIACBhOc9fOc0Rn5zxaENvVm3dbgoy?=
 =?us-ascii?Q?lGtfsBrt+kQV79MXTnvu82xvjR+bh9h0XHPchvjAkdPEM+wNZOk4z0Wn5z1r?=
 =?us-ascii?Q?x0ZRDozXkzhIxeVHmgNlBwBJkidcVX9dAo94gxaaJw6S8aftb1I7z1ePgs/f?=
 =?us-ascii?Q?BxLT0zvZPNYqzqlDRCdADlcu8qIZuLXpWj3scMHBnogTlWMMKeTplLR+ptyU?=
 =?us-ascii?Q?UAG3e2bKaCFH+EAye8sq1IaatzZ/AlSyP8SIYI4RZ1ceI9gVQ+UjA7vZ3NBA?=
 =?us-ascii?Q?eLzcgs7d+ai40jrMtyvTE3jNnZN6lW7/R4iEEZUYxk8spIAssX+mdtaqbLg1?=
 =?us-ascii?Q?XaSCkKFDnGlfCOfJM/YPZ00YCyj/pLT6tVotEEi4tI84CJDXn0Fm4Oqe3kmZ?=
 =?us-ascii?Q?F5g9WGlA4Jho1IL2bI0tksn6FNZQSkGYSogI3I3c+3nyBumO1zsicFSyCj4A?=
 =?us-ascii?Q?deQbWXNcdn+uOKg45YXaWCq+qhmeqik4EfVd4/D92lIvmgqueeOmHR3RQB/W?=
 =?us-ascii?Q?iXD/XyxMIJp+LjsC73CQuylyzYhtk+zbLqTu/GEtVBiJMzolvYRuaVqPfLv/?=
 =?us-ascii?Q?h1VC15Cn/kXV31ruQLqKdLu31dHf7PGAITurph1j+IMZ3tBgHzxyRGVonID0?=
 =?us-ascii?Q?V5VQitVYeZHGwzVHOGO4PBNi2exPFPo6ggLAx2ZMasYHT9/PMTbCZIKpobDw?=
 =?us-ascii?Q?LNPDoea1urgMxAcDPRqbLuX/600XhQl0lPSOL7Ja6YxbfDbZ6Po3z0t5LeQp?=
 =?us-ascii?Q?Zc+iBvkF1wkhrxawNXGxaRlVYqYVStqrCid3wUZkU3ayYEUMEIUF4vlOYjEL?=
 =?us-ascii?Q?m5dkY5WLtgXo3zIwFzS++j5n4inv0ErH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f886b7a-7006-4713-ef7b-08da08b7cdbc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:17:55.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kozNkaoXKbP2/inCbOCG9ijpaGPBpSHMs2m2xAaEAPYMnFCkPSss4+ANAd9g3RQ0HnWhiWppzZlBqhMUkeIyig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6285
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
index 5bce74de7cf2..5584b40fb36d 100644
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
@@ -2013,6 +2049,7 @@ static const struct v4l2_file_operations mxc_jpeg_fops = {
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

