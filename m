Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3177555E22F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiF1FW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244711AbiF1FWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:22:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3E24944;
        Mon, 27 Jun 2022 22:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kow9U74c2wiM5Ax05DAtsCghzHcq8rhbr+a0H4yDEdjrnx05gJHFJoUnvjHGROEheklhUMJQMs+z4M9BzOrOOjEkkLwKH6CmkEUmJ3/blztWSUFeY2jZgkNWdxBR/fCN5mgjgt4MDGr4XX4q1Pvu4pBhP6ASCSk4jRS6E/QE5LMVVBO3a7FXF5no/xWm7Qi5qVSIVBTyjYe6OknzRftX5eAE9vPgSWfpcVovOrPFWrD+vHCRUT2N9oJTLC94TvDXsycIJo87qdZNR8ODTzi67oRLePodYxdg3cMdVXUvFQPiynAiw06YSRR0c6yEo96hfIwolNCFKMQF6SI5CtaTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68IiFs5p4uk+/vScFAa8v/g/mZmXrVixunVAsnghXmY=;
 b=iBUldaEMIpNhbF2kpGAD7gXBgxTyIfCuBB5Znd9vgzfr7udE4oPGhkDFrTLWhjYNJk8FtOlpiwzNv44JiDHue0vM5sIWszKqsuZIE5ULV2OalHaDkZjE8lyo4NM1A+4w7ozWi1vRSXgn38qFbkl+6QaLUT+pOEXTDYqL1XEaJ6zObvqRRxSpL13ThLSSCJRe0L75Ua6HmNl9vZiBjWcjd4ef9LU3D8bISeAZa5KXyuAHRE4zRNZYaoYA6m2VuPWCB8N8kSccecDL77QJYWfzhOSFs4Wc7aarBhPJD7fI9Q1HQLpzuvvLujGGsQzEoc4BHLLIZztJVJhUjntv5lBhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68IiFs5p4uk+/vScFAa8v/g/mZmXrVixunVAsnghXmY=;
 b=JSZ7FOzvAOUu9X9j7nf4vPFGwI+EKIEBy23HNiTsKKsmbMpF3qsWNci2yXFImULzFumioetLE0GiD/kEtOyUvlbOT2GqOHQbx1X0CylqjMtVaqlXsKleBKHhy6KiSj2UqRU9P9zM6fizNDOJXEa2pOlWeDDryLFvLy5yAXrJDB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB5168.eurprd04.prod.outlook.com (2603:10a6:803:56::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 05:21:27 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 05:21:27 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: defer setting last_buffer_dequeued until resolution changes are processed
Date:   Tue, 28 Jun 2022 13:21:12 +0800
Message-Id: <20220628052112.27350-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04fbb354-1cc2-43de-6113-08da58c60d4a
X-MS-TrafficTypeDiagnostic: VI1PR04MB5168:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hroPpnQmcS/9xpkMTpnqyaXN7Qt85gxG1Nzlkgkr3W9oj9FmprJl5Musdz5WJOWXsf7AOAB/c1kesRjvEQ/WvpaUdSd/MmuYTMkBGS0VU+jkF4ZGHo9tAgYJ0+LcCJnVm32rhz0InLObaNhJU5kXRDHTE5WYfjbYvFzfhyyI9oPR8Ptc4O2e1aW70R2xB3wbfn/ni8cnAvfVwFO/w6B/CWQ10HlUUpXkKgmKzITGWsGlBPGpuuPGblBdGmW58W1YYN5bE4WLez3pRr20ypfpYUz5atIIcl7jNRtTJTfhcMTVFUYY31GlEVDreGyayfyZ9YsVZ6qH+LOEZ4FAgAk+j/7ETLMZBPzYGcqG+yZqcu5IHYXIH4p2o0+p4dnPkaAENRP+Y6OHBmqiM4XLYs5jILqU5qjnHY67xZxBUPuCQ82kOxnVDrpvEHyPVtJb86r+oAmr/892IFwkt/RLi+8beuKzLH5dWRhtj1Q/6oHSSltAKSAwDWgBgNq5t22u2AJY0BGlDNbaF49tXaH/CgMplImOm86mtR8LNyQfgUf9DtrGBh+QZQ49HBJBEC1AudvBOte6gbN5lRDkOhfr3bT5PFtDTtmuiovBbgaqByGJjvd/ZRuvlGBkPBJU3bCt1E4sCrgMP7/vel9+zbxeJp3iVY9TOCpJfE9I9i7WjBqav/7tywDzfKP3Y3tvGqOikeKHpQ2SgwTE+/pNV/6y9IgrR760rDFjWYBW/iMbydKrTloUz/Jybd5TmcaF+0GJltODjRJrDLUkP7RDdBV0UBLRc9QY91b3qbmasKYzwMTVlRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(6512007)(36756003)(26005)(83380400001)(8676002)(66476007)(66556008)(4326008)(66946007)(1076003)(2616005)(38100700002)(52116002)(316002)(86362001)(6506007)(478600001)(7416002)(38350700002)(5660300002)(6666004)(186003)(6486002)(44832011)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qwpr+spgkR3Zpbc8fOPOM50sBKT27BkCm9zPRrJ5IMr4rn2Rf8PISxIsX83i?=
 =?us-ascii?Q?6SP2r3s0T3MBG1PU158PkTT97ZmEzWV8gSPSQYU+hAorKYBWTKnSK6FfdsFF?=
 =?us-ascii?Q?zMj1vySziDkAqJAUF5AAn3wnNlzjrY4vFM69cGLCQMv/OgjGGRf63ZnkJk0N?=
 =?us-ascii?Q?gPhkMStRPlnWNJfemR5CZ+Fvxowfz2hadpU27ZROjUV5PIhHFcqZ+UFrq67o?=
 =?us-ascii?Q?IfD74+Extv6fDYP1o28hC1ZDCuK36yqdEHKm/3Xfv7DliTzldEyBvXfPsKA/?=
 =?us-ascii?Q?n+lxjc86L40it0mDbwXHWnBh4qAntU5ikiD7JyJDIRTQqbGKHkuaGeeTPEyn?=
 =?us-ascii?Q?hEmcsrWNf9bgWqRZPTiykaGgy5fc/a91T5jJL8oBenFFt2xVcix93xzWxvuX?=
 =?us-ascii?Q?v3rzX9+o2w7Due6blpWucEwoxXMn+ZLH5Px778QeHkqTKQruqy9zi8UHXU+E?=
 =?us-ascii?Q?PQvvNGuoD3i6WC6+E6KnRv59KsFf4r3lUPljijsVmX57uuNMRmXS+N+zJSX3?=
 =?us-ascii?Q?DYvk4H9Q21+dKrHFDHvzVGGvItlGLWqObTn86OXlFVQl5chpuJxZ/D4IC1ML?=
 =?us-ascii?Q?9GvYFmV2fAPPbMOAT4TV3B1P3vuV2fdtUq17ghUMnB0ByxFw/eUZpvMQxH4K?=
 =?us-ascii?Q?rcMivaEEy3IDLbUGmxxUBoE4b0/bP0tVlVrjMul2zrihxfzqP4CA0gPeUBf9?=
 =?us-ascii?Q?4Nk1eZGUFeu4TUC/v3QlKDoYTCll0uolnttH8oLTSMDdWeCBQRsZQUVq4QH7?=
 =?us-ascii?Q?+t6rz0UTzwcc54M625TgNQDhuMrpF83Jho2pLqVwXwPjOd5E76l0sG5VtOsr?=
 =?us-ascii?Q?FzzuXZxUJv1xyWOArNe+ve7WHayN5AtTYfpmm5zdI90+nhQUZ8FULFtmGXW8?=
 =?us-ascii?Q?Q0N2mMmH//GT9b6vxhYjtKNbE7B6SPBGv9VI1GJIp91Cd/ckUb2br7LQMF2s?=
 =?us-ascii?Q?Qeyj6FB9S5HOOnEdDKh0c3oJkyvFTBhDkf04bi4Mvbp7IYZONn3QZ4BYr0T+?=
 =?us-ascii?Q?9trr3jGZhL6WRx0baulrA0NPqTA13tPVHAePz7oiLJiKqyFk33DPij9EtxXN?=
 =?us-ascii?Q?9tUyZDGw4H0oGH71pKWJ0mxrVQaz8d1lLaVlAhH8SsKUlAxEXSNzt86g9OJD?=
 =?us-ascii?Q?3TTeJyQZV71a1LOQ0AHcFg6MpnsDykyE1ex0jNND2XjEkf2lw3nNq6V913bC?=
 =?us-ascii?Q?EkuOZUhSK/DAF279Vd+AlTu8FtWihHTgbo0xrXZXV9q5v+d30U2LlsnEZ0TQ?=
 =?us-ascii?Q?jcPo3Bip2R8w6/O6+GOev5hJmXbaQpNGfRF7r6KI1p+oFiIZPjfEACVuQHOR?=
 =?us-ascii?Q?bpn/nUor1dtPII67p09YHrr5gfSbk4vKgl0b8n1KwRrQizGkBHCnV8HFlzCd?=
 =?us-ascii?Q?2xX2ywUHV/dzOE2dmUN8b+hMZvgkDgd//oLIHjSKhcc0fz1Y1vo4BZi6C5hq?=
 =?us-ascii?Q?MXTY3W1KVcvPuHv8PoQ5+XqYdHFNaQRCvcx2VtQBLhppnZGs9atjP1q6EqtL?=
 =?us-ascii?Q?0qlOGlQOIts28OAlqXmLL2vp09ai/0NKVvSbO6nrxP3aS4pMfnWMuxaGd7hn?=
 =?us-ascii?Q?L88vU8hFukDlmimCWSwZcxqyzgxC0FUf/sSGSnc1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fbb354-1cc2-43de-6113-08da58c60d4a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 05:21:27.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxzWWi1hjLvnn39r+TOqQGwZkZiI6oRB14Smn4MdoC6DbeQrbg7jmw5s7ruHM3C6jpQV4UEBcBeJzR6a3n0H0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't set last_buffer_dequeued during dynamic resolution change,
otherwise it may be cleared in handling resolution change,
as streamoff may be called in dynamic resolution change.

Normally, this does not happen.
But we encounter a special testcase,
User issue V4L2_DEC_CMD_STOP after enqueue one buffer
that only contains codec config header, but not any frame data.
So VPU report the parsed resolution, then report the eos event.

So driver should notify user to handle resolution change first,
after it's handled, set the last_buffer_dequeued.
then the user can exit decoding normally.

Otherwise the user may be stalled.

Fixes: 6de8d628df6ef ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c     | 36 ++++++++++++++---------
 drivers/media/platform/amphion/vpu_v4l2.c |  2 +-
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 51218a41a5ac..1a00f1926b57 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -178,16 +178,6 @@ static int vdec_ctrl_init(struct vpu_inst *inst)
 	return 0;
 }
 
