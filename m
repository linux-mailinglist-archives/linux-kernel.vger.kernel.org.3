Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E934E4EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243169AbiCWJIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243113AbiCWJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:07:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C757523A;
        Wed, 23 Mar 2022 02:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eygwDMnzzpq2uq5sw21KruqilrLktgmZuI5CkLpkdcUfEQMWwtmnpikDen0UiaT/1mNr8Gu6M/1LwZ945A4XLwBAAXHSVohQhM5pl3FXyNQTRuZsuR2Wqn2phgz0fx+GaJhHLWdMDXdSxs3EAv1UwM4rblrRPxF0LycOQLX8riMRkGgZXBAxVVk/BWAlVbvbMGhmRy/Q8yzPtka9ALUMf/2wrU5PMiMOK9S8x5SHxcaZGGJ3tOkdGA8G3+9XjLhJhIw0UNY3Jm6XoZAXLNnTl5WooL7F6zKEc5ae2CZlut7Pm46d0pQ+Wb9Lom17u6jYgJwIvaXdpQYpQ9cbDnKCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g+690WIg+MYXNJQ5zJOBqx/MdkSYyzOmm7jmQ4tgPE=;
 b=Mz7dCxNNUltUAeVkhKFYEnbwV27gdjFVF+gYJpbktrs8KIOq7K/Jt4FctlrgF05yqNJEGGlCP07O+YD/FZqa3tdi8NBfXumqPGlJ9r5EQJp9QtipDsgmUkM+8NVO5OQIYl+yWgRh58SgN5uPlBiRi082ej7+gq+3lJIZ+Lji/EVPqGb71fpyPrrj6z+KcTergn5vISSimV8R6fd2bT6FveeEYefNYZrb2oEvUndT/BSe4i6KhGaIbPxQCjL5NnyaipSpS/q/txHPxYU3Sc789ZjCl88fT3ai68Xi+NNtLTNPzXXSoIZxWexR6/E2mhDbxiFMt2jwtnoVNSUkVPQXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g+690WIg+MYXNJQ5zJOBqx/MdkSYyzOmm7jmQ4tgPE=;
 b=kIVQOumrK8U+sWzmbdhVCP9aOTiXkuNJYPDJL4LNp64bTvlq6WL4+MBi5+peQKCdFEc7S2AjiWMHAGnhv0Qp/G8ZoiHLFyea3IkN88cvnkK9DIgeLUnTAc7tiEsyNj5uuqhAuJU+xsvxHtlj8ZHHWIkgV1StqS9STQPzeZQrwEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:06:22 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 09:06:22 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/5] media: imx-jpeg: Identify and handle precision correctly
