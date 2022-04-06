Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494D44F6109
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiDFOJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiDFOH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:07:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A623E8FF4;
        Wed,  6 Apr 2022 02:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmZWimkj37LKhRiGnT86dexoKcZIyGJQ6zOtiU8dVfO2M0gi3Ubp8YaC548XRkIo38CH5xmDALnk01G6qlwSy4FTfGBCgRNAwlVuoDgeRw/i+xmsOyVK2twF5y2XZLhTpuhziQ2/8iHKGrDgAhH9SDjpag8fFFTuOS7cu1x11zXW+Uz0Alh07u2C728Yb8wqQ61MF82zbCqv/+zrKXiFMMoZkKlRKQwhlj7gq11gWrpAi9kLxYhmE4JG57B2IOkqbP1+aoU0q8cCuv8axw40r0+LIhxJsIqUqWBQq2f+rjuWesuco4TAeyyDIpig9MD3LxoVntZ7fxd8ViB7KgTzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBxMl+rs/WT0rXg2SGOJ+iS/lW34dizmq8i46EPjF+w=;
 b=a3zXF2Sg31Mkx2CyMAdSJoiKo9udHxiXmRZPhFWh/IYICa7RFRa5EUapKXfpq1nLMSK7KbockCH4n2lFgZkhJCowqXKrworlvnG9t2NyMuGZ91uDaiMfXwKLfFELT6EzbGMifq5lY2EzCx2JW7XcxXcODTuS5adJfQMbUPRlgazlcq1nYFkGaIXooi6qDk72ejAX7sIXRJE9FBjW0Xsyo6UuqOz0FwXdo/EH60I5Sn4LQuMR4uBJyntUjs5gz95MHtRWhgYpNmezacONAcm8O4aGNjfnDZ3jySiBcBWgnkMFtL4XQUDbfnFn2flo+kYiX85NaAHqLvBtG0ZsoAlOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBxMl+rs/WT0rXg2SGOJ+iS/lW34dizmq8i46EPjF+w=;
 b=kvACuLQbMFjxe/X9rNwYYcAg10fLvqEWtAL54hUFMfhfL+hZI1et6N/n1pGRTJdJAfiYkXQRPLMjf9Nr50ydfhbpNBjCU+xFui6he+Nw+Wj0kVdOnj4IVxQC+nKCeWhQ4TQ/2VnJiULeHjfJdUj1VPbXSNnsutuQjFUIWHBUO7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 09:48:28 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6881:df46:ac23:1bc3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6881:df46:ac23:1bc3%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 09:48:28 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Correct the pixel format of rgb
