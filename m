Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54135885C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiHCC2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiHCC2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:28:40 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00AB19C20;
        Tue,  2 Aug 2022 19:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ+17Kz5+5B2Ji7E3xmRGFqpo9VOKrHmg7MX2Z3xxEnm4XkgL1kqN5vUtZw+jEyDeA+Y65TUTrG77wvENSLNliRDXzjevKtaE2DZkdHQbBr5NbfJ1VztOvOTnJBTIwjuNJlYW1VFjKhvB88YgdSLdQ4BGlTjDidvUSnnwoWdY1KqQuEX28Xg3Z5nOvFSXMY4y3zN4IVHnKhLEDWl7MuTW7OQ0nlnCIMm6w2Fktf7V22ELBWL3NnINkskAV1v9v3TrxoQuuvj3sTCWGP8Fb2uldJpgORCp6mEodHTFMN5t0sXCKGE6Tai9nOOJ5P/XUUC0VosU9bYEWC6ZDRgZMhYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILbwKsQESriic4UJzwgOD/LvSf23rx794JCog4tYBBg=;
 b=JcPItFdfxDnDQqsVNCVRgzuVy8dYgtvtbpvxWxgZr8DKj8KKOuKQBOFKiKzuRrLd/XUMwkM4tsgZBwwRcYI5hZTG2jsq/bkwPz2k02nWw9ezS9FI307iQpnvgTOr1GDurb754vIe+XGLiof9LE3F5BQIJsrZb+odaW3MrkCPZ0GGh5PWA4qO4jBFSma6x6mMXUe8YHgNGWMzi+ALV9xx1+0BVkipCkVLwfTqlarPFjEvFino/Z2uG+VUA2mMXjm9OD91Ag80UcjoGX+A0/T/OpW7iAMsPKJ5fOrs4q9+HzMBQOV3mBV+3cjG6V+LTI3Ia0jPyGSDa0qCLnlZGR7MdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILbwKsQESriic4UJzwgOD/LvSf23rx794JCog4tYBBg=;
 b=SzBWgdzUWwjLr/1zCj/PnopsK9AFwxUmqkxFsgaoBPlpIF0AmBRk028vkoik8FIp9+BzFFSgjpYYMEzgX6zwD14wuBKpU4Wr9oQNFH9a56UP/E9ViY2x1HBXoRSXfZswkzohIGK6GkuCFxjQ/EMmRsi3UzY1qryiyufTVrjknMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR04MB3077.eurprd04.prod.outlook.com (2603:10a6:6:8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.13; Wed, 3 Aug 2022 02:28:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 02:28:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] media: add nv12_8l128 and nv12_10be_8l128 video format.
