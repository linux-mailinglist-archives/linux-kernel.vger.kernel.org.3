Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102384BF3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiBVImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiBVImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:42:16 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D82AC56;
        Tue, 22 Feb 2022 00:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrzDMX1tdAx/jV8tglBVB+df4k51YFuVyOgDIzZAo5RlCHa3Y4zCnIHG/8fbXTMB5H14ZCMp68y+FvMi2QOeowsZR+OMgfOh5pYrlBuhXosdF/IH9ivHws/J6QDl7maDYvQAQfa/dwbRfU7+nNh8yQ5ChXErmmF68d9ikZxyrCTjHWi6e4YO6EPKGPQMvzvgMTLo44qcnrIQkXtSQPWBrHlRXbNZVLxzrpgKCPoVQ8HE7TRl/f2TsNFp8BUMNitzzsgXd2JWmmYw+iF+qNg2HlaxpjKUY4B9mQdGM3KwszlDGdPcHNlvQr9grvidyZP2aSae6yybJqeikIlnToqing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIh2lzjqV/SG4YRC1UJ9VW58Uli4yZSmVhyvQ4cxcow=;
 b=i1qd0uAioZ0zzIqllyxJW6uJyv1A0zyMWDg6Cedl2ZV6vmmcY39JPXN4R1D3lfQfuDeTxD6pqO9yd7hKxS9TUeAD7o54L40oxoomgimimLwwHsA8s0FibGts5mTOPLyL11c54m5qFzH6Lypvs7HrC/rNcz0vvw6ADF4gfIPNSZHKQF7MmS8XlPk2PtIRiR89zsTxthB8VRTTn3zaBN2Uwn8c6yKRYjHvutDmbrGTV2fVgIXSjCbqZDJ6fq3Tg/6G0+PCiTF6B6YWny9m2CyHquWDfyL/b605QdIqCmPKQGYMh0vUrDADbQq/od8kPYUXr3+Tn9buouBCpsKuKsQ5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIh2lzjqV/SG4YRC1UJ9VW58Uli4yZSmVhyvQ4cxcow=;
 b=a1VAu6EwcfhQbS1HtlbQqUdVvtbgvKT8CUt3YWG5LKCUEKm1s2yveXU4Es8pm/fR0XFu/r2B2FtKQ5KkhlUOFJrMUMRArtYqjGHZlASrUXgcWcAkdSKeuI5xOEKlTrQtythIUc85vM6EqMAwkHvu54Svenjm++p3OR6dmcY0ZHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7795.eurprd04.prod.outlook.com (2603:10a6:20b:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 08:41:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:41:48 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at eos
Date:   Tue, 22 Feb 2022 16:41:16 +0800
Message-Id: <20220222084116.5619-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd912e2-51d6-4262-3390-08d9f5df29d6
X-MS-TrafficTypeDiagnostic: AM8PR04MB7795:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB77958F6B2DB7796E32358327E73B9@AM8PR04MB7795.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cw7KgHJzA7GDno98sdk6w45Yl9jr5nC32luFZvaYXoQITJ/5Q9C8jUeQHe3BKVlUbvR7lX+ztauuM8lBBwPauhiNwBKWWusG/zPhH2UaI+nSelA4zL37G4j3XIRDITJQB0b9PobCWtRSF7tIyt2f15xvNr0CAjp6wCArWV40pJK/HFENZxeG7mgc9KRgSzv4NQ+53dsMZTx+HjQ0e7hWpfsp11ZOu5JpFbNYRiEJRmqZOavdVAtOMOkdQagAGYtjzdCaPgutAmQMvb1ndZUs+b8a6gSch7YJ7jiBuaiEiBLtQzKQZf5XGQxc6TqyjwwxEB3POUHEvFkdbGJi6HsZ5+9joVRoyM4ysZ3BxVO0yUBnLM+gBSOzxuRtIhsV9x86CpOd0EJr3mdUslQgB4mns0r75BNd0eUrFGp4HyYyaznlIJClul7R3g8C9JigoaNq2RmEPiax6lzDIkGdpyoRxgX0eYZLOAfCgzbYAcjRtRWP0Dfw72aPsMhpeLH1yPhaBTXYzbtM1L3CDaLKkIKKjEi3mQl9iVFxQrb3fAe+jqqy9V0F2C2U2KWz7QAbw6rGRqSk55cdEkObKPTSuLvJ+ZbgBJpYDvC/+us+J5ZWtGNraq6qGxrMLAspHeUAJgmn4FRMhVw18BOm0hK+RCxvK+rVn65G1e0pgf+ggiihpHWMKBK5wNiDGSxULQZQkHDESR36mE32rk65UNDTNe1zUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(83380400001)(508600001)(7416002)(316002)(5660300002)(86362001)(6486002)(26005)(186003)(8936002)(6666004)(2616005)(66556008)(6512007)(2906002)(6506007)(38100700002)(44832011)(38350700002)(52116002)(4326008)(66946007)(36756003)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yr4oaKA0T18fc978Xwct6jZhBrTVJVvXCDDVolO5lBw26Bz8vW8ix2jLIzRy?=
 =?us-ascii?Q?lQUmhC4DCd+pJ6Te8lbtzxpF4WpOR2AAKHmJl4bVN70joe9QCWDMADxmSohs?=
 =?us-ascii?Q?6xstxWg475Lv888BQTAXwqJ3GhRU1fn8uPu6imSTvkFiq97pxd7GgsQmCfdk?=
 =?us-ascii?Q?YaRklu9qZ6XKk8ox/yPBYHP0nG9q52uiWiA0TdijXbk1cdTfHJtZwPomQa68?=
 =?us-ascii?Q?l42mg6sfCXtRjspaxhij4Wxv3yiktSWLSNufZv7PJBrGRpFQRQIuWckf5KRN?=
 =?us-ascii?Q?YDVOSdDLmTg6wtO/QuySnJpjB1qJdk1X3zAz327f7MEKCTO+gXqv45X7oad1?=
 =?us-ascii?Q?pfvhf7Xh7cTzmMltsZhQ7t/N8jCeGwjGJlhH7INiM5veBFJB0gFXszNli7xl?=
 =?us-ascii?Q?AyDTUSEvfKiWMo5iCrCrGqaP8gXbLbnkcapD71DJxvhaDIDIcAPEhmnh+T8V?=
 =?us-ascii?Q?Ud86NMj+vMTb7AKCShfIY1mXLY0ZRU3bffVmxePA1JCeLLLxghfzhiLp6Nfe?=
 =?us-ascii?Q?XT6LKhYHK4wRO3Jzm7ZpMiyFtb+QYN/n0NvQxA5pCc6YH9NjwGUSVP5xV/Me?=
 =?us-ascii?Q?6QWDu1pVOQYaYA+0f8IYxdmGM92hFI8vh4ydAFULnNbAuwtzUxpvEqkwPW3n?=
 =?us-ascii?Q?RKUqdJXaS7BdbxW7Yw3UpYz5yBrEmmRLGC1rZc73QuGCE1K6Ybtv60vTTW0x?=
 =?us-ascii?Q?EuBlUGdI0CZzwL+aZWQo+0lPW27khY7fv0e8CxT0m5XwPABdbxqhiR19LuZE?=
 =?us-ascii?Q?whQTiO5BUKmCRxooZbI8TW+Mf6ZdpE+mNX3iKdQ6P9Wgu5LGFr2FGzj5OWVG?=
 =?us-ascii?Q?uZDxF7GFcyvhb/2DVbzV8pWlzOLeol4OiBUOLZ/n5PbjBuLFMBV5qKeotRx2?=
 =?us-ascii?Q?rsBHonoek6JaD1vZXgHCcrdrCrGu134DHXgBQ+LyjySoSaIKIZk7XbVG1ps5?=
 =?us-ascii?Q?7l64CXmtzRZnYOifAWUwGZivtgMVHCHO/a1ILdeAZy+o391seCqgp+MEG3K+?=
 =?us-ascii?Q?eaaDgp4zssyrK9FkmuhpPWDI5+1dPAK3cRW28LlSF5ps3mxLXr/Z67ZzwLlx?=
 =?us-ascii?Q?75h2mM/obA/ZCZluBr+H6t3ttxuXAMzI3X2HMuAMlR8/k0usN6iieQxA9E2s?=
 =?us-ascii?Q?xvWMHJ09VatA+odHpvxJgjpNbbEz4tF66k20+V5Aanb40Tux0KOQNKeDCyPJ?=
 =?us-ascii?Q?XxpEjIMZH8pnF+r5WN5fRn8BYNFhc//XHj1l8/WRx8CJy7Di2fAsiD6xFlu9?=
 =?us-ascii?Q?aZYzZjqJBsd87mml0JUiyyqJjnj+oArwNNu+LG+23OrpAW9L+ECok7rwlMBc?=
 =?us-ascii?Q?aCc+3An0GOlEsui5cf2NX5GyKR42nRvJrqyxV6G8nF5ZzNl3Gl//HCXPLHq9?=
 =?us-ascii?Q?InUCBJYtZvUf7fmQwIoESkxJtxWqzR1R4VMWjfaogUyHDOS5cYr49+8654gW?=
 =?us-ascii?Q?y+dAv+71lfbbPhEeBA5Dz5W5h/dHhHV6Z/8m76p1PySoneSgbXTKBQOFTM0v?=
 =?us-ascii?Q?RRHo9ojK0jQfERW1qwyNglVd7Evp7mHjzEkjWQxcxPOOo6083zmoyibCeH8T?=
 =?us-ascii?Q?0gHuvgZVVF4ERMNXjYiJigOq0BED1MkgW71VMQ5pevlzktBv2XDQ1tbU0d/G?=
 =?us-ascii?Q?OefEHZpm5uW+b0OECE/+on8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd912e2-51d6-4262-3390-08d9f5df29d6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:41:48.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JThYyloik0Gan1obYufVvjmUj3E+2u/79lpphr6D+LanIJTOdDQDep9WzwV8VbhlReIz6SdyVdN0p6z3vKnxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7795
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V4L2_EVENT_EOS event is a deprecated behavior,
the V4L2_BUF_FLAG_LAST buffer flag should be used instead.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 41 ++++++++++++++++++++--
 drivers/media/platform/imx-jpeg/mxc-jpeg.h |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index ec5a326affd6..1de0400750aa 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -997,6 +997,20 @@ static void mxc_jpeg_device_run(void *priv)
 	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
 }
 
