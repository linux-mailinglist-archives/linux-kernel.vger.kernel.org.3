Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940DF4E4EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiCWJI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbiCWJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:07:57 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7441275215;
        Wed, 23 Mar 2022 02:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQhesWiQCFGvhk7cv6H9MNE6fvqqsbdHqK/PozS5AKdYfgdBg0y7N2mBV8VBrt4TdaLACRDsyxpBE2L0PUpK5LwnAMFcVjdPCd4HlVnP94plJFrv6+GCuZdYgKy5tNXKRHF/EeONIBx57o375c7fBO6rB/lTXg76BES7ypigMVRfv0WnMCQoFha6ZqQVB+3Sx44lOmQeONqlvlf34oTQr1lM6r4ZqkifCBriZxvChNnOigMcxf7pQzxtwcuPSQQyHCLxUUoZ3ZKU8fbl0gb8KQRzYxTescuL7AJ24NCghXApFx4BLzxjX7DFlrvAhjqmJFq3eldk5qGfpZq86R9slg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxbkxqO1O3BFIRbYDJPwW5bmJEorFPJX8Y9qkO5XWMQ=;
 b=hCPKmT8DuULRDCLtqwV6o6yJz66p+lT2BB4z1JCuYmIIraAT230NMaQG9pg6m8Cv+XOg/CLnwfRk4hUkQij45JTXejJ3DN5I2yjBT1rK+y3pjv1uNfDF8HnSDJ6wHKsEVIJYzo58IIc4M38E3775ovWY75DS6svDNSnUVtGbbJ5a6k3PlyqJNCvbT9Ez89fpjZQzOz9KiQAUMIW40vt7/NxXzrPbtw9ya49EXE4KEiQnEYgoCl/KtMKlj1tXWw5UN9Rrg8/LdAs/6rudbx9dYWuF/yaPY19A36n2O9MGKZZT+5TXyH3zyw9thnyX+oElUSovaSuo46r1Zukqsd2sNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxbkxqO1O3BFIRbYDJPwW5bmJEorFPJX8Y9qkO5XWMQ=;
 b=SlnicDMGkoFa+Jc5eOmzU5APuaXdIy3JBc2OCDPVFT8+KOnbR3uLPdemyRQWGaWgfTtRvUzRWy70b8KogQB3ORje/NFi2oDPYL0H/0rQt1bRA17a5czs+5YfclBRC1u8pcrpJgn+41ASJX5aFt4SHOhJ0oaiNc1oO0Lq3FMQtlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:06:26 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 09:06:26 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/5] media: imx-jpeg: Propagate the output frame size to the capture side
