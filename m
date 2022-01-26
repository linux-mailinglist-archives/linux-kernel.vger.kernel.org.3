Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E900E49C1C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiAZDKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:10:24 -0500
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:27013
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236851AbiAZDKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:10:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3O7dLSCC+/goeOiYddiTI6BhY+c19jq8EBRQ6Vg+etwy6/qoXHvIKvNR3mE3C5gKrfKPI9FEkZDuUMMgOLro69UP2O6izwXo+73KbQzXeGNaxp8yyixoItFxFnbIcOkZONCaetx/aIYSWF/wqkIcd5K/IV/UkH4n1vqf1JnDCvI3eXezRfZVlYpoTW6EwZa7TMrBGyNkH/Ste8CzvmZbRQ14+byuE07uT8JpR+sTVle8pqYEWvarIc53i9jPRW3JOtBgrz/IHVySLVA2oGaiUlep3NCrW4CGF7gVDwrJZ0Vp53wzrzsFpul6EiM1tcqiufp3RAilaXv9OM81SRLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYbeV5YSEW6aQjmrdZxVqYYi4qhkoUhKiRmlnHxtfD4=;
 b=KMMIB8fwfFqY26mpjKd3TLZ8pt1qeeHrhTpNDijTrxAgQtSl63UFS0h05AlnDggWJs0bwWntjA6XpN03mknRid+J1GXEkxkF9ITytANmMsSDyWM5vTwLXKZ7jqi55vbH3fIhWw3PxCVHYMwX6nR+KQ4g4+SRPU6Nrdn7JgrgJjDV2o/Dr7pwF+/GJR2EmnyRwH/j8B6wjWwQ/f+huWAo7RFMqmjleSKkKVaNfdXTqk+7g9k/HnhUN78WZiTY+T4hCVy5ib/xi8hYGDmHLVKdTuMIzCsdJ5ecYfngYUf9UzHlYL9nxkA1NaokXfM1H8Qymm2Qdy49lXVOri5p40B6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYbeV5YSEW6aQjmrdZxVqYYi4qhkoUhKiRmlnHxtfD4=;
 b=ZBvSJ7IB4I8SZ/2auzxEunyq24X37WZRdF/56wD4GMmnenee2QZxOxJr0DB2iOynraHCc1uidP4qrizr1AzbHlbcUsLRcA1RY7xpPARx8dy9Mab2wfGyt4ZWiPW8SttIeoFk+klB4AD3dHBvOyuDhtFEt+K7DLcxabUSgKu9qQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3319.eurprd04.prod.outlook.com (2603:10a6:209:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 03:10:14 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 03:10:14 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15.1 02/13] media: add nv12m_8l128 and nv12m_10be_8l128 video format.