+static void mxc_jpeg_set_last_buffer_dequeued(struct mxc_jpeg_ctx *ctx)
+{
+	struct vb2_queue *q;
+
+	ctx->stopped = 1;
+	q = v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
+	if (!list_empty(&q->done_list))
+		return;
+
+	q->last_buffer_dequeued = true;
+	wake_up(&q->done_wq);
+	ctx->stopped = 0;
+}
+
 static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
 				struct v4l2_decoder_cmd *cmd)
 {
@@ -1014,6 +1028,7 @@ static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
 		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
 			/* No more src bufs, notify app EOS */
 			notify_eos(ctx);
+			mxc_jpeg_set_last_buffer_dequeued(ctx);
 		} else {
 			/* will send EOS later*/
 			ctx->stopping = 1;
@@ -1040,6 +1055,7 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
 		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
 			/* No more src bufs, notify app EOS */
 			notify_eos(ctx);
+			mxc_jpeg_set_last_buffer_dequeued(ctx);
 		} else {
 			/* will send EOS later*/
 			ctx->stopping = 1;
@@ -1116,6 +1132,10 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
 		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 	}
 	pm_runtime_put_sync(&ctx->mxc_jpeg->pdev->dev);
+	if (V4L2_TYPE_IS_OUTPUT(q->type)) {
+		ctx->stopping = 0;
+		ctx->stopped = 0;
+	}
 }
 
 static int mxc_jpeg_valid_comp_id(struct device *dev,
@@ -1407,12 +1427,29 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
 	return 0;
 }
 
