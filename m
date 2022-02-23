Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD474C1193
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbiBWLl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbiBWLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:41:23 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C160896826;
        Wed, 23 Feb 2022 03:40:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtGgmwwUeFb5onx0mb/IZtPqkKr66eS4C8EDYz+8+rCQQyDCgytAZs8nlqZAxzSV83/P7N2G0xLY6x1gdZau1l7+IiaxJObDEKQ9R668gfBL87GPk9oqu8hkACD5qK2i1gfbT0+EZxhP1/hlJ8s8XkTPJhFGtUlDIAbCqcLWJ7WOVQomUFY2dL+/eOopEuwKurvVwWUTNFykgCAAT3rFSS+5uTHyJfhrHsmwPlRwuwdIEwnAMd7Wyv/qWrWARAcIRPW7nCJqyxVSH0Edc8am8/i0iz6zkA0xFgl1CpztISdEUp3PF0n+EcTQSpdj0vx9w2J2FDUmU4uvjkKaVANTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plLDORXfJ0kB23R1bo+KVE2ciUsqdDqv8gmuxm1eh5c=;
 b=N43atjl0/GHmCb8O4C9sCd4rIhd6mcXs8Zk1o+wCm5wa6AxORvDxXI3MhdqSLVcg/9mz2I3L4sCuA0/4wVQ6pzFOgLfAhHbOsYzCqGDi3o8W74N9+3GmOTKKQ0ETu/QtBKqTWwZGi8cgKLq0OTwrOJQUUXzt86p3WLGUlsHYSZFpYAognX0WaBNEWWs3JJGoyARiqNid4U9gk/XAwYLI3Th68eArnxwA20BcdHw371860nN3DqgjeS8S9cksieNOxVJR5DELcdIdP8w39/7rdA1al+Ktnc03N7Lhc5rkvz2vTMRneTJXnnGbFLdwtGvr4a+KAYB4OJ/8nsUcnZyy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plLDORXfJ0kB23R1bo+KVE2ciUsqdDqv8gmuxm1eh5c=;
 b=CWqyWde5iMFLxmJxavjUmzAAaHFccBFJlHICw0Ziv4FFAA6HIvRgrrwJS6CXRbPKjzzaSUwj/gPPA/j2l0ai4aFe0R25j8AM8uwqs7I2sOflCKWSk4mf33Bl/ktYXLg+8eXimeshwFMtilukI9dZ54iRip9zfWJr247Kg5RY0qA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3416.eurprd04.prod.outlook.com (2603:10a6:209:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 11:40:53 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:40:53 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v17 02/14] media: add nv12m_8l128 and nv12m_10be_8l128 video format.
