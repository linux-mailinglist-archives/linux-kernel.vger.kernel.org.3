Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6721D4DD5F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiCRITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiCRITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:19:19 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150082.outbound.protection.outlook.com [40.107.15.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05257F14;
        Fri, 18 Mar 2022 01:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhxZeNeirube0ZhhWs1AygKpzKFgHPkO81wFMgcNPEyHKa8yaZXu7l6zzvHM/HPINs8i/d6qo8E02HxIq+k3W5dAHswqS7ZuCSr8HeG7i5cUzms4SxasW5TVefxlaMuNUhn7/tpIybNtHZR2Yf+Wt5RyKb3rjUvD/xtSO7gQCNqwCDp5yhrhhhjbmU0/d81g4GSq03mFhPw+hYdyUGjSjZJT0nm8dCJHGJhgQ5/JQ+v+d+0DWH5uQDgHus9BJHzMJJhWgvj7a9r0G9I8RYWr3PAxhxc6FGl1jjrx7nPc33qC9eHBtjDf5lCTaSAwKRGT1BRD1gqSXpwPpBezqCDfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoeWsAPNw7r5DQeUqLdbjG80sclODBcn2yzd9EAAUzk=;
 b=bHSkZyj9JIH02L8VfmOAhbvEGuLshP05lOt2GdfjjFjegpnbZ/ubrqCsvJP7zxZtCp+Su8/Hw5+7To9dOZqDGMvhPSyPTSJMdeRO4m+oHqsErdnF04mFMxy4a8voGZLQbyEKu2xKAhcRBRBgAtx54ioqcc56kwYPo2hiBkjJCTMG2KT3Qp/jz7O4V3c9U6o4TN35tDEXoM2V9rQa3Q54BXddy717SvlTyQVODu4OrPvhnHhN0XYtZgforjtVcyLq5ML2CynTS/WMIYWXByn06afUgkc1BD55mx/AaeAqKd+owZMx9rbWgtt0qZ90hsgzHhha3Di0HzRzOi+9PfCo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoeWsAPNw7r5DQeUqLdbjG80sclODBcn2yzd9EAAUzk=;
 b=XhN1CN+qqXVZMwjq7w+mWysGmglQ9lcqFyo/V/bDCWJMwpfLa/L34rfgnJTbWaHceovhGrvCJqQfhaLv+LzWN35psPPDxCFgo66s2sKavXIxC0NFofqShlyxSu4rt7Re7eG7bdXhJJu+4tCYUno0DL2rApOAYDQJiihxOzkpNN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by VI1PR04MB6285.eurprd04.prod.outlook.com (2603:10a6:803:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 08:17:51 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2%4]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:17:51 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] media: imx-jpeg: Handle source change in a function
