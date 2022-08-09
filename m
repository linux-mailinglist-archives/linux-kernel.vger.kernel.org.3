Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6F58D40A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiHIGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiHIGva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:51:30 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10041.outbound.protection.outlook.com [40.107.1.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E5205C9;
        Mon,  8 Aug 2022 23:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3W1GjaJcQ1EZB8SvfxjZlTCsYLVo58NJot5+U/L/v53jCFIzZ8SiIlQe+YdfSapwXq9Le8ZHxJDsVGCdjr77V17yLQFTgHnd3XZK6L78+ZB4xtrmE88yo6YwOui1Jl+Or+lSPU4wbGPQDdndhwRzEeeqxUlnT3nQhOm/ChtenevbPlul2x0mqClsoXZL9OgKCzNXogcUYdAyvQfjHEPIUrqFeWsPAWh82oX2vcxRQa/MdRlpGF2PXZhE8sjMahIQKXbT3lHCVqMT9VPrrS46+Ozu6SxJsIQKCoJxqEdKOV7yXFP2JX4AyMRTDdp3kFvbPHL1UtUO9Gx3lwBjIz70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILbwKsQESriic4UJzwgOD/LvSf23rx794JCog4tYBBg=;
 b=LJVFbaaDMgxG65olJdkqKExb68/Qbkk5ebeV2CwzoGZR7UNrmeRBuDMlUVNC5JYIXMm11+Ubr+miUh6OdBurZwdcrIzIo524k4MQJyLnftMhvF8ecx2fTBnnNs5UUI1MhQJBWRea3WimCyvblq+sru+QAV5fhHC23R7Wle+rtmGR36GeNwGk20F7aPKgLQm+yvp6/OzyxTDdk0GS5wn9clTQRqJuJbv/7kZc+0qeJrofxi3awTdvfceYBG+gLBA8sW7XS8+l5jD5cheLHFEYgiZ677uH0wmlVdVA3sZcafeabqiJAIVjm1ZZvXLS3asJaM+uSqjCy7K5PKhv28aoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILbwKsQESriic4UJzwgOD/LvSf23rx794JCog4tYBBg=;
 b=bx5vAc97GImcx0uS1ykW98toeKQCJWQTuOX7jfCCGFWdTo2zG4citnW4Af5dzs0F9t575XtK7mCN5f87SGruhGJhfftZ5hztO7R6R22j77MLjQ+yekgE63W9gS67eKQ18WXvWhRQRYBTwPneBlCZj8U6ak7vUv2Q9w3TbqpbZPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Tue, 9 Aug
 2022 06:51:25 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.017; Tue, 9 Aug 2022
 06:51:25 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/4] media: add nv12_8l128 and nv12_10be_8l128 video format.
