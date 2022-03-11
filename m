Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9484D5CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbiCKHx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347277AbiCKHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:53:44 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25554BB577;
        Thu, 10 Mar 2022 23:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRm44I/AqO9i8oVtGjoAwz2HuHuwAZoKhtckuycJBZhd71WEL09F0m6U1Rw7HNZIHJxcoleGrlOLNN2rWU4aej574zb+tZkJvOXETmx/USo3SlemG2+UaAZyVkymAaqnousF/KQY+qHFDohpCrWzXyg9oTZtFTBOwlAIKyYOGfOXqmUhxY7IviTo4vcC719jdwv/zbm/ktO2JL6gS8QUEJaYFVuJnJawAYbKCQgeoDaUbygv/Tv5URN7nwLvsuia+zRI6FKHnWCfyncntESDb+51gusvS3Wu6+B0fkLEwiohjcm7gTOM8nkZM3DqjLJkE1FoDstlgrL90u4/19Zgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bUeLjEYNurmQmNiZYNV+D5rwdXTOYZz+osKmYIV90w=;
 b=Kg5MoKNn9rL2TRgKWNW7kQ1KSHK9H2ElYHjcRiPCNJ4ZwVld/3BU34Rqp5po99eFq2lW8HydXbi+VADQ4ze4bpstH+oVpw3ovBVr2n/UMDbiymlmsP2FczgIpFYUv2oIRdY8bhuy9dIQ4r7+ApUjmK3OUfxe14qIcKpAUwMVeNhufTqv1eKbYKIJEdukuCRpBMeGDInyMA/IxJ6kiATEC5VjFZwWfVgjTODNgZqWh142d1IMSzBOJNBwoDDB9pVXaMgPdc65vrJdb03rKqe61z+sxX0quokBmlFWecpa97VnZo1dmLKisY2D1He8wj0noeIA9xSC3OZZfy/SssIIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bUeLjEYNurmQmNiZYNV+D5rwdXTOYZz+osKmYIV90w=;
 b=PaiJ9PTGv3shDqUNYwUTVm6yaX0R9c65tbJYzLcltEz0UHBNMEVVtXepYZqL4mFDhGDhojyTIni86AAhUBoKAZOZn2E73Woi/GBB05ZaguVwxOcW/CAoYJ85sGk/y2tgDBc4vAbye2s+uluBygQlzsGIYxaVRwjmkHeHKhyumYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4443.eurprd04.prod.outlook.com (2603:10a6:5:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 07:52:39 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:52:39 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] media: imx-jpeg: Handle source change in a function