Date:   Fri, 18 Mar 2022 16:16:54 +0800
Message-Id: <b59fd0c07421e907c37ec68d5dca81a3b06ac989.1647590462.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4cf7e90a-ebe9-4b69-ed42-08da08b7cb68
X-MS-TrafficTypeDiagnostic: VI1PR04MB6285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB628505248F530D549FBC6261E7139@VI1PR04MB6285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjPGOfYNnR8NGhSt+0tQBbxeJ6lLqNygDzNhCDZRhnEDGj9GsYs9W8Aq8/V/HGkVS8Vs8e6wOxqx0PVM8QUVnmzKS4l2HTMF/TX2pw0uij/b48KlD2seoPMPHcpsRuxCfsowLlo1lZZ1lWpZ6Vuv7thXzQuc0z0HpdfXnhSUc2O+KqX9Yu+ve1jrxIwlFU1nY9wIc6Hevjq9UtRACKMD3S74QstqIBu5F9e0UrFs72cwong85cexyKGtXX6fH4rIe8RXUZX9XrjP8OXD/SX78sFMHEvjHuxJdMUqAMvF+e8rAQMNYi2pxzVDj2vIoy4cu26g1gPgmgVs2c3cEWI2kJS92ksSNTFe0PCwNUjI1tGUqNEPijIXPfF77OG52rNjPvrrX8UQK+eCx+2TrZAKP9UnAR1aWREiWBsE/EI0YmxSwXESmNIJGE/z5Id5cF1aYGrNmhJujpl+IQr0/kKmRRrdXSb4+FARkc8ypXa9nRRNAwrBnrUnkhER+GcZvidn3Kw16SP6VwNG+Lq4bcDJmx3UADmtxK7dvGTJ5X7f8ZtBKj9r88Ylk1eANVb0QRS2SE6Qh6TGsGfBLelUK50FHAT90KSWGhdQaqSge3YqnqmC3es9t/FBX/c+GTISfBRnGeje7dE14pZcqoD6x/2naGpte1lwOfJDW0CIIpDD//lgSHAOw2gcNhbGybR5F83cPEuaJBpzTulRjm69E/cxDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38350700002)(26005)(38100700002)(5660300002)(6506007)(4326008)(8676002)(66946007)(66556008)(66476007)(52116002)(86362001)(7416002)(8936002)(44832011)(6512007)(2616005)(316002)(508600001)(83380400001)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1bqGK1riv2mQNIZ6NsxCMLgzfYbr6wPoEbLLKOaaNAZvii+02YIdfM0BnPGs?=
 =?us-ascii?Q?NP8bVULHFEiIbYt4u3GlOEfrysHDoCAB/DJVIep5gtzc6c0Apfbv8+hv0+qx?=
 =?us-ascii?Q?UDs6u/bYrALIyIpMnswuTD0wPk+lTdR0H3uXLhEASICZ0nyuyoLmi87aI7E3?=
 =?us-ascii?Q?dI+6y3CPKLzjcYU4niNydPiIoDcLEU4Na/EqTNEAdxQ/tw3ABSy7SwTcxG9F?=
 =?us-ascii?Q?8eHX5Ql0Ycf6t+HuU2zuucnGprVoKPbcjfLBbW7uIFNVhbWrgOEKYOF4FpO1?=
 =?us-ascii?Q?8R//8LUnKyw7j9uq+jZ0aiq1sQ2K1zLCS/s+1c+lHQq5vkOIMPRMWLeGGyXl?=
 =?us-ascii?Q?0m+UZqpatNYmb9iFkSgEPAhG7YUqQHoKuQ6sa9fHFzV6mRZpvG3sH0FPEQqH?=
 =?us-ascii?Q?XkVCXNA6/2LcXZeVmsyVNq4Q7mqdUX0OIXvGO7Rs4+HYsLTA5pwg/7W0pEoP?=
 =?us-ascii?Q?HgVoQqep356k1v2djfyGzeBI5ZeuIiRN/Lie7UaTvd4Yfb0wz/IUyGqdRzzf?=
 =?us-ascii?Q?olHVX8HFdTOdpSDrYiT38NU2fjB7Kr/Yv0WOaFElUtqqTH7n84Qawp3Y9GRu?=
 =?us-ascii?Q?qGYwLvbxlvWWtDBAXxonym9R73EjWBoL2OFK9b7cTTgXwzcEzDO9nkRjb0hM?=
 =?us-ascii?Q?03kf9NjGN51B11xBNYvBYe4BAlJJvD266QoxIZUArppGGIxaOmsmrEJZDXVC?=
 =?us-ascii?Q?bA64UPu4dh3/fd6bBK2ikgFC/BVZleU5Ymx80/2bC1IgssmGqsjRoHh4DV7O?=
 =?us-ascii?Q?1E/J7+WHjSUQfagMMv0jMMQi1WgB3vh8kHkln2XLFiFodXp0s5Jm7HzKlnaV?=
 =?us-ascii?Q?jYWEfqVvjIZs9Mp+Lhh6Mwl/OBg+tGF1mXrqrVUW7OF/1VrJfE1GE1IPSvTe?=
 =?us-ascii?Q?yie/d4PjoCLzHXaAg6fXb3B5zEwl6HCp+Y02nXcnq+HLsMNXY6Y1t/din3Xp?=
 =?us-ascii?Q?/X8lZ/K01ertLsSBtYGrAPKw/ikj8KosueTMKr9HMykGhbnd39WSN2/uSADZ?=
 =?us-ascii?Q?MmC+ASxSxrC6q1OvRBFr6/rla40zSdEjY00hrmH93Cpl8izmq8M1ueAxmFQD?=
 =?us-ascii?Q?QLFjH/De5K08BOvz8Sqn+jf0Ow8zBkgdZYCpGs9rawyF3tq2zFN+lRfeHFVz?=
 =?us-ascii?Q?w2ma9pzXXw6ZTFGDXf4qr70JmBruZY/z+ImXvGjv6vuULTupr5bFPJqI5Qj0?=
 =?us-ascii?Q?g2qfVFF0L8VFHNHzVnWGYK3WmmSHOGQMWLN0DNtG5TiFtaN1kI64Fh5n6Qp7?=
 =?us-ascii?Q?fDLmiWH0gHZW3TMlvEHxcQMKUnKRzT6JzYdjfz0cfN3uXA9oJWK2Qpet5IcQ?=
 =?us-ascii?Q?gMtvKBQU5YEx3NDfOb3UqiAS3au9A3TS3X4lwuOZcLC/ioRdeDqg6tKhBROC?=
 =?us-ascii?Q?F75n8MIA3TwL3qLAgpmOCkoNl3ixg6jjmX93q+owe09N/UaRwTKQvqgwMqrO?=
 =?us-ascii?Q?VogXCxgVNAkJ/XHjjUJ2/jJdp81EXZwO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf7e90a-ebe9-4b69-ed42-08da08b7cb68
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:17:51.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14pJsOA9CadxPsayy2tph8jINNAnZ25CZZnDaVMVA2PlC4nLa5qgKqBGYqVxRtfK8KpZuJMgvv2Tv2mp+52Pjg==
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

Refine code to support dynamic resolution change

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 114 ++++++++++--------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index d2110731346b..5bce74de7cf2 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
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