Date:   Wed,  3 Aug 2022 10:27:19 +0800
Message-Id: <84842bffb432884a0fd84de96c6e64ee2273e511.1659493105.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659493105.git.ming.qian@nxp.com>
References: <cover.1659493105.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd2c959-cbda-412d-42ca-08da74f7df13
X-MS-TrafficTypeDiagnostic: DB6PR04MB3077:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOOlOT5x4N45eniHq2NhfEn8J7OgTvn4JMGt5pCCcD7xjuDvktjRLE9npG948ZDQ8/cSY8ynzaDIr6iku+KUq6k/JPPydy6G5vg2o6tPYwFo1+IaNF3XVXXcdGCnHZzm07xgvbTjbagzT3y1cZI9HilSamoxj9cbC3kCuCBr/8Zk8/LPkzQM6kzDd6fjg5zW3DoCLrYspTum4wize3ymBcEIcy2N+oY0QX7tZn8OTDRGO+ZVk4sDWaqANigDgCGexihWtahLMbVLP9S3AFbYma5Dxhq3Yvxzkg/sVLJodcd88vBGbTkaVyg20iwbgqjK0vZ29akjKltRwdt4dv/X1YoksKSZnkyxbRq0Prlo5bMOvWKZ13EfDsHqnPeUiAjQ04HmUpWwl0x+X/iWEqr5yBs+q2XzdcPS2lFSmUaKIWpwY47rliT75QLFiaTC0mTiTJmywtXQPRVnwFmWcddXkwru8P2kqupGQBwrqOvjSa0/dVrTszzcFR4yaZvPDY++aHQaU2ZgVHbnqkP4AaiGrekst/OY6suGaIShOb6zYhAQgaqh6IvfaMNs/Lv+bk4mCY/n2g715LO+OTcEKL8QTEWCV+DEkQYKREsecT3c3ysHnPfs/IMieGY4S3+esW4N3ckBZvySz8/YjtnzynJbbcaQnUQ47ATnM3a3SNkIDX5ng+d2/1frxjhEHkpAo3OyUJ7E0vT/0uBM7iUhzksCGQBOz6AwWV7QXCqujPCfmaTQBrtvyWLF2trpIuIXRpXhbuMIBZeMPwrQEA0PtpyDjfp83qMMAKEsav5REID41MJLY//6WSynQ/Bj0os94a1T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(44832011)(5660300002)(8676002)(4326008)(66476007)(66556008)(66946007)(8936002)(7416002)(2906002)(83380400001)(36756003)(86362001)(38100700002)(6486002)(478600001)(41300700001)(38350700002)(316002)(186003)(2616005)(26005)(6666004)(6506007)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?COPil/DMnuB96HVKFBZvbH3tvQG7897vxnEKL0nTVjYbU9ySHNFUy0QHO3Uq?=
 =?us-ascii?Q?FlorPE7ghTyyGXu93dQ2YIOzyot71ZuG3cOGZp9KjcB2Xs8Eo990kSZlpP0B?=
 =?us-ascii?Q?MGNiLoVGoIlVWtKzlqbhk0PEIVrguqVxptLW+WhbjhKomspzxD99n9gzaGY/?=
 =?us-ascii?Q?EYxCdoSQ2sZB+YbH+2nrMgVzmn261drxfeiUW/vZTmHQBnxpqT3ZddOJ67XD?=
 =?us-ascii?Q?dKGyosBxn4F67ZvhQSJzxPXG8PXWujnbg90Ki/KF2XVZ07mLkgs28dzcStNW?=
 =?us-ascii?Q?84KP/wwHgrtgtcyx4CXBlLqW3cg3WlwaUmAP6G5UX8B+J9P1PT7FiHoDZLEd?=
 =?us-ascii?Q?KRJEPBnscrQPsjeyoHxVpzVmT7u0KcggtRK8rj7X4KY5/bQ/MqKgKzDDoHy+?=
 =?us-ascii?Q?GxO2tSy3yXaZ2nSdfZdN77dUMXNEwqETmYDNTVhOXq26LuUyunyT9p84TcIm?=
 =?us-ascii?Q?LHvh7ZcFg7Kn9UlUP4lF/iURuNUqGEOz7Zfp7+Xo/TY3MmYxRwikh107WcZI?=
 =?us-ascii?Q?xFoowixQFPntDqFcQfMq94/J2qqi1lLc+PPI8I95iIrlcuvyla5le4+IKWT6?=
 =?us-ascii?Q?1bnOGwLUtyWtjybBknXP9SKEGgHMr3lv7jNlHQz/ccxXjDQdU8cKovNo6MbW?=
 =?us-ascii?Q?dl4xee17qky7gN+wOT4XVIYDNeToZUOPY9WocfZJFLCEv08GJsjD9n65fiXU?=
 =?us-ascii?Q?IYN7I0khzYyW6BaTPjQFsejw7PszgW9NDLCKeEiMbnjCFOd9Fr3uK7CZZ85G?=
 =?us-ascii?Q?KLlAApZI8DDCu5zu+a5R5ZD8+aJL11+PB9SxDwSetYfGYdCqUWrm2Dm+B+SS?=
 =?us-ascii?Q?uXnp4OI8TYc1ST1n/fcQ0xOvmeVE9F87ZOr4tQgr6BDSdDdJZTbmIOgMI5yh?=
 =?us-ascii?Q?UXX9mkzSbyo7xGSqwFJD32tXMHjGy1BacuOauR6eKUsacADJu+YSnXgLRbB0?=
 =?us-ascii?Q?m7kIQljdJlcBXqfDHP5rh0bve24649+WLjCv3GrNpTOophhPnSWyYuGydLmj?=
 =?us-ascii?Q?8wGzE3D6fBn2A+cxphgKO/nPYRD2ry0ntzAkNuCWJbaH2j0kjL2gAz9Llk2k?=
 =?us-ascii?Q?9Hf6mzOeOspJz7olAOAXZHh53QaEVRHJCRdDKNYWIfGsfpCo8Pjap1ObJwKK?=
 =?us-ascii?Q?xZ5L8OvniI2vt1hsGz3EApcxxj2FJTZ7x31zD/fvOiQKxQlMRn6P4Qw2zVDl?=
 =?us-ascii?Q?5ub3ZrfRBCCkke6UoeLhyV2lTteTKFOivF/V7yaPOuu5TP7z+7ocoUs+BXpC?=
 =?us-ascii?Q?bY8mAbgSxL4TJt3+S5zyOqVZ9iWuv38nHYRpRteGiizMkHafwrRiFOIR0ZB3?=
 =?us-ascii?Q?C0AHOliYXA3v7JgBumvKXPUXljuzAbYlr8A1IkArVqOALsFXeVz5TOGN8/wb?=
 =?us-ascii?Q?yYB2BjrtKABzlMRTX+jQ8im+IYt5bxx3SV76BcVwh+3HEVcte4sNJ8R8EBzq?=
 =?us-ascii?Q?QS6ylJ5iAtBgBcu4yI9oVTrwmaCCEzqlAN0hWhIaHgvgUGOhq1zD+Ql1+r4V?=
 =?us-ascii?Q?/TUgWWRLL1xhENBmH1D6jFxU6USwK9wX9rQmdEKLqwawHrmPh0L5d3HtfRT3?=
 =?us-ascii?Q?3vcpRCAxsQ6W9siwPyn1+8e9LbuASlEz5gBpjYGc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd2c959-cbda-412d-42ca-08da74f7df13
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 02:28:37.6234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQrrciaBzNPwYLtyuegEGo2zId5bccCjUL/Ss8kEtmEOD9U20aY/DalcMbxtL3LXRavPt4CxG1EKW0yjWmKoEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add contiguous nv12 tiled format nv12_8l128 and nv12_10be_8l128

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst         | 8 ++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 2 ++
 include/uapi/linux/videodev2.h                            | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 10b1feeb0b57..f1d5bb7b806d 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -273,7 +273,9 @@ of the luma plane.
 .. _V4L2-PIX-FMT-NV12-16L16:
 .. _V4L2-PIX-FMT-NV12-32L32:
 .. _V4L2-PIX-FMT-NV12M-8L128:
