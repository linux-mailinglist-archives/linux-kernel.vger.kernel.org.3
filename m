Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3845375DE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiE3Hto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiE3Htj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:49:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B382772231;
        Mon, 30 May 2022 00:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKhPhzW4mgwGBXvvIbb7ripAERoR/HkieppbQKh3cf1KZud3aI87aNnm0flMTX60jfS0ps72aVdSom5OCKQ6uwESnMcGyKzfSTxnBbyoUDfBJmR2jQrUyqbVq1oykA0qk5bq5ahI3mRbdNJhR6ySfZq/uDkeL9hkZlxH8QYv1puG465lrmMG67CclEeliXoO1iZd8t7+qVMCC2uv/xWzPkMXtBAhhB1Ur2nq7i2FZf8QuWa4ePHrGwVJ+jg16cDXxKvq5meYU+4//SjF8o7RCaH99FXt5o9QqOuL/TY103tF+RBM4n3TXGOLZUMoN3Zh4P14G233gH/NHOmupZdvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/Npw1mpB0mQd2J6yEMg31ElLcivxV495QJFK+UggPk=;
 b=Q44m2qovAFxFZXJ4NKJL4ZXeBkkqQjz9NC5OmIr63VTUsPOg7NePb5zvnHgiWXfJBJDroYkcJbpt4i0ASb02U6ztotyR7wuQ7nCLO8LfNYBDXgV7KIw7HGdAUIVYDVegPjU+64iBITttMPi9JrfrF+XgNc0gp6l27R2nXuGAiSGzguyRjYPncayVbQcmk8xoWY17JzVe5a4ZW1els55CObfUJwdgFo+i1R5bBNBlhw9t4QKR6kKtt9t63TPlpKeVy9rPh+pMwCFvfjUunmKBaynMz8lD1AFPAfEw40H2JaqgQUaaqkyAMEgHZsyDLITeuZ8Ni7PqpK/0CUSv/Xcoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Npw1mpB0mQd2J6yEMg31ElLcivxV495QJFK+UggPk=;
 b=lc9gkhz5lKsAGO7YbcvnmX7dWMECdUzWsdJIui9Nz8C7+9HOmTvJMa68WF9Net9O8H75tsS2O9h2O6AlQ73ZAlflnyufmgW45nvQMbOKi/ZXxW5q5CvEg/d7GnQypDCntAtI1DoSGMpEJVYE2SSGTe7C/BuKFJ3cPDw2UHDT7x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB6085.eurprd04.prod.outlook.com (2603:10a6:20b:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 07:49:35 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 07:49:35 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: Align upwards buffer size
Date:   Mon, 30 May 2022 15:49:19 +0800
Message-Id: <20220530074919.14982-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84839460-ade2-482d-7727-08da4210f0f8
X-MS-TrafficTypeDiagnostic: AM6PR04MB6085:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB608552C4DD07BCE524DB68BFE7DD9@AM6PR04MB6085.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLwCZat5hdBI+7mhDA1HPU+/2eJ/WzGQd/qxyRHBy6KcM/BrvVXi7gMUILh587+M6ye/qur4WiQbEqGn6fbHb/abdqCIcp0HpItL/3Kz0P4KgbTsTsmwpSw1nv+XxJ0bCmfjCXEK+Eem5ckWUdRyCU7s4yag2iMTO7LNO7LWe/OigC4hvZ1kk/e2WzDJNFvNHHKzE1SH73bVqK0+Ix0SYnX7HYXJJfmK+9FXyPh/cF1S2KWqNCzhlR6TbuFQwLaqJY3Jnvhjx0eQtuqOrVrpqiOX835WxgfOfak5TIrsNwwhvN086r6ruOMiTup6hkkoLzUSzIz3EQoxqMs9QuvkPLR5Wb8CXKyBiyjX8oDZWurcz7jjPfqaYXKLjB9Fnhj4WruEGBd+0DnDLmyRd5gzC+kWJ+KfkeQHGqQwP0ispETUTBS3YbnnKRDPzgaLbzHR1Mat3qMYZyv6li+DGO99JHZH2DWsIJvQ0BsnlP60wy7b3i+7VZkw5HmdkR1D3Hrg56mioHUtHi8G+KNQTMow5vPFOylK4pJ57eoydwWWJL3FQrR9uFXnjOAe1/t3OK5tC5iPqcJ2btVhboq6bxGgYon4YMn1nIuD1A3z8UL4cjKA7YSxgapZ7ZlhqnzaAfRl7XOvYKv2/+FYCvLptQdCOmzMoOyBuZRK47ZuKbsUaeUWHqyocJfgPQarL7HzDGGnXF9009OgmUmXC+/936FCqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(6486002)(86362001)(1076003)(26005)(6512007)(8936002)(2616005)(6666004)(83380400001)(2906002)(52116002)(186003)(7416002)(6506007)(44832011)(66556008)(66476007)(4326008)(66946007)(8676002)(38100700002)(36756003)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8N2jxpUOelz+LScFRLlQNOj31lp/i+0kdufEPLQR7rKAwu+9XuRcjJ44z2VX?=
 =?us-ascii?Q?1jUpDeUoWEyWb9JcQI6ReHurlHsCsHbPlvkRa9xvUYm6b9avTwzizuwfZwZb?=
 =?us-ascii?Q?9ZrolKia85JXb2NiuPrWi+q2XFi6WaP+fTEjxDE4ufX3Wjj7CnCmJVpwhIr4?=
 =?us-ascii?Q?Rwsvb6hwKoBZ42DTtWhZtyORdGz8v/nkCrkZLNE33wqN0GPi94dOEJaJPUVV?=
 =?us-ascii?Q?3KOCvYIh5+uzWs948kuMZNc9awXYBAJUW+lWIQuzobjRLlps9G/z4xlvOufd?=
 =?us-ascii?Q?tvKMb129gFd/i+kqsQ8Ty0pgKeOmVAMOS6jY06tHFcYKHVFx6OWFKryCduKD?=
 =?us-ascii?Q?lfeIYURUDpIgpEZVHydDzvHhtA1AqC+UuAXlanhFMhd3Aa7mytVl2dETsGvL?=
 =?us-ascii?Q?j3c1EdqDkESpeA7Dp5ecmMs8tg6Gz3lChE36cwByEc9a7B9pwbA7PlO+yvAt?=
 =?us-ascii?Q?HXubGG9h7J2i2jIRqhTYb+Mfo/xeHTDqoN4ahq4r5GbiP57vMnJGNdwuNRgz?=
 =?us-ascii?Q?i7mSN0nGJysBRCzc9GCZlKP9jnP7us74x/YI3lR3S1Ur9K8+QQomaVO6dCuo?=
 =?us-ascii?Q?+blzzNhGO2KNOkYncw+UV12MaF4CZkA5iftoBdzo/+dyGEOswz7fXOS4Y/xf?=
 =?us-ascii?Q?/fKr9nQ+OTz6fZlaBQCzf3fST/jUJmkzOzEdP4RnnOW34b4z5D5YCjnpKh4V?=
 =?us-ascii?Q?3r1+YMtdYy1HkY7SFisr+8YmXmXM3oj56Jwtzxst055BupDge8b5Z0l7Ea6j?=
 =?us-ascii?Q?zjZp+uyjRKhANvM6LzfYOolyOhQoJBEJrnqURGmM1is4tDAvQAHy6GidSmV3?=
 =?us-ascii?Q?3M+wHw/0h3mRh4f3W/TUOG4aoMsoCwzICcxPqM87EepLvx1B4W1WdMfU1Mnf?=
 =?us-ascii?Q?CgpjE7VDxI6OFx/wxmYi0pg6w9jD4V4OUMHFgxxoZRuu8ff30SMtcEJnVtzX?=
 =?us-ascii?Q?LIfq4Kzl0oK2QOj6Cxt6HXcep9GGa8ZUIrIzat0QWwAKvUINQDVX5AFO2icY?=
 =?us-ascii?Q?bogRzhsfhfpwyoU5CT/VlskJq6/fB7R3YVYX0qsLwNKryTvboP8j0WE84FMf?=
 =?us-ascii?Q?/Iy4T+5hVzCak5DNvTCMMS3UM3Z8JWlDZzbIh8GYjDMCHr6Wui6Uwq7Fx9B6?=
 =?us-ascii?Q?CgVGl/I2P2akH1uf/87GbMc+xdafmsoBk51hYHn3pGQjQ/o310Qjuidst6ig?=
 =?us-ascii?Q?gqJhlzUYed7R9RrZ+IH2ulkIMmhRVLcEBekrr49hpWEPcqZ4DaMmVhKAs9M/?=
 =?us-ascii?Q?SUuY/agVMSZ2mF5qsZWlA2MPZLNC7GbpNTdCDyvqfGDBYCPey+pG6PX620O2?=
 =?us-ascii?Q?iMcn9XM7zIN3dKEKZtH5TH3MkfyE8M0RFJGr7MPWDTcLZqPkxySEUWNvV4Iy?=
 =?us-ascii?Q?no64iiHNZVdmDO8K30WiE54cUcrbILfVLBVlp5Az1Avekaysa01iLULgJCi8?=
 =?us-ascii?Q?B5Dav5koAO37kZQ+zWHg/EseGWeoyicf6a3DOvgkFKO5/9vEmx7rZBtpzhN9?=
 =?us-ascii?Q?vQ6TMm0AigNgxe75JL8d2E7iktYmKEAfsInOIWHKBGlvkhaSIf7HfLVmZfLK?=
 =?us-ascii?Q?4TwWzo/k8PeQQspLg+A9Fe6CY1Xf+GIIhF2MZ7YWLBf/e/09y8ozcuxfXXBa?=
 =?us-ascii?Q?BYS8SC4QdjKTQMCJ2/vquX1N8Hnez8+fMNB/2N3hhVigTjXTjQmFw/h6DNU4?=
 =?us-ascii?Q?SiQ1sd2xOY7Dsi6YvzwOCjrJv/0CdZK1kbVYdfUG3vSoURfWMbYjc/v4zcMo?=
 =?us-ascii?Q?RLFBvGdTRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84839460-ade2-482d-7727-08da4210f0f8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:49:35.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps1WmfDWN/gJ/M5WLeOGaEjasnaXOuTuBHrfx3rpEbTyFqsQ7HGwo4R/3G/KwNNrWdm1RtpPrF3660qU6y0f2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware can support any image size WxH,
with arbitrary W (image width) and H (image height) dimensions.

Align upwards buffer size for both encoder and decoder.
and leave the picture resolution unchanged.

For decoder, the risk of memory out of bounds can be avoided.
For both encoder and decoder, the driver will lift the limitation of
resolution alignment.

For example, the decoder can support jpeg whose resolution is 227x149
the encoder can support nv12 1080P, won't change it to 1920x1072.

Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
- add Fixes tag
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 88 ++++++++-----------
 1 file changed, 37 insertions(+), 51 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index c0fd030d0f19..9a1c8df522ed 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -894,8 +894,8 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	jpeg->slot_data[slot].cfg_stream_size =
 			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
 						  q_data->fmt->fourcc,
-						  q_data->w_adjusted,
-						  q_data->h_adjusted);
+						  q_data->w,
+						  q_data->h);
 
 	/* chain the config descriptor with the encoding descriptor */
 	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
