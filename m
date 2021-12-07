Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4428D46B5BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhLGI2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:28:45 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:34488
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232627AbhLGI2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:28:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+DC9MAyASOz6HzTm5S9IO+mpLAPPD4olrNYY9cpQAS/rqZmXel6CsS1JZEv42AY8a0IIciVNEJj39JuLj0MxSrlNugZfus1cJonV/Snt2ym52fZwk4JSFCS5gq1r7n1N/bgAPL8GphIWXQS5RFLp9QNTDGuh6oPZ/3NQnA2iGWspF9dr65EiLl/9iY0TFU+QymeO6xEdM69XHfq5xfNqkDCxixahIouvejdtzilKMvgqGTKOoiXx+bAyPq4aXGPVgonSyth8zrgjDYjLmbBNwTNjomDobW/udlWn3aX6FkRlQWiT8N6jH88deQeSCTR3/phViQErtC8D8lovqDkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYbeV5YSEW6aQjmrdZxVqYYi4qhkoUhKiRmlnHxtfD4=;
 b=kfuOUMsOUlNPWnFEuk8lvLdzlRKleSqbnjIhAyA4W6G/DVsyGj4M/wFwjEXiAawqh4q5J48Aw4m7sArZ7Vu2Dl7TDLyoV+ecChT0uAodI1c0Tv23M7fPNwfravf7mV0e2vqQdw20r571daQt+AbLvoCvRfsRO+dl5UkSLx4BAIrOwQzS78ecG4NfnK7R5HaAvxehApgkb3+P4Evrp/LFxVFt+h3BdQjkK3GAJxTdUMLRuOok9aG5Dbkk/TgX/fOnqnuc3ho3PMbna0QVQT3bA7pFWgI5QaXCtb9YPlfIo2SXBD8zQdykyT6y2NzoUBlktrwTJUU4NZ7Ewz3kmWsc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYbeV5YSEW6aQjmrdZxVqYYi4qhkoUhKiRmlnHxtfD4=;
 b=mbsQaGwhK4CAFjQOQ6jpo6A3rKr2N2UP4CI+f2BkrILF3skH5aXZ/6fC7s40Bp0uptvtZdxDCG+wR7d6qhT9MENkykkGwbc4tnLyfKsCt6fSJaHF1TeZDRQDZUA9QEAEAu8lRNGpcurrXMhf/00VlNbneP9UKQSTTRpc8mFlAcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB2978.eurprd04.prod.outlook.com (2603:10a6:206:5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 08:25:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:25:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v14 02/13] media: add nv12m_8l128 and nv12m_10be_8l128 video format.
