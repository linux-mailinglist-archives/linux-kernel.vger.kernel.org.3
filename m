Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693BE508723
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353496AbiDTLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbiDTLia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:38:30 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130079.outbound.protection.outlook.com [40.107.13.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175C215A28;
        Wed, 20 Apr 2022 04:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0MntwvGaPNMlyaRDR5T/8tWyYUXtkCdnE4blpCZsI4HDeaZ1SkhpnK5UeBVWbwIqcMS4VOYblIofySA+ePIDBcS+QpSfwhrQe69ADTTmuJjKNgHpgf2yihimILXs1hiQt+3tITSs6RdhMvitk2AGYx24/yDsyH71YGRon52XDtxZY34eALl4UMN/YHYf8bERk+gBH2/Gy1/JidyuNBIlHwNsGVVcfzEYyMIyP8Mee//oSX/tzyVyj3SlvOrJ23cjAItDnN0KLUks/Jpj9RkjTVwvvZfplYEBiCJDixmk5saSvhRIL6Madp/h7nZMeN4eun6TV/sPXQY1NXmvDkoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niJJ2/H0SyDA/YUccMMKDdYbxknEqb/1bhDC/WaU9ks=;
 b=OPC0KUMZK0MZKuMqHdCJSgOTsDl4GtUgcvhcFO81U7y6Cpg0qP7DVs+jLEi8TmQYVUQFRHRtoRS8NDc6sOYizbx8Zt091NMjDiYvIZ/Smjf27M0l/UCL7MPblyIStPCIFxyX/MF+5htM2MfoHIJdkKqAdexl483AyABgBZHvsDwyUG/NzKCIRha+IgwttGOqakFoiypuLE7ceumxWSc/dyRWldGvN2WRhTUh2fGINBituYZ0AD28AchpSRioCILZRxWMV9lpKtoxaIeiwTypxfflwZuaQyz9eBgo59wZGNN9mlhcNE+zSaTnNE8WQi6opwjsDElORXQk/mwMyGBfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niJJ2/H0SyDA/YUccMMKDdYbxknEqb/1bhDC/WaU9ks=;
 b=pPir66XuqywkNO6aVLqJLbTrDDOQa2L7ztKLLu2sgrEtDDptXFfTLgd0DRoL/4dqVW2fBm1SdGXcCcy1qdNiIXlWu72zCKFXzec+wKo6eA/BtrNIoCL/tqxfY+b9j/ss3BSX4RBr4RAlm21NdFeYEh/vP6hxn7WKz0AzrvioPWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB5376.eurprd04.prod.outlook.com (2603:10a6:803:cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 11:35:40 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 11:35:38 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] media: amphion: decoder copy timestamp from output to capture
Date:   Wed, 20 Apr 2022 19:34:53 +0800
Message-Id: <4ad5ad28ead921a0dee06422bfea7a54bfec45f0.1650453924.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 606332fe-3d13-45fa-35a0-08da22c1e452
X-MS-TrafficTypeDiagnostic: VI1PR04MB5376:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB537649FD089F239A2A8BFA74E7F59@VI1PR04MB5376.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vx7e3cKpE0j3Adom0gA4UsToceQolL7C7xkTqPgBUpRettlv6fUjuu5QjDRXGaavCpLeyyYt0ToF0RIZhmPjk2L3zHyAUxGgh4jInNDjftlXQ2lnCijINHIXqKiM+rSpR4Qn7V/Rfa4nN2M/HAON2PVZkYGlYlTXYRjtIFWRGeMHdQuPOuxwHd2iy85kH7GiE/BgUx0PKqFlKyEcrb38D4K9pO+Nvox3WIZt4DSubMV0YCklkdS6NEOJUak/G5Ostw5M4v4tsR53h3i/4SI+yrC7leHfohaNv0EkMeJ/ENpLeO/QnPX6k6Z+5LMFHKTCOH2mjryHwINe8BjQedKWY+VN8BEzpkiHFS9+E4kr0d/vzfD6rsjytkusp2aH5gC9sxEpKDv+o9Oanz9GwWMfoZHzJcPXFzDButYUs+v6p4KQUyvHtKo8O/bBNFJK4HtKb4m+pcr4DEUbsCUUFZ31w5SjDzacaYy/mbFX48sKzU4gFYAu9VHgjqdFMZ1Ilec/rLBqYz10S6UxqiXnH95faksjjPZGZDz6Gzqrp1C7BoAraJeqKFnQhr/3Y4Kju9AF6kxCkkfSdUo9K+1Ip3LBH2raBOGXszbjT2or24E0aH76n5XntAGl0w1KwvmXHSjf452Nv545OVDdiNJRD2CqC+uKkvsbU/YQ/CRLY9ZuEu1AVUzUGcwo5V3CiNXIKq84pDGkdgMqXZ2rd8nL0zJSpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6506007)(6486002)(508600001)(86362001)(2906002)(6666004)(38350700002)(38100700002)(316002)(26005)(186003)(2616005)(36756003)(7416002)(5660300002)(66946007)(8676002)(4326008)(83380400001)(44832011)(66556008)(30864003)(8936002)(6512007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oGvCGPqs9ahLeE28Qh7D5uHWl5DXJhUOFJpAwMnpJ0u26GRiFqoVAK2peAA?=
 =?us-ascii?Q?4W0Gq+8Y9IF9nY1JdT4JECWY4nzoBHY5Que/sGbjqXDO+b/Zn+maOgIinPgf?=
 =?us-ascii?Q?pv8aqRYj2Oymb6CMj+yuj8hWoz0jYKHbm3hSmaoriRa71oEchnLC4GPfum0i?=
 =?us-ascii?Q?HvYgJ1vcasmPEML/KfoPFzA+IdbJbMafvb9zic0KyvGE0WX6bzllzKeKp9tA?=
 =?us-ascii?Q?TvS4rpSOLiEqPYJ1bWZvgn9eE5yBUWmiVB0EgEt6p7siK8Gyd87SrMGJ4mZe?=
 =?us-ascii?Q?MtI9htSBAPjOkIGzniJtFPOCaP19wPS14kdhf19LfLjkGbXQMSbaFjVst6KV?=
 =?us-ascii?Q?iZ781hJA2HpYwAWtg7NI8CIDhihVjbNre18Wzi3SkUQd/wcppJceYY0M0QWy?=
 =?us-ascii?Q?kvJ7S8RehvamvWwtxU8lQi88pd0Ip4eYOZhbeFtcwfPlNmrppYaLCpLDqdNV?=
 =?us-ascii?Q?1zLMsRv1D7OwBp4rjtK5cu/T9wX6wpo6hS5hI1R0R9r4ERTFQ5tX2Sbtrwb6?=
 =?us-ascii?Q?RhNMuu+0+0C105c2Yx46msuPqu0D4eY5ioXrX53pSy7FopLmut7kq6wh4F/i?=
 =?us-ascii?Q?XZMbiSLEELmMHDd2mFKQqdsZJyoDts0Mbicac5sk3/Df/asscYndj0qeGfhB?=
 =?us-ascii?Q?Wj92NdS/HvBrTQfYmw6d+vD1a1dZjp+smy8lY9QqVWQjOvU0rgjIZbsIpOuK?=
 =?us-ascii?Q?yH1VZyGF1Z9AjtepZ0n0y6BNa6YFIcWsW4pPOdwIxKdOaFzWFB1dTrOdR1zA?=
 =?us-ascii?Q?2YmT1OoK6nhOHOawXaNYsUx+OZWN//CCBWqEhAS7cOlzyWyfhbOPz7u4W2g4?=
 =?us-ascii?Q?FhIPiFGEWyP1485nHfhbpbMmCzAMx+oYA6iYK1uAam3/vsbBV2srD262Ikr1?=
 =?us-ascii?Q?+OKTLsoJyF7sg3u+YkG0Asfuvcgl7O/xa9fVoulM9VO3eEWQvuGgiSZgA5l/?=
 =?us-ascii?Q?SPGIMUaWd/r4eEQhMA767m5gsOGwlIIA3WL/d/m1fC9UxSlJkHrEvez+J4/t?=
 =?us-ascii?Q?fpRtDnaaOE4aNBRKVQeUJrn/3Ru9EhI2lp+VTYA1QKh/UwtEaZ5/1/Ks1cv3?=
 =?us-ascii?Q?5P9p+DdTVuEudnRCbQqaZXG1SkdrZexV1GTzV+yz9hhgOFA32tUNce+BOEy1?=
 =?us-ascii?Q?nOtp16EPVPVxl7ZORaRLTGmozVsgQihxduxGS8nmV9qB3XZyBS9+A7ppSU0Q?=
 =?us-ascii?Q?HsP649SW3mAZr+5K4nYL0xl3Un5nq11uixC9hi05Hx1i8urZCj3eRZF6nap3?=
 =?us-ascii?Q?Zl37XHvp6WFplOPYGwbTMPC+zpL2NxqPnFokvj4XbK7x03MxYrZmicFps3i1?=
 =?us-ascii?Q?NdgOTuR68uVlQDuulymlKC2QsPoKe4spkd+tfznakgwfCxNvql69ZHatAWLu?=
 =?us-ascii?Q?NUrKgN/63nn6EoRO3Plt33dyPToHxXIqCnQbKTszzwpobFPTMksdggsGpvLz?=
 =?us-ascii?Q?uO2LOLYgZ5WGCSYDw81HAf6jAP4iSbzcqeyg6f41k756GozrkmWADLZbjIGb?=
 =?us-ascii?Q?oy8UIadmfwQsVmT39tF7JxAIb65awV02c8fIG+77sjV3+4USdr6GpBIx3aQD?=
 =?us-ascii?Q?cMf6zw9z+f6aDAUMnK6tUuzSVPrkUoNddne4+qwBcVwbSI4OBzOvG/nZNx8s?=
 =?us-ascii?Q?r67sZrJu1cNGZR2C861s7gp/xPztCechTJGuomrEARbqlPBXaRj4p9Kp4taA?=
 =?us-ascii?Q?8hs2D/emfVaEDz2rG05/GCDA9TWRQf7Im0HaKMfSYCDbfnVL5ja1I17i/WJh?=
 =?us-ascii?Q?lAtWNvoA6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606332fe-3d13-45fa-35a0-08da22c1e452
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:35:38.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Akn9Uqh2X8t1vB5o+8jfUaSEZTPqLKv4MAJXZn5duV0znsxXEn1WEE3mzLnii/cn7SpXGeFC8a5/3/zXcm0EnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5376
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
decoded, in previous, driver will return the output buffer immediately
after copying data to stream buffer.

After that, there is no need to make a workaround for poll function.
driver can use v4l2_m2m_fop_poll directly.
Also, driver don't need to keep a input threshold
as the buffer count is up to only 32.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c       | 76 ++++++++-------------
 drivers/media/platform/amphion/vpu_malone.c |  2 +-
 drivers/media/platform/amphion/vpu_v4l2.c   | 56 +++++++++++++++
 drivers/media/platform/amphion/vpu_v4l2.h   |  3 +
 4 files changed, 87 insertions(+), 50 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index c0dfede11ab7..414e5215d8d2 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -26,8 +26,8 @@
 #include "vpu_cmds.h"
 #include "vpu_rpc.h"
 
-#define VDEC_FRAME_DEPTH		256
 #define VDEC_MIN_BUFFER_CAP		8
+#define VDEC_MIN_BUFFER_OUT		8
 
 struct vdec_fs_info {
 	char name[8];
@@ -63,8 +63,6 @@ struct vdec_t {
 	bool is_source_changed;
 	u32 source_change;
 	u32 drain;
-	u32 ts_pre_count;
-	u32 frame_depth;
 };
 
 static const struct vpu_format vdec_formats[] = {
@@ -470,7 +468,7 @@ static int vdec_drain(struct vpu_inst *inst)
 	if (!vdec->drain)
 		return 0;
 
-	if (v4l2_m2m_num_src_bufs_ready(inst->fh.m2m_ctx))
+	if (!vpu_is_source_empty(inst))
 		return 0;
 
 	if (!vdec->params.frame_count) {
@@ -589,11 +587,8 @@ static bool vdec_check_ready(struct vpu_inst *inst, unsigned int type)
 {
 	struct vdec_t *vdec = inst->priv;
 
-	if (V4L2_TYPE_IS_OUTPUT(type)) {
-		if (vdec->ts_pre_count >= vdec->frame_depth)
-			return false;
+	if (V4L2_TYPE_IS_OUTPUT(type))
 		return true;
-	}
 
 	if (vdec->req_frame_count)
 		return true;
@@ -601,12 +596,21 @@ static bool vdec_check_ready(struct vpu_inst *inst, unsigned int type)
 	return false;
 }
 
+static struct vb2_v4l2_buffer *vdec_get_src_buffer(struct vpu_inst *inst, u32 count)
+{
+	if (count > 1)
+		vpu_skip_frame(inst, count - 1);
+
+	return vpu_next_src_buf(inst);
+}
+
 static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
 {
 	struct vdec_t *vdec = inst->priv;
 	struct vpu_dec_pic_info *info = arg;
 	struct vpu_vb2_buffer *vpu_buf;
 	struct vb2_v4l2_buffer *vbuf;
+	struct vb2_v4l2_buffer *src_buf;
 	int ret = 0;
 
 	if (!info || info->id >= ARRAY_SIZE(vdec->slots))
@@ -620,14 +624,21 @@ static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
 		goto exit;
 	}
 	vbuf = &vpu_buf->m2m_buf.vb;
+	src_buf = vdec_get_src_buffer(inst, info->consumed_count);
+	if (src_buf) {
+		v4l2_m2m_buf_copy_metadata(src_buf, vbuf, true);
+		if (info->consumed_count) {
+			v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx);
+			vpu_set_buffer_state(src_buf, VPU_BUF_STATE_IDLE);
+			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
+		} else {
+			vpu_set_buffer_state(src_buf, VPU_BUF_STATE_DECODED);
+		}
+	}
 	if (vpu_get_buffer_state(vbuf) == VPU_BUF_STATE_DECODED)
 		dev_info(inst->dev, "[%d] buf[%d] has been decoded\n", inst->id, info->id);
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_DECODED);
 	vdec->decoded_frame_count++;
-	if (vdec->ts_pre_count >= info->consumed_count)
-		vdec->ts_pre_count -= info->consumed_count;
-	else
-		vdec->ts_pre_count = 0;
 exit:
 	vpu_inst_unlock(inst);
 
@@ -683,10 +694,9 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
 	vb2_set_plane_payload(&vbuf->vb2_buf, 0, inst->cap_format.sizeimage[0]);
 	vb2_set_plane_payload(&vbuf->vb2_buf, 1, inst->cap_format.sizeimage[1]);
-	vbuf->vb2_buf.timestamp = frame->timestamp;
 	vbuf->field = inst->cap_format.field;
 	vbuf->sequence = sequence;
-	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, frame->timestamp);
+	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
 
 	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 	vpu_inst_lock(inst);
@@ -708,7 +718,6 @@ static void vdec_stop_done(struct vpu_inst *inst)
 	vdec->fixed_fmt = false;
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
-	vdec->ts_pre_count = 0;
 	vdec->params.frame_count = 0;
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
@@ -1244,18 +1253,14 @@ static int vdec_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
 	if (free_space < vb2_get_plane_payload(vb, 0) + 0x40000)
 		return -ENOMEM;
 
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_INUSE);
 	ret = vpu_iface_input_frame(inst, vb);
 	if (ret < 0)
 		return -ENOMEM;
 
 	dev_dbg(inst->dev, "[%d][INPUT  TS]%32lld\n", inst->id, vb->timestamp);