@@ -977,7 +977,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 				      &q_data_cap->h_adjusted,
 				      q_data_cap->h_adjusted, /* adjust up */
 				      MXC_JPEG_MAX_HEIGHT,
-				      q_data_cap->fmt->v_align,
+				      0,
 				      0);
 
 		/* setup bytesperline/sizeimage for capture queue */
@@ -1161,18 +1161,30 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 {
 	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(q);
 	struct mxc_jpeg_q_data *q_data = NULL;
+	struct mxc_jpeg_q_data tmp_q;
 	int i;
 
 	q_data = mxc_jpeg_get_q_data(ctx, q->type);
 	if (!q_data)
 		return -EINVAL;
 
+	tmp_q.fmt = q_data->fmt;
+	tmp_q.w = q_data->w_adjusted;
+	tmp_q.h = q_data->h_adjusted;
+	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++) {
+		tmp_q.bytesperline[i] = q_data->bytesperline[i];
+		tmp_q.sizeimage[i] = q_data->sizeimage[i];
+	}
+	mxc_jpeg_sizeimage(&tmp_q);
+	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++)
+		tmp_q.sizeimage[i] = max(tmp_q.sizeimage[i], q_data->sizeimage[i]);
+
 	/* Handle CREATE_BUFS situation - *nplanes != 0 */
 	if (*nplanes) {
 		if (*nplanes != q_data->fmt->colplanes)
 			return -EINVAL;
 		for (i = 0; i < *nplanes; i++) {
-			if (sizes[i] < q_data->sizeimage[i])
+			if (sizes[i] < tmp_q.sizeimage[i])
 				return -EINVAL;
 		}
 		return 0;
@@ -1181,7 +1193,7 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 	/* Handle REQBUFS situation */
 	*nplanes = q_data->fmt->colplanes;
 	for (i = 0; i < *nplanes; i++)
-		sizes[i] = q_data->sizeimage[i];
+		sizes[i] = tmp_q.sizeimage[i];
 
 	return 0;
 }
