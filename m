Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1C4D5CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347301AbiCKHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347275AbiCKHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:53:43 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626FC95A1F;
        Thu, 10 Mar 2022 23:52:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIxdjQBQAbN3xxV0zfYFqmMvZ/gGSqEYewMOm+z6fpUKKBawa9J/2PYM4p1cTqb4WdcTBqh00xQ8IFM5CHStVMX7a3Vtsjqi6d0hJf1FM5h6m/Y6+UrM6juF8hW3KfrvKWWw718zR87MjS1LvDHFL8p8PfxcO2si9FGOgzF18cShB4gfwCq1UClTbsfiDjZm8oXDtvUW9V5rPqMS7rZa9DimG0lWj51z49NwsJ5Srx7z1WIMu275Pc02RCPDM2iCdTketOlsdaEx2VQDnRHbaX8GkUs1bsuK/IotT4UjeE3AVTHZF+VwoSF+NbBVrzVhpfzdssMs+Gq8DNstRweAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku317mUSHruXe+eqtL9Jhx41SjsYYJOst5rCfUruQV0=;
 b=A1gQ9pXRv1NknBpJxT9iBbJC/41GuWiKJDQUcwzRky+kFTmA6xqa3/dmzI4UwJL5sMIGWDDkIDavjChGWPDlbvOYDoqVJ7yDS3ppUIw5r7oIE0/+zI1OZd6dkIs9qtoW6WXsvroWXOLZGrtowNHkKHdOadvTfpjpFM8H4EqUJ92lO+EfGeQRqG1LiaSh3u2Mc+eYV2SteLFSjgBcNPF7XFcowOtsiZ7PnKgMUaLMOztaWQwCmMumT9bNVWRtdjtOgVi5oNXZ8LW0RwCvJRy6mNEdU9Fjof2+SOL+7i0LDkedxpmNYCqLmjGcKosz8xOZ2eNaoR6xt84uLjLZkqDigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku317mUSHruXe+eqtL9Jhx41SjsYYJOst5rCfUruQV0=;
 b=ZHBwT+U5mdAlC+QCh2c9bXQNQEyd54tJp5TH57uHRVB05Rpcjfz082hviZzcSpImbsG+pHKkXhl2/a41saGE8n7/TZRHWE2ZrH2iA0A0HZFVX1ljIRbZ9UzURK+WYYJsfaOWwKEGnTEx8G2YWSS2e09NEtYUUL8w8aGh45H4644=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB4443.eurprd04.prod.outlook.com (2603:10a6:5:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 07:52:35 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:52:35 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] media: imx-jpeg: Propagate the output frame size to the capture side