-	vdec->ts_pre_count++;
 	vdec->params.frame_count++;
 
-	v4l2_m2m_src_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
-	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
-	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
-
 	if (vdec->drain)
 		vdec_drain(inst);
 
@@ -1318,7 +1323,6 @@ static void vdec_abort(struct vpu_inst *inst)
 		  vdec->sequence);
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
-	vdec->ts_pre_count = 0;
 	vdec->params.frame_count = 0;
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
@@ -1525,10 +1529,6 @@ static int vdec_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i
 				vdec->drain, vdec->eos_received, vdec->source_change);
 		break;
 	case 8:
-		num = scnprintf(str, size, "ts_pre_count = %d, frame_depth = %d\n",
-				vdec->ts_pre_count, vdec->frame_depth);
-		break;
-	case 9:
 		num = scnprintf(str, size, "fps = %d/%d\n",
 				vdec->codec_info.frame_rate.numerator,
 				vdec->codec_info.frame_rate.denominator);
@@ -1562,12 +1562,8 @@ static struct vpu_inst_ops vdec_inst_ops = {
 static void vdec_init(struct file *file)
 {
 	struct vpu_inst *inst = to_inst(file);
-	struct vdec_t *vdec;
 	struct v4l2_format f;
 
-	vdec = inst->priv;
-	vdec->frame_depth = VDEC_FRAME_DEPTH;
-
 	memset(&f, 0, sizeof(f));
 	f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
 	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
@@ -1612,36 +1608,18 @@ static int vdec_open(struct file *file)
 
 	vdec->fixed_fmt = false;
 	inst->min_buffer_cap = VDEC_MIN_BUFFER_CAP;
+	inst->min_buffer_out = VDEC_MIN_BUFFER_OUT;
 	vdec_init(file);
 
 	return 0;
 }
 
-static __poll_t vdec_poll(struct file *file, poll_table *wait)
-{
-	struct vpu_inst *inst = to_inst(file);
-	struct vb2_queue *src_q, *dst_q;
-	__poll_t ret;
-
-	ret = v4l2_m2m_fop_poll(file, wait);
-	src_q = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
-	dst_q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
-	if (vb2_is_streaming(src_q) && !vb2_is_streaming(dst_q))
-		ret &= (~EPOLLERR);
-	if (!src_q->error && !dst_q->error &&
-	    (vb2_is_streaming(src_q) && list_empty(&src_q->queued_list)) &&
-	    (vb2_is_streaming(dst_q) && list_empty(&dst_q->queued_list)))
-		ret &= (~EPOLLERR);
-
-	return ret;
-}
-
 static const struct v4l2_file_operations vdec_fops = {
 	.owner = THIS_MODULE,
 	.open = vdec_open,
 	.release = vpu_v4l2_close,
 	.unlocked_ioctl = video_ioctl2,
-	.poll = vdec_poll,
+	.poll = v4l2_m2m_fop_poll,
 	.mmap = v4l2_m2m_fop_mmap,
 };
 
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 446a9de0cc11..f1eca885122a 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1556,7 +1556,7 @@ int vpu_malone_input_frame(struct vpu_shared_addr *shared,
 	 * merge the data to next frame
 	 */
 	vbuf = to_vb2_v4l2_buffer(vb);
-	if (vpu_vb_is_codecconfig(vbuf) && (s64)vb->timestamp < 0) {
+	if (vpu_vb_is_codecconfig(vbuf)) {
 		inst->extra_size += size;
 		return 0;
 	}
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index ab4cf110f2a2..34ab941460df 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -127,6 +127,19 @@ int vpu_set_last_buffer_dequeued(struct vpu_inst *inst)
 	return 0;
 }
 
+bool vpu_is_source_empty(struct vpu_inst *inst)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+
+	if (!inst->fh.m2m_ctx)
+		return true;
+	v4l2_m2m_for_each_src_buf(inst->fh.m2m_ctx, buf) {
+		if (vpu_get_buffer_state(&buf->vb) == VPU_BUF_STATE_IDLE)
+			return false;
+	}
+	return true;
+}
+
 const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
@@ -234,6 +247,49 @@ int vpu_process_capture_buffer(struct vpu_inst *inst)
 	return call_vop(inst, process_capture, &vbuf->vb2_buf);
 }
 
