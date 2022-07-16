Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D56576D19
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGPJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiGPJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:38:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDE2B1B5;
        Sat, 16 Jul 2022 02:38:22 -0700 (PDT)
X-UUID: 0e249f29ffdf47f5ba60e6ac2fc003e4-20220716
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:5870c23f-a4f2-45f8-a0c3-d0cf757498bc,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:5870c23f-a4f2-45f8-a0c3-d0cf757498bc,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:c8947464-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:409a75ef775f,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0e249f29ffdf47f5ba60e6ac2fc003e4-20220716
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 927492231; Sat, 16 Jul 2022 17:38:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 16 Jul 2022 17:38:17 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sat, 16 Jul 2022 17:38:16 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 5/5] media: mediatek: vcodec: Fix encoder multi-instance deadlock
Date:   Sat, 16 Jul 2022 17:38:08 +0800
Message-ID: <20220716093808.29894-6-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220716093808.29894-1-irui.wang@mediatek.com>
References: <20220716093808.29894-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vb2_queue lock can be set by encoder context, the deadlock
may occur when running multi-instance encoding if use device
mutex lock.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h     | 3 +++
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c     | 6 +++---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index ab80e1b1979e..25fe539e6db5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -324,6 +324,9 @@ struct mtk_vcodec_ctx {
 	int hw_id;
 
 	struct vdec_msg_queue msg_queue;
+
+	/*q_mutex: vb2_queue mutex*/
+	struct mutex q_mutex;
 };
 
 /*
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index c310bb1dbbcf..63e7fe958406 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -1300,7 +1300,7 @@ void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
 {
 	struct mtk_q_data *q_data;
 
-	ctx->m2m_ctx->q_lock = &ctx->dev->dev_mutex;
+	ctx->m2m_ctx->q_lock = &ctx->q_mutex;
 	ctx->fh.m2m_ctx = ctx->m2m_ctx;
 	ctx->fh.ctrl_handler = &ctx->ctrl_hdl;
 	INIT_WORK(&ctx->encode_work, mtk_venc_worker);
@@ -1435,7 +1435,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->ops		= &mtk_venc_vb2_ops;
 	src_vq->mem_ops		= &vb2_dma_contig_memops;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
-	src_vq->lock		= &ctx->dev->dev_mutex;
+	src_vq->lock		= &ctx->q_mutex;
 	src_vq->dev		= &ctx->dev->plat_dev->dev;
 
 	ret = vb2_queue_init(src_vq);
@@ -1449,7 +1449,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->ops		= &mtk_venc_vb2_ops;
 	dst_vq->mem_ops		= &vb2_dma_contig_memops;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
-	dst_vq->lock		= &ctx->dev->dev_mutex;
+	dst_vq->lock		= &ctx->q_mutex;
 	dst_vq->dev		= &ctx->dev->plat_dev->dev;
 
 	return vb2_queue_init(dst_vq);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 6b0688b4872d..782563e636e4 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -130,6 +130,7 @@ static int fops_vcodec_open(struct file *file)
 	INIT_LIST_HEAD(&ctx->list);
 	ctx->dev = dev;
 	init_waitqueue_head(&ctx->queue[0]);
+	mutex_init(&ctx->q_mutex);
 
 	ctx->type = MTK_INST_ENCODER;
 	ret = mtk_vcodec_enc_ctrls_setup(ctx);
-- 
2.18.0