+static void mxc_jpeg_buf_finish(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_queue *q = vb->vb2_queue;
+
+	if (V4L2_TYPE_IS_OUTPUT(vb->type))
+		return;
+	if (!ctx->stopped)
+		return;
+	if (list_empty(&q->done_list)) {
+		vbuf->flags |= V4L2_BUF_FLAG_LAST;
+		ctx->stopped = 0;
+	}
+}
+
 static const struct vb2_ops mxc_jpeg_qops = {
 	.queue_setup		= mxc_jpeg_queue_setup,
 	.wait_prepare		= vb2_ops_wait_prepare,
 	.wait_finish		= vb2_ops_wait_finish,
 	.buf_out_validate	= mxc_jpeg_buf_out_validate,
 	.buf_prepare		= mxc_jpeg_buf_prepare,
+	.buf_finish             = mxc_jpeg_buf_finish,
 	.start_streaming	= mxc_jpeg_start_streaming,
 	.stop_streaming		= mxc_jpeg_stop_streaming,
 	.buf_queue		= mxc_jpeg_buf_queue,
@@ -1848,14 +1885,14 @@ static int mxc_jpeg_dqbuf(struct file *file, void *priv,
 	int ret;
 
 	dev_dbg(dev, "DQBUF type=%d, index=%d", buf->type, buf->index);
-	if (ctx->stopping == 1	&& num_src_ready == 0) {
+	if (ctx->stopping == 1 && num_src_ready == 0) {
 		/* No more src bufs, notify app EOS */
 		notify_eos(ctx);
 		ctx->stopping = 0;
+		mxc_jpeg_set_last_buffer_dequeued(ctx);
 	}
 
 	ret = v4l2_m2m_dqbuf(file, fh->m2m_ctx, buf);
-
 	return ret;
 }
 
diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
index 9fb2a5aaa941..f53f004ba851 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.h
@@ -91,6 +91,7 @@ struct mxc_jpeg_ctx {
 	struct v4l2_fh			fh;
 	enum mxc_jpeg_enc_state		enc_state;
 	unsigned int			stopping;
+	unsigned int			stopped;
 	unsigned int			slot;
 };
 
-- 
2.33.0

