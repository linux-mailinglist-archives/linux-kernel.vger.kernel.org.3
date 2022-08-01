Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1421586783
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiHAKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiHAK35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:29:57 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30058.outbound.protection.outlook.com [40.107.3.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345AF19C10;
        Mon,  1 Aug 2022 03:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdJNOxwivEt3zW1b2iJPAsbgJDFb5NTPCOTUGRZMlGbiUcU5Edh4PBrKspoDK91D5fu0iVeJHjAXrm5+hcskultWBLgU7C0MNXdQuOg+au71+JES6qsJs2mf91HJzj+4xdmRBOaCxXuT3IizjnIQw0yZFDQi64NiSwlDUvvzYxK4jZ6+TpjJrrWzCwATJ4AGcdzRoCsemhcDH/lJPsLDL0E2lq4UArNxsFmSL/2ajXvd0hckcE4rXW9g+F5CrV13YMadUn49mElSuO7Wa8LgyiNbw2aqToPL5BrePgGXbiKfySh13F0Y4RH4/IPoZ507oHH8AIQrL11VlSxiziKwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QFtL+nQLfUKlA6tE3J5nqx7NJXFgv3UjgF08LKYyqo=;
 b=i8ACSPzDCSNfLxDXtDJLNT8htOucm4EwknUys2DEeU0+mcnWHv7WCsaGBimRQybntmkcmCY/t6ML/nWbUcMPasK78D4ld/kagJPtEBOMJ7wlgTEwjfn8hC1BFA/IkWkG2hMtU07XqDMNG+BVuq9cHA4ffjNer6BpophQJuH6NORHvA4cDkzr9bFR8feDUKC3ll6+Bu30fgS4n2b1lV9DwL5fflz8tuWB5ipLB8gh9gVylS2NiiaXRxbLYubxIP1IoWwqeOZHKTFEGCnXwWsIqCcLeuiN4T41EmIoJH4IfMGdCgrTu471CJaJgWWuafpNhqsZ75yG0cALQjWc/hUvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QFtL+nQLfUKlA6tE3J5nqx7NJXFgv3UjgF08LKYyqo=;
 b=Hh4Ej4kh/hjVc+ujaqAy/E9d1V3BGdUAsyDSXm7tgNxZ/oghx7rfa2Pt43CzUqpjqWT4mhDYI2DaTThO9pIVOTbeqGl8VZGHHGEyzEvqDX65f9CMtKZbzC5TbWFWlLFpMdUuDjWjJgHyIZ8QCD6I8yjtQKrFYV6PEFvSsQ3QPzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6715.eurprd04.prod.outlook.com (2603:10a6:10:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 10:29:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5482.014; Mon, 1 Aug 2022
 10:29:48 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] media: imx-jpeg: Implement g_selection and s_selection
Date:   Mon,  1 Aug 2022 18:29:09 +0800
Message-Id: <4dc6db09e35ee1cfd05d548607f8a79ab5bb0ec4.1659349092.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659349092.git.ming.qian@nxp.com>
References: <cover.1659349092.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9e8774b-03b9-4dba-d28a-08da73a8c25f
X-MS-TrafficTypeDiagnostic: DB8PR04MB6715:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNgYmZuaMT7vP5RyFaBIusaS9FGPJx/7BYTj1sRj19ufNaSSeQJqwzwu9FuLAoSDmfgGbHwKiPtevtkFGOc6xYR9ZUwoKBMH/pVOqyAsaJZlc69K0K13PiP8RDXsJP3n6etkOyhCW3odoK+5cbLq8E/hTwSt59REU3wVpMhfgrwZKL8DLgPT/xl5v9HokQVk0j2Py68/hybZcTQH7ddreAg4rIXQfeqZfQ3GuWI9bVOi0og8dm+YK0g/RgL0aCsBrrlo8gc3nxpi++XMIYDl9VGRxXaiMnhbeVZ6K1zLTpB1mF5DjpuhGdcHV3OU9BR5gQ23dPYp2sIBxldrJD9xNU0ulWJ74Sd0H4AWy9ZK0gfun0LH52tOpS8Xn9IGHsP3NpGxh27C9bKb/BW5GihsgX/MjbRl6SsCGG2fGmS041ugN80cwIBUnyn6nCmw3BYrzutj5AGKpxrA5EUdountC+w+P3GNrt2+HM9hY5j3WFr2IsDtUzAUXWQDoWtiwGzCSjEI3Qz92e/U2iIlj2I4MJZFzJtQFy0EybPLfKIUnG9iuLOSMTzqZdSZeI6dghuSLFt9lirrwJlaGJ7hSGXvbtmhRUIcwLcSnpp/xQqd3zVUMnnnBVp4DW+SRNX18ajpdCBZzwDEClMnmMIeiSnWTvJBpcb4t97U0PFmrKJgjKMK8aOPTQnn+EfIQZSJ4qfzG4sEFXm2Yk0QiGxTwYieDISkBm0ZXMYLAbZXX8+YEHgn3FUPDsVrth9VYjzRnZZctCpwu3HNLwmJQkBqWGuV46Ifrt9mBJ+vtFMEMkTQRRn4G6IQKCSJjO6Joh02w16D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(36756003)(2906002)(7416002)(30864003)(44832011)(5660300002)(8936002)(66946007)(66556008)(66476007)(8676002)(4326008)(41300700001)(316002)(478600001)(6506007)(6486002)(52116002)(6666004)(6512007)(26005)(38350700002)(86362001)(38100700002)(83380400001)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JZjvxmEWVaiafnLsyEbuK/DG1zkwez2EmwfXrCqbAbg+KU5a7LDPqFE1TWuY?=
 =?us-ascii?Q?NLZTaajS48ZDHK+GCM+oHKo4suiVAFysS07S4kEY8zUj+w/4YSzsa0QXpZsy?=
 =?us-ascii?Q?Kl9w2vrUfP9BUUaysIrpS8B/wJ+Oi0zepZ5JNB7SSe2/5L5+Rnp+Sf1S4zUN?=
 =?us-ascii?Q?EI4N1YsbvUkiY8zdb5Pxyqf8QydHftuckO4yKQO0gDrzV4bs1OgC6qrdCE+b?=
 =?us-ascii?Q?mGHhVrB8PiQapEfJtGDc1N4HsiOpRMnLJmJ1G8eWkkfUB/nplCF4WFNvHVGp?=
 =?us-ascii?Q?UdyGRLKTvS/trDoS+hSMVuRhtVEZXYoTWvzpduFFZYdY3u/5LI5GdHDFxWqz?=
 =?us-ascii?Q?4cHhwRILRN8GLRUrbMRihwKyNR4qd1RNd8DaXSZ/G2VG+Om2BSXLGbjrgMi6?=
 =?us-ascii?Q?s2u/7V2wsVx5OEQPvD2d7abiBr+3/+BjiqXtZHz1eZZit+JLRM7agkiuBAne?=
 =?us-ascii?Q?77X4ZPqEu4FSWUzNrn2NsrEzqZqIUEdLgf9I/8DzKxIskExTTTbnDlmu1XiL?=
 =?us-ascii?Q?qTO6bBoTSx0y5edB+wkkemI/GOmmVN+UBPtCi1HTy94CtOVoGLSiflnQ7H+D?=
 =?us-ascii?Q?N9RJjP1IYiPgn0hdR8OADvG/p2Wf1JyjoDDwI7mXIHA28eqk2gqgSX/MXUuV?=
 =?us-ascii?Q?GycjMXdaWTwYqtTq9sn26qTCimoRwO0dxI+2qvVFgwVrNkdGGDmQyEyJPg6+?=
 =?us-ascii?Q?4uLlGRq1wyVwClmEalwgjYUHQgUNplYy9TrtzTFfbL2R2ymuR6xXWfyh7ZJ3?=
 =?us-ascii?Q?xqWuCXELeprqLU46bKXh0JEqlyzXOk1wNSrYuH2npdSsOEVva+yRyPtcNbpI?=
 =?us-ascii?Q?3wNr3OKkrvJ6hImW1Rs/7rS6Xw9Wk1e6s3lclcnsqLS9bKZMrP5Ye9O1WxTA?=
 =?us-ascii?Q?5thoJbXg76m+8HGdKGV212W0c+ofu20A9yEsYD+n0NqKWXXVNuIDPRJuAsf8?=
 =?us-ascii?Q?Y66W3jQmR2X5KaRGmpocCc0ITHXyTNn4W9fXzHC1NljS1r249ARv6JmimZR1?=
 =?us-ascii?Q?jePVDcYVhQZr/2D42cb1zOgzlfc67wr+PH9HBPjHSVaVn6NzenJqKRbbStGq?=
 =?us-ascii?Q?LODRDR0d8cKFYF47UTqxMpn622xi5hbakL01W4bIZF8nH5HHgf4L5Ceuzi3g?=
 =?us-ascii?Q?99PVSMjJG1nADUUAA/26lrJ8fVWbIwVe8NGY4I0z8yJcWUQgE2bP1g+n3DkJ?=
 =?us-ascii?Q?ZCqPKZSGCUEijAJE9mdBDu6CdWfQEffbMJ6IvFbR4hnqB+uu8WFv95Jlt8Bu?=
 =?us-ascii?Q?B1ED4eNj2QHU2jmAlUh6hRws7E+COQ2RScBpI99Um/ZBqIl0ielMvrtUYwMU?=
 =?us-ascii?Q?Mx+SSWURLLGcvo2VqYRw25580oG2equ0pqgnEaQG77gKg+/WnMz4dpB+guIv?=
 =?us-ascii?Q?Q5CUMTqwqEOVhibn175qcX4CzoUKpZUKVDORHaxRVtZpOkFbp/Xge6cG0LGU?=
 =?us-ascii?Q?RZY2TaM66KE/kbT4VgTgEWf7/eE/xKfqKPbvr0iDqgNoYdY1joE8Ouae7cP0?=
 =?us-ascii?Q?fpvSwE6O146ls+FbWAsJvwyUWk4BL76bMX0bkGblgSXJqtmh2xrPszvUb0kM?=
 =?us-ascii?Q?7u+INBzUj7Wzht4MP1tw+kTR6/n8/Y9VLOzDfAS2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e8774b-03b9-4dba-d28a-08da73a8c25f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:29:48.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVR5L570CVAssN/ORrjKNr+FUT/u+9xCf1vcS+oS6w/QWUgN8mFTPXWMImDkcwJ0W7XKDMLfq3BAqpRt+NMYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6715
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codec can support any image size WxH,
with arbitrary W (image width) and H (image height) dimensions.

But it requires buffer alignment,
so driver can report the aligned resolution through the g_fmt,
and report the actual resolution through the g_selection.

For encoder, it even support to encode a smaller jpeg
than the original picture through s_selection api.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 327 +++++++++++-------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   1 +
 2 files changed, 208 insertions(+), 120 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index ec13394bdddd..89f432b8c6df 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -924,8 +924,8 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	jpeg->slot_data[slot].cfg_stream_size =
 			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
 						  q_data->fmt->fourcc,
-						  q_data->w,
-						  q_data->h);
+						  q_data->crop.width,
+						  q_data->crop.height);
 
 	/* chain the config descriptor with the encoding descriptor */
 	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
