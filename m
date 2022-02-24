Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2D4C221F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiBXDLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiBXDLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:11:42 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30043.outbound.protection.outlook.com [40.107.3.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CE2465EC;
        Wed, 23 Feb 2022 19:11:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH9YsA/ubo6g4HMyymO4uOql4F2iiSjbUrIWLorW7A95IvwCtU/vhmC/CRAqG2r9fvYUz1AihWJEjLrnPOlotchp3BfzngQLAF4S56F4r8o3gbW8mIOSAwrhJbm6QnUdA42sGfaMXD6fBP9idM9HDHaJljIyKEY4tZb0IkOS6ER+fHpcmynO8+yhmNenrbXlGObL6M8rCf58ZiEqXesMs/KsrfNy6UOnjCOoDM0BU3eEeU4Q/FguUTEfe6RXTDbmAvCKXZ908PkZQmGX94Okj0ZGBYTGPA1zrY6Y680zckYPFQHrqi6J4m12pbufnnMSBrkomfpW1n2r+fq1ONvI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plLDORXfJ0kB23R1bo+KVE2ciUsqdDqv8gmuxm1eh5c=;
 b=DyW+IvuqQB/+d1Netec81c6mQWht0LQ2UPMnd6a5sHijL68iynsmSR+zeUq87rfPtVhizeUuWKAdhrZONqQNhU+gNkF3XIvSYxkChmRDeFIt3y/r86AQn1A7WmZURN9AFIgjpj1ElYH32jdc2MvZuTQCBjgoOCNiTg6iCV6Z4645ksZex3FRg+ZaX+YSes4wxO+3LqfYHGNvaqk4fsopR0D9ZDhp1+yZdANxdbp13olZWWlwy6vy+f0CU7mkSo43XI9QF2VqT8JURYyNk6M8BQiq3mphfDhu8uArSUnXMc7dsh4evOKXzSJU2xxdrudpe4oZ1F2BZnpskp9luAOV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plLDORXfJ0kB23R1bo+KVE2ciUsqdDqv8gmuxm1eh5c=;
 b=lIctc8tcjduiL9PoxHEp62xXdVA+PJFWKJ5Jleicspvh13mNq7qy0FglSPJuH6xk5GA4CNlP945fICCKHh8X1mR/Tu5Pn/EDgpNkiC+HscZ7cQPKK+8U//LaPy93RpeBWKc9LS2ldNAvMFqij8p87P3IyIHYRhD0ALYm4A8cvC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 03:11:10 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 03:11:10 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 02/15] media: add nv12m_8l128 and nv12m_10be_8l128 video format.
Date:   Thu, 24 Feb 2022 11:10:00 +0800
Message-Id: <f73dc2332f965a9ab4380895a883119a8642e160.1645670589.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645670589.git.ming.qian@nxp.com>
References: <cover.1645670589.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5a648b5-b525-4e36-6a39-08d9f7434e71
X-MS-TrafficTypeDiagnostic: PA4PR04MB8013:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB80130CA9C64769DBD31A207EE73D9@PA4PR04MB8013.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CX/pXvzfzAJWJ29tHtqSTSZn4cqjwyCYNevEmv1ZnrvS0WLiiEs3c0owWgdsjvPtIRHf8vaEtolzmouGDsMyK45kFlVouMaFvDcVxBqED+ZusFyc1y08YYtnQzfgCRRy+WL8HQftBj/x4bhCxmPKlhrofiGh0g8yMpYxh0r7dZQ6qPcoG6QM8xzsxuCsBuFMj6IBsahOvtKsob3OSAED8xo9EL+galbjzEdDciQKn61VY2jdQvm/MnMarrAabQmKT2XPJTQhcvpfbd8K8wugbvNjlKnxvWevehfzAUCEUwCkKheSqDKk5q1UFw5IC94+pKFRg3ruNspOuDsjj1bMzicroqCZ4xX8ji4mvrsogsKwbydLViKrO33OFNp2rTYwqJk9QX+RzbtIRk1pxEbaYGenkZwFxKb349kHJUv891UTI1QgsC6HBleB7Resh+ne1jRbYlBaXq9EMXV6aWI/Kp+78fbjiE8n/lEdy5Feose00HA6m9ry6oCb1qFwae0R326d7LUoS+CC3MvwBKvv4ThES+gSkPrltkCq++UmQJgGcGzn11qQ8Au7OixXnorGzAVVxZzPwEK6zycLaYShw74va3H4B+YF8t5ZVAe+zpIeVKWkhveCqCxHCmrfaD3JvNJj0CLr+rOBL35IcQkfC5LayY/f+TiFit3GOd8X591Vk4uWEUj2ZUnWCAYrcIEpYXVUSrkOp/Wgu145BycQlU7I3OMaoo3vraKZGpfsgoaLu8MjDCvyOpGRyNRDKAiTRS4N4zBaDpE1SVEsOxaRS4Rza7tnKtD62uaMunlT5o4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2616005)(44832011)(6512007)(38100700002)(38350700002)(186003)(26005)(5660300002)(966005)(508600001)(6486002)(52116002)(6506007)(86362001)(6666004)(7416002)(66946007)(8936002)(2906002)(8676002)(4326008)(83380400001)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d7UNlTSRD6Aa2DMm6qtoMOPp/OdiSHQ9D8KNDwrHCm4NeIEdttcykD+XtJ1G?=
 =?us-ascii?Q?qsXb6czQUv1B1LefZ5URX0q/O77YMYKezJPEEVNMyjhLxjGyEO2bjLOTmlw9?=
 =?us-ascii?Q?uQd2G30YtpqNJl249MqrcD2AheXdzi/XKGwwjr5qaF2iZh0KVJ/V2rzOlLmc?=
 =?us-ascii?Q?r58XtR5f5rxWAieTaVFsjUPHsw5HnKfkVnV3grzIJXa2edkxwWJ6yVbuo1VS?=
 =?us-ascii?Q?rUpBVVZyW5ddaSGR7r+6ixJdupC7/m45lzoyAmrPTFkEu9QNXl2qzlPZSFn2?=
 =?us-ascii?Q?N0Q22eLq92/YxpKOXhE+Ldy4vpjuuxxRL34yOfVxO/oL6yjvhxl7JPSzdPKz?=
 =?us-ascii?Q?grVlMsgvuGb8yp3SeBQ7q5w+M7gn1oyS5KdFRzYlBmixKSSzB8I7KvmNvidU?=
 =?us-ascii?Q?3hA8gEwc6ndCa+cwP8vOv+OQyyTdtmLvNOnbb1bUjqn3D82M3g7yv5VUbKk9?=
 =?us-ascii?Q?UgxWvYttqmtTacmw2Z/7/gAn47ObOqwk7BIjGRbKjGBu2JrS3GhHECSBxBV5?=
 =?us-ascii?Q?TmQs2imcezewlqwlUlAZrHhMmw4NHG4j1Lh9HaOIbm+Ca8aXAmbS3uiOq2kH?=
 =?us-ascii?Q?rPnXxuYds9fmLGhTvNo7R99yVn2gfPkZpDOGNYC9J40DbLmGfHT+jL7SvkIn?=
 =?us-ascii?Q?D02l4U+Rvw5QYvseD/0oRdVxHzOGWp+Jm63dSBI8acqfi83/UUzZ3L9lFb5q?=
 =?us-ascii?Q?1EQe65vb/9AKQqlka/xgjlZgAlTUyjyYbGSh54FolKwI5ckEFc6GF6kv9I9n?=
 =?us-ascii?Q?zVP6YibatZ9EWHW34ERsz8AIzj4ZNS2aRwzZeNxLEkYmFScLW1FgsS984Zz5?=
 =?us-ascii?Q?zsZusm+MZwHaBJA3TOdFB8lzFXbtCWx+morldmSkBmALi0FDCSn25BoOT38F?=
 =?us-ascii?Q?hYXvT+d6JCm6KEH3Dbo0yjXxT1jSiAAi2J1mpZeM4JIydZLXqzdXcBkGul0S?=
 =?us-ascii?Q?aavbtbuiDdN3c2QolMfsZuTqJtXPpXOyvIiMAyXVrvX7LqRY6DKv7yrr/6j/?=
 =?us-ascii?Q?NugxCi1dcHoHV6GLlCT0FSWlrzGz6MLxEDXRSr7CGRGnR/ilJ6uQCctWxDmM?=
 =?us-ascii?Q?amU7QRb9rhm/FDAzJiWAWhu4+Y9N/OjFznkDpor+l9NtwwM/srcGN60uhkWs?=
 =?us-ascii?Q?05ywtdC+u6bs3mABA03Z3rMFN1Q5GMoaPZCUTML2i2/FTCGDwzENSuvaoSWL?=
 =?us-ascii?Q?Q5aikO1FNS8T7nc4RDo+P+MNGIkcW67HVAF0pLgauk1Ka37S5p6hz7v1Nsfj?=
 =?us-ascii?Q?voFysOtTgDS4TKTMvgUkt8YoE8F6BlocP59ehn0i0LhQRGRz3nJt/0BBoYDo?=
 =?us-ascii?Q?nnPIgvQMCPVp1E+aELhEm20G30OiQqjXAyuUJFdMuTTX3OGvSxeKs520xyUw?=
 =?us-ascii?Q?FlUdcgW7zuyjFrhtiCFJmK7rRqAQaP6zCe0GbdKVK4JwxvqdoWjErLU5G05W?=
 =?us-ascii?Q?h0q1c+VRUnfXJio3bNz01WC0bcVXI42VnkH76B+5CuDSsNguOgGKQ7J3GugU?=
 =?us-ascii?Q?Nw0/7SnrY5EmYfJn4ZXdZzfYbYHRQY2E4nEew8Abocd/INXB6BWmpP78hq4L?=
 =?us-ascii?Q?pLeOjTl9RnaTtDg9hWjOGp+grOAQ1ZfvbvkkMdDF7vZkPgL1qIG3sTvUn/NE?=
 =?us-ascii?Q?meI0/utJ7ki/ooYvR66LNGk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a648b5-b525-4e36-6a39-08d9f7434e71
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:11:10.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OSRC3QJ6uIrkh+lxOK0NhQFgiPni9zCf9Nx44UAUIhhiFl6sXfhN3h2w8vB3mKa8o6qMpu4JTTTcG5dhQUjbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 642cb90f457c..96e307fe3aab 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1390,6 +1390,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
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

