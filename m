Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD54047EABD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 04:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351085AbhLXDDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 22:03:18 -0500
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:25326
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351076AbhLXDDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:03:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1EVy3QwHE0g3W6yAAEHfgR1KTI7jQtrZYHO4DWL5H2z1SykP9ZMdhufnlIZv05ZtHlHpsiav4rPpVP5Go5lY6czNYSp98kbL+T2DwO/kRiI/muxskeIIImq8YBsMKzliVX3WB/YTR1RbU1+b7oh05vo82/sXC51WGsJDbjpcpW8geUWIa2M0biVUA10XZLsx6afKNbpe0ePwPlaydf3ceObXvGb3R5h3eUmVNFY1Kch5+fMTbv4xILJiwktpsemLaG3giOegzIh9UgM8XBsxlFupG98BDAAbZWvlgH2Ym2Bdg4kY0HIPk9RPBqJYaqq4WSziRrYxcTQnhoC2Nqu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XivBjGzXt4JdBM8TWOFYepActdojMCZqmTiaYNXY5bw=;
 b=l/nhELycH8TWWQjRv8YnEPsqDghA7HEWg9nwASs9bl8kRdcwdSepbojA09S2LlfU5gahKr4qjjDD2IqOkApVGJG/XmUjQRU9fH9QLYzwsFB0okrYQtA3MY12tDd62Yvx1hpI+ba8QzqpeptFKSpv1CJK74PMpxZJzk7YsrSjneJDtMBXHdmrjeEMRZSI5BjeZ9HwRydMObwGHIm6O5revCmH3+40IJEKWTA9Nd8s1n65an3MEodZYM9ryaMlMhs+EyPHwDihtTgqXBtbSQN8ZQNHCx5RnGujP8w5qIlaKM17ECYl2S0oSaVKgbTn73B0wYXmx9LcEoe+hUktHqZDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XivBjGzXt4JdBM8TWOFYepActdojMCZqmTiaYNXY5bw=;
 b=Ya/cpu6smEtQJJ0YJxMLSzlkzmV1EU5Wq1w0s9iDIY0CE8KupWB/BdokYMu6CIWcKHahT7vs9wjbMS+3lY2J2X1DePNb0x6qrIscOVdwLaXP9KSU9lenSSMe9PALhoMky2lgbKVU3LzCH1aCaM4bFplK7A1ViHhMjmShA/niM6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB3266.eurprd04.prod.outlook.com (2603:10a6:206:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Fri, 24 Dec
 2021 03:03:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::b9f1:7371:3484:95b2]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::b9f1:7371:3484:95b2%4]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 03:03:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] media: imx-jpeg: use NV12M to represent non contiguous NV12
