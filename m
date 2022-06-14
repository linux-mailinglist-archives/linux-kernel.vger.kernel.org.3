Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8954A9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352658AbiFNGxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352601AbiFNGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:53:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D039830;
        Mon, 13 Jun 2022 23:53:11 -0700 (PDT)
X-UUID: 3c5491eef1c94249be75c28a48a26605-20220614
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:96fbbba5-b4af-4626-88d0-4e00f84d22f1,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.6,REQID:96fbbba5-b4af-4626-88d0-4e00f84d22f1,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:100
X-CID-META: VersionHash:b14ad71,CLOUDID:7e178607-b57a-4a25-a071-bc7b4972bc68,C
        OID:5ec219501881,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3c5491eef1c94249be75c28a48a26605-20220614
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mingjia.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1179339351; Tue, 14 Jun 2022 14:53:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 14 Jun 2022 14:53:04 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jun 2022 14:53:02 +0800
From:   Mingjia Zhang <mingjia.zhang@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
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
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] media: mediatek: vcodec: Add to support VP9 inner racing mode
Date:   Tue, 14 Jun 2022 14:52:19 +0800
Message-ID: <20220614065219.29712-1-mingjia.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mingjia zhang <mingjia.zhang@mediatek.com>

In order to reduce decoder latency, enable VP9 inner racing mode.
Send lat trans buffer information to core when trigger lat to work,
need not to wait until lat decode done.

Signed-off-by: mingjia zhang <mingjia.zhang@mediatek.com>
---
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 64 ++++++++++++-------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index fba06f321baa..35462d45fbf4 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -436,6 +436,7 @@ struct vdec_vp9_slice_ref {
  * @frame_ctx:		4 frame context according to VP9 Spec
  * @frame_ctx_helper:	4 frame context according to newest kernel spec
  * @dirty:		state of each frame context
+ * @local_vsi:		local instance vsi information
  * @init_vsi:		vsi used for initialized VP9 instance
  * @vsi:		vsi used for decoding/flush ...
  * @core_vsi:		vsi used for Core stage
@@ -482,6 +483,8 @@ struct vdec_vp9_slice_instance {
 	struct v4l2_vp9_frame_context frame_ctx_helper;
 	unsigned char dirty[4];
 
+	struct vdec_vp9_slice_vsi local_vsi;
+
 	/* MicroP vsi */
 	union {
 		struct vdec_vp9_slice_init_vsi *init_vsi;
@@ -1617,16 +1620,10 @@ static int vdec_vp9_slice_update_single(struct vdec_vp9_slice_instance *instance
 }
 
 static int vdec_vp9_slice_update_lat(struct vdec_vp9_slice_instance *instance,
-				     struct vdec_lat_buf *lat_buf,
-				     struct vdec_vp9_slice_pfc *pfc)
+				     struct vdec_vp9_slice_vsi *vsi)
 {
-	struct vdec_vp9_slice_vsi *vsi;
-
-	vsi = &pfc->vsi;
-	memcpy(&pfc->state[0], &vsi->state, sizeof(vsi->state));
-
 	mtk_vcodec_debug(instance, "Frame %u LAT CRC 0x%08x %lx %lx\n",
-			 pfc->seq, vsi->state.crc[0],
+			 (instance->seq - 1), vsi->state.crc[0],
 			 (unsigned long)vsi->trans.dma_addr,
 			 (unsigned long)vsi->trans.dma_addr_end);
 
@@ -2091,6 +2088,13 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 		return ret;
 	}
 
+	if (IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability)) {
+		vdec_vp9_slice_vsi_from_remote(vsi, instance->vsi, 0);
+		memcpy(&instance->local_vsi, vsi, sizeof(*vsi));
+		vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
+		vsi = &instance->local_vsi;
+	}
+
 	if (instance->irq) {
 		ret = mtk_vcodec_wait_for_done_ctx(ctx,	MTK_INST_IRQ_RECEIVED,
 						   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
@@ -2103,22 +2107,25 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	}
 
 	vdec_vp9_slice_vsi_from_remote(vsi, instance->vsi, 0);
-	ret = vdec_vp9_slice_update_lat(instance, lat_buf, pfc);
+	ret = vdec_vp9_slice_update_lat(instance, vsi);
 
-	/* LAT trans full, no more UBE or decode timeout */
-	if (ret) {
-		mtk_vcodec_err(instance, "VP9 decode error: %d\n", ret);
-		return ret;
-	}
+	if (!IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
+		/* LAT trans full, no more UBE or decode timeout */
+		if (ret) {
+			mtk_vcodec_err(instance, "frame[%d] decode error: %d\n",
+				       ret, (instance->seq - 1));
+			return ret;
+		}
 
-	mtk_vcodec_debug(instance, "lat dma addr: 0x%lx 0x%lx\n",
-			 (unsigned long)pfc->vsi.trans.dma_addr,
-			 (unsigned long)pfc->vsi.trans.dma_addr_end);
 
-	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue,
-				       vsi->trans.dma_addr_end +
-				       ctx->msg_queue.wdma_addr.dma_addr);
-	vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
+	vsi->trans.dma_addr_end += ctx->msg_queue.wdma_addr.dma_addr;
+	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue, vsi->trans.dma_addr_end);
+	if (!IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
+		vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
+
+	mtk_vcodec_debug(instance, "lat trans end addr(0x%lx), ube start addr(0x%lx)\n",
+			 (unsigned long)vsi->trans.dma_addr_end,
+			 (unsigned long)ctx->msg_queue.wdma_addr.dma_addr);
 
 	return 0;
 }
@@ -2194,10 +2201,14 @@ static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
 		goto err;
 	}
 
-	pfc->vsi.trans.dma_addr_end += ctx->msg_queue.wdma_addr.dma_addr;
 	mtk_vcodec_debug(instance, "core dma_addr_end 0x%lx\n",
 			 (unsigned long)pfc->vsi.trans.dma_addr_end);
-	vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
+
+	if (IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
+		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr);
+	else
+		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
+
 	ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req);
 
 	return 0;
@@ -2205,7 +2216,12 @@ static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
 err:
 	if (ctx && pfc) {
 		/* always update read pointer */
-		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
+		if (IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
+			vdec_msg_queue_update_ube_rptr(&ctx->msg_queue,
+						       pfc->vsi.trans.dma_addr);
+		else
+			vdec_msg_queue_update_ube_rptr(&ctx->msg_queue,
+						       pfc->vsi.trans.dma_addr_end);
 
 		if (fb)
 			ctx->dev->vdec_pdata->cap_to_disp(ctx, 1, lat_buf->src_buf_req);
-- 
2.18.0

