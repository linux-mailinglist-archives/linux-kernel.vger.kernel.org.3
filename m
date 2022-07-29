Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCAA584D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiG2IjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiG2IjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:39:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F2163C2;
        Fri, 29 Jul 2022 01:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6UvgAncUh2aCraEhG6Oj0w+dLk82QZVWsvW4TP+6bMWd7tz7fwsJNbl/fkrRgfYuPeHpYjzgn2Kd5oKUSUyrOUaLj+7q756axJiSqNOvA1zvqPxj1Mwj/oXPoHXRwj4zzi3s/Qg4xvEk34FEVNEL38TAAICq2oGYbzLA02smKFAgH44hAlTU1K10iNUwnwO3A9q+zr2OhgpyvyfXkuDNPfbBd96PxRCMTr4gVlzJHKbOgacJE2go4uBIitGJj9JLPz6MDteYvt2TDLli0Z3IZ83mH7IHIVCpwtMkioyCVrIkLZpDeqi2hYtPlNSf8Ugj6iI0N4y3zaNKkDAbLjKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cmFWcegIqFsEp+zCmcaHGqlwv5r14rBLXWuV+mA72Y=;
 b=C8Bi7zN+H3hsvFpmQ2SvpnGkzvZLmRb++8p8sej1UbEo9L1rQgBWpZP+5KFENEu5stc4nuJElLT3Zl4oJaMzGsXDx19ffVei6/3dez+oFWkQwK+/U6aR5hu5I6m4Ip8mu5t2ocmX5Rm5ipP0FOs+iaqe2w+9knrpbuPjKyYOvKdhCqLKctisC00diEmJ4AWaPbeEnufNwm17Av5xg/xQ1PpJD0LvX3p9wzEAw7ByqqQbMno4QoIohbp0vVQ3TwsbgN2ZRu1CDS6gETvBaV5pUGeanOcbH/2afiiTQ+V26/Pp9NlQ2tY65N+8BpCPIJFbjG1adBMnrkDSCPrxaCRjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cmFWcegIqFsEp+zCmcaHGqlwv5r14rBLXWuV+mA72Y=;
 b=OulLBG6Lzbk+NvFzYWr2no6btj0WLp9wFXkp7ydA9YSkWUXwiApBOkNtFKCyZ1LLxnM/lvBwCecn4BfnAF29tKQ6hLWSYBJAmEYpmlOgmBmFFeutJzp2SyURMXVMRi7q8PQNkxNS+K8L1Qb5TQKPkZvPnlLlGtd17I3mWxIBBRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB3039.eurprd04.prod.outlook.com (2603:10a6:802:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 08:39:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5438.023; Fri, 29 Jul 2022
 08:39:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] media: add nv12_8l128 and nv12_10be_8l128 video format.
