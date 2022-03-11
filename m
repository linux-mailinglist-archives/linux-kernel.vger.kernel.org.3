Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C94D5CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbiCKHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346780AbiCKHxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:53:38 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4231DD0;
        Thu, 10 Mar 2022 23:52:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqqsjVK28CfMfzRUQh86mLAsRHATIVXXSPsDZmYiZFf0fRYohIp9eVBnTC2eSZTpWBvMRq7ub+1WoAMYgkwOjLqzhl/pcVA5HojLdZPDKZq0/jtvaILXaPgcydbK26AinVA2VFZDZao73AOCj95pCR6NojCApMGzSwiqPOSzbAxiq99k7ur02S4HCsCgIIczbzY7fz3HlIO/3lIEfmGgPYakydAJtF7hWODZosQNFewW9yXQlcRHt+EEATsQeOHQvnz3cu1vShEX2DBAqG2BoUwOuxVUIeXxZ1mxmDIFu/NnRUf7ynR9GksjhNLKMXkfzM9l8PqoABEBGgJKHCEfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE9QcKGDoUZhfJe4o47yAi9yM9BKIcAXhlDwk+vQ/74=;
 b=hc4kelUFIYgdcRIeCXyCkNNdmUwnkIJCoWSf/vbMDv+UVxw9knVwHXf3LOg2zYq+afi0IhbQF9SSObQ46aMg3lGOXtq2AeXvHNsABsuLX6tUHynOhbUhYt06ucxrxcJY/9s6qzAa2fVD1S/A8YUPwNRm4DKHFddWeNBUToX6xlro3gSKvqOSX95sbT0n6zT53vsJVAZbQKdPa6y8z2nsjxn6VEwWn4b/S60kgkFxKGgmK9j+UBcAxdDO9RTTdu+J8os0LqbCc0X7W/HKq77+0qkMgM8i/uLqKQ6KnhzaMkM9PD/4Y5jf5v5YMpGQkgfeSD+OKx8g2PGtk/dgmwLB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE9QcKGDoUZhfJe4o47yAi9yM9BKIcAXhlDwk+vQ/74=;
 b=q729wGKZXwOSzoV74M1+sjgoVESnsyA0j17PtzGY3hvgaTlcToNxdSLovrDdYBfoc0Ofd21y0pJ9z+hlDkrd3Wl6rmgV86B39tw0OwWo1DZ09JGZI7x0Qk0qKR+aoFU9cOsYynhf6kgdRb4o9coAi0GQ+uiHbzBXMsQ5ihJ2Eqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4443.eurprd04.prod.outlook.com (2603:10a6:5:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 07:52:31 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:52:31 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] media: imx-jpeg: Identify and handle precision correctly