Date:   Wed, 26 Jan 2022 11:09:21 +0800
Message-Id: <3fd0d09d382b827ddc7f97ca6e4d7b3e4c1bf4fc.1643165765.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643165764.git.ming.qian@nxp.com>
References: <cover.1643165764.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0091.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95e729b-b9fc-48a8-f4d8-08d9e0795f50
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3319:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB331970DB5877FB332FA1B015E7209@AM6PR0402MB3319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeNdTi1PbIB+A2aajmvBMwRA9tMqZ8vnMe3oZ2AAM0WWn8hC4XcgFnImOvjLsXOBBqMN5A89hmKuG8rbs8aATRSheOsxL5gsfg9cXjWsWcQSq5GV6psvYpg5GBHuZsQ2NGnDWuEju8PAZ4dZsjhkSPOTo+MgG8N87xjf6vFdNFTJtvpSDzATkLMe/YJr0hAndKDQ5O0ub2AUyXOXd00plEBC6mnEbEy7xoyjWkzUT18kb7yattU+XaK3dwAloRGeqdqKm//pk7bv1/KId8m54uugXv+w6TG2el4lSFlsHOqTKowxOEdPCfOhF62MjC6txU0j4owLDO7xvLkwnAYWm0UNv0deNwwOvixT9FOYdcEehS9wuvOJmctirkX7Do2UHyeXa/gP64de5DYJpOoQTduw42Hy0sB/HypKGRaCEx2Bg26QXWAyFq50ok51ijqRarcUwUeqPfm9Tsv7m/N+oYXHJRkg4npHO7tILYO4eFtvICM5HXDHZa5kNKSYh10+d2rpcdqXDF9XjDNLc9D0VCpJno3hPr5toBiF1Kv8Ifql5gTGgstRy6JRS8vAnx3IkvCceAuyS2/LgEpW6vBrvpW1SXRGVumG43vZzUTi8ulbSk8LqDn6V7FueLD5gVp0wtmw77qPmWA9ndHq7wMl/jgleV79oHX9ajUotIxmgOOBqgQD33nQmlD1yL/+w6/VDENXlJzVXHwilGjoiZNMNRpDltxwjRlMW3BGLRbqMGqFG3EWkXmap+efKAdTmjP+Ty5xNOvh4N2s4494sV5dHHZmCIzQVNJobPfNibVWElo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(2616005)(36756003)(316002)(966005)(186003)(26005)(6486002)(66946007)(66476007)(66556008)(8676002)(5660300002)(4326008)(86362001)(52116002)(6666004)(6506007)(6512007)(44832011)(7416002)(8936002)(38100700002)(38350700002)(2906002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dEEiz5q7UZUDb1v5k1NoU9rdMNAVrklyoqlQEyErv0OakW+pDLypG3xzZ1Um?=
 =?us-ascii?Q?NNrIGWY3yyKIeluLFO/+T7NeReVjJsSrR9FcK+FYPfCEmDhsPvXS8WGD7FAm?=
 =?us-ascii?Q?DOr77u/wlgpT3pk6E5eB9W6CH7pxyNGePyLzqRzFawLinKSYNXYCRAL2Zjkc?=
 =?us-ascii?Q?KTbhc0aV/wBBLIgIv/iY1Zpea8yYYXiOs65Ra8qW96o2Hr+1P3N97GtjDcVu?=
 =?us-ascii?Q?OWsGNA72MuEySurAS0a7NwY7fxURGKnsobf6fYJ7aFOqEsa40RzOUWWs0v/T?=
 =?us-ascii?Q?zVISMnUx+10uvLiLzPVkl6hZPh7rm/LUn4No7kwTP0bICxpQ5p2h+XDgKIER?=
 =?us-ascii?Q?PUHxuCnaM50cExdzXq4Z41A80gkbW0he0fO+Af9XUkIVUsaqd0RWelENR9k7?=
 =?us-ascii?Q?9pX/dBX+2WlfO60e9zrvMWn6RHjAW4pp9Dc4UDRfVv+YirOxtmr2z9q+nyLV?=
 =?us-ascii?Q?j7c8MlmDPhMhIObFaH8ue7aWeuPyHxq6sQV2VatZoCpWV3KvJOuqIZGjvCEl?=
 =?us-ascii?Q?GsENIQr1nE/MIfjPnXnTysxaZDUCTHRDDUxRDJUf1Avmw5ed2gWoe1rHJATS?=
 =?us-ascii?Q?XVy0SQx5fRwPl1+m1bXzERsYjjTEiITe92ernwN6tz5pr+GtkQtUz+b+FQdM?=
 =?us-ascii?Q?VbJ2p/phXq8g/CT2hzp+oKKwpXJXfh8fbYwesENY+yyzzzBexYoaH64zDCeU?=
 =?us-ascii?Q?a5RGRWDWhkUGsUOiRowaJOtPJYvPmaiUJKfA6a9KE1pOStBcYh+Qe2lKI0fe?=
 =?us-ascii?Q?jUaY3j1YTQobZ3t5o2qSzRP+u7oy4kotMDZ9/F2V0/iNFE2xjvnky/5+hySi?=
 =?us-ascii?Q?Hz1Dha0h3GGoVx1wPTDXJtLEGMeJ+IIrQRP66puDj78XU+GcVHyUrRCmZ4F6?=
 =?us-ascii?Q?8dv83LpPwg+U2E8/enqu3/Uii4xmYWRXqAmA1b5Aj6eGuS+TsuGF/TE2lnSA?=
 =?us-ascii?Q?zefC+w91AyIAfOTelTuT8if2LzHVRDAAmCL2fcDan1+qX2KaLDhl21kXKpFr?=
 =?us-ascii?Q?0ekohaAK4ttv54zhKJqBIsa/R+8qP5N1htvLv9zx6OTyfswPhb9PEwlY0SA0?=
 =?us-ascii?Q?udKZzoMdHjpOX5oRssewL1PBhDDMVeSQZ76fF7t/FgUWPk9A4cQRFCzAgjTD?=
 =?us-ascii?Q?UXZe8iblnKCEKewN6f4BWhIAUydZLNM3Gl6zbcByg1yosVnAJN6d5pJWG+Q1?=
 =?us-ascii?Q?y3X2UzDm130tuSWb3GhtRsPsRemyDx/xSjlMdZ2bqSnRwjdufBGYZuOtw2FD?=
 =?us-ascii?Q?vzrzUAOU1/uOaagRAPjTPSAW4S5Z7rO7pCjeaXJ4RETJ9hhFkHMIYXxjtAPw?=
 =?us-ascii?Q?/rV9qKEvclgLfxeewdOIk0SSh1DeCFIuaNARgGhJcxIXrm1Lw3n9WVvPvRCd?=
 =?us-ascii?Q?JDHWk8kIYJVJJD9Fqlyqvgcf++9lDxARh7ibV+mOcQmY0KTQcnZlPmzwxgo+?=
 =?us-ascii?Q?uFQ8Ggktc4XMh+ed1Ej/mXg+yZLz0z5I/551rblJhWd5kSE7PDkF6h9zezl2?=
 =?us-ascii?Q?otY4M1Ta+zgXcOWGDBbwtOZ024W6t6OLH+wWMDpq9EPgdStfZK/SOGrRQ+c3?=
 =?us-ascii?Q?pRgapU94TpfgFCS2TWVA/TawhXlsVK+lnEpgyzJBvFCaR87zuSmrz8A9ZF1K?=
 =?us-ascii?Q?g10wdNGiWPNviAYifXqnZbQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95e729b-b9fc-48a8-f4d8-08d9e0795f50
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 03:10:14.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNpnN0Qq9pmUYwkY7fOKFhR9MEnQ6ySbId7Yn2esj2raZzic8Slpa/Mb0UCV4F3IE3JHv6n5vj8Z0L3lrDrtuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nv12m_8l128 is 8-bit tiled nv12 format used by amphion decoder.
nv12m_10be_8l128 is 10-bit tiled format used by amphion decoder.
The tile size is 8x128

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 28 +++++++++++++++++--
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
 include/uapi/linux/videodev2.h                |  2 ++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 3a09d93d405b..8b2ff1d29639 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -257,6 +257,8 @@ of the luma plane.
 .. _V4L2-PIX-FMT-NV12-4L4:
 .. _V4L2-PIX-FMT-NV12-16L16:
 .. _V4L2-PIX-FMT-NV12-32L32:
