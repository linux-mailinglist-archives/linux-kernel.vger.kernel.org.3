Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0649AD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443654AbiAYHQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:16:10 -0500
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:17353
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1443020AbiAYHMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:12:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA2CegCBiHqKxgHgyS3s3K1sNYYVK+xpXtLirfY+F1mnqAXyXVO8XFq8vd4mj+jv8V25QeHU0FrFfaVWehl5NzgmmsOUZbelJICbq3W7i5AaACVp90toMDCcnujF6zMwxLbTpg5UN8/qmP8fdUPFe5VaE8h3OM6JqULuNZUeKym6zJl1s4oinxHsVIQq7qOXwnj7JsOg65XG61cmDQch01ukf/HBl5yfIeBZpz+R/br53/6aEY5ZxX54W/W8KDYuR1A0ahMjlknoEJgpd2iiKqT0KMJDA4KNnTAnxk0QrBZDp1gERJw9C30LozD4RsySFZ3XC5cZBlCp5M3K+EAqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYbeV5YSEW6aQjmrdZxVqYYi4qhkoUhKiRmlnHxtfD4=;
 b=JCc+Tl8opj0VF96ojyceE9Qy1eoAR082YITri98wk8SmElv9JJyw3YefaT7c2c5exv7Sq4/ieKq1eY2k1YmZJ2hptVTQt9JHg2ELI2S5IDcfE+yz3YtjX09BPyeuz7KdivauAWO+581XIsKByGIrjGy0muQUWl3bp6l57XxEjL6bj9evGJl1DPRpKDIUFtKuiqiirpk1gadDmbBvppOrP/jcm8TcSC2WqiQiPK8JOX8NdXP0oFs/lA/W9gfEpf12jp2DCzhh8FUoMgBXfqBI3Xoy1vw47rVdbcrdB880scd3NHv48al4sZLoFRHc5xyo2zBxXwjwJf+dN3GQb56wpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYbeV5YSEW6aQjmrdZxVqYYi4qhkoUhKiRmlnHxtfD4=;
 b=YgsGkRK2dxEGznAR7LrXrU46yPpE9SBwa7yWI+jnKOuD/lKl3akYDs/OBXgJDshqfY5tHW7nZbfh4Hh79pp8zaC9pGKC3Wu6NqsN9RimapRerIDmdC79uyrLy3jzCxCwSyfXBMPQnJVrPsI3yEru52AZ8xEJuwPaCMsEAUXXybw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4094.eurprd04.prod.outlook.com (2603:10a6:803:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 07:11:59 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 07:11:59 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 02/13] media: add nv12m_8l128 and nv12m_10be_8l128 video format.
