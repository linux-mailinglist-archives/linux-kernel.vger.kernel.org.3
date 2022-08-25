Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5B85A06B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiHYBoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiHYBoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:44:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9419E0E1;
        Wed, 24 Aug 2022 18:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4zlrvBP7YDa05IgInEdnwYjL5rV0KIUVf4GZfFNCgRy6h+jL/SuRod0fhZjOYqboXJyIIA1hW7xRD6Az+wkxA+HvfQ6VHXyHcgE/Na+9oee4osjuNUpnn9zIwzREopG57kl8wtjvMYTMKQgiGG9CTWsgrhm0srOCW3Dxh7IObydLUmYSde9gpzD3zMkofEF0BwPzQb9FDcudLQyNcAmcn0k8VesKa1CDNEpMfTd7UKGvAgMrNvxxS3vLy1LF3hPKhpV93qaSs1HNuUmuHMWMzYlacxZzMTWqaZRBvexJU8LJ90sjMj5iN2oVLjDOsD114DXzREpCqfTDr/1VFrxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILbwKsQESriic4UJzwgOD/LvSf23rx794JCog4tYBBg=;
 b=TWevhLm6FphMSJGwk4iDDas3lC1ODIo0JebZSLlxlVg6F/w4viCNoQ991frjoJvYc+HfmDCWLaJQU5GgjmJpr3CVXhjD9FuM6up24by7t8iuku7zPaHkxdsqXb386uixUwEEY1rbviNAaWCTsxC24ImCNSZmFG/s1HjuPCa4gI1/s85otllzWPLGDhn5AFyE92eYNkZ8iPgCzNavGJ/T8o4WdPL3ReEECEgFtS/y4cT+SjI2BRiRUf1GrtzPl8HnyuudguewAUIW9DRIs3w7SLBTaZZO1WPPUTw7FqEetRGKFI9wRAI/jEF+Bx82v66dmbuUVY5pxymteqFclvV2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILbwKsQESriic4UJzwgOD/LvSf23rx794JCog4tYBBg=;
 b=iT4a2bB3aL5qnSMnnUekRI6mSu9V/Eid+LLqsGp5jXq1cSPYAfv63aJ94IytVTMG1sB3vK0in4cuZ1o1aEhum9HeZE708qVsSqQsVc1TRaFLTHHgMRlmY2HLzmmNSaJgmGmNnq22zPdXzq0GceJsDVNfAmCM4C8JWkaYycdPwp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6162.eurprd04.prod.outlook.com (2603:10a6:208:147::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 01:39:16 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.027; Thu, 25 Aug 2022
 01:39:16 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/4] media: add nv12_8l128 and nv12_10be_8l128 video format.
