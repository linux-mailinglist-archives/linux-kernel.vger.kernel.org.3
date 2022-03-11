Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD14D5C07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbiCKHIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiCKHIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:08:49 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50044.outbound.protection.outlook.com [40.107.5.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8DD13DFF;
        Thu, 10 Mar 2022 23:07:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl3V1uEsPp1uuQf+x59Hz6q/FJdPxy75ZYnqDlYnZ3Tif3x6kRcAcWCqj4gXS1Ti0eV64salrnytu7D39WvmRuWjqv/efqOENrOp011INYU76rXYbIMBpzp/CqYd4qyO/q3v7kZeHWr+GmYKoXPg6FWcBHbpK77WB6+iGWaV57WVVtE0u2F4Rz9N38vsZ6ZUGXGgfFeS+X3u5X/ydoWsatd+7K0+h3+JLtEbhLrzqcH3k7LPOIQ+y8FUlzZ1rAtvwd/4WoXTzsL2LMQGnHLUATnwXL3whewN2dFbKhX4rlTefQPi9Yk901+ppgXtRYvop2fSJXgm+aZ7tXEK9gzLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9cW+8gLviqTClqjU6rG6er2xLuLFUhComQnCfX1rv4=;
 b=jLxU1oYw894+TUNrUF9drt6tjgWhmais/bHw/TyUxS9xVpYINlcdTrlq3V+MctZOnO59f5Kewt6iE2xSBNSrQaE2T4C1ktquoPZv9ngt/gabcl/M9THUU6mbZc7IE+XmZddfjTaFteWBxaOFglCWg9wmxcEg6/ii5F+f68Cy+AE5LJEx5HemS0+upM+Gul+/A+Bq3aZAQQgdN9WupQHswm0FuvDjPKYOEV7VC3OwJfZ9kMP0KyTitJ2T4jumz6Uhi60qVCtb9e5dpiPJYtN/69WAXDODokPxwexhoU2nR2cPs/o0mBVuyed+RKPcaAd/a+fplpv8nGfQsRfJKnULoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9cW+8gLviqTClqjU6rG6er2xLuLFUhComQnCfX1rv4=;
 b=IEs6GXAxSsk0OJ58We/qnq16Jk4MoQ4rewPD9mzt+bYGH794T8czX1403CyIt1sHiSJyDONECJdCb+MN1R4UqC0GT6+/pBfh4LrrddNLlgpZ6Au0I5qttIk4GhdsQod5xu3gqa7CrkQDgmXiwBr0ugJC5S3RWcTVPAHfrCgtft8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 07:07:44 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:07:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] media: amphion: decoder copy timestamp from output to capture