+.. _V4L2-PIX-FMT-NV12-8L128:
 .. _V4L2-PIX-FMT-NV12M-10BE-8L128:
+.. _V4L2-PIX-FMT-NV12-10BE-8L128:
 .. _V4L2-PIX-FMT-MM21:
 
 Tiled NV12
@@ -319,6 +321,9 @@ pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
 The image height must be aligned to a multiple of 128.
 The layouts of the luma and chroma planes are identical.
 
+``V4L2_PIX_FMT_NV12_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_8L128`` but stores
+two planes in one memory.
+
 ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
 10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
 the data is arranged in big endian order.
@@ -334,6 +339,9 @@ byte 2: Y1(bits 3-0) Y2(bits 9-6)
 byte 3: Y2(bits 5-0) Y3(bits 9-8)
 byte 4: Y3(bits 7-0)
 
+``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
+two planes in one memory.
+
 ``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixels
 in 16x16 tiles. The line stride must be aligned to a multiple of 16 and the
 image height must be aligned to a multiple of 32. The number of luma and chroma
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index c314025d977e..d973bd2ff750 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1444,7 +1444,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
 	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
 	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
+	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
+	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
 	case V4L2_PIX_FMT_NV12M_10BE_8L128:	descr = "10-bit NV12M (8x128 Linear, BE)"; break;
 
 	default:
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index cd66e01ed3c3..64f16490dd2b 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -655,6 +655,8 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
 #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y/CbCr 4:2:0 32x32 tiles */
 #define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/CbCr 4:2:0 10-bit 4x4 macroblocks */
+#define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
+#define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
 
 /* Tiled YUV formats, non contiguous planes */
 #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 64x32 tiles */
-- 
2.37.1

