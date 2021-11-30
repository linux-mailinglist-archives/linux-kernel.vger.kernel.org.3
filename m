Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B034463017
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhK3Jwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:52:33 -0500
Received: from mail-am6eur05on2085.outbound.protection.outlook.com ([40.107.22.85]:18944
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240433AbhK3JwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:52:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+qDu6LIjPydH4rjxyG3tUx1gv8dw4IdYDNfoNDPv11kXinH5UwBSS8AibwZjrUvQ2LY+CFNrnjbIo8Iwa8Vzhau9Sky0bWGwnXnLG5T3qejTRJDZJG9HkaUdcCx7MUEQPUFf1ni/bkI+Qjwv6qMBUKeJW/47cZnltoI3GKl5Zd5LaCccxhzbZ0RUooZBIONQFRJnISeak9DYA2FE6aHw3VOZ9kcSjvl6GqVU6bODb0k7kmcKeTusgYG2lQlVS3F5xSyrzNSfMWLK49sumTznVlDMkGhZKM5FPktiGYhYwtJ+Wo01+dFS+bWzaetcH/9fYed9nd4L9UxQmyQ5hFkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtU7FvvwOc+jbgZZPx8l2ZglKfjTgal3fo2WXpa3c6w=;
 b=PxZ5Cj2zj0mFQW6JtJvhvho34QXOPdthzEMQ+Mb7ysz1SPcjd/SLE8x6eg17/WXejXM2SiFvC1SNK2R+dRkwXxeNSV4U439L0cAgPvqKzd0QDHw7pTWdje/pY7z/fc2BCEDaONUXwxCkOYKxuusFLSC8u3ooS8i25Z6s6P9X2YEnGcOY7RiG9v8qYYMGwFzqx1dtcDMBeM6bI8f4gkQMqaQQPYuvNWe553ttzZ8IC72+8OrrvMDq0nUsALV25nFxpCKTPksly/+6D0xi2RCqj17B/Y1FcS4Z4M9YasTprFrWTB1G63Lne4JkKMlT4/dlRu1M6qeXiGhkS55hY++5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtU7FvvwOc+jbgZZPx8l2ZglKfjTgal3fo2WXpa3c6w=;
 b=GC44UHisCFVbpSC8V71v+FoZ5mowza7qqGogaq3t1KQQk/FDT3pVBV7s2+MfP09cCfEj9ByW1JYXU5QHoY1l1CGOLCdHOwCislFXD7IXFq/AupuvCRB0I5UENMlG+iqDio2cSQVqM1VYhwyOKvvPJPUwD+vxo6WduZ+tAzh85Gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3925.eurprd04.prod.outlook.com (2603:10a6:209:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:48:44 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:48:44 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 02/13] media:Add nv12mt_8l128 and nv12mt_10be_8l128 video format.
Date:   Tue, 30 Nov 2021 17:48:03 +0800
Message-Id: <c7a7bf7a1d3c10a0e28064e37a472cbd45470e82.1638263914.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638263914.git.ming.qian@nxp.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SI2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 30 Nov 2021 09:48:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 620c967c-7ec6-445a-472e-08d9b3e6994f
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3925:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3925BEE0C945911A49F6C19DE7679@AM6PR0402MB3925.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoYS0JaKKMAzk3N8+Zt5rgaZ1a7MSWqwM4usUJhnIwNPx+8DS0WdAGpnjkXyfo3NHIvcqTereLoymM4VQMDUntTSk44bQig8e25R3l9CDGPShCZSsj8tPT/v9klAaBt/6HIZI/TEKNyQyaoEXy6PX++nzyIKCRqKX7iX0zE2XbLXhP8mFqr8Sp5DMvkZymVZ2GBCpookzd1PCvxVCdxLAgtMHPWDWCmCOFHzuttDakOELMjD94cZuaQtZRzVmohXlxuWMnXeaTOjSehrrymSqDFTrOEjRxFf4R9SbyWRDio/d1QTOC0pK1WAor7MgLD9eR4vcrNFyYGdLrLJKxd/RQdy73Z7hB0SkonLDFpUmRyS3TNlk0Eec2wzuMbBtYCUK3eva16v6Qd8GSp//frFpbLH5B8kyJ/Ko+rhd5gCvinUPJksXEGYW/xXkbXKToNR/ocyKBFGIgTFg6EMX5b3vhr28i6UkNsecxsaJeAwmUPYeDliuV2KBmvOxsqtpH3CW+mJKs4fOEaacCWKCHNLOXYcc7gCZ+EKfO74eCLNU27IhjAwToA9gcW0yIw+IksN2LO6D+OiVPcKYMcc3tARv0/E2yc+hj8NTwhtV04MUIURhyMZHmXuJ9ySHmXhgDxF2KYIQ7bBuOWbdA7ZpRuzG7Td+RSE5cHgpPNgRqZePr7RFDR9MHDPWsMyExYjI/hN4ZdyUfoPUY9kgQhvAXUhTPDUfcnlr2ho/+pnbXGdK2QvBm7IeDj6ag6bGNPMrjC/3iMuknwC7i0sDvKh0enfY85zSoNs5+/QEIojGp9YS/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(52116002)(8936002)(6666004)(966005)(508600001)(66556008)(7416002)(316002)(86362001)(6486002)(26005)(186003)(956004)(36756003)(2906002)(8676002)(7696005)(44832011)(66476007)(4326008)(38350700002)(2616005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzHlY+RKGM9F1iRjewJFv0+PpgahhOrvNffz3EG1oJGhmZZ5x6RNxegckWbl?=
 =?us-ascii?Q?hlV1trd3+hWldkDVdqGzGKyC1Hk9tzTA2PwKhwrDqt3JlCFE4dNWpRSViXOW?=
 =?us-ascii?Q?soi1U+LJ883L7Yk4FURdyrd9UUvrmpPP9Dp7+SKaqt9wCO0US5vi77USrdaM?=
 =?us-ascii?Q?rxG2tSWNuEAB7G7RWttbbAweb4b5QyPEaOC+fH4vd5DlUk+Kvn7ayNA5/GZj?=
 =?us-ascii?Q?1GviNxGSBrsLACuz7tBG2UJdIGwUBOs9cprWOaRcUjvTjPhn+VFEmkvGE1sq?=
 =?us-ascii?Q?HPp1reaJrp9gxX9Zxdot5CfKffntkT75ifX1/lYZLbFAsaQj0iGuwoneJBuP?=
 =?us-ascii?Q?tLdq9ZkPL1yTflfuqDngHKO6gvKH9SQcJ/Yb8sUTvz72c7iwZQGfNEjibQkT?=
 =?us-ascii?Q?Fl89y0FJoeXurNsGPkrzHe6JEO39/9mcPvgx7VTxxDitFxF5eXSQsmOuEEzZ?=
 =?us-ascii?Q?VzOOKgzX5ZdHEyyNDiCQlCdcAWOFABCSdRb989v9FbdkfjBqLq/bkN8iFW/t?=
 =?us-ascii?Q?mcAHKup6c/hgFmhCxqqpMd412kw0he9DH+Oz/PHoOSIcHdohHAzXEcjdMrxz?=
 =?us-ascii?Q?Jo40WJSlfGf0O7dlJ6ZdXwdJ/333OGmuUhYJw85kKzqLavDU2zLYduZVxQu3?=
 =?us-ascii?Q?19EgVxqJPeKpNUTh6WzjqypHbi/AMPgilkoxhpDarZuLko1XiFWsali/QNaV?=
 =?us-ascii?Q?GNdI1I1aMZCbDezbixnWEJRN4Ef05xDYKrklMnsZu2xbC7PRuv47i0GAVjqG?=
 =?us-ascii?Q?EQx6SAg971xxDJM83EKn0N7/O4yj3Sgcv+hMmmjNa41nj2VgB7YJD74RBKfs?=
 =?us-ascii?Q?GhZpaXY5/1fyvAyguTGX/f3KtzqVhTgVQmOdoP0RyPLoLF8BnQM/jFUaW9G4?=
 =?us-ascii?Q?eGvBvVnWMlMn5M+4fu1DSOYmant2euJj3WbNjHLjLFoavhokwOyZdG0VSCcM?=
 =?us-ascii?Q?R2h1rv2jTQs2bP1WrM0k3R6+jqVq12X0rl4s96c3IgiL0UbFPUtiktZVNEOy?=
 =?us-ascii?Q?y2k7tJdb3D/2emjyqQLqtCFSKec8c80MH9hE796vYbkl8lCAH5ps+FhAdwt2?=
 =?us-ascii?Q?B2GkozV2xePJs58clkkUdtf75uSsFFBSwfkahoIWILkyXv/rh2XNenD+/Dtn?=
 =?us-ascii?Q?mxLxahZlQiP1QcwHHmLespWfuj9LnaI4/o+GnceXy3TEwmiA/XerWgJIG/ps?=
 =?us-ascii?Q?L69hifAUSE6snwP537SpTYSk7LRlC4u2iGuCCQDUexrb1spHqsZrsv33qxmL?=
 =?us-ascii?Q?qrKLL7K+t6YTmlGs46qpxlBuUsQzM8gRv85hycB2PLXsUV3BomNh5GSzCBmL?=
 =?us-ascii?Q?aRR42YFZW3T3RWWaZAhv1u2R3MhSeslPAZ/Fc9bYCwIS4jriimXpm3xx/+1y?=
 =?us-ascii?Q?7x6T6GDGbf+leb0u8ZfbZgGpHk52dhqD/HYiLj+UrubWQo7nWdhH/TnjIwc5?=
 =?us-ascii?Q?/UL4YeJdRpi5oW6M1bUu8OsEfV/fG/DLFcLs1q9N4VJFdhwvmwJQmHBNX0Ud?=
 =?us-ascii?Q?25u0OjAS52VAB0b2t9nDCwyAj1mcBiRHea501Rd0pes+hcORz+MU+As7Kq0n?=
 =?us-ascii?Q?+LTAwYJAyzJAP8zPSIwmJKTKj7CdY6mBr+8D2FCbA+gwnPRkqRedNlvBnFZV?=
 =?us-ascii?Q?LH1al5pStuqJvXaegaTgDnA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620c967c-7ec6-445a-472e-08d9b3e6994f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:48:44.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G55ul6ltLfU5hiCZrvq0MqmPeLVIZ81U5IYTH/NTeBxoMEavrbzJqZBfyC7qmF9FGrVSFbq2rXoJA5sPIu7P/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3925
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nv12mt_8l128 is 8-bit tiled nv12 format used by amphion decoder.
nv12mt_10be_8l128 is 10-bit tiled format used by amphion decoder.
The tile size is 8x128

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst | 15 +++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c              |  2 ++
 include/uapi/linux/videodev2.h                    |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 3a09d93d405b..fc3baa2753ab 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -257,6 +257,8 @@ of the luma plane.
 .. _V4L2-PIX-FMT-NV12-4L4:
 .. _V4L2-PIX-FMT-NV12-16L16:
 .. _V4L2-PIX-FMT-NV12-32L32:
+.. _V4L2_PIX_FMT_NV12MT_8L128:
+.. _V4L2_PIX_FMT_NV12MT_10BE_8L128:
 
 Tiled NV12
 ----------
@@ -296,6 +298,19 @@ tiles linearly in memory. The line stride and image height must be
 aligned to a multiple of 32. The layouts of the luma and chroma planes are
 identical.
 
+``V4L2_PIX_FMT_NV12MT_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
+pixel in 2D 8x128 tiles, and stores tiles linearly in memory.
+The image height must be aligned to a multiple of 128.
+The layouts of the luma and chroma planes are identical.
+
+``V4L2_PIX_FMT_NV12MT_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
+10 bits pixel in 2D 8x128 tiles, and stores tiles linearly in memory.
+the data is arranged at the big end.
+The image height must be aligned to a multiple of 128.
+The layouts of the luma and chroma planes are identical.
+Note the tile size is 8bytes multiplied by 128 bytes,
+it means that the low bits and high bits of one pixel may be in differnt tiles.
+
 .. _nv12mt:
 
 .. kernel-figure:: nv12mt.svg
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 69b74d0e8a90..400eec0157a7 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1388,6 +1388,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
 	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
 	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
+	case V4L2_PIX_FMT_NV12MT_8L128:	descr = "NV12M (8x128 Linear)"; break;
+	case V4L2_PIX_FMT_NV12MT_10BE_8L128:	descr = "NV12M 10BE(8x128 Linear)"; break;
 
 	default:
 		/* Compressed formats */
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index f118fe7a9f58..9443c3109928 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -632,6 +632,8 @@ struct v4l2_pix_format {
 /* Tiled YUV formats, non contiguous planes */
 #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 64x32 tiles */
 #define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
+#define V4L2_PIX_FMT_NV12MT_8L128      v4l2_fourcc('N', 'A', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
+#define V4L2_PIX_FMT_NV12MT_10BE_8L128 v4l2_fourcc('N', 'T', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
 
 /* Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.htm */
 #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1') /*  8  BGBG.. GRGR.. */
-- 
2.33.0

