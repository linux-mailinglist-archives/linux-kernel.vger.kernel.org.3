Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA44BD5D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiBUGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:12:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbiBUGL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:11:59 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FE9E88;
        Sun, 20 Feb 2022 22:11:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXfMpjNdYQXTHB9bC+X36/vS0ostMCwbu8yTBHvTB5k2MV9u4vsXLNS3oTtiqsPjomJHe3TwtTAQ03UAY7Up6TT5S7zQu0bTiy8MUrLk503wQr0WW49FujAwW2KpFIGx7ty9tJnuDeVXqj5syymhv2s2a+CpGRLqu+4EWAZeuCvHT85dUqRgZzMHnkJRQOSsQkifEBMXT7yzfxmWJ9A4rTYhdc9aIhPxttAISgP8Z7Wpc+vuYiJaMDrLAJZ5ErvBTEIz1AzOPCya9NNmMnyn1Ggrr7VRHkKRw9GoxdrVkG8oUMB/mjK+m/BIhSsksQadCKSwIm5wS8+gjXCMyANpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plLDORXfJ0kB23R1bo+KVE2ciUsqdDqv8gmuxm1eh5c=;
 b=h+1Z+lAULKN2IkVKsIBp4X0Nvj7C4Zx3qOBQBvVpVFWnUkepNNHwsIY1vr4ilHB/e4dkDqQvztx0355eOMxXutVv2yzUjpbVfKboAY9xxUmbJcfKShvN7XBHR6Fo9BkMwvD8y1eNkQlIWKI7lMgAR2MUmPXGcqF7Ia4jP5oy+oQQx4NCauwCUYkw/Gua615BaHg0saBKkyGA8d2nghFySASifBPbcvJK2WQ7sdmKeJEfw7qOB3Podn0Xo+oC5aMIsd6drIiICpzgfAxALtIHSwjyZmyt92HzY8OAyGVjdUjx5Dt+xFf2pDyftHLbr+X909v2K0I9mEECcfzVPJWAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plLDORXfJ0kB23R1bo+KVE2ciUsqdDqv8gmuxm1eh5c=;
 b=JBdngCCjv+fJoZuUYaR26CIX1p++jguC0r4Obyxy4XKZ9TrRg12SeYcH6Tw1eXwj4INKOKTDGeNlgbSp5HBDpKTckRSMxJnfjTtdsHkuPQ8glJzkr7G2qo+6zBr11/AAJT2HHOa0hCNu/bfZlgueHLgLr0aZesgokNYztYiuWdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6064.eurprd04.prod.outlook.com (2603:10a6:803:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:11:31 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 06:11:31 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 02/13] media: add nv12m_8l128 and nv12m_10be_8l128 video format.