Date:   Wed,  6 Apr 2022 17:47:33 +0800
Message-Id: <20220406094733.8562-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69613151-fcca-40a7-5b2c-08da17b29a01
X-MS-TrafficTypeDiagnostic: DU0PR04MB9443:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9443730DA7A1478FD47F2A0DE7E79@DU0PR04MB9443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HyFQ6+wunKnC0jkgy+HdJ3SUEsEn+NClWEmafxG+nbK2efhcr/+N2dz4QECPA6PzfBDprEgbd4s5DhCh7htSq7Lq2wj6qFwf9Ja+r+3qix5yCCUdm+xg02mNBLApeJlIINj4TlsGp1ZtCo0HZMsAdf2k9evReJ3tFJ4lOoZnLpS5886OjVnUCaDGAwWOMWZwvPlme+02fEXnBX10R35RBdbD6gK8EllQSSY03wk9VTrQA67z9q9mxTscb9lT4yvIjnY1fNdTgU05c2RluyiaKIzQgm3v6HZtALMO8zuDMpuEJHrp0q3ofHNQBlaaeXdaxwkDf+bxi+hkc+9ELj/dnuu/lnv9RKea5P9ReefiAJTFArOftd6gtVM6QLfaZf/8QYXFtdEMoQcRc3t+bb01ZonOqD+CaQ74QJRnnuou1CYXA2cTFLmKPJVpt6B4pD52PTbKHwbB30eIqrCKDu1uXTzC4bA+1EJBounjljsdsPj1dxHANBErfth+CPNaISCVxBFqYPFKIKQWOSdeo9iHXDX+K0KJ5WeQpHMHNTgwenIX3kKEW5SbHO1SUWkIAbCUUBJ/pIIbk5f+xu8T528cleQ9WpaAmJLRmQbTCQAcrVF996Y04AWe46HEvbILr25cKgx1A+rC8dWGYhAWyqF6WdkyywShaXnqgE69zVEPAsKmmbg15utoxkmjTfjNixbtpYSJOf6ge9ZKvGPGNQ61w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(8676002)(6486002)(6512007)(52116002)(316002)(6666004)(4326008)(6506007)(508600001)(5660300002)(186003)(83380400001)(26005)(66556008)(1076003)(36756003)(66946007)(44832011)(38100700002)(2616005)(38350700002)(86362001)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2f1+cn5y9pq/8cZBgBgqfrCAZ63HRupOf4zVTjdLEr0JjccS1/MwDXohPOLW?=
 =?us-ascii?Q?KfEKNX8EQuMhWgulFpu2e5IVo/ZAkz6WFtw5j4Sh/ljSOQCtNZB6A+tO3rAo?=
 =?us-ascii?Q?YmQO5tHtZSEJFMRXxQ0LC9awkBuWjxZiJGgEJbyijQ9PnfxhJvXKLjsxeK9V?=
 =?us-ascii?Q?JqC8Lj4uXGbpkiMrOHvgo11fxrS0lX17F3llXH1XNEtuAvgT14p/MORJtDik?=
 =?us-ascii?Q?lubHFzeKsG0DUX1cdG/V8MOSI1pb/58L8bfE69+jPS5MD1viHVlHVaKbg9qI?=
 =?us-ascii?Q?aDTJEVcKdIACnfviRgo+5kSwog26ctnhqwzVPHfqf5o3kVArpY170o2j6B1d?=
 =?us-ascii?Q?0k7yoBq6jpBbA9Vsdlzc/GgZg3Xu2x0UuMsuxvy7rV9GjdCJY+blyzXNI6bb?=
 =?us-ascii?Q?upy4fa6aFivTLBHjSG23QKZa0ARntnLvC/qqQlBU1Awhrt3BQH0xFUkbEsyA?=
 =?us-ascii?Q?icyk55Icf4LXe8mLTaxIA9BusGEIiIPbolNJ0jZpLVXPOYPTlJQnOu5Jhd47?=
 =?us-ascii?Q?o8gOc4ocRM2AwoE0PMUwCeXMwkFYgsZLnrktMJUf19AQFKKYhM2rIOCuafzf?=
 =?us-ascii?Q?CYCWkfnyH7G6+yY6dnXvDcgSRbKKj+a7E3bd8VTzHzpeGQ7NmDKEuMMKRmmM?=
 =?us-ascii?Q?mj37I246snIeFbuMA+9+eYWdVLv6uoz5WoDoL1OloUZQzhO10xmTdfAeBuqp?=
 =?us-ascii?Q?+lABgH1+PpRTYun/6vDWKTv9vhbb+rWFcz6eWgSfaqrG5qTFv9ooGYUSoX5Y?=
 =?us-ascii?Q?sngvbLeNZzFA6sEJvb+CUxe8bSoAVHS8jLe8OwiiorF2Kjfk6KbCEIEvtEXI?=
 =?us-ascii?Q?AxMMuXWTlqx6caeG4YJPGASe+UTYqmLFUW84KWqnd4/BEe0dcmpaIjqT4h79?=
 =?us-ascii?Q?lcryK29Rt5HUf2vID87uGnU4KOv0+BPNU0pblWhIIoGtjqSFlCosgSAlnP/h?=
 =?us-ascii?Q?gagKgqepaJneAhxYJim7dRJKbidbAwlfmjex6WVGslKccNMXP6P+es+tTQID?=
 =?us-ascii?Q?6jz2JMpC6dKXCXQ+nf0ghWO6vw5JAdp8mW3bY+rsd/FzoA/dK93ccQizvILj?=
 =?us-ascii?Q?L7lYYJpgqLlrSeYNugvDpn5+hVtkylOyR7UUJrRW1wJyMUikkwVfUXsetBmR?=
 =?us-ascii?Q?YqUA3jtiFgjhqLRhAMsxlHhWx1E/BJKsSFoLL+YiWkktKGxteFjTOv7bwYKA?=
 =?us-ascii?Q?PAsd6RHlCetUti3NpuqLwIehYxCvjnDzu8mB2KpjR6LZq2F25TymqrM7G1qV?=
 =?us-ascii?Q?/iw4fjAbaYhAOOlVPBaMCHrMg6340XLKFBItAHr2oV7DHbrP2CgmaSWhF1nL?=
 =?us-ascii?Q?ZYtAWpanOBFUQrqELY+Brn4udqro2T1Id2EOdHpCPiK6mk3jln3MlFoMAjBb?=
 =?us-ascii?Q?JHR65bBmJf9GV+7PKtoXg4nhPmvRhFH5sMPVD5jVac9ihIFv2jWYFZI6Bax6?=
 =?us-ascii?Q?EFF5Sriqmos+7WRqYQffoaa+hOH6GvGJQjm1oRQdrmvWHJOtuZHmuYJ61IJ/?=
 =?us-ascii?Q?5Tce4YuIrFj5mQOsNyUGudX5sGoBeyiVPqknENc2IoL6MmHYCOhxskhDqBiP?=
 =?us-ascii?Q?1cp+YOW/3CUH5hlSNiP/E9JMfvBArY5A/k4CgBH07J0H5pteEsoIyvQnBSoX?=
 =?us-ascii?Q?NFHQ9CDMIrNQcvESbN4CQpfUVSgRx/AtoonBs1A6jNsCJvUDpLlp8yvgfBnm?=
 =?us-ascii?Q?uLCN/soPBh8TWjTeJqqOYxfjkzmBXaOiXxCx8ZeXcifVJncrblQ6dDY5+Yqn?=
 =?us-ascii?Q?4Y0pJvqaxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69613151-fcca-40a7-5b2c-08da17b29a01
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 09:48:28.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDSdvNgS7hQrxiL/BFtXEbzJOzOMvzdWE/CZ5aCPM5roo6Vp2bNUHbP7gT2JITpSMk1nujV/j3D86YWaOl9XIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware is capable of encoding/decoding RGB and ARGB formats
in whatever order the color components are,
but the resulting jpegs look good
if we start with raw data in BGR/ABGR order,
so we will further only support V4L2_PIX_FMT_BGR24 and V4L2_PIX_FMT_ABGR32.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  4 +--
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 34 +++++++++----------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index 356e40140987..e7e8954754b1 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -102,11 +102,11 @@ enum mxc_jpeg_image_format {
 	MXC_JPEG_INVALID = -1,
 	MXC_JPEG_YUV420 = 0x0, /* 2 Plannar, Y=1st plane UV=2nd plane */
 	MXC_JPEG_YUV422 = 0x1, /* 1 Plannar, YUYV sequence */
-	MXC_JPEG_RGB	= 0x2, /* RGBRGB packed format */
+	MXC_JPEG_BGR	= 0x2, /* BGR packed format */
 	MXC_JPEG_YUV444	= 0x3, /* 1 Plannar, YUVYUV sequence */
 	MXC_JPEG_GRAY = 0x4, /* Y8 or Y12 or Single Component */
 	MXC_JPEG_RESERVED = 0x5,
-	MXC_JPEG_ARGB	= 0x6,
+	MXC_JPEG_ABGR	= 0x6,
 };
 
 #include "mxc-jpeg.h"
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 3df51d866011..8bee179c5cec 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -8,7 +8,7 @@
  * Baseline and extended sequential jpeg decoding is supported.
  * Progressive jpeg decoding is not supported by the IP.
  * Supports encode and decode of various formats:
