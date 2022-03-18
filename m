Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941F74DD5F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiCRITJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiCRITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:19:04 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC82DF145;
        Fri, 18 Mar 2022 01:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6Z3IT9Oq2DyxyoMydY6cDctUbSe3zcMaNRAy3NfFLQSVH+4j533279SAJPISTdolfT/RlKc0kzsE/oY9H/fIgphnPjsGuGa46liN+wU7whC3vG45wOWlSJ/3xFK/Q3LrqOhN0n1KYuGnwvmb3d1kO/+IFmyVVqzQpO7eWmwExK+crxIobtWMW65MQshLav/lsmPlbMcjD3EA2wbOlazCsnggcvCPIEPS5bTdcZ2Crl85ZaXuC1Qx+od+V2KeKE4peXyHnSkdiDsVNaXkUK2x9LBXo3TuxIKgVNkAxPAYXUR9Yc+azCZ0qT1yuL+FGjo0VxV72MIGk3S0hxU0PAHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g+690WIg+MYXNJQ5zJOBqx/MdkSYyzOmm7jmQ4tgPE=;
 b=RyxhrD4851aAwndZcE6vMysPf93MerQ5xlH4ViUVp2Hq+zwsfZShFE4Ur1KqEycQOK9UCGuUMMIphyi9mEfUIDE6pQUgsH6PsleLd8W6FPCMJ5HIX1k2s2LAiqpjSNRiaSWDtBediidBIV64aqh8fVbHmn8je5ppH8Zv2DdHpQMgJoGdQP0OYgTWFJ2Je1qdAq1UEe1tIM2A/vvQ80w/hbjpC5YdysfnKs/CBu1NHKn8v/UyEQLRmjbZyxa/WxGUW3a8oRIk9fUuoSIMJwHkIn9fXk+huUMOgOuTkIVOlOb7mqbWzIdNBp5quaIWG+DfM6KAHbB2v9NDqv0WXDmQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g+690WIg+MYXNJQ5zJOBqx/MdkSYyzOmm7jmQ4tgPE=;
 b=pkM/Zwn/JBFnjQFxQj9Rt7f9499EzS/aiP0Ol5I6OwHF7i3L+ikupm9RjdZQb5iHzrhNEyGGIgEESxU/SBFEnLSkaSGWUOYCtE2+6iP/Uox0OQWbEY2cedBVe9E20DTX5uLb17iWGAzFKqhKFovHX2VyOR2KJ64X6psWUndKJbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com (2603:10a6:10:10c::14)
 by VI1PR04MB6285.eurprd04.prod.outlook.com (2603:10a6:803:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 08:17:43 +0000
Received: from DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2]) by DB8PR04MB6346.eurprd04.prod.outlook.com
 ([fe80::a8a5:945f:4d08:69c2%4]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:17:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/5] media: imx-jpeg: Identify and handle precision correctly