Date:   Thu, 25 Aug 2022 09:38:29 +0800
Message-Id: <84842bffb432884a0fd84de96c6e64ee2273e511.1661390673.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1661390673.git.ming.qian@nxp.com>
References: <cover.1661390673.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c01fae-7c80-4d2d-43d0-08da863a9f22
X-MS-TrafficTypeDiagnostic: AM0PR04MB6162:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfXtEtd9BedWycLWi715RDJ2RRQoFAfmyTd0E/ksxpZFp6q7DdUeDAqWuu08BaFmI3BpWm2lzSrF4Uugs0apiJMzV5ybIKu3i+wM3BoS3flEoTatHHMZQcqmAyHf6jfVkXUPYX5qomrCRFcKykEgeYQNWU9mjN6N9B18wOujQmlYqZt/6+U7LFTHTJ26ber9yl11PimtPVVqzzL00HhfDk1MJa4G4NmND8Cwhy54kzhAc86tTGegNXe+EIT8byAcZ3T+OVrj0sGgLmjhiF7SoSWYCXfyGyo/rIHKlyXd0jynKxg+4aJUHCn3RTv0GltwFpRwL1EgfkPc3ndjcB6n6Mr1+aKc6QJxqGCySeXEPPr6QsyydCHPYwdi5+NFR5xFLKY/4Lb+Y+OrrkuM0AC/wTyv2eU1m1oLfl9T2s5pzU3RsFKze46/qmRbsfS9TrSTcLYbzoKX8f+wYHqSnnV1cReK4RaLy20M2489vWWVV5qu6x9Z8cZv64PFLNsQXWVK9CScHudp4ufr9FhUngtcO4g5urMJ9ADsHeKcblQIohDzwYcuUDgUPK3cDH8EjUosJ3AsuOKvj7jKiEFpsiBL0uyXq0hI4A1V3WDoEt55y6S1DGjzuRSaZRGQfCu7Chc2fsQfZQLIeP9NEv+bMMMJynVnxiGUwfC9a7QZQXTM8JXgrzVZfkcEYXZcOjx6PXmtccbMRexlAqnWbZbtXU4Lq7Q57Wnwwl/9+xwSVqIl8zxh6RBF/FzIzBm1qTNrsWbk6sQg7VcFVX9G6ZtmnUbLqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6512007)(66946007)(38350700002)(38100700002)(6486002)(86362001)(6666004)(26005)(478600001)(6506007)(2616005)(52116002)(83380400001)(41300700001)(186003)(7416002)(8676002)(2906002)(4326008)(66476007)(66556008)(36756003)(44832011)(5660300002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zy8hqJxgbayd9s0NdMJiuzlL81xILohnC4p6/wGuUknufK3vyJYoPgdB4O5i?=
 =?us-ascii?Q?TKVXCrQc6+p6NS8BCbMnfywp2NcSszEwj/8V5pqlyf3BHwLpkxebjFo069QL?=
 =?us-ascii?Q?FW1+t6pxG0haoCbCGqKg1qQdX4SCorBYtwnMIi73Guk/dKFZkMq9lid5KEZQ?=
 =?us-ascii?Q?V6TpeUf/VKY3glKdc8ZENbpsdYk2Xioby2He+przEbXDTZW2AZ6ASjS3J0oO?=
 =?us-ascii?Q?m8iMk03CsE7UG9pxIYiAEsiD28FjDl2NdrALACEBc2B8Y0SQdsjctQLXa1Tr?=
 =?us-ascii?Q?azppDdn3s+Nm+p9WqAxtMWYG/bHOtBgo7XddHHNJL9Dv+sElCVt0Upv/7g0v?=
 =?us-ascii?Q?RDZQx+7DeKMXjYz9nYyf2BmpueFaBvgDfA5UBvimhxoQH0Krh1gM2DfCUnir?=
 =?us-ascii?Q?+tNlO3fW7l1tZ2+RnKvM9CyaryX4j+XOvXUWWf6+2QJyP1TmbZ3dZLLiqYNz?=
 =?us-ascii?Q?OSjFhaFqnhVkpuy2bLQSRoNbjgp2plBb4aGzqBsRsEWp6qXKCbkMIz0POIX2?=
 =?us-ascii?Q?u2MsKp0u/rddWZg1TjswGrvssBwfbYd5y0x4uGzME7jplEXiT7z2ZGZ7Tp3R?=
 =?us-ascii?Q?CrQPqiFhyvJCj5NIJJGex7YHeTHtQgKWMw5BFm4Mc91kYPo9jjJC3Is8wmMc?=
 =?us-ascii?Q?/xaQkY0cQXXz+pnJMamZoyR7mQ+rwcXuWIIdNhv897y3STzROzn1u38OMvlp?=
 =?us-ascii?Q?lR2AedHdtbC/AGIj8MWVMPFiGDVzJOHbawvB8qKUCyjWENHsM56f/aEcQc23?=
 =?us-ascii?Q?+DB8/6sx+1j3pKbP3M87eLJgXOAy8RPGoT0NGUoyXKF8MpAoOqbpW4riIZjU?=
 =?us-ascii?Q?xWSB5smqZ4dyQCAXyAXlj+IasFSs/Lb5YwEdvMOd1V9Xah/IB8HdZe/YTe+c?=
 =?us-ascii?Q?iiwVdm+6/I02rsrGRDjbO2sgom3WfrLH6RN6IRISmRhRLxx2Kg0DOtddqtFA?=
 =?us-ascii?Q?aTRGFu1DJS5UyAMdkVPzUqFdIUUx8cG6bfDjiPNjYbHzMo7X3I0Y2gRy468V?=
 =?us-ascii?Q?4lGuALt0P9eIprEwO/3EXnE9SW7lyvz6e/8A2rIkzpsC13TOAxQj8fi9uXMD?=
 =?us-ascii?Q?PtmbDSAtMK0E+og3nbqQci4Ce3zJpjlwWLib5Gf5Q3tr8MvIWnfX7ju8vZUe?=
 =?us-ascii?Q?TfqJyMQq7d1ZgXBVwPo+s5cFZjm8E5nlTgrunEHe5nGTxu2CztkZIk83ElFs?=
 =?us-ascii?Q?Wtu2E0Yj7bOqsyslNxlsBxw69hd4NIUu2hquXYGbsyWsMRHC+fToXuVTonnF?=
 =?us-ascii?Q?EuliedbVCgKzfvjYTp8gi4fl5OORNgiAzfe+yMYAJiHeQ41yy7MJ1nslrPlh?=
 =?us-ascii?Q?eEidoDhUPonF+AE8foWbwjeJqhOmuivnJxwYo7ccnYPxcTLoXvqyBX7r4foZ?=
 =?us-ascii?Q?46OU9rwQ8rqPx/5fhCyDrz7yh5Nmpdhtw7ymxFdFuw8wTDMe2ibzCZOE8W/v?=
 =?us-ascii?Q?xojDNZePHXWjTjOvw3FiD1h/xGwpVkV1lXrblfokh1kEbyh10rKoFu6C5aqc?=
 =?us-ascii?Q?Q9aPO2B48g0WJ6GcVPBkTvdneBUGYJRSXhl+5+S+OoKAmmQzaJJMIMAY1eLI?=
 =?us-ascii?Q?Dvg6uZeUrFubS3VB3mmUezYwUQtmGoWCWDf1DT1X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c01fae-7c80-4d2d-43d0-08da863a9f22
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 01:39:16.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCK61SlJRnV96zlvQrN0LYust5f/SC1wthob3JQtZTPEuaCWSzXbrWvzp8tO4h4lGYqBB69cvt+vzfyypoe8Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

