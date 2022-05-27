Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759BA535ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348685AbiE0H5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348631AbiE0H4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:56:44 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E13286CC;
        Fri, 27 May 2022 00:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SksrJB5PROUZNNaUJXZeiGIobgT1GU61/MxKojYQwxTPQn2drAX6pn12hEzFA9/tHM8M110Lo7Q647IWnm8701TiamDGEs8DjxdJ19mOdMu0flvcVKymF6XZgt5wPENRGDcqva3g3QCT9ZzlY59tAxZnkrAnq5S8FBCJciV2H6CE47h5eMrDeDpgEnLhFojhRPBgX709CX20vcvBzNd9GDsPLtPzN9U0no6T7Sp7Ptr+EfW+/jWunlk4G1OOZGKXXGH0J5daRpazCExPD0mI09JI9huppEFJzIcXe/Eige13XUy1K1l0qg4N25ZsdRLxaWCpN0/YcpnsRJ5Y/BbJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQeBloCpJOl0eK33OGGKc46Vz8dIC1EjwKaUywJZCkk=;
 b=oIV1+7y97c9TG8v+JrGE86BdjFIsO5Lk9ul700yiFfTR1qHNx96Q9p9/wVz5gdx6vJyNkV7srs5tbtrx8DSUZShY0UBP6+UKyuXI3TYT5mECKKPXbM6GPD2CXarsq5T2Olmr8TClmEWcA/H1lyaL5ggbkZvIVxo+U8r/MdfXHn6NVv6YgCBL4j8CxhwRrMhMPO3LTVktk48wM00WA1u6cqL6nNo4/sNO0z27rG7SOqDQK6mnbbv/lIyv9ft8ZzMPlYw/1UfSkrA1BE6O5CEktsdZo11UlSNAqxhtidMgYQfSIOV/xwQxBWpVWSMCEJljV4Mk3/aB1+LxnMF51DxxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQeBloCpJOl0eK33OGGKc46Vz8dIC1EjwKaUywJZCkk=;
 b=IBpJ2E97YgzmeKdbcv3KQcTiM8qEIVNh5YTIk5F1CyKlylEJn87xtgtFUnUJYI2Mnt9/ufSAzdvA7hh5GIGqNBZgIvR7PIx/Q9bqemVzYGc5177XUOBMlMygnsQjud33Ha0C2sjWCKmcvEvhqnaqSdLwE9lZuo34SA+KXpkIkLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4590.eurprd04.prod.outlook.com (2603:10a6:803:6d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 07:56:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 07:56:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Implement drain using v4l2-mem2mem helpers
Date:   Fri, 27 May 2022 15:54:37 +0800
Message-Id: <20220527075437.16882-5-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527075437.16882-1-ming.qian@nxp.com>
References: <20220527075437.16882-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b1d5780-1a97-4e1f-680a-08da3fb66542
X-MS-TrafficTypeDiagnostic: VI1PR04MB4590:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4590AB8AD34AECF61AE0BCC7E7D89@VI1PR04MB4590.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQpzC+EC7ClZf0e9wZoqQpd6Ci31M7iiymh81d6NDXChmfwSkaljCpbxhh+ZLg0k9IOLt+pS4ORHXqXjhpiISQnPzVE6RhIy+pKAn7s8OAYBvRc/vanlCE2L+7f8JDA6ukMqLH8V+xYnDGZ/P0rveLJ3meY7/zOrDsZTW547gjxpCgGqD5NoSG8hLJ1K7Rm9XDP49IXdp6b/eOwkTJY0otzi67P7mCeDhyUUpoU1IA/ukYD92ZRHRexNkTac75xxQLzRWFN8n/ttM9tPduqti9XoKQxVOtS9vIKa5ifDmFMXTrqHp/6syKmIUHPEW6tN4DKKxUK8EblOahKJcqzOelUuWGI+5lvJxmBn8qih6lYUVNtV0hFCDXZQjaYjsOV9TCu6jZHv5XALhG8keo6R5kYtIiMG/lOmV2+XTt1vdnKjuZarRh4Uj1ZZ/kpKCQQXrzY+1kUTWM2wqPeX5mnbGJS6FmjN5BsBxrX7YXqEIQsYjIvrOGE0p5t+qsECpZbhPGplaXzQsb51OVx1AC6UwRGrVRfqI5O2bsN+DUqMAyRfLbIUIz9REK+MkTsqhdvXn0sTEij1GUOrf64p0+NWtQS5L52x4WGXSn6XLP2CfJD3dIcb+IjTIOb0tsZonwVEuh3bm7rRGgk5XUAHB/2aMEWJf36sl1Bp2fZCO6vh1O61XG2OaOHjxpc3i+icQnbUMiZ8zr0vkhIQuLAnIOCoSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(4326008)(8676002)(38350700002)(66476007)(66556008)(2906002)(38100700002)(316002)(36756003)(6666004)(52116002)(6506007)(83380400001)(44832011)(2616005)(6512007)(186003)(1076003)(26005)(508600001)(6486002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a7CY+upb0ZGoEmx2f3bdXjA6Wk6iH7sMJ/J0LciC1my4S1AzLyWLLalhOWpQ?=
 =?us-ascii?Q?hCr4cLo6MeCzo5UmBY3VH47DMamzMapP4gGNM6KjEx9KpKu8c/X++yia6Xio?=
 =?us-ascii?Q?giHXOBJsBhumutWKwMZxZdY5fsuplavd1Bq1hCA0w0+oLTGYSaJL7CoRSFtf?=
 =?us-ascii?Q?TOWpcHHSnKDX+O/BaZJdRjisa5Ul9MoDLYW60/aB5licCqEHWLQ1jgray97w?=
 =?us-ascii?Q?EkwcyBX5wL7sI9Q2wwXWrLI0z4yefslseueQ7jXewuRNQgVXpuCqX21hjQff?=
 =?us-ascii?Q?F/iiWCvAeKaHEfmOkJG4WijLPM6iL1CRniitD450Z3fnSX6at0qZD4WFAN8I?=
 =?us-ascii?Q?varw2YPuNQD4o0HuDEVhxmnPgnZVsKN8UyDHYKO1FPFElO7uo8KEQHLVbt1b?=
 =?us-ascii?Q?WoXYcVoQAxZVVNWZ51IxP1Ll1PvFw1FXP2JgmahycIBZrpqb6DVY1KrHADI5?=
 =?us-ascii?Q?hQJGnusApZABx2bgKc4KTKQ6Ft/LeIfWzUCPiITKe8f6yy6Jf+NEYkoJZ8dU?=
 =?us-ascii?Q?5Goi8qijNkY4a7DVuT5gqrHfMUGRHqR93WIc37KDzanTxMh8CMKJXelM6xrf?=
 =?us-ascii?Q?P1qdC+4dgB+aalw4yCXaNH5dNGkTMa5WoChR1KEYtV6oeXmzz5OPquMGJ2fl?=
 =?us-ascii?Q?ZDH111ytTPXo8Pp6cv05kGA4hDX1y1IZ2bCne/F91tXEe4lid4KR0TRlKx09?=
 =?us-ascii?Q?Og9T+U075XtWLAVmhCYSdpaWgb2c53MFlElc406ltfb23TBvtz6uAA+ulAcA?=
 =?us-ascii?Q?vUq3IgeWeEEdPlaR5+N9rslaYWn8XV8e4mAI3zKIifGsVC/V8KMGwePqqDLc?=
 =?us-ascii?Q?NKcyWuXcfBsgPyEz9Qd/EiQZVF8KHS24FmUhsT4GXsDkVU22ML2TCoZKTH9q?=
 =?us-ascii?Q?P9P7YngAuMgjl06QXrvXqdRJF5YfGhxBgfygYLkThDxzq4xUY/0IEK6yegoK?=
 =?us-ascii?Q?qrLlwqBgJYt5kC3XZ0wSV3e7lwudISWRi3ma+LAqh/Idies81bWNUIRHgoRA?=
 =?us-ascii?Q?elCyUII2JApTMA7JNuuMQq7H0jjLxamVdl3vH7QaY+5XYyWd5JVQdvUn3Efa?=
 =?us-ascii?Q?II5FZ3zDDvHeJA5iDRPfBWqgBdSCm2y4Lklh378YFYmLJpde4SNEaN1s1Uu1?=
 =?us-ascii?Q?8BSTN1PaxK+otKA0EkyTg9B3HNIhuGFn19k2bng/5SdRXBF8w3bSuK0LeUYE?=
 =?us-ascii?Q?/FQeXMf8OKSYMzWcs8/50DPa0U1NTNZSFo2XMK8qNf7J9BIuWpxt/W7SJuh9?=
 =?us-ascii?Q?fp9aW+b8jxVtoNf0DhpJm8IxRR/7f5WR/D5ouxLwRrK3ik/HoI8gbCNqefaO?=
 =?us-ascii?Q?IvgexwxJZ1l3LpsC4DtCKOSiiIdJtYFs5bmuHwXfbdnRYsqWiR6Xvg0TfpT9?=
 =?us-ascii?Q?NtxnkjJnvh9HTecs4wPhdP+oAmlRJ/zC5BFacI+Z/9APiHJaEjYkKEM2LUb+?=
 =?us-ascii?Q?lCHr0mgysa+9egOar5jaH8THM5u3FXzhIdNTmk+a4vw5SDMm2MyfJLvX4KUJ?=
 =?us-ascii?Q?hBY5zuwRh1xr+Ruf3iaB0+31g/+fM+947yNBBtctrjhB/S5hOCW8Q4Pnn1Re?=
 =?us-ascii?Q?LBRMk7PQdZWaTTbqn0V+x7lPvTM0QabcdGRPol+MVZ60fI3thv5b+yh8Rfd7?=
 =?us-ascii?Q?xGsv8JgCaWfRFvKr3BMNq2AWSWLoYF3rXFtZEtXHc3NF6xgG8yCz7Mk/+VhC?=
 =?us-ascii?Q?cUK9oJ8afTM7Mf6mp4+lcmKGdbAF7SzG+VqS3JaVwZOb/mDSs1/WfMA+UojK?=
 =?us-ascii?Q?hsaUpL9gPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1d5780-1a97-4e1f-680a-08da3fb66542
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 07:56:24.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP2X2ZGxS+ljWicVnm05xERbGUrjjOX6ohoIWl2X+QCEQaAhdp4j2y3hia/cEVEXvqnbyEMJy7jhvuy82x0kpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2 m2m has supplied some helper function to handle drain,
so the driver can use the helper function directly.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 155 +++++++++---------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   2 -
 2 files changed, 73 insertions(+), 84 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 9719eab7bc83..521560c6ba83 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -558,6 +558,18 @@ static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg,
 	jpeg->slot_data[slot].used = false;
 }
 
+static void mxc_jpeg_check_and_set_last_buffer(struct mxc_jpeg_ctx *ctx,
+					       struct vb2_v4l2_buffer *src_buf,
+					       struct vb2_v4l2_buffer *dst_buf)
+{
+	if (v4l2_m2m_is_last_draining_src_buf(ctx->fh.m2m_ctx, src_buf)) {
+		dst_buf->flags |= V4L2_BUF_FLAG_LAST;
+		v4l2_m2m_mark_stopped(ctx->fh.m2m_ctx);
+		notify_eos(ctx);
+		ctx->header_parsed = false;
+	}
+}
+
 static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 {
 	struct mxc_jpeg_dev *jpeg = priv;
@@ -633,6 +645,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		dev_dbg(dev, "Decoder DHT cfg finished. Start decoding...\n");
 		goto job_unlock;
 	}
+
 	if (jpeg->mode == MXC_JPEG_ENCODE) {
 		payload = readl(reg + MXC_SLOT_OFFSET(slot, SLOT_BUF_PTR));
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, payload);
@@ -661,6 +674,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 
 buffers_done:
 	jpeg->slot_data[slot].used = false; /* unused, but don't free */
+	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
 	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
 	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 	v4l2_m2m_buf_done(src_buf, buf_state);
@@ -1028,6 +1042,7 @@ static void mxc_jpeg_device_run(void *priv)
 		jpeg_src_buf->jpeg_parse_error = true;
 	}
 	if (jpeg_src_buf->jpeg_parse_error) {
+		mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
 		v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
 		v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
@@ -1078,45 +1093,33 @@ static void mxc_jpeg_device_run(void *priv)
 	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
 }
 