Date:   Tue,  9 Aug 2022 14:50:38 +0800
Message-Id: <84842bffb432884a0fd84de96c6e64ee2273e511.1660027440.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660027440.git.ming.qian@nxp.com>
References: <cover.1660027440.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d209edba-c5fb-40f5-e0de-08da79d39404
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wW8SNu1eOAj7A4vmda7etEqwO7ufCkUKMY8B/0nOzAAZbQSNjaJ9xjFKEXa9VL0Iy3hxTjEU0xS//U/AkBIHFNF4o0R6Gn8HjWqzJTN6Ly1wpzSP2ab5x8Q7LgyCRxStusR/gRUTkWsng9/Qk3dxKjpYbEHLsTkvu0SmOT1/Q+9hHV/pdvC8PFSpPIduO4tAjfNpheXmN5duIcBa9pK7fHyHj+z7LmnLODpucB435fSR0U8CHU9JsX3uc6vgmIjeebP4OFjW5APeDJrrulBiAu/AqPGwfBmcSnLmMlIN7Tr0es+iwljO8R0eEnRAAMvb9ID86FSK9FDaUBe7es1VJf8qmgezgtkc12Sg0LrVX5DYt9sPwZtteFJFwf2rmK9RqMKGNmQvt41/rfqSo8z7W/9799fKcODwpqsBp48au8oT/IAc4nGOMoncVzISQb4tV2oknW/zJ4705hZrd69IWhpzRKlyYEjqKnjIPP91LhuVnB9nqB1FVO2YD32LwrGA0EyordpC0Y3ZdIwC94/eRT6A2cJxTVuMxELhZzLPDn74A5qhXUc7+rCBKcCgzGsZU65mhRxh1N+Cg0gVYsx2NJb8eiN/FrmcIizvS21U4oqTDIfvb6f1LITPcfvv7+KmEjCEJWavkCllNbEzB2qYLjpj99eXwekJu/Ufx8MU0jjAYZRBOIHWDkUkUD5LK8ZmjSSVPt9rzA3Zjj1N5Cybj0ajhKyK8RcwjYILLKSV709NDXErIn07e9gTdJKMYiqAhxMVifitvl8tNSNkUB2y4yR5whjW+cemeGQYsEiTwQyofpPV7w9Yo9AUFC0bLDYj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(6486002)(478600001)(52116002)(6666004)(6506007)(41300700001)(36756003)(86362001)(2906002)(6512007)(2616005)(186003)(26005)(83380400001)(8936002)(44832011)(316002)(4326008)(8676002)(66556008)(66946007)(66476007)(5660300002)(7416002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Y2j8AEG1S7kG/5jMUlPBbuY8+9x4ree3nUSEoONBSgeI8HYMx5jGF/Z9U3T?=
 =?us-ascii?Q?uVtLzDCYvvBPS7cLUBWR9n7OS5g5iG/9KWEAgr8wFAh+ZOlDGhmp7bkSrDxu?=
 =?us-ascii?Q?uxJA6kd4Grp9bZgp3TTdrJMCqsccGPyjLIal6jWBl333+R33IF93Qpw8QfHO?=
 =?us-ascii?Q?KqlZmMQKLXnuJ4LcNW0exeNeZs3P855hQ0EqF5OoDQ24I+wZc39ABXYnEVLr?=
 =?us-ascii?Q?5eGNeiNR3OowKHg8mPUB3IQkcX/MtZn0FlQFP4L+9pJXx25hwKJmZrJTKgdP?=
 =?us-ascii?Q?jUUYHRIYBdG9PGt10OuBw9aw8svM/9Cb9nR/cN3IeJnEc/VqNVo9tDiKzVRV?=
 =?us-ascii?Q?80XLBxnp2rHv9udmeS5WhdF0pI6HLlqbEEHNrvlw/OyIWA9Vf6Cj5721q4U1?=
 =?us-ascii?Q?2f9WMvBuiIkjdZvtY43TK9DiuHRun2bGusAodszr7KbXrXa8YQ6vp5LxZwoW?=
 =?us-ascii?Q?y/H1+WmR4Na6qoanBgpu5547MjPuC8aBNEBOk7ZVW+jt1SaYcUv9I82APpTP?=
 =?us-ascii?Q?zVwGVb5wJSEKCqoaKg1z6NdImLm8TrXkMo0KMbtYkFyvk9Dx8el+QdFbo0HE?=
 =?us-ascii?Q?6TpviqSi4hiq+T5ZWE7J39XsOLsdQX8J3P2QM0wXG3419SASVYCS8oSgfb77?=
 =?us-ascii?Q?FhEEK0ZuyqpCfoTiM1D9DvOezsgfFYi5tTd3ZjBZsL2DdoE0gAcvBk8Kfik6?=
 =?us-ascii?Q?LvEv1UVWwsNFd7X1VoQkyvu0HcIWNAnzwx1dY7WVuFlLT1FZiSjfg3uUDUUE?=
 =?us-ascii?Q?AvwNKVL2iVdiZAgySYOFbZ9FVx8cILkZRKjjOQ/epz74Mt46ZQoTrjQ9HdM1?=
 =?us-ascii?Q?AjfjyzSr74qoT5/bzFFYpQvjiEBvhfFF7MC2zzNJFDz1GuGp/NaxzD3W9f7b?=
 =?us-ascii?Q?Ykh3wQR5P+mZfpCztaeFkLTB8a0p7907PFS3DnaAMsvu+hiFGhE3qH8sw+yc?=
 =?us-ascii?Q?5RPuV6887FMEfbRayTRICfZuBkT9rhgriwZcbAwHFFkugWE+6LI5/fJhPjLg?=
 =?us-ascii?Q?LurN6fEv96cmD8UcSuUCEmVicUkY9UOk25lwDXMhVOCMVU3Ccmu+5iqnv+kL?=
 =?us-ascii?Q?JhaZWYq8jmjZvuPyk9bDs6oD4C/iA2Y6DjstIAASQI6QK2rrAx+MpsdKxtTp?=
 =?us-ascii?Q?+DAxMeir1GKtGCnZ0bG4DyYh4rcLnqd4IbzFQdVJo1gArskN5FTqvkM4Ho+g?=
 =?us-ascii?Q?LvCR+nSeZ0EYO7I1jx1/fm6hzpo4VNer02y8NITF7zH/f/c55dxgojrMk4Z+?=
 =?us-ascii?Q?aTFRtIQpnDxERJHjC0ni+fuPTc0u4C2QRBXdWxd64fnluLEAmGDGWQaI2TJK?=
 =?us-ascii?Q?SYwycfhCp4JcLls7qLo9OeZMVnkVzcn9Yp6y783rhRmZJpFtw2/KyDxfjy6R?=
 =?us-ascii?Q?dEfG2LzM61LVXvkY65RSjop5RT3HGmFiU0UrPgM1LnixJ2MorZNxVpKeLp3J?=
 =?us-ascii?Q?Aj0ntQW+htN7RGRbchOI3jiN3n2hqENwGWq4ZGSKpV8CTGcBjEwzuJ+C4Adw?=
 =?us-ascii?Q?I9LOIR+qqsLbYm9wMQkPbZA8Bey7fL8o8zjhvCm3N1EXOR+XVgmDXaLvCo7t?=
 =?us-ascii?Q?r5N9KtBKTzt09EFNjjCG7Lk15xeciET5ZNmDPmY3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d209edba-c5fb-40f5-e0de-08da79d39404
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 06:51:25.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdeSs1oNL9DPWnOxbPMuetKLvaDja7lAJ8OJJvqMbiAhUqg/dE4A7teDP2OolPhoo66GeQ+AbRfee/4vOH3pAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