@@ -942,11 +942,13 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	desc->next_descpt_ptr = 0; /* end of chain */
 
 	/* use adjusted resolution for CAST IP job */
-	w = q_data->w_adjusted;
-	h = q_data->h_adjusted;
+	w = q_data->crop.width;
+	h = q_data->crop.height;
+	v4l_bound_align_image(&w, w, MXC_JPEG_MAX_WIDTH, q_data->fmt->h_align,
+			      &h, h, MXC_JPEG_MAX_HEIGHT, q_data->fmt->v_align, 0);
 	mxc_jpeg_set_res(desc, w, h);
-	mxc_jpeg_set_line_pitch(desc, w * (q_data->fmt->depth / 8));
-	mxc_jpeg_set_bufsize(desc, desc->line_pitch * h);
+	mxc_jpeg_set_line_pitch(desc, q_data->bytesperline[0]);
+	mxc_jpeg_set_bufsize(desc, q_data->sizeimage[0]);
 	img_fmt = mxc_jpeg_fourcc_to_imgfmt(q_data->fmt->fourcc);
 	if (img_fmt == MXC_JPEG_INVALID)
 		dev_err(jpeg->dev, "No valid image format detected\n");
@@ -995,6 +997,10 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		q_data_cap->fmt = jpeg_src_buf->fmt;
 		q_data_cap->w_adjusted = q_data_cap->w;
 		q_data_cap->h_adjusted = q_data_cap->h;