-static void mxc_jpeg_set_last_buffer_dequeued(struct mxc_jpeg_ctx *ctx)
-{
-	struct vb2_queue *q;
-
-	ctx->stopped = 1;
-	q = v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
-	if (!list_empty(&q->done_list))
-		return;
-
-	q->last_buffer_dequeued = true;
-	wake_up(&q->done_wq);
-	ctx->stopped = 0;
-	ctx->header_parsed = false;
-}
-
 static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
 				struct v4l2_decoder_cmd *cmd)
 {
 	struct v4l2_fh *fh = file->private_data;
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
-	struct device *dev = ctx->mxc_jpeg->dev;
 	int ret;
 
 	ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, cmd);
 	if (ret < 0)
 		return ret;
 
-	if (cmd->cmd == V4L2_DEC_CMD_STOP) {
-		dev_dbg(dev, "Received V4L2_DEC_CMD_STOP");
-		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
-			/* No more src bufs, notify app EOS */
-			notify_eos(ctx);
-			mxc_jpeg_set_last_buffer_dequeued(ctx);
-		} else {
-			/* will send EOS later*/
-			ctx->stopping = 1;
-		}
+	if (!vb2_is_streaming(v4l2_m2m_get_src_vq(fh->m2m_ctx)))
+		return 0;
+
+	ret = v4l2_m2m_ioctl_decoder_cmd(file, priv, cmd);
+	if (ret < 0)
+		return ret;
+
+	if (cmd->cmd == V4L2_DEC_CMD_STOP &&
+	    v4l2_m2m_has_stopped(fh->m2m_ctx)) {
+		notify_eos(ctx);
+		ctx->header_parsed = false;
 	}
 
