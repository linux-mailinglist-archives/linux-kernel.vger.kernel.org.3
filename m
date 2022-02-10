Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD34B05B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiBJFqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:46:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiBJFq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:46:26 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9DDB5;
        Wed,  9 Feb 2022 21:46:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0BtPM3UqV+zwhXGVoIiZdtnUOIrW0Z0H5pHA6Bb6eGywgGRG9W1otsRQYCqhvtHY3bjJ3oqlZL+d0ZKxGLB166Q6E4Z9gm/vt8U9nKzDfUAFxOdkKT9Wxpm1SQDm0SwMb7itHGQcwAoWb0fx3iC8FnpdguahI/ZZAQ19J9Ibmr+0E+R6n/FPGOmmZYSKnA5ZSAj+rkXZnSOxFbhDtNH8aDQvK1knra09bsLRTGpcuSrGQgA5KrbXT9ipy72tmaP6Uyjqen2V5mahaTkTMgfuA+i5m8CMeVtIvfUo10rc4JUrIG5GtQkmt39THtlTa0nfHoNZgVdv+YaEi131F7bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leiueIUEs7yS4NSHGa75xSuheJxxYXN8Klp+bc3PHlI=;
 b=MQ71glpiJKS9VLMZ9mxYHqH5e2IXcNcPyI51RDTobA8OJSZj+4ChxtG0qUlwWJqsVSntYRDGDSM6RCTPB6gEw00bvrKK6FB7Gl3K16kofAnN8NSMqUJYfaRveBe/HsDzrFffJ0FiQ1cS8ieaHK8mM5QuJV3IJz/MkARbPtUrDROZ8dIhMFTOSdexBvtiwO91QNUtYTakY134EtGYuJ0kz0A8Omji1XGuDO+cWla8yIy+acl79oLtQbIkUvJooPbFLgTtcS/BV+G0FJ4v4ZPF2QAyFun4znjjtjnigBTGKBQQW1gA2GflrHfQf4vYKqnvfYf7NAz6JYuQG/rUIbc9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leiueIUEs7yS4NSHGa75xSuheJxxYXN8Klp+bc3PHlI=;
 b=Ur/tda0vwJV6ZuKDvnt1ihjbZTLY7DjVZA4EIAV5zScyge175MKL11ERT38qIQIccoNuooSJH/EZ3ej6/fkWeCyxE0NgX9Nk6yH7vb+WKg3HZjgv9M2/CI8N/z56YCifzxOUVHzjvfIXUOrXONsxnohii6AepznYNfTbMYjCCWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR0402MB3763.eurprd04.prod.outlook.com (2603:10a6:208:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 05:46:25 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 05:46:25 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at eos
Date:   Thu, 10 Feb 2022 13:46:01 +0800
Message-Id: <20220210054601.5889-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac17e0ec-acd3-4942-ee84-08d9ec58ac9b
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3763:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3763FB6C6CA60A79BDC61473E72F9@AM0PR0402MB3763.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8D85FuBgIFUknUqkxXP+nP+nlCQBPNg/t0u/uE8LfgHWENDhzY8fvHsEFOwRiNC1S/NL7a10jtFCKje4PeHYtanOY+F9zBZcMO6A3o1qy8atWqcky7H+rSzVnMxV0TM7AGMnu+4HEtuSgJn0vx178gz0DAwYA/NEAiTho4sbcVsTF+pFHc9YfIWnTJpuA3go+TZ1PYBxW/+V8chTh8FKeXmiCoGGby5cJw209g9nJiuF7OgW0PkQmr3qjuuUAe5VWgHzZIKRx7Iuls8OoPboFTKpICWkcAs2i+f4qcwNumqZjYlzczsqAe0xCJV/1xroCCtigc7f01ITVd0bbyYQy2bpCtfrB5qk1jPRXzBwDY7YtXgjY9q2EvJo0ofhRPu3hRbK6D+5ibAHN9z/d82Lc23sBig2O+5JpKxlyIj5qUM7HC7HQsEA3ag/N0/ynsbwzUsfTxiDzz/Sxa+79QB2LiEQHtJOCJFu/fFA0OlhNGCR/J6Q8jF/M0wgJIYjgjGDxtL5SKufSRKwj7VvQkmDQMq8FQ0bVGw4EPLpsKTYulwByQmk60p7vT+qGEU3hK2x5lqUqOxKQNNkbu4aVyAQ3tUy4hT5uEBsLAalMWyEnu4azrumqvxz666ElxxrvePq9SG3ObZwJITO0BNfhuwV2dewdU2g5b3VAwZ3qaHe8V2oHJmoH5sjrwzGV05+IZIo0uQIA08M4qeAjQLty/Axg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(6506007)(38350700002)(38100700002)(7416002)(8676002)(66476007)(66556008)(86362001)(66946007)(4326008)(6666004)(8936002)(5660300002)(52116002)(508600001)(6486002)(26005)(186003)(83380400001)(36756003)(2616005)(316002)(44832011)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zrdZ0ow9SRSTPwy34n/dZd4VqSc7gZ2SC+IT8lx4JJUGS7y+dsnMxkpuJRS?=
 =?us-ascii?Q?JYeA5S5xN4VnuiYTxe0/+pUnT8xnVzrYZsd6+sO6a5JyG5ZgyLAA/TMhf4e8?=
 =?us-ascii?Q?/aXwOQR19Tor3rWZiZilHHUDsmRzdelWRL0V8smiB5NyFb/Dhvzht3+5MvpL?=
 =?us-ascii?Q?winJgeaDUzexbnfGG8F/plkZEA85iFYUEm7DqmeryylBBwYkuqJk4TxA4jrF?=
 =?us-ascii?Q?0B7OGBmH/0QY9G3s+H2iTc1EpHhFffwQ6W3Z+rKB8X+Ju9Rp+rqYCDvzvxhE?=
 =?us-ascii?Q?2XVai7xGQEpK0AsIx3pyOfucFdM2YVU+WM2XKlxGLoKkcUUkgIiBDdsxlbVK?=
 =?us-ascii?Q?pMamnQEzOQnnAeUDYxasYHVFvSdpc4hupeWxHJr3CWOk1dQR26BBDrHfsIlK?=
 =?us-ascii?Q?4maMs1kBEK+wjQ667FJX2+7Hdrw4UAbSqFldw6vPU43RWSaTUuBv9BcY/GDG?=
 =?us-ascii?Q?lstsAAp0GrEI/OjHi3q9Xi2tpWyusQBmalmNhtqaiNXnE3e1YlG5RE1/m9cP?=
 =?us-ascii?Q?Lxxa1h0sCya8wCAHnCWJZI22ZaPIhOEmuvENBewN2TG7nvjnDta6s/THx5kS?=
 =?us-ascii?Q?/dEhbOyYkJQzlGs4uhuLIi+rJWFxke/vkU5qUUb37V9D61AM6vHKXOux3VFp?=
 =?us-ascii?Q?oJfIWAK8oGDl0+8pnzMGQRVTdNoKIrtVpGB7SvHMg0EyTcH0YSgmOltROs4c?=
 =?us-ascii?Q?5NMibl8mlR0oX09DZGkBpMvZQIjXjbVZ48fQweBUO0AxFE8+f3LYpQ4zVh2p?=
 =?us-ascii?Q?yuZNHsYpyrzkwKFkqT6CG3kDvReWhG/PwAR+tlujX/QjwLBFeRMo7U0mBkBy?=
 =?us-ascii?Q?j7G21SX1M+xNdFsV6cUQnBSJZsN1m1Kigqu47ABnhgVC2CeBV+1y65GxAvlO?=
 =?us-ascii?Q?eszxmY/emj+TpEmJWjjNiCkah2dGQv2mwySQsNSC8jl29+mETWc0ob9Ga9rq?=
 =?us-ascii?Q?0BoBIEMsS5QWesOYy1e3SAV3VjPmO2EOFOpDlbTbTNUmlUSAP6I+Io5+UIZj?=
 =?us-ascii?Q?iIrwhRWTlpHR45q0XE3BAdS+8L8hKvifJeZDDMawFA4FqeTDTDinkZpO7FST?=
 =?us-ascii?Q?4t5M57Ym2OoQAjJRSN2DCnFaaFGYxyANSdkodJtgvgH5J+orgYLoXxF1MQSJ?=
 =?us-ascii?Q?Y77s5lRNL264TWpzMCUlyggLP8jV4J8TJ/SN4F7yTJuu1nvw8rh9SkXc5dFB?=
 =?us-ascii?Q?k1swsPIpM7Xu3Z6OwLpfd0F/v58KspXoDO6wS7c2EHXpT74MX1cuh74GfgVp?=
 =?us-ascii?Q?f2ixQOQLcBo+0EtviJqLaxukngxiD/BZX8XFbnmJOwEr9ag0v0tdN+2dzpiZ?=
 =?us-ascii?Q?64uSuzae5TfbaZMGkJlwIwHkZWVrmy9/dkevopkqaFPJOdTWpP6+fTba8QuJ?=
 =?us-ascii?Q?3v2s/R+3ztYrqQMbpbrZARAKzfg9BwK3Ii2XTwOdNXeHmhGdJepXUc+eF6yf?=
 =?us-ascii?Q?o5BydZh3ZGYdnM/Gxcbf+YmZ91ykPGhS5B+x3h3f+v/4SQgjDYsgny1w4pwq?=
 =?us-ascii?Q?MO+TuOVlOvhMbkv169MghSMJ3SdzXPLVRrcKazSsh6WaLp896cHghNOBhJ6H?=
 =?us-ascii?Q?N2JSPeaO1Wa2fxEoYWdTt4gNrAS96xnfmruwxOBz+6g8nnRumcojAkdy+SxE?=
 =?us-ascii?Q?E2gLi9MiG+IbzXO2bBVJTp8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac17e0ec-acd3-4942-ee84-08d9ec58ac9b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 05:46:25.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH6h6FdQUlBgLXAXHn1MRV8b6QGS7AlLv4Y6tzGBP8tOLOOP4Zkz5MBQ5bYRYM6qrkwNFn5ylBp8hpj5fuPrUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3763
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
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 39 ++++++++++++++++++++--
 drivers/media/platform/imx-jpeg/mxc-jpeg.h |  1 +
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 86d37d14cfe2..3c50c572d6b0 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -991,6 +991,20 @@ static void mxc_jpeg_device_run(void *priv)
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
@@ -1008,6 +1022,7 @@ static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
 		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
 			/* No more src bufs, notify app EOS */
 			notify_eos(ctx);
+			mxc_jpeg_set_last_buffer_dequeued(ctx);
 		} else {
 			/* will send EOS later*/
 			ctx->stopping = 1;
@@ -1034,6 +1049,7 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
 		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
 			/* No more src bufs, notify app EOS */
 			notify_eos(ctx);
+			mxc_jpeg_set_last_buffer_dequeued(ctx);
 		} else {
 			/* will send EOS later*/
 			ctx->stopping = 1;
@@ -1110,6 +1126,8 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
 		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 	}
 	pm_runtime_put_sync(&ctx->mxc_jpeg->pdev->dev);
+	ctx->stopping = 0;
+	ctx->stopped = 0;
 }
 
 static int mxc_jpeg_valid_comp_id(struct device *dev,
@@ -1401,12 +1419,29 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
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
@@ -1842,14 +1877,14 @@ static int mxc_jpeg_dqbuf(struct file *file, void *priv,
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

