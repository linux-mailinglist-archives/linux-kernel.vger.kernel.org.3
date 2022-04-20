Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923BE508724
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356658AbiDTLio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbiDTLia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:38:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9743818C;
        Wed, 20 Apr 2022 04:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNZMCpyKoYvX2h0f9tXe9xlwwVzoOqitlij1kpNfCG/YuqBg08C1i9CrVldNHnGoxOqO2Q8kocMWRkPgmdplFfBx+wMmycRW6n3KAC7bCB1xZg2X9XFNGnHivO9gWrBOtl0d8m63ZD8yDk/hcaR3HznPktzVoYTu1uwSNN43YGol4qLhrlNXI4CcbXw5JfY/BcvfUSdZ2uE/Qxl9/4nD9cYW+WW18wmAVdtHpmslWq5CoczLLcyOa9jrST3g4BQgpX/EgvTBoUQgOofEs1iu4C3vHxoyzAWMiyI0p2hlLvzzzFoa+hTKxqlElWA2RoQXX3+mki8HPi6XLiUbpHwjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip04xNVrv+sidpa8RKsKWVqM2Fn1Czr/5ybq24opo0I=;
 b=AS9OTJ4KRDnpnrilBxGV91tNqo0x94fsj26iJkc4nHvHDfCE2fmYFyQli7FogIhVpy4wvdQaan0NrYqSmAkzLlLg1dIz9Ga8dfPI4F9e23eZnazjUjfg6m9pL3UR7gYt4HH5O65SxDarI/fIAxMp1nBN7RvAj02uN6GaIhvwRd1oPjxJsSDXV1vdOTiBenYYmf8nAkNV0BBndsN9FtIKE6zrQ73aHbE674tqaA/5PbsOvdrRmCpqgHE+c3oFYvkADS4wgNSObJ16zh4AHiud0thaGKtucJAQLC6ys1mW6Ugvjj+UX0M1FYUsvjSGmrgwyn4wbTpTBmFl1HXq2OjopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip04xNVrv+sidpa8RKsKWVqM2Fn1Czr/5ybq24opo0I=;
 b=CyQ9iqYUd5WnK+5dDQHgukNsoSorqq5rdrGitnnHuO7YAUNkKnW6RDQE2yuex3Z68cy7czN7Rk5hLgwm4lvWDCDrh8H0Xu1PGRSR8IPQgBUedrQ040+y2GRh9dtN5TVJP+na/958bsyT3kGT++WWv0zDtIiHGzcixi9xuQE/Akg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 11:35:42 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 11:35:42 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] media: amphion: encoder copy timestamp from output to capture
