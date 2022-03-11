Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6117E4D5C09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiCKHJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346474AbiCKHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:08:54 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50078.outbound.protection.outlook.com [40.107.5.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188492C12A;
        Thu, 10 Mar 2022 23:07:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfGLKes2WvgTNgt4dS7dBn+Nuefuh6LvcwDw9j8JrV4x/wttOT6002HNBPBzolySjvxzoKap5Vw0orWraQ3NcXdVUzzXpCW1Ay201DIHlh5bi4SayEkowkpzI2ZfFcF7QgMNE8fIishH/8fenAvp5+hZl+CDhYsTbhBrKph/ZaqzkiKtDGZWqDtw0Ui6qYSH775fEnaGFSB3YmRfvHkZgUnbBu8coK2SnckWp+C7Ypnd9eoLS3zJ4VyG4A+rdxcbnP7GJ1+Tc7tgnsxpKBRFDWyjBmZjCk2ONVj6sA4ToBhgGxDQwqD+N0K32bzv6gsvPOWlx3wW2jJiNDsBVljPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4Trj2LbAiTgPdhIYNDxT1JuHbcETk6HKwQYqgr93SI=;
 b=RFpk3ucPZXRDGUzbn3qawN13pe5KEnbdMKUb0qkrn2w/JnKYrKWlAi3iPIu48hAcEb1T3qsSSY3DUB4T+dqecUkr71k/MRiJSOUBNhH2Vl4KZu0qS44uQgttYoN7S+2U6FjxY0TEvHFedsIOBQCz9w3oQDfIbc1h8CZilI6neKt+xDis5uAqR3MSftADxHZpw0mn2RgJWMe+6mtk8bmsSANIX63WZJHoxgyZVTOGEnYtzA0JP6aJc8NqXRlpHP2feC4oeJUJkG8NWjYohlPd19Q1CVuP30sfVVAC50aowZgcOyYLQKIWCtMhlEuirxMlQ2Q9QcHKyj0vwIsu4Bn7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Trj2LbAiTgPdhIYNDxT1JuHbcETk6HKwQYqgr93SI=;
 b=AO++acAEVNFCmgdnMiuUL1VE8hXhNgndAketGJV7AzSYe2b3Y68JU8Sc57blyuzxaDjLXF0qDNU3Ywh9h/cljQtHLCDqtI4dI8/MLOeNhsWjUQFzIKGoK6xm+Uby1UlluTthFBYifHnwxAp5+MhFyzD+/z+6AwGZa88upLm6+P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 07:07:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:07:48 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] media: amphion: encoder copy timestamp from output to capture