+		q_data_cap->crop.left = 0;
+		q_data_cap->crop.top = 0;
+		q_data_cap->crop.width = jpeg_src_buf->w;
+		q_data_cap->crop.height = jpeg_src_buf->h;
 
 		/*
 		 * align up the resolution for CAST IP,
@@ -1007,7 +1013,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 				      &q_data_cap->h_adjusted,
 				      q_data_cap->h_adjusted, /* adjust up */
 				      MXC_JPEG_MAX_HEIGHT,
-				      0,
+				      q_data_cap->fmt->v_align,
 				      0);
 
 		/* setup bytesperline/sizeimage for capture queue */
@@ -1016,6 +1022,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		notify_src_chg(ctx);
 		ctx->source_change = 1;
 	}
+
 	return ctx->source_change ? true : false;
 }
 
@@ -1201,30 +1208,18 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 {
 	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(q);
 	struct mxc_jpeg_q_data *q_data = NULL;
-	struct mxc_jpeg_q_data tmp_q;
 	int i;
 
 	q_data = mxc_jpeg_get_q_data(ctx, q->type);
 	if (!q_data)
 		return -EINVAL;
 
-	tmp_q.fmt = q_data->fmt;
-	tmp_q.w = q_data->w_adjusted;
-	tmp_q.h = q_data->h_adjusted;
-	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++) {
-		tmp_q.bytesperline[i] = q_data->bytesperline[i];
-		tmp_q.sizeimage[i] = q_data->sizeimage[i];
-	}
-	mxc_jpeg_sizeimage(&tmp_q);
-	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++)
-		tmp_q.sizeimage[i] = max(tmp_q.sizeimage[i], q_data->sizeimage[i]);
-
 	/* Handle CREATE_BUFS situation - *nplanes != 0 */
 	if (*nplanes) {
 		if (*nplanes != q_data->fmt->colplanes)
 			return -EINVAL;
 		for (i = 0; i < *nplanes; i++) {
-			if (sizes[i] < tmp_q.sizeimage[i])
+			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
 		}
 		return 0;
@@ -1233,7 +1228,7 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 	/* Handle REQBUFS situation */
 	*nplanes = q_data->fmt->colplanes;
 	for (i = 0; i < *nplanes; i++)
-		sizes[i] = tmp_q.sizeimage[i];
+		sizes[i] = q_data->sizeimage[i];
 
 	return 0;
 }