Date:   Fri, 11 Mar 2022 15:06:50 +0800
Message-Id: <721efe5f5d414ecf7b9c3c6ec17c7aff710dd2a5.1646981934.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f9834f15-3ecd-4088-cbbf-08da032dd6a5
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB6714431A68CBDB24F89B44F0E70C9@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n41xa8mbvx8Rt3C2Nxeueb0+A8H/MBch4r361Amg/NtnpPexMCot9lA+fD9UU1P1YqB4k1kt/TYXLdTGLbJxbPT2T2JtZJo0wIJTwAna2GD1UwDYIaQtID0llxjivbGgJPYCodYw5uz5uR+VryCXZ50+WoaCQmXEqM0YMaDI+qXovEpoE2we7r/qIiyHt0IA9/sDc/87bJk+5+Wpx8n0dPd32Cu4fPn2rJou+4ofEBrKL/kgv2Lv7cAOIJ6ra/QCyBOTjBTi3oFy8M6XhQfVIsMoRRfw7CY/f/8cbQhVGDa4F7gEc7gW7cJl3aKJmYNFNTT60ua6gohNLCP/aVyjUvM17jsJWcra4EYLIIcDKljKl5TO1nRGLq+BY0mq+7CeyUh4yZwu0FcdTc720fZqswYiUofxhHYRERw3dtn6TKte0K2p0yXzM7fJDc6jF7VGGwJpb5iDBWSFDvQfetQx6UZchH9VUfQ9Xp3qGXzu3IGdm1eiitzLF8Vnsdg5zbj70YYbcqgG+7JmgR17QdMg8nGwYxUfBOeoRFTwLIVXJ+kam4sHCDsIscATMMMfZ2ezeUCjEqIak4ugLD1ZOxXXSRSvgoo65jQSPUbeDm8mpvqgP8yCFfN64n8pGhWJOH0flnYFvGeuil2hmsubeLNsTl+FA08vgRGvD/EYfY/IHS5d1zt79vXy7jxG3x0mEXLmgKfiFv5ungXcLEvXsXEgNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(83380400001)(4326008)(66556008)(66946007)(5660300002)(66476007)(44832011)(8936002)(2906002)(316002)(36756003)(7416002)(52116002)(6506007)(6666004)(6512007)(6486002)(2616005)(26005)(508600001)(186003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZbt0QJFvvFcHTs9HBQkjXZz+ulPwqD73izGBObeQ6xkNmpz2Qv3oiub1y3d?=
 =?us-ascii?Q?aBIQdGgwXE0L5XbXzdODtE7JEHBs0TeRp8omnBWfS9dTC89tHck9LAqGzLjv?=
 =?us-ascii?Q?Qh3UAm44QBqpjLfFH9D/OWF8OeskSU7kOYaqukrgzBAbBsq87BgYpWEMw7bE?=
 =?us-ascii?Q?cqj2fHy6bodDI7nLXVsOebhAzagO9l5sDYDYWHo27ccXF+QTIWhwroAoVWK4?=
 =?us-ascii?Q?ZFxKbRWemjs22RDuA44kO6eoyvevG6UzJn0b2YuWpF9tWn0mcHuV3UhhIZqM?=
 =?us-ascii?Q?T5YajuS0zw8FXew+O/zu++19vOt5g7yDJ2QD6qhecJPaoUnuGABdt309vkO2?=
 =?us-ascii?Q?CekTmXRhh9TTBzxXTkzHtF/VPtDAoH4xhoK5sZs82pYZu8e35pAp35duiLjF?=
 =?us-ascii?Q?KhuNzvHQdlcRSAf6r0J/jdzIY9PL2ejmL/isYRJXa//CEIbWJpCpmYmVVLHO?=
 =?us-ascii?Q?8gTYJGszRalIh/cyhx8Zda8xcN49W1drs+ymElWCgk34wyHDHEWrFQZs8ZqZ?=
 =?us-ascii?Q?IKckQqtuBUKWG4Fpj84Z6EaZ9hK/atvAyCrf1uxzmUsjAbp0yZEu4vFu8ODc?=
 =?us-ascii?Q?tRqc52vgZjuyEls3CCpH6gL5FkjfPZf/tvSn6h7QHcxzWbWQBghr2lzavQXd?=
 =?us-ascii?Q?U5vAc096D0xRRhhfFBgYeKsuUV93yNmbaWADkic/f5kxD5qpZjLnuZ3vrH/z?=
 =?us-ascii?Q?TFJZDkUXX5SL/UL77Od24hCSnid+/FgHTv+oP+PBs6qjBO6kA5PsJmzeO0iP?=
 =?us-ascii?Q?9VSLroaYVioiGs8R9Losrw1pkjldhVnhr+Ixa9wEn7NAE2I0SQPwFMLU7JRw?=
 =?us-ascii?Q?aL2q9v8hjyin6NnEJXgaLnMjq8ffx2hZ9eIv00zbw7dzNrrM11rC1kvdOaRd?=
 =?us-ascii?Q?gWvWDl30d87XO1ihY1g62WK3UJPOCIbDqoX3zZf4BT8P1suBl9o2+TJzQdsq?=
 =?us-ascii?Q?/FixWT4tuwSB78hokAqX1OBDy5+cFdGANppT4Woe4pFk2Uw2wXfld0aqL1yJ?=
 =?us-ascii?Q?K2saG4+NfPAVGIovc1LhkTkQ83n8egwQT598I4IVxaQq7onkNuGHUB/yQSh6?=
 =?us-ascii?Q?wcgICC7DWCDWzt/n8sxI5E/ZnOj7WEk0XDHSvOU0TnOGOAVYaHPj+VUXzNpj?=
 =?us-ascii?Q?seBe0PC3JJhH7PFutqBZbXxEEiZ+K6rGV82OVieDDOECVzeDaRUMcgTPOqC7?=
 =?us-ascii?Q?qJfeKrophi+Gm7+W3egncUGiicrUyqFkh3lN8tuEspbRSljiRHAzEM+sqkc6?=
 =?us-ascii?Q?oFvOv7A4q6IFsIc77ArkCOFxagVkD26WaGf6Km1PH4nxMjdzjrRFSrlUrr40?=
 =?us-ascii?Q?Zc8NBFGWKmL57naJuHnDxNlstetDh8cUMHdmsXytMBK5jkbA3pHuSQf4Vakj?=
 =?us-ascii?Q?3jfSGJlz1hF4wrRKjkXv9pyB9MODjDbOGwPOvwvZR4cpVnj0WawcNrKpKVyx?=
 =?us-ascii?Q?Auu1q6jBoCMbPkCFy/lN6P0uxqOm3hfm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9834f15-3ecd-4088-cbbf-08da032dd6a5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 07:07:43.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbeTBJ0AwwL2LhzpVi54cmZjJ2yacTVaBJotpQB2lsOdf5AXWQhC7UEsLHGzbzNKj31ZO9g8j0NNp/y5hxKawQ==
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
decoded, in previous, driver will return the output buffer immediately
after copying data to stream buffer.

After that, there is no need to make a workaround for poll function.
driver can use v4l2_m2m_fop_poll directly.
Also, driver don't need to keep a input threshold
as the buffer count is up to only 32.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c     | 89 ++++++++++-------------
 drivers/media/platform/amphion/vpu_v4l2.c | 13 ++++
 drivers/media/platform/amphion/vpu_v4l2.h |  1 +
 3 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 8f8dfd6ce2c6..af077a062969 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -26,8 +26,8 @@
 #include "vpu_cmds.h"
 #include "vpu_rpc.h"
 
-#define VDEC_FRAME_DEPTH		256
 #define VDEC_MIN_BUFFER_CAP		8
+#define VDEC_MIN_BUFFER_OUT		16
 
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
@@ -601,12 +596,34 @@ static bool vdec_check_ready(struct vpu_inst *inst, unsigned int type)
 	return false;
 }
 
