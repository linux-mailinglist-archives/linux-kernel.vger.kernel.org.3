Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2512B4AB4E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiBGGgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbiBGGag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:30:36 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657BFC043181;
        Sun,  6 Feb 2022 22:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY5GffQLlPp3ppJZRTgq/WsPvC+tkHETkFbhNHnZy/BPgIfKbSgRsmau/KMb52mRqjy+AyFAjkzNxvZeIN33U71J18EbDoIkH+Hltu/0QO7CxFjyFPmf2SC8wbvcW0s2E+PJsI+1RPZqHYZKVLwyPN9mLKUtU+LEkyHFhxMvKCv53Gz4TXGbJnn6QunyPBXHuPnGWLveK9ZNe9C0FpyprTr218m7H2YFLq8g6rcPA91y2S8LD45CrBqw+lajB5OqOpI8QuaWS4v8TNbrYQIZAB/Xf6MDMVvXeDPN4AdZ/+8raXRetQze0JYt+EG6N0LSFqy3guojI5mqTN5QtgNxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWI5ciy7AGlNTFV7JlN+J8IXDk6YKphtQW50wT9uo1M=;
 b=fn/SCF0g7Vpst0zHuFwMZ0o2I8eNdqo87m9NRHnOlAS1KvICpxTz9FgdV7kDD9i7ioGiO0WIOzUfaEV/GFbROV0TKi7/axswoOEe+11PPaKdUe2EjjSMrlFQdZkfShr8dOG/79fb2jJLg+fQQqMx01cdmoYL3vR5p6EGQp797LciH7io7L3Q9lMF2zxGp8zd/QyUpS0VOWXtG8xkd17KA78m2yoA2wXHR2Xnl61V3B/Zm89NXH601l2tSN5ZXU3fRS7Yx1xP9mrLxeFPOjzpxjTaXsag+4r+7851JEfXpPhOrAe4S3j6jMg92DiYVy/vZp0C7/gnKkp1fWwxZKWn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWI5ciy7AGlNTFV7JlN+J8IXDk6YKphtQW50wT9uo1M=;
 b=Zl8H5EhyUIL9/H+MT+VQMs5fTbhg1mGFU/PrtSvrlPACiD3qUGmmXn1xgsaZmjubxXYIZG6m6UxXwV+qPatIIES14ZUBLmh+3iAw3ysb0lmNY2e7cq8gJPfeZZ+Tp4mYm31YS4QqsFFmqKUzsTM0KASO1hqgKcQc3l2wo71nSSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB7PR04MB5356.eurprd04.prod.outlook.com (2603:10a6:10:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 06:30:32 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 06:30:32 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] media: imx-jpeg: set V4L2_BUF_FLAG_LAST at eos
Date:   Mon,  7 Feb 2022 14:29:58 +0800
Message-Id: <20220207062958.15907-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0171.apcprd06.prod.outlook.com
 (2603:1096:1:1e::25) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6170b928-d3ed-4fc0-6f62-08d9ea03572c