Date:   Fri, 29 Jul 2022 16:38:12 +0800
Message-Id: <687fb73b648b897426899c6a313f35a5e2451d69.1659082839.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659082839.git.ming.qian@nxp.com>
References: <cover.1659082839.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b307778-cc72-4114-c24a-08da713dcf7b
X-MS-TrafficTypeDiagnostic: VI1PR04MB3039:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EV4e+IJZffVT+ki8lo6ZnYUg46mw0CU3HfOMsUVd1oKFGZ9YcJQkf3bSRFGqK6fggjBDvLp/O43rLfJ225fbA/9yJqNXYRaMIg85S7gOOM3jLsHnoDlgWS18lzr+D56hawzH4+UWKeXbIvuVYEWf/rJVeons8ZKHhUPDop0c/OIgkO099/DQbw6RGuodLyGfVJmMslEuN8621KBCO2CDaIobevQyDWhuNl8/HyYLZ0nNr49CZKYan2qHF1uhg3l8k07sHIgaJH1IqD9ORI8j+iygLrNsfPLvvvl21pLuyRGyhmHkPwqOsDCEbl1iDhvUaO4J/puUtKtwiJWQPOthAyeHt1qJP+PBmlfTWHqYVCWBfpEGRBSEAhthcxBhZKfkhLvSXxB5sI/3yN59VKOGWjSz8ZHbyMXZW81hKaCwrJ8o+3jrMy9w1GZrCviWQAmicGSAiPmWpEvKpgS9fgsJf+UeDL3RU4NcLDFXyEXN6nk/LDMauAj7kZ/tGSlHShYKCSzFnl3za95OFd5V954NH5I5TaXzcrzegnYIJ2slSRhVFhJH7as3WBobwqK1EdK0/WdnZYj6vcHN87ojZbsgQnXUVAyd1ASwA4TGaymQSF0qyqiZdb7swgtDLQhTUhDIlUEyWNTTMzyZA1fE7m78Ftd2ZL667A0SdcrSSF3ZGJPvylNK6M03R/ybilPzBt00eJRe0g2uRMz5zELoJPa46x/wYCxXPqQxsdIMTC/y1uLKup0io6A1cbOovjeZRSvMmATdrirkZNGlNv4wQ4KuoryCdMi34p96kaqjg8JefEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(8676002)(5660300002)(52116002)(316002)(83380400001)(26005)(44832011)(8936002)(2906002)(7416002)(66556008)(4326008)(66946007)(36756003)(66476007)(86362001)(6512007)(6506007)(186003)(41300700001)(2616005)(6486002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HlM9b/brA0oGqn4ln8iiWNOprFAMU33Isk7R2cjYwUfhS16mKAfaiPt7IF/r?=
 =?us-ascii?Q?XYrdK2qH3zgrPc4BmX4BQG8Y6nhJ9QR9HFvuRU0uLlTgosl4r9MUdSByFuHl?=
 =?us-ascii?Q?pWT+Q/UvrGVfZY/XIfALTNWpLri8azrfyT9KtMhm432eSfWmrwXAz/YhLihR?=
 =?us-ascii?Q?nfYKRRICQZTmLGSZeRMV0X+eMjSU5MXAngmTkO6Ro03abBYuA5qAjHyLkZVI?=
 =?us-ascii?Q?Mi8ErHh1e0k7XgomkLmUxZZ9sofg+aPcGyUGww2RkC/SubYnsHfrKuNoJ1ym?=
 =?us-ascii?Q?Sib3Q26jzIOex0rOpBBp5u9iIZaM4SLmuXGrRHLKhzXJQ7xxICVKTIwHYQKO?=
 =?us-ascii?Q?YoR3DXoYT5euiaHrKP1aAp1r808QfrxzrbtBZR3byKwUipWzx/UKCAKjt1v5?=
 =?us-ascii?Q?qHxXU36lBSux4r2IzluTvJTSS+WGUxnR3PRIX8DWIY7wE5Mqu0dx4h2cxWTN?=
 =?us-ascii?Q?HZQ75Q+QZLQU80P/VHUMQt4YCne4JPG5yOcPtD709nrgPhLNxlVHQ45UO/7D?=
 =?us-ascii?Q?KTX1d5BiHerhL13veuf89fTL9YmQM2e0naxGgB0xFK+dLFIgQArdiWh7xry7?=
 =?us-ascii?Q?j5scefMaVp8GEbR1sMSuVe2eN3BmlhwgWME9BmYyQ0yjmQMi+wzGsBJ2tV2f?=
 =?us-ascii?Q?WKj9wLBEhFq6N3BZBfqaHZw3YU3PBHwu9zQ6ZY4uogXJ30BAa+Pksr1aMpF/?=
 =?us-ascii?Q?9FdgLZF832oZKZEnDBIo3C1f82QucJkEl3tCuiEGTxILjJL9ycJOgzDUmT7L?=
 =?us-ascii?Q?/PYMsotnV16pI3VUAXDEbfwxtmjQ/rafV3COx+SGyH9sFE99huqr+OGO1LcQ?=
 =?us-ascii?Q?jb5gHywwo7HCQ9tjz34JltQo5eysBkTTmaNiFFZDITKX0QXE/UEzEnijyKcP?=
 =?us-ascii?Q?RVNmBO9xz5ZQjqIwJ5gQAEmz84TFtU8YTeyHfW2o2U9E+1DNKzuoZ6frO84T?=
 =?us-ascii?Q?YYRt00zTH02WiiPRKh3b0tXzPW+mmMJX4/FHH6WsPlKjDolWc3qIyNkEum8o?=
 =?us-ascii?Q?f7HW98WlGu3Rz6gbKWdSNHOIEQrU27hZQnEoRshZBR7gXoELLEJ/Y5CUMkfS?=
 =?us-ascii?Q?Ufw0gSnGM6qJtASJcaFRJ2rQA8zBK3Z1bRk/xptXYnBrqnXxhlkOjuWIA0Yq?=
 =?us-ascii?Q?pChwXK2CG9cWzCFg/9lkly6y0BBDS2NzGAjzuNkc5Otwtns9DaZtNG8vOFhS?=
 =?us-ascii?Q?higf0/mDQ1698GShlRkE8o6wdmA5/V1rjd/Cc7tobcC6raThaqY2xrFAww4e?=
 =?us-ascii?Q?ZwTF3ADx5zqtpYqcqbzbTx+9BZZ6pEyUYBk3s32qsvIju4d1GgWrzC74YVI0?=
 =?us-ascii?Q?fkjyDQ+ove3x4Pr8izGPgEvxsHW0hYYqfpGEYuy0yW3gS1Wp8+1z7V0UQEDN?=
 =?us-ascii?Q?qVg/5JDxI6pCNJRQk485u6xsmD/bPQprcriIUjXb6IxIMuTg6dpytKhp7tbg?=
 =?us-ascii?Q?OnYr0BQ2bMsDGP/lQmS1NPqfwRmQp5Sez0MkxcyyUWYdkAgDhRNHcy4j0jFC?=
 =?us-ascii?Q?pWjfY3ZZwrUXWYJUZ3SiMv2V0tSiI5KDE00lLKFEdKKb5mk07U8sUkTTPlCY?=
 =?us-ascii?Q?Vbncsozyk+9c38za9vsQbMSFDJcqQFZCJM87orTA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b307778-cc72-4114-c24a-08da713dcf7b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:39:11.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/IcYnZLetReJ1oe/vj4s2B3XrG8VbJQLaWErf6r9C1OksL90q6f4xuBpdL2m3Kgrn+hBwl/8h9XaFh+0yyfgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3039
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
2.36.1