Date:   Fri, 18 Mar 2022 16:16:52 +0800
Message-Id: <629549f287c71d78b726fecdd2a3eea35982ffe9.1647590462.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c83ea986-2e1e-4d69-c1ef-08da08b7c6b9
X-MS-TrafficTypeDiagnostic: VI1PR04MB6285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6285383DF872C91BE7824238E7139@VI1PR04MB6285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1QeeHa5/ZO09y7/27CZrVZMiPSDjWxZuOC0GghCHqquhbpUTr80Cm+hMGZd54nH2d/Il0rzY/K5hdpHpyL7kxEKhPDX9v7BeA5T9pxK7abipPXBRxYx5fCF4wngIUHe//Cmgcjx2heGpmOLRIukk5SbwNr+Or35zyWaELQvXVQdlMuUy3ASy6XBWV0jaDcpTPr1CSIDhXn2l5ZfUiTyBbpZDczaGtbwmaE6cxTSEhCQ0BdXJ2n5GZXMHJy+4gh5fYcBExN/4f6+7PHgzVBOl2hBd2uRKVT8ufhqSqzWyTHinyDPwVXfXln8vcByIf3mjPkYG4c4024atdwzRV0psG9cT6cL6Gd6m3gM4mBWVihg9/RdefmqjsVmBpPJJC5gpH6GYFSOXjWzwt/ezm1ijTXGPy2iJz8joU/CVJ4JA5xnEjoEIyKyt8XOftS1Eho/2IVFyfYFQ+uXsIg6zLpAz0ZFMDVoZHyUCnmwQQEHsi7CQ1g7sjf7EHRRqxSliJpqYlpLZT5pBMFg9suV6n/qx59PjXm3xbwdd1I51tYvleaZs4y/cx0y/iw6DOwik9wa8UD3xWe8fRGdR9YwfeNi4XnbML04fOZfHR9N0BXpisKuzS13kgraTFiJN1k0KRO4vVOFAN0hydXaX73wgCw3OW9mG+fA9NF9BZ3DQ7LoeGWaM5PrDvIlnPdmAAFOV08lQtXlxt0b+bS2xd377uw+fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6346.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38350700002)(26005)(38100700002)(5660300002)(6506007)(4326008)(8676002)(66946007)(66556008)(66476007)(52116002)(86362001)(7416002)(8936002)(44832011)(6512007)(6666004)(2616005)(316002)(508600001)(83380400001)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pd7qpUxkGAPq4ZWwBML/q7WqudbSngbe0hLJ/FxhJN70U02ShdwNTnx8dCz2?=
 =?us-ascii?Q?6qx9vQbJn9CXDghaLyeFDlA7apCYpEUlQUtKpYutpmDVLD47TevuO7azPaDA?=
 =?us-ascii?Q?sJyKJWKO6zo8dafvbiJeKrPBrt4CIQSlmTSurkXPFX+ezqJRO6JB+nW7vY3C?=
 =?us-ascii?Q?xIq9FPNPvJ2+Aqy0GuvvczE0JNZtK5AJh4CT+By7ZCHPaaLtt2okGS+2Q96O?=
 =?us-ascii?Q?Ax/M51ouVQIdEQuFxg/9NVqMt0cKzfRB0qFESuS0CpiHWMk7ZtqccYiuoHCN?=
 =?us-ascii?Q?PS7sWhHheJFPJGZZpQVDqZT6et+/RGkEkNautfrOhfHXPHO+8sMSgqYTryti?=
 =?us-ascii?Q?wAz/yPc2wwF/n5DIO6BXkiE4XH6Swwp4xa8+t/nw4JchARAlLpmV4CqMwgk0?=
 =?us-ascii?Q?EtNlUJE7VYfCP33RE6sPR7n4pXc2jV/SOKuPNjeZOU7QGA78x53kmECDusr+?=
 =?us-ascii?Q?2h1GlNnP1UN2DldnGBovksZMWGh/fU/do/om0bLSlEpynRlNwzlO+XCE2oUb?=
 =?us-ascii?Q?BRENSWb+C73cbohNQAHVlz8DDIQZcC5XaUBfYKA/RcoN3+Oslk4D8XNKL2cS?=
 =?us-ascii?Q?coLACL0WXUUghtJurPYuJck/m/yceYe5RUY70XsTxdwEl4ZQa8IBU9XqGsyL?=
 =?us-ascii?Q?bN1ZIZ2R05rUGEwKkwymV+3kck/KZ0UgA/NsXNFwNq9qi/KIdH60TVVNTu3a?=
 =?us-ascii?Q?OSvvA6GfkIrXmTjCl1ZYl9OeHZ+XQqpyRMw/tgv6kMMWBdDWkUCCKA8XGcJc?=
 =?us-ascii?Q?Q3X1ErnN7TTlkY3019M+XkMlCMVfQwiCu0nODDAOxyR6B3MH0tMFnqppe4qT?=
 =?us-ascii?Q?NRXql2sg3Bm8iNFiBmiW1rjBYzbfXjJ8PL3+QkoECOxttxbtGkiyYXbc7LoH?=
 =?us-ascii?Q?OdW9i3lRf5j1OYSgolPfb9L1R/LmXQh7nTlU66QrpWRS5wVIqdp9tT4w1tvt?=
 =?us-ascii?Q?bPTQ5R9CwiC22+WjGjYQBYkOB47CwJ6qR6PjStIUZFKPAJzEq1t/GWHzhKDC?=
 =?us-ascii?Q?5XuQv/AbrApM1/hZrFp7+rvL+oqm1+NCuD8Ra+UnDb7+qqM0tkGkUN668RKL?=
 =?us-ascii?Q?MezCKKbYZ3XOMM1ONTxemvDnV+7cg9smu0vpyBL8cE9vpN2zfMHJkxI8FZsm?=
 =?us-ascii?Q?exxKom1gpdzv4JA9hqS10ZkeqyeRu8ADtfIs7p4Wv5XGFigyhztrgLGltRRu?=
 =?us-ascii?Q?ejFch7VKT8L7PMTFWpUbBjc/65TbQyVdNITe8g2UwA9embvkFikXH6kxCQpH?=
 =?us-ascii?Q?yAtmLipaTikjsZSE15xbKKCtg4LMJkVOA0O9X56uwNoZGU5ZgFWOM4t7ZiUO?=
 =?us-ascii?Q?lHewxMmbOKFkhNPq9ebIIdsNNg577QjijZEJ5COx3Mv0i0sO4ZUoE7GOARK8?=
 =?us-ascii?Q?enpGxofpPxJIJllLe3vWcsEnTMb7M7aG2fRhnFbCWiglM1SOLhSgpRCTJExD?=
 =?us-ascii?Q?hqZdgwRYvg++cWB7L8Aoht7SuYK4RZsT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83ea986-2e1e-4d69-c1ef-08da08b7c6b9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6346.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:17:43.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4LEjAoddbBQczTHmosgM7Q6USo26vDJSsF2UYw6xPO6Mk95FpcxKmv6t2IEK8Dg1MDup48+gDplR/epboQFug==
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