Date:   Wed, 23 Mar 2022 17:05:56 +0800
Message-Id: <473edd5666b24a659f651ca003add12ac9a0c2d2.1648023273.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1648023273.git.ming.qian@nxp.com>
References: <cover.1648023273.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:3:1::24) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fea22ca5-aa25-4975-8106-08da0cac68d6
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4901ED200C568F2AD87D0576E7189@AM6PR04MB4901.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htxEOoc4VFHSeJUDQZe9ry+LIQ30O+kdYq4oCihljX7zuX/1+SmieOtjq3BTs+s09T+gAETShyuJOT0vuAi20Il89nklKDXOEthssyGloqOMEwO3yRFWlolY6hueRcJTaIl/skQo+4k9Zu8HuAZ2d1/+WQOhse0hN3ct4UBT/Xu0DiKrbZlpCAeuLKVSVALLpee70xTHNNezKgoO8J4qmxth/7nkIsiHHz+HJyu1lh+x0FhZy2+z5eLM1EhgCHYerwJgOd5u4zVdLsKFjHmcjeFXxhkMn6MqIbfXuJBiLRkscZKFs+4653TGw/r7R9mk4qKFnhEiGJoHHN5gBTxZwqZIcEX7IRZFEFTIcq7JMIvmpMHE55MDQ843QFBFNOolVNmqNpYJxAAL+n1yNWn/bZxDlNQP8mWKWqBZFJRd249XiX+NGcik179i3ned4ly9KnKSDpcNuonquoeYAjhOtUiXLcIut4+zH2O7xSY5peC3IeOVG0BqQXeQ2/m31O1RxTzj4Eft/DteskidBRQh5j+0UagSK4OQzP5jQT+E+v2wQrl4JODULO2LP3ihKoNqEoz5gZ7kM2w8wzWFVbuMXm7E9D4QIb/Ia+Ebmh75w+zNsJjj+DKMHO2sZk2kjTl5aG/aoRQ6hh3YIcDr1xAER4KcHUT6d//cNEkl2djaFZwKNhAryp/LNffIIFDzzbK2BJ3MIyGOmvEYBkL/ssQmpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2906002)(38100700002)(38350700002)(316002)(8676002)(4326008)(66946007)(66556008)(66476007)(6486002)(6506007)(86362001)(508600001)(8936002)(83380400001)(7416002)(52116002)(6666004)(44832011)(5660300002)(26005)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aI8nEhFAfQ/W1YZ0g5EbG+KI7WoliO4cT6nHRF6dgod0KmidmDVxSkk8jefx?=
 =?us-ascii?Q?42gCzS9bAlh8yKs/JoW2IPtwNT1qNkgAx5+5QwXQzjvt4P9Q9G0s3R02MZdJ?=
 =?us-ascii?Q?4p1e849aIHCHx13WiAV7DEemxXk7/K/0Bf7LHTpZYWYSyBHQ4BZjHVatDyeU?=
 =?us-ascii?Q?ZnghubQe7GLZHWL1E7ocPoGidD/k9f4VATqpAxncLESGZQ51ssfolu3M3NYV?=
 =?us-ascii?Q?IWpU1bABDbFceHsJgSXJ/4ttWg1IEphn/NA5rgyu8olEz1Djc0bXQY+XkeTs?=
 =?us-ascii?Q?OMudX5+2oH59ao5cHXJa/AijzsLBKGHjtXuBZk2agnCKsX8JPS2NVMCHwlLk?=
 =?us-ascii?Q?PhSIO2csjaamRLz24Bzd2xkZExYY592ELiQzXLLSqNbDsM20hJX9ZQ3U84qs?=
 =?us-ascii?Q?T/y9ooR6cZmcyP4AMS8cg4vu6cbulQ3FZTj9XdawNBqZomrmNqqQBtN15YoF?=
 =?us-ascii?Q?ivznBseVMFLLaEPHGHydGqRmzZLUbHEcHldSATZYo7MmwF/WhgOT8/7lsYnx?=
 =?us-ascii?Q?N8u4eGOvP965M7Hdw7joLljB5H0rLUv20heGPSHsOSBam7WvVbQwAP+k3OKs?=
 =?us-ascii?Q?dmpv+bHqDB9LTFGWJl5A92uuRU2iFXDxWvPTBHZRtSThHQrEfbTzSpnhNHSg?=
 =?us-ascii?Q?rVYvOjo/nhsutBLCFyP3Ksvcc8pGoTOvdr2eDu+RVxwS5lYlcBvMmxRgO66F?=
 =?us-ascii?Q?CQfEd1Wn1w7GEiBkdQt0X26xjEADhK6QNKtALPDITs+L9hA/ZvtPCFK8hKEo?=
 =?us-ascii?Q?6VpC+jZ06hPJUtoPve1VzOgvSDbHkh9FhQchlDwU58KN9DV79pCn7z7w5f5G?=
 =?us-ascii?Q?tgxuq2tup/dZuIl4yHwA/sC51EhrA+j5G2AuQCO9zoneOT+MVf2vuiQ1a5rv?=
 =?us-ascii?Q?/Gk9nI4oosiFfi+vU0gHQEIw3WfkwG+9K5zCYTeTgH/GR1Idvm4HWxKVMCDp?=
 =?us-ascii?Q?C6wY2ODAdkk6ywh17TMINgQ82xJytfQI23jgnyPewba1VOwfVy2Zqqsn0kbH?=
 =?us-ascii?Q?JiOjans49pMe6Ru1MJXNhoJDoEtX5mx0iEcctt2BfN9F2t/C7G3qTj0/zfrG?=
 =?us-ascii?Q?J3TjPRUsDyWSYmSk5OlyPiDp/6U913W2P63R7T9CGLCAFbErSWI4XJDRufle?=
 =?us-ascii?Q?tzHB4RhPlDZL9cbHCV4KQjwiDRtr7Wc9KXYUkPu3hOrTAoJSi/LwuIRtxcXL?=
 =?us-ascii?Q?qOW3TlYiuf6IJXZj98XgyLs9LT68A8Zf84Fr1jfXAiLfzx+Iz09NFgN/U965?=
 =?us-ascii?Q?4T1LZv6O2qdTldO0J4beNwjYNexJypjEwvdbSyIU6b7xskrv+IQ16uI9vipR?=
 =?us-ascii?Q?D5cW99Q+e7ube3MY7K2eGhJ6DumJUQ1VhzGRI2HS11fLXczocsbTikjuqioL?=
 =?us-ascii?Q?15RGwSVOEdY0iU3+FReMPPaCxw60/WVv1Pn7Zxa6Y29IgQZ0THVgmlqt49oi?=
 =?us-ascii?Q?wfwg2rn12/0RtIB2j13cNmQTHOJOynQU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea22ca5-aa25-4975-8106-08da0cac68d6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:06:26.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck0kitYGFm74Vhdl3w1LUzIFzGsRttvNusUI+YlEXYjB+p0TJ3WlH8HTUfpTJ+QuXoA+FwJaxWAlna9PG81d6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GStreamer v4l2videodec only ever calls S_FMT on the output side
and then expects G_FMT on the capture side to return a valid format.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index a95305639dd9..5dfa6f87871e 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1831,12 +1831,40 @@ static int mxc_jpeg_s_fmt_vid_out(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
 	int ret;
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
+	struct vb2_queue *dst_vq;
+	struct mxc_jpeg_q_data *q_data_cap;
+	enum v4l2_buf_type cap_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	struct v4l2_format fc;
 
 	ret = mxc_jpeg_try_fmt_vid_out(file, priv, f);
 	if (ret)
 		return ret;
 
-	return mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
+	ret = mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
+	if (ret)
+		return ret;
+
+	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE)
+		return 0;
+
+	dst_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, cap_type);
+	if (!dst_vq)
+		return -EINVAL;
+
+	if (vb2_is_busy(dst_vq))
+		return 0;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, cap_type);
+	if (q_data_cap->w == f->fmt.pix_mp.width && q_data_cap->h == f->fmt.pix_mp.height)
+		return 0;
+	memset(&fc, 0, sizeof(fc));
+	fc.type = cap_type;
+	fc.fmt.pix_mp.pixelformat = q_data_cap->fmt->fourcc;
+	fc.fmt.pix_mp.width = f->fmt.pix_mp.width;
+	fc.fmt.pix_mp.height = f->fmt.pix_mp.height;
+
+	return mxc_jpeg_s_fmt_vid_cap(file, priv, &fc);
 }
 
 static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
-- 
2.33.0