+	if (cmd->cmd == V4L2_DEC_CMD_START &&
+	    v4l2_m2m_has_stopped(fh->m2m_ctx))
+		vb2_clear_last_buffer_dequeued(&fh->m2m_ctx->cap_q_ctx.q);
 	return 0;
 }
 
@@ -1125,24 +1128,27 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
 {
 	struct v4l2_fh *fh = file->private_data;
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
-	struct device *dev = ctx->mxc_jpeg->dev;
 	int ret;
 
 	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
 	if (ret < 0)
 		return ret;
 
-	if (cmd->cmd == V4L2_ENC_CMD_STOP) {
-		dev_dbg(dev, "Received V4L2_ENC_CMD_STOP");
-		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
-			/* No more src bufs, notify app EOS */
-			notify_eos(ctx);
-			mxc_jpeg_set_last_buffer_dequeued(ctx);
-		} else {
-			/* will send EOS later*/
-			ctx->stopping = 1;
-		}
-	}
+	if (!vb2_is_streaming(v4l2_m2m_get_src_vq(fh->m2m_ctx)) ||
+	    !vb2_is_streaming(v4l2_m2m_get_dst_vq(fh->m2m_ctx)))
+		return 0;
+
+	ret = v4l2_m2m_ioctl_encoder_cmd(file, fh, cmd);
+	if (ret < 0)
+		return 0;
+
+	if (cmd->cmd == V4L2_ENC_CMD_STOP &&
+	    v4l2_m2m_has_stopped(fh->m2m_ctx))
+		notify_eos(ctx);
+
+	if (cmd->cmd == V4L2_ENC_CMD_START &&
+	    v4l2_m2m_has_stopped(fh->m2m_ctx))
+		vb2_clear_last_buffer_dequeued(&fh->m2m_ctx->cap_q_ctx.q);
 
 	return 0;
 }