@@ -1366,17 +1361,17 @@ static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
 		 * applies to the first plane and is divided by the same factor
 		 * as the width field for the other planes
 		 */
-		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8);
+		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8);
 		q->bytesperline[1] = q->bytesperline[0];
 	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_422) {
-		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8) * 2;
+		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8) * 2;
 		q->bytesperline[1] = 0;
 	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_444) {
-		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8) * q->fmt->nc;
+		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8) * q->fmt->nc;
 		q->bytesperline[1] = 0;
 	} else {
 		/* grayscale */
-		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8);
+		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8);
 		q->bytesperline[1] = 0;
 	}
 }
@@ -1395,7 +1390,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
 		/* jpeg stream size must be multiple of 1K */
 		q->sizeimage[0] = ALIGN(q->sizeimage[0], 1024);
 	} else {
-		q->sizeimage[0] = q->bytesperline[0] * q->h;
+		q->sizeimage[0] = q->bytesperline[0] * q->h_adjusted;
 		q->sizeimage[1] = 0;
 		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M)
 			q->sizeimage[1] = q->sizeimage[0] / 2;
@@ -1619,6 +1614,10 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
 		q[i]->h = MXC_JPEG_DEFAULT_HEIGHT;
 		q[i]->w_adjusted = MXC_JPEG_DEFAULT_WIDTH;
 		q[i]->h_adjusted = MXC_JPEG_DEFAULT_HEIGHT;
