Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563C45375FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiE3HwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiE3HuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:50:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE672230;
        Mon, 30 May 2022 00:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNXdWE4gbrH2j5VeblCbIM1jc1BfInYP2NtcqD2RfrheEvPXaUHJs88BxkonADNFp0uORQDvI0CSxiYMpHO/qebwBtjO8ma8oe1OrlyFoGXdsQwtzdl/qg903MTy5Dp4U9f+wwfTzagLqF6GMSGK6w2+UdMIUxQIoV0sJuykDsjgB0S6PGsx51WfLpFIYEv7RDTzbozAeERNMQ28uDl3F/h4lNOEX7i/zdstp8shGGGTDBA/YpRGbsQ7k7ZogeQoEa3SQeN3OtuUCHuG4SBrrgx+Y0ihNDWRM5QHwzAphfezN0mOuzIYWNz3+ncoT39e5tC2YfhRLIAtHjMexkKt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq6bTS2J/2rQR39Mutmqtwel7YgxAHwNJvanAXyBFSw=;
 b=c37Bs8WK9lIJAQR+snFt8XjtJOLoAuyENZXe/YPqcQK38jvMftbwSbFOp1vZCcfPePk4mwDnyx5aBDPSEs7G2Vj8ZdaDxdvgCzs9ZwZt1BfR/BURzpIacFfDanddodQkLMUXUYIVsiefjIAlqTKBF/EiHW3SV8FN0cRFIKPvHMVLpDgTD4izlmslRxzfpIItDrU6W62OszTHIdcKvfyXUhb5G5zczT/bxWr3aftyMylHOh9mK4dGqNnv5cfqvRUNe/wVUaYyxibrkj87by5cW9NFay4ciRYwsGymCZ+yRW5mwvp3CSoqkMg5YDEdIQ1N74v1GC3ok6B539ZpUXGotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq6bTS2J/2rQR39Mutmqtwel7YgxAHwNJvanAXyBFSw=;
 b=oxmyUizXUuYUTKeiMOzk39An8wdCKZmhfcN6B7Z3yuFFK8FN2347OedBWg0C1igjJKLqkR/q05OAeIgy9Sp+QYHIqOqjQeuv6NLL4w3YHr8mee7hcNsuyE2O4DaWROgZneDww3rgVMWGQcz0kvudNeV3mCz993ok7wOtbFIdD/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB6085.eurprd04.prod.outlook.com (2603:10a6:20b:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 07:50:16 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 07:50:16 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: Implement drain using v4l2-mem2mem helpers
Date:   Mon, 30 May 2022 15:50:02 +0800
Message-Id: <20220530075002.15327-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f40bb6ea-221f-4c35-9e94-08da4211096a
X-MS-TrafficTypeDiagnostic: AM6PR04MB6085:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB6085E7345385084A0E57119DE7DD9@AM6PR04MB6085.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roEkhUB86IkDobhb9QjmJOWVw35xTW4QuFDauD4dyg1VSwIuVBhAo7DOEPJexxT8JUbpck4pNI4vde67tRdJFUNocwOlemWZE4OjTXb9VKJW8XN8T14WYqZ6c14bvN5FmCLdSwK0GQt44zAfBt1HxFdr1a+jZRLvUz3tw/H0RpUFPfgmgBtiDnp8/pNiVIfO0ZgN7RU7C4Qn3FVfIhBQY3DfNpOIXjwqMSQD5bhXT4PCIUyuT/fh8irsVBDdXEEaQOsVZ2tnBVzXjPaNbexwRKQBf++6y7tQ7HJAL6P1YpPp4igV9YnGJWEmhrliiKOiwY8gke714xbXlJUdwIH6btgp1BWA/UFP9kqQPR1S5NL4Z64wZUThB9SFQFDLWbECrjUJo0Z9QlMTEtGct+Ym3+B24RHj5oP5Sg4m5X1XSq6fyfoti5otZXFicIeEpNnZgRuBtAfW6b79BrafHA48EDBrqZ9hdNExP9Uty/k1vmOyZf0/7QL2dZY835SjF8wHtUcz5wq0cPO9JJEEvsy2dLMIvzaO4ExkwnolqJWDUDz8ZbLiY/f7hMWZZUxUh+hDFRD/A+yWCcuildurFYcws5Opu+nD3mzfkeMfr5/YO4n+pwaG1bOwy4bHY6JNtKkCPhyWcKG6ihC0pFCruI1fuD+zhSbkVClptXWyjElACBmiPN4vG4dDxpENZ39ZPd3eFxxEjEzAnEHzUAVfjey+2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(6486002)(86362001)(1076003)(26005)(6512007)(8936002)(2616005)(6666004)(83380400001)(2906002)(52116002)(186003)(7416002)(6506007)(44832011)(66556008)(66476007)(4326008)(66946007)(8676002)(38100700002)(36756003)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMsn0D4sNNWnRyqISvaFBXWcf20OqX44DXAugC1VvraDPaxDQnMQqLd/5TZ2?=
 =?us-ascii?Q?+CkSG2rAyiG+Sm106Pn6RHOWTupdX4sRj084l44Kw+myM/U+LEb4qnogKNW9?=
 =?us-ascii?Q?iFbhQDPRGHxZSHVfUecOG9zqPDHtbs0MxCZcHbHvkKt30TwjCP8vaGnoJh4p?=
 =?us-ascii?Q?0d/jJloA2fl5cmi+bt+dLoNBwyzUFwRbqGMArreu8dhPhqDHa4osiPXMgOX+?=
 =?us-ascii?Q?rb4arN6cgSTeRgYFXM/a+jQQ2I0Ea6Tvznl8wsVBSuA+7vLDGmh3pvGL1ewn?=
 =?us-ascii?Q?3wSjglNKZleDcCCu+Ny7qYEVkJtxYIiy0lkOUgWqItGhob2eiI416Njlc0gG?=
 =?us-ascii?Q?5g474uBvXn8Mt2Z73ARGqGOFHyQC+HKt2g0Nfsp+P2U0a1fJzSwk0W8tQ4DW?=
 =?us-ascii?Q?7RXbaRCY+EX8qgpTIdzvwCvosXXFzIzFW0ejAUCzP6bfgaCIjT7x78iGjpNw?=
 =?us-ascii?Q?39ygkNh6sorM4EB0NAgTixkeRwA3SIdfc2rXsWlt6z1QKGfe4AqvlwAgiemR?=
 =?us-ascii?Q?awQLObep+VsBMPtSfeZjQ3ozzb8cHv6/zQOWVdg7p4OoofnX246RpVaqXxbV?=
 =?us-ascii?Q?6QNwLyYS610Tt5dn/fCDLQs6Sq60sHHwmfu3QyIlG+gDDfEnl/4a/7gtVkhh?=
 =?us-ascii?Q?jkjV1DQGc5iYoO1vf7tPcz9B2QZMPvjBUtpkMMo1hV81yIMJboc8OkUXg2G6?=
 =?us-ascii?Q?1/kUtoxQqJKEmPznlnK5WF+P1lBEPCqrBhO4uinogJhX/9SweO4juFsiNmdn?=
 =?us-ascii?Q?dX2J1roGRadmaltxNV2V8i9P+Jksq4mW1roAlPkyPbxH8R7OyFAOPr0hTTMJ?=
 =?us-ascii?Q?TGy+qnYaaMKA2FV0p1jnd8b7waZyTyTjcMr0GPMudqC4uThqDfqDFAWlD6O5?=
 =?us-ascii?Q?YgTXNFWEZiKuAY3WyB7uc1r+gb3FnBk5nou0JfuRi98k3xJheaumxyDeOjwU?=
 =?us-ascii?Q?7GxZYvwpKS+B20twnike5yNTlnDyDI45oq1mG99ztRJKBLC0FwAZbsfHWC6/?=
 =?us-ascii?Q?/Ti9QHzaIvHefellPPrdACGHhaa7NAJhUyrQtHYlaMlfOvT4upNOynQoroel?=
 =?us-ascii?Q?ApGZpIDdlktujLuBhlt9ZNAzoOTBx70RoKKMjkESyngAcVWpR/AMjmijt3hp?=
 =?us-ascii?Q?GnIE5OdUTrL9JNAw9pWUvtWfbSyp43Kmj2zFCILWVUYHLUWVEC4KLbGDWbMl?=
 =?us-ascii?Q?IG2sZzb5yzFd8PLaZj/A5w3MetDou42bp3x84fgdCRvz8sJe/NhnHeI+JXfq?=
 =?us-ascii?Q?l+Oi7ncSTs/CUvw532uej55B4mVZAJZHLhRxP+RlS7u5chSGQhPuEi4CuY91?=
 =?us-ascii?Q?U1anDlyHKaYdarQDFg3eoOlz6Y4C6c4FJdQJimpKQ8Ox4DsN2BMptaU2Fk5x?=
 =?us-ascii?Q?nnG/Ptg9DRqXIs55pOhZD0zCsfAymaYuYAj4r5kmTI4PH6ETqilrnG4KZENP?=
 =?us-ascii?Q?2VanJGr+il+abo5+d25A2gYMJ84O0CEnbcvySSQrubq8SVMveIdksfig7+wF?=
 =?us-ascii?Q?HpV2yu5UprrULIdMpMAuDpzchX8yVTLJSv+77f2it9/CPU2xEpdrcFaqDT8U?=
 =?us-ascii?Q?CfJfNUC5EnFsnptmKelXUjSBB3lD+TsKGtelwG6CWpU2STGegoZbUtZh2wR/?=
 =?us-ascii?Q?j8j4F/jjOd8VPP6aVsApYEc/yd7zEqhDLqEyaQ0l1xP044Bk8aSf8Xfe16BE?=
 =?us-ascii?Q?/NkaVgm+Jg1hMcBTezJpHoRvwWTgcA0KGlvx4kc8VBkrmV3bzAI7/hD0DyP5?=
 =?us-ascii?Q?AI9+lDLhNQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40bb6ea-221f-4c35-9e94-08da4211096a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:50:16.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aic90kwtRGDnoQXRMRYbOihHbZRcnj+ahSHMwmV8b6xyzKep8SfjZB5MRA+ZhhwXpYZ6T+rQ351BmNolUSrzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6085
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

Fixes: d8ebe298d008c ("media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at eos")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
- add Fixes tag
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 155 +++++++++---------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   2 -
 2 files changed, 73 insertions(+), 84 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 9a1c8df522ed..965021d3c7ef 100644
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
@@ -1034,6 +1048,7 @@ static void mxc_jpeg_device_run(void *priv)
 		jpeg_src_buf->jpeg_parse_error = true;
 	}
 	if (jpeg_src_buf->jpeg_parse_error) {
+		mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
 		v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
 		v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
@@ -1084,45 +1099,33 @@ static void mxc_jpeg_device_run(void *priv)
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
 
@@ -1131,24 +1134,27 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
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
@@ -1204,6 +1210,8 @@ static int mxc_jpeg_start_streaming(struct vb2_queue *q, unsigned int count)
 	struct mxc_jpeg_q_data *q_data = mxc_jpeg_get_q_data(ctx, q->type);
 	int ret;
 
+	v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
+
 	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE && V4L2_TYPE_IS_CAPTURE(q->type))
 		ctx->source_change = 0;
 	dev_dbg(ctx->mxc_jpeg->dev, "Start streaming ctx=%p", ctx);
@@ -1235,11 +1243,15 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
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
@@ -1438,6 +1450,20 @@ static void mxc_jpeg_buf_queue(struct vb2_buffer *vb)
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
 
@@ -1486,24 +1512,11 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
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
@@ -1512,7 +1525,6 @@ static const struct vb2_ops mxc_jpeg_qops = {
 	.wait_finish		= vb2_ops_wait_finish,
 	.buf_out_validate	= mxc_jpeg_buf_out_validate,
 	.buf_prepare		= mxc_jpeg_buf_prepare,
-	.buf_finish             = mxc_jpeg_buf_finish,
 	.start_streaming	= mxc_jpeg_start_streaming,
 	.stop_streaming		= mxc_jpeg_stop_streaming,
 	.buf_queue		= mxc_jpeg_buf_queue,
@@ -2015,27 +2027,6 @@ static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
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
@@ -2059,7 +2050,7 @@ static const struct v4l2_ioctl_ops mxc_jpeg_ioctl_ops = {
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