- *     YUV444, YUV422, YUV420, RGB, ARGB, Gray
+ *     YUV444, YUV422, YUV420, BGR, ABGR, Gray
  * YUV420 is the only multi-planar format supported.
  * Minimum resolution is 64 x 64, maximum 8192 x 8192.
  * To achieve 8192 x 8192, modify in defconfig: CONFIG_CMA_SIZE_MBYTES=320
@@ -73,8 +73,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_ENC,
 	},
 	{
-		.name		= "RGB", /*RGBRGB packed format*/
-		.fourcc		= V4L2_PIX_FMT_RGB24,
+		.name		= "BGR", /*BGR packed format*/
+		.fourcc		= V4L2_PIX_FMT_BGR24,
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
 		.nc		= 3,
 		.depth		= 24,
@@ -85,8 +85,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.precision	= 8,
 	},
 	{
-		.name		= "ARGB", /* ARGBARGB packed format */
-		.fourcc		= V4L2_PIX_FMT_ARGB32,
+		.name		= "ABGR", /* ABGR packed format */
+		.fourcc		= V4L2_PIX_FMT_ABGR32,
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
 		.nc		= 4,
 		.depth		= 32,
@@ -420,10 +420,10 @@ static enum mxc_jpeg_image_format mxc_jpeg_fourcc_to_imgfmt(u32 fourcc)
 		return MXC_JPEG_YUV420;
 	case V4L2_PIX_FMT_YUV24:
 		return MXC_JPEG_YUV444;
-	case V4L2_PIX_FMT_RGB24:
-		return MXC_JPEG_RGB;
-	case V4L2_PIX_FMT_ARGB32:
-		return MXC_JPEG_ARGB;
+	case V4L2_PIX_FMT_BGR24:
+		return MXC_JPEG_BGR;
+	case V4L2_PIX_FMT_ABGR32:
+		return MXC_JPEG_ABGR;
 	default:
 		return MXC_JPEG_INVALID;
 	}