+		q[i]->crop.left = 0;
+		q[i]->crop.top = 0;
+		q[i]->crop.width = MXC_JPEG_DEFAULT_WIDTH;
+		q[i]->crop.height = MXC_JPEG_DEFAULT_HEIGHT;
 		mxc_jpeg_bytesperline(q[i], q[i]->fmt->precision);
 		mxc_jpeg_sizeimage(q[i]);
 	}
@@ -1786,55 +1785,84 @@ static int mxc_jpeg_enum_fmt_vid_out(struct file *file, void *priv,
 	return 0;
 }
 
-static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fmt,
-			    struct mxc_jpeg_ctx *ctx, int q_type)
+static u32 mxc_jpeg_get_fmt_type(struct mxc_jpeg_ctx *ctx, u32 type)
+{
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
+		return V4L2_TYPE_IS_OUTPUT(type) ? MXC_JPEG_FMT_TYPE_ENC : MXC_JPEG_FMT_TYPE_RAW;
+	else
+		return V4L2_TYPE_IS_CAPTURE(type) ? MXC_JPEG_FMT_TYPE_ENC : MXC_JPEG_FMT_TYPE_RAW;
+}
+
+static u32 mxc_jpeg_get_default_fourcc(struct mxc_jpeg_ctx *ctx, u32 type)
 {
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
+		return V4L2_TYPE_IS_OUTPUT(type) ? V4L2_PIX_FMT_JPEG : MXC_JPEG_DEFAULT_PFMT;
+	else
+		return V4L2_TYPE_IS_CAPTURE(type) ? V4L2_PIX_FMT_JPEG : MXC_JPEG_DEFAULT_PFMT;
+}
+
+static int mxc_jpeg_try_fmt(struct v4l2_format *f,
+			    struct mxc_jpeg_ctx *ctx, struct mxc_jpeg_q_data *q_data)
+{
+	const struct mxc_jpeg_fmt *fmt;
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct v4l2_plane_pix_format *pfmt;
+	u32 fourcc = f->fmt.pix_mp.pixelformat;
 	u32 w = (pix_mp->width < MXC_JPEG_MAX_WIDTH) ?
 		 pix_mp->width : MXC_JPEG_MAX_WIDTH;
 	u32 h = (pix_mp->height < MXC_JPEG_MAX_HEIGHT) ?
 		 pix_mp->height : MXC_JPEG_MAX_HEIGHT;
 	int i;
-	struct mxc_jpeg_q_data tmp_q;
+
+	fmt = mxc_jpeg_find_format(ctx, fourcc);
+	if (!fmt || fmt->flags != mxc_jpeg_get_fmt_type(ctx, f->type)) {
+		dev_warn(ctx->mxc_jpeg->dev, "Format not supported: %c%c%c%c, use the default.\n",
+			 (fourcc & 0xff),
+			 (fourcc >>  8) & 0xff,
+			 (fourcc >> 16) & 0xff,
+			 (fourcc >> 24) & 0xff);
+		fourcc = mxc_jpeg_get_default_fourcc(ctx, f->type);
+		fmt = mxc_jpeg_find_format(ctx, fourcc);
+		if (!fmt)
+			return -EINVAL;
+		f->fmt.pix_mp.pixelformat = fourcc;
+	}
+	q_data->fmt = fmt;
 
 	memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
 	pix_mp->field = V4L2_FIELD_NONE;
 	pix_mp->num_planes = fmt->colplanes;
 	pix_mp->pixelformat = fmt->fourcc;
 
-	pix_mp->width = w;
-	pix_mp->height = h;
-	v4l_bound_align_image(&w,
+	q_data->w = w;
+	q_data->h = h;
+	q_data->w_adjusted = w;
+	q_data->h_adjusted = h;
+	v4l_bound_align_image(&q_data->w_adjusted,
 			      w, /* adjust upwards*/
 			      MXC_JPEG_MAX_WIDTH,
 			      fmt->h_align,
-			      &h,
+			      &q_data->h_adjusted,
 			      h, /* adjust upwards*/
 			      MXC_JPEG_MAX_HEIGHT,
-			      0,
+			      fmt->v_align,
 			      0);
-
-	/* get user input into the tmp_q */
-	tmp_q.w = w;
-	tmp_q.h = h;
-	tmp_q.fmt = fmt;
 	for (i = 0; i < pix_mp->num_planes; i++) {
 		pfmt = &pix_mp->plane_fmt[i];
-		tmp_q.bytesperline[i] = pfmt->bytesperline;
-		tmp_q.sizeimage[i] = pfmt->sizeimage;
+		q_data->bytesperline[i] = pfmt->bytesperline;
+		q_data->sizeimage[i] = pfmt->sizeimage;
 	}
 
-	/* calculate bytesperline & sizeimage into the tmp_q */
-	mxc_jpeg_bytesperline(&tmp_q, fmt->precision);
-	mxc_jpeg_sizeimage(&tmp_q);
+	/* calculate bytesperline & sizeimage */
+	mxc_jpeg_bytesperline(q_data, fmt->precision);
+	mxc_jpeg_sizeimage(q_data);
 
 	/* adjust user format according to our calculations */
 	for (i = 0; i < pix_mp->num_planes; i++) {
 		pfmt = &pix_mp->plane_fmt[i];
 		memset(pfmt->reserved, 0, sizeof(pfmt->reserved));
-		pfmt->bytesperline = tmp_q.bytesperline[i];
-		pfmt->sizeimage = tmp_q.sizeimage[i];
+		pfmt->bytesperline = q_data->bytesperline[i];
+		pfmt->sizeimage = q_data->sizeimage[i];
 	}
 
 	/* fix colorspace information to sRGB for both output & capture */
@@ -1848,6 +1876,16 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fm
 	 */
 	pix_mp->quantization = V4L2_QUANTIZATION_FULL_RANGE;
 
+	if (fmt->flags == MXC_JPEG_FMT_TYPE_RAW) {
+		q_data->crop.left = 0;
+		q_data->crop.top = 0;
+		q_data->crop.width = q_data->w;
+		q_data->crop.height = q_data->h;
+	}
+
+	pix_mp->width = q_data->w_adjusted;
+	pix_mp->height = q_data->h_adjusted;
+
 	return 0;
 }
 
@@ -1857,29 +1895,14 @@ static int mxc_jpeg_try_fmt_vid_cap(struct file *file, void *priv,
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	struct device *dev = jpeg->dev;
-	const struct mxc_jpeg_fmt *fmt;
-	u32 fourcc = f->fmt.pix_mp.pixelformat;
-
-	int q_type = (jpeg->mode == MXC_JPEG_DECODE) ?
-		     MXC_JPEG_FMT_TYPE_RAW : MXC_JPEG_FMT_TYPE_ENC;
+	struct mxc_jpeg_q_data tmp_q;
 
 	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type)) {
 		dev_err(dev, "TRY_FMT with Invalid type: %d\n", f->type);
 		return -EINVAL;
 	}
 