Date:   Fri, 11 Mar 2022 15:06:51 +0800
Message-Id: <594652a4228d63d25915b17e08bd1c7cfe8d81bf.1646981934.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1646981934.git.ming.qian@nxp.com>
References: <cover.1646981934.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ec2e8e-834f-4e3b-2d8b-08da032dd93a
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB671478D4E5BF5461551BF3C9E70C9@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTEh4nUnSd1PDFlD9lEptVBTDInZ1cvONKugs530PSV5WWtSBozamtMbhk3u+RaxewoWNNdIuCiE0cTIt75+Tnflf/DYKVClSCZqZJm2D1KzRDIYmsiHH0p2y4CAuo7m+LL4peH6uoLqpSkncAuoLLnvcFzhgISdFWJAgVHiZsYkiqGCRCBDLMCeqdGpPN8Or541rBnr4ZlPnOg4ND0Ts3gvGkM5IP4aTgt7ife5Ihy32MVodOB/Pv8wrir0hWZnWnZj6WohRF+6iKzbFWhI4/lHi12MtwUXxj+wW1WvagfZGNPdFjTutDW1fH/SrMarVIKFNqpKqOexiwTUAeqzKUL2WJN9cSySkYmAC9RolTJmFPErUOfwYB69sRuLJd3LM0vKcwbAel88YeEjQl97xdRTrtqWJpO8QjeP/uLhJpYma1SDm3ijr8U7u1PevflQXHPik6oUcIObYpkPqTel2ZU+fXa2QL4UUPSup1KsFn2DK5b4h9XZ21YqAoMXsIB6fQNlW1sSkFRfyPCB4mVpb10M5dbK0OtNmx5UAxoiP7rVMuQ0sdO4jVeXzAAUZ5A7Y5eN7f8UGG4m0Cmywhid9gZa+nXkkvuHMdQvsowcapw2xVBkxVWXnX1xzU9sexY5pgcqzR0BMOxfcBBqX61T9ShJByJ9AkOtZ+bzU2MGLspReEx3X7rgQ5zgHed8ymNKkw5mD/uw/6kYWRCtrBDJsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(83380400001)(4326008)(66556008)(66946007)(5660300002)(66476007)(44832011)(8936002)(2906002)(316002)(36756003)(7416002)(52116002)(6506007)(6666004)(6512007)(6486002)(2616005)(26005)(508600001)(186003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeWoN7mq6bd/8JBSra2+ygPkqcZEXBBBM9ffPC+lrrFj2avHJv4R15OsHNA9?=
 =?us-ascii?Q?mkRuZrx10ecDJ0EjE890kx70pTcLaUitg6r6cjyVWIAEl52emPVCuauCtNZo?=
 =?us-ascii?Q?3GFCvkOp7GlyGZtYyS8YmI3o4HMH9dN3CINavWrskgP7Agn4NBD1ECtwBnn+?=
 =?us-ascii?Q?TOEAUrq+sdWlFNW7o5Awx68zwOqncuwt4/XlJKf3xbFjwDa/LgTRhjhbcxgz?=
 =?us-ascii?Q?apso2nplmxJp+wGyR1SZ3v1jBchaLz8hUlnAXpkb+t2ZATyCXQ7KmgywO/ck?=
 =?us-ascii?Q?RIRfBSJoRBwssREfDLVFa53kCoawVysX1YYAkMB44fvSrEIXRuFMtyPlW3y5?=
 =?us-ascii?Q?tCYGSxoZH0xmx9OrCuLQLrfzom9jTrZnW2IYjQvN3lxY8OvxcR9f8SlWYWuz?=
 =?us-ascii?Q?GtU7OGXHN916FMC+JNS9HDt61fdmXIRCFW1I2YYqCjcIY25YM1qg4vVj3dEV?=
 =?us-ascii?Q?wKs7vegVlw+ucxCKxMNPR5nfY1P8HV/2VJv+BvNVrphIiVfeY3yLmzihBakC?=
 =?us-ascii?Q?TANElwukuVJcCKh1yJCjavgyt9D84tLOnHDEzZtcwwfWiKhsvthK5spRU8tM?=
 =?us-ascii?Q?0utBZau0qkRGZYAlkowZcznYbm23NUYjS7yva6HzXkHnVSkTiLmxfdsLOC55?=
 =?us-ascii?Q?F+hJIl/wNSUDwcdqMSlTnE8f7pLFDXRht694zhx5Jco6zcO9aCKGbnnORkEr?=
 =?us-ascii?Q?SN4bugpcR7tl7IS9Xm/E7kwfAY+MpSUY73nL/gZjrfJL0AhoSWJInLPUzAVN?=
 =?us-ascii?Q?4paVno2+gKzZRpYkloqG7yO1FbcQ67kWoyZE7SB7lLOfbZAcKLNc0Qq3XnrP?=
 =?us-ascii?Q?96+EnKdvSrZLnFcsknbueqlMBI6aUJEgtaJcQdBpvOSVOzcCEJKD6xWOE0Y1?=
 =?us-ascii?Q?b4QBQWaNtwho8ndCmSFQ1T0kgrcHYBehialgcFElqNdpy/3YTlj9H9vx4Ifm?=
 =?us-ascii?Q?RLZ5cKJpMMi2Tpf/gPbKv0dNtlpwJl5IQW84OGN9Kx12yOtiujaBdxKRhycZ?=
 =?us-ascii?Q?4OJHFNPJ0VIoAyerx154wAv6u5aBe9d7Oa2at51Q0kyUb/8p1bJ2Pw6bhqT1?=
 =?us-ascii?Q?4eYNYF6oZ5w2DqSRQ6R+SQf0CppXbAULgileGBXZSJxzhRwPHqVb7RpVUqFX?=
 =?us-ascii?Q?6jWJa1Oju9TBuiwcHgt1P7OuC3FNh2Gcpj2YFh50NKVlV0qVz8u3ctyFCuYD?=
 =?us-ascii?Q?C2sKvLaMALiKhX+jPk1HmZjKT8u6fGSco4uIHWXJ+vY4h9TLpRLrKjv2I3Lg?=
 =?us-ascii?Q?cmAF8qRsAy5hRjouO5I0TicfzzoDAJdD/zLvxMKoiJyuvTLhRxc/DxG+pKLc?=
 =?us-ascii?Q?dD/IJ79WMTlZCXp0gFPUKJtKnlM9CSnBzzLjRnmpjldnq+PjoS7oO7SdDpR6?=
 =?us-ascii?Q?yR7YRcJmoZx4xIIT6OVmboObHUZGBIoDTkIn/XJKtjRfv1Alxb/QgN2lNCdQ?=
 =?us-ascii?Q?RzOov2WgUhgnE79CvH2DQ1pZHeYz8yZ9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ec2e8e-834f-4e3b-2d8b-08da032dd93a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:07:48.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOQtHbHZppVts1oLc7kBc0RmwSDuGrcB0VCvIBM7mQb3/hURI/13Wp5lVUVFwaRpDPlRlPaGwAoG7PrgcY944w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
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
index d33c2748e4b7..9177bf21190e 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -33,6 +33,8 @@
 #define VENC_CAPTURE_ENABLE	BIT(1)
 #define VENC_ENABLE_MASK	(VENC_OUTPUT_ENABLE | VENC_CAPTURE_ENABLE)
 #define VENC_MAX_BUF_CNT	8
+#define VENC_MIN_BUFFER_OUT	8
+#define VENC_MIN_BUFFER_CAP	8
 
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
2.33.0

