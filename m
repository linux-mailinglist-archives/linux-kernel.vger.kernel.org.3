Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D809C57B367
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiGTI6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiGTI57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:57:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930A6E890;
        Wed, 20 Jul 2022 01:57:55 -0700 (PDT)
X-UUID: affec1270f8849869aa40a4d8c4ff3ee-20220720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:92c0efc3-1795-4c3c-9604-6bcca84d21c5,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:e0d0fbd7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: affec1270f8849869aa40a4d8c4ff3ee-20220720
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 260128992; Wed, 20 Jul 2022 16:57:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 20 Jul 2022 16:57:48 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 20 Jul 2022 16:57:47 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        "Irui Wang" <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2, 6/6] media: mediatek: vcodec: Use ctx vb2_queue mutex instead of device mutex
Date:   Wed, 20 Jul 2022 16:57:31 +0800
Message-ID: <20220720085731.11011-7-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720085731.11011-1-irui.wang@mediatek.com>
References: <20220720085731.11011-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one device mutex to lock vb2_queue when running
multi-instance encoding, it can be set by each encoder context.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h     | 3 +++
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c     | 6 +++---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index fe8ed6a456e0..2a12f13557ac 100644
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
index 6d8964fb4fa2..0abe1dac75b3 100644
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

