Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D812586630
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiHAITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiHAIS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:18:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C654D3A49D;
        Mon,  1 Aug 2022 01:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a76ks7aRlYW4JtC7bDrz7j6cFok0ZFTEjjRnbnFWmVWHvV9n017fcBkIXAbHsjXM1OV6tz1RiOa4kP953FKaZYyLXCubJj4bbsbrHSFMdVkerStZPaHiqOOI8ZUZxqitc0YASF7Z2D+BpfzXy0E55lfgt4nrZpPEAiUQUBEFLvWvhYkKmi9dajZm6AgZqaNY3BN7uAgQ2GBhD3QKyWYI3kKI/vNwOhiAxSelOuTTilP2V/g354sCdjue1E3p6A8QFzqrcc/Av13tQPE/gR69bjIKsrse659dqYiTxHAussI1PFWpp6sYY0czetd0IkDXxbx2YdkvTSVFe5C3zZpcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILbwKsQESriic4UJzwgOD/LvSf23rx794JCog4tYBBg=;
 b=KDf5TIVlBlPfoeSMt/aaHk3KPmZZ56mKIfXSohPQc9vSRr46K3M8RJFEn6nWmkfmvTHFoCklm/mxTIIggn4X+M/1/qpE6dnZZfiQNvUh1I5eiDVjbLBw3JczLkTgNCNAz8Xsr8mwrhNAbk90CdYkc7i4rFfaV93Br1pD6DtqaQv/aO7sI8rQVWRBwqUOiIyTzzoMla1PoVLOpNV32ThhscTUfcajshGbFhxX+u2l8fpDNzwLWfcrHDdWz4A0qvprcD7iy13s3ahDdo0yb5Rz5G9X8DVsijYLn30n3lubuID3aZT1bHdtqqpwKeAdFDa2L20vwfW7L4FaHhzbP3KUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILbwKsQESriic4UJzwgOD/LvSf23rx794JCog4tYBBg=;
 b=c/sQ6+JqQiPy2CmLxZmSfogNFsEkCbxiOZtGSmOoVaOzBfMqW7+pxnSSI2BeOEHCuCLJFHnXZk1FoHpFNJ8ltUbW9R++HGoS+YWF6pv8TeXYCjT5YFrM+8wpo7pdK9F4HQIc8rnsE2LZw5L76/xeR7d67adko1GAre1eKe1EjFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 08:18:54 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5482.014; Mon, 1 Aug 2022
 08:18:54 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] media: add nv12_8l128 and nv12_10be_8l128 video format.