Date:   Mon, 21 Feb 2022 14:10:21 +0800
Message-Id: <f73dc2332f965a9ab4380895a883119a8642e160.1645422822.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645422822.git.ming.qian@nxp.com>
References: <cover.1645422822.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f85e8800-04f1-4775-ee9d-08d9f5010129
X-MS-TrafficTypeDiagnostic: VI1PR04MB6064:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6064C79B834AFC1F41797508E73A9@VI1PR04MB6064.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E998cRHVhuDd0yfSfihhPK2iwOr/jpjvjN+rWPGocDKxnjrw9DZgPPSvm7tk4Ka5WgN299F6gQYQAV1sA7XaFVQGnX8VdwEcodqOw6GMvLsSIzGZyFu3fWVvcrzUNn2aG7SOCPz5xYEMUoJo1+LtA8LB/HW36w84xQ77JlC8/KmIr3mlPa2+DgDTnpYy5+uhMaZ2BtBkfgGV0x3vm+H4jbImc8Ap2pe6mAedsCxME+VO0yjXJohH2iygV1L6UtcBWM2Xy6WbOfQlTMGCTgs9q90PVAx+ASf+eVl/77u3bA3jif5ggHNgvxi3sF5Ei18HSQe/MgryB+T8nKync3L0xbe5gFt/vUKXjFVS0VswjPopKnmK3UjFsdRD1nPs8SlfgUnyM9E4t5u78Bc7frfd5W/FUkwlHZZzQkaJNCkQPFRkmPBI2iTFkFfrj//mcQPlQO2apSbOBdVx9xTjaoLlJTUuY7proBOUfZm8ezPGsuK2C+bFJaVjbkBxSpt3aURXhN8JoOgC9p0xtN41hxW+f5IyRCD9btqOTDdzf4efhw6FoPScXFDq3F8WczZb6bMYQQPSz1BjT4qqXt8JZWW/bE0U0SNYgCUQ5mQHAa9we/RiAF8czq28hY+jbj4MxhUtFZQd2Ku1/u2M9jdDhfpA1RwhK5NFU7TVhHILv4p242tuwmtRxQKFBSp86cLitPkVWT8lwTOyPFUFzQpEsFsh/8XRB9p2YA9y4pM0UWDawpTEqgkfHT6Rl64q/c2wfNfzZOLj6hGp0MzHHXwfU+WCZBhK9ocsPoI0GoCY4ps+Yc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(36756003)(966005)(86362001)(26005)(44832011)(316002)(6512007)(508600001)(38100700002)(83380400001)(2906002)(2616005)(38350700002)(66946007)(66476007)(66556008)(8676002)(4326008)(6506007)(6666004)(52116002)(186003)(5660300002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VUWfzZPZzw1/26pc1sQTjGoOt+Zni/3YO1+RTe6YWJFM4RykLmwhxQfXRfXA?=
 =?us-ascii?Q?ppFI32fXsfN+7IaupJhJclKG6M+31DLbOjQgJBYgM0OhvhpScInfy8OzeZrJ?=
 =?us-ascii?Q?fZS+oPSbbUnBrMb5TMVGNdXlod14Vutv7TDY8YIDrdmfx8aHbzpX/QMGnvJt?=
 =?us-ascii?Q?a61VqafQk8G0m2sIKEE5Sdt/iqAjsEg4z+ef4LiHxwsROaGkE8alzkxsewc0?=
 =?us-ascii?Q?4XNgh+gTFeaB0B1CESeRXIEZTrPyswZ9Kjl/Bk9VQnM0VBNWDPafpGuMYSEP?=
 =?us-ascii?Q?zbjEkiE9Nqrkmye0gAdUUhACBkFEwNNwgNCW1yu5ObL4rguqwdwA5n/b0aVi?=
 =?us-ascii?Q?Ok+PwAVQFAPGZmLpeaa2QLF7lsKNs0/h5CJten+C7p2RDsgLa7T+9hsc3qPV?=
 =?us-ascii?Q?cCvJ/PQ5gxEnQiG8pg9BQxfYi0mFEpQ1cw8p4Q17knafZCgQZBDTuYsbaV+c?=
 =?us-ascii?Q?/gWLI4cnoAqxQhvcnx4O/wC95URhn1h/a9Nmmbwi5s1wbkP2WtDdQ4Z9X4+f?=
 =?us-ascii?Q?NR8xHBhSVj8qzom3aN80OB6C0P73XwrI0ypZHRzG/goinMzDv3d9JHqOxG9x?=
 =?us-ascii?Q?5sHdfHHcKFFumF8atuTV/rU7SudZQzyBFuahd4T61cNerzVqcfP1JYOPOIhs?=
 =?us-ascii?Q?5B0RARc4RwiHZ6obbcW2UW5qA/9+7Go1RmaJdXha3NW8VVihMogIU91C30Af?=
 =?us-ascii?Q?19/ANJK60MPuoG1ZaVEpJr9TN3navVkOKEIGfG71oPcPoDmvQKe7eDcM2AZa?=
 =?us-ascii?Q?bpu4tcTy9SI6+xgaZFdflVolehK2OvV1NubOUVeHmI6DKVHNaMD/nIFQYx6T?=
 =?us-ascii?Q?0zFMoDXWtzgl/L//6erBUBd4g9w/k9ujLKrMrF76covQKLaIuxWhqH4e+H02?=
 =?us-ascii?Q?PF98kKr6nnFLwtnUMn003KwhOfdfWNZndSmhsfjnxQ2ECGqQXAGbb/4a74dk?=
 =?us-ascii?Q?MaFxaWQiRDru35f3J/CKsSBETrggfWJm23vlSogd9j+s6/WWYg5D49F179n1?=
 =?us-ascii?Q?5/l9nX2AsCXaB6L+n9+N+25SHShXup8ASRleFADKqRwnupIOX2CNjjB8Hz13?=
 =?us-ascii?Q?NfjcP0+tzCAkPo08bmAeRB3GBrTdOjblHwBRoMhKwdMJk9kb+Q5RS5yFymjJ?=
 =?us-ascii?Q?S1C+odO94oivH4642A0GZGPjoPABzJoX60mijKM55dGf63t4+CX10bds2Jym?=
 =?us-ascii?Q?/x5a8xli8pK/emHFer5bHT/yhgfFAPo8hd80Et+YrFVoUXJwduU/fhJRxCRe?=
 =?us-ascii?Q?P8/6KR6+y1AkcAzlPUVeKcoRxySiIZvnlOHKC8nice2ZxK90wr2M+l5e2VGp?=
 =?us-ascii?Q?k5WSmEKlQsEmbUhL0MRubVfPXqDb2hRPtrTK0Bq6GXXVFnRQ93VY20bBXWGw?=
 =?us-ascii?Q?4fXSO8txd3bODR9lDhvzlvzEMUa7fwNoQntXgzvrRvaL5rPvOVp6VkSP2emd?=
 =?us-ascii?Q?oavxK6u5ndOgxjofqqUT+tB9OwA7V8uVAEIZaUg96eg/0kpn+LsVRn/cTaV7?=
 =?us-ascii?Q?QOaLb4Bax3T198AmriLvrlGU5KuXpQje50ay0/0h6HfIp02wiRZ2gt7wRpWg?=
 =?us-ascii?Q?QtO5gpAm2p/e2VcYPG5Jw1skfSvlVhHjzB3YFWyD8l40IrKcz7i2FWNFtiI7?=
 =?us-ascii?Q?eY/hkgZmr0KcR7FRaaTFxxE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85e8800-04f1-4775-ee9d-08d9f5010129
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:11:31.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ng8lnJ0sLL1KNqzIKv/h994Rhb4ZzsipsoBkBaC5cgreMq4d4jvqC0/35vDR9RZFSW3pKGK3Z4fM17n12D1C5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6064
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