Date:   Wed, 20 Apr 2022 19:34:54 +0800
Message-Id: <ad77d70a4babeb5fae62b211b0da7f0a0530f5ac.1650453924.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650453924.git.ming.qian@nxp.com>
References: <cover.1650453924.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f62af0-3196-4af7-b0c5-08da22c1e69c
X-MS-TrafficTypeDiagnostic: DB8PR04MB6923:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB6923B22D363FFA86FD5FD704E7F59@DB8PR04MB6923.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cv284lwEeacNVRt9msoGPxt8egIFtBpYnMpQAAIqZNyaNx1DXGBVu+N3AC9ZCbQvUGaeYEoJcTihgtO78IMSapP8hafdR9ZPR/LPl2KwTlhqId5xQ1D/lvfS0qb1+n++1+K/yoWC9RE9Z1ZVRDpuYk6ioUzWrH5yQkcD01jRfgwCTTBWeuPZaOuPHiQe5+kufOdaG06yuk88yAVkAPEx4u4hF/WUlgdHXefW+0NbHIfjbEPLF3mzjsEEa0suJq42rSM3n/P2Iw7hMsNG6LncaNlS2G554KMUt7QSF6Bgpm4fPA/TZk2zRg77XSPnTXaeiMMMJs9YRTbEFt2rsvQ+BKEz2h/br1SOg/vXoP8u/mJk3nfu3vYs9KhsjwE4oxDkqpDxuvN6sTEfgSb5LAjl0NjnEAunQaNgYlkaqRu8oIaiBzWBvJfVyRNubQ8dUnM8wxRM9MIa1Y5Pi2fX4S4FyZ5dPvxXJ5lchQgd4W2Y0PP024CsMLg1jdmSpcS2188/NJk+bCGESp+hq+XNmRuXPVLFO1O3BWeYyvrGBrf5vojEcm/JnrYjsTWvwbaLW/ksed5vmv4BSrs8yWJeJ2ns8pTwa3SEAY7BfHGqLrCI1u/zJCkkS1Gocoyfi2LzKSIklvV6CiaRQImYkYfQpchrtib8skdwzl2WoOOgV/tQJHysZTKly49jJAjRkDcy/0aR09zEFnesIYWomj1auGSk/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6512007)(26005)(52116002)(6506007)(38100700002)(6666004)(38350700002)(2616005)(186003)(83380400001)(5660300002)(44832011)(316002)(8676002)(8936002)(66946007)(66476007)(4326008)(7416002)(66556008)(36756003)(2906002)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2knYmH5FTY0vrXJRx2GjJiUqq9V8krvgNhj6GFka/3rXK8+TQ9CUj3DzlEUG?=
 =?us-ascii?Q?+pN3bL7bRGX48w2O7nozMy7cFPmRBZg4bZHEv0ddQLcW3ZuVocgEJuVt8CV3?=
 =?us-ascii?Q?xzbXyrL9k9PoKnwBH+75RqvorH4WUsiw/hffBPs12uxP78xb5WM3BUWEl9uj?=
 =?us-ascii?Q?+0IpXOScxlc2PV3jZsbH5pUv/gQiOgzkuin967vNCAREeDvuVgLNMU1VuZdF?=
 =?us-ascii?Q?0fq1Dw2pAzNl2tHa4pZq83w2aLYLbpQh0HyXC6izpFohGygD6tdJ1cStZZBv?=
 =?us-ascii?Q?bThlLWKYjx5GJlImt87vge2GG0H8ohdcRxNoW8Dfh5bWHQek87oq03KDVHxd?=
 =?us-ascii?Q?kuFOBImU6EoVvWORxv4xW3mGB7VF5BA4BHmhyKVv7dYg3K6gvTcFc+jtudAq?=
 =?us-ascii?Q?Yl1K+vKFtJ84AlOkXvDaL4BHjJ+d9uv7Gr/iNt0UN6c/Z8eNnjlPHXl1zcEh?=
 =?us-ascii?Q?rDs81yeZaBXinEps/4ZRgdzoHkqH/ejK5YdhjRekhtzLQaO9SJK791AlY/S3?=
 =?us-ascii?Q?fzMGBIjtj5OoYx2KSZofU3oVnnDGDk7Q7bYA1z2gctY7+8180pHpMljLcAlY?=
 =?us-ascii?Q?IZxtAP3Y9BVouE8+Dxk67MeSRLF38LXCp08a676mWuIAoR3JZ+AkUGwWC3EB?=
 =?us-ascii?Q?SqlxZUM2Ai2hrGD2jBu3kb6CZ39Ng9L/k6teIZ2qMmTIjldqpwwcYyXQ1ibN?=
 =?us-ascii?Q?WOfoSG1/gjTncg8HW1/tkr58cw2XRNNYvggzLELYqPh5htASSpdASP5W1bmn?=
 =?us-ascii?Q?nBmgOQwdSkjt8CMiBIY/xI4nP9w0zPdTN2siRmaI94TwlwzaC67ghs/BvAxh?=
 =?us-ascii?Q?cB7/I02kh5OykXrxJEQKEw750nrmoj3d9srdHEm0MfgpVCMUUu+BXpaAhHg0?=
 =?us-ascii?Q?N2T2TRtMQJ1wZ9xXXWOEvxMCfBI4UUcuijjJWl4HMcD0vU4jHXlClYpdxACj?=
 =?us-ascii?Q?AlMXv/4hWSX+FTJ7SqPaYb9n09n4SwjH+P4WRQ2dkJJ32QpRdD7cyEYGjWQY?=
 =?us-ascii?Q?IkmS21y44anr8ARqQAM3WSOQwEmgbAYmAppWdzV7kLcrDUfxoC59rjYNIuWF?=
 =?us-ascii?Q?lO8qCghD2QFHtKl7nJ7VONSxqgLc5BnINc4R1zqBsQngRmG1MjxlaCRQ4tPB?=
 =?us-ascii?Q?2RKkTDo4KhB873qtJZDIGWmSXq0ct2bOxrI0LFPTXNw/tLOli8tCjy1T16lG?=
 =?us-ascii?Q?snC1T4YzpBpsMHQgn7oSKKty7+tIDqVefQCtlcGY7XcH0tsCSQjM0Kk8M6zA?=
 =?us-ascii?Q?NPxquFb+l8NyVZPjLtYt9LzyoX9rivaDUiDp7EV4YCZQJSrSmks1WB9wMJR/?=
 =?us-ascii?Q?SmRAhlFbRBe8WsLCHQyTWKDSwjT2PjW8Tu4VZenQ4Mrz1tF6SGlcFKbGxFsF?=
 =?us-ascii?Q?NsXnEblaPH7wV1xctUV2wl0f53PQBRC6eAXc+Rpn23RsP8O4hTvj4T3HTGG0?=
 =?us-ascii?Q?LZa8vN9r828vuSjg8ThvwomFiYtGCADpqyIw1zSgjnH3Ky+LYyATWEqVyQzX?=
 =?us-ascii?Q?AEu5w1FHLoFVbXMVXc3lN/NjJ4AD6GTLg9mPKSfxwXnzeACUHa1sKR5U3H4D?=
 =?us-ascii?Q?/Jp66sY7YsnllB8ImaiHIeKWDIvHBCDJeNPVKC8SrTfn41j43yOvxu/7Y5zz?=
 =?us-ascii?Q?NsunfjV4YVAvd03AzJ8eU9MbMIndiPwx1w86bm+UczzELuX6rOXdOWe/TV3Z?=
 =?us-ascii?Q?duxycWTGkHkhSGq4rUJd10/172N1flD5YR7EvkwTSS9zT13wcZ+oxmAKgQi2?=
 =?us-ascii?Q?jGqFvtFIsA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f62af0-3196-4af7-b0c5-08da22c1e69c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:35:42.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3JJfQ1D9vrV7pIQrJ9z6h/EmdeACwnNrcLNlqBaMVXZFURGwxjp5KSvIPzRnPe0wbfxJDFelEb3L/CfSHQ6qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy the timestamp using the helper function