Date:   Tue, 25 Jan 2022 15:11:18 +0800
Message-Id: <3fd0d09d382b827ddc7f97ca6e4d7b3e4c1bf4fc.1643077283.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643077283.git.ming.qian@nxp.com>
References: <cover.1643077283.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71ac2bdb-4968-4d0a-dd90-08d9dfd1faa2
X-MS-TrafficTypeDiagnostic: VI1PR04MB4094:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4094C05184E1D39D785FB826E75F9@VI1PR04MB4094.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTduAFPonsfMP1ZPb7g8PHzFIEHUs9LGZHgfaPy0dAjSWL6LluOFfcBb3VsFjHxaZwo2psqJMBbyz9jhJ8A9wUgyD7CameEnaHB3JjFnQF22FxJ7jgriy1VUsFx1OX55a1br4Y1D3X3puud8ByOmxY/huZrb6kEn1utxYs1QpCdB64AnWAd5TcPj+mmLkDXDP9TH0LX97T0gjjtYK3syoEwkL2HW1RszxS9yPcGUbJqDUb9QaAjzL+ueFhlst2VblSlkewXyyw4CFPzzxeDBrM5U3kYJe7EWeKqfDj9iWRCC/uHD2LxtGABqfIYoK2+xssyFA5hZJJ6mfz7Wfk9IUZH4nFHUKEBDEwuU/aRpD600fbaSmG+BNt+iSUn8aqTp9PRULh1ZOxmZTPCK2FYf3HRoPVi2sDKMKPJQy9cFIR5EYhDAUztKgI1Dwwb2l+51SHHQODMy9+7f8Y6glh/m4Ry7xDjoypT4qS6p7EL2eFjjee9uOCiza1susbXs+whGE3bk2o5JtOVZ6uUSQwQDuZhx86H6nBWExr7mAaQft4DVjahcsadh8FKTo25G0xxITUm3xCbzY+Xckz40dg6oZImL9uS7QcRRxEbIRuzHHjvat4L4p5RaHmohFfsElu6zELf/VcIe8a6MNB5q5KZdPA7mXp6Q/IXGC/FezMBK9fUphe7jQJFsHIuSmbKSo77iy3dug4WggVU9T6oqEYUcdJdVTklmsrfKGCrDLs6itu9uVG23TVkmdl6PJROVNulMm5xiEGQaqeW6TcHtXZylYQ9rMarUTfhxB8IcBfnNfOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(966005)(6666004)(5660300002)(2616005)(7416002)(8676002)(36756003)(44832011)(86362001)(316002)(4326008)(38350700002)(6512007)(38100700002)(66476007)(66556008)(83380400001)(52116002)(6486002)(66946007)(6506007)(2906002)(186003)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nxkx1Gz7duqo1E2tvltXWF/e4R8aKtlz+D7ukZhUjGfP5OZH0i42Cy3riQiM?=
 =?us-ascii?Q?CQrK/KEVUt4OKy5Xv4lJ6ZUhDj2rowrnGTxRxFpJ+Q/Oq5Dhs4LlswUUwuQw?=
 =?us-ascii?Q?jGSpit3EzbVSCfnhYBDWnWDkOAD7OTtBTR7ce+4BIMTnHAJNdmRl6IN3bSSY?=
 =?us-ascii?Q?vLqRcGxzGWIwaNrMSs1crhGg7xeawVmlNrEViS4uqnb/7CiyhEyxX4RWAdfS?=
 =?us-ascii?Q?FMZbFMFk9dlGxrahzebGWdjqyA+agWX0TQPWGTEtaa5FnkrCcJ2//Y68eW6q?=
 =?us-ascii?Q?bZDpzLcnNliS9M/sLjI8ZD1N1Xj9RAOZwrJUO7JV0pDdP5oRJVIMmp+zskl6?=
 =?us-ascii?Q?/gHIkyUIVndl4oBgxeY+1xE7U/AOK6xf3IKISEwF/LYVPC6tdNMSEJtVa6SE?=
 =?us-ascii?Q?GnfuvN9qDKpW4ruUYZHQhwXweEBZ5vlkU4MVaKjkgA26yw1M8qMqiUo2dV51?=
 =?us-ascii?Q?K47n5KGpsWRTvQRuSCzCR/Zi8NpsL1bIneKppeVnfUuQM91MMvWcde/eR/lp?=
 =?us-ascii?Q?9R/BYi7xZzbbWgJzMQJbNtBfpULg95vFZv+/Wz6532kg0C4+mfw06A/cBYR7?=
 =?us-ascii?Q?zC3+BAEwXCZ8QaUnXtgVQ0Xegh5EdO4VVf1LabWpXc9v9aDK1I4/O5bXQ6L1?=
 =?us-ascii?Q?EXl/VhLePhkfpJ4rEshu2X4acVvGWQzZj/DvQtIkvilV3ul/GCSb5qcpVWAP?=
 =?us-ascii?Q?aF7IClNlouwIPw5gqNDdb4gEChIV3vylqiHE/5R5g4qZooFxVTdDKefMfS07?=
 =?us-ascii?Q?Uqb+GJsk7vfkUUYmuGlI0kv3tYEan9+Mlu+mjfeE011/dqWe9VVzJTAw1T0O?=
 =?us-ascii?Q?c6O08Mx5omRhl8/DdndX3oiybmR8EIxdMducr20spgQfCgDkpooqS+Fe46Wx?=
 =?us-ascii?Q?bIf3f4Ir8U6gDO2tkRabEmb1Yvb+I+oStjQVIhZ5exqsAP2gXDuTUzBvVw9n?=
 =?us-ascii?Q?9/fZxDgxDpb4YgFH2xPru3Q9NaiD69ALEFGcf5jlqnRQJpa3JMHWxXXXRwF7?=
 =?us-ascii?Q?uG+/7BgVrPH8Vghe1g2pDl89sKjPu+MgXiLt/ZHe6HhioVQplBywdCow08fq?=
 =?us-ascii?Q?JuPwXmkdUPg1+K3L4V+KI2SjcPwMV/l2wJhX0KY7i2Jnq/uRVfKnMZO4xf5J?=
 =?us-ascii?Q?jwHnZmfCRA9GhH7xse8bP/wZOh+oJfE1c3qG+Q4ODUx3b8DU2AZSk9VdQ2WQ?=
 =?us-ascii?Q?qCx9haljT+NXJIb2lpmYOaqYmFrlEZ5nKEp8HWLE00jiK2Q75tkEVqzCsQpJ?=
 =?us-ascii?Q?QY8KRK3Z559fReoHaMYVsVQRoD5uI4XVaN9kon7eSR4HEWMjoaiSMvMMesgK?=
 =?us-ascii?Q?54JbgDuXIZ4fUMm312t1gFN5frYgrXeykePkthCt6vBWFUigxp/iuV69vWCw?=
 =?us-ascii?Q?T20/ZNTu5WyurVwoINiSDJKEZCsWOoPvQCKWtQF13IRp+zMmcQD9UsBSnbob?=
 =?us-ascii?Q?Mi4Q/I5cHtJYiH+lu+Ag8UNNlrNxzWB7+TXQeNORe34uWrfFrFhdo15A7hF5?=
 =?us-ascii?Q?tE1VMOSTvtjkklsNeKzzfNR1kuEMIHOKewMnyJflwGBRByT8DTbxp4pg3sfC?=
 =?us-ascii?Q?avYrMBuul44es+4WtlH1pfCw4C8CcpUg1zh1B0dNbrGA8c2YU19hkUj4R7Nj?=
 =?us-ascii?Q?DTb8vpYj85fPGVNECbnDSEE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ac2bdb-4968-4d0a-dd90-08d9dfd1faa2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 07:11:59.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sB6MOq5fZFbjYwIe03N8N5LUUaRxjBbSNGssiTmtA6fMlnqospC5QRv5I5b9jpLters9RX2b0HED9fiQeymhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4094
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