Date:   Wed, 23 Mar 2022 17:05:55 +0800
Message-Id: <629549f287c71d78b726fecdd2a3eea35982ffe9.1648023273.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f918bef6-8490-42e0-a4f9-08da0cac6689
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4901921F38724ED362C90F7BE7189@AM6PR04MB4901.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYCsTyYHKzsXAHVvtcpzYxw1ftuTPPjfiHGPYWJxpUU9F1DNcik3seqVc9XAJo6vUmWZm0x0KWSkGLEBiA80TR17n+4jaaUI7qg6xhdoroJEB3Mva1pAfy0u+LePffFKDH7OEhOV7a3Jvf5deXYU44MqAOzaJb4hDhFl/lOpSFmy6WVpW6GHMrZ+HItuF2KbWOHWgtisY1zStEjD8V0RJSMzsjR9iWXT/gHvbP6ABxZs8KJXtNR4+dzkCHEpISmdoImUxAse4iz3iJoa20a8Mw+zMicpGYI4y3xDbv/C0Pm/dCxeTlDxFEROsmRDPsXSzupndj3Ek7yiGPjqi3NadWVn9ZeKCWqYyInSZKdPGsQ06op4xz00og2qIgApZzGyV6TTM7A0HuFTMXxQPHyYMFKMANY38a2rcaWYJ0JLiSAqu18K9KHhc8UrPDTMKu3QEd0vUuo+X/ltvfOZ1O9FlEi98ssn/DZYq6dgCq3T2Nqd/7rswoarhxQh5ob3bxsWoW4/AG6XDCIkyc1IZYaXqCEqmedKV+I9WeACEP4k8lgRoSSW2LbMUbhz0HdtWG5MHz5jmaFwfPZYqrR22eiLXp2xfwegAtGZQQc8wO/JX/Q7Nt1pW4nxPx06jYYvI7YIm29C6vW0MZt9ovHiu2tJ9kTpOQDyc0c7RQ2Cc4VBBQprkO1RDFq4j5LZOA4RZDCoOve5+cDNsof32U7rdgtwxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2906002)(38100700002)(38350700002)(316002)(8676002)(4326008)(66946007)(66556008)(66476007)(6486002)(6506007)(86362001)(508600001)(8936002)(83380400001)(7416002)(52116002)(6666004)(44832011)(5660300002)(26005)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OrrQ6/xLkM3ydwb+pHKbE9aC9xgHZSN+1Ai1a4blBdRtJvU9u+3ZlTbawc1W?=
 =?us-ascii?Q?K1sVqW4bm+A0A7n2MmMKZwAHkCwtrV7FapMgCEgjRqhFaalay89pbNIRjONK?=
 =?us-ascii?Q?LVGqPEoHkno0tkKq5zTTMJQJhsHKjGKl1f30a1Wnz2RIAoQqunl/3nvGMIuz?=
 =?us-ascii?Q?WvbUEAbWcFHvHqVauD3RatRCj87BK092j7SSRR97tdkp6h+Hf8Nnut74sIxU?=
 =?us-ascii?Q?9wo1+0w4nSlidzF2h1O7204NliReIfQhXamh3tmabbMHR1qxMRuPJ6LxnzWp?=
 =?us-ascii?Q?h/d7sJeiRp4rlp4NrPiRU0RRwBpW78truCCF9DrJ1idCFM6lNF/o52JT5OTx?=
 =?us-ascii?Q?GXDAKfjXaPmCmr2Fzgc+8cEHcVvo4S7JRC30VX/EkdjQND044DXbDwvO4lBZ?=
 =?us-ascii?Q?qVayQp5C6FQvsXv3r087VkXT+Y6MsgYDay3pLXZRW24NdzW0BCYSsWe6FAxX?=
 =?us-ascii?Q?sK0s73JGTIOHxqNZVmbibxFwpihH3R+eZGxVaT53FjQnALDvea9XuPkzV+6i?=
 =?us-ascii?Q?t76eJ889xvodHUtfC73o98QyRy70aBvG9wp9adafIBJ9gzW0+7IndIsZPfTF?=
 =?us-ascii?Q?2eIvedtademg+6EUmBbR9Rpfx45ninU5Ye7zqwNqpb3zHGj8Ups2DlVKE+Ww?=
 =?us-ascii?Q?PT+WTKeQmoD0XRa3v3euIU0rDuYhmDwe+fbS0FwG5j1sbrtS76er1URUdBoJ?=
 =?us-ascii?Q?5tXfHa7VQcnhC6fEqT2nyftXc0L2AvVAZqRXbxDJA34EwKrha2tVufELSys/?=
 =?us-ascii?Q?bB47NOh9cxCC770Qfx48hq6cWHdCWOyCYdhE27mJLh+IrL/wibNOf8tzon0G?=
 =?us-ascii?Q?Hj49ItIf6M0vfGMoNKo8mHjfSTrHJ88EGwW5fJ0HZcpsxAWCzbtJOs/irPnK?=
 =?us-ascii?Q?aLTFrvuBLLDCWXP7MaKjB4gSKnH15HCdarF0aEf1ZP0myMW7utSRBCPeXZsh?=
 =?us-ascii?Q?EapDa22WFvocaVA+a7H/Eg17Og7rIym9n962mUYtJ1MeGHF+WfWSqM6zQhmg?=
 =?us-ascii?Q?LAsL9FngKl9H3rCaiNGyqcnz5QE+M8gV7WeReuGEFd21amOYcB//rt/rL9lP?=
 =?us-ascii?Q?h16HT/sHJFE77Rtuyns2EunT0llnwSLyzysTGssP5TZQ8y9KvjmZYbJqe6dy?=
 =?us-ascii?Q?pcCYWCAnGRS5vr1B5knxbMAQtEEd/aiHkFBGz//PN1QZ8JDaa9gh9ivKhwYZ?=
 =?us-ascii?Q?DOAvAhvKHhV42M9vY1UAh0kNGxZOukWbkKIA1lrZVM6BIQ2sH7fTbJPvhsp0?=
 =?us-ascii?Q?+BCIsGlQtUxtuRMZdIyuOCu6dSRdEaa7GP+rwJVCCp4JYcmEfdvIdwXVewZN?=
 =?us-ascii?Q?bTXH8UvIl6l3rB5imUTPBGVJjGMfOxBEDasE3V3rR4g/2sHAzNG8XqJaA4uf?=
 =?us-ascii?Q?u3ApBYUJYGpcliUdsMLDjxZQ+yz35MfsiNmn/9j2BZ20N0KJl7kc2TA1yXVY?=
 =?us-ascii?Q?cxt+HBqWleOmTQAlmyFtwo9efHRnaPL7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f918bef6-8490-42e0-a4f9-08da0cac6689
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:06:22.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+aJSKS+/9rfEVSQuSZ9zHtvkOe9aJCNnEXyVoRZvpJDd4esWkUSJRJtmMNDtnjZaScWR2qDQ+DUTbmqa/Zs/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
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