Date:   Tue,  7 Dec 2021 16:24:17 +0800
Message-Id: <cad874cbf962f46f0b8ed00ec7e15debb591c483.1638865027.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638865027.git.ming.qian@nxp.com>
References: <cover.1638865027.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 08:25:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52422668-ae2b-448a-3e88-08d9b95b15ba
X-MS-TrafficTypeDiagnostic: AM5PR04MB2978:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB2978B6AF3A9F27068E866303E76E9@AM5PR04MB2978.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVsdoQC0BMm0Qa2aXzZoKYNmEWXu+OrUAWVA2OGwXhUjwV6X/EPW7sy+XoNVvO3CqCBJm9yRNkaw6iaGpII0g5OTQ95M5Mx5E2nBkBHpF0Rd7k+Y+8JvCJX/hwWeAOmuU9k5e7j95TmMEkjMd87qSAOq8OgD8uES95gJHXmwwicPTKfkBlIk6rDLuO8oQFI2+4u/k4ltRZPYCS7HkvQtE5YuTkVD2FXUB0LzanFWxNfclg3XMYd9Nx4yh6mOeD0lOCaHXgQDmyb7YfyUNZNWCMQgE60mJR5CiWf1k2kPE2Kaj1cI49b4WWCROt+no62p9N6sESArUpyRixU9o3bMWhz2NiHiTBJPDa1xE8TG07lZjQYAcZhExkc/p7w9LuVCVaXQMljSQy6ykmmpqWKNPg4N+SnQmjoXnnXAJCdtRn+6KQEKUBqpnP4AAWcbzZujBqivEsld607Y5+j7JHQrNrAWqOrkhbC+mqAlqEllOKTHIn0pwY6I+cA0dUbUIcz6ckUKN3iLssVg/9mB84Xr/ydr/cvj4RUhXp59nRGg7i71ldbpvOYlD6vx6P0nVLdwRw0onNX+7OdP3E7zMqKrqiVou/6TyOyB/KqTpjmi5dGpQiP/ebz11i1xjiS4dpg3FyOCLkuTuoz4P4Jt7Z3kKK8qOB8rw4bJj+n4zk/EpZOMk7+BIl3QBxzBzT1mM94CUkgdN87WM8w5GSIDSDShBx8VNwwD0pIdfZ4jKjJtDSXEsSx5rghp4fxUTy81pm3cDHkAVaWTjiIApHqu+slhrFnZti6mBbF0J48LQURkwjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(7696005)(44832011)(6666004)(508600001)(966005)(316002)(5660300002)(7416002)(4326008)(8676002)(36756003)(956004)(38350700002)(38100700002)(186003)(2616005)(83380400001)(26005)(2906002)(66946007)(66476007)(8936002)(86362001)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jsD/Guyrb/8ykZZRpjcQul7BXeSkk5XUasJaWZXGAd5NunjFT3QBJcSk/P2O?=
 =?us-ascii?Q?0TVQfB6NVifr4/SxeH153Wwsn4bbXm0YAg16p3Yse/fyKlfXlfXXUdLAlJFf?=
 =?us-ascii?Q?lRVMmfn/fiRykiq4TBJ0SeBoO3KjOycqKYeMPWlwkkyLF2e44ODKPJrWRLdk?=
 =?us-ascii?Q?Vintm4g9dY+zpJ01/9fWhFa3seNHG6J+VrtKL+2Mt2+12GAW2vVjmLDJoLNL?=
 =?us-ascii?Q?SyZzfagMjJcKj8a9P6DG4pUc1G5lfETkb7tcKwoV7rkXrtBV3hlvJvKznI6L?=
 =?us-ascii?Q?yuOi5+jzQzyS+N10UBk1zx6RtB3VjdGWcozJrlXL8yfWJcJRPcFWw8m87hDF?=
 =?us-ascii?Q?6kvwEpBgWIRtvI1EH2YeofbpFYJxWN37K0UfH39CHg1NKIfapQ31p6boCRoN?=
 =?us-ascii?Q?3yq3+0HSXDr0ExLN+pheMnXyg7DxLjL6F/dleBDh/8ywwUCC/a6TBrMK247i?=
 =?us-ascii?Q?8yywR7paEwOpMYwPy0NSuF0vTS4n9bhauOQ70yhMZLjomvNUkeGkIJViG9jP?=
 =?us-ascii?Q?+0UP0chwJTfBfixmZF1Fusnn1zPAYyhW4ch4iLJMH36fY0lLtZUJY4U8j1mT?=
 =?us-ascii?Q?gDflL5RYMvjRYhKJutkZe8IA5fNzdOxstyyKKqLH45cvYpAw2g7MOHjgArUG?=
 =?us-ascii?Q?+Vf65XIbU2yWsjX/NL6VcRDy+RMASQ2GFVC40H41S1/DQbuxNNmPkNTDSWvY?=
 =?us-ascii?Q?f3vnDzSQbpRhkea0Vgu0eAhPNE0Mf/U02LrSS89WltyeXD1nZD0LheWHI9bm?=
 =?us-ascii?Q?CDlcEXw7A34yeNNK6SQQBhGlb3f3seHRIZsHnBOoy2sKD5Aq1BKbqdpq0Mho?=
 =?us-ascii?Q?8fgZhPWoZ9KDmv7MPKLrGWJ2WPkyT7rznX8NAegRChbVAhlbM4DBGkVlrGaO?=
 =?us-ascii?Q?b0vn0qkLhy/EgClH+/cQQqqpauCq5wiu9eb0IeMck/pmxCi55IQZPMHP5Etz?=
 =?us-ascii?Q?9quLWb22bQ2vyuchB2LSRvNKKYEAdQUdmXuLdiFmn1orT6ET0pCma5yVSSYZ?=
 =?us-ascii?Q?BSpC7PkyVRxZeDL/SsfzfdEDuq9K2t2OZDT8+2tAJ1xQKQh4tyksLMxDZvJh?=
 =?us-ascii?Q?bc+0QWWTLBZXFnhJ6jOUIDyOF3LYr9BaEhlkiJtaPUSOAWzMqFVGc1dYpEPR?=
 =?us-ascii?Q?msN0FjzQmulg/S53UkcSDiPrX/T2pEKsUppbIFQdacCjNlnw1qgScdzvf4Qt?=
 =?us-ascii?Q?81kuQkM7Dp7IV284ygf8IOX0tunHLY7w0zXfXT0V5gBo+for92qmH/1OTbid?=
 =?us-ascii?Q?NNaTWh6aq75FsZUgTMs/Pr08vwP+FbR8bMz0LUJZoE0kxal2mBhv9ul5jr2w?=
 =?us-ascii?Q?YS9zwBoq/ACP1vkqlY5Ew92N2v1do+uRZcw4MXerArQaPhvbo2gDokGU1Y90?=
 =?us-ascii?Q?mZknJ1x9DsbJdiB0P6g2W6FDT1gYJksW0kiUks11glvpFROepPGtYqU0Wt4d?=
 =?us-ascii?Q?hGVb9rAArDxZu6CzXB61ywpg7zwDKOq7iwd8XzJ6YWySOX66mHUcN3W3zR/S?=
 =?us-ascii?Q?K2+A5e7G/z8cqtuEMJniBnn/mKxOn5pibzJc/4qbcEsgWcPCadoaosyrNhMh?=
 =?us-ascii?Q?IZU3dd0mcvGTexoq1mW7LH5pP/mcp/PG4mCVjOlVxGrgiqtyGcV7IiXRQ5ee?=
 =?us-ascii?Q?Yr/FD6L3So8zTDJgd8KIIEQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52422668-ae2b-448a-3e88-08d9b95b15ba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:25:10.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgmnSapuaRar9RLCwsZ7J7r5Sfru7OGCXO+n0xlejd5QnkTZhX7NHWqxjEphUpP2XijdMjfVPPtuFme4bbrbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2978
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