+static struct vb2_v4l2_buffer *vdec_get_src_buffer(struct vpu_inst *inst, u32 count)
+{
+	struct vb2_v4l2_buffer *src_buf;
+	enum vb2_buffer_state state;
+	u32 i;
+
+	for (i = 1; i < count; i++) {
+		src_buf = v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx);
+		if (!src_buf || vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_IDLE)
+			return NULL;
+		if (vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_DECODED)
+			state = VB2_BUF_STATE_DONE;
+		else
+			state = VB2_BUF_STATE_ERROR;
+		vpu_set_buffer_state(src_buf, VPU_BUF_STATE_IDLE);
+		v4l2_m2m_buf_done(src_buf, state);
+	}
+
+	return v4l2_m2m_next_src_buf(inst->fh.m2m_ctx);
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
@@ -620,14 +637,21 @@ static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
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
 
@@ -683,10 +707,9 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
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
@@ -708,7 +731,6 @@ static void vdec_stop_done(struct vpu_inst *inst)
 	vdec->fixed_fmt = false;
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
-	vdec->ts_pre_count = 0;
 	vdec->params.frame_count = 0;
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
@@ -1244,18 +1266,14 @@ static int vdec_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
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
 
@@ -1318,7 +1336,6 @@ static void vdec_abort(struct vpu_inst *inst)
 		  vdec->sequence);
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
-	vdec->ts_pre_count = 0;
 	vdec->params.frame_count = 0;
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
@@ -1525,10 +1542,6 @@ static int vdec_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i
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
@@ -1562,12 +1575,8 @@ static struct vpu_inst_ops vdec_inst_ops = {
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
@@ -1612,36 +1621,18 @@ static int vdec_open(struct file *file)
 
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
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 9c0704cd5766..cbf3315605a9 100644
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
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 90fa7ea67495..ad114734a017 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -27,6 +27,7 @@ int vpu_notify_source_change(struct vpu_inst *inst);
 int vpu_set_last_buffer_dequeued(struct vpu_inst *inst);
 void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type, enum vb2_buffer_state state);
 int vpu_get_num_buffers(struct vpu_inst *inst, u32 type);
+bool vpu_is_source_empty(struct vpu_inst *inst);
 
 dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no);
 unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no);
-- 
2.33.0