@@ -1381,11 +1393,6 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 	}
 	q_data_out->w = header.frame.width;
 	q_data_out->h = header.frame.height;
-	if (header.frame.width % 8 != 0 || header.frame.height % 8 != 0) {
-		dev_err(dev, "JPEG width or height not multiple of 8: %dx%d\n",
-			header.frame.width, header.frame.height);
-		return -EINVAL;
-	}
 	if (header.frame.width > MXC_JPEG_MAX_WIDTH ||
 	    header.frame.height > MXC_JPEG_MAX_HEIGHT) {
 		dev_err(dev, "JPEG width or height should be <= 8192: %dx%d\n",
@@ -1748,22 +1755,17 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fm
 	pix_mp->num_planes = fmt->colplanes;
 	pix_mp->pixelformat = fmt->fourcc;
 
-	/*
-	 * use MXC_JPEG_H_ALIGN instead of fmt->v_align, for vertical
-	 * alignment, to loosen up the alignment to multiple of 8,
-	 * otherwise NV12-1080p fails as 1080 is not a multiple of 16
-	 */
+	pix_mp->width = w;
+	pix_mp->height = h;
 	v4l_bound_align_image(&w,
-			      MXC_JPEG_MIN_WIDTH,
-			      w, /* adjust downwards*/
+			      w, /* adjust upwards*/
+			      MXC_JPEG_MAX_WIDTH,
 			      fmt->h_align,
 			      &h,
-			      MXC_JPEG_MIN_HEIGHT,
-			      h, /* adjust downwards*/
-			      MXC_JPEG_H_ALIGN,
+			      h, /* adjust upwards*/
+			      MXC_JPEG_MAX_HEIGHT,
+			      0,
 			      0);
-	pix_mp->width = w; /* negotiate the width */
-	pix_mp->height = h; /* negotiate the height */
 
 	/* get user input into the tmp_q */
 	tmp_q.w = w;
@@ -1889,35 +1891,19 @@ static int mxc_jpeg_s_fmt(struct mxc_jpeg_ctx *ctx,
 
 	q_data->w_adjusted = q_data->w;
 	q_data->h_adjusted = q_data->h;
-	if (jpeg->mode == MXC_JPEG_DECODE) {
-		/*
-		 * align up the resolution for CAST IP,
-		 * but leave the buffer resolution unchanged
-		 */
-		v4l_bound_align_image(&q_data->w_adjusted,
-				      q_data->w_adjusted,  /* adjust upwards */
-				      MXC_JPEG_MAX_WIDTH,
-				      q_data->fmt->h_align,
-				      &q_data->h_adjusted,
-				      q_data->h_adjusted, /* adjust upwards */
-				      MXC_JPEG_MAX_HEIGHT,
-				      q_data->fmt->v_align,
-				      0);
-	} else {
-		/*
-		 * align down the resolution for CAST IP,
-		 * but leave the buffer resolution unchanged
-		 */
-		v4l_bound_align_image(&q_data->w_adjusted,
-				      MXC_JPEG_MIN_WIDTH,
-				      q_data->w_adjusted, /* adjust downwards*/
-				      q_data->fmt->h_align,
-				      &q_data->h_adjusted,
-				      MXC_JPEG_MIN_HEIGHT,
-				      q_data->h_adjusted, /* adjust downwards*/
-				      q_data->fmt->v_align,
-				      0);
-	}
+	/*
+	 * align up the resolution for CAST IP,
+	 * but leave the buffer resolution unchanged
+	 */
+	v4l_bound_align_image(&q_data->w_adjusted,
+			      q_data->w_adjusted,  /* adjust upwards */
+			      MXC_JPEG_MAX_WIDTH,
+			      q_data->fmt->h_align,
+			      &q_data->h_adjusted,
+			      q_data->h_adjusted, /* adjust upwards */
+			      MXC_JPEG_MAX_HEIGHT,
+			      q_data->fmt->v_align,
+			      0);
 
 	for (i = 0; i < pix_mp->num_planes; i++) {
 		q_data->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
-- 
2.36.1