Date:   Fri, 11 Mar 2022 15:51:46 +0800
Message-Id: <538ff8ce60241c4a0729f1a518ecf0ee74291cad.1646983646.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1646983646.git.ming.qian@nxp.com>
References: <cover.1646983646.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30850c2e-1e6e-419b-57dd-08da03341d59
X-MS-TrafficTypeDiagnostic: DB7PR04MB4443:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB44431BCB229FFC1554359C4DE70C9@DB7PR04MB4443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+gU6ocIV+wTQVqOW8Ks62vZZwlmllE3GIasfR/y9d/wlb1Aim4oB54VHl66fJab/mRfKKf/gu4Aj0XZnDWflAlNBZ6JJwso2oe9XTvOkT7/Eoullt2XEO1c6gEhIm2KalfJROkss7cmoM/vEKaVKFfBeUU7a3nq456uzsmjAMGYqpCZJBzrKGUbMeX+AsDqqBs2o76teeqsorNklJObweuzJNkUTUdjx//R7qm6ml8YYrdyUPDBwS20kmGgY6dLke0MMpdymNmHtomXig4AZZderMO5tNou2u2CwiVgtFnJ2XcZOfGhvkivAC16fHUWZ5H0pH7tIcGd7kGBMWoiUk9VvRsrPgjGzixDL7G1+ZK8bXmG3j9kUxqgzKdebwlgg8B67NdgKdfabuanAlzOm06dhP3Ahl7xJlyHkLQwPhsV8mjcD93sFFQzbBFPdYd0EyT+zKNflRvR/pSQZPyfSs1OjKZH0haMi6zTXFyNq4Uf0ANMvwxC3ZJVEa8HAYdcWsGivDshDaIl7w1s60ZRH3SyTgPyTS7kgSvAnIcEt/SzVykGD1rBoR8dlXR3AovG2KrYqox+plmNWRxrz6LAMUA/cq/IaXO3idI2X+bq43iw4Xcigg0a204FAF7eEXMILjHZ6dTWLQRdClCiXAXmynbZFuluhXOUx24Rm6wWELHuCJlEJSZ3lAtjA7R6bQ187Lj9rjECtbp3qOLbYJPUWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(26005)(52116002)(44832011)(2906002)(8676002)(6486002)(2616005)(508600001)(86362001)(4326008)(186003)(66946007)(6512007)(6506007)(5660300002)(66556008)(38350700002)(6666004)(38100700002)(66476007)(316002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSUSLUlp6c0ydu3iCkuC/4WxPiVYmJ5KJWB+Z6T5fCKZeJiR+ThR58vdFsAu?=
 =?us-ascii?Q?B36/8t8/XBfA4ZHqXmFm96xvKGnxNzx0UJz4imTmwwd4dvVQJ6v+tgMVv+L9?=
 =?us-ascii?Q?2fqrfJ3C8I6YTlfDaBJGiGLbH4GqoCAkyvjjUrVEgKIgsew71c6cTcR8Bm9q?=
 =?us-ascii?Q?CUZfvUREOMzHccrHclaT1ju8UPsTWpJ878tm3GRKP9Ttlx0ssl/UEeAkL5qG?=
 =?us-ascii?Q?l3JiHNgZydCeiPB026Ppwq5f8Ob1FGTGGdCx5GfKGOhco1JVCms3Er4eB/e1?=
 =?us-ascii?Q?6n9dsoNTdUpV7P8xZFHwR0A8oNQguBG9B8WKkN91KG2mLVQPu2/85FCmBfTD?=
 =?us-ascii?Q?Z09Cs8FqGzF+12ja/GF+nNf49bSfCF4mg4fY4I4uPTAr4Q/DdsdRNP4ZwStu?=
 =?us-ascii?Q?JNyQFos/aVvS33RP2F3pbKQUcodFjEJ/2mAP0To7jZclnS3N7GeqXB/dCfmQ?=
 =?us-ascii?Q?OunXbLj38D9okJ5QynuOHQBddnyGELBp2TfMESjDAhvgoGjeWsJg4JgOwY5y?=
 =?us-ascii?Q?YsPoqqiC4C3CJJr4L8udFu8bRI7PUtY01XUpS6nF9boiRrMQ8rVwKtDYMjL3?=
 =?us-ascii?Q?K067vPSYwMbXnuPLnsXGw2YXj453rlAe2LsmSmPi+Nx7YeQxuhwhDPqUf6hc?=
 =?us-ascii?Q?VO9tFzKUc28z/A+ltT0cLjJvs4B8JC3ZQbA3jVrOidgCmVMzFIdemk6engvN?=
 =?us-ascii?Q?osz/YsJo2b4Y6fi56YjzBIDU1QiNGvBYKblS1IBmmaeolKGi+jgeY0TPl5Zz?=
 =?us-ascii?Q?k8xk5vEK3Q+ajc2ZaiQSQPtJUBHwRbjYMpA3OKtlVHZFNeK8I+LkcGWVUUst?=
 =?us-ascii?Q?adQgUFTMELrpEhemMBSesyhOcmcuIpXMp/Nnw696oGWaBxidiGSyWtWLAU63?=
 =?us-ascii?Q?5NSnt0yejNIbunsviDHErVnBGC3CR8N6snNA0BtAXNbCtqF20S/2Qu+zwsqI?=
 =?us-ascii?Q?/ZkUmBb5TyGUW8OKQVGN98bg6BsFUZHl/hXaNVI95k0QJ2mE7s+9USi8K2Rc?=
 =?us-ascii?Q?Ab2cyGTJAH6oGryQdVXisTbrxACBkzjl5Oc2zp+hTK0Ro8c6U9c/IhL0cTvf?=
 =?us-ascii?Q?FGW60WkzK7BqGZYS1Ib+QiojEpNgmzBbDzAVZHpW6110ebct+k/q/e03ytt/?=
 =?us-ascii?Q?X6IvHeft0nGrZB/IJbQQpr/ZIJW2zrUP6+6qLAckY1WPJpOUHQHEaALVIRmW?=
 =?us-ascii?Q?5fR3tXAF6oT+o4klVyRyz6mEzAkZk/DgW2lGEUlQOjSJ0/ogWV+mmIsbPe7f?=
 =?us-ascii?Q?6yjK/BTw/dER6dfIAD8eFHFpi4PUrtk4TZmK1T39n6LVVb3K7cl42UetyjhG?=
 =?us-ascii?Q?F0hIQHHuq81tz71Vv5rHrHrl7/JcMBf5hyP8FewnACsHNK8eAc4PU3Q4o8vx?=
 =?us-ascii?Q?d41W3+RNvE3ECqhQxhh4LO9vco9OjY4+bAo0jwPz/hMEUIdc4jTscMjZbQZC?=
 =?us-ascii?Q?xT41hLmQNQOxUnXfq31mFhEi81f5dmP3xo2zwcU02QPBIoO0bLOPFQV8Xk66?=
 =?us-ascii?Q?sScbfq/VI8HZ/Lwl65COVklj6gNhncMmqZ4hs7C64MSnczLSJrTVG0gdspPJ?=
 =?us-ascii?Q?8zeLRY8mN0S/D3MMoptJy6SvtYm0+r2Niwl3nOBqXTRVPOeE0rrvbRVNWRgX?=
 =?us-ascii?Q?hlunIP3/TiqUYpLKRZF4iNo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30850c2e-1e6e-419b-57dd-08da03341d59
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:52:39.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phK7j6usU1LQ3yOUbHD2nH32ciBcLJs8PaUD07oj/BsQFTM6TE3CFN9+lGM7GSKHX/jq3sxLiaKnEMgmNbQC1w==
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