The decoder will save the precision that was detected from jpeg header
and use it later, when choosing the pixel format and also calculate
bytesperline according to precision.

The 12bit jpeg is not supported yet,
but driver shouldn't led to serious problem if user enqueue a 12 bit jpeg.
And the 12bit jpeg is supported by hardware, driver may support it later.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 37 +++++++++++++------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  1 +
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 48e496cec04d..a95305639dd9 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -82,6 +82,7 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.h_align	= 3,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 8,
 	},
 	{
 		.name		= "ARGB", /* ARGBARGB packed format */
@@ -93,6 +94,7 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.h_align	= 3,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 8,
 	},
 	{
 		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
@@ -104,6 +106,7 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.h_align	= 4,
 		.v_align	= 4,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 8,
 	},
 	{
 		.name		= "YUV422", /* YUYV */
@@ -115,6 +118,7 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.h_align	= 4,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 8,
 	},
 	{
 		.name		= "YUV444", /* YUVYUV */
@@ -126,6 +130,7 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.h_align	= 3,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 8,
 	},
 	{
 		.name		= "Gray", /* Gray (Y8/Y12) or Single Comp */
@@ -137,6 +142,7 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.h_align	= 3,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 8,
 	},
 };
 
@@ -1175,14 +1181,17 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
 
 	for (i = 0; i < MXC_JPEG_NUM_FORMATS; i++)
 		if (mxc_formats[i].subsampling == header->frame.subsampling &&
-		    mxc_formats[i].nc == header->frame.num_components) {
+		    mxc_formats[i].nc == header->frame.num_components &&
+		    mxc_formats[i].precision == header->frame.precision) {
 			fourcc = mxc_formats[i].fourcc;
 			break;
 		}
 	if (fourcc == 0) {
-		dev_err(dev, "Could not identify image format nc=%d, subsampling=%d\n",
+		dev_err(dev,
+			"Could not identify image format nc=%d, subsampling=%d, precision=%d\n",
 			header->frame.num_components,
-			header->frame.subsampling);
+			header->frame.subsampling,
+			header->frame.precision);
 		return fourcc;
 	}
 	/*
@@ -1208,18 +1217,22 @@ static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q,
 		/* bytesperline unused for compressed formats */
 		q->bytesperline[0] = 0;
 		q->bytesperline[1] = 0;
-	} else if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M) {
+	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_420) {
 		/* When the image format is planar the bytesperline value
 		 * applies to the first plane and is divided by the same factor
 		 * as the width field for the other planes
 		 */
-		q->bytesperline[0] = q->w * (precision / 8) *
-				     (q->fmt->depth / 8);
+		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8);
 		q->bytesperline[1] = q->bytesperline[0];
+	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_422) {
+		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8) * 2;
+		q->bytesperline[1] = 0;
+	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_444) {
+		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8) * q->fmt->nc;
+		q->bytesperline[1] = 0;
 	} else {
-		/* single plane formats */
-		q->bytesperline[0] = q->w * (precision / 8) *
-				     (q->fmt->depth / 8);
+		/* grayscale */
+		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8);
 		q->bytesperline[1] = 0;
 	}
 }
@@ -1353,7 +1366,7 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 		(fourcc >> 24) & 0xff);
 
 	/* setup bytesperline/sizeimage for capture queue */
-	mxc_jpeg_bytesperline(q_data_cap, header.frame.precision);
+	mxc_jpeg_bytesperline(q_data_cap, q_data_cap->fmt->precision);
 	mxc_jpeg_sizeimage(q_data_cap);
 
 	/*
@@ -1509,7 +1522,7 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
 		q[i]->h = MXC_JPEG_DEFAULT_HEIGHT;
 		q[i]->w_adjusted = MXC_JPEG_DEFAULT_WIDTH;
 		q[i]->h_adjusted = MXC_JPEG_DEFAULT_HEIGHT;
-		mxc_jpeg_bytesperline(q[i], 8);
+		mxc_jpeg_bytesperline(q[i], q[i]->fmt->precision);
 		mxc_jpeg_sizeimage(q[i]);
 	}
 }
@@ -1651,7 +1664,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fm
 	}
 
 	/* calculate bytesperline & sizeimage into the tmp_q */
-	mxc_jpeg_bytesperline(&tmp_q, 8);
+	mxc_jpeg_bytesperline(&tmp_q, fmt->precision);
 	mxc_jpeg_sizeimage(&tmp_q);
 
 	/* adjust user format according to our calculations */
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index f53f004ba851..82b38cc2dfab 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -60,6 +60,7 @@ struct mxc_jpeg_fmt {
 	int					h_align;
 	int					v_align;
 	u32					flags;
+	u8					precision;
 };
 
 struct mxc_jpeg_desc {
-- 
2.33.0

