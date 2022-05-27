Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD9535AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348361AbiE0H4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348446AbiE0H4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:56:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA183134C;
        Fri, 27 May 2022 00:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyI9lwTKeWjbWwTfBSLrbzKAnYMM3ePNvIuNODI2NDMbA2QVhoHLZUP4R2qdRvgomU+bdl+jphItc8d7PDT2MtL5Vythhf3H4wICdArG/H+MVKeK2NWfSnJ3lVizwMfd1EwlSk+B+tsxUnR8CMYqJKK/Nk3gcpF859O0C159XLcWXDrVDtEQaFoztEWJ4PavxqruxJwx10BfiHmvbHWNtRfA5eB/vlUVp05cJ/lVKNbme2Z1ikoDNSWNwRdyLtKP6OWbdO5Ka2ZYJ570ZlAFiblZp+o5mKgIX97gV2HMjrOXC8ocZARmLZcZXUdYWisBNdEY/ouoNxYFsOoYISp0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A+DPtgO+MrYVokTtepeqXQdm3jt+NdKnEBhb0r6ZjE=;
 b=Km5tWAFEnMNgds6eq9ursbO7zshoc/l1JC62y5CoJLmt1Ay1O2SczDSQy992SfVC7xND85z2FDuZ3xtOfUtzgdGNhYCRJPAM1oBKskpHcnpYpSiS6dqLpwQoq30/7dCQ1CnpNASkAbXOB8E1gSMGs+AGbWxExsDOMEluy+9hCxedVH3s1RqYkU7HqQeLJqP7jCtHdV71RBi/TDu/aqGOCuCl1tR1wpBMZzG0m6lXEgfg5zTNoAd0l/s/iw8E6qwUq9WcKi4ARkLWeQT9zMABkQ26qsqAfM7KtWCA8sjrVEnZJmTtb1fj+9t3wcNp5y/fP7IDuQhtVWmf2xepbkDTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A+DPtgO+MrYVokTtepeqXQdm3jt+NdKnEBhb0r6ZjE=;
 b=XQd4gxTzChWllkvA7ytZ0EA5JARwqoMk44W7SIopLejlB72jmCI/hSbFqAofQtCQFPnMhGy3E65H1u7WEYWsKhkNco9r3Q5V41C+G54WNotBCOiSu27n5fq2TDXl5S+F6DinrbtakNg/toZ8DNKGjCcO+uyYSU1H7s08V1Y0HCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4590.eurprd04.prod.outlook.com (2603:10a6:803:6d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 07:56:20 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 07:56:20 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Align upwards buffer size
Date:   Fri, 27 May 2022 15:54:36 +0800
Message-Id: <20220527075437.16882-4-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527075437.16882-1-ming.qian@nxp.com>
References: <20220527075437.16882-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50faa715-9206-4e90-c6d2-08da3fb662f0
X-MS-TrafficTypeDiagnostic: VI1PR04MB4590:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4590FF253179A775B4FB5422E7D89@VI1PR04MB4590.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32Ch+W1FIS7fxUPryehSy9pU4B0fJRzlkK7m757sqc6ETg/0ChKnntcAQbHSCFhbUha8TmIPn2abTII2c8XbsBe0x/TtSaadVkff+j/OSXRi+Vtf8rT0TWqiQgyajmnj7W9AhgOYCuSaSZOPUbZeoLy0IQYi3yV9Nq5vlIGTwDwyftJYLyiD8Jwj2yRM/Hrix8YDSmX6grbQ0gwp2m+zAgM3wbNHnxGrL9UcA4Q8R0DwFpzr0k7XviaeI1Jhp8hb7ZRDPjWEATHg1te/X46Rb+YtHrO2NPNnK6N+k/Tz7b7LwY6rXm1QJuohYF0ryDsc86FtFusw1bEvb7eDSivbDCoTk99CkcKgztzsus+BYtuN6lxZhrM7AyQzHPVbwY7m1PDkeqt+F64PW0/KfElM6iDacox/OuXsKHNl13jFmgXRI/mIooK2q6C3VpZJ7yLeVqZUvYxBffEahJrNo/BeApDlI83XfLFeGGVEDmKFpZcszAFMvYB28GzY8kjtg0dgzsMeqLcA2AxoVeCv4hTtkLZXfLcPMeOqigWWLtH2ECvBGRlLOO4CEgEOfe/zCRI0tN0pD70uyPMWzpDyAmPLCyG1EuDUE8IcdNctkFdNTU+oew+HAdZ2QrnXBuFoQEWWUtpgrZIwvfrguo1KbOlRfNcH8SYTht+FCDdte2od+kO3e94QzHOyTxFvAv20iyjSl173O5fFQuLeC0w3Yndu6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(4326008)(8676002)(38350700002)(66476007)(66556008)(2906002)(38100700002)(316002)(36756003)(6666004)(52116002)(6506007)(83380400001)(44832011)(2616005)(6512007)(186003)(1076003)(26005)(508600001)(6486002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7Mx+R23pGJdhAo6VvEpsoF8ZAl8Xz9hcg0YwC4k/Ni5jMFoN6OwopD0PRPZ?=
 =?us-ascii?Q?KZf0SJsgwTk2nXoej8Glou8CaefiKvFHuWmaj2Lt40YQx9wUuUw+gd5Miaf4?=
 =?us-ascii?Q?gzlrsZq/btMAHsx19Uc+pC8HjrVilgxhYTV7wlfqTthiPKV2Z3YJrCDPi58p?=
 =?us-ascii?Q?MheIg0SpR9oYhLFx+T+CG8qn50dF3jdbB278+L8TQeRjoAHFdnmfVxAOG4x+?=
 =?us-ascii?Q?imDWgBL2Gij+29m28tWQ4/KmsKHxVBVxkDSo6VkF+420CHp/2VxiXP8hXHi1?=
 =?us-ascii?Q?cKFVBcxEQA4oQvzZ37VHW9ySN7vS5nBAyJEeQOr7LaIyV98l/paCLVpgyXKn?=
 =?us-ascii?Q?PYfx+VwmrqDmMycu5AFnslH7/7/uJhqWOFEFiFafzjbaZIsn7EHcKifhMM6Q?=
 =?us-ascii?Q?86Dl++peVf3kEupXqTGED5tJxsAZoY21LYXxbUAfFgdCIXTW6CYWypypy/4q?=
 =?us-ascii?Q?dmawQ7VF18ge8LlHGFQsbjES/Qx5DgZAUW1hodCns920nATZTgWOEUhGrcJe?=
 =?us-ascii?Q?l0Y0RNvmnNxUjf3wlTuYan+6fbNhp68L1UB3f+xVpQK/RHy58gmYd+6vzh3O?=
 =?us-ascii?Q?WUFvP9y3E6TdxGUpjK4xnKovnZrfHKCbKdpiPkyVMongEjNkV9nWfm87zzsS?=
 =?us-ascii?Q?9ZYVN0OdqaYuejCDa6suAU8jRtHRBbBec5j6UC4VSvDPVFy+kV1a+hzjYfp1?=
 =?us-ascii?Q?iHpvxamQLBWElHFtqCQ+BO0huCvyUuX5j3ZH/KeEDnB4tfTrLxqpl8jhuJHn?=
 =?us-ascii?Q?ZAeWisxJOnmLDkqSvCzhuUsMv0ycJjHpNpRqj2uv4Uh/1yMY5U1DM6RZCV/P?=
 =?us-ascii?Q?ohR51aImJRryKRGA2C8p+UGGslZncz58bBx0Wg9vW/Po6DLkgIKa0AWTkywA?=
 =?us-ascii?Q?xhjg9crh1mO7EPDOvqSyKDImv/jcURcD4AE9GpwiwrIshGL0eLt+ZeJpaKY/?=
 =?us-ascii?Q?SkQP8VtUsO+UgLFAtJBtjnztJzL/ISuJsnQbKE2oPKdvRspRSbtfIas8Pduh?=
 =?us-ascii?Q?AZ9d+viyl4cg7j1E8Cr6yxJsQOlAjPuXJkITOJIXpW6DZBWhTBf7YdmRgmOC?=
 =?us-ascii?Q?LU1FsvHqO0uJ8vk4EY5mJrSunjp6YjHUlR/DREPwKSgg3/2JzYO7TOO+JCl0?=
 =?us-ascii?Q?dI/pq3tmw3pKBvyCi6vyxbYHDafop6vzIyZaQ3ncIxf/5p0sC72csLMlwipF?=
 =?us-ascii?Q?v5AcMNhouCRQ+leQe0/qjeo+ohcZuheyLW09EK2S+4jrMaS31LYpy5aAwOFR?=
 =?us-ascii?Q?s+Y98u5sLVFJMrMPzCKywA1Lk+3e9VW+06fWuoBaluZvQGMZZeYFWudtPC10?=
 =?us-ascii?Q?KqicpHNs2CANJbbnwtqEmS7hbH+bI66tcRNU0j+KrK8RQ0fH1H4sqZ98JVmn?=
 =?us-ascii?Q?g4f7Htiu3Ib3gcBerMNe1QCYnU7Bpup5CJlx24N8SBBxXDzrl3tOiK6T8iuU?=
 =?us-ascii?Q?ToEDG4vgQiiOlE1FJUItaDKJsSddSBAfyDgDYD7ynfu0gKMyAXg111dS/b63?=
 =?us-ascii?Q?FVOUnKZwZU/sFRbiisAcy4MsN1yjkyBth93XrY04AQ73rQqQXifK8ZxN8lso?=
 =?us-ascii?Q?Z/6uObIXIAdjBySd6rHWIYmtjViIiXO521k5UYNJoaYZQ2ESUimr9g8/wV0S?=
 =?us-ascii?Q?PryVXXNDyGHv852RpMcFRSO6ZPRJuPELybIfFmvnPO+XvXUpgquIIQA2GcGN?=
 =?us-ascii?Q?PrVLXCnqmlkquif8pvrQt21nd6SAzX1cQ6Z7X15l9gUij4GpObVOiKalcQqg?=
 =?us-ascii?Q?EHviXdA/ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50faa715-9206-4e90-c6d2-08da3fb662f0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 07:56:20.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1TreHkBpRBBnE5SUMjgACnHBBMK6ZUsZbhhw+7Zm1Tci/vapRSt56ld2arH9834gES1kEpQ8Dam9HL5n/LKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4590
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

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 88 ++++++++-----------
 1 file changed, 37 insertions(+), 51 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index ad4213e020f3..9719eab7bc83 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -888,8 +888,8 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	jpeg->slot_data[slot].cfg_stream_size =
 			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
 						  q_data->fmt->fourcc,
-						  q_data->w_adjusted,
-						  q_data->h_adjusted);
+						  q_data->w,
+						  q_data->h);
 
 	/* chain the config descriptor with the encoding descriptor */
 	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
@@ -971,7 +971,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 				      &q_data_cap->h_adjusted,
 				      q_data_cap->h_adjusted, /* adjust up */
 				      MXC_JPEG_MAX_HEIGHT,
-				      q_data_cap->fmt->v_align,
+				      0,
 				      0);
 
 		/* setup bytesperline/sizeimage for capture queue */
@@ -1155,18 +1155,30 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
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
@@ -1175,7 +1187,7 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 	/* Handle REQBUFS situation */
 	*nplanes = q_data->fmt->colplanes;
 	for (i = 0; i < *nplanes; i++)
-		sizes[i] = q_data->sizeimage[i];
+		sizes[i] = tmp_q.sizeimage[i];
 
 	return 0;
 }
@@ -1375,11 +1387,6 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
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
@@ -1742,22 +1749,17 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fm
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
@@ -1883,35 +1885,19 @@ static int mxc_jpeg_s_fmt(struct mxc_jpeg_ctx *ctx,
 
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