-	fmt = mxc_jpeg_find_format(ctx, fourcc);
-	if (!fmt || fmt->flags != q_type) {
-		dev_warn(dev, "Format not supported: %c%c%c%c, use the default.\n",
-			 (fourcc & 0xff),
-			 (fourcc >>  8) & 0xff,
-			 (fourcc >> 16) & 0xff,
-			 (fourcc >> 24) & 0xff);
-		f->fmt.pix_mp.pixelformat = (jpeg->mode == MXC_JPEG_DECODE) ?
-				MXC_JPEG_DEFAULT_PFMT : V4L2_PIX_FMT_JPEG;
-		fmt = mxc_jpeg_find_format(ctx, f->fmt.pix_mp.pixelformat);
-	}
-	return mxc_jpeg_try_fmt(f, fmt, ctx, q_type);
+	return mxc_jpeg_try_fmt(f, ctx, &tmp_q);
 }
 
 static int mxc_jpeg_try_fmt_vid_out(struct file *file, void *priv,
@@ -1888,88 +1911,55 @@ static int mxc_jpeg_try_fmt_vid_out(struct file *file, void *priv,
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	struct device *dev = jpeg->dev;
-	const struct mxc_jpeg_fmt *fmt;
-	u32 fourcc = f->fmt.pix_mp.pixelformat;
-
-	int q_type = (jpeg->mode == MXC_JPEG_ENCODE) ?
-		     MXC_JPEG_FMT_TYPE_RAW : MXC_JPEG_FMT_TYPE_ENC;
+	struct mxc_jpeg_q_data tmp_q;
 
 	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type)) {
 		dev_err(dev, "TRY_FMT with Invalid type: %d\n", f->type);
 		return -EINVAL;
 	}
 
