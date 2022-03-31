Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7C4ED2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiCaEJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCaEIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:08:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7ED28AC4D;
        Wed, 30 Mar 2022 20:43:20 -0700 (PDT)
X-UUID: 7df92c2ab3594db88f0a6915c0a9ba41-20220331
X-UUID: 7df92c2ab3594db88f0a6915c0a9ba41-20220331
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 269154300; Thu, 31 Mar 2022 10:48:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 31 Mar 2022 10:48:34 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Mar 2022 10:48:27 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v8, 05/17] media: mediatek: vcodec: set each plane bytesused in buf prepare
Date:   Thu, 31 Mar 2022 10:47:49 +0800
Message-ID: <20220331024801.29229-6-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331024801.29229-1-yunfei.dong@mediatek.com>
References: <20220331024801.29229-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call vb2_set_plane_payload to set each plane bytesused in buf prepare,
need not to set independently for stateless and statefull architectures.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c |  2 ++
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c |  5 -----
 .../vcodec/mtk_vcodec_dec_stateless.c         | 19 -------------------
 3 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index e42d5c17d90e..c1c3f439d7d1 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -741,6 +741,8 @@ int vb2ops_vdec_buf_prepare(struct vb2_buffer *vb)
 				i, vb2_plane_size(vb, i),
 				q_data->sizeimage[i]);
 		}
+		if (!V4L2_TYPE_IS_OUTPUT(vb->type))
+			vb2_set_plane_payload(vb, i, q_data->sizeimage[i]);
 	}
 
 	return 0;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 7966c132be8f..e7fd39180123 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -90,11 +90,6 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
 	vb = &dstbuf->m2m_buf.vb;
 	mutex_lock(&ctx->lock);
 	if (dstbuf->used) {
-		vb2_set_plane_payload(&vb->vb2_buf, 0, ctx->picinfo.fb_sz[0]);
-		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
-			vb2_set_plane_payload(&vb->vb2_buf, 1,
-					      ctx->picinfo.fb_sz[1]);
-
 		mtk_v4l2_debug(2, "[%d]status=%x queue id=%d to done_list %d",
 			       ctx->id, disp_frame_buffer->status,
 			       vb->vb2_buf.index, dstbuf->queued_in_vb2);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index 5aebf88f997b..4df7b158ec5e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -108,23 +108,6 @@ static const struct mtk_codec_framesizes mtk_vdec_framesizes[] = {
 
 #define NUM_SUPPORTED_FRAMESIZE ARRAY_SIZE(mtk_vdec_framesizes)
 
-static void mtk_vdec_stateless_set_dst_payload(struct mtk_vcodec_ctx *ctx,
-					       struct vdec_fb *fb)
-{
-	struct mtk_video_dec_buf *vdec_frame_buf =
-		container_of(fb, struct mtk_video_dec_buf, frame_buffer);
-	struct vb2_v4l2_buffer *vb = &vdec_frame_buf->m2m_buf.vb;
-	unsigned int cap_y_size = ctx->q_data[MTK_Q_DATA_DST].sizeimage[0];
-
-	vb2_set_plane_payload(&vb->vb2_buf, 0, cap_y_size);
-	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2) {
-		unsigned int cap_c_size =
-			ctx->q_data[MTK_Q_DATA_DST].sizeimage[1];
-
-		vb2_set_plane_payload(&vb->vb2_buf, 1, cap_c_size);
-	}
-}
-
 static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_ctx *ctx,
 					   struct vb2_v4l2_buffer *vb2_v4l2)
 {
@@ -220,8 +203,6 @@ static void mtk_vdec_worker(struct work_struct *work)
 		}
 	}
 
-	mtk_vdec_stateless_set_dst_payload(ctx, dst_buf);
-
 	v4l2_m2m_buf_done_and_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx,
 					 ret ? VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 
-- 
2.18.0