+.. _V4L2_PIX_FMT_NV12M_8L128:
+.. _V4L2_PIX_FMT_NV12M_10BE_8L128:
 
 Tiled NV12
 ----------
@@ -281,21 +283,41 @@ If the vertical resolution is an odd number of tiles, the last row of
 tiles is stored in linear order. The layouts of the luma and chroma
 planes are identical.
 
-``V4L2_PIX_FMT_NV12_4L4`` stores pixel in 4x4 tiles, and stores
+``V4L2_PIX_FMT_NV12_4L4`` stores pixels in 4x4 tiles, and stores
 tiles linearly in memory. The line stride and image height must be
 aligned to a multiple of 4. The layouts of the luma and chroma planes are
 identical.
 
-``V4L2_PIX_FMT_NV12_16L16`` stores pixel in 16x16 tiles, and stores
+``V4L2_PIX_FMT_NV12_16L16`` stores pixels in 16x16 tiles, and stores
 tiles linearly in memory. The line stride and image height must be
 aligned to a multiple of 16. The layouts of the luma and chroma planes are
 identical.
 
-``V4L2_PIX_FMT_NV12_32L32`` stores pixel in 32x32 tiles, and stores
+``V4L2_PIX_FMT_NV12_32L32`` stores pixels in 32x32 tiles, and stores
 tiles linearly in memory. The line stride and image height must be
 aligned to a multiple of 32. The layouts of the luma and chroma planes are
 identical.
 
+``V4L2_PIX_FMT_NV12M_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
+pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
+The image height must be aligned to a multiple of 128.
+The layouts of the luma and chroma planes are identical.
+
+``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
+10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
+the data is arranged in big endian order.
+The image height must be aligned to a multiple of 128.
+The layouts of the luma and chroma planes are identical.
+Note the tile size is 8bytes multiplied by 128 bytes,
+it means that the low bits and high bits of one pixel may be in different tiles.
+The 10 bit pixels are packed, so 5 bytes contain 4 10-bit pixels layout like
+this (for luma):
+byte 0: Y0(bits 9-2)
+byte 1: Y0(bits 1-0) Y1(bits 9-4)
+byte 2: Y1(bits 3-0) Y2(bits 9-6)
+byte 3: Y2(bits 5-0) Y3(bits 9-8)
+byte 4: Y3(bits 7-0)
+
 .. _nv12mt:
 
 .. kernel-figure:: nv12mt.svg
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 9ac557b8e146..efbfda9ec3ce 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1388,6 +1388,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
 	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
 	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
+	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
+	case V4L2_PIX_FMT_NV12M_10BE_8L128:	descr = "10-bit NV12M (8x128 Linear, BE)"; break;
 
 	default:
 		/* Compressed formats */
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index df8b9c486ba1..3768a0a80830 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -632,6 +632,8 @@ struct v4l2_pix_format {
 /* Tiled YUV formats, non contiguous planes */
 #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 64x32 tiles */
 #define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
+#define V4L2_PIX_FMT_NV12M_8L128      v4l2_fourcc('N', 'A', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
+#define V4L2_PIX_FMT_NV12M_10BE_8L128 v4l2_fourcc_be('N', 'T', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
 
 /* Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.htm */
 #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1') /*  8  BGBG.. GRGR.. */
-- 
2.33.0