-static void vdec_set_last_buffer_dequeued(struct vpu_inst *inst)
-{
-	struct vdec_t *vdec = inst->priv;
-
-	if (vdec->eos_received) {
-		if (!vpu_set_last_buffer_dequeued(inst))
-			vdec->eos_received--;
-	}
-}
-
 static void vdec_handle_resolution_change(struct vpu_inst *inst)
 {
 	struct vdec_t *vdec = inst->priv;
@@ -234,6 +224,21 @@ static int vdec_update_state(struct vpu_inst *inst, enum vpu_codec_state state,
 	return 0;
 }
 
+static void vdec_set_last_buffer_dequeued(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		return;
+
+	if (vdec->eos_received) {
+		if (!vpu_set_last_buffer_dequeued(inst)) {
+			vdec->eos_received--;
+			vdec_update_state(inst, VPU_CODEC_STATE_DRAIN, 0);
+		}
+	}
+}
+
 static int vdec_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
 {
 	strscpy(cap->driver, "amphion-vpu", sizeof(cap->driver));
@@ -493,6 +498,8 @@ static int vdec_drain(struct vpu_inst *inst)
 
 static int vdec_cmd_start(struct vpu_inst *inst)
 {
+	struct vdec_t *vdec = inst->priv;
+
 	switch (inst->state) {
 	case VPU_CODEC_STATE_STARTED:
 	case VPU_CODEC_STATE_DRAIN:
@@ -503,6 +510,8 @@ static int vdec_cmd_start(struct vpu_inst *inst)
 		break;
 	}
 	vpu_process_capture_buffer(inst);
+	if (vdec->eos_received)
+		vdec_set_last_buffer_dequeued(inst);
 	return 0;
 }
 
@@ -1204,7 +1213,6 @@ static void vdec_event_eos(struct vpu_inst *inst)
 	vdec->eos_received++;
 	vdec->fixed_fmt = false;
 	inst->min_buffer_cap = VDEC_MIN_BUFFER_CAP;
-	vdec_update_state(inst, VPU_CODEC_STATE_DRAIN, 0);
 	vdec_set_last_buffer_dequeued(inst);
 	vpu_inst_unlock(inst);
 }
@@ -1480,10 +1488,10 @@ static int vdec_stop_session(struct vpu_inst *inst, u32 type)
 		vdec_update_state(inst, VPU_CODEC_STATE_SEEK, 0);
 		vdec->drain = 0;
 	} else {
-		if (inst->state != VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		if (inst->state != VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE) {
 			vdec_abort(inst);
-
-		vdec->eos_received = 0;
+			vdec->eos_received = 0;
+		}
 		vdec_clear_slots(inst);
 	}
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index da455e5ab337..8a3eed957ae6 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -500,8 +500,8 @@ static int vpu_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 		  fmt->sizeimage[1], fmt->bytesperline[1],
 		  fmt->sizeimage[2], fmt->bytesperline[2],
 		  q->num_buffers);
-	ret = call_vop(inst, start, q->type);
 	vb2_clear_last_buffer_dequeued(q);
+	ret = call_vop(inst, start, q->type);
 	if (ret)
 		vpu_vb2_buffers_return(inst, q->type, VB2_BUF_STATE_QUEUED);
 
-- 
2.36.1