Refine code to support dynamic resolution change

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 114 ++++++++++++---------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 9e8a4157ce2f..dbcb83ed86e4 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -315,6 +315,9 @@ struct mxc_jpeg_src_buf {
 	/* mxc-jpeg specific */
 	bool			dht_needed;
 	bool			jpeg_parse_error;
+	const struct mxc_jpeg_fmt	*fmt;
+	int			w;
+	int			h;
 };
 
 static inline struct mxc_jpeg_src_buf *vb2_to_mxc_buf(struct vb2_buffer *vb)
@@ -327,6 +330,9 @@ static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Debug level (0-3)");
 
+static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision);
+static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q);
+
 static void _bswap16(u16 *a)
 {
 	*a = ((*a & 0x00FF) << 8) | ((*a & 0xFF00) >> 8);
@@ -922,6 +928,59 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	mxc_jpeg_set_desc(cfg_desc_handle, reg, slot);
 }
 
+static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
+				   struct mxc_jpeg_src_buf *jpeg_src_buf)
+{
+	struct device *dev = ctx->mxc_jpeg->dev;
+	struct mxc_jpeg_q_data *q_data_cap;
+	bool src_chg = false;
+
+	if (!jpeg_src_buf->fmt)
+		return src_chg;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	if (q_data_cap->w != jpeg_src_buf->w || q_data_cap->h != jpeg_src_buf->h) {
+		dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
+			q_data_cap->w, q_data_cap->h,
+			jpeg_src_buf->w, jpeg_src_buf->h,
+			(jpeg_src_buf->fmt->fourcc & 0xff),
+			(jpeg_src_buf->fmt->fourcc >>  8) & 0xff,
+			(jpeg_src_buf->fmt->fourcc >> 16) & 0xff,
+			(jpeg_src_buf->fmt->fourcc >> 24) & 0xff);
+
+		/*
+		 * set-up the capture queue with the pixelformat and resolution
+		 * detected from the jpeg output stream
+		 */
+		q_data_cap->w = jpeg_src_buf->w;
+		q_data_cap->h = jpeg_src_buf->h;
+		q_data_cap->fmt = jpeg_src_buf->fmt;
+		q_data_cap->w_adjusted = q_data_cap->w;
+		q_data_cap->h_adjusted = q_data_cap->h;
+
+		/*
+		 * align up the resolution for CAST IP,
+		 * but leave the buffer resolution unchanged
+		 */
+		v4l_bound_align_image(&q_data_cap->w_adjusted,
+				      q_data_cap->w_adjusted,  /* adjust up */
+				      MXC_JPEG_MAX_WIDTH,
+				      q_data_cap->fmt->h_align,
+				      &q_data_cap->h_adjusted,
+				      q_data_cap->h_adjusted, /* adjust up */
+				      MXC_JPEG_MAX_HEIGHT,
+				      q_data_cap->fmt->v_align,
+				      0);
+
+		/* setup bytesperline/sizeimage for capture queue */
+		mxc_jpeg_bytesperline(q_data_cap, jpeg_src_buf->fmt->precision);
+		mxc_jpeg_sizeimage(q_data_cap);
+		notify_src_chg(ctx);
+		src_chg = true;
+	}
+	return src_chg;
+}
+
 static void mxc_jpeg_device_run(void *priv)
 {
 	struct mxc_jpeg_ctx *ctx = priv;
@@ -1209,8 +1268,7 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
 	return fourcc;
 }
 