Date:   Fri, 24 Dec 2021 11:02:41 +0800
Message-Id: <20211224030241.4624-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b347ee6-43fa-4a8e-9bf5-08d9c689ed82
X-MS-TrafficTypeDiagnostic: AM5PR04MB3266:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB32664BEA26E20A08FFDDCA7EE77F9@AM5PR04MB3266.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsA2FZm0FsNh+PkTV3FzeSW5Su7cbFhuwxIV77t94xHq8l1K8BR+nkL8ULW8rxjufSYrdnlH8uWiH2tJq1ZbTBo9oRcdHydh62LA7JI8l9iwlMcpejFsXjvdJfz/C6uE91CGz165mpPFPi8AnF+7CiAoAN9i4V47b31J7TyJRz3weQ18Ii4zrcL1oN41qoJgM0QzTMWB9Cie0WBK6k2INVe1VCLiF5kwaT/IDTRpTGhP/SCyvD0S8ZAxZ1ogQVg/tREaoUgFjeehqmU052uFhkmIERRJtDuFInsk4d77hJLjBY801RULOtrCICHqnf/ETsnt4KS6Mt0UmMrSpfaH5OW79L5tf/LxD+Z0jhA5UCs7+3Cpasn1MHkXZ4BghLq4iDJHJWVAMzQUKPgm/QbbcNK3G+rpDvWGWcbg9GndQg3l7QTgtCdDhROhNlO/nRnQul9Ai6mqnIzE/mgHYHuamCBOX4fuIkkGR4GSjpsRg64IIFTUt/gEvo1AFoQpYjG0eiTAQVAT0+UrEyLLa2C+Pf1oNSDZh815lstfvVQSnFnTJhzxpy6BCohpv9xuI92bfE8Zyc8iXyKtouRMjOxTWSumK0JFVWb+DrjbVJsYFR8XUYa8GEaZT22nH1Tq6JtBNL33lTFbgf3qDeLIfIeweXfz15g+MF7q0t1Q7ZzHLbEjwPqyqTllALQ5BptCu4IXduJX4O0VcVjzBjd/0npU9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(86362001)(44832011)(6512007)(83380400001)(36756003)(2616005)(316002)(52116002)(1076003)(66556008)(8676002)(4326008)(6666004)(38100700002)(5660300002)(2906002)(66946007)(7416002)(6506007)(8936002)(186003)(26005)(38350700002)(508600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IwkKJdq9Ku5DEvI2pzsgWuf3hYD/E6QVMNzjXNQgtmByNUlcBkef5TuS7BwL?=
 =?us-ascii?Q?9+/tT6N5MVQobSzB7ENoWtW0dK2drKul89y+GFiNBgmcHLPPLlICIZj7JD/B?=
 =?us-ascii?Q?I9c26r706VpILRoxpNQsBVRNi1iRXiLB6m0Wwnj1JdQ50bCydZM1/gI1ux4U?=
 =?us-ascii?Q?FQYzUyGinlod36O8fTNxHGpGNVCM24ZJQVH7qVPFXdy/BLry5WWx2qd+XwB3?=
 =?us-ascii?Q?c5j4cDChFb2ns/DobYRInb1zLAuQXaEkBpm5KXzWF3T+JnMo3AN22glYTfvs?=
 =?us-ascii?Q?JbcL3N/tB+GJH3wer1JiYQbZRavRB4MdQnBFTULnEwefKo/+uIy0rUpBHpwH?=
 =?us-ascii?Q?8geK0UIEhX3PC773XKtYBAq2hIMwr38QSpj2O6kzB+MzI/ehuzfQahlmbdvb?=
 =?us-ascii?Q?EiZviI+nim4rw+c0ahZEUBle6OlTpw/VFqEJw7Z3IDjn4PhwmMRwT8mJILKn?=
 =?us-ascii?Q?SeAHtqVq2nRy4BXsNAKpv7Rqu/E4QmgRDCUFHJPycnJ9u/NpynaerIRI0hrD?=
 =?us-ascii?Q?zzmAZpLo4edmYoDkIjMdp7aGXJlGpcrglRSGXMiSLQLbGABpdiYkqE2YQUCX?=
 =?us-ascii?Q?u9gDHQ46n7+LBXppvXwUxsXhYHPmV8a2Swf+U2gZzkQEmBiRGMToNbT6Tgpf?=
 =?us-ascii?Q?hhZqjhQn4+xxgBbpxf5J2X/yZgCFlEwVHE1hlfRNyJMBPuyf2vvWhanvv3Pi?=
 =?us-ascii?Q?gQV44JWt6O85mXpxB+DgtGdGFTZQBxyG5ydJUYcnMLcs7+6ISxLXvmltaM8S?=
 =?us-ascii?Q?KVVFVNikFDEfZug+hQueJ09YaX6FxG0lIPg4MhIhODEmZlfg0ZIkMG08p5KR?=
 =?us-ascii?Q?69VsMkraogsvTodE/mE4mxR1Jeg0H+pTCr6M8V4URLck8Glo6ROeoF41Vc+M?=
 =?us-ascii?Q?8rvi++uD8Whwg84sQ3qliUzf/DDWg4gYSb5mTndRZHdFL4orevfkusK91FxP?=
 =?us-ascii?Q?JtsiJjeRSlJP4OWFDxggRjIt9KslXs3Ok7JYGUfkDrypSLRf39VBDJjmjcOr?=
 =?us-ascii?Q?zecEeT1tDLFOeHCCbDQUk9CKqOjIWZDGLl0u/retKqgAz1uat9wbW+c6mjeX?=
 =?us-ascii?Q?2gxZoC1gWX3W2rUaV/rlZxSP/mD+Ec5UffQs44SQ+pvfbxkWPeA39Bbkh+3f?=
 =?us-ascii?Q?uQV/+c6TaH9oF65h2absXslcApEws9I4u74p3p2C0A6RSltjakXRkr1PiM21?=
 =?us-ascii?Q?NgAj0eR7phDPNJGlhk56qWv6zaN1enFsIOyRBt/Bd62T96iOPdMfJ3g3Y8ui?=
 =?us-ascii?Q?f7EqDdw4mUQGUoafINmaIAPuJlt/0JXlVKqrV2w0+L0icMLjxydr+qNIOpOL?=
 =?us-ascii?Q?bWWh4OIm0G75Xo9eB5ZmSN096WMaWErfqeRatiNZnCN0KDR6pkF1D20TBj8v?=
 =?us-ascii?Q?h6/1h1xCPpQqvDF1XBq/n72xTiDsAvEkrd4Ql32pWotfMNsFhh25j0I+j7cs?=
 =?us-ascii?Q?nick1Z2NQR20fq8/cmdLuA1UKsHaWSG/gevusrw0O+XDDbuOFKejxqd99Sko?=
 =?us-ascii?Q?HXOurh7VNPGMgxbbHneX7iyN8tSY/svkB0CfxuvxUp1TeUthe412JuGH2s+z?=
 =?us-ascii?Q?mEDCJsRaXwPJh54cO0yaP1r8QzHPiTYXZSVsLZY26vca0GN5ZMw9KDnPYxhp?=
 =?us-ascii?Q?Wc77ZBvVb22b6W3JpVlB9z8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b347ee6-43fa-4a8e-9bf5-08d9c689ed82
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 03:03:14.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK6sQXItDK0Xm+3d/+eGN+bJ6S243p16zvJlCPVA88/KXR+rA2060ZIVv3+5yxTtzQe9lVxN3U1xbW1CYGMABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3266
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4L2_PIX_FMT_NV12 requires num_planes equals to 1,
V4L2_PIX_FMT_NV12M requires num_planes equals to 2.
and mxc-jpeg supports 2 planes for nv12,
so we should use 4L2_PIX_FMT_NV12M instead of V4L2_PIX_FMT_NV12,
otherwise it will confuses gstreamer and prevent encoding and decoding.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Reviewed-by: Mirela Rabulea <mirela.rabulea@oss.nxp.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 4ca96cf9def7..7c0366f5f801 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -96,7 +96,7 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 	},
 	{
 		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
-		.fourcc		= V4L2_PIX_FMT_NV12,
+		.fourcc		= V4L2_PIX_FMT_NV12M,
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
 		.nc		= 3,
 		.depth		= 12, /* 6 bytes (4Y + UV) for 4 pixels */
@@ -404,7 +404,7 @@ static enum mxc_jpeg_image_format mxc_jpeg_fourcc_to_imgfmt(u32 fourcc)
 		return MXC_JPEG_GRAY;
 	case V4L2_PIX_FMT_YUYV:
 		return MXC_JPEG_YUV422;
-	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV12M:
 		return MXC_JPEG_YUV420;
 	case V4L2_PIX_FMT_YUV24:
 		return MXC_JPEG_YUV444;
@@ -673,7 +673,7 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
 	_bswap16(&sof->width);
 
 	switch (fourcc) {
-	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV12M:
 		sof->components_no = 3;
 		sof->comp[0].v = 0x2;
 		sof->comp[0].h = 0x2;
@@ -709,7 +709,7 @@ static int mxc_jpeg_fixup_sos(struct mxc_jpeg_sos *sos,
 	u8 *sof_u8 = (u8 *)sos;
 
 	switch (fourcc) {
-	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV12M:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_YUYV:
@@ -1183,7 +1183,7 @@ static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q,
 		/* bytesperline unused for compressed formats */
 		q->bytesperline[0] = 0;
 		q->bytesperline[1] = 0;
-	} else if (q->fmt->fourcc == V4L2_PIX_FMT_NV12) {
+	} else if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M) {
 		/* When the image format is planar the bytesperline value
 		 * applies to the first plane and is divided by the same factor
 		 * as the width field for the other planes
@@ -1215,7 +1215,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
 	} else {
 		q->sizeimage[0] = q->bytesperline[0] * q->h;
 		q->sizeimage[1] = 0;
-		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12)
+		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M)
 			q->sizeimage[1] = q->sizeimage[0] / 2;
 	}
 }

base-commit: 68b9bcc8a534cd11fe55f8bc82f948aae7d81b3c
-- 
2.33.0