@@ -1198,6 +1204,8 @@ static int mxc_jpeg_start_streaming(struct vb2_queue *q, unsigned int count)
 	struct mxc_jpeg_q_data *q_data = mxc_jpeg_get_q_data(ctx, q->type);
 	int ret;
 
+	v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
+
 	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE && V4L2_TYPE_IS_CAPTURE(q->type))
 		ctx->source_change = 0;
 	dev_dbg(ctx->mxc_jpeg->dev, "Start streaming ctx=%p", ctx);
@@ -1229,11 +1237,15 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
 			break;
 		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 	}
-	pm_runtime_put_sync(&ctx->mxc_jpeg->pdev->dev);
-	if (V4L2_TYPE_IS_OUTPUT(q->type)) {
-		ctx->stopping = 0;
-		ctx->stopped = 0;
+
+	v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
+	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
+	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx)) {
+		notify_eos(ctx);
+		ctx->header_parsed = false;
 	}
+
+	pm_runtime_put_sync(&ctx->mxc_jpeg->pdev->dev);
 }
 
 static int mxc_jpeg_valid_comp_id(struct device *dev,
@@ -1432,6 +1444,20 @@ static void mxc_jpeg_buf_queue(struct vb2_buffer *vb)
 	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct mxc_jpeg_src_buf *jpeg_src_buf;
 
+	if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
+	    vb2_is_streaming(vb->vb2_queue) &&
+	    v4l2_m2m_dst_buf_is_last(ctx->fh.m2m_ctx)) {
+		struct mxc_jpeg_q_data *q_data;
+
+		q_data = mxc_jpeg_get_q_data(ctx, vb->vb2_queue->type);
+		vbuf->field = V4L2_FIELD_NONE;
+		vbuf->sequence = q_data->sequence++;
+		v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, vbuf);
+		notify_eos(ctx);
+		ctx->header_parsed = false;
+		return;
+	}
+
 	if (vb->vb2_queue->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
 		goto end;
 
@@ -1480,24 +1506,11 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
 			return -EINVAL;
 		}
 	}