-static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q,
-				  u32 precision)
+static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
 {
 	/* Bytes distance between the leftmost pixels in two adjacent lines */
 	if (q->fmt->fourcc == V4L2_PIX_FMT_JPEG) {
@@ -1261,9 +1319,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
 static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 {
 	struct device *dev = ctx->mxc_jpeg->dev;
-	struct mxc_jpeg_q_data *q_data_out, *q_data_cap;
-	enum v4l2_buf_type cap_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	bool src_chg = false;
+	struct mxc_jpeg_q_data *q_data_out;
 	u32 fourcc;
 	struct v4l2_jpeg_header header;
 	struct mxc_jpeg_sof *psof = NULL;
@@ -1331,51 +1387,11 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 	if (fourcc == 0)
 		return -EINVAL;
 
-	/*
-	 * set-up the capture queue with the pixelformat and resolution
-	 * detected from the jpeg output stream
-	 */
-	q_data_cap = mxc_jpeg_get_q_data(ctx, cap_type);
-	if (q_data_cap->w != header.frame.width ||
-	    q_data_cap->h != header.frame.height)
-		src_chg = true;
-	q_data_cap->w = header.frame.width;
-	q_data_cap->h = header.frame.height;
-	q_data_cap->fmt = mxc_jpeg_find_format(ctx, fourcc);
-	q_data_cap->w_adjusted = q_data_cap->w;
-	q_data_cap->h_adjusted = q_data_cap->h;
-	/*
-	 * align up the resolution for CAST IP,
-	 * but leave the buffer resolution unchanged
-	 */
-	v4l_bound_align_image(&q_data_cap->w_adjusted,
-			      q_data_cap->w_adjusted,  /* adjust up */
-			      MXC_JPEG_MAX_WIDTH,
-			      q_data_cap->fmt->h_align,
-			      &q_data_cap->h_adjusted,
-			      q_data_cap->h_adjusted, /* adjust up */
-			      MXC_JPEG_MAX_HEIGHT,
-			      q_data_cap->fmt->v_align,
-			      0);
-	dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
-		q_data_cap->w, q_data_cap->h,
-		q_data_cap->w_adjusted, q_data_cap->h_adjusted,
-		(fourcc & 0xff),
-		(fourcc >>  8) & 0xff,
-		(fourcc >> 16) & 0xff,
-		(fourcc >> 24) & 0xff);
-
-	/* setup bytesperline/sizeimage for capture queue */
-	mxc_jpeg_bytesperline(q_data_cap, q_data_cap->fmt->precision);
-	mxc_jpeg_sizeimage(q_data_cap);
+	jpeg_src_buf->fmt = mxc_jpeg_find_format(ctx, fourcc);
+	jpeg_src_buf->w = header.frame.width;
+	jpeg_src_buf->h = header.frame.height;
 
-	/*
-	 * if the CAPTURE format was updated with new values, regardless of
-	 * whether they match the values set by the client or not, signal
-	 * a source change event
-	 */
-	if (src_chg)
-		notify_src_chg(ctx);
+	mxc_jpeg_source_change(ctx, jpeg_src_buf);
 
 	return 0;
 }
-- 
2.33.0