+struct vb2_v4l2_buffer *vpu_next_src_buf(struct vpu_inst *inst)
+{
+	struct vb2_v4l2_buffer *src_buf = v4l2_m2m_next_src_buf(inst->fh.m2m_ctx);
+
+	if (!src_buf || vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_IDLE)
+		return NULL;
+
+	while (vpu_vb_is_codecconfig(src_buf)) {
+		v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx);
+		vpu_set_buffer_state(src_buf, VPU_BUF_STATE_IDLE);
+		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
+
+		src_buf = v4l2_m2m_next_src_buf(inst->fh.m2m_ctx);
+		if (!src_buf || vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_IDLE)
+			return NULL;
+	}
+
+	return src_buf;
+}
+
+void vpu_skip_frame(struct vpu_inst *inst, int count)
+{
+	struct vb2_v4l2_buffer *src_buf;
+	enum vb2_buffer_state state;
+	int i = 0;
+
+	if (count <= 0)
+		return;
+
+	while (i < count) {
+		src_buf = v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx);
+		if (!src_buf || vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_IDLE)
+			return;
+		if (vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_DECODED)
+			state = VB2_BUF_STATE_DONE;
+		else
+			state = VB2_BUF_STATE_ERROR;
+		i++;
+		vpu_set_buffer_state(src_buf, VPU_BUF_STATE_IDLE);
+		v4l2_m2m_buf_done(src_buf, state);
+	}
+}
+
 struct vb2_v4l2_buffer *vpu_find_buf_by_sequence(struct vpu_inst *inst, u32 type, u32 sequence)
 {
 	struct v4l2_m2m_buffer *buf = NULL;
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 90fa7ea67495..795ca33a6a50 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -19,6 +19,8 @@ int vpu_v4l2_close(struct file *file);
 const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f);
 int vpu_process_output_buffer(struct vpu_inst *inst);
 int vpu_process_capture_buffer(struct vpu_inst *inst);
+struct vb2_v4l2_buffer *vpu_next_src_buf(struct vpu_inst *inst);
+void vpu_skip_frame(struct vpu_inst *inst, int count);
 struct vb2_v4l2_buffer *vpu_find_buf_by_sequence(struct vpu_inst *inst, u32 type, u32 sequence);
 struct vb2_v4l2_buffer *vpu_find_buf_by_idx(struct vpu_inst *inst, u32 type, u32 idx);
 void vpu_v4l2_set_error(struct vpu_inst *inst);
@@ -27,6 +29,7 @@ int vpu_notify_source_change(struct vpu_inst *inst);
 int vpu_set_last_buffer_dequeued(struct vpu_inst *inst);
 void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type, enum vb2_buffer_state state);
 int vpu_get_num_buffers(struct vpu_inst *inst, u32 type);
+bool vpu_is_source_empty(struct vpu_inst *inst);
 
 dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no);
 unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no);
-- 
2.35.1