V4L2_BUF_FLAG_TIMESTAMP_COPY

To implement this, driver will keep the output buffer until it's
encoded, in previous, driver will return the output buffer immediately
after firmware return it

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 47 +++++++++------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index d33c2748e4b7..06c873fd0031 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -33,6 +33,8 @@
 #define VENC_CAPTURE_ENABLE	BIT(1)
 #define VENC_ENABLE_MASK	(VENC_OUTPUT_ENABLE | VENC_CAPTURE_ENABLE)
 #define VENC_MAX_BUF_CNT	8
+#define VENC_MIN_BUFFER_OUT	6
+#define VENC_MIN_BUFFER_CAP	6
 
 struct venc_t {
 	struct vpu_encode_params params;
@@ -423,7 +425,7 @@ static int venc_drain(struct vpu_inst *inst)
 	if (inst->state != VPU_CODEC_STATE_DRAIN)
 		return 0;
 
-	if (v4l2_m2m_num_src_bufs_ready(inst->fh.m2m_ctx))
+	if (!vpu_is_source_empty(inst))
 		return 0;
 
 	if (!venc->input_ready)
@@ -775,10 +777,20 @@ static int venc_get_one_encoded_frame(struct vpu_inst *inst,
 				      struct vb2_v4l2_buffer *vbuf)
 {
 	struct venc_t *venc = inst->priv;
+	struct vb2_v4l2_buffer *src_buf;
 
 	if (!vbuf)
 		return -EAGAIN;
 
+	src_buf = vpu_find_buf_by_sequence(inst, inst->out_format.type, frame->info.frame_id);
+	if (src_buf) {
+		v4l2_m2m_buf_copy_metadata(src_buf, vbuf, true);
+		vpu_set_buffer_state(src_buf, VPU_BUF_STATE_IDLE);
+		v4l2_m2m_src_buf_remove_by_buf(inst->fh.m2m_ctx, src_buf);
+		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
+	} else {
+		vbuf->vb2_buf.timestamp = frame->info.timestamp;
+	}
 	if (!venc_get_enable(inst->priv, vbuf->vb2_buf.type)) {
 		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
 		return 0;
@@ -800,11 +812,10 @@ static int venc_get_one_encoded_frame(struct vpu_inst *inst,
 	}
 	vb2_set_plane_payload(&vbuf->vb2_buf, 0, frame->bytesused);
 	vbuf->sequence = frame->info.frame_id;
-	vbuf->vb2_buf.timestamp = frame->info.timestamp;
 	vbuf->field = inst->cap_format.field;
 	vbuf->flags |= frame->info.pic_type;
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
-	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, frame->info.timestamp);
+	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
 	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 	venc->ready_count++;
 
@@ -860,33 +871,6 @@ static int venc_frame_encoded(struct vpu_inst *inst, void *arg)
 	return ret;
 }
 
-static void venc_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
-{
-	struct vb2_v4l2_buffer *vbuf;
-
-	if (!inst->fh.m2m_ctx)
-		return;
-
-	vpu_inst_lock(inst);
-	if (!venc_get_enable(inst->priv, frame->type))
-		goto exit;
-	vbuf = vpu_find_buf_by_sequence(inst, frame->type, frame->sequence);
-	if (!vbuf) {
-		dev_err(inst->dev, "[%d] can't find buf: type %d, sequence %d\n",
-			inst->id, frame->type, frame->sequence);
-		goto exit;
-	}
-
-	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
-	if (V4L2_TYPE_IS_OUTPUT(frame->type))
-		v4l2_m2m_src_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
-	else
-		v4l2_m2m_dst_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
-	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
-exit:
-	vpu_inst_unlock(inst);
-}
-
 static void venc_set_last_buffer_dequeued(struct vpu_inst *inst)
 {
 	struct venc_t *venc = inst->priv;
@@ -1252,7 +1236,6 @@ static struct vpu_inst_ops venc_inst_ops = {
 	.check_ready = venc_check_ready,
 	.input_done = venc_input_done,
 	.get_one_frame = venc_frame_encoded,
-	.buf_done = venc_buf_done,
 	.stop_done = venc_stop_done,
 	.event_notify = venc_event_notify,
 	.release = venc_release,
@@ -1333,6 +1316,8 @@ static int venc_open(struct file *file)
 	if (ret)
 		return ret;
 
+	inst->min_buffer_out = VENC_MIN_BUFFER_OUT;
+	inst->min_buffer_cap = VENC_MIN_BUFFER_CAP;
 	venc_init(file);
 
 	return 0;
-- 
2.35.1