Date:   Wed, 23 Feb 2022 19:39:55 +0800
Message-Id: <f73dc2332f965a9ab4380895a883119a8642e160.1645615976.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645615976.git.ming.qian@nxp.com>
References: <cover.1645615976.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad7d657d-deec-444c-5b1b-08d9f6c158e9
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3416:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34164261BE4AB35F51A97AFDE73C9@AM6PR0402MB3416.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVmY/v1V4IAwenL5Ti+Kfmr2zXCezjrputldvlpz/l97+x5g/r/q+SZyt3XRcZ3INosH42eKeyFoLNnp+9S4EPpM6OMAA4N0wcgA6DHIijSInYtnZlwzyrcnN5eor0UveGig6Qi8NoFcf4D/tre6SL3UPdObK8QIIc8smx0eJeVjHuSGCSfb1As8Zn/RWy/ScZ2/TdTgsy1TqjC/0ShymcSZHU4l9jA+EIFhzl4WP3Chg8MXhCwbBWxNbqP+AqcgQd9VsaJXYEe+4JX4n5CWh2pxsZlFcr31xzSbGllUZFBvuaDDRxZUYE+j4DqNzRl9nWwnmNawrCppiS+rwz4tVteYFCpPL2F9AIecxjRpSHSEknOVVUzHRF2InZSWqxJ5AgsFArAxAxVM1ZcxC/TDTOPcsPU73rpRoLirBn+aif/zi6/IWl74CA3bKTu2SoV6cfWUuiy6/k3U4MXYV6NqB/ewnwEAi5ya0nHoLtNKqPucxEVv76nKmIP1Ye33raj0WyAawbhjTwD0a2b/zkTGDl+d8CKhBPr7Nok4QhotZL58WKUxVstdkRDJmFSAyjQMYikPcXZxtLJ9pMsHJgXfEXZHahF2bbzL0+zLrlFKw8fbYuhM5dxlTXlVm/BlSfUfzdBv3m0ifGuZ07XYVkSuoSrTV5qxNSGV/eYrKkgEsJzG0pl1EN/cT1JeR+tB14B+H9+e+7/cMQil1QgU2zJL3cNW1VFgOnjS1EL+w+vqM2PnBdOPD4pwGsH5nO/VSnZozcYHXjaek7grvawIgHa9mOVHRn+RaIdpPyp7B6YtO54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(6506007)(6486002)(52116002)(966005)(508600001)(38350700002)(6512007)(2906002)(38100700002)(66476007)(4326008)(186003)(5660300002)(8676002)(8936002)(26005)(66556008)(316002)(44832011)(86362001)(83380400001)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C2xwsTsc6K8lTiJW4nsB4ccm7vcaBSBWrj59oiXuBA2LBNqLipsFBbLWMfA3?=
 =?us-ascii?Q?iiYi/rRbWYPw305vn5tL4bEw2JDUWOSZl0iB6/NYpkrQM+/yk60WPJ/uJuS3?=
 =?us-ascii?Q?/mwVaI0XqRi9xURthVM9UI8A+jmS2aIi0JLFRjO6EnpWggBKxgpq3qsjj7Iu?=
 =?us-ascii?Q?9mrHpBBzeqrfH5NHgZ7ccOIwT/5C1zoj5cBUcDK1qCG6zOeNe5w19cc7RbOR?=
 =?us-ascii?Q?Z39xsKbMMHWL5iYkETkun/EEx1ulXqtvJIC9l+qu/TlxG6H/n++od/WtwsXX?=
 =?us-ascii?Q?RwqCZIDmcftzaHZsFfRiIkHnn+gajxug5w0DfzbN/7T4cBh3LeXImZUbYN6h?=
 =?us-ascii?Q?Ab7pQvT253C8XFxfzwmIt2pPwOGGkM6aciSS8R2TD1vvKYKOJ4K/AobjSyQA?=
 =?us-ascii?Q?d8nSjahPlPfn2L+LjakWopFH9JVzeHl4wNC+BRkhJJizjW65aSrhbKcG1hBF?=
 =?us-ascii?Q?Oys0tDRWjGxdjSG7mFrJean7wzQK114OyxMDv6Th13gKP9VxBIyPp/jE0zyy?=
 =?us-ascii?Q?8gc9O1sdB7NoqKlLBnF8JFbCWMsm+oV6jeS5fR6ZJud5li1tv8C6j9LHkxOh?=
 =?us-ascii?Q?a5FREBv6qRymhpYDQ/muQCWNq6x4YIDz4mlgWNnmU2/oq9yNIfCef6p5vgU/?=
 =?us-ascii?Q?o5hYX0tvuvIRB5C3q1b5ghw0jZZa9cIDNUHy6G4m3EaoYzw0bqN5/j3KhdOM?=
 =?us-ascii?Q?w/vaSZKS9uqP2Y0P6wjzVgZCOniJITkulHZUYx4+xvwfCInKBDDCoAABTtSm?=
 =?us-ascii?Q?9bkyt5BNlJbeJd6+rLl0RcGB5vu4MdvaNzl9RpwQ+Rb8xqAXOGXYHEW4dmDc?=
 =?us-ascii?Q?ZeslpuTYxTbkzaz7o8leMwzsRm8HSjRb76X2DEtUXsIms4r1o2lnSOEHTi3T?=
 =?us-ascii?Q?Ug1PGa4iN8XvJCg9z1hRF8D7pY3/rAB+4tc/Af63eehe/0N7Hkngrx34csSx?=
 =?us-ascii?Q?LA1/QCJfkMfUq8aaolfmd8WS6pQQKPaHXgkZEMtPhmPOBt1ZBXiYS5qGOnqV?=
 =?us-ascii?Q?mlRn1CpHBdBcxu7R4DO3Q1dnVlZ/nn9Lr+rD1WNOBwyNnj46RKKUIJ9YyG3+?=
 =?us-ascii?Q?OGYJLp+SQkNFmJAqKiX4TqD2pvwWzrtq+dy5hVKifJVwc4oeAtRQBtlM7ZaK?=
 =?us-ascii?Q?v+38E/oKxb5KqwOOgMveaKgwmGJ9jqFzzO3Gsz4nPogxxpUHw01VkqgT1QyL?=
 =?us-ascii?Q?l2dD4P1c6iKLwzHKzkmqSfOKj57ZUfLlhd4ySQB74BWCR1OkKhX2KSAf/FKr?=
 =?us-ascii?Q?LueY2+AJ/4MCf7faToqlTHBUCSoGZJsBH7EO9CRB0fQuMEDlOgB930UdlDZk?=
 =?us-ascii?Q?xOlcctV3H11ieMpMxzVIC2NSDf1XhXDASXoUCPbl44zxc18B8ChJiIQsu05S?=
 =?us-ascii?Q?t2KoMvzcocDC8Bv+VyLBZ5ymvIfkRtYfyc7n0En8T7o9YC8bA6NrCM/HL1Tu?=
 =?us-ascii?Q?ZAOC8XOGgZDvCAvNOaJlSx1+N9RzJ+mWnIcqmrFTSgA2R1S42nlONL6MoKDh?=
 =?us-ascii?Q?9YdqnGdiSF95kHapR12EhQU31zWEoG3wOu6LOmOWrrU5hv/+WFsnsSdi6zH2?=
 =?us-ascii?Q?JLg6D8G3ayPkpl4d+I1LoRfNksxw/LHAt5XANtG78mkmNY2f4Gq/AZf3vL0+?=
 =?us-ascii?Q?e7iEQ4DauSKxSvU9bcae1eY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7d657d-deec-444c-5b1b-08d9f6c158e9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:40:53.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZd8vg4mtN1Lmqt96tDBtxSWEOVeEvUyjbCKSeVOarAFtvBuwKPxlhq401ORog8Rlt/eT6TsNmlojkukpuJy/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3416
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