-	fmt = mxc_jpeg_find_format(ctx, fourcc);
-	if (!fmt || fmt->flags != q_type) {
-		dev_warn(dev, "Format not supported: %c%c%c%c, use the default.\n",
-			 (fourcc & 0xff),
-			 (fourcc >>  8) & 0xff,
-			 (fourcc >> 16) & 0xff,
-			 (fourcc >> 24) & 0xff);
-		f->fmt.pix_mp.pixelformat = (jpeg->mode == MXC_JPEG_ENCODE) ?
-				MXC_JPEG_DEFAULT_PFMT : V4L2_PIX_FMT_JPEG;
-		fmt = mxc_jpeg_find_format(ctx, f->fmt.pix_mp.pixelformat);
-	}
-	return mxc_jpeg_try_fmt(f, fmt, ctx, q_type);
+	return mxc_jpeg_try_fmt(f, ctx, &tmp_q);
+}
+
+static void mxc_jpeg_s_parsed_fmt(struct mxc_jpeg_ctx *ctx, struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
+	struct mxc_jpeg_q_data *q_data_cap;
+
+	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE || !V4L2_TYPE_IS_CAPTURE(f->type))
+		return;
+	if (!ctx->header_parsed)
+		return;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, f->type);
+	pix_mp->pixelformat = pix_mp->pixelformat;
+	pix_mp->width = q_data_cap->w;
+	pix_mp->height = q_data_cap->h;
 }
 
 static int mxc_jpeg_s_fmt(struct mxc_jpeg_ctx *ctx,
 			  struct v4l2_format *f)
 {
 	struct vb2_queue *vq;
-	struct mxc_jpeg_q_data *q_data = NULL;
-	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
-	int i;
 
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
 	if (!vq)
 		return -EINVAL;
 
-	q_data = mxc_jpeg_get_q_data(ctx, f->type);
-
 	if (vb2_is_busy(vq)) {
 		v4l2_err(&jpeg->v4l2_dev, "queue busy\n");
 		return -EBUSY;
 	}
 
-	q_data->fmt = mxc_jpeg_find_format(ctx, pix_mp->pixelformat);
-	q_data->w = pix_mp->width;
-	q_data->h = pix_mp->height;
-
-	q_data->w_adjusted = q_data->w;
-	q_data->h_adjusted = q_data->h;
-	/*
-	 * align up the resolution for CAST IP,
-	 * but leave the buffer resolution unchanged
-	 */
-	v4l_bound_align_image(&q_data->w_adjusted,
-			      q_data->w_adjusted,  /* adjust upwards */
-			      MXC_JPEG_MAX_WIDTH,
-			      q_data->fmt->h_align,
-			      &q_data->h_adjusted,
-			      q_data->h_adjusted, /* adjust upwards */
-			      MXC_JPEG_MAX_HEIGHT,
-			      q_data->fmt->v_align,
-			      0);
-
-	for (i = 0; i < pix_mp->num_planes; i++) {
-		q_data->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
-		q_data->sizeimage[i] = pix_mp->plane_fmt[i].sizeimage;
-	}
+	mxc_jpeg_s_parsed_fmt(ctx, f);
 
-	return 0;
+	return mxc_jpeg_try_fmt(f, ctx, mxc_jpeg_get_q_data(ctx, f->type));
 }
 
 static int mxc_jpeg_s_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	int ret;