X-MS-TrafficTypeDiagnostic: DB7PR04MB5356:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB53560544D74C072ED8E89952E72C9@DB7PR04MB5356.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vw5bLp3SnthOw8cUdvRHfNOyleXnmKhNci1CnG7gB9NHriRJfXJ6mM72tw53D2Lcym7S8AMovnPrRXpMFFKX9FLFUNdY8zYiLJ+f0g9UcCo7vxycbAztNuFF028Nri6IZNIZtQ/kedEutbhchNz4uEI+c2YrsYpIS8sr+e4LzwLIcyMnt/72ok3eZw2pH6pFoPGGJL2QGAjWmy/IWYGXds5Yq/Bifafd/uuGXDG1s71ZyMmXWpQHCQNMJzBSL9tf4N52Wk5JAljqhwqN53NJnbemqzIL/8U6gGiH1bqjlkGE7DWYcaczK2ihmUh4myaD0VQ6OicesYWrVD95x0U1nchLEHyY7aHu+2TFGr9IoLX+kOhESJdQgdYjdpdAsqp0oOYbguT8bFbMFXFHazE06VMw8EC6+2RJ74yKvpjm4HRUwUmrVenxAYC7vmmmVRpVqq3dh4OWiOEl7HJlUY03fRBM3UmDkCTMq0zc97NezPKuvY0kXpE1jqqbsySylcaH7ZpLQdSTIBA589PI2Uebu1JbCC/z0NTDS2gTeHFSrRT78frWJ+xgRnCcnKhujseqiFNzUhxKl+EZWfGd5mrtZu63P+WcTtpT1mAYjzAAVgW3Jiziq1aUH8vKwUCZarhhMPRj1/Mih1rLCUd5z05vQyNPWVCnlF5gNcmyQkYHh/59xRw7qi5J3NB7WXXSE3oZb0oYBn8qh1oJclcNosnfuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(52116002)(6512007)(44832011)(6506007)(38100700002)(38350700002)(86362001)(6666004)(7416002)(2906002)(186003)(316002)(66946007)(83380400001)(66476007)(8936002)(66556008)(4326008)(2616005)(1076003)(6486002)(26005)(8676002)(508600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fIBqwleqB+PLOLa+V7bP4Te5liMka1gN9Qu5LvVtAc+XWGTMh85B38F72i9P?=
 =?us-ascii?Q?YnadOCTvq/PKPO+yKrK6BIitOE38codOQEP3R5ro3DrFWF2kWSEdA4CkI8hr?=
 =?us-ascii?Q?/S0kvNn4imBZGnxsW7bCm/DxHU3B2LJKscl04InRWEQloLhjD+9ntoU4o61e?=
 =?us-ascii?Q?fDnnkbzpmgc43UQyFMwE2Qe4NnjxIjMVttylVf6NQSChDHKIQO8vZ3DHD1zi?=
 =?us-ascii?Q?owcBhEWH7dh2Lmh+gjfZF42wgsvMZygWuGEB1Y5n3ywebrjkkbw8tm/QqfB7?=
 =?us-ascii?Q?861oubCaBhhpymKfPN0KH/GRLNnOccOeSBGvD6iGUujv7d3pKVYAlZ8S+thP?=
 =?us-ascii?Q?ew193DV0JYOzA3wg7cphjRd2S9b3fnD1LWE76tVj+13Tfs2YPLtl5TxKy1fL?=
 =?us-ascii?Q?FJc2vr84zBdgPNRaf+yi/a6dLp5jU4V51mtYcTIK3N5fNYGevBVlTWGWyIFo?=
 =?us-ascii?Q?yBX+iCVQ59isKklCOjiEjN1O2GODmTAiH26CHV11RY9g6HAnsCv38dGaHH3P?=
 =?us-ascii?Q?w2RKrby/YVs8BKSt8cMz9IZlPln4tS1N95Ayzu2V7A8hbMXsJW+5PD8YJ1XF?=
 =?us-ascii?Q?5UiAYlQZCXEiMZY+3S29IxJXxkB3J/ksjHrT7K9JqARWg6GlBpnNXeCYL9rd?=
 =?us-ascii?Q?7OicZBgERym51f1fTcZM6ycFaOD+d6iYaudDbmT/9uc2gDYjXzBWMNm9yLm7?=
 =?us-ascii?Q?Vc4coOefgplM62totcVei12QVPaYSORvmwxNeBzwrRefwepeYMCM+DKW+aOa?=
 =?us-ascii?Q?MKXs2t3aqcLkm08hU4BROIO0lW9n2bTputiUoZ2NsttUONUdhXtdTJs399lU?=
 =?us-ascii?Q?f9P8IyaeUO34AB8QRrxFkmsmFJX+OCS++MDmobmUw4whFRa06TrXxa32Ya1N?=
 =?us-ascii?Q?n6LCZM1d+VWabUNYfewXDCjGqg05csVlyaYqdGTyjPKrSyywBzZ9SHXRjUpo?=
 =?us-ascii?Q?pj34KtYRy6WRC4DvtODgkyELPoND2/5UOy//NBFA+LbTkJID9KZOhJl4Ezhc?=
 =?us-ascii?Q?29tjlMWWwNqwrPcMYXnR9oNAsux4BXgf4nj47VsAVq9aYJBpN9p6/ZgIhD1c?=
 =?us-ascii?Q?7+bfT4mn136EAtefIMQS9dcV9dfSNzt2TPXQ9N8ljfDHhHud1NJ4DcfK07sX?=
 =?us-ascii?Q?PvCWgcxcDE1RDUlNrl+UaEnuZwHCBGUFhgYeaMCJNkCYBLqVAqxi9oqbYoDb?=
 =?us-ascii?Q?PEnkGyB4OkN9A1/H3iV9rA+yVm1obYflLOefn8aAqHUiDPxV8UjEr2ECGKoh?=
 =?us-ascii?Q?cO+UQwvA68MEAqHjKXGNRJB5UZZ3DmpeYLEL2cwjASc8Fbm5GYpbZttYdLFn?=
 =?us-ascii?Q?kOL4eeH5i6wxMhQHkjKoNAqZxhD14i77TuVjkuHhRWMwEwRs3eSpdt+OyGcO?=
 =?us-ascii?Q?swgpnv8M4ap1E7z51j4XEjxOKoGFkyXKEFfDj1Oni2JZvIrAeP2cShyXXlDR?=
 =?us-ascii?Q?SfZeFKQdcjmSvTBnKfM1cZM9JmQSdSUsnCsAVdp7+Tpcq2EkOqCSzgym0dqX?=
 =?us-ascii?Q?gDoWOo1CWnAR17P93dF+Pcfhcxvwfl9ojQhuFMB7K7+DdSNUg9Xu12xBqtom?=
 =?us-ascii?Q?6OwODklQy/73/FxPdOg3/hfLbuvc3soNcZz2TbPOvxJU72I8lV8aIdw20hHT?=
 =?us-ascii?Q?U3dm0RByvMsPOwHzPNkLCgE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6170b928-d3ed-4fc0-6f62-08d9ea03572c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:30:31.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78Q1nfPdzFWWaCIO9IJq1lCs/fI31sWWAw+IFC8Jtvi7lu3/Vp+5cMGGwjq5ZPkqnPdNrRk03eVFOM1E27uUsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the V4L2_EVENT_EOS event is a deprecated behavior,
The V4L2_BUF_FLAG_LAST buffer flag should be used instead.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 45 +++++++++++++++++++++-
 drivers/media/platform/imx-jpeg/mxc-jpeg.h |  1 +
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 86d37d14cfe2..22572a1ae7a4 100644
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
@@ -1008,6 +1022,10 @@ static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
 		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
 			/* No more src bufs, notify app EOS */
 			notify_eos(ctx);
+			if (!mutex_lock_interruptible(&ctx->mxc_jpeg->lock)) {
+				mxc_jpeg_set_last_buffer_dequeued(ctx);
+				mutex_unlock(&ctx->mxc_jpeg->lock);
+			}
 		} else {
 			/* will send EOS later*/
 			ctx->stopping = 1;
@@ -1034,6 +1052,10 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
 		if (v4l2_m2m_num_src_bufs_ready(fh->m2m_ctx) == 0) {
 			/* No more src bufs, notify app EOS */
 			notify_eos(ctx);
+			if (!mutex_lock_interruptible(&ctx->mxc_jpeg->lock)) {
+				mxc_jpeg_set_last_buffer_dequeued(ctx);
+				mutex_unlock(&ctx->mxc_jpeg->lock);
+			}
 		} else {
 			/* will send EOS later*/
 			ctx->stopping = 1;
@@ -1110,6 +1132,8 @@ static void mxc_jpeg_stop_streaming(struct vb2_queue *q)
 		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 	}
 	pm_runtime_put_sync(&ctx->mxc_jpeg->pdev->dev);
+	ctx->stopping = 0;
+	ctx->stopped = 0;
 }
 
 static int mxc_jpeg_valid_comp_id(struct device *dev,
@@ -1401,12 +1425,29 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
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
@@ -1842,14 +1883,14 @@ static int mxc_jpeg_dqbuf(struct file *file, void *priv,
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