Date:   Mon,  1 Aug 2022 16:18:02 +0800
Message-Id: <84842bffb432884a0fd84de96c6e64ee2273e511.1659340974.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659340974.git.ming.qian@nxp.com>
References: <cover.1659340974.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc905b1-8ac7-4c32-07de-08da7396796e
X-MS-TrafficTypeDiagnostic: AS1PR04MB9334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoCjB58mS23UIulQPhn67y5fVNV8r4cqJWqB/04+uEQ1ZsytvYb1+b9gtRM/srFugHU0Ken3lAO32h+VmFmUtfwVnn7J3/jF0q+gYu29S8UaWXUliqAhzpWB1t7RIQWBTbnLOZe50VHS4e3bD/i3hq4MY3GGYzKlQcn/WknmLkdhRH/IO9dvBdQuAbVm4zQer8MjgS6sm0AigCASpL9MECMEEIqQ5jH3O2CXH9KbwuGv3oJ1g0iCsPcmMG+rdqgS00NoLAqrNhULFw7+FXGdud9dujDGEDJ7Wk7dxlcYPwwDM+8v3p3Wf/GinPOec7Ob3rM8HKjYQDAKyGBWSrGXZBtVD4M4AvyD4rRy+e9CDLvE66XGtvtUA4NWHjo+I30zBcA3f07iMX62ggVMIhJRkJEKOgy9CqIpHLWyHKsBIjq9J2smwL00XIimEDBo2CVcd7TDbb4xEJTKjVAIM0yMDDY07lUg6YjarmFY+0iwXwUKiMmJ3OJVpQXEbYFh65uJTqTNpJmn8KUqknnS9TQ8BcXISvEwrSPQ5pepPIOi4ZQbBv1Y9XVKfxmOTWF+9R3K6I6a1XC9bFk7YLL0u9jsiwWiZmjX47xl9Fa3GhYBpmSeiSVNfkoEEz8nyndeK4NkFV1dviJbxZn1iiALJd86EEIvdgxiJQfj6YOQVxQZnk0sEWPkZu949u6mVc84OhAt4RWdbTFQ5ppxyQVLNl0cae6v9IcQzC4Uqt2s/kaei7rgBsL4WbNuCHPTk3tl+mTryo/NzhoVWY2rDlG3+6XN1e70G4/x2G9w9H3KqnU+KTHd8zU/mnEwujv6i++XfwRX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(66946007)(6666004)(316002)(6506007)(6512007)(52116002)(26005)(6486002)(86362001)(2616005)(41300700001)(38350700002)(478600001)(83380400001)(5660300002)(7416002)(44832011)(36756003)(38100700002)(66476007)(66556008)(4326008)(8676002)(8936002)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+sOYqIOQqs0c0U7Wvpmu4600g3JBxKP88X9f7Xw2hFT8ThkwADjtsZBXu+p?=
 =?us-ascii?Q?oRtXDQm0g2pOSnZ+kFZ2OwmFYBHXjTk2MOFWGMyCwYlCT4C0IYyRogPsdwja?=
 =?us-ascii?Q?Z2/YeKsBCgl3WvhTyxGBLSc7lpyc0u4c0clYfVM0MauLA6HCoU13HkVKEywo?=
 =?us-ascii?Q?aGayhy2YKeoGhhuWN7BaFE0TkwppHq6ug7NlDngowppp9cSZazLbVTHQrXTB?=
 =?us-ascii?Q?Yvs0T4Uk2Qy8cdcgg5NfmNBxjU3bGbq578scEwfEo0cbTaDSr2X2fu4mPg1g?=
 =?us-ascii?Q?e492vQo1mEy3la4rQl2FU0MWsXxer4Yil1jGwima7uD8fzJXax6quKVEcMhV?=
 =?us-ascii?Q?P4tN9oD2xRYb5AVrhpbicHs0QFWjyY4WVf4OInUPd0jXWSkVrMhbjgknQv+h?=
 =?us-ascii?Q?ginpVXIfmfYh/fL6SsFCHSmCTvUa/+LHMuN24cQbOeTynO0EWJUZRAonQ1fO?=
 =?us-ascii?Q?VXKvmq00ZLuTMbBjpJK+bL75FKvF9F8PyRWvm0bT6Pk2TKjtbuhXMq1vfAbT?=
 =?us-ascii?Q?v9FZXy+Dfnrgib/BHoBm4yisjAId2lyDKoxMM2xD4r+kGkn9qzpyjXiLB8pW?=
 =?us-ascii?Q?HViZdAF6Q5ECZU67ZtfGF/BSUoXsFCuti+kGqah6e79xFJQxvgoL+Rjg3UXy?=
 =?us-ascii?Q?aic1T0wMWwsup934k6Dh+1kpQq2p5wvj8DCm+xykC8bNABL8bMiHEBG+4/6a?=
 =?us-ascii?Q?7zPsE4ToCJkfjliEPu3pucIHcuiZjbQgKxhJBm5oxcbS5NWe36uR/u39E/V5?=
 =?us-ascii?Q?tUHbVNP9HWrj0uJWMn1T++hgR9P5u+cprf0hY3gUkT4cs9d9b+WGQJDUZGuT?=
 =?us-ascii?Q?dA8li6MdT8et5Sh/YDB9V0ohgKGVybgBFMvgmFVrYz4TIBqjBTFL4DKUl+4h?=
 =?us-ascii?Q?wDKwnudK4a3JrJNKWz8URrNFfW9wydrVasQOjqEgWjJijz+hR0C0jLl3kAge?=
 =?us-ascii?Q?Zg5ItdeXKl7tq0JK6lb2vY5EcOIxE6K5Sp6xcRvnPZgjfIG2bzuPQ8O37pif?=
 =?us-ascii?Q?CGX1nfuYSoHbaAnhGmKVPabwqTLVFiy7fgvmfBPFmGeGnli9C1INjCY9WwCi?=
 =?us-ascii?Q?Rwcvca45u/0vcIEy57vIjJTvKb94VcoYNr9UvakR13oPEcgrFeIhC6zKzAOR?=
 =?us-ascii?Q?SDikNETR/xYzLGM/X3wcIDljl4ehNOf8MIabovbsrZ7pN+XfOOwGDQvVQk3u?=
 =?us-ascii?Q?7UVdibHADj0+jLRtwnyqMJLm7kaar0GUXNTFyLkL5umKeDkBr049V4pahlNL?=
 =?us-ascii?Q?SWA2Z1DKaAt7+FfwPe4I9NZpvScHiQ3KeRCq49RIrCrhhK1CrRT8jInr8CU9?=
 =?us-ascii?Q?r1veQoLAppS+u7ZGcHKnrZJZKtwCVA6gyUldew/I7tasA+oaGdz5Aat1nGPl?=
 =?us-ascii?Q?b9bFjg8Xzgm49nVVzGkrEJaBXMuWWCvACNxh85Is+2wur7nGnQaECfIVOnOW?=
 =?us-ascii?Q?ygMdYFLFk+rSZnGLSfldy4LErpzJql68HS4A6G+Mhw8Amigh4pbMHIuFU6GD?=
 =?us-ascii?Q?MgQFOZIM1dRG0n7hHIULUVWV5yAdoE3G5pQUYteEPfbL6L/WG2oos87oDBBF?=
 =?us-ascii?Q?7Pq6CtuUK5CgsqbuZLEQMBzfkUHwGFV4Yi+saJ1w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc905b1-8ac7-4c32-07de-08da7396796e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 08:18:54.8076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARnVq2kPrtYYQrO7QofLeHhG9SIieSmk3fGZemL+Fkm0AQK6yNDwh+DyoWxwD1P2EGvi4okzLz0jpfS0vgxFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334
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