-
-	ret = mxc_jpeg_try_fmt_vid_cap(file, priv, f);
-	if (ret)
-		return ret;
-
 	return mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
 }
 
@@ -1983,10 +1973,6 @@ static int mxc_jpeg_s_fmt_vid_out(struct file *file, void *priv,
 	enum v4l2_buf_type cap_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	struct v4l2_format fc;
 
-	ret = mxc_jpeg_try_fmt_vid_out(file, priv, f);
-	if (ret)
-		return ret;
-
 	ret = mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
 	if (ret)
 		return ret;
@@ -2032,6 +2018,10 @@ static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
 	pix_mp->width = q_data->w;
 	pix_mp->height = q_data->h;
 	pix_mp->field = V4L2_FIELD_NONE;
+	if (q_data->fmt->flags == MXC_JPEG_FMT_TYPE_RAW) {
+		pix_mp->width = q_data->w_adjusted;
+		pix_mp->height = q_data->h_adjusted;
+	}
 
 	/* fix colorspace information to sRGB for both output & capture */
 	pix_mp->colorspace = V4L2_COLORSPACE_SRGB;
@@ -2048,6 +2038,100 @@ static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
 	return 0;
 }
 
+static int mxc_jpeg_dec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+	struct mxc_jpeg_q_data *q_data_cap;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE && s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, s->type);
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_COMPOSE:
+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+	case V4L2_SEL_TGT_COMPOSE_PADDED:
+		s->r = q_data_cap->crop;
+		break;
+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = q_data_cap->w_adjusted;
+		s->r.height = q_data_cap->h_adjusted;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mxc_jpeg_enc_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+	struct mxc_jpeg_q_data *q_data_out;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
+	q_data_out = mxc_jpeg_get_q_data(ctx, s->type);
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = q_data_out->w;
+		s->r.height = q_data_out->h;
+		break;
+	case V4L2_SEL_TGT_CROP:
+		s->r = q_data_out->crop;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mxc_jpeg_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
+		return mxc_jpeg_dec_g_selection(file, fh, s);
+	else
+		return mxc_jpeg_enc_g_selection(file, fh, s);
+}
+
+static int mxc_jpeg_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+	struct mxc_jpeg_q_data *q_data_out;
+
+	if (ctx->mxc_jpeg->mode != MXC_JPEG_ENCODE)
+		return -ENOTTY;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+	if (s->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	q_data_out = mxc_jpeg_get_q_data(ctx, s->type);
+	if (s->r.left || s->r.top)
+		return -EINVAL;
+	if (s->r.width > q_data_out->w || s->r.height > q_data_out->h)
+		return -EINVAL;
+
+	q_data_out->crop.left = 0;
+	q_data_out->crop.top = 0;
+	q_data_out->crop.width = s->r.width;
+	q_data_out->crop.height = s->r.height;
+
+	return 0;
+}
+
 static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
 				    const struct v4l2_event_subscription *sub)
 {
@@ -2077,6 +2161,9 @@ static const struct v4l2_ioctl_ops mxc_jpeg_ioctl_ops = {
 	.vidioc_g_fmt_vid_cap_mplane	= mxc_jpeg_g_fmt_vid,
 	.vidioc_g_fmt_vid_out_mplane	= mxc_jpeg_g_fmt_vid,
 
+	.vidioc_g_selection		= mxc_jpeg_g_selection,
+	.vidioc_s_selection		= mxc_jpeg_s_selection,
+
 	.vidioc_subscribe_event		= mxc_jpeg_subscribe_event,
 	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
 
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 8104ee4a3b7a..f75dfc89ff6d 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -84,6 +84,7 @@ struct mxc_jpeg_q_data {
 	int				h;
 	int				h_adjusted;
 	unsigned int			sequence;
+	struct v4l2_rect		crop;
 };
 
 struct mxc_jpeg_ctx {
-- 
2.37.1