Date:   Fri, 11 Mar 2022 15:51:45 +0800
Message-Id: <f5b3eb363a5353d31bbcbc96a8d380866af2dab7.1646983646.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1646983646.git.ming.qian@nxp.com>
References: <cover.1646983646.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2600a90e-3dc0-4fac-a2b7-08da03341af4
X-MS-TrafficTypeDiagnostic: DB7PR04MB4443:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4443277FD319A9F3803D1546E70C9@DB7PR04MB4443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvbHJyob2eZvcyOfJP8CpYjL2PMkQmVjclDec/TNye/LkbMocSLfNnGafv9Exn8jhAfccPYIvqevFW30nYr0xtyNYfl+oW1WRrvX/jPDxvpRlZcI3VG+pLrrwqh9JpESNvEpwJ8u3SbdkdAxQBC1IDrc4heLvm8Asf7lDI37Oiu+WiTsIf1N3pMmpDq7UQH5oxgo1/mY1UDJDC0n6e9pV3Ln4Vu90f8XfoU1wpQrEZbzPn/0MEtcvQEJwn1LV40HaE7r+g9wvQzpn3dlves0kM6raCom/Yi7dkcm91dhGl34pMTfeyWz82EWA7UJ4fpwn1+IOlln1RyE2D2rK5K5/SD5Woka3M2GovpAGg+v5511NehkHp0cLmanYrEJaYvaUJG3B+y1sXZxOAz0t1OWm/ccUHdJ9/yzylSfmo4Q859N1wOIp0a0xpywI3FwR1vfFR5zUxUjA1MpZnPisP6kqaGsdT7/5xF1BNfdv2THODXRFA6IjnQTWOF65D4iL1Z/tVxl/RKTvnDGccj4Jepny3gg5km3daZFOY9P/xRigsoCityGFvBPXDcQYpwEvDtC58aCAU3H/ALq5LF16FUpoMys4PXw4zzq9IZe0syEr0peksI4Ix2HKDM3u0GGSookkaYAtHVH8zc08OGDhdbau9ndfFQaYEXCz/ITnYSvxJni3SHHqQVhRfIp8hG1PAXFn0WVi5ufmCE0ROvANMGF9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(26005)(52116002)(44832011)(2906002)(8676002)(6486002)(2616005)(508600001)(86362001)(4326008)(186003)(66946007)(6512007)(6506007)(5660300002)(66556008)(38350700002)(6666004)(38100700002)(66476007)(316002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tet9QfBlwgEe111tKBeUvGQVe9YiZfOM0/n+ikhGogBnX2skkCk+RTxqpv0d?=
 =?us-ascii?Q?J0albz8WoJ4mANZAVU2MkAwPrTzlfePk6KH8igq2uQdSy+fxvDVM4lWo0N8d?=
 =?us-ascii?Q?FWj62kL42Y5BYqxzHMVxvKoVHB+PBN1DOj+blW1KHTEE6XI6NGR5f/IDV/YQ?=
 =?us-ascii?Q?W6Y7NfDT1XYlKRoCXunMVdEWdsgi7hOqkALFqqX9+ZemqFZMDM3+cDw4FIjN?=
 =?us-ascii?Q?3fJsoHr+NdUI0agzGXEqYTNQXg+G/c+wwRJpUUs1yneGy58taliZm+tdTSb1?=
 =?us-ascii?Q?abkAy61iosQ6YRmXDc0CztKVz7U98WiRs+ZlHZrlGXKir6b7UK/bbiclUDmZ?=
 =?us-ascii?Q?U66xZWQb7fg+xzvjrRMJrBgBORnLg+YiFn3Z5+JUgduiSeVI3NCYOIqsu52i?=
 =?us-ascii?Q?qhN6YdSrVCeqcOlnL9RpJf4g42EESmIinlg5ltUWYrI1Y5uEyPkB8hnFXWY+?=
 =?us-ascii?Q?3OnHLQo2fOu4EuCd6g6gLYsl1V3AD7xj46U+zOhoVUbtjqMjFDH3ciPoqC4p?=
 =?us-ascii?Q?syRZN0Iq2MOa/mHci1RZsMm0R5dXuvokrjvjbt3RsTOk+x11k/DAJBOK1R3f?=
 =?us-ascii?Q?5hAys8cne1MInEN+vdAzRCO6QpA3S6EBZVdB7hj82ediWj9lRkHI9IOf6dcN?=
 =?us-ascii?Q?JCgUmvhvLv9H0ZxDTssLmGl9FkxdDxE0Am84h997Q/VoUOH2PUwpSIeuUKLs?=
 =?us-ascii?Q?LN2sA6Eqb1zpC6afHLuGcPQty4BkycRQyXzDYj0r4mbhKDjmW8T532OX9IUl?=
 =?us-ascii?Q?2Tgcg14FyVQepM4hyBMZGCpoEy35ng+qNkTEDa/Eq42MDEMYUJhV/2mjz3mT?=
 =?us-ascii?Q?lYDYgjjwVuqNLvxLPU8uSvgRzO2/ZFO8VoF4FbdevCAXO4eyMlvr+9j4tXyK?=
 =?us-ascii?Q?6pFy2isPwn2YL27jyfmrUy6j1mvUPvmPhp5Zx1uU/jhoBdLRzlJ5+QUxe3bo?=
 =?us-ascii?Q?nwA0Q1nbt4NUdBT0qs8IuMmumu06cDmXO1W2KlVGn7LJUHRWv5DmbBWHCWn9?=
 =?us-ascii?Q?MmOgC2z5HHN3TWExgCRhARGQCzpylNx4MXwTDG1rYBt6qzRQyfFZJ2dalJXX?=
 =?us-ascii?Q?sCSAVl49WSIIgu5FIp/9kNPTmtrsdpNoCJuWnv8dm/H6xB6SdWKTVSBwlsgS?=
 =?us-ascii?Q?ea3ngWZ/TjFiXiInz/K5oZnndMlbJqawb7Qj+2fyzkQ8N8u/XCbVY4G9XNtM?=
 =?us-ascii?Q?sjo7XFEwcRDs9cXkq2ycjOYO7EffVs2s7vaYWtMaybWL6IobKPJhBi9Dwayw?=
 =?us-ascii?Q?OpL3DCPNBGfNqsour62TxmCWSzxwj/PKFugxTKV41veFZ39sBXu/U7v9SlkS?=
 =?us-ascii?Q?bO4jhmp67d1R0ibpKrkGQbt02i58HlGJ15TmA6gkCPOvhkKfn7YOt8/3BhCZ?=
 =?us-ascii?Q?jdrCXa8XPqY8+qn4fZ6h9ieR/l2AyFdxLklY8L7H8mc1rGYOAz3VQaraN/xV?=
 =?us-ascii?Q?kLl3osjqwhN4lYdrgpyJh53hp1Qk8PKz4OQyIGASeooA4wcs2WYWte5YP72Q?=
 =?us-ascii?Q?pRtX2TZR65NMG6QDbvaxolzgM/Un8kqmsgvkOzetwsfd5ngPNe9Bt1lNLrWk?=
 =?us-ascii?Q?fqq23uLtVwiMx+u94O2DHYeBnIBfULQNfMECDdtSMDk2kETbgtbcfNuYzj2Z?=
 =?us-ascii?Q?0VLXB/lM7gCj2WK40CmzGYI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2600a90e-3dc0-4fac-a2b7-08da03341af4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:52:35.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSbYlqDjIRxRI6Atgzm1+CvTu6qPT4vLY4Gs2+q96KIVcHoBmEk5ylAVyPiAczWwKo+zdaU4THv4RSrBeCgoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4443
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
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 25 +++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 82b9b4630d9c..9e8a4157ce2f 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -1831,12 +1831,35 @@ static int mxc_jpeg_s_fmt_vid_out(struct file *file, void *priv,
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
+	dst_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, cap_type);
+	if (!dst_vq)
+		return -EINVAL;
+
+	if (vb2_is_busy(dst_vq))
+		return 0;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, cap_type);
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