-	return 0;
-}
-
-static void mxc_jpeg_buf_finish(struct vb2_buffer *vb)
-{
-	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
-	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
-	struct vb2_queue *q = vb->vb2_queue;
-
-	if (V4L2_TYPE_IS_OUTPUT(vb->type))
-		return;
-	if (!ctx->stopped)
-		return;
-	if (list_empty(&q->done_list)) {
-		vbuf->flags |= V4L2_BUF_FLAG_LAST;
-		ctx->stopped = 0;
-		ctx->header_parsed = false;
+	if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type)) {
+		vb2_set_plane_payload(vb, 0, 0);
+		vb2_set_plane_payload(vb, 1, 0);
 	}
+	return 0;
 }
 
 static const struct vb2_ops mxc_jpeg_qops = {
@@ -1506,7 +1519,6 @@ static const struct vb2_ops mxc_jpeg_qops = {
 	.wait_finish		= vb2_ops_wait_finish,
 	.buf_out_validate	= mxc_jpeg_buf_out_validate,
 	.buf_prepare		= mxc_jpeg_buf_prepare,
-	.buf_finish             = mxc_jpeg_buf_finish,
 	.start_streaming	= mxc_jpeg_start_streaming,
 	.stop_streaming		= mxc_jpeg_stop_streaming,
 	.buf_queue		= mxc_jpeg_buf_queue,
@@ -2009,27 +2021,6 @@ static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
 	}
 }
 
-static int mxc_jpeg_dqbuf(struct file *file, void *priv,
-			  struct v4l2_buffer *buf)
-{
-	struct v4l2_fh *fh = file->private_data;
-	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
-	struct device *dev = ctx->mxc_jpeg->dev;
-	int num_src_ready = v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx);
-	int ret;
-
-	dev_dbg(dev, "DQBUF type=%d, index=%d", buf->type, buf->index);
-	if (ctx->stopping == 1 && num_src_ready == 0) {
-		/* No more src bufs, notify app EOS */
-		notify_eos(ctx);
-		ctx->stopping = 0;
-		mxc_jpeg_set_last_buffer_dequeued(ctx);
-	}
-
-	ret = v4l2_m2m_dqbuf(file, fh->m2m_ctx, buf);
-	return ret;
-}
-
 static const struct v4l2_ioctl_ops mxc_jpeg_ioctl_ops = {
 	.vidioc_querycap		= mxc_jpeg_querycap,
 	.vidioc_enum_fmt_vid_cap	= mxc_jpeg_enum_fmt_vid_cap,
@@ -2053,7 +2044,7 @@ static const struct v4l2_ioctl_ops mxc_jpeg_ioctl_ops = {
 	.vidioc_encoder_cmd		= mxc_jpeg_encoder_cmd,
 
 	.vidioc_qbuf			= v4l2_m2m_ioctl_qbuf,
-	.vidioc_dqbuf			= mxc_jpeg_dqbuf,
+	.vidioc_dqbuf			= v4l2_m2m_ioctl_dqbuf,
 
 	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
 	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index d439be6e4acf..c508d41a906f 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -92,8 +92,6 @@ struct mxc_jpeg_ctx {
 	struct mxc_jpeg_q_data		cap_q;
 	struct v4l2_fh			fh;
 	enum mxc_jpeg_enc_state		enc_state;
-	unsigned int			stopping;
-	unsigned int			stopped;
 	unsigned int			slot;
 	unsigned int			source_change;
 	bool				header_parsed;
-- 
2.36.1