@@ -697,11 +697,11 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
 		sof->comp[0].h = 0x2;
 		break;
 	case V4L2_PIX_FMT_YUV24:
-	case V4L2_PIX_FMT_RGB24:
+	case V4L2_PIX_FMT_BGR24:
 	default:
 		sof->components_no = 3;
 		break;
-	case V4L2_PIX_FMT_ARGB32:
+	case V4L2_PIX_FMT_ABGR32:
 		sof->components_no = 4;
 		break;
 	case V4L2_PIX_FMT_GREY:
@@ -729,11 +729,11 @@ static int mxc_jpeg_fixup_sos(struct mxc_jpeg_sos *sos,
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_YUV24:
-	case V4L2_PIX_FMT_RGB24:
+	case V4L2_PIX_FMT_BGR24:
 	default:
 		sos->components_no = 3;
 		break;
-	case V4L2_PIX_FMT_ARGB32:
+	case V4L2_PIX_FMT_ABGR32:
 		sos->components_no = 4;
 		break;
 	case V4L2_PIX_FMT_GREY:
@@ -764,8 +764,8 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
 	memcpy(cfg + offset, jpeg_soi, ARRAY_SIZE(jpeg_soi));
 	offset += ARRAY_SIZE(jpeg_soi);
 
-	if (fourcc == V4L2_PIX_FMT_RGB24 ||
-	    fourcc == V4L2_PIX_FMT_ARGB32) {
+	if (fourcc == V4L2_PIX_FMT_BGR24 ||
+	    fourcc == V4L2_PIX_FMT_ABGR32) {
 		memcpy(cfg + offset, jpeg_app14, sizeof(jpeg_app14));
 		offset += sizeof(jpeg_app14);
 	} else {
@@ -1277,9 +1277,9 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
 	 * encoded with 3 components have RGB colorspace, see Recommendation
 	 * ITU-T T.872 chapter 6.5.3 APP14 marker segment for colour encoding
 	 */
-	if (fourcc == V4L2_PIX_FMT_YUV24 || fourcc == V4L2_PIX_FMT_RGB24) {
+	if (fourcc == V4L2_PIX_FMT_YUV24 || fourcc == V4L2_PIX_FMT_BGR24) {
 		if (header->app14_tf == V4L2_JPEG_APP14_TF_CMYK_RGB)
-			fourcc = V4L2_PIX_FMT_RGB24;
+			fourcc = V4L2_PIX_FMT_BGR24;
 		else
 			fourcc = V4L2_PIX_FMT_YUV24;
 	}
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 9c9da32b2125..6e8c5aa7d956 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -17,7 +17,7 @@
 #define MXC_JPEG_FMT_TYPE_RAW		1
 #define MXC_JPEG_DEFAULT_WIDTH		1280
 #define MXC_JPEG_DEFAULT_HEIGHT		720
-#define MXC_JPEG_DEFAULT_PFMT		V4L2_PIX_FMT_RGB24
+#define MXC_JPEG_DEFAULT_PFMT		V4L2_PIX_FMT_BGR24
 #define MXC_JPEG_MIN_WIDTH		64
 #define MXC_JPEG_MIN_HEIGHT		64
 #define MXC_JPEG_MAX_WIDTH		0x2000
-- 
2.33.0