Date:   Fri, 11 Mar 2022 15:51:44 +0800
Message-Id: <a46042733a6a65d84b488cb2c9f7f7cd494e0ef5.1646983646.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1646983646.git.ming.qian@nxp.com>
References: <cover.1646983646.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88abc27-3188-4735-4e1f-08da033418b1
X-MS-TrafficTypeDiagnostic: DB7PR04MB4443:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB444366C2469863A0A316C6D8E70C9@DB7PR04MB4443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1m9purfkm2vOqhSdvNO68oya4rtVBFVyXfZgLGEL9KA27NseaRMgGmfY+41POQ2Okrn2qwSh7G/ElYPHNQ1FsTVwCsOV4NnNSbYUibTXYEmNz4mXKh+Tv5lVC4u6UHVlcg53zZuad3QTvpBUmTdXnUa91TdxptrKJ/95WY+8XT8vtbaf1UwocHpqCvxNsezNzyCSdWKE4aldqjlEIhZ5WdZsCA8FlARqhYMDSZ9Bln0Px0CIdXQd2SQXmXFlrZQBpksFsaA89H+HzDDsi4131yJoLcE3kUNbYANdoupSkp6DPLsCkNebC9ebivCW4WF/eoo6uMOPZW6iFZ2rlpX4LchmrHkNZ4MazzXIMWTh2XLcf5h6AIktSsdbLeKaZRLq30haKXPN2wYbJmwuc9idzbpIcov6HOXSp0hFBSw001H16uGth7NRBhpYD8Tpk2ptXf0Kj4lAUcTxzVBaYqgGbTU040i13sxC8S6oNt7/UJYok0Je7Eotd5meoHtx69V1jA83hgq7Q8EPscZEF5fUCkNfA0lQi9gv5o3QX+KM7u9/8xItVaXp1fsxKaQ9Rus3PbuINGsOy8Uq23cr5RbgoJSgv6EjKd3WA61k2kRr6rv2EiesB+xD2dQpzOf60iPtH5vuRULBChK7ZsLqavZ5VrvtEPE9KesPD4teFZjL/3aHst3D9FnyzZc+YxNZ98T8V3/6l4N75Op+fSpxq0HNdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(26005)(52116002)(44832011)(2906002)(8676002)(6486002)(2616005)(508600001)(86362001)(4326008)(186003)(66946007)(6512007)(6506007)(5660300002)(66556008)(38350700002)(6666004)(38100700002)(66476007)(316002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2tVwOUIQznyeevss/SAUXbElkGAFHbjm+YyxPPI4Vn17GhwkvOkX6MsgYqe?=
 =?us-ascii?Q?MiYawpcwJAL1jtJyUf7LYQ+R2Y+sYFR8/N6F9tL+PATGDsda97MGF+JG4mxk?=
 =?us-ascii?Q?f5Sb7MRMY5MbbB4BvJA6aAQUJoUNSIo5wEbnlGRLvCV3s3vsf18r69UBpkRn?=
 =?us-ascii?Q?9FGBvrcxX2Ay3hhvZavNvovhRnFvzPD3tsEzZsv0k6WvFx3uMot3BNZaDZG5?=
 =?us-ascii?Q?H6WKfNQsZjU4KYOF3hGdewzkYm54OeZrN9asI0Cm3H66ifdoSGYGQKQHbJN+?=
 =?us-ascii?Q?JTloncKRzW9AK/EhdKyKydVbW8Pbipw2dGZWfI+Kguxqcydsi/nE9S9QQGWH?=
 =?us-ascii?Q?R8WG8AAisNmYvTO8TSTKcZXdUvrlqqH+FCoQnZKIaQE8ZV3ihpgmXJ6RMonQ?=
 =?us-ascii?Q?+lXeEzfmZGqwdMkUohUWQ2OPLo8trwrDjcjbtNo3CL51G0RmGBy12lKdEpkh?=
 =?us-ascii?Q?b4Ha8g7KX/9IWvHVF59wzHRITHWZUM8n7jeFAVA40XEMRJayvYS5Z3uihHEF?=
 =?us-ascii?Q?yL6ALDMCeuKHSA0UC+1PbzaoCUZX0DcfJ2TwvkawmYxZk2eyYxphopjB+HC/?=
 =?us-ascii?Q?RcxoXph2aLJNNQRzu1N8IMlGOUM8cu8w0ETEPI9tjCtKAS75wkU/oXAba+0G?=
 =?us-ascii?Q?nsJHoixWTau0SHt6iPgl4gcx34mpEpOdhEiuoW742IV9zqyGMh21xi/xbzob?=
 =?us-ascii?Q?Jpj4cKhIzJB/waeJzB9FviG9tXe92zXy37uGZg5xAchcL6LItPhhAGwHwgoN?=
 =?us-ascii?Q?j2jii9L4AbZz2Dqy3pmyY6Bj4u/zWA6+nfTImFP3fTLfeDOdy6cujNzkRYIe?=
 =?us-ascii?Q?u78mlFpX7FcuoYy7NLipFDURn71DB1p4rz2pQMtjht7Nfuk7jVgb4iTaHT9f?=
 =?us-ascii?Q?ndxkykwFjyOWUfTvLE6smNZhAxoRDakNfvD+ev8eBNnzYQGjxrtWcg8KzYjl?=
 =?us-ascii?Q?NTSpZ2bkJOhSShodszhSpU6qOwDgY/IPFxF6CfJwAosiQhMRcx3NiWaRbEin?=
 =?us-ascii?Q?hI8czqHdlP+0PRzins9DEjcerarcblvZxHlmzTe+qFjJdjhw4GP/PanNPqcg?=
 =?us-ascii?Q?6vIBEzDY4k+3UdWX933Js2gNvzEhIC4+fR9XQGXzoo1gi8ywqzCR8SXOAFul?=
 =?us-ascii?Q?RPw6H8mlfMkyCBtcVetJDnyihZT2yAgTv31od7w1GqPnoXsdVM/7ftxVZtEY?=
 =?us-ascii?Q?WgRWKg5Ee+EdpCzee5FrGKcSKSnaM8cNMAJlRy2yE7QMcIkjdTtUzXG5oICV?=
 =?us-ascii?Q?MuhYoP+6LH/dXYdMQ8CtGVBM9zcL8UaHhEQW36VvZS+dTNeAafFkx8rasRfG?=
 =?us-ascii?Q?/iik7vcrpsNuxx/hs8y7e1OVwJtcsnmLqzLQSOdr8YTEnriIsyo2xS3AULM6?=
 =?us-ascii?Q?YJjoyrjRwdghTDOrCUJ5/EEQt5b3zcl7EcBtikSWkKLUJYmScZARWWO5kMFG?=
 =?us-ascii?Q?0qlqGG2BmNhQ2s1yRYYJgfpJ+4ueNL4LQNsGOzWYvWVJhCDQD2sZSenduwMr?=
 =?us-ascii?Q?OlOc+/0zzCR6Pe4WiYF2HIV9HrwOUjCXzEIod+zndyXS+kvVXya6HgdDZWpT?=
 =?us-ascii?Q?JNfKnSWPhgYcROYv/J8/zElxWOR2MvRm3hNoMshQAQUPgLzulPatMpwNVDyG?=
 =?us-ascii?Q?skH6Z0QR5KQ2L5D9KwSs36I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88abc27-3188-4735-4e1f-08da033418b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:52:31.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZXK1wC0UGnSNHHR9C/qVzIe/Y3VBfRGvpegw45uJazzQ/E7tfDIujyBZ7ZzujCh6kZfiGL6bVkppVz1nrNHDQ==
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

The decoder will save the precision that was detected from jpeg header
and use it later, when choosing the pixel format and also calculate
bytesperline according to precision.

The 12bit jpeg is not supported yet,
but driver shouldn't led to serious problem if user enqueue a 12 bit jpeg.
And the 12bit jpeg is supported by hardware, driver may support it later.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 37 +++++++++++++++-------
 drivers/media/platform/imx-jpeg/mxc-jpeg.h |  1 +
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index d8d24c19f423..82b9b4630d9c 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
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
diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
index f53f004ba851..82b38cc2dfab 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
@@ -60,6 +60,7 @@ struct mxc_jpeg_fmt {
 	int					h_align;
 	int					v_align;
 	u32					flags;
+	u8					precision;
 };
 
 struct mxc_jpeg_desc {
-- 
2.33.0

