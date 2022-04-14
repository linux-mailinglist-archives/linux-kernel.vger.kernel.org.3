Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B5500934
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiDNJFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbiDNJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:03:42 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00065.outbound.protection.outlook.com [40.107.0.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093E827FE3;
        Thu, 14 Apr 2022 02:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay3MvD3WxQbcabzkWpmAhVrzV9MuSuW8rFepHNfuVpowsbsjEOWgS+ntR1P/HGUxN4ruUAHPJZD+f4CJRn3adDvyaXIB5fvAdgpraZoKd1AHAwZ4WFoiwIvkNZOsWYDN94MUYMy6NCDG2mVDh4nKCdFHB8V9qfANlqAQs6MaM05/sqrD2ieAs0xExroPg/xMwMXUZfx8iQ9qGWYdBZlrDvce3RP+U62SIaVxYRucGvLuVYXGhzDvrqnUVQkRUA9VLCaAlrvfthZx+nwldtt5IJCKunjErIvqYuWfX/o6aFS8rhG/joDpG4RPJB4oSN42wL5Wjir6bJ6L8jVMF7IerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip04xNVrv+sidpa8RKsKWVqM2Fn1Czr/5ybq24opo0I=;
 b=OtTAaHXJypdZ0q8VtQcM4O2ra8v+gGPfs5BZb55CVWPsLkjZdYP6UYaUoXwRWhVfdu7/v9I55Kk5sFSeDv5kXh9tzl2jGXW2o6E/o4z8ZegzjN6qgcfUIZgHuR9Kqv3cuqW2w40tlqDG+Iivbw6ezzLdHFEoCtl7O/Qjp4BS0QDnuYLwhEhVHByWoYXdGoBzQfRRfiWEQve4c+al6dTEFoEf3LwOkt0Q2AEKtn2075AoDeb4qLdL2rwaXWUk/l7SftZNU1phm0Esx9MrPsQ+a/qExucXOAKEvKjhYmbh0xT877ZnUgtPxGkTbKKXIEpZ/e8AsJUVUtydctnIju3QpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip04xNVrv+sidpa8RKsKWVqM2Fn1Czr/5ybq24opo0I=;
 b=MCOhrECSjHc2kPFFaDXe0g+zqgVSgIsSPtVF8NU9YQ3h75GPphBBDc6zJdxNYxG4QEHfKA7PYrZ9CTe0l8Zl7TgXBmYim6GFhsm1cxso0ZVcX2g+L6OzHNHLFCttqzLONeaMJZpdmMdWmKPUGwv/usboIlOW2Et0x7h0z6oXwxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8800.eurprd04.prod.outlook.com (2603:10a6:102:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 09:01:15 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 09:01:15 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] media: amphion: encoder copy timestamp from output to capture
Date:   Thu, 14 Apr 2022 17:00:30 +0800
Message-Id: <483845f7b902ebb29c791ce251e09eb93fed97ff.1649753693.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649753692.git.ming.qian@nxp.com>
References: <cover.1649753692.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a57da67-2b2e-45d4-e06c-08da1df554cf
X-MS-TrafficTypeDiagnostic: PAXPR04MB8800:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB8800CD94DB42EBFF49E21F10E7EF9@PAXPR04MB8800.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hgU49Ws/vdQRVyTbtlLecrhoNb8O8fVeiqRgYx7NRhaBhDlStdnbJyulTTlV3qBDhorRKNsZteKzyzfKcb+VM0H652+oaag9kuO0pAUtPq5GIg9TdFc2J6R7JD8yjYfr680rdL20H5myDlYvuS2ANOZRK8BN4X6WVnbpjzPwslNHdD/7X0pYnet5zcmGGpGKoyV3PPoafDu01Luz6jW1o4avpBC8vkX7r36YdK7IEuFSed8/rT0kmrouPmd6/56T3shPU0ie5LqSkhJI4KlLX0kRpaXGIjx3JGhz4NnZM21+xbDAruS6Ca9JnB+7OEBnjddDDbr/hOGtuZ8iDnI9ml+0EYJKrn+TYEHWkHzdR1UH2tzfWp/B+HuX2JHmj0zz7pSF5wwi088hrUzQSn+Vhd1tAipstZb58UlyEiIvqdR38dxf6WN53EyHhaFA4fGrSzieyYeDSOiA23X4Oc8X3xTQYddaShkf1W9GXG9foNXF+Esj4O83BRCXhbea/cQKsCQ7ubdUmNUO6Q04wfs5ySNMNi3KqvjmiCK99JIFmc8cIpCZBbOyTNotdfxDnOu8CwjJa6OCXyN02jTBRlDwsPy2lFvzrZblqbk2xK21H+Lv+yFEytfKXB4rXhkk8dED27iGuoB4RKzU7uSQ2PyQNdXF0/gudmk42cpQ+A9ay7B5HVfbqbZFkkMdI3VjkFhKzgS60hwD/Me9V1p2SjdTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(36756003)(86362001)(8676002)(4326008)(38350700002)(508600001)(5660300002)(66556008)(2906002)(8936002)(316002)(66946007)(38100700002)(6486002)(7416002)(2616005)(186003)(26005)(44832011)(6666004)(52116002)(6506007)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JEokU32dVcvgPCfiPXP6+REm88LHhDwuxGPLd5VygiGHq1m0jRXYQjVe/RcB?=
 =?us-ascii?Q?LLgwl/KIzzdCAWzLvOjrUAj2UHs7iG4vrB/2HrBTAZC5u61u6JtX4aKCkbRL?=
 =?us-ascii?Q?RIs8LhbxX/0Ac+gdYDnLqMUEVjom4SYNRJYWEa0s5GebLVxH/93sK5NwHxoV?=
 =?us-ascii?Q?wr0d70KUTGNKuvWMVzB3KyigZUqw3QdLtUSN3jhZlvuq0ZcF+2zBhxxpjxle?=
 =?us-ascii?Q?+eVcvY4qdkAieE9bFL91kMlL/oWzuuAzdHdzHO8iYOMKfSAXIKQ9EnHRK3Ct?=
 =?us-ascii?Q?tTsuTkh5hzJ1xUwbT2DlGEwW3zE/Zzd4rDI3XfSHoz9hSn4mmlnPJC4A+c0u?=
 =?us-ascii?Q?q3FOnYENXV/lwTUAKsce6aDFJncwa+B1a0zuJOZyC8Imi1rphY8m1gzH73pm?=
 =?us-ascii?Q?1l88vdlG5ZJXpOjSdOTbBNWRLpPgl9oh+K8T9rw1kwzOrh68TpOh5Pfjznm3?=
 =?us-ascii?Q?g1Sau8A2JJbPdFF3gb7ZfyQVsNJZrUB6PB70RLgg2ZBZOqVcyW5FvNZFbp8e?=
 =?us-ascii?Q?8zEQXwfMvVG2ECRI43YSM/svkWD+BjshqEpVQenTuPGSZjJ0gNGBrmmuLfMv?=
 =?us-ascii?Q?2cmGDWvH4F9HuiK9NNdZ5ODXz9vsPbep4X7y0dl9PpJomPPXnfmILlIVzQYn?=
 =?us-ascii?Q?wa+0sc5Dij2lnBUSHGa+vhEMjxQgRrlzCP9lCTsC8GhqLwHa7aGCkvUe1tv5?=
 =?us-ascii?Q?inAveiL6YhhAco5h358GKb6qdrcdJJL803wXBTE5S/cYA7ioCCBuCeSM6CDt?=
 =?us-ascii?Q?HECSIpd9QbdWVlAKbTM2v1Vm8+RQ3v2licbHf+Aypc3bzV9L+8BlrkGTiwNo?=
 =?us-ascii?Q?hvjmwtoVq8alOzrb9nJm1f9uucT9XQm4Q5ZRJZmgfgr38xRpS6Z5Qe5melPT?=
 =?us-ascii?Q?QZqmb+e+bSFDROO5swGDLJ+AhN9X3t9MkIvu1SdU/LLAsEwrTOYPPw2ZsFK0?=
 =?us-ascii?Q?cti86NPZn/nYFDXWAqzGKrP3OX0tRf/PiDxOe1PRCmoQ/SGhs0dHYByyHjqC?=
 =?us-ascii?Q?kAcoCFt6QHMgKbM8srQ7HRSPX0G6d8IaWqlnnuoJY1Jcgsvf/0SgTfHeRjLe?=
 =?us-ascii?Q?TJUpEDYNlIxmLpK0Uwqn7Z9PFc+AlJembaRQ1SkPRJGcwJtfHW/VirP+txtx?=
 =?us-ascii?Q?ERqFQ5lD4uXdLRvfAsucR8Tp3eDHJGmsXk94ZqDFllYpc4PU8I9bAElhg6NU?=
 =?us-ascii?Q?O6M8ia46RsIuaiQx3BhkJoHK+69aCr26lXemjP3I1xp8PnqNovCGFjx2t/XF?=
 =?us-ascii?Q?Z2hxEJAyrOa54hzwJHWMHi16SRjEl2R7PjWe3bVs4UdtujwB8xE2Q7ZqT26z?=
 =?us-ascii?Q?jC/VjazD/z6yqfkQbSs7yZVEE4e6FJpNVVLgFL6ovJtIv6YAmB6f4K08Auop?=
 =?us-ascii?Q?WJUqdc9nPQyUOSEOqo05E4sTQc7Ts4HWJ+buzKa7U87Ph7cXZGFvTv15t/DD?=
 =?us-ascii?Q?KKMKy+w4x7imgDgZMp8Fxr5yWrECP5YMJ0nE5e+fDDhEqumz2ckNvAQaQYnV?=
 =?us-ascii?Q?AeF5SP9OSoWLYfKegYb1iHSDFlSENVuLc03/a8+YvXS+oxep/YFvIoHbwE+T?=
 =?us-ascii?Q?bieAJXVnOrcK68y2AfO6QDQsdKDy23G96eHbG2jk3pjrRJKlFf7BdJBF2efO?=
 =?us-ascii?Q?D/TJrmij9SHx3EHpEgu75MwQabXO86ma366tikAIVorelshurGIzYIpwczpE?=
 =?us-ascii?Q?OdXabmFpGLJ2aJXUjzkcOe9/drCU4uBNOZZXNhI2sIx6QwUEJRadFIJKEyQj?=
 =?us-ascii?Q?GLtwYiJUJg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a57da67-2b2e-45d4-e06c-08da1df554cf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 09:01:15.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNr7FsRU7GD1G3ETwbQIF+K1bOtgcpQSAs1FvG4wO4WPmhKqDi1UzSatzZhasxl2KJG/jL2rtLUBxY5ms1s7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

